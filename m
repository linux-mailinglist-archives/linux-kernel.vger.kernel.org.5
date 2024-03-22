Return-Path: <linux-kernel+bounces-111915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1CC887297
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3A991C20FFB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7208662173;
	Fri, 22 Mar 2024 18:07:42 +0000 (UTC)
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804B56168B;
	Fri, 22 Mar 2024 18:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711130862; cv=none; b=bSO5/xwgdjU26iGGHsTLvabf/AKJjM1grc/MKbtg8IJ+jAVBjc72ACpbY7NjUvhns+8I+xM0Gk+SAsHF8HgXMxvcQHyL/j+mo5nD2aiKUaJKHQWJclSJH13FdKEVyGJN3CxPDBemFdgssscl9om1VHm0w4jxW5hY8nnbUHsEK0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711130862; c=relaxed/simple;
	bh=epCbL1igJ7lobjd9Ar0a6bb7CfPsN6ZdIgcKRJGWeuI=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=Nnm8SzkJ72gnOKkSy6GeE2FTKzxY3ukFlpAAMGUcd+sPg5U6a9qLedLdAl6ZSGnlOla4RgkkDiwsCCfpmSIwpOtavRr9ttIV4gjkf/ldKcRyC6KrkZodymBP04Jvw3sNtWoUe92CASSKEVL58trS4MgX0mW9Xmr6Hp2JJC5wCWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:46388)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rnik8-0014jr-9d; Fri, 22 Mar 2024 11:31:48 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:37452 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rnik7-004NHx-B5; Fri, 22 Mar 2024 11:31:47 -0600
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
	<003f1e83-fd93-4f4f-a316-d3e89e5a23a5@intel.com>
Date: Fri, 22 Mar 2024 12:31:40 -0500
In-Reply-To: <003f1e83-fd93-4f4f-a316-d3e89e5a23a5@intel.com> (Dave Hansen's
	message of "Fri, 22 Mar 2024 09:27:54 -0700")
Message-ID: <87le6ab2bn.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1rnik7-004NHx-B5;;;mid=<87le6ab2bn.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX182K7ZeK1zm1O7MPM0uW0UgHwiPD3rE928=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4986]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Dave Hansen <dave.hansen@intel.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 426 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 14 (3.3%), b_tie_ro: 12 (2.9%), parse: 1.05
	(0.2%), extract_message_metadata: 13 (2.9%), get_uri_detail_list: 1.09
	(0.3%), tests_pri_-2000: 5 (1.2%), tests_pri_-1000: 3.1 (0.7%),
	tests_pri_-950: 1.35 (0.3%), tests_pri_-900: 1.14 (0.3%),
	tests_pri_-90: 93 (21.7%), check_bayes: 90 (21.1%), b_tokenize: 7
	(1.6%), b_tok_get_all: 8 (2.0%), b_comp_prob: 2.4 (0.6%),
	b_tok_touch_all: 66 (15.6%), b_finish: 1.72 (0.4%), tests_pri_0: 210
	(49.3%), check_dkim_signature: 0.48 (0.1%), check_dkim_adsp: 3.5
	(0.8%), poll_dns_idle: 61 (14.4%), tests_pri_10: 2.1 (0.5%),
	tests_pri_500: 79 (18.6%), rewrite_mail: 0.00 (0.0%)
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
>> 
>> So, reduce the use of GB pages only on systems where this is known to
>> be necessary (specifically, UV systems).
>
> Isn't this called "buggy firmware"?
>
> I'd much rather add synthetic entries to the memory maps that have this
> information than hack around it by assuming that things are within a
> gigabyte.

So this change is a partial revert of a change that broke kexec in
existing configurations.  To fix a regression that breaks kexec.

I don't have enough to know which systems broke.  So I don't know
the difficulty in fixing systems.

Dave do you know what synthetic entries need to be added to the
memory maps to fix the regression?  If not we should go with this
and if we care enough we can add the synthetic entries later.

Eric

