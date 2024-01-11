Return-Path: <linux-kernel+bounces-23171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A4582A897
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33D54288320
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78A3D30F;
	Thu, 11 Jan 2024 07:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ATSZsn2s"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF9BD2E2;
	Thu, 11 Jan 2024 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704959899; x=1736495899;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6SWAP6rWKQLvpfwOKZYTtX7+UdkpygkCYBqaYOchKGM=;
  b=ATSZsn2s1DoyU/5fLi1EoFqXMJFCy5F0U1YHbq4Qv0LVLUlGRzLzo5aB
   1r8FAXcw62ZOiLm5kMQuY9NHccklz8J+OKZXfbeGj5E+y3o6aVUhPzbuw
   I8O1ZobC1dFRBEHrKA+byBrxpkgbEGhFFP3hEiBSvFwLd+ZBUdb8zTgoJ
   tJkHWJmaQRqS3V2zJtZXnHyPRRA2MI1uocxf3p21phtf9YXM0eSZd1P0w
   asTwTS06ZCsWv180owmuTecz1UAlC69kDKe6D+TQhtDniRWNar1508GWg
   emnQCjBqAmC2JP7/x88B994HwWumS8F4m7wj32fkDVWpGgDpXhuO18ls0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="12258991"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="12258991"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 23:58:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="905861073"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="905861073"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.54.133])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 23:58:04 -0800
Date: Thu, 11 Jan 2024 08:58:01 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux PM <linux-pm@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] PM: sleep: Restore asynchronous device resume
 optimization
Message-ID: <ZZ+fiUZolz3jogcE@linux.intel.com>
References: <10423008.nUPlyArG6x@kreacher>
 <ZZ5zcBBEv7qupIdE@linux.intel.com>
 <CAJZ5v0gp6uETgLNHxDnSd4h_0ois7J2AC7soJJVv18B99GmxcQ@mail.gmail.com>
 <ZZ6kDVD3p4KdR9Cs@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ6kDVD3p4KdR9Cs@linux.intel.com>

On Wed, Jan 10, 2024 at 03:05:07PM +0100, Stanislaw Gruszka wrote:
> On Wed, Jan 10, 2024 at 01:33:07PM +0100, Rafael J. Wysocki wrote:
> > > I would consider different naming just to make clear this
> > > is regarding async call, in_progress looks too generic for me.
> > 
> > OK, what about async_in_progress?
> Sure, that better.

Even better would be using_async IMO, because we don't know if
async call is in progress or finish or before start.

Regards
Stanislaw

