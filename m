Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824717D2DE7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbjJWJQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbjJWJQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:16:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B471728
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:15:51 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698052549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M8vXG2tJd9kcJDGoaWK7bPyKAi4fVKeW+17ZQYQF8y4=;
        b=uhFrS9Q7keqeRq8u+BCLY8PBuJUO7CkDMQddt2pL16SsHIddnhDgQmE8kDi7v1kD49w+mA
        rs+kskYPuxr60ggD63svyBkhs75xFh+OsYq6GjPEqfgTSyYFgXHJr93558axLy/vWVajhy
        ym/1oiYqLeHnoi/uUtCGC6y3wtplvCSDu4+6ixnoL0ZdGX+RTaEmPTHxMn72/kyQ/sFt9x
        G5xPG6hsstuA3gmr+jpJh0t9oRQJvsx0FA/M8u/75uRDq3nO/6S8/ylheIivIv6zViCEZB
        BZPGBncvj+UGFxW0VxagTNpKsgXJn7A8ANCFS/hc69TJx1NCnC3pT4A6Fanwpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698052549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M8vXG2tJd9kcJDGoaWK7bPyKAi4fVKeW+17ZQYQF8y4=;
        b=FLqXPcm4Ao1eur8K6DdHABBaPHstRuBH4Wb18I3xO14iULcg3Zhp9Ipln/C0ecjOO4tDui
        Y38nP1r2QK1B34Dw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 4/4] printk: Ignore waiter on panic
In-Reply-To: <ZS-r3QnpKzm7UVip@alley>
References: <20231013204340.1112036-1-john.ogness@linutronix.de>
 <20231013204340.1112036-5-john.ogness@linutronix.de>
 <ZS-r3QnpKzm7UVip@alley>
Date:   Mon, 23 Oct 2023 11:21:43 +0206
Message-ID: <87y1ft1yyo.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-18, Petr Mladek <pmladek@suse.com> wrote:
> Well, I have spent some time thinking about possible scenarios and I would
> go even further. I would block also console_lock_spinning_enable()
> Also I would do the checks before taking console_owner_lock.
>
> It would make the behavior symmetric. And more importantly, it would prevent
> possible deadlocks caused by console_owner_lock.
>
> See the proposed patch below. I created it to see the changes in the
> code. Also I added info about possible scenarios and effects.

Reviewed-by: John Ogness <john.ogness@linutronix.de>

I will use your patch for the next version of this series.

John
