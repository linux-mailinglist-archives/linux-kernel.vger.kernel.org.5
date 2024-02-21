Return-Path: <linux-kernel+bounces-75296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CBA85E604
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5823284AC6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B7985654;
	Wed, 21 Feb 2024 18:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sbJ6zd2J"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A9784FD8
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 18:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708540243; cv=none; b=B9v7SYNCJw/2jCOIbciKwKcTvLJsVcKI+NJUCxT1CtHhFgrY992oiDbIeEcEVIFKVXzpu0nlT0IaVtBAYoCN1Y00lIU6YOGpGYKlrqSRXDbiyBL0dDvSSyICcH2T5KptmDMdykOn0xA9SDaDE17uD9iPzierN8DXrlDg/y3kh1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708540243; c=relaxed/simple;
	bh=onB+abJjruTzzbHbLA8gv0zsFd+P1U9flFiiaAQhMrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uen6bmc3e3duoMxj9HDfPcfAeGO2iXBkU9jaL6nB9CY9qJtTeDqbTXV5SLcXLJiLwQv2S5vxcN5QFzq365FlIFVTkYwC+RJa1PO9ZANyesSGyJ00zxk6gD2GNCxAt9empO3c6bx05q+ivuoILsjXO+OrnqZWRs2+z36Fn4HB4iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sbJ6zd2J; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 21 Feb 2024 10:30:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708540238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FekxhxYh2M8PuEvR0875ALSaW6smsNFC8mdylkThqb8=;
	b=sbJ6zd2Jm8KIsuk2mP1lBhRM34SywZap4g2+mC7W5O97siHcv0PiA/Myf6zP+eU/rVFq37
	nBzzsWlzYuNO7uNWrnvKqIPEvu4EAn/RmO1lNnCts5EmhsayT6xy4nihRI5CcL+5TWrSQd
	Z2hYtSHSWp4hkaxqp9Aya4cKeT5Lay0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Zheng Yejian <zhengyejian1@huawei.com>,
	Xiongwei Song <xiongwei.song@windriver.com>,
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/3] mm, slab: deprecate SLAB_MEM_SPREAD flag
Message-ID: <ZdZBN_K8yJTVIbtC@P9FQF9L96D.corp.robot.car>
References: <20240220-slab-cleanup-flags-v1-0-e657e373944a@suse.cz>
 <20240220-slab-cleanup-flags-v1-1-e657e373944a@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220-slab-cleanup-flags-v1-1-e657e373944a@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 20, 2024 at 05:58:25PM +0100, Vlastimil Babka wrote:
0;95;0c> The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
> removed.  SLUB instead relies on the page allocator's NUMA policies.
> Change the flag's value to 0 to free up the value it had, and mark it
> for full removal once all users are gone.
> 
> Reported-by: Steven Rostedt <rostedt@goodmis.org>
> Closes: https://lore.kernel.org/all/20240131172027.10f64405@gandalf.local.home/
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Do you plan to follow up with a patch series removing all usages?

Thanks!

