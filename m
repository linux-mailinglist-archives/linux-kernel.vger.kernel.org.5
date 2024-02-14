Return-Path: <linux-kernel+bounces-65458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04821854D58
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36F381C288A0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDE55D912;
	Wed, 14 Feb 2024 15:51:01 +0000 (UTC)
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [49.12.208.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645F05C8F9
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 15:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.208.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925860; cv=none; b=jOHUvHCFAqfXmCPTftbX5lLCQRQSREWwG7o0Pd+b+9w6OcRbVBpeuE02G/jGL8PNVEoahEa0f9zKSQUTY+/OMqYUHyp0co+ZCP3zKYAsfjRmEeFuDhNt1NqV/SF/70g+FsnkCvm+fhgeB14Ved5PTVy/qtRQw5EoXAPjgcePQXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925860; c=relaxed/simple;
	bh=o17Yaz26IjWAG2mdbxPC3P4T4qfP+MX8KI/T4rwq+ao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u2TlN0gfVGVY+RYx/rWA+I5QUrh8vFlVCwbAIZrlu3PvEzdUDvPtpUkXyYTGOrB3K10jxx6ogseIszNiPLm1X35DUGD1Zj1wiAhC4qM0yXdROxU6bCMzZGcHikc8oJJfzw67UYOvEFdO5HiaY5X8mRmA/xLuLo248qT+KyS3M2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar; spf=pass smtp.mailfrom=sdfg.com.ar; arc=none smtp.client-ip=49.12.208.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdfg.com.ar
Received: from [192.168.0.26]
	by sdfg.com.ar (chasquid) with ESMTPSA
	tls TLS_AES_128_GCM_SHA256
	(over submission+TLS, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
	; Wed, 14 Feb 2024 15:50:55 +0000
Message-ID: <cc997fd5-1478-43fc-8ba0-aba5e7b3bfdc@sdfg.com.ar>
Date: Wed, 14 Feb 2024 12:50:53 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] tools/nolibc: Fix strlcpy() return code and size
 usage
Content-Language: en-US
To: Willy Tarreau <w@1wt.eu>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 linux-kernel@vger.kernel.org
References: <20240129141516.198636-1-rodrigo@sdfg.com.ar>
 <20240129141516.198636-4-rodrigo@sdfg.com.ar> <20240211110814.GB19364@1wt.eu>
From: Rodrigo Campos <rodrigo@sdfg.com.ar>
In-Reply-To: <20240211110814.GB19364@1wt.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/11/24 12:08, Willy Tarreau wrote:
> Hi Rodrigo,
> 
> It's good, but for the same reason as the previous one, I'm getting
> smaller code by doing less in the loop. Also calling strlen() here
> looks expensive, I'm seeing that the compiler inlined it nevertheless
> and did it in a dep-optimized way due to the asm statement. That
> results in 67 bytes total while a simpler version gives 47.
> 
> If I explicitly mark strlen() __attribute__((noinline)) that prevents
> it from doing so starting with gcc-10, where it correctly places a jump
> from strlcpy() to strlen() and ends up with 50 bytes (vs 44 for the alt
> one). The other one I can propose is directly derived from the other
> strlcat() variant, which first performs the copy and starts to count:
> 
> size_t strlcpy(char *dst, const char *src, size_t size)
> {
>          size_t len;
> 
>          for (len = 0; len < size; len++) {
>                  if (!(dst[len] = src[len]))
>                          return len;
>          }
> 
>          /* end of src not found before size */
>          if (size)
>                  dst[size - 1] = '\0';
> 
>          while (src[len])
>                  len++;
> 
>          return len;
> }
> 
> Just let me know what you think. 

This is one is very nice, thanks!

Sorry I didn't think about the size at all when writing the functions :)

We can change the loop to be:

         for (len = 0; len < size; len++) {
                 dst[len] = src[len];
                 if (!dst[len])
                         break;
         }

That IMHO it is slightly more readable and makes it only 2 bytes longer 
here.

What do you think? I'm fine with both, of course.


If I resend, shall I add a suggested-by or directly you as the author?



Best,
Rodrigo

