Return-Path: <linux-kernel+bounces-86013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0916586BE8C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B35151F2405E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADD636135;
	Thu, 29 Feb 2024 01:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QygaAOrh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC412E84B;
	Thu, 29 Feb 2024 01:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709171520; cv=none; b=jHYX0zuSHVBgyfOwsc7xSW/4C0GRy9KX+qGc4X8evD7yMpgNvuAdFwVaq30e5yypkeCTMFZ5BJ3KYGIGWDika513g783bamIP7deBm1U99eVXzllg/Doqj1KWQrVFw0zvHr6hkeQWaMFL9isr6cYAu4FO3IX9ROvYRg7+0DP3UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709171520; c=relaxed/simple;
	bh=Hia628mJqk0mdl+TojiKwXcdzR4GIqXVs2Civd7u4js=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mb+YXU3mkIofY7SbPmyuA8gCoDP/K8NZPlZwPB0XjNCqxJv5Fi6aCu9gGuPE8nXl7VPoJRT/SxDQn7n+KL3KsDVOnFovvy1GPHpnCHPFdJ57gxEBiSxSP+dBdeFAilIMB1J4ZtPVYrcWnoPehM4CYsUw+ji4zmwrU/ZbngU/Ej0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QygaAOrh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94192C433C7;
	Thu, 29 Feb 2024 01:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709171519;
	bh=Hia628mJqk0mdl+TojiKwXcdzR4GIqXVs2Civd7u4js=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QygaAOrhxDP/E65REvdBLymUwi8i7QPMMEbe2JehTbFs80zs6iPxQ+di+0u8SZmvQ
	 TbJPsxrT3GyQ9/X4auIGQQcjY29hRg+BWRvLSbU5krVgWcXwcD7l/m7Fh/QN+z7xvJ
	 nvngj1/0aOcWCKxP82VBNQAHPIM+mHhbiWGO/ADy6YKocTZVDJl+P/6fZYI67l/1R6
	 0PiyL2Rzu9GsO26iwkRN8agZG7fzPzzc694OzLNoJVGDKJBrtCX52hDAhgp2gDrBTB
	 RP8bfcuPwRXtLbul9T2YQPvV1Y9i+mL+sijCBH5n6JC+r1pmtS6I+ewNksvWyeqKxL
	 BzmC1aTZ7Q39Q==
Date: Wed, 28 Feb 2024 17:51:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Paolo Abeni <pabeni@redhat.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Charlie Jenkins <charlie@rivosinc.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Erhard Furtner <erhard_f@mailbox.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, "David S. Miller"
 <davem@davemloft.net>
Subject: Re: [PATCH net] kunit: Fix again checksum tests on big endian CPUs
Message-ID: <20240228175158.04c0aa1b@kernel.org>
In-Reply-To: <f0eeaab76d6386e22b88d9526ec7a53ae7e98ef5.camel@redhat.com>
References: <73df3a9e95c2179119398ad1b4c84cdacbd8dfb6.1708684443.git.christophe.leroy@csgroup.eu>
	<c434b94a-2072-4b74-a222-0906579a351e@csgroup.eu>
	<f0eeaab76d6386e22b88d9526ec7a53ae7e98ef5.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Feb 2024 10:06:41 +0100 Paolo Abeni wrote:
> On Sat, 2024-02-24 at 07:44 +0000, Christophe Leroy wrote:
> > Hi,
> >=20
> > Le 23/02/2024 =C3=A0 11:41, Christophe Leroy a =C3=A9crit=C2=A0: =20
> > > Commit b38460bc463c ("kunit: Fix checksum tests on big endian CPUs")
> > > fixed endianness issues with kunit checksum tests, but then
> > > commit 6f4c45cbcb00 ("kunit: Add tests for csum_ipv6_magic and
> > > ip_fast_csum") introduced new issues on big endian CPUs. Those issues
> > > are once again reflected by the warnings reported by sparse.
> > >=20
> > > So, fix them with the same approach, perform proper conversion in
> > > order to support both little and big endian CPUs. Once the conversions
> > > are properly done and the right types used, the sparse warnings are
> > > cleared as well.
> > >=20
> > > Reported-by: Erhard Furtner <erhard_f@mailbox.org>
> > > Fixes: 6f4c45cbcb00 ("kunit: Add tests for csum_ipv6_magic and ip_fas=
t_csum")
> > > Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu> =20
> >=20
> > netdev checkpatch complains about "1 blamed authors not CCed:=20
> > palmer@rivosinc.com; 1 maintainers not CCed: palmer@rivosinc.com "
> >=20
> > Palmer was copied but as Palmer Dabbelt <palmer@dabbelt.com>. Hope it i=
s=20
> > not a show stopper. =20
>=20
> No, it's not.
>=20
> Acked-by: Paolo Abeni <pabeni@redhat.com>
>=20
> I *think* this, despite the subject prefix, should go via Andrew's tree
> to avoid conflicts.
>=20
> @Andrew does the above fits you?

I don't see this in linux-next, so unless told otherwise I'll merge it
and ship to Linus tomorrow.

