Return-Path: <linux-kernel+bounces-27281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D03582ED3B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E046C28568E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F9C1A592;
	Tue, 16 Jan 2024 10:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hf3wWH2s"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8D018EB3
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 10:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705402731; x=1736938731;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fVFzolAaNMqJShGWKu8kQmZjsqjN+EpSt9vDF82e8oo=;
  b=hf3wWH2sdtxbiZ4puwlEzC4I8O/OrB/YpIkEcS6/Q/AZ19GSYiLRP7Gw
   R19SwvCfjBzM2+Hmnqsi62GdhsCqQz/INZF/a3174HdkXTNZfYyIrLMVg
   O2m9eK3RuSAYQxe1v9Yh3I+v/OlWqZkFefak39MEFsku5714IiX0d7V97
   V9snWISWFl/5osiNnISBE0Zov3V3M3jDIKYxSiOQO+gvKYHUS8yQ3xg3k
   1PVKjVfGyxLyOU4xiQOyWts/LwJu+WhjqbQ0TeW1padzsxCHt4hHncOvy
   aXN0KOnEzlkdskQPIvRiJM2jbveQ1p44NON2JkI+hldN+0AfNY20BVyus
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="399496629"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="399496629"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 02:58:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="1115252763"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="1115252763"
Received: from uschumac-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.213.254])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 02:58:47 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 8EDF310A17B; Tue, 16 Jan 2024 13:58:44 +0300 (+03)
Date: Tue, 16 Jan 2024 13:58:44 +0300
From: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"jpiotrowski@linux.microsoft.com" <jpiotrowski@linux.microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Cui, Dexuan" <decui@microsoft.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCHv2] x86/mm: Fix memory encryption features advertisement
Message-ID: <20240116105844.cjnwpzuywukfv5rs@box.shutemov.name>
References: <20240111111224.25289-1-kirill.shutemov@linux.intel.com>
 <2b171c78e3dbc33f6fcf015c14c9e84825776798.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b171c78e3dbc33f6fcf015c14c9e84825776798.camel@intel.com>

On Tue, Jan 16, 2024 at 10:36:10AM +0000, Huang, Kai wrote:
> On Thu, 2024-01-11 at 14:12 +0300, Kirill A. Shutemov wrote:
> > When memory encryption is enabled, the kernel prints the encryption
> > flavor that the system supports.
> > 
> > The check assumes that everything is AMD SME/SEV if it doesn't have
> > the TDX CPU feature set.
> > 
> > Hyper-V vTOM sets cc_vendor to CC_VENDOR_INTEL when it runs as L2 guest
> > on top of TDX, but not X86_FEATURE_TDX_GUEST. Hyper-V only needs memory
> > encryption enabled for I/O without the rest of CoCo enabling.
> > 
> > To avoid confusion, check the cc_vendor directly.
> > 
> > Possible alternative is to completely removing the print statement.
> > For a regular TDX guest, the kernel already prints a message indicating
> > that it is booting on TDX. Similarly, AMD and Hyper-V can also display
> > a message during their enumeration process.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Cc: Dexuan Cui <decui@microsoft.com>
> > Cc: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
> 
> Seems this fix is for userspace running in hyperv environment being able to use
> some easy grep to get which coco vendor it is running on?

Making decision in userspace by	grepping dmesg is bad idea and nobody
should do this. It can easily give false result: dmesg is not ABI, format
can change and ring buffer has finite size, the message can be overridden.

If we need a way for userspace to discover which CoCo environment it runs
on, we need proper ABI for that. Maybe sysfs file or something.

> If so I think it would be nice to mention it too.
> 
> Acked-by: Kai Huang <kai.huang@intel.com>

Thanks.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

