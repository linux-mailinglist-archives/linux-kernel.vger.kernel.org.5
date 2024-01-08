Return-Path: <linux-kernel+bounces-20172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8374827B55
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 00:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84B46B22AE0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 23:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A695476B;
	Mon,  8 Jan 2024 23:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJ8foQrT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA5EB672
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 23:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E403C433C7;
	Mon,  8 Jan 2024 23:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704755724;
	bh=7KlcJVD8ZYiOIvP/KELAQLAx/l7D+V5cUHRCxDMgkEY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ZJ8foQrTyKniQDnjPPX687cBiNwV5nw4ShB8Muq+4lXuESkucboH5Vku4ScB+8cBy
	 0MdQgDmKl6s/jmTBscx0oGEpwgJrZkC4II30SMotD52XMKx1wLFOMsteVm6ZYxwpXJ
	 TARpO+7tmxHAQSgTg6uTiGx+XoUO3HItG4GfNusKRwyDCKp9naNZIiPR9arAR9ChcJ
	 jc5AWwEXiwhyaKfj1WVjCeSpB7F6N4RrHodJoQUVGz/y+9QK9oTwKkn3EdUbUvMZA+
	 A2cZVFcawaROBhQYKMrnwu4AkePCUb2gRcZQ8ruRHGNNvURJU9hqekMAa1KUnJGN2v
	 3SsKrVZV57IJQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B2278CE0C54; Mon,  8 Jan 2024 15:15:23 -0800 (PST)
Date: Mon, 8 Jan 2024 15:15:23 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: lucas.dimarchi@intel.com, ogabbay@kernel.org,
	thomas.hellstrom@linux.intel.com, linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org
Subject: Re: [BUG] allmodconfig build error in next-20240108
Message-ID: <341a4955-0cdd-48d0-bfbd-cc6f6f09df37@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <45ad1d0f-a10f-483e-848a-76a30252edbe@paulmck-laptop>
 <20240109095757.1313b2d9@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240109095757.1313b2d9@canb.auug.org.au>

On Tue, Jan 09, 2024 at 09:57:57AM +1100, Stephen Rothwell wrote:
> Hi Paul,
> 
> On Mon, 8 Jan 2024 13:33:36 -0800 "Paul E. McKenney" <paulmck@kernel.org> wrote:
> >
> > Recent -next trees get the following build error for allmodconfig builds:
> > 
> > ------------------------------------------------------------------------
> > 
> > drivers/gpu/drm/xe/xe_gt_pagefault.c: In function ‘xe_guc_pagefault_handler’:
> > ./include/linux/fortify-string.h:57:33: error: writing 16 bytes into a region of  size 0 [-Werror=stringop-overflow=]
> >    57 | #define __underlying_memcpy     __builtin_memcpy
> >       |                                 ^
> > ./include/linux/fortify-string.h:644:9: note: in expansion of macro ‘__underlying_memcpy’
> >   644 |         __underlying_##op(p, q, __fortify_size); \
> >       |         ^~~~~~~~~~~~~
> > ./include/linux/fortify-string.h:689:26: note: in expansion of macro ‘__fortify_memcpy_chk’
> >   689 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s, \
> >       |                          ^~~~~~~~~~~~~~~~~~~~
> > drivers/gpu/drm/xe/xe_gt_pagefault.c:340:17: note: in expansion of macro ‘memcpy’
> >   340 |                 memcpy(pf_queue->data + pf_queue->tail, msg, len * sizeof(u32));
> >       |                 ^~~~~~
> > In file included from drivers/gpu/drm/xe/xe_device_types.h:17,
> >                  from drivers/gpu/drm/xe/xe_vm_types.h:16,
> >                  from drivers/gpu/drm/xe/xe_bo.h:13,
> >                  from drivers/gpu/drm/xe/xe_gt_pagefault.c:16:
> > drivers/gpu/drm/xe/xe_gt_types.h:102:25: note: at offset [1144, 265324] into destination object ‘tile’ of size 8
> >   102 |         struct xe_tile *tile;
> >       |
> 
> Which architecture?  What compiler and version?  Anything special in your build
> setup?  I do x86_64 allmodconfig builds all day with gcc v13.2 and I don't see
> this failure.

Good point!

I am using gcc version 11.3.1 20230605 (Red Hat 11.4.1-2) on x86_64.
I see the same behavior on gcc version 8.5.0, which for all I know might
be too old.

							Thanx, Paul

