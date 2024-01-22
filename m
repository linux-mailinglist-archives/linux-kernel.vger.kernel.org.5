Return-Path: <linux-kernel+bounces-32463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F119835BFD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53618B2675C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E059118C2A;
	Mon, 22 Jan 2024 07:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="oNuR0xo9"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE17E210E0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 07:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705909656; cv=none; b=uvr+/jnBTc39eIXSh/5vk8tfY/gOXFg/Cx8Ua81Q9w8Mmj6tMw2pHtwEX6bfTne3U5A/9GMNTJ5sKKBlER2WijncbMbG6JpdsxKpBiZ60JBjCc7KLsQ5ml64EhgY8EFMXFykFZULnibMTg4YFMkxP2syIkANdVbW7Mp8gRZapFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705909656; c=relaxed/simple;
	bh=7gN0pw0Jx+OaK+oQL8aEN9UCrERUzCUSwTwWQLDx9V4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCMnQucjjVsVIsPDBA4+DA6S1sX/oPZLl15DKExxFOVONpvZTeu4BAEJkB4oxV+PEOfU4lgMeT/HvNh76bEVSENKZQiaO9XkOnY8P4UBd42s3taB7yU/eRaskygsGnUPpmsNmawC7PC+pXvaeNhj9fvBnQhSA8jVVeIeAeRav40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=oNuR0xo9; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e86a9fc4bso37372935e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 23:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705909651; x=1706514451; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ySmY5MAyDMutjoMPe3tReX9rWPyvSoGQC0n/7ejYOPA=;
        b=oNuR0xo9GhOv4lGRksxSeyuoFtJaXWCFvmbEDczAwqYQ1wzNxAfzIt+Tz9vxwdxwHL
         Tzo8KI4sKeXo/GLVVSodIZkTSPCOSZ8HLWIgqIdKeHfYqb6nKgGsnCzIeQSWB+JfE5Oe
         yaB2XePyFL3jYDYeLPZnC8cavLX5+9BqYN1btLtRuim3hcLa1/jT3zqsOT5sNypKUEqA
         kSiNHYze6+mT16Qg8qqkxgv8B5J+4RVLR0T1LPEH5qMNo4/9wB1lY/o3keste+XZb+9D
         YRAQwOTXgwSM3GYVjIFhfj1zn4h0du1CxZBYI8tGVLS3HTcDcGH2SNohRDmszoiq//TX
         TsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705909651; x=1706514451;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ySmY5MAyDMutjoMPe3tReX9rWPyvSoGQC0n/7ejYOPA=;
        b=OcS2vVkBn/QAUmyzrj2hZNOOvsGSvtVV2PZvvae6U9Y3Fjs32ejrGv0UwA+n7V35a6
         P2bwsF+SIo8rxsXT7DWyOKwmqw7po6jMvZEOqSpT5IweLZdcZd1MMonKJoEo/E0Ld0NB
         Z+6DDd3dLygcqII9+tO8xUslRibSqWowN/pan8qfWHxAQqrzTLH7iQDfZbYv9ZOPKZ2A
         3ZMiB07zxOPrSEAVtnUDSt7QIiwaKrOX5XNT6+O7RfOa3zwXAcocFkzVaJ5FEXd779sF
         uyc8TT0v9HZ2guT335br1vYnSV6FtTBQrgQsQ8F6pWhViV5YbKBiPd5KI6w6hIr95dKi
         VbHA==
X-Gm-Message-State: AOJu0Yx6svsiyC0UxRqH0euSStFLCdwCvmHJmA2esYDIsoooTiZ9uKJK
	4D3fBUE7JysMMKPNffgRv6foyhGur5jhGsHqFniOvhCp/wi+CWRuBPL151YzlPM=
X-Google-Smtp-Source: AGHT+IFITIosAYOqlxn8hFlNeDM7+hCXETt1OYV89AUkMK0voRgz3wA/biGanBNOuCF5HAzJzCZvpA==
X-Received: by 2002:a05:600c:46c7:b0:40e:71e3:139d with SMTP id q7-20020a05600c46c700b0040e71e3139dmr2282194wmo.154.1705909651024;
        Sun, 21 Jan 2024 23:47:31 -0800 (PST)
Received: from vermeer (lfbn-mon-1-1176-165.w90-113.abo.wanadoo.fr. [90.113.119.165])
        by smtp.gmail.com with ESMTPSA id r8-20020adfe688000000b00337d97338b0sm8811352wrm.76.2024.01.21.23.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 23:47:30 -0800 (PST)
Date: Mon, 22 Jan 2024 08:46:58 +0100
From: Samuel Ortiz <sameo@rivosinc.com>
To: Qinkun Bao <qinkun@google.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, jiewen.yao@intel.com,
	ken.lu@intel.com
Subject: Re: [RFC PATCH v1 3/4] tsm: Allow for mapping RTMRs to TCG TPM PCRs
Message-ID: <Za4dcowdY84fGF1f@vermeer>
References: <20240114223532.290550-1-sameo@rivosinc.com>
 <20240114223532.290550-4-sameo@rivosinc.com>
 <1bbf8d3e-aa94-48c7-a1e4-76f9eefc4af7@linux.intel.com>
 <65a72c305291f_3b8e29484@dwillia2-xfh.jf.intel.com.notmuch>
 <5539c533-37b2-4b12-a5c5-056881cf8e3c@linux.intel.com>
 <Za1G9I+tYuIL9ser@vermeer>
 <90EDEF2B-DB43-413F-840E-3268977FDBD0@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90EDEF2B-DB43-413F-840E-3268977FDBD0@google.com>

