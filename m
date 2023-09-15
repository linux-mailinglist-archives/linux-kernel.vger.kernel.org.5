Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F1E7A1809
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjIOILY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjIOILX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:11:23 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2076.outbound.protection.outlook.com [40.107.20.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2092113
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 01:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHnF2dn7gpjLvRT4CnH9NlN46uasuT1tU/RjhlQ+bTk=;
 b=XknwgywSrz1fEeL6PvyjPpzsBgvnbFzHyA4kU0MN3VqPs1nQGkwPmu7cAS1AQS7cpMy4zDfU8CIp+mAaGdwhFvGcqrAzeCk88VIbEKieAPByCZc+idQwFu+itoDO0o7T6E3cIhqEWEhQ2J6wEgssp8EQrWUqRFQVx+jdoz02hWE=
Received: from AM6P192CA0105.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:8d::46)
 by VE1PR08MB5661.eurprd08.prod.outlook.com (2603:10a6:800:1b3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 08:11:11 +0000
Received: from AM7EUR03FT036.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:8d:cafe::65) by AM6P192CA0105.outlook.office365.com
 (2603:10a6:209:8d::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 08:11:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT036.mail.protection.outlook.com (100.127.140.93) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.21 via Frontend Transport; Fri, 15 Sep 2023 08:11:11 +0000
Received: ("Tessian outbound 0b7d6027328f:v175"); Fri, 15 Sep 2023 08:11:10 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 38c591e275bd0eb2
X-CR-MTA-TID: 64aa7808
Received: from d82c9cdd5773.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 7AC90F10-9144-475B-BA2B-48488FA97D09.1;
        Fri, 15 Sep 2023 08:10:59 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d82c9cdd5773.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 15 Sep 2023 08:10:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAhvmwFXIDhRA/xww4igXiNocmWAFDcC3z4CZ59uSq/vHYU9V0RN/291OTJ914GeC0Sfzr0/uxu6K9J6kgcaFd6TIdv3IP1pz3V3Q1V0jh91YTwP91ABd5yY14mKWAudqV+m2UlPqaHwhgrpR6ZkZYY9em8PytDQCRvh0wgE489LU1/zgcIfN+NY7xPZynHmh5NyQnXML5ghYjuGlzl7050V1qs6/nf3VWrqs+ghoVlDqnuUXUVv6z7oSzdC6j6QNcSMj/NamBV3ru8DST7pvz0saWba5g+y+3Uxe/XrUAGtP5aQm9N96Wv4jnzAlJoX5z20Z0sNvmXHojCAec36fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHnF2dn7gpjLvRT4CnH9NlN46uasuT1tU/RjhlQ+bTk=;
 b=lZQJrorzjk+N/YCM4CzviUvUOt6oeCaJ34OB5tcAIa+9H5rHeMQw0V4m5igpYY1KDlhAY1KqcTnfC44XbFdU1fiiciNJ4ZDHKUpr5i25V55Rx6doHDjdGtwWRE8QZ4tT3gVQmJfnArUI9ll2PMOiJGDkOCp5QmnH6GDu/arzDOqN3Ohf3k92Y8QaT95ByLYGT/rkYsLfcPRk+fTHX4TQuUtp8ymf8jJDvKxNu2pYm8x+gL0wuBGbKYDaYCCGOnQgvMfLg2GelpBxr1qRhxu06sLIKgb4pt9K28W058+r+2OZ4/QCL+yWa6vcg/2RG8jyyve73qu74DEn2T8GA0SJaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHnF2dn7gpjLvRT4CnH9NlN46uasuT1tU/RjhlQ+bTk=;
 b=XknwgywSrz1fEeL6PvyjPpzsBgvnbFzHyA4kU0MN3VqPs1nQGkwPmu7cAS1AQS7cpMy4zDfU8CIp+mAaGdwhFvGcqrAzeCk88VIbEKieAPByCZc+idQwFu+itoDO0o7T6E3cIhqEWEhQ2J6wEgssp8EQrWUqRFQVx+jdoz02hWE=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by PAVPR08MB9329.eurprd08.prod.outlook.com (2603:10a6:102:305::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 15 Sep
 2023 08:10:56 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::7e2f:184:7fc7:6448]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::7e2f:184:7fc7:6448%7]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 08:10:56 +0000
