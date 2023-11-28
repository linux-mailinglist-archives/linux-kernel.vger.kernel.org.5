Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B6A7FCAA6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 00:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376356AbjK1XRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 18:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK1XRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 18:17:42 -0500
Received: from w4.tutanota.de (w4.tutanota.de [81.3.6.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B0F197;
        Tue, 28 Nov 2023 15:17:48 -0800 (PST)
Received: from tutadb.w10.tutanota.de (unknown [192.168.1.10])
        by w4.tutanota.de (Postfix) with ESMTP id 3B8311060171;
        Tue, 28 Nov 2023 23:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1701213467;
        s=s1; d=well-founded.dev;
        h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
        bh=JqVKyMAMt9Bj6vMHPBXGDNf4LP6ToGp593DuEmyVmVg=;
        b=DuiXrfuiZatvQK8SRbBUX5h4qnitFshGTibmQ7My96Ji3pbzkj31MwcfRW5yozFF
        uDBBJIz0cWqEOVfxDIFPzxzzV0xDs4Nc2eqG0gLeyQrjYwO05NKHmzPnzV2QFHTM+rh
        cKQgd8g3wxhtyDo7abslOqpRazaosNLz75lyydlP65iGOfgWigxMNlJLBN9GAGsUUTv
        ZcRbRkCk6tL36cjxU9Y2BFeXmIHHr1zw/cWE5j7oqXHIVLb9ADUMYnnJ207eNPc3f4Z
        yg/hRXpEJ+zUdn+ySfiHtsqFGh6E7injjcbURlpkQl8vO19gyQ/QNcIQ+L7mMG9atBF
        Ff70xakhLw==
Date:   Wed, 29 Nov 2023 00:17:47 +0100 (CET)
From:   Ramses <ramses@well-founded.dev>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Power Management <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Yu Chen <yu.c.chen@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Message-ID: <NkNDM2v--B-9@well-founded.dev>
In-Reply-To: <c2a9ceb3d7b1f384ad94d10b7058bb1cebea3d07.camel@linux.intel.com>
References: <01df8329-06d7-4fd1-9c7a-05296f33231e@gmail.com> <b2b9121c6d2003b45f7fde6a97bb479a1ed634c7.camel@linux.intel.com> <NkN3JYx--3-9@well-founded.dev> <c2a9ceb3d7b1f384ad94d10b7058bb1cebea3d07.camel@linux.intel.com>
Subject: Re: Fwd: Intel hybrid CPU scheduler always prefers E cores
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nov 29, 2023, 00:10 by tim.c.chen@linux.intel.com:

> On Tue, 2023-11-28 at 23:33 +0100, Ramses wrote:
>
>> I applied the patch on top of 6.6.2, but unfortunately I see more or less the same behaviour as before, with single-threaded CPU-bound tasks running almost exclusively on E cores.
>>
>> Ramses
>>
>
> I suspect that you may have other issues. I wonder if CPU priorities are getting
> assigned properly on your system.
>
> Saw in the original bugzilla 
> https://bugzilla.kernel.org/show_bug.cgi?id=218195
> that you don't see /proc/sys/kernel/sched_itmt_enabled which
> may be a symptom of such a problem.
>
> +Srinivas, is there something Ramses can do to help
> find out if there are issues with cppc?
>
> Tim
>
Yeah I'm getting the impression that something is going wrong on my system. AFAIU, itmt is supposed to be auto-detected and doesn't require additional config?

I have the intel ME disabled on my CPU (it came like that from the OEM), I don't know if that can have an effect?

Let me know if there's any additional info that I can provide.

Ramses

