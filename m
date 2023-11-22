Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FCD7F4796
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 14:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344086AbjKVNTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 08:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343961AbjKVNTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 08:19:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDC9191;
        Wed, 22 Nov 2023 05:19:21 -0800 (PST)
Date:   Wed, 22 Nov 2023 13:19:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700659158;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fojc2VGWk1Ppqi8igArbeVREM67+3gzH2X7O+KyEs7k=;
        b=FjIv3wsBdmz322hgPdMxAW+a5y4fN/TVKc+BWVWixWsXrZUI4rWFAPupAWIYjzLtCsrA+Z
        blS6cNGTXxEuexwvSf4S1FXU6DrigqkAqGH0kgAOSv3ggGWq7xeAcBFOqPG35ya0MmQ9NZ
        0Zbz/hr0NmuBfavLXlPYIoWBs17POcov/7AKO0GlCpwctjplIIOFpDdADRPDDbmwf/2QL2
        2qeyj/6GnGJE98RhQsh2VS1Pge+JmuDQeFcPeOOehYs6wMyHNI03NiZtAPG41gY4WFDN1X
        AW0D4E1hufW+hGbcJ9GKFOp+Evbk02OyIKKqC1bJvcjk7lPDKoxKJB0rAtUu4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700659158;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fojc2VGWk1Ppqi8igArbeVREM67+3gzH2X7O+KyEs7k=;
        b=zd2H1Kgc54bbiw4/o7TA002G2AAU8tVmRos8O//v1EqEM/STHsUgKCQcVNFfB45Ue/uKV3
        4iaOo39zXxdU4yBw==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] time: Make sysfs_get_uname() function visible in header
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        u.kleine-koenig@pengutronix.de, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231108125843.3806765-5-arnd@kernel.org>
References: <20231108125843.3806765-5-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <170065915799.398.1839657355059760928.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     a89299c40911ee29c6ec4fb66f9c598cd947265b
Gitweb:        https://git.kernel.org/tip/a89299c40911ee29c6ec4fb66f9c598cd94=
7265b
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Wed, 08 Nov 2023 13:58:25 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 22 Nov 2023 14:12:10 +01:00

time: Make sysfs_get_uname() function visible in header

This function is defined globally in clocksource.c and used conditionally
in clockevent.c, which the declaration hidden when clockevent support
is disabled. This causes a harmless warning in the definition:

kernel/time/clocksource.c:1324:9: warning: no previous prototype for 'sysfs_g=
et_uname' [-Wmissing-prototypes]
 1324 | ssize_t sysfs_get_uname(const char *buf, char *dst, size_t cnt)

Move the declaration out of the #ifdef so it is always visible.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20231108125843.3806765-5-arnd@kernel.org

---
 kernel/time/tick-internal.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 649f2b4..481b7ab 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -56,7 +56,6 @@ extern int clockevents_program_event(struct clock_event_dev=
ice *dev,
 				     ktime_t expires, bool force);
 extern void clockevents_handle_noop(struct clock_event_device *dev);
 extern int __clockevents_update_freq(struct clock_event_device *dev, u32 fre=
q);
-extern ssize_t sysfs_get_uname(const char *buf, char *dst, size_t cnt);
=20
 /* Broadcasting support */
 # ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
@@ -197,3 +196,5 @@ void hrtimers_resume_local(void);
 #else
 #define JIFFIES_SHIFT	8
 #endif
+
+extern ssize_t sysfs_get_uname(const char *buf, char *dst, size_t cnt);
