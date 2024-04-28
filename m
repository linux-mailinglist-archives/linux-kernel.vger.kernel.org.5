Return-Path: <linux-kernel+bounces-161552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2168B4DA1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 21:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 702E21C206A6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 19:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C774E745C3;
	Sun, 28 Apr 2024 19:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bluemarch.art header.i=@bluemarch.art header.b="W00eijjg"
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9050079EA
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 19:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714332417; cv=none; b=S5lbcbTVf/Q8eZ71xMifipceeX2cRvFWLEmZmh8VBl2ViSGS9HXCih72FVsbAf8t86GksvH6UQReLf7SkN/NRh3O5mGLKqjclMfBc1VPzyqpQUfYQanSGbQQBU7LGAYCp6b+3p+qD0ZNL5f7lSQl8CdSB2+Q1h9n/vHyOuSRwkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714332417; c=relaxed/simple;
	bh=7SeU37LkQUjBnW0vKM/OHdQSjwL1fMqh2Dr0tLsHXyE=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=G+8OYfaMoyhIUtQpGWfznb8hAep2D8P6y6Uy1vA0eU/QzRbcbslyTgXj1zGyKj7JxVdoixg4L+9p1iGf2qNbqdIeysTYt5XSNcZwSvs2LrSzDHI+GTpw+CWAG7hzQxR9Ii8aS5r8iFIeRo6lRv1vYOb/4hkA1xayqdPJPFagcs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bluemarch.art; spf=pass smtp.mailfrom=bluemarch.art; dkim=pass (2048-bit key) header.d=bluemarch.art header.i=@bluemarch.art header.b=W00eijjg; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bluemarch.art
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bluemarch.art
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bluemarch.art;
	s=protonmail2; t=1714332400; x=1714591600;
	bh=7SeU37LkQUjBnW0vKM/OHdQSjwL1fMqh2Dr0tLsHXyE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=W00eijjgfJQAt30WGglrJnav/ZykdRkD2O3Uy34DsavAvLMSnYqhVnDjMcvHex67U
	 hihmxA85t8dwNUIpJHX/+/LoHBOtmtvtAxMRN6hylxYGy/FYtTDpkPcvJx1+CV5jiU
	 ifIbYNC0eyFewVrB7THZNOH5QW4uwAgslcK2orVPnLYUEpgoyp6aLu5kmK6rzh4Flw
	 hfoQFYNnv0cVZg6WyQM+28i2DteWtQKJhASRU1stQPdfkNBs86nbdBE7V/lceHBKmP
	 di6hSovs+8YKAQ+TmAzOcZL5ieeG7TCjM7f68ZDDOFp2ncYS/JCVd0rR6Sfmjxcvvs
	 RNkngUjEKoChw==
Date: Sun, 28 Apr 2024 19:26:33 +0000
To: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, jwoithe@just42.net, hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com
From: Szilard Fabian <szfabian@bluemarch.art>
Cc: Szilard Fabian <szfabian@bluemarch.art>
Subject: [PATCH] platform/x86/fujitsu-laptop: Replace sprintf() with sysfs_emit()
Message-ID: <20240428192548.113261-1-szfabian@bluemarch.art>
Feedback-ID: 87830438:user:proton
X-Pm-Message-ID: 91986108e2b793fc817e8c7a9acf033c4c9c77e6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

As suggested by Documentation/filesystems/sysfs.rst sysfs_emit() should be
used when formatting the value to be returned to user space.

Signed-off-by: Szilard Fabian <szfabian@bluemarch.art>
---
 drivers/platform/x86/fujitsu-laptop.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/f=
ujitsu-laptop.c
index 94480af49467..968fc91bd5e4 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -386,11 +386,11 @@ static ssize_t lid_show(struct device *dev, struct de=
vice_attribute *attr,
 =09struct fujitsu_laptop *priv =3D dev_get_drvdata(dev);
=20
 =09if (!(priv->flags_supported & FLAG_LID))
-=09=09return sprintf(buf, "unknown\n");
+=09=09return sysfs_emit(buf, "unknown\n");
 =09if (priv->flags_state & FLAG_LID)
-=09=09return sprintf(buf, "open\n");
+=09=09return sysfs_emit(buf, "open\n");
 =09else
-=09=09return sprintf(buf, "closed\n");
+=09=09return sysfs_emit(buf, "closed\n");
 }
=20
 static ssize_t dock_show(struct device *dev, struct device_attribute *attr=
,
@@ -399,11 +399,11 @@ static ssize_t dock_show(struct device *dev, struct d=
evice_attribute *attr,
 =09struct fujitsu_laptop *priv =3D dev_get_drvdata(dev);
=20
 =09if (!(priv->flags_supported & FLAG_DOCK))
-=09=09return sprintf(buf, "unknown\n");
+=09=09return sysfs_emit(buf, "unknown\n");
 =09if (priv->flags_state & FLAG_DOCK)
-=09=09return sprintf(buf, "docked\n");
+=09=09return sysfs_emit(buf, "docked\n");
 =09else
-=09=09return sprintf(buf, "undocked\n");
+=09=09return sysfs_emit(buf, "undocked\n");
 }
=20
 static ssize_t radios_show(struct device *dev, struct device_attribute *at=
tr,
@@ -412,11 +412,11 @@ static ssize_t radios_show(struct device *dev, struct=
 device_attribute *attr,
 =09struct fujitsu_laptop *priv =3D dev_get_drvdata(dev);
=20
 =09if (!(priv->flags_supported & FLAG_RFKILL))
-=09=09return sprintf(buf, "unknown\n");
+=09=09return sysfs_emit(buf, "unknown\n");
 =09if (priv->flags_state & FLAG_RFKILL)
-=09=09return sprintf(buf, "on\n");
+=09=09return sysfs_emit(buf, "on\n");
 =09else
-=09=09return sprintf(buf, "killed\n");
+=09=09return sysfs_emit(buf, "killed\n");
 }
=20
 static DEVICE_ATTR_RO(lid);
--=20
2.44.0



