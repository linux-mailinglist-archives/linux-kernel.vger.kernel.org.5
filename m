Return-Path: <linux-kernel+bounces-85089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 548A686B047
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8572E1C23CCB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074A414EFEB;
	Wed, 28 Feb 2024 13:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CdY2I4LT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB11314CAB3
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 13:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709126858; cv=none; b=NRx4THe6ChqCV1ELniqtWcxFOfOkqAodS5HPq+m0i65kuTBiR010LuT5zl4ilL/5iLyTqKEsX/Hwnq0sFKXKH1pU6sA/+mxSrEHYzGSFo2XhfQXxh1nMNsWkld1riE1sTGzZYrBL+uPreZoKhqyOY5IQe86P1omaJqd7piL9+Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709126858; c=relaxed/simple;
	bh=vD1tlfblNwnvLOwYPS7mhVThYZgtC7eA9lrC8aSdMKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7r7M7lkeQcn7k71pNk0XhCS8MyJJ+MmRVytaAv/mHuLtn/8hFeb0oYLLuVFE1iOzMqS7ZhJJZUY+sAJnmA7Le2WZAkfJFoXNrruNrb/c16rB9UMZ97BYtBy3yCiiAc0Wza2nsUDqW+MGXrPn6ATvGVsB+Cz506aymOtYywjhHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CdY2I4LT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709126855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kEfwbgk+HJXxJPFthOIkO9PMTrZebAOuLRXMpclJ/tY=;
	b=CdY2I4LTe6ySvhKUd5OXvK28CMprZtY2PBLDW4XFHiESApTPt/4BiAluWOvJF+zzEyMqqC
	nJAa6ultmka3u5QI6BYTXaIFOkI7ZDS8oZVEr1p1dFzIcU6dH+nveaXJejk2dEE9pXbUBE
	FuWuv8ygOZdLewAxrLeQv8n8nvLOyys=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-klg8Z8ybN-SVy6j-IZi_eg-1; Wed, 28 Feb 2024 08:27:32 -0500
X-MC-Unique: klg8Z8ybN-SVy6j-IZi_eg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6817C8871C2;
	Wed, 28 Feb 2024 13:27:31 +0000 (UTC)
Received: from localhost (unknown [10.72.116.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E66E9492BE2;
	Wed, 28 Feb 2024 13:27:29 +0000 (UTC)
Date: Wed, 28 Feb 2024 21:27:24 +0800
From: Baoquan He <bhe@redhat.com>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Kexec-ml <kexec@lists.infradead.org>,
	lkml <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH linux-next v2 0/3] powerpc/kexec: split CONFIG_CRASH_DUMP
 out from CONFIG_KEXEC_CORE
Message-ID: <Zd80vHHS2Jrobvtq@MiWiFi-R3L-srv>
References: <20240226103010.589537-1-hbathini@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226103010.589537-1-hbathini@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 02/26/24 at 04:00pm, Hari Bathini wrote:
> This patch series is a follow-up to [1] based on discussions at [2]
> about additional work needed to get it working on powerpc.
> 
> The first patch in the series makes struct crash_mem available with or
> without CONFIG_CRASH_DUMP enabled. The next patch moves kdump specific
> code for kexec_file_load syscall under CONFIG_CRASH_DUMP and the last
> patch splits other kdump specific code under CONFIG_CRASH_DUMP and
> removes dependency with CONFIG_CRASH_DUMP for CONFIG_KEXEC_CORE.
> 
> [1] https://lore.kernel.org/all/20240124051254.67105-1-bhe@redhat.com/
> [2] https://lore.kernel.org/all/9101bb07-70f1-476c-bec9-ec67e9899744@linux.ibm.com/
> 
> Changes in v2:
> * Fixed a compile error for POWERNV build reported by Sourabh.
> 
> Hari Bathini (3):
>   kexec/kdump: make struct crash_mem available without CONFIG_CRASH_DUMP
>   powerpc/kexec: split CONFIG_KEXEC_FILE and CONFIG_CRASH_DUMP
>   powerpc/kdump: Split KEXEC_CORE and CRASH_DUMP dependency

I have acked patch 1. And patch 2 and 3 looks good to me, leave these
two to powerpc experts to have a careful reviewing. Thanks for these
great work.


> 
>  arch/powerpc/Kconfig                 |   9 +-
>  arch/powerpc/include/asm/kexec.h     |  98 +++++-----
>  arch/powerpc/kernel/prom.c           |   2 +-
>  arch/powerpc/kernel/setup-common.c   |   2 +-
>  arch/powerpc/kernel/smp.c            |   4 +-
>  arch/powerpc/kexec/Makefile          |   3 +-
>  arch/powerpc/kexec/core.c            |   4 +
>  arch/powerpc/kexec/elf_64.c          |   4 +-
>  arch/powerpc/kexec/file_load_64.c    | 269 ++++++++++++++-------------
>  arch/powerpc/platforms/powernv/smp.c |   2 +-
>  include/linux/crash_core.h           |  12 +-
>  11 files changed, 209 insertions(+), 200 deletions(-)
> 
> -- 
> 2.43.2
> 


