Return-Path: <linux-kernel+bounces-76314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2C385F58A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 309E91C237FA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1F43A1B4;
	Thu, 22 Feb 2024 10:22:01 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C718638F88;
	Thu, 22 Feb 2024 10:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708597321; cv=none; b=f7Hb9I/S4OuNv59gWs5AsRuvKp4uWav7z2Us4gxJz0EtHzVwmhlCacY2iK+DWmuhZl3A2kc/oAje89bHcXV23hJ3sFdhdbT/cEfSxPwPkt6OumC1xRskorn+pvSqRjMmUOaouthtMWRzCKfYKSM6hZqdv7gQ07HFfoZEBd93cHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708597321; c=relaxed/simple;
	bh=h9oSTywzl9Hi2AcCRwxhES/clvN6ZDIc4hLI+kvwq58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dw514QKzKCgqSSLd/oeQkvyeFWDroQH1pzPpuC7D9lh7O2OM7iJPi6K+ZPrnQud4Gkcqv8lM3SMITMDGQXhY8v7OrIwRGoI+BWRP9Z2dtaAJ+8MQnJ+oQnIaXrZN8AaY6d5No5c9Cs13S4RiQ7heXwNK2fOjUmJKVTZ0efANlOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.6] (ip5f5af3d6.dynamic.kabel-deutschland.de [95.90.243.214])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 57D4861E5FE01;
	Thu, 22 Feb 2024 11:21:11 +0100 (CET)
Message-ID: <7e3adb79-4eec-4631-bedd-047f849c6b4b@molgen.mpg.de>
Date: Thu, 22 Feb 2024 11:21:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH] igc: fix LEDS_CLASS dependency
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Andrew Lunn <andrew@lunn.ch>,
 Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
References: <20240222100324.453272-1-arnd@kernel.org>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240222100324.453272-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Arnd,


Thank you for the patch.


Am 22.02.24 um 11:02 schrieb Arnd Bergmann:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When IGC is built-in but LEDS_CLASS is a loadable module, there is
> a link failure:
> 
> x86_64-linux-ld: drivers/net/ethernet/intel/igc/igc_leds.o: in function `igc_led_setup':
> igc_leds.c:(.text+0x75c): undefined reference to `devm_led_classdev_register_ext'
> 
> Add another dependency that prevents this combination.
> 
> Fixes: ea578703b03d ("igc: Add support for LEDs on i225/i226")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/net/ethernet/intel/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
> index af7fa6856707..6e7901e12699 100644
> --- a/drivers/net/ethernet/intel/Kconfig
> +++ b/drivers/net/ethernet/intel/Kconfig
> @@ -372,6 +372,7 @@ config IGC
>   config IGC_LEDS
>   	def_bool LEDS_TRIGGER_NETDEV
>   	depends on IGC && LEDS_CLASS
> +	depends on LEDS_CLASS=y || IGC=m

Should it be ordered as the line above?

>   	help
>   	  Optional support for controlling the NIC LED's with the netdev
>   	  LED trigger.


Kind regards,

Paul

