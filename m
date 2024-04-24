Return-Path: <linux-kernel+bounces-157050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B35B8B0C2B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E903B23605
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1598915E800;
	Wed, 24 Apr 2024 14:13:48 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7601C15B0E2;
	Wed, 24 Apr 2024 14:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713968027; cv=none; b=oxsHbw/3Czyrap1sWMIonLPyWZR/MJUF3HylDo9uwNRiqTiNmPgkIZPJhJ4RxdLj2ok4jHO5BcN+QKsyorc+9Azz9BOQ2spoA+E4tA1OyTAxdRZ30Awc7cS425AaQI7LtQT5kXHCXL5Cdx/ihaEWkfGLUCeNaKdunYf7Cnx98hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713968027; c=relaxed/simple;
	bh=cRbX4fFdqq6ANBfeAy8HYW0knzfPEAqtYyQ9SIFo+K0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ElQd9iPqr5p+CjNvJ7T/lSlERn3XitNIqvTMB7tP2fEbH7a8chE81qVeJZJPfmkvtNEUPop5G8EJ/pHUQPn+hNwfSqohU2Uv1jdqElXXDxaPHvG7lL5N9kU1kTj4R64PtkeyIhSzkMbzgwyBopRW/8EzJkSZi+gspKiquGvOh60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.6] (ip5f5af5d1.dynamic.kabel-deutschland.de [95.90.245.209])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id AF4A061E5FE06;
	Wed, 24 Apr 2024 16:13:09 +0200 (CEST)
Message-ID: <0391b306-1368-47ea-9602-26ff6df48921@molgen.mpg.de>
Date: Wed, 24 Apr 2024 16:13:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: hci_sync: Using hci_cmd_sync_submit when
 removing Adv Monitor
To: Chun-Yi Lee <joeyli.kernel@gmail.com>
Cc: Chun-Yi Lee <jlee@suse.com>,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 Manish Mandlik <mmandlik@google.com>, Archie Pusaka <apusaka@chromium.org>,
 Miao-chen Chou <mcchou@chromium.org>, linux-kernel@vger.kernel.org,
 linux-bluetooth@vger.kernel.org
References: <20240424135903.24169-1-jlee@suse.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240424135903.24169-1-jlee@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Chun-Yi,


Thank you for your patch.

Am 24.04.24 um 15:59 schrieb Lee, Chun-Yi:
> From: Chun-Yi Lee <jlee@suse.com>

Please use imperative mood in the commit message summary:

Use hci_cmd_sync_submit() when removing Adv Monitor

> Since the d883a4669a1de be introduced in v6.4, bluetooth daemon
> got the following failed message of MGMT_OP_REMOVE_ADV_MONITOR
> command when controller is power-off:

Maybe:

Since commit d883a4669a1de, present since Linux v6.4, the daemon 
bluetoothd logs the failure below, if the command 
MGMT_OP_REMOVE_ADV_MONITOR is sent when the controller is powered off.

> bluetoothd[20976]:
> src/adapter.c:reset_adv_monitors_complete() Failed to reset Adv
> Monitors: Failed>

Please make this one line and indent it with four spaces.

> Normally this situation is happened when the bluetoothd deamon

1.  happen*s*
2.  d*ae*mon

> be started manually after system booting. Which means that

is started

> bluetoothd received MGMT_EV_INDEX_ADDED event after kernel

receive*s*

> runs hci_power_off().
> 
> Base on doc/mgmt-api.txt, the MGMT_OP_REMOVE_ADV_MONITOR command

Base*d*

> can be used when the controller is not powered. This patch changes

“This patch …” is redundant. Use: Change the code …

> the code in remove_adv_monitor() to use hci_cmd_sync_submit()
> instead of hci_cmd_sync_queue().

Please document the test setup.

> Fixes: d883a4669a1de ("Bluetooth: hci_sync: Only allow hci_cmd_sync_queue if running")
> Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Cc: Manish Mandlik <mmandlik@google.com>
> Cc: Archie Pusaka <apusaka@chromium.org>
> Cc: Miao-chen Chou <mcchou@chromium.org>
> Signed-off-by: Chun-Yi Lee <jlee@suse.com>
> ---
>   net/bluetooth/mgmt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 32ed6e9245a3..21962969411d 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -5475,7 +5475,7 @@ static int remove_adv_monitor(struct sock *sk, struct hci_dev *hdev,
>   		goto unlock;
>   	}
>   
> -	err = hci_cmd_sync_queue(hdev, mgmt_remove_adv_monitor_sync, cmd,
> +	err = hci_cmd_sync_submit(hdev, mgmt_remove_adv_monitor_sync, cmd,
>   				 mgmt_remove_adv_monitor_complete);
>   
>   	if (err) {


Kind regards,

Paul

