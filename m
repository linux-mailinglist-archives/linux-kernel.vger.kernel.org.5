Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510A678FF8A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 16:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350084AbjIAO4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 10:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbjIAO4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 10:56:19 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D698C10EF;
        Fri,  1 Sep 2023 07:56:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3AEE4CE224C;
        Fri,  1 Sep 2023 14:56:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E3AC433C7;
        Fri,  1 Sep 2023 14:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693580173;
        bh=vwo7zx7th9i170RULwmiP9QIcemObD9n564q0acI7E8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=t9AhKZqxyPq+yUXrea0J6CWo4g00bZlAXveM41jstkIJztWqZ8qsRbJw8EX/Sctzg
         4Z10BfWnbcrtedInpNZHo1FI6zHYRrpwRMgUbEtr7YdliiKBgoul5VOpz8srVvgGOf
         avEXDUQI7nvXUQTizGmaLHQW43Ew8xkqhERo7sxUoPMHSlvLdBoZpz6W4rIkFMYycc
         SDUjAVwrc6zpSvSeTmd5r0NTUXfYuz4iCM9dSeOqhBMmnVooWcHBnATWVyNi8u9h15
         jHD7yVq1HwizyODPvjuXxxRQl8nDe7Amjk9bbel6gi1YyVYI1q1AdehnLDsYzlXeK5
         JxjKUdydaHW4g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 90C6ECE10FD; Fri,  1 Sep 2023 07:56:11 -0700 (PDT)
Date:   Fri, 1 Sep 2023 07:56:11 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Z qiang <qiang.zhang1211@gmail.com>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Traverse possible cpu to set maxcpu in
 rcu_nocb_toggle()
Message-ID: <8ae2c077-da7c-48e8-9369-0a478acab19f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ZOy6mfw5Yr7hsi3i@2a01cb09806c67d6fe4a366cc09da8f8.ipv6.abo.wanadoo.fr>
 <16F11103-75C4-4DCE-8272-D619ECAA96BD@joelfernandes.org>
 <ZO25SDat3cd6opQ7@lothringen>
 <7ca81dd6-af72-4345-9689-a1ef7dadfa95@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ca81dd6-af72-4345-9689-a1ef7dadfa95@paulmck-laptop>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 05:38:54AM -0700, Paul E. McKenney wrote:
> On Tue, Aug 29, 2023 at 11:24:24AM +0200, Frederic Weisbecker wrote:
> > On Mon, Aug 28, 2023 at 05:51:09PM -0400, Joel Fernandes wrote:
> > > I think the issue is the loop later in the function does
> > > not try to toggle cpus that came online too late.
> > > 
> > > So it does not test offloading on all CPUs just because max got updated too
> > > late.
> > 
> > Right, and therefore for_each_possible_cpu() or for_each_present_cpu()
> > should be fine to iterate since it's ok to try to toggle an offline CPU.
> 
> OK, so I will accept the original patch which did just that.

Which I finally did.  I took the liberty of adding Frederic's Reviewed-by,
but please let me know if this is in any way inappropriate.

							Thanx, Paul

> Thank you!
> 
> I recently got burned by lack of workqueues on a not-yet-onlined CPU,
> hence my questions here.  ;-)
> 
> 							Thanx, Paul
> 
> > > One fix could be to periodically check in the loop if a new cpu at maxcpu + 1
> > > ever got onlined. If it did, update the maxcpu.
> > 
> > Is it worth the complication though?
> > 
> > Thanks.
> > 
> > > 
> > > Thanks.
> > > 
> > > 
> > > > 
> > > > Thanks.
