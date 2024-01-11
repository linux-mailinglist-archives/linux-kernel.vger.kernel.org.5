Return-Path: <linux-kernel+bounces-23592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C854A82AED2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CFB41F24702
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C178015AD9;
	Thu, 11 Jan 2024 12:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="At+n92TL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD8615ACE
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 12:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704976565; x=1736512565;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YtXDiIvWUWaP/lYh1Up7SkxhhppURJh5x5MViBxRt1Q=;
  b=At+n92TLwADh5Ah2lpBAMGsQh9Wvj56/VnTkHbtv5f+vVZwdcKF2LYSe
   2X2BV0rfHQh1tzO/r2EWYD5qJK8HsPecnz15weNhPO3nf902xhzwNdo66
   AF0iIIeiGpIMT8GyZtf55QgcIApvS6/1abab5UpIY7Am2b0LCuqL7WoAW
   /4r64nuisAw5pBuRJj/27mmvgz1SiF34ZvZVCnSF2f5mOkLoxYG9Lya4f
   yt+2k0vdkOTuk0ulmbTPrHHxh19HEibbwOW49lgcY6VdxuRmc6ABIYdEN
   4cUUtwgOCEQAIdBefmTJMao8aVZ6RkKPAQSlTxz9QeUzSy3fPkeygFzKv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="5561813"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="5561813"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 04:36:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="926000150"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="926000150"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 04:36:04 -0800
Date: Thu, 11 Jan 2024 04:36:02 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Marco Elver <elver@google.com>
Cc: Oscar Salvador <osalvador@suse.de>, andrey.konovalov@linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
	Evgenii Stepanov <eugenis@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v4 12/22] lib/stackdepot: use read/write lock
Message-ID: <ZZ_gssjTCyoWjjhP@tassilo>
References: <cover.1700502145.git.andreyknvl@google.com>
 <9f81ffcc4bb422ebb6326a65a770bf1918634cbb.1700502145.git.andreyknvl@google.com>
 <ZZUlgs69iTTlG8Lh@localhost.localdomain>
 <87sf34lrn3.fsf@linux.intel.com>
 <CANpmjNNdWwGsD3JRcEqpq_ywwDFoxsBjz6n=6vL5YksNsPyqHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNdWwGsD3JRcEqpq_ywwDFoxsBjz6n=6vL5YksNsPyqHw@mail.gmail.com>

> stackdepot is severely limited in what kernel facilities it may use
> due to being used by such low level facilities as the allocator
> itself.

RCU can be done quite low level too (e.g. there is NMI safe RCU)

> 
> I've been suggesting percpu-rwsem here, but looking at it in more
> detail that doesn't work because percpu-rwsem wants to sleep, but
> stackdepot must work in non-sleepable contexts. :-/

Yes something per CPU would work too I suppose. We used to have
big reader spinlocks for this. 

-Andi

