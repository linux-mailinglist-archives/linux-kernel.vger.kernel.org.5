Return-Path: <linux-kernel+bounces-44340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD2F842074
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24691F2B3D0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5AD60882;
	Tue, 30 Jan 2024 10:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dShA7CDH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940746A32C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 10:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608822; cv=none; b=q/c0l+hmqyJ/UTtPv8AtRnlSjw0tbOV4ozgw34bwYlfnGeW4SGGKMFre4uAC/YZHG9DKiYFeYlmlcrEVCYJUVwjgygn4jf4ALbplo96zRNeLK1pttipOzuByJSaK6zutNEXTdfQe/BG8gGcJK0XYhVHhebW0ypq6GwW5r54CyVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608822; c=relaxed/simple;
	bh=hl3aWWcDKcj6n80V7MgjKRZSLee3oVCAam4GiDvNx9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSWtkyUYrRqTzXjxBJhC+I0NdCLjWlPgU5W+sf5V9gwnJv/SUckJqExVod0C14S0RGznXhlCoFx3f/bAFvAzAaoBhAXpje3OAAatoef5WzbBJ3eVjSRQJsZljHOauzhJGk8XTTS8+IEduXoGF2e2aIEcbDk3GULptypS+z/LEUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dShA7CDH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706608819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lvd79EwJ/EeeRbQUvV7D8alEJPVcC5AuHB/N6mbkr5Q=;
	b=dShA7CDHqo7nkGNy44jA4nN+FQ0AATCq6wDSNRu3iORsbO9j6rEWcB4vSthI1j1Z6ujsQv
	sDeaE8GMwdO3kW+Qq0GJH63l/NxyS5eepJOHHXe34uRjakjWJqnwJlxxQPSpCx5W/MaM++
	C8D3GwDxqQGipvnZ1nnWFTQDkSaMNmI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-Qzd-oGeuMXyENNVF1gEpXg-1; Tue, 30 Jan 2024 05:00:17 -0500
X-MC-Unique: Qzd-oGeuMXyENNVF1gEpXg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33af5879edfso583094f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 02:00:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706608816; x=1707213616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lvd79EwJ/EeeRbQUvV7D8alEJPVcC5AuHB/N6mbkr5Q=;
        b=T0txsOi45ZpxDohQN5Vu8p4WLU3s/as7SAJAzNgkXW4FbPxGo2yfJpHaMjBo7v/LFL
         WFoslzSpXJoPnVnJK3ydIgbHoZ9gwpqmCEf6joEOYDav0Rpg9LAiRAZRGevjaQ5NEdZY
         RaA/kwsVVzD+HRgQRvZl9PMLv1PzTbeuq3lvVfm4F2HTruA9xJvQFiA69yHWdPNFFT3c
         TLYbSaEyZVMtZdjso2etwCrpIti+VJyu4cNnpmG8sRJ3axriwfZZO2/W87mae+Bmu9+X
         2QVh7x3XSFg/Kb19P1oHLt60a24Nis3/yZyDJbIKcgMq8nBIlam65LYDN1M7GQL6w0eD
         FuQQ==
X-Gm-Message-State: AOJu0YzDP5p/+1CkHltYYEqgIQM7sjPc+cvSrkuaMHmn5RJBE9IapP9S
	lLXJBpPg51yWPQJN7grN9CAJV/9pQEHFJ6a1r0eFAGrxl563fhkoreTsy43NJJznhzzRzLi7oqL
	ZLXFCW39+UFbV0ukBOhoASTT1QycV6b7o+8mGmo+R+/ENIqjA/Lov9xkqjUQE4g==
X-Received: by 2002:a05:6000:2ac:b0:33a:f521:5815 with SMTP id l12-20020a05600002ac00b0033af5215815mr2795199wry.26.1706608816486;
        Tue, 30 Jan 2024 02:00:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwb92jelVdRIonuHD9AAXhHL37860vpbI9s5dqUN+CbIom/XaWO3f0Bq1fr41DoHF1tZ3ZDA==
