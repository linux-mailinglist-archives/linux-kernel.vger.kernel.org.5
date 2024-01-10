Return-Path: <linux-kernel+bounces-21703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AADA18292FA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 05:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D179D1C24C61
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 04:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66656123;
	Wed, 10 Jan 2024 04:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mHalI2Lw"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644BE53AA
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 04:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40A3TDEo005600;
	Wed, 10 Jan 2024 04:17:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=LblpeOnKAG7ZiMLboCXzTZu8Qz2iYku27kij+rJ4/ns=;
 b=mHalI2Lw/3CFMYtYCccVZhLAVIF0a0mOlGzH4Z148JokuO6tMx22Dz17uNlm752nqf9W
 Na5/hXnJMGhxgQG3oUlFyjpnHgKu26mnppkbPdEG0yeVZMHqwFdCsCuIfC7Zf5QC1p5P
 awdCMMZ/TmPbHVePwjM39sl3MkWedjZ013duPXpluy59eIAChw+xoVZuLvAfNLNOwyQt
 P/BIp3z2OZu7QSrADYQ/3n2dBlPgLmP5+l2ub2tS29p6AOQ1O6naL1BUIBSEKdliLdlU
 tZ+OC+LR3qYwVjcJdQaSEd116QTFaBtTFxDUf2vCI2BBPG5GjbVPbmwVGT2A728aeQ17 mQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vhgdvmvst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 04:17:05 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40A46i5Y008316;
	Wed, 10 Jan 2024 04:17:04 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vhgdvmvsp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 04:17:04 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40A2VeuT004389;
	Wed, 10 Jan 2024 04:17:04 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vfjpktwan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 04:17:03 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40A4H1Ok35521020
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 04:17:02 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDA2520040;
	Wed, 10 Jan 2024 04:17:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69AE02004D;
	Wed, 10 Jan 2024 04:17:01 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jan 2024 04:17:01 +0000 (GMT)
Received: from [10.61.2.106] (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 0781C60218;
	Wed, 10 Jan 2024 15:16:59 +1100 (AEDT)
Message-ID: <b48922e4-a89a-4aaf-94cf-bb2b1bff22cb@linux.ibm.com>
Date: Wed, 10 Jan 2024 15:16:58 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] powerpc: Disable KMSAN checks on functions which
 walk the stack
Content-Language: en-US
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
        "glider@google.com" <glider@google.com>,
        "elver@google.com"
 <elver@google.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "npiggin@gmail.com" <npiggin@gmail.com>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "iii@linux.ibm.com" <iii@linux.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20231214055539.9420-1-nicholas@linux.ibm.com>
 <20231214055539.9420-10-nicholas@linux.ibm.com>
 <e70b4365-cb0c-4565-b7b1-ac25be85c5a6@csgroup.eu>
From: Nicholas Miehlbradt <nicholas@linux.ibm.com>
In-Reply-To: <e70b4365-cb0c-4565-b7b1-ac25be85c5a6@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lXcvNy98EeOQfMelbTu7LH7BnZ-p2zEy
X-Proofpoint-ORIG-GUID: XtMIHxtsP68xzx66riI-pk7vgjKZbboK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-09_13,2024-01-09_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=573 malwarescore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401100032



On 14/12/2023 8:00 pm, Christophe Leroy wrote:
> 
> 
> Le 14/12/2023 à 06:55, Nicholas Miehlbradt a écrit :
>> Functions which walk the stack read parts of the stack which cannot be
>> instrumented by KMSAN e.g. the backchain. Disable KMSAN sanitization of
>> these functions to prevent false positives.
> 
> Do other architectures have to do it as well ?
> 
> I don't see it for show_stack(), is that a specific need for powerpc ?
> Other archs have the annotation on functions called by show_stack(). For 
x86 it's on show_trace_log_lvl() and for s390 it's on __unwind_start() 
and unwind_next_frame().


