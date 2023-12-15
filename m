Return-Path: <linux-kernel+bounces-1294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F02A814D06
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B7B41C23AB5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD793D393;
	Fri, 15 Dec 2023 16:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="TnXbcwOI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BB43DB81;
	Fri, 15 Dec 2023 16:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id F124346A;
	Fri, 15 Dec 2023 16:28:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net F124346A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1702657737; bh=CgAKQtM1ov3AkxMJyAU3ESVKdSBQLRwSeuZfB5322bY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TnXbcwOI46VA2bH9AFFM/xw40kwnNlHyql7QzN2kp2pGlr+589CRxYrp7KidE7aOv
	 ByJtesSe2WmXyt83TiuFtca3ve0maZQikXiFl9ba85Xj06AtGgpc1VGi89QRabNmiW
	 Cb8HjWTXOjvej70WL78EZo5z5KDwkatBvfiAVuE7IFE0SMRxqvIwETraOL+OuQ8o5C
	 lWpmNLVq2bf4IQ9OsTQf/X0yheK4XxmJQoKJ2GOD5qywjRyzUnmHiGVXl2tUp/8tDj
	 B/+yFSHi+UWHr6NeD6TVAJSSEcInr+8YYCOdqfc15oI6H4by+XlMXI50Qdvvbm4dPb
	 XMy9wjAJ4JfkA==
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Mauro Carvalho Chehab
 <mchehab@s-opensource.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] scripts/kernel-doc: restore warning for Excess
 struct/union
In-Reply-To: <20231214070200.24405-1-rdunlap@infradead.org>
References: <20231214070200.24405-1-rdunlap@infradead.org>
Date: Fri, 15 Dec 2023 09:28:56 -0700
Message-ID: <875y0zqvjr.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

> The warning for Excess struct or union member description was
> removed when the $nested parameter of check_sections() was removed.
> This causes some kernel-doc notation warnings to be missed.
>
> Recently the kernel test robot somehow reported an Excess member. The
> code in kernel-doc has not issued that warning since kernel v4.16, so I
> don't know how the robot did it. (See the Link for the report.)
>
>   drivers/net/wireless/intel/iwlwifi/fw/dbg.c:86: warning: Excess struct/union/enum/typedef member 'trans_len' description in 'iwl_fw_dump_ptrs'
>
> I patched that warning away even though I could not reproduce the
> warning from kernel-doc. The warning should be issued for extraneous
> struct member or union member description, so restore it.
>
> Fixes: 1081de2d2f91 ("scripts: kernel-doc: get rid of $nested parameter")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Link: https://lore.kernel.org/all/202312060810.QT9zourt-lkp@intel.com/
> Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  scripts/kernel-doc |    7 +++++++
>  1 file changed, 7 insertions(+)

*sigh*

This adds nearly 600 new warnings.  Anybody gonna help fix them?

Of course, most of them are duplicates.  Someday it would be really nice
if we could find a way to only emit each warning once.

Anyway, I've applied it.

Thanks,

jon

