Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E9D7CFB89
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345672AbjJSNrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbjJSNrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:47:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B872124
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 06:47:28 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697723247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UlWilW+N2s/Qe+0A+LtqI/TQl6f/DnywsDkIWD40T2c=;
        b=XnMrmE+m6l/LvGaoelOq7POTuAK+rnJAm+e3uEczi29ICMRPyibp5Yw5VLr2hA3NJCS+91
        0ZSBu1J8m++atNA2yppaOF10uoVQeMVarO7+6km+aOJ+/8QELbdT49blZ8TKRqewBfHdQG
        fqpk2YRFxB6SeDvC4cS+jK7i2SKfWH+dvD7GM3WKKuTBBQTfwLDsWGesrv0pdWgr37jffn
        yOLeI0VtkMwdNstFrg4RMKeQFTv+zoVWqrIFE0j6lf0XrBu9h0vYk1hqEhrUh+chW/BFgh
        SrZWiBZPylw2CfHBY6xUOIpwNKouOGt/zk9BtajqRLXSm5n9tWSYMi4Xclpixw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697723247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UlWilW+N2s/Qe+0A+LtqI/TQl6f/DnywsDkIWD40T2c=;
        b=jXNauR8vhzgmoVgPT3xlyq/TfUpmwUQZI8cBfGxWsoPJDnui96tMPEYpmZ8FEqjxlWPJg8
        S5pNaK9G2nL1iMBA==
To:     "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "jstultz@google.com" <jstultz@google.com>,
        "riel@surriel.com" <riel@surriel.com>,
        "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
        "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "arjan@infradead.org" <arjan@infradead.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "ggherdovich@suse.cz" <ggherdovich@suse.cz>,
        "gautham.shenoy@amd.com" <gautham.shenoy@amd.com>
Subject: Re: [PATCH v8 00/25] timer: Move from a push remote at enqueue to a
 pull at expiry model
In-Reply-To: <151240c939d02df4979651b84bb99356a938c44d.camel@intel.com>
References: <20231004123454.15691-1-anna-maria@linutronix.de>
 <151240c939d02df4979651b84bb99356a938c44d.camel@intel.com>
Date:   Thu, 19 Oct 2023 15:47:26 +0200
Message-ID: <87pm1a911t.fsf@somnus>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Pandruvada, Srinivas" <srinivas.pandruvada@intel.com> writes:

> Hi Maria,
>
> On Wed, 2023-10-04 at 14:34 +0200, Anna-Maria Behnsen wrote:
>> Hi,
>> 
>> 
>
> [...]
>
>> 
>> The proper solution to this problem is to always queue the timers on
>> the
>> local CPU and allow the non pinned timers to be pulled onto a busy
>> CPU at
>> expiry time.
>
> Thanks for these patches. I am looking for saving power during video
> playback with our low power daemon. I use cgroup v2 isolation to keep
> some CPUs idle (CPU 0-11) and video is played on a single module (CPU
> 12-15).
>
> I have some kernelshark pictures at below link. The traces are
> collected with sched, timer and irq. With 6.6-rc5, you can see some
> timers still expires on CPUs which I want to keep idle. With timer
> patches added, they are mostly pulled to busy CPU. 
>
> https://imgur.com/a/8nF5OoP
>
> I can share the .dat files, but they are too big to attach here.

Thanks a lot for testing! The images are totally fine (at least for
me). As there are still some issues in v8, I'll have to post a new
version...

Thanks,

	Anna-Maria

