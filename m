Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675997578BC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 12:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjGRKBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 06:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbjGRKBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 06:01:06 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B9B116;
        Tue, 18 Jul 2023 03:01:02 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 4A2363BE;
        Tue, 18 Jul 2023 12:01:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1689674460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TliMGa/AjS5CE9Jf6SZ3Vzpj2EtgwzwZjg72TLl0zqM=;
        b=1tZ25vKAwvmo1bgrRHA025NmOefVDb6pIPqUrbYMERVCHhTLbGXhBFrA0BGs7RgMtOirHD
        3zMKlXEtVvZGO/pQaKbZMrgkr5vfgduAnYedFZJXCCmfAvkNZlL3/aqxD1eEsBvZ/V9tHm
        oWV1nY3Og16O8NvQ1K5Iycqnz4LoIRGM3LggtBwF8LDXzGYn/36SovjHQdsyqu4Nl4iLq3
        DqYoTFqzSWS4Py5HODIvrWQkSGOEXd1fq2DB8OA3zZqN2O8koZKgNfUsAWSsfZsHOQ0RPq
        Zo18n8Z3vl2RRYF2cwzIqxFq1yzoEBsZuM0V2vky8MIsGC+GKpiXXO5GcMZrAA==
MIME-Version: 1.0
Date:   Tue, 18 Jul 2023 12:01:00 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, saikrishna12468@gmail.com,
        git@amd.com
Subject: Re: [PATCH 0/3] spi: spi-cadence-quadspi: Add Rx tuning support for
 DTR mode
In-Reply-To: <67e1d3af-d106-bd5c-f8d8-3f43a58975a0@linaro.org>
References: <20230207060924.265789-1-sai.krishna.potthuri@amd.com>
 <67e1d3af-d106-bd5c-f8d8-3f43a58975a0@linaro.org>
Message-ID: <85d8e122a236818b162b64b473a3fdc4@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-02-07 07:48, schrieb Tudor Ambarus:
> On 2/7/23 06:09, Sai Krishna Potthuri wrote:
>> Enable PHY and DQS required for Xilinx Versal Octal SPI to operate in 
>> DTR
>> protocol.
>> Add and update device_id field in spi_mem structure with flash id
>> information. Xilinx Versal Octal SPI driver requires the device id
>> information to perform the Rx tuning operation. Since there is no 
>> common
>> Tuning Data Pattern defined across all vendors, controllers like 
>> Xilinx
>> Versal Octal SPI which requires Rx tuning to find out the optimal 
>> sampling
>> point for data lines, this device id information will be used as a 
>> golden
>> data.
> 
> Using only 6 bytes as golden pattern seems fragile, but you are aware 
> of
> that, as I see that you chose to read the ID 10 times to make the
> decision whether the tap is valid or not. Other option (which is not
> perfect) is to use SFDP data as golden pattern. If I remember
> correctly, JESD216 suggests to use the Read SFDP cmd at 50 MHz, so it
> won't help you much. In practice SPI NOR uses the Read SFDP command at
> the flash's maximum speed and we haven't seen problems. But better 
> would
> be to use some flash OTP data maybe? I remember Pratyush has submitted 
> a
> phy calibration series in the past, I haven't had the chance to read 
> his
> proposal. Did you? How's your proposal different than his?

And its not 6 bytes.. it's usually only three. The last three bytes will
probably be undefined. So the might return ff or just wrap around and
return the first three bytes again.

Is there a datasheet where you can read how the calibration is done? Is 
this
the same for all i/o pads or individual per i/o pad?

I cannot see where the op to read the id is coming from. Are you relying
on the fact that a RDID is the first command which gets executed. If so,
please don't.

Do you calibrate only one pad? RDID (9f) is  single bit i/o, right? And
I guess you are calibrating with the highest frequency, are
we sure that RDID will work with any frequency (on any flash).


>> The reason behind choosing this approach instead of reading the ID 
>> again
>> in the controller driver is to make it generic solution.
>> - Other controller drivers which want to use similar tuning process, 
>> they
>> will make use of this ID instead of reading the ID again in the 
>> driver.

Honestly, I'm not sure this is the way to go. Pratyush proposed solution
to have a dedicated memory area within the flash array with a know 
pattern
seems to make more sense, because you are calibrating on the thing you 
are going
to use later, that is quad/ocal read with the fastest frequency.

>> - Also, we can avoid hardcoding the command information and initiating 
>> the
>> transfer in the controller driver as this should happen from spi-nor.

So how you know that this is a RDID instruction?

-michael
