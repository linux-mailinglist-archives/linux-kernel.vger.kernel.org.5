Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10B17FFBB0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376517AbjK3ToR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjK3ToQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:44:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B8093
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 11:44:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01342C433C8;
        Thu, 30 Nov 2023 19:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701373462;
        bh=lVSnuH+tJnwYCxo7/cDHBwyalQ3cnS+JX2dNI0Wt3fU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vm24Fv+5VtVQZ+asYdfwlm8/G5iS7aYut/0Ux8Yn9Y31WRBaIRPvFy+UdGBsuAf8z
         ZQOvQEKERgjTFSYUf/bV9Tba2TgcUB5jEO5HsDLT/uWw3ga5vXmAuRWpjH1kjO2vVD
         +n+UF4D52Ypo62Cks9iGFeeJNOA2M4iIvsqYcG6bJ9rMM40U2lNTI2qrWe1ZDDCnw9
         ph/C8GFl7oXO37ivvdgR/fog4e8PrKf+r80OsDPqTervKsj2HKoUBH2upOmNadTl3C
         kFmX0UVrbnw8hcz1e8pF2zbWnFm8mY8DOcsSXHGw5OkEU2iDxX5I3VFS3ZNeiKNHX6
         5W/2ump3Xrbjg==
From:   SeongJae Park <sj@kernel.org>
To:     cuiyangpei <cuiyangpei@gmail.com>
Cc:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, xiongping1@xiaomi.com
Subject: Re: [PATCH 1/2] mm/damon/sysfs: Implement recording feature
Date:   Thu, 30 Nov 2023 19:44:20 +0000
Message-Id: <20231130194420.51355-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130091426.GA13946@cuiyangpei>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cuiyangpei,

On Thu, 30 Nov 2023 17:14:26 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:

> Hi SeongJae,
> 
> We also investigated the operation schemes you mentioned, but we don't
> think it can fit our needs.
> 
> On android, user will open many apps and switch between these apps as
> needs. We hope to monitor apps' memory access only when they are on
> foreground and record the memory access pattern when they are switched
> to the background. 
> 
> When avaliable memory reaches a threshold, we will use these access
> patterns with some strategies to recognize those memory that will have
> little impact on user experience and to reclaim them proactively.  
> 
> I'm not sure I have clarified it clearly, if you still have questions
> on this, please let us know.

So, to my understanding, you expect applications may keep similar access
pattern when they are in foreground, but have a different, less aggressive
access pattern in background, and therefore reclaim memory based on the
foreground-access pattern, right?

Very interesting idea, thank you for sharing!

Then, yes, I agree current DAMOS might not that helpful for the situation, and
this record feature could be useful for your case.

That said, do you really need full recording of the monitoring results?  If
not, DAMOS provides DAMOS tried regions feature[1], which allows users get the
monitoring results snapshot that include both frequency and recency of all
regions in an efficient way.  If single snapshot is not having enough
information for you, you could collect multiple snapshots.

You mentioned absence of Python on Android as a blocker of DAMOS use on the
previous reply[2], but DAMOS tried regions feature is not depend on tracepoints
or Python.

Of course, I think you might already surveyed it but found some problems.
Could you please share that in detail if so?

[1] https://docs.kernel.org/admin-guide/mm/damon/usage.html#schemes-n-tried-regions 
[2] https://lore.kernel.org/damon/20231129131315.GB12957@cuiyangpei/


Thanks,
SJ

> 
> Thanks.
