Return-Path: <linux-kernel+bounces-25494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFD082D11E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 16:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB9D91F2174B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 15:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F922581;
	Sun, 14 Jan 2024 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="BtgUzr6P"
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1354A7E
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 15:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id P2D2rpeDvx8edP2D2ruurW; Sun, 14 Jan 2024 16:15:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1705245339;
	bh=gGvgGoM0e1dEjbodoGgiPLnqIqDMOOhcBuBKmJRpc0g=;
	h=From:To:Cc:Subject:Date;
	b=BtgUzr6PiLEDrT5U7hh+Jo3YWfcnNrYPzC3/04dcm9p4EHAa9TcvqKQ27kwu4TTql
	 Ol4tDykXmDjWOXTK6OH3AbkkQ2j/8QVv1zsYOcOntfb3BZQw97Y//wzeWOeSWkVHFT
	 g9KyBM5JsNeU/wMxd/IpUtc0lcYLS0wntGq8wrHXwLu98r+ZdA0M/MIcEjGLk8chV9
	 Uj18E1i+0gWvdYH+lSQ4TB2snhTdGsg9fnsgdmAYm3yyJaUtmTxkCxHEmT2W3Jspja
	 SR3DQdevSDv+pir+9kftCvA/RpF+w6MKEVKOp43eus0qVfRr3qtHZvlDg8K4utfFlE
	 KTdg05vxZI/TQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 14 Jan 2024 16:15:39 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/i915/guc: Remove usage of the deprecated ida_simple_xx() API
Date: Sun, 14 Jan 2024 16:15:34 +0100
Message-ID: <7108c1871c6cb08d403c4fa6534bc7e6de4cb23d.1705245316.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

Note that the upper limit of ida_simple_get() is exclusive, but the one of
ida_alloc_range() is inclusive. So a -1 has been added when needed.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
index a259f1118c5a..73ce21ddf682 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
@@ -2156,11 +2156,10 @@ static int new_guc_id(struct intel_guc *guc, struct intel_context *ce)
 					      order_base_2(ce->parallel.number_children
 							   + 1));
 	else
-		ret = ida_simple_get(&guc->submission_state.guc_ids,
-				     NUMBER_MULTI_LRC_GUC_ID(guc),
-				     guc->submission_state.num_guc_ids,
-				     GFP_KERNEL | __GFP_RETRY_MAYFAIL |
-				     __GFP_NOWARN);
+		ret = ida_alloc_range(&guc->submission_state.guc_ids,
+				      NUMBER_MULTI_LRC_GUC_ID(guc),
+				      guc->submission_state.num_guc_ids - 1,
+				      GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
 	if (unlikely(ret < 0))
 		return ret;
 
@@ -2183,8 +2182,8 @@ static void __release_guc_id(struct intel_guc *guc, struct intel_context *ce)
 							   + 1));
 		} else {
 			--guc->submission_state.guc_ids_in_use;
-			ida_simple_remove(&guc->submission_state.guc_ids,
-					  ce->guc_id.id);
+			ida_free(&guc->submission_state.guc_ids,
+				 ce->guc_id.id);
 		}
 		clr_ctx_id_mapping(guc, ce->guc_id.id);
 		set_context_guc_id_invalid(ce);
-- 
2.43.0


