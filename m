Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B477CA4D0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjJPKJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjJPKJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:09:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1692AC
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 03:09:51 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697450990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lm/sCgLXyQJvjntNocjGInAVDmxpu8y10P7sSSOLEcw=;
        b=d0QLvGGBXR++0sfI7hBvbcjV/d5k1+J2F3u4glhEarSgkt9vMpcM0girfCj/uscrReqWUQ
        ieulS50IoYNvAOxpmp6Buns768cVVAfFn+Eytmfs5DuOTghok0KPkC0mfvn8llhVsd/XWj
        kQeSfZZkIV398R4FYmmnm2xz1G7e5RJC9JwFEBOQkbF/cgDSPiYsRegVkibN1UNlZww0J6
        qts9DZAaIvarXGutSrBW/NZBBcl14FaWuE8dslPDbZ1Q1i1LI1kvrcP/P0Hgv/KcVqEzB7
        USAYvXdq/nIs8PfzHRWWEbzOb07nrtrRO/Qd7dqIQgoUJlGLgtAL9lNuQ03KXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697450990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lm/sCgLXyQJvjntNocjGInAVDmxpu8y10P7sSSOLEcw=;
        b=GqfycxaU1UC4UL17ePNW65pxcyj+LcCCc2oVXIXsfgRoFs1E67VckHwCp+X+akV3Kr9ovc
        XQzi0bUxm8wP+EDA==
To:     Dave Young <dyoung@redhat.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kexec@lists.infradead.org, bhe@redhat.com, prudo@redhat.com,
        ebiederm@xmission.com, vgoyal@redhat.com
Subject: Re: panic context: was: Re: [PATCH printk v2 04/11] printk: nbcon:
 Provide functions to mark atomic write sections
In-Reply-To: <ZSz7RFqv994u/Vt+@darkstar.users.ipa.redhat.com>
References: <ZRGvn4m2NGCn3Pef@alley> <87h6n5teos.fsf@jogness.linutronix.de>
 <ZSADUKp8oJ2Ws2vC@alley> <87il7hv2v2.fsf@jogness.linutronix.de>
 <ZSz7RFqv994u/Vt+@darkstar.users.ipa.redhat.com>
Date:   Mon, 16 Oct 2023 12:15:42 +0206
Message-ID: <87il76ho9l.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 2023-10-16, Dave Young <dyoung@redhat.com> wrote:
>> > Does anyone really want explicit flushes in panic()?
>> 
>> So far you are the only one speaking against it. I expect as time
>> goes on it will get even more complex as it becomes tunable (also
>> something we talked about during the demo).
>
> Flush consoles in panic kexec case sounds not good, but I have no deep
> understanding about the atomic printk series, added kexec list and
> reviewers in cc.

Currently every printk() message tries to flush immediately.

This series introduced a new method of first allowing a set of printk()
messages to be stored to the ringbuffer and then flushing the full
set. That is what this discussion was about.

The issue with allowing a set of printk() messages to be stored is that
you need to explicitly mark in code where the actual flushing should
occur. Petr's argument is that we do not want to insert "flush points"
into the panic() function and instead we should do as we do now: flush
each printk() message immediately.

In the end (for my upcoming v3 series) I agreed with Petr. We will
continue to keep things as they are now: flush each printk() message
immediately.

Currently consoles try to flush unsafely before kexec. With the atomic
printk series our goal is to only perform _safe_ flushing until all
other panic operations are complete. Only at the very end of panic()
would unsafe flushing be attempted.

John
