Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50AA27F7234
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345717AbjKXK71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345713AbjKXK7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:59:24 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB63C10F5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:59:28 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ce5b72e743so290645ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700823568; x=1701428368; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9toATxM+d6eRCYqlZIqOo6hx5RVSvPJKB3GUF4f5giQ=;
        b=h9Gesy3Z6zaq+IWnbkWKK6dJihvbPPFbInBRHUIcpfxtfqzIT/MFY8Q5tuxrSVXhuW
         gjNKa69KKfAso6gvsT9+Vr4gB9IKbYrRtb+QTs/RhHNbpUQkJJcIGOXRIgIL5HYUw8nR
         hu4dopTjTeRgy257/3bLZHi3BUsbCjQTPC0FQzU3ebCEtrjJ4vnbGrE38jCzXUlCMpNL
         3L6kwg1NWzXcqE9C/Lbsoj5jiGOpVfNjh7abO4fo2PuZgVY+1IBEM4jkrXfp1rIl4zwQ
         aF95hsgJc8FMEqf7wBOzqMK4fi1Jp6cf8Mxa1lk2yJuNpEjh7FSplBg89T+IfpuTeph5
         73mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700823568; x=1701428368;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9toATxM+d6eRCYqlZIqOo6hx5RVSvPJKB3GUF4f5giQ=;
        b=CndXxgtYas1Bk2yW9p8r51mT/SYoQLKzhCdaTLQ8FOObY6YR/uQKLrNl9TedO7lD2a
         jFl//j7kdjpWyCbZHDyF7ApUXFMyqaWELNR/rVlysUX7ReBfqhrYBKMrYgV0OGJUOnzf
         7eLCLijOt7wEmwny+wfK2/8BcUJnlKeud25HY/+AvIGFeZ+EWay7+EFBvNSskuHwnxTz
         RyYwaC7Yu59YE8BPo5s8nCPSEMsNYouABVoc9I0yNzJIovX2jF9uPvFccyVURYSSOHhI
         uahFMRak1IwLRFd5t97NWrcWDDZ2k9DCRUU9bxfULvhk7hq0OliROlWwyAipGvpS3tk2
         Zetw==
X-Gm-Message-State: AOJu0Yw+IrKXsESmNPF7vFqfbP57fxAjMUjv+U4k6FI4nUTFDA8LbVcl
        wZPJQkE/GC7jSau48iuOlx9TPQ==
X-Google-Smtp-Source: AGHT+IG5wV5x+TYKfxmSYuOtoy+5GCFyIyMKVSF37bVK+/JgxbgLDuhPZEJ4oq55qm6WAhy1z4+3aQ==
X-Received: by 2002:a17:903:2312:b0:1ce:5f56:7fdb with SMTP id d18-20020a170903231200b001ce5f567fdbmr606021plh.25.1700823568098;
        Fri, 24 Nov 2023 02:59:28 -0800 (PST)
Received: from [2620:0:1008:15:ab09:50a5:ec6d:7b5c] ([2620:0:1008:15:ab09:50a5:ec6d:7b5c])
        by smtp.gmail.com with ESMTPSA id jk2-20020a170903330200b001b8b1f6619asm2939635plb.75.2023.11.24.02.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 02:59:27 -0800 (PST)
Date:   Fri, 24 Nov 2023 02:59:26 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        mhocko@suse.com, david@redhat.com, vbabka@suse.cz,
        hannes@cmpxchg.org, quic_pkondeti@quicinc.com,
        quic_cgoldswo@quicinc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH V2] mm: page_alloc: unreserve highatomic page
 blocks before oom
In-Reply-To: <1700823445-27531-1-git-send-email-quic_charante@quicinc.com>
Message-ID: <52128e17-7f69-ef51-95b4-5b4a338b9c3a@google.com>
References: <1700823445-27531-1-git-send-email-quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Fri, 24 Nov 2023, Charan Teja Kalla wrote:

> __alloc_pages_direct_reclaim() is called from slowpath allocation where
> high atomic reserves can be unreserved after there is a progress in
> reclaim and yet no suitable page is found. Later should_reclaim_retry()
> gets called from slow path allocation to decide if the reclaim needs to
> be retried before OOM kill path is taken.
> 
> should_reclaim_retry() checks the available(reclaimable + free pages)
> memory against the min wmark levels of a zone and returns:
> a)  true, if it is above the min wmark so that slow path allocation will
> do the reclaim retries.
> b) false, thus slowpath allocation takes oom kill path.
> 
> should_reclaim_retry() can also unreserves the high atomic reserves
> **but only after all the reclaim retries are exhausted.**
> 
> In a case where there are almost none reclaimable memory and free pages
> contains mostly the high atomic reserves but allocation context can't
> use these high atomic reserves, makes the available memory below min
> wmark levels hence false is returned from should_reclaim_retry() leading
> the allocation request to take OOM kill path. This can turn into a early
> oom kill if high atomic reserves are holding lot of free memory and
> unreserving of them is not attempted.
> 
> (early)OOM is encountered on a VM with the below state:
> [  295.998653] Normal free:7728kB boost:0kB min:804kB low:1004kB
> high:1204kB reserved_highatomic:8192KB active_anon:4kB inactive_anon:0kB
> active_file:24kB inactive_file:24kB unevictable:1220kB writepending:0kB
> present:70732kB managed:49224kB mlocked:0kB bounce:0kB free_pcp:688kB
> local_pcp:492kB free_cma:0kB
> [  295.998656] lowmem_reserve[]: 0 32
> [  295.998659] Normal: 508*4kB (UMEH) 241*8kB (UMEH) 143*16kB (UMEH)
> 33*32kB (UH) 7*64kB (UH) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB
> 0*4096kB = 7752kB
> 
> Per above log, the free memory of ~7MB exist in the high atomic
> reserves is not freed up before falling back to oom kill path.
> 
> Fix it by trying to unreserve the high atomic reserves in
> should_reclaim_retry() before __alloc_pages_direct_reclaim() can
> fallback to oom kill path.
> 
> Fixes: 0aaa29a56e4f ("mm, page_alloc: reserve pageblocks for high-order atomic allocations on demand")
> Reported-by: Chris Goldsworthy <quic_cgoldswo@quicinc.com>
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>

Acked-by: David Rientjes <rientjes@google.com>
