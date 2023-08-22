Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3BD783853
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 05:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbjHVDMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 23:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbjHVDMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 23:12:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B44185
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 20:12:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F4C2641BA
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 03:12:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA98C433C7;
        Tue, 22 Aug 2023 03:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692673971;
        bh=18HDjDMZa6XLbtpsNYGSnGuSb03N/2O/CdDsBatVzRw=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=oOI65ig3i5dIDkkWu4BcrwERB3ykob4WbZfH75UNlPgQdpZljVzideqIZejiQkagf
         XqCfSFhV7wnADzjHYgQSVz5rfAxVyn1IsE8Qej6D7yi1rUdw+HCc15JvtAiPkOBA2J
         lUjxXx2znMDrcCx1xdjJOIxCvLd+uJwUnhadbRiK+ceF4RLMAQvBvnTVefOozoDcGm
         tXuD6s3Pc41mfUhoz8cE/DdnOSIv+zktw07nZkNeqoRhrTbEyH6m8GbBeb8G1Nd+Af
         g8DOfFB7felm03v8LSx5J+rWzVaGWGU0zQILSRh8KZov9ZHra6gbcl5fjituhut50E
         DvM9kWoJ0npKw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EE2D3CE0367; Mon, 21 Aug 2023 20:12:50 -0700 (PDT)
Date:   Mon, 21 Aug 2023 20:12:50 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     joel@joelfernandes.org
Cc:     linux-kernel@vger.kernel.org
Subject: Question on __torture_rt_boost() else clause
Message-ID: <1393d18f-4928-45da-b504-7e5b6a681e51@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Joel!

A quick question for you...

I am doing catch-up additions of locktorture module parameters
to kernel-parameters.txt, and came across rt_boost_factor.  The
multiplication by cxt.nrealwriters_stress in the !rt_task(current)
then-clause makes sense:  No matter how many writers you have, the
number of boost operations per unit time remains roughly constant.
But I am having some difficulty rationalizing a similar multiplication
in the else-clause.  That would seem to leave boosting in effect for
longer times the more writers there were.

Is that the intent?

Also, I am rationalizing the choice of 2 as default for rt_boost by
noting that "mutex" and "ww_mutex_lock" don't do boosting and that
preemption-disabling makes non-RT spinlocks immune from priority
inversion.  Is this what you had in mind, or am I off in the weeds here?

I am putting my best guess in the patch, and am including you on CC.

						Thanx, Paul
