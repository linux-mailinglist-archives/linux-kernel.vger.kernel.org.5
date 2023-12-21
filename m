Return-Path: <linux-kernel+bounces-8695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F4781BB30
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 055DB1C209D5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8875FEE2;
	Thu, 21 Dec 2023 15:42:51 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BDD55E5F;
	Thu, 21 Dec 2023 15:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rGLC9-0002qk-00; Thu, 21 Dec 2023 16:42:45 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id E556EC028A; Thu, 21 Dec 2023 16:42:30 +0100 (CET)
Date: Thu, 21 Dec 2023 16:42:30 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
	gregory.clement@bootlin.com, vladimir.kondratiev@intel.com
Subject: Re: [PATCH v2 02/10] MIPS: spaces: Define a couple of handy macros
Message-ID: <ZYRc5guD3PSldr24@alpha.franken.de>
References: <20231027221106.405666-1-jiaxun.yang@flygoat.com>
 <20231027221106.405666-3-jiaxun.yang@flygoat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027221106.405666-3-jiaxun.yang@flygoat.com>

On Fri, Oct 27, 2023 at 11:10:58PM +0100, Jiaxun Yang wrote:
> KSEGX_SIZE is defined to size of each KSEG segment.
> 
> TO_CAC and TO_UNCAC are brought to 32bit builds as well,
> TO_PHYS remains to be 64bit only as we want people to
> use __pa to avoid mixup compat address space.

the problem here is, that in the 64bit case the macros work on every address
while in 32bit only the first 512MB address space is covered. So there
is a reason to not expose TO_CAC/TO_UNCAC for 32bit.

Which leaves the problem how to handle all the CKSEG[01]ADDR()
cases nicer for 64bit... I'd prefer an extra macro/inline function
which handles 32bit and 64bit accordingly. Not sure about the name
for it, but maybe something like

CKSEG[01]ADDR_OR_64BIT()

That would at least make clear (to me) this thing is special and might
return a XPHYS uncached address.

Thomas. 

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

