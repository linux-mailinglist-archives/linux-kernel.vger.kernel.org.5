Return-Path: <linux-kernel+bounces-43533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD42841538
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54BF02876D4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBA21586FC;
	Mon, 29 Jan 2024 21:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y+m9Vxh+"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478AB152DFC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 21:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706564680; cv=none; b=E9J6XibKSuqjw8z4Sb2HKUhFyzzwmL6TLt31PwJeEjfLGiq3sMWIhjbVmxAYdFYIfmumR0uWKSCWArWlPS14CaEZK8u9QGPI9hiGGXh2w3hINXCKNufqjsupcMZaEb0QKAgaLdoMBGrgiD6W8REF4nkMEbOI34Jruk1VXPBkcj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706564680; c=relaxed/simple;
	bh=ZPrtIDYwdeoYrKa8v/Jr8d+FvYQ17cyId6EuVFn8HZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekocKXsB/9hpRh5CD/jatQ86b0zhyWHJB6kjYSJurjmuH4WPbvNH+Oz/50ucviZJ7i1HBl28A+57jwI4mvB3T357Q+8pMpsioqGHMGFhThZRpRU+ke06f5Y19GLx/tEBuaCJchYML1Qq50k7Q5Z7xBKHAC2Zm0+pB2fZSuCfi7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y+m9Vxh+; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706564679; x=1738100679;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZPrtIDYwdeoYrKa8v/Jr8d+FvYQ17cyId6EuVFn8HZE=;
  b=Y+m9Vxh+CqkX7zSO1nhnxw6t633vUDOup+R91noXxKBAmXe3wJOsuw1j
   LR7CWw0Hki1YY8Kz9fAhO+AbpFoLPJnJqTQ7wJ31f5WgoSzve2WltDeeF
   xfwAtgmNa2dHZ5G20T8wmCv+mWIqqIFRJIlIPF4aYWtgHG/g7sEWfwoqf
   Bp6FbNsgt1mcXq+ZPFebj4M05xUUd3uve/tBvkrSVgSTCSZjvmU9arnWJ
   75XX+FradiCV7pPOI3yXYW05jL7JOLqmdWBV8Zxd0Cy9+BT2Cmv+XS6Vs
   hXrVono4X7AN65FgLckvHhInyRpuT7ev/2/KipXq1m2TmJqPqd4be/ss4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="406812961"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="406812961"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 13:44:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="931225023"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="931225023"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 29 Jan 2024 13:44:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 654F8FF; Mon, 29 Jan 2024 23:33:00 +0200 (EET)
Date: Mon, 29 Jan 2024 23:33:00 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Theodore Ts'o <tytso@mit.edu>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	"Kalra, Ashish" <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Randomness on confidential computing platforms
Message-ID: <v6maadzwtke3z5ejp2mavsnm4mvmjbu7demvldzpobqeva74rx@r6y5fwxsyoep>
References: <20240126134230.1166943-1-kirill.shutemov@linux.intel.com>
 <276aaeee-cb01-47d3-a3bf-f8fa2e59016c@intel.com>
 <dqiaimv3qqh77cfm2huzja4vsho3jls7vjmnwgda7enw633ke2@qiqrdnno75a7>
 <f5236e76-27d0-4a90-bde5-513ac9446184@intel.com>
 <dlhffyn7cccn5d4uvubggkrmtyxl4jodj5ukffafpsxsnqini3@5rcbybumab4c>
 <3a37eae3-9d3c-420c-a1c7-2d14f6982774@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a37eae3-9d3c-420c-a1c7-2d14f6982774@intel.com>

On Mon, Jan 29, 2024 at 01:04:23PM -0800, Dave Hansen wrote:
> On 1/29/24 12:26, Kirill A. Shutemov wrote:
> >>> Do we care?
> >> I want to make sure I understand the scenario:
> >>
> >>  1. We're running in a guest under TDX (or SEV-SNP)
> >>  2. The VMM (or somebody) is attacking the guest by eating all the
> >>     hardware entropy and RDRAND is effectively busted
> >>  3. Assuming kernel-based panic_on_warn and WARN_ON() rdrand_long()
> >>     failure, that rdrand_long() never gets called.
> > Never gets called during attack. It can be used before and after.
> > 
> >>  4. Userspace is using RDRAND output in some critical place like key
> >>     generation and is not checking it for failure, nor mixing it with
> >>     entropy from any other source
> >>  5. Userspace uses the failed RDRAND output to generate a key
> >>  6. Someone exploits the horrible key
> >>
> >> Is that it?
> > Yes.
> 
> Is there something that fundamentally makes this a VMM vs. TDX guest
> problem?  If a malicious VMM can exhaust RDRAND, why can't malicious
> userspace do the same?
> 
> Let's assume buggy userspace exists.  Is that userspace *uniquely*
> exposed to a naughty VMM or is that VMM just added to the list of things
> that can attack buggy userspace?

This is good question.

VMM has control over when a VCPU gets scheduled and on what CPU which
gives it tighter control over the target workload. It can make a
difference if there's small window for an attack before RDRAND is
functional again.

Admittedly, I don't find my own argument very convincing :)

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

