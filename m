Return-Path: <linux-kernel+bounces-5748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1731B818F05
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAF071F29218
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E69240C00;
	Tue, 19 Dec 2023 17:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PhC7AOMb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D2D4B5A1;
	Tue, 19 Dec 2023 17:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJGucNb031777;
	Tue, 19 Dec 2023 17:52:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Ate2nQXbafi7WMu36jIrSAMLBThAwZVJ7XxcLPp9YLg=;
 b=PhC7AOMbFo0UFXB0jgULWba/ju+jRIfjUwTvmZAGm5tLFOQjIMdOo7zZxhi/P75p7x8y
 ai4wQUd57AJpUuTobyBoatPKN9Pw716pcNOCBareM5gFEIQn2iJtbqCFpgZ7tyac+st/
 d2ae+ZcBPmN4NAtiCpaGXuX6yqatMzQ/9E6RyzAWDv7jJG+PGUAARJEdAhFmS1l0ri82
 cKwV7SzmyeUOq50eU5lFzMTPu9tFh77hnVyIzkE4bFGESF7950oV90fVtl4u1N3MCfCJ
 OoURWtW17r3cPH5Gof0fUCbEv7wk3FSiDnpUW8T4LTvIEs5TBCy36VLKth9djbwkSKYg bw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v3d5u5185-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 17:52:23 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BJGuggB032360;
	Tue, 19 Dec 2023 17:52:23 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v3d5u517r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 17:52:23 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJFm1bD010900;
	Tue, 19 Dec 2023 17:52:22 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3v1q7nheg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 17:52:21 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BJHqJ1n15991452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 17:52:20 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAA1D2004B;
	Tue, 19 Dec 2023 17:52:19 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2EDE320043;
	Tue, 19 Dec 2023 17:52:18 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.61.138.145])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Dec 2023 17:52:17 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-unionfs@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>
Subject: [PATCH v2 3/3] overlay: disable EVM
Date: Tue, 19 Dec 2023 12:52:06 -0500
Message-Id: <20231219175206.12342-4-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231219175206.12342-1-zohar@linux.ibm.com>
References: <20231219175206.12342-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: l6owamPJ2tsk1ibyGUYFdROvgtzvvV6p
X-Proofpoint-ORIG-GUID: aFUWRoiknWYYO-D-vDItShJhEj4KhB1X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-19_10,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxlogscore=631 clxscore=1015
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312190133

Until a complete solution is developed, update 'sb->s_iflags' to
disable EVM.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 fs/overlayfs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index a0967bb25003..e3d9c6c80a47 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1454,6 +1454,7 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 	 * lead to unexpected results.
 	 */
 	sb->s_iflags |= SB_I_NOUMASK;
+	sb->s_iflags |= SB_I_EVM_UNSUPPORTED;
 
 	err = -ENOMEM;
 	root_dentry = ovl_get_root(sb, ctx->upper.dentry, oe);
-- 
2.39.3