From:   Justin He <Justin.He@arm.com>
To:     kernel test robot <lkp@intel.com>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC:     "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: RE: [PATCH] dma-mapping: fix dma_addressing_limited if dma_range_map
 is scanned
Thread-Topic: [PATCH] dma-mapping: fix dma_addressing_limited if dma_range_map
 is scanned
Thread-Index: AQHZ5VTJb5HgcbylTEiPRH8iRHuc47AXgymAgAQJ3fA=
Date:   Fri, 15 Sep 2023 08:10:56 +0000
Message-ID: <DBBPR08MB4538DFF8BA4D9C098A8FC7B0F7F6A@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <20230912084002.2168-1-justin.he@arm.com>
 <202309130234.COIfUg9W-lkp@intel.com>
In-Reply-To: <202309130234.COIfUg9W-lkp@intel.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: DBBPR08MB4538:EE_|PAVPR08MB9329:EE_|AM7EUR03FT036:EE_|VE1PR08MB5661:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cf677e6-3a21-45a4-ee3f-08dbb5c352a2
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: W4pe2LpsG5Ly/BK6cYx0pLPWfrHlao7TX3oi4Zos+t78w6O7C/zbqf0ugnufWERglUO3H4/Qe4fsxQsRsVQyR9tgpibHxMxYjC3RI1XciYHL6jNnktz7f50kDoMWDSltA6PBxIiFqyLYsYPZRJ/RLFftRKcGVAMYd4pyoCWBdpny/RjjVPQQJdliZCYSwyC01hI69zz65cc38wnPku6Qd/Hg2TICf6dGofN6v7w65N2ekvlgkZ2AoCE/xy6hs5QppxNAlZONmNstTjDEBA6PX78G4pytbn/ttNrmbk9eF3SXSlTQt+N9uNLbvd3MxoPHH7u5J7+QVZG0lXsbdQL3scq01WHR8hrdJeLaZ3hO1tslqEalmdBIXHWUR0OTRCAx/CxaFDsQaXbSdJM5a5Y5WTuBcJhjaoAtrupdOjgKrmBVd9cGIU5uKNV5NQWt+howpNFX4ZwITwZpkFwnVPQ22aoyWRVMBxKXUaJcEGlOcnDTqHtj8e9ridAMns4Q+9FAOf5lJSef4v9WdpOWBfkshizboMId0nl3exLCibqAWTdsDDG0CZXz2zOEteQukSD6s62ezIhpLMW+8A2OAfpGuSnuXiztEU13NanladzGj1Fn8VD/Gxl0Vq4cflwQ9kzOZB2kqSO8d7vzoRvleLC0Ug==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(366004)(39860400002)(1800799009)(186009)(451199024)(52536014)(71200400001)(53546011)(7696005)(6506007)(2906002)(86362001)(122000001)(33656002)(38070700005)(55016003)(38100700002)(8936002)(30864003)(26005)(9686003)(66446008)(478600001)(110136005)(83380400001)(966005)(64756008)(4326008)(5660300002)(8676002)(41300700001)(66476007)(66946007)(66556008)(316002)(76116006)(54906003)(579004)(559001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9329
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT036.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 760e5684-d939-4ae8-2267-08dbb5c349c0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xIUSxiKIc3v03a8JWKt4eWwU/1KINKp5ypWimMuXCySTn8fuhAQuSBkqzSq5tY35k3WNBC2ITr88+UfmZxup5yoMbJmqJva9XFdtfz5JgT6miyJP2O66Q4OdfzNH/Wcx96X8g3VEzr+Un06nS5X0ZdXCeEgzOG0E/CTutk57uPW8AsSp8Aj6cpBWmhO6ygHKs4NKBkE3749g+vCZ48swplivpp7/MqnszXHG0g3lzLGpmAMeEJ388R9iL8q9eYhseb62gh0+1cfM/kYsgyi7y2f7L323RxRFc5ItXicWxCZDeoy4DTieyCgzNoQ+aLvD4GEDkjcgMAfamsYEmTo8e05LMIKtKQZ8+GWp5lYUXrltHhXdW6c35JIXmvSavmac6ihKDrNoGGwCKLGTiLBQZ8k6z3ep75a/ZAVBXmr/8sNyKOListE6LGg0yCY5IQCHxKwJ8Xv4F8JNel9yW/G2g7IPeGk5AtIsk2cZi6dq5WWiBBGER465A81OAXqS1Eg+UuGF/p1V6YT2RMNp7JIQCXo80npbuRC77DPbMvZQNWRyl0iUc9/CqVN+7G5oz1mA2X0Gr4lqFhAD271fuxCaJ3RcJH/QPUf5RjwUE84RfhUlDKxY47hyclWa/ohREWbtBidwWtfaBHHLOC1mqo37Kqc42Z4yFKfmwWxEuB+YpKHII/sBNiR17zXR7+4+q5dsj2Yy54bRfddrgB5EAO96ptMxgC0/SreU9QZT7AX7ZSQ=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39850400004)(376002)(136003)(346002)(82310400011)(451199024)(1800799009)(186009)(36840700001)(46966006)(53546011)(7696005)(6506007)(9686003)(966005)(83380400001)(478600001)(26005)(336012)(2906002)(30864003)(8676002)(70206006)(70586007)(54906003)(316002)(110136005)(52536014)(5660300002)(8936002)(41300700001)(47076005)(4326008)(356005)(40480700001)(36860700001)(86362001)(33656002)(81166007)(55016003)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 08:11:11.1935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf677e6-3a21-45a4-ee3f-08dbb5c352a2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT036.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5661
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: kernel test robot <lkp@intel.com>
> Sent: Wednesday, September 13, 2023 2:28 AM
> To: Justin He <Justin.He@arm.com>; Christoph Hellwig <hch@lst.de>; Marek
> Szyprowski <m.szyprowski@samsung.com>; Robin Murphy
> <Robin.Murphy@arm.com>; iommu@lists.linux.dev
> Cc: llvm@lists.linux.dev; oe-kbuild-all@lists.linux.dev;
> linux-kernel@vger.kernel.org; Justin He <Justin.He@arm.com>
> Subject: Re: [PATCH] dma-mapping: fix dma_addressing_limited if
> dma_range_map is scanned
>=20
> Hi Jia,
>=20
> kernel test robot noticed the following build errors:
>=20
> [auto build test ERROR on linus/master]
> [also build test ERROR on v6.6-rc1 next-20230912] [If your patch is appli=
ed to
> the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>=20
> url:
> https://github.com/intel-lab-lkp/linux/commits/Jia-He/dma-mapping-fix-dma=
_
> addressing_limited-if-dma_range_map-is-scanned/20230912-164126
> base:   linus/master
> patch link:
> https://lore.kernel.org/r/20230912084002.2168-1-justin.he%40arm.com
> patch subject: [PATCH] dma-mapping: fix dma_addressing_limited if
> dma_range_map is scanned
> config: um-allyesconfig
> (https://download.01.org/0day-ci/archive/20230913/202309130234.COIfUg9
> W-lkp@intel.com/config)
> compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git
> f28c006a5895fc0e329fe15fead81e37457cb1d1)
> reproduce (this is a W=3D1 build):
> (https://download.01.org/0day-ci/archive/20230913/202309130234.COIfUg9
> W-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes:
> | https://lore.kernel.org/oe-kbuild-all/202309130234.COIfUg9W-lkp@intel.
> | com/
>=20
> All errors (new ones prefixed by >>):
>=20
>    In file included from init/main.c:21:
>    In file included from include/linux/syscalls.h:90:
>    In file included from include/trace/syscall.h:7:
>    In file included from include/linux/trace_events.h:9:
>    In file included from include/linux/hardirq.h:11:
>    In file included from arch/um/include/asm/hardirq.h:5:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:13:
>    In file included from arch/um/include/asm/io.h:24:
>    include/asm-generic/io.h:547:31: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            val =3D __raw_readb(PCI_IOBASE + addr);
>                              ~~~~~~~~~~ ^
>    include/asm-generic/io.h:560:61: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            val =3D __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE +
> addr));
>=20
> ~~~~~~~~~~ ^
>    include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded fro=
m
> macro '__le16_to_cpu'
>    #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
>                                                      ^
>    In file included from init/main.c:21:
>    In file included from include/linux/syscalls.h:90:
>    In file included from include/trace/syscall.h:7:
>    In file included from include/linux/trace_events.h:9:
>    In file included from include/linux/hardirq.h:11:
>    In file included from arch/um/include/asm/hardirq.h:5:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:13:
>    In file included from arch/um/include/asm/io.h:24:
>    include/asm-generic/io.h:573:61: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            val =3D __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE +
> addr));
>=20
> ~~~~~~~~~~ ^
>    include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded fro=
m
> macro '__le32_to_cpu'
>    #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
>                                                      ^
>    In file included from init/main.c:21:
>    In file included from include/linux/syscalls.h:90:
>    In file included from include/trace/syscall.h:7:
>    In file included from include/linux/trace_events.h:9:
>    In file included from include/linux/hardirq.h:11:
>    In file included from arch/um/include/asm/hardirq.h:5:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:13:
>    In file included from arch/um/include/asm/io.h:24:
>    include/asm-generic/io.h:584:33: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            __raw_writeb(value, PCI_IOBASE + addr);
>                                ~~~~~~~~~~ ^
>    include/asm-generic/io.h:594:59: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE +
> addr);
>                                                          ~~~~~~~~~~
> ^
>    include/asm-generic/io.h:604:59: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE +
> addr);
>                                                          ~~~~~~~~~~
> ^
>    include/asm-generic/io.h:692:20: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            readsb(PCI_IOBASE + addr, buffer, count);
>                   ~~~~~~~~~~ ^
>    include/asm-generic/io.h:700:20: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            readsw(PCI_IOBASE + addr, buffer, count);
>                   ~~~~~~~~~~ ^
>    include/asm-generic/io.h:708:20: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            readsl(PCI_IOBASE + addr, buffer, count);
>                   ~~~~~~~~~~ ^
>    include/asm-generic/io.h:717:21: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            writesb(PCI_IOBASE + addr, buffer, count);
>                    ~~~~~~~~~~ ^
>    include/asm-generic/io.h:726:21: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            writesw(PCI_IOBASE + addr, buffer, count);
>                    ~~~~~~~~~~ ^
>    include/asm-generic/io.h:735:21: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            writesl(PCI_IOBASE + addr, buffer, count);
>                    ~~~~~~~~~~ ^
>    In file included from init/main.c:102:
>    In file included from include/net/net_namespace.h:43:
>    In file included from include/linux/skbuff.h:28:
> >> include/linux/dma-mapping.h:483:10: error: implicit declaration of
> >> function 'all_ram_in_dma_range_map' is invalid in C99
> >> [-Werror,-Wimplicit-function-declaration]
>            return !all_ram_in_dma_range_map(dev);
Seems I need to define a stub when DMA Kconfig is disabled.
Thanks

