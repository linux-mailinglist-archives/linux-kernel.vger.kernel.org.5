Return-Path: <linux-kernel+bounces-23475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9BA82AD48
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DF3228871E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA88214F9B;
	Thu, 11 Jan 2024 11:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IxEkt4DL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA03314F90
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 11:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704972197; x=1736508197;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IhLVf1IN4DSrbYF9P13rk6JGQJ+d09K7DNovQma/Gpc=;
  b=IxEkt4DL9N66BUh+U0i+FlV5R8mPwxZi7Up/qjwNz9Y/N5sJCORrIN3N
   FQzj6BRb7b8d61Ic8/9S0DWU43E4n9D6CBv8KyJwH6LJ1NRFL+blPKr8U
   TZ5uePheb032va/3aa2kMNpWYTbpOsO+LgDgw7Ihus5KjR1LARVC/Z/oI
   x7nMDU6JyHP4EQtqahbTyxnrvD1b6xhVo83YGqO7Iy08dKCdCeOPjJ/r1
   kPN2os/mEvw3qqXwsDy27x+mP/sBVIAwZBgAqhvWQhghrpzTFJjoCWRB3
   5p2PK+NX30Hs7zn9X5pTafp1wQx70ggN7K17NwVzlsHyacpP9NM9EnmIS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="5546859"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="5546859"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 03:23:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="852916313"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="852916313"
Received: from gcrisanx-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.213.56])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 03:23:15 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id BD76F10A557; Thu, 11 Jan 2024 14:23:12 +0300 (+03)
Date: Thu, 11 Jan 2024 14:23:12 +0300
From: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH v2] virt: tdx-guest: Handle GetQuote request error code
Message-ID: <20240111112312.zdgkmfywscp2kvxw@box.shutemov.name>
References: <20240111033245.2632484-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111033245.2632484-1-sathyanarayanan.kuppuswamy@linux.intel.com>

On Thu, Jan 11, 2024 at 03:32:45AM +0000, Kuppuswamy Sathyanarayanan wrote:
> During the TDX guest attestation process, TSM ConfigFS ABI is used by
> the user attestation agent to get the signed VM measurement data (a.k.a
> Quote), which can be used by a remote verifier to validate the
> trustworthiness of the guest. When a user requests for the Quote data
> via the ConfigFS ABI, the TDX Quote generation handler
> (tdx_report_new()) forwards the request to VMM (or QE) via a hypercall,
> and then shares the output with the user.
> 
> Currently, when handling the Quote generation request, tdx_report_new()
> handler only checks whether the VMM successfully processed the request
> and if it is true it returns success and shares the output to the user
> without actually validating the output data. Since the VMM can return
> error even after processing the Quote request, always returning success
> for the processed requests is incorrect and will create confusion to
> the user. Although for the failed request, output buffer length will
> be zero and can also be used by the user to identify the failure case,
> it will be more clear to return error for all failed cases.
> 
> Validate the Quote data output status and return error code for all
> failed cases.
> 
> Fixes: f4738f56d1dc ("virt: tdx-guest: Add Quote generation support using TSM_REPORTS")
> Reported-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Closes: https://lore.kernel.org/linux-coco/6bdf569c-684a-4459-af7c-4430691804eb@linux.intel.com/T/#u
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

