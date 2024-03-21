Return-Path: <linux-kernel+bounces-110017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E348A8858F0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20C3E1C21386
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C28175811;
	Thu, 21 Mar 2024 12:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pbxcKG74"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335487603D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 12:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711023541; cv=none; b=SHiID9OseFkRVvGgNX61Cc4aDEFRuAviSXmjX9T4h8PudKlYULLFrQcJBSrhCk9o8jBEMHizfPYPXqI5Vf0j9AFbDrGOz7FTlRN56fFSSAqR52ueOPsHxHzWELaNg05jfDG/7TBYYitqbzO7AVQEQQYUUJZdMQ5IDHoR0jEyRgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711023541; c=relaxed/simple;
	bh=Bmaj9jZHb6ssuXbAoO8kcltlmCaT2xFcXoFyCB79y1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDKwem6AeTdBO3p7o9MQU+ddvOQRpB1An31WvPX6XZ+dgT2gVOmB5H2Zx28Tpg8yliFrtm1ssBVQsBTyQTtFnfZlFgItvOH+PYz9k8Ma1wxkKrdjqd6D3/ZtNJMXEOMONevmVdKdUSkQMXbfvP+2g2Wf3WCGblm1EGR8c8i7RbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pbxcKG74; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42LBbtDm018953;
	Thu, 21 Mar 2024 12:18:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=X62us59Pvqeqmm1GjmKBYwVbjEXqdctN/u1yZ3LFFdI=;
 b=pbxcKG74TNPUnWhKLBm2QZOQayYdqwj1yl6C0AopzCPBbjD9aN59RCkwFr1Kop3osXN2
 B4kt+vqPWwedAJRH+sBh5nbQoyijoLMuH0sjGa61RbXmJmPaJQ1JJQHZH4TT1dipjZfn
 dBXAiba+gZHbuQk8hAcqBN8HRPkFFJCkj4GKBaSQRQX4IIK1v+pnXU+U1mwFvXZBJdCt
 Zyo3swc8vseqw4KigW/ySg2YPiLd5kFXrAkZFY8lYnkl5aM8BL12/mPUjc59km/UAIya
 HHmtmDE+ZXiYuZKrwi3A7ncSqRD3YPE0HNYLIzUNsAaOMylvutmHr+S8C4kpUJydGGc7 wg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0hwv0e7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 12:18:45 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42LCIioG018156;
	Thu, 21 Mar 2024 12:18:45 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0hwv0e7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 12:18:44 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42L9v2d0011615;
	Thu, 21 Mar 2024 12:18:44 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wwq8mcu5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 12:18:44 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42LCIex341812296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 12:18:42 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E1742004E;
	Thu, 21 Mar 2024 12:18:40 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BFE7C20040;
	Thu, 21 Mar 2024 12:18:39 +0000 (GMT)
Received: from DESKTOP-2CCOB1S. (unknown [9.171.204.154])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 21 Mar 2024 12:18:39 +0000 (GMT)
Date: Thu, 21 Mar 2024 13:18:38 +0100
From: Tobias Huschle <huschle@linux.ibm.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Luis Machado <luis.machado@arm.com>, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        sshegde@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org, nd <nd@arm.com>
Subject: Re: [RFC] sched/eevdf: sched feature to dismiss lag on wakeup
Message-ID: <ZfwlnqGsICGc1fOr@DESKTOP-2CCOB1S.>
References: <20240228161018.14253-1-huschle@linux.ibm.com>
 <5a32e8e1-67cf-4296-a655-f0fc35dc880a@arm.com>
 <ZfL/hROYxQudcTuX@DESKTOP-2CCOB1S.>
 <66c4286e-deaf-44a0-be62-0928529ae73f@arm.com>
 <4b25ab45b762e64b9df09d4d12d8289f@linux.ibm.com>
 <CAKfTPtDyrsnq-CSFo+upzdOJpuH=JkRzSALad-OL29OvqkK2dg@mail.gmail.com>
 <65fa8a7c.050a0220.c8ec5.0278SMTPIN_ADDED_BROKEN@mx.google.com>
 <CAKfTPtBA7ECeYJYdzL9ybeXLbpEudLfB6V9s+DZiJUmpnPf_kQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBA7ECeYJYdzL9ybeXLbpEudLfB6V9s+DZiJUmpnPf_kQ@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ESasaKX97QiUdCbjWjCk4eq2vYhB8I1A
X-Proofpoint-ORIG-GUID: IaiJkQbwVe71r9Guni3BnrsUfF9eqTYm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 mlxlogscore=639 impostorscore=0 mlxscore=0 suspectscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403210086

On Wed, Mar 20, 2024 at 02:51:00PM +0100, Vincent Guittot wrote:
> On Wed, 20 Mar 2024 at 08:04, Tobias Huschle <huschle@linux.ibm.com> wrote:
> > There was no guarantee of course. place_entity was reducing the vruntime of
> > woken up tasks though, giving it a slight boost, right?. For the scenario
> 
> It was rather the opposite, It was ensuring that long sleeping tasks
> will not get too much bonus because of vruntime too far in the past.
> This is similar although not exactly the same intent as the lag. The
> bonus was up to 24ms previously whereas it's not more than a slice now
> 

I might have gotten this quite wrong then. I was looking at place_entity
and saw that non-initial placements get their vruntime reduced via

    vruntime -= thresh;

which would mean that the placed task would have a vruntime smaller than
cfs_rq->min_vruntime, based on pre-EEVDF behavior, last seen at:

   af4cf40470c2 sched/fair: Add cfs_rq::avg_vruntime

If there was no such benefit for woken up tasks. Then the scenario I observed
is just conincidentally worse with EEVDF, which can happen when exchanging an
algorithm I suppose. Or EEVDF just exposes a so far hidden problem in that 
scenario.

