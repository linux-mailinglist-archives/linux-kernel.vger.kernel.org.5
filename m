Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FACB7FEBA2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbjK3JO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbjK3JO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:14:26 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03BC1A8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:14:32 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cfc2bcffc7so6663685ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701335672; x=1701940472; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkZm04lfRlD3mzOUGiHtFxV8qZ1vw4L1VTf3erF9dac=;
        b=XARN8ftdHu7RvmsxQnJP9OUtda79Rz3Ua6qMKRIxomYTCteBpdApQFQqTkYKOeXIlz
         nOX23kFGIFtM3QuCVMB++l1l8KXfixGGY0mKziOLMrlKv40AMb+IKNek3GKdNGJkNhWY
         6obnKsExtMKO1TepvPUwX+kNsNLfwxXzf1QwQAPECkt/XeE3ePYG6VLEt2iJB0z2a1ks
         sen8PeonG58XkV9ijH3caZcjM8Q8savj3oJZO5rYr98DWRtl9jamlzob21xWY4RtkFiA
         cJBAbEXCXN6gZB9maq6r8mIxKnjq7j4qwJJKqzb0kXnHO8uWIkaVSTn6INvs7/egygVg
         A5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701335672; x=1701940472;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkZm04lfRlD3mzOUGiHtFxV8qZ1vw4L1VTf3erF9dac=;
        b=cJIyxFI23Q8Q8IJe53I7T2/5VfkHGiw5jUXheDQkHPR3GwKNa8FGnT59SkAgU6JAqC
         LyrFJhagAJ5gIskooHj6mZJWJfrQGcfnZVP4NgegniwNTgZdJLjvEBqOFEDfzdS27kEf
         Yey+WOZnQ/dODYSC1Q2NXrKgXiuxmrov3vA3FrJHc5JGkcDoThE4kxC/ir0KQ2N91Awn
         SFtokVET4DcVLu4wRHvhfE5h2uQkGmJGmQf/Z9x4gitsuGIC8m/sS+N6cjHOR64Ef8s8
         TqPXD3u1Vdb0D0RBaiINAzczAN2xKjZRB5EEbhwvvHnjdGQNn+qtqND6ru6JHtBZwyx8
         tm8Q==
X-Gm-Message-State: AOJu0YwoUQ1UxuRhmqhf6Zk9ds4S/+z3uN1wt8UvJ8YYono3TPKV9lcm
        5Tbiup0boDK1fe9jNFt8Yew=
X-Google-Smtp-Source: AGHT+IFcncNN/ZTUn02k8CmbBs5KH3TQJCqee4HEtCviqsR8oz+yW8pmspfox950SyTatF7XsUr+2g==
X-Received: by 2002:a17:902:db09:b0:1cf:cc0d:b269 with SMTP id m9-20020a170902db0900b001cfcc0db269mr15176117plx.40.1701335672265;
        Thu, 30 Nov 2023 01:14:32 -0800 (PST)
Received: from cuiyangpei ([43.224.245.227])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902700400b001cfc46baa40sm835498plk.158.2023.11.30.01.14.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Nov 2023 01:14:31 -0800 (PST)
Date:   Thu, 30 Nov 2023 17:14:26 +0800
From:   cuiyangpei <cuiyangpei@gmail.com>
To:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     xiongping1@xiaomi.com
Subject: Re: [PATCH 1/2] mm/damon/sysfs: Implement recording feature
Message-ID: <20231130091426.GA13946@cuiyangpei>
References: <20231129131315.GB12957@cuiyangpei>
 <20231129171058.50270-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129171058.50270-1-sj@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi SeongJae,

We also investigated the operation schemes you mentioned, but we don't
think it can fit our needs.

On android, user will open many apps and switch between these apps as
needs. We hope to monitor apps' memory access only when they are on
foreground and record the memory access pattern when they are switched
to the background. 

When avaliable memory reaches a threshold, we will use these access
patterns with some strategies to recognize those memory that will have
little impact on user experience and to reclaim them proactively.  

I'm not sure I have clarified it clearly, if you still have questions
on this, please let us know.

Thanks.

On Wed, Nov 29, 2023 at 05:10:58PM +0000, SeongJae Park wrote:
> Hi Cuiyangpei,
> 
> On Wed, 29 Nov 2023 21:13:15 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:
> 
> > Hi SeongJae,
> > 
> > We are using damon on the Android operating system. It starts monitoring
> > when app comes to the foreground, stops monitoring and save the
> > monitoring results when app goes to the background.
> 
> Thank you so much for sharing this detailed use case.  This will be very
> helpful for us at understanding real usage of DAMON and making it better for
> that together.
> 
> > 
> > The two methods that you mentioned,
> > 
> > 1.tracepoint events
> > This method requires opening the tracepoint event and using the
> > 'perf-record' tool to generate the perf.data file. Then parsing the
> > perf.data file. However, the user's phone is not enabled tracepoint
> > events. Additionally, the generated file is quite complex, and we only
> > need memory addresses and access frequency informations.
> 
> That's fair points, thank you for kindly explaining this.
> 
> > 
> > 2. damos
> > There is no direct Python runtime environment on android phones.
> > 
> > Both of these methods provide results that are not very intuitive and
> > require complex parsing. We save the results in the format of starting
> > address, region size, and access frequency. When the available memory
> > reaches a threshold, the user space reclaim memory with low access
> > frequency by calling 'process_madvise' function.
> 
> Again, very fair points.  So, if I understood correctly, you want to reclaim
> cold pages proactively when the available memory reaches a threshold, right?
> DAMON could do that directly instead of you[1].  Using that, you don't need to
> save the access pattern and parse but just ask DAMON to find memory regions of
> specific access frequency range and reclaim.  Have you also considered using
> that but found some problems?
> 
> I understand the feature may not perfectly fit for your use case, and I want to
> learn from you how it could be better.
> 
> [1] https://docs.kernel.org/mm/damon/design.html#operation-schemes
> 
> 
> Thanks,
> SJ
> 
> > 
> > Thanks.
> > 
> [...]
