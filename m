Return-Path: <linux-kernel+bounces-47495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDFD844EA4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3974E1C28209
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FF4442D;
	Thu,  1 Feb 2024 01:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VRYRA8v8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99474417;
	Thu,  1 Feb 2024 01:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706750755; cv=none; b=OpR3fhquI0vh1VO+Gf5f73UiclUOi8jlTOCVsOLMhQn4I2z6DncrOPNloeW6lcRsL26KEkuhDz6ahLiACiLfkkjulIQC8yG1dgVPpFBwr2OmgDbxwzfY+g1VcQNPW5ABfXlO7j3OEY5Ng75X++dTdxTcNPCo7LjGkCtIljjaaeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706750755; c=relaxed/simple;
	bh=frfQKxLoEzeMVr6mq09w8CamaELprKykJ2MCygBUcGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G6rMyU8KUA2r8tbRgk+ZjPTIG0dhTUB0xypLhUoFctRUjYM0W4EurhG+iefTKvPta5iPIXLe6/pAz0ZqzEQb/0UKuiHty6c9CI050MVMJ728Z/XSE8BGq+CpjTChfbTcPNVF7NP9MeuvQ/5cdvSs6RU3jvXp9klo1jCG5j7wp2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VRYRA8v8; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706750754; x=1738286754;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=frfQKxLoEzeMVr6mq09w8CamaELprKykJ2MCygBUcGY=;
  b=VRYRA8v8W3/xOxU4OMWpDLNxUXVv/ZV18O2BTv+4IfhNLp9T0kiQBaiK
   V0NHHX239i55NNuMNZvvNc6eXsEh5oXM9f0dSvfpT7I8UpII7uCvMfv6M
   wOHMT1UDAPbBPMRcoiThGWMUHFT8watFJbto69DzLxsJn71Zx4v/05rA+
   VFPbui9GFKv96NE3qsizAFmxaOksJLFp8IeDm+B9XMtqEzps1jJzYLeeb
   48oacYvn5Ufe2afDCyV6K0RFeue4a+RJQsabteL7ppNV3jYT/Ltyo1laA
   QZOt8+UGXShy1PIIeM2MQNsQj/6UJDQ0lg2RNfJp5y0vEmxh/slsmSghU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3614805"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="3614805"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 17:25:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="911975143"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="911975143"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.213.21.45])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 17:25:49 -0800
From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RFC PATCH v3] cleanup: Add cond_guard() to conditional guards
Date: Thu, 01 Feb 2024 02:25:46 +0100
Message-ID: <5284664.GXAFRqVoOG@fdefranc-mobl3>
Organization: intel
In-Reply-To: <65baefec49c1a_4e7f52946b@dwillia2-xfh.jf.intel.com.notmuch>
References:
 <20240131134108.423258-1-fabio.maria.de.francesco@linux.intel.com>
 <6168759.DvuYhMxLoT@fdefranc-mobl3>
 <65baefec49c1a_4e7f52946b@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, 1 February 2024 02:12:12 CET Dan Williams wrote:
> Fabio M. De Francesco wrote:
> > I just noticed that this is not the final version. It misses a semicolon.
> > Please discard this v3. I'm sending v4.
> 
> Ok, but do please copy the aspect of scoped_conf_guard() to take a
> "_fail" statement argument. Passing a return code collector variable by
> reference just feels a bit too magical. I like the explicitness of
> passing the statement directly.

I'm sorry I haven't been clear. The following call convention fails my tests:

	cond_guard(..., rc = -EINTR, ...);

It always returns -EINTR, regardless of the success of 
down_read_interuptible(). There must be a reason that I can't see.

It works only if we immediaely return an error code: 

	cond_guard(..., return -EINTR, ...);

But this is not what we want since we want to check 'rc'.

Fabio




