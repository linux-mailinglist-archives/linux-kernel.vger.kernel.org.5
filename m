Return-Path: <linux-kernel+bounces-39304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB4283CE7A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D03241F28729
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769BE13A272;
	Thu, 25 Jan 2024 21:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oDdGM3I/"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B32D13A242;
	Thu, 25 Jan 2024 21:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706217892; cv=none; b=pSEPLFxIfW05rskpy3nb2jLm2IQTMSLix/HN40WH3wNNekOMfirz27sxw0UV1Lrgk5BrXAmwkBAOaPAIW0EAcz1l51zmeKg51m8PcYF03vQaOWDsYfQQA0DGq4n3fmnwkdC1OoOvwqpA54kJCSjpBOUFT0FB/EULxXbvawf0Or8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706217892; c=relaxed/simple;
	bh=wF7lnyES1kcFW+pAAffY+2WrYEqI4AmwamSHD36HjYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uIdbdaRqeNF3FpIaZHeRRSH1lR0tafzQ0lxW961wpxzkeZ3tOoIxE5hUQHhWC7RV8TOrifuhDJq0G2gIshsLMC7f+voTZYRVhFo/uUOPTyrAg1gOpLFk11MY2PLyTkL+2sexedZTCoyNpyfi9kJWclI+fRJnLx98gL3r+jS6y1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oDdGM3I/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40PKOsK4003822;
	Thu, 25 Jan 2024 21:24:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=X4knlC7JqfUtxkp4byTD9WxtEc2D+QZ0DzKaY+9nXvc=;
 b=oDdGM3I/PlfVC3eEYZJUWpkehZIryqK8YI6DAmCPcpEmCGf4pqftn47xiYbX4I7mmDOG
 mWVnRwSabJfoF9QpArNrWfY/InQYzcZ5hdnhb5woY8A5JFE8sbFcU0DDTf7XYFPTz5X/
 kJ9toCpuWfdhs4ggGVSk8NYmLxwM9rTkg4iUjtxo7J2Oy4ebV9/GspiEZT8SYzQqFWkh
 V07dOnACOV4aDFftBOFcdUS3NH95HyQVxXcsepxWQj6FCYVtMYyNTbflCr9mtiPH1m/v
 n2jWNelNZqAuf8t/XmDixav+MiajfrHtUbKmydnzda+WTCr4zTfigZsc3+FtdHiYmqgF 3Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vuvv0v9fe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 21:24:00 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40PLEhiB000766;
	Thu, 25 Jan 2024 21:23:59 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vuvv0v9es-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 21:23:59 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40PK3JJQ025291;
	Thu, 25 Jan 2024 21:23:58 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vrtqkpdva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 21:23:58 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40PLNvY125887374
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 21:23:58 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB36F58055;
	Thu, 25 Jan 2024 21:23:57 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C17B358043;
	Thu, 25 Jan 2024 21:23:56 +0000 (GMT)
Received: from [9.61.160.70] (unknown [9.61.160.70])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 25 Jan 2024 21:23:56 +0000 (GMT)
Message-ID: <b5b0e7bd-25e5-49a4-8ac2-349020c2344b@linux.ibm.com>
Date: Thu, 25 Jan 2024 15:23:56 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] ARM: dts: aspeed: System1: IBM system1 BMC board
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        joel@jms.id.au, andrew@codeconstruct.com.au, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, keescook@chromium.org,
        tony.luck@intel.com, gpiccoli@igalia.com,
        johannes.holland@infineon.com, linux@roeck-us.net, broonie@kernel.org,
        andre.werner@systec-electronic.com,
        Andrew Geissler <geissonator@yahoo.com>, patrick.rudolph@9elements.com,
        vincent@vtremblay.dev, peteryin.openbmc@gmail.com, lakshmiy@us.ibm.com,
        bhelgaas@google.com, naresh.solanki@9elements.com,
        alexander.stein@ew.tq-group.com, festevam@denx.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org,
        geert+renesas@glider.be, luca.ceresoli@bootlin.com
References: <20240116190321.GA102334@bhelgaas>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <20240116190321.GA102334@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wUZ0cU7yrFT0wEjuA747LiOyYUO_dYd_
X-Proofpoint-GUID: HJm4xSjPhV2NU6Q64V5KJgHDqN0uwgdU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 adultscore=0 phishscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401250154

Hello Bjorn,

On 1/16/24 13:03, Bjorn Helgaas wrote:
> On Tue, Jan 16, 2024 at 12:37:34PM -0600, Ninad Palsule wrote:
>> From: Andrew Geissler <geissonator@yahoo.com>
>>
>> Add a device tree for IBM system1 BMC board. It uses AST2600 SOC.
>> - Added base board
> s/Added/Add/ to match first sentence.
Fixed
>
>> - Added i2c devices and muxes.
>> - Added different voltage regulators.
>> - Added GPIO pin assignements, GPIO expansion devices
>> - Added LED brinker devices
> "brinker"?  "blinker" maybe (no idea what it actually is).
Fixed. Its blinker.
>> - Added Fan controllers
> s/Fan/fan/
Fixed.
>
>> - Added EEPROM/VPD
>> - Added Power supplies
> s/Power/power/
Fixed.
>
>> - Added Humidity, pressure and temperature sensors.
> s/Humidity/humidity/
Fixed.
>
>> - Added Trusted platform module(TPM) chip.
> s/Trusted platform module/Trusted Platform Module /
Fixed
>
>> Tested:
>>      This board is tested using the simics simulator.
>>
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>> Signed-off-by: Andrew Geissler <geissonator@yahoo.com>
> Your sign-off should be last since you are sending the series.

Fixed.

Thanks for the review.

Regards,

Ninad Palsule



