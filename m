Return-Path: <linux-kernel+bounces-91258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC54D870BD6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE91B1C23346
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FD01F5FD;
	Mon,  4 Mar 2024 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="cqVXbVTb"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C19F9EC;
	Mon,  4 Mar 2024 20:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709585429; cv=none; b=V1Ow1OH19aOAsPystCc4GZyqQeRHuhfhTLRMVktCcQdDY3c+WOFpuQbXWDF9z4IuPekFvnvcMQ/z+4Opy+KV6dCqGraEM0SOjwQAicf5QilTjbBJTy5x4qgWEcoX0VuN52yTFNNv6Fy7HJ3vgsCOH4rpApLsWa6JAcTYrbjaGEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709585429; c=relaxed/simple;
	bh=9A/3tQ3Ax2vPmjLAoeCi2nwrMNtSh6cMAuJUN0O5S8A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FsNRw/3gUSWpPCQtVExr/hEJtNgU/sflsvzSqRwKtGwpquWdDsb5GT5m9ZKfQUKnqs87G33uflGfqCfe0poxp+aNLlkkox3kDd9a15LLYUVmOj2hTA+VFa1X8wfHOAoTuna5vOUNCWib5aYFA59at9cRKWNImqIGWqxycyOFr1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=cqVXbVTb; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709585417; x=1710190217; i=w_armin@gmx.de;
	bh=9A/3tQ3Ax2vPmjLAoeCi2nwrMNtSh6cMAuJUN0O5S8A=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=cqVXbVTbMUEhVQnRZz/CxidJAGBk/zVE8GvqWT1GAUZLEFo1hcdAeC+MA8jH+241
	 TLWx3F41zb09Fm/j+Yrohw5RPwAvAxfkn4fbqt47fIoX3oh7tTXJWJIU8vYH3Jmhs
	 n/xCgcr8q/JE/FDIjQVqc22sz7gZGq+K/ECR2KvZZn85dD6E/0LhmKgsggF1T0rwD
	 d0kFqkX+tt2gkOW2xtV7ADwpzvlIYAE33Ncyy78XBawLu9EMQKwjAluLP8W4pAwj6
	 5hbs4wbJe0hFkORzmatTYAluy6Bzv8kUCHptHr1x8e/z3c4vMT/Rb8ASul0h4t7HF
	 JYK2PQpC1ipwS9OQOw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MnakR-1qyWWi32Vp-00jZIv; Mon, 04 Mar 2024 21:50:17 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: Shyam-sundar.S-k@amd.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] platform/x86/amd/pmf: Use struct for cookie header
