Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307077CD655
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbjJRIZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235147AbjJRIY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:24:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439D8FA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:24:58 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697617496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x0NqHzJi+SiI0xRnDWL93ULd5WSNeqBxu/jo5Msruzc=;
        b=iU5QYS4IVeJJbzZ2OFY5EBI+0ss/BOFk6oFBVN4br+Bbwo7VEBEJWwAIpIx+ohsQ8jUkGN
        GTGwrpV/WAki2SUhg6ad+EgLkemBF5qxoqIrAFhzkBkhGZbSS5JnBRb98AgMDDGOvMcEcP
        TV6gUFn0Hq6BHiY+gO434qPeSaI7aeVex0ChrcqSRysaAQ+hM9Rw6DtmSqr0IArprjPd4d
        WVeK+t10CPNMG0ms42qEQ4Fh5fTxE6+oSMNjSgWiRfRgmUN8jlqsgdXLeh1B/bq/aLkVys
        kmwM0WsATffq0WfrtBpeLTvJcR3I8lwN5jElszmVeMnpGFG3SlVK9v32ZiCq4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697617496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x0NqHzJi+SiI0xRnDWL93ULd5WSNeqBxu/jo5Msruzc=;
        b=3imP60sn+X6jYtEZRmSm4S6Ve/xT3a4JDvtXvpw9JgyQ9ns2m6uVvawSkFYjqKpkwh2a+1
        Dofz4feUhFTRe0BQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 3/4] printk: Skip unfinalized records in panic
In-Reply-To: <87mswh6iwq.fsf@jogness.linutronix.de>
References: <20231013204340.1112036-1-john.ogness@linutronix.de>
 <20231013204340.1112036-4-john.ogness@linutronix.de>
 <ZS5vrte2OZXcIc9L@alley> <87mswh6iwq.fsf@jogness.linutronix.de>
Date:   Wed, 18 Oct 2023 10:30:46 +0206
Message-ID: <877cnk72y9.fsf@jogness.linutronix.de>
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

On 2023-10-17, John Ogness <john.ogness@linutronix.de> wrote:
>>> -	if (!prb_read_valid(prb, seq, &r))
>>> -		return false;
>>> +	while (!prb_read_valid(prb, seq, &r)) {
>>> +		if (this_cpu_in_panic() && seq < prb_next_seq(prb)) {
>>> +			/*
>>> +			 * The record @seq is not finalized and there may be

I am wondering if we should put the this_cpu_in_panic() check into
_prb_read_valid() instead. This has the advantage that it could more
intelligently skip non-finalized records and not need to rely on
prb_next_seq(). Also, it would allow any other readers (kmsg_dump) to
skip non-finalized records during panic.

Looking over the code, it would be easy to extend
desc_read_finalized_seq() to return a separate error code for exists but
is non-finalized. This would make it trivial for _prb_read_valid() to
skip over it when this_cpu_in_panic().

John
