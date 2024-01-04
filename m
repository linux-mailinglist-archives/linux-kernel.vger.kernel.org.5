Return-Path: <linux-kernel+bounces-16974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9808246B2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C92C5287C19
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644BC25566;
	Thu,  4 Jan 2024 16:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y5nUPbA7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25CE25554;
	Thu,  4 Jan 2024 16:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704387130; x=1735923130;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=UdCcRXEMi569p6+ITr0KHlXsSxx0feyXn0U+aodkq0k=;
  b=Y5nUPbA7kbyc4srFtpTeDW8aftVeQc/W7r0uy2u8lDUqToT7BBRAmM+3
   he1VlQSgV5b+O0WfB9SCTW8HvQBNDc3cBC9Jjxw9Y3/gAwNAGRt9wT3Sl
   1WgbITQS6BPFw4ubU9Y/XPs+Uj8Z573UPeO+5B8PnNvjHPcsPpEOtzl0Z
   toel2EI605/zMGArnEUq3yjuy3a+X5PU/r5M3+6wsxnDBBSBOPX445IHU
   eKke9xPgps56w7kqJdjmolyokR/krreaShvjnIK1qwqV9gC7FFfsl6Taq
   2m/wuKOfj3ZHAkO//dZDucgwfbTY17M4flvLVKkY05gzJS10YUS06wvm1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="382278649"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="382278649"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 08:52:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="814705023"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="814705023"
Received: from pdelarag-mobl.ger.corp.intel.com (HELO localhost) ([10.252.36.32])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 08:52:06 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Dave Airlie <airlied@redhat.com>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>, Andrzej Hajda
 <andrzej.hajda@intel.com>, DRI <dri-devel@lists.freedesktop.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the drm tree
In-Reply-To: <20240103122734.16b29e09@canb.auug.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240102111222.2db11208@canb.auug.org.au>
 <20240103121911.4ec8f237@canb.auug.org.au>
 <20240103122734.16b29e09@canb.auug.org.au>
Date: Thu, 04 Jan 2024 18:52:03 +0200
Message-ID: <87frzdyrbg.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 03 Jan 2024, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> OK, the only thing I can find is that there are 2 intel_wakeref.h files
> that have different definitions for intel_wakeref_t:
>
> ./drivers/gpu/drm/i915/intel_wakeref.h:typedef unsigned long intel_wakeref_t;
> ./drivers/gpu/drm/xe/compat-i915-headers/intel_wakeref.h:typedef bool intel_wakeref_t;
>
> and the two compilations above seem to use different include paths, but
> how the single character change causes that is beyond me.

There are a few things going on here, but the gist of it is that
intel_wakeref_t is supposed to be an opaque cookie, and printing its
value does not make sense, especially not when you can't be certain
which printf format should be used for it.

Fix at [1], thanks for the report.

BR,
Jani.


[1] https://patchwork.freedesktop.org/patch/msgid/20240104164600.783371-1-jani.nikula@intel.com


-- 
Jani Nikula, Intel

