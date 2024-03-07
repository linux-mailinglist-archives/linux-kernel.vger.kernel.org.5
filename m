Return-Path: <linux-kernel+bounces-94899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCD5874675
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F9611C222C3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9796CA62;
	Thu,  7 Mar 2024 03:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fCDOyvXl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D534863D0
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 03:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709780489; cv=none; b=plHsRnFz2fG4FQ31KDHYWB8Zj5NWnb865pkS83RudeU8w/62HiIqyrWOFptgw6mxvNOz1lKBe04yjSTt4dvTRU4VlUx3FnXeKxEszIVglh7EGJhFDVoWodX1YYg362M5ARF/Za+kxEF7L+pjpVVhPEt2nQJlsPUOH0GtxpazfEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709780489; c=relaxed/simple;
	bh=jiLpUS83X9bqo/l0qgvT+USU1pSdPuVxOBLFS+X6ePA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qhk5wDz0qVhmDlI9/pOghLRRZEzeBfNBF4EvQnz1VoQR7cq1shRLERn+2jvnidAGiHu7twQRLsROm/gCFlafFbmoJuVBgWtkQlF8CnW9y244hLIJUlhgfQtbojmGdzB/ZBcNd3bcj4OEAOjtI8EJZyGyDnpdrMYro3mLlCuyCTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fCDOyvXl; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709780487; x=1741316487;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jiLpUS83X9bqo/l0qgvT+USU1pSdPuVxOBLFS+X6ePA=;
  b=fCDOyvXlL/WGROeKSVZU+zfwvTjMPQj20a+QQxuRXE0mhSE8c/NKJcFA
   mzecJSERir0nLYNoSwnCvALgfxO2uVkzIm6o41s2p0w9aIpjWDSFYSMp0
   81oVg6YOIdT7xI8EcwVIBIvddf7uABK3HHeN3iJkw82Zx0uJ8ClZCu8E3
   Zv2gnXTMwTVCqtSGjl2tYjk/qnOUYin11VEAeePS/OxxR90CxtK7LMdpG
   QjoLCGfGWLbhWA5IL3Z7xfspxdnhf/DXnaPQfCbhT2Uq7j87/OX1FFN+L
   oQJKPdmtYYEE+sTL85QV6HJvWhO86U2rPE8GRYk7/MRznLmV2P/0lziRi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4289142"
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="4289142"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 19:01:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="14457352"
Received: from rulin.ccr.corp.intel.com (HELO [10.238.4.104]) ([10.238.4.104])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 19:01:13 -0800
Message-ID: <140860ab-59f2-4633-8a55-fb6cfa854250@intel.com>
Date: Thu, 7 Mar 2024 11:01:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] mm/vmalloc: Moved macros with no functional change
 happened
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>, Uladzislau Rezki <urezki@gmail.com>
Cc: akpm@linux-foundation.org, colin.king@intel.com, hch@infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, lstoakes@gmail.com,
 tianyou.li@intel.com, tim.c.chen@intel.com, wangyang.guo@intel.com,
 zhiguo.zhou@intel.com
References: <20240301155417.1852290-1-rulin.huang@intel.com>
 <20240301155417.1852290-2-rulin.huang@intel.com> <Zei9n-VMxtzG8z4Y@pc636>
 <ZekW/nGXfTqOlvPZ@MiWiFi-R3L-srv>
From: "Huang, Rulin" <rulin.huang@intel.com>
In-Reply-To: <ZekW/nGXfTqOlvPZ@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

We have made changes based on your latest suggestions.
1.Removed bugs_on.
2.Removed adjustion of macros.

We submitted patch v8 based on this. Thanks to Baoquan for the
discussion, and could you please help to review and confirm if there are
any problems on the latest version?

On 2024/3/7 9:23, Baoquan He wrote:
> On 03/06/24 at 08:01pm, Uladzislau Rezki wrote:
>> On Fri, Mar 01, 2024 at 10:54:16AM -0500, rulinhuang wrote:
> ......
>>
>> Sorry for the late answer, i also just noticed this email. It was not in
>> my inbox...
>>
>> OK, now you move part of the per-cpu allocator on the top and leave
>> another part down making it split. This is just for the:
>>
>> BUG_ON(va_flags & VMAP_RAM);
>>
>> VMAP_RAM macro. Do we really need this BUG_ON()?
> 
> Sorry, I suggested that when reviewing v5:
> https://lore.kernel.org/all/ZdiltpK5fUvwVWtD@MiWiFi-R3L-srv/T/#u
> 
> About part of per-cpu kva allocator moving and the split making, I would
> argue that we will have vmap_nodes defintion and basic helper functions
> like addr_to_node_id() etc at top, and leave other part like
> size_to_va_pool(), node_pool_add_va() etc down. These are similar.
> 
> While about whether we should add 'BUG_ON(va_flags & VMAP_RAM);', I am
> not sure about it. When I suggested that, I am also hesitant. From the
> current code, alloc_vmap_area() is called in below three functions, only
> __get_vm_area_node() will pass the non-NULL vm. 
>  new_vmap_block()     -|
>  vm_map_ram()         ----> alloc_vmap_area()
>  __get_vm_area_node() -|
> 
> It could be wrongly passed in the future? Only checking if vm is
> non-NULL makes me feel a little unsafe. While I am fine if removing the
> BUG_ON, because there's no worry in the current code. We can wait and
> see in the future.
> 
>        if (vm) {
>                BUG_ON(va_flags & VMAP_RAM);
>                setup_vmalloc_vm(vm, va, flags, caller);
>        }
> 
> Thanks
> Baoquan
> 

