Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA637AFE24
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjI0IUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjI0ITg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:19:36 -0400
Received: from mx1.mythic-beasts.com (mx1.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF751AC;
        Wed, 27 Sep 2023 01:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lentin.co.uk; s=mythic-beasts-k1; h=Subject:To:From:Date;
        bh=Gd38sDa5ZujK2sWcQBS9UuqvWuA9QvUGhRKdOCB3Qlc=; b=d4udonc6aoZ/9t/Iz1SdVZmgTp
        7BGuzFMpJIIEZijhyKricfGClyBavtvATbYdcLK+s4Oa4F86IlpEGDjhtexb6Fw8qCN/YFW1clMoz
        eo/0Yz/B9qagNXqMHIW/61722Mjg4n4xGfy5ergJK6mYwrWp6StlZ1iYQNM0eTHbY5hRySaabgcm/
        6swo+PymYHCXhrJ9UlDs44VHVqnehtQiguJj62Pr2mmMa7Fy8xgbcZTAVtaQnrJj9IEngy9QgkqGS
        2vefchpCpAaOaytIdinlWQryy2z0gI1TlAcrHGPi8mhwk4o07knWI8D7dWQhZH/+G2arvk5IeX9+S
        ndaBsy3Q==;
Received: by mailhub-cam-d.mythic-beasts.com with esmtpa (Exim 4.94.2)
        (envelope-from <jm@lentin.co.uk>)
        id 1qlPlS-00B0N1-7J; Wed, 27 Sep 2023 09:19:22 +0100
MIME-Version: 1.0
Date:   Wed, 27 Sep 2023 09:19:04 +0100
From:   Jamie Lentin <jm@lentin.co.uk>
To:     Martin Kepplinger <martink@posteo.de>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] hid: lenovo: move type checks to
 lenovo_features_set_cptkbd()
In-Reply-To: <20230925102302.13094-2-martink@posteo.de>
References: <140b721bc345a846863a37ebf17c3174@lentin.co.uk>
 <20230925102302.13094-1-martink@posteo.de>
 <20230925102302.13094-2-martink@posteo.de>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <ef0f15c3b17ebbd58f7481910b3f40ff@lentin.co.uk>
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

On 2023-09-25 11:23, Martin Kepplinger wrote:
> These custom commands will be sent to both the USB keyboard & mouse
> devices but only the mouse will respond. Avoid sending known-useless
> messages by always prepending the filter before sending them.
> 
> Suggested-by: Jamie Lentin <jm@lentin.co.uk>
> Signed-off-by: Martin Kepplinger <martink@posteo.de>
> ---
>  drivers/hid/hid-lenovo.c | 27 +++++++++------------------
>  1 file changed, 9 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
> index 29aa6d372bad..922f3e5462f4 100644
> --- a/drivers/hid/hid-lenovo.c
> +++ b/drivers/hid/hid-lenovo.c
> @@ -521,6 +521,14 @@ static void lenovo_features_set_cptkbd(struct
> hid_device *hdev)
>  	int ret;
>  	struct lenovo_drvdata *cptkbd_data = hid_get_drvdata(hdev);
> 
> +	/* All the custom action happens on the USBMOUSE device for USB */
> +	if (((hdev->product == USB_DEVICE_ID_LENOVO_CUSBKBD) ||
> +	    (hdev->product == USB_DEVICE_ID_LENOVO_TPIIUSBKBD)) &&
> +	    hdev->type != HID_TYPE_USBMOUSE) {
> +		hid_dbg(hdev, "Ignoring keyboard half of device\n");
> +		return;
> +	}
> +
>  	/*
>  	 * Tell the keyboard a driver understands it, and turn F7, F9, F11 
> into
>  	 * regular keys
> @@ -1122,14 +1130,6 @@ static int lenovo_probe_cptkbd(struct hid_device 
> *hdev)
>  	int ret;
>  	struct lenovo_drvdata *cptkbd_data;
> 
> -	/* All the custom action happens on the USBMOUSE device for USB */
> -	if (((hdev->product == USB_DEVICE_ID_LENOVO_CUSBKBD) ||
> -	    (hdev->product == USB_DEVICE_ID_LENOVO_TPIIUSBKBD)) &&
> -	    hdev->type != HID_TYPE_USBMOUSE) {
> -		hid_dbg(hdev, "Ignoring keyboard half of device\n");
> -		return 0;
> -	}
> -

I like the idea of doing it once then forgetting about it, but removing 
this will mean that the "keyboard half" will have it's own set of 
non-functional sysfs parameters I think? Currently:-

# evtest
   . . .
/dev/input/event10:     ThinkPad Compact Bluetooth Keyboard with 
TrackPoint
/dev/input/event11:     Lenovo ThinkPad Compact USB Keyboard with 
TrackPoint
/dev/input/event12:     Lenovo ThinkPad Compact USB Keyboard with 
TrackPoint

# ls -1 /sys/class/input/event*/device/device/fn_lock
/sys/class/input/event10/device/device/fn_lock
/sys/class/input/event12/device/device/fn_lock

(note 11 is missing.)

I think the easiest (but ugly) thing to do is to copy-paste this lump of 
code to the top of lenovo_reset_resume.

Cheers,

>  	cptkbd_data = devm_kzalloc(&hdev->dev,
>  					sizeof(*cptkbd_data),
>  					GFP_KERNEL);
> @@ -1264,16 +1264,7 @@ static int lenovo_probe(struct hid_device *hdev,
>  #ifdef CONFIG_PM
>  static int lenovo_reset_resume(struct hid_device *hdev)
>  {
> -	switch (hdev->product) {
> -	case USB_DEVICE_ID_LENOVO_CUSBKBD:
> -		if (hdev->type == HID_TYPE_USBMOUSE) {
> -			lenovo_features_set_cptkbd(hdev);
> -		}
> -
> -		break;
> -	default:
> -		break;
> -	}
> +	lenovo_features_set_cptkbd(hdev);
> 
>  	return 0;
>  }
