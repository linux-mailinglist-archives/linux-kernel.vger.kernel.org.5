Return-Path: <linux-kernel+bounces-119796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0DB88CD14
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40BF71F8680A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F6E13D619;
	Tue, 26 Mar 2024 19:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="R5KMHK5C"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C5D13D26E;
	Tue, 26 Mar 2024 19:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711480902; cv=none; b=ODD9L5ASJJz8EYNPM95c+V73KHkPPjb+DBvUQJFjVMIJ5lhwKG5b4rgv+kMtihYjuPVJFeQGTG4GMbU3wAHRzmoOrdul7ecLjkM81pooUh7pr/kW0QSG4EVowKhoiVmUUskUaXpRdzGGlFyt4cApfPjb+SEBp2a63GF23p2iW2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711480902; c=relaxed/simple;
	bh=3A3cUofIlRna705vx5jsCPCgaHRLlKXj/Nz0QjfDrdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LNFQAahyJlxN2Kmq4JYxKgJvZ4ZQCeY58TbM2o/32w/O+eDbsQMI53u6Ka+xu1VOI7wmTIqNyNTbYbDmCKxeZRhr4clrupYYto3u3IxFJer0scUfVq2aiEc8x/6WQl6a5zvlcXofcoBWIf1vuYmzT8Css+1cufEh4uJcBk9V7fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=R5KMHK5C; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=CWDnJWjsGyR5bMSxtWzq19TTn4cNaR7RRe3msB2JQWY=;
	t=1711480901; x=1712690501; b=R5KMHK5C5UAKY8E905YeRlpAPjuYJtTc/ozGWGjAxjISSM7
	xzMKQzqBRpsygw+ahuWUwbQ/DuAse6BvFqpNmOsv3GN02Db1SRgi9Ymrbq9ufrUzzKRjHv59CIcYd
	lnOUCgy/+BW9cvD7AgrIfbTok7S0rNWnQrLWTIAtd7pmM3nyV/EifmviLU6pz2xkjzY/zX07stSEf
	+cpmh5Qxtlb9DjuWwZHF0uvRkljs+mt+i5htA3+WdiuhpgRkwh6uoBbcmjZacSwNz/EwFJS3pNQHi
	tgrNylaqfMR8khmqldg90zkMG5dPInQVI46OC/A3ZI24TwxnV0KLfESV2V04ihlg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rpCMc-0000000FvLV-1Pu0;
	Tue, 26 Mar 2024 20:21:38 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-kernel@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH v2 4/4] tracing/timer: use __print_sym()
Date: Tue, 26 Mar 2024 20:15:59 +0100
Message-ID: <20240326202131.666447ad089a.I5e112e423a69704fa05db74a05a6ebaad45d4f6e@changeid>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326192131.438648-6-johannes@sipsolutions.net>
References: <20240326192131.438648-6-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Use the new __print_sym() in the timer tracing, just to show
how to convert something. This adds ~80 bytes of .text for a
saving of ~1.5K of data in my builds.

Note the format changes from

print fmt: "success=%d dependency=%s", REC->success, __print_symbolic(REC->dependency, { 0, "NONE" }, { (1 << 0), "POSIX_TIMER" }, { (1 << 1), "PERF_EVENTS" }, { (1 << 2), "SCHED" }, { (1 << 3), "CLOCK_UNSTABLE" }, { (1 << 4), "RCU" }, { (1 << 5), "RCU_EXP" })

to

print fmt: "success=%d dependency=%s", REC->success, __print_symbolic(REC->dependency, { 0, "NONE" }, { 1, "POSIX_TIMER" }, { 2, "PERF_EVENTS" }, { 4, "SCHED" }, { 8, "CLOCK_UNSTABLE" }, { 16, "RCU" }, { 32, "RCU_EXP" })

Since the values are now just printed in the show function as
pure decimal values.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/trace/events/timer.h | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index 1ef58a04fc57..d483abffed78 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -402,26 +402,18 @@ TRACE_EVENT(itimer_expire,
 #undef tick_dep_mask_name
 #undef tick_dep_name_end
 
-/* The MASK will convert to their bits and they need to be processed too */
-#define tick_dep_name(sdep) TRACE_DEFINE_ENUM(TICK_DEP_BIT_##sdep); \
-	TRACE_DEFINE_ENUM(TICK_DEP_MASK_##sdep);
-#define tick_dep_name_end(sdep)  TRACE_DEFINE_ENUM(TICK_DEP_BIT_##sdep); \
-	TRACE_DEFINE_ENUM(TICK_DEP_MASK_##sdep);
-/* NONE only has a mask defined for it */
-#define tick_dep_mask_name(sdep) TRACE_DEFINE_ENUM(TICK_DEP_MASK_##sdep);
-
-TICK_DEP_NAMES
-
-#undef tick_dep_name
-#undef tick_dep_mask_name
-#undef tick_dep_name_end
-
 #define tick_dep_name(sdep) { TICK_DEP_MASK_##sdep, #sdep },
 #define tick_dep_mask_name(sdep) { TICK_DEP_MASK_##sdep, #sdep },
 #define tick_dep_name_end(sdep) { TICK_DEP_MASK_##sdep, #sdep }
 
+TRACE_DEFINE_SYM_LIST(tick_dep_names, TICK_DEP_NAMES);
+
+#undef tick_dep_name
+#undef tick_dep_mask_name
+#undef tick_dep_name_end
+
 #define show_tick_dep_name(val)				\
-	__print_symbolic(val, TICK_DEP_NAMES)
+	__print_sym(val, tick_dep_names)
 
 TRACE_EVENT(tick_stop,
 
-- 
2.44.0


