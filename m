Return-Path: <linux-kernel+bounces-14516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE47821E2E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91BFA1F22DA8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B732212E60;
	Tue,  2 Jan 2024 14:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UPkFrzD5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B722914278;
	Tue,  2 Jan 2024 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 402DiYWJ028306;
	Tue, 2 Jan 2024 14:56:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=lsm9Z8oSWVZr6wzE5pLu0Eka6uF10LkWTmR40tX3qI4=;
 b=UPkFrzD59Aq9QpPotaEKCmGGdd48wOVkpsN/+sKlWlyzH/BgAL+J8V/hik+EZZ19tTR5
 IcMaxoe79klGubMjJBol10TIoDSWV1xZ3IQCd1TYnkEM0rw6bhkNvCxbCdk5x8U87qO3
 ErN6FRxXvGfjzUal1+zT2Itf5pUGDtalbQ9iu1gpNk2KFhxe+BbMfryaFGxS5P++memF
 J2XrJZYcMKt8gCPKyqV4igNdGdtJF0a1W/zjcJgFu6EcIYkiI+eOm4wCvto6HQSnsZZE
 YEwrSVXgSYcXjmTnxR51KDWatQAh/8+J22E+SttKfA8OD4ptVWiAiaZTHv73bftBAhpf 0g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vcjquu2mv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 14:56:57 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 402DifJu029532;
	Tue, 2 Jan 2024 14:56:56 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vcjquu2kf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 14:56:56 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 402EUC52007568;
	Tue, 2 Jan 2024 14:56:54 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vaxhnwena-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 14:56:54 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 402EupRq9503450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jan 2024 14:56:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 752C820043;
	Tue,  2 Jan 2024 14:56:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 582982004D;
	Tue,  2 Jan 2024 14:56:50 +0000 (GMT)
Received: from osiris (unknown [9.171.22.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  2 Jan 2024 14:56:50 +0000 (GMT)
Date: Tue, 2 Jan 2024 15:56:48 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@suse.cz>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v3 26/34] s390/ftrace: Unpoison ftrace_regs in
 kprobe_ftrace_handler()
Message-ID: <20240102145648.6306-D-hca@linux.ibm.com>
References: <20231213233605.661251-1-iii@linux.ibm.com>
 <20231213233605.661251-27-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213233605.661251-27-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0mYsWeZo8_mKnSAkujm5HJyJGjjC43NV
X-Proofpoint-ORIG-GUID: 8KZKMcBNnDM3yBYkxj3czEh8Z83hu_tr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-02_04,2024-01-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxlogscore=704 suspectscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401020115

On Thu, Dec 14, 2023 at 12:24:46AM +0100, Ilya Leoshkevich wrote:
> s390 uses assembly code to initialize ftrace_regs and call
> kprobe_ftrace_handler(). Therefore, from the KMSAN's point of view,
> ftrace_regs is poisoned on kprobe_ftrace_handler() entry. This causes
> KMSAN warnings when running the ftrace testsuite.
> 
> Fix by trusting the assembly code and always unpoisoning ftrace_regs in
> kprobe_ftrace_handler().
> 
> Reviewed-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  arch/s390/kernel/ftrace.c | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Heiko Carstens <hca@linux.ibm.com>

