Return-Path: <linux-kernel+bounces-90460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFDD86FF7D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B49A21F261C0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1DA25760;
	Mon,  4 Mar 2024 10:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4EHMFH0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E53B654
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 10:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549502; cv=none; b=fGU6g1X33bludrPXtJfnb/l08uF1BpFfPEbbGdMkLdFWeInjYmub6nsaLghcvOwRn2QLKS1iQxy4ByloVI1go8o39zyvBWsiH/2uloPZBE15rtnl6JxpUMPwjV26TQQ5euej6TmTVIbMYuwMsewsNaECtDfe7dK9tXShejjkMAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549502; c=relaxed/simple;
	bh=AWkFBgfU32UlDqkiUF9U7RS12kflTBdFk/tNRRbAdYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsFg1xGGbWp0E26UIFtaI2GLareE73j2nOVIz2xjull0jpCWC5pO0/bTmRocRq8EM1KIZra0W2a91eJFoUuFcQI7JtseLzZqzdt7dcCp4zC6NT6xWE6zJmyVZ/ZjyNcSJusNna40uBxr/nJYUNBnTyTeY+Y/DhEEqoHBlcmhsB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E4EHMFH0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709549500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8KDGD6J5huIB/ELO1ZkJuBYCkJyRo8YAdd5Mvn33swU=;
	b=E4EHMFH09RErNNjY72/tj8kmAJ4ZWMsz2Bd8YiyYmDgVdpXK0p6Ew4/HE3PM0dSjF1JQyn
	OiweBTlPIzFanb1w7W/7RZj4EqPuoYd/RhiVWGOYESRCQKF92VSHZ2WmH/sqhX3LI+MzoY
	lw/fdt1yk6xiMbtLOsalckmPcTR1sBs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515--l8jLQ_AN36e-Sv1IVWe5A-1; Mon, 04 Mar 2024 05:51:35 -0500
X-MC-Unique: -l8jLQ_AN36e-Sv1IVWe5A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D16C6862DC0;
	Mon,  4 Mar 2024 10:51:34 +0000 (UTC)
Received: from localhost (unknown [10.72.116.6])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E9A09422A9;
	Mon,  4 Mar 2024 10:51:33 +0000 (UTC)
Date: Mon, 4 Mar 2024 18:51:26 +0800
From: Baoquan He <bhe@redhat.com>
To: Borislav Petkov <bp@alien8.de>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	dyoung@redhat.com
Subject: Re: [RFC PATCH 1/2] Revert "x86/kexec/64: Prevent kexec from 5-level
 paging to a 4-level only kernel"
Message-ID: <ZeWnrhzU86pz7y5Z@MiWiFi-R3L-srv>
References: <20240301185618.19663-1-bp@alien8.de>
 <20240301185618.19663-2-bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301185618.19663-2-bp@alien8.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 03/01/24 at 07:56pm, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> This reverts commit ee338b9ee2822e65a85750da6129946c14962410.
> 
> This whole dynamic switching support is silly. I don't see a use case
> where one would use an old kernel with CONFIG_X86_5LEVEL disabled to
> kexec into. I.e., you use pretty much the same kernel.

It's not true. Customer may want to try to load a different kernel if
they have taken many testings and trust that kdump kernel, or for
debugging. The similar for kexec reboot into 2nd kernel. We don't
enforce kexec/kdump to work on the same kernel as the 1st kernel. With
the fail and message, user can take measure to avoid that. it's better
the failure is encountered when failing to jump to kexec/kdump kernel.

I remmeber we have use case where customer used kdump kernel different
than the 1st kernel. While I don't remember why.

> 
> But I'm open to corrections.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>  arch/x86/kernel/kexec-bzimage64.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index cde167b0ea92..4f2e47338b7f 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -375,11 +375,6 @@ static int bzImage64_probe(const char *buf, unsigned long len)
>  		return ret;
>  	}
>  
> -	if (!(header->xloadflags & XLF_5LEVEL) && pgtable_l5_enabled()) {
> -		pr_err("bzImage cannot handle 5-level paging mode.\n");
> -		return ret;
> -	}
> -
>  	/* I've got a bzImage */
>  	pr_debug("It's a relocatable bzImage64\n");
>  	ret = 0;
> -- 
> 2.43.0
> 


