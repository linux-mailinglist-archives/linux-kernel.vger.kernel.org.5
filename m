Return-Path: <linux-kernel+bounces-110116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D95885A35
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EF311F2225D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF7684FB1;
	Thu, 21 Mar 2024 13:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rpoAc7mb"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A5F82D86;
	Thu, 21 Mar 2024 13:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711029536; cv=none; b=h1dWgUZIeOMbEegUlRd8GNN4ljy145xSQmx4RVAvkdYL/A8cW7uCuMasUoHG73AlxcyEGwzUm6u2++2iFAPtpUKTyKj6kFfJ9RT0WYo91FRSYj8I1ePO/IBifP9slEEPg2CLE9mzJboJdYO7f0LHhQAhv7OugUqT7VAHLMnrt5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711029536; c=relaxed/simple;
	bh=HPFUfXcjh9xUQ2o4yoAZg0WXqjhPAAlp6RwOP/jeKCw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=NVVPyQfmA8140QXfwm73t/7Vn87x08AhDVW/REktBIhFmcbQCUABw4PZnsw0f5YigwPFI3qAfwMV3Pbl4IkfTCqd/jTw4pCOs8aCs1roXAvSpq0csWlpYhsCiePte/EvNxV9c6Z68mFm6oinN5C0s+GLtmHBFZJ5xyfKMXGKJhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rpoAc7mb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42LCm5NZ008641;
	Thu, 21 Mar 2024 13:58:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=eWM4TWj+zZPR08g9wS1AAFFSzeMGDPAIQ+pCPf4MFe0=;
 b=rpoAc7mbhihYAII22azxL74DzRLCpsm2Tdb9ZCl1uoQskOSiPTjz73hqB+Uf3V34KA4G
 XRYq8Q0hxbcZbYoiBsx+mZGgS1qdj9/BstSGzEz4TibAnWVUZq61skw28fgj3Vpnz8FL
 kiwiKgW7fdDqQ5QirKTnykxPXswnedlz9gkV3lvD+2uCEwjZRFmqPEXdWASgsGRHR98c
 VVy/mG4D/uZkxqYc2npSZk3hhiOez7TK3WA2kN/G8Vb+5+0dY+IsMWUCCQ8GIfPX3e6q
 S6XzMWG/LvMTY2Zgh2ZkERZi8gmiJz3FxeYlBnxwWuDOiYX/WcAoL2IOODP6qXu4KZ9r +A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0n6wr8hp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 13:58:38 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42LDwb3S028244;
	Thu, 21 Mar 2024 13:58:37 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0n6wr8h1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 13:58:37 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42LBM934010083;
	Thu, 21 Mar 2024 13:58:36 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wxvavah10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 13:58:36 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42LDwXBK7340662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 13:58:35 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5BF85808F;
	Thu, 21 Mar 2024 13:58:31 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BF085807C;
	Thu, 21 Mar 2024 13:58:31 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.40.138])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Mar 2024 13:58:31 +0000 (GMT)
Message-ID: <267f340e1b309cff2fab01f83a141ee465296907.camel@linux.ibm.com>
Subject: Re: [PATCH v3][next] integrity: Avoid
 -Wflex-array-member-not-at-end warnings
From: Mimi Zohar <zohar@linux.ibm.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Roberto Sassu
 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date: Thu, 21 Mar 2024 09:58:30 -0400
In-Reply-To: <ZfuzWku+ip4fsZrb@neat>
References: <ZfuzWku+ip4fsZrb@neat>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-23.el8_9) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -PQQ-S8rn1ftx9JS2MJlj6S1u3AoIdvq
X-Proofpoint-ORIG-GUID: ZUNX21kpOw7k7GpDeTPF6HPVVI0NDsN8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 mlxlogscore=898 spamscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2403140000 definitions=main-2403210100

On Wed, 2024-03-20 at 22:11 -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
> ready to enable it globally.
> 
> There is currently an object (`hdr)` in `struct ima_max_digest_data`
> that contains a flexible structure (`struct ima_digest_data`):
> 
>  struct ima_max_digest_data {
> 	struct ima_digest_data hdr;
>         u8 digest[HASH_MAX_DIGESTSIZE];
>  } __packed;
> 
> So, in order to avoid ending up with a flexible-array member in the
> middle of a struct, we use the `__struct_group()` helper to separate
> the flexible array from the rest of the members in the flexible
> structure:
> 
> struct ima_digest_data {
>         __struct_group(ima_digest_data_hdr, hdr, __packed,
> 
> 	... the rest of the members
> 
>         );
>         u8 digest[];
> } __packed;
> 
> With the change described above, we can now declare an object of the
> type of the tagged `struct ima_digest_data_hdr`, without embedding the
> flexible array in the middle of another struct:
> 
>  struct ima_max_digest_data {
>         struct ima_digest_data_hdr hdr;
>         u8 digest[HASH_MAX_DIGESTSIZE];
>  } __packed;
> 

And similarly for 'struct evm_digest'.


> We also use `container_of()` whenever we need to retrieve a pointer to
> the flexible structure.
> 
> So, with these changes, fix the following warnings:
> 
> security/integrity/evm/evm.h:45:32: warning: structure containing a flexible
> array member is not at the end of another structure [-Wflex-array-member-not-
> at-end]
> security/integrity/evm/evm.h:45:32: warning: structure containing a flexible
> array member is not at the end of another structure [-Wflex-array-member-not-
> at-end]
> security/integrity/evm/evm.h:45:32: warning: structure containing a flexible
> array member is not at the end of another structure [-Wflex-array-member-not-
> at-end]

I assume these messages are gone.

thanks,

Mimi


> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v3:
>  - struct ima_digest_data is a packed structure. So, to keep things
>    consistent, use the attribute __packed on the tagged struct 
>    ima_digest_data_hdr. For this, we use __struct_group() instead of
>    struct_group_tagged(). Update the changelog text, accordingly.
> 
> Changes in v2:
>  - Include changes for `struct evm_digest` (Mimi Zohar)
> 


