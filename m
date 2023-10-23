Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE64C7D3E8A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 20:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjJWSG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 14:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjJWSGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 14:06:54 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926D5B4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 11:06:51 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a45e7e0f9so4373158276.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 11:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698084411; x=1698689211; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V6PhEth19A3QRnVa0rNOexlvpKjNVl5clcJks12zGPI=;
        b=lF2IwynkdSmZd6K2Yo3Ryol6mz3e0uGr9np+lWu5pjWP/CwMiidoIPzz4SRbPVVJMm
         phxtjrPCiIRrOlbv9CWodzaYWEVR1KWIp5bx2voedltBgI1MAUqluLUvGDEJNdSCOfoE
         GH0vJxAPkXR6x9JnzGvDvx8xl9c5ns/8MQaGhe6OzjUItQFtRaw3X13t3XqeNrC1ZKfV
         hWrjFVlJyLYAa+UxGqXirFyeBXRNWp0vD9uvsV1F/ZYX4R7NzBEcNuEC4eqKI28cVKRC
         KtVQPX1w76EfSrr6vFGdRZBJXNOqF+3qXjyaYgDVqUuydINgZ4IFN57B1CDIrLICzSn3
         deWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698084411; x=1698689211;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V6PhEth19A3QRnVa0rNOexlvpKjNVl5clcJks12zGPI=;
        b=ZK2wJov/uIONuizwd0/cmAW6363VY+kB4G3onaiw5NBl/imuFNgzsRA8CMWoADUylI
         eyb7yQiMj8WQErsG2YXUwpgiRA1OcNy4W8S57WahpnMzShFDUCoXkhg8SIJI2iC/k0gD
         AqXqaij+4QeRShqxjslr68Yb1ka8i7iWsW4CqsTsiWLlxdLGydjsps8k4tqjRoCYWyy+
         Q1fMkL+BwnTCDFdvwv3luHuILAIX9NRzx4yp/QZMLNOtcoxDiA6MUuzjERCyzWV9RVhg
         LDjDAjibDWQrSecQndfpeM39SEy5ZDr5N1biplDtODAFpnmSyMEmmiv7eLDrAE/HtknB
         oz6g==
X-Gm-Message-State: AOJu0YwESGYSva9Ga9U4eLPSLtO6Afoqecw1XAohuNEwJHqhbgBdUujb
        Yn2E8/H6HJ4nyprJFlf+5UnCrNzyhbA=
X-Google-Smtp-Source: AGHT+IHuxP2goBRurlTWeNgMm9ZNa3uPxmMsM4p/o7jqI2HG+UsLgu+MqrbGPegwQLN37IYjlwnDBTjBShE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1743:b0:d90:e642:d9fc with SMTP id
 bz3-20020a056902174300b00d90e642d9fcmr189695ybb.6.1698084410842; Mon, 23 Oct
 2023 11:06:50 -0700 (PDT)
Date:   Mon, 23 Oct 2023 11:06:49 -0700
In-Reply-To: <ZS8wdNtAoSvH_jpX@google.com>
Mime-Version: 1.0
References: <20231016184737.1027930-1-michael.roth@amd.com> <ZS8wdNtAoSvH_jpX@google.com>
Message-ID: <ZTa2OWVjSOUtm0Ea@google.com>
Subject: Re: [PATCH gmem] KVM: selftests: Fix gmem conversion tests for
 multiple vCPUs
From:   Sean Christopherson <seanjc@google.com>
To:     Michael Roth <michael.roth@amd.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, vannapurve@google.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023, Sean Christopherson wrote:
> On Mon, Oct 16, 2023, Michael Roth wrote:
> > +			vm_mem_add(vm, src_type, BASE_DATA_GPA + size * i,
> > +				   BASE_DATA_SLOT + i, size / vm->page_size,
> > +				   KVM_MEM_PRIVATE, memfd, size * i);
> 
> But I think that's a moot point, because isn't it easier to do this?
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c b/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c
> index c04e7d61a585..c99073098f98 100644
> --- a/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c
> @@ -367,6 +367,7 @@ static void test_mem_conversions(enum vm_mem_backing_src_type src_type, uint32_t
>          */
>         const size_t size = align_up(PER_CPU_DATA_SIZE, get_backing_src_pagesz(src_type));
>         const size_t memfd_size = size * nr_vcpus;
> +       const size_t slot_size = memfd_size / nr_memslots;
>         struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
>         pthread_t threads[KVM_MAX_VCPUS];
>         uint64_t gmem_flags;
> @@ -390,7 +391,7 @@ static void test_mem_conversions(enum vm_mem_backing_src_type src_type, uint32_t
>  
>         for (i = 0; i < nr_memslots; i++)
>                 vm_mem_add(vm, src_type, BASE_DATA_GPA + size * i,
> -                          BASE_DATA_SLOT + i, size / vm->page_size,
> +                          BASE_DATA_SLOT + i, slot_size / vm->page_size,
>                            KVM_MEM_PRIVATE, memfd, size * i);

This isn't quite right, the stride and offset needs to be per-memslot too.  Argh,
I created quite the mess by trying to take a shortcut for testing multiple memslots,
i.e. by only allowing '1' or "nr_vcpus" memslots.  Much of the code assumes that
ranges can't be covered by multiple memslots, e.g. the UCALL_SYNC handler assumes
the entire range is contiguous in the host virtual address space.

And I think there's meaningful coverage we're not getting, e.g. as is I don't think
we're testing KVM_SET_MEMORY_ATTRIBUTES across multiple memslots (thankfully we
seem to have gotten the KVM side of things correct).

I'll post a small series to clean up the mess and let the user specify the number
of memslots (with some restrictions to keep the code relatively simple).
