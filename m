Return-Path: <linux-kernel+bounces-13418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A5A820607
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 13:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F361F2179B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 12:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2138BF6;
	Sat, 30 Dec 2023 12:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HLZCkMOv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992958BEB;
	Sat, 30 Dec 2023 12:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BU5qIWv010575;
	Sat, 30 Dec 2023 12:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : content-transfer-encoding : mime-version; s=pp1;
 bh=5WPb7lu8nCv6A+qP0p0HpluMWmDEtFO0vVPTnxPG74k=;
 b=HLZCkMOvP8Wzcx826QNz3jbBskppdgrSxmBqJnNTMd5ndr75dXPwZreNlgxK2NG4rhr+
 JknwRR8Ou7WadQKb8UuP67OU0ayVUHxUAz1oXCD3O2HiDqPMP4yiN4J0e0tMrgCY0xww
 27Ly6o5PCNcWfFtJfVOF8J/v5hJjDb0IxkeYhucyMTXb+bSiB5vlIrsSGtFGIL6/PfqI
 TZf6xzHG8kzmnUrXlISpPW1rzY7ohDbRvNasOxeLtZgJFRILglLu/jwIAv8bj49D6iAK
 fKyn+2wS5KIvKvpKSVz+VW2Hgkx8/5qRVgSWLTePxe3dBnBh1aA0bI1U7hUqU+65+e6D /w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vadecmqc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 30 Dec 2023 12:41:59 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BUCRWDV016919;
	Sat, 30 Dec 2023 12:41:58 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vadecmqc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 30 Dec 2023 12:41:58 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BUBRstu016595;
	Sat, 30 Dec 2023 12:41:57 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3v6c3kjg5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 30 Dec 2023 12:41:57 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BUCfu3U18547396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 30 Dec 2023 12:41:57 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3CDC58057;
	Sat, 30 Dec 2023 12:41:56 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F84058059;
	Sat, 30 Dec 2023 12:41:55 +0000 (GMT)
Received: from lingrow.int.hansenpartnership.com (unknown [9.67.64.147])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 30 Dec 2023 12:41:55 +0000 (GMT)
Message-ID: <a35c6128d4449fec00238c909e5f6f45ebf4bcba.camel@linux.ibm.com>
Subject: Re: scsi: ses: Move a label in ses_enclosure_data_process()
From: James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To: Markus Elfring <Markus.Elfring@web.de>, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        "Martin K. Petersen"
	 <martin.petersen@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Date: Sat, 30 Dec 2023 07:41:53 -0500
In-Reply-To: <b65afa15-41e6-4d71-87bd-39fd688fa551@web.de>
References: <4616e325-e313-4078-9788-dd1e6e51b9e0@web.de>
	 <9d24844f30604f969ac10da456801f594ce72f2d.camel@linux.ibm.com>
	 <b65afa15-41e6-4d71-87bd-39fd688fa551@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: voUnU-wsCS1EbwPdhiveWTACMypjg6C3
X-Proofpoint-GUID: iSykN4Qcx_VcRpfdVAFxLZU11Z24z3hT
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
 definitions=2023-12-30_07,2023-12-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=922 mlxscore=0 bulkscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312300106

On Sat, 2023-12-30 at 08:04 +0100, Markus Elfring wrote:
> > > The kfree() function was called in up to three cases by
> > > the ses_enclosure_data_process() function during error handling
> > > even if the passed variable contained a null pointer.
> > > This issue was detected by using the Coccinelle software.
> > 
> > Why is this an issue?  The whole point of having kfree(NULL) be a
> > nop
> 
> Such “a nop” can trigger the allocation of extra data processing
> resources, can't it?

No.

> > is so we don't have to special case the free path.
> 
> A bit more development attention can hopefully connect the mentioned
> label with a more appropriate jump target directly.

That's making the flow more complex as I pointed out in my initial
email.

> >                                                     The reason we
> > do that is because multiple special case paths through code leads
> > to more complex control flows and more potential bugs.
> 
> You probably know some advices from another information source.
> 
> https://wiki.sei.cmu.edu/confluence/display/c/MEM12-C.+Consider+using+a+goto+chain+when+leaving+a+function+on+error+when+using+and+releasing+resources
> 

Yes, but it's about using staged deallocation at the end of the
function instead of in the if loops.  That's to *simplify* the exit
chain and make the error legs less error prone because the teardown
isn't repeated in if bodies.  It has no bearing on what you just tried
to do.

> >                                               If coccinelle
> > suddenly thinks this is a problem, it's coccinelle that needs
> > fixing.
> 
> This software tool can help to point source code places out for
> further considerations. The search patterns are evolving accordingly.

The pattern is wrong because kfree(NULL) exists as a teardown
simplification.

James


