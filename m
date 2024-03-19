Return-Path: <linux-kernel+bounces-108214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DDA880791
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EF2E1F237AF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DBD57874;
	Tue, 19 Mar 2024 22:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MPAxnsGs"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A18454BC4;
	Tue, 19 Mar 2024 22:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710888867; cv=none; b=a1r2h5DJ0yYyh9wnoJrMapvtwEo/jTiJXiCUsRaumh1TAlT8CMTvIrkkkCHhtSUQfYxNIEMofZlaujEzxbFcNZSj3vswxNuGMyRw38DVEnOdjc80iXqKnxKII0SxT+H8fTcjYkgV1GxjN2yP55k5CESXf+TQ9FxIcc6F+GQXk6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710888867; c=relaxed/simple;
	bh=3UZZ30OA0jA5JUILju1kNyfyf/u621MYz2QjrmvfMq8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=tU83oo05139r+HjQLAw2yGMou4aWblU0TfemtAlsATpulcVrUUAJO96r8X7gEi14k/2XHyNsLMievywVMvUduqchZ4zMbKumXwv49IKkIGwk9aCO7q5ukBOIA5BbRFanZ0a5NQcL1520lDOP8V+e7/SXkEletoFd25euj1qDqNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MPAxnsGs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JMkGrN012244;
	Tue, 19 Mar 2024 22:54:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=7X9jcGNPmWLmFdVW41kX9OfYyqZ3FxypITECaxqWny8=;
 b=MPAxnsGszLC0JaO5tUKgNkkVWy5Wf/WHKe5FOHM/hE44evEShvlyeMs853t/2PLU17wW
 ZGxB8S6z0XbzYve4emDewGK102lfAMZU4+3W2K+uQz+uwTfa7wwnDo6Tq6pHIeDx68EY
 g2ANFaUlTuIXWcDxonEfM63o1wiLnHMhsp/Zxo2ST09GIqcq52rhqcbuoecwisBQrg0w
 SDMz8mmWaHtMiEVsGNnDW4b9AzvijxgNiiB+W2VfwEjxU6pswrRlvzsGIZV2Bl6tyhHS
 i06Y/f1hfnw9y1elRplcp0XnEmywd3VFX3giHKQ6BkO6YwoAv9XQwsr7EuISbwueq+Zq 9A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wykner0sf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 22:54:09 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42JMs9hr023631;
	Tue, 19 Mar 2024 22:54:09 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wykner0rp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 22:54:09 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42JKoR03010061;
	Tue, 19 Mar 2024 22:51:55 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wxvauykmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 22:51:55 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42JMpqs039977548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 22:51:55 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A24E95805E;
	Tue, 19 Mar 2024 22:51:52 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B4A858052;
	Tue, 19 Mar 2024 22:51:51 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.80.83])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Mar 2024 22:51:51 +0000 (GMT)
Message-ID: <17b17f3ba8ce7af3bccda15bf81535950fa78a48.camel@linux.ibm.com>
Subject: Re: [PATCH v3 02/10] security: allow finer granularity in
 permitting copy-up of security xattrs
From: Mimi Zohar <zohar@linux.ibm.com>
To: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, roberto.sassu@huawei.com, amir73il@gmail.com,
        brauner@kernel.org, miklos@szeredi.hu
Date: Tue, 19 Mar 2024 18:51:51 -0400
In-Reply-To: <20240223172513.4049959-3-stefanb@linux.ibm.com>
References: <20240223172513.4049959-1-stefanb@linux.ibm.com>
	 <20240223172513.4049959-3-stefanb@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: rfWDJbAYl7ce7tdpLkNmdGwaITZT7433
X-Proofpoint-GUID: SwMPlrKBIgxhT5FE2UTZjN7qpE3X_svk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_09,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=620 bulkscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403190176

On Fri, 2024-02-23 at 12:25 -0500, Stefan Berger wrote:
> Copying up xattrs is solely based on the security xattr name. For finer
> granularity add a dentry parameter to the security_inode_copy_up_xattr
> hook definition, allowing decisions to be based on the xattr content as
> well.
> 
> Co-developed-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Acked-by: Amir Goldstein <amir73il@gmail.com>

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>


