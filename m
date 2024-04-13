Return-Path: <linux-kernel+bounces-143723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBF68A3CA5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 13:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 793C21F21B89
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 11:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF833FB1C;
	Sat, 13 Apr 2024 11:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.li header.i=thomas.kuehne@gmx.li header.b="mZ0IRgfG"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3856F2C9D;
	Sat, 13 Apr 2024 11:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713008290; cv=none; b=JFVODSQtkyJXs2Emv2h3LEGqBDHUKsc8nE2ZigpUIBg7FEqsR5bCYzE5rVt2YbIL4BOxQiLYgsTcNL8eB9fTy4UUZ9+hiiyXMOHxeSbhSdEhY8u1sjWpCs3qdugqDcQ3x1RJWejUqJuOjCx3ZU1qH0iqpsLgqwrpUxBJMAmRD3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713008290; c=relaxed/simple;
	bh=eURnQW+uqGSQ/Y+YT+UOu7F4suXVR0cemcfQqJf1+gM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QAitxl7aDA9JdsEedqbheXZgH8Y9d7lj5navj8LDccSp1/tVw6N0kC5vOGJGGxkWfQvJhjZv2KVa6A1zF5/PxhRZ7S+gRF8vIqW3uYlIMhFM5DEBuhY868D2Q6u5EcUdw1Jn9ttWPprGCJovb0kFA1D3MpK97FW/h6iSIk7XJhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.li; spf=pass smtp.mailfrom=gmx.li; dkim=pass (2048-bit key) header.d=gmx.li header.i=thomas.kuehne@gmx.li header.b=mZ0IRgfG; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.li
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.li;
	s=s31663417; t=1713008281; x=1713613081; i=thomas.kuehne@gmx.li;
	bh=V6CMb3JGrJkWpqnpZmfMM2ApMJs9UEpEUKghePgL/0M=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
	b=mZ0IRgfGQNzCQ2YUklN45m2/RfjtND5e8U8e9tZfCcnOVZDkr8zXxXPeWRsOJ/cq
	 6/ruHaBdeBNVaIU4pKOTVeNZXOjjsN4r//FXPdWjov6Xr2LuM0f9UfJxVu7wVSMWD
	 10wOf/LyDaBMeZSoP3Y+aoZ4indXIy5NGpfLaqrgdsNEMvJgGpme01zPg7EUVdZyG
	 3Uu4HsdTLi5A3L4TqP9RmOrd/HR7CXRPEhMC/C4OzKA48JwkmqIShAhkW0OeBNe/f
	 iDSFHU7At1LNCpY56UXQneAJvUtNJxAQlSGC7zS7AG9WzFG9zcZHuLHOXFTvD6p2n
	 hp9x1N2tUhQ5kArVkg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from black ([2.59.120.154]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MdvmY-1sVU9n2tBG-00b5F0; Sat, 13
 Apr 2024 13:38:01 +0200
Date: Sat, 13 Apr 2024 12:39:17 +0000
From: Thomas Kuehne <thomas.kuehne@gmx.li>
To: jikos@kernel.org, bentiss@kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: hid-debug: add EV_FF and FF_STATUS mappings
Message-ID: <Zhp89Q8k13Uua24f@black>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:yfDYyEJwUb0Xe8wBgiJpFcSD8oAkG8Uz1oUcteWNSAHC7/+5aAq
 wUCXBVP47cF+6sQcn6zyhz+9o/ZOBLgX8MafzDex+mM0P32BUW9qfJ6V9Q5/6Fu9g0Bk/nf
 5R8N3QIjmjyDDOQ8TmyvotTj+KcEuPGiTXmAVg5x2wPffPSgJYRxuKqG/YyzwGJbRjrQQZj
 S9lpwy7mHk2eiekVa1Jmg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:j7jnh2l+7zk=;867nGBU6mLpqOfJlFkCtij2daPk
 MFZr3bZuaxMc3mcxzErtn9TPvdTgSwr82y0+XeYLKRNWdaX8hrU2ke66FPVesIPKN0sH1+pTs
 iFAlxwLPELsp3WU9935pMl31TPCzmEbjsAa09WMkeJtzkXJB+VOvtZ5odpgpsT6+4kBqmCYrG
 cfpR4XGDkdWPiKGkDifIW5lokdM80DTrzedULZtcDHIhXKLWQ/K4ZrR1VwdOQ+g/Vpe6+qhHv
 2j1ctWcVTI+X6H2t9gKe76qQj+5I7qF3lSHpVlSanSJpoM1hrEerfB6hV8AUiaAPQ2EVOYdj1
 SYrA9Pr1rep5tWuhKA8fXqShRTW0loYTO5Vp0LaaNXvZ0sAErpas4tfWBBG0fI+EfwNmRISoC
 s8dsbtD7hdspWTsI5hRO01EUpSInJeuGfIn6hXNN6ssF+SSTsZkw1ignMN48+PqH51T2U3bDf
 722R12iIm8fIvXWVKs9sYfI2je1iUC5A3zZm54X7zEnNY/NVZvLIAHW8TWeFlEptWd6p06Wwr
 XbVJkQf4PX0+yodm+jFsAG0CedjRqx4d6m3MyLin3dKJuW9LWWK8p0yljHr0G9oyEjYqBtRCX
 TXvMKfKiwvgF/+98/n/ElZypZvO8VI0DMTUH1y9nG/Kuyrsyd5v8FOA7ET0+jqHtmkDhVFjva
 A+9C4b2RS8kCpUL7qxjur1iMVw4wOlMZjyQjNSSGWBp1M00LJZLPObYb9mKPDRNnYK3fzSUMP
 wuLp3alFECRcz/YLujt6K3DFB+JFk9ri+TxDYgjugdhydmo6cuMZQvgG6TXUj8QQEj6lSXABN
 5hefdL1d9q8oqC275LTS64Qs+0zQ1oeq+WqnDzeZDg7u4=
Content-Transfer-Encoding: quoted-printable

Currently hid-debug only output question marks for all force
feedback related input mapping making debugging gamepads
with force feedback a challenge.

This adds the necessary mapping information to output
EV_FF and FF_STATUS related information.

Signed-off-by: Thomas Kuehne <thomas.kuehne@gmx.li>
=2D--
 drivers/hid/hid-debug.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index add353a17853..bd9bb235363f 100644
=2D-- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -3572,12 +3572,38 @@ static const char *software[SW_CNT] =3D {
 	[SW_MACHINE_COVER] =3D "MachineCover",
 };

+static const char *force[FF_CNT] =3D {
+	[FF_RUMBLE] =3D "FF_RUMBLE",
+	[FF_PERIODIC] =3D "FF_PERIODIC",
+	[FF_CONSTANT] =3D "FF_CONSTANT",
+	[FF_SPRING] =3D "FF_SPRING",
+	[FF_FRICTION] =3D "FF_FRICTION",
+	[FF_DAMPER] =3D "FF_DAMPER",
+	[FF_INERTIA] =3D "FF_INERTIA",
+	[FF_RAMP] =3D "FF_RAMP",
+	[FF_SQUARE] =3D "FF_SQUARE",
+	[FF_TRIANGLE] =3D "FF_TRIANGLE",
+	[FF_SINE] =3D "FF_SINE",
+	[FF_SAW_UP] =3D "FF_SAW_UP",
+	[FF_SAW_DOWN] =3D "FF_SAW_DOWN",
+	[FF_CUSTOM] =3D "FF_CUSTOM",
+	[FF_GAIN] =3D "FF_GAIN",
+	[FF_AUTOCENTER] =3D "FF_AUTOCENTER",
+	[FF_MAX] =3D "FF_MAX",
+};
+
+static const char *force_status[FF_STATUS_MAX + 1] =3D {
+	[FF_STATUS_STOPPED] =3D "FF_STATUS_STOPPED",
+	[FF_STATUS_PLAYING] =3D "FF_STATUS_PLAYING",
+};
+
 static const char **names[EV_MAX + 1] =3D {
 	[EV_SYN] =3D syncs,			[EV_KEY] =3D keys,
 	[EV_REL] =3D relatives,			[EV_ABS] =3D absolutes,
 	[EV_MSC] =3D misc,			[EV_LED] =3D leds,
 	[EV_SND] =3D sounds,			[EV_REP] =3D repeats,
-	[EV_SW]  =3D software,
+	[EV_SW]  =3D software,			[EV_FF] =3D force,
+	[EV_FF_STATUS] =3D force_status,
 };

 static void hid_resolv_event(__u8 type, __u16 code, struct seq_file *f)

base-commit: 9ed46da14b9b9b2ad4edb3b0c545b6dbe5c00d39
=2D-
2.40.1


