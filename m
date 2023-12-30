Return-Path: <linux-kernel+bounces-13387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7EF820450
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 11:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C4721C20CC7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 10:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8904A210A;
	Sat, 30 Dec 2023 10:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DpmXUBOg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A69463C4
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 10:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703932095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aX1O++zYx1k3/mNIX5UfYhS34dL4AjJIqDFQMzvM7pA=;
	b=DpmXUBOgl6EtQObEnSkfxYvgBEgdPp8uWzf+Ns5vqQi99pKq5hJl1Zc/ZbFQ/kO57f2qJk
	e9NQh2leRsDEkjIaNTCB8dPqh2BtTS0iJAGuvFulObPe+0dzMpvwilqnPldx4YZXtcW9ik
	2lBi3GuwTRqEH0y3AsKHGOWsLhcl5pQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-41-mWMzJCyJOcSEIdihBIHiBA-1; Sat,
 30 Dec 2023 05:28:11 -0500
X-MC-Unique: mWMzJCyJOcSEIdihBIHiBA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0E6529AA396;
	Sat, 30 Dec 2023 10:28:10 +0000 (UTC)
Received: from localhost (unknown [10.72.112.216])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B0C53C25;
	Sat, 30 Dec 2023 10:28:09 +0000 (UTC)
Date: Sat, 30 Dec 2023 18:28:06 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yuntao Wang <ytcoode@gmail.com>, bp@alien8.de,
	dave.hansen@linux.intel.com, dyoung@redhat.com,
	hbathini@linux.ibm.com, hpa@zytor.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, mingo@redhat.com, seanjc@google.com,
	tglx@linutronix.de, tiwai@suse.de, vgoyal@redhat.com,
	x86@kernel.org
Subject: Re: [PATCH] crash_core: optimize crash_exclude_mem_range()
Message-ID: <ZY/wtvltzGR0CokV@MiWiFi-R3L-srv>
References: <20231218092902.9fae480cfcad3874e9e7236f@linux-foundation.org>
 <20231219163418.108591-1-ytcoode@gmail.com>
 <20231229121014.fd090f8c616a34fbb45f7843@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231229121014.fd090f8c616a34fbb45f7843@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 12/29/23 at 12:10pm, Andrew Morton wrote:
> On Wed, 20 Dec 2023 00:34:18 +0800 Yuntao Wang <ytcoode@gmail.com> wrote:
> 
> > Because memory ranges in mem->ranges are stored in ascending order, when we
> > detect `p_end < start`, we can break the for loop early, as the subsequent
> > memory ranges must also be outside the range we are looking for.
> > 
> > Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> > ---
> > Hi Andrew,
> > 
> > Patch "[PATCH 2/2] crash_core: fix out-of-bounds access check in
> > crash_exclude_mem_range()" can be ignored, use this patch instead.
> > 
> 
> Some reviewer input on this would be helpful please?


I suggested this in below discussion thread:
https://lore.kernel.org/all/ZYEOshALGbDKwSdc@MiWiFi-R3L-srv/T/#u

So it would be good if squashing this into patch 3 of another patch
thread you are asking:
[PATCH 3/3] crash_core: fix and simplify the logic of crash_exclude_mem_range()

And I would suggest withdrawing Yuntao's below patch on your
mm-nonmm-unstable branch.

961c69e9f1bf x86/crash: fix potential cmem->ranges array overflow

Becase there's better one to fix the potential oob from fuqiang,
although fuqiang need improve his patch log.

[PATCH v3] x86/kexec: fix potential cmem->ranges out of bounds
https://lore.kernel.org/all/20231222121855.148215-1-fuqiang.wang@easystack.cn/T/#u

> 
> > --- a/kernel/crash_core.c
> > +++ b/kernel/crash_core.c
> > @@ -575,9 +575,12 @@ int crash_exclude_mem_range(struct crash_mem *mem,
> >  		p_start = mstart;
> >  		p_end = mend;
> >  
> > -		if (p_start > end || p_end < start)
> > +		if (p_start > end)
> >  			continue;
> >  
> > +		if (p_end < start)
> > +			break;
> > +
> >  		/* Truncate any area outside of range */
> >  		if (p_start < start)
> >  			p_start = start;
> > -- 
> > 2.43.0
> 


