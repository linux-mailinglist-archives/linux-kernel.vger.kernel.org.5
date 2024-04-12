Return-Path: <linux-kernel+bounces-142139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B338A27FD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08AE1285257
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5834C4AEEA;
	Fri, 12 Apr 2024 07:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SHrBC2Vz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3984610A24
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712906923; cv=none; b=nF5xITr2WBNuNculaPauGzmvvC9sRmsHRBOGAGTbLpQQkp/Z+UhOYfs4O0rMLCaeaYO/jo6TJGyATzYLxu/S3cwr5o6qBtrRK+0voeWGZPl2/CxjGfIshSsPCGqSi8RKSITDwdmqvbJ+zrc0kRRn/+0r238Os1KpItWirO+mrLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712906923; c=relaxed/simple;
	bh=ZwXeDZARNK3WVATdjJMvwtCrbqLGzgmkGeywXg37DZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LkveOozXhL3IQta6Hp6B03Cfp4VE4kck4M1/5TMTQhIcu50qnQU2QBM3PniRE9QWYi7qXcDyczIVk6/7RFd691THaNA/wuS5uU6+2uVHtArZ/og9rWEG74QNsAr9rHLDjXTtqiv20AJsrZNkHcuF6lRXvDIWoprqjHwWB0xU3Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SHrBC2Vz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712906921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l4v5L9yYqFT1nF+Gr2M5J9sdYztg1g6ZV5At3HsBWFs=;
	b=SHrBC2Vzp4IXP/3WcS9N8cIbar/ilbMOV9KbAPrkE3+NBCWj50lGg2whyZaf7G7ej1nD57
	RCMZXfown2zWLw5Kykpcx/GiztpPqaaiRXA6XxSj/UCBSOo+rNA5Rd1RPtvfsc0xEFiQ6y
	gcaLiBfy574R+pFC2UviOn4N7OhvJqs=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-5se29RojPAyF8qb1wVyeOQ-1; Fri, 12 Apr 2024 03:28:38 -0400
X-MC-Unique: 5se29RojPAyF8qb1wVyeOQ-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36a1110ff5bso602085ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 00:28:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712906918; x=1713511718;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l4v5L9yYqFT1nF+Gr2M5J9sdYztg1g6ZV5At3HsBWFs=;
        b=Um5rw6hnbfNyrzZsJXu3lo3aHAszafHFce8NRUFctrFaHWSI4zzQ/4GeqU3ZOu/Dow
         ISgQEQGDHMremSJAWYEwr6s1Xy1j2/MxcBhsW/sgXpcvva6mA0wT5i/ibVxwAIp2A9mc
         w+PfBAuGWgzMG5EIvuS1HgeaZ507v0UdHN7zE2C53W8waD5zCS/zdEOeT391ptdownyL
         /MArmn5rO/nvqJDtdjEahvxoiFd2+njwm0XaJYD3en+UqqTRZz7ZZGeU2qP0Q2a0tvRK
         Bok8eoHsJzT8tI06QNsl0NilKCQ9pfUmS6V1QVhsVSfG7lOqhTArbAaKTB+EloltzOc2
         594w==
X-Forwarded-Encrypted: i=1; AJvYcCXjN6xr5X/y4jqOOd2qG34/l1s1NklRUyoIF7rkT/9V2OBYFnuD1rQfkSnXOTuzDr9gR2Bs5c/J8nyNM/XZIEBbY4bDQWnqVGLOR89T
X-Gm-Message-State: AOJu0YwRbxUtODxRS/wiGZIudt+RHjb2Kdgy5LwuOSoMyB+tAJsPqFuy
	bny+BV2WfCvcwvjG96HyWuHIQMWA2F+v0K/DvpI/gftwBFOfW54n5rxwbyq3K3E91rGeD77UppV
	VnJoZQuGeKNloqgIV3oOrg/J8zOR/Uc+bw8+oQqvrC/+MdfVbuTASB7PLoeYsErVOJeJi6osUjC
	ijucEBLM1EdO7M1nMuKjz06FbfI3A2i9aGGx7z
X-Received: by 2002:a05:6e02:1fec:b0:36a:2d25:3d82 with SMTP id dt12-20020a056e021fec00b0036a2d253d82mr2093927ilb.0.1712906918161;
        Fri, 12 Apr 2024 00:28:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3mtFwkDAWvZL9WB+G3Djd0/EsxG1ujbtd6oa5q2SV7swKwH/GPa7ti3VumMBkbl/CHIdLMcmIEoUhu5lxNy8=
X-Received: by 2002:a05:6e02:1fec:b0:36a:2d25:3d82 with SMTP id
 dt12-20020a056e021fec00b0036a2d253d82mr2093917ilb.0.1712906917899; Fri, 12
 Apr 2024 00:28:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409042238.1240462-1-bhe@redhat.com>
In-Reply-To: <20240409042238.1240462-1-bhe@redhat.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 12 Apr 2024 15:28:53 +0800
Message-ID: <CALu+AoRB=kK00ecpboSJxpNqP+ERZaUrS+h-oo+uaXLoYPYT_Q@mail.gmail.com>
Subject: Re: [PATCH v2] kexec: fix the unexpected kexec_dprintk() macro
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, jirislaby@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Apr 2024 at 12:23, Baoquan He <bhe@redhat.com> wrote:
>
> Jiri reported that the current kexec_dprintk() always prints out
> debugging message whenever kexec/kdmmp loading is triggered. That is
> not wanted. The debugging message is supposed to be printed out when
> 'kexec -s -d' is specified for kexec/kdump loading.
>
> After investigating, the reason is the current kexec_dprintk() takes
> printk(KERN_INFO) or printk(KERN_DEBUG) depending on whether '-d' is
> specified. However, distros usually have defaulg log level like below:
>
>  [~]# cat /proc/sys/kernel/printk
>  7       4      1       7
>
> So, even though '-d' is not specified, printk(KERN_DEBUG) also always
> prints out. I thought printk(KERN_DEBUG) is equal to pr_debug(), it's
> not.
>
> Fix it by changing to use pr_info() instead which are expected to work.

Could you also update the kernel/crash_core.c and
kernel/crash_reserve.c to include the filename prefix?
#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

Otherwise:
Reviewed-by: Dave Young <dyoung@redhat.com>

>
> Fixes: cbc2fe9d9cb2 ("kexec_file: add kexec_file flag to control debug printing")
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Reported-by: Jiri Slaby <jirislaby@kernel.org>
> Closes: https://lore.kernel.org/all/4c775fca-5def-4a2d-8437-7130b02722a2@kernel.org
> ---
> v1->v2:
> - Change to use pr_info() only when "kexec -s -d" is specified. With
>   this change, those debugging message for "kexec -c -d" of kexec_load
>   will be missed. We'll see if we need add them for kexec_load too, if
>   someone explicitly requests it.
>
>  include/linux/kexec.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 060835bb82d5..f31bd304df45 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -461,10 +461,8 @@ static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) {
>
>  extern bool kexec_file_dbg_print;
>
> -#define kexec_dprintk(fmt, ...)                                        \
> -       printk("%s" fmt,                                        \
> -              kexec_file_dbg_print ? KERN_INFO : KERN_DEBUG,   \
> -              ##__VA_ARGS__)
> +#define kexec_dprintk(fmt, arg...) \
> +        do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0)
>
>  #else /* !CONFIG_KEXEC_CORE */
>  struct pt_regs;
> --
> 2.41.0
>
>


