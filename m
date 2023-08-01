Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88A876B057
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbjHAKGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbjHAKGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:06:38 -0400
X-Greylist: delayed 135 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Aug 2023 03:06:37 PDT
Received: from p3plsmtpa14-08.prod.phx3.secureserver.net (p3plsmtpa14-08.prod.phx3.secureserver.net [97.74.135.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4872FD3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:06:37 -0700 (PDT)
Received: from localhost ([82.27.99.45])
        by :SMTPAUTH: with ESMTPA
        id QmEmqrZkLyhe0QmEnqlwKH; Tue, 01 Aug 2023 03:04:21 -0700
X-CMAE-Analysis: v=2.4 cv=abin3zkt c=1 sm=1 tr=0 ts=64c8d8a5
 a=YwMIiW7BGddQzL8MrqPWMg==:117 a=YwMIiW7BGddQzL8MrqPWMg==:17
 a=2pMVjWlDXWENfkYnN9AA:9
X-SECURESERVER-ACCT: atomlin@atomlin.com
From:   Aaron Tomlin <atomlin@atomlin.com>
To:     peterz@infradead.org, tj@kernel.org
Cc:     atomlin@atomlin.com, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] workqueue: Introduce PF_WQ_RESCUE_WORKER
Date:   Tue,  1 Aug 2023 11:04:20 +0100
Message-Id: <20230801100420.939677-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230729160712.GA5697@hirez.programming.kicks-ass.net>
References: <20230729160712.GA5697@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfBYzk98O0O1erpH2VmSPAByCKAiI/9RV6J0qSksSCo+2JivjCjYFq6OzWiih80wp9X6jVMwEjAmlPcK4ptf+FFYohnZnBdbottnUBNhEVZfOVpG5br3Q
 FsXJ9SMefb2gGAT1b4l10gTfP5RV/61MwiXMEs0qqtTvW4bze4EgDlicYHboCtPfJeUTmNvWJeb0ipS4AzkFVO6uGbD6oieHKTgt3TDDcUojqR9X52XUTLll
 O7klyK9OAtsfxckFxLuHJkuYPbYi1ukvd/VvloBrLKeg58olBiwTTzMvoEoiyF+VfBXL2w2hnTgSvhJuFiJMsg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Is the implication that PF_flags are considered ABI? We've been changing
> them quite a bit over the years.

Hi Peter, Tejun,

I never assumed they were.

In this context, one should always check the Linux kernel source code first
i.e. do not assume what is exported via /proc/[PID]/stat will be stable/or
consistent between releases.

> Also, while we have a few spare bits atm, we used to be nearly out for a
> while, and I just don't think this is sane usage of them. We don't use PF
> flags just for userspace.

Fair statement.

Albeit, I suspect it would still be useful for user-mode to easily
differentiate between a kworker and a rescuer kworker. According to
create_worker(), we do make it clear the difference between a CPU-specific
and unbound kworker by way of the task's name. Looking at init_rescuer() a
rescuer kworker is simply given the name of its workqueue. Would you
consider modifying the rescuer's task's name so it is prefixed with
"kworker/r-%s" and then include the workqueue's name e.g.
"kworker/r-ext4-rsv-conver" acceptable?



Kind regards,
-- 
Aaron Tomlin
