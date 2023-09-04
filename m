Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9307911EE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbjIDHTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjIDHTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:19:37 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9924999;
        Mon,  4 Sep 2023 00:19:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B2076CE0E26;
        Mon,  4 Sep 2023 07:19:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16765C433C8;
        Mon,  4 Sep 2023 07:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693811969;
        bh=kLhgyFa69yyZtHTyoV3KOFbc551E0bFb3ERUll9YW58=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DZmFkAZcvoDkeL/By6eogWispdgZGCHqReFtOuRFvOLgX4iDsCUqzJs7ngl40B4Jn
         jtkgCQkVUuABisv5zoT/7WnxZzwqFrSP2bloiO+FvwPyRfKGkaq5ydk+o4sS/bAfmh
         o0Rkn4anv1XSoxmqSQuwp4TPvBH+lUcmsDNxIGTg8tWhGnefK8g8nXcuXmTWMs5zpL
         s9ejPuX8hV7it0DdlC6BZmZJhdsCJjsYBg6aVomauv9lp8/MsDH7dOr4QEQ12k1lzo
         vTmuyfRp2+qTpLkRwoJmiPHqiS0B+BH+x3iNj6+41AOjUTVYKuOjM2njazBESEAWFd
         mmLw/eccZgapg==
Message-ID: <27a445d6-d904-244f-266c-ffb2d68d0e27@kernel.org>
Date:   Mon, 4 Sep 2023 09:19:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 2/3] greybus: Add BeaglePlay Linux Driver
Content-Language: en-US
To:     Ayush Singh <ayushdevel1325@gmail.com>,
        greybus-dev@lists.linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org,
        Vaishnav M A <vaishnav@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Nishanth Menon <nm@ti.com>
References: <20230902182845.1840620-1-ayushdevel1325@gmail.com>
 <20230902182845.1840620-3-ayushdevel1325@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230902182845.1840620-3-ayushdevel1325@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/2023 20:28, Ayush Singh wrote:
> Add the Greybus host driver for BeaglePlay board by BeagleBoard.org.
> 
> The current greybus setup involves running SVC in a user-space
> application (GBridge) and using netlink to communicate with kernel
> space. GBridge itself uses wpanusb kernel driver, so the greybus messages
> travel from kernel space (gb_netlink) to user-space (GBridge) and then
> back to kernel space (wpanusb) before reaching CC1352.
> 
> This driver directly communicates with CC1352 (running SVC Zephyr
> application). Thus, it simplifies the complete greybus setup eliminating
> user-space GBridge.
> 
> This driver is responsible for the following:
> - Start SVC (CC1352) on driver load.
> - Send/Receive Greybus messages to/from CC1352 using HDLC over UART.
> - Print Logs from CC1352.
> - Stop SVC (CC1352) on driver load.
> 
> Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
> ---
>  MAINTAINERS                     |   1 +
>  drivers/greybus/Kconfig         |  10 +
>  drivers/greybus/Makefile        |   3 +-
>  drivers/greybus/gb-beagleplay.c | 494 ++++++++++++++++++++++++++++++++
>  4 files changed, 507 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/greybus/gb-beagleplay.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9d1b49a6dfad..3cbf2c87fb14 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8974,6 +8974,7 @@ M:	Ayush Singh <ayushdevel1325@gmail.com>
>  L:	greybus-dev@lists.linaro.org (moderated for non-subscribers)
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/serial/beaglecc1352.yaml
> +F:	drivers/greybus/gb-beagleplay.c
>  
>  GREYBUS SUBSYSTEM
>  M:	Johan Hovold <johan@kernel.org>
> diff --git a/drivers/greybus/Kconfig b/drivers/greybus/Kconfig
> index 78ba3c3083d5..62f091368272 100644
> --- a/drivers/greybus/Kconfig
> +++ b/drivers/greybus/Kconfig
> @@ -28,5 +28,15 @@ config GREYBUS_ES2
>  	  To compile this code as a module, choose M here: the module
>  	  will be called gb-es2.ko
>  
> +config GREYBUS_BEAGLEPLAY

B shouild be before E. Keep things ordered, usually by name, do not add
stuff at the end.

