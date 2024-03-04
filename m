Return-Path: <linux-kernel+bounces-90667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C94E8702EC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56419286EF4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9173EA77;
	Mon,  4 Mar 2024 13:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="KF1Y+MPC"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC4C3E494;
	Mon,  4 Mar 2024 13:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709559570; cv=none; b=Q42uBL73TQ6nXlvbmeC+PO4Bb/HxJxsBe7Vt/XnecDZ+7Q0F8pQMK4hMlspR00HU0yOLqmya/+tkAC5J/Z/Anh6RvRBjtibIC8lKHwodQmmQs08sxXx8jl5bOlKJsp2k0QfvMj5dw/t2dRwzA4K6VgGIHmCci3ZQeI8AvcwmkCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709559570; c=relaxed/simple;
	bh=lMEQDj4wA9CSoQcPHMZJJYk/61VCQ5aWH38lX7E2mnM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IHuPoDAkPe+WIQIGdPwYiHPIWAxrsyukjVUcWSx5MhcTAspkXmptZZsXFyKyxRq0pCkTANweuSg/jNhWOk3rYxEKoks8wyiyb45sJymOBWxpaZyYccVkx5MNcm2Sa9F0y52iYI7pyAwdfjrteLq7JtIBCEqZqStFZivMz8yIjoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=KF1Y+MPC; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 95400418BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1709559567; bh=g/HLnVv992UFJH8TinGv51zquGqHoXPwXe5EaET4ry8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=KF1Y+MPCWxeBr/CzWgXbVtwk+PHp4e2ll2QZXoK9uugY79bxprrAudOWkYvGcHcZc
	 gldJYfNEIgTvFUsYXWS2A/9xqxIPSinfIppWBNwfyqd/mK8SPX+gNvPxlFjmmZKhoJ
	 Sns6MArjjkc+oUP+J8nYzgkUncB5ozJSdOFely+kgk6BP8JnsmBuybujrK1Hqq3tuN
	 StUWiR4BCDTUGF2DghM1RiCR2VMHMl5d6yINwaiFLq9iUqOS9ESZpTPew3tMqm5zAy
	 77EXkhBHZQPn/NZlRBiBXG6okfowFNwHCU+RHYQ5U6hQ+AG1a0N+NZkO8Z2lly3tvT
	 j35uFqcnTcigQ==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 95400418BA;
	Mon,  4 Mar 2024 13:39:27 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Salvatore Bonaccorso <carnil@debian.org>, regressions@lists.linux.dev,
 stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ben Hutchings
 <ben@decadent.org.uk>, Kees Cook <keescook@chromium.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Aditya Srivastava
 <yashsri421@gmail.com>, 1064035@bugs.debian.org
Subject: Re: [regression 5.10.y] linux-doc builds: Global symbol "$args"
 requires explicit package name (did you forget to declare "my $args"?) at
 ./scripts/kernel-doc line 1236.
In-Reply-To: <ZeHKjjPGoyv_b2Tg@eldamar.lan>
References: <ZeHKjjPGoyv_b2Tg@eldamar.lan>
Date: Mon, 04 Mar 2024 06:39:26 -0700
Message-ID: <877ciiw1yp.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Salvatore Bonaccorso <carnil@debian.org> writes:

> Hi,
>
> Ben Hutchings reported in https://bugs.debian.org/1064035 a problem
> with the kernel-doc builds once 3080ea5553cc ("stddef: Introduce
> DECLARE_FLEX_ARRAY() helper") got applied in 5.10.210 (as
> prerequisite of another fix in 5.10.y):
>
>> The backport of commit 3080ea5553cc "stddef: Introduce
>> DECLARE_FLEX_ARRAY() helper" modified scripts/kernel-doc and
>> introduced a syntax error:
>> 
>> Global symbol "$args" requires explicit package name (did you forget to declare "my $args"?) at ./scripts/kernel-doc line 1236.
>> Global symbol "$args" requires explicit package name (did you forget to declare "my $args"?) at ./scripts/kernel-doc line 1236.
>> Execution of ./scripts/kernel-doc aborted due to compilation errors.
>> 
>> This doesn't stop the documentation build process, but causes the
>> documentation that should be extracted by kernel-doc to be missing
>> from linux-doc-5.10.
>> 
>> We should be able to fix this by eithering backport commit
>> e86bdb24375a "scripts: kernel-doc: reduce repeated regex expressions
>> into variables" or replacing /$args/ with /([^,)]+)/.
>> 
>> Ben.
>
> What would be prefered here from stable maintainers point of view?
> AFAICS e86bdb24375a ("scripts: kernel-doc: reduce repeated regex
> expressions into variables") won't apply cleanly and needs some
> refactoring. The alternative pointed out by Ben would be to replace
> the /$args/ with  /([^,)]+)/.

Hmm...this is the first I see of any of this...

The latter fix seems like the more straightforward of the two.  The only
concern might be if there are other kernel-doc backports that might run
afoul of the same problem, hopefully not.

But this makes me wonder if there are other stable kernels that are
affected as well.  I guess that, despite all of the testing being done
on stable updates, nobody is testing the docs build?

Thanks,

jon

