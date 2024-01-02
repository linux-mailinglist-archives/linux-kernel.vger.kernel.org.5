Return-Path: <linux-kernel+bounces-14682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4F48220A8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4DB1C226B1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E7E15AF8;
	Tue,  2 Jan 2024 17:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Rm9QcEmR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1315415EAA;
	Tue,  2 Jan 2024 17:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 402HHw0A019523;
	Tue, 2 Jan 2024 17:54:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=I0MgCuODickFIYksO64ThHepb8KQxUyfAdwDlDz1u7w=;
 b=Rm9QcEmRda6ykCaaAqcVIdHwoSpAmZe5MZyABJJW31NqfvhusFqTzhDnajjgFTiOviFt
 ATdMXUyFrUYje5//xxY4b6hclY5GWbbenQya8FIEOL6yqVJCdasKkc4aUhKXkxpcoZFT
 RZAGMPuPGtaeRZKLyvpFFqvfWO+PSFMDuFlCk/JPkycQKlvb0rVLO5wk02fHW81emT5B
 80dgKj8YZzMjtiU4DfiJzZ3zXwVmQ4h4NjFUTm1De1Ruk7DiZkuLsmK1TTZj3NHfo/Fw
 uJyknUeQH2ia3xRuaplqBfgJSkLEbHIbGZXaMXeG/JJFGJZCtTrN7gvD7FtD9jUpN5Hq uw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vcprx8qe1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 17:54:05 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 402HI7Vd019985;
	Tue, 2 Jan 2024 17:54:04 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vcprx8qd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 17:54:04 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 402Gfwl6017838;
	Tue, 2 Jan 2024 17:54:04 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vawwypf9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 17:54:04 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 402Hs3kC23462486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jan 2024 17:54:03 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 460F358063;
	Tue,  2 Jan 2024 17:54:03 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8076F58060;
	Tue,  2 Jan 2024 17:54:02 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.135.171])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jan 2024 17:54:02 +0000 (GMT)
Message-ID: <39e5612eb2d4dea2759310ccce39c1ad40b5388f.camel@linux.ibm.com>
Subject: Re: [PATCH] integrity: don't throw an error immediately when failed
 to add a cert to the .machine keyring
From: Mimi Zohar <zohar@linux.ibm.com>
To: Coiby Xu <coxu@redhat.com>, linux-integrity@vger.kernel.org
Cc: itrymybest80@protonmail.com, Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>, James
 Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "open
 list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
        open list
 <linux-kernel@vger.kernel.org>
Date: Tue, 02 Jan 2024 12:54:02 -0500
In-Reply-To: <20231227044156.166009-1-coxu@redhat.com>
References: <20231227044156.166009-1-coxu@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: M5pVSb9sk9s-TDoesZfNQZZhgHz4hpOp
X-Proofpoint-ORIG-GUID: 3mjAS6lJuc6SPA8h4W2zeZQnJ0yC0kB2
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-02_06,2024-01-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 mlxlogscore=593 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401020134

Hi Coiby,

According to https://docs.kernel.org/process/submitting-patches.html,the summary line should be no more than  70 - 75 characters. 

On Wed, 2023-12-27 at 12:41 +0800, Coiby Xu wrote:
> Currently when the kernel fails to add a cert to the .machine keyring,
> it will throw an error immediately in the function integrity_add_key.
> 
> Since the kernel will try adding to the .platform keyring next or throw
> an error (in the caller of integrity_add_key i.e. add_to_machine_keyring),
> so there is no need to throw an error immediately in integrity_add_key.
> 
> Reported-by: itrymybest80@protonmail.com
> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2239331
> Signed-off-by: Coiby Xu <coxu@redhat.com>

Otherwise, the patch looks good.

-- 
thanks,

Mim




