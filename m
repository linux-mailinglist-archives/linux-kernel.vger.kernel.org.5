Return-Path: <linux-kernel+bounces-127350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 115E8894A28
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 05:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F5721C23544
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 03:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FD9175BC;
	Tue,  2 Apr 2024 03:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hROEiqAF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1261426F;
	Tue,  2 Apr 2024 03:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712029866; cv=none; b=ZXmX39UaRBIu5eYE7WNggFC/6YZnLMpnSIm7Zz1bCMq7uIkes3F478qYobxab+5R31UydOIjQ19csGpgyUyUk+AP15I9WuZGCUDfgWB4yk+Cpl0Yo4quVGB20W8etxc9m6imF1q5SxMYRCernAe9KRzfIOlPYf8IGRsIwMNP0KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712029866; c=relaxed/simple;
	bh=WMeus+9z+os5yRKCGjNzYgYzIutPvTegtUqNJyOVU14=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WCOAKpJytJelPyWZ7Nn1l+omLAzTU4ze3jcCc/dPPDRVUManC0uqxcARWqBiQn5lEo1/2Py3Lzp5R6FmOMCbsL9uc+q5XqmsurJGprC/rz4EqJHMpEVS5MsSCJ7OEozBR9M0qytANwioFyqKhLj1lH9p7FeooMnBjPOcLcNn1Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hROEiqAF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE14C433C7;
	Tue,  2 Apr 2024 03:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712029866;
	bh=WMeus+9z+os5yRKCGjNzYgYzIutPvTegtUqNJyOVU14=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hROEiqAF8JPVjwyxxVNXQgq/D3Y3t1UkjQdUAmA7XeXMQvX3ZOIDoZjXCGQ51VH60
	 9dsOPlorjq3/QEZLR3DPiVKtesMRUWqkA8B29el0rgQ2+oNmfM2fYe94Hzhz5b2ho0
	 37Dhly3rlc0QVL9doCxoQJiWmEAK0r7R8+4VlP/3DODB/p6G3VpogOEqkiEZrKXYaE
	 GlCJ4LNQpbW/d1mWrazakeepPhZZDv7gBTVrUx/uqe4zsiyLPKT8oZSilRhxxYmxH9
	 eUB47u2ZohGT6QC0mbO+zuWQwjJU20q8caWN5f2ur46Nys9+KeW9JpERDNqtEk6zeR
	 gp4RoglGM+nNw==
Date: Mon, 1 Apr 2024 20:51:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Netdev <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Arnd Bergmann <arnd@arndb.de>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH 6.8 000/399] 6.8.3-rc1 review
Message-ID: <20240401205103.606cba95@kernel.org>
In-Reply-To: <CA+G9fYuHZ9TCsGYMuxisqSFVoJ3brQx4C5Xk7=FJ+23PHbhKWw@mail.gmail.com>
References: <20240401152549.131030308@linuxfoundation.org>
	<CA+G9fYuHZ9TCsGYMuxisqSFVoJ3brQx4C5Xk7=FJ+23PHbhKWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Apr 2024 01:10:11 +0530 Naresh Kamboju wrote:
> The following kernel BUG: unable to handle page fault for address and followed
> by Kernel panic - not syncing: Fatal exception in interrupt noticed
> on the qemu-i386 running  selftests: net: pmtu.sh test case and the kernel
> built with kselftest merge net configs with clang.
> 
> We are investigating this problem on qemu-i386.

One-off or does it repro?

