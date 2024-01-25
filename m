Return-Path: <linux-kernel+bounces-38723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB8583C4B0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5B4B28E907
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993B1634E1;
	Thu, 25 Jan 2024 14:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BSyR08Iw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6159C63414
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 14:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706192955; cv=none; b=lt/LOTVx5d8Koqt1iXYax5nM+tTIGPlogCslzjE/L04Mfp3oGDqoqkxqIRUqIHtIBqEZXPyEOq+y5g0fKCNE7DMP3tKRlyWaSA5s9L4XVQwDO5+mBFEt11Q6utUUxD/ew/0/cxGBSA+SeCs9VWIKOGpKgZlEDhLB1Vwmb8u3BfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706192955; c=relaxed/simple;
	bh=I9v6mTvqmxyACa7UAj0Kn3HhukunpBN8/1TUzaln4BY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5Dpcy6NaPM1zIPgZr/sLRl/Vb2NmMVeAdF+JJR1vFKy55eeKZmS+0LDXiduEVesrBvoAHQzN8QgyyLBZen50fU1N5o2h84EcEG4l6cycZTg0bMEc+DVX7VhIJ+SRxk15FoykkJCWfHMvEoBY6saTFFUbHnIeHH0drw/XL2uj2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BSyR08Iw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706192953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kPi/FMkqk0jnFyJr7PYHECOz2TuqXvAotPupADG5z7E=;
	b=BSyR08IwtHN9SP2Ut5KnEXymVcVQHM8x9u451EmyE7urq9pke8gb6QFEIL3h3MdthsPM8L
	RrfYooBIkd6Cu5MTTugwCgczdWPF/VFzWZvGISucoHlcgYWb7RRZiGty2jsarJZC1ia6Tc
	dNnzx/C+IPgmZVC3eXvJhg8R+YbfwQA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-ujrFm4q3OBCZXPbbiMa7cg-1; Thu, 25 Jan 2024 09:29:11 -0500
X-MC-Unique: ujrFm4q3OBCZXPbbiMa7cg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6C1E18A0109;
	Thu, 25 Jan 2024 14:29:11 +0000 (UTC)
Received: from localhost (unknown [10.72.116.117])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B625D1121306;
	Thu, 25 Jan 2024 14:29:10 +0000 (UTC)
Date: Thu, 25 Jan 2024 22:29:07 +0800
From: Baoquan He <bhe@redhat.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-ID: <ZbJwMyCpz4HDySoo@MiWiFi-R3L-srv>
References: <20240125142907.33015c9f@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125142907.33015c9f@canb.auug.org.au>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Hi Stephen,

On 01/25/24 at 02:29pm, Stephen Rothwell wrote:
..... 
> Caused by commit
> 
>   9dc830523e4e ("ppc, crash: enforce KEXEC and KEXEC_FILE to select CRASH_DUMP")
> 
> I have applied the following patch:
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Thu, 25 Jan 2024 14:20:51 +1100
> Subject: [PATCH] fix up for "ppc, crash: enforce KEXEC and KEXEC_FILE to
>  select CRASH_DUMP"
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/powerpc/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 31f013e636e3..e7707bebc061 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -610,6 +610,8 @@ config ARCH_SUPPORTS_KEXEC
>  
>  config ARCH_SELECTS_KEXEC
>  	def_bool y
> +	depends on ARCH_SUPPORTS_CRASH_DUMP
> +	depends on KEXEC_CORE
>  	select CRASH_DUMP
>  
>  config ARCH_SUPPORTS_KEXEC_FILE

Thanks for the work.

I reproduced the failure with allnoconfig on ppc, and found below change
can fix it too. And the change makes ARCH_SELECTS_KEXEC consistent with
ARCH_SELECTS_KEXEC_FILE on the dependency. What do you think?

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 31f013e636e3..79f98cd5f2c9 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -610,6 +610,7 @@ config ARCH_SUPPORTS_KEXEC
 
 config ARCH_SELECTS_KEXEC
 	def_bool y
+	depends on KEXEC
 	select CRASH_DUMP
 
 config ARCH_SUPPORTS_KEXEC_FILE



