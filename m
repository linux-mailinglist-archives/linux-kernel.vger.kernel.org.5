Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA137544E4
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 00:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjGNWRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 18:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjGNWRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 18:17:12 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504F1271E
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 15:17:10 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1b441dd19eeso1970031fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 15:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689373029; x=1691965029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdzHr07zTGluOEPoHrNDfSU95b5L29PdHHrd1vv/M7g=;
        b=abj0MkO8lcO9upHhziT/xhOgnHzY2pYWq7mFKHg1wbTaYYs3KdwPF4Ub8GturcaKbY
         66FWrW/QFPBAiU/UFxQfLOmlWpffyaJSsZSX48mBmuU3wz0GQJsxoevr5HW9FMXq5Gyi
         N+B1038jDI8I0oARmHCPnUoWPBRVvQCUbbDw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689373029; x=1691965029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdzHr07zTGluOEPoHrNDfSU95b5L29PdHHrd1vv/M7g=;
        b=RXs4gFBPT1UlD7tPVN8XahrQIHSGL57+9+zF9+WaonhEt28m4VALKoHxR0cPfeIKzE
         n8Qx+rAG8Z3uOgMGRYI06cCR6NuCOH7bkfWaduW2imCQQiXIMGVyxYEbxbGmwp77H7N0
         tdZgzc1NPfJdVZbBxgUB1E/jxgFEJo51qAgNxsuvS+bY+zmGVxsXMkhOcT5vJgP+D9z4
         +529yUZcOtaHIV8JsmX5tXBJ4ShzY6cLY0ILfaftz+EgusAFAEbHVCKmTaZqSSqyW9hx
         OMGeGkbeGyeuqu61bNgImG8NQkIbHO2CtZq5MgfSb77zu3FLURhEi7YMgbxywhds8MGl
         p8hg==
X-Gm-Message-State: ABy/qLZeB7wpQRgZDt6J98u0F1oJriGBR9KjEJjUFXboRKnerlXZ2+KS
        3LPXjnARG5JXpOChjOIfhOeCx+yWssk51QzDZ7XWdA==
X-Google-Smtp-Source: APBJJlF+444Rtf5lv/i1FfrEOMuYg/0oSCGX92ogiIgjyKKypfPbtbiXcWR15nGp46E9p7ad2yllRJQXa/JNva2tC4Y=
X-Received: by 2002:a05:6871:720:b0:1b7:30eb:9055 with SMTP id
 f32-20020a056871072000b001b730eb9055mr7023268oap.49.1689373029563; Fri, 14
 Jul 2023 15:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230714120222.3920248-1-pinkperfect2021@gmail.com>
In-Reply-To: <20230714120222.3920248-1-pinkperfect2021@gmail.com>
From:   Matthew Wang <matthewmwang@chromium.org>
Date:   Sat, 15 Jul 2023 00:16:58 +0200
Message-ID: <CABRiz0q8ujbAvYJCQFtx4gvxG4H_FGM5TZWdWULX0UpoZhH=uQ@mail.gmail.com>
Subject: Re: [PATCH v5] wifi: mwifiex: Fix OOB and integer underflow when rx packets
To:     Polaris Pi <pinkperfect2021@gmail.com>
Cc:     kuba@kernel.org, amitkarwar@gmail.com, kvalo@kernel.org,
        ganapathi017@gmail.com, sharvari.harisangam@nxp.com,
        huxinming820@gmail.com, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 2:02=E2=80=AFPM Polaris Pi <pinkperfect2021@gmail.c=
