Return-Path: <linux-kernel+bounces-72359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0825685B269
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 035A41C2156D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B4B58217;
	Tue, 20 Feb 2024 05:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="TrwHiWqO"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FE456B9C;
	Tue, 20 Feb 2024 05:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708407935; cv=none; b=lXop87aWgSfs4LDCCFwi76BUN/F27/CUv9z/ev9dGGq2/yE6cR4JKUuXczyPSnyFpRN5dw7Jm1y2VwFoR6h4NjSbEUdNWKy5w/nzapW7f29wFvo6Mr4XQUR44ndGOLnjAOrNeebWg1FA0NmjpVheDiPAFAP5yUCutdYQWzJb5Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708407935; c=relaxed/simple;
	bh=EOUDer5qk9/zoxzi1igP61wAaiJrJ+Ygu/OKnKKEOVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WDL446HPRX3NHbwAOvphh8SvlnEr56WKJwcDvyqMtI2WprlZsAcbR/KEsRXPuDkgR/FgoegQbl2Vd3QEIVN/kBT8UMI45eGztNGwcxcH4Z1qmKWsdyG3T4JAAEf3Y7yQeFP5GkPRHFUk4N86rHfjpWCUOJn2i35BM6I7f0KuQQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=TrwHiWqO; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708407920; x=1709012720; i=w_armin@gmx.de;
	bh=EOUDer5qk9/zoxzi1igP61wAaiJrJ+Ygu/OKnKKEOVI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=TrwHiWqOqX2cpbBaE+ZAsxJrN/YGkjBLqcGVYKuAn+x13lFKmt/E7v74QpyGFX++
	 x+4iASOJnblW/nWYXSrLKrLHEGuXGlEq3f/r8tRikhUCTndXE4ufWO05Mtj9pHd/5
	 v5dlHWfCDK1aZyNiCf9NICFi8E2cOng0nLI7cZvqnnB5Cp8grLDfAS2oKhGcJiyv5
	 VhEFxxwIdJTKRgyqyJcxXWjsJcsPuXicf4nFGgbbIheleOvcMLUJpEVYU0TblJRWy
	 N9wyLTzxVUzvj0JxsUtvKcbtky2CFy473MuqZL0dKC79+S2XYBngPFoziD9i5Eqlx
	 dNjnoVohUcI/c9cPFQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MOREi-1rHzpu2uMw-00Putm; Tue, 20 Feb 2024 06:45:20 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: Shyam-sundar.S-k@amd.com,
	mika.westerberg@linux.intel.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] platform/x86/amd/pmf: Do not use readl() for policy buffer access
Date: Tue, 20 Feb 2024 06:45:12 +0100
Message-Id: <20240220054513.2832-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240220054513.2832-1-W_Armin@gmx.de>
References: <20240220054513.2832-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SyimU/oU4LVCuHbt58JTQgUNmqeE86uN4FHY9gZeuyC1388IYJf
 F42AV8S3/ztnTnQ3LUomiqNKoGgY30JN4zSZTvq3yvUmKmPARltjba8fJ4s2FDwLjneDnqW
 IkVb/J51EOBlsKE1Jv3BUpQghL08Zrj93S8bb32yrNWQwoo5QGF9OCQzN4yD+u/y2W0iJ50
 6zZtNfUwIg++lWY9RYQjw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9mDdGKpSQWw=;FZUCS8i+sySI+qn939HZXC7F9jt
 XQZ/HXICIrSQYIQpfT4EounJf+Sa/W3Ql0bp4L+s7vUiuSAgmT0Lpt2dHFsulOul3bohA6uln
 t+WPZOLoSTFR8Lu/cJgikCh+OWF2G7K2HFy71sRhYJ/Fb9dC/tBV7DZp7iVGykkqfyPRDHxvK
 2/YWQ/GAMOB1Sx/K9VwGklT+3qyMDJtsxbH3uNX3O+KyxWrnClh7rhymditKgnnIsGYQBxNER
 +LuibJqnhiJQy9z4pgR2/ODmSEZYkJYNXEaccIe3Q7yN0Daz3YxdyUuCZWLNh9ZBwSQ+wACf4
 OSCK9RvJiVmOuDgZdCHd2+gu/1z4kPxP4j1O5+GxUheS4vi1U1kPsB9LE5WgvNypCpE/9QB7S
 K4zvYBwB+LKNNjGaVBHsqNFblgv3OFSBRnRrh3RT8kuK2RXbJbSoGH9xztnws/t3s5r4mut7P
 OrdZQ8jRqCYAH39i6BlT4/5Z+D/MvuBSJkw1V3SiS08SweyEchMbvtubPSM34Cu+uozYE5Apq
 fi9ivaW1ewcueyJ9zv7t/YZnlLnQYjpGY3lisfSYXDfjfJcGT3EQUuZp6ljbYrQqceGIz42BF
 NxUZEVD6pyBjgAQfDdLz/VUzDEH4RBUXSqPTsiwAJUs+IuDFSI9f6r6AyugZLJuNLfsTnJwEO
 Hv36fnd8Ahkt80VPylRCgMue67f16SKLaDfDOyW3DYmX8SfB59731gqBilvNoYA4LuweHxi46
 usNrzRDrTCIva8wSsMk0V/sQ7f+UUl4pNA5jYalmDAc4hHuQAQ4DNN8aUMc7X7I4s4Op48FHg
 1WFAd+ip1tVR2m4fD/xcnqx9Y4xk7/U0sglXU7+k9F0SY=

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


