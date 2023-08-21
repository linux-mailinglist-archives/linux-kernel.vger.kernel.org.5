Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A5E7825D3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 10:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbjHUIvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 04:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234183AbjHUIvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 04:51:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF77BF;
        Mon, 21 Aug 2023 01:51:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 133B76156C;
        Mon, 21 Aug 2023 08:51:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B012C433AD;
        Mon, 21 Aug 2023 08:51:13 +0000 (UTC)
Message-ID: <67a1657a-e8f4-683c-375d-5ca6b1e75b9a@xs4all.nl>
Date:   Mon, 21 Aug 2023 10:51:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 5/9] media: cros-ec-cec: Support multiple ports in MKBP
 cec_events
Content-Language: en-US, nl
To:     Reka Norman <rekanorman@chromium.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Stefan Adolfsson <sadolfsson@google.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
References: <20230814043140.1108917-1-rekanorman@chromium.org>
 <20230814043140.1108917-6-rekanorman@chromium.org>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230814043140.1108917-6-rekanorman@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reka,

On 14/08/2023 06:29, Reka Norman wrote:
> Use the top four bits of the cec_events MKBP event to store the port
> number.
> 
> Signed-off-by: Reka Norman <rekanorman@chromium.org>
> ---
> 
>  drivers/media/cec/platform/cros-ec/cros-ec-cec.c | 13 +++++++++++--
>  include/linux/platform_data/cros_ec_commands.h   | 10 ++++++++++
>  2 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
> index d674a432dfdd..eb4b778f83e9 100644
> --- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
> +++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
> @@ -77,8 +77,17 @@ static void handle_cec_message(struct cros_ec_cec *cros_ec_cec)
>  static void handle_cec_event(struct cros_ec_cec *cros_ec_cec)
>  {
>  	struct cros_ec_device *cros_ec = cros_ec_cec->cros_ec;
> -	uint32_t events = cros_ec->event_data.data.cec_events;
> -	struct cros_ec_cec_port *port = cros_ec_cec->ports[CEC_PORT];
> +	uint32_t cec_events = cros_ec->event_data.data.cec_events;
> +	int port_num = EC_MKBP_EVENT_CEC_GET_PORT(cec_events);
> +	uint32_t events = EC_MKBP_EVENT_CEC_GET_EVENTS(cec_events);
> +	struct cros_ec_cec_port *port;
> +
> +	if (port_num < 0 || port_num >= cros_ec_cec->num_ports) {

Since cec_events is unsigned, then I would also keep port_num unsigned.
Mixing signed and unsigned for bit shifting is a bit dangerous.

That will also mean that you can skip the 'port_num < 0' check.

Regards,

	Hans

> +		dev_err(cros_ec->dev,
> +			"received CEC event for invalid port %d\n", port_num);
> +		return;
> +	}
> +	port = cros_ec_cec->ports[port_num];
>  
>  	if (events & EC_MKBP_CEC_SEND_OK)
>  		cec_transmit_attempt_done(port->adap, CEC_TX_STATUS_OK);
> diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
> index 9a0c6e28f370..b7e8573a8a49 100644
> --- a/include/linux/platform_data/cros_ec_commands.h
> +++ b/include/linux/platform_data/cros_ec_commands.h
> @@ -4440,6 +4440,16 @@ struct ec_response_i2c_passthru_protect {
>  
>  #define MAX_CEC_MSG_LEN 16
>  
> +/*
> + * Helper macros for packing/unpacking cec_events.
> + * bits[27:0] : bitmask of events from enum mkbp_cec_event
> + * bits[31:28]: port number
> + */
> +#define EC_MKBP_EVENT_CEC_PACK(events, port) \
> +		(((events) & GENMASK(27, 0)) | (((port) & 0xf) << 28))
> +#define EC_MKBP_EVENT_CEC_GET_EVENTS(event) ((event) & GENMASK(27, 0))
> +#define EC_MKBP_EVENT_CEC_GET_PORT(event) (((event) >> 28) & 0xf)
> +
>  /* CEC message from the AP to be written on the CEC bus */
>  #define EC_CMD_CEC_WRITE_MSG 0x00B8
>  

