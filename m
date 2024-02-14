Return-Path: <linux-kernel+bounces-65435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A4A854CF5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6003F28A032
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589725FDCE;
	Wed, 14 Feb 2024 15:34:54 +0000 (UTC)
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [49.12.208.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9095FDAC
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.208.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924893; cv=none; b=rOSI6Fz1wuZbxt/0ad4QlsmRKproZCrNoirQim+/3A4Cn4eENqEHteUdYahJDMlRs5kL2w7Yla2qIlUVjD9JIk9PRVHB7vzPCk1rXQ+itinGLzxdIxvqd7SYShsikqcVeiLixEc1G1IiqASk0R3Rh1Kawbo97GLZIJZuisRCaHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924893; c=relaxed/simple;
	bh=BQig4Yk8JQ/ubx3GIyx8RwWB99QJzp3uKdwSxLp9NQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MuSfKTCJ83/0fUk/R3cYBNCVTGa7meUMmTy0jG/1t9Zm41z2PLe1ZK0BLfzDnr9VKHJr8akwVIz1CShw4pR+NxSiXip/AwqnKj2G/Hsme5ZHYYufSjxuLiYQmnA+S0w040COqeBVT0OEoLmpHleQaS8ea5fhCwnxvYnDMkC4Xso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar; spf=pass smtp.mailfrom=sdfg.com.ar; arc=none smtp.client-ip=49.12.208.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdfg.com.ar
Received: from [192.168.0.26]
	by sdfg.com.ar (chasquid) with ESMTPSA
	tls TLS_AES_128_GCM_SHA256
	(over submission+TLS, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
	; Wed, 14 Feb 2024 15:34:48 +0000
Message-ID: <10b97cd3-5690-40b2-aa8e-3fea5dd4275f@sdfg.com.ar>
Date: Wed, 14 Feb 2024 12:34:46 -0300
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
From: Rodrigo Campos <rodrigo@sdfg.com.ar>
In-Reply-To: <20240211104817.GA19364@1wt.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/11/24 11:48, Willy Tarreau wrote:
> On Mon, Jan 29, 2024 at 03:15:14PM +0100, Rodrigo Campos wrote:
> The test inside the loop is going to make this not very efficient. Same
> for the fact that we're measuring the length of src twice (once via
> strlen, a second time through the loop). I've just had a look and it
> compiles to 77 bytes at -Os. A simpler variant would consist in trying

The sizes here don't match that, even using gcc 9.5.0 from debian sid 
(your example in the other email was calling gcc 9.5).

Here I see bigger sizes, even using the same line you share to compile.

> For me it's 58 bytes, or 19 less / 25% smaller, and at first glance it
> should do the right thing as well.

I see 69 bytes for that func (nm --size says 45, that is in hex).
The function I posted in the patchset I see it as 101 bytes, so that is 
here is 32 bytes less here.

Here are two versions that are significantly shorter than the 101 bytes, 
that pass the tests (I added more to account for the src vs dst mismatch 
that was easy to pass tests when both buffers have the same size as they 
did before).

size_t strlcat_rata(char *dst, const char *src, size_t size)
{
         const char *orig_src = src;
         size_t len = 0;
         for (;len < size; len++) {
                 if (dst[len] == '\0')
                         break;
         }

         /* Let's copy len < n < size-1 times from src.
          * size is unsigned, so instead of size-1, that can wrap around,
          * let's use len + 1 */
         while (len + 1 < size) {
                 dst[len] = *src;
                 if (*src == '\0')
                         break;
                 len++;
                 src++;
         }

         if (src != orig_src)
                 dst[len] = '\0';

         while (*src++)
                 len++;

         return len;
}

This one compiles to 81 bytes here using gcc 13.2.0 and to 83 using gcc 
9.5.0. Compared to the one posted in the patchset, it is significantly 
smaller.


One based in the version you posted (uses strlen(dst) instead), is this one:

size_t strlcat_willy_fixed(char *dst, const char *src, size_t size)
{
         const char *orig_src = src;
         size_t len = strlen(dst);
         if (size < len)
                 len = size;

         for (;len + 1 < size; len++, src++) {
                 dst[len] = *src;
                 if (*src == '\0')
                         break;
         }

         if (orig_src != src)
                 dst[len] = '\0';

         while (*src++)
                 len++;

         return len;
}


Note the "if size < len, then len=size", I couldn't get rid of it 
because we need to account for the smaller size of dst if we don't get 
passed it for the return code.

This one is 90 bytes here.


What do you think? Can you make them shorter?

If you like one of these, I can repost with the improved tests too.

