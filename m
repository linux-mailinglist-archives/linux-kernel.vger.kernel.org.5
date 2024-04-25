Return-Path: <linux-kernel+bounces-158536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6E48B21CB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88AB0B21D8B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CD41494C4;
	Thu, 25 Apr 2024 12:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="P4q/UdjP"
Received: from smtpdh20-2.aruba.it (smtpdh20-2.aruba.it [62.149.155.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDACC1494BE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 12:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714048967; cv=none; b=DtBWlKC27Izi4ExRj2xTmW267RRiwBVW0PMpEdy8pfOoarvWLI0bzsE8cQCvp2ajRVJNQa6zDa9hDMNuk0xg3vuODwHdizJiPS2q+jpoon218QoqzZ3xmLvkrXz+JJLsuV7M1yuwGGKQqW6C5Orb0zErt+L2k5tYLmByDLD6Baw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714048967; c=relaxed/simple;
	bh=IVg6l6ZxJMimuWReZNU4LVvHdV1/qN0bo9jfUjEd6Ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lRqMot6kYdeqWrHbKHi3fEC5FkqZT/R8RScp5ZZ7gonMuVteMenn9fleHFxZdeMLIitsZ6Tev9z0Mri2wV7aAzSHtfc9ueOY4yXB2VO6BeR5w4iFXGNv4AFBzM9WER6M8ck+2ESa8AchKBWXPN2WJuhvD+pYUL4jT4B+DcV+zIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=P4q/UdjP; arc=none smtp.client-ip=62.149.155.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.58] ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id zyQyr0ZBl9WDgzyQyrAwPo; Thu, 25 Apr 2024 14:42:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1714048960; bh=IVg6l6ZxJMimuWReZNU4LVvHdV1/qN0bo9jfUjEd6Ts=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=P4q/UdjP8aMNdwnHR3CDz9sBtIYmJEwNtXsJYvRJupo3ivkMC3tOUEeuruxWH7cvt
	 ET8WNQoApfVmqdakqcmufVzSRyzNHZ1pDom0FEVhHdHTcr9clhWee9VkpHGMKiiV5I
	 nzfxueqtQn8nqa2Yb1EwM2XYCyaEC0T7BNysfXQNGqlPD5RTT6R3t8EDI+uo9W5Maw
	 QmdB319BDWRPBBu6BhAJBSdHbcY+zqE/G1xh3cHL0Trk3A+c4XP2r0WRgQq8pXfNHE
	 Bgbk+hd2v1kZ9Z26fOaxrb11p0KG4hurC7DDWKLv02nDMQQ+V7Rb4kNtaa++pIvdH8
	 FE798Yj2gHjCA==
Message-ID: <3612b36e-3350-4a5c-827e-482434753e95@enneenne.com>
Date: Thu, 25 Apr 2024 14:42:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] pps: clients: gpio: Bypass edge's direction check
 when not needed
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, herve.codina@bootlin.com,
 christophercordahi@nanometrics.ca,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20240425122853.29544-1-bastien.curutchet@bootlin.com>
From: Rodolfo Giometti <giometti@enneenne.com>
Content-Language: en-US, it, it-IT
In-Reply-To: <20240425122853.29544-1-bastien.curutchet@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfKsaNUXgqiP2wes+KhKCkh51MlxGtgESyY40Ql9+64N1+j+cvgUQUGFQ4VdMuQVkmoXS77j67XbPsHQLM5+uKdd6DVEjbchntipEAJM5a6XBp6vOvb1b
 Azn68wkW38E7bA0GvNREtaG9yJcrj/GVFY+j111rq2ztAfNtohkk1bguLRJgJdS3UOm+rxBiypGN3apSMD7SWLArlEhJnDxyBsDRNC2UkxqH2/HOI15yg4G1
 RT4ofVhqoYoA7Y9u/beuzcnhP1PHiwYH0QXpwakHmYcZMLrln7ESyWCMTqDi4F4/ZEJM6bVUtn7vC27O7or/6/vHVWJAMb+Oe6bcJeYcrnYg6UISG7xzGWag
 Z0m4pMyXCJqtZ8alXg6aA9A9szCeBQcpg02qIU/Bs9BwznAlZ6lC5Cb4cNPzaGi0+ytMJaBqV+87FFfqEOhKXM/oAqOqKvVsTaP0DrM6Edts8rLkHAo=

On 25/04/24 14:28, Bastien Curutchet wrote:
> In the IRQ handler, the GPIO's state is read to verify the direction of
> the edge that triggered the interruption before generating the PPS event.
> If a pulse is too short, the GPIO line can reach back its original state
> before this verification and the PPS event is lost.
> 
> This check is needed when info->capture_clear is set because it needs
> interruptions on both rising and falling edges. When info->capture_clear
> is not set, interruption is triggered by one edge only so this check can
> be omitted.
> 
> Add a warning if irq_handler is left without triggering any PPS event.
> Bypass the edge's direction verification when info->capture_clear is not
> set.
> 
> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>

Acked-by: Rodolfo Giometti <giometti@enneenne.com>

> ---
> Changes in v3:
>   - Add a warning in irq_handler
> Changes in v2:
>   - Modifiy the way the bypass is done to avoid code duplication
> 
> v1: https://lore.kernel.org/all/20240410113502.73038-1-bastien.curutchet@bootlin.com/
> v2: https://lore.kernel.org/all/20240411061329.7262-1-bastien.curutchet@bootlin.com/
> 
>   drivers/pps/clients/pps-gpio.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
> index 2f4b11b4dfcd..af62d944d051 100644
> --- a/drivers/pps/clients/pps-gpio.c
> +++ b/drivers/pps/clients/pps-gpio.c
> @@ -52,7 +52,9 @@ static irqreturn_t pps_gpio_irq_handler(int irq, void *data)
>   
>   	info = data;
>   
> -	rising_edge = gpiod_get_value(info->gpio_pin);
> +	/* Small trick to bypass the check on edge's direction when capture_clear is unset */
> +	rising_edge = info->capture_clear ?
> +		      gpiod_get_value(info->gpio_pin) : !info->assert_falling_edge;
>   	if ((rising_edge && !info->assert_falling_edge) ||
>   			(!rising_edge && info->assert_falling_edge))
>   		pps_event(info->pps, &ts, PPS_CAPTUREASSERT, data);
> @@ -60,6 +62,8 @@ static irqreturn_t pps_gpio_irq_handler(int irq, void *data)
>   			((rising_edge && info->assert_falling_edge) ||
>   			(!rising_edge && !info->assert_falling_edge)))
>   		pps_event(info->pps, &ts, PPS_CAPTURECLEAR, data);
> +	else
> +		dev_warn_ratelimited(info->pps->dev, "IRQ did not trigger any PPS event\n");
>   
>   	return IRQ_HANDLED;
>   }

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming


