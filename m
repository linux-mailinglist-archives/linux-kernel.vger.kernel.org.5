Return-Path: <linux-kernel+bounces-153602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BE68AD03E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 632161C22021
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44620152DED;
	Mon, 22 Apr 2024 15:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DBu4hbOs"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941261474B9;
	Mon, 22 Apr 2024 15:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713798442; cv=none; b=iCgyuyNHm9bTCPiZou54OsLlf12WBSyaBBPJgZVdt5El58lQ7nHDTLWhJcX2c8SLFSs+9BXhcwoI2d88W1QW9LLoSe2IeFtxD4t9W8DCV6zOrU/tvYpIwAubTzQULNKWCVVfz/whFY9Cw10I9+fLbHjGFYNM3tQrOgSiF5MP054=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713798442; c=relaxed/simple;
	bh=OwBTM38wR2q83NXNwr0WZqVclcVxAfrXdY/laVtugxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oh429OtPT9OYA/tVm5hnlOkbQ7bAq5UrENa7LpUE8ubNzVbLcDWSvJMwh3DE8rnWOasBn5+dlIQGbhekSv6LnLNOhZMePZUFvJH2HmZQ//TiXm8qVD7kIZwLe82VfePqDDiIjddH0oKKRDWGnyqy4mF8sO5JVNp+XnMVF+vs/7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DBu4hbOs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43MEnfqJ031250;
	Mon, 22 Apr 2024 15:07:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=X/qZpknkXE3GmCsg7Uudnu3Lok0kBSYi8OLJ1TnoCRE=;
 b=DBu4hbOsuSInpXU5lJUbIMaL861LBWfosxc6+TtL2clnP3T4/GPYec2EdJvcyx/aJpzd
 tiigYfRnhekq4Q48DYOK1v6d79BdOP3tdd3bX4shSjMWCxs/4SlJlpks5ZBNDEFk2Gbj
 J9y0mtu/KlznbBxl9eucSL0m3e9qDXbA3zLTZhnJEVqj4j00lFkX0KQXu6gcxRYjGduM
 SKVEmHUEib3EXOWRtU3HqW4E99kXFU8gF7aAQvstIzMBGdlWaJN635CXbxggyAKHjIwu
 WRLwi+ccYoQuiS+fOUmNfFs70iZMjkKVhD6JfefS3NRfWroUiWCKbM7Hia44HcGsQxiC 6w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xnsyx81j8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 15:07:03 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43MF73Qg030610;
	Mon, 22 Apr 2024 15:07:03 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xnsyx81j5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 15:07:03 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43MEk6Vj005341;
	Mon, 22 Apr 2024 15:07:02 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xmx3c732k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 15:07:02 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43MF6xbU25035364
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 15:07:01 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6151E58063;
	Mon, 22 Apr 2024 15:06:59 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EAD958053;
	Mon, 22 Apr 2024 15:06:58 +0000 (GMT)
Received: from sbct-3.bos2.lab (unknown [9.47.158.153])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Apr 2024 15:06:58 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        roberto.sassu@huawei.com, amir73il@gmail.com, miklos@szeredi.hu,
        brauner@kernel.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: [RFC PATCH v2 0/2] ima: Fix detection of read/write violations on stacked filesystems
Date: Mon, 22 Apr 2024 11:06:49 -0400
Message-ID: <20240422150651.2908169-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YpzgEsrKWbOGmi1SxPnRCSSENnl8QvoO
X-Proofpoint-GUID: JzYrXdFfo49JUJD0CxIcfkUo230NyBie
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=561 impostorscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404220065

This series fixes the detection of read/write violations on stacked
filesystems. To be able to access the relevant dentries necessary to
detect files opened for writing on a stacked filesystem a new d_real_type
D_REAL_FILEDATA is introduced that allows callers to access all relevant
files involved in a stacked filesystem while traversing the layers.

  Stefan

v2:
 - Simplified 2nd patch
 - Improvements on patch description on 1st patch

Stefan Berger (2):
  ovl: Define D_REAL_FILEDATA for d_real to return dentry with data
  ima: Fix detection of read/write violations on stacked filesystems

 fs/overlayfs/super.c              |  6 ++++++
 include/linux/dcache.h            |  1 +
 security/integrity/ima/ima_main.c | 21 ++++++++++++++++-----
 3 files changed, 23 insertions(+), 5 deletions(-)

-- 
2.43.0


