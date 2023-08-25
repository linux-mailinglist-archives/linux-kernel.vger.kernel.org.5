Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910187891C7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 00:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjHYWi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 18:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjHYWil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 18:38:41 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C71D269F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:38:38 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68a3e943762so1260442b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693003118; x=1693607918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pvT61EgqHV2sXzVGpzHb3/Do1J2IZRGpt5oeUSTXS1M=;
        b=DOo8GPav/4/T0YBMMrO/cePh0ds1j+7XmPnsFiA81vr3N7hBMYIs6zg16ettL7gDXz
         p9nCAjfggAkvTQaYkLHvydpFAuhhirXtq//ddTQNDrBzPaMlhwBaL0SlAH2fNVt/COZa
         OKKoiWuxLo6XsHLH8vlgCysrsRSCMT9yGkNIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693003118; x=1693607918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvT61EgqHV2sXzVGpzHb3/Do1J2IZRGpt5oeUSTXS1M=;
        b=Lc+BvoLRt8m8IbtBAR5eJ1zyqTC+C7HqBXiRdMN7a7/i2v8biqUl92soNJrfBaFCxt
         ozkfI/OPGzHtvn07q38JIDANxo9Tq6wtmGs/tL2zl37w5jyzjQyzK/aHjf86vtVdK4yO
         QFp1wl8TxBerk8B3KF5myf3vH2L3/dZIW1ouGCKtoRtZTzZgMtsJFjEwcINyJ7bPujqD
         kLqBFjXpdh49MQ700omsj9+zdA5liocpBYIPmXkVkFCleiVSoEJDDeOYefXy9S8dU34e
         L2vaSJSas61vZistDXqMhrjco6PksX+S7Sx+WtNi1RU9dRor2Tz2b3ejeP5ZKnVsBOUu
         ZHuQ==
X-Gm-Message-State: AOJu0YyIqUE/g3Uc+tdL1JZD301pjCKUNLM2wOpU1+Xvtwmd6wh85oDj
        yONrPuw7BzXMt8OHne0WuOo8oA==
X-Google-Smtp-Source: AGHT+IHtcM7TBjRhEYZWBp/1bp8NSpQ8O6IsMGa1gTP1wB419PgWbxNHloZgf1ds3UA3SEXCGogzLg==
X-Received: by 2002:a05:6a20:258b:b0:13e:1945:8873 with SMTP id k11-20020a056a20258b00b0013e19458873mr23803455pzd.37.1693003117713;
        Fri, 25 Aug 2023 15:38:37 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a3-20020aa78643000000b0068874e1faf2sm2069987pfo.56.2023.08.25.15.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 15:38:36 -0700 (PDT)
Date:   Fri, 25 Aug 2023 15:38:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Florent Revest <revest@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        david@redhat.com, peterx@redhat.com, izbyshev@ispras.ru,
        broonie@kernel.org, szabolcs.nagy@arm.com, kpsingh@kernel.org,
        gthelen@google.com, toiwoton@gmail.com
Subject: Re: [PATCH v3 4/5] mm: Add a NO_INHERIT flag to the PR_SET_MDWE prctl
Message-ID: <202308251535.551E797B1@keescook>
References: <20230704153630.1591122-1-revest@chromium.org>
 <20230704153630.1591122-5-revest@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704153630.1591122-5-revest@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 05:36:28PM +0200, Florent Revest wrote:
