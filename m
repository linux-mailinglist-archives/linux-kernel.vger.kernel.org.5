Return-Path: <linux-kernel+bounces-24251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC86382B9C3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 03:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FD5D28737E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 02:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B941390;
	Fri, 12 Jan 2024 02:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="k3OUmtM7"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462C263F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 02:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1705028247;
	bh=xepTqcl9suzdLR8lMHdRnGuSlDf39865QxwWYUYjY90=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k3OUmtM7mowl5kLHrw0MQKDXZIuKnsHmOJjHg6J8UGZD407kxs5GhZdbmtd0LMNwi
	 SSVO0xkNAc39r/LSoIpKQt7cR1Z6nMACDi/DyQU1QIlvm/yl8ynz7iOD4M4P2rnLNN
	 99Zm01OiPlEt8MTCL9rdAeQ7wHD6lmL95b++NkqzNCZ1GvP9cJkVUyS26JpjywQcbS
	 nHXvCRHqJ7nlstaCRvfmc10oDPsNIIKszWrkqBhV1ravBfTGwD1z70svAAuPCD8b2g
	 C0gD/wPhwYP0Wf/D7q4I14gcDxTmKPY/9jdvZp7RbsLUFOoS3HE5NTHFQjekG96q1z
	 For7W/T1OGDvQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TB5mk2hB6z4wy9;
	Fri, 12 Jan 2024 13:57:26 +1100 (AEDT)
Date: Fri, 12 Jan 2024 13:57:25 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, syzbot
 <syzbot+705209281e36404998f6@syzkaller.appspotmail.com>, Peter Xu
 <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 aarcange@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] kernel BUG in move_pages
Message-ID: <20240112135725.2038ea89@canb.auug.org.au>
In-Reply-To: <CAJuCfpFxoDzQ_MBQe127pdWBRxugN2c7QsoemvHp+qCnfir+JQ@mail.gmail.com>
References: <00000000000011d709060eadffd3@google.com>
	<CAJuCfpG-8w_KQ8bWvSr=GrXM+Jx3YKn5DqTFJU2MaMojML_a-A@mail.gmail.com>
	<CAJuCfpFfKYn+G1+puQ0KxzWCnbfFT51tKwV8MnrP7YZcJAORwg@mail.gmail.com>
	<CAJuCfpHTAAPEjMLrcxyG8zW7HA47EinB8CQfKGmBw7gGxqQ=vA@mail.gmail.com>
	<5ed23cf3-eedd-44aa-a498-d2a9ab046535@redhat.com>
	<CAJuCfpG5T71Sc46pB2eGpV7TreMZX2VZ-kDfaNmtn+etP0q9JA@mail.gmail.com>
	<bf9dbc58-35c4-4a35-b194-6d8d9e7e4923@redhat.com>
	<CAJuCfpGRA7KJhMBneqAj+dw=rQReU7PyR1r34yqrNSoa-RUKbg@mail.gmail.com>
	<15ce90cd-ff0b-4bc3-bee4-880bee3200ae@redhat.com>
	<CAJuCfpFcjxX4RkcYyzLWMBqPw4amzbiJCZx8UdmM1H2_QkoOqA@mail.gmail.com>
	<CAJuCfpFQaKMh9c8e4YMvqh5ZDoX91C3RWYaB-vsX5YgwC=wvcg@mail.gmail.com>
	<CAJuCfpFxoDzQ_MBQe127pdWBRxugN2c7QsoemvHp+qCnfir+JQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DKxx/VTs3TW31WnEj7VJZHZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/DKxx/VTs3TW31WnEj7VJZHZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 11 Jan 2024 17:44:57 -0800 Suren Baghdasaryan <surenb@google.com> w=
rote:
>
> I posted a quick fix for this issue here:
> https://lore.kernel.org/all/20240112013935.1474648-1-surenb@google.com/
> It cleanly applies over linux-next, mm-stable and mm-unstable. Andrew,
> Stephen, could you please pull the fix into your branches?

Since I will be away for a few days, I have applied that to linux-next toda=
y.

--=20
Cheers,
Stephen Rothwell

--Sig_/DKxx/VTs3TW31WnEj7VJZHZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWgqpUACgkQAVBC80lX
0GwwWQf/VnMGKKLPcqsbhZGQW7mXDvZtyr0Fi8PxCqYGCGdmxWuBzcWur4LLzABu
ntYXrwXH8twVC62/GvSFSiPgfvkeF5Fliqptia5avxcfDiJzp3Rl0E8SB1y3xJ4V
5tWArIacndgwqFzpLM/RL4ytu85ttM02cAZn92+CgpdDLIemrZHWFT3Ui1ThFAYX
tD391GA7UUB9K0Wp0+1mnBgkYQxjzpb3WscYlVHnT7XxnvpqqtzweBluUk4QDCGk
fEk91nzGOAlBPLz2AUqMFIMeBrRJV6mT6bSwCsbHT42In2D4dWcMgQrtWOkrnJ7u
/hDlrIvon+Uj0ESpJ8JaP4/6VXGrkA==
=u/W6
-----END PGP SIGNATURE-----

--Sig_/DKxx/VTs3TW31WnEj7VJZHZ--

