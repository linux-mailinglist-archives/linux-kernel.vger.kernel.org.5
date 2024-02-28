Return-Path: <linux-kernel+bounces-85176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0E186B1A8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E9D11F29286
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FAA1586E7;
	Wed, 28 Feb 2024 14:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dDkkaWYB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC76E157E9C
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709130174; cv=none; b=QZ+0IMb+yA02Qmw102p4UJhatowgpEz5QsfBszw4GyeXR0BVcMTUqEpCV1NWgUhGMyuzVABBe3c6FLWXnSAgqGbagaIGbLX797vuQ/EBiKMS+8Dlh1lxCrNdlNVMkgX810CzRpgxNxPF4VgvvRksLj6txGWBmg30y8pJI/phTzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709130174; c=relaxed/simple;
	bh=Zyy3vOWbN9CNXIJi3DeG6e23eV6FtWhsMR1FozLh5EA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=LWqm+PMNxxSD+Py8C/UJ3wk2HEIKi0rNPvo5IEOhaDxr94krWcJa/UwzWpXoSz1DlXizYjpPagHWYagU8vnHuSy2b7M7D2Vy4ehTdRdyj3sfnGBZkcS8MccYSGYGQ9LmwT1YIB0Lt4IHqB9JHtICu1WnPUD5Pu/I9RCeYI0KNhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dDkkaWYB; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709130170; x=1740666170;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Zyy3vOWbN9CNXIJi3DeG6e23eV6FtWhsMR1FozLh5EA=;
  b=dDkkaWYB2VkSkNQSfeKh/QPeNVsRyLhjJtKLPepT/IH6kKGldJ0WwabR
   KTUnNpqykXijzynjVql9imPwRVS7WrUTG8HWjNH1EcYFaO/lN+bR4RkOR
   dre8oIp32U9bLfSixqaine0eF6wkc+QN3lZGSywUkt8dJMA8qlTqJEYgo
   9WQ45PQQiLZvgK6spMaZSGEAiEW2QqkHJruCu7NCFGyXDf2SdNzeiSJoI
   Yvi8eDEy5EnLGIWA7TBoJLjAfjS0Mi2MqadFfA1eZRE98dn6ofbOwGDW5
   MjlQpWdx76//k+FVXOeQ7l2kALnLrza0kAgNZAJb0K5jZ3mRhNNejnl3Q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14948591"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="14948591"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 06:22:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="11989525"
Received: from mcox1-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.213.233.55])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 06:22:47 -0800
From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To: Intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH] MAINTAINERS: Update email address for Tvrtko Ursulin
Date: Wed, 28 Feb 2024 14:22:40 +0000
Message-Id: <20240228142240.2539358-1-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

I will lose access to my @.*intel.com e-mail addresses soon so let me
adjust the maintainers entry and update the mailmap too.

While at it consolidate a few other of my old emails to point to the
main one.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 .mailmap    | 5 +++++
 MAINTAINERS | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index b99a238ee3bd..d67e351bce8e 100644
--- a/.mailmap
+++ b/.mailmap
@@ -608,6 +608,11 @@ TripleX Chung <xxx.phy@gmail.com> <triplex@zh-kernel.org>
 TripleX Chung <xxx.phy@gmail.com> <zhongyu@18mail.cn>
 Tsuneo Yoshioka <Tsuneo.Yoshioka@f-secure.com>
 Tudor Ambarus <tudor.ambarus@linaro.org> <tudor.ambarus@microchip.com>
+Tvrtko Ursulin <tursulin@ursulin.net> <tvrtko.ursulin@intel.com>
+Tvrtko Ursulin <tursulin@ursulin.net> <tvrtko.ursulin@linux.intel.com>
+Tvrtko Ursulin <tursulin@ursulin.net> <tvrtko.ursulin@sophos.com>
+Tvrtko Ursulin <tursulin@ursulin.net> <tvrtko.ursulin@onelan.co.uk>
+Tvrtko Ursulin <tursulin@ursulin.net> <tvrtko@ursulin.net>
 Tycho Andersen <tycho@tycho.pizza> <tycho@tycho.ws>
 Tzung-Bi Shih <tzungbi@kernel.org> <tzungbi@google.com>
 Uwe Kleine-König <ukleinek@informatik.uni-freiburg.de>
diff --git a/MAINTAINERS b/MAINTAINERS
index 19f6f8014f94..b940bfe2a692 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10734,7 +10734,7 @@ INTEL DRM I915 DRIVER (Meteor Lake, DG2 and older excluding Poulsbo, Moorestown
 M:	Jani Nikula <jani.nikula@linux.intel.com>
 M:	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
 M:	Rodrigo Vivi <rodrigo.vivi@intel.com>
-M:	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
+M:	Tvrtko Ursulin <tursulin@ursulin.net>
 L:	intel-gfx@lists.freedesktop.org
 S:	Supported
 W:	https://drm.pages.freedesktop.org/intel-docs/
-- 
2.40.1


