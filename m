Return-Path: <linux-kernel+bounces-86754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B02A986CA4D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2E491C20F7C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450C37F47F;
	Thu, 29 Feb 2024 13:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RuQNA7CI"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE617E578
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 13:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709213510; cv=none; b=VBD0H5ymGTBud/YwjKUmW+u5ZR/+WIq576zE1v8HPa56V+Jr6rK907MXQbthzX1oeHxatHFcjDhbATw0ZdvYkABSqaSEfL071IUx0kPhMRnggCpwMtNDt1vZgZV3Qm2yqyP05jDfmpympvHwvS+ghKTqLOKKJg45HKlCTy+lf0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709213510; c=relaxed/simple;
	bh=GJo8iJMGfaGPwS99dafMtTmfFm51EAfN5bAYGc+TU50=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=tcsOZv1TG50cpp5FTHQAoWKTGMwt+HFSFQ900axyZh1hHkUDMZEJ/qLPwfBMIlgT7u75qlFaUAoaS9npdjg6WvKbBSjZHo2O8KkRHri1a+5r3mUl/JCfwmVrb4+YfPzbgtugR9eE6coewVniwheOPXtVjMlPD34Me2RpSId7F2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RuQNA7CI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41TDS4kj013608;
	Thu, 29 Feb 2024 13:31:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=GJo8iJMGfaGPwS99dafMtTmfFm51EAfN5bAYGc+TU50=;
 b=RuQNA7CIekh/yYwAcIVRXbdhA1CWtqJbIy3FzwCffuWmVD0gJ5EI1b86UTTQRWaRSrAd
 t+6u+t0dxoEPb9Gu+c4Af/nhwlu8fa17McT8M65xG4943tWxYRlZA8c+1ysfwjQenfSD
 qVjEczqoKZctZLsBxNbPtxWIGrMSRUpCPdqJhS+CKsXrgT73FyzP5uZpEzHNL0u++q0K
 uAAftIsfATnoeqvQMWX3ZKuc8tC8EAX1JQccW1w+4XZyWHV7jjkPGHZTDhClxflXz/wm
 98PKkl+dCOL1fadlZQGqUXD1O48gL+75V31Q1X3/4V+uPbnLthL/nvYj4YJS27IgI9NV og== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wjtu382u3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 13:31:44 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41TCC8mG024154;
	Thu, 29 Feb 2024 13:31:14 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wfw0kn86r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 13:31:14 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41TDV83116646718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 13:31:11 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCAE420043;
	Thu, 29 Feb 2024 13:31:08 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D347F20040;
	Thu, 29 Feb 2024 13:31:07 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.80.238])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Feb 2024 13:31:07 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [netdev] Build failure on powerpc
From: Sachin Sant <sachinp@linux.ibm.com>
In-Reply-To: <875xy8103a.fsf@mail.lhotse>
Date: Thu, 29 Feb 2024 19:00:56 +0530
Cc: Tasmiya Nalatwad <tasmiya@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <916F09F9-FC10-4248-BE64-9E01AA264CBA@linux.ibm.com>
References: <8294bf9a-d175-4d86-b6df-9c409108cbf1@linux.vnet.ibm.com>
 <875xy8103a.fsf@mail.lhotse>
To: Michael Ellerman <mpe@linux.ibm.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5sYoHCdsaqxIPrqUqApQzJ2Rv-uhNl1Y
X-Proofpoint-GUID: 5sYoHCdsaqxIPrqUqApQzJ2Rv-uhNl1Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 malwarescore=0 adultscore=0 mlxlogscore=912 mlxscore=0 priorityscore=1501
 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402290104



> On 29-Feb-2024, at 7:52=E2=80=AFAM, Michael Ellerman =
<mpe@linux.ibm.com> wrote:
>=20
> Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com> writes:
>> Greetings,
>>=20
>> [netdev] Build failure on powerpc
>> latest netdev 6.8.0-rc5-auto-g1ce7d306ea63 fails to build on powerpc=20=

>> below traces
>=20
> Please include the defconfig you're building, and the toolchain
> versions, in reports like this.
>=20
> I wasn't able to reproduce this failure here.

I believe this is tied to gcc version.=20

Build failure is seen while using gcc-8.5.x but not with gcc-11.4.x

=E2=80=94 Sachin

