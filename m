Return-Path: <linux-kernel+bounces-140266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAB18A10F4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FBD41F2CFA8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B9D1482E6;
	Thu, 11 Apr 2024 10:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jAX3JCdI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD737147C9D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 10:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831936; cv=none; b=pRueDAl2uiSa5mG0TFsyXU8k50t3w7l3Do9urAPKhQMahOv1E4a2pYOSuwlubOkqvHjfX/ijQ92m5OL1a8NfcIgv+NOHtvC8+nl/LQae0CWG2GjQYAFT97HIeC6DeBSacteVvd1fIqwg6O/0TDQpFiSl2MfM3WGLQpL5RKtemZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831936; c=relaxed/simple;
	bh=4bkwHo8HvOVpM773QtBhdjug2HdT83ARAY5I3dAxDRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIANaMZYHW58CuzJSQ7HjGjRkAWF/BP52aFK6FqzYZg4J1kRlgG+ZHcL6b6bwXsfzsPBGSVbbwVfaBS5+A7R0g7Ckz+URFcP88hMxYKqwo1bXTFIzN149ZBb5OeXCgb4Xd982hSoJlnFNlp7X81C7f36BB6RVUoJTiBuAeIzP0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jAX3JCdI; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712831935; x=1744367935;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4bkwHo8HvOVpM773QtBhdjug2HdT83ARAY5I3dAxDRk=;
  b=jAX3JCdIkToZijxGGLffAaGr36ybzmChgKZHsIO6/71jNn9Jqj35KfTf
   qveq6JAvOl8gfX6kLcuW3QTT8KfGYM9m905/t65Z46bhxWofs1RN63mh+
   KPpISTGeumfvYCjIlDv85YKnk0A+Huxyb4Iwk55wkK31EgFQvB8cLCcbh
   57tb9Ze3bNUzml3hYf61ePySt015wFptQ2LU8xpOhvzgjhLUmFilqNJA0
   VQLxKLymI1V+L619sAol+LlU5fULl0AvcyYaNkP78m6WIhNLKqPTLIT9S
   VS88eUrBVUi54tCjgtPE6N6NxNj+Ze7FRZKZoCPP4Y3zK5AYCRnZDNDu1
   w==;
X-CSE-ConnectionGUID: hdQB8xN8RGmlmfMTbdsXyA==
X-CSE-MsgGUID: 54zkYjCZSw6BLItfxSYTEw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8454002"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="8454002"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 03:38:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="915459875"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="915459875"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 03:38:50 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rurpP-00000003K7E-0KHQ;
	Thu, 11 Apr 2024 13:38:47 +0300
Date: Thu, 11 Apr 2024 13:38:46 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kyle Meyer <kyle.meyer@hpe.com>
Cc: linux-kernel@vger.kernel.org, yury.norov@gmail.com,
	linux@rasmusvillemoes.dk, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	russ.anderson@hpe.com, dimitri.sivanich@hpe.com, steve.wahl@hpe.com
Subject: Re: [PATCH v2 2/2] sched/topology: Optimize topology_span_sane()
Message-ID: <Zhe9ttm9Ppv2wT3S@smile.fi.intel.com>
References: <20240410213311.511470-1-kyle.meyer@hpe.com>
 <20240410213311.511470-3-kyle.meyer@hpe.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410213311.511470-3-kyle.meyer@hpe.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 10, 2024 at 04:33:11PM -0500, Kyle Meyer wrote:
> Optimize topology_span_sane() by removing duplicate comparisons.
> 
> Since topology_span_sane() is called inside of for_each_cpu(), each
> pervious CPU has already been compared against every other CPU. The

previous

> current CPU only needs to be compared against higher-numbered CPUs.
> 
> The total number of comparisons is reduced from N * (N - 1) to
> N * (N - 1) / 2 on each non-NUMA scheduling domain level.

Thank you, now it makes sense.

-- 
With Best Regards,
Andy Shevchenko



