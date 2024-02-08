Return-Path: <linux-kernel+bounces-58155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2EB84E1FF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A7351C2442F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D587640C;
	Thu,  8 Feb 2024 13:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C1nKUUet"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730377318C
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 13:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707399059; cv=none; b=MIzAytgFjBBk21EZ0Iv8eOYyB6iCU9uggr0Gg7j/carm04VianXaA/LnnunxUBoV/zu4+b/uVD++Sw5cDxQYxNfQWPr+iDkNdsezMlla7L3uaIjA40aUSgw1KIEpaV4ZzdJ/gu/AQxh/sv5NNpcwtVjaCvTur8k/+snpMIet2sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707399059; c=relaxed/simple;
	bh=0Y/NWtq0++KDS7DW5Ga8O7mDH7qi4qQn92PYZrXAwJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D9j1qMNP/1RyjqTdrmX0tEBFQQPvQHMYmmrURcqnLjg/pkkfmkIGYfFOcC/qmUDUnQPVx9SgiXuhZPEMWWgMpo9zy3Xm14q8tdqLZ5Ta1ZysgtAnSs3j1ftcD8bPR/tVv0sdRfFF37Q9999sNREuDjST5JP3rwmZIzE4cpsWKdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C1nKUUet; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707399055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=skHZhH2neXcw79cTYknGaCDYowrcPvP9mC0pM3v/Buk=;
	b=C1nKUUetf4Sei3lltfc5DOaaipaGN9gnXrytwp3KUBoXrGwCppCSCUfcoyoz0Z1pJz5ULG
	60fh3gEvP6nV8PkUEf9UKRVUdMaR4TSsWnjBo3JsNju9vJGYuVnsRj64U+kBf7gVeRl+BT
	ZHzVlVHQCxiLr1xZFdIiVgZckldWeHM=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-FFq2A4eRM5i2Injj4ulY1Q-1; Thu, 08 Feb 2024 08:30:53 -0500
X-MC-Unique: FFq2A4eRM5i2Injj4ulY1Q-1
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-4c04147bfa1so915048e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 05:30:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707399053; x=1708003853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=skHZhH2neXcw79cTYknGaCDYowrcPvP9mC0pM3v/Buk=;
        b=vJvEpccZ8bV0/Pkg2mfEq3zUHxcxu+V5U0O/3Ze/iN7RJe0pT5m2OXDSSQqe+Hvq9I
         MVGAcJoykxn83ixieh4UYzkwLMbuVJFBYBSUh1t8XirbiFDGxgjBHKSUifGj1XJAa1l7
         IhTORH4weUxF2AaAddU+p0PYBVQB/gxW0CjpgpN8QYS2GmaQcFQ5pg7OREeZfvz3RsQd
         2Uok6IpRJTjo7fpcccYBj2bdJFDdbfi/sSU4guN03ryXG31r8UpfRTUktoFKWkcTdQKD
         xUDuH867r70Z1Yl2AyMbN8ii9ojj5eQ6K/CpHQA56Wi+geZu7hQBecBdLVjoyq+mpQPl
         WwKw==
X-Forwarded-Encrypted: i=1; AJvYcCUWmWXMhf4gT3WD7H2tv2BIGAZJsm+5U78if0GlUWPYFE3X6iSwT0hhxlRSaaSTjnDo1tZdpAcJOLPlUyo2LzgERBwZyHrsJTDXP0Bw
X-Gm-Message-State: AOJu0YzDvVDLxflZR3ld7tju7ka1HqGJSX+YvTmq/LqkJDz2x87/5jsi
	FrtH5rIWm9CYEy/+tyFqyYI9eoU61So/bxZBHyfoRyqN/KVPWuCFka8j/W9s6KmzX/VV5hlzXK9
	ibV3sB2D4JkvTCIJ8XU1RYqvEa+JraIyN1aVZKK+tc3zyuRfb6ou6VEU5y4+v6ewv+j43GuMIxf
	1vIFmX7xGpr/d9Y9B11lbrLtc6+QPyO+yzG+bb
X-Received: by 2002:a05:6122:180b:b0:4b8:4e76:a5e6 with SMTP id ay11-20020a056122180b00b004b84e76a5e6mr2144894vkb.2.1707399053093;
        Thu, 08 Feb 2024 05:30:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHob5ah0xO/MlvFGAhaRvzI6DpcAzryTHKFxy2TvzFiQUbK7JU6un06DmZ+jkQelMn9n9cWdEcFEiY+DONfdyE=
