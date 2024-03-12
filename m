Return-Path: <linux-kernel+bounces-100125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA753879213
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C493284427
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C185466B;
	Tue, 12 Mar 2024 10:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="WhjR2Xpx"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FB635F18;
	Tue, 12 Mar 2024 10:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710239578; cv=none; b=PaySdLaYjDQGM4SqVSZJ5ceA1egnAXf9F8Liy5b8Vh6z9ctlLj2Z1hdxP3UsDnm4J+MDekWJpoMLAChM7a/2tlP73mxY9vfNppOXsmzhZv4Apc4v2+yrXvtMCJmaiU0bqZqkfMcf+mtB17T4toPeRCq21T4WOYjt5d37wgXQo+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710239578; c=relaxed/simple;
	bh=7IM+v4sCwMimkJ1ZXA117FFaV50XcO43VM3+gBWy65g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uf5+cM/U4XYANz7zOMtaaYQL503epQldxpVdUqJlzXw6oKuFO4ZLmE1/V7gsy4tJ/miuN9HUN2Les2zzoN5EnU/n5G3aceeIvmVLuxIhTfsBnFi6RGYjNw3GLLVuFF6ITLPQ4biTS4z+kEkfJcA/Xt5bDVgegFFKZoNxTesAKa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=WhjR2Xpx; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1710239571;
	bh=WAJdAg2kSVxd3biZa1Q3GiQlxvq8aCBQjEnXtrdMZQc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WhjR2XpxEiPKrQ1UxYUIKDVVtrEY/A16XeUHH+p3tVkIPYZbSPSK7huCOZ9+EGJrn
	 jmmBglW76EAQAZA0xMrdgDmIsfa7yJuLAhdZ4QjZXTuYz6VdgH0pQipie0omSQtxi3
	 x0OIJJhmBV1opHy0gGEjVxsiPU5Jz2Cmnu8bJ7d2HyT/sVcCWrZB4t+jwDCorJ/Z7g
	 Uq0eSwfQ4vOLUiMhEG5uX0nWXbzcfKfjE5DJA+PEHbyCPfhMCkz1u54ZfiRFBIN3tS
	 QSJqAF3zo/BRQ3x+xIdcnEKIFkh31tl6eZziDO+eCpeXZtS/mbdIf6EcPtKcnImw6k
	 DwgrCoGA7JCEA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tv92W2Nl8z4wcq;
	Tue, 12 Mar 2024 21:32:51 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Rob Herring <robh@kernel.org>, Stefan Berger <stefanb@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, jarkko@kernel.org, rnsastry@linux.ibm.com,
 peterhuewe@gmx.de, viparash@in.ibm.com
Subject: Re: [PATCH 1/2] powerpc/prom_init: Replace linux,sml-base/sml-size
 with linux,sml-log
In-Reply-To: <20240308205751.GA1249866-robh@kernel.org>
References: <20240306155511.974517-1-stefanb@linux.ibm.com>
 <20240306155511.974517-2-stefanb@linux.ibm.com>
 <87jzmenx2c.fsf@mail.lhotse> <20240307215214.GB3110385-robh@kernel.org>
 <851536a5-ad8f-4d65-8c33-707e2fe762df@linux.ibm.com>
 <20240308205751.GA1249866-robh@kernel.org>
Date: Tue, 12 Mar 2024 21:32:50 +1100
Message-ID: <87a5n34u5p.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Rob Herring <robh@kernel.org> writes:
> On Fri, Mar 08, 2024 at 07:23:35AM -0500, Stefan Berger wrote:
>> On 3/7/24 16:52, Rob Herring wrote:
>> > On Thu, Mar 07, 2024 at 09:41:31PM +1100, Michael Ellerman wrote:
>> > > Stefan Berger <stefanb@linux.ibm.com> writes:
>> > > > linux,sml-base holds the address of a buffer with the TPM log. This
>> > > > buffer may become invalid after a kexec and therefore embed the whole TPM
>> > > > log in linux,sml-log. This helps to protect the log since it is properly
>> > > > carried across a kexec with both of the kexec syscalls.
>> > > > 
>> > > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> > > > ---
>> > > >   arch/powerpc/kernel/prom_init.c | 8 ++------
>> > > >   1 file changed, 2 insertions(+), 6 deletions(-)
>> > > > 
>> 
>> > 
>> > 
>> > > Also adding the new linux,sml-log property should be accompanied by a
>> > > change to the device tree binding.
>> > > 
>> > > The syntax is not very obvious to me, but possibly something like?
>> > > 
>> > > diff --git a/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml b/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml
>> > > index 50a3fd31241c..cd75037948bc 100644
>> > > --- a/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml
>> > > +++ b/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml
>> > > @@ -74,8 +74,6 @@ required:
>> > >     - ibm,my-dma-window
>> > >     - ibm,my-drc-index
>> > >     - ibm,loc-code
>> > > -  - linux,sml-base
>> > > -  - linux,sml-size
>> > 
>> > Dropping required properties is an ABI break. If you drop them, an older
>> > OS version won't work.
>> 
>> 1) On PowerVM and KVM on Power these two properties were added in the Linux
>> code. I replaced the creation of these properties with creation of
>> linux,sml-log (1/2 in this series). I also replaced the handling of
>> these two (2/2 in this series) for these two platforms but leaving it for
>> powernv systems where the firmware creates these.
>
> Okay, I guess your case is not a ABI break if the kernel is populating 
> it and the same kernel consumes it. 
>
> You failed to answer my question on using /reserved-memory. Again, why 
> can't that be used? That is the standard way we prevent chunks of memory 
> from being clobbered.

Yes I think that would mostly work. I don't see support for
/reserved-memory in kexec-tools, so that would need fixing I think.

My logic was that the memory is not special. It's just a buffer we
allocated during early boot to store the log. There isn't anything else
in the system that relies on that memory remaining untouched. So it
seemed cleaner to just put the log in the device tree, rather than a
pointer to it.

Having the log external to the device tree creates several problems,
like the crash kernel region colliding with it, it being clobbered by
kexec, etc.

cheers

