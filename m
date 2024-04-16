Return-Path: <linux-kernel+bounces-147130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FF48A6FD9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36289282549
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E2E130E55;
	Tue, 16 Apr 2024 15:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R487GgL3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A8D84E0A;
	Tue, 16 Apr 2024 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713281475; cv=none; b=UXmpWCEpOvasOrfoYVPbmUxnFwyzUvgh3gH9ztrRWjt3b0oUyELSdfFQ5cLGjzKPT3dnB2wcAqEjQoD1iX0YUou4wRWNgOqqvh/LCmItQ+8c9iWsD93BK7gI7lXDKoGGcXYf8o9MwpqDcpFOHzrCqlB5QfP66gFdtNWEcmr0vs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713281475; c=relaxed/simple;
	bh=ayFQIrGDzoWusQnCjR5R/LS3TPKOR5mdELJbyQXt0gQ=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=uSObg/VQahyIswTCnBsWnQ9vwN7GpYMNvQh2YyrhwaSd1uzgbDuCW0mtwFZiw67iIKVTrQ2maCCFitsklR3o9NdXqwMoOzrZS5j7j1hSm5HylvLwu3anQjXj7hVHY4WKeF4QJekx6e00aOUNFF/O3xZ4nmgLa0iLdLC4iMp5Oak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R487GgL3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4540CC113CE;
	Tue, 16 Apr 2024 15:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713281474;
	bh=ayFQIrGDzoWusQnCjR5R/LS3TPKOR5mdELJbyQXt0gQ=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=R487GgL3aprV0Qc8xy0Y/bjdankMw1kB1COdoXOH2wQz4xVPEzJumhEMeyPRaecmx
	 5mNCL45A9uB/upxUkb8gcUz2BIZk/bAMeCPFiOOy6qTegWdTamANQuCDdmrRIeKsNv
	 /cul/PXpOz7PjB6ef/76Wvvs2sryIEQIKO4S6lrPGjh+D6xygM/7Qv2nyhxUYnnGPu
	 rSdqU10RxQgbU4N5pfFBedAKXznXGuesmdvWwRSJGEbSjNgWmkGCwAbhEIJI+b3ohW
	 p2ynG7JJIXsDjiXjHcycNGFYZtEvM5yorW9KKyPGmNnPB8rYbHL60BnC/Ng9pxxINm
	 7y4c0EzNxGvzw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] wifi: wilc1000: set atomic flag on kmemdup in srcu
 critical section
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240410-wilc_srcu_to_rcu-v1-1-a9ff5b10feaa@bootlin.com>
References: <20240410-wilc_srcu_to_rcu-v1-1-a9ff5b10feaa@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, =?utf-8?q?Al?=
	=?utf-8?q?exis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171328147120.402909.13178958912833921498.kvalo@kernel.org>
Date: Tue, 16 Apr 2024 15:31:13 +0000 (UTC)

Alexis Lothoré <alexis.lothore@bootlin.com> wrote:

> In order to prepare wilc1000 driver switch from SRCU to RCU, make sure that
> allocators are provided with the GFP_ATOMIC flag when called in a critical
> read section.
> 
> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>

2 patches applied to wireless-next.git, thanks.

35aee01ff43d wifi: wilc1000: set atomic flag on kmemdup in srcu critical section
f236464f1db7 wifi: wilc1000: convert list management to RCU

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240410-wilc_srcu_to_rcu-v1-1-a9ff5b10feaa@bootlin.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