X-Received: by 2002:a05:6122:180b:b0:4b8:4e76:a5e6 with SMTP id
 ay11-20020a056122180b00b004b84e76a5e6mr2144873vkb.2.1707399052811; Thu, 08
 Feb 2024 05:30:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705965634.git.isaku.yamahata@intel.com> <88bcf53760c42dafb14cd9a92bf4f9243f597bbe.1705965634.git.isaku.yamahata@intel.com>
In-Reply-To: <88bcf53760c42dafb14cd9a92bf4f9243f597bbe.1705965634.git.isaku.yamahata@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 8 Feb 2024 14:30:40 +0100
Message-ID: <CABgObfYo0OaSXUYjQbn188y8JOAZGzD56TabdyENXAW6_Ca0Hw@mail.gmail.com>
Subject: Re: [PATCH v18 002/121] x86/virt/tdx: Export SEAMCALL functions
To: isaku.yamahata@intel.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	isaku.yamahata@gmail.com, erdemaktas@google.com, 
	Sean Christopherson <seanjc@google.com>, Sagi Shahar <sagis@google.com>, Kai Huang <kai.huang@intel.com>, 
	chen.bo@intel.com, hang.yuan@intel.com, tina.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 12:54=E2=80=AFAM <isaku.yamahata@intel.com> wrote:
>
> From: Kai Huang <kai.huang@intel.com>
>
> KVM will need to make SEAMCALLs to create and run TDX guests.  Export
> SEAMCALL functions for KVM to use.
>
> Also add declaration of SEAMCALL functions to <asm/asm-prototypes.h> to
> support CONFIG_MODVERSIONS=3Dy.
>
> Signed-off-by: Kai Huang <kai.huang@intel.com>

I thought you were going to introduce builtin functions for SEAMCALLs
needed by KVM, instead?

In any case, missing Signed-off-by.

Paolo

> ---
>  arch/x86/include/asm/asm-prototypes.h | 1 +
>  arch/x86/virt/vmx/tdx/seamcall.S      | 4 ++++
>  2 files changed, 5 insertions(+)
>
> diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm=
/asm-prototypes.h
> index b1a98fa38828..0ec572ad75f1 100644
> --- a/arch/x86/include/asm/asm-prototypes.h
> +++ b/arch/x86/include/asm/asm-prototypes.h
> @@ -13,6 +13,7 @@
>  #include <asm/preempt.h>
>  #include <asm/asm.h>
>  #include <asm/gsseg.h>
> +#include <asm/tdx.h>
>
>  #ifndef CONFIG_X86_CMPXCHG64
>  extern void cmpxchg8b_emu(void);
> diff --git a/arch/x86/virt/vmx/tdx/seamcall.S b/arch/x86/virt/vmx/tdx/sea=
mcall.S
> index 5b1f2286aea9..e32cf82ed47e 100644
> --- a/arch/x86/virt/vmx/tdx/seamcall.S
> +++ b/arch/x86/virt/vmx/tdx/seamcall.S
> @@ -1,5 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  #include <linux/linkage.h>
> +#include <linux/export.h>
>  #include <asm/frame.h>
>
>  #include "tdxcall.S"
> @@ -21,6 +22,7 @@
>  SYM_FUNC_START(__seamcall)
>         TDX_MODULE_CALL host=3D1
>  SYM_FUNC_END(__seamcall)
> +EXPORT_SYMBOL_GPL(__seamcall);
>
>  /*
>   * __seamcall_ret() - Host-side interface functions to SEAM software
> @@ -40,6 +42,7 @@ SYM_FUNC_END(__seamcall)
>  SYM_FUNC_START(__seamcall_ret)
>         TDX_MODULE_CALL host=3D1 ret=3D1
>  SYM_FUNC_END(__seamcall_ret)
> +EXPORT_SYMBOL_GPL(__seamcall_ret);
>
>  /*
>   * __seamcall_saved_ret() - Host-side interface functions to SEAM softwa=
re
> @@ -59,3 +62,4 @@ SYM_FUNC_END(__seamcall_ret)
>  SYM_FUNC_START(__seamcall_saved_ret)
>         TDX_MODULE_CALL host=3D1 ret=3D1 saved=3D1
>  SYM_FUNC_END(__seamcall_saved_ret)
> +EXPORT_SYMBOL_GPL(__seamcall_saved_ret);
> --
> 2.25.1
>


