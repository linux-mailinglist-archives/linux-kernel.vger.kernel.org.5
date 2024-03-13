Return-Path: <linux-kernel+bounces-101418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0C487A6DE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5181F21E31
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15C83F9C3;
	Wed, 13 Mar 2024 11:09:39 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E364C618;
	Wed, 13 Mar 2024 11:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710328179; cv=none; b=PuSiNCY2z0gCf+cM7H7ZXrBFeIQm8rn/YGiDZaQ6XnmSkZCZ15YkCenNZIiQUMSz41K0gAjoJCH8bUGt+WDdYxQgwQUmIDVqF15urn6XFTAtyao4a99ZroJq1RF4Mexv2LT1dnbkwf0yGuTrs2rJGtNBXvvcsyeDnxo5DSCyO2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710328179; c=relaxed/simple;
	bh=7E0FWu/tC3XQEAq8/VJphNgdP79HyVmJK+bjjlHyHHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=RCWNRya7DPFkfE1yRsu/Zu3nuuuVM2xpM83T8r6WWL+HY+0q6IgJuXv6jd563BPr0kgkX0RMS7kqZ2lthFSpDGRALHAGqYaVa3AjtBhgKKFi10Nc4InE9ZS8ZfYQY3Y9G67MeoDf6li43VDo2F4aT7xIP8Z9WqSQn2+czEmoqYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 40E6161E5FE04;
	Wed, 13 Mar 2024 12:08:02 +0100 (CET)
Message-ID: <6f2af609-e3fc-426b-a7ee-b83b859af09f@molgen.mpg.de>
Date: Wed, 13 Mar 2024 12:08:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pinctrl: pinctrl-aspeed-g6: Fix register offset for
 pinconf of GPIOR-T
Content-Language: en-US
To: Billy Tsai <billy_tsai@aspeedtech.com>
References: <20240313092809.2596644-1-billy_tsai@aspeedtech.com>
Cc: andrew@codeconstruct.com.au, linus.walleij@linaro.org, joel@jms.id.au,
 johnny_huang@aspeedtech.com, linux-aspeed@lists.ozlabs.org,
 openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 BMC-SW@aspeedtech.com, Ricky_CX_Wu@wiwynn.com
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240313092809.2596644-1-billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Billy,


Thank you very much for sending version 2.


Am 13.03.24 um 10:28 schrieb Billy Tsai:
> The register offset to disable the internal pull-down of GPIOR~T is 0x630
> instead of 0x620, as specified in the Ast2600 datasheet v15
> The datasheet can download from the official Aspeed website.

(No need for another iteration for this, but “can be downloaded”.)

> Fixes: 15711ba6ff19 ("pinctrl: aspeed-g6: Add AST2600 pinconf support")
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>   drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c | 34 +++++++++++-----------
>   1 file changed, 17 insertions(+), 17 deletions(-)

[…]

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

