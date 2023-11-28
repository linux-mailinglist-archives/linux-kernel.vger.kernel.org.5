Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001677FB546
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjK1JK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbjK1JKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:10:52 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2445A1B6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 01:10:56 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id AD0F96E;
        Tue, 28 Nov 2023 10:10:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1701162654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ntqosi7UP2Do89QUaBtdH8dZHNZj7id7/4zX8GPlxF8=;
        b=zOcQi7qNp1g5i9Qydg1AuVFUJop7+nVIWhEfUCPeV3UeX/eYsQnjWILQVfO4bixDYqSwlt
        QEW4MONYK0AidoQy/cgHai6l5xrd1J8Ah8lcoEE+a2/tg7kVT0NGsOBzTfg8J/pfyTVTlD
        7jUKDNKRvTtk2IhRIkrhHLnm4kWaYnDfYckvr6gitOyHkasvUGL+mXi1A/EEQRfmzeVMcq
        8M0SNXQren7mQrlWTafTUJBQuds7vxfXVDSfGCL17e+lCFSZisusSWz0Lh9qnGt2qeBnay
        FBHA2zgvDxUROf/Y61tV8CXKhkv47bcNPELJ1icUXlmpRgWbHltFYq2n82qXkA==
MIME-Version: 1.0
Date:   Tue, 28 Nov 2023 10:10:54 +0100
From:   Michael Walle <michael@walle.cc>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>, jaimeliao.tw@gmail.com,
        jaimeliao@mxic.com.tw, pratyush@kernel.org, richard@nod.at,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: stop printing superfluous debug info
In-Reply-To: <20231128100313.3c990f69@xps-13>
References: <20231127165908.1734951-1-tudor.ambarus@linaro.org>
 <42c96d63d1ea4f7e8f16a3c8eb0a4cf1@walle.cc> <20231128100313.3c990f69@xps-13>
Message-ID: <18ba4126dbd9e49846344b517ad2fbdd@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>> > The mtd data can be obtain with the mtd ioctls and the SPI NOR
>> > flash name can be determined interrogating the sysfs entries.
>> > Stop polluting the kernel log.
>> >
>> > Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> >
>> > ---
>> >  drivers/mtd/spi-nor/core.c | 19 -------------------
>> >  1 file changed, 19 deletions(-)
>> >
>> > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>> > index 25a64c65717d..6de76fd009d1 100644
>> > --- a/drivers/mtd/spi-nor/core.c
>> > +++ b/drivers/mtd/spi-nor/core.c
>> > @@ -3517,25 +3517,6 @@ int spi_nor_scan(struct spi_nor *nor, const char > *name,
>> >  	/* No mtd_info fields should be used up to this point. */
>> >  	spi_nor_set_mtd_info(nor);
>> >
>> > -	dev_info(dev, "%s (%lld Kbytes)\n", info->name,
>> > -			(long long)mtd->size >> 10);
>> 
>> I'd lower this to dev_dbg() and print the jedec id. It might come in
>> handy for a quick glance during bootup if debug is enabled.
> 
> Ack. Although, your boot time will almost be unaffected if you don't
> print the info messages to the console. What takes the most time is not
> writing to the kernel buffer, it's to display the lines on a serial
> console, and dev_info() are by default discarded, you need to select a
> lower log level manually, and if you do that it means you're not
> looking for quick boot times but rather more for additional 
> information.

Also with recent (or planned, dunno the current state) printk won't wait
anymore for the slowest console. I really don't have a strong opinion,
either dev_info(jedec_id) or dev_dbg(jedec_id). Whatever Tudor prefers.

>> > -	dev_dbg(dev,
>> > -		"mtd .name = %s, .size = 0x%llx (%lldMiB), "
>> > -		".erasesize = 0x%.8x (%uKiB) .numeraseregions = %d\n",
>> > -		mtd->name, (long long)mtd->size, (long long)(mtd->size >> 20),
>> > -		mtd->erasesize, mtd->erasesize / 1024, mtd->numeraseregions);
>> > -
>> > -	if (mtd->numeraseregions)
>> > -		for (i = 0; i < mtd->numeraseregions; i++)
>> > -			dev_dbg(dev,
>> > -				"mtd.eraseregions[%d] = { .offset = 0x%llx, "
>> > -				".erasesize = 0x%.8x (%uKiB), "
>> > -				".numblocks = %d }\n",
>> > -				i, (long long)mtd->eraseregions[i].offset,
>> > -				mtd->eraseregions[i].erasesize,
>> > -				mtd->eraseregions[i].erasesize / 1024,
>> > -				mtd->eraseregions[i].numblocks);
>> >  	return 0;
>> 
>> Part of this is already available through the spi-nor debugfs, 
>> although not
>> the actual mtd properties. These I think, should go into the mtdcore
>> itself if really needed. Either through dev_dbg() or debugfs.
> 
> Maybe we don't need this at all, as long as one message remains about
> the JEDEC ID, but keep in mind that spi-nors are commonly storing the
> rootfs and if your spi-nor does not boot you don't have a userspace yet
> and all the debugfs entries are purely useless.

Good point.

Just curious, do you know any boards which has the rootfs writable on
the spi-nor flash?

-michael

