Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1C176FA4D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 08:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbjHDGmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 02:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjHDGmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 02:42:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1E5E53
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 23:42:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1CF761F2D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 06:42:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97793C433CA;
        Fri,  4 Aug 2023 06:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691131323;
        bh=YE6JfkMkXl9XPK3NoaGgAgTqWqSUr2g18HujC+qBon0=;
        h=From:To:Cc:Subject:Date:From;
        b=ICMPzsl/Bl3lVEDraftSCIcOSIOzp+Zf5H2Kgdc/sgAf5auhi3g8BFfUIZDC+TfBD
         8HgPTXSXO1yT2fb3WsrDf8Srz25hugqXyfZZwhLYOF3BauCQMHyU9ag9RQt5H5bTfV
         otYupeylYCbVTt++Dg2qVgZKPApajwkKf4QH7k4I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <jstultz@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Mike Christie <michael.christie@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Zqiang <qiang1.zhang@intel.com>,
        Prathu Baronia <quic_pbaronia@quicinc.com>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: [PATCH] kthread: unexport __kthread_should_park()
Date:   Fri,  4 Aug 2023 08:41:51 +0200
Message-ID: <2023080450-handcuff-stump-1d6e@gregkh>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Lines:  52
X-Developer-Signature: v=1; a=openpgp-sha256; l=1946; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=YE6JfkMkXl9XPK3NoaGgAgTqWqSUr2g18HujC+qBon0=; b=owGbwMvMwCRo6H6F97bub03G02pJDCln5q4P5NPa5n5ul02d9qLWoqz2lTN2bnp6+dyXt4JTi ph+/hOS6YhlYRBkYpAVU2T5so3n6P6KQ4pehranYeawMoEMYeDiFICJ1OszLNiQIZS9VOKngd+/ 8ycOmUf6B70IXsuwYNOM1fu+9b2YYxdpXv6d9UvV07RF7wA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no in-kernel users of __kthread_should_park() so mark it as
static and do not export it.

Cc: John Stultz <jstultz@google.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: "Arve Hjønnevåg" <arve@android.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Christian Brauner (Microsoft)" <brauner@kernel.org>
Cc: Mike Christie <michael.christie@oracle.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Zqiang <qiang1.zhang@intel.com>
Cc: Prathu Baronia <quic_pbaronia@quicinc.com>
Cc: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/kthread.h | 1 -
 kernel/kthread.c        | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index f1f95a71a4bc..2c30ade43bc8 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -88,7 +88,6 @@ void kthread_bind_mask(struct task_struct *k, const struct cpumask *mask);
 int kthread_stop(struct task_struct *k);
 bool kthread_should_stop(void);
 bool kthread_should_park(void);
-bool __kthread_should_park(struct task_struct *k);
 bool kthread_should_stop_or_park(void);
 bool kthread_freezable_should_stop(bool *was_frozen);
 void *kthread_func(struct task_struct *k);
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 4fff7df17a68..1eea53050bab 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -159,11 +159,10 @@ bool kthread_should_stop(void)
 }
 EXPORT_SYMBOL(kthread_should_stop);
 
-bool __kthread_should_park(struct task_struct *k)
+static bool __kthread_should_park(struct task_struct *k)
 {
 	return test_bit(KTHREAD_SHOULD_PARK, &to_kthread(k)->flags);
 }
-EXPORT_SYMBOL_GPL(__kthread_should_park);
 
 /**
  * kthread_should_park - should this kthread park now?
-- 
2.41.0

