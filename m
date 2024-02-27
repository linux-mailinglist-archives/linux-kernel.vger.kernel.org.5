Return-Path: <linux-kernel+bounces-83070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3444D868E13
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A59F1C21B72
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9442F139574;
	Tue, 27 Feb 2024 10:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GzM7CDvo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3100D1386CE
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031192; cv=none; b=Sap2Dkj6yJ0yWFtEFvgoUfRzCo2A93uYK0G8O4C0yunOT61N4bDJAVfN8zh1MXSFHtWSO5S2GoeYFHFBbdGMTJXM1BS605yeGXczHvRyQD2Xijmoh83oAxwDO0tA4oPbzT4eM2eQbj2kCXirhomFRC+B3EtE8SE1Mej8aDCpB+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031192; c=relaxed/simple;
	bh=1e54Ewk7dKSI2j2rLaGO4VOlLiMm104HLmVcrEPRgZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrkY8ke/PF955PFSvgFbdZLdYZk+zoO+K1LV9tNFbw7TyODX2wsM2K7wOxl97SOmiLbyJIz7iBLa4bf/WaBOuLdQHePfQwM35x7BaSxnbxlsnah+r9THZkIQPFt8FGiXygJXZdORoH49ja9VzGbyNrZB0VAjuaYei2ANM3EWklQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GzM7CDvo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709031189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1/R0zYYMzMrd102J3JgHM4IsC1fahdOwS+2IaXy3PeY=;
	b=GzM7CDvoX4hH3SCYJfL9BKwe9rvqrymoAJpuUmiCViApwToLZYGanC5gvAhUcofVAcjlrm
	5V39+14uquxj+E/ytqRh91M9vTY8kzRnmozoVt0jAI4I9vtA5eBPtXynny82TD6Aitk/YR
	slmZzR9ffIwcEE04uSG9Dbs5o8sRLiM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-3FvsOudxP5y2P_M0yYeEmA-1; Tue,
 27 Feb 2024 05:53:06 -0500
X-MC-Unique: 3FvsOudxP5y2P_M0yYeEmA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A73F33C1E9C4;
	Tue, 27 Feb 2024 10:53:05 +0000 (UTC)
Received: from localhost (unknown [10.72.116.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 74B271C06713;
	Tue, 27 Feb 2024 10:53:01 +0000 (UTC)
Date: Tue, 27 Feb 2024 18:52:57 +0800
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
Subject: Re: [PATCH linux-next v2 1/3] kexec/kdump: make struct crash_mem
 available without CONFIG_CRASH_DUMP
Message-ID: <Zd2/CRHtB4kETwtp@MiWiFi-R3L-srv>
References: <20240226103010.589537-1-hbathini@linux.ibm.com>
 <20240226103010.589537-2-hbathini@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226103010.589537-2-hbathini@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 02/26/24 at 04:00pm, Hari Bathini wrote:
> struct crash_mem defined under include/linux/crash_core.h represents
> a list of memory ranges. While it is used to represent memory ranges
> for kdump kernel, it can also be used for other kind of memory ranges.
> In fact, KEXEC_FILE_LOAD syscall in powerpc uses this structure to
> represent reserved memory ranges and exclude memory ranges needed to
> find the right memory regions to load kexec kernel. So, make the

We may be able to refactor code to make struct crash_mem only used for
crash handling, or get another data structure for loading kexec kernel.
Anyway, for the time being, this is the simplest way we can take. Thanks
for the work on ppc to make crash split out from the kexec code.

Acked-by: Baoquan He <bhe@redhat.com>

> definition of crash_mem structure available for !CONFIG_CRASH_DUMP
> case too.
> 
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
> 
> * No changes in v2.
> 
>  include/linux/crash_core.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index 23270b16e1db..d33352c2e386 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -8,6 +8,12 @@
>  
>  struct kimage;
>  
> +struct crash_mem {
> +	unsigned int max_nr_ranges;
> +	unsigned int nr_ranges;
> +	struct range ranges[] __counted_by(max_nr_ranges);
> +};
> +
>  #ifdef CONFIG_CRASH_DUMP
>  
>  int crash_shrink_memory(unsigned long new_size);
> @@ -51,12 +57,6 @@ static inline unsigned int crash_get_elfcorehdr_size(void) { return 0; }
>  /* Alignment required for elf header segment */
>  #define ELF_CORE_HEADER_ALIGN   4096
>  
> -struct crash_mem {
> -	unsigned int max_nr_ranges;
> -	unsigned int nr_ranges;
> -	struct range ranges[] __counted_by(max_nr_ranges);
> -};
> -
>  extern int crash_exclude_mem_range(struct crash_mem *mem,
>  				   unsigned long long mstart,
>  				   unsigned long long mend);
> -- 
> 2.43.2
> 


