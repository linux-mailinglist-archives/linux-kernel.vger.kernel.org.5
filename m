Return-Path: <linux-kernel+bounces-123970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1177891077
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 266641C26120
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FF217BA1;
	Fri, 29 Mar 2024 01:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmrNDWe7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F28512E61
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 01:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711676375; cv=none; b=IRXkw36sDtSsA80hqEBKU7tMuSyJQZ/Z3PHi42HrKYuD0YI5aKxYcVPy3Emk6qHv0oAHrcNqnk4ggzauCBk4sNhWtVvieoNAMn+7pUoPnue8huD1b27SvLR9iVBD4jpiHGyYD4nOVmcNT2ELvd5n4NgcwnuUp73BIv/hUUp0pUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711676375; c=relaxed/simple;
	bh=a5ieawO8SQeApeL9oKybsPxEd82dEmDBRDRIxBwjcRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSzyKInIVrm4n54JYSRYJzdjg+BDh09a+pdI8OfRZpPLLQaPDOXtxLQL4m9ZNFWLhUdMbIKy/5W595dh04eFj4a4seUTNl1X+nYC4oQl3S+xASepdXwC4nSY4AsLeXri4xWhq1Ea3tjfQNI4+Nxw44VaMJhv0/kGLX1LG9den8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmrNDWe7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1159C433C7;
	Fri, 29 Mar 2024 01:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711676374;
	bh=a5ieawO8SQeApeL9oKybsPxEd82dEmDBRDRIxBwjcRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kmrNDWe7VC2Iv6v7c0lpVD7a5pC8MGsELcd3loeJEUQ/m9S9kcIVYTwePNyflMFgI
	 Cx8JBaKTvJR8p3Bs6VBPaZWa+Y4PN87vGDcbDVfn2E6MI3rEx7a8pZ8OhLI6BRSlfe
	 jwHginDeJnwlzT9xEP/zVKLcothlgnvpy6eE9AqL++177/+a66WtlZ/vy9iuj2bKyb
	 Ab0G03yW32mWB6pwqJEAkTjZh4ln9WCfwW06/0MlL+PCcHgokeV+FP67Ew+MyUKAg2
	 hlt55mBJNB2Y6/kx+IjxbfBAzroof28eAUdntZ1CBLAscatZqHk4Av83oZcnPNI+bq
	 Mjk3xIUDlX4oA==
Date: Thu, 28 Mar 2024 18:39:32 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Alexandre Chartre <alexandre.chartre@oracle.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: Re: [PATCH] objtool/x86: objtool can confuse memory and stack access
Message-ID: <20240329013932.vxqzc74szrckxqdq@treble>
References: <20240328134634.350592-1-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240328134634.350592-1-alexandre.chartre@oracle.com>

On Thu, Mar 28, 2024 at 02:46:34PM +0100, Alexandre Chartre wrote:
> The encoding of an x86 instruction can include a ModR/M and a SIB
> (Scale-Index-Base) byte to describe the addressing mode of the
> instruction.
> 
> objtool processes all addressing mode with a SIB base of 5 as having
> %rbp as the base register. However, a SIB base of 5 means that the
> effective address has either no base (if ModR/M mod is zero) or %rbp
> as the base (if ModR/M mod is 1 or 2). This can cause objtool to confuse
> an absolute address access with a stack operation.
> 
> For example, objtool will see the following instruction:
> 
>  4c 8b 24 25 e0 ff ff    mov    0xffffffffffffffe0,%r12
> 
> as a stack operation (i.e. similar to: mov -0x20(%rbp), %r12).
> 
> [Note that this kind of weird absolute address access is added by the
>  compiler when using KASAN.]
> 
> If this perceived stack operation happens to reference the location
> where %r12 was pushed on the stack then the objtool validation will
> think that %r12 is being restored and this can cause a stack state
> mismatch.
> 
> This kind behavior was seen on xfs code, after a minor change (convert
> kmem_alloc() to kmalloc()):
> 
> >> fs/xfs/xfs.o: warning: objtool: xfs_da_grow_inode_int+0x6c1: stack state mismatch: reg1[12]=-2-48 reg2[12]=-1+0
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202402220435.MGN0EV6l-lkp@intel.com/
> Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>

Nice, thanks for finding and debugging this.

Would it make sense to make the check more generic by putting it into
rm_is()?

-- 
Josh

