Return-Path: <linux-kernel+bounces-58897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A54384EE3F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 01:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5FDD28954F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51B5393;
	Fri,  9 Feb 2024 00:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JyzD2vg5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DEB7F6;
	Fri,  9 Feb 2024 00:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707437804; cv=none; b=ANv9QI/n1+JXqTrfZSoClsnvKyv9mePt85VSd9mLTLvu1nwMTwmLRePrMBZKVq0k4lLCigA0X4YzY7q/uXjJuRaDnJioIgoiwxsGz1h2f46s9xb0sFi3Z03/pqRgkgKYR8h1D1c3LTZtlb60fO5BEVPbJpL1K3qNTvvYekpCit8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707437804; c=relaxed/simple;
	bh=Mg4Z1DyQeRBBImS9ItEMROMe4CmqqFacv1y2is3Cx5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONq5KQPA4nMfXVGqRPuG5/KFkr5p7sMzhU5fChDatRjTg/jCW7Qt6xdFXxDeYRITBpBj7Ag/o/lUXiAgmWKqqya6LBKgeefW4B9+rcYpZILGRYKNioIoGmkx0TDNla8XFT44nhlPyoM0gzB8fMqic98sStfajl1E+CRutU3vV3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JyzD2vg5; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707437798; x=1738973798;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Mg4Z1DyQeRBBImS9ItEMROMe4CmqqFacv1y2is3Cx5M=;
  b=JyzD2vg5QxLLGPwOIUOPHpQCLSQF6H9QiOnQXBI3CF+v8XKrtA5tmpK4
   yAB9MpPlPPZZDMLmCxQOsGt6mUelYVok+nr+rmJW60AG4WR9btvGBXzV8
   +XgXrG1zZDF7pcm90gCQlsIh7hcW+5JvR6aYpic1jTAB/xfw1Mk08tisw
   R/dFJxzNgD2J/tpnJhJTsHdYUic2tbbZR7fm6WX4hKfXeF84ystiY3cS9
   UTHQSTQe4XjZVBPAnvRLixQH2VUciHeMdoHKtBhfMLyRBdgcpFrDqTWG4
   CpWbdp6ufTtRNEbwSzv9Dk2qOpyaYljxJb6FMkFMEWhxfs1+j7B2JvTzR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1203513"
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="1203513"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 16:16:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="2027629"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 16:16:34 -0800
Date: Thu, 8 Feb 2024 16:16:32 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Will Deacon <will@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V5 12/12] perf intel-pt: Add a test for pause / resume
Message-ID: <ZcVu4PPZKgyI1jeO@tassilo>
References: <20240208113127.22216-1-adrian.hunter@intel.com>
 <20240208113127.22216-13-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208113127.22216-13-adrian.hunter@intel.com>


For Patch 2-12:

Reviewed-by: Andi Kleen <ak@linux.intel.com>


