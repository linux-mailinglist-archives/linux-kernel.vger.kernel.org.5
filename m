Return-Path: <linux-kernel+bounces-50153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A798474F9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAEEC1C2705D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9FF14901A;
	Fri,  2 Feb 2024 16:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i5Qiz51h"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3702F1487D0
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 16:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891761; cv=none; b=CPz+NE80w26USwR2fpjcAoQZ3GuloGzuR3kxDsFGv82LeRGCxGNhqmwb+7iKxy86spPXSwAUtMVd2BdPcJLvd2KA47KRkrVeNoAozzc6m8hWy8yKx5pj9yJ1ynyEpdajY17G7W2i80KWpN/FpKQsyw0GBl5JpZ7AEpXPYHsPE3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891761; c=relaxed/simple;
	bh=NvkwA1jk/5kaJF3W/uYQ89LSQ+kOKTgXko1D4t7m/78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nMWRpIoEdcbxTogsLfBiDmk0z4X2GNfkzVaWHZvK1GKyfUQiAzlK9MZDBUM5J/3x4111TvqS2PvuSjc+Rf50Jr0X+usjnauRcQte11wKNiGDXcKFWMO+uoQPJ9pWwxH/wZzFeN5fDN3GlE/ZEQXz8lcfos3lqh5DHpCPBk7u0jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i5Qiz51h; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706891760; x=1738427760;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NvkwA1jk/5kaJF3W/uYQ89LSQ+kOKTgXko1D4t7m/78=;
  b=i5Qiz51hD4MikrTOzHTwgScjko3N3kPLIPl5AgxhG2BxbvMEi3uNUz5P
   bpQ048ZLKB2typmYxwACKjD5Nc/jGLffAqJr6PuK19ntq09ViCY++iAjT
   5oyPWN4vnlQn0OgBQh31BamxBr8JTurW7m4lxqPj4gBjJHBi/fHoORFDF
   ixgx8iBvTitzb2VW21xfSJWySu3i/iwGOZbL1bqL6YSdBWE+LF6OEK23h
   68AjWkC5XCIHhIcJ3MOGR3tEPu22nD5xZwecQ1bM97ltbIHFuJBfLmEie
   I9fh5zwipaKap8cP8jXHN51SFnmR43EPLvUIylyGUvekMqRytlZIkM6Vc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="22673852"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="22673852"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 08:35:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="4715525"
Received: from adcimmar-mobl.amr.corp.intel.com (HELO [10.212.206.109]) ([10.212.206.109])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 08:35:59 -0800
Message-ID: <746d2448-3adc-467b-a39c-5585f33bd740@intel.com>
Date: Fri, 2 Feb 2024 08:35:58 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 5/5] x86: CVMs: Ensure that memory conversions happen at
 2M alignment
Content-Language: en-US
To: Vishal Annapurve <vannapurve@google.com>,
 Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com,
 rientjes@google.com, seanjc@google.com, erdemaktas@google.com,
 ackerleytng@google.com, jxgao@google.com, sagis@google.com,
 oupton@google.com, peterx@redhat.com, vkuznets@redhat.com,
 dmatlack@google.com, pgonda@google.com, michael.roth@amd.com,
 kirill@shutemov.name, thomas.lendacky@amd.com, dave.hansen@linux.intel.com,
 linux-coco@lists.linux.dev, chao.p.peng@linux.intel.com,
 isaku.yamahata@gmail.com, andrew.jones@linux.dev, corbet@lwn.net,
 hch@lst.de, m.szyprowski@samsung.com, rostedt@goodmis.org,
 iommu@lists.linux.dev
References: <20240112055251.36101-1-vannapurve@google.com>
 <20240112055251.36101-6-vannapurve@google.com>
 <6709a57c-48a0-4ddd-b64e-a1e34ae2b763@intel.com>
 <CAGtprH_ANUVU+Dh1KOq0vpT7BGbCEvD2ab9B=sxjzHYsKxFGeA@mail.gmail.com>
 <1d9d3372-825a-417a-8811-ffa501c83936@linux.microsoft.com>
 <CAGtprH8r0kYYqGoumsVeZq42cX8CN3cchkuRYhQULqtb-1nKww@mail.gmail.com>
 <3313c886-e964-48c3-8277-b47cb1955de9@linux.microsoft.com>
 <CAGtprH9X0Yz_Z+QaYcLpLNXtY_Ye68aqvx-G1pOWZxv9SiRRoQ@mail.gmail.com>
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <CAGtprH9X0Yz_Z+QaYcLpLNXtY_Ye68aqvx-G1pOWZxv9SiRRoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/2/24 08:22, Vishal Annapurve wrote:
>> If you must - focus on getting swiotlb conversions to happen at the desired
>> granularity but don't try to force every single conversion to be >4K.
> If any conversion within a guest happens at 4K granularity, then this
> will effectively cause non-hugepage aligned EPT/NPT entries. This
> series is trying to get all private and shared memory regions to be
> hugepage aligned to address the problem statement.

Yeah, but the series is trying to do that by being awfully myopic at
this stage and without being _declared_ to be so myopic.

Take a look at all of the set_memory_decrypted() calls.  How many of
them even operate on the part of the guest address space rooted in the
memfd where splits matter?  They're not doing conversions.  They're just
setting up shared mappings in the page tables of gunk that was never
private in the first place.

