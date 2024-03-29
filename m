Return-Path: <linux-kernel+bounces-123935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53560890FF5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DABE28BD60
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47313125B2;
	Fri, 29 Mar 2024 01:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SF1hv1YA"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724B0A92F;
	Fri, 29 Mar 2024 01:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711674179; cv=none; b=NbVLEteT8D2ty2HSDS8bgAzmLk/kMcobUeLsf4B5Mp96V5QtricgOmKgD0UaLE7jjOlEZYiOWzpDc+GLwGu/QLKsRGobJPyimtTlVrstzpSQno7MuvgSOTDexdW9/s/Gie/5hNCxTaIva89pKiHx8p21Melywrj1ug6NI43sbJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711674179; c=relaxed/simple;
	bh=Dr1VlokoSKaC9y28ynylm4SEPgQMTWxh85ITtu46N1g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XkVfctbHYwUmGxJ06EL6Rj90TXTh2JQbucP1T6bV9THET2i++hhptbwDP0GzuSPRIZJoniuuiSkw7u355sZqQzSnmnYdcjTVhZjx681qBsao2qjrze0UTWGGCdCububSBueDKIC8BMpqxAkM+Fn8NLzWhz/dxTqvqSEzTG0JzpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SF1hv1YA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42SN55oe011440;
	Fri, 29 Mar 2024 01:02:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=0dY3d4JiA2sDHJ3WMxYQw6Z9eBfTuUH6pqj6z2iebXo=;
 b=SF1hv1YAOIAAAdmL9eYanM4UCYDfi2rpGwOEQiz/g3Y51utt3NpEhxShlMPrbpVrlyUX
 qZgjdeEobiEVbk7khfOQ+7G3mpjFgcpJ52SeQi5tEpN44p0VOqYJ3zaaxylV6viDixIz
 92KObcOmeq0tKNWQb+FA7++JDLNIJ9oBlLx/8dus6/F4V1M/EQOQa1VkCJwZg8KFB/7/
 FkJm3iUBYP+DT1SxKTmG88FSsKlm4W8ZMQ7hQtzp2X4GVF4vXPF1uC6Nnb7DkuJjpBJs
 YAJa88ntno+vINPjKo9mp6a1ZSPRn48H3C15M35ardusysqBiYHAZUKialJnbUVuEpag 1A== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x5h9h87ku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 01:02:43 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42SNFbwg025458;
	Fri, 29 Mar 2024 01:02:41 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x2awn8wek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 01:02:41 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42T12c4f63373678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Mar 2024 01:02:41 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE75958068;
	Fri, 29 Mar 2024 01:02:38 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46C7B58061;
	Fri, 29 Mar 2024 01:02:38 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.90.219])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 Mar 2024 01:02:38 +0000 (GMT)
Message-ID: <36fa018559b8d68ac9d41826148e7d36c1ecf1ab.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Fix use-after-free on a dentry's dname.name
From: Mimi Zohar <zohar@linux.ibm.com>
To: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, roberto.sassu@huawei.com,
        Al Viro
	 <viro@zeniv.linux.org.uk>
Date: Thu, 28 Mar 2024 21:02:37 -0400
In-Reply-To: <20240322140312.1804404-1-stefanb@linux.ibm.com>
References: <20240322140312.1804404-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-23.el8_9) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1Xy32qb6LKaXx8FmWrzWbFao4CU4K2kd
X-Proofpoint-ORIG-GUID: 1Xy32qb6LKaXx8FmWrzWbFao4CU4K2kd
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
 definitions=2024-03-28_19,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=837 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403290007

On Fri, 2024-03-22 at 10:03 -0400, Stefan Berger wrote:
> ->d_name.name can change on rename and the earlier value can be freed;
> there are conditions sufficient to stabilize it (->d_lock on dentry,
> ->d_lock on its parent, ->i_rwsem exclusive on the parent's inode,
> rename_lock), but none of those are met at any of the sites. Take a stable
> snapshot of the name instead.
> 
> Link: https://lore.kernel.org/all/20240202182732.GE2087318@ZenIV/
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Thanks, Al, Stefan.

Mimi


