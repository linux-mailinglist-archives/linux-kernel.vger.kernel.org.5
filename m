Return-Path: <linux-kernel+bounces-81937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CFB867C78
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5F4E1F27B06
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D4612C80F;
	Mon, 26 Feb 2024 16:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O1Fo3E7g"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B5F60B9F;
	Mon, 26 Feb 2024 16:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966178; cv=none; b=UV+p8mXZyF4rPJC7HWrO2HOSiqb1s+SGKUx4m86AAM9QfHv6BzQd1rh2u+dyjY8srIX7mdFjazzCBkTn2Y1lpMAoGSybV7ZudppIDbEhzFsjAPLn8TtEwR7H/ms5a9RmHi29PpVHSEA/K3rkaru89sQITGpDPxNxNgS2/3rwM7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966178; c=relaxed/simple;
	bh=qgSbrEvPXdgNiC/UJm11zFW9tgsbpt+8ylKHzAn/bhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HR6m684adtXxOtAEjubArg48RXaO8Uy1GOm2XZlv9PBmtNsPSb8NefK8ln5IqN8VvV0HogugPNAvMxJDsM+tR1tHEkFQttOUQbK7+5t42CAdBEsfb3mhBKWFmiY2vOokzcj+8GYrfCWpYodxZFpHtaQ8+Nvnj3bu9MOl00IokOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=O1Fo3E7g; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41QGh0Rl003527;
	Mon, 26 Feb 2024 16:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=UdqOq7Lx+mxt1cvwHHbViM4XUO6JWwWx781fxPxQPO8=;
 b=O1Fo3E7gRgmssVTQRm+zDcPE9BpTYK/yPOvocD7WgmNGodQHNg+OeqrNokSZNOiwyCp8
 m7ygfj4PjDSeAx6CMEaZJL8TVJwtfNTFzT80cUp2/1LQGU7jDOpev7yuP9kadDVYHM/x
 4ozFtXiCDlvs4yXpt19HRFM66QF12FWV59nGIdfehej6zwCgZWcTuQ2uaV1cEamF5cCJ
 S9Lgn0cNvnfi0w5ld/FyXw9tUfAnatrm4+nVnlPT/0DAnbcurzsTRto8abt8NcJgfJpI
 R0UIkMuWAG+RwasK9nS2lYyfdL+DWTQXYMPN7hH5oNvYPtl8UhhL8fyjy/hBZ9UhKB+2 fg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wgxdfr3gg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 16:47:07 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41QGjEsc011226;
	Mon, 26 Feb 2024 16:47:07 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wgxdfr3fu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 16:47:07 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41QF8J1a021278;
	Mon, 26 Feb 2024 16:47:06 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfusntdaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 16:47:05 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41QGl14M24183328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 16:47:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CAC892004B;
	Mon, 26 Feb 2024 16:47:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8799C20040;
	Mon, 26 Feb 2024 16:47:00 +0000 (GMT)
Received: from [9.171.38.134] (unknown [9.171.38.134])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Feb 2024 16:47:00 +0000 (GMT)
Message-ID: <f7f47717-276f-47f5-af7d-4117b2eb1338@linux.ibm.com>
Date: Mon, 26 Feb 2024 17:47:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 06/13] net: Add struct kernel_ethtool_ts_info
To: Kory Maincent <kory.maincent@bootlin.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King
 <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>
References: <20240226-feature_ptp_netnext-v9-0-455611549f21@bootlin.com>
 <20240226-feature_ptp_netnext-v9-6-455611549f21@bootlin.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20240226-feature_ptp_netnext-v9-6-455611549f21@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LQqKCQFvXnND9bQqkLWZGehnxJwN6suK
X-Proofpoint-ORIG-GUID: GCCOKM-MW73RDG1Trk6kCKNNLXEvb2s1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 impostorscore=0 clxscore=1011 bulkscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402260127



On 26.02.24 14:39, Kory Maincent wrote:
> In prevision to add new UAPI for hwtstamp we will be limited to the struct
> ethtool_ts_info that is currently passed in fixed binary format through the
> ETHTOOL_GET_TS_INFO ethtool ioctl. It would be good if new kernel code
> already started operating on an extensible kernel variant of that
> structure, similar in concept to struct kernel_hwtstamp_config vs struct
> hwtstamp_config.
> 
> Since struct ethtool_ts_info is in include/uapi/linux/ethtool.h, here
> we introduce the kernel-only structure in include/linux/ethtool.h.
> The manual copy is then made in the function called by ETHTOOL_GET_TS_INFO.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---

For drivers/s390/net/qeth_ethtool.c  :
Acked-by: Alexandra Winter <wintera@linux.ibm.com>

