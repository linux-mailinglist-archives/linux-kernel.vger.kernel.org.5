Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC387B37CF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 18:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbjI2QVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 12:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbjI2QVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 12:21:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9421A4;
        Fri, 29 Sep 2023 09:21:30 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696004487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Pfy40HfW0rOpJbLp9/b9G4Tw0KUOebfRdechmC+0mdA=;
        b=wLXAzFm9DNE3IK001s6BGy7aX+uVYsoCxDrs2NGf9JxmjkU3JAP1YPr2HQNcV3oE0anECk
        LEJfB4+lBmB9VokpzPfSCqyiB9bJ76FKghCNOhWTzyqdFaX6FwwCRPmHFMJaiHoATUsmIa
        P/9tEcHa8m/ZVcQxcaLhrFkBTKDgc2r4iD2fBrVO/v2JYdMGqQTgP2zASBMK81mXuIAFTL
        8R0cMdOc6w4iAOGYS/gwm5OdzkfrNzCq8SQew54zkH6MHCorPBQcDjyqUiTwAE0REUD4xQ
        ExZPnP2VL9co2HGLiyEqtA3xe5eNsxVsbUnB6D57b8hvJSfTSaqml6/auWydfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696004487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Pfy40HfW0rOpJbLp9/b9G4Tw0KUOebfRdechmC+0mdA=;
        b=PdNwR8qu/XS8Uos9j6mMejZBVzlKL4KAyye/CdS/ycC4jMGWhmF2WEMLYR9KjpqckLpHdq
        ve7nHhcR8TxoaWCw==
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wander Lairson Costa <hawk@kernel.org>
Subject: [PATCH net-next 0/2] net: Use SMP threads for backlog NAPI (or optional).
Date:   Fri, 29 Sep 2023 18:20:18 +0200
Message-ID: <20230929162121.1822900-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RPS code and "deferred skb free" both send IPI/ function call
to a remote CPU in which a softirq is raised. This leads to a warning on
PREEMPT_RT because raising softiqrs from function call led to undesired
behaviour in the past. I had duct tape in RT for the "deferred skb free"
and Wander Lairson Costa reported the RPS case.

Changes:
- RFC=E2=80=A6v1 https://lore.kernel.org/all/20230818092111.5d86e351@kernel=
.org

   - Patch #2 has been removed. Removing the warning is still an option.

   - There are two patches in the series:
     - Patch #1 always creates backlog threads
     - Patch #2 creates the backlog threads if requested at boot time,
       mandatory on PREEMPT_RT.
     So it is either or and I wanted to show how both look like.

   - The kernel test robot reported a performance regression with
     loopback (stress-ng --udp X --udp-ops Y) against the RFC version.
     The regression is now avoided by using local-NAPI if backlog
     processing is requested on the local CPU.

Sebastian

