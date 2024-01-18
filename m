Return-Path: <linux-kernel+bounces-29745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 340B78312D8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 595B11C2183C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 06:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF54944D;
	Thu, 18 Jan 2024 06:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N/LbTHaZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C9613ADC;
	Thu, 18 Jan 2024 06:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705560453; cv=none; b=Cbt7KzN/U/SyAxYWctm6jdwoouhowrNBjr+4ssdWRnHsVEm/8VaVvE8N1zi4AYy3vdX8kiJIez/iaHSLwc22Qgio27VHrZF+wFceJGnTuH5NIZtS5FBDblreduX0/oyYsagFhIzR1+PTLskeE2jNXkCEcYFQqC/YWhwSEVYfwwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705560453; c=relaxed/simple;
	bh=SWREub8VuUlUODzLU8q34Rk02UcISqoTmL/dacBll1w=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=VepQrOjAJ8o+VjGHuBPCmYsSkwNMFW3bhwKpic8bkxAzEg/BjqG14Uowe307xM1XJ+cdJitJGJrGDdOAYN1SKMCjvuI6/tP1dZ/aGlnBvO7/xIrlnhVdk7B05WYbVeMDbWvA8lisblEhAshv0TRiQ/k6HV/3Q/PXTuwHgq6dmak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N/LbTHaZ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705560451; x=1737096451;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SWREub8VuUlUODzLU8q34Rk02UcISqoTmL/dacBll1w=;
  b=N/LbTHaZlIWfykiqKBRdeyxs9o2Cim/HB1T0CHN3ErxZ/gEMikhg5O34
   VzIUQcD7tCwq0VHGcHGjYnBAXiWQo6kiHL9/PAQsDxaBfcy8ho1qlKpbO
   /EeWu1cAIQqK9vE+5aqPjVChS3G3zdTJh00ifYtbP22Xl4XP5Q4nMNAbM
   aU0EiKKOE1W+qgzWDZ5E9wuU51ObzubHPl9z9osCD087VBedsuq4eM9g1
   ptPc42B6p18n4DToj+TjecPfoy5e8EFXUip3xoT1SZTFdSlJ1uNPtizcD
   CJUV50FONS2GpyYxpF7qA2h6O3xbsSiFYSvQqfAqoRWzD3eCmfTWFrFBh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="7459413"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="7459413"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 22:47:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="204921"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 17 Jan 2024 22:47:22 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rQMBL-0002jI-0y;
	Thu, 18 Jan 2024 06:47:19 +0000
Date: Thu, 18 Jan 2024 14:46:57 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Graf <graf@amazon.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, x86@kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	James Gowans <jgowans@amazon.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	arnd@arndb.de, pbonzini@redhat.com, madvenka@linux.microsoft.com,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Usama Arif <usama.arif@bytedance.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 13/17] tracing: Recover trace buffers from kexec
 handover
Message-ID: <202401181457.dzB2femp-lkp@intel.com>
References: <20240117144704.602-14-graf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117144704.602-14-graf@amazon.com>

Hi Alexander,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[cannot apply to tip/x86/core arm64/for-next/core akpm-mm/mm-everything v6.7 next-20240117]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Graf/mm-memblock-Add-support-for-scratch-memory/20240117-225136
base:   linus/master
patch link:    https://lore.kernel.org/r/20240117144704.602-14-graf%40amazon.com
patch subject: [PATCH v3 13/17] tracing: Recover trace buffers from kexec handover
config: arc-defconfig (https://download.01.org/0day-ci/archive/20240118/202401181457.dzB2femp-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240118/202401181457.dzB2femp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401181457.dzB2femp-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/trace/ring_buffer.c: In function 'rb_kho_replace_buffers':
>> kernel/trace/ring_buffer.c:5936:66: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    5936 |                         cpu_buffer->head_page->list.prev->next = (struct list_head *)
         |                                                                  ^
   kernel/trace/ring_buffer.c:5939:44: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    5939 |                         bpage->list.next = (struct list_head *)((ulong)new_lhead | rb_page_head);
         |                                            ^
--
>> kernel/trace/ring_buffer.c:1783: warning: Function parameter or struct member 'tr_off' not described in '__ring_buffer_alloc'


vim +5936 kernel/trace/ring_buffer.c

  5896	
  5897	static int rb_kho_replace_buffers(struct ring_buffer_per_cpu *cpu_buffer,
  5898					     struct rb_kho_cpu *kho)
  5899	{
  5900		bool first_loop = true;
  5901		struct list_head *tmp;
  5902		int err = 0;
  5903		int i = 0;
  5904	
  5905		if (!IS_ENABLED(CONFIG_FTRACE_KHO))
  5906			return -EINVAL;
  5907	
  5908		if (kho->nr_mems != cpu_buffer->nr_pages * 2)
  5909			return -EINVAL;
  5910	
  5911		for (tmp = rb_list_head(cpu_buffer->pages);
  5912		     tmp != rb_list_head(cpu_buffer->pages) || first_loop;
  5913		     tmp = rb_list_head(tmp->next), first_loop = false) {
  5914			struct buffer_page *bpage = (struct buffer_page *)tmp;
  5915			const struct kho_mem *mem_bpage = &kho->mem[i++];
  5916			const struct kho_mem *mem_page = &kho->mem[i++];
  5917			const uint64_t rb_page_head = 1;
  5918			struct buffer_page *old_bpage;
  5919			void *old_page;
  5920	
  5921			old_bpage = __va(mem_bpage->addr);
  5922			if (!bpage)
  5923				goto out;
  5924	
  5925			if ((ulong)old_bpage->list.next & rb_page_head) {
  5926				struct list_head *new_lhead;
  5927				struct buffer_page *new_head;
  5928	
  5929				new_lhead = rb_list_head(bpage->list.next);
  5930				new_head = (struct buffer_page *)new_lhead;
  5931	
  5932				/* Assume the buffer is completely full */
  5933				cpu_buffer->tail_page = bpage;
  5934				cpu_buffer->commit_page = bpage;
  5935				/* Set the head pointers to what they were before */
> 5936				cpu_buffer->head_page->list.prev->next = (struct list_head *)
  5937					((ulong)cpu_buffer->head_page->list.prev->next & ~rb_page_head);
  5938				cpu_buffer->head_page = new_head;
  5939				bpage->list.next = (struct list_head *)((ulong)new_lhead | rb_page_head);
  5940			}
  5941	
  5942			if (rb_page_entries(old_bpage) || rb_page_write(old_bpage)) {
  5943				/*
  5944				 * We want to recycle the pre-kho page, it contains
  5945				 * trace data. To do so, we unreserve it and swap the
  5946				 * current data page with the pre-kho one
  5947				 */
  5948				old_page = kho_claim_mem(mem_page);
  5949	
  5950				/* Recycle the old page, it contains data */
  5951				free_page((ulong)bpage->page);
  5952				bpage->page = old_page;
  5953	
  5954				bpage->write = old_bpage->write;
  5955				bpage->entries = old_bpage->entries;
  5956				bpage->real_end = old_bpage->real_end;
  5957	
  5958				local_inc(&cpu_buffer->pages_touched);
  5959			} else {
  5960				kho_return_mem(mem_page);
  5961			}
  5962	
  5963			kho_return_mem(mem_bpage);
  5964		}
  5965	
  5966	out:
  5967		return err;
  5968	}
  5969	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

