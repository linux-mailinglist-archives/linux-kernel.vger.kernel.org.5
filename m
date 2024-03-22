Return-Path: <linux-kernel+bounces-111914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA0F887294
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F192AB2465F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8015D62163;
	Fri, 22 Mar 2024 18:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="CSNa1Xb7"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582CE6168B;
	Fri, 22 Mar 2024 18:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711130832; cv=none; b=n3QO15IBXzyg6qEIzhZQSDrW9D240KmIOADYzf3ObFBqM53bezEfYDK0z0aL1g1fI05IVMvx26gEpUcxTaDknPedjgAQmHAnzcQzofsKYloC+Khru4onKUjQUcI/CW5BwSE1n/e9KRFZobeaTB+mjJtUL0hs2uh8HnZMISb3KWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711130832; c=relaxed/simple;
	bh=9SCemixHaPIQTMmMO0MIZkvrCKGmeAXj1EIQqh1Tlto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTUw4SXJ0Qe83XNz5MgQQN7SonhOj0MaERbd4mjLIJGIY4YIk9a99LgibRhPHIskVmmn0ojzeoWXp7mPIkVgka+9szT1NmI3P0KhtoEnV0taS4TPNYy0CGN4mjUrajhYwArQorqjpFsGTdmlPUGJw7TNDdcM+aE5TrwOBv7sSWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=CSNa1Xb7; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42MDlD4i003362;
	Fri, 22 Mar 2024 18:06:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=noi4Ni8/8f6ogQ9HUQ1rGTOkWtvWPwM/bipZwxEfTLQ=;
 b=CSNa1Xb7/gkVovPY4vFozG4DSg7RR/BrYiC3MWx3mL8sts6pxqa4LbuHlNkW6rmLUgBR
 pB9PWcS9ytvFxC2T2eJ0Mhi48t6uYOo13uM6+v1IR6EzIA+eq9onskR3AxRREbU8w+9g
 nV51nQ2SEVNS5MNu7JNgpHt3fAb4Lawg8C3mzYB8zYyM7jUoLV2pD0Gpbs+JPP17/v+f
 Ap/oNpIOwyapz+WaBQoa8aW0YG0uJap/TktRDeohJWV5zcd2JCh2w8KC6f6+QKEjjS3e
 exu+I1MDPod+ZuiuRSmsIlHc0PSjeAMtPObM967OnliZKi0cB9CUN54oxew64Snqvpj4 VQ== 
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3x0wy88msj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 18:06:40 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 3BA3C80020F;
	Fri, 22 Mar 2024 18:06:39 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 9BFAC80044B;
	Fri, 22 Mar 2024 18:06:34 +0000 (UTC)
Date: Fri, 22 Mar 2024 13:06:32 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Pavin Joseph <me@pavinjoseph.com>, stable@vger.kernel.org,
        Eric Hagberg <ehagberg@gmail.com>, Simon Horman <horms@verge.net.au>,
        Dave Young <dyoung@redhat.com>, Sarah Brofeldt <srhb@dbc.dk>,
        Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>
Subject: Re: [PATCH] x86/mm/ident_map: Use full gbpages in identity maps
 except on UV platform.
Message-ID: <Zf3IqJaGlS9HMdHN@swahl-home.5wahls.com>
References: <20240322162135.3984233-1-steve.wahl@hpe.com>
 <003f1e83-fd93-4f4f-a316-d3e89e5a23a5@intel.com>
 <87le6ab2bn.fsf@email.froward.int.ebiederm.org>
 <2f8d726a-9800-4068-9c0c-6c4a79d69a85@intel.com>
 <01e64b89-8d30-45c5-9b83-f2e4d81b6344@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01e64b89-8d30-45c5-9b83-f2e4d81b6344@intel.com>
X-Proofpoint-ORIG-GUID: _Y6kqVOuCd3PhIivrnYwng4jGkjrEVjb
X-Proofpoint-GUID: _Y6kqVOuCd3PhIivrnYwng4jGkjrEVjb
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_10,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=813 spamscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403220130

On Fri, Mar 22, 2024 at 10:43:36AM -0700, Dave Hansen wrote:
> On 3/22/24 10:40, Dave Hansen wrote:
> >  * Mapping extra memory on UV systems causes halts[1]
> >  * Mapping extra memory on UV systems breaks kexec (this thread)
> 
> Sorry, I said that second one backwards:
> 
>  * _Not_ mapping extra memory on UV systems breaks kexec

Not quite.  This is * _Not_ mapping extra memory on _non_ UV systems
breaks kexec.

Thanks,

--> Steve

-- 
Steve Wahl, Hewlett Packard Enterprise

