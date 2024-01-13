Return-Path: <linux-kernel+bounces-25230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6E282CABE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 10:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA271B212A3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 09:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE53A38;
	Sat, 13 Jan 2024 09:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="knCctoyh"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329367E6
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 09:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705137579; x=1736673579;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=40I2MKqfAkOFazQVYRT6HU5athsSbMattEgJmLpYaKc=;
  b=knCctoyh1eLkMUoODXFbf47yFo+qngct38UePtpthriAfQAMLeayQW3c
   bJgTZM1I0rnyCnHvEmKdNnXyHpk5AHiPcFu46/UeC2fA4Iz43uKm7c9eB
   WVMpvv+f9dX+faphuExSIsGkAKrnUlP9E+fDQupqCmTpiF4HB/DiZqyo0
   VNl8Yd4v8723L1nEWBctdH/bMQvy+InJ0vQClvI2zD8Ujm/eBhq+7uBCT
   uKeHpjh3Zv/oW1ht/c70BOxMI+cuhbRw3YBT2bKRAA2dHBdrl6H1ltYG+
   WtEKbYhklwrYIVzC58KjKuTszY7KmYt6e+49kgQzfTx9hWseGjjsOI7r3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="403130394"
X-IronPort-AV: E=Sophos;i="6.04,192,1695711600"; 
   d="scan'208";a="403130394"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2024 01:19:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="853513285"
X-IronPort-AV: E=Sophos;i="6.04,192,1695711600"; 
   d="scan'208";a="853513285"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2024 01:19:37 -0800
Date: Sat, 13 Jan 2024 01:19:36 -0800
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
Message-ID: <ZaJVqF-_fJ_O3pJK@tassilo>
References: <ZZUlgs69iTTlG8Lh@localhost.localdomain>
 <87sf34lrn3.fsf@linux.intel.com>
 <CANpmjNNdWwGsD3JRcEqpq_ywwDFoxsBjz6n=6vL5YksNsPyqHw@mail.gmail.com>
 <ZZ_gssjTCyoWjjhP@tassilo>
 <ZaA8oQG-stLAVTbM@elver.google.com>
 <CA+fCnZeS=OrqSK4QVUVdS6PwzGrpg8CBj8i2Uq=VMgMcNg1FYw@mail.gmail.com>
 <CANpmjNOoidtyeQ76274SWtTYR4zZPdr1DnxhLaagHGXcKwPOhA@mail.gmail.com>
 <ZaG56XTDwPfkqkJb@elver.google.com>
 <ZaHmQU5DouedI9kS@tassilo>
 <CANpmjNO-q4pjS4z=W8xVLHTs72FNq+TR+-=QBmkP=HOQy6UHmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNO-q4pjS4z=W8xVLHTs72FNq+TR+-=QBmkP=HOQy6UHmg@mail.gmail.com>

On Sat, Jan 13, 2024 at 10:12:21AM +0100, Marco Elver wrote:
> On Sat, 13 Jan 2024 at 02:24, Andi Kleen <ak@linux.intel.com> wrote:
> >
> > On Fri, Jan 12, 2024 at 11:15:05PM +0100, Marco Elver wrote:
> > > +             /*
> > > +              * Stack traces of size 0 are never saved, and we can simply use
> > > +              * the size field as an indicator if this is a new unused stack
> > > +              * record in the freelist.
> > > +              */
> > > +             stack->size = 0;
> >
> > I would use WRITE_ONCE here too, at least for TSan.
> 
> This is written with the pool_lock held.

..which doesn't help because the readers don't take it?

-Andi

