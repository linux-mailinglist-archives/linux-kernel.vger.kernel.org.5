Return-Path: <linux-kernel+bounces-17979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30762825641
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3F58B22DAE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485A32E3F9;
	Fri,  5 Jan 2024 14:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pmnw6U6t"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AEA2E623;
	Fri,  5 Jan 2024 14:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 405CRg7u009167;
	Fri, 5 Jan 2024 14:59:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=srVFGRu3fKLXSKgBecGL2P7rO5z7cc9P6fOF/yabDLg=;
 b=pmnw6U6tj31dw5SpY47xUj6dhUPMktXqwM4PGn7LHR3FdnfTbt3lAkIHEkSXythiyRSq
 C+iMicm+nPBECq46DdNC0UJs9AMBZps/BqbC54WWYsnzbI2MkBszMsCMkTmQpk2ugOs3
 VdkC9E8BcO7a3HP50cWm3QZD7klCYtDv/nd/xuELdeOh9wDWeVOBIUi5pIczHrcjdKet
 56ZWWV0qKWFTUAWY8zSddAhbohAu1teXzp1UwACH69lLs2/sveJjgjQCcud4m+8sBG/t
 vs3YRcMNPAOUrXOC9jdJb/TOG1C7L98kZbplmDi5ukulyvqbMlnMwF+U0oCHhu1t5GWw 3g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vehsnc7nu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jan 2024 14:59:29 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 405EKn7t002127;
	Fri, 5 Jan 2024 14:59:29 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vehsnc7n2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jan 2024 14:59:28 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 405EbBjd017991;
	Fri, 5 Jan 2024 14:59:28 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vayrkyqg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jan 2024 14:59:28 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 405ExRD841288236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jan 2024 14:59:27 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E68FF5805E;
	Fri,  5 Jan 2024 14:59:26 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65DEF58063;
	Fri,  5 Jan 2024 14:59:26 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.173.4])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Jan 2024 14:59:26 +0000 (GMT)
Message-ID: <16ae3e51dc4eeb2b2e674b8ff1051ac315fa492c.camel@linux.ibm.com>
Subject: Re: Re: [PATCH] integrity: don't throw an error immediately when
 failed to add a cert to the .machine keyring
From: Mimi Zohar <zohar@linux.ibm.com>
To: Coiby Xu <coxu@redhat.com>
Cc: linux-integrity@vger.kernel.org, itrymybest80@protonmail.com,
        Dmitry
 Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date: Fri, 05 Jan 2024 09:59:14 -0500
In-Reply-To: <35tiggwgbrb2sapyykv3umio5l2xqhmzc43wy33dxmz4hyu24c@bprgz7skpxma>
References: <20231227044156.166009-1-coxu@redhat.com>
	 <39e5612eb2d4dea2759310ccce39c1ad40b5388f.camel@linux.ibm.com>
	 <35tiggwgbrb2sapyykv3umio5l2xqhmzc43wy33dxmz4hyu24c@bprgz7skpxma>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DjDUnVaF_nPsRvGPV58oT1rYzNdxVAPX
X-Proofpoint-GUID: sHIjKXT9Ew1vDO8zBib0u7QMiLv7rSs-
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
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 mlxscore=0 mlxlogscore=805 bulkscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401050125

On Fri, 2024-01-05 at 21:27 +0800, Coiby Xu wrote:
> On Tue, Jan 02, 2024 at 12:54:02PM -0500, Mimi Zohar wrote:
> >Hi Coiby,
> 
> Hi Mimi,
> 
> >
> >According to https://docs.kernel.org/process/submitting-patches.html,the
> summary line should be no more than  70 - 75 characters.
> 
> Thanks for pointing me to this limit! How about 
> integrity: eliminate harmless error "Problem loading X.509 certificate -126"

Still >75.   How about the following?

integrity: eliminate unnecessary "Problem loading X.509 certificate" msg

Mimi         

> 
> >
> >On Wed, 2023-12-27 at 12:41 +0800, Coiby Xu wrote:
> >> Currently when the kernel fails to add a cert to the .machine keyring,
> >> it will throw an error immediately in the function integrity_add_key.
> >>
> >> Since the kernel will try adding to the .platform keyring next or throw
> >> an error (in the caller of integrity_add_key i.e. add_to_machine_keyring),
> >> so there is no need to throw an error immediately in integrity_add_key.
> >>
> >> Reported-by: itrymybest80@protonmail.com
> >> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2239331
> >> Signed-off-by: Coiby Xu <coxu@redhat.com>
> >
> >Otherwise, the patch looks good.
> 
> Thanks for reviewing the patch!



