Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F9A79FCD6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 09:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbjINHKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 03:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbjINHKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 03:10:03 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD86CCD
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 00:09:59 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-792623074edso44047539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 00:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694675398; x=1695280198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXGAZ78A/w9CJ0c+P/nZnXrFyXcvdwQOenfrsg4vU14=;
        b=jpD77JK0s6aZuDQ7YPA1IS1ITLzh1MB/Bm4pyjRw8Ypn8gydfMsTWuKbL5I7ieYSh9
         Jq6BhDpSUefPVurEUle+fpbT0nOlA7L9o/0mJwjNbT7AFtVLQfvLWEvKsZrg+zfsBzKL
         iYivg8iEMsNUdyCV7fuxPBgHNDPInwrdS2xAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694675398; x=1695280198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nXGAZ78A/w9CJ0c+P/nZnXrFyXcvdwQOenfrsg4vU14=;
        b=P/lxybTIo7eautI4/OmltH5Tq3yfKQg12VbCjQyKM8WrtAwKSPIDoXkCprXL/rhifX
         OfWcShMhiyqufOFD2bx83BhUYeaZZu3HcIh2Nw3W2xWsw9Eg/HUgpO9MnmzFx7zt47gr
         6rDYe7xFNllx3ldLHlsPwpjbVnwBh8AQBgK7fogzF3siV1YEpVlAn2HeIBP14WZ+3OXQ
         13llIsUPN+w8FEQQN1yxKxdFtrbDFxhO2XGiIep4LBpI398eZaUqXQ1XDm13aibMftuq
         TStlrlMc7Ncy1Em4yjLrS2yUmqzdWGQpuhMGraVE6QkNE2rejlSTjOYA71PUSvPG+Xf6
         XbpA==
X-Gm-Message-State: AOJu0YykT16u+ewE1Fi9wbSuGuBLETVXrS3425uAMsVTq7CNBAdd+RDp
        b0/ZGVQrVgj01c5RjmKfCj/1FpLKGNlz6Xl4NkekMA==
X-Google-Smtp-Source: AGHT+IHtPPjx8XHPgcJbUbC4PGXpftwQyQQvUJiU6i/Q6nSsofftIBt36ifhVhnxUWEnjQpiBfmFonGczgh5uqvp1wQ=
X-Received: by 2002:a05:6e02:1645:b0:34f:7e2f:b837 with SMTP id
 v5-20020a056e02164500b0034f7e2fb837mr1291009ilu.2.1694675398363; Thu, 14 Sep
 2023 00:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230908104308.1546501-1-treapking@chromium.org> <ZQIcDWKrmgoPkwlN@google.com>
In-Reply-To: <ZQIcDWKrmgoPkwlN@google.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Thu, 14 Sep 2023 15:09:47 +0800
Message-ID: <CAEXTbpc=QC6wC-W2VZCaRCp6rSpyNSsq5M6cxNcqAQxciNj0vg@mail.gmail.com>
Subject: Re: [PATCH v3] wifi: mwifiex: Fix oob check condition in mwifiex_process_rx_packet
To:     Brian Norris <briannorris@chromium.org>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Polaris Pi <pinkperfect2021@gmail.com>,
        Matthew Wang <matthewmwang@chromium.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,

Thanks for the review.