X-Received: by 2002:a05:6000:2ac:b0:33a:f521:5815 with SMTP id l12-20020a05600002ac00b0033af5215815mr2795173wry.26.1706608816134;
        Tue, 30 Jan 2024 02:00:16 -0800 (PST)
Received: from t14s (109-81-83-173.rct.o2.cz. [109.81.83.173])
        by smtp.gmail.com with ESMTPSA id az28-20020adfe19c000000b0033afcf8925asm678165wrb.24.2024.01.30.02.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 02:00:15 -0800 (PST)
Date: Tue, 30 Jan 2024 10:54:20 +0100
From: Jan Stancek <jstancek@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linuxppc-dev@lists.ozlabs.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, jstancek@redhat.com
Subject: Re: [PATCH] powerpc: add crtsavres.o to always-y instead of extra-y
Message-ID: <ZbjHTMhQ4Z9lRR6L@t14s>
References: <20231120232332.4100288-1-masahiroy@kernel.org>
 <CX42TU4QHS1Z.A0UUHMDAMZOL@wheely>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CX42TU4QHS1Z.A0UUHMDAMZOL@wheely>

On Tue, Nov 21, 2023 at 10:51:34AM +1000, Nicholas Piggin wrote:
>On Tue Nov 21, 2023 at 9:23 AM AEST, Masahiro Yamada wrote:
>> crtsavres.o is linked to modules. However, as explained in commit
>> d0e628cd817f ("kbuild: doc: clarify the difference between extra-y
>> and always-y"), 'make modules' does not build extra-y.
>>
>> For example, the following command fails:
>>
>>   $ make ARCH=powerpc LLVM=1 KBUILD_MODPOST_WARN=1 mrproper ps3_defconfig modules
>>     [snip]
>>     LD [M]  arch/powerpc/platforms/cell/spufs/spufs.ko
>>   ld.lld: error: cannot open arch/powerpc/lib/crtsavres.o: No such file or directory
>>   make[3]: *** [scripts/Makefile.modfinal:56: arch/powerpc/platforms/cell/spufs/spufs.ko] Error 1
>>   make[2]: *** [Makefile:1844: modules] Error 2
>>   make[1]: *** [/home/masahiro/workspace/linux-kbuild/Makefile:350: __build_one_by_one] Error 2
>>   make: *** [Makefile:234: __sub-make] Error 2
>>
>
>Thanks. Is this the correct Fixes tag?
>
>Fixes: d0e628cd817f ("powerpc/64: Do not link crtsavres.o in vmlinux")
>
>Hmm, looks like LLD might just do this now automatically for us
>too without --save-restore-funcs (https://reviews.llvm.org/D79977).
>But we probably still need it for older versions, so we still need
>your patch.

Hi,

I'm still seeing the error of crtsavres.o missing when building external modules
after "make LLVM=1 modules_prepare". Should it be built also in archprepare?

Thanks,
Jan


diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 051247027..a62334194 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -57,8 +57,11 @@ ifeq ($(CONFIG_PPC64)$(CONFIG_LD_IS_BFD),yy)
  # Have the linker provide sfpr if possible.
  # There is a corresponding test in arch/powerpc/lib/Makefile
  KBUILD_LDFLAGS_MODULE += --save-restore-funcs
+crtsavres_prepare:
  else
  KBUILD_LDFLAGS_MODULE += arch/powerpc/lib/crtsavres.o
+crtsavres_prepare:
+       $(MAKE) $(build)=arch/powerpc/lib arch/powerpc/lib/crtsavres.o
  endif

  ifdef CONFIG_CPU_LITTLE_ENDIAN
@@ -389,7 +392,7 @@ vdso_prepare: prepare0
                 $(build)=arch/powerpc/kernel/vdso include/generated/vdso64-offsets.h)
  endif

-archprepare: checkbin
+archprepare: checkbin crtsavres_prepare

  archheaders:
         $(Q)$(MAKE) $(build)=arch/powerpc/kernel/syscalls all


