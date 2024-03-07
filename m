Return-Path: <linux-kernel+bounces-96148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 498EB8757AF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3B0B282E80
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F651369BD;
	Thu,  7 Mar 2024 19:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rgt1cBUs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABB61EB56;
	Thu,  7 Mar 2024 19:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709841448; cv=none; b=noriz84jGVyGqnNqSnO1eT7vXrodz3GtakqEDGDcHEWLnr7WEZNljtYqEWQJ+i3WFchH9m0PRVeZ5WI4nlfixqe1xhBrmnJz4KHoMj+02meWfNSLT3uzFnO5WcjUzedNVvtaq/rtYVioOAfE5aRJApPHHoUyFOy+X01fHECA1mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709841448; c=relaxed/simple;
	bh=fOsKn2f9zmPGdpFx8KnXbnRFneCgwvg7ZyYzVHMdDUQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=hf6Dohlh1j7rLg4/5Iz2la45cpFnDAtJv5WV9w6C/GfMnwbZbiS0YyU9AHi+jWYVuanRMPrbBF0xjlvgnJ//bnnoYaZ9cbhNKzNIjMjPT2i1dStrjADsverYBTWyRF9jWuqfcXhSiWHDaDPT/WzXRMU/YcoLLbjP8HyUGujW28I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rgt1cBUs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4858FC433F1;
	Thu,  7 Mar 2024 19:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709841448;
	bh=fOsKn2f9zmPGdpFx8KnXbnRFneCgwvg7ZyYzVHMdDUQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=Rgt1cBUsraDPPk+fgftIJwCdAGYpX0MO1sI2vhONF8NqS0poeL5TMd/ZfmmyC48Vu
	 KCcSkw/FZSRWxbcxLewqonJaQYViDP2xI7+SDf9GuxSJnQydNWCRIWOwGlmAylkWVY
	 QADULHnRfDANW6HA8eCzAyjhDCmYTRetwPZ0K/TGXv4907WA0b7NXb+xcp5hBh1oPt
	 vsNfmGjUmNAy558xV2ABlZkTsZqSEBtAcEbH9qF1fF6mkfEKC5BoeGlWq/lZGwZzlv
	 thYRCZY3VuEuDC4WHb7h7nBWE2BVbL/p1aaVNDlYKHUawdPCXDiTTCb38sRb0GmIDX
	 ZBkRamVC2ULYg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Mar 2024 21:57:24 +0200
Message-Id: <CZNS7FO53BHK.6NO93P0C0VY5@kernel.org>
Subject: Re: [PATCH 2/2] tpm: of: If available Use linux,sml-log to get the
 log and its size
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, <mpe@ellerman.id.au>,
 <linux-integrity@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Cc: <linux-kernel@vger.kernel.org>, <rnsastry@linux.ibm.com>,
 <peterhuewe@gmx.de>, <viparash@in.ibm.com>
X-Mailer: aerc 0.17.0
References: <20240306155511.974517-1-stefanb@linux.ibm.com>
 <20240306155511.974517-3-stefanb@linux.ibm.com>
In-Reply-To: <20240306155511.974517-3-stefanb@linux.ibm.com>

in short summary: s/Use/use/

On Wed Mar 6, 2024 at 5:55 PM EET, Stefan Berger wrote:
> If linux,sml-log is available use it to get the TPM log rather than the
> pointer found in linux,sml-base. This resolves an issue on PowerVM and KV=
M
> on Power where after a kexec the memory pointed to by linux,sml-base may
> have been corrupted. Also, linux,sml-log has replaced linux,sml-base and
> linux,sml-size on these two platforms.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

So shouldn't this have a fixed tag, or not?

> ---
>  drivers/char/tpm/eventlog/of.c | 36 +++++++++++-----------------------
>  1 file changed, 11 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/char/tpm/eventlog/of.c b/drivers/char/tpm/eventlog/o=
f.c
> index 930fe43d5daf..e37196e64ef1 100644
> --- a/drivers/char/tpm/eventlog/of.c
> +++ b/drivers/char/tpm/eventlog/of.c
> @@ -54,8 +54,8 @@ int tpm_read_log_of(struct tpm_chip *chip)
>  	const u32 *sizep;
>  	const u64 *basep;
>  	struct tpm_bios_log *log;
> +	const void *logp;
>  	u32 size;
> -	u64 base;
> =20
>  	log =3D &chip->log;
>  	if (chip->dev.parent && chip->dev.parent->of_node)
> @@ -66,37 +66,23 @@ int tpm_read_log_of(struct tpm_chip *chip)
>  	if (of_property_read_bool(np, "powered-while-suspended"))
>  		chip->flags |=3D TPM_CHIP_FLAG_ALWAYS_POWERED;
> =20
> -	sizep =3D of_get_property(np, "linux,sml-size", NULL);
> -	basep =3D of_get_property(np, "linux,sml-base", NULL);
> -	if (sizep =3D=3D NULL && basep =3D=3D NULL)
> -		return tpm_read_log_memory_region(chip);
> -	if (sizep =3D=3D NULL || basep =3D=3D NULL)
> -		return -EIO;
> -
> -	/*
> -	 * For both vtpm/tpm, firmware has log addr and log size in big
> -	 * endian format. But in case of vtpm, there is a method called
> -	 * sml-handover which is run during kernel init even before
> -	 * device tree is setup. This sml-handover function takes care
> -	 * of endianness and writes to sml-base and sml-size in little
> -	 * endian format. For this reason, vtpm doesn't need conversion
> -	 * but physical tpm needs the conversion.
> -	 */
> -	if (of_property_match_string(np, "compatible", "IBM,vtpm") < 0 &&
> -	    of_property_match_string(np, "compatible", "IBM,vtpm20") < 0) {
> +	logp =3D of_get_property(np, "linux,sml-log", &size);
> +	if (logp =3D=3D NULL) {
> +		sizep =3D of_get_property(np, "linux,sml-size", NULL);
> +		basep =3D of_get_property(np, "linux,sml-base", NULL);
> +		if (sizep =3D=3D NULL && basep =3D=3D NULL)
> +			return tpm_read_log_memory_region(chip);
> +		if (sizep =3D=3D NULL || basep =3D=3D NULL)
> +			return -EIO;
> +		logp =3D __va(be64_to_cpup((__force __be64 *)basep));
>  		size =3D be32_to_cpup((__force __be32 *)sizep);
> -		base =3D be64_to_cpup((__force __be64 *)basep);
> -	} else {
> -		size =3D *sizep;
> -		base =3D *basep;
>  	}
> -
>  	if (size =3D=3D 0) {
>  		dev_warn(&chip->dev, "%s: Event log area empty\n", __func__);
>  		return -EIO;
>  	}
> =20
> -	log->bios_event_log =3D devm_kmemdup(&chip->dev, __va(base), size, GFP_=
KERNEL);
> +	log->bios_event_log =3D devm_kmemdup(&chip->dev, logp, size, GFP_KERNEL=
);
>  	if (!log->bios_event_log)
>  		return -ENOMEM;
> =20

Looks pretty good other than that.

BR, Jarkko

