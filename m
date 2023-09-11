Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FCA79ACBB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354856AbjIKVzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243401AbjIKRJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:09:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30C35121
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 10:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694452123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TFJAPZqdXWh1lxYffHvCizRcNAf7dvvGam28HNGiWK4=;
        b=Y8TKZppQ4HRhLCBrBaXuGGreCAHK0+EGLHGfg7OAb6lYrdHWu7N2LBRnTJT8r0MrKPQH3A
        PXkY39UJEtK8Oy9mUEkclXxwV+s45lptpbPpqgTycq1oAy9vDqOKZaK+zZXVLTGsBV51Gl
        wdsTvTqRivrSBfoFOkY62cY/tybTpeM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-jXzBky-KMiGssS4mWH4DVQ-1; Mon, 11 Sep 2023 13:08:41 -0400
X-MC-Unique: jXzBky-KMiGssS4mWH4DVQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-402d63aeea0so38730255e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 10:08:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694452120; x=1695056920;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TFJAPZqdXWh1lxYffHvCizRcNAf7dvvGam28HNGiWK4=;
        b=pbV3c3FmJh292K0oUFAow6oGzMNDuvsLkkBQeupL+ib87jiO2L96gXg65focyLbcoG
         IJ3Z7tSfU1oFAG3wa8vOkfZA+ix+5RuuUymVy2H0476hCWcoPNhWuG6zI98GfkFx/D0Q
         e7/xZ+t0b3GrKLZMnqZTGdyQQTrf1rhpbrrZVG88Taq4hmqzDQsD5tyi9/FvqhmdsUsm
         Jpl2f/tn/wZ1bvJmvmslYyObmYz94ZjtXWJucea11UdakwF2sHGfFNeq58NRAo/DbzmY
         3wVgNcGl4Oc7Hef59QNGPfAK+qaYHh2n9dcz5R/QjHq2vyj1vcND55rxuZ/oQfiKADUt
         8Wag==
X-Gm-Message-State: AOJu0YzumkBwV2O8A9B51HpgVvGS2OvSY3FEcbsac3bpOErypWjEYrl0
        vyinZ+zI11/UiBnNTlPNHqWpjwFrUagK1UETkB0hDYL2+7/QX6o3oAzGvtWFgQfD5kE2fJlm2vg
        WJ/hu/qGGqUVwvdCURUEoYfKN
X-Received: by 2002:a5d:4ac3:0:b0:317:6cc7:6b21 with SMTP id y3-20020a5d4ac3000000b003176cc76b21mr8290470wrs.69.1694452120735;
        Mon, 11 Sep 2023 10:08:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUedehlTzYxcOKDjdVMIJCttCDP0JHpSvJOzbF3mH6QXBs3v3oC+AeQ9XRFhb/mxgueGunqA==
X-Received: by 2002:a5d:4ac3:0:b0:317:6cc7:6b21 with SMTP id y3-20020a5d4ac3000000b003176cc76b21mr8290447wrs.69.1694452120403;
        Mon, 11 Sep 2023 10:08:40 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id b4-20020a05600003c400b0030fd03e3d25sm3644406wrg.75.2023.09.11.10.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 10:08:39 -0700 (PDT)
Message-ID: <a64122a6-0be1-8263-4629-8cae0c013305@redhat.com>
Date:   Mon, 11 Sep 2023 19:08:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 00/12] Unify TDCALL/SEAMCALL and TDVMCALL assembly
Content-Language: en-US
To:     Kai Huang <kai.huang@intel.com>, peterz@infradead.org,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, seanjc@google.com,
        isaku.yamahata@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        n.borisov.lkml@gmail.com
References: <cover.1692096753.git.kai.huang@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <cover.1692096753.git.kai.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/23 13:01, Kai Huang wrote:
> Hi Peter, Kirill,
> 
> This series unifies the assembly code for TDCALL/SEAMCALL and TDVMCALL.
> Now all of them use one singe TDX_MODULE_CALL asm macro.  More
> information please see cover letter of v2 (see link below).
> 
> Tested by booting TDX guest, initializing TDX module, and running TDX
> guest successfully, all with this series applied.

Not sure it if's new in this version but I'm seeing

     WARNING: modpost: EXPORT symbol "__seamcall_ret" [vmlinux] version ...
     Is "__seamcall_ret" prototyped in <asm/asm-prototypes.h>?
     WARNING: modpost: EXPORT symbol "__seamcall" [vmlinux] version ...
     Is "__seamcall" prototyped in <asm/asm-prototypes.h>?
     WARNING: modpost: EXPORT symbol "__seamcall_saved_ret" [vmlinux] version ...
     Is "__seamcall_saved_ret" prototyped in <asm/asm-prototypes.h>?

which is fixed by

diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
index 8f80de627c60..eff5252e9c86 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -6,6 +6,7 @@
  #include <asm/page.h>
  #include <asm/checksum.h>
  #include <asm/mce.h>
+#include <asm/tdx.h>
  
  #include <asm-generic/asm-prototypes.h>
  

Paolo

> ------- Histroy --------
> 
> v3 -> v4:
> 
>   - Addressed Kirill's minor comments
>   - Collected Reviewed-by tags from Kirill/Sathy.
>   - Collected Isaku's Tested-by tag.
>   - Removed unneeded header file inclusion in tdcall.S in the relevant
>     two patches.
>   - Rebased to latest tip/x86/tdx (v6.5-rc5).
> 
> v3: https://lore.kernel.org/lkml/20230806114131.2ilofgmxhdaa2u6b@box.shutemov.name/T/
> 
> v2 -> v3:
> 
>   - New patch (patch 12) to adjust 'struct tdx_module_args' layout to
>     match KVM's "vcpu::regs[]" for VP.ENTER. (Peter)
>   - Added __seamcall_saved_ret() wrapper to support VP.ENTER (merged to
>     patch 10).
>   - Fixed a 'noinstr' check build regression found by LKP (patch 7).
>   - Rebased to latest Linus's tree (6.5-rc3 + 2 commits).
> 
> v2: https://lore.kernel.org/lkml/a23ce8fd289141cea3a1b4f3dace221dca847238.camel@intel.com/T/
> 
> v1 -> v2:
>   - Rebased to 6.5-rc2.
>   - Fixed comments from Peter and others.
>   - Split patch "x86/tdx: Unify TDX_HYPERCALL and TDX_MODULE_CALL assembly"
>     into three smaller patches for better review.
>   - A new patch to skip saving output registers when SEAMCALL fails due to
>     VMFailInvalid.
>   - Removed patch "x86/tdx: Use cmovc to save a label in TDX_MODULE_CALL asm"
>   - Merged patch "x86/tdx: Move FRAME_BEGIN/END to TDX_MODULE_CALL asm macro"
>     to the new patch mentioned above.
> 
> v1: https://lore.kernel.org/lkml/b95c4169-88c8-219e-87b7-6c4e058c246a@suse.com/T/
> 
> 
> 
> Kai Huang (12):
>    x86/tdx: Zero out the missing RSI in TDX_HYPERCALL macro
>    x86/tdx: Skip saving output regs when SEAMCALL fails with
>      VMFailInvalid
>    x86/tdx: Make macros of TDCALLs consistent with the spec
>    x86/tdx: Rename __tdx_module_call() to __tdcall()
>    x86/tdx: Pass TDCALL/SEAMCALL input/output registers via a structure
>    x86/tdx: Extend TDX_MODULE_CALL to support more TDCALL/SEAMCALL leafs
>    x86/tdx: Make TDX_HYPERCALL asm similar to TDX_MODULE_CALL
>    x86/tdx: Reimplement __tdx_hypercall() using TDX_MODULE_CALL asm
>    x86/tdx: Remove 'struct tdx_hypercall_args'
>    x86/virt/tdx: Wire up basic SEAMCALL functions
>    x86/virt/tdx: Make TDX_MODULE_CALL handle SEAMCALL #UD and #GP
>    x86/virt/tdx: Adjust 'struct tdx_module_args' to use x86 "register
>      index" layout
> 
>   arch/x86/Kconfig                  |  12 ++
>   arch/x86/Makefile                 |   2 +
>   arch/x86/boot/compressed/tdx.c    |   6 +-
>   arch/x86/coco/tdx/tdcall.S        | 234 ++++--------------------------
>   arch/x86/coco/tdx/tdx-shared.c    |  28 +++-
>   arch/x86/coco/tdx/tdx.c           |  71 +++++----
>   arch/x86/include/asm/shared/tdx.h |  92 +++++++-----
>   arch/x86/include/asm/tdx.h        |  11 ++
>   arch/x86/kernel/asm-offsets.c     |  33 ++---
>   arch/x86/virt/Makefile            |   2 +
>   arch/x86/virt/vmx/Makefile        |   2 +
>   arch/x86/virt/vmx/tdx/Makefile    |   2 +
>   arch/x86/virt/vmx/tdx/seamcall.S  |  61 ++++++++
>   arch/x86/virt/vmx/tdx/tdxcall.S   | 230 ++++++++++++++++++++++-------
>   14 files changed, 435 insertions(+), 351 deletions(-)
>   create mode 100644 arch/x86/virt/Makefile
>   create mode 100644 arch/x86/virt/vmx/Makefile
>   create mode 100644 arch/x86/virt/vmx/tdx/Makefile
>   create mode 100644 arch/x86/virt/vmx/tdx/seamcall.S
> 
> 
> base-commit: 52a93d39b17dc7eb98b6aa3edb93943248e03b2f

