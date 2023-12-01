Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF09800ACE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 13:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378816AbjLAMZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 07:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378794AbjLAMZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 07:25:07 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464C4103
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 04:25:13 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d0521554ddso3881165ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 04:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701433513; x=1702038313; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFLb7KVsw6jFSNkRuQETVY19rXhRyG8eEk4pj82LTQI=;
        b=DEP/ODObVD1AuiDKT8gJM785fdqd7hJ/lf+yqh59jGQobq0G05lxfhzfRf6JwEo1u/
         4Mqgc/a2Jh5s4oU7pbvYAgxq7+tucHKVAIhc+NBuYCzUcz0wOtZGe0ZZb1RVQBXnBYta
         zDdjpburOXMJSwPH00EuUjF3Bl4c82HvGuNwtaiwSilYbyZonXN9pwbCJoFUIje2pr4/
         2gVxPfYDkmLfU3FHmrf4ThGiRtQu/2b+11YcGptDG0YJTD1rHuSdaHoNwgQHdfkVh5iq
         LEkATGiirtNIrH+KB45XjsaL+5Wb6xEkj8yWOyCpEtkC6n+sGKejP5BdLz2B6ZvqVnvK
         1d1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701433513; x=1702038313;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vFLb7KVsw6jFSNkRuQETVY19rXhRyG8eEk4pj82LTQI=;
        b=j/SdgAgVwEugHRdcHqQR+tGq3i5k3/HkWM3n9AJrY8JT9ZPE4IqNNojuIOihUgMFTq
         b12PGkOMCQ3lKpScHj+ONWSJ7CwRv5dkEMl7WYBs1xJ0/AIvoCGeVj454PHb1IIVBIrz
         UPlT7UOdQThVE6P3/xJFTuLw/5FMpgFOfemhSGqrm4Kg/wp0GP6b6mbkyfeFymIl9tQp
         q6UBzSxmPxLyLA1RfdKGq5PRuJNlE+mgfjdtM/dZ3jLtRHy9uvbKIy0wPJ6KAkyXtonb
         40H+82yT6g3qMWObIr+8SNpt8uQy+qwZwG4uUCy4WfbBFGygM0fYOFkAEJIt+DnCmKG5
         QUhA==
X-Gm-Message-State: AOJu0Yy4u8PhAUQ9UQW0XH0pXyBpzcSNwt/5Vizixn2zywCTpdkZHJnC
        KcatH8iWEFsIxnkqOhxJq2E=
X-Google-Smtp-Source: AGHT+IGwHjW8ph1E++zlfVk58m5vvGNHyejPxcXVReGB+FDfMZvDbQ7ctLqTN3OYTS2OGZHVQSIrgA==
X-Received: by 2002:a17:903:445:b0:1d0:5db3:7791 with SMTP id iw5-20020a170903044500b001d05db37791mr661485plb.63.1701433512659;
        Fri, 01 Dec 2023 04:25:12 -0800 (PST)
Received: from cuiyangpei ([43.224.245.227])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b001cfacc54674sm3250857pln.106.2023.12.01.04.25.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Dec 2023 04:25:12 -0800 (PST)
Date:   Fri, 1 Dec 2023 20:25:07 +0800
From:   cuiyangpei <cuiyangpei@gmail.com>
To:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     xiongping1@xiaomi.com
Subject: Re: [PATCH 1/2] mm/damon/sysfs: Implement recording feature
Message-ID: <20231201122507.GA15806@cuiyangpei>
References: <20231130091426.GA13946@cuiyangpei>
 <20231130194420.51355-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130194420.51355-1-sj@kernel.org>
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

On Thu, Nov 30, 2023 at 07:44:20PM +0000, SeongJae Park wrote:
> Hi Cuiyangpei,
> 
> On Thu, 30 Nov 2023 17:14:26 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:
> 
> > Hi SeongJae,
> > 
> > We also investigated the operation schemes you mentioned, but we don't
> > think it can fit our needs.
> > 
> > On android, user will open many apps and switch between these apps as
> > needs. We hope to monitor apps' memory access only when they are on
> > foreground and record the memory access pattern when they are switched
> > to the background. 
> > 
> > When avaliable memory reaches a threshold, we will use these access
> > patterns with some strategies to recognize those memory that will have
> > little impact on user experience and to reclaim them proactively.  
> > 
> > I'm not sure I have clarified it clearly, if you still have questions
> > on this, please let us know.
> 
> So, to my understanding, you expect applications may keep similar access
> pattern when they are in foreground, but have a different, less aggressive
> access pattern in background, and therefore reclaim memory based on the
> foreground-access pattern, right?
>

Different apps may have different access pattern. On android, the apps will
join in freeze cgroup and be frozen after switch to the background. So we 
monitor apps' memory access only when they are in foreground.
> Very interesting idea, thank you for sharing!
> 
> Then, yes, I agree current DAMOS might not that helpful for the situation, and
> this record feature could be useful for your case.
> 
> That said, do you really need full recording of the monitoring results?  If
> not, DAMOS provides DAMOS tried regions feature[1], which allows users get the
> monitoring results snapshot that include both frequency and recency of all
> regions in an efficient way.  If single snapshot is not having enough
> information for you, you could collect multiple snapshots.
> 
> You mentioned absence of Python on Android as a blocker of DAMOS use on the
> previous reply[2], but DAMOS tried regions feature is not depend on tracepoints
> or Python.
> 
> Of course, I think you might already surveyed it but found some problems.
> Could you please share that in detail if so?
> 
DAMOS tried regions feature you mentioned is not fully applicable. It needs to
apply schemes on regions. There is no available scheme we can use for our use
case. What we need is to return regions with access frequency and recency to
userspace for later use.
> [1] https://docs.kernel.org/admin-guide/mm/damon/usage.html#schemes-n-tried-regions 
> [2] https://lore.kernel.org/damon/20231129131315.GB12957@cuiyangpei/
> 
> 
> Thanks,
> SJ
> 
> > 
> > Thanks.
