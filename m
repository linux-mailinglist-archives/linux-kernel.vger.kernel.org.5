Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94047D2EF6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjJWJyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbjJWJyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:54:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A03E8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:54:06 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698054844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5TEX1NBJZk6RU6eh7yI/QX4WuIU+RE9lCnRfwDOqNss=;
        b=VNlf5pocsQ++v3IobxwfV+H66+nuShGuhOyU+iM1OtSjL72LR3hJhXl5jLyWArxFrOA/mr
        y+LuxVfZB08gMAJQ/1Df7/eeOQdJA5P0YZbnyvSX/GW+OiIML4PHtYf4L0xBrM/y4uE7HV
        1hZkeakWXdItFmdpuXQczl6cVqEHuhdrsMYhwKMpK/xu/4BDm1InskDg6x+3yWIef8Lat/
        l6m8Zz1gZTPwCvxe4tvVuudLmeCJPKVbrTLcat2N8Ihh/sTy8u1dV5Y28vr43k4+YlJhHa
        TL8pL0w7OgX98zNLEWx2ObZ7FWKGNDg3tug9iDJKO9vliYbVNVTvYuJUDMSePA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698054844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5TEX1NBJZk6RU6eh7yI/QX4WuIU+RE9lCnRfwDOqNss=;
        b=LX5l2lrehEuOuK04T+VNrQHu225DSxcg3CaEjcPMAEgBz1M2xig5WBsom6aw+mkPmFkBAE
        7VkjjTAUFaX928Bw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 3/4] printk: Skip unfinalized records in panic
In-Reply-To: <ZS_puLYK4TZR12Cx@alley>
References: <20231013204340.1112036-1-john.ogness@linutronix.de>
 <20231013204340.1112036-4-john.ogness@linutronix.de>
 <ZS5vrte2OZXcIc9L@alley> <87mswh6iwq.fsf@jogness.linutronix.de>
 <ZS_Vg4vvT29LxWSD@alley> <ZS_puLYK4TZR12Cx@alley>
Date:   Mon, 23 Oct 2023 11:59:58 +0206
Message-ID: <87v8ax1x6x.fsf@jogness.linutronix.de>
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

On 2023-10-18, Petr Mladek <pmladek@suse.com> wrote:
> I think about "empty line record" and "records with missing data".
> And I would rename NO_LPOS to EMPTY_LINE_LPOS to make the meaning
> more obvious.

OK.

> Also it would make sense to use 0x2 for EMPTY_LINE_LPOS and
>
> #define FAILED_LPOS		0x1
> #define EMPTY_LINE_LPOS		0x2
> #define DATALESS_LPOS_MASK	(FAILED_LPOS | EMPTY_LINE_LPOS)
>
> #define LPOS_DATALESS(lpos)	((lpos) & DATALESS_LPOS_MASK)

The existing debugging tools use bit0 to identify if there is data. Bit1
is really the _reason_ for the missing data. This can be seen in the
definition of LPOS_DATALESS(), but it needs to be documented
better. (Ideally where FAILED_LPOS and EMPTY_LINE_LPOS are defined.)

John
