Return-Path: <linux-kernel+bounces-112583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07433887BAC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 05:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29AD21C20D4C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 04:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD5513AC5;
	Sun, 24 Mar 2024 04:46:50 +0000 (UTC)
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09EB33CA;
	Sun, 24 Mar 2024 04:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711255609; cv=none; b=uXZowhZKakjmMGn0NcIyZwN7pKVomP4dtKGYEltKNYgOJrG6PYcfDNMC+AxmHbwx/8wf90MKGkkjImQz+5EUQBhqCJrQdcQyZxbxw/V4yutOiC7RudB57wl1YovQxN3rgXPcn4LYzUrWNRcsypsPSDphlXITf0WAMimLALbmktk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711255609; c=relaxed/simple;
	bh=yVR06Ih/KJ5pGPueVFaxchOrqFkSterp3P0mEJLquFQ=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=BG9L7YdDm0LbXCMI5seC56EqI6EGyAOAvRS+3iMf7CWJ1yLfCLfsq9IAqhBqb3EtR81rzThIyW6iwUN0HTBhdMzpTlPpnb+DysbI9o6mog7w3TO4Jf9FpaPkrACOuCgzc3e2T324oZuzBLkI9hg8yMvVPRdFW3rWRC1hNMPpOp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:52900)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1roFkj-00AWYi-75; Sat, 23 Mar 2024 22:46:37 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:33228 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1roFki-0097H7-5N; Sat, 23 Mar 2024 22:46:36 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Steve Wahl <steve.wahl@hpe.com>,  Dave Hansen
 <dave.hansen@linux.intel.com>,  Andy Lutomirski <luto@kernel.org>,  Peter
 Zijlstra <peterz@infradead.org>,  Thomas Gleixner <tglx@linutronix.de>,
  Ingo Molnar <mingo@redhat.com>,  Borislav Petkov <bp@alien8.de>,
  x86@kernel.org,  "H. Peter Anvin" <hpa@zytor.com>,
  linux-kernel@vger.kernel.org,  Linux regressions mailing list
 <regressions@lists.linux.dev>,  Pavin Joseph <me@pavinjoseph.com>,
  stable@vger.kernel.org,  Eric Hagberg <ehagberg@gmail.com>,  Simon Horman
 <horms@verge.net.au>,  Dave Young <dyoung@redhat.com>,  Sarah Brofeldt
 <srhb@dbc.dk>,  Russ Anderson <rja@hpe.com>,  Dimitri Sivanich
 <sivanich@hpe.com>
References: <20240322162135.3984233-1-steve.wahl@hpe.com>
	<8cc9e238-fa70-402f-9990-f7e391b367a9@intel.com>
Date: Sat, 23 Mar 2024 23:45:45 -0500
In-Reply-To: <8cc9e238-fa70-402f-9990-f7e391b367a9@intel.com> (Dave Hansen's
	message of "Fri, 22 Mar 2024 16:29:27 -0700")
Message-ID: <87r0g09r0m.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1roFki-0097H7-5N;;;mid=<87r0g09r0m.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+1mU387us5HCk1pfooEbFfD96wfus8BAg=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4951]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Dave Hansen <dave.hansen@intel.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 492 ms - load_scoreonly_sql: 0.05 (0.0%),
	signal_user_changed: 14 (2.9%), b_tie_ro: 9 (1.9%), parse: 0.80 (0.2%),
	 extract_message_metadata: 10 (1.9%), get_uri_detail_list: 1.51 (0.3%),
	 tests_pri_-2000: 4.2 (0.8%), tests_pri_-1000: 2.9 (0.6%),
	tests_pri_-950: 0.97 (0.2%), tests_pri_-900: 0.80 (0.2%),
	tests_pri_-90: 79 (16.0%), check_bayes: 77 (15.7%), b_tokenize: 8
	(1.6%), b_tok_get_all: 11 (2.2%), b_comp_prob: 2.7 (0.6%),
	b_tok_touch_all: 53 (10.8%), b_finish: 0.72 (0.1%), tests_pri_0: 366
	(74.4%), check_dkim_signature: 0.51 (0.1%), check_dkim_adsp: 2.7
	(0.6%), poll_dns_idle: 1.16 (0.2%), tests_pri_10: 2.1 (0.4%),
	tests_pri_500: 9 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] x86/mm/ident_map: Use full gbpages in identity maps
 except on UV platform.
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)

Dave Hansen <dave.hansen@intel.com> writes:

> On 3/22/24 09:21, Steve Wahl wrote:
>> Some systems have ACPI tables that don't include everything that needs
>> to be mapped for a successful kexec.  These systems rely on identity
>> maps that include the full gigabyte surrounding any smaller region
>> requested for kexec success.  Without this, they fail to kexec and end
>> up doing a full firmware reboot.
>
> I'm still missing something here.  Which ACPI tables are we talking
> about?  What don't they map?  I normally don't think of ACPI _tables_ as
> "mapping" things.

Either E820 or ACPI lists which areas of memory are present in a
machine.  Those tables are used to build the identity memory mappings.

Those identity mapped page tables not built with GB pages cause kexec to
fail for at least 3 people.  Presumably because something using those
page tables accesses memory that is not mapped.

> It seems like there's a theory that some ACPI table isn't mapped, but
> looking through the discussion so far I don't see a smoking gun.  Let's
> say the kernel has a bug and the kernel was actively not mapping
> something that it should have mapped.  The oversized 1GB mappings made
> the bug harder to hit.  If that's the case, we'll just be adding a hack
> which papers over the bug instead of fixing it properly.
>
> I'm kind of leaning to say that we should just revert d794734c9bbf and
> have the UV folks go back to the nogbpages until we get this properly
> sorted.

That is exactly what this patch does.  It reverts the change except
on UV systems.

>> @@ -10,6 +10,7 @@ struct x86_mapping_info {
>>  	unsigned long page_flag;	 /* page flag for PMD or PUD entry */
>>  	unsigned long offset;		 /* ident mapping offset */
>>  	bool direct_gbpages;		 /* PUD level 1GB page support */
>> +	bool direct_gbpages_always;	 /* use 1GB pages exclusively */
>>  	unsigned long kernpg_flag;	 /* kernel pagetable flag override */
>>  };
>
> But let's at least talk about this patch in case we decide to go forward
> with it.  We've really got two things:
>
> 1. Can the system use gbpages in the first place?
> 2. Do the gbpages need to be exact (UV) or sloppy (everything else)?
>
> I wouldn't refer to this at all as "always" use gbpages.  It's really a
> be-sloppy-and-paper-over-bugs mode.  They might be kernel bugs or
> firmware bugs, but they're bugs _somewhere_ right?

Is it?

As far as I can tell the UV mode is be exact and avoid cpu bugs mode.

My sense is that using GB pages for everything (when we want an identity
mapping) should be much cheaper TLB wise, so we probably want to use GB
pages for everything if we can.

Personally I'd rather turn of the page tables entirely for kexec but
that is not an option in x86_64.

Eric



