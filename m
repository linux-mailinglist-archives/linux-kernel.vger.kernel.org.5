Return-Path: <linux-kernel+bounces-57558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6B684DAB4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E0C61C23962
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829FA69970;
	Thu,  8 Feb 2024 07:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dRLt9hr/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D25C67A0F;
	Thu,  8 Feb 2024 07:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707377493; cv=none; b=NGADtznBzbzVOfq/6KswFBPF+CsN103LSl1tJfy0BIr7lRsp5Qb9iLHAqkRm0op7KaUdYmdu/xcLWfQQkPuL7KA/2Cbc17qsoIBlDEdjJqsWKTeao79PgZY2lgd56QArsoEBQIDqwkXg5OK+KkykEeqSX45oPlsA/PaC8WTECsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707377493; c=relaxed/simple;
	bh=SNhkKnZ7sr8GDFAjdsVQk/H/wcAOE3G/rN1aQC5b0dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VQTM8wjQMcxj9DLjtV40+ONtU5ZQwjcULfU7mVqz9kChvgvsmcEWVeIXu1yRxq9UDspLKoDuwd3IuaEuFXZCMD23YtYIupDsJ+9Rm/Y8c6lgOkvtkGyGAYCk2t15s5DJSfMwCs/tIo+ZGhOICZTIDY8J+yRdKudu2gNShAVGK+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dRLt9hr/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41860Bac027492;
	Thu, 8 Feb 2024 07:31:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=lzbz1GNhahpMkNP7h5Kr7JjPzEoxKQtweREGWC1/SkI=; b=dR
	Lt9hr/Y7IGmbQO8ifGuJr+PGXoa56JHkFBG1CZwuR7I0RD3fCZOYEQP6MWhdfUgf
	EqAEZKJs6ShghWTBYT3uk9vAt6b3OyHsqvjFKgHpwDeZnwQ9cNcz0SYu4HIy5cgX
	VkcHQtm3k3+DTJ8bEgh8jraWoBIPv/TE8XdzctqPDHEdg3EAirvV6ttCvvEJQVOi
	90s9f/q2pt2EpK0acS70y7eahmFLj1N7LLTP+/zDYQGKX7u0rvlxhy6tI1J7LK4O
	FzMOMIOG4ZTtEmJFzan9XWp88Ix5ooCvhNdAWDG70td4Fp55FX2kMqJTyaBqUXqy
	MlhPKlKfxPbrmYZ2Sp2Q==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w4frwse51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 07:31:26 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4187VPXE017903
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 Feb 2024 07:31:25 GMT
Received: from [10.239.132.150] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 7 Feb
 2024 23:31:20 -0800
Message-ID: <84de6e73-31a1-4ae2-afe1-71e9947a22c0@quicinc.com>
Date: Thu, 8 Feb 2024 15:31:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] pinctrl: Add lock to ensure the state atomization
Content-Language: en-US
To: Linus Walleij <linus.walleij@linaro.org>
CC: <andersson@kernel.org>, <kernel@quicinc.com>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20240202105854.26446-1-quic_aiquny@quicinc.com>
 <CACRpkdZM96tji2OCXHPd9iXE1kU5u1TGsuPhB0YLbHG=LXAiqg@mail.gmail.com>
From: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>
In-Reply-To: <CACRpkdZM96tji2OCXHPd9iXE1kU5u1TGsuPhB0YLbHG=LXAiqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0OuElrODJEJaWKo016xQk7bkhnlT5F_3
X-Proofpoint-GUID: 0OuElrODJEJaWKo016xQk7bkhnlT5F_3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_01,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=826 adultscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402080038



On 2/7/2024 6:51 PM, Linus Walleij wrote:
> On Fri, Feb 2, 2024 at 11:59 AM Maria Yu <quic_aiquny@quicinc.com> wrote:
> 
>> Currently pinctrl_select_state is an export symbol and don't have
>> effective re-entrance protect design. During async probing of devices
>> it's possible to end up in pinctrl_select_state() from multiple
>> contexts simultaneously, so make it thread safe.
>> More over, when the real racy happened, the system frequently have
>> printk message like:
>>    "not freeing pin xx (xxx) as part of deactivating group xxx - it is
>> already used for some other setting".
>> Finally the system crashed after the flood log.
>> Add per pinctrl lock to ensure the old state and new state transition
>> atomization.
>> Also move dev error print message outside the region with interrupts
>> disabled.
>> Use scoped guard to simplify the lock protection needed code.
>>
>> Fixes: 4198a9b57106 ("pinctrl: avoid reload of p state in list iteration")
>> Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
> 
> Thank you for rebasing!
> 
> Patch applied now, so we get some shakeout in linux-next and can
> make sure it works for everyone.
Feel free to add me into any thread related. Also I will try to pay 
attention from the email list.

:)
> 
> Yours,
> Linus Walleij

-- 
Thx and BRs,
Aiqun(Maria) Yu

