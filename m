Return-Path: <linux-kernel+bounces-76718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 785BA85FB77
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 120F21F23E79
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08BE148FEE;
	Thu, 22 Feb 2024 14:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ePh/1mJx"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39AA146900;
	Thu, 22 Feb 2024 14:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708612895; cv=none; b=ClFXCtEv62/UY/1alAmZyFIT+ag+chIl/5oTu53UlkL51lpaBjj667s5aYorI9H1+ezteohGnEvKIwTdqWODWx3r3nJ0IYMENdH2NnZuP4uTdclsESImd4SjkIUKeURUWN0vKvdbrV5ESytmL689+3xfGBU1+GtIhewkaVPprsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708612895; c=relaxed/simple;
	bh=q6fetJ0AExiWalMdmM6s8b4qYxZrhUDwrcBwekf6GGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cIA6Kts9V7uIJMtkmIic/wWEaaoh1aiBb1zDksYZjBy5v7PvnyPkEKDvgMaRA+20f5HT+Qs2tGf5lPo0H8LQjwXUacStDp7sOZqLdCkGed4SpTUQYQ4n3lUVXOPftxefgSQ9hnJ93QD/m3DXn/sXDsNIkkIk6gv0Ngr1PDIBB70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ePh/1mJx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41MEMYUY029248;
	Thu, 22 Feb 2024 14:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=2FbUmTkNvpatRSD/X0RigoKpImk5kATvJtmRf+tdtRU=;
 b=ePh/1mJxO7c72r0/zLT3rTGqCZN6U2716t+yr+6Qk2DRdDVdzObYZ0LbMZiKqVZv1JQq
 rx9sOQXo5tPxtQ8agTS3OzqQDYFDUniXZiY+Hhk3Y0/IYrc3WrL73EQa1rS+1u3+ABi8
 ajYDZ9SER0rGWqiLrlXr2N4SygaRRkEJJ6FAqWFBCrnk5qNgdQiO1cweIf7yOakQMKS7
 4u7PKRJpThDzYBijKwQ1UWk/0FpdXU70fDosjZUqlMaXZNTriORx/l1pbzSbp0P2pCJD
 Xg4I4xDh/cKz7YYTBrV+GoJEHnRe2V8OLV+UlFNFesfl+g1JeoCm4cQCxSWTo1NO2ME+ OA== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3we7cxhwqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 14:41:30 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41MDUL0Y014390;
	Thu, 22 Feb 2024 14:41:29 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb9u2x82v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 14:41:29 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41MEfOAX6160996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 14:41:26 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23CD42004E;
	Thu, 22 Feb 2024 14:41:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB5EA20040;
	Thu, 22 Feb 2024 14:41:23 +0000 (GMT)
Received: from [9.152.224.128] (unknown [9.152.224.128])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Feb 2024 14:41:23 +0000 (GMT)
Message-ID: <b96f27a5-53fa-495b-b1a4-cff574898083@linux.ibm.com>
Date: Thu, 22 Feb 2024 15:41:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/af_iucv: fix virtual vs physical address confusion
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240215080500.2616848-1-agordeev@linux.ibm.com>
 <47789946-0ffe-462e-9e2e-43b03ea41fe0@linux.ibm.com>
 <20240221143115.6b04b62a@kernel.org>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20240221143115.6b04b62a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 57L79kqtnc2jyl8ajdmgwNGZtjAKrHkT
X-Proofpoint-ORIG-GUID: 57L79kqtnc2jyl8ajdmgwNGZtjAKrHkT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_11,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 malwarescore=0
 adultscore=0 impostorscore=0 mlxlogscore=618 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402220116



On 21.02.24 23:31, Jakub Kicinski wrote:
> On Thu, 15 Feb 2024 14:36:57 +0100 Alexandra Winter wrote:
>> I would have preferred to do all the translations in __iucv_* functions in iucv.c,
>> but I understand that for __iucv_message_receive() this would mean significant changes. 
> 
> FWIW we're assuming this is going via the s390 tree.
> Please let us know if you prefer networking to pick it up.
> 

Hello Jakub and maintainers,

please take this patch via net-next, as it belongs to the net/iucv module.
Please excuse that it was not flagged with [PATCH net-next]

Kind regards
Alexandra

