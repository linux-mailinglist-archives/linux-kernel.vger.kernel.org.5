Return-Path: <linux-kernel+bounces-73442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C8385C2A0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4802E1F21CDD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4967976C9A;
	Tue, 20 Feb 2024 17:28:53 +0000 (UTC)
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9406BB3C;
	Tue, 20 Feb 2024 17:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.239.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708450132; cv=none; b=D9zIjlEJQipfjU3KHJk6JTO6dCUt9a5trvr4IoofzLWm0f6MmETRXGyO5s8nf1cRfzWvKhlZAPv5mBIncacXOY4srM9ma8RC+tbQYKS9O6X7pMd/dIwiyNHzkUyC0IB0NMh59s76J5IkG3CqGnqDMD/u02QQO9fZHVc8Zb/EBvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708450132; c=relaxed/simple;
	bh=oKDLccZyHEGW2g0OCb7bDldgHeaDewYT0IdMlFRFtLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QvAEGgkxhChCEVEVDxFjRV9Y97oU5EXk5gD8Pay5KY+BRvg6/hQokoHzbMYFlMd+/nRNA+p4JZ4BuQjIU7OwFQMutKbjCcHEO+X2U6tY6oUhOy/0HykD9NciYxVIqPHbbF44Y2TvnQKc0tf4CUnpMH+OdZ56+AK1ZGpAIy6tuC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org; spf=pass smtp.mailfrom=enpas.org; arc=none smtp.client-ip=46.38.239.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id 041CAFFE54;
	Tue, 20 Feb 2024 17:20:04 +0000 (UTC)
Message-ID: <dd1c1536-f36b-4615-97b7-7f6ea4b5e5a9@enpas.org>
Date: Wed, 21 Feb 2024 02:20:02 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] HID: nintendo: Don't fail on setting baud rate
Content-Language: en-US
To: "Daniel J . Ogorchock" <djogorchock@gmail.com>,
 Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240115145000.12777-1-max@enpas.org>
From: Max Staudt <max@enpas.org>
In-Reply-To: <20240115145000.12777-1-max@enpas.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Ping :)

Do you think this patch could be upstreamed to widen the controller support?


Thank you for looking at this!

Max




On 1/15/24 23:50, Max Staudt wrote:
> Some third-party controllers can't change the baud rate.
> 
> We can still use the gamepad as-is, so let's do that.
> 
> Signed-off-by: Max Staudt <max@enpas.org>
> ---
>   drivers/hid/hid-nintendo.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index 997c3a1adaca..8cba0612c3ae 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
> @@ -2164,8 +2164,11 @@ static int joycon_init(struct hid_device *hdev)
>   		/* set baudrate for improved latency */
>   		ret = joycon_send_usb(ctlr, JC_USB_CMD_BAUDRATE_3M, HZ);
>   		if (ret) {
> +			/*
> +			 * We can function with the default baudrate.
> +			 * Provide a warning, and continue on.
> +			 */
>   			hid_err(hdev, "Failed to set baudrate; ret=%d\n", ret);
> -			goto out_unlock;
>   		}
>   		/* handshake */
>   		ret = joycon_send_usb(ctlr, JC_USB_CMD_HANDSHAKE, HZ);


