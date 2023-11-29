Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007DC7FD77A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbjK2NFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbjK2NFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:05:35 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4524C4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:05:40 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id EDBDD957;
        Wed, 29 Nov 2023 14:05:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1701263138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9SblSzxpofP2hDrymhDMMQF3FF11knUQb/jaSOSo4hs=;
        b=XstcDe19tFQavza0YkuDOsi5A1Nkc0sWNOZ6/PKIHKXkXD0wg8LTdG0mrkFjtSRYTLUo/e
        BcCWwOHkYXojQ+mn4FYxzkhi9I9uPvTsy/SUib0pqM5zlpeSOM9iUF3lQ4f1EkZ8Irmjd2
        nhOG4inXoL83qTSWoGmTnQLP3DpEFZwWQh3yCfTpuK3+8PLROuH8a0QyBoOCk+lJajwyij
        Qwp9mwFkaDefICLh/khHIRCMB700lNrUdHmtraYbMJdWDPSDrkLIiWbuUA/i8uqzdIW66u
        YPL4Ee0PfRMmVKmsh33oVA5zE2+wirxgKk//2N0B8niXpwE2SAKrt8XQCHii3w==
MIME-Version: 1.0
Date:   Wed, 29 Nov 2023 14:05:37 +0100
From:   Michael Walle <michael@walle.cc>
To:     "Boyapally, Srikanth" <Srikanth.Boyapally@amd.com>
Cc:     Pratyush Yadav <pratyush@kernel.org>, tudor.ambarus@linaro.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: Re: [PATCH] mtd: spi-nor: issi: Add support for is25lp02g
In-Reply-To: <BN9PR12MB5196EF2D4EFF36F6FCD7BDC19E83A@BN9PR12MB5196.namprd12.prod.outlook.com>
References: <20231123054713.361101-1-srikanth.boyapally@amd.com>
 <mafs0jzq7dx8l.fsf@kernel.org>
 <BN9PR12MB51966705C3E306502ABABA6E9EBCA@BN9PR12MB5196.namprd12.prod.outlook.com>
 <6342ad8a798ef811d37775b7269623a3@walle.cc>
 <BN9PR12MB5196EF2D4EFF36F6FCD7BDC19E83A@BN9PR12MB5196.namprd12.prod.outlook.com>
Message-ID: <542998283b464d19fa5f354898de79df@walle.cc>
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

>> >> > Add support for issi is25lp02g.
>> >> >
>> >> > Verified on AMD-Xilinx versal platform and executed mtd_debug
>> >> > read/write test.
>> >> >
>> >> > Signed-off-by: Srikanth Boyapally <srikanth.boyapally@amd.com>
>> >>
>> >> Based on a datasheet [0] I found online, this flash seems to have
>> >> SFDP.
>> >> And since you do not add any flash specific fixups, it likely does
>> >> not need an entry and would work fine with the generic flash driver.
>> >> Did you try using that? See [1] for more info on contribution
>> >> guidelines.
>> >>
>> >> [0] https://www.issi.com/WW/pdf/25LP-WP02GG.pdf
>> >> [1] https://lore.kernel.org/linux-mtd/20231123160721.64561-2-
>> >> tudor.ambarus@linaro.org/
>> >>
>> > I ran mtd_debug read/write tests on this flash, without adding flash
>> > entry, it worked fine for me. Please ignore this patch.
>> 
>> Great! Could you please still dump and post your SFDP just for us to 
>> have more
>> SFDP of diferent flashes? See [1].
>> 
> SFDP dump:
> versal-generic:/home/petalinux# hexdump -C 
> /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
> 00000000  53 46 44 50 06 01 01 ff  00 06 01 10 30 00 00 ff  
> |SFDP........0...|
> 00000010  84 00 01 02 80 00 00 ff  ff ff ff ff ff ff ff ff  
> |................|
> 00000020  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
> |................|
> 00000030  e5 20 fb ff ff ff ff 7f  44 eb 08 6b 08 3b 80 bb  |. 
> ......D..k.;..|
> 00000040  fe ff ff ff ff ff 00 ff  ff ff 44 eb 0c 20 0f 52  
> |..........D.. .R|
> 00000050  10 d8 00 ff 62 42 a9 00  82 64 02 e2 ec 8d 69 4c  
> |....bB...d....iL|
> 00000060  7a 75 7a 75 f7 a2 d5 5c  4a c2 2c ff e8 30 fa a9  
> |zuzu...\J.,..0..|
> 00000070  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
> |................|
> 00000080  ff ee ff ff 21 5c dc ff                           |....!\..|
> 00000088

Thanks!

-michael
