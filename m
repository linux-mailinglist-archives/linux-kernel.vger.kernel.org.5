Return-Path: <linux-kernel+bounces-116759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9D088A709
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14A33B22A0E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988A276058;
	Mon, 25 Mar 2024 10:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gDPgmlkW"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E0476045;
	Mon, 25 Mar 2024 09:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711359639; cv=none; b=X6CGTfOOCWoGZgISgGzg+G8d38DoYtWl2WtDOR3HmWZ4D9Q6xVeqwtNw3LqKKQffUkUOvlFEsQVg7MXKgoso5yHD0NXiAPTILmow/6JpvDlMuBHKtZDPmyO2NAUnWuHeDpXvBcyYKFoSt8V0/6+ktkvxHHDm5jjX+y6xwENeCLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711359639; c=relaxed/simple;
	bh=XTa/O56XTWdw5ZF7TMRdkm4wmKncpZtw2pKiTC9UVyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLRssnuxrUn2ztRUW3TCQ6jt/WYsKntAzT6rXudUinU6w8UGERjXB+wRGEQ3z2tlgBVQ4e0G3MwSDo8cBZVnlPxYqH43VxpedtwGRyPnPsSdrfy5aaViolQJ5ZQ+LyB5twhJ7/uilJT7zmeA2eCLoVbAoIY4lSmSxk+e0MSvfnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gDPgmlkW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42P5ua6K001614;
	Mon, 25 Mar 2024 09:40:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=lbLk1l291cRpU9S2Tsbm27SJWoB+hUfjrtZd/Xy3feI=;
 b=gDPgmlkWNRs6tmUokyl+eLPZ0a2jRGDPaWEEPatE9xDpYmhLwmeEuPJ1lppcoBxVhEaB
 wPz3wtBJO2JsB0dmBs28JVcK1mPiA3DbjynMs1X0bzbVIpDxNgVGxUXcEVyI0OEJgi4E
 YCKrGTZt/qNVKGaGZ1rC4DdOmda7pdYXQ0X9idpnSR0ECD7Tf3Ga9ct+FPlUI6EidrTM
 cZ8By8BlnJL9udeRRtbMHX5MsaV6yEH6x+aEZOOHLAZ4eh7lQOXE4qx13hWvi2GI7AVg
 RqI6eC0ycdgh3Cb2+ghPwJxoSggmdzmfMtOGmTT37DZ1Dofn9kNTajYm4sCkJaRuAXXU 0g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x2hh69x12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 09:40:08 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42P9ZRcQ008400;
	Mon, 25 Mar 2024 09:40:08 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x2hh69x0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 09:40:07 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42P7Zx2Y016410;
	Mon, 25 Mar 2024 09:40:07 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x29dtrhms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 09:40:06 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42P9e1KP22544922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 09:40:03 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C6872004E;
	Mon, 25 Mar 2024 09:40:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CED8520040;
	Mon, 25 Mar 2024 09:40:00 +0000 (GMT)
Received: from osiris (unknown [9.171.70.91])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 25 Mar 2024 09:40:00 +0000 (GMT)
Date: Mon, 25 Mar 2024 10:39:59 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>, Guenter Roeck <linux@roeck-us.net>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/1] mm: vmalloc: Bail out early in find_vmap_area() if
 vmap is not init
Message-ID: <20240325093959.9453-B-hca@linux.ibm.com>
References: <20240323141544.4150-1-urezki@gmail.com>
 <ZgC38GfEZYpYGUU9@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgC38GfEZYpYGUU9@infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _9711NiWy7-EsEOQcdt74z12AqRCg_ZC
X-Proofpoint-GUID: cWCtJLwizTW0fQFZ-RczZfodSfAwtBtC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_07,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=778 spamscore=0
 phishscore=0 clxscore=1011 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403250052

