Return-Path: <linux-kernel+bounces-56552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B3884CB99
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49483282388
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCBE77622;
	Wed,  7 Feb 2024 13:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dwWz2nJc"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD4F76C8F;
	Wed,  7 Feb 2024 13:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707312813; cv=none; b=m+GbOR4Cz0NfVNsztRo61ymxpPAPAucKPWK7QuMhhVXYTnvmKPqyQ0D5HW9Ag3QaKVZPwQgSB+YEgCTKJrP1NHfuAwqNOgcCMk3G25bpy/+a9uggijR6qgg9aWrtOt9lQkHkwnxmI9msnBQw7RyjkK93971AvqPEY9bAqbDrbbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707312813; c=relaxed/simple;
	bh=ZSe4z1HCyYrJKERT65x4UpvppmJUQYF549bGogyFD+o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WfPbiZIoVSjtLDeEKvgYFr3//wYz/P0P3T/iSqz7q3oT4j3vsen97iZkSn50Xc2QKu8gupjPdv1Y4uIuqbdTns0Yk3xQRzNfRTABAgy8OB8fTW+0xuIS/uvXdv3ZPH9Fnv+Vx4Fx9qZruhEIgeMTgbFW9fGrwXgFNpwyGXzRuOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dwWz2nJc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 417CivsL019789;
	Wed, 7 Feb 2024 13:33:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=KlwPRPULd+ltLeNtqjMhdh9CekZatxoXADZYmL1/9xA=;
 b=dwWz2nJcfTkCR87ARl1giFnwXXCby4wQKydyRjly0V54VK1T6B5u3lp6NUm209eITjY8
 4/S1UTyL9YR7TiuhcSZqo2si8dENN+ZUinZtbUHxK62xHSS+sC14MctCA3kdtmKRODc9
 SkTUzk6s0Dy4o8wR5+lCn7O1EsFbYbdrj7qSG+cEEaT3K9bpoNAAsoOB/1zVgrjIB8ys
 fvZOg37oCzyAVeHrOu6jqvXQ2S5pxWOs9tV8P0Rq6JUZkX5cnW/9y3FsyU5faKvSupYR
 Hb/bzOcAYlZWc41dHh7WKYkipSka324vacqS8hJ9xbMRQ1Swc9FwMofs/G8lQxjTDsa9 /w== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w49vksxw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 13:33:24 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 417CQAut016154;
	Wed, 7 Feb 2024 13:33:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w22h25ey7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 13:33:23 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 417DXMFL53346766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Feb 2024 13:33:22 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3060B20043;
	Wed,  7 Feb 2024 13:33:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBF9C2004B;
	Wed,  7 Feb 2024 13:33:21 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  7 Feb 2024 13:33:21 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mete Durlu <meted@linux.ibm.com>, Masami Hiramatsu
 <mhiramat@kernel.org>,
        Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: use ring_buffer_record_is_set_on() in
 tracer_tracing_is_on()
In-Reply-To: <20240207072812.4a29235f@rorschach.local.home> (Steven Rostedt's
	message of "Wed, 7 Feb 2024 07:28:12 -0500")
References: <20240205065340.2848065-1-svens@linux.ibm.com>
	<20240205075504.1b55f29c@rorschach.local.home>
	<yt9djznj3vbl.fsf@linux.ibm.com>
	<20240205092353.523cc1ef@rorschach.local.home>
	<yt9d34u63xxz.fsf@linux.ibm.com> <yt9dsf262d2n.fsf@linux.ibm.com>
	<20240206060113.39c0f5bc@rorschach.local.home>
	<yt9deddovn3w.fsf@linux.ibm.com>
	<20240207060923.182ecb55@rorschach.local.home>
	<9a062196-ccbe-440e-a2f9-23eb8c5eb837@linux.ibm.com>
	<20240207072812.4a29235f@rorschach.local.home>
Date: Wed, 07 Feb 2024 14:33:21 +0100
Message-ID: <yt9dzfwch00u.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: q-fCWpd0q8CBRclbROSdJD19GZpUya-x
X-Proofpoint-GUID: q-fCWpd0q8CBRclbROSdJD19GZpUya-x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=875 suspectscore=0 mlxscore=0 clxscore=1015 bulkscore=0
 adultscore=0 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402070101

Steven Rostedt <rostedt@goodmis.org> writes:

> On Wed, 7 Feb 2024 13:07:36 +0100
> Mete Durlu <meted@linux.ibm.com> wrote:
>
>> wouldn't the following scenario explain the behavior we are seeing.
>> When using event triggers, trace uses lockless ringbuffer control paths.
>> If cmdline update and trace output reading is happening on different
>> cpus, the ordering can get messed up.
>>
>> 1. event happens and trace trigger tells ring buffer to stop writes
>> 2. (on cpu#1)test calculates checksum on current state of trace
>>     output.
>> 3. (on cpu#2)not knowing about the trace buffers status yet, writer adds
>>     a one last entry which would collide with a pid in cmdline map before
>>     actually stopping. While (on cpu#1) checksum is being calculated, new
>>     saved cmdlines entry is waiting for spinlocks to be unlocked and then
>>     gets added.
>> 4. test calculates checksum again and finds that the trace output has
>>     changed. <...> is put on collided pid.
>
> But the failure is here:
>
> on=`cat tracing_on`
> if [ $on != "0" ]; then
>     fail "Tracing is not off"
> fi

It might be misleading because we're discussing two issues in one
thread. The failure above was one problem, which the initial fix
is for. The other issue we're still seeing is the test below:

> csum1=`md5sum trace`
> sleep $SLEEP_TIME
> csum2=`md5sum trace`
>
> if [ "$csum1" != "$csum2" ]; then
>     fail "Tracing file is still changing"
> fi
>
> 1. tracing is off
> 2. do checksum of trace
> 3. sleep
> 4. do another checksum of trace
> 5. compare the two checksums
>
> Now how did they come up differently in that amount of time? The
> saved_cmdlines really should not have been updated.

My assumption without reading the code is that something like this
happens:

CPU0                             CPU1
[ringbuffer enabled]
                                 ring_buffer_write()
                                     if (atomic_read(&buffer->record_disabled))
                                            goto out;
echo 0 > tracing_on
record_disabled |= RB_BUFFER_OFF
csum1=`md5sum trace`
                                 [adds trace entry to ring buffer,
                                  overwriting savedcmd_lines entry because
                                  it thinks ring buffer is enabled]
csum2=`md5sum trace`


