Return-Path: <linux-kernel+bounces-147331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B61A58A729D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21589B21069
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2560D13398E;
	Tue, 16 Apr 2024 17:49:14 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E77A1327ED
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 17:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713289753; cv=none; b=UxOpJZx97TLjON7Y23oZCd92gYgXlaC14d6+1LFCyzhke3l/rRMOUQRwn/7sxkfKzsxYWXYCWBkLbIuAYWEiB1v4wmuywKO6mivK0RFRhNlan1xI4g8u/yfYgBN6jf6Uy55F9sowPVsEgjvKfnJIKlraXs9duCW23NeKQ364dQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713289753; c=relaxed/simple;
	bh=zL4vHYXodo+iDEIfDbv2+Viy78mHAcondGKwEefuddE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rs03z4Qxr2UX+pTGT3zW5xJMdYLjnWXBUpUokF+mrKIWdeyVERPWfT9yCwxWCbKrk5s6miO3McAASeIKoPViW1LCC8ouybDNTbMdo4fIlOMh/eHoEcrPNzvSFvewidlbCoJvOX0WcMSGV8+2uiOd3DKkulNeQfCjOuKaZVDzETY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BE68340E0187;
	Tue, 16 Apr 2024 17:49:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sU6ThkcJiHGY; Tue, 16 Apr 2024 17:49:03 +0000 (UTC)
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2832440E00B2;
	Tue, 16 Apr 2024 17:48:56 +0000 (UTC)
Date: Tue, 16 Apr 2024 19:48:50 +0200
From: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Robert Richter <rric@kernel.org>, linux-kernel@vger.kernel.org,
	jgross@suse.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH 2/4] perf/x86/ibs: Use CPUID region helper
Message-ID: <20240416174850.GEZh66AmnDjrLxoXaw@fat_crate.local>
References: <20240403153508.7328E749@davehans-spike.ostc.intel.com>
 <20240403153511.75CB9DA0@davehans-spike.ostc.intel.com>
 <20240416151242.GGZh6VaiO2gC4ej2BT@fat_crate.local>
 <f142e9c4-4829-4ace-8757-485246ad3572@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f142e9c4-4829-4ace-8757-485246ad3572@intel.com>

On Tue, Apr 16, 2024 at 08:23:58AM -0700, Dave Hansen wrote:
> When I was looking at it, I (maybe wrongly) assumed that 0x8000001b and
> X86_FEATURE_IBS were independent for a reason.  Because, oddly enough:
> 
> 	#define IBS_CAPS_DEFAULT         (IBS_CAPS_AVAIL         \
>                                          | IBS_CAPS_FETCHSAM    \
>                                          | IBS_CAPS_OPSAM)
> 
> So, if the CPU enumerates X86_FEATURE_IBS but has a
> max_level<IBS_CPUID_FEATURES then it assumes there's a working IBS
> because the software-inserted IBS_CAPS_DEFAULT has IBS_CAPS_AVAIL set.

Right, that's why I added Robert. I found this in a F10h doc (old
Greyhound CPU rust):

"CPUID Fn8000_0001_ECX Feature Identifiers

..

10: IBS: Instruction Based Sampling = 1.

..

CPUID Fn8000_001B Instruction Based Sampling Identifiers

..

IBSFFV. IBS feature flags valid. Revision B = 0. Revision C = 1."

which makes this look like some hack to fix broken CPUID IBS reporting.

And if it is that, I don't think we care, frankly, because revB is
ooold. Mine is somewhere in the basement on some old board which got
bricked so I don't know even if I could use it anymore.

And I'm not even planing to - that CPU is almost 20 years old and no one
cares whether it can even do IBS.

So I wouldn't mind at all if we simplify this code for the sake of it.
I don't think anyone would care or notice.

But let's see what Robert says first...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

