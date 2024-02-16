Return-Path: <linux-kernel+bounces-68619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FB3857D4A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB1D81F28626
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074665465D;
	Fri, 16 Feb 2024 13:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RnKEV1pq"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA731292E5;
	Fri, 16 Feb 2024 13:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708089043; cv=none; b=sHd6Y/EsmW6H3df+DTZagr1faLVq1T23JFnQw0w2lvtQCyrnPs+ttJzZJl3524U08D/aO9oJpf9TcWeFOoerY2Vq2FUzpxZXBhUx/ikwHWfRqg83qSSCyx6WQXSNM6dG2AAYrJeXfqHq6JRTx73UCXHiZeI2JYz3mrIl8tjfyok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708089043; c=relaxed/simple;
	bh=wDCT/AKq28T1CaqjuwfiesQ85q6iMwOARLD1Lg0gyJs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=LaULF8dm9vKF7meRferL58JrINzv+FIGJ2mjjW+pqlb2UljQV61WkauHTheXE2vmyp3J8PeTTt9yl5mlGL+w/IV3s9Oj71Y9XstYuSOXzuwRzjmn4W2+1vshY0HwuBU8LW7rCZixvov/K9UimlgP9/w1bGlOSsToVWLaynkAPiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RnKEV1pq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41GCbZb4006914;
	Fri, 16 Feb 2024 13:10:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=y7PGMOhJkJC7HYN/DW1kwfv/QxIiLB0yuOSBedKbfuo=;
 b=RnKEV1pqbqzbJlYMlomrNR3wYtcxOvteJexvaWonBso9lqhdurgDYcnXEHglJToa2ysG
 c3FzSwZDgfQT6ZGyGDBk+uZMZ46vNxZlWzacultsVr9BqeThIylclZ3rtsQsBuajNXyS
 9aPdKxHwi3CI/k6gocJwZxALDJnBw0LDKo6jWldNv4pFxlnq2ab31EjRDzCada4vxIWf
 vmTNoaRcw+6aOfUC4rZmJoPq9At5TF2vvlbcpVslY1ywl+LBHDBN+zHo8Okk7uJNb56c
 H8rA5qBAwacltCSyw0ctYh4hEfb1E8S/YLfPv3rPuYOC6SDIHuasB3Ls4f4Djk2+7y8L jA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wa7vcrh2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 13:10:28 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41GD5XG6016325;
	Fri, 16 Feb 2024 13:10:27 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wa7vcrh1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 13:10:27 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41GBOIUY009741;
	Fri, 16 Feb 2024 13:10:26 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6p63awpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 13:10:26 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41GDAOa517957424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 13:10:26 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 550BE58063;
	Fri, 16 Feb 2024 13:10:24 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE9DB58052;
	Fri, 16 Feb 2024 13:10:23 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.181.243])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 16 Feb 2024 13:10:23 +0000 (GMT)
Message-ID: <7fe03370dd3d31b6a9b21b0eff93398a8ca07d87.camel@linux.ibm.com>
Subject: Re: [PATCH v2] integrity: eliminate unnecessary "Problem loading
 X.509 certificate" msg
From: Mimi Zohar <zohar@linux.ibm.com>
To: Coiby Xu <coxu@redhat.com>, linux-integrity@vger.kernel.org
Cc: itrymybest80@protonmail.com, Eric Snowberg <eric.snowberg@oracle.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn"
 <serge@hallyn.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "open
 list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
        open list
 <linux-kernel@vger.kernel.org>
Date: Fri, 16 Feb 2024 08:10:23 -0500
In-Reply-To: <pgwe5qhu7j3t7l37d3tj2nf6wpcjfonxonxjk4ozpinbhl4llr@g5ddvx7cgqsk>
References: <20231227044156.166009-1-coxu@redhat.com>
	 <20240109002429.1129950-1-coxu@redhat.com>
	 <pgwe5qhu7j3t7l37d3tj2nf6wpcjfonxonxjk4ozpinbhl4llr@g5ddvx7cgqsk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 09bz_3rqmsdfsP9ehpZSebLFyCIh4iBM
X-Proofpoint-GUID: ty67EL53qs4DfuhG_C5E0oDD1TqMIMQD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_11,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 spamscore=0 mlxlogscore=663 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402160106

On Fri, 2024-02-16 at 19:10 +0800, Coiby Xu wrote:
> Hi Mimi,
> 
> Could you take a look at this version of patch? If it escaped your
> attention because it got buried in the same thread, sorry for that. And
> I won't send new version as a reply to previous version in the future.

Thanks for the reminder.

Mimi