om> wrote:
>
> Make sure mwifiex_process_mgmt_packet and its callers
> mwifiex_process_sta_rx_packet and mwifiex_process_uap_rx_packet
> not out-of-bounds access the skb->data buffer.
>
> Fixes: 2dbaf751b1de ("mwifiex: report received management frames to cfg80=
211")
> Signed-off-by: Polaris Pi <pinkperfect2021@gmail.com>
> ---
> V5: Follow chromeos comments: preserve the original flow of mwifiex_proce=
ss_uap_rx_packet
> ---
>  drivers/net/wireless/marvell/mwifiex/sta_rx.c   |  3 ++-
>  drivers/net/wireless/marvell/mwifiex/uap_txrx.c | 11 +++++++++++
>  drivers/net/wireless/marvell/mwifiex/util.c     |  5 +++++
>  3 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/marvell/mwifiex/sta_rx.c b/drivers/net/=
wireless/marvell/mwifiex/sta_rx.c
> index 13659b02ba88..88aaec645291 100644
> --- a/drivers/net/wireless/marvell/mwifiex/sta_rx.c
> +++ b/drivers/net/wireless/marvell/mwifiex/sta_rx.c
> @@ -194,7 +194,8 @@ int mwifiex_process_sta_rx_packet(struct mwifiex_priv=
ate *priv,
>
>         rx_pkt_hdr =3D (void *)local_rx_pd + rx_pkt_offset;
>
> -       if ((rx_pkt_offset + rx_pkt_length) > (u16) skb->len) {
> +       if ((rx_pkt_offset + rx_pkt_length) > (u16)skb->len ||
> +           skb->len - rx_pkt_offset < sizeof(*rx_pkt_hdr)) {
>                 mwifiex_dbg(adapter, ERROR,
>                             "wrong rx packet: len=3D%d, rx_pkt_offset=3D%=
d, rx_pkt_length=3D%d\n",
>                             skb->len, rx_pkt_offset, rx_pkt_length);
> diff --git a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c b/drivers/ne=
t/wireless/marvell/mwifiex/uap_txrx.c
> index e495f7eaea03..32f4626a4d76 100644
> --- a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
> +++ b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
> @@ -367,6 +367,17 @@ int mwifiex_process_uap_rx_packet(struct mwifiex_pri=
vate *priv,
>         rx_pkt_type =3D le16_to_cpu(uap_rx_pd->rx_pkt_type);
>         rx_pkt_hdr =3D (void *)uap_rx_pd + le16_to_cpu(uap_rx_pd->rx_pkt_=
offset);
>
> +       if (le16_to_cpu(uap_rx_pd->rx_pkt_offset) > skb->len ||
> +           skb->len - le16_to_cpu(uap_rx_pd->rx_pkt_offset) < sizeof(*rx=
_pkt_hdr)) {

The second condition is strictly a subset of the first. Can we just make th=
is:

le16_to_cpu(uap_rx_pd->rx_pkt_offset) + sizeof(*rx_pkt_hdr) > skb->len

> +               mwifiex_dbg(adapter, ERROR,
> +                           "wrong rx packet offset: len=3D%d, offset=3D%=
d\n",
> +                           skb->len, le16_to_cpu(uap_rx_pd->rx_pkt_offse=
t));
> +               priv->stats.rx_dropped++;
> +
> +               dev_kfree_skb_any(skb);
> +               return 0;
> +       }
> +
>         ether_addr_copy(ta, rx_pkt_hdr->eth803_hdr.h_source);
>
>         if ((le16_to_cpu(uap_rx_pd->rx_pkt_offset) +
> diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wi=
reless/marvell/mwifiex/util.c
> index 94c2d219835d..31e1a82883e4 100644
> --- a/drivers/net/wireless/marvell/mwifiex/util.c
> +++ b/drivers/net/wireless/marvell/mwifiex/util.c
> @@ -399,6 +399,11 @@ mwifiex_process_mgmt_packet(struct mwifiex_private *=
priv,
>
>         pkt_len =3D le16_to_cpu(rx_pd->rx_pkt_length);
>
> +       if (pkt_len < sizeof(struct ieee80211_hdr) || skb->len < pkt_len)=
 {
> +               mwifiex_dbg(priv->adapter, ERROR, "invalid rx_pkt_length"=
);
> +               return -1;
> +       }
> +
>         ieee_hdr =3D (void *)skb->data;
>         if (ieee80211_is_mgmt(ieee_hdr->frame_control)) {
>                 if (mwifiex_parse_mgmt_packet(priv, (u8 *)ieee_hdr,
> --
> 2.25.1
>
