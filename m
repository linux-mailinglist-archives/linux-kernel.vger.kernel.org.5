Return-Path: <linux-kernel+bounces-21697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC518292E3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 04:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B13FE1C24B9C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 03:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07A84A3E;
	Wed, 10 Jan 2024 03:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Di0upVoz"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2BF2579
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 03:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704859017; x=1736395017;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gdadnGNt0Fm1J3d13vTf9QC7afXDTIlf4F249pDwUqM=;
  b=Di0upVozpG/71gPCnlIUhjHGce0c16RUd2Mg3zMzr+Irykoh1MTkQc9P
   v907RnvJTZJHbZKYc6J/QMhC2Nf6p5OKP5NLUSyfmIA6P8gWArNkZWnHX
   5eTxdtEO/YeEPkstFglEQ8IihExAYwmryhkUscVpc28OzTQR44sv8MXJ8
   +tIcFD3FjFcQfoNlkZp8Hdy8hpXSVekGhmeYEeL1BDdnJnC2ITPT/q5CA
   jaJjN+BZxAM2nUsN0b2NhOnpvzzEy4by32NML/OgUFUJ9cLWM7Rd8YSKy
   kzHexDvVa0Yy9PTO7W2NQ2+CZYbnu0tPxFR2JdEo4qPiUwM9T1yJMDraZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="388840831"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="388840831"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 19:56:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="925493785"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="925493785"
Received: from nitishde-mobl1.amr.corp.intel.com (HELO [10.209.101.57]) ([10.209.101.57])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 19:56:56 -0800
Message-ID: <6805ad1f-2c91-4a8d-98c9-5da337dd13f6@linux.intel.com>
Date: Tue, 9 Jan 2024 19:56:56 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] virt: tdx-guest: Handle GetQuote request error code
Content-Language: en-US
To: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
References: <20240109054604.2562620-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20240109131740.nk54gdmri6gpwkta@box.shutemov.name>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240109131740.nk54gdmri6gpwkta@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/9/2024 5:17 AM, Kirill A . Shutemov wrote:
> On Tue, Jan 09, 2024 at 05:46:04AM +0000, Kuppuswamy Sathyanarayanan wrote:
>> Currently when a user requests for the Quote generation, the Quote
>> generation handler (tdx_report_new()) only checks whether the VMM
>> successfully processes the Quote generation request (status !=
>> GET_QUOTE_IN_FLIGHT) and returns the output to the user without
>> validating the status of the output data. Since VMM can return error
>> even after processing the Quote request, returning success just after
>> successful processing will create confusion to the user. Although for
>> the failed request, output buffer length will be zero and can also be
>> used by the user to identify the failure case, it will be more clear to
>> return error for all failed cases. So validate the Quote output status
>> and return error code for all failed cases.
> 
> Could you split commit message into several paragraphs? It would be easier
> to get along.
> 
> It can be helpful to follow structure like:
> 
> <Background>
> 
> <Problem>
> 
> <Solution>
> 

How about the following version?

During the TDX guest attestation process, TSM ConfigFS ABI is used by
the user attestation agent to get the signed VM measurement data (a.k.a
Quote), which can be used by a remote verifier to validate the
trustworthiness of the guest. When a user requests for the Quote data
via the ConfigFS ABI, the TDX Quote generation handler
(tdx_report_new()) forwards the request to VMM (or QE) via a hypercall,
and then shares the output with the user.

Currently, when handling the Quote generation request, tdx_report_new()
handler only checks whether the VMM successfully processed the request
and if it is true it returns success and shares the output to the user
without actually validating the output data. Since the VMM can return
error even after processing the Quote request, always returning success
for the processed requests is incorrect and will create confusion to
the user. Although for the failed request, output buffer length will
be zero and can also be used by the user to identify the failure case,
it will be more clear to return error for all failed cases.

So when handling the Quote generation request, validate the Quote data
output status and return error code for all failed cases.


-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

