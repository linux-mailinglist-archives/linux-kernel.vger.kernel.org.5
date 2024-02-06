Return-Path: <linux-kernel+bounces-55333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1FC84BB4B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6309B1F26E9D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739C8523C;
	Tue,  6 Feb 2024 16:45:57 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E20217C8
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 16:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707237957; cv=none; b=deL2h3vWfps+jb/CY86Kid8iwe106UVsVcv41xZvCZVJ2eJNqeMRX3qdH5CYJnGdSgAjzqmvxRI2g9ZfpxorJ9UNMRHjeqSkPDqXJxK6/rJj1RhL88EI9gLKb5UiLzKP4dwfZuSbyhqSSmEihVqVWFptNFFwTL8wPLJeAK2NRyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707237957; c=relaxed/simple;
	bh=TR+lH7ISxKIARyqROnyJyvS+Y3ZOyzG8fwAigwII1l0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uvZlPqJEsCllGz8C0eRA/wkcwQ0OIMt4DYDHJSQLoDZhTxZ2kmhib5VEc7zEHGtbvVHVX/TqeQ9IjIVL9VdwWemvlzggzkMj5zxS1Eoem8btZ3ruKmNTEK/SWiniETS2VkQ346iJNceY4XOcr2v3KvJ9tDBwZB83Wy/2CqvXIJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 6 Feb
 2024 19:45:48 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 6 Feb 2024
 19:45:48 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Jani Nikula <jani.nikula@linux.intel.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Joonas Lahtinen
	<joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	<intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] drm/i915/gt: Prevent possible NULL dereference in __caps_show()
Date: Tue, 6 Feb 2024 08:45:43 -0800
Message-ID: <20240206164543.46834-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

After falling through the switch statement to default case 'repr' is
initialized with NULL, which will lead to incorrect dereference of
'!repr[n]' in the following loop.

Fix it with the help of an additional check for NULL.

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: 4ec76dbeb62b ("drm/i915/gt: Expose engine properties via sysfs")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
P.S. The NULL-deref problem might be dealt with this way but I am
not certain that the rest of the __caps_show() behaviour remains
correct if we end up in default case. For instance, as far as I
can tell, buf might turn out to be w/o '\0'. I could use some
direction if this has to be addressed as well.

 drivers/gpu/drm/i915/gt/sysfs_engines.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/sysfs_engines.c b/drivers/gpu/drm/i915/gt/sysfs_engines.c
index 021f51d9b456..6b130b732867 100644
--- a/drivers/gpu/drm/i915/gt/sysfs_engines.c
+++ b/drivers/gpu/drm/i915/gt/sysfs_engines.c
@@ -105,7 +105,7 @@ __caps_show(struct intel_engine_cs *engine,
 
 	len = 0;
 	for_each_set_bit(n, &caps, show_unknown ? BITS_PER_LONG : count) {
-		if (n >= count || !repr[n]) {
+		if (n >= count || !repr || !repr[n]) {
 			if (GEM_WARN_ON(show_unknown))
 				len += sysfs_emit_at(buf, len, "[%x] ", n);
 		} else {
-- 
2.25.1


