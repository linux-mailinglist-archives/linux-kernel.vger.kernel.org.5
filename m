Return-Path: <linux-kernel+bounces-63086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308F5852AC0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1EAC28496F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8274B225AC;
	Tue, 13 Feb 2024 08:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="jrgaoN5l"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413752232A
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 08:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707812230; cv=none; b=CcPNFDzvl1KSLEBP3HQDlsDiFMb99QtSxpq0wsSWaqtPL0+POVp3Znk0HKspriW6GR3frGdMXRFYQD9cLznREbPPQ28ptOP7ZLizKCu6c1q3WRymCQXzUUZI9UgFggshRKnyeHhLYcGzQf9G4RDulUlzvGk1O83GZpLMkh/52p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707812230; c=relaxed/simple;
	bh=YsSXyUoBoQT0IwX3NdvoTnvhBuIOfrZ35XLfOOL2+Tw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kUdru8GJ51WAPBjKTZNLLA47mBNFsf2Nlyq5L3RDW4NHPOQOyVsay0kMLAxetuuZQ8BvVedng8iTFFopIVWrM8pjNqzwjkr+4jNknPyzvQCqPk+r7uCVWR7MESDHWaWXcmo+ozoItR6iyd9cPu9LK+jKFuKn4P8zY/Ek1JWYtdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=jrgaoN5l; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-35-128.elisa-laajakaista.fi [91.154.35.128])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7053C13AB;
	Tue, 13 Feb 2024 09:17:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1707812224;
	bh=YsSXyUoBoQT0IwX3NdvoTnvhBuIOfrZ35XLfOOL2+Tw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jrgaoN5lVRxxcFXito+GQZkNpUXZvI0n/DOMbqAkOX0JgbGKs60bfZEFNCIVjA8S8
	 SJ/SVlYeaO2IAqjLTlqGbdazvFFk5EwlJXrPM9kaYHx17yHjQaC/gbAXn/m2MJhw9e
	 ZsimXMe1awPF3DnXYbdVQ6sS7yrcGmW7K7Mt5UHw=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 13 Feb 2024 10:16:36 +0200
Subject: [PATCH 1/2] drm/tidss: Fix initial plane zpos values
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-tidss-fixes-v1-1-d709e8dfa505@ideasonboard.com>
References: <20240213-tidss-fixes-v1-0-d709e8dfa505@ideasonboard.com>
In-Reply-To: <20240213-tidss-fixes-v1-0-d709e8dfa505@ideasonboard.com>
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Sam Ravnborg <sam@ravnborg.org>, Devarsh Thakkar <devarsht@ti.com>, 
 Aradhya Bhatia <a-bhatia1@ti.com>, Francesco Dolcini <francesco@dolcini.it>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2076;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=YsSXyUoBoQT0IwX3NdvoTnvhBuIOfrZ35XLfOOL2+Tw=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBlyyV/yfb/cYWS5pNx0IA84/3kZKinY05RPOM0Z
 c0jEEyZaeiJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZcslfwAKCRD6PaqMvJYe
 9Z3dEACXkwC3bLK5AqM40K1v8IGB7Z01jp9J0lLRqtHAvKMUoRyu0nFcj5knVSOW7Pzh5ZmFanC
 FenJi3nCboq/dMdOU0r1mqeZIOPm/SskViSpWJVRGGdcgAVYvniLqvorP3/dxjhQasCGhqpaykd
 mIis3vc8xc4E7pJUarely91uBOawwVgtRkcGSepEiqEWa7OhUJUIwzIDeOHCnc66t5MeFK89Oqj
 3XeB4cG+sPbZVQn/VIiqmQek41L5QF5PoRaNi+saA6qGHD0JvGsbgwkxyuyh7I2XACIU1eHNdte
 AXa1GgL4fSjQmS4pr95zu5YU/kk/RE0z8jfYUf4OcVWnLWAfZNa4+BW6Ee5eoE+7V61FknkzIJg
 DKH78Zv+cM5JPwtWNFepCEr+tx8J7eNU5AwwpPveO4gLQvgdZkW3P5tXadxzf7nGlbn7O1+uIZY
 BbniXwuNK7j0wgLSmQpwlE/RelgZ8Cg3JMimRl59V6qzYqsUObUHbS5PBKVvlDuvvSqvqCnqamY
 DJWMgbMfveMdRSUh9yon/dWzDTrW+Q/PV6Op1UopN5APuR+jWnV6cIdj8bnfvyaYoOHFBrBQTlV
 SGaBzfohhivQeaGmiqT92jCNuwyW6DIVskGhO8XHq29MhAopUNh3LQatX7YJzE2OJj/8uiRElNh
 crqwdQLTCSDiVuw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

When the driver sets up the zpos property it sets the default zpos value
to the HW id of the plane. That is fine as such, but as on many DSS
versions the driver arranges the DRM planes in a different order than
the HW planes (to keep the non-scalable planes first), this leads to odd
initial zpos values. An example is J721e, where the initial zpos values
for DRM planes are 1, 3, 0, 2.

In theory the userspace should configure the zpos values properly when
using multiple planes, and in that sense the initial zpos values
shouldn't matter, but there's really no reason not to fix this and help
the userspace apps which don't handle zpos perfectly. In particular,
Weston seems to have issues dealing with the planes with the current
default zpos values.

So let's change the zpos values for the DRM planes to 0, 1, 2, 3.

Another option would be to configure the planes marked as primary planes
to zpos 0. On a two display system this would give us plane zpos values
of 0, 0, 1, 2. The end result and behavior would be very similar in this
option, and I'm not aware that this would actually help us in any way.
So, to keep the code simple, I opted for the 0, 1, 2, 3 values.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Fixes: 32a1795f57ee ("drm/tidss: New driver for TI Keystone platform Display SubSystem")
---
 drivers/gpu/drm/tidss/tidss_plane.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tidss/tidss_plane.c b/drivers/gpu/drm/tidss/tidss_plane.c
index e1c0ef0c3894..68fed531f6a7 100644
--- a/drivers/gpu/drm/tidss/tidss_plane.c
+++ b/drivers/gpu/drm/tidss/tidss_plane.c
@@ -213,7 +213,7 @@ struct tidss_plane *tidss_plane_create(struct tidss_device *tidss,
 
 	drm_plane_helper_add(&tplane->plane, &tidss_plane_helper_funcs);
 
-	drm_plane_create_zpos_property(&tplane->plane, hw_plane_id, 0,
+	drm_plane_create_zpos_property(&tplane->plane, tidss->num_planes, 0,
 				       num_planes - 1);
 
 	ret = drm_plane_create_color_properties(&tplane->plane,

-- 
2.34.1


