Return-Path: <linux-kernel+bounces-108213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA1A88078D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C33BB22677
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441C65F870;
	Tue, 19 Mar 2024 22:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jY1wvw3L"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E682753E32;
	Tue, 19 Mar 2024 22:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710888866; cv=none; b=L7RXpiFPgYBNbVniWNk5hsilju9wjApy53dHnnexJU7h2uafQIpXqdhl1eElrHnsNGz6q8KAF587MEedmIGZRB20YtwqaqKeuwFysbrBQWNi3nBDJRMC654mai+VCzhypIP5CfoXZdc50UjfQAQJ+25GPA1nQVvaoIC4EEvdyNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710888866; c=relaxed/simple;
	bh=Zw0wFjaCCBKcsQ3lyAv39YK7/EhhTT/4dEmwP8X6S6c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=i7Jfa9dTtrUPpP3GuDe9y8CWS7rCZ6fIZ9wKFpxO/sHeanAZWeAXnKBz6f1tXvixLJbT3s209XZsz+FVRFD2XMNbLXOTqUPuR5k5LD1sf1w6lHCCBKrNj0GKZkXh2cM/ieB2NGar0jY1j/65nl2iK09xMJMQFlv3cXG6ZP8UlEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jY1wvw3L; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JMb9wE031810;
	Tue, 19 Mar 2024 22:54:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=UPiXAnbTN6L5PI02UmJo2if2jAmAhdesNCVcfgA2zUM=;
 b=jY1wvw3LZBSUlB3Zu4cZQrrZR/SRFbiSyJMOQ2KI4UJ65cetG2q5yNQ8b3pwcOfmR5Zc
 o0OTQCWp1jUWqFhBIJfDa3sEH3HwftOoza6vyLniJ4RwfiU85UHj/sMCStap1s3+Odly
 ur2N5teg1eq/dtKi3LvPvaGhNEgva6bSI3hgpbMjY9BfLiJe7aQqvqYqS89JoQ3HjeG6
 EQveICjPwaq6XDxQT3pCREYVPni1GRKNZecSb1Gu9com42cX4VaaUdANenasWWAm9SVe
 xI6VhH6MPJWtHnsJn+M7Bc7iI8Gq/47ivlm19vQ8C8dXhLCtfLjJIFR+XDbI0nGxuqCN TA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wykner0se-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 22:54:09 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42JMs9a0023630;
	Tue, 19 Mar 2024 22:54:09 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wykner0rg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 22:54:09 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42JKWN7D019843;
	Tue, 19 Mar 2024 22:51:46 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwqykjaw9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 22:51:46 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42JMphMd48366168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 22:51:46 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2DE45805E;
	Tue, 19 Mar 2024 22:51:43 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B71315805B;
	Tue, 19 Mar 2024 22:51:42 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.80.83])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Mar 2024 22:51:42 +0000 (GMT)
Message-ID: <90c306c957d0502332bda154ff60f21206c57a3c.camel@linux.ibm.com>
Subject: Re: [PATCH v3 04/10] evm: Use the metadata inode to calculate
 metadata hash
From: Mimi Zohar <zohar@linux.ibm.com>
To: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, roberto.sassu@huawei.com, amir73il@gmail.com,
        brauner@kernel.org, miklos@szeredi.hu
Date: Tue, 19 Mar 2024 18:51:42 -0400
In-Reply-To: <20240223172513.4049959-5-stefanb@linux.ibm.com>
References: <20240223172513.4049959-1-stefanb@linux.ibm.com>
	 <20240223172513.4049959-5-stefanb@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 5Zi3e-dch-Cmc6HxFR8xW8RPa7Dkk5af
X-Proofpoint-GUID: n6_iUU2o2Ul3baH8kv2cZtmKSbtj9pZ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_09,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=760 bulkscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403190176

On Fri, 2024-02-23 at 12:25 -0500, Stefan Berger wrote:
> Changes to file attributes (mode bits, uid, gid) on the lower layer are
> not taken into account when d_backing_inode() is used when a file is
> accessed on the overlay layer and this file has not yet been copied up.
> This is because d_backing_inode() does not return the real inode of the
> lower layer but instead returns the backing inode which in this case
> holds wrong file attributes. Further, when CONFIG_OVERLAY_FS_METACOPY is
> enabled and a copy-up is triggered due to file metadata changes, then
> the metadata are held by the backing inode while the data are still held
> by the real inode. Therefore, use d_inode(d_real(dentry, D_REAL_METADATA))
> to get to the file's metadata inode and use it to calculate the metadata
> hash with.
> 
> Co-developed-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Acked-by: Amir Goldstein <amir73il@gmail.com>

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>


