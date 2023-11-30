Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A3C7FFE67
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 23:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377140AbjK3WWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 17:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbjK3WWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 17:22:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E89910DC
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 14:22:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B0EC433C9;
        Thu, 30 Nov 2023 22:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1701382979;
        bh=I70BdKU/73bt3bINwbAQDlbPPsOr3EaYr337MLhm72A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hMuAYQacI3uy8MkIewi8Y0e99BqFxrdh+u3R7OkSUWJESruRNEZqWOS/YIYOr+3oO
         N7WBa7oVTjiSY7xIos4KFgVnq9iIxpGl6vaCtEWq68ZV45Ot+Zw49VvJKxZCPVVu6S
         1NpX40MRKfdKgScLv4ZYbYBe5D2rNfhvzA+Py8cs=
Date:   Thu, 30 Nov 2023 14:22:58 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] mm/damon: let users feed and tame/auto-tune DAMOS
Message-Id: <20231130142258.c06fcb7c0c9abd339bab5c32@linux-foundation.org>
In-Reply-To: <20231130023652.50284-1-sj@kernel.org>
References: <20231130023652.50284-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2023 02:36:43 +0000 SeongJae Park <sj@kernel.org> wrote:

> The core logic uses the below simple feedback loop algorithm to
> calculate the next aggressiveness level of the scheme from the current
> aggressiveness level and the current feedback (target_score and
> current_score).  It calculates the compensation for next aggressiveness
> as a proportion of current aggressiveness and distance to the target
> score.  As a result, it arrives at the near-goal state in a short time
> using big steps when it's far from the goal, but avoids making
> unnecessarily radical changes that could turn out to be a bad decision
> using small steps when its near to the goal.

fwiw, the above is a "proportional controller".  MGLRU has, in
vmscan.c, a PID controller (proportional, integral, derivative).  PID
controllers have better accuracy (the integral feedback) and better
stability (the derivative feedback).

Generalizing MGLRU's PID controller might be somewhat challenging!
