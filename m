Return-Path: <linux-kernel+bounces-34970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6258C838A0E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BB4528A426
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACC058124;
	Tue, 23 Jan 2024 09:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kbqRRmAQ"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC247E9;
	Tue, 23 Jan 2024 09:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706001260; cv=none; b=qu6jLtxIsQxK5DwklQ2cpoCuEvzPdqICKuwkMy/TWLaJxcucbaujQGz6h/DAtl0tsEZYqQ++qHL+MVPjzGZwc4yi0INJzsYrEYwLp1EiZQQk30NCflC6km0DCUU+KGWiAgup7mRdxgFbMu2C5vFoYcoUS5JBrJbsycizhV766Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706001260; c=relaxed/simple;
	bh=RYg6idq8Qd6RJSL13IwhEBRCgLYFPiV2UAWGRhd9z4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTY/JLDAwSeb+Cyn0ZGPxh1NphXtY+1Brmp7tg+HuVgmc29eqYb0uJny/kuuBpV4M0z0njoB7loYwO9CjDCFiCajkF/uF9LCNhJ375f0yr0QBkdCQJV4+IEMKZMd2QlGorMTz7Ha4QPQRIQ2UKbi8290jCbm28Dg3y4HCYUeAqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kbqRRmAQ; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706001258; x=1737537258;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RYg6idq8Qd6RJSL13IwhEBRCgLYFPiV2UAWGRhd9z4U=;
  b=kbqRRmAQ0BSN1Ua0lgXjALc/+UFB53o8YlU0wFaO3dQCScvOPdQ8vtoT
   MOdn7HQncvl2oKwSvtTSgwQwDc/XhRVcdDG2569+CktEr/PCJXMVGxkit
   vH/qlmLbU2ErsFoBfsPSlL+eUk/AHBWf2m8JQWwEBUG6T7ltBx8OJNGdt
   9nbXM8lIyBiX7ag746w7oRRhj8zlEVXZpYyi+UG9mAgI7PZIOyOyMuES0
   023gHa+v600ZMM/x5RSWTr/1EBu/yGrocLfexd2gJ903XD1vOtljvZ0bD
   0/jrk/HRmMFCtpUIO7hjKhBhkDmNi6gFr9dYc4yEKYquqFI3kdH90jeql
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="405220829"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="405220829"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 01:14:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="905167122"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="905167122"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.41.26])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 01:14:15 -0800
Date: Tue, 23 Jan 2024 10:14:13 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1] PM: sleep: Use bool for all 1-bit fields in struct
 dev_pm_info
Message-ID: <Za+DZVM6Dd2YRsWL@linux.intel.com>
References: <12380944.O9o76ZdvQC@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12380944.O9o76ZdvQC@kreacher>

On Mon, Jan 22, 2024 at 05:11:26PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> For some 1-bit fields in struct dev_pm_info the data type is bool, while
> for some other 1-bit fields in there it is unsigned int, and these
> differences are somewhat arbitrary.
> 
> For consistency, change the data type of the latter to bool, so that all
> of the 1-bit fields in struct dev_pm_info fields are bool.
> 
> This also reduces the size of struct device on my x86 systems by 8 B,
> from 1120 B to 1112 B.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

