Return-Path: <linux-kernel+bounces-13437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8928A82069B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 14:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3B4CB213A8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 13:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28068F65;
	Sat, 30 Dec 2023 13:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QALueXQM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D69BE49;
	Sat, 30 Dec 2023 13:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BUDHRnv013946;
	Sat, 30 Dec 2023 13:46:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : content-transfer-encoding : mime-version; s=pp1;
 bh=UJ5caAb/2R5/2MyedyGM5AifIXVNYiFI71K0EBUoHBs=;
 b=QALueXQM9WXu6UGqTQC/ljsDW/1rWB30klqBHlUA158aJfdigV5CHVUzvMBS1Rt83fAj
 5nyp8zmdE7l3jqAIS0cJ2W//yrxsgcxyW3ylCvXhvrg9RQ9c1IxfXyGQMnUXA9R5pgW+
 +1Rjv5QZ3D2/exeN3pnS9OSXa6+tu/7NxZDm9WO72a+V8qB4M+/muzFn7/qxLnrUa+kX
 X4PZQi5btM1/bm8Ux/vrcpn17MgOR4buI6w3U6nQBvCfsOXzXP5+MYA+ysCIYMcsdvi6
 VcVnBOx7MIe4+DknoUzUBAGj4sLZ527aUOHAydN0vIg4PDNx6LXkR+20vpVJYxxL2r+b oA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vabbkqdy4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 30 Dec 2023 13:46:04 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BUDfiZY027983;
	Sat, 30 Dec 2023 13:46:04 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vabbkqdxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 30 Dec 2023 13:46:03 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BUAIv3K004727;
	Sat, 30 Dec 2023 13:46:02 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3v6bcmawt4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 30 Dec 2023 13:46:02 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BUDk1IF16908952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 30 Dec 2023 13:46:02 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E601A58058;
	Sat, 30 Dec 2023 13:46:01 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA58058057;
	Sat, 30 Dec 2023 13:46:00 +0000 (GMT)
Received: from lingrow.int.hansenpartnership.com (unknown [9.67.79.160])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 30 Dec 2023 13:46:00 +0000 (GMT)
Message-ID: <4018ab9225ecaf18501e54114a94217a58a8a57f.camel@linux.ibm.com>
Subject: Re: scsi: ses: Move a label in ses_enclosure_data_process()
From: James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To: Markus Elfring <Markus.Elfring@web.de>, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        "Martin K. Petersen"
	 <martin.petersen@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Date: Sat, 30 Dec 2023 08:45:59 -0500
In-Reply-To: <a3825ab2-8987-4b85-9db0-642035789c49@web.de>
References: <4616e325-e313-4078-9788-dd1e6e51b9e0@web.de>
	 <9d24844f30604f969ac10da456801f594ce72f2d.camel@linux.ibm.com>
	 <b65afa15-41e6-4d71-87bd-39fd688fa551@web.de>
	 <a35c6128d4449fec00238c909e5f6f45ebf4bcba.camel@linux.ibm.com>
	 <a3825ab2-8987-4b85-9db0-642035789c49@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LdMrCx3KT8LjOx-tjmlq1duVEoP3iLgX
X-Proofpoint-ORIG-GUID: UfqQ1FHVR1nFGlkzVKsVY1etK73uWAGz
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 suspectscore=0 mlxscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=689 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312300115

On Sat, 2023-12-30 at 14:36 +0100, Markus Elfring wrote:
> > > You probably know some advices from another information source.
> > > 
> > > https://wiki.sei.cmu.edu/confluence/display/c/MEM12-C.+Consider+using+a+goto+chain+when+leaving+a+function+on+error+when+using+and+releasing+resources
> > > 
> > 
> > Yes, but it's about using staged deallocation at the end of the
> > function instead of in the if loops.  That's to *simplify* the exit
> > chain and make the error legs less error prone because the teardown
> > isn't repeated in if bodies.  It has no bearing on what you just
> > tried to do.
> 
> I got the impression that there is a general conflict involved
> according to different programming styles.

There isn't; you simply seem to have misunderstood what the above 
resource is actually saying.

> > > >                                               If coccinelle
> > > > suddenly thinks this is a problem, it's coccinelle that needs
> > > > fixing.
> > > 
> > > This software tool can help to point source code places out for
> > > further considerations. The search patterns are evolving
> > > accordingly.
> > 
> > The pattern is wrong because kfree(NULL) exists as a teardown
> > simplification.
> 
> It might be convenient to view in this way.
> 
> If you would dare to follow advice from goto chains in a strict way,
> I imagine that you can tend to stress the attention for more useful
> data processing a bit more than such a redundant function call.

It's about maintainability and simplicity.  Eliminating kfree(NULL)
doesn't simplify most code, it just makes the exit paths more complex
as I've said for the third time now.  It could possibly be done in
extremely performance critical situations for good and well documented
reason, but that's only a tiny fraction of the kernel and it certainly
doesn't apply here.

James


