Return-Path: <linux-kernel+bounces-93859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FE58735ED
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46F681C2160E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86CB7FBBF;
	Wed,  6 Mar 2024 11:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rvTphROz"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9673160B86;
	Wed,  6 Mar 2024 11:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709726129; cv=none; b=CSLzRHA9McWZYS/zqxLAOlvxLzntZ8pVE+g12tHIwM0KCewSrO5vGN31RvHUqdKxnInjFVl8Ef0ewCAwoVItYPv7D3vZQpU8o2x/rXoxVXbwpGx2aCIt3Tw0/W3WY52Nu/Med7oc2yNoTRLI6RTxpjCYwI41hRK3NWnVpvibQEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709726129; c=relaxed/simple;
	bh=XdWyUAYB3kLZe/yIQrocuP6DXR4ct+DXO30W//s+sbM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IGAxLZFEa0e2ddME3YwWKh1H9h4MTW/b78AddrPK1Q3CEGshcVvqDqAUjsWpEjLGwFRHdfyMW/brpsQ9U8x1o/E9B6MSJM4foyo6iYJQ3iviaqLJJDYhgb1bSVJt0WIp5V8C0+R/oTU7TvLbBJgFtV/vGdG0iWrTLJGYfLrMqYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rvTphROz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 426B2AhJ002879;
	Wed, 6 Mar 2024 11:55:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=kIFk6i1GlO9jyQC37kXh4zuglxoT8soSWpXp8uAyqYU=;
 b=rvTphROzvGynwyj3F22V++TsSE2lQr4PeZK5YQfEWDrl4Es9pI6j89tZzR5Bmdk2FlaL
 nvMd8/402M9FYwAL8yCYEUDmbRLLEE8GsoblMFmwQLUA37j0vSNZAYyh/FZnQkFSm5Qt
 yTRUTBZ6hVrXtr0PB7jVkFAA+iwel/6DLPQfSlYxMujbqUsmmBWhHzvbuhSciatqWszn
 E+KcuzAxzXctieFrRjCLpox2xOi57r0eIybiUm9H+YuLr0Ytwy1TwjWO+7gY9NJmvkk7
 KmVkaK6g66pSW5od8kq1989gjLJs2EMURujO8EKyyvyoeMtbkuiS2DYNQZQbRx7B0+Vu Ag== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wpq8n93tk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 11:55:18 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 426BKIj3000875;
	Wed, 6 Mar 2024 11:55:16 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wpq8n93by-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 11:55:15 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 426Bo5Bi010877;
	Wed, 6 Mar 2024 11:55:06 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmh52dywp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 11:55:06 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 426Bt3MJ26870372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Mar 2024 11:55:05 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D887B5806B;
	Wed,  6 Mar 2024 11:55:01 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFBFA58066;
	Wed,  6 Mar 2024 11:55:00 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.175.142])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Mar 2024 11:55:00 +0000 (GMT)
Message-ID: <a677a9cd8eda40e5529094ba2a6ad2f7c0c927fa.camel@linux.ibm.com>
Subject: Re: [PATCH v2] integrity: eliminate unnecessary "Problem loading
 X.509 certificate" msg
From: Mimi Zohar <zohar@linux.ibm.com>
To: Maxime Ripard <mripard@redhat.com>,
        Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Coiby Xu
 <coxu@redhat.com>
Cc: linux-integrity@vger.kernel.org, itrymybest80@protonmail.com,
        Eric
 Snowberg <eric.snowberg@oracle.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date: Wed, 06 Mar 2024 06:55:00 -0500
In-Reply-To: <20240306-humongous-nuthatch-of-science-00e58b@houat>
References: <20231227044156.166009-1-coxu@redhat.com>
	 <20240109002429.1129950-1-coxu@redhat.com>
	 <20240306-humongous-nuthatch-of-science-00e58b@houat>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aBm0LrkuZUuj8SQWpvgPCWwlXDnciCbo
X-Proofpoint-ORIG-GUID: xHSEh9S-92NQMJAUK730F36o_g7js2Mk
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_07,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403060095

On Wed, 2024-03-06 at 11:57 +0100, Maxime Ripard wrote:
> Hi Dmitry, Eric, James, Mimi, Paul, Serge,
> 
> On Tue, Jan 09, 2024 at 08:24:28AM +0800, Coiby Xu wrote:
> > Currently when the kernel fails to add a cert to the .machine keyring,
> > it will throw an error immediately in the function integrity_add_key.
> > 
> > Since the kernel will try adding to the .platform keyring next or throw
> > an error (in the caller of integrity_add_key i.e. add_to_machine_keyring),
> > so there is no need to throw an error immediately in integrity_add_key.
> > 
> > Reported-by: itrymybest80@protonmail.com
> > Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2239331
> > Fixes: d19967764ba8 ("integrity: Introduce a Linux keyring called machine")
> > Reviewed-by: Eric Snowberg <eric.snowberg@oracle.com>
> > Signed-off-by: Coiby Xu <coxu@redhat.com>
> 
> Any chance this patch can be merged? This is breaking (at least) Fedora
> at the moment.

https://git.kernel.org/torvalds/c/29cd507cbec282e13dcf8f38072a100af96b2bb7

Mimi


