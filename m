Return-Path: <linux-kernel+bounces-121329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 772F988E614
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1259C295B16
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB33812F580;
	Wed, 27 Mar 2024 12:58:52 +0000 (UTC)
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D8812C80B;
	Wed, 27 Mar 2024 12:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711544332; cv=none; b=Zs0qQwzKETCaWzADIixsXuQ5TmBQOOJPkXL6h+9RH0nh9m77He39ItkUZTJGH4YSWzutKrodYDh0BjnqR/+LMPLFBqUpJ6kmUFuTLVceSp8RAvVu7aUJQF1fkAr5gzjWgNttbU99C2pEhwD67Y7gzDspw6V4MjCYnyQy9TuWVCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711544332; c=relaxed/simple;
	bh=iG8uPrBOIOH+AQyDUzYn/BzO2DNiuhvbgR0PyAf2uwk=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=Knqja2l5ETFLunV0iEgHkeqd7FQHFY99Mk3+OXsJzFb2yS362HwKnOfhwsnxP2n2VoKLKIogwJNEk1PU8LbfepbGHlyEWW8LhWzOC1um05JWZFsNdyr9kDViGSleBhfxnvPL+XpO/7swVorp13slqmqKV9sGhInH6zv+vnameBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:49876)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rpSrZ-001fy3-Ti; Wed, 27 Mar 2024 06:58:41 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:50926 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rpSrY-00GeAq-LA; Wed, 27 Mar 2024 06:58:41 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Steve Wahl <steve.wahl@hpe.com>
Cc: Russ Anderson <rja@hpe.com>,  Ingo Molnar <mingo@kernel.org>,  Dave
 Hansen <dave.hansen@linux.intel.com>,  Andy Lutomirski <luto@kernel.org>,
  Peter Zijlstra <peterz@infradead.org>,  Thomas Gleixner
 <tglx@linutronix.de>,  Ingo Molnar <mingo@redhat.com>,  Borislav Petkov
 <bp@alien8.de>,  x86@kernel.org,  "H. Peter Anvin" <hpa@zytor.com>,
  linux-kernel@vger.kernel.org,  Linux regressions mailing list
 <regressions@lists.linux.dev>,  Pavin Joseph <me@pavinjoseph.com>,
  stable@vger.kernel.org,  Eric Hagberg <ehagberg@gmail.com>,  Simon Horman
 <horms@verge.net.au>,  Dave Young <dyoung@redhat.com>,  Sarah Brofeldt
 <srhb@dbc.dk>,  Dimitri Sivanich <sivanich@hpe.com>
References: <20240322162135.3984233-1-steve.wahl@hpe.com>
	<ZgABC1oQ9YJW6Bw3@gmail.com> <20240325020334.GA10309@hpe.com>
	<87o7b273p2.fsf@email.froward.int.ebiederm.org>
	<ZgHTXvCQr6ycbVzp@swahl-home.5wahls.com>
Date: Wed, 27 Mar 2024 07:57:52 -0500
In-Reply-To: <ZgHTXvCQr6ycbVzp@swahl-home.5wahls.com> (Steve Wahl's message of
	"Mon, 25 Mar 2024 14:41:18 -0500")
Message-ID: <87r0fv6ddb.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1rpSrY-00GeAq-LA;;;mid=<87r0fv6ddb.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18MbAr20HjhuH3WMgkVKae6ZAm/7EpD1rc=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4918]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Steve Wahl <steve.wahl@hpe.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 699 ms - load_scoreonly_sql: 0.11 (0.0%),
	signal_user_changed: 13 (1.9%), b_tie_ro: 11 (1.6%), parse: 1.68
	(0.2%), extract_message_metadata: 19 (2.7%), get_uri_detail_list: 2.9
	(0.4%), tests_pri_-2000: 7 (1.0%), tests_pri_-1000: 5 (0.7%),
	tests_pri_-950: 1.68 (0.2%), tests_pri_-900: 1.37 (0.2%),
	tests_pri_-90: 65 (9.3%), check_bayes: 64 (9.1%), b_tokenize: 12
	(1.7%), b_tok_get_all: 10 (1.4%), b_comp_prob: 3.5 (0.5%),
	b_tok_touch_all: 35 (4.9%), b_finish: 0.91 (0.1%), tests_pri_0: 341
	(48.8%), check_dkim_signature: 0.57 (0.1%), check_dkim_adsp: 2.4
	(0.3%), poll_dns_idle: 193 (27.7%), tests_pri_10: 6 (0.8%),
	tests_pri_500: 233 (33.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] x86/mm/ident_map: Use full gbpages in identity maps
 except on UV platform.
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)

Steve Wahl <steve.wahl@hpe.com> writes:

> On Mon, Mar 25, 2024 at 10:04:41AM -0500, Eric W. Biederman wrote:
>> Russ Anderson <rja@hpe.com> writes:
>> > Steve can certainly merge his two patches and resubmit, to replace the
>> > reverted original patch.  He should be on in the morning to speak for
>> > himself.
>> 
>> I am going to push back and suggest that this is perhaps a bug in the
>> HPE UV systems firmware not setting up the cpus memory type range
>> registers correctly.
>> 
>> Unless those systems are using new fangled cpus that don't have 16bit
>> and 32bit support, and don't implement memory type range registers,
>> I don't see how something that only affects HPE UV systems could be
>> anything except an HPE UV specific bug.
>
> Eric,
>
> I took the time to communicate with others in the company who know
> this stuff better than I do before replying on this.
>
> One of the problems with using the MTRRs for this is that there are
> simply not enough of them.  The MTRRs size/alignment requirements mean
> that more than one entry would be required per reserved region, and we
> need one reserved region per socket on systems that currently can go
> up to 32 sockets.  (In case you would think to ask, the reserved
> regions also cannot be made contiguous.)
>
> So MTRRs will not work to keep speculation out of our reserved memory
> regions.
>
> Let me know if you need more information from us on this.

Thanks for this.

Do you know if there are enough MTRRs for the first 4GB?

I am curious if kexec should even consider going into 32bit mode without
page tables or even into 16bit mode on such a system.  Or if such a
system will always require using page tables.

If you don't have enough MTRRs on a big NUMA system I think it is
perfectly understandable, to need to use the page tables.

Please include this the fact that splitting GBpages is necessary because
of a lack of MTRRs in the change description.

Given that it is the lack of MTRRs on a large NUMA system that make the
change necessary.   The goes from a pure bug fix change to a change to
accommodate systems without enough MTRRs.

That information makes it more understandable why older systems (at
least in the case of kexec) might not be ok with the change.  As for
older systems their MTRRs are sufficient and thus they can use fewer
page table entries.  Allowing for use of larger TLB entries.


Eric

