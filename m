Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FBF777E90
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbjHJQq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjHJQqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:46:54 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1899C10C4;
        Thu, 10 Aug 2023 09:46:54 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 25C29207DB;
        Thu, 10 Aug 2023 18:46:52 +0200 (CEST)
Date:   Thu, 10 Aug 2023 18:46:48 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] Bluetooth: btnxpuart: Add support for IW624 chipset
Message-ID: <ZNUUeD2Zr1SfTODT@francesco-nb.int.toradex.com>
References: <20230810094802.832652-1-neeraj.sanjaykale@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810094802.832652-1-neeraj.sanjaykale@nxp.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Aug 10, 2023 at 03:18:02PM +0530, Neeraj Sanjay Kale wrote:
> This adds support for NXP IW624 chipset in btnxpuart driver
> by adding FW name and bootloader signature. Based on the
> loader version bits 7:6 of the bootloader signature, the
> driver can choose between selecting secure and non-secure
> FW files.
> For cmd5 payload during FW download, this chip has addresses
> of few registers offset by 1, so added boot_reg_offset to
> handle the chip specific offset.
> 
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> ---
>  drivers/bluetooth/btnxpuart.c | 44 ++++++++++++++++++++++++-----------
>  1 file changed, 31 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
> index ee6f6c872a34..b42572ca63af 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
...
> @@ -547,7 +553,7 @@ static int nxp_download_firmware(struct hci_dev *hdev)
>  	serdev_device_set_flow_control(nxpdev->serdev, false);
>  	nxpdev->current_baudrate = HCI_NXP_PRI_BAUDRATE;
>  
> -	/* Wait till FW is downloaded and CTS becomes low */
> +	/* Wait till FW is downloaded */
>  	err = wait_event_interruptible_timeout(nxpdev->fw_dnld_done_wait_q,
>  					       !test_bit(BTNXPUART_FW_DOWNLOADING,
>  							 &nxpdev->tx_state),
> @@ -558,16 +564,11 @@ static int nxp_download_firmware(struct hci_dev *hdev)
>  	}
>  
>  	serdev_device_set_flow_control(nxpdev->serdev, true);
> -	err = serdev_device_wait_for_cts(nxpdev->serdev, 1, 60000);
> -	if (err < 0) {
> -		bt_dev_err(hdev, "CTS is still high. FW Download failed.");
> -		return err;
> -	}
this seems like an unrelated change, and it's moving from a 60secs
timeout polling CTS to nothing.

What's the reason for this? Should be this a separate commit with a
proper explanation?

Francesco

