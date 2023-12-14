Return-Path: <linux-kernel+bounces-60-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4ED813B6C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78CF62835B4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCC16A03C;
	Thu, 14 Dec 2023 20:20:20 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA4765EAD
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 20:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.com
Received: by gentwo.org (Postfix, from userid 1003)
	id 2451240E8E; Thu, 14 Dec 2023 12:14:40 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 23BBB40E89;
	Thu, 14 Dec 2023 12:14:40 -0800 (PST)
Date: Thu, 14 Dec 2023 12:14:40 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@linux.com>
To: Matthew Wilcox <willy@infradead.org>
cc: Vlastimil Babka <vbabka@suse.cz>, Pekka Enberg <penberg@kernel.org>, 
    David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
    "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
    Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
    Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
    kasan-dev@googlegroups.com
Subject: Re: [PATCH RFC v3 0/9] SLUB percpu array caches and maple tree
 nodes
In-Reply-To: <ZWerDCdvVkAfsStz@casper.infradead.org>
Message-ID: <146558f5-9f5c-e65f-0177-5f736fe663cd@linux.com>
References: <20231129-slub-percpu-caches-v3-0-6bcf536772bc@suse.cz> <b51bfc04-d770-3385-736a-01aa733c4622@linux.com> <ZWerDCdvVkAfsStz@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 29 Nov 2023, Matthew Wilcox wrote:

>> In order to make the SLUB in page freelists work better you need to have
>> larger freelist and that comes with larger page sizes. I.e. boot with
>> slub_min_order=5 or so to increase performance.
>
> That comes with its own problems, of course.

Well I thought you were solving those with the folios?

>> Also this means increasing TLB pressure. The in page freelists of SLUB cause
>> objects from the same page be served. The SLAB queueing approach
>> results in objects being mixed from any address and thus neighboring objects
>> may require more TLB entries.
>
> Is that still a concern for modern CPUs?  We're using 1GB TLB entries
> these days, and there are usually thousands of TLB entries.  This feels
> like more of a concern for a 90s era CPU.

ARM kernel memory is mapped by 4K entries by default since rodata=full is 
the default. Security concerns screw it up.



