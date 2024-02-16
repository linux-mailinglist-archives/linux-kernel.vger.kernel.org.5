Return-Path: <linux-kernel+bounces-68127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2AA857644
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57BB5B2488E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC72F1CD37;
	Fri, 16 Feb 2024 06:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNZN1U+W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2C81CD2B
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 06:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708066453; cv=none; b=ON1xXu9zJ62xAqpOqUzaLvQsaFak0kuyeVj+Dx4Z4LYddOf8coOA7hvDFd3PJ4EbJSG02AjfpTDgny0LYttPbuFhpESqLZZzekzJo+xF4LHeET/4TOpwBpHxHw4SsCZljd+RjRYlfb3ijRTZ3bDRDaIG6dGy9ntqL46ZkBKx2mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708066453; c=relaxed/simple;
	bh=TktpFXRJz/ldFZumo7iwlZkQPrtoXAs7MIXqQ9AMx+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GtQqnUaL8epq24qCHq2Ewrq9ZHqzFQ84CPyZI6Y4uH8MAC4TgP1jDn8rwP7H3QZeZLzC3eSaimT4Q/F6YnTmc7k0wI6HM15Yb6suebXrpYwOKTGjyH1IXVCCUxJ+aP6WxpotVEiahoxDlIrlq61LP31N/QWL6kDEQ8Ll4qPF1E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNZN1U+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665B7C43399;
	Fri, 16 Feb 2024 06:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708066453;
	bh=TktpFXRJz/ldFZumo7iwlZkQPrtoXAs7MIXqQ9AMx+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FNZN1U+WIzhHHPi5oj6KocxGGyE+DAW/vy1cSJoV03TW0rpM7j68r9Y0/KAC/GZHL
	 Cc7oh1TJ29x8OBhQwOJt5brlWQ/o6m2uVrxXMyq42QtrwEfReN/C7DWGa1sN5k2A/p
	 weXkEzT8r55DVqJyD9izVzNfObcpkZ6qQSXmxOrM+6HDtO8D+J1FLoo5iG5FY4eBy1
	 kZXa9mlRuLSAwi81J12G2RmwQe5PCi2CCqtJuUYF84b4pewjVi1ahvyTQAZrJehH4U
	 nWqh5wRFZ1ND/RTTd+kXNm8ZpcDC24td26oInNolWGYhN/uupW6kmehBSbWhM+47YW
	 rBX2+8omIIPHw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: jani.nikula@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH 13/21] drm/i915: remove intel_vgpu_opregion::mapped
Date: Fri, 16 Feb 2024 07:53:18 +0100
Message-ID: <20240216065326.6910-14-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240216065326.6910-1-jirislaby@kernel.org>
References: <20240216065326.6910-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intel_vgpu_opregion::mapped is not used since commit 367748066eeb
(drm/i915/gvt: remove enum hypervisor_type). Drop it.

Found by https://github.com/jirislaby/clang-struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org
---
 drivers/gpu/drm/i915/gvt/gvt.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/gvt.h b/drivers/gpu/drm/i915/gvt/gvt.h
index b6fe17f1a16f..8e5d696fc79c 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.h
+++ b/drivers/gpu/drm/i915/gvt/gvt.h
@@ -118,7 +118,6 @@ struct intel_vgpu_irq {
 };
 
 struct intel_vgpu_opregion {
-	bool mapped;
 	void *va;
 	u32 gfn[INTEL_GVT_OPREGION_PAGES];
 };
-- 
2.43.1


