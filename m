Return-Path: <linux-kernel+bounces-129669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F93896E48
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49537B24CA5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE83C146594;
	Wed,  3 Apr 2024 11:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHpTDr9J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E812142E82;
	Wed,  3 Apr 2024 11:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712144093; cv=none; b=fxZwwF0HcvXNETtj45+2HOvLZi33vUuhNi+AAwt7k08u/2OabGfjPVGSSAcW+M9uBAsA/Kd636L93jAQ0ZEZjFE3eZNBn2Srbm3AIcFN5UU5oUGn00XG+bDICtyzWHZgqgA/nTE4byYG/b+uMwr5TW2rsM/yPm2y4XY9iWmdWpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712144093; c=relaxed/simple;
	bh=UDYQPhlA5eM2YlkU/4jxQmmyMYA7pLirv/wkMA+a+Ho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mPu4lze0biA072mb/yoKE2axXywKHX5AnPf41PVFYMKc07rDO9ltYoBRg3+XN4idhsyyid+vB4fspFfaNtP4mSpnNQOiZdF9SPgWCyfKl2WnyXQiteAK3BUkYMvexXxY+SqSxmIsaSeJsdEaZX0wYNPZFAivjEfWYklMNHwq+TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHpTDr9J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA40CC43390;
	Wed,  3 Apr 2024 11:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712144092;
	bh=UDYQPhlA5eM2YlkU/4jxQmmyMYA7pLirv/wkMA+a+Ho=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gHpTDr9J4ABLAfofTIZdmHgcF4X53E+MsA6Kyy0gCDir23w+XUVIYdfO+3xBKjEpU
	 Xbp9VqWa+vLSSl+HkQPE13x5tjw1UYmm/5USbToax6j4AR6S0Cs2aK84zm20xJ5gaB
	 IWtpyV016XByzp5mRTBWI1rWgs20lywAc2gnkCF4SymrFD3Z0pFEt/s3hot2gkxMgr
	 cWgVBJWFiARaE2fy5folobdM26YrABLFjQSkbBVuI7AH261LjHDgL32bwg4KKo0a2+
	 nLBeTFQSjmzHCOi2gX9ejTwsgj0oWGC1mCJaodOIVeGPNrRKXToFga+gbauU3XLHQ3
	 y3cgia0J9i4NQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEEFCD128A;
	Wed,  3 Apr 2024 11:34:52 +0000 (UTC)
From: Nikita Travkin via B4 Relay <devnull+nikita.trvn.ru@kernel.org>
Date: Wed, 03 Apr 2024 16:31:41 +0500
Subject: [PATCH v2 2/3] thermal: gov_power_allocator: Allow binding without
 trip points
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-gpa-no-cooling-devs-v2-2-79bdd8439449@trvn.ru>
References: <20240403-gpa-no-cooling-devs-v2-0-79bdd8439449@trvn.ru>
In-Reply-To: <20240403-gpa-no-cooling-devs-v2-0-79bdd8439449@trvn.ru>
To: Lukasz Luba <lukasz.luba@arm.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nikita Travkin <nikitos.tr@gmail.com>, Nikita Travkin <nikita@trvn.ru>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2101; i=nikita@trvn.ru;
 h=from:subject:message-id;
 bh=aX3XyiCHA+n2cubW1L4ZLcOrqQkfy11LKyh/4X5tJVw=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBmDT7aDjJW3qq1rSoA7iBt+c+AS53Nu9qzgj6L+
 e0DzRUDI5yJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZg0+2gAKCRBDHOzuKBm/
 dcvlD/0VZ9HatTS7LP55/Kje6FO3xvMn0crj+CRHX3Z1csFoUDnlTFaJsyFONaS5LvROuIutiJK
 gObneneKf2549moPVUtubHdi/vHQTdf2MWmxxSjhqyh+cNskIQk8WoRDpYVPrPY1Vma8858G4fb
 uhtSt4ygEXqClScqki9DlizOcWv1qqy3yMPMG/qR/Mi5C+s8rky9kbXaeN57QODSqtweVGD9Egw
 x027zgNdA0z8Tge29DlydmPAug6dAXHNWcSzhge48pXUjyoDTxIqfbxZGcgyV8meRB2nMCJSjXp
 SpJzRltV4m1uMirSDvEpoTrMrjZ1FL4he3D/0iQEcpBkBJTXfJTHiWSmlvsF5y/MFeknm8k6esu
 /2sW2+sD+5YY7h1nf1gPY+rVp+RPh3f10tYGLFvpLaO+6EtOFDxWPeUJJi4OAz2MQNZJbGtA7Sm
 J9uor6qK1GdCY8NYd1aMFRQCk6yytDi/XAkOKCQxQUsqmTPg3R9deMGLwJL5Wu3H98n+2vlWiMP
 lAYXs5mseKe8PKi08v0eWBmXPSmYL8ooqmv2P4nkKAmb9tqSRM/CZWDcHvFDqMLlnjaXGUm1vEY
 Ovppz7SH/mDIs0uu4Se0Exvel+IKYx7GV/ZvxVBI2kfE4zb7PfVLLc9CePlsPv1uzPxD0s6qcrq
 cvLXDNfkIfKxeFg==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Endpoint-Received: by B4 Relay for nikita@trvn.ru/default with
 auth_id=151
X-Original-From: Nikita Travkin <nikita@trvn.ru>
Reply-To: nikita@trvn.ru

From: Nikita Travkin <nikita@trvn.ru>

IPA probe function was recently refactored to perform extra error checks
and make sure the thermal zone has trip points necessary for the IPA
operation. With this change, if a thermal zone is probed such that it
has no trip points that IPA can use, IPA will fail and the TZ won't be
created. This is the case if a platform defines a TZ without cooling
devices and only with "hot"/"critical" trip points, often found on some
Qualcomm devices [1].

Documentation across IPA code (notably get_governor_trips() kerneldoc)
suggests that IPA is supposed to handle such TZ even if it won't
actually do anything.

This commit partially reverts the previous change to allow IPA to bind
to such "empty" thermal zones.

[1] arch/arm64/boot/dts/qcom/sc7180.dtsi#n4776

Fixes: e83747c2f8e3 ("thermal: gov_power_allocator: Set up trip points earlier")
Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 drivers/thermal/gov_power_allocator.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index ec637071ef1f..e25e48d76aa7 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -679,11 +679,6 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 		return -ENOMEM;
 
 	get_governor_trips(tz, params);
-	if (!params->trip_max) {
-		dev_warn(&tz->device, "power_allocator: missing trip_max\n");
-		kfree(params);
-		return -EINVAL;
-	}
 
 	ret = check_power_actors(tz, params);
 	if (ret < 0) {
@@ -714,9 +709,10 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 	else
 		params->sustainable_power = tz->tzp->sustainable_power;
 
-	estimate_pid_constants(tz, tz->tzp->sustainable_power,
-			       params->trip_switch_on,
-			       params->trip_max->temperature);
+	if (params->trip_max)
+		estimate_pid_constants(tz, tz->tzp->sustainable_power,
+				       params->trip_switch_on,
+				       params->trip_max->temperature);
 
 	reset_pid_controller(params);
 

-- 
2.44.0



