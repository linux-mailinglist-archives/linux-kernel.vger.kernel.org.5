Return-Path: <linux-kernel+bounces-25967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F1082D8EE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 616FC281F84
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 12:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AEF15AF6;
	Mon, 15 Jan 2024 12:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e66828PM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049E413AD4;
	Mon, 15 Jan 2024 12:35:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39426C433F1;
	Mon, 15 Jan 2024 12:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705322147;
	bh=ka2hi/uM2nE/0NKw+Ue3UWnzr5acORYb/NeWIN/2f+U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e66828PMRqC5XrkvIVrAGDYDGKxgNZx3pXLiUaFI9j1huy3xJx8e5QFnkEaWSaQay
	 gaiO3lsWdmcombfowkdDy6EIOb0ZZEkqO3XmRygRhb8wlFJg5ALtf6BjKtc0nHNbiy
	 h280O2Zgtyw2IfyGoaAsFh3JcZ1e+Mt4RqC5aIdvvRj6Ur2FNwKkWgUUkskgbrq7lp
	 K32x/Ax1rs0eTENdQKFQhd7lEFlDekezv29MQ+Sp6p4p+NJCoiCdDPMOuyNG3eZjKg
	 i/KGkyIaieHkHeKyOSJbLMID9cJwtWkTPdb5VXghRrVSrpX/8XrrbPenD8uEu8WZL1
	 u3ScKn33GpW5A==
Message-ID: <f236fe3c-c2ea-49c9-8594-aca74891c7f2@kernel.org>
Date: Mon, 15 Jan 2024 14:35:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mfd: omap-usb-host: Increase size of buffer to
 include all possible values
Content-Language: en-US
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
 Keshava Munegowda <keshava_mgowda@ti.com>, linux-omap@vger.kernel.org
References: <20240111163949.1976778-1-lee@kernel.org>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240111163949.1976778-1-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/01/2024 18:39, Lee Jones wrote:
> Avoid these nasty W=1 errors:
> 
>   drivers/mfd/omap-usb-host.c: In function ‘usbhs_omap_probe’:
>   drivers/mfd/omap-usb-host.c:706:54: error: ‘_clk’ directive output may be truncated writing 4 bytes into a region of size between 1 and 11 [-Werror=format-truncation=]
>   drivers/mfd/omap-usb-host.c:705:17: note: ‘snprintf’ output between 24 and 34 bytes into a destination of size 30
>   drivers/mfd/omap-usb-host.c:721:56: error: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size 8 [-Werror=format-truncation=]
>   drivers/mfd/omap-usb-host.c:721:33: note: directive argument in the range [-2147483640, 2147483647]
>   drivers/mfd/omap-usb-host.c:720:17: note: ‘snprintf’ output between 28 and 38 bytes into a destination of size 30
>   drivers/mfd/omap-usb-host.c:731:55: error: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size 9 [-Werror=format-truncation=]
>   drivers/mfd/omap-usb-host.c:731:33: note: directive argument in the range [-2147483640, 2147483647]
>   drivers/mfd/omap-usb-host.c:730:17: note: ‘snprintf’ output between 27 and 37 bytes into a destination of size 30
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Keshava Munegowda <keshava_mgowda@ti.com>
> Cc: Roger Quadros <rogerq@ti.com>
> Cc: linux-omap@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Reviewed-by: Roger Quadros <rogerq@kernel.org>


