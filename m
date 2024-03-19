Return-Path: <linux-kernel+bounces-108204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA86880776
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0B791F22B9B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C818660275;
	Tue, 19 Mar 2024 22:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P6Ogfuac"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E365FDD3;
	Tue, 19 Mar 2024 22:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710888710; cv=none; b=JsHY11tpUaDez4QN8Rio/+o85CUbMsTzFVEjQgYTgyCnIZwy0G8c+uTjSTuFp9V48SWy218qcJE07WEbX+FgImoKgQl1D3LhhAAaizer7ZahqIv6qZHJa0rAa+ThKAXVG43umYqGlXRy1bPbJ2p/DJWuDK8h5tKq1nNxfxtb5mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710888710; c=relaxed/simple;
	bh=IU1PCXQe1NSdbBnY4sTGTjqiGnGliYg75WlahJ675b4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=VJVuSRRxhwaqP9gdwSjHYl9kuXoPtjW/14JYmllJ2dkUz779+Fzpn719M1x/KtDMPEXog+e0ZAsINuZHp5g3mYuH0zRcLuQVok7xvf6v7cgzoPyZliFYFCxpVTbs2VC/fRaBjIIiXeCkqIXnMtBp+cmemaWVfFl0NxpkTU7geHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P6Ogfuac; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JLewjK024577;
	Tue, 19 Mar 2024 22:51:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=SU/WmQVRnDFhOMmtaXP3ay9X1IDxE95+NRNPtSj9LQY=;
 b=P6OgfuacAmbiXGR9HLmE+e1I/uh7ihnzs4Cabq0G6r/nfG+4/95DAtozri4UUfP/us9E
 V1RqP55pUe0yElXDI0AciZu5IZDAyhLcM/vQWNsRgJAd2QEPsDs1htNzj77a46Rk+WGx
 bJ0DDcPwPlvm6pxbjNV1b+YVuY6bdyBjTppQb5ZABAR+dTsplFByq35ehlc7o4AISZ5d
 2S3U91qqhO74Am9274bqGtmRHg2Dv2ZJ8BILsR8oxsB0Fu7ASOiaotrF314yW33cebjY
 edhmjcr911SL1IyOCcwIb0+vRwIAVuKlaYzHo5ktgT0YQh6UPFXJSZF44PkzBhGEZG1j 6g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wyg2qgfyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 22:51:22 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42JMpLm6010859;
	Tue, 19 Mar 2024 22:51:21 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wyg2qgfyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 22:51:21 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42JKjCkF010073;
	Tue, 19 Mar 2024 22:51:20 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wxvauykhx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 22:51:20 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42JMpH6T41747044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 22:51:19 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9436D58059;
	Tue, 19 Mar 2024 22:51:17 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC20B58055;
	Tue, 19 Mar 2024 22:51:16 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.80.83])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Mar 2024 22:51:16 +0000 (GMT)
Message-ID: <45f3d3c56a140d174e8234198124c1d2e1712f64.camel@linux.ibm.com>
Subject: Re: [PATCH v3 03/10] evm: Implement per signature type decision in
 security_inode_copy_up_xattr
From: Mimi Zohar <zohar@linux.ibm.com>
To: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, roberto.sassu@huawei.com, amir73il@gmail.com,
        brauner@kernel.org, miklos@szeredi.hu
Date: Tue, 19 Mar 2024 18:51:16 -0400
In-Reply-To: <20240223172513.4049959-4-stefanb@linux.ibm.com>
References: <20240223172513.4049959-1-stefanb@linux.ibm.com>
	 <20240223172513.4049959-4-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: i8FJ9rBkXC0xX0Ei8BS5wURKlyPCn43u
X-Proofpoint-ORIG-GUID: FRDB_SQk1rFHaHJOT17cBwsHNcicwSOr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_09,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 clxscore=1015 mlxlogscore=888 priorityscore=1501 lowpriorityscore=0
 phishscore=0 malwarescore=0 impostorscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403190176

On Fri, 2024-02-23 at 12:25 -0500, Stefan Berger wrote:
> To support "portable and immutable signatures" on otherwise unsupported
> filesystems, determine the EVM signature type by the content of a file's
> xattr. If the file has the appropriate signature type then allow it to be
> copied up. All other signature types are discarded as before.
> 
> "Portable and immutable" EVM signatures can be copied up by stacked file-
> system since the metadata their signature covers does not include file-
> system-specific data such as a file's inode number, generation, and UUID.
> 
> Co-developed-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>


