Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0778A78183E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 10:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjHSIJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 04:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjHSIJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 04:09:45 -0400
Received: from icts-p-cavuit-1.kulnet.kuleuven.be (icts-p-cavuit-1.kulnet.kuleuven.be [134.58.240.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D164205
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 01:09:43 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: D4F192015B.A03C7
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:145:242:ac11:22])
        by icts-p-cavuit-1.kulnet.kuleuven.be (Postfix) with ESMTP id D4F192015B;
        Sat, 19 Aug 2023 10:09:40 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_VALID#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1692432580;
        bh=V3leTNuTw836n3/bLimhjXv5C1WXrn4ysLPouSQ4Cpk=;
        h=From:To:Cc:Subject:Date;
        b=WLBSWLKC+zpi1qix1HKZJ0oNNi34kxb/5cnNMC6GEns0JbiyOYIdA6xtF6CC+Ir1g
         YHb36UnWSsAVSEZtWNYtvzg6HTiBNfcT5AATmiWAIsssFcgGzu5LVOWsq76h2wNbXJ
         q9jaa3YvQS+hj+3qKlyswsYqG5X3mOiwhu7vDO6I=
Received: from localhost.localdomain (ptr-94-109-233-233.dyn.orange.be [94.109.233.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPSA id BFCDBD4EB5306;
        Sat, 19 Aug 2023 10:09:37 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
To:     linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, mingo@redhat.com,
        sohil.mehta@intel.com
Cc:     x86@kernel.org, bp@alien8.de, tglx@linutronix.de, hpa@zytor.com,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH v4 0/1]  x86/pti: Fix kernel warnings for pti= and nopti cmdline options.
Date:   Sat, 19 Aug 2023 10:09:20 +0200
Message-Id: <20230819080921.5324-1-jo.vanbulck@cs.kuleuven.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the fourth iteration of a patch to improve the cmdline option parsing
for PTI. This reverts largely back to the first iteration and cleans up the
code to remove any attempts at backwards compatible behavior for clearly
conflicting options when users erroneously combine pti= nopti and
mitigations=off as per Dave's suggestions [1].

[1] https://lore.kernel.org/all/b9bbb279-fa8f-0784-900f-114ce186cbb3@intel.com/

Behavior
--------

For reference, behavior with this patch is now as follows in case of any
conflicting options.

1. Latest in order of nopti pti= takes priority:

KERNEL_CMDLINE="nopti pti=on"
[    0.021779] Kernel/User page tables isolation: enabled
Mitigation: PTI

KERNEL_CMDLINE="pti=on nopti"
[    0.010289] Kernel/User page tables isolation: disabled on command line.
Vulnerable

2. Passing mitigations=off will unconditionally disable PTI:

KERNEL_CMDLINE="mitigations=off pti=on"
[    0.008331] Kernel/User page tables isolation: disabled on command line.
Vulnerable

KERNEL_CMDLINE="pti=on mitigations=off"
[    0.008495] Kernel/User page tables isolation: disabled on command line.
Vulnerable

Changelog
---------

v4
  - Add whitespace (Sohil)
  - Remove goto (Sohil)

v3
  - Revert backwards compatibility ugliness for conflicting options (Dave)

v2
  - Split pti=off and mitigations=off checks (Sohil)
  - Ensure backwards compatibility for conflicting options (Sohil)

Best,
Jo

Jo Van Bulck (1):
  x86/pti: Fix kernel warnings for pti= and nopti cmdline options

 arch/x86/mm/pti.c | 58 +++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

-- 
2.25.1

