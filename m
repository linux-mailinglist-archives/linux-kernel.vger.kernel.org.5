Return-Path: <linux-kernel+bounces-128628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA21895D38
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C5B31F21A7C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F2315CD56;
	Tue,  2 Apr 2024 20:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5ZqBuXN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F2F15AAA1
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 20:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712088147; cv=none; b=RkYuHbent7p9Z6bo2J1ZkiuMaR8bzOAkfInoXYGXhSHza8zmlPI3higoyHOkM2JoF3cnChLSDiH1Rk1TuaW8djPMEYik0uX/oeBQD18YxYAaGdoqah0e28f9kfS0vVT59ZyxvN0145d9lT+P8VvAkyEvB5ug5qYLqGm7r9XvTeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712088147; c=relaxed/simple;
	bh=/SrKFwRHrNxDQO6a2zBh8+17zL5ihRA+vx0wtBRVDCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jANtZgGymXdCLDEU50yOUzSuA6VQqWctXVVc08icsdn+i1ai6K1l5q/fygFz18HL4QjrIcKDK7Nmuwvk+gbmV49D/vEF9b8WipoyQTcPX5pQQlTw2gVF6zCC8FMSUA127oa5q2JbfB1etaCaJD9oMJ9aV8U4ZedcZ9b/Iu9QSpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5ZqBuXN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C287C433C7;
	Tue,  2 Apr 2024 20:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712088146;
	bh=/SrKFwRHrNxDQO6a2zBh8+17zL5ihRA+vx0wtBRVDCM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=n5ZqBuXNeXDQvAQIy8wj0daxR6A1qOp77/7EPpbeV11SSaRN+vw3lTut8Sltcs/rm
	 JlwwjBJKnL+d/rsU6SvVeKVSqj+SGCR3iNiAGpqqF/qQkcWZT4/CdY4xJxylEScBS5
	 e0MXtwvXpN83fnudUsaWTjI9sM/60HZsZGF5HrJICQf7vpeSnPTu/R+4V1W0taU/6I
	 s5z7Ie2cm7DiqKt2lbVpqEYvBM3k3HJBAE48x890RMLCQseAL6CXUbJS3EnaHtZlVi
	 Oowt31G1RBvl0iOaBvhnaVyts9GL7GOxtUU6VXsXKmvSRgjsfLU273HZcm42hNjYTk
	 xkat3lV7rIbZw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2347ECE0FF2; Tue,  2 Apr 2024 13:02:26 -0700 (PDT)
Date: Tue, 2 Apr 2024 13:02:26 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, "David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Marco Elver <elver@google.com>
Subject: Re: [PATCH 3/8] sparc32: unify __cmpxchg_u{32,64}
Message-ID: <b8df1921-1368-4355-a378-0c6cd02cdfc9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240402041138.GF538574@ZenIV>
 <20240402042835.11815-1-viro@zeniv.linux.org.uk>
 <20240402042835.11815-3-viro@zeniv.linux.org.uk>
 <d85654ba-54b5-419a-89e5-526660284769@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d85654ba-54b5-419a-89e5-526660284769@app.fastmail.com>

On Tue, Apr 02, 2024 at 09:28:57AM +0200, Arnd Bergmann wrote:
> On Tue, Apr 2, 2024, at 06:28, Al Viro wrote:
> > Add a macro that expands to one of those when given u32 or u64
> > as an argument - atomic32.c has a lot of similar stuff already.
> >
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> I think we should merge Sam's series to remove non-CAS sparc32
> first:
> 
> https://lore.kernel.org/all/20240309-sunset-v2-0-f09912574d2c@ravnborg.org/
> 
> I don't see a patch yet to actually change cmpxchg() to use CAS,
> but it can probably just share the sparc64 implementation at
> that point.

Fair points!

In the meantime, I pulled in Al's patches for both sparc and parisc.

If I leave out sparc support, I am inducing build failures on sparc in
RCU code.  I do not feel comfortable pulling in Sam's series.

One approach is for me to push in the emulation and uses as they are
accepted, and modify from there.

Another approach would be for me to add KCSAN annotation to RCU's current
open-coded one-byte emulation and let things play out from there.

A third would be for us all to deadlock on each other.

My preference is the first approach.  But what would work better?

							Thanx, Paul

