Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832257DA12F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 21:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjJ0TOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 15:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjJ0TOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 15:14:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926E312A;
        Fri, 27 Oct 2023 12:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=s5bWgVKpwmS1KllHLKJH6MgftoWkWiVLZ4YJm3tjFD4=; b=Lm/WGIyRJjJfRsdY53T4rtZXPq
        WgEnLip1WsWSzW7hPSzoqL3CkCULHfUqtiixPcHU4/Sxv9t6be3iGrvGzZew4mdXYdxefVxVgfguG
        1Wc4tIvraqp9VyCAIXs6nZAihLnhEB4BS9+nZgnlNTHc8WRZSWBsPM3vGdiW+KDbyEOJF67JqVEED
        NClrnbYbx/v6G6CiuRkqAqqgHY2C7GJrPGWmPprcbX4CSTgFj2Xkc9tmaQT0DooiOlfp8xPfSC/hs
        nVBRqo+VDeyPMdkfUHOZ0Gg7l3L1PU7qIhMr404RXKYYXSOFWmEhDYADds/a+zdkJq1RZQQsM/Gy9
        qceYikrQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qwSHz-0056Vr-SO; Fri, 27 Oct 2023 19:14:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 84DA4300392; Fri, 27 Oct 2023 21:14:35 +0200 (CEST)
Date:   Fri, 27 Oct 2023 21:14:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     linux-acpi <linux-acpi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Juergen Gross <jgross@suse.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH] acpi_idle: use raw_safe_halt() from acpi_idle_play_dead()
Message-ID: <20231027191435.GF26550@noisy.programming.kicks-ass.net>
References: <a079bba5a0e47d6534b307553fc3772d26ce911b.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a079bba5a0e47d6534b307553fc3772d26ce911b.camel@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 07:36:51PM +0100, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
>=20
> Xen HVM guests were observed taking triple-faults when attempting to
> online a previously offlined vCPU.
>=20
> Investigation showed that the fault was coming from a failing call
> to lockdep_assert_irqs_disabled(), in load_current_idt() which was
> too early in the CPU bringup to actually catch the exception and
> report the failure cleanly.
>=20
> This was a false positive, caused by acpi_idle_play_dead() setting
> the per-cpu hardirqs_enabled flag by calling safe_halt(). Switch it
> to use raw_safe_halt() instead, which doesn't do so.
>=20
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
> We might {also,instead} explicitly set the hardirqs_enabled flag to
> zero when bringing up an AP?

So I fixed up the idle paths the other day (see all that __cpuidle
stuff) but I've not yet gone through the whole hotplug thing :/

This seems right, at this point everything, including RCU is very much
gone, any instrumentation is undesired.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

>=20
>  drivers/acpi/processor_idle.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 3a34a8c425fe..55437f5e0c3a 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -592,7 +592,7 @@ static int acpi_idle_play_dead(struct cpuidle_device =
*dev, int index)
>  	while (1) {
> =20
>  		if (cx->entry_method =3D=3D ACPI_CSTATE_HALT)
> -			safe_halt();
> +			raw_safe_halt();
>  		else if (cx->entry_method =3D=3D ACPI_CSTATE_SYSTEMIO) {
>  			io_idle(cx->address);
>  		} else
> --=20
> 2.41.0
>=20
>=20


