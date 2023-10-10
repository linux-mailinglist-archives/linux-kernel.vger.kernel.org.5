Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57ABB7BF9E4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjJJLiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjJJLio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:38:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDA0AC
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 04:38:42 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696937920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E3m24tA8X03D0oVS4i4mcEKwKE/QJadsr01j2gMVf4c=;
        b=eEexWBsu+WIixsCVvqKSt3kYLj3eNSVloDh9Aif//tXF6UgirpjSbwqhal7COq6mzsbAhn
        Qg4YBxWFfxW9mmuTI4tgPcsSQrazbetNP666RtHIx9SKidXLcGWKydOStW9qbXCS6snLkJ
        ++6NzdXozpbhksGuOmUAKT7Yib1f7WRQGU+FBf20cn5M1HJCCLeS94RiaUzQGtP7iwNrMV
        16NSE3pgp8+Aj3HgrpAG6S/pODtq2dhEuDxQTqNkeRYV8+m45zixWdXS8erhK0jEGfFd9i
        c0L3QLeBy3NBWDm1O/W0ICQeymSVf8Clt600OgMTryRqVE6oXtiigJTyK4LAig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696937920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E3m24tA8X03D0oVS4i4mcEKwKE/QJadsr01j2gMVf4c=;
        b=DVAN+GiKZn2uJyaeNmwWYEfHTWKr0/L5PaFvn03hG7cB6FD/5A4+K8dfiPzCiYwLV4Fw4w
        Q+eHfx+RtAECG/AA==
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Todd Brandt <todd.e.brandt@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] printk: Reduce unnecessary wait times by pr_flush()
In-Reply-To: <ZSUPBiTXY486H1FV@alley>
References: <20231006082151.6969-1-pmladek@suse.com> <ZSUPBiTXY486H1FV@alley>
Date:   Tue, 10 Oct 2023 13:44:38 +0206
Message-ID: <87cyxmso5d.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-10, Petr Mladek <pmladek@suse.com> wrote:
>> This is an updated version of the patch
>> https://lore.kernel.org/r/20230929113233.863824-1-john.ogness@linutronix.de
>> 
>> Changes since v1:
>> 
>>   + Split reduction of the pooling time into separate patch.
>>   + Use jiffies to count the real sleeping time.
>> 
>> Note that my original POC counted jiffies spent in the entire cycle.
>> It would count also the time spent by console_lock() and by flushing
>> the legacy consoles in console_unlock().
>> 
>> The current version counts only the time spent by msleep(1) aka
>> the pooling interval.
>> 
>> 
>> John Ogness (1):
>>   printk: flush consoles before checking progress
>> 
>> Petr Mladek (1):
>>   printk: Reduce pr_flush() pooling time
>
> JFYI, the patchset has been committed into printk/linux.git,
> branch rework/misc-cleanups.
>
> I am going to push it in the next merge window for 6.7.
> IMHO, the issue is not critical and we are already at 6.6-rc5.

It is a real regression. I think it is important that it goes into
6.6. At least the first patch is simple enough and fixes the regression.

John
