Return-Path: <linux-kernel+bounces-123798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 172CC890E40
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 458481C2165B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE70657BC;
	Thu, 28 Mar 2024 23:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ChwRpmEk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FAF51028;
	Thu, 28 Mar 2024 23:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711667287; cv=none; b=Z0LODCcp7kuzXc0tZl9MWEBtoUL5eWoJFJIrltb7sL273Gn61mC+ZMqTkbe9snzriCzns9I4nnckxCmLcfIyaLTKmy+ebatq8rsEXSY45+cBzylbzvqxvh6uTUogR+AfC9J89XKQsXjc0LKpgIdcMYIkdzXP6GDHGIer+fWafo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711667287; c=relaxed/simple;
	bh=jJ8ndh4jPTr4kA/TfIwqYnMh28CJq8arUOLMMU2wl/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lWXI68T8YzYkS8ntrO8MS8hHfj/LFM3NmwAMPhULY3kQMjIIlTLfIrcAqsqPKMvjZnLL7859RJLTt8G2L4RxLTX9VVylpLRcDXk4iZkWKokJxaSMq30lAM2ylrq9617l8jywE7IL6O3sB9pec3DDpN0WK3N/zbTlY4GF08uWf54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ChwRpmEk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42SMuwh5032671;
	Thu, 28 Mar 2024 23:07:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=bvmtnXMU0NWxXLj5hbrz19dq6LLZ8Z3eKw7VMSubTpg=; b=Ch
	wRpmEkQnTYk1jOfIr9cnIztnoeTegHi2SzZt/inTG/sGTbc+ma4qq43v+Jzvs6MG
	Nfrfis/ThrOlct4/xrwB/TiKIdJ8H5TCstaC7pcy0V9hdiu+Xu53nY0yoYV7yV7n
	qebetgXaUmsTWqpRdZUOZtULX01VSZbiKwEnH8wUXyI7HjUgSzfbSMn+d9t8tvs5
	ddy/TLBxkhcxnTzL5D8AFr5W9KuH9VbfvuKkLYSSD/tlUAREILQA/JOuw6mzisg3
	C/PRSCdaEPD/T8PdoM6cwofr8fdCwXrXB4s6lRpnSax3mlDdpfEUh4fOavkzZBYa
	j+h+ZSN1NCp7jCSPjEDA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x56njhw9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 23:07:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42SN7fCu011865
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 23:07:41 GMT
Received: from [10.110.124.221] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 28 Mar
 2024 16:07:40 -0700
Message-ID: <86de9e81-7ac4-4609-bd18-d92e7244e2a5@quicinc.com>
Date: Thu, 28 Mar 2024 16:07:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80222: Fix ieee80211_i.h kernel-doc issues
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>,
        Johannes Berg
	<johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240328-ieee80211_i-kerneldoc-v1-1-e848bdec58f3@quicinc.com>
 <a009a21a-56d7-4a1a-aaf9-feefa5acc561@infradead.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <a009a21a-56d7-4a1a-aaf9-feefa5acc561@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _74hLoE_OdvduVV9BRmjgphW1V9NJQSA
X-Proofpoint-GUID: _74hLoE_OdvduVV9BRmjgphW1V9NJQSA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_17,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=736 impostorscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403280167

On 3/28/2024 3:16 PM, Randy Dunlap wrote:
> Hi,
> 
> On 3/28/24 14:08, Jeff Johnson wrote:
>> kernel-doc flagged the following issues:
>>
>> net/mac80211/ieee80211_i.h:146: warning: expecting prototype for enum ieee80211_corrupt_data_flags. Prototype was for enum ieee80211_bss_corrupt_data_flags instead
>> net/mac80211/ieee80211_i.h:163: warning: expecting prototype for enum ieee80211_valid_data_flags. Prototype was for enum ieee80211_bss_valid_data_flags instead
>>
>> Correct the documentation to match the code.
>>
>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> 
> These seem to be corrected in linux-next already.

Looks like I fixed these two earlier -- not sure why they haven't reached
wireless-next yet which was the code I was looking at today.

I've flagged as N/A in patchwork

> However, I do still see this one:
> 
> ieee80211_i.h:689: warning: missing initial short description on line:
>  * struct mesh_table

Ah, I haven't been adding [-Wshort-desc[ription]]  (or some of the other -W
switches)

Yay, I can find even more issues.

I'll fix this one


