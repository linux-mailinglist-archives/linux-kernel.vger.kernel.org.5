Return-Path: <linux-kernel+bounces-57999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAB484E01F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 522501F2123B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA55D76405;
	Thu,  8 Feb 2024 11:56:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7854B763EF;
	Thu,  8 Feb 2024 11:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707393386; cv=none; b=phkc+KWI+3moz0NlZYszUOi3dfKU6NCR/11pAXqVZOBGdFCoop8jw9JVoNdZZBtu/tq6up2s9lnmu2+n+mNk6D/fWMGUhtOv/vEXfhuX6wao1ajA5eBmWKpXZHWYwZq0mNwN8Bdvii3aLc3Uk5++No2nrhmP5WTwr22dh9Ay0CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707393386; c=relaxed/simple;
	bh=Da4Wg14h1CcjXL0JhFy9dAEG/iSfGR93L/E4kBh6W60=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mwR4z9TQIJ3uYydZtMgCfMK2m2L6W/NoJ1I86THIWWBQ4j6Esf/UgqMqQPFzrFDT6RFjRDPlFvt25FkCISpLnfQWxUdpNn9tYxT/56aiEfhtvoDivpY2uyyBylIKF65sBQIoCcfkDZn7ABVb/8WJCaDvFj1HdEtkKbAUu5rwS4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D2741FB;
	Thu,  8 Feb 2024 03:57:06 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.8.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 08FFE3F5A1;
	Thu,  8 Feb 2024 03:56:20 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael@kernel.org
Cc: lukasz.luba@arm.com,
	dietmar.eggemann@arm.com,
	rui.zhang@intel.com,
	amit.kucheria@verdurent.com,
	amit.kachhap@gmail.com,
	daniel.lezcano@linaro.org,
	viresh.kumar@linaro.org,
	len.brown@intel.com,
	pavel@ucw.cz,
	mhiramat@kernel.org,
	qyousef@layalina.io,
	wvw@google.com,
	xuewen.yan94@gmail.com
Subject: [PATCH v8 06/23] PM: EM: Check if the get_cost() callback is present in em_compute_costs()
Date: Thu,  8 Feb 2024 11:55:40 +0000
Message-Id: <20240208115557.1273962-7-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240208115557.1273962-1-lukasz.luba@arm.com>
References: <20240208115557.1273962-1-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subsequent changes will introduce a case in which 'cb->get_cost' may
not be set in em_compute_costs(), so add a check to ensure that it is
not NULL before attempting to dereference it.

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/power/energy_model.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 5c47caaf270e..21d761223255 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -116,7 +116,7 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
 	for (i = nr_states - 1; i >= 0; i--) {
 		unsigned long power_res, cost;
 
-		if (flags & EM_PERF_DOMAIN_ARTIFICIAL) {
+		if ((flags & EM_PERF_DOMAIN_ARTIFICIAL) && cb->get_cost) {
 			ret = cb->get_cost(dev, table[i].frequency, &cost);
 			if (ret || !cost || cost > EM_MAX_POWER) {
 				dev_err(dev, "EM: invalid cost %lu %d\n",
-- 
2.25.1


