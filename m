Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE85A7A6CF6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 23:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbjISVbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 17:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjISVbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 17:31:16 -0400
Received: from zproxy1.foxvalley.net (zimbra.foxvalley.net [212.78.26.134])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 8FCD0AD
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 14:31:09 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy1.foxvalley.net (Postfix) with ESMTP id 11A1A40F41;
        Tue, 19 Sep 2023 16:31:09 -0500 (CDT)
Received: from zproxy1.foxvalley.net ([127.0.0.1])
 by localhost (zproxy1.foxvalley.net [127.0.0.1]) (amavis, port 10032)
 with ESMTP id TTPAtvcRs1Uy; Tue, 19 Sep 2023 16:31:04 -0500 (CDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy1.foxvalley.net (Postfix) with ESMTP id 2E2F940F48;
        Tue, 19 Sep 2023 16:31:04 -0500 (CDT)
X-Virus-Scanned: amavis at zproxy1.foxvalley.net
Received: from zproxy1.foxvalley.net ([127.0.0.1])
 by localhost (zproxy1.foxvalley.net [127.0.0.1]) (amavis, port 10026)
 with ESMTP id jx6hYx1nuwrR; Tue, 19 Sep 2023 16:31:04 -0500 (CDT)
Received: from [192.168.1.3] (unknown [161.97.241.227])
        by zproxy1.foxvalley.net (Postfix) with ESMTPSA id D692D40F41;
        Tue, 19 Sep 2023 16:31:03 -0500 (CDT)
Message-ID: <ac03a0cf-d699-47bc-bc14-f030fa2408d2@foxvalley.net>
Date:   Tue, 19 Sep 2023 15:31:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v1] arch/x86: port I/O tracing on x86
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com
References: <14c27df7-12a3-e432-a741-17672185c092@foxvalley.net>
 <20230919194337.GC424@noisy.programming.kicks-ass.net>
 <a5c505d1-730c-912c-3c83-1df83d8e264b@foxvalley.net>
 <20230919211214.GE424@noisy.programming.kicks-ass.net>
From:   Dan Raymond <draymond@foxvalley.net>
In-Reply-To: <20230919211214.GE424@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/2023 3:12 PM, Peter Zijlstra wrote:
>>> This means I can no longer use early_console->write() to print to my
>>> early_serial_console.
>>
>> Why not?  Did you try it?
> 
> I have tried debugging the kernel for the last 15+ years. The only
> reliable way to get something out of the machine is outb on the serial
> port. Anything else is a waste of time..
> 
> Adding tracing to it (which relies on RCU, which might not be alive at
> this point) which might itself be the problem, is a total no-go.
> 
> You do not wreck early_serial_console.

But you didn't try my patch to see if it "wrecks" early_serial_console.
I doubt it has any impact there because it does not get compiled into
boot code.  Notice the BOOT_COMPRESSED_MISC_H and BOOT_BOOT_H checks.

I don't understand your general objection.  The kernel already has
tracing for memory mapped I/O which includes serial ports.  This patch
just extends that to include port I/O.
