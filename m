Return-Path: <linux-kernel+bounces-106759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3810587F331
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 685581C214E7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEEC5A790;
	Mon, 18 Mar 2024 22:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i76FQw2J"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F75A1B94D;
	Mon, 18 Mar 2024 22:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710801778; cv=none; b=GZRZwc8mEbDb4txpqrCARyA6mbmlqWPryXqsdJ4pNyfDyU0eIqGXV2XtDdn3DbdLbzGxvRQTENoOaW892nmmJdimwk8r8PbOY3Xtiu5ugrOItYcqldy6cUUQqA9Mzvi/94pkFY0SDi23RWBOV8Q4ma7h3NfXwUR+5v4Kde3dVr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710801778; c=relaxed/simple;
	bh=rKcxt+Ifoji1aSSIkIDX0L22ddZFTEE1J5wDyZm5/Jg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XkmiL/OGQbicdbPYn7sH2dtSXda5w8eA7nSRkMj8YPBV1YDnnP/ByXmbaeptaqYpO5I3tnMytcvmEUaszSZpS+DZnvV9sv2t+oKikLJOv13CO5I2n/OdvHNcpbzdygm2yDb5rc31eHLUNuzSvhq6EPwvZF+lrEiD7zqcQb+5qcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i76FQw2J; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42IMetME032600;
	Mon, 18 Mar 2024 22:42:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=iPysDLdhbVVKcy20L/MPHXQLxk3DDciI1CVoRI7Mhs8=;
 b=i76FQw2JZohw1/8vyDaHqqg0gF58l8cwPxGYKmDDk02m/4UdpmMEglRe1cdDc28j1Zwx
 PAcreS8UCyFZIHAstUZsRN9yemw2CPPocNpyVvjpd3xladAbpdOTwAZ1cPHN40YUemw8
 4KKIVf2zEnRt7Do6M99HURPcbnBg6LdUhc3TxbEQopev6AyUImFD8zYyfNJSWsKJNTAc
 e088Ig2IBXspIkvl26zQtA8Dn512cQ5aiK3YBX0mXdZ3O8eefU2NM7aOP0Z97Sgp98wv
 7CfnvuPUrOh1wiFm9pz/85HTXh+6nSmctNlRquLL9PSspI0Xgta2OcxVORoNBX5Y6lNH VA== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wxxgbr0uq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 22:42:42 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42IK47pV010083;
	Mon, 18 Mar 2024 22:42:42 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wxvaurnnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 22:42:42 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42IMgdZq2884308
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Mar 2024 22:42:41 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C9795804B;
	Mon, 18 Mar 2024 22:42:39 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1BCB58055;
	Mon, 18 Mar 2024 22:42:37 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 Mar 2024 22:42:37 +0000 (GMT)
Message-ID: <d02eda40-2d3a-43a2-a3a9-cb79055acda7@linux.ibm.com>
Date: Mon, 18 Mar 2024 18:42:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/13] Add support for NIST P521 to ecdsa
Content-Language: en-US
To: Lukas Wunner <lukas@wunner.de>, Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br,
        bbhushan2@marvell.com, jarkko@kernel.org
References: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
 <ZfiMhi9D2Rhh89BI@wunner.de>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <ZfiMhi9D2Rhh89BI@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MskxMCOC4vKqeS8loHY-iCsPiuyozSZu
X-Proofpoint-ORIG-GUID: MskxMCOC4vKqeS8loHY-iCsPiuyozSZu
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=859
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403180172



On 3/18/24 14:48, Lukas Wunner wrote:
> On Tue, Mar 12, 2024 at 02:36:05PM -0400, Stefan Berger wrote:
>> This series adds support for the NIST P521 curve to the ecdsa module
>> to enable signature verification with it.
> 
> v6 of this series is still
> 
> Tested-by: Lukas Wunner <lukas@wunner.de>

Thanks.

> 
> as it successfully authenticates PCI devices with the
> "TPM_ALG_ECDSA_ECC_NIST_P521" SPDM asymmetric algorithm
> using my development branch:
> 
> https://github.com/l1k/linux/commits/doe
> 
> Thanks,
> 
> Lukas
> 

