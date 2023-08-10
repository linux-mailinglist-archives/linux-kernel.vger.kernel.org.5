Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F664777657
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbjHJK4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbjHJK43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:56:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3531703;
        Thu, 10 Aug 2023 03:56:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B9CE60AD1;
        Thu, 10 Aug 2023 10:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46C7C433C9;
        Thu, 10 Aug 2023 10:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691664988;
        bh=VNB7J0sNStEzCd8cGx8BrhaRIe5VtMJrq9LUHaC2pkM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ikvI6GdYlwWwP/8GJbRw77QRHRO56Btg9nX8tmPKOFjCcPaWTvk5Xsii9p+xrOklm
         DnV8Hf2pc6TEolos3MzpZD/Mb3WzpTohxN0y5Ngotqt9UWUEJOjVBKRUYhkWJo2XK3
         z1cw3Yee57W+AYSKY8h4B5Pj5briru7DJKqdWj2hIjA4cERSCwZwLJ2hqMG7rdXSUH
         VUoLOfHHyNp+rETLPrBfslIZvdvZnbVjW5nxOBcy5w1wa2rlAt339D/3lmXvMSj89s
         gprIC1pZWuwbRoHGWbS9DCqRbZaxHlu98PoIsmFsIdwSuf8mRdfZOkA9aU86rGEyq+
         8bilumKeR7zQQ==
Message-ID: <beb378c1-cba4-26a0-0737-90243ec226c1@kernel.org>
Date:   Thu, 10 Aug 2023 05:56:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 4/5] clk: socfpga: agilex: add clock driver for the
 Agilex5
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, niravkumar.l.rabara@intel.com
Cc:     adrian.ho.yin.ng@intel.com, andrew@lunn.ch, conor+dt@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, netdev@vger.kernel.org,
        p.zabel@pengutronix.de, richardcochran@gmail.com,
        robh+dt@kernel.org, wen.ping.teh@intel.com
References: <20230618132235.728641-1-niravkumar.l.rabara@intel.com>
 <20230801010234.792557-1-niravkumar.l.rabara@intel.com>
 <20230801010234.792557-5-niravkumar.l.rabara@intel.com>
 <4c0dfd1c-2b61-b954-73ad-ac8d4b82487d@kernel.org>
 <677706de77d5d5b799d25c855a723b2c.sboyd@kernel.org>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <677706de77d5d5b799d25c855a723b2c.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/9/23 16:28, Stephen Boyd wrote:
> Quoting Dinh Nguyen (2023-08-08 04:03:47)
>> Hi Stephen/Mike,
>>
>> On 7/31/23 20:02, niravkumar.l.rabara@intel.com wrote:
>>> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
>>>
>>> Add support for Intel's SoCFPGA Agilex5 platform. The clock manager
>>> driver for the Agilex5 is very similar to the Agilex platform,we can
>>> re-use most of the Agilex clock driver.
>>>
>>> Signed-off-by: Teh Wen Ping <wen.ping.teh@intel.com>
>>> Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
>>> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
>>> ---
>>>    drivers/clk/socfpga/clk-agilex.c | 433 ++++++++++++++++++++++++++++++-
>>>    1 file changed, 431 insertions(+), 2 deletions(-)
>>>
>>
>> If you're ok with this patch, can I take this through armsoc?
>>
> 
> Usually any binding files go through arm-soc and clk tree but the driver
> only goes through clk tree via a PR. Is that possible here?

Ok. Should be fine in this case.

Thanks,
Dinh
