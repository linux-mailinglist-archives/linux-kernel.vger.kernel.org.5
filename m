Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2A681173D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442044AbjLMPgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442703AbjLMPgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:36:01 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B4A10C8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:35:54 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1d336760e72so18497905ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702481753; x=1703086553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YSYeywzLgqaZI2MS9nHX0Fs7SGO3wtfBMr/dgErcxP4=;
        b=RqkWWchH8Zcw1tgNhAEq3A6UDwHbb9k7z4+OrJ7cklt22xDMzgZ0DbOpXWnKCzYBAX
         lXMiiV/P/N5K5hla45QiO2sLd+aLIg0GUFDdceysuCuOW6N52UjSUlJ/TTeCSYjrjpeg
         AIaTyeLebxAiex4EwLuttvglUEtSq+74wuNdtL0rDM+3QmcQfSJDMnWyjIUQIlxu1jHO
         +bEhocRydl8Lgm2zruSHts27bb+6oz1knNJmgrIa+UFA2gHGrHSr/r5gCWjEQsPYxr5s
         3RakdyxaLdJUfN66ANHOTEBncR2NTksJ3IAY0hcyY5o9Stx2I1IXI67XAIhAlsPg3dI3
         5zKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702481753; x=1703086553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSYeywzLgqaZI2MS9nHX0Fs7SGO3wtfBMr/dgErcxP4=;
        b=HRf3pRovZ5S74TxJM5QP05nrhU+8FrkcFmORFS6CPUnmuclrCC0LpSztCSV5lrYj9v
         bzEZ1zAZSI5tzwXmsA4g+eJOTKiCGVlV+5ddTqKEYOmtlRFNL05hnvBGFl06JtL/WU6a
         JDyYIiFi8CpbEvfYKGhRU7WDwXaZcnvDBecLzSHxoqsAwziVNJ0YFjjhZa6uQ3anhKXs
         Njwxm/orOyDwQWFj1LP9eRi2DA9FuDeri+gTZfkwuUDLgpa01eyIjlSFbCNHk/c6Pz/s
         918D74LG3CQC6KIjoIms56KENNTDHo94bwqqUVciYMObwGzG0h0ICFU2UeHJbaDNC+BA
         qmEQ==
X-Gm-Message-State: AOJu0YwvFAIZXiGqI1HiVaGvISS45QBa374SsXdo5MT7FLfwzFrZTjF2
        oC8kyNoVmiQAsRbl9VC57bwys7zKEb0=
X-Google-Smtp-Source: AGHT+IGaoKndvosJx2CfdIl7/lnVnNuv9YFf1Em7CCtxWmW6bQmFtHSvQT1TpzKrJsIBGcGMNahkOQ==
X-Received: by 2002:a17:902:6bc4:b0:1d0:acd7:97fa with SMTP id m4-20020a1709026bc400b001d0acd797famr7982784plt.127.1702481752879;
        Wed, 13 Dec 2023 07:35:52 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id k9-20020a170902c40900b001b9e9edbf43sm10711595plk.171.2023.12.13.07.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 07:35:52 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 13 Dec 2023 05:35:50 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Aaron Tomlin <atomlin@atomlin.com>, linux-kernel@vger.kernel.org,
        jiangshanlai@gmail.com, peterz@infradead.org
Subject: Re: [RFC PATCH 0/2] workqueue: Introduce PF_WQ_RESCUE_WORKER
Message-ID: <ZXnPVtISKQ2JFDNn@slm.duckdns.org>
References: <20230729135334.566138-1-atomlin@atomlin.com>
 <um77hym4t6zyypfbhwbaeqxpfdzc657oa7vgowdfah7cuctjak@pexots3mfb24>
 <ZXdXdBzvbkI4Y4fL@slm.duckdns.org>
 <ZXguMgcKLCLn16T4@localhost.localdomain>
 <ZXiVCOKk90Fjpmhw@slm.duckdns.org>
 <ZXlyfjDsFGbYcMU6@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXlyfjDsFGbYcMU6@localhost.localdomain>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Dec 13, 2023 at 09:59:42AM +0100, Juri Lelli wrote:
> Something like the following then maybe?
> 
> ---
>  kernel/workqueue.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 2989b57e154a7..ed73f7f80d57d 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -4405,6 +4405,12 @@ static void apply_wqattrs_commit(struct apply_wqattrs_ctx *ctx)
>         link_pwq(ctx->dfl_pwq);
>         swap(ctx->wq->dfl_pwq, ctx->dfl_pwq);
> 
> +       /* rescuer needs to respect wq cpumask changes */
> +       if (ctx->wq->rescuer) {
> +               kthread_bind_mask(ctx->wq->rescuer->task, ctx->attrs->cpumask);
> +               wake_up_process(ctx->wq->rescuer->task);
> +       }
> +
>         mutex_unlock(&ctx->wq->mutex);
>  }

I'm not sure kthread_bind_mask() would be safe here. The rescuer might be
running a work item. wait_task_inactive() might fail and we don't want to
change cpumask while the rescuer is active anyway.

Maybe the easiest way to do this is making rescuer_thread() restore the wq's
cpumask right before going to sleep, and making apply_wqattrs_commit() just
wake up the rescuer.

Thanks.

-- 
tejun
