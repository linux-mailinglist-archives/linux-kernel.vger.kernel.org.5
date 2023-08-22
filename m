Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBDB784815
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbjHVQ5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjHVQ5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:57:19 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8A7128
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 09:57:15 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 1FE66120007;
        Tue, 22 Aug 2023 19:57:12 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 1FE66120007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1692723432;
        bh=drhH7+YmqhbOL557A+typ2DY3+xT4Rr5zlMBEjbe3+Y=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
        b=hhRttlqISvoDCwY91PCukwI7GEoGC1kDBWxglzmCK8jxdfU+8lSxomFeqqezK4gPF
         AVILo4fqPOmVj3vuEBZhd/YsAd0jYKAjusmSmRjmRGdxLwVOVDhgn+Y38ZTP1prvfG
         wKuYA9eMdnIf35JXjb+GhxdT+zxRlrPlUElxKkY4YriDVzUkbdJh8QfCowM5yUAQcW
         Geuj16u4aMIEWT4APbUKNwtKv5kWamHawUDOGLf/2azkclt/6z4C3ngDchB7taXRDE
         BIYJtNydfIlXixA2dmq5lk93dDfSWKycK1zDk0B8tZ/izM/otb5oHod8gL70qDsXud
         W9eRzXzOvXvbw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Tue, 22 Aug 2023 19:57:11 +0300 (MSK)
Received: from [192.168.1.146] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 22 Aug 2023 19:57:10 +0300
Message-ID: <01925ff8-1d19-a729-429a-89866fad319f@sberdevices.ru>
Date:   Tue, 22 Aug 2023 19:57:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 2/2] mtd: spinand: micron: fixing the offset for OOB
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <kernel@sberdevices.ru>
References: <20230822122534.872646-1-mmkurbanov@sberdevices.ru>
 <20230822122534.872646-3-mmkurbanov@sberdevices.ru>
 <20230822153556.630e65b9@xps-13>
From:   Martin Kurbanov <mmkurbanov@sberdevices.ru>
In-Reply-To: <20230822153556.630e65b9@xps-13>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 179385 [Aug 22 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: mmkurbanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 527 527 5bb611be2ca2baa31d984ccbf4ef4415504fc308, {Tracking_smtp_not_equal_from}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;datasheet.lcsc.com:7.1.1;www.micron.com:7.1.1;100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/08/22 16:05:00
X-KSMG-LinksScanning: Clean, bases: 2023/08/22 16:04:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/08/22 13:42:00 #21676335
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On 22.08.2023 16:35, Miquel Raynal wrote:
> Hi Martin,
> 
> mmkurbanov@sberdevices.ru wrote on Tue, 22 Aug 2023 15:25:34 +0300:
> 
>> The first 4 bytes are reserved for bad block data.
> 
> Are you sure about that? I've never seen 4-bytes BBM.

Yes, I'm sure. I have checked in all the relevant datasheets:
----------------------------------------------------------------------------------
|        Name        | Max Byte | Min Byte |  Area   |        Description        |
|                    | Address  | Address  |         |                           |
|--------------------+----------+----------+---------+---------------------------|
| MT29F2G01ABAGD [1] |          |          |         |                           |
|--------------------|          |          |         |                           |
| MT29F2G01ABBGD [2] |          |          |         |                           |
|--------------------|   803h   |   800h   |         |                           |
| MT29F1G01ABAFD [3] |          |          |         |                           |
|--------------------|          |          |         |                           |
| MT29F4G01ADAGD [4] |          |          |         |                           |
|--------------------+----------+----------| Spare 0 | Reserved (bad block data) |
| MT29F4G01ABAFD [5] |          |          |         |                           |
|--------------------|          |          |         |                           |
| MT29F4G01ABBFD [6] |          |          |         |                           |
|--------------------|  1003h   |  1000h   |         |                           |
| MT29F8G01ADAFD [7] |          |          |         |                           |
|--------------------|          |          |         |                           |
| MT29F8G01ADBFD [8] |          |          |         |                           |
----------------------------------------------------------------------------------

Note: to view the datasheet on the Micron (https://www.micron.com/) website, you need
to register.

Links:
  [1] https://datasheet.lcsc.com/lcsc/1912111437_Micron-Tech-MT29F2G01ABAGDWB-IT-G_C410863.pdf - page 45
  [2] https://www.micron.com/-/media/client/global/documents/products/data-sheet/nand-flash/70-series/m79a_2gb_1_8v_nand_spi.pdf - page 46
  [3] https://datasheet.lcsc.com/lcsc/2209201030_Micron-Tech-MT29F1G01ABAFDWB-IT-F_C2905686.pdf - page 46
  [4] https://www.micron.com/-/media/client/global/documents/products/data-sheet/nand-flash/70-series/m79a_ddp_4gb_3v_nand_spi.pdf - page 46
  [5] https://www.micron.com/-/media/client/global/documents/products/data-sheet/nand-flash/70-series/m70a_4gb_3v_nand_spi.pdf - page 47
  [6] https://www.micron.com/-/media/client/global/documents/products/data-sheet/nand-flash/70-series/m70a_4gb_1_8v_nand_spi.pdf - page 49
  [7] https://www.micron.com/-/media/client/global/documents/products/data-sheet/nand-flash/70-series/m70a_ddp_8gb_3v_nand_spi.pdf - page 48
  [8] https://www.micron.com/-/media/client/global/documents/products/data-sheet/nand-flash/70-series/m70a_ddp_8gb_1_8v_nand_spi.pdf - page 48

-- 
Best Regards,
Martin Kurbanov
