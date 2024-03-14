Return-Path: <linux-kernel+bounces-103315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4A587BDF2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87A462830DF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3BA612EC;
	Thu, 14 Mar 2024 13:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="he8MG/k9"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2625E5C5F3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 13:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710423968; cv=none; b=VpiqSan951je+dgVkptuaRkwqjK9ihpAI6bzOx8U2cvi6mWne9JpoT4mBlxSE0Ny1Xm/mg8pnAkvxN6qGmUm6b9Cf1AlO6jvV6bP585WmqKaZX+zHgmjjsD+k+4Mtj9NuQEz/Q6qph/zmIQZkKpZaPGa3OWI7nWyKD1yisRhmv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710423968; c=relaxed/simple;
	bh=Nwe0OJCwPmO+Pyk5ikxG+QFsv/VS0r+15g43/j6W8GM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B+ZFCaTJ8qxyGKO2b50cSmdo1KN7vkbDY+08AaO+9jcM0BYn+Ry/suylreJtOO+xKYt7dWih42CNz4cxlQekIevnunQ0jfHcBFQWhPzEzPBBhYqciWy4gEZw0+kj0WboFJVeEP65QXXarIGkv8Pt8pYeXC6Ife7B7gtfKrTQcUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=he8MG/k9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42ECrD2l029511;
	Thu, 14 Mar 2024 13:45:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=XwiQpHXIslt51XYw+nYwRS+Tl6bFp6ua9li80Bv5mQw=;
 b=he8MG/k9ecHXJLA09kkkxNS8g7veOVeccmEJKg8RCfagzZBt1/11Pxu7FM+pW9DSI5FT
 sVVXvmSHO+SitfcyDOvOwuuKKzwlHIBblYZ60LMmmnjrHjqwYaeITiLhpkg5BFkpEOHO
 c+VsMx6DiSx1hrGAqPrawXuuI7nOO7yMyL+7KEu+zsnnesU3SaygPmvWM93hPMq3hGzZ
 kzf4qyxWICNv95FADnbQnC1yRYLK1D3uQ7RhdFOznR+3RGoQdKu7y1iJDwIqMGHQYWXP
 SbC9edevwNibhqyZJOPb7VmiOm0/JsKq7WUC4Q5skhTxb+4rJ4fFJ+jxFNrRfISILxEK 4w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wv1mngvq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 13:45:48 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42EDdHqV001952;
	Thu, 14 Mar 2024 13:45:47 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wv1mngvpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 13:45:47 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42EB0RiW020506;
	Thu, 14 Mar 2024 13:45:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ws3kmd2ar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 13:45:46 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42EDjgFa12583400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 13:45:44 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABADF2004B;
	Thu, 14 Mar 2024 13:45:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 699EB20040;
	Thu, 14 Mar 2024 13:45:42 +0000 (GMT)
Received: from DESKTOP-2CCOB1S. (unknown [9.171.201.209])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 14 Mar 2024 13:45:42 +0000 (GMT)
Date: Thu, 14 Mar 2024 14:45:41 +0100
From: Tobias Huschle <huschle@linux.ibm.com>
To: Luis Machado <luis.machado@arm.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        sshegde@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org, nd <nd@arm.com>
Subject: Re: [RFC] sched/eevdf: sched feature to dismiss lag on wakeup
Message-ID: <ZfL/hROYxQudcTuX@DESKTOP-2CCOB1S.>
References: <20240228161018.14253-1-huschle@linux.ibm.com>
 <5a32e8e1-67cf-4296-a655-f0fc35dc880a@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a32e8e1-67cf-4296-a655-f0fc35dc880a@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PvEnVf3CeDddS-tn5gdTkdX5xc-aFryX
X-Proofpoint-GUID: uO3Sy-jjvv1DLMP_tYpnLbfXBGAXTWbH
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_11,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403140100

On Fri, Mar 08, 2024 at 03:11:38PM +0000, Luis Machado wrote:
> On 2/28/24 16:10, Tobias Huschle wrote:
> > 
> > Questions:
> > 1. The kworker getting its negative lag occurs in the following scenario
> >    - kworker and a cgroup are supposed to execute on the same CPU
> >    - one task within the cgroup is executing and wakes up the kworker
> >    - kworker with 0 lag, gets picked immediately and finishes its
> >      execution within ~5000ns
> >    - on dequeue, kworker gets assigned a negative lag
> >    Is this expected behavior? With this short execution time, I would
> >    expect the kworker to be fine.
> 
> That strikes me as a bit odd as well. Have you been able to determine how a negative lag
> is assigned to the kworker after such a short runtime?
> 

I did some more trace reading though and found something.

What I observed if everything runs regularly:
- vhost and kworker run alternating on the same CPU
- if the kworker is done, it leaves the runqueue
- vhost wakes up the kworker if it needs it
--> this means:
  - vhost starts alone on an otherwise empty runqueue
  - it seems like it never gets dequeued
    (unless another unrelated task joins or migration hits)
  - if vhost wakes up the kworker, the kworker gets selected
  - vhost runtime > kworker runtime 
    --> kworker gets positive lag and gets selected immediately next time

What happens if it does go wrong:
From what I gather, there seem to be occasions where the vhost either
executes suprisingly quick, or the kworker surprinsingly slow. If these
outliers reach critical values, it can happen, that
   vhost runtime < kworker runtime
which now causes the kworker to get the negative lag.

In this case it seems like, that the vhost is very fast in waking up
the kworker. And coincidentally, the kworker takes, more time than usual
to finish. We speak of 4-digit to low 5-digit nanoseconds.

So, for these outliers, the scheduler extrapolates that the kworker 
out-consumes the vhost and should be slowed down, although in the majority
of other cases this does not happen.

Therefore this particular usecase would profit from being able to ignore
such outliers, or being able to ignore a certain amount of difference in the
lag values, i.e. introduce some grace value around the average runtime for
which lag is not accounted. But not sure if I like that idea.

So the negative lag can be somewhat justified, but for this particular case
it leads to a problem where one outlier can cause havoc. As mentioned in the
vhost discussion, it could also be argued that the vhost should not rely on 
the fact that the kworker gets always scheduled on wake up, since these
timing issues can always happen.

Hence, the two options:
- offer the alternative strategy which dismisses lag on wake up for workloads
  where we know that a task usually finishes faster than others but should
  not be punished by rare outliers (if that is predicatble, I don't know)
- require vhost to adress this issue on their side (if possible without 
  creating an armada of side effects)

(plus the third one mentioned above, but that requires a magic cutoff value, meh)

> I was looking at a different thread (https://lore.kernel.org/lkml/20240226082349.302363-1-yu.c.chen@intel.com/) that
> uncovers a potential overflow in the eligibility calculation. Though I don't think that is the case for this particular
> vhost problem.

Yea, the numbers I see do not look very overflowy.

