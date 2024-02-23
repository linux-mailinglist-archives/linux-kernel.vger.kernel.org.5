Return-Path: <linux-kernel+bounces-78743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9277D86182C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D4E0B2522B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9067212BE98;
	Fri, 23 Feb 2024 16:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="tPjW3FS2"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A738012880E;
	Fri, 23 Feb 2024 16:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708706359; cv=none; b=CZF5h5jSHR4YJC5YDqrICiRXIRww6PKjvfNtvNLODN0NjTfRICUbOS7we148/Fi5iVY3hUauEdjB9LVN7HZ58jrz6LgC0usFLGuG2S/9PcQgvJSgKERMYPC14C+QZwvvO2toDc5BjLI7+jjbyhpsG5idlo81Fg1dvuumLCHMGGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708706359; c=relaxed/simple;
	bh=sB+n4etd/gtVhOjMb5MrARpzVq6Ad9vcYeHKS2dl2jE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TN0jIjS/Le1Kn0nGz+iGTclQdMreltVdtP8slh2pbgqyNADryfVgbgD+jaS+ptZohsEtT5aEpBPcnfnTaXdhoEC6INwhsjZnP5Efbhge/xt7XfzfyRun+0CgTA6549bUyjN54QnoWiNVghuPjMfTKohgBnAcfNrWI76ntxkRYao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=tPjW3FS2; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708706346; x=1709311146; i=w_armin@gmx.de;
	bh=sB+n4etd/gtVhOjMb5MrARpzVq6Ad9vcYeHKS2dl2jE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=tPjW3FS2Wcx0FFaNwOzqZaUlciLQ8HKYlR40JUHn7ffwlWRmrqMUnhN+M3rqLRwY
	 LjnDJ/E7pjN073KYIA/QxjKrxmemB2sre9FzMjg8AsnntsAaGeKwDyITtikr5EfzJ
	 tIM2ltHVw+frZ9dRHBR6NjkJEafcCNxJgrrUqOj9A8eqnl+luTRV2Ns2ITmtjJuza
	 1r0ZgfPzmpeVj3Gcah9+tltPplw2wJlfAMM6m+5IgqASUx1eUv7RRnylNM4U6O+V0
	 xjkhXMmsLAKTKRCOg4RihBLnSx7s04xP1dOLN0Ng+fqpe64UcKaMOEd71zFcCdJCQ
	 YhEnVV61ZLYXE95Mfg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MiJVG-1r1UXU00RC-00fSdt; Fri, 23 Feb 2024 17:39:06 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: Shyam-sundar.S-k@amd.com,
	mika.westerberg@linux.intel.com
Cc: sathyanarayanan.kuppuswamy@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] platform/x86/amd/pmf: Do not use readl() for policy buffer access
Date: Fri, 23 Feb 2024 17:39:00 +0100
Message-Id: <20240223163901.13504-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240223163901.13504-1-W_Armin@gmx.de>
References: <20240223163901.13504-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xJrTW73+XmPgXT0JmOHX3IY9eRW5w4Hf+pwHGtsT1qCACiR8frN
 gTPS+G+Ay6bbBk3+zTVHcg1MOaS3Ns6RNlUb/ZJV4onO1PXadopumSXTDueKSMNo4Yiun1S
 Vmzq1jqKjnxjCk+3UrdI4A04HvEpsibH/dJY4GiFdCwwlhxUnb+z2bSlymEbsJQZqMoD4Xd
 IjulV72aNEjn8Z6RrmqQw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MzZBuO2b4+E=;mfb/AwrUHrNDFLCyDSqO9D2HeKk
 OkAkJEtvZjiRdsq86qFYfJIIgjMXG8rx3zuQ5KNISyIngYtgG1m2KPV1jdeMrMxrBmNFHDg99
 DhAbXCI7EnW8t4uc3erciDda0hY0J891f7mWFzRODgJUatqC6s0CoMt+/vOlqQLnQxSHoDgKh
 cgcos0fy4JdS/ysooV7gSONuLTvDJ6rvm4RMTKitKLgzsPINDrHytVsT2K3oy5Is+yGBlchiw
 lkDQwIMFUbt++Hu4bgyr1eowr6/FI6FUjja8CS6PYjs7Trh3jaTNZ7EV5IfV4mEHlGEGY5hCe
 AK/thW8PEUIpgdR05hmFejvPhd/mrWy4SkD2evwJvUe5+Uglnjzp+HeKht1B0MjsNB6eaUcz6
 Huo91B6WHoQ8OVoez8ldTkusElZ3kNrbH/XSzbRLv4W5AcOpV/7QmGvckKt/5PzX3hyo2FI4t
 DFcm+xDBI7F1VO10Z2lpe5pRN1/++JubrnYqj6BfN6Tm+JCSogK5ZrmUOmMwwFDLADhcdYQ+F
 x+najwzwNqQHv9wgKKNA0hsX7oGbPL2tBlnYFsqhW6cgtrZe8pcwbxeJZnJx2oDWX6GCHvGvc
 YYBmNRoP0qqieuLqz0u1VmJqtC2nFMWY0bJXQn3+setmcI+CN+eJ6r+wyJkAmjBR482suxXG1
 k7Vxfus1HiIbMMo8n3qJU3fBhn4JjowcCPVP3zjOas8B/MqDxXtwNEmOU9Pl2Y9D7p5tKeQus
 uWViZwi+7vQiIo/uOcPIrYwzI/SSBP8KjBaZoxvmmhJzANF7ISNy3947jLAOM1F5qrSltm93G
 sG30GtBUKZ2z6jVL9/XpNAhyO4rz1eLKsIlVrQq+4EuxU=

The policy buffer is allocated using normal memory allocation
functions, so readl() should not be used on it.

Use get_unaligned_le32() instead.

Compile-tested only.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/amd/pmf/tee-if.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/=
amd/pmf/tee-if.c
index 16973bebf55f..3220b6580270 100644
=2D-- a/drivers/platform/x86/amd/pmf/tee-if.c
+++ b/drivers/platform/x86/amd/pmf/tee-if.c
@@ -11,6 +11,7 @@
 #include <linux/debugfs.h>
 #include <linux/tee_drv.h>
 #include <linux/uuid.h>
+#include <asm/unaligned.h>
 #include "pmf.h"

 #define MAX_TEE_PARAM	4
@@ -249,8 +250,8 @@ static int amd_pmf_start_policy_engine(struct amd_pmf_=
dev *dev)
 	u32 cookie, length;
 	int res;

-	cookie =3D readl(dev->policy_buf + POLICY_COOKIE_OFFSET);
-	length =3D readl(dev->policy_buf + POLICY_COOKIE_LEN);
+	cookie =3D get_unaligned_le32(dev->policy_buf + POLICY_COOKIE_OFFSET);
+	length =3D get_unaligned_le32(dev->policy_buf + POLICY_COOKIE_LEN);

 	if (cookie !=3D POLICY_SIGN_COOKIE || !length)
 		return -EINVAL;
=2D-
2.39.2


