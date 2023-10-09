Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23ECA7BEE3F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 00:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378921AbjJIWYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 18:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378900AbjJIWYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 18:24:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A614E9E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 15:24:09 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696890248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=79g0TJ+WHkogXr+tQyKPTHPS+QTW+I7kx+LuYFFHnW4=;
        b=rUh1ZfaVz10rjGYuCYvvHYYLgdOyU2hCP2ht6FQ20Fchup4zR3CdHiqV5Si+YlDZRtCjui
        gcB+whoMqu1/jwPYtNWfFx4YeuL/J6t/yGJHxTtK87jNuPn8Au4dG8VjqkOQ/rf17TmpC8
        XJjFDpqgWvKNANuW8r9yDkqq/bW6Chssh6d046oWCTZHyTyDt916UjTDpZpS5IBSeTFpif
        o2ekKvsVQzI6eLgDsxq6xq406i+4UVpuxXNof/XpIY50gQiqb32q8vEInIXeOFgDqVY4Hy
        aCf+cfoxj2qbMehYNePA7A9f2wJSAv+/jdq8VbKORsrEjVZ4U6Xf/uHFSu8rFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696890248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=79g0TJ+WHkogXr+tQyKPTHPS+QTW+I7kx+LuYFFHnW4=;
        b=S6LqOzplVH9A+RxCfYTgWz/pD/zswwWJX2VJ/bnZLN9F3l+lxC/+HnBLlDwtxpLISiB/Le
        drtl0dKIK8MV6VBg==
To:     Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v8 09/25] timer: Split out get next timer functionality
In-Reply-To: <ZSRtb9Kh-m0laSwL@localhost.localdomain>
References: <20231004123454.15691-1-anna-maria@linutronix.de>
 <20231004123454.15691-10-anna-maria@linutronix.de>
 <ZSRtb9Kh-m0laSwL@localhost.localdomain>
Date:   Tue, 10 Oct 2023 00:24:07 +0200
Message-ID: <87zg0ro2ns.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09 2023 at 23:15, Frederic Weisbecker wrote:
> Le Wed, Oct 04, 2023 at 02:34:38PM +0200, Anna-Maria Behnsen a =C3=A9crit=
 :
>>=20=20
>> +	expires =3D basem + (u64)(nextevt - basej) * TICK_NSEC;
>
> Does that compute KTIME_MAX when there is no timers pending?

Probably not :)