> This extends the current PR_SET_MDWE prctl arg with a bit to indicate
> that the process doesn't want MDWE protection to propagate to children.
> 
> To implement this no-inherit mode, the tag in current->mm->flags must be
> absent from MMF_INIT_MASK. This means that the encoding for "MDWE but
> without inherit" is different in the prctl than in the mm flags. This
> leads to a bit of bit-mangling in the prctl implementation.
> 
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---
>  include/linux/sched/coredump.h   | 10 ++++++++++
>  include/uapi/linux/prctl.h       |  1 +
>  kernel/fork.c                    |  2 +-
>  kernel/sys.c                     | 32 ++++++++++++++++++++++++++------
>  tools/include/uapi/linux/prctl.h |  1 +
>  5 files changed, 39 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
> index 0ee96ea7a0e9..1b37fa8fc723 100644
> --- a/include/linux/sched/coredump.h
> +++ b/include/linux/sched/coredump.h
> @@ -91,4 +91,14 @@ static inline int get_dumpable(struct mm_struct *mm)
>  				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK)
>  
>  #define MMF_VM_MERGE_ANY	29
> +#define MMF_HAS_MDWE_NO_INHERIT	30
> +
> +static inline unsigned long mmf_init_flags(unsigned long flags)
> +{
> +	if (flags & (1UL << MMF_HAS_MDWE_NO_INHERIT))
> +		flags &= ~((1UL << MMF_HAS_MDWE) |
> +			   (1UL << MMF_HAS_MDWE_NO_INHERIT));
> +	return flags & MMF_INIT_MASK;
> +}
> +
>  #endif /* _LINUX_SCHED_COREDUMP_H */
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 6e9af6cbc950..dacbe824e7c3 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -284,6 +284,7 @@ struct prctl_mm_map {
>  /* Memory deny write / execute */
>  #define PR_SET_MDWE			65
>  # define PR_MDWE_REFUSE_EXEC_GAIN	(1UL << 0)
> +# define PR_MDWE_NO_INHERIT		(1UL << 1)
>  
>  #define PR_GET_MDWE			66
>  
> diff --git a/kernel/fork.c b/kernel/fork.c
> index d17995934eb4..bc3c762d378f 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1284,7 +1284,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>  	hugetlb_count_init(mm);
>  
>  	if (current->mm) {
> -		mm->flags = current->mm->flags & MMF_INIT_MASK;
> +		mm->flags = mmf_init_flags(current->mm->flags);
>  		mm->def_flags = current->mm->def_flags & VM_INIT_DEF_MASK;
>  	} else {
>  		mm->flags = default_dump_filter;
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 339fee3eff6a..1a2dc3da43ea 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2362,19 +2362,41 @@ static int prctl_set_vma(unsigned long opt, unsigned long start,
>  }
>  #endif /* CONFIG_ANON_VMA_NAME */
>  
> +static inline unsigned long get_current_mdwe(void)
> +{
> +	unsigned long ret = 0;
> +
> +	if (test_bit(MMF_HAS_MDWE, &current->mm->flags))
> +		ret |= PR_MDWE_REFUSE_EXEC_GAIN;
> +	if (test_bit(MMF_HAS_MDWE_NO_INHERIT, &current->mm->flags))
> +		ret |= PR_MDWE_NO_INHERIT;
> +
> +	return ret;
> +}
> +
>  static inline int prctl_set_mdwe(unsigned long bits, unsigned long arg3,
>  				 unsigned long arg4, unsigned long arg5)
>  {
> +	unsigned long current_bits;
> +
>  	if (arg3 || arg4 || arg5)
>  		return -EINVAL;
>  
> -	if (bits & ~(PR_MDWE_REFUSE_EXEC_GAIN))
> +	if (bits & ~(PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT))
> +		return -EINVAL;
> +
> +	/* NO_INHERIT only makes sense with REFUSE_EXEC_GAIN */
> +	if (bits & PR_MDWE_NO_INHERIT && !(bits & PR_MDWE_REFUSE_EXEC_GAIN))
>  		return -EINVAL;
>  
> +	current_bits = get_current_mdwe();
> +	if (current_bits && current_bits != bits)
> +		return -EPERM; /* Cannot unset the flags */

I was pondering why PR_MDWE_NO_INHERIT can't be unset, but I guess it
doesn't matter. Anything forked with have it off, and any process
wanting to launch stuff before locking down can just skip running the
prctl() until later.

> +
> +	if (bits & PR_MDWE_NO_INHERIT)
> +		set_bit(MMF_HAS_MDWE_NO_INHERIT, &current->mm->flags);
>  	if (bits & PR_MDWE_REFUSE_EXEC_GAIN)
>  		set_bit(MMF_HAS_MDWE, &current->mm->flags);
> -	else if (test_bit(MMF_HAS_MDWE, &current->mm->flags))
> -		return -EPERM; /* Cannot unset the flag */
>  
>  	return 0;
>  }
> @@ -2384,9 +2406,7 @@ static inline int prctl_get_mdwe(unsigned long arg2, unsigned long arg3,
>  {
>  	if (arg2 || arg3 || arg4 || arg5)
>  		return -EINVAL;
> -
> -	return test_bit(MMF_HAS_MDWE, &current->mm->flags) ?
> -		PR_MDWE_REFUSE_EXEC_GAIN : 0;
> +	return (int)get_current_mdwe();
>  }
>  
>  static int prctl_get_auxv(void __user *addr, unsigned long len)
> diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
> index 6e9af6cbc950..dacbe824e7c3 100644
> --- a/tools/include/uapi/linux/prctl.h
> +++ b/tools/include/uapi/linux/prctl.h
> @@ -284,6 +284,7 @@ struct prctl_mm_map {
>  /* Memory deny write / execute */
>  #define PR_SET_MDWE			65
>  # define PR_MDWE_REFUSE_EXEC_GAIN	(1UL << 0)
> +# define PR_MDWE_NO_INHERIT		(1UL << 1)
>  
>  #define PR_GET_MDWE			66
>  
> -- 
> 2.41.0.255.g8b1d071c50-goog
> 

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
