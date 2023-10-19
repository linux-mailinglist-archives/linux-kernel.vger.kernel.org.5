Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F0A7CF417
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345060AbjJSJaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344997AbjJSJaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:30:52 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333D898
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 02:30:50 -0700 (PDT)
Received: from fsav114.sakura.ne.jp (fsav114.sakura.ne.jp [27.133.134.241])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 39J9Ultw008723;
        Thu, 19 Oct 2023 18:30:48 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav114.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp);
 Thu, 19 Oct 2023 18:30:47 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 39J9Ul9w008720
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Oct 2023 18:30:47 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <5ef329fe-1f3b-4d81-9625-9738620f051e@I-love.SAKURA.ne.jp>
Date:   Thu, 19 Oct 2023 18:30:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource: disable irq when holding watchdog_lock.
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86@kernel.org, joel@joelfernandes.org
References: <80ff5036-8449-44a6-ba2f-0130d3be6b57@I-love.SAKURA.ne.jp>
 <CANDhNCpw+hEHNbtdAZR01HsHW_L1C0BXjZq21eXouQGNnYuUNQ@mail.gmail.com>
 <878r826xys.ffs@tglx>
 <90361195-4309-4a02-bd3f-8ee606e6d35b@I-love.SAKURA.ne.jp>
 <c9ddbc3f-dbb8-4ccc-8eb6-43554327984b@paulmck-laptop>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <c9ddbc3f-dbb8-4ccc-8eb6-43554327984b@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/17 23:10, Paul E. McKenney wrote:
>> But I'm hitting something different (but might be timer/scheduler related) problem.
>> What config option would cause taking more than 2 minutes to bring up only 8 CPUs?
>> (This environment is Oracle VM VirtualBox on Windows 11 host.)
>>
> The timing is about the same in both cases.  Does this happen in kernels
> built with CONFIG_PROVE_LOCKING=n?

Disabling all options in "Lock Debugging (spinlocks, mutexes, etc...)" does not help.

> 
> Either way, what mainline or -stable version is this?

The kernel is latest commit of upstream linux.git tree.
I'm seeing this slowdown (almost hung-up) problem for many releases,
but nobody else seems to be reporting this problem.

The only reliable workaround is to specify "nosmp" kernel command line option.

