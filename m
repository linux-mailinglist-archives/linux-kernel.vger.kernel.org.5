Return-Path: <linux-kernel+bounces-116990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE6A88A5DD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20E8C1F61CA3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B85156C59;
	Mon, 25 Mar 2024 12:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="m94wRtYy"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BD113BACB;
	Mon, 25 Mar 2024 12:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711369282; cv=none; b=rDFQ/lYsu6H276MfCNwsUnG2Fa6qNe1vsr611X9hcwXqPRydoUj/keVdjVkG5FSVqW/AqrO+wQH3bhEf0/6aLTixYWeBLXnbSx+3ydo+Iyumv6+OW9lIJbP7BdsEwK6/Ai8e4PJIqaymLE8zgMjp74fh+UHM3cwadod4FRR3jRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711369282; c=relaxed/simple;
	bh=YPO2WL6qypUgdkyYCnkzqyLMD/CgYwEAAIRUoFlpBGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCbSz6aBX+3zPtD0yCj85V2aRm8umc3oG00cK8MGlLRoybEr9sa8KkMUDdzwY1O6eLJaYKd74ZjQczzgNmbeLyLFcqH7Rzmt2N9h6+d23jblFt4EmyKhJHczhQo0aFcQOx2wlrgRK95yBVHaZ4KAtzwmFUr1Il0oylNhFP2Fbgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=m94wRtYy; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42PAFnfk019869;
	Mon, 25 Mar 2024 12:20:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=afp8tIN3gWCl7bSWhWw+40+8io7o5i4DQAiMbDPfbuY=;
 b=m94wRtYycklXwZW7cBCP6SIlP8FfESx6OE4dtbUZZYaHcmdt0AQbS+tJMyFlUQzQ3pZz
 L7am7bvZiPYv65jDipbbQWRju60zEh+vQMmZnjjTEOxLdGXOAvRnsyoCjdSx5HHW7ADq
 NPYunHRPIisKhVerLAnhfwEXixNC6CZnpI1RPZT12GlXNRYBIkwbk5+0qs7qADVpXB1u
 G4pKCb3PjOuv3mdne4vpUjpTYc7cLFw5EmBKErlw7zxr+0pvQ9k8SVroGCcMyHmiEsL9
 olgtC83YK6R+eJVqUqrW/Fp9UK/4EmKsCTm1+vqiq/gmyHGMrwyHy5wAbjxQvuz3zPLy BQ== 
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3x37c4rxny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 12:20:44 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 3BE7D12B5C;
	Mon, 25 Mar 2024 12:20:43 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 6A52F806B55;
	Mon, 25 Mar 2024 12:20:40 +0000 (UTC)
Date: Mon, 25 Mar 2024 07:20:37 -0500
From: Dimitri Sivanich <sivanich@hpe.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Steve Wahl <steve.wahl@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: Re: [PATCH] Allocate DMAR fault interrupts locally
Message-ID: <ZgFsFWlGxClzgGEb@hpe.com>
References: <Ze9r47riIq9ovBCY@hpe.com>
 <87plvjfl9s.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plvjfl9s.ffs@tglx>
X-Proofpoint-ORIG-GUID: 0o_zeOy2hiSmRC-D5lD2ShvuDsboQijw
X-Proofpoint-GUID: 0o_zeOy2hiSmRC-D5lD2ShvuDsboQijw
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_08,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=836
 impostorscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2403210000 definitions=main-2403250068

Thomas!

On Sun, Mar 24, 2024 at 09:05:35PM +0100, Thomas Gleixner wrote:
> Dimitri!
> 
> On Mon, Mar 11 2024 at 15:38, Dimitri Sivanich wrote:
> > On Thu, Feb 29, 2024 at 11:18:37PM +0100, Thomas Gleixner wrote:
> >> What you really want is a cpu hotplug state in the CPUHP_BP_PREPARE_DYN
> >> space which enables the interrupt for the node _before_ the first AP of
> >> the node is brought up. That will solve the problem nicely w/o any of
> >> the above issues.
> >>
> >
> > Initially this sounds like a good approach.  As things currently stand, however,
> > there are (at least) several problems with attempting to allocate interrupts on
> > cpus that are not running yet via the existing dmar_set_interrupt path.
> >
> > - The code relies on node_to_cpumask_map (cpumask_of_node()), which has been
> >   allocated, but not populated at the CPUHP_BP_PREPARE_DYN stage.
> >
> > - The irq_matrix cpumaps do not indicate being online or initialized yet, except
> >   for the boot cpu instance, of course.
> >
> > So things still revert to boot cpu allocation, until we exhaust the
> > vectors.
> 
> I thought about the following:
> 
>     CPUHP_BP_PREPARE_DYN allocates the hardware interrupt on the control
>     CPU (the boot CPU during early boot).
>     
>     CPUHP_AP_ONLINE_DYN moves it over to the AP. This needs to set
>     affinity and then retrigger the interrupt so that the horrible
>     non-remapped MSI migration logic is invoked.
> 
> Though that does not work for parallel bringup as then the prepare stage
> is invoked for all CPUs before any of them gets to the online phase,
> which obviously ends up with the same problem.
> 
> > Of course, running the dmar_set_interrupt code from a CPUHP_AP_ONLINE_DYN state
> > does work (although I believe there is a concurrency issue that could show up
> > with the current dmar_set_interrupt path).
> 
> Which concurrency issue? CPU hotplug is fully serialized.

Yes, which allowed a simpler iplementation for V2 of this patch than I first
thought.

> 
> > So the code seems to have been designed based on the assumption that it will be
> > run on an already active (though not necessarily fully onlined?) cpu.  To make
> > this work, any code based on that assumption would need to be fixed.  Otherwise,
> > a different approach is needed.
> 
> Yes, the interrupt vector code it is designed that way and for the
> general case this is absolutely the right thing to do.
> 
> Thanks,
> 
>         tglx

