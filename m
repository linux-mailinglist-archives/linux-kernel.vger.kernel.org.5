Return-Path: <linux-kernel+bounces-26672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DE282E50B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DB501C225A7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155A3219F2;
	Tue, 16 Jan 2024 00:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFAwK7A9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFD7A921;
	Tue, 16 Jan 2024 00:14:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE586C433F1;
	Tue, 16 Jan 2024 00:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364070;
	bh=5xaBwxTKxIz5PyR/JD4JH843H06XHTnJjJPrj74bQP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HFAwK7A9b9dMS9y1oLtz6WtUrVJREeBfsYffOJRETGlruHlOpUfFczs+/ZJ/uHrwo
	 +AVWZjuz1BS+AjG4mSQaYJDOBOl+4M8H4lcVqPbM+bRxNPvkngkhrFYQEqJtVniY9Q
	 wcMEVK+9ECTVavNeFAophlMPxpQHUiCeW/pfROnW3zHeebOqFlBYS6Yrpg5fCniidF
	 G9/dy3O3ZN6yObxv0RaSsmYPgvffk/aMVmSIXRdQEyVzC4b2BUT5sA7EVCNSo8ARZV
	 q2FXJEW8jEl4gRAm5sTgBnxn/BV9926znbI9z7SIYLLz2dU48ZpkSt7wwlHmgTKO7w
	 V0lO6nMXZ4MHw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yuntao Wang <ytcoode@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	dave.hansen@linux.intel.com,
	dan.j.williams@intel.com,
	alison.schofield@intel.com,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 7/9] ACPI: NUMA: Fix the logic of getting the fake_pxm value
Date: Mon, 15 Jan 2024 19:14:12 -0500
Message-ID: <20240116001418.213635-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116001418.213635-1-sashal@kernel.org>
References: <20240116001418.213635-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
Content-Transfer-Encoding: 8bit

From: Yuntao Wang <ytcoode@gmail.com>

[ Upstream commit e3f577830ce216b0ca21d4750cbbd64cfc21efff ]

The for loop does not iterate over the last element of the node_to_pxm_map
array. This could lead to a conflict between the final fake_pxm value and
the existing pxm values. That is, the final fake_pxm value can not be
guaranteed to be an unused pxm value.

While at it, fix up white space in slit_valid().

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
[ rjw: Changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/numa/srat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 12f330b0eac0..b57de78fbf14 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -183,7 +183,7 @@ static int __init slit_valid(struct acpi_table_slit *slit)
 	int i, j;
 	int d = slit->locality_count;
 	for (i = 0; i < d; i++) {
-		for (j = 0; j < d; j++)  {
+		for (j = 0; j < d; j++) {
 			u8 val = slit->entry[d*i + j];
 			if (i == j) {
 				if (val != LOCAL_DISTANCE)
@@ -532,7 +532,7 @@ int __init acpi_numa_init(void)
 	 */
 
 	/* fake_pxm is the next unused PXM value after SRAT parsing */
-	for (i = 0, fake_pxm = -1; i < MAX_NUMNODES - 1; i++) {
+	for (i = 0, fake_pxm = -1; i < MAX_NUMNODES; i++) {
 		if (node_to_pxm_map[i] > fake_pxm)
 			fake_pxm = node_to_pxm_map[i];
 	}
-- 
2.43.0


