Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBB677D627
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 00:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240428AbjHOWca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 18:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240483AbjHOWcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 18:32:18 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32B81FF3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 15:32:01 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51d95aed33aso7928900a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 15:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1692138720; x=1692743520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6R1K7ydUNFwtjoi/u3FY7+KS9fiu0n5Lc1EtyEIeePE=;
        b=eB2hYLGDWreCCGz4u7/lLVM/3mhrrmlpJmf6qykpGgYnFwjWbaWXqmpDzPRIWrbTV7
         chAc0pfd09KQ7RQAMFhAP41RI2jD7JJDedvL0yl2tPrkUs6AmYdlZ6oKnnN7mEyeyztp
         IvP7TwBmkEMW7DgDQR4gERPEcxcrzeZ1NYUb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692138720; x=1692743520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6R1K7ydUNFwtjoi/u3FY7+KS9fiu0n5Lc1EtyEIeePE=;
        b=iTRz+90czX6HU0H/kdCIwJUsPwqa8KLufILpQAoSrrIomx4E7vwYpDgqB3fLf2/KDf
         97fhdpRygBKttR557YHdDfeJX3BDYj4n9d+ykebJiz4+TtSN5p++AH6HIT6OXs6ERxAS
         CSOkysFrzr3K6WhJC+DmIBqnGwo+2iJ0dKzo/VWVkn3aMPNpQ9vfPbBvQngbqoWnSlEU
         +ZZCQMIGLph2C3qrha02R52iEsxFFxk8uF5NHCCw6/QVAy8s+nS3f66XQ3I86Sa0LUV8
         93TAIQDHCp7N9itGnsxrpkX6XQ/KfJ8GDmu0Zz05SuSEaMrjmtxIBBw3TuHSCAmPD3En
         V9fQ==
X-Gm-Message-State: AOJu0YwYtWM5BhWVsE1kNUxya2SJbawJxXpWJY2XePzofKJOPWsjNbJE
        UEqEXheoNa7E6peFN2RQjybtw2B9rUvTuGilelmD1Q==
X-Google-Smtp-Source: AGHT+IHLnvvHpVGa2ywLMBcWm2YOrhVOII3BV6OZjuJ+ojTRMx3vBIotf2jz9W0SnMJBKanY97CG/LjI41ukHSMs1Cs=
X-Received: by 2002:aa7:d1ce:0:b0:523:d1e0:7079 with SMTP id
 g14-20020aa7d1ce000000b00523d1e07079mr140764edp.21.1692138720456; Tue, 15 Aug
 2023 15:32:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230814093528.117342-1-bigeasy@linutronix.de>
 <20230814093528.117342-3-bigeasy@linutronix.de> <25de7655-6084-e6b9-1af6-c47b3d3b7dc1@kernel.org>
In-Reply-To: <25de7655-6084-e6b9-1af6-c47b3d3b7dc1@kernel.org>
From:   Yan Zhai <yan@cloudflare.com>
Date:   Tue, 15 Aug 2023 17:31:49 -0500
Message-ID: <CAO3-PbpX_Hzxy5aj-mppnipm2HE63oB-p51DAV7v9HvSNS9y6Q@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] softirq: Drop the warning from do_softirq_post_smp_call_flush().
To:     Jesper Dangaard Brouer <hawk@kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wander Lairson Costa <wander@redhat.com>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 7:08=E2=80=AFAM Jesper Dangaard Brouer <hawk@kernel=
.org> wrote:
>
>
>
> On 14/08/2023 11.35, Sebastian Andrzej Siewior wrote:
> > This is an undesired situation and it has been attempted to avoid the
> > situation in which ksoftirqd becomes scheduled. This changed since
> > commit d15121be74856 ("Revert "softirq: Let ksoftirqd do its job"")
> > and now a threaded interrupt handler will handle soft interrupts at its
> > end even if ksoftirqd is pending. That means that they will be processe=
d
> > in the context in which they were raised.
>
> $ git describe --contains d15121be74856
> v6.5-rc1~232^2~4
>
> That revert basically removes the "overload" protection that was added
> to cope with DDoS situations in Aug 2016 (Cc. Cloudflare).  As described
> in https://git.kernel.org/torvalds/c/4cd13c21b207 ("softirq: Let
> ksoftirqd do its job") in UDP overload situations when UDP socket
> receiver runs on same CPU as ksoftirqd it "falls-off-an-edge" and almost
> doesn't process packets (because softirq steals CPU/sched time from UDP
> pid).  Warning Cloudflare (Cc) as this might affect their production
> use-cases, and I recommend getting involved to evaluate the effect of
> these changes.
>
> I do realize/acknowledge that the reverted patch caused other latency
> issues, given it was a "big-hammer" approach affecting other softirq
> processing (as can be seen by e.g. the watchdog fixes patches).
> Thus, the revert makes sense, but how to regain the "overload"
> protection such that RX networking cannot starve processes reading from
> the socket? (is this what Sebastian's patchset does?)
>
Thanks for notifying us. We will need to evaluate if this is going to
change the picture under serious floods.

Yan

> --Jesper
>
> Thread link for people Cc'ed:
> https://lore.kernel.org/all/20230814093528.117342-1-bigeasy@linutronix.de=
/#r
