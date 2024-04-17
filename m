Return-Path: <linux-kernel+bounces-148208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F188A7F54
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DB431F21FF9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A0A12D74B;
	Wed, 17 Apr 2024 09:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b="MQZ3votM"
Received: from outbound8.mail.transip.nl (outbound8.mail.transip.nl [136.144.136.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0477B5810F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 09:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.136.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713345138; cv=none; b=JPihyy+m2vFYkaxx3zVKdo0nFANfpeIBYQTeep6EFfMjXHaDBbr4/+AE8dO43GrzRjvuADOVvR8Z4W6Jrpy9wHBdIwT3dFUb6wgsiRFDsvjqSZq85JcuR9iKth8uJb4fAFJgrlrUxg8nU0ZGv0i2ARIiE/zZ5ouZueccjivcmIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713345138; c=relaxed/simple;
	bh=VRiVEbHM2P9YEekiNpe1oZU5DPqCzezeEvX2ypwiNS0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fqPKCr21MTrh/aUOW2H6JFCRPMz/9yQPWoStaE1o9LrEhAEi/DmG60mR7wGFXkDZ813oJ2tS+uFz3hYRZMI+cp6osHH9Hw0sN+kMZ7JLBbM05wYbNgM1W5sHbFg+qJ4KOrqTjNqMog+8i2X4N5I/WboFuXC0deFe0JIf8L7NgcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org; spf=pass smtp.mailfrom=herrie.org; dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b=MQZ3votM; arc=none smtp.client-ip=136.144.136.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Received: from submission13.mail.transip.nl (unknown [10.103.8.164])
	by outbound8.mail.transip.nl (Postfix) with ESMTP id 4VKFXp3KBLzY76Kw;
	Wed, 17 Apr 2024 11:12:10 +0200 (CEST)
Received: from [127.0.1.1] (110-31-146-85.ftth.glasoperator.nl [85.146.31.110])
	by submission13.mail.transip.nl (Postfix) with ESMTPA id 4VKFXn1kPlz1y46;
	Wed, 17 Apr 2024 11:12:09 +0200 (CEST)
From: Herman van Hazendonk <github.com@herrie.org>
Date: Wed, 17 Apr 2024 11:12:09 +0200
Subject: [PATCH] component: Support masters with no subcomponents
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240417-component-dummy-v1-1-b0854665c760@herrie.org>
X-B4-Tracking: v=1; b=H4sIAGiSH2YC/x3MQQqAIBBA0avErBPKDKmrRItBp5qFGlpRhHdPW
 r7F/y8kikwJxuqFSBcnDr6grSswG/qVBNtikI1UjWq1MMHtwZM/hD2dewQOiNSj0bJTUKo90sL
 3f5zmnD81B83AYQAAAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Herman van Hazendonk <github.com@herrie.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713345129; l=2091;
 i=github.com@herrie.org; s=20240417; h=from:subject:message-id;
 bh=VRiVEbHM2P9YEekiNpe1oZU5DPqCzezeEvX2ypwiNS0=;
 b=c0KNXUbpABkwqE0nzndSWHDlCfnS599Du8qBSroBZgyHgD5lKAgPTvRx8q4ogEzGkM3ZIiUSq
 KFQdW5ZX/nPBRlNxe8QmBwUxNMKVZDPHbizPXuM6BLIC9HJrS32c8Kw
X-Developer-Key: i=github.com@herrie.org; a=ed25519;
 pk=YYxdq8fb5O9vhkW3n2dCH044FPZZO5718v/du7fRhFw=
X-Scanned-By: ClueGetter at submission13.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1713345129; h=from:subject:to:cc:date:
 mime-version:content-type;
 bh=f5pWlvugPptcvo9q7M8W7i3/NU50UzEPnCDDkAgQDLo=;
 b=MQZ3votMUxsBhd2fMjScAnwdaPULK37fmk1IWCWKXNwn24giQWMUhdYqK3TK+rpaujAy5K
 cEBrltilbvKQ9V+550UVmCx66CJTjtvt3PltyNZrP+wNSzFBhEkCZSzN3g+tWpPVS4bRR2
 y5poJHKPSDDwwN4AFwuLMlCv0VzIerC+Ogj2aqrpWD4C4s+jDu0dx9/i6IDew+mVGmkcG5
 64rDSS6Wl4IlxEzigjkIgL0tItAtCH4GienhAsVPYtkrh3qmGtWQ3o8XhL+fWlvxDMgynv
 W1Bct5bba27OkGj4eJrIeYwV3L8GO1eY+HF0gX/nB4rv6S2aCGTvi0zHOo6iRA==
X-Report-Abuse-To: abuse@transip.nl

This happens in the MSM DRM driver when it is used
without any subcomponents, which is a special corner
case.

If the MDP4 is used with nothing but the LVDS display,
we get this problem that no components are found since
the LVDS is part of the MDP4 itself.

We cannot use a NULL match, so create a dummy match
with no components for this case so the driver will
still probe nicely without adding a secondary
complicated probe() path to the MSM DRM driver.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
---
This happens in the MSM DRM driver when it is used
without any subcomponents, which is a special corner
case.

If the MDP4 is used with nothing but the LVDS display,
we get this problem that no components are found since
the LVDS is part of the MDP4 itself.

We cannot use a NULL match, so create a dummy match
with no components for this case so the driver will
still probe nicely without adding a secondary
complicated probe() path to the MSM DRM driver.
---
 drivers/base/component.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index 741497324d78..bb79e7a77bb0 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -497,6 +497,10 @@ static void free_aggregate_device(struct aggregate_device *adev)
 	kfree(adev);
 }
 
+static struct component_match dummy_match = {
+	.num = 0,
+};
+
 /**
  * component_master_add_with_match - register an aggregate driver
  * @parent: parent device of the aggregate driver
@@ -516,6 +520,9 @@ int component_master_add_with_match(struct device *parent,
 	struct aggregate_device *adev;
 	int ret;
 
+	if (!match)
+		match = &dummy_match;
+
 	/* Reallocate the match array for its true size */
 	ret = component_match_realloc(match, match->num);
 	if (ret)

---
base-commit: 96fca68c4fbf77a8185eb10f7557e23352732ea2
change-id: 20240417-component-dummy-a9aae5ac7234

Best regards,
-- 
Herman van Hazendonk <github.com@herrie.org>


