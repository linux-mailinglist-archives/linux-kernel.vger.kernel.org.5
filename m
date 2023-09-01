Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D4D78FB83
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240925AbjIAJ4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjIAJ4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:56:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74371E8;
        Fri,  1 Sep 2023 02:56:42 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693562200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YMH/L366w3EUFTFROQVC1b+RZIO8d4sE9aBa+kTdubg=;
        b=l4QjJqf8C2duh9CCrH6p1UEA1uDTQ3rWpR4M0hWfDgLtZujt75pd8TEKmk2jdsXKfXWf91
        xj/oAWtUBqc+wssnoI2RirLYinOpIUfDNXLJ3Ln08zsFiUr7Y2u57jSZ1Tpab2EY2Q4UGO
        DNFq4JErv4Ytg4QnCJwPEpfyN5g+ZhfmpdCh+Ni52viwrR9W8dCoRNUshibT3FENAc/Ilp
        4VfYHwAJYhGfZoMwRSmCpsqmKuX/SC5D8vlcO4aGyMT8itjl88JSzD517XDFWRPIzCDWGx
        yQ3ulGTEZZu9GNWLsw1nBicq8lZBlIBVwJMFHv8mnwTxhGjEA7IsvsdINMjXOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693562200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YMH/L366w3EUFTFROQVC1b+RZIO8d4sE9aBa+kTdubg=;
        b=ezIF1IxZ7GZmbwpNO+Uv7Co/L/pOGgJdB1zHZWGt5G8sxG40xuQg1evnhuTOLsJGgOcppe
        037++pEMh0vfMXAA==
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Wen Yang <wenyang.linux@foxmail.com>,
        paul.gortmaker@windriver.com, LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] tick/rcu: fix false positive "softirq work is pending"
 messages on RT
In-Reply-To: <20230831133214.XF2yjiEb@linutronix.de>
References: <20230818200757.1808398-1-paul.gortmaker@windriver.com>
 <tencent_C80D3EE7563151B306E94C2AA7BF3023F80A@qq.com>
 <ff5263ec-96a8-4e8e-96af-de6ab8a17750@paulmck-laptop>
 <ZOy3S8ajaV8YWtE-@2a01cb09806c67d6fe4a366cc09da8f8.ipv6.abo.wanadoo.fr>
 <20230831133214.XF2yjiEb@linutronix.de>
Date:   Fri, 01 Sep 2023 11:56:39 +0200
Message-ID: <87il8u43oo.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31 2023 at 15:32, Sebastian Andrzej Siewior wrote:

> On 2023-08-28 17:03:39 [+0200], Frederic Weisbecker wrote:
>> > Frederic would normally take this, but he appears to be out.  So I am
>> > (probably only temporarily) queueing this in -rcu for more testing
>> > coverage.
>>=20
>> I'm back, I should relay this to Thomas to avoid conflicts with
>> timers changes.
>
> I somehow missed this thread and I do see this if I enable NO_HZ. I lost
> it=E2=80=A6
> Anyway, I'm going to pick it up for RT and ping the timer department
> after the merge window.

It's queued in timers/urgent and will hit Linus tree before rc1
