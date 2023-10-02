Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6601D7B4CC5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235784AbjJBHnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 03:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjJBHns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:43:48 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AAFAB;
        Mon,  2 Oct 2023 00:43:45 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-5041bb9ce51so24792726e87.1;
        Mon, 02 Oct 2023 00:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696232623; x=1696837423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o+nReRagUozu8z0tWV2+jg0w12ucMifR6ov/hT+a2As=;
        b=VftKKsWBUF+XRm4W5NE1Ov/odMnZ4R7qFW3EfbzgyrDetMxcJOUP+BDIyDzaO3Wcp3
         WyipHmZvm4WU3+Ya3e4fwHuenB0VonlVSRflko2/5q8GKWaVD3Z8w2cApiR88dcr0RUU
         XNqPyobqMS3n/1vDo7ohiSYuX4rBMqyj25kAYSvXXXgqGaTThWbD2PNm0R/w5WPO8T2C
         88O3opfHZ4Dyqs9u9QsAs8DiqALbm4s+x9SlVo3a/zSPxBi3Xp9SWqgOahIKsdasNLuD
         WwZd8Q8Wqufeuk+LWXJ4t1vmDKliaaZqqvDkmphdg/ZfAMYlOD07Iesg5zmuU2ZghGYO
         sFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696232623; x=1696837423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+nReRagUozu8z0tWV2+jg0w12ucMifR6ov/hT+a2As=;
        b=NmEHQhJYmSFSfOo32v0rtzzZEhftIZbfggMU9iufAW4xzWSD7bqcBeqfgBemll1UGf
         bphTj7Lb9Cby4axR35hAElhJ/+omr4z6aCqg8AW978rnf1U5uia0r+OxowUXdHBsi7OI
         QhyfT9Fk77uuqyYUkV9qghkiKV2gdycwBx9xH+agXTzxCwXAk9OchMehZh9ntdVmqR4v
         EBdGz4fxcaQ8copA3zNuu65MZbt2DtCbyquLARCZl9OZC5yIg0+xQk9jKs9jsJoKESRj
         4UG7QU+kASBVlu9VgQw1AO+WI/+zygjImI/SWBlZJBru/yMa/HGyeILugVquPyAkT+Td
         D26Q==
X-Gm-Message-State: AOJu0YwnqItfeIVCH5iLM87ZzT4sCI3ABd233sIdLb8tORIWHSNr2vOl
        8pX6vVlJowqh4FXVYycTTIGcvPiA6iI=
X-Google-Smtp-Source: AGHT+IEEisoHnB4dHSYvzwRawwJ8vQwMufIusH62krxfUfH8omy30RCu3+e/jnlvbnT0qcWMK+gjsQ==
X-Received: by 2002:a19:7b0b:0:b0:503:1ca6:c590 with SMTP id w11-20020a197b0b000000b005031ca6c590mr6238199lfc.22.1696232623342;
        Mon, 02 Oct 2023 00:43:43 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id a11-20020a05600c2d4b00b004065daba6casm6541786wmg.46.2023.10.02.00.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 00:43:42 -0700 (PDT)
Date:   Mon, 2 Oct 2023 08:43:41 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/3] mmap: Fix error paths with dup_anon_vma()
Message-ID: <6f85e46d-78e3-426d-9a24-3aadfd91bdc6@lucifer.local>
References: <20230929183041.2835469-1-Liam.Howlett@oracle.com>
 <20230929183041.2835469-3-Liam.Howlett@oracle.com>
 <843f059f-dd54-4481-b46a-e87e56274db3@lucifer.local>
 <db77d8e7-4b29-2348-c034-3a2cf120b7b2@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db77d8e7-4b29-2348-c034-3a2cf120b7b2@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 09:26:03AM +0200, Vlastimil Babka wrote:
> On 9/30/23 00:28, Lorenzo Stoakes wrote:
> > On Fri, Sep 29, 2023 at 02:30:40PM -0400, Liam R. Howlett wrote:
> >> When the calling function fails after the dup_anon_vma(), the
> >> duplication of the anon_vma is not being undone.  Add the necessary
> >> unlink_anon_vma() call to the error paths that are missing them.
> >>
> >> This issue showed up during inspection of the error path in vma_merge()
> >> for an unrelated vma iterator issue.
> >>
> >> Users may experience increased memory usage, which may be problematic as
> >> the failure would likely be caused by a low memory situation.
> >>
> >> Fixes: d4af56c5c7c6 ("mm: start tracking VMAs with maple tree")
> >> Cc: stable@vger.kernel.org
> >> Cc: Jann Horn <jannh@google.com>
> >> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> >> ---
> >>  mm/mmap.c | 30 ++++++++++++++++++++++--------
> >>  1 file changed, 22 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/mm/mmap.c b/mm/mmap.c
> >> index acb7dea49e23..f9f0a5fe4db4 100644
> >> --- a/mm/mmap.c
> >> +++ b/mm/mmap.c
> >> @@ -583,11 +583,12 @@ static inline void vma_complete(struct vma_prepare *vp,
> >>   * dup_anon_vma() - Helper function to duplicate anon_vma
> >>   * @dst: The destination VMA
> >>   * @src: The source VMA
> >> + * @dup: Pointer to the destination VMA when successful.
> >>   *
> >>   * Returns: 0 on success.
> >
> > Being a bit nitpicky/refactory here, but anon_vma_clone() appears to have
> > two possible return values - 0 for success, and -ENOMEM.
> >
> > As a result, it's not really gaining us much passing through this value.
> >
> > It'd be nice if dup_anon_vma() and anon_vma_clone() were therefore updated
> > to instead return NULL on ENOMEM and the dst otherwise.
>
> But we also need to represent that dup_anon_vma() had nothing to do, because
> "(src->anon_vma && !dst->anon_vma)" was false, and in that case we should
> not be returning dst from there?
>
> So maybe we could return NULL for that case and ERR_PTR(ret) for the -ENOMEM
> from anon_vma_clone() ?

Yeah, you're right, actually I think that would probably be the best
approach as you'd both eliminate the awkward out parameter but retain the
fact that there's 3 possible return states (dup'd, no need to dup, error).

>
> > Then we could de-clunk this whole code path, and the quite natural fact of
> > 'thing didn't return a pointer therefore had no memory to allocate it' fals
> > out.
> >
> > But this isn't exactly an earth-shattering concern :)
> >
>
