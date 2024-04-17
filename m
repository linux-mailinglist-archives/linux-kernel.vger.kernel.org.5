Return-Path: <linux-kernel+bounces-149216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 239858A8D45
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C85991F22E9E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931CF481A8;
	Wed, 17 Apr 2024 20:51:19 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776293D967
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 20:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713387079; cv=none; b=qCY5xepV90EoVuF72U9yUywNHGpdUV0gzNR9ZX1yekGB+1MD2mbF66C5PfYJFYwkcJv1F3MFk4CoRvrltmE7tAyukfoeZj0XHKFpGaD9b9TgA4QVURq+Xao5UK4+k2+Axh1UaBLpeDrSnFAD7/vo+SaN1UbXXnJLSRq66IzFK10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713387079; c=relaxed/simple;
	bh=25na2u5dqSMwdfKH+InG17crUdYa9TxiMOwoUCyo2Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+r/5A/QRmU5C4i9R+Qp1lWsxRONPHo7hDmpJyv/v7OmVReFALLTfuy0dIVAQAX2zKPOKOjpdGqpJ8Q+6XB7T/S8/egcHgfaSne/aXowf1UADh8Nb4SFuvRl3EsMYBfgmK3x03WJM86M5xs+PKqsAImMdowbMNYYjHhOGfi2aHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E478040E0177;
	Wed, 17 Apr 2024 20:51:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WjHW1JqznPJz; Wed, 17 Apr 2024 20:51:09 +0000 (UTC)
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 21AF640E00B2;
	Wed, 17 Apr 2024 20:50:54 +0000 (UTC)
Date: Wed, 17 Apr 2024 22:50:48 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-coco@lists.linux.dev, svsm-devel@coconut-svsm.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v3 02/14] x86/sev: Make the VMPL0 checking function more
 generic
Message-ID: <20240417205048.GHZiA2KGbFFTQFyTAM@fat_crate.local>
References: <cover.1711405593.git.thomas.lendacky@amd.com>
 <1b0d8ec8e671ad957a2ad888725ce24edeedf74a.1711405593.git.thomas.lendacky@amd.com>
 <20240417114658.GHZh-2sk47TZgCp4Mb@fat_crate.local>
 <505dcf34-93ff-643c-b149-8ef9ce90c023@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <505dcf34-93ff-643c-b149-8ef9ce90c023@amd.com>

On Wed, Apr 17, 2024 at 03:35:53PM -0500, Tom Lendacky wrote:
> Well, it doesn't really modify any permissions that matter. It tries to
> change the permission of a lesser privileged VMPL level.

Potato potato. :-P

> Since the kernel only runs at a single VMPL it would never be
> effected. The operation performed here is to update VMPL1 permission
> levels (which can only be done successfully at VMPL0) and return the
> result of the operation.  A success implies running at VMPL0 and
> failure implies not running at VMPL0.

Yap.

The point is, it is calling RMPADJUST. And it does modify RMP
permissions of a guest page.

Thus, if you prefer, you can go all out and call the helper

	rmp_adjust_permissions(unsigned int tgt_vmpl, void *pa)

and make it generic from the get-go.

And then have the macro wrap around it in order to explain that
particular use with the macro name.

If it is still not clear what I mean, lemme know and I'll do a diff
ontop.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

