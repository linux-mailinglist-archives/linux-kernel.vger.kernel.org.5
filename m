Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE997B5D5E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 00:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236756AbjJBWvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 18:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237021AbjJBWvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 18:51:16 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E911A4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 15:51:08 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-405497850dbso3129605e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 15:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696287066; x=1696891866; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PiBVYtIuOlLuFNiBVRUMfSfexf+qnE+0Tc8CZdcfjOg=;
        b=M8Fm+mEVTI/GlhdgIj9u2YOaWNIdNofx75b8kACJZtWXrPXkYleJs6BTHBWgedwI0U
         cgZ3JOAjlhp7Tc9qOERxSsKKTuvNeJnPI+zg9T8kdSvEdfsXML8chcV+EzF1ZNAwrz5H
         B87oj76jtJ8/1yTGycjeQFE5j0NNtuMDdFYLQ7vmgpk8xCHahivkgs2OE0VHOk4z7+2g
         a2cQqmv0+VKpU7msO8d7C/G9U3q57eYg72erCrXmB72+t9q+u43/a0FO6EVn+phLeXEc
         s35HfWXbpIQuO1ZpCuue5HUaRpD+9+urgI3XIjYDn9eBEbQQ0hr+mDdvntdWgRJsKxB0
         2KWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696287066; x=1696891866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PiBVYtIuOlLuFNiBVRUMfSfexf+qnE+0Tc8CZdcfjOg=;
        b=KznoHxp+2u/l+V086h02OolGfZINsqNOregVL8DT7m422QG8p2ZTJNxHd8DYnWLQN8
         5BMJ5VJKWbAhwjZpDkXjqbVY5Ph8Yk1Th0teRBS09exqOaG3gpevCWz/PZWqJQonA0JE
         QlCB5NgomwZEbh23OZuGDWkY+e+wy+ecxTL+xEusvlqIDUcjZpZZ6zEkN0A7vO5vB3n8
         9BfzUyJxHVUpMIMMIHke+fixBo+0p8tP03K009NJufeYOYM0XxnAv9X7xRQdzBI+kBKD
         jc9C0ttkYpmlA2YO6/AP/UvknncX4o0HQEzO4Dv4BXwsuLR3rq7MQzCc5aztEvGowRib
         7yxQ==
X-Gm-Message-State: AOJu0Yz/am2GrFC9S/Ogtb95sSjbi+4P7wVWFZnFWw+u2zgHy+BvkR/J
        vLfXUPo11oOwfq5atAbIc/Q=
X-Google-Smtp-Source: AGHT+IEqBIX71QHlHmjXxlsBxqravil/edeaibGDoUYymDPdHZAtqf7Z5cLRPMS2JvwRgC2LpRcY9A==
X-Received: by 2002:a05:600c:2113:b0:405:1ba2:4fd1 with SMTP id u19-20020a05600c211300b004051ba24fd1mr12423351wml.24.1696287066108;
        Mon, 02 Oct 2023 15:51:06 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id f14-20020a7bc8ce000000b00402d34ea099sm8045752wml.29.2023.10.02.15.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 15:51:04 -0700 (PDT)
Date:   Mon, 2 Oct 2023 23:51:04 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/4] mm/gup: make failure to pin an error if FOLL_NOWAIT
 not specified
Message-ID: <6a421da0-8479-4873-8e46-6f92aed342c6@lucifer.local>
References: <cover.1696174961.git.lstoakes@gmail.com>
 <c7bfaf30cb682b92766e35ec85d93a84798b37f4.1696174961.git.lstoakes@gmail.com>
 <6161e8a8-64a4-c4ea-626d-daac45ccd836@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6161e8a8-64a4-c4ea-626d-daac45ccd836@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 01:04:51PM +0200, David Hildenbrand wrote:
> On 01.10.23 18:00, Lorenzo Stoakes wrote:
> > There really should be no circumstances under which a non-FOLL_NOWAIT GUP
> > operation fails to return any pages, so make this an error.
> >
> > To catch the trivial case, simply exit early if nr_pages == 0.
> >
> > This brings __get_user_pages_locked() in line with the behaviour of its
> > nommu variant.
> >
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > ---
> >   mm/gup.c | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> >
> > diff --git a/mm/gup.c b/mm/gup.c
> > index b21b33d1787e..fb2218d74ca5 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -1471,6 +1471,9 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
> >   	long ret, pages_done;
> >   	bool must_unlock = false;
> > +	if (!nr_pages)
> > +		return 0;
> > +
>
> Probably unlikely() is reasonable. I even wonder if WARN_ON_ONCE() would be
> appropriate, but likely there are weird callers that end up calling this
> with nr_pages==0 ... probably they should be identified and changed. Future
> work.
>
> >   	/*
> >   	 * The internal caller expects GUP to manage the lock internally and the
> >   	 * lock must be released when this returns.
> > @@ -1595,6 +1598,14 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
> >   		mmap_read_unlock(mm);
> >   		*locked = 0;
> >   	}
> > +
> > +	/*
> > +	 * Failing to pin anything implies something has gone wrong except when
> > +	 * FOLL_NOWAIT is specified, so explicitly make this an error.
> > +	 */
> > +	if (pages_done == 0 && !(flags & FOLL_NOWAIT))
> > +		return -EFAULT;
> > +
>
> But who would be affected by that and why do we care about adding this
> check?
>
> This smells like a "if (WARN_ON_ONCE())", correct?

Sure it does somewhat, however there are 'ordinary' (maybe) scenarios where
this could possibly happen - FOLL_UNLOCKABLE and __get_user_pages() returns
0, or lock retained for non-FOLL_NOWAIT scenario and __get_user_pages() 0
also.

So I think the safest option might be to leave without-WARN, however you
could argue since we're making it an error now maybe we want to draw
attention to it by warning.

I just want to avoid a warning that _might_ be a product of a particular
faulting scenario.

Jason or John may have an opinion on this.

Actually having written all this, given we're changing this into an error
now anyway and this is just not a correct or expected scenario, yeah I
think WARN_ON_ONCE() would make sense, will update on v2.

>
> --
> Cheers,
>
> David / dhildenb
>
