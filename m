Return-Path: <linux-kernel+bounces-8164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF36381B2EB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E4F11F2341F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8681830335;
	Thu, 21 Dec 2023 09:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZJzeI8tm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0A24BAAC;
	Thu, 21 Dec 2023 09:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703152392; x=1734688392;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jqZ/0vneGI1A7pzJKwtayNvEPW9rt5oNvOrvps0qTzw=;
  b=ZJzeI8tmHogbyyjyPOPwezxVKWzT7v1dAwG8jr3UkYMRtyJghbfm0yST
   /mf3jbEnXUqiW+M8Nx5moo6mxmq0GHaTUgwc9miW/bQY006C7hNgEO4Gh
   X6nr3cNm9TjmyhFfzarAhVTHZehFlQZm8hj3I+nwkb0ad+k7hWhFfXwDQ
   0nBMz7cNmFoSbboIdnReygtBwzZzo3WL054AAeCmUpcwTEuki3EW4rZ34
   XvvUR+UJ8qo+HUmEebd+dj0C6hkPHnEDAVsk1sLt2kUZcOoeW3ZtMDnf+
   A+CGInaJmvwt+Puk+IV8LhtizbteqIs2uFJetfQzZIrn4g5TEZNCgqmIE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="2785037"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="2785037"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 01:53:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="920278179"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="920278179"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 21 Dec 2023 01:53:09 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 62C5BB8; Thu, 21 Dec 2023 11:53:07 +0200 (EET)
Date: Thu, 21 Dec 2023 11:53:07 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Sanath S <sanaths2@amd.com>
Cc: Sanath S <Sanath.S@amd.com>, mario.limonciello@amd.com,
	andreas.noever@gmail.com, michael.jamet@intel.com,
	YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [Patch v2 2/2] thunderbolt: Teardown tunnels and reset
 downstream ports created by boot firmware
Message-ID: <20231221095307.GB2543524@black.fi.intel.com>
References: <20231218122312.GE1074920@black.fi.intel.com>
 <997f2a94-66d9-fb95-8f75-46d61937f7e8@amd.com>
 <20231218131840.GH1074920@black.fi.intel.com>
 <0fd5c09f-1cf2-8813-a8f9-1bd856e3a298@amd.com>
 <20231219122634.GJ1074920@black.fi.intel.com>
 <0816caa4-81b5-d0f9-2305-80c7fec6abb9@amd.com>
 <20231219180424.GL1074920@black.fi.intel.com>
 <20231220125857.GA2543524@black.fi.intel.com>
 <5bfaa405-b15e-36ef-a4e0-04b93dd983b1@amd.com>
 <257c694f-5aa2-c29b-891d-3a1f480dd4a1@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <257c694f-5aa2-c29b-891d-3a1f480dd4a1@amd.com>

On Thu, Dec 21, 2023 at 03:01:50PM +0530, Sanath S wrote:
> > Sure. I'll check with these combinations.
>
> Can you name any docks that meets these requirements ? I'll try to get
> hold of it here and check.

Pretty much every Titan Ridge based dock. For instance Dell WD19TB.

I have some hardware here that I can use to try it out too.

