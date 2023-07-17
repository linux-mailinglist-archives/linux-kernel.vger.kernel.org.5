Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4206C756C0B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjGQS2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjGQS2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:28:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8985E1A5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 11:28:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2766E611F0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 18:28:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF6FC433CB;
        Mon, 17 Jul 2023 18:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689618483;
        bh=90t3K+mbEU1G4DQ4Mhh9uzGaPV3x7YWOvc2Rn9WUFEo=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=vAO5Lj0267rvUTd0ZlcDtGmXUOYBvsQ4M7XZ6cCLhy6QPlKmMrqy35OZNz7YO682v
         KxiDM83XTl+SYr8yZ+CJyrzZ+jEf14traBdFoJZgQLLxlyaAzZ/R5UW9P1l556tNEE
         4/T7glccUtnQTx661He/MUFdIM18EhtSHQaGbtMox4yOejU88MNqWZXXeRr7iLwJOD
         wCbWdpUOuUbRjd95dl3OWypcJTCM1Y1gLICV+J12IgNsE4yJDCzl79yBBmKjKR7XtG
         W1+EpdGCyZ9cT7/6/WDMbWO0bTOVYxXItGoPFwfkm8VgMtAvvAbVMy35P/MMLTk+Hn
         k4HbJiiqAwLaA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 01C44CE03F1; Mon, 17 Jul 2023 11:28:02 -0700 (PDT)
Date:   Mon, 17 Jul 2023 11:28:02 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de, daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@meta.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com
Subject: [PATCH clocksource 0/2] TSC and clocksource-watchdog updates for v6.6
Message-ID: <db4a845e-5f87-4aee-8957-150c253f67e7@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains TSC and clocksource-watchdog updates:

1.	Handle negative skews in "skew is too large" messages.

2.	x86/tsc: Extend watchdog check exemption to 4-Sockets platform,
	courtesy of Feng Tang.

						Thanx, Paul

------------------------------------------------------------------------

 arch/x86/kernel/tsc.c     |    2 +-
 kernel/time/clocksource.c |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)
