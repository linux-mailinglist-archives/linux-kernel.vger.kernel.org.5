Return-Path: <linux-kernel+bounces-61883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9948A8517CF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D9FE280632
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CDB3C478;
	Mon, 12 Feb 2024 15:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BSh4cTTp"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E29E3C680;
	Mon, 12 Feb 2024 15:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707751198; cv=none; b=pBadYDq6N578ul6u6U/DmuMAEvAAZqM+E4of0fsDR3Z5pOIT38aC9MejaovsnOTrFsrIagiSVhdVyZb1nuebNYCl8ECM0OT94R0TleNu46sRp+945wVRktA/Mt5JM2lh5AcKJDAr0eHmkKF3lWGU6/+Cs3tl1kSX0NWp6Sp5ghU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707751198; c=relaxed/simple;
	bh=ZeRAJLXnOrarwVuFVCgiWBb2EBcg6ZUwSd2FOEzYv8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkFZb8AwkIY9WRtd7QFm/l7u0Zb/9teIMceZG8OuMnxbuGc/gjtZ6Otzj1F8b7FU/v6PwMlqYvnzaYUYkChcASDK3iiLWFozo91/EYm57wJ4OTraAToKpSZ9dZNk80kwU6+2yZFibkGvQpcetmrbx3FxLHjzlEWgXKQ+D3VXN4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BSh4cTTp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41CF8aFg016651;
	Mon, 12 Feb 2024 15:19:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=aT/kgplriDWlq76xWaEayWNC60N8uxsgPfrSfFD9TOE=;
 b=BSh4cTTphZKGDakyiQlXK5WzTwQNJUTFUi8D+qT0dtJdeBLcBRa+sQyaiMAqKc5Gv6Co
 ZhrSJbb/v89wd9WXi5cjv2u/EmlLc2w+ABPKpKCYCeCmfe8aoUBkwcE1+p3thwM+gf+6
 TN/ewLbBcF2SV3FbDU9tR239vDjDsY8YUoQ/rs5khBPUmo3h5GjnYc6cWig+LysNnjEX
 nvVM3I+jI/iH/xp/VLs8iDp/7pKi9GCTa4kHgsuz+CQWo/xArR1ZUZ4PgMjLWr+mKOi+
 OssEJLvbO5Kn6DpF2SxSpEtYKjA99y5IsguIGDax/KP6hXfriybroVSIri1AZqgEv1YN Ag== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7nq6gess-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 15:19:53 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41CF9Axs017776;
	Mon, 12 Feb 2024 15:19:53 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7nq6gesj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 15:19:53 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41CCj1W7004254;
	Mon, 12 Feb 2024 15:19:52 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6kv01fx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 15:19:52 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41CFJlpO2359922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 15:19:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 601822004B;
	Mon, 12 Feb 2024 15:19:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A912920043;
	Mon, 12 Feb 2024 15:19:46 +0000 (GMT)
Received: from osiris (unknown [9.171.5.16])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 Feb 2024 15:19:46 +0000 (GMT)
Date: Mon, 12 Feb 2024 16:19:45 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Nathan Chancellor <nathan@kernel.org>, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        maskray@google.com, ndesaulniers@google.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH 04/11] s390: vmlinux.lds.S: Discard unnecessary sections
Message-ID: <20240212151945.65142-B-hca@linux.ibm.com>
References: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org>
 <20240207-s390-lld-and-orphan-warn-v1-4-8a665b3346ab@kernel.org>
 <20240212135511.65142-A-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212135511.65142-A-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GAVJlrA3BjnldXFXjHWd-HD91RbMQErb
X-Proofpoint-GUID: RmgLZx_myTMtF7GpfGrgK_hJ9uwp-I14
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_12,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 suspectscore=0 mlxscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=416 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2402120115

On Mon, Feb 12, 2024 at 02:55:11PM +0100, Heiko Carstens wrote:
> Explicitly keep those sections like other architectures when
> CONFIG_RELOCATABLE is enabled, which is always true for s390.
..
> +	.dynstr ALIGN(8) : {
> +		*(.dynstr)
> +	}

Except for this, which is already present (copy-paste-error).

