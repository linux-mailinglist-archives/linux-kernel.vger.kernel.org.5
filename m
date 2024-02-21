Return-Path: <linux-kernel+bounces-74900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3462A85DFC2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6616C1C2404F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C937FBB2;
	Wed, 21 Feb 2024 14:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="QiZQHm2A"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957CF78B5E
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 14:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525947; cv=none; b=sHZ8IqrSnejQ7/qjpF7ASd6k7ooChMlAcQpqdtGDltUUpuaBvBeNyjY0b80xHHP0S7uOEuvJ1yF+WYrIM55gecQKWGci6ON2RP3gjkvwD+aEuZNLt+XgiCBMIzFA137Tl00bf7ii1S9RZ/atZEC2w4o3dmSzyozcYX+SKiEPfQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525947; c=relaxed/simple;
	bh=A8tZrzARhDzSrJvFwMxR+MdZZC7cYSQdLi2blDB1wa0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Zex+W839sRTPq955eqjkJc0Dm8IkLVgW9mSyzqLeNH2p8rHo5fKyA99wks9CmauA7s5sOyP2svh2PnevBq17nrRV0VGEW11mCF6u7n6OlE3TlgF+QMT2Rd+wjcUkIjnV3tCZEN88OiFRUVaLeIR+yA6B0L3aBSqign8eavm31mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=QiZQHm2A; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41L9WIHP029001;
	Wed, 21 Feb 2024 14:32:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : mime-version : content-type : in-reply-to;
 s=pps0720; bh=/iv4ThsUnofZrp6dBFEzAeN+gu67jIY2EunvYP4Mqns=;
 b=QiZQHm2ATy+WpXFBZOqA5MKwuHiJ4tHrPID5SrQv4sHZidH21NOAe+X/PzIl5G+6F7bG
 qcp6MJ6k1bEAxsBjEez3U3cLGKZ6W2cgt1sjeL9pGiXjlHb6BCh+vQyqbH/PlAKMazFM
 D8y3rMZZn+XDJ+5WIA4z5spHggUQ0UBIxXFs7EScJz7nSm22fj1ZXVxjyMte6C3vUDFP
 taM9V5aZmtr6u/33ajel4jroqoh1Wk+L/EgwpwkiuRyGb6r5h+zdDN4iigIT68nIkUi3
 Gc0ZYFlWS2HXJVcLjRZNaf+fM46ErbL5Masbvfz9/tCEqX3XYO6qV+SRzF8xXz/iZFUd bg== 
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3wd3dh125t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 14:32:12 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 15ADA13794;
	Wed, 21 Feb 2024 14:32:12 +0000 (UTC)
Received: from localhost (unknown [16.231.227.39])
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 9EF5E800466;
	Wed, 21 Feb 2024 14:32:11 +0000 (UTC)
Date: Wed, 21 Feb 2024 22:32:10 +0800
From: Keng-Yu Lin <keng-yu.lin@hpe.com>
To: gregkh@linuxfoundation.org, matt.hsiao@hpe.com
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de
Subject: Re: [PATCH] MAINTAINERS: change the maintainer for hpilo driver
Message-ID: <ZdYJag6SKHmU027h@tarheel.asiapacific.hpqcorp.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024022107-amuck-festival-873f@gregkh>
X-Proofpoint-ORIG-GUID: WU1u4KOW7fcNv6Pzj3JWLGI6cklqdWur
X-Proofpoint-GUID: WU1u4KOW7fcNv6Pzj3JWLGI6cklqdWur
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_01,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 mlxlogscore=401 mlxscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402210113

On Wed, 21 Feb 2024 08:02:27 +0100, gregkh@linuxfoundation.org wrote:
> Great, but I need an ack from Keng-Yu for obvious reasons :)
> 
> thanks,
> 
> greg k-h

Sure, no problem.

Acked-by: Keng-Yu Lin <keng-yu.lin@hpe.com>

