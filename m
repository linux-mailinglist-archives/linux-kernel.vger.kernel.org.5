Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F2B756B30
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjGQSDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjGQSDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:03:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67372B3;
        Mon, 17 Jul 2023 11:03:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3EFB611BF;
        Mon, 17 Jul 2023 18:03:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA0DC433C8;
        Mon, 17 Jul 2023 18:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689616994;
        bh=aUyjBUMINCyfPovEBJv8iduU9zI+11vnLgqgR3Vbln0=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=Wtf4vRW5oaC0jcIo5s268/VivTcurhKJ/0WFB6MCF5VO2SVVn0fSHi9/E6zopy3jd
         p78VSy6AkjTlaxWeiSPBJu1EglCmaquuKsQRJLEOcZkEyyGhbbCSZnm2KYeXvmzHdK
         ODnArlYhxyHDGBl9af+Q8/myHV2eYrFZS3+RFn9/aEb4bxcbeuVv8X4c9UXHu84VTR
         kLbXpZzFUUSWRACeelIpWGQgXA3Vn6XeVEWbVlzVuWuJDPJzA/3315xm8LE4tMJlzO
         R1R2AJl+AScWxokaC1fuQGtspHdg88o4mce0XIwRx5YfL5Wbh7z0eeyBsMv2ST77dk
         D152MoLy9lVZA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CDA36CE03F1; Mon, 17 Jul 2023 11:03:13 -0700 (PDT)
Date:   Mon, 17 Jul 2023 11:03:13 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/6] Miscellaneous fixes for v6.6
Message-ID: <6127192c-da9b-4599-9738-6e8f92e6c75c@paulmck-laptop>
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

This series has miscellaneous fixes:

1.	Update synchronize_rcu_mult() comment for call_rcu_hurry().

2.	Clarify rcu_is_watching() kernel-doc comment.

3.	srcu,notifier: Remove #ifdefs in favor of SRCU Tiny srcu_usage.

4.	Mark __rcu_irq_enter_check_tick() ->rcu_urgent_qs load.

5.	Make the rcu_nocb_poll boot parameter usable via boot config.

6.	Use WRITE_ONCE() for assignments to ->next for rculist_nulls,
	courtesy of Alan Huang.

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/notifier.h      |   11 -----------
 b/include/linux/rculist_nulls.h |    4 ++--
 b/include/linux/rcupdate_wait.h |    5 +++++
 b/include/linux/srcutiny.h      |    7 +++++++
 b/kernel/rcu/tree.c             |   12 ++++++++----
 b/kernel/rcu/tree_nocb.h        |    4 ++--
 kernel/rcu/tree.c               |    2 +-
 7 files changed, 25 insertions(+), 20 deletions(-)
