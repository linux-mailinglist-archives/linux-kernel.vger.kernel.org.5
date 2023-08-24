Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F807786C2A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238480AbjHXJjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240850AbjHXJj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:39:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973AE10F9;
        Thu, 24 Aug 2023 02:39:19 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692869958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DvZfmm7zgSnDofgwBuPopLomuztY6pWf7tnJiRvMuNg=;
        b=hqkhO1uDufRG29MhSHWx7hYZ1RKyxc6JAxR/q7qXqEseZ7scy6y1COWYr/Rx1Iws88d73V
        Lw++X5SBKRO/0g6klh78kpoc3HPZhNN5MoFZoDlC5Cy/0pLHh54o5iDHvt1EmxZBHRSYcd
        lZp9U22dLDzUxiHdZSJPvlTA3ej8EwklW/vK1twrk6gTS8yCeQDbJSFO4BND6CjxNaXJf1
        uiNMBd28TGYv/JrZQQZYnnKePP0S3XYFC6rOPJcrHiLLd0ebEzZAbqR5wBGMUB3jLfSNCn
        l/Jn+//Ouuj6CvOE999RzKJT8e/IF8mQDRqGdMul+fKPnktl/Z6fm4vBvl50Xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692869958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DvZfmm7zgSnDofgwBuPopLomuztY6pWf7tnJiRvMuNg=;
        b=rt2aVqOB0gufNxOlvRu4UVYC5NmgzM/auhxiR05esYVcjgp/WTOdsOT+S8UjQydUxU6U2E
        m5aD7rNm5Wysd6Bw==
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Z qiang <qiang.zhang1211@gmail.com>, paulmck@kernel.org,
        Huacai Chen <chenhuacai@loongson.cn>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
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
In-Reply-To: <CAAhV-H7o+SK__ySWQRkbB4B-LTBFS-ryosqH_r53ZrZ+W1ZE-A@mail.gmail.com>
References: <CAAhV-H6ejw=8afS0jmmQvKUrCw=qZm_P6SA0A+tuvvb8bsq4-Q@mail.gmail.com>
 <5777BD82-2C8D-4BAB-BDD3-C2C003DC57FB@joelfernandes.org>
 <CAAhV-H58OpQJapV7LDNjZ-vM7nNJrwdkBiPjFcCutO1yRsUshQ@mail.gmail.com>
 <87ttspct76.ffs@tglx>
 <CAAhV-H7o+SK__ySWQRkbB4B-LTBFS-ryosqH_r53ZrZ+W1ZE-A@mail.gmail.com>
Date:   Thu, 24 Aug 2023 11:39:18 +0200
Message-ID: <87il94dbjt.ffs@tglx>
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

On Thu, Aug 24 2023 at 10:47, Huacai Chen wrote:
> On Thu, Aug 24, 2023 at 6:03=E2=80=AFAM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> +unsigned long tick_estimate_stale_jiffies(void)
>> +{
>> +       ktime_t delta =3D ktime_get_mono_fast_ns() - READ_ONCE(last_jiff=
ies_update);
>> +
>> +       return delta < 0 ? 0 : div_s64(delta, TICK_NSEC);
>> +}
>> +
>>  /*
>>   * Must be called with interrupts disabled !
>>   */
> Thank you for your advice, now the latest proposal is here [1], this
> is very similar to your diff, please take a look.

Similar by some definition of similar.
