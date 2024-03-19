Return-Path: <linux-kernel+bounces-108212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F52A880788
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E3F284321
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AF05FEF2;
	Tue, 19 Mar 2024 22:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dDtHKf5q"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6645FDAF;
	Tue, 19 Mar 2024 22:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710888834; cv=none; b=jrdaQYtVpdHuqMJcfgxCKvQ9rdZPhWzPL23k5GC6Uhi4u8MD8b5SOoi9mzvS6DcL7aRkQp1+m5/7V5m05UpS2MtBiIQ2m14pFqtLwzwO0xno+uk26rxx+zOMv+Zwx7NdyjdVUymHHZMawZLVKWV7w0Lf1wwM861pjF+bnbgOhSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710888834; c=relaxed/simple;
	bh=uViNWnjbyPnAgnJzoDJ4u3duiT3uN22DyjhH/94J8aQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=VYArueZIXA/SGN2Erb+M7dAnuYd8n3uAV8DMhVDjy9BqxypH0TcNInUPi2tvFH+ZgTDPzWwCIlUu6f1B0HNpyvvXmuTMvKz/xyJ8KvNfwMGsFv82z5DRsIidbKpxBmeYimxtLgz0SeNkEROVGvZcTvHupQFNIttG3ZGG+eyijO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dDtHKf5q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JMp02R017804;
	Tue, 19 Mar 2024 22:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=8q3s4opcuHXJjrGLVS88W7yR/VK1WKBfpAMDhzeWnbk=;
 b=dDtHKf5qb/4FCOSeyK6xn3Pb993p8wIJ8fPn5sANoBZcev8mf14MWzsOmACxM4a8C7JG
 AdWg6zv305fXfWoY5CjY18QVJWBWGWKoB9yMhmPfVA/mqpyIzTvbt7WfRTComum6aDkz
 AVHSHoEVWFMzcKyZwkVuOHMbPN0FpNMkdERwhMbYN6mOm/720k9pQBkR0PxkjYO38v9J
 19d5AZAhZHFn78p48Q58RdvXW1tXinPv3r38lQqIFZO+g7WhDgGogsOHi+JfQZnuArAj
 umphiXi326WMNT4GwAAW1k1rj6omXKo6fiXXpDyCykiVLmzXG0ET7om2K3KciZihwdQ3 4Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wyh3hrahs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 22:53:38 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42JMrcb1022532;
	Tue, 19 Mar 2024 22:53:38 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wyh3hrahr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 22:53:38 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42JKYg7A002779;
	Tue, 19 Mar 2024 22:53:37 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwrf2j5ve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 22:53:37 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42JMrYP614615146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 22:53:36 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75A1C58052;
	Tue, 19 Mar 2024 22:53:34 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AAC7758068;
	Tue, 19 Mar 2024 22:53:33 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.80.83])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Mar 2024 22:53:33 +0000 (GMT)
Message-ID: <5c3a94dfc6dad32824e25736ec816b8c805de898.camel@linux.ibm.com>
Subject: Re: [PATCH v3 10/10] evm: Rename is_unsupported_fs to
 is_unsupported_hmac_fs
From: Mimi Zohar <zohar@linux.ibm.com>
To: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, roberto.sassu@huawei.com, amir73il@gmail.com,
        brauner@kernel.org, miklos@szeredi.hu
Date: Tue, 19 Mar 2024 18:53:33 -0400
In-Reply-To: <20240223172513.4049959-11-stefanb@linux.ibm.com>
References: <20240223172513.4049959-1-stefanb@linux.ibm.com>
	 <20240223172513.4049959-11-stefanb@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: vncPtyxpUgFXwOH6Z2GyYeUZTaBwUfYv
X-Proofpoint-GUID: U5jE3Rfse1LmHk6ycWIEI5laTVVYgzqj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_09,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0
 mlxlogscore=724 mlxscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2403140000 definitions=main-2403190176

On Fri, 2024-02-23 at 12:25 -0500, Stefan Berger wrote:
> Rename is_unsupported_fs to is_unsupported_hmac_fs since now only HMAC is
> unsupported.
> 
> Co-developed-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>


