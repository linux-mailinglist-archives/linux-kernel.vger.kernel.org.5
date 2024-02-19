Return-Path: <linux-kernel+bounces-71350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC90385A3D6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D7111F23BEA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD1B2E85A;
	Mon, 19 Feb 2024 12:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efSH1iWp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43942E844
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708347151; cv=none; b=B2iX62Y0YZ+AorreLZeCELMAgdeujbHzDnRgXsVQuNWbeeB94QSB44GSK3A5q9dOf825AHtg2uFqgvdM/cWFMykBwVmqA1wajrqPmdeqjuOrtJPhKJTy+68cpfSJJOByrwniXE3Uou6WHcSCbg9kKFl7x9l1x+u9OaJKhEJqR9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708347151; c=relaxed/simple;
	bh=oFTNQdLe9IZPhk9GU/tAEuzjPFGM/mjuC7YNdKT5FeM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o+HgGoc2gcqUMb6K2UuXwjBF2n7QTreoInztM7gyvHRVzrQVd1ZK8k4ycis+ELUBapyRCwNisJch4sSZxRkYdqzjWibIypZQocEv6shqs5/7bXGr56P8TZzSEa2NIxDbqg80cab6hU3OWtdcETBDl/5VaR/t75803FQy1FsaJzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efSH1iWp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045B9C433F1;
	Mon, 19 Feb 2024 12:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708347150;
	bh=oFTNQdLe9IZPhk9GU/tAEuzjPFGM/mjuC7YNdKT5FeM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=efSH1iWpvJ2lvF7CV+Lz23JHIj5dcAdE4JHFDSdbVVPeBq37vZ0Iix8QV+WOPSUbI
	 oEPF49HuEbvx3+hUohbXwBMHPVcTTMoKW/0bPVPUxcfCCBC6tScCjrMdbWxjAr08Z+
	 T7LXUbcCv3c838J1dGlajH3Wp7l5R9WzroiChxC+U9ucIqJsndB4bmwO14/gFFfkbq
	 LnG3U/QIJomnz+zKMZaWjl/7snmBMGqsI/CJ6aorh9P4g+l+rDLuK2ksBK6eqxr1iP
	 ejYdCIPHxqPYKqS7kQGRM0otcMxj9mLf0csMo3iPDvaE4sSmzl6/dlH9F7uZKLi7q8
	 RSGfihMtiW+/g==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Samuel
 Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH 3/7] riscv: kprobes: Use patch_text_nosync() for insn slots
In-Reply-To: <20240212025529.1971876-4-samuel.holland@sifive.com>
References: <20240212025529.1971876-1-samuel.holland@sifive.com>
 <20240212025529.1971876-4-samuel.holland@sifive.com>
Date: Mon, 19 Feb 2024 13:52:27 +0100
Message-ID: <87a5nwfwfo.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Samuel Holland <samuel.holland@sifive.com> writes:

> These instructions are not yet visible to the rest of the system,
> so there is no need to do the whole stop_machine() dance.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
>  arch/riscv/kernel/probes/kprobes.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probe=
s/kprobes.c
> index 2f08c14a933d..cbf8197072bf 100644
> --- a/arch/riscv/kernel/probes/kprobes.c
> +++ b/arch/riscv/kernel/probes/kprobes.c
> @@ -28,9 +28,9 @@ static void __kprobes arch_prepare_ss_slot(struct kprob=
e *p)
>=20=20
>  	p->ainsn.api.restore =3D (unsigned long)p->addr + offset;
>=20=20
> -	patch_text(p->ainsn.api.insn, &p->opcode, 1);
> -	patch_text((void *)((unsigned long)(p->ainsn.api.insn) + offset),
> -		   &insn, 1);
> +	patch_text_nosync(p->ainsn.api.insn, &p->opcode, 1);
> +	patch_text_nosync(p->ainsn.api.insn + offset,
> +			  &insn, 1);

Nit: 100 chars lines!

Nice find!

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