On Thu, Sep 14, 2023 at 4:31=E2=80=AFAM Brian Norris <briannorris@chromium.=
org> wrote:
>
> On Fri, Sep 08, 2023 at 06:41:12PM +0800, Pin-yen Lin wrote:
> > Only skip the code path trying to access the rfc1042 headers when the
> > buffer is too small, so the driver can still process packets without
> > rfc1042 headers.
> >
> > Fixes: 119585281617 ("wifi: mwifiex: Fix OOB and integer underflow when=
 rx packets")
> > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
>
> I'd appreciate another review/test from one of the others here
> (Matthew?), even though I know y'all are already working together.
>
> > ---
> >
> > Changes in v3:
> > - Really apply the sizeof call fix as it was missed in the previous pat=
ch
> >
> > Changes in v2:
> > - Fix sizeof call (sizeof(rx_pkt_hdr) --> sizeof(*rx_pkt_hdr))
> >
> >  drivers/net/wireless/marvell/mwifiex/sta_rx.c | 16 +++++++++-------
> >  1 file changed, 9 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/net/wireless/marvell/mwifiex/sta_rx.c b/drivers/ne=
t/wireless/marvell/mwifiex/sta_rx.c
> > index 65420ad67416..257737137cd7 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/sta_rx.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/sta_rx.c
> > @@ -86,7 +86,8 @@ int mwifiex_process_rx_packet(struct mwifiex_private =
*priv,
> >       rx_pkt_len =3D le16_to_cpu(local_rx_pd->rx_pkt_length);
> >       rx_pkt_hdr =3D (void *)local_rx_pd + rx_pkt_off;
> >
> > -     if (sizeof(*rx_pkt_hdr) + rx_pkt_off > skb->len) {
> > +     if (sizeof(rx_pkt_hdr->eth803_hdr) + sizeof(rfc1042_header) +
> > +         rx_pkt_off > skb->len) {
> >               mwifiex_dbg(priv->adapter, ERROR,
> >                           "wrong rx packet offset: len=3D%d, rx_pkt_off=
=3D%d\n",
> >                           skb->len, rx_pkt_off);
> > @@ -95,12 +96,13 @@ int mwifiex_process_rx_packet(struct mwifiex_privat=
e *priv,
> >               return -1;
> >       }
> >
> > -     if ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
> > -                  sizeof(bridge_tunnel_header))) ||
> > -         (!memcmp(&rx_pkt_hdr->rfc1042_hdr, rfc1042_header,
> > -                  sizeof(rfc1042_header)) &&
> > -          ntohs(rx_pkt_hdr->rfc1042_hdr.snap_type) !=3D ETH_P_AARP &&
> > -          ntohs(rx_pkt_hdr->rfc1042_hdr.snap_type) !=3D ETH_P_IPX)) {
> > +     if (sizeof(*rx_pkt_hdr) + rx_pkt_off <=3D skb->len &&
>
> Are you sure you want this length check to fall back to the non-802.3
> codepath? Isn't it an error to look like an 802.3 frame but to be too
> small? I'd think we want to drop such packets, not process them as-is.

I did that because I saw other drivers (e.g., [1], [2]) use similar
approaches, and I assumed that the rest of the pipeline will
eventually drop it if the packet cannot be recognized. But, yes, we
can just drop the packet here if it doesn't look good.

[1]: https://elixir.bootlin.com/linux/latest/source/drivers/net/wireless/in=
tersil/hostap/hostap_80211_rx.c#L1035
[2]: https://elixir.bootlin.com/linux/latest/source/drivers/net/wireless/in=
tel/ipw2x00/libipw_rx.c#L735
>
> If I'm correct, then this check should move inside the 'if' branch of
> this if/else.

We can't simply move the check inside the if branch because the
condition also checks rx_pkt_hdr->rfc1042_hdr.snap_type. Though, of
course, it is doable by adding another `if` conditions.
>
> Brian
>

Regards,
Pin-yen

> > +         ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
> > +                   sizeof(bridge_tunnel_header))) ||
> > +          (!memcmp(&rx_pkt_hdr->rfc1042_hdr, rfc1042_header,
> > +                   sizeof(rfc1042_header)) &&
> > +           ntohs(rx_pkt_hdr->rfc1042_hdr.snap_type) !=3D ETH_P_AARP &&
> > +           ntohs(rx_pkt_hdr->rfc1042_hdr.snap_type) !=3D ETH_P_IPX))) =
{
> >               /*
> >                *  Replace the 803 header and rfc1042 header (llc/snap) =
with an
> >                *    EthernetII header, keep the src/dst and snap_type
> > --
> > 2.42.0.283.g2d96d420d3-goog
> >
