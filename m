Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92444801B63
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 09:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjLBIHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 03:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjLBIHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 03:07:14 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A001D40
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 00:07:20 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1cfd4ef9f06so12243305ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 00:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701504440; x=1702109240; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F4H7ix0GwWOKnKT1fbRv5Z46mxtqVFyhAaxH7ZBfa1E=;
        b=O9gn3MhTdeau9nhpn+bsi6gmelfMzayHFqtWWoUuQYWWfruDNnZrLHSqInLvTLWDqe
         RSfEfu+nBxmkCDr4r8xCnBFnpc3qxySYwh775WA/xTX4/faYQPEN5WqWmzKsXAbdrWgA
         XeYwmacJQ3SthOXObxtoDFVG85zURy6YkqRY0hIEjoLUuxfUxMhCyXf4vpIXa0YV7N1x
         Ain19NBLZaSz7wkH8j01y3f7BquOitl/xKEGMgIw/+3kHa2syhEyZ7wThXVEoN2RH5lh
         f9LHUjtrivPfuP5+mWjy1t6ce2uQvJRKGo7e90g+cio3jiBZ5pJxFxNJkEstsrKi23rV
         OdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701504440; x=1702109240;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F4H7ix0GwWOKnKT1fbRv5Z46mxtqVFyhAaxH7ZBfa1E=;
        b=KZYcj+WWn/ly7Daqw3niOR0/Wy7LdH+gsjQl7ff/MtWg/MTI6/cnULYQPS8whm0qpE
         0kxXtnpn+whN8JieOiVwI+aqcQzWYsjBjKkFmti58lY0t32w1wsQ7uguEvq0YAhVA9UO
         cHk29qtLhcgo+abucuaY7pSfNYAcNHnhSfnGUpCJMxYgwqSPHVhWxQWnTdbIf5TCNu/a
         89JzdImRhII7Yc1b3kz0RxhpFudfYa1z8lYElNxkTWatBr3J0mF57O9pEHUs86KpW+gH
         Hg2V7iEbkqbKOpJ7PshrSMMHutuf3ayG+1EcjoTQDCf5O0R+09UkHSARLbsXF7SJP4xT
         S7GA==
X-Gm-Message-State: AOJu0YzbTzUbuyCyZSHPUmERivC2CEW14sZX0UpxYgmTfguXLxm5xhfj
        9P/R94zgqicKluybhMoY69aqCoS//OMmHw==
X-Google-Smtp-Source: AGHT+IG2eYR6XCK75HIwvJKDXYxZCz40j886qrZkIZ8OMvd/IHm4nrH6JYuAPk74Uv56De/DVsgtHOrY69VO2A==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a17:902:f801:b0:1d0:5cf0:8ab6 with SMTP
 id ix1-20020a170902f80100b001d05cf08ab6mr356679plb.10.1701504439521; Sat, 02
 Dec 2023 00:07:19 -0800 (PST)
Date:   Sat, 2 Dec 2023 08:07:17 +0000
In-Reply-To: <20231129032154.3710765-5-yosryahmed@google.com>
Mime-Version: 1.0
References: <20231129032154.3710765-1-yosryahmed@google.com> <20231129032154.3710765-5-yosryahmed@google.com>
Message-ID: <20231202080717.ykhhu7fvryarphmi@google.com>
Subject: Re: [mm-unstable v4 4/5] mm: workingset: move the stats flush into workingset_test_recent()
From:   Shakeel Butt <shakeelb@google.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        "Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 03:21:52AM +0000, Yosry Ahmed wrote:
> The workingset code flushes the stats in workingset_refault() to get
> accurate stats of the eviction memcg. In preparation for more scoped
> flushed and passing the eviction memcg to the flush call, move the call
> to workingset_test_recent() where we have a pointer to the eviction
> memcg.
> 
> The flush call is sleepable, and cannot be made in an rcu read section.
> Hence, minimize the rcu read section by also moving it into
> workingset_test_recent(). Furthermore, instead of holding the rcu read
> lock throughout workingset_test_recent(), only hold it briefly to get a
> ref on the eviction memcg. This allows us to make the flush call after
> we get the eviction memcg.
> 
> As for workingset_refault(), nothing else there appears to be protected
> by rcu. The memcg of the faulted folio (which is not necessarily the
> same as the eviction memcg) is protected by the folio lock, which is
> held from all callsites. Add a VM_BUG_ON() to make sure this doesn't
> change from under us.
> 
> No functional change intended.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Tested-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
