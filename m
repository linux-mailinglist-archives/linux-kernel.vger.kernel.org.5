Return-Path: <linux-kernel+bounces-103046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7DC87BA5C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 673A81F2305E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0B46CDBD;
	Thu, 14 Mar 2024 09:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRSsRtNe"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1CC6BB45
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 09:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710408359; cv=none; b=I0k/xZpU076zn9monrC392+0ZAF6mazVMRMrFnrSO/n/TtUPwMpXyyc88zIMgG2zU0FMGs9DVAcMqC821UlAVzWPYKP27KnUj8xrRX4r4wsEc17ExbJVX4v68+HgvH3RcOhsJsdTAKZ/neUn+/b52xzVW95aCIDwyTZYCm3pj00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710408359; c=relaxed/simple;
	bh=WYA+m1DITRQzpKu2pClgxqsOc+g4yLi6VPuijP4U5gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nguq6OhIsSXvdALKv43EGPVtWI//SzkQTKPSlmV1zf/Akxm2B33yV032Jbp6R/mXKjpstduJDzsbvKmkn3VfcMCqtx1Tqct1MQyOFxcIlzrrJCvXjsIRaxRaEvhEWQP9ShI0HTryExpWamY1inwtmbeQnXFPp8LxECN7UX9ncAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRSsRtNe; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a466a1f9ea0so86689166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 02:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710408356; x=1711013156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dS4w68llSh5sQyhQyoaj7nYbU0fzmUYwbPctLQVSMGw=;
        b=cRSsRtNeUn3CO3AP4pfhFUFo2IIJWxQn+gtoBg1SQgtOI6hb86m4+SguW2BNuJg7lK
         ZAyokIoqi69IFfM+uKpsGAPWlMhvHj8xotJ7KudW6QvYxJDOujpS9GGBIPAyKyPmojCE
         /GUPO0wE9OOt0az8WOppP2P02hZ/51+3P7MAnh78XALYh0i+IvIpbc4cbRbFm+69sEgJ
         rDBf2zF7s+LJldAeCKkMxuOSXLhLlpZOiHjlYTL+h7kyGLvEKpBpvEiM1rJzQm0HBd50
         aWP53rjEkf3xxDVDTCcmsXhPnN1csGUynDcp1Yf4H4SZjy9CfkyzBuZQAZA+v3xYJ8Ve
         d8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710408356; x=1711013156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dS4w68llSh5sQyhQyoaj7nYbU0fzmUYwbPctLQVSMGw=;
        b=ZPSCP+/fEl9RFfvFSccE0chDi2R6ZOjBN2ISsjVO47/NfwshgKU8/2ze6uEzV8ny14
         CN98SteKoWdOdx8iysiMjuSxfY4uCpbyvhm0j9HjA3WyXfL8uEPoaJlLzgwrIbKwunw5
         ukgl+imMCwE7Kb7Ww7QPSZJQNvk8nVe869JFeqhwNai9jUlOVg8oeylGDeJmm5hE6ItI
         7+zbhJZTqEhR4LCnoOoh8LxJqu1mZzR4fjZtpFilKDQ9rqt9hEJBzpYZEpAzEx8jWJK3
         NV4PoPsh4tLXAafwaRu5HXew6BTpqq+jRLFEDO4Ec5yF3FKNv+B8nwol8D8ig74fJWnZ
         PyGw==
X-Forwarded-Encrypted: i=1; AJvYcCWo/fCT4YlOXFG3A54q9mF43X2ftq6r6H6CUL6MOcbt3qbhyXyCfpoT2ateg0xL4QfDV1JQNXdWEEjKpd8Kc58fbfue0e8Q/WmCQh0D
X-Gm-Message-State: AOJu0YxVBVCTZd6lCU+Jk9F+X225x0MtByVT5ajoSI3QncgBhYLRxgZP
	WMvq4R3ccRecVbdrEDtlOMf1mXba/9NBnbrSyLLerubOPlcnl8Vm
X-Google-Smtp-Source: AGHT+IFxabWhnHAZ2p0AwR77bgnLKiTzCmf5SxXuXlbgtcvZzDTq9HfVmDXZ6m2lEzEOZ2qo0Cg/pw==
X-Received: by 2002:a17:906:394:b0:a45:ebdf:b071 with SMTP id b20-20020a170906039400b00a45ebdfb071mr855827eja.35.1710408355722;
        Thu, 14 Mar 2024 02:25:55 -0700 (PDT)
Received: from gmail.com (1F2EF295.nat.pool.telekom.hu. [31.46.242.149])
        by smtp.gmail.com with ESMTPSA id c19-20020a170906341300b00a45e80cbf99sm515728ejb.221.2024.03.14.02.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 02:25:55 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 14 Mar 2024 10:25:53 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] x86/boot: replace __PHYSICAL_START with
 LOAD_PHYSICAL_ADDR
