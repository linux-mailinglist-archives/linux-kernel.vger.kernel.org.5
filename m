Return-Path: <linux-kernel+bounces-150886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA848AA63C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 02:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D616D1F220B7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 00:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF32C7E1;
	Fri, 19 Apr 2024 00:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3OOXQdd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01B2384
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 00:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713486703; cv=none; b=WN2g1IpvN0oPjkUjJvJR9gMzZkDZU0t7NULv6VNmMrW6sgkKgEDWn2jzSzTqOaGACiXZbjBKWtvY1mNscYXHgbxgdbJRTFbDAqMDDHB9uGySq+prOCmrNJP20pOVQ5wR65lms132mozYyDlLRnDuhKBG37gU9DduXsmQyu4aIa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713486703; c=relaxed/simple;
	bh=afqxxhV/UjurKNem0VkvBnc+8N2Ycl93sGw2OtrQE3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJQ4imTchIP5g1N49thaAG4ZX3HXpbdNJyFJANxQZqX3lUV041LLIf3km5AVJC6zWVzbrMgRdc1T4RT6zy3+rbk19g+bzS3zgWUtIWs0VKpiyg03QL1BU/LkUd90orEL31I4Z0g0byYqDFUd0GLae7ZoBfvfPWVBApCByG36N4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3OOXQdd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0FEC113CC;
	Fri, 19 Apr 2024 00:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713486702;
	bh=afqxxhV/UjurKNem0VkvBnc+8N2Ycl93sGw2OtrQE3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D3OOXQdd0CfBA7jmq53UJ3aUWUC7X9gsdddfI65858DtpBTUuokqD4A8iKJUM4hsD
	 EIQPenMEUTHW7C9c/2ystoSStr1xjhIG2+IIfZJ/wYXxqcUVwr10sQdsSgbPlmLpvL
	 ro6ZR1LMdAKSshTaDOilLEl6BcarUu69RVVUrkeAqO0pWB4+5VKZbgLR3wdQH/B1ZZ
	 GiH5Cns8jlMnvJ+R7hu2eHlSWxpRaHFA+1CDRWepM69Ar6LidbuteeaYEiPy5yCciu
	 NNoJ1zfrKjGIRTvFpGU+I0sY0AaHqF7IRPnTHXIy/cLsEKpTHnUx7WPpOo+eA0MHEl
	 QTvANbk1wJlBA==
Date: Thu, 18 Apr 2024 17:31:39 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
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
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	KP Singh <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3] x86/bugs: Only harden syscalls when needed
Message-ID: <20240419003139.kjfepjhjcjzexqpr@treble>
References: <eda0ec65f4612cc66875aaf76e738643f41fbc01.1713296762.git.jpoimboe@kernel.org>
 <ZiDCz3_0cy1ulw9S@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZiDCz3_0cy1ulw9S@infradead.org>

On Wed, Apr 17, 2024 at 11:50:55PM -0700, Christoph Hellwig wrote:
> On Tue, Apr 16, 2024 at 04:02:21PM -0700, Josh Poimboeuf wrote:
> > Syscall hardening (i.e., converting the syscall indirect branch to a
> > series of direct branches) may cause performance regressions in certain
> > scenarios.
> 
> Maybe spell out the scenarios, as this just sounds like hand waiving
> right now..

Will do.

-- 
Josh

