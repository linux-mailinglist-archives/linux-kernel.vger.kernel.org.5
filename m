Return-Path: <linux-kernel+bounces-60863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C609A850A4C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 17:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82E88284049
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB725C5F5;
	Sun, 11 Feb 2024 16:27:15 +0000 (UTC)
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [104.156.224.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9338465
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 16:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.156.224.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707668835; cv=none; b=VZWo0aA890Xqf8/SDG3pKoK9UWzwlBwW7g2PhL7WSTg32a41gvhh/xfrYWa8jTUXSMIeqc2YeKunWMha8UPst/GHfUPEI2TtrnNN0uRd+bMCvS9J1LVHH6JIOifIaMdDPBdX/y+lQQgcNo0sYN+baWniX6n5adnrBz//1eTOjns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707668835; c=relaxed/simple;
	bh=kYUPUttvJ/ugFgsbqtppfxlQu6IMhI9CjpX3VGnGZSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STbyOw4gAwbvJhAC/L4WXyVNqlcpPN+pku1BEc54FyFNaIkwo5NOt1uFNL469dJszgF91c54+kodcMr/vKwq1dc5DkcH4EOzlzA5AYJpLhOXLnp/Yab/G1ZKf2XCbPHxBkR8Pn06m5DIOl0x8uNA8KBcLKmUOkz1aW+ec5AyJ28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org; spf=pass smtp.mailfrom=aerifal.cx; arc=none smtp.client-ip=104.156.224.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aerifal.cx
Date: Sun, 11 Feb 2024 11:12:13 -0500
From: Rich Felker <dalias@libc.org>
To: "D. Jeff Dionne" <djeffdionne@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Problems with csum_partial with misaligned buffers on sh4
 platform
Message-ID: <20240211161212.GL22081@brightrain.aerifal.cx>
References: <0a0fbbd8-17dd-4f4c-9513-f3ac9749890b@roeck-us.net>
 <8C704EE6-7B5E-4569-B9C3-84B2CBADA102@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8C704EE6-7B5E-4569-B9C3-84B2CBADA102@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Sun, Feb 11, 2024 at 12:41:16PM +0900, D. Jeff Dionne wrote:
> I remember there being problems with alignment on SH targets in the
> network stack. IIRC, wireguard triggered it in actual use, seems to
> me it had to do with skb alignment.
> 
> Rich Felker may remember more, but I don’t think we implemented a
> (complete) solution.

What I recall was that some of the tunneling encapsulation code
ultimately did its zerocopy by arranging for either the inner or outer
headers to be misaligned (due to the historical badness of ethernet),
and thereby blowing up on archs without misaligned access support
(ours read/wrote bogus data, probably ignoring the low address bits or
something, on misaligned addresses). We never solved it; the code that
later worked was doing the encapsulatio in userspace without the
kernel's misaligned zerocopy stuff.

The right solution would be to make the affected accesses happen
through custom int16/int32 types with attribute packed applied to
them, so that on archs with misaligned access, the code would not
change at all, but on archs without it, the codegen would do
everything byte-by-byte and reassemble. But this would probably be an
invasive change that would make the maintainers of the network stack
unhappy...

Rich

