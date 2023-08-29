Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122C778C45E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbjH2MjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235531AbjH2Mi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:38:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F0AD2;
        Tue, 29 Aug 2023 05:38:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45B5F641AC;
        Tue, 29 Aug 2023 12:38:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922A5C433C9;
        Tue, 29 Aug 2023 12:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693312735;
        bh=7FiVkg6Xp8KzB2AENKpSX0KiHgalTgBxgRn8t+eVVHE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=MiXjKnDbZ/tS3lFgZALz3DV0JeWr9UZf2ekBg0H0kcvV5VNBr4M3/uIAMbb90GAft
         csDcSAHN6FkN/ytDtVaHxTGf0xB3+Pw8cgTdtc2OUJ3KQLuvM1DIO2E8u4RKqTIWb/
         ROe+VEZon3W8o6I25MAPo3AUdlu7rSgHhCAGY818myXKHov/RwnnT1P9Wn6ZU9BBLB
         Z7Y2LXJK7BJUTegfcV7Z6YxTiesqtrlG7oSJj/RJiXoZGqOJMJuQtMAJ95xtDskvYn
         iitgMd4ds+BsOsT8Pmxs6x9BGdhUCdTFG8rOsXgrOHORdMkcoqvVtbkymUNKCEBGZt
         mvmcR4YDe+o8w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 21CDCCE1CD9; Tue, 29 Aug 2023 05:38:54 -0700 (PDT)
Date:   Tue, 29 Aug 2023 05:38:54 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Z qiang <qiang.zhang1211@gmail.com>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Traverse possible cpu to set maxcpu in
 rcu_nocb_toggle()
Message-ID: <7ca81dd6-af72-4345-9689-a1ef7dadfa95@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ZOy6mfw5Yr7hsi3i@2a01cb09806c67d6fe4a366cc09da8f8.ipv6.abo.wanadoo.fr>
 <16F11103-75C4-4DCE-8272-D619ECAA96BD@joelfernandes.org>
 <ZO25SDat3cd6opQ7@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZO25SDat3cd6opQ7@lothringen>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 11:24:24AM +0200, Frederic Weisbecker wrote:
> On Mon, Aug 28, 2023 at 05:51:09PM -0400, Joel Fernandes wrote:
> > I think the issue is the loop later in the function does
> > not try to toggle cpus that came online too late.
> > 
> > So it does not test offloading on all CPUs just because max got updated too
> > late.
> 
> Right, and therefore for_each_possible_cpu() or for_each_present_cpu()
> should be fine to iterate since it's ok to try to toggle an offline CPU.

OK, so I will accept the original patch which did just that.

Thank you!

I recently got burned by lack of workqueues on a not-yet-onlined CPU,
hence my questions here.  ;-)

							Thanx, Paul

> > One fix could be to periodically check in the loop if a new cpu at maxcpu + 1
> > ever got onlined. If it did, update the maxcpu.
> 
> Is it worth the complication though?
> 
> Thanks.
> 
> > 
> > Thanks.
> > 
> > 
> > > 
> > > Thanks.
