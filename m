Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130E975D8D8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 03:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjGVB5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 21:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGVB5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 21:57:22 -0400
Received: from mailgw.gate-on.net (auth.gate-on.net [IPv6:2001:278:1033:4::74:21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03B63C06
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 18:57:20 -0700 (PDT)
Received: from vega.pgw.jp (unknown [49.135.109.134])
        by mailgw.gate-on.net (Postfix) with ESMTP id 3DE47802A7;
        Sat, 22 Jul 2023 10:57:17 +0900 (JST)
Received: from localhost (vega.pgw.jp [10.5.0.30])
        by vega.pgw.jp (Postfix) with SMTP
        id 7059CA53D; Sat, 22 Jul 2023 10:57:14 +0900 (JST)
From:   <kkabe@vega.pgw.jp>
Content-Type: text/plain; charset=ISO-2022-JP
To:     rostedt@goodmis.org
Cc:     regressions@lists.linux.dev, bagasdotme@gmail.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        kkabe@vega.pgw.jp
Subject: Re: radeon.ko/i586: BUG: kernel NULL pointerdereference,address:00000004
In-Reply-To: Your message of "Mon, 17 Jul 2023 11:21:38 -0400".
        <20230717112138.1fd48cca@gandalf.local.home>
X-Mailer: mnews [version 1.22PL5] 2002-11-27(Wed)
Date:   Sat, 22 Jul 2023 10:57:14 +0900
Message-ID: <230722105714.M0104460@vega.pgw.jp>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rostedt@goodmis.org sed in <20230717112138.1fd48cca@gandalf.local.home>

>> On Sat, 15 Jul 2023 11:39:11 +0900
>> <kkabe@vega.pgw.jp> wrote:
>> 
>> 
>> > Yes, this is puzzling. That's why I need other people's opinion on this.
>> > Does it matter the DUT is a slow machine (Pentium 120MHz)?
>> > 
>> 
>> Hmm, I wonder because the workqueue is running __init functions, could it
>> possibly be that it didn't finish before the end of boot, where it frees
>> all the functions? It shouldn't do that because there's code to make sure
>> it's done before it continues further.
>> 
>> But just in case something isn't working as planned, you could try this
>> patch to see if the bug goes away.
>> 
>> -- Steve
>> 
>> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
>> index 05c0024815bf..af5a40ef3be4 100644
>> --- a/kernel/trace/ftrace.c
>> +++ b/kernel/trace/ftrace.c
>> @@ -3771,13 +3771,13 @@ static int test_for_valid_rec(struct dyn_ftrace *rec)
>>  	return 1;
>>  }
>>  
>> -static struct workqueue_struct *ftrace_check_wq __initdata;
>> -static struct work_struct ftrace_check_work __initdata;
>> +static struct workqueue_struct *ftrace_check_wq;
>> +static struct work_struct ftrace_check_work;
>>  
>>  /*
>>   * Scan all the mcount/fentry entries to make sure they are valid.
>>   */
>> -static __init void ftrace_check_work_func(struct work_struct *work)
>> +static void ftrace_check_work_func(struct work_struct *work)
>>  {
>>  	struct ftrace_page *pg;
>>  	struct dyn_ftrace *rec;
>> 

Just in case I tried this patch too;
no banana, it panics (vblank->worker == NULL check fires)

-- 
kabe

