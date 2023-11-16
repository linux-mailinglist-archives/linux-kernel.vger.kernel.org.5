Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C781B7EE891
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 22:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjKPVAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 16:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKPVAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 16:00:31 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F1CD68
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 13:00:25 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5c7045e972dso610117b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 13:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700168424; x=1700773224; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pcg1jHOi88FLN7hCqkcZwcR8zkGGhGMDTBufXRqyOok=;
        b=AR8LC9RdzQJ6e04orRQ7NovChpkme4uD8a5w8U6EF3WUGxEuLhURPJTy96rf3K4WNQ
         xxE8sD7/d3QeR+YsUnwL0t5v7PZ70vsTr+Bd1xceYyZx2I8BC5Zt5HKTqJTCKcxVxKmh
         35TdC1VPrs8AdH1hr5SatgucrL3Y5+9Bs0t1NfLBqwJM6o6y2vGjM9+/C0lTaHwuVY+r
         lRe/yBmNqO+6EZkX/WhUQRyWdRoDD05/VHwJb0B0qyJ2Fob6cmgQwA7MdHE5KMTEz0lT
         xtLMml7o5rQD6n4+cQIRCtXO0HDgRih3fpwt8Qp2XhCAXNQCxaqWg4qKY5XmzysECn8X
         JLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700168424; x=1700773224;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pcg1jHOi88FLN7hCqkcZwcR8zkGGhGMDTBufXRqyOok=;
        b=f4bov+i0RdYHu1zjCRZMyO1ocbGIYQXWmCEWc/3FkHnhgpgl4G8Zoqt762oZ8OQ0f7
         ouu560tlJoeBhzx0PHYY+yfdoU2DI1j35UjvT9CZ0XqzzWGzmvYZSVKTH9UVIa/scmim
         shXkanlZldyZl7iZ7A5X1eawm95JhkJAoF6E+al50rDDPyz/j//lxgJV9O5sIqUADFwg
         z7f+FNd+xR0o93W1MzuCKBojq5BVWepW5gU8f+wDySEYtjCBA/pHNJ73BD5+fQA/pDK4
         TrQLKB0xTGOfuz7Rd5ZXZlFrBLCfe7fRWMRPXl2m2S2217VmJJmbko05cc8Ml8TgKOP7
         xxdA==
X-Gm-Message-State: AOJu0YzK4Wg9Kqkrl3RuEspznnB60eKDe6dYlaX/blTsk6AOpf4Y5NXF
        +xNJwopxG8ChWfaESj0dhgmwgbX15qw2X0dmjQ==
X-Google-Smtp-Source: AGHT+IERExc4D+qrt27go/xYBPrtoAORZdvfQFtSO07pMqMqSuTLQB8wBOPMZT1riqPUGW5/Jxx9EA2kvlBTv30QyA==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a25:7644:0:b0:da3:a4ae:1525 with SMTP
 id r65-20020a257644000000b00da3a4ae1525mr393167ybc.5.1700168424573; Thu, 16
 Nov 2023 13:00:24 -0800 (PST)
Date:   Thu, 16 Nov 2023 21:00:22 +0000
In-Reply-To: <20231105163040.14904-33-pbonzini@redhat.com> (message from Paolo
 Bonzini on Sun,  5 Nov 2023 17:30:35 +0100)
Mime-Version: 1.0
Message-ID: <diqzfs15o1ll.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [PATCH 32/34] KVM: selftests: Add basic selftest for guest_memfd()
From:   Ackerley Tng <ackerleytng@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     pbonzini@redhat.com, maz@kernel.org, oliver.upton@linux.dev,
        chenhuacai@kernel.org, mpe@ellerman.id.au, anup@brainfault.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, seanjc@google.com, viro@zeniv.linux.org.uk,
        brauner@kernel.org, willy@infradead.org, akpm@linux-foundation.org,
        kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xiaoyao.li@intel.com, yilun.xu@intel.com,
        chao.p.peng@linux.intel.com, tabba@google.com, jarkko@kernel.org,
        amoorthy@google.com, dmatlack@google.com,
        yu.c.zhang@linux.intel.com, isaku.yamahata@intel.com,
        mic@digikod.net, vbabka@suse.cz, vannapurve@google.com,
        mail@maciej.szmigiero.name, david@redhat.com, qperret@google.com,
        michael.roth@amd.com, wei.w.wang@intel.com,
        liam.merwick@oracle.com, isaku.yamahata@gmail.com,
        kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> <snip>
>
> +static void test_create_guest_memfd_invalid(struct kvm_vm *vm)
> +{
> +	size_t page_size = getpagesize();
> +	uint64_t flag;
> +	size_t size;
> +	int fd;
> +
> +	for (size = 1; size < page_size; size++) {
> +		fd = __vm_create_guest_memfd(vm, size, 0);
> +		TEST_ASSERT(fd == -1 && errno == EINVAL,
> +			    "guest_memfd() with non-page-aligned page size '0x%lx' should fail with EINVAL",
> +			    size);
> +	}
> +
> +	for (flag = 1; flag; flag <<= 1) {

Since transparent hugepage support is no longer officially part of this
series, 

> +		uint64_t bit;

this declaration of bit can be removed.

> +
> +		fd = __vm_create_guest_memfd(vm, page_size, flag);
> +		TEST_ASSERT(fd == -1 && errno == EINVAL,
> +			    "guest_memfd() with flag '0x%lx' should fail with EINVAL",
> +			    flag);
> +

This loop can also be removed,

> +		for_each_set_bit(bit, &valid_flags, 64) {
> +			fd = __vm_create_guest_memfd(vm, page_size, flag | BIT_ULL(bit));
> +			TEST_ASSERT(fd == -1 && errno == EINVAL,
> +				    "guest_memfd() with flags '0x%llx' should fail with EINVAL",
> +				    flag | BIT_ULL(bit));
> +		}

otherwise this won't compile because valid_flags is not declared.

These lines will have to be added back when adding transparent hugepage
support.

> +	}
> +}

Tested-by: Ackerley Tng <ackerleytng@google.com>
