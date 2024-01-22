Return-Path: <linux-kernel+bounces-32957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3408F836274
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7CD81F22BF3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954773E49F;
	Mon, 22 Jan 2024 11:44:35 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FF03D0D5;
	Mon, 22 Jan 2024 11:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705923875; cv=none; b=PqHKgqqanPsPKpsxPPFd0h/3rLKlh9CodYeySk9Tl7k70J9252T2S4XaZhtkSK/kFckh0zxiKKN8duZ3Tlb9iyfAGG/efVgR23TPqUxNPnI+rhBnVuvrTeJLTFiQlZi1Q3zQaabqToAnQ1PRdp79chtDrDi8ukw+t5LFSiPgEVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705923875; c=relaxed/simple;
	bh=TAuTg+ebqU3GHaMugMat3oRGpYYeFGa9Q3+ZhmA5B20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gRZi4V8+gUzQEyKHdCvPP9S2lp+5/avdMdwhidqRlwMLeaL/cQsMAIalZZ9empO2vjteUprz1ZH4dklHCrfXqbdHZZypkWTk07HSEhRP//7i0Q7mp/Mwfr91YX6cziBw0iOPtuNA5f3z7ShSmkGZlUiEEY2Ct8O7h/gNYgW8qWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 1f64a8577498be2e; Mon, 22 Jan 2024 12:44:29 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 0D8A3669540;
	Mon, 22 Jan 2024 12:44:29 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Subject: [PATCH v1 01/12] PM: sleep: Simplify dpm_suspended_list walk in dpm_resume()
Date: Mon, 22 Jan 2024 12:22:38 +0100
Message-ID: <4553341.LvFx2qVVIh@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekiedgfedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehulhhfrdhhrghnshhsohhnsehlihhnrghrohdrohhrghdprhgtphhtthhopehsthgrnhhishhlrgifrdhgrhhushiikhgrsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Notice that devices can be moved to dpm_prepared_list before running
their resume callbacks, in analogy with dpm_noirq_resume_devices() and
dpm_resume_early(), because doing so will not affect the final ordering
of that list.

Namely, if a device is the first dpm_suspended_list entry while
dpm_list_mtx is held, it has not been removed so far and it cannot be
removed until dpm_list_mtx is released, so moving it to dpm_prepared_list
at that point is valid.  If it is removed later, while its resume
callback is running, it will be deleted from dpm_prepared_list without
changing the ordering of the other devices in that list.

Accordingly, rearrange the while () loop in dpm_resume() to move
devices to dpm_prepared_list before running their resume callbacks and
implify the locking and device reference counting in it.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c |   16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -1017,25 +1017,19 @@ void dpm_resume(pm_message_t state)
 
 	while (!list_empty(&dpm_suspended_list)) {
 		dev = to_device(dpm_suspended_list.next);
-
-		get_device(dev);
+		list_move_tail(&dev->power.entry, &dpm_prepared_list);
 
 		if (!dev->power.async_in_progress) {
+			get_device(dev);
+
 			mutex_unlock(&dpm_list_mtx);
 
 			device_resume(dev, state, false);
 
+			put_device(dev);
+
 			mutex_lock(&dpm_list_mtx);
 		}
-
-		if (!list_empty(&dev->power.entry))
-			list_move_tail(&dev->power.entry, &dpm_prepared_list);
-
-		mutex_unlock(&dpm_list_mtx);
-
-		put_device(dev);
-
-		mutex_lock(&dpm_list_mtx);
 	}
 	mutex_unlock(&dpm_list_mtx);
 	async_synchronize_full();




