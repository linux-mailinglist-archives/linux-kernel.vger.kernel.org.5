Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352A37781BF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236244AbjHJToY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236404AbjHJToU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:44:20 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0665426B6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:44:20 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bc7e65ea44so9417695ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691696659; x=1692301459;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Y7zOvxXwIuA5rgiamcnWYKungJc3z5komgZPppKVkg=;
        b=D0sQojkFas15jrjLj99bibUCBLyzaQ7EgzRCtjHmB2i4oUZHoeNZLK12l/pTqSvM0T
         q6y/4jjDt61peozlrloDOuif9MPZG/sgfEQLyRBiA5oLQNfPwLqYTbYMqTNzSEvc+vrc
         83aOhjzfayJEp76O/mjpCco4pZPBabArlbwQnjtw8WfLRWhwz97rli2Y+wH4/C/Q33xs
         WQw9CYmYUTxikLEWcV2Q25ZtcBWMP9U/CmM73HHATYmRnGCFa8K5dEtcgkWln8nclwub
         vqiEVq4AMBdLcoqur0nyjBxwgKeqG7aze6fs0uZjelm6XtXjvGb5cEhAvGoB/PEohCEq
         oQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691696659; x=1692301459;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Y7zOvxXwIuA5rgiamcnWYKungJc3z5komgZPppKVkg=;
        b=NPy3xYiwJAtKRXoIypWf9WR5/YknEXu1/VBJGKK6Vagqolj2LR6Kn0f1OoasKBf122
         zl1qHdizae2nxw61GeGD4FQFXkIibIislzIA9Pdhqm3tVFJt7/w+iPl8scnryxH/j3eM
         C4k6kSw+ZQdBZ+nL18dJ+T9HAHFQDR2CkrmPOJKoX8YBNh8ogzES0A8pnF7bufZxFhzS
         05j9q6WCU9+9QAlWnSqChl2GTwuvPXpNOP3pJPrxVGhAkOmC3mRIX4Mm/5PMy9eY+D9w
         ui9N0hreIhp/RD+0fzj3iPqcr1zsSHoEoIiJntkZA5+H5oo/RUc0FQvhN569/OhJysti
         8Tew==
X-Gm-Message-State: AOJu0YzodY1XMwJuWw5Ee0AGs7z36v7Jf1CRWTMxTJFpQ5wQCWpYS4oK
        SHMZ+ut/CeCCNLIBgKCR8ZoFetOBHYqpvBNcqrA=
X-Google-Smtp-Source: AGHT+IE2eIz04tQ3tBDeTsX6jx4bnSOGfuo5x1j5j2oFvlwLIMiEXDUvEPMKiaI3BkU4/JtlhziMaQ==
X-Received: by 2002:a17:902:a40f:b0:1bd:9c43:c887 with SMTP id p15-20020a170902a40f00b001bd9c43c887mr3338597plq.10.1691696659289;
        Thu, 10 Aug 2023 12:44:19 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id je1-20020a170903264100b001bb9aadfb04sm2160601plb.220.2023.08.10.12.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 12:44:18 -0700 (PDT)
In-Reply-To: <20230808-riscv_static-v2-1-2a1e2d2c7a4f@google.com>
References: <20230808-riscv_static-v2-1-2a1e2d2c7a4f@google.com>
Subject: Re: [PATCH v2] riscv: mm: fix 2 instances of
 -Wmissing-variable-declarations
Message-Id: <169169664361.3729.4946663711060334827.b4-ty@rivosinc.com>
Date:   Thu, 10 Aug 2023 12:44:03 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kernel test robot <lkp@intel.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 08 Aug 2023 09:35:00 -0700, Nick Desaulniers wrote:
> I'm looking to enable -Wmissing-variable-declarations behind W=1. 0day
> bot spotted the following instance in ARCH=riscv builds:
> 
>   arch/riscv/mm/init.c:276:7: warning: no previous extern declaration
>   for non-static variable 'trampoline_pg_dir'
>   [-Wmissing-variable-declarations]
>   276 | pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
>       |       ^
>   arch/riscv/mm/init.c:276:1: note: declare 'static' if the variable is
>   not intended to be used outside of this translation unit
>   276 | pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
>       | ^
>   arch/riscv/mm/init.c:279:7: warning: no previous extern declaration
>   for non-static variable 'early_pg_dir'
>   [-Wmissing-variable-declarations]
>   279 | pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
>       |       ^
>   arch/riscv/mm/init.c:279:1: note: declare 'static' if the variable is
>   not intended to be used outside of this translation unit
>   279 | pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
>       | ^
> 
> [...]

Applied, thanks!

[1/1] riscv: mm: fix 2 instances of -Wmissing-variable-declarations
      https://git.kernel.org/palmer/c/d2402048bc8a

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

