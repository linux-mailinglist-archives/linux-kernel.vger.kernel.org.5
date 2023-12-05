Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00338804A70
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 07:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344338AbjLEGlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 01:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbjLEGln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 01:41:43 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FFC120
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 22:41:50 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1d048c171d6so35140395ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 22:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1701758509; x=1702363309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sM9HKgTZr+p8ADu3gd1UavO919XUEWryeTGCYLI3vNw=;
        b=E7clarBXDAH9Z4294grZqgJPl/K4072peksEITs3kpEI4LYnGf3bKt7QME2Qi5Grge
         XIXCbBmy/iJbMwoWst/bBMqqNCD6QVZA18yRI6H1Bl+xqr6eIq5j6ZGH4vuKaBAkZnzT
         sUO96Bt+DaNW/lXNocLsPfc1ISh3I1N1rKcG9HGCEcRlguIlS0hBjqFsQu0dChdxEQYE
         RkRuPgTbo19HJAPnxh9jyleVkiKZjc0JpSRW6jqyA6WEEDT5Y1TsUXjB4vu5g81vvgoa
         4NYvEdd0L9iia1R9aJTEOOWCjNGtLXFLvVkAJB6mWnXxKw9AE+qGJk7g4SDIyVy435Oy
         zBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701758509; x=1702363309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sM9HKgTZr+p8ADu3gd1UavO919XUEWryeTGCYLI3vNw=;
        b=B38ggQGt94k1ShUaGuFaTCkE2D7BhrA8ALE4/0bFis3Gl0n+IofTu6qGYekQjYqVO/
         pR2E1B8SZpJJJdylvWz1x8OnNGh8NFIiwWieSLIibzYDazZvwP3Of+0UBWr0jUKxm5zJ
         IteHimaeO2gnu6zMVIZq6HOTPMmGjLW1o1ccrNbH4jcj6HJ0bdyRhg7pgN9YHSKvU6T/
         Cd5P42D6IgDkOdoi6vcO0xRaHLClo/qhhx+Vy/sl0zZccDQOgg1b+U2zHSDhAyUrtv9q
         DI9IXkOqRawW2FD7jDRl/RH/3nr+iexqo5qvvH1Y46IQGpiq5aE+kkUOavjgGHQH0epI
         p6zg==
X-Gm-Message-State: AOJu0YzdNo7VEDOqqwf1dsjEbqYktHyo40j3LgZbtvmdmUKJfRSsQH3C
        NWNN6PinNMb2TVukqq5sG22I8A==
X-Google-Smtp-Source: AGHT+IGGwRff8egiFit0GnW0c+0W5AJeqP3GsIUaY0ZilL8vXp8eTjV0aSiixF1UGouLxVBLkQDRSw==
X-Received: by 2002:a17:902:d2c7:b0:1d0:c445:8014 with SMTP id n7-20020a170902d2c700b001d0c4458014mr846274plc.76.1701758509530;
        Mon, 04 Dec 2023 22:41:49 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id h17-20020a170902f55100b001cfc50e5afesm7062435plf.23.2023.12.04.22.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 22:41:49 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1rAP7q-0044Nr-2j;
        Tue, 05 Dec 2023 17:41:46 +1100
Date:   Tue, 5 Dec 2023 17:41:46 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] Allow a kthread to declare that it calls
 task_work_run()
Message-ID: <ZW7GKku/F2QK9MrC@dread.disaster.area>
References: <20231204014042.6754-1-neilb@suse.de>
 <20231204014042.6754-2-neilb@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204014042.6754-2-neilb@suse.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 12:36:41PM +1100, NeilBrown wrote:
> User-space processes always call task_work_run() as needed when
> returning from a system call.  Kernel-threads generally do not.
> Because of this some work that is best run in the task_works context
> (guaranteed that no locks are held) cannot be queued to task_works from
> kernel threads and so are queued to a (single) work_time to be managed
> on a work queue.
> 
> This means that any cost for doing the work is not imposed on the kernel
> thread, and importantly excessive amounts of work cannot apply
> back-pressure to reduce the amount of new work queued.
> 
> I have evidence from a customer site when nfsd (which runs as kernel
> threads) is being asked to modify many millions of files which causes
> sufficient memory pressure that some cache (in XFS I think) gets cleaned
> earlier than would be ideal.  When __dput (from the workqueue) calls
> __dentry_kill, xfs_fs_destroy_inode() needs to synchronously read back
> previously cached info from storage.

We fixed that specific XFS problem in 5.9.

https://lore.kernel.org/linux-xfs/20200622081605.1818434-1-david@fromorbit.com/

Can you reproduce these issues on a current TOT kernel?

If not, there's no bugs to fix in the upstream kernel. If you can,
then we've got more XFS issues to work through and fix. 

Fundamentally, though, we should not be papering over an XFS issue
by changing how core task_work infrastructure is used. So let's deal
with the XFS issue first....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
