Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FD3793982
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 12:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbjIFKHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 06:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238639AbjIFKHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 06:07:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E09170E;
        Wed,  6 Sep 2023 03:07:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F05C433C8;
        Wed,  6 Sep 2023 09:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693994359;
        bh=32oaGrTGMGPijXh2U6clQsX0cT1y9TDGOJiUR+PtnLE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ut6X/waLoHK5qufwDK+m89ZkCL0v8dHC5oSylAY58+rWLIspJsDqzo7gxdyYROgfs
         VVEB4uGRR5OEgoXU/SSbCm/JtZ5mhip2b5rZRvVO1N1QTvkuy5duZ26MWVnol8Ns6f
         5CrxPJX71SuDi0qgmNKX5BV0yrG7rfe/ZnZc+mpveRPl/rC5NMclV+OkeFDi0nHLia
         9OVTqH3zjJ0/UA3HdHW/5xLzvtCNS4+x/iLBKISOkmBjq8YqpUJl45O8C0pNTloW5q
         AfiGjiG8e1w6+FvLGmGJ9MAYzs0C7eYSlCxsg8AASR0x5en0cArqHi2DN/8pkV7E3e
         M185A9rozsXtw==
Message-ID: <608ddca9-4ab8-1aef-767f-92a90e7e0970@kernel.org>
Date:   Wed, 6 Sep 2023 11:59:14 +0200
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
 <27a445d6-d904-244f-266c-ffb2d68d0e27@kernel.org>
 <1bbe7772-09f4-6c5a-8c4d-c88988b34c99@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <1bbe7772-09f4-6c5a-8c4d-c88988b34c99@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2023 18:27, Ayush Singh wrote:
>>> +static void hdlc_handle_rx_frame(struct gb_beagleplay *bg)
>>> +{
>>> +	u8 address = bg->rx_buffer[0];
>>> +	char *buffer = &bg->rx_buffer[2];
>>> +	size_t buffer_len = bg->rx_buffer_len - 4;
>>> +
>>> +	switch (address) {
>>> +	case ADDRESS_DBG:
>>> +		hdlc_handle_dbg_frame(bg, buffer, buffer_len);
>>> +		break;
>>> +	case ADDRESS_GREYBUS:
>>> +		hdlc_handle_greybus_frame(bg, buffer, buffer_len);
>>> +		break;
>>> +	default:
>>> +		dev_warn(&bg->serdev->dev, "Got Unknown Frame %u", address);
>> ratelimit
>> Probably as well in several places with possible flooding.
> 
> I don't think `hdlc_handle_rx_frame` is the correct place since it only 
> processes a single completed HDLC frame.  The more appropriate place 
> would be `hdlc_rx` if we want to limit based on the number of HDLC 
> frames or `gb_beagleplay_tty_receive` to limit based on the number of bytes.
> 
> I would like to ask, though, why is rate limiting required here? Won't 
> `serdev_device_ops->receive_buf` already rate limit the number of bytes 
> somewhat? Or is it related to blocking in the 
> `serdev_device_ops->receive_buf` callback? In the case of latter, it 
> would probably make sense to ratelimit based on number of frames, I think.

My comment might not be accurate, so I do not insist. The name of the
function suggested something being called very often (on every frame),
thus you would print warning also very often.

Best regards,
Krzysztof

