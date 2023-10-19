Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3AB7CFFDE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345181AbjJSQoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbjJSQog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:44:36 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFD812A;
        Thu, 19 Oct 2023 09:44:33 -0700 (PDT)
Received: from [192.168.0.233] (ip5f5bf22a.dynamic.kabel-deutschland.de [95.91.242.42])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7DE8061E5FE01;
        Thu, 19 Oct 2023 18:44:05 +0200 (CEST)
Message-ID: <153890ae-2aba-461a-a0a2-0745047c9303@molgen.mpg.de>
Date:   Thu, 19 Oct 2023 18:44:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] Bluetooth: btnxpuart: Fix nxp_setup
Content-Language: en-US
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-bluetooth@vger.kernel.org, Sherry Sun <sherry.sun@nxp.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>,
        linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Amitkumar Karwar <amitkumar.karwar@nxp.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20231018145540.34014-1-marcel@ziswiler.com>
 <20231018145540.34014-3-marcel@ziswiler.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20231018145540.34014-3-marcel@ziswiler.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Marcel,


Thank you for your patch.

Am 18.10.23 um 16:55 schrieb Marcel Ziswiler:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

“Fix nxp_setup” is really generic. A more specific message would be 
great. Maybe: Wait up to 10 s for firmware.

> Unfortunately, nxp_setup() may inadvertently assume that the
> firmware is already running while the module is not even powered yet.
> Fix this by waiting up to 10 seconds for the CTS to go up as the combo
> firmware might be loaded by the Wi-Fi driver over SDIO (mwifiex_sdio).
> 
> Fixes: 689ca16e5232 ("Bluetooth: NXP: Add protocol support for NXP Bluetooth chipsets")
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> This is what may happen without this fix:
> [  284.588177] Bluetooth: hci0: Opcode 0x0c03 failed: -110
> [  286.636167] Bluetooth: hci0: Setting wake-up method failed (-110)
> Unfortunately, even re-loading the btnxpuart kernel module would not
> recover from this condition.

I’d add that information to the commit message.

>   drivers/bluetooth/btnxpuart.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
> index 9cb7529eef09..4b83a0aa3459 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -1021,6 +1021,16 @@ static int nxp_setup(struct hci_dev *hdev)
>   		if (err < 0)
>   			return err;
>   	} else {
> +		/* The combo firmware might be loaded by the Wi-Fi driver over SDIO (mwifiex_sdio).
> +		 * We wait up to 10s for the CTS to go up. Afterwards, we know that the firmware is
> +		 * really ready.
> +		 */
> +		err = serdev_device_wait_for_cts(nxpdev->serdev, true, 10000);
> +		if (err) {
> +			bt_dev_err(nxpdev->hdev, "Wait for CTS failed with %d", err);
> +			return err;
> +		}
> +
>   		bt_dev_dbg(hdev, "FW already running.");
>   		clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
>   	}

Isn’t there another way to find out, if the firmware is there? Adding an 
arbitrary timeout of ten seconds sounds like a fundamental flaw in the 
driver?


Kind regards,

Paul
