Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC79756B44
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjGQSHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGQSHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:07:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B7F8E;
        Mon, 17 Jul 2023 11:07:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 582FA611BF;
        Mon, 17 Jul 2023 18:07:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B4CC433C8;
        Mon, 17 Jul 2023 18:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689617223;
        bh=bdbGBtBp9gVUjYwlZXwNLIIeuymzok0/+4OiQERDR9w=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=FSi/b9KZqFtd+Kte6tyr4FvDEX0OceAlDcee2WxtFbiPfDMLeWAZghm6zGpyGssyd
         K9Eifrc/v0JLn92dvd2H1rBA17sPY7qrQPPvaXBYqlI13S+DTVQaV1Fim4zh9n8gqB
         lWjjg07y1E6xEiEnTu1qJBWgoFp6ixmdNYU2B6XptEs0jHd3rVlVDElYNM3nJJAvby
         kH1KChvD5KUcFsJIoCH1d9qXb8nwAmXRbiynH9euGwskRZO25iiH5xXRtPJlYrsUbl
         TU1hS++1eBlzOsOlSW4YcU/sDzr+Ns9MG+DoYMFnd2P0t83k3k/Lg1Qo5Zkg97UVf3
         vBUTMzLONO2bg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 52BBFCE03F1; Mon, 17 Jul 2023 11:07:03 -0700 (PDT)
Date:   Mon, 17 Jul 2023 11:07:03 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/3] Reference-side scalability test updates for v6.6
Message-ID: <2c4aea8b-6f82-45ab-988e-a6bb19129808@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains reference-side scalability tests:

1.	Add CONFIG_PREEMPT_DYNAMIC=n to NOPREEMPT scenario.

2.	Fix uninitalized use of wait_queue_head_t, courtesy of Waiman
	Long.

3.	Add a "jiffies" test.

						Thanx, Paul

------------------------------------------------------------------------

 b/kernel/rcu/refscale.c                                         |    3 
 b/tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT |    1 
 kernel/rcu/refscale.c                                           |   34 +++++++++-
 3 files changed, 35 insertions(+), 3 deletions(-)
