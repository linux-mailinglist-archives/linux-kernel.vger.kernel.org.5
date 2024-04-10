Return-Path: <linux-kernel+bounces-137852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BE389E841
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4EC71C241BF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3E6947A;
	Wed, 10 Apr 2024 02:41:41 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0528C5CB5
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 02:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712716901; cv=none; b=nCyAWqkS+mENFte6ZpJeASl92Q71QNwoWgUB/QDJ9NVbDeG5ODjk/CONAfylC1D2wEdkvDYnhxiIOGH164AtZCEobyq4SHiXQKSignOKflW2rkLDrZODDq7YdRBHNbA7tZTHYP5CoWrUh1SXbyRfDO7z9yulNONkQVlzJ5WSrSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712716901; c=relaxed/simple;
	bh=WQE/DcVn0z+Dwqhu6TGO6zO3ltOLL30++8D0WS2ug+I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hkv5rLwvGBCcJeX0p4Ci3RTyNtqyK49VQOyFeiNP/KQsMNQ80tZ//80uQAsAbHyx49vSVPyeLjYaeMxUVy/Wv1UjnPcq/Ui2/Hiivneg95tC9PYglupVp8y5UMLV4ZFR/Bxff7qVG/0/5drtXgg6iopmw00+D/f6d12ucdpxf/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VDnBV3Vjxz1GGgC;
	Wed, 10 Apr 2024 10:40:50 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (unknown [7.193.23.54])
	by mail.maildlp.com (Postfix) with ESMTPS id 3204D18002D;
	Wed, 10 Apr 2024 10:41:36 +0800 (CST)
Received: from Linux-SUSE12SP5.huawei.com (10.67.136.233) by
 kwepemm600014.china.huawei.com (7.193.23.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 10:41:35 +0800
From: zhuqiuer <zhuqiuer1@huawei.com>
To: <nathan@kernel.org>
CC: <ardb@kernel.org>, <justinstitt@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux@armlinux.org.uk>, <llvm@lists.linux.dev>, <morbo@google.com>,
	<ndesaulniers@google.com>, <zhuqiuer1@huawei.com>
Subject: Re: [PATCH] ARM: Add a memory clobber to the fmrx instruction
Date: Wed, 10 Apr 2024 10:41:25 +0800
Message-ID: <20240410024126.21589-1-zhuqiuer1@huawei.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20240409164641.GC3219862@dev-arch.thelio-3990X>
References: <20240409164641.GC3219862@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600014.china.huawei.com (7.193.23.54)

> > Instruction fmrx is used throughout the kernel,
> > where it is sometimes expected to be skipped
> > by incrementing the program counter, such as in vfpmodule.c:vfp_init().
> > Therefore, the instruction should not be reordered when it is not intended.
> > Adding a barrier() instruction before and after this call cannot prevent
> > reordering by the compiler, as the fmrx instruction is constrained
> > by '=r', meaning it works on the general register but not on memory.
> > To ensure the order of the instruction after compiling,
> > adding a memory clobber is necessary.
> > 
> > Below is the code snippet disassembled from the method:
> > vfpmodule.c:vfp_init(), compiled by LLVM.
> > 
> > Before the patching:
> > xxxxx:   xxxxx    bl  c010c688 <register_undef_hook>
> > xxxxx:   xxxxx    mov r0, r4
> > xxxxx:   xxxxx    bl  c010c6e4 <unregister_undef_hook>
> > ...
> > xxxxx:   xxxxx    bl  c0791c8c <printk>
> > xxxxx:   xxxxx    movw    r5, #23132  ; 0x5a5c
> > xxxxx:   xxxxx    vmrs    r4, fpsid  <- this is the fmrx instruction
> > 
> > After the patching:
> > xxxxx:   xxxxx    bl  c010c688 <register_undef_hook>
> > xxxxx:   xxxxx    mov r0, r4
> > xxxxx:   xxxxx    vmrs    r5, fpsid  <- this is the fmrx instruction
> > xxxxx:   xxxxx    bl  c010c6e4 <unregister_undef_hook>
> > 
> > Signed-off-by: zhuqiuer <zhuqiuer1@huawei.com>
> > ---
> >  arch/arm/vfp/vfpinstr.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/vfp/vfpinstr.h b/arch/arm/vfp/vfpinstr.h
> > index 3c7938fd40aa..e70129e10b8e 100644
> > --- a/arch/arm/vfp/vfpinstr.h
> > +++ b/arch/arm/vfp/vfpinstr.h
> > @@ -68,7 +68,7 @@
> >  	u32 __v;			\
> >  	asm(".fpu	vfpv2\n"	\
> >  	    "vmrs	%0, " #_vfp_	\
> > -	    : "=r" (__v) : : "cc");	\
> > +	    : "=r" (__v) : : "memory", "cc");	\
> >  	__v;				\
> >   })
> >  
> > -- 
> > 2.12.3
> > 
> 
> This seems like the same issue that Ard was addressing with this patch
> at https://lore.kernel.org/20240318093004.117153-2-ardb+git@google.com/,
> does that change work for your situation as well? I do not really have a
> strong preference between the two approaches, Ard also mentioned using
> *current in the asm constraints as another option.

Sorry for not reading Ard's thread at first. 
Yes, using "asm volatile" also worked for our case, and it was our previous solution. 
But we later switched to the memory clobber due to the same reason that you mentioned in Ard's thread. 
We believe that a memory clobber is robust enough to prevent the reordering situation mentioned.

v1 -> v2: Adding a memory clobber the fmxr instruction.

