Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030107BB4EF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjJFKMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbjJFKMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:12:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AF9D6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 03:12:11 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696587129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y6rHmC1zD8wcB4iNbJmwHEYA/P6PHQnX7NfRYyR7AeY=;
        b=ZaaxxeZ2Munz8jdVnYuid5auIz6s5fmwD4fHxhuBVWnFFEOCJiqSBJvs+/lvAnCscyrYrf
        Z6jJvuo+YVhYhVGfmGHbjvGu3Ir16S1mx59RRKQL7n/z+27DUdaNlzed9lFHnCzB8PDCpE
        0SNlXlSmT2nnhuvfbotGYvfmSyk9l08yaXAIPnwY9+p3anZ4/NxGwYqpwbU+s2Au3ltTTt
        0ZFeHPNHYnPw8PrGgbnOQ50KuzmZ55hsu3/huokqT9pcB1hCa0IyIGhuuDDRffCDiOMFmS
        oyQ32JHr9xQ0ZC5HgnEYKxWZRx5L9LDbLC3prTklskQLM/NcZKbkv0DZSB1sZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696587129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y6rHmC1zD8wcB4iNbJmwHEYA/P6PHQnX7NfRYyR7AeY=;
        b=PcWok/67hQNKgxh91q8eqB4jtyCLE/yLotjRziK8gd1/2oDO+rBvv4tnpx6oTRuk0GLS7f
        KDu7dKr2I3ZWFCCA==
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Todd Brandt <todd.e.brandt@intel.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2 2/2] printk: Reduce pr_flush() pooling time
In-Reply-To: <20231006082151.6969-3-pmladek@suse.com>
References: <20231006082151.6969-1-pmladek@suse.com>
 <20231006082151.6969-3-pmladek@suse.com>
Date:   Fri, 06 Oct 2023 12:18:06 +0206
Message-ID: <87wmw0vz49.fsf@jogness.linutronix.de>
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

On 2023-10-06, Petr Mladek <pmladek@suse.com> wrote:
> pr_flush() does not guarantee that all messages would really get flushed
> to the console. The best it could do is to wait with a given timeout.[*]
>
> The current interval 100ms for checking the progress might seem too
> long in some situations. For example, such delays are not appreciated
> during suspend and resume especially when the consoles have been flushed
> "long" time before the check.
>
> One the other hand, the sleeping wait might be useful in other situations.

  "One" should be "On"

Otherwise the patch looks OK to me. Thanks!

Reviewed-by: John Ogness <john.ogness@linutronix.de>
