Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809E9775903
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 12:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjHIK4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 06:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjHIK42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 06:56:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E4B1FF6;
        Wed,  9 Aug 2023 03:56:27 -0700 (PDT)
Date:   Wed, 9 Aug 2023 12:56:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691578585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7otBgQNwEPlGGa7A34K/b+UVvvmPFarUTBRcW4oPvA4=;
        b=QLYmo36x2dYs13WAINYDsixXwTkt4dYB9Z6i4Gw61GUY4iIZUapC5EDNxvM71T3xPjGLkq
        tG1W2JIzxJqoWl0WrPdopEQ8lSALan7+VyLBc4Fu8Oj6ChOt8SsZ04Z5s/0OzrK0TnSf9I
        vn3sEZ3rmSZ3IqDB5XgiD/F7xh0qDl/FpXufLyAten1m8GO6v0/xTUG5PfudBWT44/G2aV
        i72oAjjcw7OwUXzxXPCrSoAIziCThCd/YyejD9/vk7oezxqRyOJgTrIc+1r2wBYRa44bld
        hvIcw7IiCnjRS0+xRE9U8mhskhvYsgPhKsIJ8TzoKlr1HtJf30VY08Uv/1l2ZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691578585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7otBgQNwEPlGGa7A34K/b+UVvvmPFarUTBRcW4oPvA4=;
        b=CO/odTV2XRsNcMLrQW/O+7oYfRENV3nfWwFs96dBAyAm3shjrK083wze+INr5yXtWTZsLn
        HSdiYzIjnHVPDNDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, juri.lelli@redhat.com
Subject: Re: Splat in kernel RT while processing incoming network packets
Message-ID: <20230809105623.DSEPQ9LC@linutronix.de>
References: <bkw2aao62e3ppg7332dbhycgzdwr7k5brezj3bcij6zewphmnd@eigmbvjh6wuu>
 <20230703142908.RcxjjF_E@linutronix.de>
 <x6d2ae4ss4wvvuib2hmop6ztysjsbyno7gbjkyek5xng2kmgyd@yfmnfognlj5n>
 <20230704100527.75hMNZ35@linutronix.de>
 <a4ed5a8cc35f34a3cb11aded76b0f289c658c1a7.camel@redhat.com>
 <20230704144749.wJUlub6-@linutronix.de>
 <6cmltsaeqjcekglutpnp4lxyqnjng5m4w73ae4btwrivuxvptf@zmhahab7643i>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6cmltsaeqjcekglutpnp4lxyqnjng5m4w73ae4btwrivuxvptf@zmhahab7643i>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-05 12:59:28 [-0300], Wander Lairson Costa wrote:
> Maybe, under RT, some softirq should run in the context of the "target"
> process. For NET_RX, for example, the softirq's would run in the context
> of the packet recipient process. Each task_struct would have a list of
> pending softirq, which would be checked in a few points, like on scheduli=
ng,
> when the process enters in the kernel, softirq raise, etc. The default
> target process would be ksoftirqd. Does this idea make sense?

We had something similar. The softirq runs in the context of the task
that raised it. So the networking driver raised NET_RX and it was
processed in its context (and still is). The only difference now is that
we no longer have a task based "raised bit" but a per-CPU.

For RPS you already pulled the skb from the NIC, you need to process it
and this isn't handled in the task's context but on a specific CPU.

Let me look at per-CPU backlog thread or ripping the warning out=E2=80=A6

Sebastian
