Return-Path: <linux-kernel+bounces-143422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C838A38B1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 00:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58E60B2239C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7940315217D;
	Fri, 12 Apr 2024 22:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmO4P7Pq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8084C6E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 22:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712962708; cv=none; b=F2vBL75Kswqzpgg/wmtUqETvDIr/Qr3ZqnJ5AuAWctWxh2UerwTuypCHdQ9aBuN+YAbL2V7/2JIoXDGk6O1c4wYcSEZqsLONwVFthA/+QWNBFiMF16PBC1N8on9iPvykNAxAoSrrNEhug8YXsacEYxjIzDRt5XmkTwTz46+41c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712962708; c=relaxed/simple;
	bh=XtRVdyDfNNTzE6XODtSq713n/AxyzUDycBzMGhRjTE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BL2wy7Z72d1CfElqiyLWR0KBGn2SB9caQwKE0PzccfgxQKisPUyKK+yt8xCN3MwlwOD83E9F8fQhnk7nRigtclYuLqSQBMZL+wPtFVHrZnK6yMattEbRz4vyRFzUA/n4HEtTokTO29ReCjRpStyVljgyeb46HxJyGsr7zCh2VmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmO4P7Pq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B603C113CC;
	Fri, 12 Apr 2024 22:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712962708;
	bh=XtRVdyDfNNTzE6XODtSq713n/AxyzUDycBzMGhRjTE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GmO4P7PqI9w/uAHXW7XSIRYn6UJaXTSS0jz0QUncRoV9gd66N2zt8DGAgpO9d6QnH
	 dGebfHjENBZEMDLcfb20mVWpP7arPGa5xFSOmww9MIDV9C6HvT5HjPxbULZX966YE6
	 vO1+xWzYYLv+C5uxnsgwUAylpodmRRXMJdEuIam9f25jE1QmX/Q/OxKGJqMhGRXvcF
	 6AL2zpDY1N0Suv6coCkLnIRsTmedb2Ais0uqEa5oVJ8iR940I+6PnE+HD+qILt9mqK
	 pPAS0E2YG0vvKUo7BxjE+VUihW5I+r5vuQsweC3cFlHit8i72OukGzr0l1NL53uAZR
	 eATiCn3j55C3w==
Date: Fri, 12 Apr 2024 15:58:25 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	KP Singh <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2 1/3] x86/bugs: Only harden syscalls when needed
Message-ID: <20240412225825.3tgtu4opi2e5jucg@treble>
References: <cover.1712944776.git.jpoimboe@kernel.org>
 <079f24edefb5b47e922c2804f199463e04ccf0c8.1712944776.git.jpoimboe@kernel.org>
 <20240412224232.uiaht6yx2ghtx3gg@desk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240412224232.uiaht6yx2ghtx3gg@desk>

On Fri, Apr 12, 2024 at 03:42:32PM -0700, Pawan Gupta wrote:
> On Fri, Apr 12, 2024 at 11:10:32AM -0700, Josh Poimboeuf wrote:
> > diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> > index 3c7434329661..7c87fe80c696 100644
> > --- a/arch/x86/include/asm/cpufeatures.h
> > +++ b/arch/x86/include/asm/cpufeatures.h
> > @@ -470,6 +470,7 @@
> >  #define X86_FEATURE_BHI_CTRL		(21*32+ 2) /* "" BHI_DIS_S HW control available */
> >  #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* "" BHI_DIS_S HW control enabled */
> >  #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* "" Clear branch history at vmexit using SW loop */
> > +#define X86_FEATURE_INDIRECT_SAFE	(21*32+ 4) /* "" Indirect branches aren't vulnerable to Spectre v2 */
> 
> This should be (21*32+ 5).

Argh :-/

> Other than that:
> 
> Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

Thanks!

-- 
Josh

