Return-Path: <linux-kernel+bounces-91444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D234D871190
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 390F2B23CF1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F5D1C11;
	Tue,  5 Mar 2024 00:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Y1ttMkUX"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CDA647;
	Tue,  5 Mar 2024 00:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709597961; cv=none; b=YPwZmSLbtOdMr27HnPBtywii9S+pWJcPyZ7Aii/AXUM4wfGj/yqdMVpGuNnbPTzbgOEhOo+dtO4ErhWOGxcgyVVvU15ZEUVFGTLRbCWgTXKJRAxEHubPTxXAX4vnoeqmbK3CQHe7XFrUv6HDmBza7txmVZ/kVXYP8jsayWeQrYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709597961; c=relaxed/simple;
	bh=vWe/Iah/qneo1EiM9nKXq+OXjLo2iX4yMleyyY+4Lhk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h0yGjwHTYs4t2gox6s1L0TF+50juDTVVBTy9qwfD9Vx8/vbLJPnbxpYsJs6UcVE5QPST6aoXA0VmiWIdGFnNzCuqT9eZId9MNhTzBTtGq8D/lbEo/qzWoUsn7A4I84UptvK2NxMGE349hjbUdEkYE98qMcAfS8KjuC2qOYTBfeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Y1ttMkUX; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709597956;
	bh=wTnRdSHTrw7SLJclAIWYZgsb2Tzbj1bZxuYcSQ1MOuw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y1ttMkUXqXydxSJrgpQqaRpYzmwWAmxzInPP9Ecb6+4H8R+VjDElSvhDGIO3L+P3t
	 AydmMnfkSdEP/1PHwmq+C/f9nu5PDivNPXLrzLNzxxtbDcBY3vZLB8DAb749fS9gA+
	 iKiYOAXgWOCKDDFQdS9tGDc+ilHMYGdU8YCeaqdZv1Td2KiUW9QCyjc0/hueop5t2F
	 kARtajSK4fcZInFD3cidSkOYMIjWbrz22bzzasnf3ESOOapMaNggPIoWLHjvx6Accj
	 00Rg6GIWKD6bBixDQ5BMJDzYa4btyFmD13thMHypfcRr7Y+PJ5is6qXHszbx4hHN87
	 ivONrZJ6glr9g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tpbll5srTz4wc9;
	Tue,  5 Mar 2024 11:19:15 +1100 (AEDT)
Date: Tue, 5 Mar 2024 11:19:15 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Eric Dumazet <edumazet@google.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Networking <netdev@vger.kernel.org>, Jiri
 Pirko <jiri@nvidia.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the net-next tree
Message-ID: <20240305111915.742aaf1f@canb.auug.org.au>
In-Reply-To: <CANn89iKsbT_qAdAiP6R6HRxic1YE3J6afMhWzF27Pbn2ifeCyg@mail.gmail.com>
References: <20240301121108.5d39e4f9@canb.auug.org.au>
	<CANn89iKpsHTQ9Zqz4cbCGOuj8sp5CCYGHe3Wvk2cyQL4HPADkw@mail.gmail.com>
	<CANn89iKsbT_qAdAiP6R6HRxic1YE3J6afMhWzF27Pbn2ifeCyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//0OK9MpWFRWZb=MOrx_m8GI";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_//0OK9MpWFRWZb=MOrx_m8GI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Fri, 1 Mar 2024 10:54:19 +0100 Eric Dumazet <edumazet@google.com> wrote:
>
> OK, I think the issue is caused by a hole at the start of
> tcp_sock_write_rx group
>=20
> I will send this patch for review, thanks !
>=20
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index 988a30ef6bfe956fa573f1f18c8284aa382dc1cc..55399ee2a57e736b55ed067fc=
06ea620bbe62fd3
> 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -304,7 +304,7 @@ struct tcp_sock {
>         __cacheline_group_end(tcp_sock_write_txrx);
>=20
>         /* RX read-write hotpath cache lines */
> -       __cacheline_group_begin(tcp_sock_write_rx);
> +       __cacheline_group_begin(tcp_sock_write_rx) __aligned(8);
>         u64     bytes_received;
>                                 /* RFC4898 tcpEStatsAppHCThruOctetsReceiv=
ed
>                                  * sum(delta(rcv_nxt)), or how many bytes
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index c82dc42f57c65df112f79080ff407cd98d11ce68..7e1b848398d04f2da2a91c3af=
97b1e2e3895b8ee
> 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -4651,7 +4651,7 @@ static void __init tcp_struct_check(void)
>         CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock,
> tcp_sock_write_tx, tsorted_sent_queue);
>         CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock,
> tcp_sock_write_tx, highest_sack);
>         CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock,
> tcp_sock_write_tx, ecn_flags);
> -       CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_tx, 1=
13);
> +       CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_tx, 1=
05);
>=20
>         /* TXRX read-write hotpath cache lines */
>         CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock,
> tcp_sock_write_txrx, pred_flags);

I will apply this patch to them merge of the net-next tree until it is
applied there.

--=20
Cheers,
Stephen Rothwell

--Sig_//0OK9MpWFRWZb=MOrx_m8GI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXmZQMACgkQAVBC80lX
0GwgVQf/UzJ5KS73jOaujls1vJ3m+uZjTGSV2CR9GXdSXMqzsrTvMsg9k5FaD7Qm
2jEMT+LWqdsI3+9L3aeYpOADQl7rRIgFpecd1dRZVr57Wnq/8Ij+bKrgn7NNhLif
O8U0S6ii8NafSDOXtIB0l/O6PgaEW+YtnlOYaCFKwzsAbxaYfAa/Ke54HwhgGGRO
Bzm7CKxjcnYQ9xnyz88Ig2IKAipiuEUiPRgy3pVAyv914RXIwmwUSlDpxKR79e2p
6XfQ2QsqZ4A113Oe5nTbrTU8VeAokO8epLwZEeE3w5rAE6f0EMDYgji3UQMzEGIo
1axhga8xHAVTf8KqZTJUiRNAbdD0oA==
=tMoX
-----END PGP SIGNATURE-----

--Sig_//0OK9MpWFRWZb=MOrx_m8GI--

