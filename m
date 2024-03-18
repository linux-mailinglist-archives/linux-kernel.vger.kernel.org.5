Return-Path: <linux-kernel+bounces-105894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FE887E620
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14F861C210A4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9B42C694;
	Mon, 18 Mar 2024 09:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="gptay8ah"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152A62D608;
	Mon, 18 Mar 2024 09:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754865; cv=none; b=eseG3It4Setpoa1ykNMuuSdf/cVnhJyjQ+8CnFk5XS7EqkisbXDGFKhr0Hd7uIxlqaFnhn+ha0LBXh375XlpyxnT0yzwlgyVMc3liSg4uMEwC2scZ1LuEZT0e1HitzTPAZ7bPhv0yjpHpsKpeBIcSVfOIh5G1CIfkO5o0rnWKgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754865; c=relaxed/simple;
	bh=Rw1hNtfJiAGkJcXBduFbgoUE8X3Z/UIDYOX+xgmBwhw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CFIyipZ34EW6RjYC33j45uwfxeDfLiSZcP7N7/+1KtQG7Dj4T1EXmvPgfZntnq7jJUslaKg5MNFhwpba522XmGXKNESs5O0GhKQ1DGehdH/JtJRMgK+diU/N12dxzIFqFQdYTQElt3C5MvdXHD17fqAFDnMxGpddUArFzn8bG2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=gptay8ah; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8D808418C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1710754863; bh=xKOrfowcxhP62fcLUdlphsdPX0NycUtodiRNloAifDU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gptay8ahH8034EWx5v3A1M4fQiOli/2zCuRu3YAQ0YZYThrGcuFEVQc4+h0cD6Xic
	 EwyyCFynCC9FlLopzptVciRNF6vtAWyIj4uZ2N6BYnbvn1D8shSPqtdviANR/rCNmI
	 Iz4rlUWg4Hp2ekumxWF1h++le8JhHvMGNWoWDwXVW6BO4shopla2FddFZpg1wizl9z
	 Jnr3pKhBV9bYqucecujcIqxyQ4Wge0sh67dESG0H1o7vsi7yI4lU+eUnxP94L7icfa
	 E4JiaAF37xikauT7KNxpgZHKE8/URGZhMcAHMf37qo7Ryu3RwM9V+edlxDdc0ns37m
	 +Si5cIgzApPcA==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 8D808418C4;
	Mon, 18 Mar 2024 09:41:02 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>,
 Thorsten Leemhuis
 <linux@leemhuis.info>
Cc: kernel@collabora.com, regressions@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 workflows@vger.kernel.org, Chris Bainbridge <chris.bainbridge@gmail.com>,
 =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Subject: Re: [PATCH v2 0/2] docs: *-regressions.rst: Tweaks to the commands
In-Reply-To: <20240311-regzbot-fixes-v2-0-98c1b6ec0678@collabora.com>
References: <20240311-regzbot-fixes-v2-0-98c1b6ec0678@collabora.com>
Date: Mon, 18 Mar 2024 03:40:59 -0600
Message-ID: <87edc7andg.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com> writes:

> A couple tweaks to the commands in the regression documentation to make
> them up-to-date and less confusing.
>
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> Changes in v2:
> - Reworded patch 1:
>   - s/collon/colon/
>   - Made title and message more straightforward
> - Link to v1: https://lore.kernel.org/r/20240308-regzbot-fixes-v1-0-577a4=
fe16e12@collabora.com
>
> ---
> N=C3=ADcolas F. R. A. Prado (2):
>       docs: *-regressions.rst: Add colon to regzbot commands
>       docs: handling-regressions.rst: Update regzbot command fixed-by to =
fix
>
>  Documentation/admin-guide/reporting-regressions.rst |  2 +-
>  Documentation/process/handling-regressions.rst      | 12 ++++++------
>  2 files changed, 7 insertions(+), 7 deletions(-)

Applied, thanks.

jon