--
Cheers,
Justin (Jia He)

>                    ^
>    12 warnings and 1 error generated.
> --
>    In file included from arch/um/os-Linux/drivers/ethertap_kern.c:10:
>    In file included from include/linux/netdevice.h:38:
>    In file included from include/net/net_namespace.h:43:
>    In file included from include/linux/skbuff.h:17:
>    In file included from include/linux/bvec.h:10:
>    In file included from include/linux/highmem.h:12:
>    In file included from include/linux/hardirq.h:11:
>    In file included from arch/um/include/asm/hardirq.h:5:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:13:
>    In file included from arch/um/include/asm/io.h:24:
>    include/asm-generic/io.h:547:31: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            val =3D __raw_readb(PCI_IOBASE + addr);
>                              ~~~~~~~~~~ ^
>    include/asm-generic/io.h:560:61: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            val =3D __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE +
> addr));
>=20
> ~~~~~~~~~~ ^
>    include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded fro=
m
> macro '__le16_to_cpu'
>    #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
>                                                      ^
>    In file included from arch/um/os-Linux/drivers/ethertap_kern.c:10:
>    In file included from include/linux/netdevice.h:38:
>    In file included from include/net/net_namespace.h:43:
>    In file included from include/linux/skbuff.h:17:
>    In file included from include/linux/bvec.h:10:
>    In file included from include/linux/highmem.h:12:
>    In file included from include/linux/hardirq.h:11:
>    In file included from arch/um/include/asm/hardirq.h:5:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:13:
>    In file included from arch/um/include/asm/io.h:24:
>    include/asm-generic/io.h:573:61: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            val =3D __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE +
> addr));
>=20
> ~~~~~~~~~~ ^
>    include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded fro=
m
> macro '__le32_to_cpu'
>    #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
>                                                      ^
>    In file included from arch/um/os-Linux/drivers/ethertap_kern.c:10:
>    In file included from include/linux/netdevice.h:38:
>    In file included from include/net/net_namespace.h:43:
>    In file included from include/linux/skbuff.h:17:
>    In file included from include/linux/bvec.h:10:
>    In file included from include/linux/highmem.h:12:
>    In file included from include/linux/hardirq.h:11:
>    In file included from arch/um/include/asm/hardirq.h:5:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:13:
>    In file included from arch/um/include/asm/io.h:24:
>    include/asm-generic/io.h:584:33: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            __raw_writeb(value, PCI_IOBASE + addr);
>                                ~~~~~~~~~~ ^
>    include/asm-generic/io.h:594:59: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE +
> addr);
>                                                          ~~~~~~~~~~
> ^
>    include/asm-generic/io.h:604:59: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE +
> addr);
>                                                          ~~~~~~~~~~
> ^
>    include/asm-generic/io.h:692:20: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            readsb(PCI_IOBASE + addr, buffer, count);
>                   ~~~~~~~~~~ ^
>    include/asm-generic/io.h:700:20: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            readsw(PCI_IOBASE + addr, buffer, count);
>                   ~~~~~~~~~~ ^
>    include/asm-generic/io.h:708:20: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            readsl(PCI_IOBASE + addr, buffer, count);
>                   ~~~~~~~~~~ ^
>    include/asm-generic/io.h:717:21: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            writesb(PCI_IOBASE + addr, buffer, count);
>                    ~~~~~~~~~~ ^
>    include/asm-generic/io.h:726:21: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            writesw(PCI_IOBASE + addr, buffer, count);
>                    ~~~~~~~~~~ ^
>    include/asm-generic/io.h:735:21: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            writesl(PCI_IOBASE + addr, buffer, count);
>                    ~~~~~~~~~~ ^
>    In file included from arch/um/os-Linux/drivers/ethertap_kern.c:10:
>    In file included from include/linux/netdevice.h:38:
>    In file included from include/net/net_namespace.h:43:
>    In file included from include/linux/skbuff.h:28:
> >> include/linux/dma-mapping.h:483:10: error: implicit declaration of
> >> function 'all_ram_in_dma_range_map' is invalid in C99
> >> [-Werror,-Wimplicit-function-declaration]
>            return !all_ram_in_dma_range_map(dev);
>                    ^
>    arch/um/os-Linux/drivers/ethertap_kern.c:66:5: warning: no previous
> prototype for function 'ethertap_setup' [-Wmissing-prototypes]
>    int ethertap_setup(char *str, char **mac_out, void *data)
>        ^
>    arch/um/os-Linux/drivers/ethertap_kern.c:66:1: note: declare 'static' =
if the
> function is not intended to be used outside of this translation unit
>    int ethertap_setup(char *str, char **mac_out, void *data)
>    ^
>    static
>    13 warnings and 1 error generated.
> --
>    In file included from arch/um/os-Linux/drivers/tuntap_kern.c:6:
>    In file included from include/linux/netdevice.h:38:
>    In file included from include/net/net_namespace.h:43:
>    In file included from include/linux/skbuff.h:17:
>    In file included from include/linux/bvec.h:10:
>    In file included from include/linux/highmem.h:12:
>    In file included from include/linux/hardirq.h:11:
>    In file included from arch/um/include/asm/hardirq.h:5:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:13:
>    In file included from arch/um/include/asm/io.h:24:
>    include/asm-generic/io.h:547:31: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            val =3D __raw_readb(PCI_IOBASE + addr);
>                              ~~~~~~~~~~ ^
>    include/asm-generic/io.h:560:61: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            val =3D __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE +
> addr));
>=20
> ~~~~~~~~~~ ^
>    include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded fro=
m
> macro '__le16_to_cpu'
>    #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
>                                                      ^
>    In file included from arch/um/os-Linux/drivers/tuntap_kern.c:6:
>    In file included from include/linux/netdevice.h:38:
>    In file included from include/net/net_namespace.h:43:
>    In file included from include/linux/skbuff.h:17:
>    In file included from include/linux/bvec.h:10:
>    In file included from include/linux/highmem.h:12:
>    In file included from include/linux/hardirq.h:11:
>    In file included from arch/um/include/asm/hardirq.h:5:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:13:
>    In file included from arch/um/include/asm/io.h:24:
>    include/asm-generic/io.h:573:61: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            val =3D __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE +
> addr));
>=20
> ~~~~~~~~~~ ^
>    include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded fro=
m
> macro '__le32_to_cpu'
>    #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
>                                                      ^
>    In file included from arch/um/os-Linux/drivers/tuntap_kern.c:6:
>    In file included from include/linux/netdevice.h:38:
>    In file included from include/net/net_namespace.h:43:
>    In file included from include/linux/skbuff.h:17:
>    In file included from include/linux/bvec.h:10:
>    In file included from include/linux/highmem.h:12:
>    In file included from include/linux/hardirq.h:11:
>    In file included from arch/um/include/asm/hardirq.h:5:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:13:
>    In file included from arch/um/include/asm/io.h:24:
>    include/asm-generic/io.h:584:33: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            __raw_writeb(value, PCI_IOBASE + addr);
>                                ~~~~~~~~~~ ^
>    include/asm-generic/io.h:594:59: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE +
> addr);
>                                                          ~~~~~~~~~~
> ^
>    include/asm-generic/io.h:604:59: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE +
> addr);
>                                                          ~~~~~~~~~~
> ^
>    include/asm-generic/io.h:692:20: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            readsb(PCI_IOBASE + addr, buffer, count);
>                   ~~~~~~~~~~ ^
>    include/asm-generic/io.h:700:20: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            readsw(PCI_IOBASE + addr, buffer, count);
>                   ~~~~~~~~~~ ^
>    include/asm-generic/io.h:708:20: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            readsl(PCI_IOBASE + addr, buffer, count);
>                   ~~~~~~~~~~ ^
>    include/asm-generic/io.h:717:21: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            writesb(PCI_IOBASE + addr, buffer, count);
>                    ~~~~~~~~~~ ^
>    include/asm-generic/io.h:726:21: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            writesw(PCI_IOBASE + addr, buffer, count);
>                    ~~~~~~~~~~ ^
>    include/asm-generic/io.h:735:21: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            writesl(PCI_IOBASE + addr, buffer, count);
>                    ~~~~~~~~~~ ^
>    In file included from arch/um/os-Linux/drivers/tuntap_kern.c:6:
>    In file included from include/linux/netdevice.h:38:
>    In file included from include/net/net_namespace.h:43:
>    In file included from include/linux/skbuff.h:28:
> >> include/linux/dma-mapping.h:483:10: error: implicit declaration of
> >> function 'all_ram_in_dma_range_map' is invalid in C99
> >> [-Werror,-Wimplicit-function-declaration]
>            return !all_ram_in_dma_range_map(dev);
>                    ^
>    arch/um/os-Linux/drivers/tuntap_kern.c:56:5: warning: no previous
> prototype for function 'tuntap_setup' [-Wmissing-prototypes]
>    int tuntap_setup(char *str, char **mac_out, void *data)
>        ^
>    arch/um/os-Linux/drivers/tuntap_kern.c:56:1: note: declare 'static' if=
 the
