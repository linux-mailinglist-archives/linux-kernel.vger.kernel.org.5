Return-Path: <linux-kernel+bounces-100938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FB8879FE0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73AC02835C6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6654AEC8;
	Tue, 12 Mar 2024 23:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TfT7iGv9"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CF5482CD
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 23:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710287579; cv=none; b=ABFFRTLB2hTSXwPaO10ne/67rgRrfKYtD7e6MDh95qz5DG+TAbVwlS/pxDk5ftzw8bK00Pi/SZu59rG0fv2oMQScOZzjLN6LSkVJglm0pl4SN0Xq221eA91GLsP2fn6IRhCCfubgTA8CVFYyIF7DvGW25YaeUpL9Hq7cMiUMLQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710287579; c=relaxed/simple;
	bh=BMo8O/lywSXbV853RJbbJt6gl1OA/tX3OHK5HDpfBaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X4phEMmd41TQ6kGGBVGyK8z8/V9/KHUVZbZOj2WxC7IaMQ6KXVNequ8fh0aq4G31ZO6Zj1hQRQZBmAQpeeEV/GS50CYj68J+qRhU6A73vHYKjEN+w4hj826QW/uyB1HEftOuWFGz6BS7SBTzSid2uOwyJNTh3R27Hm4gGLZORcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TfT7iGv9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42CNPnsf029449;
	Tue, 12 Mar 2024 23:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=fxzUnZ0nbYPzD6mGgMCor9l0aAH74e99rvLKk3Y5RPM=;
 b=TfT7iGv9qYnyvtsnURQU/864hfqaS0AJkr+AmNJZ6O2meRKneNGQw9eNslyCkckaejb2
 tCzZwRr2pv7pouBCZsRd2QyjmHvZ7HBZHe4RlWxNIn5wI0SKSGwfpgo/0vTBSCArrPWN
 Cd2eNOFST4Lbo2CrjHs9Nc+u+v7l2I97Z54YLyzn3iqJs0MU3LbiXZ8fguUCQr4Gc6K8
 Mo3bu5PNyMHP1w056IWOlX175WN9j7fS4Mocyfnm/jMZEdzjyLt6urgdtP38UkakWDS2
 RpRCveB3vG9/A/oIiF3Cjgl7njDotoNBOtEqT7WRVEQww/NnjbaPzGFEAQ5PBY2Q1ADf vg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtyv3rxev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 23:52:40 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42CNnhtU017491;
	Tue, 12 Mar 2024 23:52:39 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtyv3rxes-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 23:52:39 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42CLYt81020446;
	Tue, 12 Mar 2024 23:52:39 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ws3km28r2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 23:52:39 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42CNqZiH12779868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 23:52:37 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CBBF2004D;
	Tue, 12 Mar 2024 23:52:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAC8420040;
	Tue, 12 Mar 2024 23:52:34 +0000 (GMT)
Received: from heavy (unknown [9.171.20.188])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 12 Mar 2024 23:52:34 +0000 (GMT)
Date: Wed, 13 Mar 2024 00:52:33 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Changbin Du <changbin.du@huawei.com>, elver@google.com
Cc: Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] kmsan: instrumentation recursion problems
Message-ID: <ndf5znadjpm4mcscns66bhcgvvykmcou3kjkqy54fcvgtvu7th@vpaomrytk4af>
References: <20240308043448.masllzeqwht45d4j@M910t>
 <CANpmjNOc4Z6Qy_L3pjuW84BOxoiqXgLC1tWbJuZwRUZqs2ioMA@mail.gmail.com>
 <20240311093036.44txy57hvhevybsu@M910t>
 <20240311110223.nzsplk6a6lzxmzqi@M910t>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311110223.nzsplk6a6lzxmzqi@M910t>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XMoEI2_KLVggDytKVnGT_gt9PRMt-t9n
X-Proofpoint-ORIG-GUID: nFuB370a9GDq1Q2xV0HTmVpkEjO3Y1ND
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_14,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 clxscore=1011 impostorscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403120183

