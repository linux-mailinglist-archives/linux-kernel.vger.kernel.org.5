Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464C37B3C90
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 00:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbjI2WVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 18:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2WVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 18:21:42 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92906139;
        Fri, 29 Sep 2023 15:21:40 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4053c6f1087so139437295e9.0;
        Fri, 29 Sep 2023 15:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696026099; x=1696630899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cfkoZtZzWFKUAXVfkTw1XT497sJpCWkeZgREXpBpHnM=;
        b=PCnhW8Ij7IAB8ISKHsPVHuMun5syvcVSYeeY0ROHQSbUEsA3Ha9nQJLLH8dV3fK+ml
         MompR5YKyEtzKAeIeFvG9MCKEENUlVTPTk4s1cMjHKs3U1WUJdbdOU+JgWTcvY3IPfIJ
         KuZkaf1V7GNTwagBDVQ7/s4bHEhPYrAYc3SbaGTLTwLDb0Lqhcc1WXa2URyiKVta/t3x
         LbN77918kMgtf03NifewgzhGwGH26245KzEGAF2yyVlJZN/31Rn/HILdVByPFSdUx6cO
         EQcPHffN3e5D5pESEtjBsZ5klhJROSnaWI05bjPlRwsbL+SLXJEOgrWoZO/bBkd+ccIW
         4dwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696026099; x=1696630899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfkoZtZzWFKUAXVfkTw1XT497sJpCWkeZgREXpBpHnM=;
        b=A7D5cf+ZeaxUIG8UE/Ll2y1fkIMolR1FfHRR5EOadSsVe2yOWFMWTUgdfeuQvAADUF
         pHi7OzPU6Jdall0lUnEvRhEY9DV9poMcCssjuuik9Eg8/8a0pX86Tjw/7uiSJgz+VFRz
         kwnMKgXOTuFAvdGk8rFB7jLj/CiQPEEbWQI3O7Ms5iZS6Gb6zkdBe3nDZv8g2925g2Db
         4a+QtVSSjezLUh278HXyEIa9ZqGrFbnTK0RpL3kCmU9FbDSLKiQgHxqve1L8x/Wi4l2w
         OaDIdRaTY2ucrcQCvgwFUlApfsHpOXPWIPLmTNuE9qKKUh/ASTuXlOAYXG4hUlcqtu3e
         3agw==
X-Gm-Message-State: AOJu0YyfmuiWnD4EH6i1xHaP8QEpdJm+o5JCjkzHTiqHbgwWRgMs4M7o
        ghvZkJJc+RL5ly53qcqJ3cs=
X-Google-Smtp-Source: AGHT+IHp2979RLyG4yl77VxrPIQnP1hdoLxq2OeMecv7VB0xcyOg9BAYIcfLgRQ7K1Hy9R295KDl3Q==
X-Received: by 2002:a05:600c:2145:b0:401:c338:ab94 with SMTP id v5-20020a05600c214500b00401c338ab94mr5418356wml.29.1696026098484;
        Fri, 29 Sep 2023 15:21:38 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id t16-20020a5d49d0000000b0031c5b380291sm22386092wrs.110.2023.09.29.15.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 15:21:37 -0700 (PDT)
Date:   Fri, 29 Sep 2023 23:21:36 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/3] mmap: Fix vma_iterator in error path of
 vma_merge()
Message-ID: <f3193ba5-32de-4f61-9b36-07373a21d751@lucifer.local>
References: <20230929183041.2835469-1-Liam.Howlett@oracle.com>
 <20230929183041.2835469-2-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929183041.2835469-2-Liam.Howlett@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 02:30:39PM -0400, Liam R. Howlett wrote:
> During the error path, the vma iterator may not be correctly positioned
> or set to the correct range.  Undo the vma_prev() call by resetting to
> the passed in address.  Re-walking to the same range will fix the range
> to the area previously passed in.
>
> Users would notice increased cycles as vma_merge() would be called an
> extra time with vma == prev, and thus would fail to merge and return.
>
> Link: https://lore.kernel.org/linux-mm/CAG48ez12VN1JAOtTNMY+Y2YnsU45yL5giS-Qn=ejtiHpgJAbdQ@mail.gmail.com/
> Closes: https://lore.kernel.org/linux-mm/CAG48ez12VN1JAOtTNMY+Y2YnsU45yL5giS-Qn=ejtiHpgJAbdQ@mail.gmail.com/
> Fixes: 18b098af2890 ("vma_merge: set vma iterator to correct position.")
> Cc: stable@vger.kernel.org
> Cc: Jann Horn <jannh@google.com>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  mm/mmap.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index b56a7f0c9f85..acb7dea49e23 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -975,7 +975,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>
>  	/* Error in anon_vma clone. */
>  	if (err)
> -		return NULL;
> +		goto anon_vma_fail;
>
>  	if (vma_start < vma->vm_start || vma_end > vma->vm_end)
>  		vma_expanded = true;
> @@ -988,7 +988,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  	}
>
>  	if (vma_iter_prealloc(vmi, vma))
> -		return NULL;
> +		goto prealloc_fail;
>
>  	init_multi_vma_prep(&vp, vma, adjust, remove, remove2);
>  	VM_WARN_ON(vp.anon_vma && adjust && adjust->anon_vma &&
> @@ -1016,6 +1016,12 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  	vma_complete(&vp, vmi, mm);
>  	khugepaged_enter_vma(res, vm_flags);
>  	return res;
> +
> +prealloc_fail:
> +anon_vma_fail:
> +	vma_iter_set(vmi, addr);
> +	vma_iter_load(vmi);
> +	return NULL;
>  }
>
>  /*
> --
> 2.40.1
>
Looks good to me,

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