On Sun, Jan 21, 2024 at 06:09:19PM -0800, Qinkun Bao wrote:
> 
> 
> > On Jan 21, 2024, at 8:31 AM, Samuel Ortiz <sameo@rivosinc.com> wrote:
> > 
> > On Tue, Jan 16, 2024 at 07:35:30PM -0800, Kuppuswamy Sathyanarayanan wrote:
> >> 
> >> On 1/16/24 5:24 PM, Dan Williams wrote:
> >>> Kuppuswamy Sathyanarayanan wrote:
> >>>> On 1/14/24 2:35 PM, Samuel Ortiz wrote:
> >>>>> Many user space and internal kernel subsystems (e.g. the Linux IMA)
> >>>>> expect a Root of Trust for Storage (RTS) that allows for extending
> >>>>> and reading measurement registers that are compatible with the TCG TPM
> >>>>> PCRs layout, e.g. a TPM. In order to allow those components to
> >>>>> alternatively use a platform TSM as their RTS, a TVM could map the
> >>>>> available RTMRs to one or more TCG TPM PCRs. Once configured, those PCR
> >>>>> to RTMR mappings give the kernel TSM layer all the necessary information
> >>>>> to be a RTS for e.g. the Linux IMA or any other components that expects
> >>>>> a TCG compliant TPM PCRs layout.
> >>>>> 
> >>>>> TPM PCR mappings are configured through configfs:
> >>>>> 
> >>>>> // Create and configure 2 RTMRs
> >>>>> mkdir /sys/kernel/config/tsm/rtmrs/rtmr0
> >>>>> mkdir /sys/kernel/config/tsm/rtmrs/rtmr1
> >>>>> echo 0 > /sys/kernel/config/tsm/rtmrs/rtmr0/index
> >>>>> echo 1 > /sys/kernel/config/tsm/rtmrs/rtmr1/index
> >>>>> 
> >>>>> // Map RTMR 0 to PCRs 4, 5, 6, 7 and 8
> >>>>> echo 4-8 > /sys/kernel/config/tsm/rtmrs/rtmr0/tcg_map
> >>>>> 
> >>>>> // Map RTMR 1 to PCRs 16, 17 and 18
> >>>>> echo 16-18 > /sys/kernel/config/tsm/rtmrs/rtmr1/tcg_map
> >>>> Any information on how this mapping will be used by TPM or IMA ?
> >>>> 
> >>>> RTMR to PCR mapping is fixed by design, right? If yes, why allow
> >>>> user to configure it. We can let vendor drivers to configure it, right?
> >>> I assume the "vendor driver", that publishes the RTMR to the tsm-core,
> >>> has no idea whether they will be used for PCR emulation, or not. The TPM
> >>> proxy layer sitting on top of this would know the mapping of which RTMRs
> >>> are recording a transcript of which PCR extend events.
> >> 
> >> My thinking is, since this mapping is ARCH-specific information
> >> and fixed by design, it makes more sense to hide this detail in the
> >> vendor driver than letting userspace configure it. If we allow users to
> >> configure it, there is a chance for incorrect mapping.
> > 
> > I think I agree with the fact that letting users configure that mapping
> > may be error prone. But I'm not sure this is an architecture specific
> > mapping, but rather a platform specific one. I'd expect the guest firmware
> > to provide it through e.g. the MapPcrToMrIndex EFI CC protocol.
> > 
> > So I agree I should remove the user interface for setting that mapping,
> > and pass it from the provider capabilities instead. It is then up to the
> > provider to choose how it'd build that information (hard coded, from
> > EFI, etc).
> 
> The UEFI specification has defined the mapping relationship between the 
> TDX RTMR and TPM PCRs (See https://uefi.org/specs/UEFI/2.10/38_Confidential_Computing.html#intel-trust-domain-extension). The current RTMR implementation in the boot loader 
> is “hooked” in the implementation for the TPM. 
> 
> When the bootloader needs to extend the PCR value, it calls 
> `map_pcr_to_mr_index`  to retrieve the corresponding RTMR index and 
> then extends the RTMR. Considering this behavior, I don’t think we should
>  allow users to configure the mappings between the PCR and RTMR. (See https://github.com/rhboot/shim/pull/485/files <https://github.com/rhboot/shim/pull/485/files>).

Just to be clear: I agree with that and I am going to send a v2 with
that user interface removed.
However I believe that we still need the TSM framework to know about
these mappings and the question is where does the kernel get it from?

You're suggesting that for TDX these mappings are architecturally
defined, as described by the UEFI spec. For other architectures (CCA,
CoVE) they are not (yet), so I'm suggesting to leave each TSM provider
backend decide how the PCR to RTMR mapping should be built/fetched and
provide it to the TSM framework through the tsm_capabilities structure
that this patchset introduces. The TDX implementation could decide to
hardcode it to the UEFI specification.

Cheers,
Samuel.

