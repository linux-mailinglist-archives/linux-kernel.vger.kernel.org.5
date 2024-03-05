Return-Path: <linux-kernel+bounces-91460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D0F8711CF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C13801F23729
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E574C96;
	Tue,  5 Mar 2024 00:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="L5LihVMM"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999747F;
	Tue,  5 Mar 2024 00:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709599163; cv=none; b=Tq5/774pxHqIHltsOFXrFNAuxZgWU0ipT++8TmWAJKk0ziFOHM0gpOMg28PixAqVfI9UksDm8GnOfgsaIM3cGJw31KnYSDsmFO+XRHeHd8p8KUh9TEL0nckhzRhzZehhffjwIQXodGx3xqIlknppn7IESlZ0se6V7iSABZb7ea4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709599163; c=relaxed/simple;
	bh=O0yyXFEBHAkyNtI5CjiaTsfcPSXS8959gJlNgVluFYY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kN9d/qnzuiWwOqUQuLNMHxuh8FcqkLnycCnPrMx14n2RqmYVhtuxucwFLbm0v340mbl17JVVAVew+5/wLKZlDLfuuMSxIU06JcAjrPUo2kgxp6nAhclRZ9ArbZyB1r0eQN+/3GNFvPv13bJCq+bmL/d8+LVZxwaEqKC0UWVYlYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=L5LihVMM; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1709599159;
	bh=O0yyXFEBHAkyNtI5CjiaTsfcPSXS8959gJlNgVluFYY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=L5LihVMMitiNLxNXu2uwdvAv5G9pLC5oUdBu+pvYJDZ313YT8SyKPN20bPRxW4GVj
	 /utTJNIIqFYG2T9xXeKGzbECdqAlQXpV2INu3W3M9K2sEDjHtJCC1xTQxcw4aDTaUn
	 LeLem1wU+SnumutF4cSN6xEfhO8L2iISNF0BZGTmWmYublljLePl9zrN0qM0U1nZQY
	 3zjHR+/kCU+tdM61C06/119pJz9yBVmYSF9NBTYGjOuNdoKnV/LeRDgn1n1Zd5ym6S
	 p4UmssY0/676QfbmJFkFp9KgmxO9w5mXW8AsUMO1oGPCthyKjrjzBikVQdMtXrFtK4
	 E/5H0SV/AJJQw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TpcBt73J0z4wcv;
	Tue,  5 Mar 2024 11:39:18 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jani Nikula <jani.nikula@intel.com>, linuxppc-dev@lists.ozlabs.org
Cc: dri-devel@lists.freedesktop.org, lkft-triage@lists.linaro.org,
 linux-kernel@vger.kernel.org, Naresh
 Kamboju <naresh.kamboju@linaro.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, Helge Deller <deller@gmx.de>,
 linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] powerpc: include linux/backlight.h from asm/backlight.h
In-Reply-To: <87bk7u5n9h.fsf@intel.com>
References: <CA+G9fYsAk5TbqqxFC2W4oHLGA0CbTHMxbeq8QayFXTU75YiueA@mail.gmail.com>
 <20240304095512.742348-1-jani.nikula@intel.com> <87bk7u5n9h.fsf@intel.com>
Date: Tue, 05 Mar 2024 11:39:18 +1100
Message-ID: <87cys9pl55.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jani Nikula <jani.nikula@intel.com> writes:
> On Mon, 04 Mar 2024, Jani Nikula <jani.nikula@intel.com> wrote:
>> Removal of the backlight include from fb.h uncovered an implicit
>> dependency in powerpc asm/backlight.h. Add the explicit include.
>>
>> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
>> Closes: https://lore.kernel.org/r/CA+G9fYsAk5TbqqxFC2W4oHLGA0CbTHMxbeq8QayFXTU75YiueA@mail.gmail.com
>> Fixes: 11b4eedfc87d ("fbdev: Do not include <linux/backlight.h> in header")
>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>> Cc: Helge Deller <deller@gmx.de>
>> Cc: linux-fbdev@vger.kernel.org
>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>>
>> ---
>>
>> Not even compile tested!
>
> Naresh, please try this patch!
>
> Michael, if this is fine by you, ack to merge via the drm subsystem
> along with the regressing commit?

I prefer Thomas' patch, but I'm fine with either to go in via drm.

cheers

