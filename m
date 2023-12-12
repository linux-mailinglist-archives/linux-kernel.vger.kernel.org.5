Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AC380F954
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377410AbjLLV1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377383AbjLLV1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:27:08 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CBECA;
        Tue, 12 Dec 2023 13:27:14 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5c701bd9a3cso1547329a12.0;
        Tue, 12 Dec 2023 13:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702416434; x=1703021234; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mGU0tRhB9g2my+2/cE06clpBuE4ux9GMlKQnA88vmOY=;
        b=iUHJL12hkaQpYvJQ51GOvvbzu/A/N0rTuQ9psB+2rNSXP6LkUljAEAFJGzmUzqsd8Y
         k19JbyOQNfT4Cb1i5H5juVQW+aDQl8g6TysUlVJ+HcGsjN4JK15r/Hdz65Ps0bTchMFB
         yMzrgeYCM86VOtVueS2DBBZcM9kprpwSXoaGyz9WSrEyzC+RLKZzasF+ZgXBNh9YR7V8
         ANk7Q7yDQZQq5vYJe+b8Pxu0cjlRdfFmbAWSP+BqfujUNIkTbO+HMGuhztFmS0LNIoUD
         7koDQSw/GioKmImtedBeLSVhELItrkvMSk8u2V9lldI2A4ZCLO8j1FR7MNw0edwU0DUl
         ig/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702416434; x=1703021234;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mGU0tRhB9g2my+2/cE06clpBuE4ux9GMlKQnA88vmOY=;
        b=JzdV0RzQov9nK0dE9tZioMWR0GOF/nyHxWgeI3YrZ0wmMcP9oBcgrOyNXIqqnNtyvz
         oX2BK3rhWM+jW9aJ2P5E6HNBHuSVtxgRTKDatDfD6SyymIG+oo94ZdzPWnN2ZbnimXZs
         M2OqmRZgQeSVra5BIaC70X+Ylu5EFTuB2rpZtf5B53uP2HBfXZj+/jYjPc0Zr3HeMUFH
         T1hWwaMyelgkpM6jDLucUbDvAMALJXhGImcC2+wlGcFGyN+ip62+j3XWbu8aSQgM8H3h
         nCfnJIw4Bmxfa7fAtoQAfuZMHX0nOoExnBw6emwqrHm+N79UtDQ10F65e9RztRv4EaD9
         cGHw==
X-Gm-Message-State: AOJu0Yw+un8AUMSWFyOZJblRxKk3LAnv2l3zJA/FrH115xQmVmUh/1sg
        ocKga8EYNZlVQxbK3gzJ8Fc=
X-Google-Smtp-Source: AGHT+IEOqV6YioHzLz+CMzevAybZpWI90BvWGUhoOK81GcGWs2eSGpaD9M4nWE3MXP3iEb5BjRySyQ==
X-Received: by 2002:a05:6a20:3d1e:b0:18f:b870:e9b3 with SMTP id y30-20020a056a203d1e00b0018fb870e9b3mr3562327pzi.121.1702416433791;
        Tue, 12 Dec 2023 13:27:13 -0800 (PST)
Received: from dschatzberg-fedora-PF3DHTBV ([2620:10d:c090:500::5:671e])
        by smtp.gmail.com with ESMTPSA id z21-20020a656115000000b0059d219cb359sm7504411pgu.9.2023.12.12.13.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 13:27:13 -0800 (PST)
Date:   Tue, 12 Dec 2023 16:27:09 -0500
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Huan Yang <link@vivo.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Chris Li <chrisl@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH V3 1/1] mm: add swapiness= arg to memory.reclaim
Message-ID: <ZXjQLXJViHX7kMnV@dschatzberg-fedora-PF3DHTBV>
References: <20231211140419.1298178-1-schatzberg.dan@gmail.com>
 <20231211140419.1298178-2-schatzberg.dan@gmail.com>
 <CAJD7tkZQ2aakT8M2bTg0bp4sDtrGYv_4i4Z4z3KBerfxZ9qFWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkZQ2aakT8M2bTg0bp4sDtrGYv_4i4Z4z3KBerfxZ9qFWA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 11:41:24AM -0800, Yosry Ahmed wrote:
> On Mon, Dec 11, 2023 at 6:04 AM Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
> 
> contains* the*
> 
> I think this statement was only important because no keys were
> supported, so I think we can remove it completely and rely on
> documenting the supported keys below like other interfaces, see my
> next comment.
> 
> > +       to reclaim.
> >
> >         Example::
> >
> > @@ -1304,6 +1304,17 @@ PAGE_SIZE multiple when read back.
> >         This means that the networking layer will not adapt based on
> >         reclaim induced by memory.reclaim.
> >
> > +       This file also allows the user to specify the swappiness value
> > +       to be used for the reclaim. For example:
> > +
> > +         echo "1G swappiness=60" > memory.reclaim
> > +
> > +       The above instructs the kernel to perform the reclaim with
> > +       a swappiness value of 60. Note that this has the same semantics
> > +       as the vm.swappiness sysctl - it sets the relative IO cost of
> > +       reclaiming anon vs file memory but does not allow for reclaiming
> > +       specific amounts of anon or file memory.
> > +
> 
> Can we instead follow the same format used by other nested-keyed files
> (e.g. io.max)? This usually involves a table of supported keys and
> such.

Thanks, both are good suggestions. Will address these.

> > +       while ((start = strsep(&buf, " ")) != NULL) {
> > +               if (!strlen(start))
> > +                       continue;
> > +               switch (match_token(start, if_tokens, args)) {
> > +               case MEMORY_RECLAIM_SWAPPINESS:
> > +                       if (match_int(&args[0], &swappiness))
> > +                               return -EINVAL;
> > +                       if (swappiness < 0 || swappiness > 200)
> 
> I am not a fan of extending the hardcoded 0 and 200 values, and now
> the new -1 value. Maybe it's time to create constants for the min and
> max swappiness values instead of hardcoding them everywhere? This can
> be a separate preparatory patch. Then, -1 (or any invalid value) can
> also be added as a constant with a useful name, instead of passing -1
> to all other callers.
> 
> This should make the code a little bit more readable and easier to extend.

I'm not sure I understand the concern. This check just validates that
the swappiness value inputted is between 0 and 200 (inclusive)
otherwise the interface returns -EINVAL. Are you just concerned that
these constants are not named explicitly so they can be reused
elsewhere in the code?
