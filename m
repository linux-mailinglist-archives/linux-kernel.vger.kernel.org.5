Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429047F13D7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 13:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbjKTM6D convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Nov 2023 07:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbjKTM6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 07:58:01 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854709C;
        Mon, 20 Nov 2023 04:57:58 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6d32ce135c4so536478a34.0;
        Mon, 20 Nov 2023 04:57:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700485078; x=1701089878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRmWYnun+H8N6YfHDxRkcl1OdXmrpY1OVWguGUrRMHw=;
        b=caqh4zh26kGCCi6+xbjkTn/LNvDALT2bki1d570bDb53aJGplWuXrS51M2YJNH4o+2
         atnT9ARSGDxCsllZ8wYXd/BOUBoYyq72O9xieAFgM77j6exkuqMTvFBeiI4Wr9K58JFk
         moYRj/RQPryEsEeih54Sw88e4BuWWhmUY326IJAshoeKeXs19xspaa60pZyemNpf5JQ/
         X3RefuPIrX1BvvkmYpwFboOJNqq05VCmkVo8fNJuFBKvE7zpUIL5ey3fiyxTk6o4pXWd
         +zNf/QRBTuYeJOjUvzXhmQgw0mVr1/W+ryPHLZJmPQLrFOK/rlJH8EeXj4L6gJ7iF/+c
         /qnQ==
X-Gm-Message-State: AOJu0YyG+6oMap4/TUW+gNWSzJn4DQr1H5mFTOewl7d/tw2aI1uvNMJF
        3/PhDIe3hCch+WBCWmzmseAk2KymKPFk+h7YVPVXyw5d
X-Google-Smtp-Source: AGHT+IH4DqzxN5gzKls1477E5UEmNarpobq+egq12hb2R4tSdspyOE8ms35n4o0BxLppvIHPFohx9qyv0KiJRw9tOUQ=
X-Received: by 2002:a4a:e783:0:b0:589:daaf:44a1 with SMTP id
 x3-20020a4ae783000000b00589daaf44a1mr6702974oov.0.1700485077850; Mon, 20 Nov
 2023 04:57:57 -0800 (PST)
MIME-Version: 1.0
References: <a079bba5a0e47d6534b307553fc3772d26ce911b.camel@infradead.org>
 <20231027191435.GF26550@noisy.programming.kicks-ass.net> <da465baf0ebcfa3c31e5be7e70319b0796ac59da.camel@infradead.org>
In-Reply-To: <da465baf0ebcfa3c31e5be7e70319b0796ac59da.camel@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 20 Nov 2023 13:57:46 +0100
Message-ID: <CAJZ5v0hfkoZM==qobzgzxAvTBDO6yP3w37K=EdHVGFr7WuJTaQ@mail.gmail.com>
Subject: Re: [PATCH] acpi_idle: use raw_safe_halt() from acpi_idle_play_dead()
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-acpi <linux-acpi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Juergen Gross <jgross@suse.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 1:20 PM David Woodhouse <dwmw2@infradead.org> wrote:
>
> On Fri, 2023-10-27 at 21:14 +0200, Peter Zijlstra wrote:
> > On Fri, Oct 27, 2023 at 07:36:51PM +0100, David Woodhouse wrote:
> > > From: David Woodhouse <dwmw@amazon.co.uk>
> > >
> > > Xen HVM guests were observed taking triple-faults when attempting to
> > > online a previously offlined vCPU.
> > >
> > > Investigation showed that the fault was coming from a failing call
> > > to lockdep_assert_irqs_disabled(), in load_current_idt() which was
> > > too early in the CPU bringup to actually catch the exception and
> > > report the failure cleanly.
> > >
> > > This was a false positive, caused by acpi_idle_play_dead() setting
> > > the per-cpu hardirqs_enabled flag by calling safe_halt(). Switch it
> > > to use raw_safe_halt() instead, which doesn't do so.
> > >
> > > Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> > > ---
> > > We might {also,instead} explicitly set the hardirqs_enabled flag to
> > > zero when bringing up an AP?
> >
> > So I fixed up the idle paths the other day (see all that __cpuidle
> > stuff) but I've not yet gone through the whole hotplug thing :/
> >
> > This seems right, at this point everything, including RCU is very much
> > gone, any instrumentation is undesired.
> >
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> Ping? Who's taking this?

I'm going to apply it.

> Needs a Cc:stable@vger.kernel.org now too, to fix 6.6.x.

Sure.
