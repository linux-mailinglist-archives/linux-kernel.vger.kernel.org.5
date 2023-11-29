Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1743C7FE1BE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 22:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjK2VZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 16:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjK2VZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 16:25:46 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194A0D67
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:25:52 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40b4f6006d5so1775495e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701293150; x=1701897950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mTMzjE/bDrmBMPdnzKtm66VHkni1QoAV3st9513yBEk=;
        b=R+j0WY281cHaGIfZMFQ7aRReaX7KkfsAIQM6EVfzUJXVWqUfZ2KZIaq9NL20PxyqVb
         YIKRJzE6oOsp7K3FO8r/h9Of8Aj/ry7qZJ9kLXIhUnkXL/NzQjbOeeH5vPHBJxleJIiF
         WzLQLTpIl64w6yHM+QdF6G1hRDVMDkdqdi+g0uP3YmVq6oryAmQjNgdO0IgI/DG2kKwE
         OXK0n/AZyQGcWmfoZPGFKgSluFww4TQv9pb3F1hciqc0hIDTJr9aFbUzTHV53MjMW6E5
         PyCXYfMmp15tfHUepLnFrEf465lqZQi97okCT/tubwb+ned5Vu7rnhaskWx0q9vvFrEH
         rixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701293150; x=1701897950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTMzjE/bDrmBMPdnzKtm66VHkni1QoAV3st9513yBEk=;
        b=B0m778HvSKvj5Pci3MLNMhzGbBej28ytZTHck8djQ4ubmVQPu8EOj8mCCacuxZGF6Z
         k7AoVNUp4djXUQLu8aNsTeaNM5LnqWFdJU0cMHs6TiNlcnT2LDTJJyqbHeXILNy+72nG
         e8ab8oEl0JwtXzWa1VAL41dlY+Mm9+vO1wrmvrqkOA2/9rNykWq+VQRcXbUAMy3E3mHi
         Edy3o1bDNlRq/VsevU9+M8XrJpA49Tq5y+go+SQJKq8zLm5IPo2FkD3hw0LYLr6pjJw1
         SVnaZSNKANGI0WjlV8Z6vDmUlGuRcEqMfWqyRMWQ0CyDAZHKTW06XDbQKqw4LxT99jd9
         woYA==
X-Gm-Message-State: AOJu0Yz+VniJvulYIdg2L19Ez1GO5qS4WHmqgdh5jyxE3s45br3J3T07
        wkXb95KmGssylQQE9A8F8q4=
X-Google-Smtp-Source: AGHT+IE+EmxWqIy+5n9+9PMwi5GnrH95AFgkASnDZh/3Csqh+4tOrWDSiqppGP+0YILlGYONVBNNkw==
X-Received: by 2002:a05:600c:1d1d:b0:40b:5008:9c0 with SMTP id l29-20020a05600c1d1d00b0040b500809c0mr3786010wms.9.1701293150284;
        Wed, 29 Nov 2023 13:25:50 -0800 (PST)
Received: from andrea ([31.189.63.178])
        by smtp.gmail.com with ESMTPSA id f15-20020a05600c4e8f00b0040b3632e993sm3442383wmq.46.2023.11.29.13.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 13:25:49 -0800 (PST)
Date:   Wed, 29 Nov 2023 22:25:44 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     paulmck@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, mmaas@google.com, hboehm@google.com,
        striker@us.ibm.com, charlie@rivosinc.com, rehn@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] membarrier: riscv: Provide core serializing command
Message-ID: <ZWesWCRAPV3rZlx9@andrea>
References: <20231127103235.28442-1-parri.andrea@gmail.com>
 <20231127103235.28442-3-parri.andrea@gmail.com>
 <91ab0210-07f9-42c4-af7f-a98799250cf7@efficios.com>
 <ZWYDtB/otYvTMZWd@andrea>
 <0a84c0e0-2571-4c7f-82ae-a429f467a16b@efficios.com>
 <ZWeDF0eHyOc/b9UJ@andrea>
 <53aac2ac-46ae-46b8-9fdf-34527b79a63b@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53aac2ac-46ae-46b8-9fdf-34527b79a63b@efficios.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > As regards the Fixes: tag, I guess it boils down to what we want or we
> > need to take for commit "riscv: Support membarrier private cmd".  :-)
> 
> I'm not seeing this commit in the Linux master branch, am I missing
> something ?

I don't think you're missing something: I was wondering "what/where is
this commit"?  Sorry for the confusion.


> > FWIW, a quick git-log search confirmed that MEMBARRIER has been around
> > for quite some time in the RISC-V world (though I'm not familiar with
> > any of its mainstream uses): commit 1464d00b27b2 says (at least) since
> > 93917ad50972 ("RISC-V: Add support for restartable sequence").  I am
> > currently inclined to pick the latter commit (and check it w/ Palmer),
> > but other suggestions are welcome.
> 
> Supporting membarrier private expedited is not optional since Linux 4.14:
> 
> see kernel/sched/core.c:
> 
>                 membarrier_switch_mm(rq, prev->active_mm, next->mm);
>                 /*
>                  * sys_membarrier() requires an smp_mb() between setting
>                  * rq->curr / membarrier_switch_mm() and returning to userspace.
>                  *
>                  * The below provides this either through switch_mm(), or in
>                  * case 'prev->active_mm == next->mm' through
>                  * finish_task_switch()'s mmdrop().
>                  */
>                 switch_mm_irqs_off(prev->active_mm, next->mm, next);
> 
> Failure to provide the required barrier is a bug in the architecture's
> switch_mm implementation when CONFIG_MEMBARRIER=y.
> 
> We should probably introduce a new
> Documentation/features/sched/membarrier/arch-support.txt
> to clarify this requirement.
> 
> Userspace code such as liburcu [1] heavily relies on membarrier private
> expedited (when available) to speed up RCU read-side critical sections.
> Various DNS servers, including BIND 9, use liburcu.

Thanks for the information.

So I should probably stick to 93917ad50972, which apparently selected
CONFIG_MEMBARRIER on RISC-V, for the Fixes: tag in question.

I'll look into adding the membarrier feature you mention (as a final/
follow-up patch), unless you or someone else want to take care of it.

  Andrea
