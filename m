Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B6D7C5517
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346767AbjJKNP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234958AbjJKNPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:15:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE2593
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wylDPGSbHiTs2Q0e0qTsSFcSCa3RyAKkf9nWVpyjUCY=; b=mebrz071sEeYDPh0ZW+qz0ZUqG
        YdF8RkDeylhLVNWiJfMteUPHUpVlCv4WW3P3uCEFj7NoUjAf5WaeBOLDX0XTZLYn+OtL/+JpA7T/j
        PWJZ/ZupdCvw5rmm/0cKXDKwL+DUQ9cLvCMb7kyFrKoRezs9GD4LLkGBAJRsQ/0l7AhBceaAN71Hi
        6ZPhbBGzfz0PQs3WOkNlaDcqcBZNVum4GyqoHcmm5gOZEBpZ2gGY4QSIuLOYkighRFFlHJIsxFdyW
        g/9oGE7j4qPELHoetP85krpMOeSm0JDVHZrG99N6opUzDUEnPaGNAGPGGEPIXxtgNL0UmzjzjJgjy
        ru1weJBw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qqZ38-00AwZW-Sw; Wed, 11 Oct 2023 13:14:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8BB9730036C; Wed, 11 Oct 2023 15:14:54 +0200 (CEST)
Date:   Wed, 11 Oct 2023 15:14:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Benjamin Segall <bsegall@google.com>, mingo@kernel.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bristot@redhat.com,
        corbet@lwn.net, qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org, efault@gmx.de,
        tglx@linutronix.de
Subject: Re: [PATCH] sched/fair: fix pick_eevdf to always find the correct se
Message-ID: <20231011131454.GN14330@noisy.programming.kicks-ass.net>
References: <20230531115839.089944915@infradead.org>
 <20230531124603.931005524@infradead.org>
 <xm261qego72d.fsf_-_@google.com>
 <6b606049-3412-437f-af25-a4c33139e2d8@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b606049-3412-437f-af25-a4c33139e2d8@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 08:12:09PM +0800, Abel Wu wrote:

> The implementation of __pick_eevdf() now is quite complicated which
> makes it really hard to maintain. I'm trying my best to refactor this
> part, hopefully can do some help. Below is only for illustration, I
> need to test more.

Well, the form it has now is somewhat close to the one in the paper. I
think Ben added one early break it doesn't have or something.

As the paper explains, you get two walks, one down the eligibility path,
and then one down the heap. I think the current code structure
represents that fairly well.

Very vague memories seem to suggest I thought to be clever some 10+
years ago when I wrote that other decent loop that Ben showed to be
broken (and woe on me for not verifying it when I resurrected the
patches, I rewrote pretty much everything else, except this lookup :/).

