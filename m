Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF8D7FA41D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbjK0PJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbjK0PJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:09:44 -0500
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53A5C6;
        Mon, 27 Nov 2023 07:09:49 -0800 (PST)
Received: from [141.14.220.40] (g40.guest.molgen.mpg.de [141.14.220.40])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id A356D61E5FE01;
        Mon, 27 Nov 2023 16:08:58 +0100 (CET)
Message-ID: <207e13bb-e0d9-49b6-824f-99a8d0944dff@molgen.mpg.de>
Date:   Mon, 27 Nov 2023 16:08:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: hci_sync: fix BR/EDR wakeup bug
To:     15013537245@163.com
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clancy Shang <clancy.shang@quectel.com>
References: <20231127090545.117162-1-15013537245@163.com>
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20231127090545.117162-1-15013537245@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Clancy,


Thank you for the patch.

Am 27.11.23 um 10:05 schrieb 15013537245@163.com:
> From: "clancy.shang" <clancy.shang@quectel.com>

It’d be great, if you spelled your name “Clancy Shang”.

     $ git config --global user.name "Clancy Shang"
     $ git commit -s --amend --author="Clancy Shang 
<clancy.shang@quectel.com>"

> Steam deck in suspending state, but bt controller send hci
> mode change event to host. cause Steam Deck can't into sleep.

Could you please elaborate on the fix little more, for example, mention 
the mode change (0xf7).

> Signed-off-by: clancy.shang <clancy.shang@quectel.com>
> ---
>   net/bluetooth/hci_sync.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index a15ab0b874a9..a26a58cb2c38 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -3800,12 +3800,14 @@ static int hci_set_event_mask_sync(struct hci_dev *hdev)
>   	if (lmp_bredr_capable(hdev)) {
>   		events[4] |= 0x01; /* Flow Specification Complete */
>   
> -		/* Don't set Disconnect Complete when suspended as that
> -		 * would wakeup the host when disconnecting due to
> -		 * suspend.
> +		/* Don't set Disconnect Complete and mode change when
> +		 * suspended as that would wakeup the host when disconnecting
> +		 * due to suspend.
>   		 */
> -		if (hdev->suspended)
> +		if (hdev->suspended) {
>   			events[0] &= 0xef;
> +			events[2] &= 0xf7;
> +		}
>   	} else {
>   		/* Use a different default for LE-only devices */
>   		memset(events, 0, sizeof(events));


Kind regards,

Paul Menzel
