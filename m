Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA0575BFFD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjGUHlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 03:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjGUHln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:41:43 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4AC2D60
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 00:41:39 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 48D9B5E6;
        Fri, 21 Jul 2023 09:41:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1689925297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/UbQmHU+C8ZYTtOIH5DrZDvSS0VGEOCXbjcqDQfVMMk=;
        b=ec8UShmMSCqWSZdwrUdestLBa1aY+puNKY6Q+ISwqSp6LCo4TXtaDUIV6AxsCkzcTi5mi1
        ey7N7Ao9GIlcJ5o3MHsCAgCf7ZqG4/QHLc45LjLV4rStdMfzk5LHHXGYFise82Z8158406
        bkNgaTo6Ly+OTGCkh9ZUTx9u4KbIeI3xYpSmvRPbDSoI67YW2nsNpmQ12qtBEQSMVm5rd1
        gJp4H5FRdNVBciThmzH2UxbA1yOhVidDlYTFLeq0bVatNi0gHpt7aJ2xwcgzbUHb2wDQX6
        irAm029PY54kUU0yyz/O47jHA6Rq98YRFBYB/MQimJsnxGifJKraYyeBb4BbFA==
MIME-Version: 1.0
Date:   Fri, 21 Jul 2023 09:41:36 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     Vlim <vlim@gigadevice.com>, pratyush@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        akumarma@amd.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, vikhyat.goyal@amd.com
Subject: Re: [PATCH V1 1/1] linux: drivers: mtd: spi-nor: gigadevice.c
In-Reply-To: <130b3742-fe0b-2030-654f-0cf8863c1479@linaro.org>
References: <20230720042834.12296-1-vlim@gigadevice.com>
 <62663146a51c2beac4eff48abe1f61f8@walle.cc>
 <TY0PR06MB56580D3FEE55389F41E33398BB3EA@TY0PR06MB5658.apcprd06.prod.outlook.com>
 <55d60aec-3b20-d9d3-aeb2-77abbcc47d16@linaro.org>
 <TY0PR06MB56581B9A28DCD7A7270CFC0ABB3FA@TY0PR06MB5658.apcprd06.prod.outlook.com>
 <130b3742-fe0b-2030-654f-0cf8863c1479@linaro.org>
Message-ID: <3795b6594981a236481f70f9172d140b@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> 
>> { "gd25q128", INFO(0xc84018, 0, 64 * 1024, 256)
>>             FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
> 
> The locking support is not part of the JEDEC SFDP standard, but vendors
> can define their own SFDP tables where they describe the locking
> support. So for now, if you want to enable locking you have to specify
> the locking flags, whatever they are. There are different flavors of
> block protection locking, with 3 or 4 block protection bits, their
> order, etc. You'll have to check the datasheet.

I've seen that gigadevice has their own proprietary SFDP table which
also indicates locking. I'd prefer to have a parser for these, esp.
because the patch is coming from the vendor itself :)

-michael
