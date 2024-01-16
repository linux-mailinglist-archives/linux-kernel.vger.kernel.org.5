Return-Path: <linux-kernel+bounces-27675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9691882F3F8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3286D1F24A94
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085CA1CFA7;
	Tue, 16 Jan 2024 18:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e1yQNgZi"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD4B1CD25;
	Tue, 16 Jan 2024 18:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705429092; cv=none; b=UTOh9l36lgXICjrWcbGVKFpd/sTAJucW1t7A/DjdP09a63sF4bk0BydzDouqhG6rK6OLgoJ8h2YbqcdrawLl05d8DA0eB7yuXS/+59wxr1ACgP7AlTJulTWkZxxVJcbknREIpiqbSR0Z8/yOv0nA67Z9DeqPwnPOievcdl9HKh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705429092; c=relaxed/simple;
	bh=D+9yhsbbiU3M8+XaRQAhZHfptq83I3P1xJofsv0BUiM=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:
	 Received:Received:Received:Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:X-TM-AS-GCONF:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:Content-Transfer-Encoding:
	 X-Proofpoint-UnRewURL:MIME-Version:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=jjKxR8y58+zF5YgHPP97LGJOGvcolZw8RJn+gUBHnjRuCkLYrAbfBdbepoB5ZA6iQtmJANvmfWdKk/tr3ig/91XJbPKGL65rdL6n+uQhJHdTwiHm47huUh0GMCxRAHaKeNO/dIDeiNTu09KjHZ2zwhJTgrphT9vl04tYVFoifv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e1yQNgZi; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40GHajnj013956;
	Tue, 16 Jan 2024 18:17:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=aaFBe5zBgPU2Ep6HdcKRRKcDrXSVRkoQTfG6kuOOue8=;
 b=e1yQNgZi2knu+i4J+lf0I9IPs7YCcccNs9kaG7leYmy8z0TVLB8dbI9JPqA8Wx1cty7C
 clrqjMtlXhqa4uKMvJCgx5gaTwpfNrwoUjemEjcH6lMpuvTI3qT/xt7Ig9Ld8+sNeoqg
 wGrA+E11ed123sjzgohuVWEKlQH76dr5QUrR6v4N3ToyvKYhMs4dC5V5qc4ZE9+sziXn
 XHq4Tq06FfHIvtDeDBxOKX9rN60bjicFCElz6/XkcQ70tdH1oVCv2H66qByLCEIkBDxh
 lx6UhfcuRrOr9UYHoQJR6Kw/dq7ILrsQC3uXJhninZEOilxqwDEVcs1WZCyZIDUoNNco wA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vnxbrhfaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 18:17:59 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40GIB8oi005724;
	Tue, 16 Jan 2024 18:17:58 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vnxbrhfab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 18:17:58 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40GGOVZo023364;
	Tue, 16 Jan 2024 18:17:57 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vm6bkg5h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 18:17:57 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40GIHugm22282748
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jan 2024 18:17:56 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B02A058057;
	Tue, 16 Jan 2024 18:17:56 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B37F58059;
	Tue, 16 Jan 2024 18:17:56 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Jan 2024 18:17:56 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ninad Palsule <ninad@linux.ibm.com>, joel@jms.id.au
Subject: [PATCH v2 0/1] Add more compatibility strings to tpm-tis-i2c
Date: Tue, 16 Jan 2024 12:17:53 -0600
Message-Id: <20240116181754.3905754-1-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: c5DCmR4WSTSNRNFjBtc9QCaZ2Rh_InRN
X-Proofpoint-ORIG-GUID: L_XYt_5DC9FNJYzP1i59sreuXKJMWxtj
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_10,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxlogscore=872
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401160144

The new IBM system1 bmc machine uses Nuvoton TPM chip. I had this commit
as part of the device tree for new machine but reviewer suggested send
the driver commit as separate patch. The version 2 includes common
compatibility string for TPM 2.0.

The patchset for IBM system1 bmc machine device tree is as follows:
https://lore.kernel.org/linux-kernel/20231212164004.1683589-1-ninad@linux.ibm.com/

Joel Stanley (1):
  tpm: tis-i2c: Add more compatible strings

 drivers/char/tpm/tpm_tis_i2c.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.39.2


