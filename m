Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAFE7799A1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 23:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236488AbjHKVhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 17:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235682AbjHKVhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 17:37:22 -0400
Received: from icts-p-cavuit-1.kulnet.kuleuven.be (icts-p-cavuit-1.kulnet.kuleuven.be [134.58.240.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9035271E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 14:37:10 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: A4D702015F.AA64C
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:145:242:ac11:22])
        by icts-p-cavuit-1.kulnet.kuleuven.be (Postfix) with ESMTP id A4D702015F;
        Fri, 11 Aug 2023 23:37:07 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_SIGNED#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1691789827;
        bh=mgzOOQxYQDl+jFuVhD5H2Cp+ameP5CKxHmtg1ZiqcaI=;
        h=From:To:Cc:Subject:Date;
        b=gitSo/ztJBVrfXrNPIEZTNVRGeG9w4tYEWBDP+ioh0Y7hIJZ/J5IA22tPwS+3TwPo
         sWb10317UxwZrYzC2u9L7SUmrTtzefuAldusiBo+diAYjpQnsk5zMHBGVpl+bQQlFq
         mx/ayrpMDn8oSgqo6TAd2Z2QLnaziiawq/sWWXYw=
Received: from localhost.localdomain (unknown [68.170.73.15])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPSA id 88395D4EBF944;
        Fri, 11 Aug 2023 23:37:05 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
To:     linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, mingo@redhat.com,
        sohil.mehta@intel.com
Cc:     x86@kernel.org, bp@alien8.de, tglx@linutronix.de, hpa@zytor.com,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH v2 0/1] x86/pti: Fix kernel warnings for pti= and nopti cmdline
Date:   Fri, 11 Aug 2023 14:36:27 -0700
Message-Id: <20230811213628.40428-1-jo.vanbulck@cs.kuleuven.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the second iteration of a patch to improve the cmdline option parsing
for PTI.

Changelog
---------

v2
  - Split pti=off and mitigations=off checks (Sohil)
  - Ensure backwards compatibility for conflicting options (Sohil)

Best,
Jo

Jo Van Bulck (1):
  x86/pti: Fix kernel warnings for pti= and nopti cmdline options.

 arch/x86/mm/pti.c | 59 +++++++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 25 deletions(-)

-- 
2.25.1

