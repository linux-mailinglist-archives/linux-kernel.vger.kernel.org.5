Return-Path: <linux-kernel+bounces-58865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D428A84EE05
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 772C7B2630B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E284D53E16;
	Thu,  8 Feb 2024 23:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="iQyDMlQN"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F47537E1;
	Thu,  8 Feb 2024 23:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707434426; cv=none; b=k8q1wCB4B/FORCSSx53GPlap9TZMfNabkMlKHIhbafc6vZer8HvOJJseYtUZH/+MtCHZ0YyWlf8o1UWolHj4r5whiEGcEBXGokqNqfgbXxhuWfMBjI6/8G1L7Gr21cT/cEeUHJKhpTNCEgxO0x72+FECn/iqFoLMVX0xG4DvHCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707434426; c=relaxed/simple;
	bh=QysFqLPnIN2b/3vb29dE3cFM/8GikjHr5HwtIEkvbQQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VA3oz95ZgCEYVCBIcB9lTvFbd/PKJWTmQlQtEzXrIsix0r1YfJ9ICzS7fDUJ5lDKoE1kZvaJLKn4COC267dpapO8MdtqLmAMY4wmwEzk9zhMvuBH/eKi5fINViPr/wuqEx0pgxMvduE4FbWWsGsXh4aEbNBWPoyOUBECF6W+IuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=iQyDMlQN; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B4A3745917
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1707434421; bh=KKvRDbl+tUyU9Ag+tr/Y9YF0CGVJnhyAHR4KFudkBFg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=iQyDMlQNDG+hGCiV+ZYOVrGngsAiVoe4gnxCnnytPedZikIglUgcdoKPWqIXyn9FO
	 HQqOdh659sIrSgVBLkDnslb9qAtNyBadHWIyE33aM7VkZ+u6v8l9BFhXPD8mIRuvMe
	 1GxDwcux9GE2SN+aQaWgogrJR3WvzMU4zZjM5+2dKmrZSQJ/Pq7ehyatFqGWTO4S3e
	 r0y8q+IyKz6keVQVs4jw/Kuh5CVs9HX53JVyh+kqOrDoIdMo70xc0ntb+cRsTWSYfG
	 rLM2eXJDs1x97D16XRQ1Dx9/9usCge7XNvRPQ9kuPAVy9z1hw2yCAfrlJH+QGsDsMU
	 mbKRfeilxFrlQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id B4A3745917;
	Thu,  8 Feb 2024 23:20:21 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Florian Eckert <fe@dev.tdt.de>
Cc: Lee Jones <lee@kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the leds-lj tree
In-Reply-To: <20240109222031.6ce4aecc@canb.auug.org.au>
References: <20240105173352.6ce1a546@canb.auug.org.au>
 <17b4305d9fe1fbed3e39597f0767f7bd@dev.tdt.de>
 <20240109222031.6ce4aecc@canb.auug.org.au>
Date: Thu, 08 Feb 2024 16:20:20 -0700
Message-ID: <87wmreee6j.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi Florian,
>
> On Mon, 08 Jan 2024 08:47:07 +0100 Florian Eckert <fe@dev.tdt.de> wrote:
>>
>> Hello Stephen,
>> 
>> thanks for your hint
>> 
>> On 2024-01-05 07:33, Stephen Rothwell wrote:
>> > Hi all,
>> > 
>> > After merging the leds-lj tree, today's linux-next build (htmldocs)
>> > produced this warning:
>> > 
>> > Warning: /sys/class/leds/<led>/rx is defined 2 times:
>> > Documentation/ABI/testing/sysfs-class-led-trigger-tty:7
>> > Documentation/ABI/testing/sysfs-class-led-trigger-netdev:49
>> > Warning: /sys/class/leds/<led>/tx is defined 2 times:
>> > Documentation/ABI/testing/sysfs-class-led-trigger-tty:15
>> > Documentation/ABI/testing/sysfs-class-led-trigger-netdev:34  
>> 
>> The behavior of the tty trigger can be controlled via the Rx and Tx file.
>> If a value is set in Rx or Tx, the LED flashes when data is transmitted in
>> this direction. The same behavior is used for the netdev trigger.
>> I have therefore used the same pattern for the new tty trigger as well.
>> 
>> I didn't know that the names have to be unique!
>> 
>> I'm a bit at a loss as to what to do now. Should I put a prefix "tty_"
>> in front of the names so that we have "tty_rx", "tty_tx"?
>> 
>> If we do it this way, however, the general question arises as to whether
>> we do have to use a prefix everywhere! If new triggers are added, then the
>> names for a config file are already used up and anyone who then wants to use
>> the same name for an other trigger with the same config file because it describe
>> the same function must then work with a prefix!
>
> I think this is only a problem with the documentation system, not the
> actual sysfs file naming.  Maybe just adding a uniquifying bit to the
> "<led>" part will solve it.  Or maybe we need the tooling to be taught
> about placeholders in sysfs names (or maybe there is already a way).

So I finally remembered to look at this when I had a chance to...  yes,
it wants each ABI entry to be unique, and the ones listed here are not.
I *think* the easiest answer is to take a line like:

  What:		/sys/class/leds/<led>/rx

and turn it into something like:

  What:		/sys/class/leds/<netdev-led>/rx

..that makes the warning go away and, I think, conveys the information
just as well.  A bit kludgy, perhaps, but I don't really see anything
else there that could be used to disambiguate the names automatically.

Thanks,

jon

