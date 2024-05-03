Return-Path: <linux-kernel+bounces-167595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE298BABB9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A419A1F22627
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7027B152DE8;
	Fri,  3 May 2024 11:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="4cuJ8QfQ"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B831509B2
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 11:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714736307; cv=none; b=q624IkXAdyo0gIcotkni64+l9XmfwNMk1UUHCYmSIzlyfEGtKRrftk+9+K+VWY3tiJTwhWsJsDvF9JI19/mjk6odld54FGLM6b1MfdAhtx/MSbFmFOiVcfcIipDPfobvLdmFRxi0Ao3kLKRB85OGFgt4WEDYojs4oVfukc/b/EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714736307; c=relaxed/simple;
	bh=rBI030nnjBaGuDp119mQ6rF4+O/VVsNKdIq/NQwkRf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uagOcVmrIa5zgioU6fAC4AdEj46NCBpuEH587fuWO0CQckIjWq95Pko5avi3KXhdlXnMRs/CZtxA76ZB+5blO1rLOIh/loVykTZZ3wS7Rz5rLgEhAj6hZXTWibmhtoGmEyqeOW4p0avcBd7dZP4euJD+USLTjAanQhRABfAgWts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=4cuJ8QfQ; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe0bdf.dip0.t-ipconnect.de [79.254.11.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 8A30B1C0D01;
	Fri,  3 May 2024 13:38:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1714736304;
	bh=rBI030nnjBaGuDp119mQ6rF4+O/VVsNKdIq/NQwkRf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=4cuJ8QfQOgGOa4WUzUJMVUE9bxrwxLie0fgcNzaEjt7JoBadWwPunovk+QEXETfZh
	 bbOpG6oIKAByFvKq7eq2XgjBauhWYYNwinBbuzl3qHnhCeGW3JMDmLIwTDUB9El+Er
	 HYnX+PkEsL/UVx9vpYV4M9SBf91X+pFpqn+g625CQbuKrRralVXzcUeQNK0fYdQtzG
	 CQPqEJbLT5Qk4Q+KDTVadwqZeku0/zRwpgit0O/iyA+ZfbgpIq/XDKS2J1k94J8Y2U
	 lesfpgcHMN71yeWJXDpt/kmMPgdvmzwXCZdBzN1ZQtD8Q22SPJ0nsPDrGvq5Fo2aWI
	 DSSurMAzOMRvA==
Date: Fri, 3 May 2024 13:38:23 +0200
From: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-coco@lists.linux.dev, svsm-devel@coconut-svsm.dev,
	Peter Zijlstra <peterz@infradead.org>,
	Michael Roth <michael.roth@amd.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Joel Becker <jlbec@evilplan.org>,
	Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [svsm-devel] [PATCH v4 00/15] Provide SEV-SNP support for
 running under an SVSM
Message-ID: <ZjTMr8CAA3STRlDR@8bytes.org>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1713974291.git.thomas.lendacky@amd.com>

On Wed, Apr 24, 2024 at 10:57:56AM -0500, Tom Lendacky wrote:
> Tom Lendacky (15):
>   x86/sev: Shorten snp_secrets_page_layout to snp_secrets_page
>   x86/sev: Rename snp_init() in the boot/compressed/sev.c file
>   x86/sev: Make the VMPL0 checking more straight forward
>   x86/sev: Check for the presence of an SVSM in the SNP Secrets page
>   x86/sev: Use kernel provided SVSM Calling Areas
>   x86/sev: Perform PVALIDATE using the SVSM when not at VMPL0
>   x86/sev: Use the SVSM to create a vCPU when not in VMPL0
>   x86/sev: Provide SVSM discovery support
>   x86/sev: Provide guest VMPL level to userspace
>   virt: sev-guest: Choose the VMPCK key based on executing VMPL
>   configfs-tsm: Allow the privlevel_floor attribute to be updated
>   fs/configfs: Add a callback to determine attribute visibility
>   x86/sev: Take advantage of configfs visibility support in TSM
>   x86/sev: Extend the config-fs attestation support for an SVSM
>   x86/sev: Allow non-VMPL0 execution when an SVSM is present

I tested these on latest COCONUT-SVSM upstream and found no issues.

Tested-by: Joerg Roedel <jroedel@suse.de>

