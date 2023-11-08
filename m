Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42B37E583A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 14:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbjKHN6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 08:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbjKHN6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 08:58:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CFB1BEF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 05:58:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B92DC433C7;
        Wed,  8 Nov 2023 13:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699451897;
        bh=/a9FgUe/BIr5zHWkGLlCKL2qwlPru5dGvvCfOaHtyzo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Lyt7u1CJ/ZF3jsfCB0gqngfio8ZQvFpDGerYJS8sdsRoF8vnn1XTJtrz4zY/WXT+D
         i1+80WpXejxv+DwgjnJmwBdyU8n6VihzENfNWN4Q6z9a7xbzMTPPAAYaqca/Ag71UY
         /cPxP6kqg5ZqA2wmmd5cPzzbj+bkI6nROqrub9GNFTPq2jkqbowZRYsTtTgIIzyH7S
         WrGYp5z4pTrIbgaJKUCDJyfsrG3ZEKQLBIQGdjc79rD2IMOSYaBWh/GJwZ7Y+0qKhH
         W0LBmhU4nXzXecfTwVKuqUk+QVJXWQcbiAfM6J7wxJDburOpQ1FRE+A/Lvbll6/vXd
         CMcVeEzi39wuw==
Message-ID: <be487754-5073-467b-8c73-6727e8dc3530@kernel.org>
Date:   Wed, 8 Nov 2023 14:58:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] sched/deadline: Deferrable dl server
Content-Language: en-US, pt-BR, it-IT
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Phil Auld <pauld@redhat.com>
References: <cover.1699095159.git.bristot@kernel.org>
 <c7b706d30d6316c52853ca056db5beb82ba72863.1699095159.git.bristot@kernel.org>
 <CAEXW_YS=PrWDx+YGVR7bmq0_SoKNztzGrreApCd9qk1yBLA5bA@mail.gmail.com>
 <CAEXW_YQ8kv3tXQJexLSguPuWi0bXiReKDyYNo9+A-Hgp=Zo1vA@mail.gmail.com>
 <CAEXW_YSjsZSrJK_RbGmbLNy4UrLCgu+7NPZjg-wiLuNbGOGr+w@mail.gmail.com>
 <20231107114732.5dd350ec@gandalf.local.home>
 <7d1ea71b-5218-4ee0-bc89-f02ee6bd5154@redhat.com>
 <3e58fad7-7f66-4e48-adcc-0fda9e9d0d07@kernel.org>
 <20231108124401.GQ8262@noisy.programming.kicks-ass.net>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20231108124401.GQ8262@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/23 13:44, Peter Zijlstra wrote:
> Should we rather not cap the runtime, something like so?
> 
> Because the above also causes period drift, which we do not want.

like in the example I showed before:

- 3/10 reservation (30%).
- w=waiting
- r=running
- s=sleeping
- T=throttled
- fair server dispatched at 0, starvation from RT.


|wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww|rrrrrrrrrrrrrrrrrrrrrrrrrrrrrr|TTTTTTTTTT[...]TTTTTTTTTTT|rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr|TTTTTTT
|___________________________period 1_________________________________|_________period 2________________________[...]___________|___period 3____________________|[.... internal-period
0---------1---------2---------3---------4---------5---------6--------7--------8---------9----------10.......11.[...]16.........17........18........19........20|[.... < Real-time
---------------------------------------------------------------------+---------------------------------------------------------|
                                                                     |                                                         +new period

From "real-world/wall clock" the internal period shift produces the
"zerolax" timeline. It runs 3 units of time before the 10's.

If one has a mix of DL and FIFO task, and want to enforce
a given response time to the fair server, they can reduce the
fair server period to achieve that.

-- Daniel
