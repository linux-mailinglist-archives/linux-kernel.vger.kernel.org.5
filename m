Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA997D5C99
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 22:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344191AbjJXUtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 16:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbjJXUtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 16:49:39 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBD910CE;
        Tue, 24 Oct 2023 13:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=n1hoWu1QQf0mXz91DzUGE4OYJa5WmwrJOSpDXP5IzqI=;
        t=1698180576; x=1699390176; b=bWzwrTaYFO871kF17LNz7WP+SIeLlMVRtFbrMa5YBbdPF8R
        2LJ0r4gIxXgLE6ndCjhpYXYg5MU+PsVOUiHfu4geyi8kNHXYMTO+scODdYP5Qtv+FNzSQcYarMOEf
        xncewFLOf33lDoy9LZd7qOtrc5JF1LGVMugShLfZm2JI/42NLn5/r0QpcPa79V+wKIiGQHhC4otQJ
        UAEkoLQxYGOW8L2ctWNa7YxnFZHPz4d82b4sfa3EmqPt1t+IiVI8WGfrLpdtXodtZAmSR8eMphr3q
        kXtIvhXVzZ3LuBQSLYxWw4SspZCFcoZAQj2Fxk9YyjQNxA5DZVlZyeniGeiv67DQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qvOLC-00000001bbh-1i2d;
        Tue, 24 Oct 2023 22:49:30 +0200
Message-ID: <f8daa53ee8a8019e4fd2b823c1fcb85a6cc4d806.camel@sipsolutions.net>
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
Date:   Tue, 24 Oct 2023 22:49:29 +0200
In-Reply-To: <07e9bb04-f9fc-46d5-bfb9-a00a63a707c0@embeddedor.com>
References: <626ae2e7-66f8-423b-b17f-e75c1a6d29b3@embeddedor.com>
         <26b15f4702cef17fe70b496a62f03735874bd16a.camel@sipsolutions.net>
         <07e9bb04-f9fc-46d5-bfb9-a00a63a707c0@embeddedor.com>
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

On Tue, 2023-10-24 at 14:41 -0600, Gustavo A. R. Silva wrote:
>=20
> It seems we run into the same issue in the function below, even in the
> case this `memset()` is unnecessary (which it seems it's not):
>=20
> 	8920         memset(skb->data, 0, sizeof(*cmd));
>=20
> Notice that if `cap->peer_chan_len =3D=3D 0` or `cap->peer_chan_len =3D=
=3D 1`,
> in the original code, we have `len =3D=3D sizeof(*cmd) =3D=3D 128`:

Right.

> -       /* tdls peer update cmd has place holder for one channel*/
> -       chan_len =3D cap->peer_chan_len ? (cap->peer_chan_len - 1) : 0;
> -
> -       len =3D sizeof(*cmd) + chan_len * sizeof(*chan);
> +       len =3D struct_size(cmd, peer_capab.peer_chan_list, cap->peer_cha=
n_len);
>=20
>          skb =3D ath10k_wmi_alloc_skb(ar, len);
>          if (!skb)
>=20
> which makes `round_len =3D=3D roundup(len, 4) =3D=3D struct_size(cmd,...,=
...) =3D=3D 104`
> when `cap->peer_chan_len =3D=3D 0`

And yeah, that's really the issue, it only matters for =3D=3D0. For a momen=
t
there I thought that doesn't even make sense, but it looks like it never
even becomes non-zero.

No idea then, sorry. You'd hope firmware doesn't care about the actual
message size if the inner data says "0 entries", but who knows? And how
many firmware versions are there? :)

So I guess you'd want to stay compatible, even if it means having a

	chan_len =3D min(cap->peer_chan_len, 1);

for the struct_size()?

johannes
