Return-Path: <linux-kernel+bounces-146016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A57888A5EAC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 01:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0E01F2262A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BF3159567;
	Mon, 15 Apr 2024 23:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkYyBw88"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EBC156974
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 23:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713224658; cv=none; b=ZyvkfMMLut+eIN0DRFfArMK78vcuQtE6IKDgfMgCw3UC0rE5wgsf2YmRnndllpQZ42quw4026pEB1Gb0ySDhy1hkvGrP1dqydKGo+A0PMSMjPww/R/zUYSPdQGG7hOl4Ffg9kgxKtXKS573YMFvhu8FqKT/ykVPHPuANX2oIABo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713224658; c=relaxed/simple;
	bh=zpKurUMgjqar+MTlzO/Wp5wCc57TdsSBvHylHxkL37g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgYn6IEKzxiBWokQZRMikKkpAso1K/EdmvTvj3Rz1uozxqo19AQGlxXIqb4fjAREsTBwmLkc1Pzu/eLhiMak/9cUJOJdH+eJH2i4gCBBBFNPTaLcbmw3+EMrGO0paCl2AtKePje8WHOmRzDSqkHgxbYt9WsqaJlLJ3eXyn7xF78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkYyBw88; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7A5C113CC;
	Mon, 15 Apr 2024 23:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713224657;
	bh=zpKurUMgjqar+MTlzO/Wp5wCc57TdsSBvHylHxkL37g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hkYyBw88h2Iu1OWyvZoIBr42/7CbVhy2dbC8h5jDNK63/5HFsOkZr7KQirmtnV0FQ
	 zamkuIpQAwq1Etr04g//xYZEvcqtjMx8ngdZH+AjR5P8brKmS7Bn98IA2FRnZNTvUT
	 c++dzi6ywKS36oc3mIy0pj6Z5CHNBvldA8WqrTgfqy9WPdFkUe2tfciqeqmRZpOfPK
	 VvWuTufrZtZdoQ1tOWborxmSxuvvH0jsJFNJO+1+dOIlC4E17PegyifCUqFbeFP7K/
	 frPpno4/OFlDnwP066wuNexlcU4aclAK/MudrPjIOHZGXMuCbRr4Pzj85inC1R1pW3
	 ku4hJmH0LBatQ==
Date: Mon, 15 Apr 2024 16:44:15 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	KP Singh <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 3/3] x86/bugs: Remove support for Spectre v2 LFENCE
 "retpolines"
Message-ID: <20240415234415.6labhhhbllinzyvp@treble>
References: <cover.1712944776.git.jpoimboe@kernel.org>
 <e5356c0e018cd0a96aabe719f685c237ac519403.1712944776.git.jpoimboe@kernel.org>
 <b0074626-8e98-4573-8047-08916fbb5537@citrix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b0074626-8e98-4573-8047-08916fbb5537@citrix.com>

On Fri, Apr 12, 2024 at 09:49:33PM +0100, Andrew Cooper wrote:
> On 12/04/2024 7:10 pm, Josh Poimboeuf wrote:
> > I found several bugs where code assumes that X86_FEATURE_RETPOLINE
> > actually means retpolines (imagine that!).
> 
> Yeah :(   One could also imagine a past where that was pointed out, or
> just read about it in the archives.
> 
> >   In fact that feature also
> > includes the original AMD LFENCE "retpolines", which aren't in fact
> > retpolines.
> >
> > Really, those "retpolines" should just be removed.  They're already
> > considered vulnerable due to the fact that the speculative window after
> > the indirect branch can still be long enough to do multiple dependent
> > loads.  And recent tooling makes such gadgets easier to find.
> 
> There are two Atom CPUs which are not repotline safe, and for which
> Intel released a statement saying "use lfence/jmp" on these.
> 
> I'm still trying to find it...

Any luck finding it?  The only thing I found [1] isn't exactly a ringing
endorsement of LFENCE;JMP over retpolines.

[1] https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/technical-documentation/branch-history-injection.html

-- 
Josh

