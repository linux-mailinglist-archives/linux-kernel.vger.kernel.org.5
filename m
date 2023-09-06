Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998CF7935BD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 08:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239986AbjIFG4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 02:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjIFGzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 02:55:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2AD170A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 23:55:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00EFAC433C7;
        Wed,  6 Sep 2023 06:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693983321;
        bh=Zf26d3LHnHPCdwo6hyJ0XXRfY39HmKvzvzs6PL2TM4Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CUzpFTDPOT3yfzqVKkqHTYVGmbpyHyy7baE5JthZyB4oWJNIg/RZv/T2mvQky2/k/
         dD73tGVbvtzVkILmVYC0N3l1UcpDJ727FL3GPQdfg/auqFjFGgFNIUmCNUhLSwXU8j
         b5cJ5rdWKtrb6Hf1ridOJ+M/T5MbzcE4+VTyrfp8B6VgR/86wj5C5nYyjq7EPdfal5
         tMqdtGHOR51L1vLH78aT5F2JFrxX+EkCKKr9wyQojfKj8VdWPO/dJF2HB4XjQ4H9JY
         8U9FuSn1GrOTGm7drvWyLY7sk7CUmOetj2qFohPAd1oynjcYBIIunsZPHuMH1cJTce
         Zc7KIPYUPt9kg==
MIME-Version: 1.0
Date:   Wed, 06 Sep 2023 08:55:17 +0200
From:   Michael Walle <mwalle@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 11/41] mtd: spi-nor: drop .parse_sfdp
In-Reply-To: <e7387e77-0397-4d1f-99d5-d465c63951d9@linaro.org>
References: <20230807-mtd-flash-info-db-rework-v2-0-291a0f39f8d8@kernel.org>
 <20230807-mtd-flash-info-db-rework-v2-11-291a0f39f8d8@kernel.org>
 <e7387e77-0397-4d1f-99d5-d465c63951d9@linaro.org>
Message-ID: <3ce6bedfa306afae0cbae3fcf5b3ba64@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +	{ "gd25q256", INFO(0xc84019, 0, 64 * 1024, 0)
>>  		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_TB_SR_BIT6)
>>  		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
>>  		.fixups = &gd25q256_fixups },
> 
> We might get in trouble here if SFDP advertises a wrong flash size. And
> this is because in BP, instead of relying on the info->sector_size, we
> now compute locally the sector size based on the size advertised by
> SFDP. And if the SFDP flash size is wrong, we'll break BP for this
> flash.

I'd say if the SFDP advertises a wrong flash size we are in larger
trouble than a non-working BP :)

> I'm ok taking this risk, but please update the commit message and
> inform readers about what they may hit, and what would be the fix.

sure :)

-michael

> With that feel free to add:
> 
> Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
