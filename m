Return-Path: <linux-kernel+bounces-127361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6E3894A4E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB38C1C2201B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9FF175BD;
	Tue,  2 Apr 2024 04:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jLVoQk3b"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D49175BF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 04:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712031104; cv=none; b=rkBy0kuOmO40twcYH0V5fEjpeW53CZWAf3exrH4dUSxuCSx4irfNfCUqNWbAyc2kioU5QNZh3/u9dU2N930j/+9+CZ5Kb3zxeh70oN3IOKrLVbWQ3bsAqbFdr8IdIbPU9pSA/1Chy19PZDcVkrNVogfGu+Ed2o1It++f4l2J+kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712031104; c=relaxed/simple;
	bh=HKrpCf5hdJblYPSdAfn+r9vPyscHYwnAwcdvv9YswjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zje3LYNwDEDtC0bCP69rSaV3d9HO3D181H3wz29AfqWSqBBSm3j1VMS7OqxXAGgvqKNtMZ3Zq+eT7vop/vjauEgry2JdgOGRWV98jLhs3WdPI5F1M4DQs3+heZWmYVWRbNb3hWlLRpoqKTz/1CYoVcS5cwABwMQC8hE4WWNVjvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jLVoQk3b; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=on2uDY9xoIExekB3f+wnsHvu22s4kf//goF/Vx2reRk=; b=jLVoQk3b5lSeuqEwMknDHFsIn8
	PIQmigKY348kr3rXQm1//TK18+YPP6Zhk4BGb6Hg2XcEKx+0ubXYuCwaa8eIm33wGez9mERw6f+cR
	qo25ki1lliNH/2gmaaEl1Lz2nG09oEZCU1+1CVUVX+EymhEJmEnF+akdZdeAai9U3M08+X+1uo3Yl
	5hR7Fpvfb3NH7MZ+Z61djHheRXx1/6SdjRY5oCACeD9cby9b4LzL5MrDEVn0kqv9lQbiVCNPEvOoo
	gDyGmb6HVzJkKWuY9TYbILyj76vZWQGz18FbVmzJjE3rCu57KSMy/rOFL7QrARNwhEVSuyTUElUfT
	T0mB6iew==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rrVUo-003w0T-1B;
	Tue, 02 Apr 2024 04:11:38 +0000
Date: Tue, 2 Apr 2024 05:11:38 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Palmer Dabbelt <palmer@rivosinc.com>, Arnd Bergmann <arnd@arndb.de>,
	Marco Elver <elver@google.com>
Subject: Re: [PATCH RFC cmpxchg 2/8] sparc: Emulate one-byte and two-byte
 cmpxchg
Message-ID: <20240402041138.GF538574@ZenIV>
References: <31c82dcc-e203-48a9-aadd-f2fcd57d94c1@paulmck-laptop>
 <20240401213950.3910531-2-paulmck@kernel.org>
 <20240401223803.GZ538574@ZenIV>
 <114dc62e-e0fb-41c8-bf9c-a9fda8b19eb6@paulmck-laptop>
 <20240402000758.GC538574@ZenIV>
 <20240402033753.GE538574@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402033753.GE538574@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Apr 02, 2024 at 04:37:53AM +0100, Al Viro wrote:
> On Tue, Apr 02, 2024 at 01:07:58AM +0100, Al Viro wrote:
> 
> > It does, IIRC.
> > 
> > > Would you like to do that patch?  If so, I would be happy to drop mine
> > > in favor of yours.  If not, could I please have your Signed-off-by so
> > > I can do the Co-developed-by dance?
> > 
> > Will do once I dig my way from under the pile of mail (sick for a week
> > and subscribed to l-k, among other lists)...
> 
> FWIW, parisc is in the same situation - atomics-by-cached-spinlocks.
> 've a candidate branch, will post if it survives build...

Seems to survive.  See
git://git.kernel.org:/pub/scm/linux/kernel/git/viro/vfs.git misc.cmpxchg

Completely untested; builds on several configs, but that's it.
Al Viro (8):
      sparc32: make __cmpxchg_u32() return u32
      sparc32: make the first argument of __cmpxchg_u64() volatile u64 *
      sparc32: unify __cmpxchg_u{32,64}
      sparc32: add __cmpxchg_u{8,16}() and teach __cmpxchg() to handle those sizes
      parisc: __cmpxchg_u32(): lift conversion into the callers
      parisc: unify implementations of __cmpxchg_u{8,32,64}
      parisc: add missing export of __cmpxchg_u8()
      parisc: add u16 support to cmpxchg()

 arch/parisc/include/asm/cmpxchg.h   | 16 ++++++------
 arch/parisc/kernel/parisc_ksyms.c   |  2 ++
 arch/parisc/lib/bitops.c            | 52 ++++++++++++-------------------------
 arch/sparc/include/asm/cmpxchg_32.h | 11 +++++---
 arch/sparc/lib/atomic32.c           | 45 ++++++++++++++------------------
 5 files changed, 55 insertions(+), 71 deletions(-)

Individual patches in followups.

