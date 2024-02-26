Return-Path: <linux-kernel+bounces-81733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C4386797B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2808A1F25F2A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDDA13247D;
	Mon, 26 Feb 2024 14:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QvQm1Tgx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A94E12BF1C
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 14:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708958832; cv=none; b=HlT/VZ4DFpSa0mMHqNG5tnqlwxbI44bfNIVuXJ4RL9hd7dZHA0e8c3GpAiQ9mnHezNbu/tPAW3EMLPQgpapNyc0MGjBog2IeZNmZsUUaL4HNHr6kfsXQV0DVrVic/DiJNAdqQPEZPzuCyBemTs/p0n71P9+dCTr8bytA3LHlGVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708958832; c=relaxed/simple;
	bh=BS/LynQ/vfsRyBPVQ8PFhDz219TrZ+G+szkSUtWDY2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntYRFQ35xCZoD1AdLoNkhY9yS2s3HZYrGnoKWBfmSoouYkRqqb1m4wTD5CAUJsrnj+A+NYMidg26NI2Q28LzCkyfw9o7aOZHg9Y+gSkhAs26e6ZwWtHczi/nraVER937ccUqeDD1xxT59IYC37tjpjJnVtM9hhao6KHv8e017QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QvQm1Tgx; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708958831; x=1740494831;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=BS/LynQ/vfsRyBPVQ8PFhDz219TrZ+G+szkSUtWDY2k=;
  b=QvQm1TgxBswjVGgXmMxzLalwsDR0EYOkZIE+jVFjd8C5f/LWRqeGAVut
   x73H4I2ThfHMYzrFIVgvQExbvB5NPUwgjJVaR58QoZBIJZBxcIleUlyf+
   6ZftohHFVRcYOKehcVzztWsbF5jHwFarzMcvSsRZZuaJ0iUjVqWEMIpHj
   hnlI6eEcOu1cWZmIiI7NxgdgPv1XlTEZTeWAFREhVTjMb42mIzBFpfZRN
   rzeW3jxhGUfpYTAUrxBPLYFcYrlDXZEbJ/aC5YyLuZmDDlLSIZ3NpXJqn
   LAWG5wTQ2bxfIG2F8hE5FFenjMsboL2YGcNEzVVzC/gIQFNf/qze8CRab
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="14681758"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="14681758"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 06:47:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="913874171"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="913874171"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 06:47:08 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1recG1-00000007hu6-2KVF;
	Mon, 26 Feb 2024 16:47:05 +0200
Date: Mon, 26 Feb 2024 16:47:05 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shahar Avidar <ikobh7@gmail.com>
Cc: gregkh@linuxfoundation.org, luca.ceresoli@bootlin.com,
	benjamin.tissoires@redhat.com, elder@linaro.org, robh@kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] staging: pi433: Move FIFO_THRESHOLD define to source
 file
Message-ID: <ZdykaQCdtqOrdOsC@smile.fi.intel.com>
References: <20240225173341.1278918-1-ikobh7@gmail.com>
 <20240225173341.1278918-5-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240225173341.1278918-5-ikobh7@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Feb 25, 2024 at 07:33:41PM +0200, Shahar Avidar wrote:
> FIFO_THRESHOLD is only being used by pi433_if.c source file

Same issue (and seems in all of your commit messages) — missing periods
at the end of the sentences. Respect English grammar, please.

-- 
With Best Regards,
Andy Shevchenko



