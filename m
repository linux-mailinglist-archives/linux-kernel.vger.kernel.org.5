Return-Path: <linux-kernel+bounces-71368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C74D85A430
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DCD71C22D6D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2AE364A8;
	Mon, 19 Feb 2024 13:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRQOXAiM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202512D610
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 13:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708347802; cv=none; b=MIayz15o/qLJfZXVLD2rvbW/C0Fe3waTGvB4SSflv2pInI2RrKLjW4/nQ3LeRDkS2NuzxwCsDWLR6MbFWgMGrsWTWZ4NI75INerxmULOKGvUp/7oFz7qkmEYYqW050M84tVRrH7q0809JGBD586EsKJJV9PCKqepcn9Bivxkm+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708347802; c=relaxed/simple;
	bh=Cw01mhaoUD3dZvwZMcIsBldKkiKVpb79QSBQh1zE1Qk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QEKCgl9cOdRCGEyXbPh2f2ZWBbKuvR7XbSpYniTz22ysIwOdbqLEz31bNEZWncTV131H7EoA7Ydv/S+y2uHIWN7vWPhKElRvgP0bdmwW8wcmKSgjZsDd19b1ADCdcr74MdFD9uuIcLMIo0lHGDty4AUYgELi2okVAOe55F4OU+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRQOXAiM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE46C433F1;
	Mon, 19 Feb 2024 13:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708347802;
	bh=Cw01mhaoUD3dZvwZMcIsBldKkiKVpb79QSBQh1zE1Qk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SRQOXAiMD27AreHIedFyqsVZHI3jim/KHyFi+9a3X2f+CD9v105Byq/89ajQZfyFo
	 SRMgbcDaqCACtD8mH+j/VCB7AGcAtQSqSKbNTPGSWAQpJwUAQZi1qGhgeES7HOQ2cT
	 J9FGDpHUzFFCRLqBs2fKBEbtwn+4m3cJdq+KssC0EWIjqlsroX0q2zCYADw/BlL73m
	 dUGny+A599zcAhUE0OOzA96ylNBkLzzV/ZJgHIB/y25p5gHAv035vtcTUazvLNQoa/
	 +nTA3tPeGxDfa2lQ7fFhS+ZtsrCHjHlVTPL+jb/8wbLaRSbo5n2tUFrq+aUNNW8fBG
	 /UqyIH0HGkhYg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Samuel
 Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH 4/7] riscv: Simplify text patching loops
In-Reply-To: <20240212025529.1971876-5-samuel.holland@sifive.com>
References: <20240212025529.1971876-1-samuel.holland@sifive.com>
 <20240212025529.1971876-5-samuel.holland@sifive.com>
Date: Mon, 19 Feb 2024 14:03:18 +0100
Message-ID: <874je4fvxl.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Samuel Holland <samuel.holland@sifive.com> writes:

> This reduces the number of variables and makes the code easier to parse.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
>  arch/riscv/kernel/patch.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> index bccd9ed04a05..7f030b46eae5 100644
> --- a/arch/riscv/kernel/patch.c
> +++ b/arch/riscv/kernel/patch.c
> @@ -155,7 +155,6 @@ NOKPROBE_SYMBOL(__patch_insn_write);
>=20=20
>  static int patch_insn_set(void *addr, u8 c, size_t len)
>  {
> -	size_t patched =3D 0;
>  	size_t size;
>  	int ret =3D 0;
>=20=20
> @@ -163,11 +162,12 @@ static int patch_insn_set(void *addr, u8 c, size_t =
len)
>  	 * __patch_insn_set() can only work on 2 pages at a time so call it in a
>  	 * loop with len <=3D 2 * PAGE_SIZE.
>  	 */
> -	while (patched < len && !ret) {
> -		size =3D min_t(size_t, PAGE_SIZE * 2 - offset_in_page(addr + patched),=
 len - patched);
> -		ret =3D __patch_insn_set(addr + patched, c, size);
> +	while (len && !ret) {
> +		size =3D min_t(size_t, PAGE_SIZE * 2 - offset_in_page(addr), len);
> +		ret =3D __patch_insn_set(addr, c, size);

While you're at it, do:
  ret =3D __patch_insn_set(addr, c, size);
  if (ret)
          return ret;
  ...
return 0;
}

and simplify the while-loop predicate?

>=20=20
> -		patched +=3D size;
> +		addr +=3D size;
> +		len -=3D size;
>  	}
>=20=20
>  	return ret;
> @@ -190,7 +190,6 @@ NOKPROBE_SYMBOL(patch_text_set_nosync);
>=20=20
>  int patch_insn_write(void *addr, const void *insn, size_t len)
>  {
> -	size_t patched =3D 0;
>  	size_t size;
>  	int ret =3D 0;
>=20=20
> @@ -198,11 +197,13 @@ int patch_insn_write(void *addr, const void *insn, =
size_t len)
>  	 * Copy the instructions to the destination address, two pages at a time
>  	 * because __patch_insn_write() can only handle len <=3D 2 * PAGE_SIZE.
>  	 */
> -	while (patched < len && !ret) {
> -		size =3D min_t(size_t, PAGE_SIZE * 2 - offset_in_page(addr + patched),=
 len - patched);
> -		ret =3D __patch_insn_write(addr + patched, insn + patched, size);
> +	while (len && !ret) {
> +		size =3D min_t(size_t, PAGE_SIZE * 2 - offset_in_page(addr), len);
> +		ret =3D __patch_insn_write(addr, insn, size);

Same comment as above.


Bj=C3=B6rn

