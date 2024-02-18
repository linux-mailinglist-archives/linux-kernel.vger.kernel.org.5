Return-Path: <linux-kernel+bounces-70551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D539859915
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D63B01F21B20
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD6271B2E;
	Sun, 18 Feb 2024 19:34:14 +0000 (UTC)
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [49.12.208.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C6F1E86F
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 19:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.208.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708284854; cv=none; b=nDwYsrXjBy4hZghpCPXyMGMpq5aw3HWRgc44216oBQBOwg2z5K+1BBAq9dOwL23DZhx4zM+2AnpIP2XhTAUsMKoP2w3SWQdvkOg1dLaaEJMIQNcuItjRvZG70MruLAo+qwXH6xOHmrm7EndenZ6C/77Vqd+uzDTfmCw6/ExlB4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708284854; c=relaxed/simple;
	bh=Yj9qMMPZ19LtDe2elg6koYFa60SHjf7b/xK1dI0ZI5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rXWaT5C6KqczdT2hoGZhiEU+vGgMcqaY/41Akf8A81JTUujCLnuBZIw01etx0yuuk5e12bmHb8+wn2o7eYL6Qi8eLgd4OEeGURUP3fPsTK763yB7Eu+wIEgqE4fBqu5P/oCZjqOuZ5lz+ClGpUPO1CceQ4Iciln1RjC+8nJQdSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar; spf=pass smtp.mailfrom=sdfg.com.ar; arc=none smtp.client-ip=49.12.208.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdfg.com.ar
Received: from [192.168.0.26]
	by sdfg.com.ar (chasquid) with ESMTPSA
	tls TLS_AES_128_GCM_SHA256
	(over submission+TLS, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
	; Sun, 18 Feb 2024 19:34:01 +0000
Message-ID: <428e1561-3219-4567-90df-7130013f3468@sdfg.com.ar>
Date: Sun, 18 Feb 2024 16:33:59 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] tools/nolibc: Fix strlcat() return code and size
 usage
Content-Language: en-US
To: Willy Tarreau <w@1wt.eu>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 linux-kernel@vger.kernel.org
References: <20240129141516.198636-1-rodrigo@sdfg.com.ar>
 <20240129141516.198636-3-rodrigo@sdfg.com.ar> <20240211104817.GA19364@1wt.eu>
 <10b97cd3-5690-40b2-aa8e-3fea5dd4275f@sdfg.com.ar>
 <20240218102003.GA32375@1wt.eu>
From: Rodrigo Campos <rodrigo@sdfg.com.ar>
In-Reply-To: <20240218102003.GA32375@1wt.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/18/24 07:20, Willy Tarreau wrote:
> Hi Rodrigo,
> 
> 
> OK this looks good to me.

I'll use that version in the next send then, thanks!

> I think your test on src != orig_src is not
> trivial and that testing instead if (len < size) would be better, and
> possibly even shorter.

Fixed that, thanks.

>> Note the "if size < len, then len=size", I couldn't get rid of it because we
>> need to account for the smaller size of dst if we don't get passed it for
>> the return code.
> 
> Please no, again as I mentioned earlier, it's wrong to use strlen(dst) in
> this case: the only situation where we'd accept size < len is if dst is
> already not zero-terminated, which means that strlen() cannot be used, or
> you'd need strnlen() for that, I'm just seeing that we have it, I thought
> we didn't.

Right, sorry.

>> What do you think? Can you make them shorter?
> 
> I don't want to enter that activity again this week-end ;-)  It's sufficient
> here.

haha, fair :)

>> If you like one of these, I can repost with the improved tests too.
> 
> Yeah please check the few points above for your version, make sure to
> clean it up according to the kernel's coding style (empty line after
> variable declaration, */ on the next line for the multi-line comment
> etc) and that's fine.

Will do



Best,
Rodrigo

