Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E891C7A8283
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236360AbjITNAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236339AbjITNAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:00:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA40D93
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:00:19 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695214818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b+lwndKdQlP/9nZEQAFcW14cpo1FpcaI6fxfaleP4oA=;
        b=DDx3bnMdWWwpG85xcoDuibKSsbmtg8cu1d3hN5naZ//ntjz6h1Q4hBoY/m4UrhJHzW7oSd
        sLTWX5lIy+EBvtw487xsoKS8rvBXkP2V4r24h1FFs2++IsTmNBvyN29scZNac2nq7CdnQj
        du+8uB2QGlWcbbZ93+pv2/Ewm9WZn5re/qZsXiH4mQx+LbKCsLEsNziYKK1fO9uNog5Xja
        a9dq3VF1BaX+UWQymmu3RYubgR4caJuxXJ+Jy/OErpDCch8cTUkeqTaFld6PDFUMi5n3L0
        nOtVxg0t9wKzjI32hJLGWbzGGi853HQFxP7GEp+nxy1Eqeig/NR5Wp5mr8hx9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695214818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b+lwndKdQlP/9nZEQAFcW14cpo1FpcaI6fxfaleP4oA=;
        b=pSKL+CZ/M3RATCymopWoEDKt9qljPHgoljCszAEqb356czCG6wLngmoITLVGJXedJwcE4c
        vfvAlAHTj4Cf+ADw==
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH] printk/nbcon: Add assert that CPU migration is disabled
 when calling nbcon_context_try_acquire()
In-Reply-To: <20230920125136.15504-1-pmladek@suse.com>
References: <20230920125136.15504-1-pmladek@suse.com>
Date:   Wed, 20 Sep 2023 15:06:08 +0206
Message-ID: <874jjpt2xz.fsf@jogness.linutronix.de>
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

On 2023-09-20, Petr Mladek <pmladek@suse.com> wrote:
> The nbcon console is locked when the 'prio' and 'cpu' fields in
> console->nbcon_state stay the same. The locking algorithm would
> break when the locked context got migrated to another CPU.
>
> Add assert into nbcon_context_try_acquire(). It would warn when
> the function is called in a context where the CPU migration
> is possible.

static bool nbcon_context_try_acquire(struct nbcon_context *ctxt)
{
        unsigned int cpu = smp_processor_id();

Doesn't smp_processor_id() already provide the necessary checking and
warning?

John
