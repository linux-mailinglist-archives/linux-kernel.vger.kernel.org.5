Return-Path: <linux-kernel+bounces-54376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E74984AE6D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD939286932
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 06:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1A512880E;
	Tue,  6 Feb 2024 06:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U7TXTm0w"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C8B127B77;
	Tue,  6 Feb 2024 06:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707201375; cv=none; b=Ic8t1TQMHOARsOb5HxshCKYbAIaLMtH+PJW7r49COkk4oOh/Hs0r1wayEU5/54T2rdcz0BrI9G2CM8Fv+BuzhQDBWVfAZsY+ZLG/SeujGlqFVl0ldc/n2kK73PnufIjs6IhavVx0/c80hT7BRJyVLPaMBT+kri5crWpEx9IwZLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707201375; c=relaxed/simple;
	bh=bThOglmzdhMK28hBp6N65aL0zNw8KG5f1OHgmPfdGvk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZudJAvdeR9EIf3q/ZDXwvUgUrAsT9NbIYPrnL3ANH+PeWluKyKvU0vo5NLjhYw39qQeZuJlWSe/fcaCl4IlnnQFAHkKuZ6iMXH4Zfd0eQBwYv0YCJn/JjG5TQ9l/hotxQjdLTqUQ5ZxKb7HRuWHgpsEwqAmwFbtBBpgIDxlLcLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U7TXTm0w; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4165v3xb002523;
	Tue, 6 Feb 2024 06:36:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=4qfhYcxR39f2g8qTeMlIUPr3GKH2e+75pYMxrTJPrgE=;
 b=U7TXTm0wDC7KLoSOiucZ533en7iqqBWzwFdoXMgTeSWyOiSRM96lcKwWvPMC+xK/Cf33
 rJxIg/mg/fcsThxrstt4cmrzRUysOdKWkG/l6Ofl/2/fj1ls89isTbZP9v879qLlwYzm
 BH6TUCXFNZJIdC/nMULi5zdj28016H3gV0+rWVDqrWKlYrsV93aiuy2d9Cxhdphfcha7
 qtNdlcvFIQX7y/hicLIIKVaJTvqcuQz/K+Li5+lRhqdjweF909i3VuooSNqT2s0FTeC/
 HenaaXTfOmkg+79dtyPNadDuZ/be24oxW1LPMVuj6kr/qAwSp+tCldCsA/kTVTFplMkM xA== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w3exd9427-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 06:36:06 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 416583D4020383;
	Tue, 6 Feb 2024 06:32:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w1ytswk58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 06:32:10 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4166W9av6816372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Feb 2024 06:32:09 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 165302004D;
	Tue,  6 Feb 2024 06:32:09 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E30502004B;
	Tue,  6 Feb 2024 06:32:08 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  6 Feb 2024 06:32:08 +0000 (GMT)
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
Date: Tue, 06 Feb 2024 07:32:08 +0100
Message-ID: <yt9d34u63xxz.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nTITQIJBFvH89v1zAVBFrPiee1g8nRF9
X-Proofpoint-ORIG-GUID: nTITQIJBFvH89v1zAVBFrPiee1g8nRF9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_18,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402060044

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

Looking at trace_save_cmdline():

tpid = tsk->pid & (PID_MAX_DEFAULT - 1); where PID_MAX_DEFAULT = 0x8000

so this is basically

tpid = tsk->pid & 0x7fff;

further on:

        // might clash with other pid if (otherpid & 0x7fff) == (tsk->pid & 0x7fff)
	idx = savedcmd->map_pid_to_cmdline[tpid];
	if (idx == NO_CMDLINE_MAP) {
                // This will pick an existing entry if there are
                // more than cmdline_num entries present
		idx = (savedcmd->cmdline_idx + 1) % savedcmd->cmdline_num;      
		savedcmd->map_pid_to_cmdline[tpid] = idx;
		savedcmd->cmdline_idx = idx;
	}

So i think the problem that sometimes '<...>' instead of the correct
comm is logged is just expected behaviour given the code above. 

