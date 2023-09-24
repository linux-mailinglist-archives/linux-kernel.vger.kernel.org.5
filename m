Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91327AC721
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 10:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjIXIPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 04:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjIXIPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 04:15:42 -0400
X-Greylist: delayed 206 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 24 Sep 2023 01:15:35 PDT
Received: from mx1.mythic-beasts.com (mx1.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6974F10B;
        Sun, 24 Sep 2023 01:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lentin.co.uk; s=mythic-beasts-k1; h=Subject:To:From:Date;
        bh=zkyOVeOH2gDIlvyMUdIGDWcpYtTCEjk1PY006D/SgBA=; b=Oj2AXPYpU9j/GzPQ9y5vBEySmV
        zI0purE3gmK1SO6UiaOGJVvaJFon7IxmMgAsBsK/6GMG7xinoSojhOz/r2/jRs43Io97s2aSFXwUY
        DR5h1nUI7eY1ywourktUR175jg04cNGFWnnmwq/XhRL2/Fcth+fMdoJYfV7r6HOpPGjfIrTNA80CV
        0PBTw/oNyROuPwUHXEM8ShhrTIOY8GkFTj/NXrsV1xrpe/giieINokZUkGLoi0TU7SwxlOaCQ+uF/
        zkWu0mLw8vMyeAUXYLaaccow3Kn7z+xg7DRn1N0UWbSeDHUK2ZqCGzHMVo23lgJKuznUWokBxpCIB
        M4ZJ/anQ==;
Received: by mailhub-cam-d.mythic-beasts.com with esmtpa (Exim 4.94.2)
        (envelope-from <jm@lentin.co.uk>)
        id 1qkKDu-00ECPf-CK; Sun, 24 Sep 2023 09:12:14 +0100
MIME-Version: 1.0
Date:   Sun, 24 Sep 2023 09:11:16 +0100
From:   Jamie Lentin <jm@lentin.co.uk>
To:     Martin Kepplinger <martink@posteo.de>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: lenovo: Fix middle-button behaviour for system
 suspend
In-Reply-To: <20230921092140.120533-1-martink@posteo.de>
References: <20230921092140.120533-1-martink@posteo.de>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <140b721bc345a846863a37ebf17c3174@lentin.co.uk>
X-Sender: jm@lentin.co.uk
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-21 10:21, Martin Kepplinger wrote:
> After system suspend the middle-button mode is being reset to
> compatibility mode which simply breaks functionality for the devices
> where native mode is configured during probe().
> 
> Fix this by setting native mode in reset_resume() for the appropriate
> devices.
> 
> Fixes: 94eefa271323 ("HID: lenovo: Use native middle-button mode for
> compact keyboards")
> Signed-off-by: Martin Kepplinger <martink@posteo.de>
> ---
>  drivers/hid/hid-lenovo.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
> index 44763c0da444..d20562b9eca6 100644
> --- a/drivers/hid/hid-lenovo.c
> +++ b/drivers/hid/hid-lenovo.c
> @@ -1344,6 +1344,28 @@ static int lenovo_input_configured(struct
> hid_device *hdev,
>  	return 0;
>  }
> 
> +static int __maybe_unused lenovo_resume(struct hid_device *hdev)
> +{
> +	int ret;
> +
> +	switch (hdev->product) {
> +	case USB_DEVICE_ID_LENOVO_CUSBKBD:
> +	case USB_DEVICE_ID_LENOVO_CBTKBD:
> +	case USB_DEVICE_ID_LENOVO_TPIIUSBKBD:
> +	case USB_DEVICE_ID_LENOVO_TPIIBTKBD:
> +		/* Switch middle button to native mode again */
> +		ret = lenovo_send_cmd_cptkbd(hdev, 0x09, 0x01);

This will only reset the middle button state and not the Function key 
state, which I believe has similar problems. This was my attempt at 
solving this:

   
https://github.com/lentinj/linux/commit/f1c4e2de780abf8526bcdc9496c463f1ff4fe53b

...which should ensure everything is in a consistent state with what the 
kernel expects.

I never submitted this since sending commands was sporadically resulting 
in timeouts, although I'm fairly sure it was unrelated to this patch, 
and quite possibly a hardware problem with my keyboard. I'd be 
interested to know how you get on.

Also, the above will send the command to both the USB keyboard & mouse 
devices, only the mouse will respond. So worth prepending something 
like:

	if (((hdev->product == USB_DEVICE_ID_LENOVO_CUSBKBD) ||
	    (hdev->product == USB_DEVICE_ID_LENOVO_TPIIUSBKBD)) &&
	    hdev->type != HID_TYPE_USBMOUSE) {
		hid_dbg(hdev, "Ignoring keyboard half of device\n");
		return 0;
	}

...to avoid sending known-useless messages.

> +		if (ret)
> +			hid_warn(hdev, "Failed to switch middle button: %d\n",
> +				 ret);
> +		break;
> +	default:
> +		ret = 0;
> +		break;
> +	}
> +
> +	return ret;
> +}
> 
>  static const struct hid_device_id lenovo_devices[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_TPKBD) },
> @@ -1380,6 +1402,9 @@ static struct hid_driver lenovo_driver = {
>  	.raw_event = lenovo_raw_event,
>  	.event = lenovo_event,
>  	.report_fixup = lenovo_report_fixup,
> +#ifdef CONFIG_PM
> +	.reset_resume = lenovo_resume,
> +#endif
>  };
>  module_hid_driver(lenovo_driver);