On Sun, Mar 24, 2024 at 04:32:00PM -0700, Christoph Hellwig wrote:
> On Sat, Mar 23, 2024 at 03:15:44PM +0100, Uladzislau Rezki (Sony) wrote:
> > During the boot the s390 system triggers "spinlock bad magic" messages
> > if the spinlock debugging is enabled:
> > 
> > [    0.465445] BUG: spinlock bad magic on CPU#0, swapper/0
> > [    0.465490]  lock: single+0x1860/0x1958, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
> > [    0.466067] CPU: 0 PID: 0 Comm: swapper Not tainted 6.8.0-12955-g8e938e398669 #1
> > [    0.466188] Hardware name: QEMU 8561 QEMU (KVM/Linux)
> > [    0.466270] Call Trace:
> > [    0.466470]  [<00000000011f26c8>] dump_stack_lvl+0x98/0xd8
> > [    0.466516]  [<00000000001dcc6a>] do_raw_spin_lock+0x8a/0x108
> > [    0.466545]  [<000000000042146c>] find_vmap_area+0x6c/0x108
> > [    0.466572]  [<000000000042175a>] find_vm_area+0x22/0x40
> > [    0.466597]  [<000000000012f152>] __set_memory+0x132/0x150
> > [    0.466624]  [<0000000001cc0398>] vmem_map_init+0x40/0x118
> > [    0.466651]  [<0000000001cc0092>] paging_init+0x22/0x68
> > [    0.466677]  [<0000000001cbbed2>] setup_arch+0x52a/0x708
> > [    0.466702]  [<0000000001cb6140>] start_kernel+0x80/0x5c8
> > [    0.466727]  [<0000000000100036>] startup_continue+0x36/0x40
..
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 22aa63f4ef63..0d77d171b5d9 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -2343,6 +2343,9 @@ struct vmap_area *find_vmap_area(unsigned long addr)
> >  	struct vmap_area *va;
> >  	int i, j;
> >  
> > +	if (unlikely(!vmap_initialized))
> > +		return NULL;
> > +
>
> I guess this is ok as an urgend bandaid to get s390 booting again,
> but calling find_vmap_area before the vmap area is initialized
> seems an actual issue in the s390 mm init code.
> 
> Adding the s390 maintainers to see if they have and idea how this could
> get fixed in a better way.

I'm going to push the patch below to the s390 git tree later. This is not a
piece of art, but I wanted to avoid to externalize vmalloc's vmap_initialized,
or come up with some s390 specific change_page_attr_alias_early() variant where
sooner or later nobody remembers what "early" means.

So this seems to be "good enough".

From 0308cd304fa3b01904c6060e2115234101811e48 Mon Sep 17 00:00:00 2001
From: Heiko Carstens <hca@linux.ibm.com>
Date: Thu, 21 Mar 2024 09:41:20 +0100
Subject: [PATCH] s390/mm,pageattr: avoid early calls into vmalloc code

The vmalloc code got changed and doesn't have the global statically
initialized vmap_area_lock spinlock anymore. This leads to the following
lockdep splat when find_vm_area() is called before the vmalloc code is
initialized:

BUG: spinlock bad magic on CPU#0, swapper/0
 lock: single+0x1868/0x1978, .magic: 00000000, .owner: swapper/0, .owner_cpu: 0

CPU: 0 PID: 0 Comm: swapper Not tainted 6.8.0-11767-g23956900041d #1
Hardware name: IBM 3931 A01 701 (KVM/Linux)
Call Trace:
 [<00000000010d840a>] dump_stack_lvl+0xba/0x148
 [<00000000001fdf5c>] do_raw_spin_unlock+0x7c/0xd0
 [<000000000111d848>] _raw_spin_unlock+0x38/0x68
 [<0000000000485830>] find_vmap_area+0xb0/0x108
 [<0000000000485ada>] find_vm_area+0x22/0x40
 [<0000000000132bbc>] __set_memory+0xbc/0x140
 [<0000000001a7f048>] vmem_map_init+0x40/0x158
 [<0000000001a7edc8>] paging_init+0x28/0x80
 [<0000000001a7a6e2>] setup_arch+0x4b2/0x6d8
 [<0000000001a74438>] start_kernel+0x98/0x4b0
 [<0000000000100036>] startup_continue+0x36/0x40
INFO: lockdep is turned off.

Add a slab_is_available() check to change_page_attr_alias() in order to
avoid early calls into vmalloc code. slab_is_available() is not exactly
what is needed, but there is currently no other way to tell if the vmalloc
code is initialized or not, and there is no reason to expose
e.g. vmap_initialized from vmalloc to achieve the same.

The fixes tag does not mean that the referenced commit is broken, but that
there is a dependency to this commit if the vmalloc commit should be
backported.

Fixes: d093602919ad ("mm: vmalloc: remove global vmap_area_root rb-tree")
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/mm/pageattr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/s390/mm/pageattr.c b/arch/s390/mm/pageattr.c
index 01bc8fad64d6..b6c6453d66e2 100644
--- a/arch/s390/mm/pageattr.c
+++ b/arch/s390/mm/pageattr.c
@@ -344,6 +344,9 @@ static int change_page_attr_alias(unsigned long addr, unsigned long end,
 	struct vm_struct *area;
 	int rc = 0;
 
+	/* Avoid early calls into not initialized vmalloc code. */
+	if (!slab_is_available())
+		return 0;
 	/*
 	 * Changes to read-only permissions on kernel VA mappings are also
 	 * applied to the kernel direct mapping. Execute permissions are
-- 
2.40.1


