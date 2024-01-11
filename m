Return-Path: <linux-kernel+bounces-23569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C29F982AE80
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75EE81F25B35
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36438156F4;
	Thu, 11 Jan 2024 12:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NjUKSC9Y"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2434C15AC4;
	Thu, 11 Jan 2024 12:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704975144;
	bh=TB5P8KrCbMGbGJbuacdDLOIpRYEMY/WzZcPaRIxL9Io=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NjUKSC9YpMGUIeFDwmk/rtOZbUG5chj6AL1sw0IzoKiRdD4/c8ziU8tBNqWKaPbJp
	 VW9GVpaWILaUVn6Sz+5ICS4lWlqeRZuAG5kv/K+QO3Cv7qIuHFcGF1KpUk15yCB7YO
	 db/+UzO5u5cFNf4SxKMIlqwjspz62TTwOBRSI4F2JdFFQfaOqtRFMj3tT3zne06vsL
	 ajnNp42AKGS0Mop0VyYy8OVOvDw3gHNA6yvnHCe331JqE7ahWQiI8+X1vOBSph94Nt
	 KQSWLyEFNEUo4dYW6BtF7Qb9ff1DnNt9GX1rH0IGiKeo+fj+YjSYboT+J0V9Bqi7wv
	 oeKBhuO0O2hOA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 56F393781182;
	Thu, 11 Jan 2024 12:12:23 +0000 (UTC)
Message-ID: <549d8438-cae7-4c81-8f2e-1513a5e2dd5d@collabora.com>
Date: Thu, 11 Jan 2024 13:12:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: unwind: Add missing "Call trace:" line
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, Russell King <linux@armlinux.org.uk>
Cc: Mark Brown <broonie@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>,
 Vladimir Murzin <vladimir.murzin@arm.com>,
 Zhen Lei <thunder.leizhen@huawei.com>, Keith Packard <keithpac@amazon.com>,
 Haibo Li <haibo.li@mediatek.com>, linux-arm-kernel@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Alexandre Mergnat <amergnat@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240110215554.work.460-kees@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240110215554.work.460-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 10/01/24 22:56, Kees Cook ha scritto:
> Every other architecture in Linux includes the line "Call trace:" before
> backtraces. In some cases ARM would print "Backtrace:", but this was
> only via 1 specific call path, and wasn't included in CPU Oops nor things
> like KASAN, UBSAN, etc that called dump_stack(). Regularize this line
> so CI systems and other things (like LKDTM) that depend on parsing
> "Call trace:" out of dmesg will see it for ARM.
> 
> Before this patch:
> 
> 	UBSAN: array-index-out-of-bounds in ../drivers/misc/lkdtm/bugs.c:376:16
> 	index 8 is out of range for type 'char [8]'
> 	CPU: 0 PID: 1402 Comm: cat Not tainted 6.7.0-rc2 #1
> 	Hardware name: Generic DT based system
> 	 dump_backtrace from show_stack+0x20/0x24
> 	 r7:00000042 r6:00000000 r5:60070013 r4:80cf5d7c
> 	 show_stack from dump_stack_lvl+0x88/0x98
> 	 dump_stack_lvl from dump_stack+0x18/0x1c
> 	 r7:00000042 r6:00000008 r5:00000008 r4:80fab118
> 	 dump_stack from ubsan_epilogue+0x10/0x3c
> 	 ubsan_epilogue from __ubsan_handle_out_of_bounds+0x80/0x84
> 	...
> 
> After this patch:
> 
> 	UBSAN: array-index-out-of-bounds in ../drivers/misc/lkdtm/bugs.c:376:16
> 	index 8 is out of range for type 'char [8]'
> 	CPU: 0 PID: 1402 Comm: cat Not tainted 6.7.0-rc2 #1
> 	Hardware name: Generic DT based system
> 	Call trace:
> 	 dump_backtrace from show_stack+0x20/0x24
> 	 r7:00000042 r6:00000000 r5:60070013 r4:80cf5d7c
> 	 show_stack from dump_stack_lvl+0x88/0x98
> 	 dump_stack_lvl from dump_stack+0x18/0x1c
> 	 r7:00000042 r6:00000008 r5:00000008 r4:80fab118
> 	 dump_stack from ubsan_epilogue+0x10/0x3c
> 	 ubsan_epilogue from __ubsan_handle_out_of_bounds+0x80/0x84
> 	...
> 
> Reported-by: Mark Brown <broonie@kernel.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Vladimir Murzin <vladimir.murzin@arm.com>
> Cc: Zhen Lei <thunder.leizhen@huawei.com>
> Cc: Keith Packard <keithpac@amazon.com>
> Cc: Haibo Li <haibo.li@mediatek.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


