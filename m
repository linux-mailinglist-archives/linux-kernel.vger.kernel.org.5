Return-Path: <linux-kernel+bounces-82987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF014868C99
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEDBAB25517
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086651369A6;
	Tue, 27 Feb 2024 09:45:07 +0000 (UTC)
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF48D1332AA;
	Tue, 27 Feb 2024 09:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709027106; cv=none; b=azR8yi6mhQF/NOwL1PQp0qzN8XW6w1811Njbc5W+XpgR9KHzPs/RmGsOgtEcgBw9ERpicIPHdiz3GtULjIwBB6e3Z/+xuqYu+MDiwAqWIHLQsyJCyE5pc6S1LpNPBdL8MDOITg4C2s4Nb/4A5yjhouUcH4mjm7UOfspzplcekME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709027106; c=relaxed/simple;
	bh=WxG9ZhSh/THW/M5a72xK7O/httANrB9iPIhwfUKRXsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LTxj8RPQ0gncXcNfikyyUT/MkyqcU07CGVl3B7WdFn+7Yi926uPtdTV2aFV+mcxubjmUk/cbO93bED7zVfdsgUlU/ZrQHv10/fKN4POBGIttecD1gNNSMJ0hEFlj2RORW/LceLBcmPd/ixAFeuIOtzKlI8zi3dc+oFylf7Wi91o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 27 Feb 2024 18:43:53 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
	by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id ED58620584CE;
	Tue, 27 Feb 2024 18:43:52 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Tue, 27 Feb 2024 18:43:52 +0900
Received: from [10.212.157.38] (unknown [10.212.157.38])
	by kinkan2.css.socionext.com (Postfix) with ESMTP id F1918B62A2;
	Tue, 27 Feb 2024 18:43:51 +0900 (JST)
Message-ID: <2cb457a6-0039-e4fe-3668-690e6355771d@socionext.com>
Date: Tue, 27 Feb 2024 18:43:51 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 14/14] serial: 8250_uniphier: Switch to use
 uart_read_port_properties()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-rpi-kernel@lists.infradead.org,
 linux-mips@vger.kernel.org, linux-tegra@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Al Cooper <alcooperx@gmail.com>,
 =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Paul Cercueil <paul@crapouillou.net>, Vladimir Zapolskiy <vz@mleia.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
References: <20240226142514.1485246-1-andriy.shevchenko@linux.intel.com>
 <20240226142514.1485246-15-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <20240226142514.1485246-15-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2024/02/26 23:19, Andy Shevchenko wrote:
> Since we have now a common helper to read port properties
> use it instead of sparse home grown solution.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I confirmed that it works properly.

Reviewed-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Tested-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Thank you,

---
Best Regards
Kunihiko Hayashi

