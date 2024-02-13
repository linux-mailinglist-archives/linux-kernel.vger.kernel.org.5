Return-Path: <linux-kernel+bounces-62934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A64852811
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 05:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ECA41F238F3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 04:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11041171C;
	Tue, 13 Feb 2024 04:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="afKfcWFm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D1B8BFC
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 04:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707800012; cv=none; b=egvSLNcJKdlZqzkvO7dEJyObGS/2yyzvpTontsnLG9r4i6VDlkcxiAN8L3w+8tH1E6xbKAJ7BNc5vsfkhqQSsLQNiZY9jvMmxsKTisQOs9eSLJt46zKwgDiUprVI5R+KrxAJPWfY8lR+QFa82uu55xc1Ccn4fp4Ms2uBePThjiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707800012; c=relaxed/simple;
	bh=r55OEhM8sozL1JPbY2lRvmHVimjJgWPvWFCFH+yiNrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGxaZ43riBmnMpw4/9KlyGMmJq9JKe4347fDigU7oGRNYJOB6eIM/riiwqpSS7k+5ILpwEEyLTbpRKJPpRIr3F0yy79+e/1tTA6yWPlJwvkR+hkHO2YE9UkWxcIAJGE8JUb52bIX7PHZARnfHZItsuLtkxSDezgZmjy3Sl6pW5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=afKfcWFm; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707800010; x=1739336010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r55OEhM8sozL1JPbY2lRvmHVimjJgWPvWFCFH+yiNrg=;
  b=afKfcWFm+Oo4Tdi/d5oC8/twjsHobHp0gVgAKXTalQafQmt6Pl56CCbC
   jNusuNSYaibistz/O5XaGPpVZjt2+BixXr2rlG6IGuc05FKrDFaAkVWUU
   QI6qIBwGFjNX7pGZwJvWHthcMh0jLm71BjQeDW8+sTtma+nyIfsys82Pj
   P1Jm3lpDvyUbP2mDFx8NHu6zloPItvia0l4KXrmxMmSy/+ptAb2Zuf2ER
   xtDhMT4EP7FebEn7t6EWnGUPqmgWU0S4HB/yq22eif9d5Hr58ZFq36F65
   Dk00YNuK2P3dLOrpmUApfO5wjfMLy9BWKhrfOIDvl/v/GDkHA8cAo96DC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="13191175"
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="13191175"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 20:53:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="40235866"
Received: from mpai-mobl1.amr.corp.intel.com (HELO desk) ([10.209.55.176])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 20:53:30 -0800
Date: Mon, 12 Feb 2024 20:53:28 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	antonio.gomez.iglesias@linux.intel.com,
	alyssa.milburn@linux.intel.com, andrew.cooper3@citrix.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/bugs: Default retbleed to =stuff when retpoline
 is enabled
Message-ID: <20240213045328.3gdcjefbdwyjv3ll@desk>
References: <20240212-retbleed-auto-stuff-v2-1-89401649341a@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212-retbleed-auto-stuff-v2-1-89401649341a@linux.intel.com>

On Mon, Feb 12, 2024 at 05:23:21PM -0800, Pawan Gupta wrote:
> On Intel systems when retpoline mitigation is enabled for spectre-v2,
> retbleed=auto does not enable RSB stuffing. This may make the system
> vulnerable to retbleed. Retpoline is not the default mitigation when
> IBRS is present, but in virtualized cases a VMM can hide IBRS from
> guests, resulting in guest deploying retpoline by default. Even if IBRS
> is enumerated, a user can still select spectre_v2=retpoline.
> 
> As with other mitigations, mitigate retbleed by default. On Intel
> systems when retpoline is enabled, and retbleed mitigation is set to
> auto, enable Call Depth Tracking and RSB stuffing i.e. retbleed=stuff
> mitigation. For AMD/Hygon auto mode already selects the appropriate
> mitigation.

By mistake I sent this patch twice, please ignore the duplicate:

  https://lore.kernel.org/lkml/20240213042453.6j01GG4kjjcdTev7AtniyPHPRNH3RFHNGgVJ5nIXho4@z/