> +	tristate "Greybus BeaglePlay driver"
> +	depends on TTY
> +	help
> +	  Select this option if you have a BeaglePlay where CC1352
> +		co-processor acts as Greybus SVC.
> +
> +	  To compile this code as a module, chose M here: the module
> +	  will be called gb-beagleplay.ko
> +
>  endif	# GREYBUS
>  
> diff --git a/drivers/greybus/Makefile b/drivers/greybus/Makefile
> index 9bccdd229aa2..63f9cb3b2df0 100644
> --- a/drivers/greybus/Makefile
> +++ b/drivers/greybus/Makefile
> @@ -23,4 +23,5 @@ gb-es2-y := es2.o
>  
>  obj-$(CONFIG_GREYBUS_ES2)	+= gb-es2.o
>  
> -
> +# Beagleplay Greybus driver

Drop useless comment

> +obj-$(CONFIG_GREYBUS_BEAGLEPLAY)	+= gb-beagleplay.o

Keep things ordered, usually by name, do not add stuff at the end.


...

> +/* The maximum number of CPorts supported by Greybus Host Device */
> +#define BEAGLEPLAY_GB_MAX_CPORTS 32
> +
> +static const struct of_device_id gb_beagleplay_of_match[] = {
> +	{
> +		.compatible = "beagle,cc1352",
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, gb_beagleplay_of_match);

The entire structure should be next to probe, not at beginning of file.

> +

...

> +static void hdlc_handle_rx_frame(struct gb_beagleplay *bg)
> +{
> +	u8 address = bg->rx_buffer[0];
> +	char *buffer = &bg->rx_buffer[2];
> +	size_t buffer_len = bg->rx_buffer_len - 4;
> +
> +	switch (address) {
> +	case ADDRESS_DBG:
> +		hdlc_handle_dbg_frame(bg, buffer, buffer_len);
> +		break;
> +	case ADDRESS_GREYBUS:
> +		hdlc_handle_greybus_frame(bg, buffer, buffer_len);
> +		break;
> +	default:
> +		dev_warn(&bg->serdev->dev, "Got Unknown Frame %u", address);

ratelimit
Probably as well in several places with possible flooding.

> +	}
> +}
> +
> +static void hdlc_transmit(struct work_struct *work)
> +{
> +	struct gb_beagleplay *bg =
> +		container_of(work, struct gb_beagleplay, tx_work);
> +
> +	spin_lock_bh(&bg->tx_consumer_lock);
> +	hdlc_write(bg);
> +	spin_unlock_bh(&bg->tx_consumer_lock);
> +}
> +
> +static void hdlc_send_async(struct gb_beagleplay *bg, u8 address, u8 control,
> +			    const struct hdlc_payload payloads[], size_t count)
> +{
> +	size_t i;
> +
> +	/* HDLC_FRAME

Use Linux style of comments:
/*
 * foo bar

> +	 * 0 address : 0x01
> +	 * 1 control : 0x03
> +	 * contents
> +	 * x/y crc
> +	 * HDLC_FRAME
> +	 */
> +
> +	spin_lock(&bg->tx_producer_lock);
> +
> +	hdlc_append_tx_frame(bg);
> +	hdlc_append_tx_u8(bg, address);
> +	hdlc_append_tx_u8(bg, control);
> +	for (i = 0; i < count; ++i) {
> +		hdlc_append_tx_buffer(bg, payloads[i].payload,
> +				      payloads[i].length);
> +	}
> +	hdlc_append_tx_crc(bg);
> +	hdlc_append_tx_frame(bg);
> +
> +	spin_unlock(&bg->tx_producer_lock);
> +
> +	schedule_work(&bg->tx_work);
> +}
> +
> +static void hdlc_send_s_frame_ack(struct gb_beagleplay *bg)
> +{
> +	hdlc_send_async(bg, bg->rx_buffer[0], (bg->rx_buffer[1] >> 1) & 0x7,
> +			NULL, 0);
> +}
> +
> +static int hdlc_rx(struct gb_beagleplay *bg, const u8 *data, size_t count)
> +{
> +	u16 crc_check;
> +	size_t i;
> +	u8 c, ctrl;
> +
> +	for (i = 0; i < count; ++i) {
> +		c = data[i];
> +
> +		switch (c) {
> +		case HDLC_FRAME:
> +			if (bg->rx_buffer_len) {
> +				crc_check = crc_ccitt(0xffff, bg->rx_buffer,
> +						      bg->rx_buffer_len);
> +				if (crc_check == 0xf0b8) {
> +					ctrl = bg->rx_buffer[1];
> +					if ((ctrl & 1) == 0) {
> +						/* I-Frame, send S-Frame ACK */
> +						hdlc_send_s_frame_ack(bg);
> +					}
> +					hdlc_handle_rx_frame(bg);
> +				} else {
> +					dev_err(&bg->serdev->dev,
> +						"CRC Failed from %02x: 0x%04x",
> +						bg->rx_buffer[0], crc_check);
> +				}
> +			}
> +			bg->rx_buffer_len = 0;
> +			break;
> +		case HDLC_ESC:
> +			bg->rx_in_esc = 1;
> +			break;
> +		default:
> +			if (bg->rx_in_esc) {
> +				c ^= 0x20;
> +				bg->rx_in_esc = 0;
> +			}
> +
> +			if (bg->rx_buffer_len < MAX_RX_HDLC) {
> +				bg->rx_buffer[bg->rx_buffer_len] = c;
> +				bg->rx_buffer_len++;
> +			} else {
> +				dev_err(&bg->serdev->dev, "RX Buffer Overflow");
> +				bg->rx_buffer_len = 0;
> +			}
> +		}
> +	}
> +
> +	return count;
> +}
> +
> +static void hdlc_init(struct gb_beagleplay *bg)
> +{
> +	INIT_WORK(&bg->tx_work, hdlc_transmit);
> +	spin_lock_init(&bg->tx_producer_lock);
> +	spin_lock_init(&bg->tx_consumer_lock);
> +	bg->tx_circ_buf.head = 0;
> +	bg->tx_circ_buf.tail = 0;
> +	bg->tx_circ_buf.buf =
> +		devm_kmalloc(&bg->serdev->dev, TX_CIRC_BUF_SIZE, GFP_KERNEL);
> +	bg->rx_buffer_len = 0;
> +	bg->rx_in_esc = 0;
> +}
> +
> +static void hdlc_deinit(struct gb_beagleplay *bg)
> +{
> +	flush_work(&bg->tx_work);
> +}
> +
> +static int gb_beagleplay_tty_receive(struct serdev_device *serdev,
> +				     const unsigned char *data, size_t count)
> +{
> +	struct gb_beagleplay *bg = serdev_device_get_drvdata(serdev);
> +
> +	return hdlc_rx(bg, data, count);
> +}
> +
> +static void beagleplay_greybus_tty_wakeup(struct serdev_device *serdev)
> +{
> +	struct gb_beagleplay *bg = serdev_device_get_drvdata(serdev);
> +
> +	schedule_work(&bg->tx_work);
> +}
> +
> +static struct serdev_device_ops gb_beagleplay_ops = {
> +	.receive_buf = gb_beagleplay_tty_receive,
> +	.write_wakeup = beagleplay_greybus_tty_wakeup,
> +};
> +
> +static int gb_message_send(struct gb_host_device *hd, u16 cport_id,
> +			   struct gb_message *msg, gfp_t gfp_mask)
> +{
> +	struct gb_beagleplay *bg = dev_get_drvdata(&hd->dev);
> +	struct hdlc_payload payloads[2];
> +
> +	dev_dbg(&hd->dev,
> +		"Sending Greybus message with Operation %u, Type: %X on Cport %u",
> +		msg->header->operation_id, msg->header->type, cport_id);
> +
> +	if (msg->header->size > RX_HDLC_PAYLOAD) {
> +		dev_err(&hd->dev, "Greybus message too big");
> +		return -E2BIG;
> +	}
> +
> +	memcpy(msg->header->pad, &cport_id, sizeof(cport_id));
> +
> +	payloads[0].payload = msg->header;
> +	payloads[0].length = sizeof(*msg->header);
> +	payloads[1].payload = msg->payload;
> +	payloads[1].length = msg->payload_size;
> +
> +	hdlc_send_async(bg, ADDRESS_GREYBUS, 0x03, payloads, 2);
> +	greybus_message_sent(bg->gb_host_device, msg, 0);
> +
> +	return 0;
> +}
> +
> +static void gb_message_cancel(struct gb_message *message)
> +{
> +}
> +
> +static struct gb_hd_driver gb_hdlc_driver = { .message_send = gb_message_send,
> +					      .message_cancel =
> +						      gb_message_cancel };
> +
> +static void gb_beagleplay_start_svc(struct gb_beagleplay *bg)
> +{
> +	const u8 command = CONTROL_SVC_START;
> +	const struct hdlc_payload payload = { .length = 1,
> +					      .payload = (void *)&command };
> +
> +	hdlc_send_async(bg, ADDRESS_CONTROL, 0x03, &payload, 1);
> +}
> +
> +static void gb_beagleplay_stop_svc(struct gb_beagleplay *bg)
> +{
> +	const u8 command = CONTROL_SVC_STOP;
> +	const struct hdlc_payload payload = { .length = 1,
> +					      .payload = (void *)&command };
> +
> +	hdlc_send_async(bg, ADDRESS_CONTROL, 0x03, &payload, 1);
> +}
> +
> +static int gb_beagleplay_probe(struct serdev_device *serdev)
> +{
> +	u32 speed = 115200;
> +	int ret = 0;
> +	struct gb_beagleplay *bg =
> +		devm_kmalloc(&serdev->dev, sizeof(*bg), GFP_KERNEL);
> +
> +	if (!bg) {
> +		dev_err(&serdev->dev, "Failed to allocate driver");

Nope. Run coccinelle. None of the code in the kernel drivers prints
error messages for allocation failures.

> +		return -ENOMEM;
> +	}
> +
> +	bg->serdev = serdev;
> +	serdev_device_set_drvdata(serdev, bg);
> +	serdev_device_set_client_ops(serdev, &gb_beagleplay_ops);
> +	ret = serdev_device_open(serdev);
> +	if (ret) {
> +		dev_err(&bg->serdev->dev, "Unable to Open Device");

return dev_err_probe

> +		return ret;
> +	}
> +	speed = serdev_device_set_baudrate(serdev, speed);
> +	dev_info(&bg->serdev->dev, "Using baudrate %u", speed);
> +	serdev_device_set_flow_control(serdev, false);
> +
> +	hdlc_init(bg);
> +
> +	/* Greybus setup */
> +	bg->gb_host_device = gb_hd_create(&gb_hdlc_driver, &serdev->dev,
> +					  TX_CIRC_BUF_SIZE,
> +					  BEAGLEPLAY_GB_MAX_CPORTS);
> +	if (IS_ERR(bg->gb_host_device)) {
> +		dev_err(&bg->serdev->dev,
> +			"Unable to create Greybus Host Device");
> +		ret = -1;

ret = PTR_ERR, not some random number.

> +		goto free_hdlc;
> +	}
> +	ret = gb_hd_add(bg->gb_host_device);
> +	if (ret) {
> +		dev_err(&serdev->dev, "Failed to add Greybus Host Device");
> +		goto free_gb_hd;
> +	}
> +	dev_set_drvdata(&bg->gb_host_device->dev, bg);
> +
> +	gb_beagleplay_start_svc(bg);
> +
> +	dev_info(&bg->serdev->dev, "Successful Beagleplay Greybus Probe");


Drop silly tracing messages.

> +
> +	return 0;
> +
> +free_gb_hd:
> +	gb_hd_del(bg->gb_host_device);
> +	gb_hd_put(bg->gb_host_device);
> +free_hdlc:
> +	hdlc_deinit(bg);
> +	serdev_device_close(serdev);
> +	return ret;
> +}
> +
> +static void gb_beagleplay_remove(struct serdev_device *serdev)
> +{
> +	struct gb_beagleplay *beagleplay_greybus =
> +		serdev_device_get_drvdata(serdev);
> +
> +	dev_info(&beagleplay_greybus->serdev->dev,
> +		 "Remove BeaglePlay Greybus Driver");

Drop silly tracing messages.

> +
> +	gb_hd_del(beagleplay_greybus->gb_host_device);
> +	gb_hd_put(beagleplay_greybus->gb_host_device);
> +
> +	gb_beagleplay_stop_svc(beagleplay_greybus);
> +
> +	hdlc_deinit(beagleplay_greybus);
> +
> +	serdev_device_close(serdev);
> +}
> +
> +static struct serdev_device_driver gb_beagleplay_driver = {
> +	.probe = gb_beagleplay_probe,
> +	.remove = gb_beagleplay_remove,
> +	.driver = {
> +	      .name = "gb_beagleplay",
> +	      .of_match_table = of_match_ptr(gb_beagleplay_of_match),

Drop of_match_ptr(). You will have warnings.


Best regards,
Krzysztof

