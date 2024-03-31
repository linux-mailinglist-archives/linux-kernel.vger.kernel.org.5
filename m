Return-Path: <linux-kernel+bounces-125939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6D7892E6C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 05:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50156B2166B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 03:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45672566;
	Sun, 31 Mar 2024 03:47:24 +0000 (UTC)
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8040A15A5;
	Sun, 31 Mar 2024 03:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711856844; cv=none; b=UPb7Pv3mZPGzMXmWfn5TvCKxwlPYrBNOORkqncPeUPqLXGjbpgGrPotVvdIA3MNWkT2aLjU3b+/I0eQ+ef38R0vH/a77GS7BkC5hGRyujUhyJcR7Rageze+Gsy6zLVUnHzq9EQXFPE2LUP7A0GgKQpaPCzhjo5Wu6Eu1xyn4ZSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711856844; c=relaxed/simple;
	bh=q/UXeIVEvbuRxXjpDaKpAWZldLOGx4dunY82JvdDwgo=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=bygUVHiSUYVVhwNCvA8FNEnDQ24oCyvjbBBu50FhJk5JUKXQg6+A93nSXIQS14rgopDnFjzzztl448zYhy7t8/SGorK72iEeJhImGeteP8ZTHwc+q1wXfYvzTYo0C9cLSY3QN9plQ2aecxiJQ+waSnjkQzASBKvpK8071nHdvLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:58052)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rqmA4-006QND-0x; Sat, 30 Mar 2024 21:47:12 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:50014 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rqmA2-00BMxw-UQ; Sat, 30 Mar 2024 21:47:11 -0600
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
	<87r0fv6ddb.fsf@email.froward.int.ebiederm.org>
	<ZgQ8Ej-MLlNJR6wn@swahl-home.5wahls.com>
	<87zfuj2bgh.fsf@email.froward.int.ebiederm.org>
	<ZgWO5I_p8zHyp3en@swahl-home.5wahls.com>
Date: Sat, 30 Mar 2024 22:46:21 -0500
In-Reply-To: <ZgWO5I_p8zHyp3en@swahl-home.5wahls.com> (Steve Wahl's message of
	"Thu, 28 Mar 2024 10:38:12 -0500")
Message-ID: <87msqf12sy.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1rqmA2-00BMxw-UQ;;;mid=<87msqf12sy.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18tVHgKQJM7d8W+0ghGuHKCx2buRkgEzhE=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
	*      [score: 0.3191]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Steve Wahl <steve.wahl@hpe.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 529 ms - load_scoreonly_sql: 0.06 (0.0%),
	signal_user_changed: 12 (2.2%), b_tie_ro: 10 (1.9%), parse: 1.18
	(0.2%), extract_message_metadata: 14 (2.6%), get_uri_detail_list: 2.1
	(0.4%), tests_pri_-2000: 5 (1.0%), tests_pri_-1000: 3.7 (0.7%),
	tests_pri_-950: 1.27 (0.2%), tests_pri_-900: 1.10 (0.2%),
	tests_pri_-90: 86 (16.2%), check_bayes: 84 (15.9%), b_tokenize: 11
	(2.0%), b_tok_get_all: 11 (2.1%), b_comp_prob: 3.6 (0.7%),
	b_tok_touch_all: 54 (10.3%), b_finish: 1.11 (0.2%), tests_pri_0: 386
	(73.1%), check_dkim_signature: 0.87 (0.2%), check_dkim_adsp: 2.8
	(0.5%), poll_dns_idle: 1.20 (0.2%), tests_pri_10: 2.3 (0.4%),
	tests_pri_500: 12 (2.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] x86/mm/ident_map: Use full gbpages in identity maps
 except on UV platform.
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)

Steve Wahl <steve.wahl@hpe.com> writes:

> On Thu, Mar 28, 2024 at 12:05:02AM -0500, Eric W. Biederman wrote:
>> 
>> From my perspective the entire reason for wanting to be fine grained and
>> precise in the kernel memory map is because the UV systems don't have
>> enough MTRRs.  So you have to depend upon the cache-ability attributes
>> for specific addresses of memory coming from the page tables instead of
>> from the MTRRs.
>
> It would be more accurate to say we depend upon the addresses not
> being listed in the page tables at all.  We'd be OK with mapped but
> not accessed, if it weren't for processor speculation.  There's no "no
> access" setting within the existing MTRR definitions, though there may
> be a setting that would rein in processor speculation enough to make
> due.

The uncached setting and the write-combining settings that are used for
I/O are required to disable speculation for any regions so marked.  Any
reads or writes to a memory mapped I/O region can result in hardware
with processing it as a command.  Which as I understand it is exactly
the problem with UV systems.

Frankly not mapping an I/O region (in an identity mapped page table)
instead of properly mapping it as it would need to be mapped for
performing I/O seems like a bit of a bug.

>> If you had enough MTRRs more defining the page tables to be precisely
>> what is necessary would be simply an exercise in reducing kernel
>> performance, because it is more efficient in both page table size, and
>> in TLB usage to use 1GB pages instead of whatever smaller pages you have
>> to use for oddball regions.
>> 
>> For systems without enough MTRRs the small performance hit in paging
>> performance is the necessary trade off.
>> 
>> At least that is my perspective.  Does that make sense?
>
> I think I'm begining to get your perspective.  From your point of
> view, is kexec failing with "nogbpages" set a bug?  My point of view
> is it likely is.  I think your view would say it isn't?

I would say it is a bug.

Part of the bug is someone yet again taking something simple that
kexec is doing and reworking it to use generic code, then changing
the generic code to do something different from what kexec needs
and then being surprised that kexec stops working.

The interface kexec wants to provide to whatever is being loaded is not
having to think about page tables until that software is up far enough
to enable their own page tables.

People being clever and enabling just enough pages in the page  tables
to work based upon the results of some buggy (they are always buggy some
are just less so than others) boot up firmware is where I get concerned.

Said another way the point is to build an identity mapped page table.
Skipping some parts of the physical<->virtual identity because we seem
to think no one will use it is likely a bug.

I really don't see any point in putting holes in such a page table for
any address below the highest address that is good for something.  Given
that on some systems the MTRRs are insufficient to do there job it
definitely makes sense to not enable caching on areas that we don't
think are memory.

Eric


