Return-Path: <linux-kernel+bounces-25237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 172D582CAD0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 10:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C93B01F210A8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 09:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE72BD30E;
	Sat, 13 Jan 2024 09:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W8NCNXA4"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A553C63C3
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 09:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705138270; x=1736674270;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SjTM9ZlVdC+zj2d9f7k7IlQgeOjiVf2LBGRGd/ifRbk=;
  b=W8NCNXA4TU5t2pLwkBNUXTYgZO2qkYVhzL2k5LYXoRYzGoMLkodETBjg
   CvRBv5i9cyte+wMY4HKOxsHIFnO6Jw4A8sXAx+aOhgptoVP6apjP64n5a
   X4+QJvtESYU93gvY3CX1Zwcc4tmLEa7TjpCYKhSknVOCANiOMjn5M/1qb
   R91EIaFBYQYei/eTGzJmZUEoRuMPF01K10lPzLsepKTRxEvAyroCFQ9J7
   M1hJ9rD8Syy6twBB3K13PnIUkJ7neijIO1K91HPQE2Q4wEEsePDw+TPHz
   ca+uSOGEddxCc+gnxOFd6w95jt2YDzlOw7y83Dmn05dPtDR9in2wMUCxV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="463646410"
X-IronPort-AV: E=Sophos;i="6.04,192,1695711600"; 
   d="scan'208";a="463646410"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2024 01:31:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="956337463"
X-IronPort-AV: E=Sophos;i="6.04,192,1695711600"; 
   d="scan'208";a="956337463"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2024 01:31:09 -0800
Date: Sat, 13 Jan 2024 01:31:08 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Marco Elver <elver@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Oscar Salvador <osalvador@suse.de>, andrey.konovalov@linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
	Evgenii Stepanov <eugenis@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v4 12/22] lib/stackdepot: use read/write lock
Message-ID: <ZaJYXCVKA_pDqLqn@tassilo>
References: <CANpmjNNdWwGsD3JRcEqpq_ywwDFoxsBjz6n=6vL5YksNsPyqHw@mail.gmail.com>
 <ZZ_gssjTCyoWjjhP@tassilo>
 <ZaA8oQG-stLAVTbM@elver.google.com>
 <CA+fCnZeS=OrqSK4QVUVdS6PwzGrpg8CBj8i2Uq=VMgMcNg1FYw@mail.gmail.com>
 <CANpmjNOoidtyeQ76274SWtTYR4zZPdr1DnxhLaagHGXcKwPOhA@mail.gmail.com>
 <ZaG56XTDwPfkqkJb@elver.google.com>
 <ZaHmQU5DouedI9kS@tassilo>
 <CANpmjNO-q4pjS4z=W8xVLHTs72FNq+TR+-=QBmkP=HOQy6UHmg@mail.gmail.com>
 <ZaJVqF-_fJ_O3pJK@tassilo>
 <CANpmjNOz7tBMK-HoyZNVR2KcgxEBY1Qym=DRa9gHLFkaNHLmVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOz7tBMK-HoyZNVR2KcgxEBY1Qym=DRa9gHLFkaNHLmVw@mail.gmail.com>

> This function is only refilling the freelist. Readers don't see it yet
> because it's in none of the hash table buckets. The freelist is only
> ever accessed under the lock.
> 
> Once an entry is allocated from the freelist, its size is overwritten
> with something non-zero (since it then contains a stack trace). Those
> updates are released into the right hash table bucket with
> list_add_rcu() (which implies a release).
> 
> Am I missing something else?

It's probably ok semantically here, but at least I would be consistent with
using the macro for a specific field.

-Andi

