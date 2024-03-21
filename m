Return-Path: <linux-kernel+bounces-109808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0238855F4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2895D1F21B8D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931112A1C6;
	Thu, 21 Mar 2024 08:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WLHgw0Oc"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7961CD1E;
	Thu, 21 Mar 2024 08:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711010761; cv=none; b=XvpEklfknJgyVsVgUFpbgaPizJ+9JKhHUUt25/gYfubdccjaukBq4PP4YbNsF2L+wLUquOivw+uY6jPPmcGmZgcbJBYnT1X1Bw/SInGcAPw3EwfkvWBkiCNXk9H1PMpVmnYdTMleyoE6XV+FOQFwGS5oeiZ+Uw6dMq9dPwRWEEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711010761; c=relaxed/simple;
	bh=vY+pgNxP5agnZS3lZvczA7j/a5myVK7NY475boIDNL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A96jZQQiHesxXknOxe/AuYdl5++CRcb4t2TxR6Fjb86YhUMmPi7sO/SDXxzdw5nPR87/x5NmZ2IrHS40rjHMHN/BQXKC6fN6JNO9qasR02LmCp8swipjLf6we3y7AUsNCU7+LcIVJsXBspKMI/6CaBKQkNYD88eTqxpfBxxH/xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WLHgw0Oc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42L8VgFu006435;
	Thu, 21 Mar 2024 08:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=eON5wf8vXjUbhAWLa3fsuk9PyIi46INytgA4dC5vzVQ=;
 b=WLHgw0Ocq6Z0manE5cztoT1WoD+LXEfUa0QtTLvNJNv0/1KqRSXpRkxV1CojFnbUbI1k
 Z6D1JjqJWTHI0Yt/TEKujnfD0LG3YP17BOS4dKY/E4Arm0kthsQqhivq3Y0zZqEY87q2
 7w11pnYRlUTmM9Wf2lqETVpshSnxBS47iv2KNAhlxo3UmxXvXSf7t+xOynGSePuRzYPg
 5PobxeUVyxOrJ5LayeIPRFeg3YVqUA3Z4t3leqaWaAL7+T/mfEbA6CY3e3b2w6274sQw
 xgaLvzamiZiCjhWvLWGZkmga/xfukuYdNBoSAVE0R+zUeVQujoflpCWEX8Lp0I1zz/Kb zg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0hfb80vb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 08:45:14 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42L8jDBD028522;
	Thu, 21 Mar 2024 08:45:13 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0hfb80v4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 08:45:13 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42L7FR6h019872;
	Thu, 21 Mar 2024 08:45:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwqykum6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 08:45:12 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42L8j8RQ30999282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 08:45:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9324520040;
	Thu, 21 Mar 2024 08:45:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 531A32004B;
	Thu, 21 Mar 2024 08:45:07 +0000 (GMT)
Received: from heavy (unknown [9.171.8.38])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 21 Mar 2024 08:45:07 +0000 (GMT)
Date: Thu, 21 Mar 2024 09:45:05 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: verifier: prevent userspace memory access
Message-ID: <ed5cozsc7mduzmgbwrlw3lou4tlb6zpivhs2xrqwgpq2rhvkue@l7aifknll4tb>
References: <20240320105436.4781-1-puranjay12@gmail.com>
 <CAADnVQJ3o6DsURi=N_KXx+mbW9r7__3LrwYLyYwuoMOsqFHPkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJ3o6DsURi=N_KXx+mbW9r7__3LrwYLyYwuoMOsqFHPkw@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TYjvFxQwEBdE5__OC1dzjMlHjdsm_YEY
X-Proofpoint-GUID: Op4zlibBI5OweaTnIoIg1COwJwRAnpk3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_06,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=798 priorityscore=1501
 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403210059

On Wed, Mar 20, 2024 at 11:08:00PM -0700, Alexei Starovoitov wrote:
> On Wed, Mar 20, 2024 at 3:55 AM Puranjay Mohan <puranjay12@gmail.com> wrote:
> >
> > The JITs need to implement bpf_arch_uaddress_limit() to define where
> > the userspace addresses end for that architecture or TASK_SIZE is taken
> > as default.
> >
> > The implementation is as follows:
> >
> > REG_AX =  SRC_REG
> > if(offset)
> >         REG_AX += offset;
> > REG_AX >>= 32;
> > if (REG_AX <= (uaddress_limit >> 32))
> >         DST_REG = 0;
> > else
> >         DST_REG = *(size *)(SRC_REG + offset);
> 
> The patch looks good, but it seems to be causing s390 CI failures.
> 
> Ilya,
> could you help us understand is this check needed on s390
> and if so, what should be the uaddress_limit ?

s390x does not define ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE.
Userspace and kernel run in completely different and isolated address
spaces, so it's not possible to determine from a pointer value whether
it's a user or a kernel pointer.
But the good news is that whatever you deference without using
special instruction sequences will refer to the kernel address space.
So I wonder if we could somehow disable this check on s390x altogether?
And if we are not sure whether it's a valid pointer, use BPF_PROBE_MEM
as always.

