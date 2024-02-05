Return-Path: <linux-kernel+bounces-52875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2E5849DB2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0B60B242BD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5A22C6AD;
	Mon,  5 Feb 2024 15:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dLxFnIad"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78F22C68C;
	Mon,  5 Feb 2024 15:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707145765; cv=none; b=KMTh6xz3YclrAHXtpdDXevs2J9PiY1V6eAgQcDA8nEH25DXS8NUAtxYZYuM3k4zikMCX/qVNsQJ3if2vwpapY6EMr6IknNckktWhbCLf9t5O0iMISA1j3sZoyTX9n698YofiUQ8loNQjwticE/uJ33iIq8QlY3gbaCA73sqJAj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707145765; c=relaxed/simple;
	bh=BXmgXKi0qbrpohDlq4XoeGpuhOvymtq43DR2m2gEr+I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QP4ovmIT/ANUZr43KY6//M4C4AbcoIAsHC2N+gS+kGxrg+jzXYYIoYto7RJI2nlsxvH0sCSUbfzpA6LVTeUC4APvCH59IJch/lcOUvUxG2dBaMxv/q6jUFtHSQEQfh/hNMmdoCt1K6tGpTgp2XZNUbze7f5zumfip8mtEowBlvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dLxFnIad; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 415Ed371020278;
	Mon, 5 Feb 2024 15:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=xE5r1BIcNWE0jTeVUWkbGBO/+PUZmQcefY7pgVxH2pk=;
 b=dLxFnIadrlBFlwf8AyzhdIOOnDoSbk+NbDxP1s3EaiD6Pa/Ip9qL6ubSzhJZXCGFjJhd
 D2NubcMnHZ7UNVr2C9teQEEwpfVccGe6yNnEZyI8brKVv9tEd7xGYLRlESZ7RNZ/ssmT
 V+x4pxX7Y9Y8yvOUjdyd+R58q53AZhFWxu8wOlqPnoRoiu6Bkva4BzGyX+Qlwal6+WMH
 V8DSTO3X4dGoMqYb9wwU0nArkopd907IB+GXwsCJINTO85c6LnFXoxjVpEHlQf27sfTo
 9jNR3NZmIctva+ww2atpLmmBPmvD3RkHlsZ3n2UmQYngdsvVcnACCoNz0cBN80ac5c9I /w== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w31m8s1be-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 15:09:17 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 415CGYUP008494;
	Mon, 5 Feb 2024 15:09:17 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w221jrswx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 15:09:17 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 415F9FPI16843514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Feb 2024 15:09:15 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A37B20043;
	Mon,  5 Feb 2024 15:09:15 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E84320040;
	Mon,  5 Feb 2024 15:09:15 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  5 Feb 2024 15:09:15 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Mete Durlu <meted@linux.ibm.com>
Subject: Re: [PATCH] tracing: use ring_buffer_record_is_set_on() in
 tracer_tracing_is_on()
In-Reply-To: <20240205092353.523cc1ef@rorschach.local.home> (Steven Rostedt's
	message of "Mon, 5 Feb 2024 09:23:53 -0500")
References: <20240205065340.2848065-1-svens@linux.ibm.com>
	<20240205075504.1b55f29c@rorschach.local.home>
	<yt9djznj3vbl.fsf@linux.ibm.com>
	<20240205092353.523cc1ef@rorschach.local.home>
Date: Mon, 05 Feb 2024 16:09:14 +0100
Message-ID: <yt9dfry73q3p.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ukcjfl03xv7jf_bN_jT48tN__rIv8Kjy
X-Proofpoint-GUID: Ukcjfl03xv7jf_bN_jT48tN__rIv8Kjy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_09,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050114

Hi Steven,

Steven Rostedt <rostedt@goodmis.org> writes:

> On Mon, 05 Feb 2024 14:16:30 +0100
> Sven Schnelle <svens@linux.ibm.com> wrote:
>> 
>> Another issue i'm hitting sometimes is this part:
>> 
>> csum1=`md5sum trace`
>> sleep $SLEEP_TIME
>> csum2=`md5sum trace`
>> 
>> if [ "$csum1" != "$csum2" ]; then
>>     fail "Tracing file is still changing"
>> fi
>> 
>> This is because the command line was replaced in the
>> saved_cmdlines_buffer, an example diff between both files
>> is:
>
> [..]
>
>> 
>> This can be improved by:
>> 
>> echo 32768 > /sys/kernel/tracing/saved_cmdlines_size
>> 
>> But this is of course not a fix - should we maybe replace the program
>> name with <...> before comparing, remove the check completely, or do
>> anything else? What do you think?
>
> Hmm, actually I would say that this exposes a real bug. Not a major
> one, but one that I find annoying. The saved commandlines should only
> be updated when a trace event occurs. But really, it should only be
> updated if one is added to the ring buffer. If the ring buffer isn't
> being updated, we shouldn't be adding new command lines.
>
> There may be a location that has tracing off but still updating the
> cmdlines which will break the saved cache.

Ok, my understanding is that it will override the entry in the list if
another process comes up with the same PID. But i haven't read the code
carefully - let me do that now.

