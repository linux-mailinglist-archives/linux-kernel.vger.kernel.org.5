Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFDA7D96DA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 13:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjJ0Lob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 07:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjJ0Loa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 07:44:30 -0400
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC54AC
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 04:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1698407064;
        bh=yukBmy9p11tx0AucygHU2OcvxtseIS2votlBhSgyhq8=;
        h=From:To:Cc:Subject:Date;
        b=El6MylZsa+dz4TLl1uAlBJGFPMQO+P2HwHTIPHuF8z363j6JqhKpLUpMmZqEAJfzJ
         uIcfRNSnN9BHQlJMLSHzsX22u0oI9gQNOsGXvNZa2tp9oETvxb8M2gvXZZzgwasy60
         J86xvjPDPXmgYKOX+9taOSQaxoNqHUVMlVYQmTDA=
Received: from RT-NUC.. ([39.156.73.12])
        by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
        id B158D689; Fri, 27 Oct 2023 19:44:21 +0800
X-QQ-mid: xmsmtpt1698407061t7e7mbwhe
Message-ID: <tencent_FB1D31CEC045E837ABE5B25CC5E37575F405@qq.com>
X-QQ-XMAILINFO: NMGzQWUSIfvTE831ChY3WYp2gelANgt1hI89QIxhwQKjZvz2qRg8w5+AULfJWH
         TbZLaL78DhCf5cIHrCIPJAEnIUMLzzhYI9JfG6U8qlCWlpM6ytiLHYLt1vkiGRHdsebN9u3K3J17
         Jmoyfp7Knvte11KFxX60kjAcsBuCmQYZ2X1r2GQGmY3wdcZs/GlAR13ob7U5/lq4hy/TCdAnut1w
         Tu1ldm2R2QPA1h10dL87y41UkOjHy0eitPsg7AOXeMlCsaC741+aWkgRIXqIX6mcz7XpoS8QLv2j
         IX6XGdikVIdVx6KnEbXDbFAA/obsgaKpfUXSiTQDTJy7TP6Y3wgCuoHCSj6XF2oc0ZDRnzidubSq
         Ixhdl+G3RKeA1wlXOCh0W/1XlYZXfbvxm7vXXubeLaD9XpT2tL6x4J6OgNWsqFH13s4QU5QlC9zw
         PhnLWTIRIbIpu6y/qNa0W2hjJgMPQV03nHd3rBNovnEOqwoCxVGf+bmAbpSdOCGY469mqBmIA8Fy
         PomfCFj/ocJ0FYUdJveLgRpA5QgGHRWfA+0ZKrCCOgOEQchQYppOJlFiNRVjbIS2uF80KUnnRYjE
         b15nqP93aEzF0sv5pK3CASGukEMm/kELDlS6xFHZjc4Gm58ETxJSx5Sm2DeFx18byFiu2ZSrU9Sd
         DQYl38WbF/xXUZ7gcWGz45Oyk7mQDtAYvexRyMkqF++RSlTaY7HQT/BOvALUBxEcRFkwCXigA1H4
         ULfDIxFEcRDfx6T0/XmA0qNtHVDhN9a6b0kV7jLSF3jyoe3Tr142XeE5PeaQlZPzLG/rZ9HevP+h
         EwPRO/CWjmcJnvaicRpRF7c0AXkhMf2YAQA7SvcZuSHy8oR/YVOD4W3lQonbSttEqZCFldltnK6i
         1SfIjNSMmCuvP0ftINngNkbP59k9Fha4Y9P5H/duDYvjvcB2D58narkWgf2zIHK8TsF1YLE3ttfE
         q0ugfrMM/CCVrui7d1V+3gDIqt80WXf1VAEcobeXzVtBQzUezvt7U+B9aCK+5VNu9QYRq0sWYWuw
         Hqa50Pkw==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From:   Rong Tao <rtoax@foxmail.com>
To:     mark.rutland@arm.com, elver@google.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Cc:     rongtao@cestc.cn, rtoax@foxmail.com, tglx@linutronix.de
Subject: [PATCH v4] stop_machine: pass curstate to ack_state()
Date:   Fri, 27 Oct 2023 19:44:20 +0800
X-OQ-MSGID: <20231027114420.53491-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

The multi_cpu_stop() state machine uses multi_stop_data::state to hold
the current state, and this is read and written atomically except in
ack_state(), which performs a non-atomic read.

As ack_state() only performs this non-atomic read when there is a single
writer, this is benign, but it makes reasoning about the state machine a
little harder.

Remove the non-atomic read and pass the (atomically read) curstate in
instead. This makes it clear that we do not expect any racy writes, and
avoids a redundant load.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
v4: This patch, modify comment words according to [0].
    [0] https://lore.kernel.org/lkml/ZTegiFbGQUAp1l0p@FVFF77S0Q05N/
v3: Only pass curstate to ack_state(), it's one of patchset([1/2])
    https://lore.kernel.org/lkml/tencent_49AFDBA31F885906234219591097D42ABE08@qq.com/
v2: Pass curstate to ack_state() and apply smp_store_release()
    https://lore.kernel.org/lkml/tencent_4CD220721A6C0B39670D5D52AAE4BD2A8F0A@qq.com/
v1: Just add READ_ONCE()
    https://lore.kernel.org/lkml/tencent_705C16DF25978ACAEBD1E83E228881901006@qq.com/
---
 kernel/stop_machine.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index cedb17ba158a..268c2e581698 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -188,10 +188,11 @@ static void set_state(struct multi_stop_data *msdata,
 }
 
 /* Last one to ack a state moves to the next state. */
-static void ack_state(struct multi_stop_data *msdata)
+static void ack_state(struct multi_stop_data *msdata,
+		      enum multi_stop_state curstate)
 {
 	if (atomic_dec_and_test(&msdata->thread_ack))
-		set_state(msdata, msdata->state + 1);
+		set_state(msdata, curstate + 1);
 }
 
 notrace void __weak stop_machine_yield(const struct cpumask *cpumask)
@@ -242,7 +243,7 @@ static int multi_cpu_stop(void *data)
 			default:
 				break;
 			}
-			ack_state(msdata);
+			ack_state(msdata, curstate);
 		} else if (curstate > MULTI_STOP_PREPARE) {
 			/*
 			 * At this stage all other CPUs we depend on must spin
-- 
2.42.0

