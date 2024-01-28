Return-Path: <linux-kernel+bounces-41961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C4083FA0F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 22:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 789631C21864
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8EC3C46D;
	Sun, 28 Jan 2024 21:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ra+nySSU"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147DF3C063
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 21:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706477136; cv=none; b=SJ8J8wU/RhgYVn9+GTSWqyr3T4TDTopwjjV1B9MpAxLLkYbKSgTezafF4fRpW1Cc8M11/sFhNDEin1MBMiYtcGJogG/BtO8I1F3B/ffXZF2Cm/lrmn24sQG2/qGkLwR7azOSC7U7qogz9LgLTZncsDigPP7cOoN0DomVoSPZHsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706477136; c=relaxed/simple;
	bh=ZBPha3pKeVcVB/4t5Yz6dkK0HjSA9BidgZ8H/39mJCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sQRtoO5dEXqNUKRrsu0nz3KttpvLXjWo7lOdan6a5af+76pnVJtRBB5Ykki6GkKSbOunhh7Eeq8b86t1SqPNSmsin5oN4ksPQkip+QuHBMi3lmoZMsxA3765drnKjRYr9AzBKV5PTSxsemG3gUVpv99KZvdKU8LL0tcgacGJ/fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ra+nySSU; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=esUOLqZ9eTPDph2l8qLm7kLjWJiyKC5ICzbRuvIVRhc=; b=ra+nySSUbn1Pfe9kXhEH4eKNE3
	fU+ed5m11My9oo4y+NJdmHgU3JN+K0ojaZ26BFeLEhClKHscK4sGpY9CoD/E8TpjewV0PWNuA1lVl
	ka2SaR3gq4rbRSABh4ZFdK5aPrUlrANkxBplof2tXfAJ+wDFHPpvRl435rdWkI9ag+kbjsq5V2UEm
	E9fQPObmSSv2giS1pWeAk3+hbg3GfothPZoZ51T937B1D/1lZo8lQnbx6NcZ8ye5gJASG57IWtsAH
	6MBLB9U12tkV0d2qHGwldPaGs49TcWMiqr1t8+bHLX0z55rCMXyIgKWRzfvaKZdQawGbK4EKD94N4
	JpY5SzIQ==;
Received: from 201-42-129-61.dsl.telesp.net.br ([201.42.129.61] helo=steammachine.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rUCeg-00B1M8-Kh; Sun, 28 Jan 2024 22:25:31 +0100
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: kernel-dev@igalia.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Simon Ser <contact@emersion.fr>,
	Pekka Paalanen <ppaalanen@gmail.com>,
	daniel@ffwll.ch,
	Daniel Stone <daniel@fooishbar.org>,
	=?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
	Dave Airlie <airlied@gmail.com>,
	ville.syrjala@linux.intel.com,
	Xaver Hugl <xaver.hugl@gmail.com>,
	Joshua Ashton <joshua@froggi.es>,
	=?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v3 2/3] drm/atomic: Allow userspace to use explicit sync with atomic async flips
Date: Sun, 28 Jan 2024 18:25:14 -0300
Message-ID: <20240128212515.630345-3-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128212515.630345-1-andrealmeid@igalia.com>
References: <20240128212515.630345-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Allow userspace to use explicit synchronization with atomic async flips.
That means that the flip will wait for some hardware fence, and then
will flip as soon as possible (async) in regard of the vblank.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
v3: new patch

 drivers/gpu/drm/drm_atomic_uapi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 6d5b9fec90c7..edae7924ad69 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1060,7 +1060,8 @@ static int drm_atomic_check_plane_changes(struct drm_property *prop,
 	 * change will be either rejected or ignored, so we can stop the check
 	 * here
 	 */
-	if (prop != config->prop_fb_id) {
+	if (prop != config->prop_fb_id &&
+	    prop != config->prop_in_fence_fd) {
 		ret = drm_atomic_plane_get_property(plane, plane_state,
 						    prop, &old_val);
 		return drm_atomic_check_prop_changes(ret, old_val, prop_value, prop);
-- 
2.43.0


