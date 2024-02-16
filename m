Return-Path: <linux-kernel+bounces-68772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30236857FE4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD30928AD91
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F4112F39D;
	Fri, 16 Feb 2024 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="WAYLoxou"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D2712F372;
	Fri, 16 Feb 2024 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708095491; cv=none; b=UF+dduOp4YfzGBVVWhmeV4i4Fkjdbp+/Hd2VEoVRMQf81rKDUxYEvX/iloRMVBPkJeDHYGX2SnCUQ267rT7s7XaWJ2HARSrnttqvq7GSID3TgjJmGg7uDv1+/OkxWso6AQenvPVi0TlQlGeJFhGPCQgkSG6rVNABsMJ2Ax/H6NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708095491; c=relaxed/simple;
	bh=v3AOGTbTMTIU6iGZKfmnaeDoZ92yg35YAi9sU5vStrA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cGgIktMYe1U/QbLctMbTAA+IeTqWCppkJl/fuYKwkE7VlMLSjiQWHavN2EXzoGdpagXfSh/jZ2OEIiv2cbTCaabaYLpdc44wv4LyxxZMT+nMEY7iPHV0hLIH+cG8DWLzW7EeEFmYHKD5dViuBptEvSQdAsjquo8ABKOqSacXqp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=WAYLoxou; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7DA775A321
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1708095481; bh=v3AOGTbTMTIU6iGZKfmnaeDoZ92yg35YAi9sU5vStrA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WAYLoxouTxHteQQ22OvgVbP/TcYBJGv9ppqRodQu55jLWiBUkFUveZqwMP3pKH03O
	 ZjmpJWoC9zK6PGXZyZydISFuH+KhF8X+lEEPe6oTmZRmf232Kz3oNRR2zO8Ox5ovoz
	 +O2ZrLCZg9DhMp5p1POY0fn3eQKA0XVrtqcv4iGeCBW9jLdVgjWgrQGuhMob20Fc8A
	 PH3+YXf/shdDn0LGY0fGu9hTVV7LivqdcEkb/GfVbeXvm7mU0OQBueWAkMNh0lytXO
	 2FkqbdYHltrnBhw3kVPvCn6LY3ywiwrQ9pr9YL3qhFgEnYd7bQYCmVlxuVMjgQbbmj
	 jRbVIt4fOCLog==
Received: from localhost (unknown [IPv6:2601:280:5e00:625:67c:16ff:fe81:5f9b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 7DA775A321;
	Fri, 16 Feb 2024 14:58:01 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jani Nikula
 <jani.nikula@intel.com>
Cc: Vegard Nossum <vegard.nossum@oracle.com>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 security@kernel.org, Kees Cook <keescook@chromium.org>, Sasha Levin
 <sashal@kernel.org>, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v3] Documentation: Document the Linux Kernel CVE process
In-Reply-To: <2024021619-barrack-shack-206c@gregkh>
References: <2024021430-blanching-spotter-c7c8@gregkh>
 <00057b93-b5fc-4536-b13d-cd3b6cead5b1@oracle.com>
 <2024021530-plank-cornmeal-90eb@gregkh>
 <26b25204-9829-44a8-9836-1ce1c8725586@oracle.com>
 <87v86o4xu0.fsf@intel.com> <2024021619-barrack-shack-206c@gregkh>
Date: Fri, 16 Feb 2024 07:58:00 -0700
Message-ID: <87r0hcv4lj.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Fri, Feb 16, 2024 at 10:28:39AM +0200, Jani Nikula wrote:
>> rst basically allows any order of the heading underlines, and their
>> relative hierarchy is determined by how they show up in each document,
>> it's not specified by rst. However, it would be much easier for everyone
>> if all the kernel documents followed the same style.
>
> Agreed, someone should pick a style and sweep the whole directory and
> sync them up to the agreed formatting. :)

Somebody did pick a style, it's in Documentation/doc-guide/sphinx.rst :)

jon

