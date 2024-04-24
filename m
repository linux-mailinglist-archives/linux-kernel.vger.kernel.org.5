Return-Path: <linux-kernel+bounces-157722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E22C8B150F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF6A61C236D7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B999156992;
	Wed, 24 Apr 2024 21:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tk6CODpc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B801E745CB;
	Wed, 24 Apr 2024 21:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713992969; cv=none; b=AX5d5MVYhhcNk83IbIDt3UOdeenAwo5xaU1tlH69dp1kMMKSLDxICsc+cM2OAvasLvbwoWY1uiakmRHaywOvh55jEFpgQgABew5MOq8GRF3yzO9JnzCc8HUD1iS8e05N00X5xiqrFK0fi1q99saPj9oS5sz85uNXEHzhw9SBHb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713992969; c=relaxed/simple;
	bh=WtRVZAYfjCSELqE6SJYhA7wi/mQscM6/bN4aAcsYB4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sw4bPdEP9JtKnHLEnxLR+s4xJFsRk2XS31vbKVVsd3aVbG9Eiu8NqZLNEHfvKu/WnfrdKVCWr0OHoANj4Q8jQtvBnAvjkc6gNCh7PVLmuFhtO1AQjWfK1/LyqFto7ttKun79XCCr28jgSuTKKPaZBthx+uO+v5vTFKL/lFKLjpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tk6CODpc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12CABC113CD;
	Wed, 24 Apr 2024 21:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713992969;
	bh=WtRVZAYfjCSELqE6SJYhA7wi/mQscM6/bN4aAcsYB4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tk6CODpcUBs/befweQZ/UTc28JcNAN8SbSNtICHU1iDuyakWoChUZLesJVCH50icO
	 lrN3fghAX8lPvubQos0fLoQDtWsGquzJVZmQsrOcK8MBf7+y7dn2k7NBXue1tra3ja
	 nJ4GHhHUl5rtR1LcvvI6OeHzDjNt/SEev8CuaDYvTBUsKCGxX/l1kJ0OSD3weRmHt7
	 /XV+ND23TPTOgRbDO8DKsj8b4FPFlRAT9KgQZ3+jtjn9E9DLwtrk5/DlJJdutyoYfc
	 btp8/TxCA7LvvLrqPkbyZgqFj2lC1pN1buvf1iiDhDIcQcOZEiKrFFCGdwMzhswGFn
	 F5sLcyAk9h2Sw==
Date: Wed, 24 Apr 2024 14:09:27 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v4 28/71] x86/bugs: Switch to new Intel CPU model defines
Message-ID: <20240424210927.woup2cyqajrvpjkw@treble>
References: <20240424181245.41141-1-tony.luck@intel.com>
 <20240424181507.41693-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240424181507.41693-1-tony.luck@intel.com>

On Wed, Apr 24, 2024 at 11:15:07AM -0700, Tony Luck wrote:
> New CPU #defines encode vendor and family as well as model.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh

