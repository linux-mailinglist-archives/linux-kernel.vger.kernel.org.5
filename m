Return-Path: <linux-kernel+bounces-4796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FF981822C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AB07B2370F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9340C135;
	Tue, 19 Dec 2023 07:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lib1RGZW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E7411709;
	Tue, 19 Dec 2023 07:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A3EC433C8;
	Tue, 19 Dec 2023 07:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702970524;
	bh=PGqQxcwPatxskOKVrRhkChWNTndldd2FX9IIaUY7CSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lib1RGZWc3IjGfojR+jKNoywDghUkJE2ZCMNgntzGHOuR921PHl4J73LEG10+dxVI
	 SsN8cuyRC6nDxYarRY3PjXILyqT6URvtqsAtIhn9PVZhLr6qF/fu86OfxzbBSlkYHz
	 frVlo5Mh1FXf1tW27WVzV5VrgAT59SkgvT6r/E4Y=
Date: Tue, 19 Dec 2023 08:22:01 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
	stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH 4.19 00/36] 4.19.303-rc1 review
Message-ID: <2023121911-litmus-demanding-bfb5@gregkh>
References: <20231218135041.876499958@linuxfoundation.org>
 <cf94f746-55d7-4f22-bb53-b5c1be843354@linaro.org>
 <f4987195-97ed-4ad3-8bdd-dbf3fb590e79@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4987195-97ed-4ad3-8bdd-dbf3fb590e79@oracle.com>

On Tue, Dec 19, 2023 at 11:23:48AM +0530, Harshit Mogalapalli wrote:
> Hello Greg,
> 
> On 19/12/23 10:57 am, Daniel Díaz wrote:
> > Hello!
> > 
> 
> > 
> > -----8<-----
> >    In file included from /builds/linux/include/linux/list.h:9,
> >                     from /builds/linux/include/linux/module.h:9,
> >                     from /builds/linux/net/core/skbuff.c:41:
> >    /builds/linux/net/core/skbuff.c: In function 'skb_segment':
> >    /builds/linux/include/linux/kernel.h:847:43: warning: comparison of
> > distinct pointer types lacks a cast
> >      847 |                 (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
> >          |                                           ^~
> >    /builds/linux/include/linux/kernel.h:861:18: note: in expansion of
> > macro '__typecheck'
> >      861 |                 (__typecheck(x, y) && __no_side_effects(x, y))
> >          |                  ^~~~~~~~~~~
> >    /builds/linux/include/linux/kernel.h:871:31: note: in expansion of
> > macro '__safe_cmp'
> >      871 |         __builtin_choose_expr(__safe_cmp(x, y), \
> >          |                               ^~~~~~~~~~
> >    /builds/linux/include/linux/kernel.h:880:25: note: in expansion of
> > macro '__careful_cmp'
> >      880 | #define min(x, y)       __careful_cmp(x, y, <)
> >          |                         ^~~~~~~~~~~~~
> >    /builds/linux/net/core/skbuff.c:3630:32: note: in expansion of macro
> > 'min'
> >     3630 |                 partial_segs = min(len, GSO_BY_FRAGS - 1) / mss;
> >          |                                ^~~
> > ----->8-----
> > 
> 
> Note:
> 
> Caused by this commit:
> 98c6fb04f83b net: prevent mss overflow in skb_segment()
> 
> I don't see this commit being queued in other stable branches yet, 5.4.y,
> 5.10.y, 5.15.y, 6.1.y, 6.6.y but only 4.19.y

Odd, Sasha, did something happen with your scripts?  I'll drop this from
4.19.y now, but it looks like it needs to be added to all branches.
Maybe because we don't really notice new build warnings on 4.19.y that
easily (due to so many of them), this got left in :(

thanks,

greg k-h

