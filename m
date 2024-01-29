Return-Path: <linux-kernel+bounces-42470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6018401C1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9BDA281C21
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64865823E;
	Mon, 29 Jan 2024 09:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AV4Nwt/9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E728F58237;
	Mon, 29 Jan 2024 09:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706520703; cv=none; b=FfPT2fkALvN5O5jq3cnnxrcq4wd7CCCKObBnXklxQgWFI5IpByhiIS4nv6tdWLPScdBhPoQUFePCs3WklWHLMpf+NamvIOnX8C4G1pcuaVdM0aa16R18bHHfIocCY0+HWX5YGeaPHUb3gsNXEAwOzb57FVaIP3aVeoBMhdepffg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706520703; c=relaxed/simple;
	bh=u8bZBL7bROLWcZ4zvnUltfzF1EYkuzlBMkwtZKRU30M=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8qzQw98qPPi8Kd51kwSRHQ8zhfyH3QgeE1ImkxbjwIdYfnsfK3ZvzNF0lQRLN5kbLzcr+eCxPzIGLFMClWN0sSIOUiIY2LqWUffiJXvLsd5nsCWw+Y2yWF8Fp6vu1UGKaZm8HIc4ImKykNEG1isAoLxhc3xsIV7+IJuQcpSPtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AV4Nwt/9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B30C433F1;
	Mon, 29 Jan 2024 09:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706520702;
	bh=u8bZBL7bROLWcZ4zvnUltfzF1EYkuzlBMkwtZKRU30M=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=AV4Nwt/943wXxhxogOP43vdO42usifK0ExymHJin/JnP2rZxVVDPJAK8C6qhNaMyo
	 eU7yUxGg5Yc4uRqfp9VrDYPkngcl7syAxHOpsnQNmCvM9aNUHQr+kZG8qStyOsuaqh
	 w8ft13+0KKTC0df/EMdMg/OydM+iulIMwujDhDsuSpQ/nelaQxFWEGyQkSZxlShR3d
	 ls0aNQv9gWgTL4g4hzdytiqAHFe61fu9hlLc4PkF8KLEFWYL+YwlMd9eqvgmKEbygE
	 F1IlK5cYIF915qWcwKrnh/Ydl8eiwyU6oTeT0yRSjGqR5CEtJBQvTd+a0ARC0Ox3SO
	 lzKchPIWm/S3Q==
Date: Mon, 29 Jan 2024 09:31:36 +0000
From: Lee Jones <lee@kernel.org>
To: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Crutcher Dunnavant <crutcher+kernel@datastacks.com>,
	Juergen Quade <quade@hsnr.de>,
	David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH 1/1] lib/vsprintf: Implement ssprintf() to catch
 truncated strings
Message-ID: <20240129093136.GB1708181@google.com>
References: <20240129092705.1978653-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240129092705.1978653-1-lee@kernel.org>

Please discard - missing version identifier in the subject line.

New version here:

  https://lore.kernel.org/r/20240129092952.1980246-1-lee@kernel.org

-- 
Lee Jones [李琼斯]

