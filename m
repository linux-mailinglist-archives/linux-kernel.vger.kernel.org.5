Return-Path: <linux-kernel+bounces-64875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFF0854427
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90E231C23BB7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA12D2E6;
	Wed, 14 Feb 2024 08:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOJigtsT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E535CBE48;
	Wed, 14 Feb 2024 08:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707900258; cv=none; b=mDASKbVsMb0Xw5itW1WDKgcIN/s76YAtIfKATkgGHy0PS0XnbJBrtZ5dthdJrrFayek1I2tQkm7kOGD824oO5s8IP4Z13wpgFXUERwDwYgcl5QNe46Rf+c4JaxtGLsuNQ/w8ll98M5S1qQqhePtFkRvVyuawIJALcmX+5n1gA8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707900258; c=relaxed/simple;
	bh=u3CxopS384xy1pq8axVOiaOQ1FEfcHdIIJHwm89eKjk=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=WKZcfTmWK5zU7TUOlHpxQllYSdpr6MoTGr962AbuqNFDrK60AhzElQoCf97OblpM80E/EiwbWG6kmOzQo8eg+0QOBCGmJgSPkgRczyP7VsRjsvo6cqsi+xdAikLzSaiXyTcwiw47r6AX4Tei+RHs4yBezBtkCRggJLNS2Nn5x4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOJigtsT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F849C433C7;
	Wed, 14 Feb 2024 08:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707900257;
	bh=u3CxopS384xy1pq8axVOiaOQ1FEfcHdIIJHwm89eKjk=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=WOJigtsTcgI88bgbEoVvVOczkajq01e+kG6HeD6HlkMAYEUj9Wrrpef3REFn6wJDg
	 g5aSAHOhpNq34cZDSOiBUGIwHLoW9USIpqSlMpaIIXcwbs4dQDHQHeYQqfkkvU0zNA
	 ASiPhjwkFoAIHXAZOICEPdIPKISqmF63Wl/OLKAgsWWQzPtNk+8g1zuG9Zee9Q8hux
	 v8TeXX2DSM0sWs8cP+LV03YKLZrMS1YcxT4hyaB+nvOzP5ybzmMTavrr4ex29w8lay
	 PswgbU9vEcQaRGtcarXtl6eRViNjwdA3KBjJw0MqyOubI/CzyywG+CTwwIJGnx9wMF
	 EbJv8vb3MfWGA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: sanitize ath12k_mac_allocate() return code
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240213100912.459018-1-arnd@kernel.org>
References: <20240213100912.459018-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
 Arnd Bergmann <arnd@arndb.de>, Aloka Dixit <quic_alokad@quicinc.com>,
 Wen Gong <quic_wgong@quicinc.com>, Muna Sinada <quic_msinada@quicinc.com>,
 Aditya Kumar Singh <quic_adisi@quicinc.com>, ath12k@lists.infradead.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170790025305.3179441.138152315558305278.kvalo@kernel.org>
Date: Wed, 14 Feb 2024 08:44:14 +0000 (UTC)

Arnd Bergmann <arnd@kernel.org> wrote:

> The return code has no initializer:
> 
> drivers/net/wireless/ath/ath12k/mac.c:8006:9: error: variable 'ret' is uninitialized when used here [-Werror,-Wuninitialized]
> 
> Make it return -ENOMEM for allocation failures and remove the unused
> variable instead.
> 
> Fixes: 6db6e70a17f6 ("wifi: ath12k: Introduce the container for mac80211 hw")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Nathan already fixed this:

https://git.kernel.org/kvalo/ath/c/04edb5dc68f4

Patch set to Rejected.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240213100912.459018-1-arnd@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


