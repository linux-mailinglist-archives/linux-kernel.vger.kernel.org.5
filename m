Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA4D7D864F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345504AbjJZPxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjJZPxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:53:40 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A948C1A2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:53:37 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-586b512ba0aso229597eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1698335617; x=1698940417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7hynPC3scdZ40zr3lj72+b2FKOXBK+Y3Zgo5uOul25Y=;
        b=HMu7Sn+hoYqbmiZBZbNfLjQV6cglOiSQQmXZ1B54BDsK2u88Sd4SOa8CcZHficl12R
         00myd9SWfESwPhUoprfW7rw6FknKJerBy/Iy3GHRbedMuRrJ0DAUs33C5C/O3ygM0Je2
         JDNx4Dy0CzHx53v5EJe4zmeW5SsuALSQ7DRGbI75TFLb3ofEjeTfdQ7ilB6VpY9KPw3/
         JPv/rvyLb9RA74oARlVlId9belzIcba+QBScfaM5LeoBaXyb9KIcmFIyX54i+6Qb+OMW
         6FUeM5S/edgooXzX80RW4e4fLYobTJp3jamvapkweSYBXHA8djhg+7gslNPkN+WzE9Pv
         WHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698335617; x=1698940417;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hynPC3scdZ40zr3lj72+b2FKOXBK+Y3Zgo5uOul25Y=;
        b=PuetFLGmyHt0V/kHzxNEli1mPc+hqI9fnikCsrDgTFaG+nMgRtGSL6VoBsJSRIknkG
         YtfcI0tOakk2sY+0aCRHK3QqZ7+8FUnpq+bPECnjS0M28dOPM+FCMG+14ENbgOLZcl7A
         SeHQNZkkaevSEe73LtPJv1VhaNJbeHPKvvXZkXft6+FQaKAOOJhpP3NMmFmGyXWRMXNs
         C7RxDmo0BIienInsWnKXC+pD/ZkQmg+m4pYGmX2XMfjOzg8rmURuWhfoHG259aqaWVgN
         os0S+0dVwdr6FLTsIdXTXe2IWmT6YTlilE+IFSZI6DsnxcGdmQFYv2zLriQHi9ecp+Z3
         3CQQ==
X-Gm-Message-State: AOJu0YwPsamCQHsI3rEBk01PBahRphZXEO6vd66urhMkAHEUNU0SQG83
        pCZARd4lZNbXDa5lJ7m3LaHmMA==
X-Google-Smtp-Source: AGHT+IEeyHg1dUDgFZE6ROA2MlEUvrjJFouNC+lSWthpjwRsuxTpjV+ibRRLmcvAGnBUWfF0nMVdlg==
X-Received: by 2002:a05:6870:2b15:b0:1e0:eb36:a7ed with SMTP id ld21-20020a0568702b1500b001e0eb36a7edmr22601245oab.29.1698335616806;
        Thu, 26 Oct 2023 08:53:36 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id dd4-20020a056871c80400b001ef459c9a72sm479351oac.29.2023.10.26.08.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 08:53:36 -0700 (PDT)
Date:   Thu, 26 Oct 2023 08:53:36 -0700 (PDT)
X-Google-Original-Date: Thu, 26 Oct 2023 08:49:23 PDT (-0700)
Subject:     Re: [PATCH 6/7] riscv: mm: Always flush a single MM context by ASID
In-Reply-To: <20230910-haggler-barrier-421cefb0cc79@spud>
CC:     samuel@sholland.org, alexghiti@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor@kernel.org>
Message-ID: <mhng-da5b8de5-35f0-4027-9a4a-fbdb9dc86773@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Sep 2023 12:46:38 PDT (-0700), Conor Dooley wrote:
> On Sat, Sep 09, 2023 at 03:16:34PM -0500, Samuel Holland wrote:
>> Even if ASIDs are not supported, using the single-ASID variant of the
>> sfence.vma instruction preserves TLB entries for global (kernel) pages.
>> So it is always most efficient to use the single-ASID code path.
>> 
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>
> On nommu:
> arch/riscv/include/asm/tlbflush.h:59:69: error: 'mm_context_t' has no member named 'id'
> arch/riscv/include/asm/tlbflush.h:61:9: error: implicit declaration of function 'local_flush_tlb_all_asid'; did you mean 'local_flush_tlb_all'? [-Werror=implicit-function-declaration]

I'm getting a few more build issues as well.  One's over here 
https://lore.kernel.org/r/20231026145516.25866-1-palmer@rivosinc.com , 
but I'm also getting 


In file included from /scratch/merges/ko-linux-next/linux/arch/riscv/include/asm/pgalloc.h:11,
                 from /scratch/merges/ko-linux-next/linux/arch/riscv/include/asm/efi.h:13,
                 from /scratch/merges/ko-linux-next/linux/arch/riscv/kernel/setup.c:40:
/scratch/merges/ko-linux-next/linux/arch/riscv/include/asm/tlb.h: In function 'tlb_flush':
/scratch/merges/ko-linux-next/linux/arch/riscv/include/asm/tlb.h:18:9: error: implicit declaration of function 'flush_tlb_mm'; did you mean 'flush_tlb_all'? [-Werror=implicit-function-declaration]
   18 |         flush_tlb_mm(tlb->mm);
      |         ^~~~~~~~~~~~
      |         flush_tlb_all
/scratch/merges/ko-linux-next/linux/arch/riscv/include/asm/tlb.h:18:25: error: invalid use of undefined type 'struct mmu_gather'
   18 |         flush_tlb_mm(tlb->mm);
      |                         ^~
cc1: some warnings being treated as errors

>
> Cheers,
> Conor.
