Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F9B80B1C3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 03:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjLIC3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 21:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjLIC3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 21:29:43 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CEB1710
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 18:29:49 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db547d41413so2306616276.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 18:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702088988; x=1702693788; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4KmejgukXo7m764qqW7DNGExe6RkwfWGfLJnqMZhyJs=;
        b=nuDb//m6XLvqeI/HIhB+wXYvF153oPs6aZ5hXK2s9jrSa1pjNPSkKvpo5QFQBGD/hr
         4J5pxT6Fbj9Kz1eNEEJQEKO6XiVLj82NCRVDA9l8F9h2gX/s9I9P8I7NRSNrQgvYCM2/
         yj3YGiE/zZ7tTpbyUK1kXSv0NxT6uaKmF8jDXcG9WhocwwhgIiWHp+6DSCt4SOxCPwac
         T4mpw76lFeQ0ZRigKXOjVR4vCt/X7tX9sQ3X9aSMROSPUwtR7fmanRYzOuPp9lpUUUJW
         u1yV3Aingvoca0fa5zOucDFI/vW6rYtPIDtOFrTqjbuxx8A2AGJGNkl7gIfnSxEDJNBI
         Wqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702088988; x=1702693788;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4KmejgukXo7m764qqW7DNGExe6RkwfWGfLJnqMZhyJs=;
        b=JVZn17H5ii5o/xp2tQTJ+nSzZqrr2wk31W4QDKOl7skH6pgNUThYZRzjdyuM4SNOz4
         0AJ8mforLW3vuYzXVhgztbAtD59VeK3/t0RRXU4F5Lc3Px5Nf7r0M3rc3HznHfdWbHbB
         D3aUlQVifGIaBTqkxFxy/YKHT8Em8Sz61EfhrShGHKem7au6QsE2RC927TUqKd57njL7
         EUX4/npRqQ9ZbhAERIHYpE0t3yI+9xQ2itMQyDCGIcm01dVH9DhkkYEbWz97HSVuHWJA
         24Kh09BaGNY3dHGYf7kry7iq0xIuiG/LgFM0AKsxyW2eTBfgAojFATtnODq/7u5+cVEX
         yOhw==
X-Gm-Message-State: AOJu0YzHJzmgs7CpbZqGx+OVlIzZLg+jrbqcCJhMi0eLcwHe+gp3Tu8n
        lZDs8R7fsjKun4lxWbJ8nL+FFOwVBKA=
X-Google-Smtp-Source: AGHT+IF8bg9FcnNJFlvIumcFhDXG/a/z3zARXW8lhXG8Z7KoYcgKIL4eXnE4wsGqAe0l3/isXPMIand5drU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:14d:b0:db5:3aaf:5207 with SMTP id
 p13-20020a056902014d00b00db53aaf5207mr29309ybh.3.1702088988456; Fri, 08 Dec
 2023 18:29:48 -0800 (PST)
Date:   Fri, 8 Dec 2023 18:29:47 -0800
In-Reply-To: <20231208184628.2297994-1-pbonzini@redhat.com>
Mime-Version: 1.0
References: <20231208184628.2297994-1-pbonzini@redhat.com>
Message-ID: <ZXPRGzgWFqFdI_ep@google.com>
Subject: Re: [PATCH] KVM: selftests: fix supported_flags for aarch64
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023, Paolo Bonzini wrote:
> KVM/Arm supports readonly memslots; fix the calculation of
> supported_flags in set_memory_region_test.c, otherwise the
> test fails.

You got beat by a few hours, and by a better solution ;-)

https://lore.kernel.org/all/20231208033505.2930064-1-shahuang@redhat.com

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tools/testing/selftests/kvm/set_memory_region_test.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
> index 6637a0845acf..dfd1d1e22da3 100644
> --- a/tools/testing/selftests/kvm/set_memory_region_test.c
> +++ b/tools/testing/selftests/kvm/set_memory_region_test.c
> @@ -333,9 +333,11 @@ static void test_invalid_memory_region_flags(void)
>  	struct kvm_vm *vm;
>  	int r, i;
>  
> -#ifdef __x86_64__
> +#if defined __aarch64__ || defined __x86_64__
>  	supported_flags |= KVM_MEM_READONLY;
> +#endif
>  
> +#ifdef __x86_64__
>  	if (kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM))
>  		vm = vm_create_barebones_protected_vm();
>  	else
> -- 
> 2.39.1
> 
