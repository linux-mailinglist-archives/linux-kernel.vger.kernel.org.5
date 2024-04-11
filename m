Return-Path: <linux-kernel+bounces-141298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC5B8A1C45
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D3151F270E0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF08515CD68;
	Thu, 11 Apr 2024 16:14:40 +0000 (UTC)
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAA925575;
	Thu, 11 Apr 2024 16:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852080; cv=none; b=EbfENGqs+jLsSOZOiUcyAbqRbM8Nl0lQMvAHDV5byV+9UXerQCz8k7TmaEUOaAqUD+PLyB0ElJWXe9N/f5brSyLchakM4npuOqWIcda7zfGOq6bQrz7BgS2U2ULqKCUPQzOtLqaq6BHqNkZqRcXHORTbzsN9P5sLbrIHohGYekw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852080; c=relaxed/simple;
	bh=zQ5fre0BsKd5TeAzHpaKWKI/8r8nMue9kRfrAZYhBWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FJk5CF2CNfClLK4F0u/eZE5znuxAucC7+Z5/5hrPppeyZWA3L2/bKqFIGM2cUBz8pkLofXozHKUZjKLfqcnHw636lIt5jSVpyLqAiD3dAafpmUdTIa0/YAXCNEDLRXuRrWDELJUTQszGMer+QOqzlj+zfkcG22v+o1SUqupYIV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 33B452F20242; Thu, 11 Apr 2024 16:14:36 +0000 (UTC)
X-Spam-Level: 
Received: from [10.88.128.156] (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 341862F2022C;
	Thu, 11 Apr 2024 16:14:34 +0000 (UTC)
Message-ID: <cfe268c1-9395-da7f-2db5-46152e348274@basealt.ru>
Date: Thu, 11 Apr 2024 19:14:34 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net] Bluetooth: hci_event: fix possible multiple drops by
 marked conn->state after hci_disconnect()
Content-Language: en-US
To: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20240411151929.403263-1-kovalev@altlinux.org>
From: kovalev@altlinux.org
In-Reply-To: <20240411151929.403263-1-kovalev@altlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

11.04.2024 18:19, kovalev@altlinux.org wrote:
> From: Vasiliy Kovalev <kovalev@altlinux.org>
> 
> When returning from the hci_disconnect() function, the conn->state
> continues to be set to BT_CONNECTED and hci_conn_drop() is executed,
> which decrements the conn->refcnt.

Syzkaller C reproducer: 
https://lore.kernel.org/all/f8bb62a7-5845-53ed-7fbe-c0557c2745f2@basealt.ru/#t

During debugging, the value conn->refcnt goes down to -1000 and less.

> Syzkaller has generated a reproducer that results in multiple calls to
> hci_encrypt_change_evt() of the same conn object.
> --
> hci_encrypt_change_evt(){
> 	// conn->state == BT_CONNECTED
> 	hci_disconnect(){
> 		hci_abort_conn();
> 	}
> 	hci_conn_drop();
> 	// conn->state == BT_CONNECTED
> }
> --
> This behavior can cause the conn->refcnt to go far into negative values
> and cause problems. To get around this, you need to change the conn->state,
> namely to BT_DISCONN, as it was before. > Fixes: a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for 
aborting connections")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
> ---
>   net/bluetooth/hci_event.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 64477e1bde7cec..e0477021183f9b 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2989,6 +2989,7 @@ static void hci_cs_le_start_enc(struct hci_dev *hdev, u8 status)
>   
>   	hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
>   	hci_conn_drop(conn);
> +	conn->state = BT_DISCONN;
>   
>   unlock:
>   	hci_dev_unlock(hdev);
> @@ -3654,6 +3655,7 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
>   		hci_encrypt_cfm(conn, ev->status);
>   		hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
>   		hci_conn_drop(conn);
> +		conn->state = BT_DISCONN;
>   		goto unlock;
>   	}
>   
> @@ -5248,6 +5250,7 @@ static void hci_key_refresh_complete_evt(struct hci_dev *hdev, void *data,
>   	if (ev->status && conn->state == BT_CONNECTED) {
>   		hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
>   		hci_conn_drop(conn);
> +		conn->state = BT_DISCONN;
>   		goto unlock;
>   	}
>   

-- 
Regards,
Vasiliy Kovalev

