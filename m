Return-Path: <linux-kernel+bounces-108217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAE388079B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50BB81C22A6C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE045F860;
	Tue, 19 Mar 2024 22:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bdXBL9s0"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493753FBB1;
	Tue, 19 Mar 2024 22:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710888921; cv=none; b=dUnvyl+dB1MT6DGmldFEVF3rZwrm+JiXtJdcdaBBhhE0zuttS6l3oimtBR0vkQKVCwlpKjBjo29NNWCtR27urNXjS53NAB5PA5jZTRgNgtnLI37jx9j4QYP8juxXa8xJP4l6rZJ35PV3d4QosClQeK+DGaQLSu74nSXvOkqd/z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710888921; c=relaxed/simple;
	bh=fLjxN0Sk5KrBVRj/F43291DNmPrPvvUPq+zN5q/P3rA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=lBQCEbP3BfM9ZcBDgEYvbmOnw3vbBAzg130Lre0OVr94lTIkvuIC9cq2c13X9T0xsslVvJ+gz7p4Es1R/okQJXm9zfWSyLGJvLNj5ssrsKqyA9ZITFKb0MUazGK3K8Yd0pZvGcSB89ZpzkcoBsXy2r+37usX4WgbBZJ9CAtQWmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bdXBL9s0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JMk5on029729;
	Tue, 19 Mar 2024 22:55:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=xEWRN1kQtdflhyrl2Pxa7AJCVUu9MrlZm0JM8RwO/9o=;
 b=bdXBL9s072ucTw/T756cHbAiv3eHX4VX1bzTqEI/PGp9Ehbyi0QZb2VNMLiaOUqyF53d
 w45hcKopSlSpaQPhsENGAAn7Rcuj/e+JqMOehOOB1OlgWK+7kyVKivfo0FyVm8V0UwpO
 hf/+meSzkh/WYcmVeAKfcVS/TUhvUVtEwpwQo0qwCXB6CJb7b7Xfs9LRbVW04NL2le0f
 dchd9UOlPh8WXcbMt+SbOnyBCvyK6O/KWKjmHX2UunkewiCPk74aUtTVZDqbl8A6eD30
 IAaGfJSN3WCrSPHsHGbE/6lOqbt4dwFF1dRShpV+aAf2tmCIFWD4ZlATNrMpx19o4zeH iw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wyjx0g397-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 22:55:08 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42JMt7iA011599;
	Tue, 19 Mar 2024 22:55:07 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wyjx0g35t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 22:55:07 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42JL1JNs002780;
	Tue, 19 Mar 2024 22:50:43 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwrf2j58e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 22:50:43 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42JMofpc21758708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 22:50:43 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7B1F58068;
	Tue, 19 Mar 2024 22:50:40 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A43A58056;
	Tue, 19 Mar 2024 22:50:40 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.80.83])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Mar 2024 22:50:39 +0000 (GMT)
Message-ID: <9daaa1d12d351bca982b28830354f86f7ef97b6f.camel@linux.ibm.com>
Subject: Re: [PATCH v3 01/10] ima: Rename backing_inode to real_inode
From: Mimi Zohar <zohar@linux.ibm.com>
To: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, roberto.sassu@huawei.com, amir73il@gmail.com,
        brauner@kernel.org, miklos@szeredi.hu
Date: Tue, 19 Mar 2024 18:50:39 -0400
In-Reply-To: <20240223172513.4049959-2-stefanb@linux.ibm.com>
References: <20240223172513.4049959-1-stefanb@linux.ibm.com>
	 <20240223172513.4049959-2-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-23.el8_9) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jvYkY3ss7LvP5Zm-XbPVGn_4UYQFYrFN
X-Proofpoint-GUID: cqs4CkSCMlhN4GqJuCVj4XPxha8djzpE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_09,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=693
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403190176

Hi Stefan,

On Fri, 2024-02-23 at 12:25 -0500, Stefan Berger wrote:
> Rename the backing_inode variable to real_inode since it gets its value
> from real_inode().
> 
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Co-developed-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Acked-by: Amir Goldstein <amir73il@gmail.com>

Thanks for adding me as a co-developer.  The "Co-developed-by" tag needs to be
followed immediately by their "Signed-off-by" tag.  I'll need to move it
immediately before my "Signed-off-by" tag.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

Mimi


