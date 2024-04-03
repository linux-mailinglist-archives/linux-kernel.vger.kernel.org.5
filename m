Return-Path: <linux-kernel+bounces-129667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC44896E47
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05D251C24AC6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA672146589;
	Wed,  3 Apr 2024 11:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5cyU6hy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7371420BC;
	Wed,  3 Apr 2024 11:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712144093; cv=none; b=uXvam9Zpr/ZB7mTGzLAgScoum1U874gR87tFE/P1BllUxfz+m+T83yzWUbugsuavx45XHIayLHG0/8FqY5JQXhrWBnoG6+afEPjZiq0g6hWDgNIlaWwyN1IuTob0mbNRamyNu2TpPV/BUQfskjHIs1P8s9wU7a74HolyZ9C4up0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712144093; c=relaxed/simple;
	bh=/cAO8r1QYGwr2S/rVs04YoQy4x022R0HsRlCwXhwDy8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZPrZOTzzmcQCtW5E2iBRA3A+sXQ5l3bALLbVK4M2hWuh2UlX7xCFQ0Tt7gZEmjKmaSZke1zzUUqNeTnHhR0m1GVluGrLneFJ0gRRtAAnz4+rncPNcfT6MBenpbPISmwX/LT12XbsdNQFmrbiRVS/O6TVCySkBDtPWJgMenZK50Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5cyU6hy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A11A4C433F1;
	Wed,  3 Apr 2024 11:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712144092;
	bh=/cAO8r1QYGwr2S/rVs04YoQy4x022R0HsRlCwXhwDy8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=c5cyU6hyZjlCQa99pLKwXQquNKOXu/KjzX0biLYaYlj5vXsjZtbKynHJSsK34s63C
	 lWtZzIq8RkUSQAOZ3aEKrK+IaX6Lc8fvIRt1dDPo31qw9JmFNAtifCU0/tEBBMHwtD
	 NbF8oIhJXltGEKI7ctrZg+v4SLw++FDQ2xlw6pvxmSJb3oFq0bFdLLYp0kJS4HqPO1
	 arRvd+fhUYeKV8eaVp5Lr49NS/PDH6taereUrUftGvtkEhSJnCW//WXl/WJwdDl4Vq
	 WM3aRVEL2lJrQhsOYktuDQEl0uAKnrjt/VC/56YeNKb0A0NUCV6mQBGg7GllzGkCdw
	 7BwIxnpcigREA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92412CD1294;
	Wed,  3 Apr 2024 11:34:52 +0000 (UTC)
From: Nikita Travkin via B4 Relay <devnull+nikita.trvn.ru@kernel.org>
Subject: [PATCH v2 0/3] gov_power_allocator: Allow binding before cooling
 devices
Date: Wed, 03 Apr 2024 16:31:39 +0500
Message-Id: <20240403-gpa-no-cooling-devs-v2-0-79bdd8439449@trvn.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABs+DWYC/32NQQ6CMBBFr0Jm7Zh2KgqsvIdhQcoAk5iWtNhoS
 O9u5QAu30v++ztEDsIRumqHwEmieFeAThXYZXAzo4yFgRRdlCGN8zqg82i9f4qbceQU0d5aZkN
 NY6iGslwDT/I+qo++8CJx8+FznCT9s/97SaPG2raseCJ1Jb5vIblzeEGfc/4CTDoJDrQAAAA=
To: Lukasz Luba <lukasz.luba@arm.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nikita Travkin <nikitos.tr@gmail.com>, Nikita Travkin <nikita@trvn.ru>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1696; i=nikita@trvn.ru;
 h=from:subject:message-id;
 bh=/cAO8r1QYGwr2S/rVs04YoQy4x022R0HsRlCwXhwDy8=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBmDT7a2ZJ+6h2UyGUMDWmTJw5594rvcAqSVYhhI
 mm25hiSTV+JAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZg0+2gAKCRBDHOzuKBm/
 dS4zEACIvT69tLK+to/i9P4Tafv+2U2+Adq/PdVRoSvU9CCFSgPmtX4pAv6TDgUiCrQ9XpT+Del
 tnr/E9mcN4eONS3zbiWwPwGqffrcbNTj5rBFLymizi3kRx3dM9kIF+SXPu7p7fb4PFNDdkB9OjI
 gZR+WACVbkAIigvjmJsfFMVzku9yXdyAhqzEvKifhBWGQaYlldmK2MZcOti5IydO8TO/BVPJzz5
 iNBsLmUY7gE9DfMaMxROEUQcXVrqgUxk+PRuon6QzAC5t2/iEhEh6jOY2aAl2NYeF7X3qXFQ5++
 F1SOe6f90qgmmxSIduk7lJGf8LEu/SztXbtEAwE8pos8jvBvpyNs7om3lnGl7ers4oGYQi9MMO9
 ZYAZnNHlNY8bYJW7/w8b7X47Hk/l39P73akKE98lgm4eoKPxh6/Z6MysrCce1tBC1jlK4H688KO
 wHNSX0BIoku3sPoiX265pS4oupZkhJTPNfLMwS5WI6nrjMUqN7xcPAMkuLx0uttfsju/v2L79N6
 3LVWrk5+OTIkjZWUMFwsJGKzPQnCJmpR+TBtCuwFVEKmlvAEpPP+cHrnzpKjHAWlKjAz+fSwXfS
 mr5nycga8HXYydB0/4U8v92Lb+oD0FutJ/Nvlife/FNLzY8XqEacbq9kct1eOh7wNC7dDiatWPF
 YAZ1Qf1aUl6VmKg==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Endpoint-Received: by B4 Relay for nikita@trvn.ru/default with
 auth_id=151
X-Original-From: Nikita Travkin <nikita@trvn.ru>
Reply-To: nikita@trvn.ru

Recent changes in IPA made it fail probing if the TZ has no cooling
devices attached on probe or no trip points defined.

This series restores prior behavior to:

- allow IPA to probe before cooling devices have attached;
- allow IPA to probe when the TZ has no passive/active trip points.

I've noticed that all thermal zones fail probing with -EINVAL on my
sc7180 based Acer Aspire 1 since 6.8. This series allows me to bring
them back.

Additionally there is a commit that supresses the "sustainable_power
will be estimated" warning on TZ that have no trip points (and thus IPA
will not be able to do anything for them anyway). This allowed me to
notice that some of the TZ with cooling_devices on my platform actually
lack the sustainable_power value.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
Changes in v2:
- Split to two changes (Lukasz)
- Return 0 in allocate_actors_buffer() instead of suppressing -EINVAL
  (Lukasz)
- Add a change to supress "sustainable_power will be estimated" warning
  on "empty" TZ
- Link to v1: https://lore.kernel.org/r/20240321-gpa-no-cooling-devs-v1-1-5c9e0ef2062e@trvn.ru

---
Nikita Travkin (3):
      thermal: gov_power_allocator: Allow binding without cooling devices
      thermal: gov_power_allocator: Allow binding without trip points
      thermal: gov_power_allocator: Suppress sustainable_power warning without trip_points

 drivers/thermal/gov_power_allocator.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)
---
base-commit: 727900b675b749c40ba1f6669c7ae5eb7eb8e837
change-id: 20240321-gpa-no-cooling-devs-c79ee3288325

Best regards,
-- 
Nikita Travkin <nikita@trvn.ru>



