Return-Path: <linux-kernel+bounces-125948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA9C892E86
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 05:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE11B2823D5
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 03:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFCA20E3;
	Sun, 31 Mar 2024 03:56:06 +0000 (UTC)
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6196F15A5;
	Sun, 31 Mar 2024 03:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711857365; cv=none; b=tg8nFyJ8+UqSwx9CyFXpiYGaDg4kLdcOhO/BYn877nBddORpytJmOSREnDGpO1jIuNYPgSJ+EIZmIvUI3p3Q/alMHUTl7axRENiYRjgG8URGr7hxWv7zTBgDZ0CyuImoL+aPd8Yu5+BiNjY9aeL4Cwqjil0eY7O+eLqykL6vRUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711857365; c=relaxed/simple;
	bh=AAkRuLGOG4uqK+pVFGRIXj1u90Wm2JoqrdOoOkvsh88=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=N1wA9usPrCwIUEKgiXK9aTjVxeYAS2Yj+Ti1SPq4eSFp/4eG1J6YeRw6b1s6Pqh9y6WkjnOgK4EIQpTUBvSwV67tGBtrHn6rGRYl0V/6gQMFj1hkhPVGTpWsfx/MX71Rkn9bfaQcn+brY9Zovoow5ZEg6HQbv613GVLQjVGjAzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:37872)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rqmIc-006R2Q-0g; Sat, 30 Mar 2024 21:56:02 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:42414 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rqmIa-00BOOY-SP; Sat, 30 Mar 2024 21:56:01 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Pavin Joseph <me@pavinjoseph.com>,  Steve Wahl <steve.wahl@hpe.com>,
  Dave Hansen <dave.hansen@linux.intel.com>,  Andy Lutomirski
 <luto@kernel.org>,  Peter Zijlstra <peterz@infradead.org>,  Thomas
 Gleixner <tglx@linutronix.de>,  Ingo Molnar <mingo@redhat.com>,  Borislav
 Petkov <bp@alien8.de>,  x86@kernel.org,  "H. Peter Anvin" <hpa@zytor.com>,
  linux-kernel@vger.kernel.org,  Linux regressions mailing list
 <regressions@lists.linux.dev>,  stable@vger.kernel.org,  Eric Hagberg
 <ehagberg@gmail.com>,  Simon Horman <horms@verge.net.au>,  Dave Young
 <dyoung@redhat.com>,  Sarah Brofeldt <srhb@dbc.dk>,  Russ Anderson
 <rja@hpe.com>,  Dimitri Sivanich <sivanich@hpe.com>,  Hou Wenlong
 <houwenlong.hwl@antgroup.com>,  Andrew Morton <akpm@linux-foundation.org>,
  Baoquan He <bhe@redhat.com>,  Yuntao Wang <ytcoode@gmail.com>,  Bjorn
 Helgaas <bhelgaas@google.com>
References: <20240328160614.1838496-1-steve.wahl@hpe.com>
	<ZgZqhWoRZoq5tJoU@gmail.com>
	<47302624-6466-41a7-85db-f6872d58a4d2@pavinjoseph.com>
	<ZgZ4qlbncvxhboQ0@gmail.com>
	<be5982f8-3928-455e-969c-1e4c419d80a2@pavinjoseph.com>
	<ZgbCfVPvWroCnGE4@gmail.com>
Date: Sat, 30 Mar 2024 22:55:53 -0500
In-Reply-To: <ZgbCfVPvWroCnGE4@gmail.com> (Ingo Molnar's message of "Fri, 29
	Mar 2024 14:30:37 +0100")
Message-ID: <871q7r12d2.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1rqmIa-00BOOY-SP;;;mid=<871q7r12d2.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/kWo8wjQwNMWG010uyvizqLJN0L8iVgO0=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4922]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	*  0.0 T_TooManySym_03 6+ unique symbols in subject
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Ingo Molnar <mingo@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 518 ms - load_scoreonly_sql: 0.05 (0.0%),
	signal_user_changed: 13 (2.5%), b_tie_ro: 11 (2.2%), parse: 1.72
	(0.3%), extract_message_metadata: 19 (3.6%), get_uri_detail_list: 2.4
	(0.5%), tests_pri_-2000: 7 (1.4%), tests_pri_-1000: 6 (1.2%),
	tests_pri_-950: 1.84 (0.4%), tests_pri_-900: 1.47 (0.3%),
	tests_pri_-90: 100 (19.3%), check_bayes: 84 (16.2%), b_tokenize: 13
	(2.4%), b_tok_get_all: 9 (1.8%), b_comp_prob: 3.1 (0.6%),
	b_tok_touch_all: 54 (10.5%), b_finish: 1.18 (0.2%), tests_pri_0: 334
	(64.4%), check_dkim_signature: 0.69 (0.1%), check_dkim_adsp: 3.1
	(0.6%), poll_dns_idle: 0.93 (0.2%), tests_pri_10: 5 (1.0%),
	tests_pri_500: 24 (4.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v4] x86/mm/ident_map: On UV systems, use gbpages only
 where full GB page should be mapped.
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)

Ingo Molnar <mingo@kernel.org> writes:

> * Pavin Joseph <me@pavinjoseph.com> wrote:
>
>> On 3/29/24 13:45, Ingo Molnar wrote:
>> > Just to clarify, we have the following 3 upstream (and soon to be upstream) versions:
>> > 
>> >   v1: pre-d794734c9bbf kernels
>> >   v2: d794734c9bbf x86/mm/ident_map: Use gbpages only where full GB page should be mapped.
>> >   v3: c567f2948f57 Revert "x86/mm/ident_map: Use gbpages only where full GB page should be mapped."
>> > 
>> > Where v1 and v3 ought to be the same in behavior.
>> > 
>> > So how does the failure matrix look like on your systems? Is my
>> > understanding accurate:
>
>> Slight correction:
>> 
>>    regular boot  | regular kexec | nogbpages boot | nogbpages kexec boot
>> -----------------|---------------|----------------|------------------
>> v1:       OK     | OK            | OK             | FAIL
>> v2:       OK     | FAIL          | OK             | FAIL
>
> Thanks!
>
> So the question is now: does anyone have a theory about in what fashion 
> the kexec nogbpages bootup differs from the regular nogbpages bootup to 
> break on your system?
>
> I'd have expected the described root cause of the firmware not properly 
> enumerating all memory areas that need to be mapped to cause trouble on 
> regular, non-kexec nogbpages bootups too. What makes the kexec bootup 
> special to trigger this crash?

My blind hunch would be something in the first 1MiB being different.
The first 1MiB is where all of the historical stuff is and where
I have seen historical memory maps be less than perfectly accurate.

Changing what is mapped being the difference between success and failure
sounds like some place that is dark and hard to debug a page fault is
being triggered and that in turn becoming a triple fault.

Paving Joseph is there any chance you can provide your memory map?
Perhaps just cat /proc/iomem?

If I have something to go one other than works/doesn't work I can
probably say something intelligent.

Eric

