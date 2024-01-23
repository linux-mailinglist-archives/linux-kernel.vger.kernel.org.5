Return-Path: <linux-kernel+bounces-35153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD5E838CE5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0BE81F2666C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077095DF1B;
	Tue, 23 Jan 2024 11:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="p6xYMsIK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C173F5DF13
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 11:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706007853; cv=none; b=MIyD1SALhaPmIxXoJlXB42pR57/aI58AvJbBegMS+8BSr2ZotMe/ynm1nPwv/KHBaOINUM6x4Sc1QT5mYo4Lw1Is9ZZ79NCiMSwnJq/YFYSOX1MsroZ4ke61qKr937T3mtb622i7KSiN7YmBc4UYyi0fj8xHUY/NQaRXI63KRR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706007853; c=relaxed/simple;
	bh=2i6lV9/1dpM70IMRlA2HW1ksIVKBRL+Sy8MAykGS0LQ=;
	h=Message-ID:Date:MIME-Version:From:To:CC:Subject:Content-Type; b=GaH8HASPeCY+8SN/VwUykJHPoA6z4b2sF7Eem2KUI2dUIZZpqDKi5uIZoynynkbscx9r4eOg0dMVM1ojjfBe7NsW2Xo9vr02lneQe9ZQKV3yqODcqgvn2htmZex6+qxp7VrcdnDbtf1cFOprWjicv2inwnWIR8Szbvi88ZHeYvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=p6xYMsIK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40NAEF0T024765;
	Tue, 23 Jan 2024 11:03:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:from:to:cc:subject:content-type
	:content-transfer-encoding; s=qcppdkim1; bh=ep+LJJCGCPOiBkIso0Gx
	eydK6txy6MfI/exTM73RNrI=; b=p6xYMsIKphvCwTjSyT3TWEty4p2cL3XF3Sr0
	/hEKPkGWDBBRBaH9hHvBzE59N1fSoBHv6Dv7Nhsyq9jeai/bk2NSiE4I9rxKiQ1Q
	Z0GofyBhCLC4nyIcu3LE1ZR4z4KsebRUFFllJ5NcICo48CZ03lqtcDaV6s12lEnH
	jB0SU7EUXt+wnep2X5O2vXkJ45bU/r9C7KhzGmPy+JcZ5JeL/i2rERtHaMj7tWJz
	Mw3p8rEp0Rmk0sik/hPuxTYEJ0z39yInShUdas9AEv9YpvSlCDXTPC81BHzvD93V
	IqIgJ0IBoppuzt9Y4kMaFvHBeSWcW0nYQTj/lmW+sOED39/sKQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vt8140jd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 11:03:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40NB3uKU028388
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 11:03:56 GMT
Received: from [10.214.66.119] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 23 Jan
 2024 03:03:54 -0800
Message-ID: <56154bf4-c1e2-16d5-c6e2-c2dee42d3377@quicinc.com>
Date: Tue, 23 Jan 2024 16:33:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
From: Charan Teja Kalla <quic_charante@quicinc.com>
To: <Liam.Howlett@oracle.com>, Matthew Wilcox <willy@infradead.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML
	<linux-kernel@vger.kernel.org>
Subject: Purpose of maple_node objects to be its size aligned
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hCX1sMD41WRuH3wU0PexQVokd9gePt1y
X-Proofpoint-ORIG-GUID: hCX1sMD41WRuH3wU0PexQVokd9gePt1y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_05,2024-01-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=998 clxscore=1011 impostorscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401230080

I am just curious about the purpose of maple node slab objects to be its
size aligned, but I can understand why they need to be cache aligned.

void __init maple_tree_init(void)
{
	maple_node_cache = kmem_cache_create("maple_node",
			sizeof(struct maple_node),
			sizeof(struct maple_node),// Alignment of the slab object.
			SLAB_PANIC, NULL);
}

Reason for the ask is, when slub debug enabled with option Z, the change
[1] makes the total object to be 256 * 3 (=768)bytes.  This turns out to
be a problem in debug builds where the unreclaimable slab consumption
itself is very high thus exerting the memory pressure on the system.

maple_node:
  orginal object size 	   = 256b
  after slub_debug enabled = 768b


If, there is no special requirement, other than just needs to be cache
aligned, thinking of the below:

--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -6283,8 +6283,8 @@ bool mas_nomem(struct ma_state *mas, gfp_t gfp)
 void __init maple_tree_init(void)
 {
        maple_node_cache = kmem_cache_create("maple_node",
-                       sizeof(struct maple_node), sizeof(struct
maple_node),
-                       SLAB_PANIC, NULL);
+                       sizeof(struct maple_node), 0,
+                       SLAB_HWCACHE_ALIGN | SLAB_PANIC, NULL);
 }


[1]d86bd1bece6f ("mm/slub: support left redzone")

Thanks,
charan

