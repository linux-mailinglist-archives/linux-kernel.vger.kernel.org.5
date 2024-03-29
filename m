Return-Path: <linux-kernel+bounces-125341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B97B892456
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBCB21F21861
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE36139566;
	Fri, 29 Mar 2024 19:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=incomsystems.biz header.i=@incomsystems.biz header.b="O+glM+dQ"
Received: from mail01.incomsystems.biz (mail.cipherdyne.com [162.250.226.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A36452F79
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 19:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.250.226.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711740838; cv=none; b=sLAaTCpuTQg5mBnw8OyNMfPunM0XZTGGxjYtLlA/OhQrHARVrSbc9ODmmnYJl6v8KlGCemJxCjpOwCHEpTjbaR9VOid4AfmpwYRcf0f99XwZNvmEdvKf8STObHDZY2lkC0tlG8enYeOTLcNbVVQI4Sn/BWHzzmklXxJRfSokIKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711740838; c=relaxed/simple;
	bh=nMP0BULoObJ+jGA9CPG1Y3fM6LjvVsuJbkWR5hHhkYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c29Mt9VkoL6bXWmyQzr8huHkLy2jAygNS6UfHo9T1cRVNmatLwLl97tUSem0i7j75LmxeUv1jMgDRWd6ZHvbH6rRIAjkHCujNiMCdynEcblOJeUDwp3liwqT7fRujH8RLLcc6tfY6QqvR3rAYZfAPGI52uAf7AipH2vl+WFwKF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=incomsystems.biz; spf=pass smtp.mailfrom=incomsystems.biz; dkim=temperror (0-bit key) header.d=incomsystems.biz header.i=@incomsystems.biz header.b=O+glM+dQ; arc=none smtp.client-ip=162.250.226.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=incomsystems.biz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=incomsystems.biz
Received: from mail01.incomsystems.biz (localhost [127.0.0.1])
	by mail01.incomsystems.biz (Postfix) with ESMTP id 4V5r2W3FtVz1XXv49
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 14:24:51 -0500 (CDT)
Authentication-Results: mail01.incomsystems.biz (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)" header.d=incomsystems.biz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=incomsystems.biz;
	 h=content-transfer-encoding:content-type:in-reply-to:from
	:references:to:content-language:subject:user-agent:mime-version
	:date:message-id; s=dkim; t=1711740290; x=1714332291; bh=nMP0BUL
	oObJ+jGA9CPG1Y3fM6LjvVsuJbkWR5hHhkYE=; b=O+glM+dQZGntBuOKEIrkuH5
	DGV/cUMdD7EvZt2vTQbqhjN16hLLPk+gkuyFY0rgMoXxPzHA02QjyXfbpmmd2Drw
	01gAEynUhPJd5Ss1hmyEwtD4J4pC5/CqsqFQ+blBJqGAWZmex/TOfUkool3Fxgb3
	bt1LO0yV1/uJoilL074+2X0BTuHtADYOJIJ9W5JfkbSd8V9gW6dnJiEsgzLQLsEO
	adFyzF4up6ZLq3GtptD66RrhDcvsRZVBZo3ldf9cpeLmnukMTFaT8pyojvI2SJXR
	7qwzZGK8joh49HM9LTRutDOoiVW5utt5tljyvAUfeOQrsLHcGWfcLXkDtbhTNfA=
	=
X-Virus-Scanned: amavisd-new at mail01.incomsystems.biz
Received: from mail01.incomsystems.biz ([127.0.0.1])
	by mail01.incomsystems.biz (mail01.incomsystems.biz [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id GISwZ0IIefrh for <linux-kernel@vger.kernel.org>;
	Fri, 29 Mar 2024 14:24:50 -0500 (CDT)
Received: from [10.0.1.239] (199-47-118-71.fidnet.com [199.47.118.71])
	by mail01.incomsystems.biz (Postfix) with ESMTPSA id 4V5r2V5LtMz1Xg8rk;
	Fri, 29 Mar 2024 14:24:50 -0500 (CDT)
Message-ID: <14dc0bca-e5c7-40a4-88ae-b08b3680058c@incomsystems.biz>
Date: Fri, 29 Mar 2024 14:24:49 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] xz: Updates to license, filters, and compression
 options
Content-Language: en-US
To: Lasse Collin <lasse.collin@tukaani.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Jia Tan <jiat0218@gmail.com>, linux-kernel@vger.kernel.org
References: <20240320183846.19475-1-lasse.collin@tukaani.org>
From: Jonathan Bennett <jbennett@incomsystems.biz>
Autocrypt: addr=jbennett@incomsystems.biz; keydata=
 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
 YdQTKZDQSuKmpmCIzJrRCnc=
In-Reply-To: <20240320183846.19475-1-lasse.collin@tukaani.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Just in case it hasn't been brought to the kernel's attention, the xz=20
project has been compromised in its upstream repo, and versions 5.6.0=20
and 5.6.1 attempt to load a backdoor into SSH. I suggest any patches=20
associated with Lasse Collin, Jia Tan, or tukaani.org=C2=A0 be held until=
=20
that matter is fully resolved. And all their previous work needs to be=20
re-examined with this in mind.

--Jonathan Bennett

On 3/20/24 1:38 PM, Lasse Collin wrote:
> XZ Embedded, the upstream project, switched from public domain to the
> BSD Zero Clause License (0BSD). Now matching SPDX license identifiers
> can be added.
>
> The new ARM64 and RISC-V filters can be used by Squashfs.
>
> Account for the default threading change made in the xz command line
> tool version 5.6.0. Tweak kernel compression options for archs that
> support XZ compressed kernel.
>
> Documentation was revised. There are minor cleanups too.
>
> Lasse Collin (11):
>    MAINTAINERS: Add XZ Embedded maintainers
>    LICENSES: Add 0BSD license text
>    xz: Switch from public domain to BSD Zero Clause License (0BSD)
>    xz: Documentation/staging/xz.rst: Revise thoroughly
>    xz: Fix comments and coding style
>    xz: Cleanup CRC32 edits from 2018
>    xz: Optimize for-loop conditions in the BCJ decoders
>    xz: Add ARM64 BCJ filter
>    xz: Add RISC-V BCJ filter
>    xz: Use 128 MiB dictionary and force single-threaded mode
>    xz: Adjust arch-specific options for better kernel compression
>
>   Documentation/staging/xz.rst    | 130 ++++++++---------------
>   LICENSES/deprecated/0BSD        |  23 ++++
>   MAINTAINERS                     |  14 +++
>   include/linux/decompress/unxz.h |   5 +-
>   include/linux/xz.h              |   5 +-
>   init/Kconfig                    |   5 +-
>   lib/decompress_unxz.c           |  39 ++++---
>   lib/xz/Kconfig                  |  13 ++-
>   lib/xz/xz_crc32.c               |   7 +-
>   lib/xz/xz_dec_bcj.c             | 183 ++++++++++++++++++++++++++++++-=
-
>   lib/xz/xz_dec_lzma2.c           |   5 +-
>   lib/xz/xz_dec_stream.c          |   5 +-
>   lib/xz/xz_dec_syms.c            |  16 +--
>   lib/xz/xz_dec_test.c            |  12 +--
>   lib/xz/xz_lzma2.h               |   5 +-
>   lib/xz/xz_private.h             |  20 ++--
>   lib/xz/xz_stream.h              |   7 +-
>   scripts/Makefile.lib            |  13 ++-
>   scripts/xz_wrap.sh              | 157 +++++++++++++++++++++++++--
>   19 files changed, 487 insertions(+), 177 deletions(-)
>   create mode 100644 LICENSES/deprecated/0BSD
>

