Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC437D0A71
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbjJTITo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjJTITl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:19:41 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDA9BE
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 01:19:40 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4084e49a5e5so4496125e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 01:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697789978; x=1698394778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J6McO7iCkNBRBCpKgUqgVhPb6Hf4s6Lra6fBOLrTfMY=;
        b=aEuR/x4nmFhHzLLJCZXnahe8GUC6W2Pctg7N1/dYnlknLICLsU0J87/CDTbvEvboBU
         lRvH9zyevqHf4xDTT5jdj3X/fAvWdQfQmjVyzStBzR4yR5GYoSXKz13V4GO7y/yVsWh8
         86TruoUVpbtT6jOi3LU6FQBLka/Tnj8JOF0Ys46poyQ58XO9vQEUByukw3iCL0nzoVPv
         v0lYUbZi3goP0JbeApCbJFv1G3HQ0SAB7KtSGMBnrBKXhvQ9b627+CJn7EWDiXNn1B8X
         ftWYK32arAYm59g9QF+vvDpX+0D3UxcQvhcyWfKoCyTJa+YUITmGk0VOa3gNeO+n4x+V
         POSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697789978; x=1698394778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6McO7iCkNBRBCpKgUqgVhPb6Hf4s6Lra6fBOLrTfMY=;
        b=pl8/qFrY7Ukz9imeBceHs5lgqI/vnt4dseOf7aFkgFh8kTd9lItWpxeNA9wjFA8fkz
         vLioDl+KymcpxjWPIMJV/qP7IPkCB2h0/KEDd75IFTNHMJW388wmoFaVZjmd1ewYzqT/
         wCmXD3vB0kXcao0rZGSc2gpqGH7cl7QfTtgyOUpLh6DECj/fODap+y1La8vl/NquQgGF
         L+1VInp71SA0xz8gSv8qDfJMo4AhQsVFeRfYspeNnlKJC3o0+ELddm//t3CVYd22n97D
         lZZAMRAOC5XkpWrRBVTzUuzuYRHu/SCjGnERr52vSKj5a2g9GSEJNM1Z30drJkcwWmjs
         yF2w==
X-Gm-Message-State: AOJu0YwAqxv8cMqHW7EC4OYDgHiVAlixeCzds8vi+iy1PSUF95vaQLgN
        siMCf8UrMOmA5k80/XTP8t73XQ==
X-Google-Smtp-Source: AGHT+IGhZf+aOc5CORnKxLgq2L/StMiHIhiN8RZyid6bewWMrLayatbGXf3MAx9RUOUCkHYSPuKNaQ==
X-Received: by 2002:a05:600c:3541:b0:405:40c6:2b96 with SMTP id i1-20020a05600c354100b0040540c62b96mr871419wmq.3.1697789978389;
        Fri, 20 Oct 2023 01:19:38 -0700 (PDT)
Received: from google.com (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c1d8f00b00402d34ea099sm6402498wms.29.2023.10.20.01.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 01:19:37 -0700 (PDT)
Date:   Fri, 20 Oct 2023 09:19:33 +0100
From:   Vincent Donnefort <vdonnefort@google.com>
To:     Sebastian Ene <sebastianene@google.com>
Cc:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        akpm@linux-foundation.org, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, qperret@google.com, smostafa@google.com
Subject: Re: [PATCH v2 00/11] arm64: ptdump: View the second stage page-tables
Message-ID: <ZTI4FcFkgwnLv0-1@google.com>
References: <20231019144032.2943044-1-sebastianene@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019144032.2943044-1-sebastianene@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 02:40:21PM +0000, Sebastian Ene wrote:
> Hi,
> 
> This can be used as a debugging tool for dumping the second stage
> page-tables under debugfs.
> 
> From the previous feedback I re-worked the series and added support for
> guest page-tables dumping under VHE & nVHE configuration. I extended the
> list of reviewers as I missed the interested parties in the first round. 
> 
> When CONFIG_NVHE_EL2_PTDUMP_DEBUGFS is enabled under pKVM environment,
> ptdump registers the 'host_stage2_kernel_page_tables' entry with debugfs.
> Guests are registering a file named '%u_guest_stage2_page_tables' when
> they are created. 

I believe guests entries should be also available for nVHE and VHE.

> 
> This allows us to dump the host stage-2 page-tables with the following command:
> cat /sys/kernel/debug/host_stage2_kernel_page_tables.

As it needs the debugfs anyway, this should probably live in the kvm/ debugfs
folder, while the VMs ptdump should be placed in their respective folder.

This is quite easy, you should get access to the global kvm_debugfs_dir and
struct kvm->debugfs_dentry.

> 
> The output is showing the entries in the following format:
> <IPA range> <size> <descriptor type> <access permissions> <mem_attributes>
> 
> The tool interprets the pKVM ownership annotation stored in the invalid
> entries and dumps to the console the ownership information. To be able
> to access the host stage-2 page-tables from the kernel, a new hypervisor
> call was introduced which allows us to snapshot the page-tables in a host
> provided buffer. The hypervisor call is hidden behind CONFIG_NVHE_EL2_DEBUG
> as this should be used under debugging environment.
> 
> Link to the first version:
> https://lore.kernel.org/all/20230927112517.2631674-1-sebastianene@google.com/
> 
> Changelog:
>   v1 -> v2:
>   * use the stage-2 pagetable walker for dumping descriptors instead of
>     the one provided by ptdump.
> 
>   * support for guests pagetables dumping under VHE/nVHE non-protected
> 
> Thanks,
> 
> 
> Sebastian Ene (11):
>   KVM: arm64: Add snap shooting the host stage-2 pagetables
>   arm64: ptdump: Use the mask from the state structure
>   arm64: ptdump: Add the walker function to the ptdump info structure
>   KVM: arm64: Move pagetable definitions to common header
>   arm64: ptdump: Introduce stage-2 pagetables format description
>   arm64: ptdump: Add hooks on debugfs file operations
>   arm64: ptdump: Register a debugfs entry for the host stage-2
>     page-tables
>   arm64: ptdump: Parse the host stage-2 page-tables from the snapshot
>   arm64: ptdump: Interpret memory attributes based on runtime
>     configuration
>   arm64: ptdump: Interpret pKVM ownership annotations
>   arm64: ptdump: Add support for guest stage-2 pagetables dumping
> 
>  arch/arm64/include/asm/kvm_asm.h              |   1 +
>  arch/arm64/include/asm/kvm_pgtable.h          |  85 +++
>  arch/arm64/include/asm/ptdump.h               |  27 +-
>  arch/arm64/kvm/Kconfig                        |  12 +
>  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |   8 +-
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c            |  18 +
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 103 ++++
>  arch/arm64/kvm/hyp/pgtable.c                  |  98 ++--
>  arch/arm64/kvm/mmu.c                          |   3 +
>  arch/arm64/mm/ptdump.c                        | 487 +++++++++++++++++-
>  arch/arm64/mm/ptdump_debugfs.c                |  42 +-
>  11 files changed, 822 insertions(+), 62 deletions(-)
> 
> -- 
> 2.42.0.655.g421f12c284-goog
> 
