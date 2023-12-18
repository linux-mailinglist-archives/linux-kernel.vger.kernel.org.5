Return-Path: <linux-kernel+bounces-3417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEDE816BFD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6F471C22E5B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E21F18EC8;
	Mon, 18 Dec 2023 11:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Bn6y3orl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C1018E2D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 11:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1702897878;
	bh=NS546S3nezX5KtA5ZEsUrJc395ipkqDNIJ9bo/coqqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bn6y3orlkbd/O25jrNW9H44843d7dKx4t69o2OtzyLgcriGf7rHlD0q6pTKh3OUSt
	 GRApF+O6ZHgcGUEsh/poarjLOE5syiySpsEIRx4zb06QmN4Frxz76uYMSsGLbOYLUA
	 hqs3ecYaUB7zPwhuuTZ293E2fD0kZ8d1C4uOOtOY=
Date: Mon, 18 Dec 2023 12:11:17 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>
Subject: Re: include/linux/compiler_types.h:397:45: error: call to
 '__compiletime_assert_810' declared with attribute error: BUILD_BUG_ON
 failed: skb_ext_total_length() > 255
Message-ID: <bfe530f9-d3d4-4cdf-b92b-2fab95f44522@t-8ch.de>
References: <202312171924.4FozI5FG-lkp@intel.com>
 <3fb66648-5581-4371-b15e-23e52e6469ba@t-8ch.de>
 <b091f9d3-14e9-4f2c-bf98-9a207cef412a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b091f9d3-14e9-4f2c-bf98-9a207cef412a@app.fastmail.com>

On 2023-12-18 10:12:03+0000, Arnd Bergmann wrote:
> On Sun, Dec 17, 2023, at 17:13, Thomas Weißschuh wrote:
> > +Cc Arnd who was taking care of CFLAGS_GCOV in the past.
> >
> > On 2023-12-17 19:39:34+0800, kernel test robot wrote:
> >> | Closes: https://lore.kernel.org/oe-kbuild-all/202312171924.4FozI5FG-lkp@intel.com/
> >> 
> >> All errors (new ones prefixed by >>):
> >> 
> >>    In file included from <command-line>:
> >>    In function 'skb_extensions_init',
> >>        inlined from 'skb_init' at net/core/skbuff.c:4848:2:
> >> >> include/linux/compiler_types.h:397:45: error: call to '__compiletime_assert_810' declared with attribute error: BUILD_BUG_ON failed: skb_ext_total_length() > 255
> 
> I tried to count the actual number of bytes and got to a worst case of 200
> bytes (for 64-bit machines), but this may have been wrong. I can think of two
> possible things that may have caused the problem:
> 
> a) there is an actual overflow but gcc fails to realize it without GCOV
> b) the compile-time calculation goes wrong and is no longer a constant
>    value, so the assertion fails to evaluate
> 
> We can probably elinminate a) if you can show that raising the limit does
> not avoid the problem.

I raised the limit and the issue persists.

Also I replaced all entries in the array with a constant "0" and the
issue also persists.
So it can't be a).

Funnily when I keep the explicit array initializers and set all values
to "0" then the tripping point is from 4 to 5 array elements, the same
as with the current code.

With a plain array initialization the tripping point is from 2 to 3
elements.

> > [..]
> >
> > This seems to be a compiler bug/configuration issue.
> >
> > When I remove the entry for SKB_EXT_MCTP from skb_ext_type_len then the
> > error goes away. However this entry works the same as all other entries.
> >
> > Also dropping -fno-tree-loop-im *or* -fprofile-arcs from CFLAGS_GCOV
> > makes the code compile as-is.
> >
> > Or switching to a 64bit build...
> 
> The -fno-tree-loop-im option would likely stop the loop from getting
> unrolled, which is how the skb_ext_total_length() return code is no
> longer constant.
> 
> Does manually unrolling this loop avoid the problem?

That also works.

The offending commit was a change from a manually unrolled loop to the
current code.
This code is a few months old but somehow the issue was only found now.

