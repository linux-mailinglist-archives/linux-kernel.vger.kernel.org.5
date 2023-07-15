Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2788B754C04
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 22:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjGOUXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 16:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjGOUW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 16:22:58 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D58D2707
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 13:22:57 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3a1c162cdfeso2286686b6e.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 13:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689452576; x=1692044576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STm6LkRTWi6KPP077fUx+V22dGnylBXk6BWjTWf9c5Q=;
        b=UplMPPtxWpR+M1tc1YmgYZwfsstBdqB/7ya0NgKvoPH4uS5+eZiyNMUGtlcCT/WGE5
         Kkg95bU2jd6uaDNX09hN0jQhgcbYc7s6lslyObvmy1tzZlNJviIo5ZpqtGGfBkESlwDJ
         hdpx9DywYD9wI9/lT2z44nS+iIVB0Gl7hEdLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689452576; x=1692044576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STm6LkRTWi6KPP077fUx+V22dGnylBXk6BWjTWf9c5Q=;
        b=IyEsVRM7Fff7MVwUcOia4nRH6VaY7+bBFxD2RXSaTCWs9ogXh/Y5IkXWzjJqIEldZw
         fRuP1E7ln0wXid+OD3puIcRvet/tNZRjsehkcYXthPjp0XCRuKFD+k8qEEqa/Yw2cwuj
         YkS+TKa3+YyHNdTjpZxUCpjbszXructu8GD8rSIE1DLasoJgiEBXXCaIJzi/lCLzlhpW
         ybkCsx2fuS8iAXNrSYEyUpxno3nxtN3XxyvRLMN3JmdCiIFHIKjRont600l4/7dzD2N1
         HcuzRJh6b74rL6fvZSR/GOWEi4fm5sMsI0Fs7mVnoad5Za2PIjAJkQCin4jjGq8dBgyr
         cpaA==
X-Gm-Message-State: ABy/qLZDiJIY0v4yb3ZsduJh5eYBoJzeYnfarEOCmCAherkuZqotc7Nb
        5nNct4KT+MhIbmI8AskSSuXafEIKx8bMnsOVh+8+6w==
X-Google-Smtp-Source: APBJJlHJdHTFo7V2BQV74YAeVfMeCZgqlAxzMn625VyvO6ThFwBrne1mLIXfJmPujhAa+DkO3pLnXiid3t6cyJpMyFw=
X-Received: by 2002:a05:6808:bd1:b0:38e:a824:27d3 with SMTP id
 o17-20020a0568080bd100b0038ea82427d3mr10093062oik.27.1689452576704; Sat, 15
 Jul 2023 13:22:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230714224809.3929539-1-pinkperfect2021@gmail.com>
In-Reply-To: <20230714224809.3929539-1-pinkperfect2021@gmail.com>
From:   Matthew Wang <matthewmwang@chromium.org>
Date:   Sat, 15 Jul 2023 22:22:45 +0200
Message-ID: <CABRiz0qR6j51QXZvNG2iZCK4__rB2w3VZ5kX+ZPWrVhuK02CyA@mail.gmail.com>
Subject: Re: [PATCH v6] wifi: mwifiex: Fix OOB and integer underflow when rx packets
To:     Polaris Pi <pinkperfect2021@gmail.com>
Cc:     kuba@kernel.org, kuabhs@chromium.org, amitkarwar@gmail.com,
        kvalo@kernel.org, ganapathi017@gmail.com,
        sharvari.harisangam@nxp.com, huxinming820@gmail.com,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Matthew Wang <matthewmwang@chromium.org>

On Sat, Jul 15, 2023 at 12:48=E2=80=AFAM Polaris Pi <pinkperfect2021@gmail.=
com> wrote:
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
> V6: Simplify check in mwifiex_process_uap_rx_packet
> ---
>  drivers/net/wireless/marvell/mwifiex/sta_rx.c   |  3 ++-
>  drivers/net/wireless/marvell/mwifiex/uap_txrx.c | 10 ++++++++++
>  drivers/net/wireless/marvell/mwifiex/util.c     |  5 +++++
>  3 files changed, 17 insertions(+), 1 deletion(-)
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
> index e495f7eaea03..f0711b73ba3e 100644
> --- a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
> +++ b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
> @@ -367,6 +367,16 @@ int mwifiex_process_uap_rx_packet(struct mwifiex_pri=
vate *priv,
>         rx_pkt_type =3D le16_to_cpu(uap_rx_pd->rx_pkt_type);
>         rx_pkt_hdr =3D (void *)uap_rx_pd + le16_to_cpu(uap_rx_pd->rx_pkt_=
offset);
>
> +       if (le16_to_cpu(uap_rx_pd->rx_pkt_offset) + sizeof(*rx_pkt_hdr) >=
 skb->len) {
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