On Mon, Mar 11, 2024 at 07:02:23PM +0800, Changbin Du wrote:
> On Mon, Mar 11, 2024 at 05:30:36PM +0800, Changbin Du wrote:
> > On Fri, Mar 08, 2024 at 10:39:15AM +0100, Marco Elver wrote:
> > > On Fri, 8 Mar 2024 at 05:36, 'Changbin Du' via kasan-dev
> > > <kasan-dev@googlegroups.com> wrote:
> > > >
> > > > Hey, folks,
> > > > I found two instrumentation recursion issues on mainline kernel.
> > > >
> > > > 1. recur on preempt count.
> > > > __msan_metadata_ptr_for_load_4() -> kmsan_virt_addr_valid() -> preempt_disable() -> __msan_metadata_ptr_for_load_4()
> > > >
> > > > 2. recur in lockdep and rcu
> > > > __msan_metadata_ptr_for_load_4() -> kmsan_virt_addr_valid() -> pfn_valid() -> rcu_read_lock_sched() -> lock_acquire() -> rcu_is_watching() -> __msan_metadata_ptr_for_load_8()
> > > >
> > > >
> > > > Here is an unofficial fix, I don't know if it will generate false reports.
> > > >
> > > > $ git show
> > > > commit 7f0120b621c1cbb667822b0f7eb89f3c25868509 (HEAD -> master)
> > > > Author: Changbin Du <changbin.du@huawei.com>
> > > > Date:   Fri Mar 8 20:21:48 2024 +0800
> > > >
> > > >     kmsan: fix instrumentation recursions
> > > >
> > > >     Signed-off-by: Changbin Du <changbin.du@huawei.com>
> > > >
> > > > diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
> > > > index 0db4093d17b8..ea925731fa40 100644
> > > > --- a/kernel/locking/Makefile
> > > > +++ b/kernel/locking/Makefile
> > > > @@ -7,6 +7,7 @@ obj-y += mutex.o semaphore.o rwsem.o percpu-rwsem.o
> > > >
> > > >  # Avoid recursion lockdep -> sanitizer -> ... -> lockdep.
> > > >  KCSAN_SANITIZE_lockdep.o := n
> > > > +KMSAN_SANITIZE_lockdep.o := n
> > > 
> > > This does not result in false positives?
> > >
> This does result lots of false positives.
> 
> > I saw a lot of reports but seems not related to this.
> > 
> > [    2.742743][    T0] BUG: KMSAN: uninit-value in unwind_next_frame+0x3729/0x48a0
> > [    2.744404][    T0]  unwind_next_frame+0x3729/0x48a0
> > [    2.745623][    T0]  arch_stack_walk+0x1d9/0x2a0
> > [    2.746838][    T0]  stack_trace_save+0xb8/0x100
> > [    2.747928][    T0]  set_track_prepare+0x88/0x120
> > [    2.749095][    T0]  __alloc_object+0x602/0xbe0
> > [    2.750200][    T0]  __create_object+0x3f/0x4e0
> > [    2.751332][    T0]  pcpu_alloc+0x1e18/0x2b00
> > [    2.752401][    T0]  mm_init+0x688/0xb20
> > [    2.753436][    T0]  mm_alloc+0xf4/0x180
> > [    2.754510][    T0]  poking_init+0x50/0x500
> > [    2.755594][    T0]  start_kernel+0x3b0/0xbf0
> > [    2.756724][    T0]  __pfx_reserve_bios_regions+0x0/0x10
> > [    2.758073][    T0]  x86_64_start_kernel+0x92/0xa0
> > [    2.759320][    T0]  secondary_startup_64_no_verify+0x176/0x17b
> > 
> Above reports are triggered by KMEMLEAK and KFENCE.
> 
> Now with below fix, I was able to run kmsan kernel with:
>   CONFIG_DEBUG_KMEMLEAK=n
>   CONFIG_KFENCE=n
>   CONFIG_LOCKDEP=n
> 
> KMEMLEAK and KFENCE generate too many false positives in unwinding code.
> LOCKDEP still introduces instrumenting recursions.

FWIW I see the same issue on s390, and the best I could come up with so
far was also disabling lockdep.

For KFENCE I have the following [1] though, maybe this will be helpful
to you as well?

[1] https://patchwork.kernel.org/project/linux-mm/patch/20231213233605.661251-17-iii@linux.ibm.com/

[...]

