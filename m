Return-Path: <linux-kernel+bounces-100368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBD1879661
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B8001F2237A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9307CF04;
	Tue, 12 Mar 2024 14:30:43 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F210C29AB;
	Tue, 12 Mar 2024 14:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710253843; cv=none; b=eoL+H/R2Hm2OC3nPHiNQXq985hLwDm1uaLqweZkJBlS9PXhUjECViVCFrrM0vEFRhMSio1rpSM04LggPOQaWFLQZkMxtwbZ12gv+8L7YvDdkViA7APlgqMbicQlLTuvToj6As0E+Eiq/xad3wu0BFYN22sh1U9q/p0pPNm7O0Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710253843; c=relaxed/simple;
	bh=Nv9DSRH1knEN/7XSZZmWRevE7uROHH/o5/dobsKswvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAfEl9QRtStSJnVyFD5RZ4hvnX05uIedwIO9UJ1wcJCNy//1pCCyn/7sZ5nEQzmcY8vER57B9yHo4Dg0sc9MDL+29D03OlzRh+/SshN44EhzQ7vqgqS0paAvgLW857br+rsvYwxnatGuzWKzpPUqNHN7F59TKzcsvzGqpvVV/9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rk39B-0001Mp-4H; Tue, 12 Mar 2024 15:30:29 +0100
Date: Tue, 12 Mar 2024 15:30:29 +0100
From: Florian Westphal <fw@strlen.de>
To: Eric Dumazet <edumazet@google.com>
Cc: Florian Westphal <fw@strlen.de>, xingwei lee <xrivendell7@gmail.com>,
	pabeni@redhat.com, davem@davemloft.net, kuba@kernel.org,
	linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, ralf@linux-mips.org,
	syzkaller-bugs@googlegroups.com, samsun1006219@gmail.com
Subject: Re: KASAN: slab-use-after-free Read in ip_finish_output
Message-ID: <20240312143029.GE1529@breakpoint.cc>
References: <CABOYnLwtfAxS7WoMw-1_uxVe3EYajXRuzZfwaQEk0+7m6-B+ug@mail.gmail.com>
 <CANn89i+qLwyPLztPt6Mavjimyv0H_UihVVNfJXWLjcwrqOudTw@mail.gmail.com>
 <20240306103632.GC4420@breakpoint.cc>
 <CANn89iLe0KGjbSim5Qxxr6o0AjJVs7-h79UvMMXKOgGKQUosiA@mail.gmail.com>
 <20240312132107.GA1529@breakpoint.cc>
 <CANn89iLkDwnZdBY8CwkrQwCk2o7EAM9J1sv+uxU1tjKb=VB=Ag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iLkDwnZdBY8CwkrQwCk2o7EAM9J1sv+uxU1tjKb=VB=Ag@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Eric Dumazet <edumazet@google.com> wrote:
> Thanks for taking a look Florian.
> 
> Perhaps not messing with truesize at all would help ?

Thanks for the sketch patch, that makes things simpler indeed.
I'll try to build something along these lines.

