Return-Path: <linux-kernel+bounces-34161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B70098374BC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63181C2858A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B2447A79;
	Mon, 22 Jan 2024 20:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QhL7SsUR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034C72CA8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 20:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705957123; cv=none; b=k4eBVWC4Xt52Ng7YrIvRbLD77aQTWnizvreZf/g8i/1xhoAz9hNKYSjXQ2U2Yic8vD7ZlZHfg5nngMvYhEK5AJsOtWd//wJ0bMMCR+z2DKIAfRF6H8qvgcBb4/Q3xJbjbHtokzd+rY7E1xpCLrxbAuLywSWz6VBkUth9ZJjuaEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705957123; c=relaxed/simple;
	bh=R9UEuJp8ppdupIv3IX2iBOopSRv/ljd+c4NPmx/9vbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCB44YB6R0sf/q6a+N4PelRqEM7CblhvFpEu5kltkJm2mEPvAYwWVtx779mZNJN5qcMw+4+f4R6MdnvVFbbhvC57N/jrMdHRg9nUW0+C5rCBxSgNu2tGQ6DUzSIiFkHjNMns2WCs7BWEGCaA9qcOkOT4MeficHFAY5zPAZnGSBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QhL7SsUR; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705957122; x=1737493122;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R9UEuJp8ppdupIv3IX2iBOopSRv/ljd+c4NPmx/9vbE=;
  b=QhL7SsURWbSstoQy5zHCfhQYe1cN5OV2LPRrBG2r1Co4HwE4cqLq6tU1
   dNzmtOup3HHa4P3sOLk7Ad43kgUpmpEOs8kaOwjVEkS7H0lyYAnGHszwZ
   5KCby6axpR/gfMZdHdHsMdRnMM7MS0NosYkp5yppaxIBtl2bnpB2w2DMb
   hHNOx6byJKE1XqDWArO81blZ43/ChxGShuyi8it+N7tOpzTfhT+UOy5F2
   Ktu3yv/eQte6Od0Pa3xV79pHoWHYQLHnnr/p8qnA1WzFo14pgDIz7EEMn
   M1oqqDbWg49iqExB0HnU7WnaMuotBmMRGoKTauXwMvmrE0M2mUvr2TZnl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="22802474"
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="22802474"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 12:58:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="1117002086"
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="1117002086"
Received: from thalethi-mobl2.amr.corp.intel.com (HELO desk) ([10.209.98.31])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 12:58:38 -0800
Date: Mon, 22 Jan 2024 12:58:21 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Breno Leitao <leitao@debian.org>
Cc: mingo@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] x86/bugs: Add a separate config for missing
 mitigation
Message-ID: <20240122205821.m5dsyi4sc2ghoavd@desk>
References: <20240118173213.2008115-1-leitao@debian.org>
 <20240118173213.2008115-3-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118173213.2008115-3-leitao@debian.org>

On Thu, Jan 18, 2024 at 09:32:12AM -0800, Breno Leitao wrote:
> +config MITIGATION_RETBLEED
> +	bool "Mitigate RETBleed hardware bug"
> +	depends on CPU_SUP_INTEL || (CPU_SUP_AMD && MITIGATION_UNRET_ENTRY)

Atleast on Intel CPUs, Retbleed mitigation is meaningless without
spectre-v2 being mitigated, shouldn't this depend on MITIGATION_SPECTRE_V2?