Message-ID: <ZfLCoZXQ4kp2TeB+@gmail.com>
References: <20240313075839.8321-1-richard.weiyang@gmail.com>
 <20240313075839.8321-3-richard.weiyang@gmail.com>
 <ZfF/ekjP9R91dw2j@gmail.com>
 <20240314032320.iug2hvzyblychanu@master>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314032320.iug2hvzyblychanu@master>


* Wei Yang <richard.weiyang@gmail.com> wrote:

> On Wed, Mar 13, 2024 at 11:29:33AM +0100, Ingo Molnar wrote:
> >
> >* Wei Yang <richard.weiyang@gmail.com> wrote:
> >
> >> Both __PHYSICAL_START and LOAD_PHYSICAL_ADDR are defined to get aligned
> >> CONFIG_PHYSICAL_START, so we can replace __PHYSICAL_START with
> >> LOAD_PHYSICAL_ADDR. And then remove the definition of __PHYSICAL_START,
> >> which is only used to define __START_KERNEL.
> >> 
> >> Since <asm/boot.h> includes <asm/pgtable_types.h>, which includes
> >> <asm/page_types.h>, it is fine to move definition from <asm/boot.h> to
> >> <asm/page_types.h>.
> >> 
> >> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> >> ---
> >>  arch/x86/include/asm/boot.h       | 5 -----
> >>  arch/x86/include/asm/page_types.h | 8 +++++---
> >>  2 files changed, 5 insertions(+), 8 deletions(-)
> >> 
> >> diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
> >> index a38cc0afc90a..12cbc57d0128 100644
> >> --- a/arch/x86/include/asm/boot.h
> >> +++ b/arch/x86/include/asm/boot.h
> >> @@ -6,11 +6,6 @@
> >>  #include <asm/pgtable_types.h>
> >>  #include <uapi/asm/boot.h>
> >>  
> >> -/* Physical address where kernel should be loaded. */
> >> -#define LOAD_PHYSICAL_ADDR ((CONFIG_PHYSICAL_START \
> >> -				+ (CONFIG_PHYSICAL_ALIGN - 1)) \
> >> -				& ~(CONFIG_PHYSICAL_ALIGN - 1))
> >> -
> >>  /* Minimum kernel alignment, as a power of two */
> >>  #ifdef CONFIG_X86_64
> >>  # define MIN_KERNEL_ALIGN_LG2	PMD_SHIFT
> >> diff --git a/arch/x86/include/asm/page_types.h b/arch/x86/include/asm/page_types.h
> >> index 86bd4311daf8..acc1620fd121 100644
> >> --- a/arch/x86/include/asm/page_types.h
> >> +++ b/arch/x86/include/asm/page_types.h
> >> @@ -31,10 +31,12 @@
> >>  
> >>  #define VM_DATA_DEFAULT_FLAGS	VM_DATA_FLAGS_TSK_EXEC
> >>  
> >> -#define __PHYSICAL_START	ALIGN(CONFIG_PHYSICAL_START, \
> >> -				      CONFIG_PHYSICAL_ALIGN)
> >> +/* Physical address where kernel should be loaded. */
> >> +#define LOAD_PHYSICAL_ADDR ((CONFIG_PHYSICAL_START \
> >> +				+ (CONFIG_PHYSICAL_ALIGN - 1)) \
> >> +				& ~(CONFIG_PHYSICAL_ALIGN - 1))
> >
> >I agree with this simplification, but the ALIGN() expression is far easier 
> >to read, so please keep that one instead of the open-coded version.
> >
> 
> I just tried to define LOAD_PHYSICAL_ADDR by ALIGN, but face a compile error
> on compressed/head_[32|64].o.
> 
> $ make arch/x86/boot/compressed/head_64.o
>   CALL    scripts/checksyscalls.sh
>   DESCEND objtool
>   INSTALL libsubcmd_headers
>   AS      arch/x86/boot/compressed/head_64.o
> arch/x86/boot/compressed/head_64.S: Assembler messages:
> arch/x86/boot/compressed/head_64.S:154: Error: junk (0x1000000,0x200000)' after expression
> arch/x86/boot/compressed/head_64.S:154: Error: number of operands mismatch for 16' after expression
> arch/x86/boot/compressed/head_64.S:157: Error: junk mov'
> arch/x86/boot/compressed/head_64.S:330: Error: junk (0x1000000,0x200000)' after expression
> arch/x86/boot/compressed/head_64.S:330: Error: number of operands mismatch for 16' after expression
> arch/x86/boot/compressed/head_64.S:333: Error: junk movq'
> 
> If my understanding is correct, the reason is linkage.h defines ALIGN, which
> is ".balign xxx". Maybe this is why original LOAD_PHYSICAL_ADDR doesn't use
> ALIGN.

linkage.h defines __ALIGN, which is different from ALIGN().

Also, a number of .S files seem to be using some sort of ALIGN() method 
within arch/x86/, according to:

   git grep 'ALIGN(' -- 'arch/x86/*.S'

> So is this ok to keep the open-coded definition?

It would be nice to figure out why ALIGN() appears to be working in other 
cases in .S files, while not in this case.

Thanks,

	Ingo

