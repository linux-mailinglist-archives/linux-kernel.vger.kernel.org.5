Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C9C7862B2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 23:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238482AbjHWVmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 17:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238600AbjHWVl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 17:41:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A697510F1;
        Wed, 23 Aug 2023 14:41:52 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692826911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PK5b0ivuEa/PS4x9NzJ6KdYooqZ+f0W8WnndXaZS2Pg=;
        b=0sG4P5mw38zKQGTymLeRst1lf6lhNxBsE3iDIVkNr+37BtKsIfFQFM+CopGywwCD3xUQJ4
        1PIv/plA79QOLO8n7mazzHjACREs6aQKFhnyjh8sLXl34RS00aBq0MlCF8re3fC9lDhTOp
        mC3XrB8xF7EThDVKic9Z/NaH235RYOHTAuV+RqHIz3ilmlsTXFsJuxR0t941n1L8arv+fA
        aPj2C0W189rQWyWYS1KL3wl4Fp8aWwbe1bt0y7543vJsJG819KxLac0gFDBBjcBi2YVqRU
        PsHsfSiA2pEj6YzKy8kikGbs4JrRKg1IMufIBLjx3n/n93XB67w9MKPW2Jikow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692826911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PK5b0ivuEa/PS4x9NzJ6KdYooqZ+f0W8WnndXaZS2Pg=;
        b=d1l8+UuwBMa5UJJnhQuKOSVTgAefBI82ymLBTZhWjY1QwSv1QJfAy/qBxbL/niYnxwN6Iw
        dw6MFIaRJIqGUMBA==
To:     Alan Huang <mmpgouride@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     Z qiang <qiang.zhang1211@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Binbin Zhou <zhoubinbin@loongson.cn>
Subject: Re: [PATCH V4 2/2] rcu: Update jiffies in rcu_cpu_stall_reset()
In-Reply-To: <D3AFC0E7-9E6C-43F2-B9F5-3AC498B14F0F@gmail.com>
References: <20230814020045.51950-1-chenhuacai@loongson.cn>
 <20230814020045.51950-2-chenhuacai@loongson.cn>
 <18b9119c-cbc8-42a1-a313-9154d73c9841@paulmck-laptop>
 <CAAhV-H7t46hD1k18-sLYQA8h=M+ROdyMnT7gRtEGoRwKKBUZUA@mail.gmail.com>
 <CALm+0cWkQ8j_jiOSOuSsR9LbKPUL5cxRrONVxeNgSM5f1nDxMQ@mail.gmail.com>
 <CAAhV-H6S3Scu-Mf7E3aaqySytY4xDgjXrWc=fXSbr4i7R+-GDA@mail.gmail.com>
 <CALm+0cUpqONZOEHbc85d-Z5cC=P5LSeOAGuCCOukpTagLxnXWw@mail.gmail.com>
 <CAAhV-H7J6Rj99M6rxoFCEKu4G6NQPX9-N0a3-2GjEwbr+tbwQw@mail.gmail.com>
 <CALm+0cVdaXn5+4veu2NDwdi7htm=KY4ca+Eh54TwnN_6Xjs8TA@mail.gmail.com>
 <CAAhV-H6ejw=8afS0jmmQvKUrCw=qZm_P6SA0A+tuvvb8bsq4-Q@mail.gmail.com>
 <D3AFC0E7-9E6C-43F2-B9F5-3AC498B14F0F@gmail.com>
Date:   Wed, 23 Aug 2023 23:41:50 +0200
Message-ID: <87wmxlcu75.ffs@tglx>
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

On Wed, Aug 16 2023 at 23:56, Alan Huang wrote:
>> If  do_update_jiffies_64() cannot be used in NMI context, can we
>
> What about updating jiffies in dbg_touch_watchdogs or adding a wrapper which updates
> both jiffies and jiffies_stall?

What makes dbg_touch_watchdogs() any different?

KGDB can pretty much have a breakpoint everywhere and therefore also
within the jiffies lock held region.

Thanks,

        tglx
