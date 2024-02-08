Return-Path: <linux-kernel+bounces-58616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 160B884E8E2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62C0CB2E6BE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8279374EB;
	Thu,  8 Feb 2024 19:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cxt+cCfT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4D5374D2
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 19:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707420304; cv=none; b=UVHBiWtIIC0DZd/Ev19f/kG/Iz9Qm5br7+zjnJLAotq1NKoUOW2E4YDKuNv2p1BbubMH19TW0NMsZ6MU5Ep3vzHqzf7E+bQPlaqxpqgeBn5+BWAkkeSx8vSSqm8/EvXqHEa0X1ZDXHhs/HSdZlGIrBxQ2j3fW4EQfpNEufPpiks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707420304; c=relaxed/simple;
	bh=C/qhpvQ1U/IGPG9Q/4H48Jyadfqklag1ncD0iP9AUlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ikBdzle8SX4neJRNNmkwRhJy7e3ZK9iK0JkU9TYMIAxl+A37gO4nmSWcGAX0MNLFZ2hi/0jeds8/e/XuElVcLeMujaOc/Dj/Go8PMFORpzgMz5nGlDeBb9wDFfJMbuUccSF9+JqWz1QYg9X/3ZKo5PKx+czhpxFpm5c4tZB/q94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cxt+cCfT; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707420303; x=1738956303;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C/qhpvQ1U/IGPG9Q/4H48Jyadfqklag1ncD0iP9AUlU=;
  b=Cxt+cCfTX2ASH+KuJOLY1m0D8OhJAUADUcDkQZS4KJYU+Hs2mrBsETB7
   639FZkGREp21YR5WHRBguN88PMj9oL/bws66eNWa59yxjPZb8vEuxw3vz
   twzgTPPbsWzpxKOqr+HF7la66LcwvAg1oR+Zlta9gkmz//lpPydKtN/iG
   w7cN+iLt+JHyvHFANVGcvO8YvbZNjhJ1ZqjOBHP/h0c/jBQNACQOUHu78
   I9gIHpVcxbRk6H//ToXeo5Lk0E8F5O+w9K7s5hcOVDbkfSDWiOAThdlGP
   cLz/Pnaz5a+SYVoJ/5RbuO+55Q03mYwfHA5hZvzJMKsTnH8pDyZkyD1Qe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1202720"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1202720"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 11:25:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="934228592"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="934228592"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 11:25:00 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rYA14-00000002yGc-0sDF;
	Thu, 08 Feb 2024 21:24:58 +0200
Date: Thu, 8 Feb 2024 21:24:57 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v1 1/1] extcon: intel-mrfld: Don't shadow error from
 devm_extcon_dev_allocate()
Message-ID: <ZcUqiaGI8N-FLijJ@smile.fi.intel.com>
References: <20231222161854.2955859-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222161854.2955859-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Dec 22, 2023 at 06:18:54PM +0200, Andy Shevchenko wrote:
> Don't shadow error from devm_extcon_dev_allocate() and return it as is.

Any comment on this?

-- 
With Best Regards,
Andy Shevchenko



