Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E887BA088
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236895AbjJEOhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235193AbjJEOfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:35:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8303698
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 06:59:35 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696514369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HefGVIbKSQ3vy0UfHqATp/KOc0Tq42iQ8ydZMVaCb8c=;
        b=2IOGzdwZ9qsltc3VzYE5j9y4RlFQIW+YWutgC088wz01n3Py2dlZKPMcULBCz3J8dnWdDm
        wmcHGtou++xiMX0rRUTH+LFd91FQB4XwfLVj8EJyXCytcjTu8G7PvpiFewq1Yy5gWF5FS3
        hDwGDcg4x/ceGWomUCNzbP7mMWS/dusbAJWSM/0cx9iqOYVNDPQQCPwdjhkwsEWt4LVWZp
        0IdB+KBN+ECync+My5OTb4iWCReS51X1RDfyM1uDfNQtSUqhOdeZR3OLAkv+mCqaYe+Vta
        Vf4t+yUMXd0M80tFMnDDHTYOw4pXsW0ToClQygy0ZnCnK9QFRiLe6PkZt0VceQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696514369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HefGVIbKSQ3vy0UfHqATp/KOc0Tq42iQ8ydZMVaCb8c=;
        b=1/71++pw1ukYqHa6TixEjX6KNLofwMzjRdS+fyU0Bi3JqPyvnDfRRZ0vOZFf/XTaa3gQPH
        J/R2VRFsS3JWZ5CA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 06/11] printk: nbcon: Wire up nbcon console
 atomic flushing
In-Reply-To: <ZRLLNh4g_BiwxIsA@alley>
References: <20230919230856.661435-1-john.ogness@linutronix.de>
 <20230919230856.661435-7-john.ogness@linutronix.de>
 <ZQ3R4Lz1LHQYsylw@alley> <87a5tabchs.fsf@jogness.linutronix.de>
 <ZRLLNh4g_BiwxIsA@alley>
Date:   Thu, 05 Oct 2023 16:05:27 +0206
Message-ID: <87edi9tbk0.fsf@jogness.linutronix.de>
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

On 2023-09-26, Petr Mladek <pmladek@suse.com> wrote:
> Anyway, the proposed behavior (agreed on LPC2022) seems
> to contradict the original plan from LPC 2019, see
> https://lore.kernel.org/all/87k1acz5rx.fsf@linutronix.de/
> Namely:
>
>   --- cut ---
>   3. Rather than defining emergency _messages_, we define an emergency
>   _state_ where the kernel wants to flush the messages immediately before
>   dying. Unlike oops_in_progress, this state will not be visible to
>   anything outside of the printk infrastructure.
>
>   4. When in emergency state, the kernel will use a new console callback
>   write_atomic() to flush the messages in whatever context the CPU is in
>   at that moment. Only consoles that implement the NMI-safe write_atomic()
>   will be able to flush in this state.
>   --- cut ---
>
> We wanted to flush it ASAP.

In 2019 we didn't have all the code yet. Yes, we assumed that flushing
each individual printk() call would be how to do it. But in 2022, during
a live demo with real code, we saw that it was a bad idea.

I disagree that the 2022 decisions are contradicting the 2019
decisions. We have added more details because now we have a real
implementation.

v2 establishes an emergency state before dying. v2 flushes the messages
safely before dying (and unsafely _immediately_ before dying). v2
flushes the messages in whatever context the CPU is in. v2 uses
write_atomic() to perform the flush.

John
