Return-Path: <linux-kernel+bounces-22196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59358829AB3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6930B1C25B23
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED6D48783;
	Wed, 10 Jan 2024 12:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mw0Opq/z"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA02138DE0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 12:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704891297; x=1736427297;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xm2YU4WaqEHvWHszTGe+00QdRB6H2V0BZ+19qV1T0og=;
  b=Mw0Opq/zlvG+t6a20i3J/DFSbNxX4jytHjtlfQChtj7/f41+gRbDx47+
   R9sK5gKk1k5UzWDYL2pkb7G9oUlo5PVJK1J82RNB5zzSBEfw4IXN5URsa
   vn+kBcZzpAlYeTWdEGdnKt0B6Y6ghEK9cG1TTV9dtiaCnUp1cKPK45WaP
   glz7/2Kmd+a5ZpFE/NlSmUnP3tCoXCOnRtTV9cld76Ct1HlwnPS831/UW
   rPJYs8fZ4iPu3Z2DiXmpc+LexhRHIRl8CEsyond/FdzzHN0wYY/3bxg8G
   oclysBur3BpqhqloJxcp9cYhsrsLcWlkcbeNWIgWnRpK/1jnH6TbV/JU2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10948"; a="5257498"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="5257498"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 04:54:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10948"; a="785592166"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="785592166"
Received: from jganji-mobl1.gar.corp.intel.com (HELO box.shutemov.name) ([10.249.37.201])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 04:54:54 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 6CB6B109589; Wed, 10 Jan 2024 15:54:51 +0300 (+03)
Date: Wed, 10 Jan 2024 15:54:51 +0300
From: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH v1] virt: tdx-guest: Handle GetQuote request error code
Message-ID: <20240110125451.whabimhece7dw5jn@box>
References: <20240109054604.2562620-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20240109131740.nk54gdmri6gpwkta@box.shutemov.name>
 <6805ad1f-2c91-4a8d-98c9-5da337dd13f6@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6805ad1f-2c91-4a8d-98c9-5da337dd13f6@linux.intel.com>

On Tue, Jan 09, 2024 at 07:56:56PM -0800, Kuppuswamy Sathyanarayanan wrote:
> 
> 
> On 1/9/2024 5:17 AM, Kirill A . Shutemov wrote:
> > On Tue, Jan 09, 2024 at 05:46:04AM +0000, Kuppuswamy Sathyanarayanan wrote:
> >> Currently when a user requests for the Quote generation, the Quote
> >> generation handler (tdx_report_new()) only checks whether the VMM
> >> successfully processes the Quote generation request (status !=
> >> GET_QUOTE_IN_FLIGHT) and returns the output to the user without
> >> validating the status of the output data. Since VMM can return error
> >> even after processing the Quote request, returning success just after
> >> successful processing will create confusion to the user. Although for
> >> the failed request, output buffer length will be zero and can also be
> >> used by the user to identify the failure case, it will be more clear to
> >> return error for all failed cases. So validate the Quote output status
> >> and return error code for all failed cases.
> > 
> > Could you split commit message into several paragraphs? It would be easier
> > to get along.
> > 
> > It can be helpful to follow structure like:
> > 
> > <Background>
> > 
> > <Problem>
> > 
> > <Solution>
> > 
> 
> How about the following version?
> 
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
> So when handling the Quote generation request, validate the Quote data
> output status and return error code for all failed cases.

I would drop the start of the sentence upto ',' here, but otherwise looks
good to me.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

