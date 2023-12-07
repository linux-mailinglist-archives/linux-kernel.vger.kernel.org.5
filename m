Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2E28089B9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442677AbjLGOAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbjLGOAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:00:45 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87C5133
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 06:00:50 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54c79cca895so11978a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 06:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701957649; x=1702562449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+yGSqZ11QV/22duj6c6AAFIvmwA7gtQojZiRqNzB1A=;
        b=tHQiGah2KRHocfcs6nXPssNQn+Y62cikemwlCV6p5byLra+dC7jgOXQic0KuMTf6Fg
         WIP6/5A0HUk3YAdiYNu/7rHIHmtFEHveSs0XkeWOAGEKw0JH0/OvtTyS1lIpMBR8UF8v
         Ub2xlL/xfRf5usZLfB5d6hZzJObAbQijDbFWuBe+Y2i6vNRoIQygWuXCCauWdtuaUAH9
         M/hDVZidMeeyqe1mzR734Bi+tIqX5mF8NjQfQnKW5W6KaiWpauo9BOhwNYLatTT7nDgd
         OqjQeEeUqPCkiuCe/qesFjIVmIf40MUEQECgL5M+xmS9DDHUSjTYbwqMPmOtfwMVUvPm
         33Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701957649; x=1702562449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+yGSqZ11QV/22duj6c6AAFIvmwA7gtQojZiRqNzB1A=;
        b=nH2SoOOiG1sfoFYZL6R8ydlfDJWhX6/N8k6cPZqUrXzheWiP4cX1j5VbnHM1FVQjWn
         QJ8TY4lHNXFkVFLNHFL6reTDRFBQzR7LqIZmdoHnpXXdsZPsgovZW3KZA+B0gl0IBnmy
         dBcdVCJObR+HHD6CYXusjADTzt/rqDH9yaPYuAAjSjiawcEA4duJEc6V5/tWShwcOnaO
         NnqHpXATuVTqFsbwKyFzW3NSsKnAQRzueIfqLYCExs2UnNebgevkKTmyceBbWf36/abI
         BSVGkeVmBBhnnLZAu3VqQEDRD60jFiZIhauFaTeEeRfuiVBOXQhdgm7OHiChhyW8nzka
         MWcQ==
X-Gm-Message-State: AOJu0YxD/bWfHhyGDfjEYxvu+EL8o8RSnRGxglTmD3+T7x/4eOqOjKTk
        UGmBrkrB0HSUd8xCwxKbDAYrbaZuxZEsGl83Il7s0g==
X-Google-Smtp-Source: AGHT+IGA6+1WHGVoJdWfC9ZSeFSRpBQrEpVr6+oFGCkIX/thP3tMAHw6JaFmNkHsu3yW2DoaLc02r3g0aAnOPLwVPDI=
X-Received: by 2002:a50:baae:0:b0:545:279:d075 with SMTP id
 x43-20020a50baae000000b005450279d075mr198699ede.1.1701957648485; Thu, 07 Dec
 2023 06:00:48 -0800 (PST)
MIME-Version: 1.0
References: <20231207094844.706407-1-agordeev@linux.ibm.com>
In-Reply-To: <20231207094844.706407-1-agordeev@linux.ibm.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 7 Dec 2023 15:00:10 +0100
Message-ID: <CAG48ez2KS=EpmRmiQWB0jOMD+qCGjZag6dtFQQG5FUfWU0RfUw@mail.gmail.com>
Subject: Re: [PATCH] mm: do not protect VMA lock object in vma_end_read()
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Suren Baghdasaryan <surenb@google.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 10:49=E2=80=AFAM Alexander Gordeev
<agordeev@linux.ibm.com> wrote:
> In early discussion to the implementation of vma_end_read()
> Jann Horn pointed out that up_read() could access the VMA
> lock object after it has already been acquired by someone
> else. As result, up_read() is protected with RCU read lock:
>
>         rcu_read_lock(); /* keeps vma alive */
>         up_read(&vma->lock);
>         rcu_read_unlock();
>
> Since commit 3f5245538a19 ("locking/rwsem: Disable preemption
> in all down_read*() and up_read() code paths") __up_read()
> disables preemption internally and thus the need to protect
> the VMA lock object does not exist anymore.

I think this is a bad idea. Please don't.

Yes, it looks like the (non-RT) implementation of __up_read
*currently* disables preemption. But that's an implementation detail,
not a documented API contract of up_read(), so there would be nothing
stopping someone from reimplementing __up_read() in the future such
that the preemption stuff disappears again.

And from what I can tell from a quick look, the RT implementation of
__up_read() does not currently give you this kind of guarantee.

In my opinion, if you want to make this change, then as a prerequisite
you have to get buy-in from the locking maintainers.


> Link: https://lore.kernel.org/all/CAG48ez3sCwasFzKD5CsqMFA2W57-2fazd75g7r=
0NaA_BVNTLow@mail.gmail.com/
> Cc: Jann Horn <jannh@google.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  include/linux/mm.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 418d26608ece..7b32bc75a4ab 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -683,9 +683,7 @@ static inline bool vma_start_read(struct vm_area_stru=
ct *vma)
>
>  static inline void vma_end_read(struct vm_area_struct *vma)
>  {
> -       rcu_read_lock(); /* keeps vma alive till the end of up_read */
>         up_read(&vma->vm_lock->lock);
> -       rcu_read_unlock();
>  }
>
>  /* WARNING! Can only be used if mmap_lock is expected to be write-locked=
 */
> --
> 2.40.1
>
