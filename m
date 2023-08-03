Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC4576E541
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbjHCKJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235097AbjHCKJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:09:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F2A30F9
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 03:09:40 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691057378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Lxahx/B0p2ithwD2QTTzfFEaN6TUd/OP+8nagb234wQ=;
        b=yTKdB1d/A7F2KkjwQPKreoSG/7EcE+4PaPl9vUZ4+9HSY3PcU5Hf1/xMepiO7GJ4gDw6pj
        vo0cxTz5Wo3xPJxJnfzD20wQ0Aj/ZnpPEoiy4b6XYQGiJIkZ7nQd4ACR5vQVAI5nt5P4Ug
        o5VlXTU/jSZE6f080dYiP7anluD+ES1lfosTYF3KCZepSporxftC8Kig2zgZsU/eyiBvdM
        uZ/kGPPJh0dQ+jdoftMPediH4BT1D9MCrrpf9bGNnPQEVCJ0nE1/C8qXM3DoCk3bmMhMyW
        F3z/cTG4qcz8Rcb3m5ePYnR5eJYJChS8ZX10SCQ3x35PQ2zj13D5689LIcR7Gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691057378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Lxahx/B0p2ithwD2QTTzfFEaN6TUd/OP+8nagb234wQ=;
        b=yG/Q2CRHjJCXK9S741fKdju3TO/fc419ebohNjyByzB4vjPSRIpgiB4yio6zGfTd35UM3w
        LFn5fHQoWSW6XqCw==
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH REPOST v3 0/2] signal: Avoid preempt_disable() in ptrace_stop() on PREEMPT_RT
Date:   Thu,  3 Aug 2023 12:09:30 +0200
Message-Id: <20230803100932.325870-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this mini series updates the comment to properly explain why the
preempt-disable section has been added and then disables this on
PREEMPT_RT explaining why it can not be done.

v3=E2=80=A6v1
  - Include the update comment of the second patch which was posted as
    v2 within the orignal thread.
  - Add Oleg's Acks.

This is the repost of
	https://lore.kernel.org/20230615105627.1311437-1-bigeasy@linutronix.de

Previous post:
	https://lore.kernel.org/20230606085524.2049961-1-bigeasy@linutronix.de


