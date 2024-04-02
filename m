Return-Path: <linux-kernel+bounces-128803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C1E895FBF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0E92288777
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25BB374F6;
	Tue,  2 Apr 2024 22:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Zgn2BYNt"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6309C58AA3
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 22:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712097835; cv=none; b=jZyXJYTNKc5oI74VbGx7JmEXgtAmu9r47+EFk7qdmFFjL1KBXGzTJgvus7CkvJcgu1CetG3DKIilqR7pyt+sw4hlhbmeLIFHRP3Xm96CJIecJdeBj61tMWqH8M1DKU8riRSeRC3AYFQWrBLIj4ZsbGeQypHoSUv5BNhquR0T5FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712097835; c=relaxed/simple;
	bh=M5g/fcmIVnd03cJua4t7cktQpdvhmTWTKnPw4RyHuwI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJJt9l+9/VZdnrgPDsZIlUsCFrK68o9PyHJ4yOWccJVPHghGiMorHC0lfB2aMzpxj8/u4hb8T4ztiaXj/2GWOfSUiiFHe2fMw3QJO0wDEP1liMoGHrNT+Xn5uGONob/RjX3WTDOiO/wYuIfAua06jfP3+U3oDUoRw+WAVNcBDq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Zgn2BYNt; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1712097826; x=1712357026;
	bh=M5g/fcmIVnd03cJua4t7cktQpdvhmTWTKnPw4RyHuwI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Zgn2BYNtEub2wOHTZ512OSFsjW68aYTqzJJMvtctlN9DvmKOJswdeE/AKPPtCrHft
	 JoEop76LObx7G4aBep/eIHaCWDmIHwcVvisu8YbIb+sMB1zXPP9sgJcPCDYoMZhnPZ
	 uZPWRfJi/0hb8PJe6Mk93PMXzeThkhWFwj43Vq1fYTE38in3CmwDka7C+Vf4YwheLD
	 DavkTtg/ozn5nKf2znzu5jWjwYQGVLF7Mw8lIhqli7eXk+wPY3xUt8rAYnfhacNZ8p
	 NUVHv+WPXlzv1w2waG/gUmFsnnY1wseeRuRzQ+TiXWxQ/SvcwqY0nSTboJpl04+8T7
	 PzMBqQoXKirqQ==
Date: Tue, 02 Apr 2024 22:43:43 +0000
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
From: Nicolas Devos <ndevos-dev@pm.me>
Cc: Nicolas Devos <ndevos-dev@pm.me>
Subject: [PATCH 3/4] gpu/drm: Prefer `unsigned int` over `unsigned`
Message-ID: <20240402224320.12146-4-ndevos-dev@pm.me>
In-Reply-To: <20240402224320.12146-1-ndevos-dev@pm.me>
References: <20240402224320.12146-1-ndevos-dev@pm.me>
Feedback-ID: 76711691:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This commit fixes following checkpatch warning:
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'

Signed-off-by: Nicolas Devos <ndevos-dev@pm.me>
---
 drivers/gpu/drm/drm_connector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connecto=
r.c
index 6d8f0fc905f3..de71805aab2c 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2076,7 +2076,7 @@ int drm_connector_attach_scaling_mode_property(struct=
 drm_connector *connector,
 =09struct drm_device *dev =3D connector->dev;
 =09struct drm_property *scaling_mode_property;
 =09int i;
-=09const unsigned valid_scaling_mode_mask =3D
+=09const unsigned int valid_scaling_mode_mask =3D
 =09=09(1U << ARRAY_SIZE(drm_scaling_mode_enum_list)) - 1;
=20
 =09if (WARN_ON(hweight32(scaling_mode_mask) < 2 ||
--=20
2.42.0



