Return-Path: <linux-kernel+bounces-117323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2358388AA01
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CBB01F68484
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93F75D467;
	Mon, 25 Mar 2024 15:05:14 +0000 (UTC)
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7063DABEF;
	Mon, 25 Mar 2024 15:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711379114; cv=none; b=fQsReQV6idT7eD3USVAvKVeUmgOXoOJ6bomCfiDMHLtWoyuRGnwC/9BucLjGTCaQ5ql9zFUXP9Ro2oEQrC8sA0PJNVVYuUfz6bDzewFtiNVAWKqycohzMlaTliVCpvKd+dfsJ5sOdtT0WH/oBgNWi+n+lJt3VbcMpJm3cUPCOxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711379114; c=relaxed/simple;
	bh=8g+oHovsLguRb7qPa/NTWa64s2iwYsQxbUdFpJ1FTLg=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=Dz8YPYKLFUnfgB7xAjtPZLha0e8gbhI5Vg0WY+9q78NL0F+v6vYxG523QLa13t0eG+Gq5WW/lkraHCFz/FukFpn6sB7JxAnAKkeLfnywOA4W1MHBWq4Pdi1JBizl/oSyUQjoDpdZaSXx+xrHWsDLp+x/Xly9xgz9EzkCDm2SHtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:57906)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rolsl-00DPp3-Id; Mon, 25 Mar 2024 09:05:03 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:52092 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rolsk-00AUl2-E2; Mon, 25 Mar 2024 09:05:03 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Russ Anderson <rja@hpe.com>
Cc: Ingo Molnar <mingo@kernel.org>,  Steve Wahl <steve.wahl@hpe.com>,  Dave
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
Date: Mon, 25 Mar 2024 10:04:41 -0500
In-Reply-To: <20240325020334.GA10309@hpe.com> (Russ Anderson's message of
	"Sun, 24 Mar 2024 21:03:34 -0500")
Message-ID: <87o7b273p2.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1rolsk-00AUl2-E2;;;mid=<87o7b273p2.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+ZtzFswDvp6s1F4eomy+VsibAq3KSeLJo=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: *
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4988]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  0.8 XM_B_SpammyWords2 Two or more commony used spammy words
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Russ Anderson <rja@hpe.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 584 ms - load_scoreonly_sql: 0.06 (0.0%),
	signal_user_changed: 9 (1.5%), b_tie_ro: 7 (1.3%), parse: 0.84 (0.1%),
	extract_message_metadata: 13 (2.3%), get_uri_detail_list: 2.3 (0.4%),
	tests_pri_-2000: 22 (3.7%), tests_pri_-1000: 2.9 (0.5%),
	tests_pri_-950: 1.01 (0.2%), tests_pri_-900: 0.85 (0.1%),
	tests_pri_-90: 171 (29.2%), check_bayes: 169 (29.0%), b_tokenize: 9
	(1.6%), b_tok_get_all: 11 (1.9%), b_comp_prob: 3.2 (0.6%),
	b_tok_touch_all: 141 (24.2%), b_finish: 0.96 (0.2%), tests_pri_0: 343
	(58.8%), check_dkim_signature: 0.48 (0.1%), check_dkim_adsp: 2.2
	(0.4%), poll_dns_idle: 0.57 (0.1%), tests_pri_10: 3.9 (0.7%),
	tests_pri_500: 14 (2.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] x86/mm/ident_map: Use full gbpages in identity maps
 except on UV platform.
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)

Russ Anderson <rja@hpe.com> writes:

> On Sun, Mar 24, 2024 at 11:31:39AM +0100, Ingo Molnar wrote:
>> 
>> * Steve Wahl <steve.wahl@hpe.com> wrote:
>> 
>> > Some systems have ACPI tables that don't include everything that needs
>> > to be mapped for a successful kexec.  These systems rely on identity
>> > maps that include the full gigabyte surrounding any smaller region
>> > requested for kexec success.  Without this, they fail to kexec and end
>> > up doing a full firmware reboot.
>> > 
>> > So, reduce the use of GB pages only on systems where this is known to
>> > be necessary (specifically, UV systems).
>> > 
>> > Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
>> > Fixes: d794734c9bbf ("x86/mm/ident_map: Use gbpages only where full GB page should be mapped.")
>> > Reported-by: Pavin Joseph <me@pavinjoseph.com>
>> 
>> Sigh, why was d794734c9bbf marked for a -stable backport? The commit 
>> never explains ...
>
> I will try to explain, since Steve is offline.  That commit fixes a
> legitimate bug where more address range is mapped (1G) than the
> requested address range.  The fix avoids the issue of cpu speculativly
> loading beyond the requested range, which inludes specutalive loads
> from reserved memory.  That is why it was marked for -stable.

To call that a bug presumes that the memory type range registers
were not setup properly by the boot firmware.

I think I saw something that the existence of memory type range
registers is changing/has changed in recent cpus, but historically it
has been the job of the memory type range registers to ensure that the
attributes of specific addresses are correct.

The memory attributes should guide the speculation.

To depend upon page tables to ensure the attributes are correct would
presumably require a cpu that does not have support for disabling page
tables in 32bit mode and does not have 16bit mode.

On older systems (I haven't looked lately) I have seen all kinds of
oddities in the descriptions of memory.  Like not describing the memory
at address 0 where the real mode IDT lives.  So I am not at all certain
any firmware information can be depended upon or reasonably expected to
be complete.  For a while there was no concept of firmware memory areas
so on some older systems it was actually required for their to be gaps
in the description of memory provided to the system, so that operating
systems would not touch memory used by the firmware.

Which definitely means in the case of kexec there are legitimate reasons
to access memory areas that are well known but have not always been
descried by the boot firmware.  So the assertion that it is necessarily
a firmware bug for not describing all of memory of memory is at least
historically incorrect on x86_64.

There may be different requirements for the kexec identity map and the
ordinary kernel boot type memory map and as we look at solutions that
can reasonably be explored

> Some memory ends up not being mapped, but it is not
> clear if it is due to some other bug, such as bios not accurately
> providing the right memory map or some other kernel code path did
> not map what it should.

> The 1G mapping covers up that type issue.

I have seen this assertion repeated several times, and at least
historically on x86_64 it is most definitely false.   The E820 map which
was the primary information source for a long time could not describe
all of memory so depending upon it to be complete is erroneous.

>> When there's boot breakage with new patches, we back out the bad patch 
>> and re-try in 99.9% of the cases.
>
> Steve can certainly merge his two patches and resubmit, to replace the
> reverted original patch.  He should be on in the morning to speak for
> himself.

I am going to push back and suggest that this is perhaps a bug in the
HPE UV systems firmware not setting up the cpus memory type range
registers correctly.

Unless those systems are using new fangled cpus that don't have 16bit
and 32bit support, and don't implement memory type range registers,
I don't see how something that only affects HPE UV systems could be
anything except an HPE UV specific bug.

Eric