> function is not intended to be used outside of this translation unit
>    int tuntap_setup(char *str, char **mac_out, void *data)
>    ^
>    static
>    13 warnings and 1 error generated.
> --
>    In file included from net/ipv4/route.c:67:
>    In file included from include/linux/memblock.h:13:
>    In file included from arch/um/include/asm/dma.h:5:
>    In file included from arch/um/include/asm/io.h:24:
>    include/asm-generic/io.h:547:31: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            val =3D __raw_readb(PCI_IOBASE + addr);
>                              ~~~~~~~~~~ ^
>    include/asm-generic/io.h:560:61: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            val =3D __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE +
> addr));
>=20
> ~~~~~~~~~~ ^
>    include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded fro=
m
> macro '__le16_to_cpu'
>    #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
>                                                      ^
>    In file included from net/ipv4/route.c:67:
>    In file included from include/linux/memblock.h:13:
>    In file included from arch/um/include/asm/dma.h:5:
>    In file included from arch/um/include/asm/io.h:24:
>    include/asm-generic/io.h:573:61: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            val =3D __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE +
> addr));
>=20
> ~~~~~~~~~~ ^
>    include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded fro=
m
> macro '__le32_to_cpu'
>    #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
>                                                      ^
>    In file included from net/ipv4/route.c:67:
>    In file included from include/linux/memblock.h:13:
>    In file included from arch/um/include/asm/dma.h:5:
>    In file included from arch/um/include/asm/io.h:24:
>    include/asm-generic/io.h:584:33: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            __raw_writeb(value, PCI_IOBASE + addr);
>                                ~~~~~~~~~~ ^
>    include/asm-generic/io.h:594:59: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE +
> addr);
>                                                          ~~~~~~~~~~
> ^
>    include/asm-generic/io.h:604:59: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE +
> addr);
>                                                          ~~~~~~~~~~
> ^
>    include/asm-generic/io.h:692:20: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            readsb(PCI_IOBASE + addr, buffer, count);
>                   ~~~~~~~~~~ ^
>    include/asm-generic/io.h:700:20: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            readsw(PCI_IOBASE + addr, buffer, count);
>                   ~~~~~~~~~~ ^
>    include/asm-generic/io.h:708:20: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            readsl(PCI_IOBASE + addr, buffer, count);
>                   ~~~~~~~~~~ ^
>    include/asm-generic/io.h:717:21: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            writesb(PCI_IOBASE + addr, buffer, count);
>                    ~~~~~~~~~~ ^
>    include/asm-generic/io.h:726:21: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            writesw(PCI_IOBASE + addr, buffer, count);
>                    ~~~~~~~~~~ ^
>    include/asm-generic/io.h:735:21: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            writesl(PCI_IOBASE + addr, buffer, count);
>                    ~~~~~~~~~~ ^
>    In file included from net/ipv4/route.c:71:
>    In file included from include/linux/inet.h:42:
>    In file included from include/net/net_namespace.h:43:
>    In file included from include/linux/skbuff.h:28:
> >> include/linux/dma-mapping.h:483:10: error: implicit declaration of
> >> function 'all_ram_in_dma_range_map' is invalid in C99
> >> [-Werror,-Wimplicit-function-declaration]
>            return !all_ram_in_dma_range_map(dev);
>                    ^
>    net/ipv4/route.c:880:6: warning: variable 'log_martians' set but not u=
sed
> [-Wunused-but-set-variable]
>            int log_martians;
>                ^
>    13 warnings and 1 error generated.
> ..
>=20
>=20
> vim +/all_ram_in_dma_range_map +483 include/linux/dma-mapping.h
>=20
>    468
>    469	/**
>    470	 * dma_addressing_limited - return if the device is addressing
> limited
>    471	 * @dev:	device to check
>    472	 *
>    473	 * Return %true if the devices DMA mask is too small to address al=
l
> memory in
>    474	 * the system, else %false.  Lack of addressing bits is the prime
> reason for
>    475	 * bounce buffering, but might not be the only one.
>    476	 */
>    477	static inline bool dma_addressing_limited(struct device *dev)
>    478	{
>    479		if (min_not_zero(dma_get_mask(dev), dev->bus_dma_limit) <
>    480							dma_get_required_mask(dev))
>    481			return true;
>    482
>  > 483		return !all_ram_in_dma_range_map(dev);
>    484	}
>    485
>=20
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
