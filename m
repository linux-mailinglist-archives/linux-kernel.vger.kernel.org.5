Return-Path: <linux-kernel+bounces-116767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6529588A3AF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 961631C350CE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991AD146A97;
	Mon, 25 Mar 2024 10:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d5QAGzkc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFB282D68
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711360124; cv=none; b=CDDEWYXmNB8mHjfteCr0H6goG8eJGfnt1SruXGuG+bYmG+KSOHlBLVrHEbOGSL9z/KT4foQ3TzU7erJOGj4vVZOFyMzx1e5ipdJVpf1kMgLSN6UGe0e0zARrlRCgoUtsneE3MjkPINFGqoV9DQEDWIMGbZ/88NRx808Gm2xyAPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711360124; c=relaxed/simple;
	bh=z7nQ+fuXBBJwghbwTKA/0pe69mO2YVrSsG63TX2xrh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eR49JOdsBC4zbNIbLmZtgsncyjOnc+Ym3TRzCM7JKXWYjJOy6AEdVw3j1eeqfvON+Rq0Kqamg+vgxHBMM9ZiWUp7faYu0sjKALb/sBAqR5A+3mxdUG2BKTRnRjkadErdSL+Uyj08OHzEvDnVRulJHVrM5X3pqMwUxyn44R0asBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d5QAGzkc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711360121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BzvHsR0swPhNezye8rUpRIe+AmkradciiszFVdBH2qI=;
	b=d5QAGzkcFVgfNPW1CO0oLPlhmxGApS7hScJ1cLqq6shPh9CB1aGymZAPlr5DzlZwPD5+xp
	Gq5w9Iph9qjmesRKdP5Xe57/g8T80D7rcjalpl3kRP7o2ljlY/77P9AcXHokfr03tzhcfG
	PdcgfvMh0EcJg3d8jU5382ubAFA9ES8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-sGBrjBOZPjWGzkRUL_JyGQ-1; Mon,
 25 Mar 2024 05:48:36 -0400
X-MC-Unique: sGBrjBOZPjWGzkRUL_JyGQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B0273C0BE29;
	Mon, 25 Mar 2024 09:48:35 +0000 (UTC)
Received: from localhost (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4782E112131D;
	Mon, 25 Mar 2024 09:48:25 +0000 (UTC)
Date: Mon, 25 Mar 2024 17:48:18 +0800
From: Baoquan He <bhe@redhat.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
	loongarch@lists.linux.dev, akpm@linux-foundation.org,
	ebiederm@xmission.com, hbathini@linux.ibm.com, piliu@redhat.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH linux-next v3 02/14] crash: split vmcoreinfo exporting
 code out from crash_core.c
Message-ID: <ZgFIYuYULrgF1tFG@MiWiFi-R3L-srv>
References: <20240124051254.67105-1-bhe@redhat.com>
 <20240124051254.67105-3-bhe@redhat.com>
 <CAMuHMdVxKEGYj9C1=P-493vcrN_HmLNx8gS6i1nheXO9gH46oA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdVxKEGYj9C1=P-493vcrN_HmLNx8gS6i1nheXO9gH46oA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 03/25/24 at 09:24am, Geert Uytterhoeven wrote:
> Hi Baoquan,
> 
> On Wed, Jan 24, 2024 at 6:13 AM Baoquan He <bhe@redhat.com> wrote:
> > Now move the relevant codes into separate files:
> > kernel/crash_reserve.c, include/linux/crash_reserve.h.
> >
> > And add config item CRASH_RESERVE to control its enabling.
> >
> > And also update the old ifdeffery of CONFIG_CRASH_CORE, including of
> > <linux/crash_core.h> and config item dependency on CRASH_CORE
> > accordingly.
> >
> > And also do renaming as follows:
> >  - arch/xxx/kernel/{crash_core.c => vmcore_info.c}
> > because they are only related to vmcoreinfo exporting on x86, arm64,
> > riscv.
> >
> > And also Remove config item CRASH_CORE, and rely on CONFIG_KEXEC_CORE to
> > decide if build in crash_core.c.
> >
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> > v2->v3:
> > - There's conflict when rebasing to linux-next in kernel/crash_core.c
> >   because of below commits from Uladzislau:
> >   commit 699d9351822e ("mm: vmalloc: Fix a warning in the crash_save_vmcoreinfo_init()")
> >   commit 5f4c0c1e2a51 (:mm/vmalloc: remove vmap_area_list")
> 
> Thanks for your patch, which is now commit 443cbaf9e2fdbef7
> ("crash: split vmcoreinfo exporting code out from
> crash_core.c") in v6.9-rc1.
> 
> After this, there are still two references left to CRASH_CORE:
> 
>   1. Documentation/admin-guide/kdump/kdump.rst:
> 
>          Subsequently, CRASH_CORE is selected by KEXEC_CORE::
> 
>   2. arch/loongarch/Kconfig
> 
>          config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
>              def_bool CRASH_CORE

Sure, will post patch to clean them up. Thanks a lot.