Date: Mon,  4 Mar 2024 21:50:04 +0100
Message-Id: <20240304205005.10078-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240304205005.10078-1-W_Armin@gmx.de>
References: <20240304205005.10078-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HXVXsZG4+Ru6zHKk1FmaMFHiWz2j6i32QtRu/bYLLIHTaFG0nCj
 6zC09Q9IfOOCl2/6OV2skC+UMHczbK+2tOO94t5la/OicXp4OMDsRJTUUtasruhhKxQ6XPg
 h+tiQLYaZ52j7iI4wNx3cjtYEoWD0ujEUUOOaB/gnJ9GghXzGKXqEqaOTBbvEf2o8n3H5eY
 j9hC9l4D+dN2YGIyW2ZkQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dBkj+g/lS9Y=;zepoQjztOQJPHYlIXBk7+RXbBsk
 5CVpVQaXwP95auqNbIcIoRG/Kl39tahU8LSEENm56btZ4ol+OdGMjkz5/QBmO+/pi2UpEKfQ1
 TdssyNO9lkBk96PxVMjNI9KFs2pGz/wlu0rB/B2R3W7d2qSB0bIF8CO5bvrgFK7z9lz9J6VdP
 2GXjEnIXWTlucUg1WgVRSGcOXJMOzIKNAhrlGmkDiZdwAbPimd85pbNekZ5w8pdh6avLq3ZXt
 HRT7pBsi5IYoBzEg9NbSp36ZEcPs5X1Ddj5SpaIJ1SsckvyrnnCcSs7ikM5BRNXIFFG/yuUEh
 O6vQ/NFkfeHwvDb0IqftcUt4EkCB5/gsRfvIs5yUrtTWFtiELue7OiNrjxwxPokAjrvKemODZ
 PSb/vXJgwZ8E34iHZRdCGG6rPE8wKbQIF8ZrlOUJa4Lfnumlj6VDYsrxlmkqjW5zkZVtBC1B3
 wpZk2gc4n/vY46xXwioOfkgPGxU840nIl0Qs+W3JWpKQNZDiVtTS0hWU4VDhTAL3H+yCZNu6s
 LoCZe0DY07l+uQi0yuw1oMTTMdyomHbsSeC6el3SbuQjbznxGERyPYRbci26t3Tzwj5nsQXh9
 8tpypIOhHC4WPHFdIfOl7+9vABmjtjN5H51JW3qNrD+dyjZpz/t++rDp9q5zIGksdhqJ+P4qQ
 HbSODIdbwRRhMJIes8bkC8DiRyHx/znUzkcLGTrvcZ6XHw4h2C0dECUG1bL/8oRKwbhVGy0El
 dt4DYt8Nra5tJE/AUGfsfZ4SSbQSEQ0CR/WmFMmucor7GUXU+i8fKOBJYW2bD8mIxCHbVGbPv
 49c4Zii3mlV+Zo0+XTDLpoUNIc8lK6d58bVR14y9GTLj8=

The cookie header consists of a sign field and a length field.
Combine both in a single struct to make accesses simpler.

Compile-tested only.

Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/amd/pmf/pmf.h    | 6 +++++-
 drivers/platform/x86/amd/pmf/tee-if.c | 9 ++++-----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/amd/pmf/pmf.h b/drivers/platform/x86/amd=
/pmf/pmf.h
index bcf777a5659a..0c90805dc85b 100644
=2D-- a/drivers/platform/x86/amd/pmf/pmf.h
+++ b/drivers/platform/x86/amd/pmf/pmf.h
@@ -17,7 +17,11 @@
 #define POLICY_BUF_MAX_SZ		0x4b000
 #define POLICY_SIGN_COOKIE		0x31535024
 #define POLICY_COOKIE_OFFSET		0x10
-#define POLICY_COOKIE_LEN		0x14
+
+struct cookie_header {
+	u32 sign;
+	u32 length;
+} __packed;

 /* APMF Functions */
 #define APMF_FUNC_VERIFY_INTERFACE			0
diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/=
amd/pmf/tee-if.c
index 58ec2c9606e1..71ea7eefc211 100644
=2D-- a/drivers/platform/x86/amd/pmf/tee-if.c
+++ b/drivers/platform/x86/amd/pmf/tee-if.c
@@ -246,17 +246,16 @@ static void amd_pmf_invoke_cmd(struct work_struct *w=
ork)

 static int amd_pmf_start_policy_engine(struct amd_pmf_dev *dev)
 {
-	u32 cookie, length;
+	struct cookie_header *header;
 	int res;

-	cookie =3D *(u32 *)(dev->policy_buf + POLICY_COOKIE_OFFSET);
-	length =3D *(u32 *)(dev->policy_buf + POLICY_COOKIE_LEN);
+	header =3D (struct cookie_header *)(dev->policy_buf + POLICY_COOKIE_OFFS=
ET);

-	if (cookie !=3D POLICY_SIGN_COOKIE || !length)
+	if (header->sign !=3D POLICY_SIGN_COOKIE || !header->length)
 		return -EINVAL;

 	/* Update the actual length */
-	dev->policy_sz =3D length + 512;
+	dev->policy_sz =3D header->length + 512;
 	res =3D amd_pmf_invoke_cmd_init(dev);
 	if (res =3D=3D TA_PMF_TYPE_SUCCESS) {
 		/* Now its safe to announce that smart pc is enabled */
=2D-
2.39.2


