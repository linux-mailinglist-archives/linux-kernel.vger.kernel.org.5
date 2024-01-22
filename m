Return-Path: <linux-kernel+bounces-32948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E4E836262
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0398A1F28660
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89AE3CF74;
	Mon, 22 Jan 2024 11:44:30 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60ED3BB2D;
	Mon, 22 Jan 2024 11:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705923870; cv=none; b=Xjk4nnVX2ZXwGjvX4AECHr2+Qae4LluQc+5To6GazjmWxePYhLOcjUaTI6ZoZqHMqQAs02K4Y2QH1fwMBq0H3dK2cc3s/pYM7vaXbtln8p/wQVMWeiCv6YpnaK/Pqoun5BDoSEj+FDLwVzt2T/QkwxyxjBf5gWW/D9URxyIGKdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705923870; c=relaxed/simple;
	bh=CxPWEItIqkP3rza59OPyafonJL7J+WNzKVFT4RdtkXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RCPfzATFjD7jzZu0iFqwxU3L6LqW1U6Ky7Xsare5ocgDjIwCKqqP8vKtEcwzyST0EpTshhliPFMPGBk+plJe5D/4GGfbn3apIPQeCFjqCnSSqjfAz7vPFJX5YTzD8ZRLjjzFxX4e+acZiL3D87BOakJ6maFZeT2YCIfxAHPKfnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 9756b4d4305953bb; Mon, 22 Jan 2024 12:44:24 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 086D6669540;
	Mon, 22 Jan 2024 12:44:24 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Subject: [PATCH v1 08/12] PM: sleep: stats: Use locking in dpm_save_failed_dev()
Date: Mon, 22 Jan 2024 12:33:53 +0100
Message-ID: <3798847.kQq0lBPeGt@kreacher>
In-Reply-To: <5760158.DvuYhMxLoT@kreacher>
References: <5760158.DvuYhMxLoT@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekiedgfedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehulhhfrdhhrghnshhsohhnsehlihhnrghrohdrohhrghdprhgtphhtthhopehsthgrnhhishhlrgifrdhgrhhushiikhgrsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Because dpm_save_failed_dev() may be called simultaneously by multiple
failing device PM functions, the state of the suspend_stats fields
updated by it may become inconsistent.

Prevent that from happening by using a lock in dpm_save_failed_dev().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/main.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: linux-pm/kernel/power/main.c
===================================================================
--- linux-pm.orig/kernel/power/main.c
+++ linux-pm/kernel/power/main.c
@@ -323,13 +323,18 @@ struct suspend_stats {
 };
 
 static struct suspend_stats suspend_stats;
+static DEFINE_MUTEX(suspend_stats_lock);
 
 void dpm_save_failed_dev(const char *name)
 {
+	mutex_lock(&suspend_stats_lock);
+
 	strscpy(suspend_stats.failed_devs[suspend_stats.last_failed_dev],
 		name, sizeof(suspend_stats.failed_devs[0]));
 	suspend_stats.last_failed_dev++;
 	suspend_stats.last_failed_dev %= REC_FAILED_NUM;
+
+	mutex_unlock(&suspend_stats_lock);
 }
 
 void dpm_save_failed_step(enum suspend_stat_step step)




