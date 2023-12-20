Return-Path: <linux-kernel+bounces-7617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EB381AADE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C07EA2849B0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A5A4F1E4;
	Wed, 20 Dec 2023 23:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pBlhEnae"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9948C4EB41;
	Wed, 20 Dec 2023 23:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BKLtXiO005819;
	Wed, 20 Dec 2023 23:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=JhE7DMqgpFwz11VwQEbJY74dNI53kJxfKPO8LV7SDso=; b=pB
	lhEnaeJB6XKVYZksz6sRkKrfm9xHmQLqfw5x4SLkiOAgZ4lLRw0NKQ/Ym15jFl+v
	PDUmR6XwHEUP9mQfyU6vqP+B7hj2YDktjRuNBsRFIK1thzrRIeT5ukz/bFmvlEec
	gPMIeahZGAi6St1xw3qPBFGFOoLWHM2wBYlBOHHdAMmK2lz6UgMAupQWGzvhSmSB
	n+QrIA1+zzObN9q6Q+3TAMKci6t6ONwtjGUxqBA+dtTWoNTvuWPz7KSVEBYkJa4G
	Nec1wNfcBkwXKYcioeM1MtLAQTm7VPx8cFh0kDLtb2Cr5D95v0zS6DT2+Yz6kN/W
	X6SnGmrFTuPZTUJX32sg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v3tmm2ej3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 23:03:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BKN2xVW026427
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 23:02:59 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Dec
 2023 15:02:58 -0800
Message-ID: <452a71aa-1e66-479c-bd68-f5ef7b409ade@quicinc.com>
Date: Wed, 20 Dec 2023 15:02:57 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mwifiex: fix uninitialized firmware_stat
Content-Language: en-US
To: David Lin <yu-hao.lin@nxp.com>, <linux-wireless@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <briannorris@chromium.org>,
        <kvalo@kernel.org>, <francesco@dolcini.it>,
        <tsung-hsien.hsieh@nxp.com>, <stable@vger.kernel.org>,
        kernel test robot <lkp@intel.com>, Dan Carpenter
	<error27@gmail.com>
References: <20231220090135.1028991-1-yu-hao.lin@nxp.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231220090135.1028991-1-yu-hao.lin@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NfhnfI2XoSw_hLI7B-so0OKUpSGfUKo4
X-Proofpoint-ORIG-GUID: NfhnfI2XoSw_hLI7B-so0OKUpSGfUKo4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 mlxlogscore=836 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312200165

On 12/20/2023 1:01 AM, David Lin wrote:
> Variable firmware_stat is possilbe to be used without initialization.

s/possilbe /possible /

Kalle can probably fix when he picks it up


