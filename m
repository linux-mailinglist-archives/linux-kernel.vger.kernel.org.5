Return-Path: <linux-kernel+bounces-127344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B17894A19
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 05:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01243B22BF9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 03:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BBD171A7;
	Tue,  2 Apr 2024 03:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ongtbNaL"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF9E10A12
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 03:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712029082; cv=none; b=RNbgMRAbRMqkVAv2nkptdj3XcqnETpd1WkTUc2mePqLsxv6fsUFMNcdU5pmGe2cDFuMOg5ZdAcCovbQW5vQZwydPnEdJsmDOLLh1Gg//AWIOx9Nz5jgWKElyHxrAlF0CVY2ZmcmXScqTjyQTOBOXzSr46IHp0D2YVi46l56tj/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712029082; c=relaxed/simple;
	bh=PTihjnNnRWYt63v0jYx99i599QWIaG1uupG+LTrXiDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZCDeq7PPjjo7e8XEuMQrsSk9hjAqufKJsJeMnqyvKl91yi6KNloI5pXaMUqtthXlH4sd4BANui/MCsCoxftwf6koxAE/YMAP/gSI3JNlbWGty31OJpX+8cD8MW8j1GCJpFHStuHQJpRvpDZl+k021WMiyRO5KXp2WhV/+pJ/UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ongtbNaL; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Gin1thki7fsUyaGKZnFO5YM0/jNaVAAsjAM+SK/6YRQ=; b=ongtbNaLQ+2oRhCBdyPFzHpHH7
	2mGtgydEOiqz6YuwLR5OkLpc3IqRGTEyiB8XUA6vkOh8Msjz09KIvmni0kTYhmTuOArCZi0dviV/i
	LsvSEQTOCP1srbGjHVTVal2NF5Myl0a3vDOLxnaMwI7F0/4YsEmdFgAO45Q3weHoYbXZKZl+v951u
	5bDK1jEszZTWJjEYfbJnPy2B3aU+jIYlqxP7X6bZvY0y0M8vavrmtY2ahCFKds1AyoBUG7Fggx/MA
	5SS/zEME/dL4A7935Beej2NWLBVkUmlMr2Lh5A7IVJC37H60zxaOVMPAZWOSyA6y+gngWYcLEQZp4
	7Y8/ubow==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rrUy9-003v3l-2A;
	Tue, 02 Apr 2024 03:37:53 +0000
Date: Tue, 2 Apr 2024 04:37:53 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Palmer Dabbelt <palmer@rivosinc.com>, Arnd Bergmann <arnd@arndb.de>,
	Marco Elver <elver@google.com>
Subject: Re: [PATCH RFC cmpxchg 2/8] sparc: Emulate one-byte and two-byte
 cmpxchg
Message-ID: <20240402033753.GE538574@ZenIV>
References: <31c82dcc-e203-48a9-aadd-f2fcd57d94c1@paulmck-laptop>
 <20240401213950.3910531-2-paulmck@kernel.org>
 <20240401223803.GZ538574@ZenIV>
 <114dc62e-e0fb-41c8-bf9c-a9fda8b19eb6@paulmck-laptop>
 <20240402000758.GC538574@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402000758.GC538574@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Apr 02, 2024 at 01:07:58AM +0100, Al Viro wrote:

> It does, IIRC.
> 
> > Would you like to do that patch?  If so, I would be happy to drop mine
> > in favor of yours.  If not, could I please have your Signed-off-by so
> > I can do the Co-developed-by dance?
> 
> Will do once I dig my way from under the pile of mail (sick for a week
> and subscribed to l-k, among other lists)...

FWIW, parisc is in the same situation - atomics-by-cached-spinlocks.
've a candidate branch, will post if it survives build...

Re parisc: why does it bother with arch_cmpxchg_local()?  Default is
	* save and disable local interrupts
	* read the current value, compare to old
	* if equal, store new there
	* restore local interrupts
For 32bit case parisc goes for __cmpxchg_u32(), which is
	* if (SMP) choose the spinlock (indexed by hash of address)
	* save and disable local interrupes
	* if (SMP) arch_spin_lock(spinlock)
	* read the current value, compare to old
	* if equal, store new there
	* if (SMP) arch_spin_unlock(spinlock)
	* restore local interrupts
In UP case it's identical to generic; on SMP it's strictly more work.
Unless I'm very confused about cmpxchg_local() semantics, the
callers do not expect atomicity wrt other CPUs, so why do we bother?

