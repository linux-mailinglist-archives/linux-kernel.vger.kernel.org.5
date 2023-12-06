Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8106D8074EB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378036AbjLFQ26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjLFQ24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:28:56 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924C3D44
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 08:29:02 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6d9ae075e5fso495828a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 08:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1701880142; x=1702484942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B5ZbGGmoH/lFlZhMRZN1vjFtS/EFqjm5PsB2wakbCe8=;
        b=JUP9Q7hQu9MmC8qT+pvq4Rvvq1eyIaYqOLTyljMFCuaeJS7pJri5kF+MfbVN26lg8h
         NbQAtypwudwKwgAnl4F2e4YIGPKgeXQvCYWKRhvhrePNzfDBNQjnAmx3w0yttDn3Oh3u
         ELEA6s41uIP/aJhbtXh+sPC9yDZT9uIzzw8hYMBOlmldIVohtdFSayFtHKXNaNvqL5pG
         9tblrpZ2IEvFHK9wSOzSLLFgV4RzVHl/wk4ZebAjuD4uzFEHnsFLXVCabYheSQxM0mcF
         YHN8LrpFy1MRsuxZMFzIztIK7s5iEy3vvBvlIQEWH2LK3ZJgZDe+ojzcDzEyyNwMYljO
         5Fmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701880142; x=1702484942;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5ZbGGmoH/lFlZhMRZN1vjFtS/EFqjm5PsB2wakbCe8=;
        b=q8k+lSms88OqR/t389FDYUMlFGtmqA0jOgee4G9i2D8O8pW55fT5j63yf30WYrwfO5
         2d/gECgI4AArpdfJxpL6KVBHVahNlCI7ZPfKHhpa6Vitt1z5x41hXVMPa+yTGNVKcJ+X
         38qUHThWv0baslRb1j7t2YDdDQXnRxCaNUXFnLiTx83W+hFXOPaWKgnXH2jfPa5un83e
         7QvgzMO6Q/9DpNVpBFoNqPaTpS3efesUfqruyT1sFH6Z/fRoxB2Njt17vsLoNe8SxW0v
         W0ZZnhr+sCW2D//3Z7KYGW0qj+BmuFrql/dTmjxAiuD6O7x8yZ8CKjYP9YJnNB2z65MB
         MnyA==
X-Gm-Message-State: AOJu0YxbDJGNaP7CQxhB+FHVRX3sDRrbrrio6DbXyzZQdmI2MwLvK0FR
        goyhYaTa7aXCb5RshZA50QQ3QA==
X-Google-Smtp-Source: AGHT+IGn8NLklrz8gfLpf4ZROBA91oSNRaf0+Ba33U1gJX5IEC3OyhkihvKkTQRDR3ZHIRtV5+wHCg==
X-Received: by 2002:a9d:6385:0:b0:6d9:9ed9:f0e0 with SMTP id w5-20020a9d6385000000b006d99ed9f0e0mr559336otk.14.1701880141802;
        Wed, 06 Dec 2023 08:29:01 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id c25-20020a9d6859000000b006d9a0bf775asm24697oto.7.2023.12.06.08.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 08:29:01 -0800 (PST)
Date:   Wed, 06 Dec 2023 08:29:01 -0800 (PST)
X-Google-Original-Date: Wed, 06 Dec 2023 08:28:59 PST (-0800)
Subject:     Re: [PATCH v2] selftests: sud_test: return correct emulated syscall value on RISC-V
In-Reply-To: <20231206134438.473166-1-cleger@rivosinc.com>
CC:     shuah@kernel.org, krisman@collabora.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, cleger@rivosinc.com,
        Bjorn Topel <bjorn@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     cleger@rivosinc.com, tglx@linutronix.de
Message-ID: <mhng-bd5d2bdb-99ab-464a-a043-bdfc34b96b71@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Dec 2023 05:44:37 PST (-0800), cleger@rivosinc.com wrote:
> Currently, the sud_test expects the emulated syscall to return the
> emulated syscall number. This assumption only works on architectures
> were the syscall calling convention use the same register for syscall
> number/syscall return value. This is not the case for RISC-V and thus
> the return value must be also emulated using the provided ucontext.
>
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>
> ---
>
> Changes in V2:
>  - Changes comment to be more explicit
>  - Use A7 syscall arg rather than hardcoding MAGIC_SYSCALL_1
>
> ---
>  .../selftests/syscall_user_dispatch/sud_test.c     | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_test.c b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
> index b5d592d4099e..d975a6767329 100644
> --- a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
> +++ b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
> @@ -158,6 +158,20 @@ static void handle_sigsys(int sig, siginfo_t *info, void *ucontext)
>
>  	/* In preparation for sigreturn. */
>  	SYSCALL_DISPATCH_OFF(glob_sel);
> +
> +	/*
> +	 * The tests for argument handling assume that `syscall(x) == x`. This
> +	 * is a NOP on x86 because the syscall number is passed in %rax, which
> +	 * happens to also be the function ABI return register.  Other
> +	 * architectures may need to swizzle the arguments around.
> +	 */
> +#if defined(__riscv)
> +/* REG_A7 is not defined in libc headers */
> +# define REG_A7 (REG_A0 + 7)
> +
> +	((ucontext_t *)ucontext)->uc_mcontext.__gregs[REG_A0] =
> +			((ucontext_t *)ucontext)->uc_mcontext.__gregs[REG_A7];
> +#endif
>  }
>
>  TEST(dispatch_and_return)

Thanks.

Thomas: looks like you picked up all the commits that touched this?  No 
rush on my end, just LMK if you want me to pick it up -- I'm going to 
leave it alone for now.
