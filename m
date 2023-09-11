Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0ADA79C288
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235848AbjILCRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237561AbjILCQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:16:35 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4298064075
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 15:47:49 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3a7f4f7a8easo2379045b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 15:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1694472324; x=1695077124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ok19BPXq/ZtE5Je9WteUjIQMcW5gGGmyf4q0shWhFBg=;
        b=FHQGJCJNb90QfQ3XPtDRQ3MTNnTQPxbF9B4Yp0F33YLDfnlV77dVnPC1+kGNjenP4U
         1PAhFcPWBTV1aZ0zktt4Es0+OXdY+ob31Qb6FqdRLi2TGYFpPXbTDtRQcUBqJbuCFNG7
         rJm1SalC7oHCKtl9/NtDZvsKtidg08UOcpsOptkpaaTwqoXPALxZt+OSlBqvgw1pQDKp
         dJXr3aAqOiDYFbfSSOM3Er5Fo82WKyYChDufPeSIFWbc6/0XJMyOzyo7HsddvuCmY9bF
         MPrehp2wCKZeWvr+8RiNL9r8jCn5xQwx9F4xWB3zYIPnnzdZ6uBIlbmKb1b4AqBZw4m9
         1Txg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694472324; x=1695077124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ok19BPXq/ZtE5Je9WteUjIQMcW5gGGmyf4q0shWhFBg=;
        b=n/fVXaDmTsVKtcUW1ay8Ptg9LkY3jTfPklRoBIEnASUooUXntOKUbbeqhpIlsTEiXG
         GY6TU+WBDNwNV5Nh7M5MoPUj22ZOHgkmwMKDAXVG7Lcf2HiOEHXtW8tRG9aS8x+kPv1a
         LOd+ee1xAQhG4lvmjFZUVH+f30s9IzTVHeZLKPJ2kTfrlf2pxl0C/dMP0TIkYcCleWFj
         Fjw2er34E10Y8VKq4oVAlnJInmi7xSSgOxhehzahluTMO28R57foolJTnER6EnMjtWbg
         hggeYICXISyhUF2gKDp6aE0ruIYtbJLdrVN8UVWcV8Gkf4WXj0QhYDiYnZ3UsV33JvZi
         N7rQ==
X-Gm-Message-State: AOJu0YwBYGBxrvaQ+Vpk9Xyybgzu8LTAB79BPDjPEn+jmdq7MGmE3qKZ
        sWsC0pQGDF5BkHifpFjuEACoOOtLUJAvvaUVAd8=
X-Google-Smtp-Source: AGHT+IE/LaOllEbOYogtobKnQv0RIkvkE2D1hgCfX1NOJa1hWXTzgr9ZPscNFI5RdpRx8ePwENieLg==
X-Received: by 2002:a05:6a21:6da9:b0:148:f16f:113f with SMTP id wl41-20020a056a216da900b00148f16f113fmr10528676pzb.12.1694471398931;
        Mon, 11 Sep 2023 15:29:58 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-66-88.pa.nsw.optusnet.com.au. [49.195.66.88])
        by smtp.gmail.com with ESMTPSA id g14-20020a056a001a0e00b0068fba4800cfsm2979220pfv.56.2023.09.11.15.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 15:29:58 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qfpPn-00Dy3W-0c;
        Tue, 12 Sep 2023 08:29:55 +1000
Date:   Tue, 12 Sep 2023 08:29:55 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/5] locking: Add rwsem_is_write_locked()
Message-ID: <ZP+U49yfkm0Fpfej@dread.disaster.area>
References: <20230907174705.2976191-2-willy@infradead.org>
 <20230907190810.GA14243@noisy.programming.kicks-ass.net>
 <ZPoift7B3UDQgmWB@casper.infradead.org>
 <20230907193838.GB14243@noisy.programming.kicks-ass.net>
 <ZPpV+MeFqX6RHIYw@dread.disaster.area>
 <20230908104434.GB24372@noisy.programming.kicks-ass.net>
 <ZP5JrYOge3tSAvj7@dread.disaster.area>
 <ZP5OfhXhPkntaEkc@casper.infradead.org>
 <ZP5llBaVrJteHQf3@dread.disaster.area>
 <70d89bf4-708b-f131-f90e-5250b6804d48@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70d89bf4-708b-f131-f90e-5250b6804d48@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 10, 2023 at 10:15:59PM -0400, Waiman Long wrote:
> 
> On 9/10/23 20:55, Dave Chinner wrote:
> > On Mon, Sep 11, 2023 at 12:17:18AM +0100, Matthew Wilcox wrote:
> > > On Mon, Sep 11, 2023 at 08:56:45AM +1000, Dave Chinner wrote:
> > > > On Fri, Sep 08, 2023 at 12:44:34PM +0200, Peter Zijlstra wrote:
> > > > > Agreed, and this is fine. However there's been some very creative
> > > > > 'use' of the _is_locked() class of functions in the past that did not
> > > > > follow 'common' sense.
> > > > > 
> > > > > If all usage was: I should be holding this, lets check. I probably
> > > > > wouldn't have this bad feeling about things.
> > > > So your argument against such an interface is essentially "we can't
> > > > have nice things because someone might abuse them"?
> > > Some people are very creative ...
> > Sure, but that's no reason to stop anyone else from making progress.
> > 
> > > I was thinking about how to handle this better.  We could have
> > > 
> > > static inline void rwsem_assert_locked(const struct rw_semaphore *sem)
> > > {
> > > 	BUG_ON(atomic_long_read(&sem->count) == 0);
> > > }
> > > 
> > > static inline void rwsem_assert_write_locked(const struct rw_semaphore *sem)
> > > {
> > > 	BUG_ON((atomic_long_read(&sem->count) & 1) != 1);
> > > }
> > We already have CONFIG_DEBUG_RWSEMS, so we can put these
> > introspection interfaces inside debug code, and make any attempt to
> > use them outside of debug builds break the build. e.g:
> > 
> > #if DEBUG_RWSEMS
> > /*
> >   * rwsem locked checks can only be used by conditionally compiled
> >   * subsystem debug code. It is not valid to use them in normal
> >   * production code.
> >   */
> > static inline bool rwsem_is_write_locked()
> > {
> > 	....
> > }
> > 
> > static inline bool rwsem_is_locked()
> > {
> > 	....
> > }
> > #else /* !DEBUG_RWSEMS */
> > #define rwsem_is_write_locked()		BUILD_BUG()
> > #define rwsem_is_locked()		BUILD_BUG()
> > #endif /* DEBUG_RWSEMS */
> > 
> > And now we simply add a single line to subsystem Kconfig debug
> > options to turn on rwsem introspection for their debug checks like
> > so:
> > 
> >   config XFS_DEBUG
> >   	bool "XFS Debugging support"
> >   	depends on XFS_FS
> > +	select RWSEM_DEBUG
> >   	help
> >   	  Say Y here to get an XFS build with many debugging features,
> >   	  including ASSERT checks, function wrappers around macros,
> 
> That may be a possible compromise. Actually, I am not against having them
> defined even outside the DEBUG_RWSEMS. We already have mutex_is_locked()
> defined and used in a lot of places. So this is just providing the rwsem
> equivalents.

So, once again, we have mixed messages from the lock maintainers.
One says "no, it might get abused", another says "I'm fine with
that", and now we have a maintainer disagreement stalemate.

This is dysfunctional.

Peter, Waiman, please make a decision one way or the other about
allowing rwsems ito support native write lock checking. In the
absence of an actual yes/no decision, do we assume that the
maintainers don't actually care about it and we should just
submit it straight to Linus?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
