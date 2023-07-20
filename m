Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960F175B0F4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 16:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjGTONq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 10:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjGTONm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:13:42 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341A12135
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 07:13:40 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b93fba1f62so12411041fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 07:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689862418; x=1690467218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ERQ0Qu3T6Bz3k+ywQiOUif0b4ZsQ7lChxmwFwBw8hTs=;
        b=HSBJvB5Cd67p4JvLMey/aDWMBCFn6p1aofMqSm7puXk2Ghe97RK1IUwyT6UeEcagmt
         B8vCUMxGdt03qsSm2JDLEOeYj6H9FosR8gPhmQ6SoMRYcvbEpSs+O/vOG8h0AQkFlAaz
         R4cDr1oN0ubZLBRmJWWgGUlzR4z932clQBBY3uJ9ywJIW8WCU0korUD/d1k0Ml8dzzTc
         r6q4hd4x/meKCqpCDr6JrjKIo+NozsTwnXXaI14miR1xwv9klqL99XDDcY70E6oqsbO4
         pIv5z8jI58a6jpZkME/nitDks7wnthn9AsUerus6IeW2wwvLxVbuqUqDxOhnpkAU4JZw
         IrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689862418; x=1690467218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERQ0Qu3T6Bz3k+ywQiOUif0b4ZsQ7lChxmwFwBw8hTs=;
        b=FIkyXFAcnhw6MV5yp5wE0qxijBbDVWVT0sh9qhwccjChQoftldoaDMShJ6y9H2UVbm
         ZWqeniG2joV/Ow0Cdm6R1gxOf/QE7sjiLK2fUNjP6FmiFEbepZGJ5gzlVwofVxsxTwuJ
         iOZVzWAsvQSUm6mohXnZdl6PQxO0+tSODB5ean7E5cqPlTDfzFgadSWR1o6WScmYDkPF
         V1ujLDy/fcrOEJUy7pzDdgUVqSOJggYISqSEwmTDY7Sy8S0Hbaw/BRbournw/X9Ax72X
         /kaA39IsSzMQsRhhy8DJHjEKJo8qm3fYHJWq8hEZEQbTH6mhxZ3pnq7BPzdrR+/mno9+
         s30A==
X-Gm-Message-State: ABy/qLYE23ACo/3tq7iK1oePL7qxNZ7TQ7WjacPBmhQy+nlGAlk4kY6b
        +QHMGfYNq2bbNkwVjCWTf9Te5A==
X-Google-Smtp-Source: APBJJlHBphGKstGk7EBxhAe0LG1t1rqwF3LxHgC2TQIHknyOF/bOOSmH41DtrjQ6hKYblqDd4QJoEw==
X-Received: by 2002:a2e:9695:0:b0:2b6:dc55:c3c7 with SMTP id q21-20020a2e9695000000b002b6dc55c3c7mr2066251lji.20.1689862418392;
        Thu, 20 Jul 2023 07:13:38 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n15-20020a1c720f000000b003fc0505be19sm1270545wmc.37.2023.07.20.07.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 07:13:35 -0700 (PDT)
Date:   Thu, 20 Jul 2023 17:13:33 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Linke Li <lilinke99@foxmail.com>
Cc:     linux-mm@kvack.org, mike.kravetz@oracle.com, muchun.song@linux.dev,
        nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Linke Li <lilinke99@gmail.com>
Subject: Re: [PATCH v2] hugetlbfs: Fix integer overflow check in
 hugetlbfs_file_mmap()
Message-ID: <5630f9d8-660f-46ec-8e44-91b00e301bb2@kadam.mountain>
References: <tencent_710619B2865DE8AC059D51A027D919CBD00A@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_710619B2865DE8AC059D51A027D919CBD00A@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 09:49:39PM +0800, Linke Li wrote:
> From: Linke Li <lilinke99@gmail.com>
> 
> ```
> 	vma_len = (loff_t)(vma->vm_end - vma->vm_start);
> 	len = vma_len + ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
> 	/* check for overflow */
> 	if (len < vma_len)
> 		return -EINVAL;
> ```
> 
> There is a signed integer overflow in the code, which is undefined
> behavior according to the C stacnard. Although kernel disables some
> optimizations by using the "-fno-strict-overflow" option, there is
> still a risk.

It's not a risk.  Better to say, "although this works, it's still a bit
ugly and static checkers will complain".

I wouldn't have commented on the commit message except that this patch
checkpatch warning so you're going to have to redo it anyway.  Run
scripts/checkpatch.pl on your patches before sending them.

WARNING: please, no spaces at the start of a line
#49: FILE: fs/hugetlbfs/inode.c:158:
+    if (check_add_overflow(vma_len, (loff_t)vma->vm_pgoff << PAGE_SHIFT, &len))$

WARNING: suspect code indent for conditional statements (4, 16)
#49: FILE: fs/hugetlbfs/inode.c:158:
+    if (check_add_overflow(vma_len, (loff_t)vma->vm_pgoff << PAGE_SHIFT, &len))
                return -EINVAL;

total: 0 errors, 2 warnings, 10 lines checked

regards,
dan carpenter

