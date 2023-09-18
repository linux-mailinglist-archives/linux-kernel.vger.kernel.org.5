Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8983E7A5631
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 01:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjIRXbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 19:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjIRXbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 19:31:15 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C6590
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 16:31:05 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-59c04237bf2so43047767b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 16:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695079865; x=1695684665; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AvmZeLJa5EyjvpWd7at0QcGbhWatmHcWmtqRx8CiCf4=;
        b=pGExb2pPuLuG/EbV4lKr/lwnQIudowJDrj3y1Pd/+B2GSU0hVGnW3RJ7TW5JBhYgOG
         aD1VVHLT9gUR6YdQiXZQ5cPgCwn7NdkR0wy1BcdUa7HKSg67Xsq0ZeoStyF3UIRlWbVt
         h60Yii3bW3KfIzpEwajXnrLANTGz6GMw5fVUAaXwl4ioGBc10CygbsGR13gNPaNTM0bu
         NZKNNiIYiBinOPSG+bSzBqs4/8jrSfA/JNWf4zOtYNNcB/7qNwFVWUD1l6tdXWNi3eUh
         Gm4mF+szpQXaGaQftRWu31znIu890mA+SH+SHpXej30I52zj4mZqny3AgzU7mbVOWDgW
         jLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695079865; x=1695684665;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AvmZeLJa5EyjvpWd7at0QcGbhWatmHcWmtqRx8CiCf4=;
        b=LSTBNHLumZb8gR4Zcn5kFGXemM5xf5LKE90YKjFPMkvHFuMtPyH5OttiRWeu/nwB87
         T2AxcYFmjJgfl7vSwJynTe8Xs3D/vHm05XTTDVgzGaCsU/OeDTgAYgK220qHzj9MDGf1
         mWZGabOpfaYczs825H1dv44JRlL1jDypsLaIiXCXs1L8cUrYB5LyO0fZX7SsX2S+SZqO
         X8uGX0wPuhnX9FwxOY23nqg/Mm8H/BT4jrZC6TS2snsoMUKstpOWqHHa0SXvkShd4rst
         ntFEKCJ2p55q/H2mF+zaKlnpK9cvthCRFSKIXp3SDcwEF9VTWIsQLA09nGEbgTfb/P3D
         MoUg==
X-Gm-Message-State: AOJu0Yza8JIfs5Bxxp3PLkteSEPdkQBl+4V1YKg+nKFo9VtG7dd5TUdE
        mClskKvviP1Bet2M/Pw9YLwOTw==
X-Google-Smtp-Source: AGHT+IF3JT5bCA7I7Ld7k7UXeUjFs+gdf923oWqmQjQTHiHBf/0n5u4GnJW18U8J/QECAfDT+CG+XA==
X-Received: by 2002:a0d:efc6:0:b0:595:be7:a38 with SMTP id y189-20020a0defc6000000b005950be70a38mr9618335ywe.49.1695079864905;
        Mon, 18 Sep 2023 16:31:04 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x8-20020a817c08000000b00589b653b7adsm2888815ywc.136.2023.09.18.16.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 16:31:03 -0700 (PDT)
Date:   Mon, 18 Sep 2023 16:30:54 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Suren Baghdasaryan <surenb@google.com>
cc:     akpm@linux-foundation.org, willy@infradead.org, hughd@google.com,
        shy828301@gmail.com, mhocko@suse.com, vbabka@suse.cz,
        syzkaller-bugs@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/1] mm: lock VMAs skipped by a failed
 queue_pages_range()
In-Reply-To: <20230918211608.3580629-1-surenb@google.com>
Message-ID: <512d487a-758c-6d9c-787c-4169117d20cf@google.com>
References: <20230918211608.3580629-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Sep 2023, Suren Baghdasaryan wrote:

> When queue_pages_range() encounters an unmovable page, it terminates
> its page walk. This walk, among other things, locks the VMAs in the range.
> This termination might result in some VMAs being left unlock after
> queue_pages_range() completes. Since do_mbind() continues to operate on
> these VMAs despite the failure from queue_pages_range(), it will encounter
> an unlocked VMA.
> This mbind() behavior has been modified several times before and might
> need some changes to either finish the page walk even in the presence
> of unmovable pages or to error out immediately after the failure to
> queue_pages_range(). However that requires more discussions, so to
> fix the immediate issue, explicitly lock the VMAs in the range if
> queue_pages_range() failed. The added condition does not save much
> but is added for documentation purposes to understand when this extra
> locking is needed.
> 
> Fixes: 49b0638502da ("mm: enable page walking API to lock vmas during the walk")
> Reported-by: syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/000000000000f392a60604a65085@google.com/
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: Hugh Dickins <hughd@google.com>

> ---
>  mm/mempolicy.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 42b5567e3773..cbc584e9b6ca 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1342,6 +1342,9 @@ static long do_mbind(unsigned long start, unsigned long len,
>  	vma_iter_init(&vmi, mm, start);
>  	prev = vma_prev(&vmi);
>  	for_each_vma_range(vmi, vma, end) {
> +		/* If queue_pages_range failed then not all VMAs might be locked */
> +		if (ret)
> +			vma_start_write(vma);
>  		err = mbind_range(&vmi, vma, &prev, start, end, new);
>  		if (err)
>  			break;
> -- 
> 2.42.0.459.ge4e396fd5e-goog
