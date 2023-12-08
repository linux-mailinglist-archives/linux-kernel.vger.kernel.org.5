Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4221380A2C6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 13:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbjLHMEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 07:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbjLHMEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 07:04:43 -0500
Received: from 11.mo584.mail-out.ovh.net (11.mo584.mail-out.ovh.net [46.105.34.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBDCD59
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 04:04:48 -0800 (PST)
Received: from director9.ghost.mail-out.ovh.net (unknown [10.109.156.194])
        by mo584.mail-out.ovh.net (Postfix) with ESMTP id B2211276AF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 11:25:08 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-7kq9l (unknown [10.110.171.110])
        by director9.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 1973A1FE8D;
        Fri,  8 Dec 2023 11:25:08 +0000 (UTC)
Received: from RCM-web1.webmail.mail.ovh.net ([176.31.238.120])
        by ghost-submission-6684bf9d7b-7kq9l with ESMTPSA
        id hpf6AxT9cmXqjQAAh0gf5A
        (envelope-from <rafal@milecki.pl>); Fri, 08 Dec 2023 11:25:08 +0000
MIME-Version: 1.0
Date:   Fri, 08 Dec 2023 12:25:07 +0100
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>
Subject: Re: [PATCH V3] nvmem: brcm_nvram: store a copy of NVRAM content
In-Reply-To: <29d2f463-90c2-4c96-8828-96806679db8e@linaro.org>
References: <20231102062848.23965-1-zajec5@gmail.com>
 <29d2f463-90c2-4c96-8828-96806679db8e@linaro.org>
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <7cb70a8ead5f6b74f0a287ac8832873c@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 31.11.218.106
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 18236200791980485615
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudekiedgvdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvvefujghffgfkgihitgfgsehtkehjtddtreejnecuhfhrohhmpeftrghfrghlucfoihhlvggtkhhiuceorhgrfhgrlhesmhhilhgvtghkihdrphhlqeenucggtffrrghtthgvrhhnpefghfeuiefhiedttedtheefhfeifeffveekvdegteetkeetjedtiedvvdfhgfffffenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvdejrddtrddtrddupdefuddruddurddvudekrddutdeipddujeeirdefuddrvdefkedruddvtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehrrghfrghlsehmihhlvggtkhhirdhplheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkeegpdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-08 12:15, Srinivas Kandagatla wrote:
> Thank you for the patch,
> 
> On 02/11/2023 06:28, Rafał Miłecki wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>> 
>> This driver uses MMIO access for reading NVRAM from a flash device.
>> Underneath there is a flash controller that reads data and provides
>> mapping window.
>> 
>> Using MMIO interface affects controller configuration and may break 
>> real
>> controller driver. It was reported by multiple users of devices with
>> NVRAM stored on NAND.
>> 
>> Modify driver to read & cache NVRAM content during init and use that
>> copy to provide NVMEM data when requested. On NAND flashes due to 
>> their
>> alignment NVRAM partitions can be quite big (1 MiB and more) while
>> actual NVRAM content stays quite small (usually 16 to 32 KiB). To 
>> avoid
>> allocating so much memory check for actual data length.
>> 
>> Link: 
>> https://lore.kernel.org/linux-mtd/CACna6rwf3_9QVjYcM+847biTX=K0EoWXuXcSMkJO1Vy_5vmVqA@mail.gmail.com/
>> Fixes: 3fef9ed0627a ("nvmem: brcm_nvram: new driver exposing 
>> Broadcom's NVRAM")
> 
> Any reason not to add
> Cc: <Stable@vger.kernel.org>
> ?

Not really. I believe stable team would pick this fix anyway (thanks to
the Fixes:) but doing
Cc: stable@vger.kernel.org
is described as strongly preferred.

Do you think you can just ammend my patch while applying it and add
Cc: stable@vger.kernel.org
to it?

-- 
Rafał Miłecki
