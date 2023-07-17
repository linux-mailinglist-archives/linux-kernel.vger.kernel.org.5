Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71082756B57
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjGQSKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjGQSKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:10:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394F6A1;
        Mon, 17 Jul 2023 11:10:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C06D6611D3;
        Mon, 17 Jul 2023 18:10:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28CF3C433C8;
        Mon, 17 Jul 2023 18:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689617408;
        bh=Sdq5gQ+aL3LLkEeJ/3g5VCOtLbSSBFoRGd1+OGzUMlQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dP1hdja+w1VHezoiNAIR5UXWSAX7RxMmhxU6eDztOX/7OWfZYgVRTA3fTj8ux0b8E
         fUCdtl6MVWjYKFQsxb37wbIe9h0lviBUxI43IJfDXooMy98VyrA056KzmXbCr+9THo
         uhikJIOQQYwcQ9Ie5YPRcAOJd/JxgmFsxmGCttwoZieX0effr8zKwFdcIsXnsarCAm
         n3KPLmHv09EkxiQ4V1OoBABdpX8cWC9C+gV31pbjM4tE9X51kugONHRr8rHev7H6ut
         JQzHKjYO/eHj4nWQd2P+CzBW8M92oCyWo0/w7wpXQaoFJc8pEBb73qmyTHBl5xnGEw
         H9kacEnHfQkBA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CE48ACE03F1; Mon, 17 Jul 2023 11:10:07 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/3] refscale: Add CONFIG_PREEMPT_DYNAMIC=n to NOPREEMPT scenario
Date:   Mon, 17 Jul 2023 11:10:04 -0700
Message-Id: <20230717181006.1097957-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2c4aea8b-6f82-45ab-988e-a6bb19129808@paulmck-laptop>
References: <2c4aea8b-6f82-45ab-988e-a6bb19129808@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is no longer possible to build a kernel with a preemption-disabled
RCU without use of CONFIG_PREEMPT_DYNAMIC=n.  This commit therefore
adds CONFIG_PREEMPT_DYNAMIC=n to the refscale torture type's NOPREEMPT
scenario file.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT b/tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT
index ef2b501a6971..67f9d2998afd 100644
--- a/tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT
+++ b/tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT
@@ -2,6 +2,7 @@ CONFIG_SMP=y
 CONFIG_PREEMPT_NONE=y
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
+CONFIG_PREEMPT_DYNAMIC=n
 #CHECK#CONFIG_PREEMPT_RCU=n
 CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=y
-- 
2.40.1

