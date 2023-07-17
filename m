Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C42A756B3E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjGQSFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjGQSFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:05:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BC1172D;
        Mon, 17 Jul 2023 11:04:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E35DE611CB;
        Mon, 17 Jul 2023 18:04:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512DBC433C7;
        Mon, 17 Jul 2023 18:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689617090;
        bh=0EJJmYXOL7M7V4ygQyDxCfubtMpDAB+gg67o07k8rOc=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=RE4uJNSbMz8uSmwquQbgbKv8XWj+SU3ZrwbfBS9kW5nRgrD8SFI5IfrSxe9pkdqcp
         WIuptz3P1XXRhbsS2M9r8lw6WfMCzNxYwTZ6LdLvBkiicLoP70/6OylTHmCNEen1n2
         yEK5XkARFhQpPypIySKGJR0XkA7Kj5299/M4Vk+WgCxRuyExYCwPABwDpAbgVvG4Oa
         mmkfmDiw+JRXFuzylnvRnLkxW4/z5nLailmfX6j9LzgTel3/gueA76Hsa2/o+c4peT
         QWaQbbAtajcvkauk1OuN5wa2R4yhwY3xDiITIJ/P2TtOmVzUxIuY2byGFdKNJVZjyS
         oZO3rxf5DpCeA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F29A7CE03F1; Mon, 17 Jul 2023 11:04:49 -0700 (PDT)
Date:   Mon, 17 Jul 2023 11:04:49 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/5] Tasks RCU updates for v6.6
Message-ID: <a6fff63c-5930-4918-82a3-a9301309d88d@paulmck-laptop>
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

This series contains Tasks RCU updates.

1.	rcu-tasks: Treat only synchronous grace periods urgently.

2.	rcu-tasks: Remove redundant #ifdef CONFIG_TASKS_RCU.

3.	rcu-tasks: Add kernel boot parameters for callback laziness.

4.	rcu-tasks: Cancel callback laziness if too many callbacks.

5.	Complain about unexpected uses of RCU Tasks Trace.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt   |    7 +
 b/Documentation/admin-guide/kernel-parameters.txt |   23 ++++++
 b/kernel/rcu/tasks.h                              |   81 +++++++++++++++++++---
 b/scripts/checkpatch.pl                           |   18 ++++
 kernel/rcu/tasks.h                                |   24 +++++-
 5 files changed, 141 insertions(+), 12 deletions(-)
