Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F70F7D5C31
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 22:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344272AbjJXULt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 16:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343896AbjJXULs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 16:11:48 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CD8A2;
        Tue, 24 Oct 2023 13:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=nfdtctD5s+siSQUr/kengnC4iQIqyN5aDOBCjVSm0Aw=;
        t=1698178306; x=1699387906; b=CW1rVgPN9ACYbDs9KcCyOkgT54qDYgMO+Ev59qad5F9x/xQ
        egyesXxAAE6rTo4Dw/o/1/3ZEe/ft+CJnamQ5mYdmM69n+uEwXTTJ7wUvqIdDLKAvHedExeTbm17r
        vrUxxXm6LZqzNYhiQ6vDpkBFNf+gfrhMztsZw/Q7XfTBFMW4Tega6OxwuECBtHol1yzlyDZ1FTEFl
        R3FhUKoFufDFRG5PlI9W2H3OlLVprEUcJ8g1HeSn1Xyka91qRZ0cq1ycC3uDjXNol5vR1M4Tbbwgw
        vGFUCibVGLoOOQ439aJQtRJkcpoc7cqiqU/KBto4JFn03ajqWoK1YXptuhJTzpQg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qvNkZ-00000001akU-3Ra3;
        Tue, 24 Oct 2023 22:11:40 +0200
Message-ID: <26b15f4702cef17fe70b496a62f03735874bd16a.camel@sipsolutions.net>
Subject: Re: [RFC - is this a bug?] wifi: ath10k: Asking for some light on
 this, please :)
From:   Johannes Berg <johannes@sipsolutions.net>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Date:   Tue, 24 Oct 2023 22:11:38 +0200
In-Reply-To: <626ae2e7-66f8-423b-b17f-e75c1a6d29b3@embeddedor.com>
References: <626ae2e7-66f8-423b-b17f-e75c1a6d29b3@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-10-24 at 13:50 -0600, Gustavo A. R. Silva wrote:
> Hi all,
>=20
> While working on tranforming one-element array `peer_chan_list` in
> `struct wmi_tdls_peer_capabilities` into a flex-array member
>=20
> 7187 struct wmi_tdls_peer_capabilities {
> ...
> 7199         struct wmi_channel peer_chan_list[1];
> 7200 } __packed;
>=20
> the following line caught my attention:
>=20
> ./drivers/net/wireless/ath/ath10k/wmi.c:
> 8920         memset(skb->data, 0, sizeof(*cmd));
>=20
> Notice that before the flex-array transformation, we are zeroing 128
> bytes in `skb->data` because `sizeof(*cmd) =3D=3D 128`, see below:


> So, my question is: do we really need to zero out those extra 24 bytes in
> `skb->data`? or is it rather a bug in the original code?
>=20

If we look a step further, I _think_ even that memset is unnecessary?


struct sk_buff *ath10k_wmi_alloc_skb(struct ath10k *ar, u32 len)
{
        struct sk_buff *skb;
        u32 round_len =3D roundup(len, 4);

        skb =3D ath10k_htc_alloc_skb(ar, WMI_SKB_HEADROOM + round_len);
        if (!skb)
                return NULL;

        skb_reserve(skb, WMI_SKB_HEADROOM);
        if (!IS_ALIGNED((unsigned long)skb->data, 4))
                ath10k_warn(ar, "Unaligned WMI skb\n");

        skb_put(skb, round_len);
        memset(skb->data, 0, round_len);

        return skb;
}


So shouldn't the outgoing skb be exactly the same?

Anyway, just looking at the code out of curiosity, I don't actually know
anything about this driver :)

johannes
