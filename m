Return-Path: <linux-kernel+bounces-153703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7468AD1DC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E0071F210C2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4236E153833;
	Mon, 22 Apr 2024 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QdfJ/DMg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690671E49E;
	Mon, 22 Apr 2024 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713803057; cv=none; b=qHRmGlN14IWny4m8CRFj3oIyxt9gDuyp8or0ib0VIqVgXqwIPt6u8t8a23uTLRpE2CnensplkxFwpYu+ZXonSw4xSRrRcdHMnTbI4N05EdPuxlr60LU6ZPyGWzQW4QX8luX5/2sM1YETbPaIhWTZkez79ZPVUhkmqNoOfGCywuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713803057; c=relaxed/simple;
	bh=kk1vuHdQUapMNM1gmGRk1+FTKW5OjZWy4qpokeEYqNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GHdaiThC38EiVNDkBihAuR0OCjL267Csbg853n2EJ+6ludxENPGSa6dxZ0zUFwnVlzF9MPDzLbgrl2LeSO9MQZtgLBfgUPpBGUN5C2U5y2RSzHQKARmJxx01vH5ixJSIC4c+r6wruuEwQ0LroogmTQZm6L+feF1+t/BorgqBByc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QdfJ/DMg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43MEFiH0003144;
	Mon, 22 Apr 2024 16:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=o47mZLlbjZ8BBVjTLMZTKirpl7IfxMDSxPg8gdfsUBg=; b=Qd
	fJ/DMgF1vS/8dT5Ux56kxuVWFO84nRCl+cHgO+bjd/ol555UR7K8CYJPpe0h99nf
	VvUg2XcJ4ZpdCdfIwL9WWNhi8kf7cgPtE3PWQngEMZ0Sxq8x+YECcG7IUO5NgrcF
	KatFZvj96TmPrKx5JB4zQNCkLXMiGTBuwOQyxhgDU8CHxSXJoxk8Ru40EN3Ls4hR
	bjcpM6iQ/xnz+q+RZ3D62GTY5MZAXEPMJGqfoZYXM/4D6e/y6Ao8o0vjYkrZ1nRd
	8N1px5e1zK05QSdz9ZhqqCPy0Bjow62xorOmRwpUCIqIU7NgbeG3+7dL/SzXUIoa
	T6WPLxu8yiQMkyMaHMWg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm5sx4xv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 16:24:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MGNxup010478
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 16:23:59 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Apr
 2024 09:23:58 -0700
Message-ID: <5a2bf374-0def-4c41-8260-20fd7428bad6@quicinc.com>
Date: Mon, 22 Apr 2024 09:23:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless v2] wifi: ath10k: Fix an error code problem in
 ath10k_dbg_sta_write_peer_debug_trigger()
Content-Language: en-US
To: Su Hui <suhui@nfschina.com>, <kvalo@kernel.org>, <jjohnson@kernel.org>,
        <nathan@kernel.org>, <ndesaulniers@google.com>, <morbo@google.com>,
        <justinstitt@google.com>
CC: <c_mkenna@qti.qualcomm.com>, <linux-wireless@vger.kernel.org>,
        <ath10k@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>, <kernel-janitors@vger.kernel.org>
References: <20240422034243.938962-1-suhui@nfschina.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240422034243.938962-1-suhui@nfschina.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dvO7Ruw17PXOuEqElGCj4QLG1BCbc9n0
X-Proofpoint-GUID: dvO7Ruw17PXOuEqElGCj4QLG1BCbc9n0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=754 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220069

On 4/21/2024 8:42 PM, Su Hui wrote:
> Clang Static Checker (scan-build) Warning:
> drivers/net/wireless/ath/ath10k/debugfs_sta.c:line 429, column 3
> Value stored to 'ret' is never read.
> 
> Return 'ret' rather than 'count' when 'ret' stores an error code.
> By the way, remove some useless code.
> 
> Fixes: ee8b08a1be82 ("ath10k: add debugfs support to get per peer tids log via tracing")
> Signed-off-by: Su Hui <suhui@nfschina.com>

(try that again)
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


