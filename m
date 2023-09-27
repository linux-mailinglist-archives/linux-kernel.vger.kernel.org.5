Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A337AFB14
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 08:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjI0G2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 02:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjI0G2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 02:28:11 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6664F9C;
        Tue, 26 Sep 2023 23:28:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rbm2EeMDExa7elRCLmVcWS7Ll0hu2p4N4ymy3k0Yr/nuuebunH3pqRgfnAjb6XmcTA4kxKbWFfvCMqJrUUrAxAW6jv2fLgqQWFWaGEpY8fJxCxS2zhCDLDwfP6/jCL6F3OWFOcuTbYmsKL8YLRbaMsEADuhT6Eplcno62eagldZ0/nt/WAW3akv/RDDf6EIagyJPgI/qV2CnFfM2AOz75Bij6uWk4Y8gna3ui5gFPp/5dF04QmgqE4cFsLMsbUtlOZAoI0xB32G7T/1myjKPHYKH32vnULsPA6xPUitjXywz6s4YmAAVwf6V+VnSwz59+nBF6hi576lTkAYhPLUxNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmlSYu3zQBMK43PtY/kyNC8lYl3VRg9OzmQ3Rf93Zpo=;
 b=bsPVzMiWjZrFdsCXukOBVpYmveSRC4O24CJ1Hg9yOna3ss5JTZtIGMAE43RJAE0hlyZXKWtNx8eoNhT93ebxJfUxAvVlvzHyvOB0k7BuFq4m1bL7wvZaHSISklbPLKEpPSj6bPo+4gGnfn4Tyg5TYCl+h5XQ2pcKnnyiwgX0REc34CJAp5+XNYj6Z8DJwkFg7rGI8fok7ZJbjK7AnZlpl5uz+n+Epgk69qkOOb/faApfRLBQ2uGRLWbpyNZsvho8zH51yY5rLrBrxO5naa4j5OjSeDqtKzJVeqWKPYh2EN/VkAuyR5PSu4vtYDIKx5szefEoVzqLqvF+H0E2kPDX4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmlSYu3zQBMK43PtY/kyNC8lYl3VRg9OzmQ3Rf93Zpo=;
 b=ESkaFH+e9mim6BFv38DBN1V2odmH8GYXakMpsCJw4R0H7+HIgY4ls+vvwo9dsCzrzH9c34gc5/1JgUaHv7mkECDTRllIc/jE5WQX1tGq0HSFbMUfW4/E+pOahiaG2rBqvApvDl2ubJYJW5QHUWqGndvHy0hpsAagaDjXmwRcwJALnqggLsDazKwZs4T04Y/NaXSHQYW3CzTLvpr5RBawmQFa75FRTlnxHhH/wozO4hy5fHsK7Pa24jVWoPP19+Lwh7fb+4mfmwaNaCgg6texlkAc2bjFuGnWxAGqvADWTuV9uicRRjbA/nCbeeM2mu7DxeBehldFZ+gBPXa6ygOLBw==
Received: from BYAPR08MB4437.namprd08.prod.outlook.com (2603:10b6:a02:ff::32)
 by CH0PR08MB8730.namprd08.prod.outlook.com (2603:10b6:610:188::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 27 Sep
 2023 06:28:05 +0000
Received: from BYAPR08MB4437.namprd08.prod.outlook.com
 ([fe80::3def:2b75:4cc1:76e8]) by BYAPR08MB4437.namprd08.prod.outlook.com
 ([fe80::3def:2b75:4cc1:76e8%5]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 06:28:04 +0000
From:   Domenico Punzo <dpunzo@micron.com>
To:     'Miquel Raynal' <miquel.raynal@bootlin.com>,
        =?utf-7?B?TWFydGluIEh1bmRlYitBUGctbGw=?= <martin@geanix.com>
CC:     Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        =?utf-7?B?TStBT1UtbnMgUnVsbGcrQU9VLXJk?= <mans@mansr.com>,
        Alexander Shiyan <eagle.alexander923@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        JaimeLiao <jaimeliao.tw@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-7?B?U2VhbiBOeWVraitBT1ktcg==?= <sean@geanix.com>,
        Bean Huo <beanhuo@micron.com>
Subject: RE: [EXT] Re: [PATCH v2] mtd: rawnand: Ensure the nand chip supports
 cached reads
Thread-Topic: [EXT] Re: [PATCH v2] mtd: rawnand: Ensure the nand chip supports
 cached reads
Thread-Index: AQHZ8GxsHk1a7lkdfEql/mFIunWFFbAtFx+g
Date:   Wed, 27 Sep 2023 06:28:04 +0000
Message-ID: <BYAPR08MB4437C4365962602735E7810CBBC2A@BYAPR08MB4437.namprd08.prod.outlook.com>
References: <20230922141717.35977-1-r.czerwinski@pengutronix.de>
        <e911f5d9c7def8c80904a17ad3924ecba6625998.camel@geanix.com>
 <20230926132725.5d570e1b@xps-13>
In-Reply-To: <20230926132725.5d570e1b@xps-13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ActionId=7f1c071f-e25f-4709-96dc-6704b7429d92;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ContentBits=0;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Enabled=true;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Method=Standard;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Name=Confidential;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SetDate=2023-09-26T13:18:48Z;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SiteId=f38a5ecd-2813-4862-b11b-ac1d563c806f;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=micron.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR08MB4437:EE_|CH0PR08MB8730:EE_
x-ms-office365-filtering-correlation-id: 6b617500-3648-4531-cf53-08dbbf22e820
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6Qg1WoaxwfYf79xbsbgFvC1WjxlJYjzaLJW+o3ZES2sCpxrBkr33EXDO83yMeyaj1wsTHGhk8SO7It4Smnx9PTX6QOvOQenWB7WUpVOfHr+YHwirGbgDXAxlqf28pB3sMe/MwB06z/dw+xDvn1PH1uStFGy/aAEmonUnpEzM9ojgVaPfbdnymtzc5V7+FlnPHX6Om/mnUvj92JRz0J6PNrwW24RCuNgSnkSTMzIvKtD6oZwr9LXGaKGX9Estp7p6QN7ERjk5enWKWKYpNXdGsVWelBSA/X+Z+ro8VoSI1Ww+29FAUDS/1FuOm5fPm2cygI7Vo4zlJHJvK4oOYgAYUCjOMsySUVyZd5bKBxbduMSFmNds62d5Prw2KJa7F8eMKRJtxf7LJ+yyyhZJ+51TL0s10O/2p6tReccP9SIcNI/AqbmMomw0SR9y+JjPGorc7gSdm5BvGMlw2sdsy7TAlAz9ZCVEOTnL3kpg6PJ9QzOnFltYrLzrTPzMDlC0XfKdx8ZNPtsgFIMmwDHewxdoPDzrhvF08t4ToaofGIe/VCi5MEsADPmSAbY+pDfT3FSodCrvv6DP/4xMRpvWw5bIT6PW29J3OOL/rSg+P6jmEt/NR5IJoV16Tu/GWqdjKOr+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR08MB4437.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(376002)(396003)(366004)(230922051799003)(186009)(1800799009)(451199024)(38070700005)(52536014)(7696005)(53546011)(6506007)(478600001)(38100700002)(122000001)(33656002)(2906002)(86362001)(55016003)(41300700001)(7416002)(9686003)(54906003)(5660300002)(83380400001)(66476007)(107886003)(8676002)(71200400001)(110136005)(64756008)(8936002)(76116006)(66946007)(316002)(26005)(66446008)(4326008)(66574015)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-7?B?eTBaVlpqWkxtNGVUNUlNL3JJakU3UnlCZUlDeFVaUVRsZVZQZjdtUUd0T3FJ?=
 =?utf-7?B?MEdjZXd6dGdBR2JFYkZjdTkvQzZZcUdaeGs0bystWlRvSkRTT0ZqMUhhUzdp?=
 =?utf-7?B?MmJ1WWNzcnRWTmNXUU1QQVNwaHhNY21XeGtLcFg3TmJtV1VvQWFEOHVMY1FE?=
 =?utf-7?B?R2E2Nnp1dzNyM2l1WTBUY3ZBYnZRVzAxdFJ6N2dMU0ZBR1dvdzBOWWkzTHRG?=
 =?utf-7?B?Zk9nODRvSkhkcXpJR21zN1diZFY1UFYyTnFadnZmV0dkZmZ4Ky1YNXRsbTU5?=
 =?utf-7?B?Y2pkN25vSHpMSEw1bk5uNXU0QWlHbDY2cnFqR3QvMHhKZnpaczdkRistaXh2?=
 =?utf-7?B?UFFiVlZxVWt1dEFvQmJEaTVMb1ArLUYvTnlJT3NmKy0vdTFQb2pxdXh4QXFo?=
 =?utf-7?B?NWxMOSstWVJpeTZTc0QvVGpBdTRwblpzYkhiTW9RTnBRNjhsVXpDVnQ5c3RU?=
 =?utf-7?B?aGdhblRHbHZLdk1kSTkzOVRuRVpMMVFubHJxL3ByaUxuU2dFNUp3S2pUN2Nk?=
 =?utf-7?B?a1VERjFqY2JHakQzSDNTWW44VFhjL21YUFplcUs1Uzk2aGp0Ky1ENVV6bVk=?=
 =?utf-7?B?QystdWxuQ3lTRXVGM2NiKy1JYzROL3locjA3YXdsT0tLUUVqcGVlQ2xWeXNS?=
 =?utf-7?B?QVBReVZLem1JV3A3RzUrLUExUklzaks4R001SmRZamw3MzZzTjZpNUR1alR6?=
 =?utf-7?B?b3A5ZU5CMGIrLTRpdnEzVk44YXQwYlBXUUd2Y2xPOGRGSUtLQmo1VTh3ZVZN?=
 =?utf-7?B?WjdPc2owWjFtdjVRYjQ0bXVuaDhQQXlaVjBPZlJIdzd0MFNBQ1hUdmNGZVJR?=
 =?utf-7?B?bXBkWE1NUzlUYktZKy1NNGN4UzRuU2E2RkUwM0NBNFN0cjFNaTd6d0I2aTVX?=
 =?utf-7?B?MVUvZzBsVTl5OGNJcHAyL29YbW9aOFJQMkdXZG1wcUJvYkZhREpMQkh4VTRC?=
 =?utf-7?B?Q1BTZldTbXRpamZYcm42eTdvRGFrNXE3MDgrLTdNUVZhbm1sZWRxcGtvSU42?=
 =?utf-7?B?WEFhZ0NTVmRNY3o0WXFsMS9Gc2hoZTBmOVpzZlAvVDJhRFo3MkhXUWhBUy9K?=
 =?utf-7?B?ZkcyKy1pWTZmbWYwYjRFN2hJVUpuZzRJSm5hUVRDTmg2L2FBV05VNXQ3WUFz?=
 =?utf-7?B?c1BNVWFTRVJEQ0tvcTJ4TUxDZjRzMlgzalBHYURBNXA0QXdDMzdTMFRRNXd0?=
 =?utf-7?B?dERtdDFsaTc3Mk05ME5nMElWZGtSS1dCUGsxeWpWbVVxdmJhaVU0RXhXV24v?=
 =?utf-7?B?bzcrLXQzU01sSVFlOFdWdXg2Q0x6TEFpdVp5T3VoSXFJKy1DTnREZ1RDdkxP?=
 =?utf-7?B?dndQNERSN3BTSVF3UERpMkJlZ3lJYUY1TnpxTmw0dzJtMjBKZWprWUpReW1L?=
 =?utf-7?B?NEUvajdQaDVYYUNPMHJtdHBMT0w3a3BLclNodHFIYWxmSlptMGRRcWp1YlBL?=
 =?utf-7?B?M0czWWtxMldEeFpkendMbHdwZ05WYW84eDRSV3RWZGNzeDVGRmVMbEpnSXFQ?=
 =?utf-7?B?TS8zcVMvOGV5SU5IZmtHUVc0UnpBV3ZFWHRDMEFYcm1GeksxMTV1WjYrLUVO?=
 =?utf-7?B?V1Rjc0VUMlhqSU5ISFkycEJLSExwY3RrQnUrLXZRZjlaRlRmWTFRdHJlQzNT?=
 =?utf-7?B?dXJ3NVlSalBVTk9LOWoybFpnRnlFa0NLY280clJJN0hNVTEvQ3FzajJBS0Rh?=
 =?utf-7?B?Ty9zVjhSVUN1cmRaSFJFRkN3cGNmZnFQM0lNMU9tdGcrLThEQXRiU1k4ZzBo?=
 =?utf-7?B?M0xmM0xoYjdqdzErLVZUOFFBMld2ME1HL0ZYeDNERXRCeUVxZW95VDdjMEJZ?=
 =?utf-7?B?eG5JcDZxdnh1WjNhNXUxUlZxeThuTUs5OUJGUFpWVkRpSkRhRDhGOUFBb1NZ?=
 =?utf-7?B?MzZzOVlRQnduamlKbWI5cGRuUlQ0amRiTmNyM3BVMlJHcUh5c2FpVlZjZyst?=
 =?utf-7?B?TzBqejB1UUNpZFFJZkl5SXZ3Ky1JUzU3RGJJZXF2RklMUjFmRXc4MFFVMzd2?=
 =?utf-7?B?RkJEd04wbXE0UTFLb253Vnp3ckl5NDlwbTQvaVY1eXBYUWxHd3VYVGF4eU11?=
 =?utf-7?B?QW9YOVNrcWkwTHh2aXc4NlFleEtMRUJkWEg2SXR6UkVUVXZma1MvbU9RYVRm?=
 =?utf-7?B?SUx0M1AwMmREVlhLY2owV3V0cmtTMUdMeVNFK0FEMC0=?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR08MB4437.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b617500-3648-4531-cf53-08dbbf22e820
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 06:28:04.6740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iu5miNBvF6aLDa8ReZ+Je/w9FnQK/1ONybmTEa0F0CHEcegF9OWDoEWwzJassL+ZacSTOkFeqUgZimFRiFWlnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR08MB8730
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Micron Confidential

Hello Miquel,

The MPN mt29f4g08abadawp is a single LUN device and it is supposed to suppo=
rt cache read with the limitation reported into the datasheet.

Can you clarify about the IDs list you need?

Thanks.
Regards,
Domenico P.




Micron Confidential
-----Original Message-----
From: Miquel Raynal +ADw-miquel.raynal+AEA-bootlin.com+AD4-
Sent: Tuesday, September 26, 2023 1:27 PM
To: Martin Hundeb+APg-ll +ADw-martin+AEA-geanix.com+AD4-
Cc: Rouven Czerwinski +ADw-r.czerwinski+AEA-pengutronix.de+AD4AOw- M+AOU-ns=
 Rullg+AOU-rd +ADw-mans+AEA-mansr.com+AD4AOw- Alexander Shiyan +ADw-eagle.a=
lexander923+AEA-gmail.com+AD4AOw- Richard Weinberger +ADw-richard+AEA-nod.a=
t+AD4AOw- Vignesh Raghavendra +ADw-vigneshr+AEA-ti.com+AD4AOw- JaimeLiao +A=
Dw-jaimeliao.tw+AEA-gmail.com+AD4AOw- kernel+AEA-pengutronix.de+ADs- stable=
+AEA-vger.kernel.org+ADs- linux-mtd+AEA-lists.infradead.org+ADs- linux-kern=
el+AEA-vger.kernel.org+ADs- Sean Nyekj+AOY-r +ADw-sean+AEA-geanix.com+AD4AO=
w- Domenico Punzo +ADw-dpunzo+AEA-micron.com+AD4AOw- Bean Huo +ADw-beanhuo+=
AEA-micron.com+AD4-
Subject: +AFs-EXT+AF0- Re: +AFs-PATCH v2+AF0- mtd: rawnand: Ensure the nand=
 chip supports cached reads

CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unless you =
recognize the sender and were expecting this message.


Hi Martin,

+- Bean and Domenico, there is a question for you below.

martin+AEA-geanix.com wrote on Mon, 25 Sep 2023 13:01:06 +-0200:

+AD4- Hi Rouven,
+AD4-
+AD4- On Fri, 2023-09-22 at 16:17 +-0200, Rouven Czerwinski wrote:
+AD4- +AD4- Both the JEDEC and ONFI specification say that read cache seque=
ntial
+AD4- +AD4- support is an optional command. This means that we not only nee=
d to
+AD4- +AD4- check whether the individual controller supports the command, w=
e
+AD4- +AD4- also need to check the parameter pages for both ONFI and JEDEC =
NAND
+AD4- +AD4- flashes before enabling sequential cache reads.
+AD4- +AD4-
+AD4- +AD4- This fixes support for NAND flashes which don't support enablin=
g
+AD4- +AD4- cache reads, i.e. Samsung K9F4G08U0F or Toshiba TC58NVG0S3HTA00=
.
+AD4- +AD4-
+AD4- +AD4- Sequential cache reads are now only available for ONFI and JEDE=
C
+AD4- +AD4- devices, if individual vendors implement this, it needs to be
+AD4- +AD4- enabled per vendor.
+AD4- +AD4-
+AD4- +AD4- Tested on i.MX6Q with a Samsung NAND flash chip that doesn't su=
pport
+AD4- +AD4- sequential reads.
+AD4- +AD4-
+AD4- +AD4- Fixes: 003fe4b9545b (+ACI-mtd: rawnand: Support for sequential =
cache
+AD4- +AD4- reads+ACI-)
+AD4- +AD4- Cc: stable+AEA-vger.kernel.org
+AD4- +AD4- Signed-off-by: Rouven Czerwinski +ADw-r.czerwinski+AEA-pengutro=
nix.de+AD4-
+AD4-
+AD4- Thanks for this. It works as expected for my Toshiba chip, obviously
+AD4- because it doesn't use ONFI or JEDEC.
+AD4-
+AD4- Unfortunately, my Micron chip does use ONFI, and it sets the cached-
+AD4- read-supported bit. It then fails when reading afterwords:
+AD4-
+AD4- kernel: ONFI+AF8-OPT+AF8-CMD+AF8-READ+AF8-CACHE +ACM- debug added by =
me
+AD4- kernel: nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xdc
+AD4- kernel: nand: Micron MT29F4G08ABAFAWP
+AD4- kernel: nand: 512 MiB, SLC, erase size: 256 KiB, page size: 4096, OOB
+AD4- size: 256
+AD4- kernel: nand: continued read supported +ACM- debug added by me
+AD4- kernel: Bad block table found at page 131008, version 0x01
+AD4- kernel: Bad block table found at page 130944, version 0x01
+AD4- kernel: 2 fixed-partitions partitions found on MTD device gpmi-nand
+AD4- kernel: Creating 2 MTD partitions on +ACI-gpmi-nand+ACI-:
+AD4- kernel: 0x000000000000-0x000000800000 : +ACI-boot+ACI-
+AD4- kernel: 0x000000800000-0x000020000000 : +ACI-ubi+ACI-
+AD4- kernel: gpmi-nand 1806000.nand-controller: driver registered.
+AD4-
+AD4- ...
+AD4-
+AD4- kernel: ubi0: default fastmap pool size: 100
+AD4- kernel: ubi0: default fastmap WL pool size: 50
+AD4- kernel: ubi0: attaching mtd1
+AD4- kernel: ubi0: scanning is finished
+AD4- kernel: ubi0: attached mtd1 (name +ACI-ubi+ACI-, size 504 MiB)
+AD4- kernel: ubi0: PEB size: 262144 bytes (256 KiB), LEB size: 253952 byte=
s
+AD4- kernel: ubi0: min./max. I/O unit sizes: 4096/4096, sub-page size 4096
+AD4- kernel: ubi0: VID header offset: 4096 (aligned 4096), data offset:
+AD4- 8192
+AD4- kernel: ubi0: good PEBs: 2012, bad PEBs: 4, corrupted PEBs: 0
+AD4- kernel: ubi0: user volume: 9, internal volumes: 1, max. volumes count=
:
+AD4- 128
+AD4- kernel: ubi0: max/mean erase counter: 4/2, WL threshold: 4096, image
+AD4- sequence number: 1431497221
+AD4- kernel: ubi0: available PEBs: 12, total reserved PEBs: 2000, PEBs
+AD4- reserved for bad PEB handling: 36
+AD4- kernel: block ubiblock0+AF8-4: created from ubi0:4(rootfs.a)
+AD4- kernel: ubi0: background thread +ACI-ubi+AF8-bgt0d+ACI- started, PID =
36
+AD4- kernel: block ubiblock0+AF8-6: created from ubi0:6(appfs.a)
+AD4- kernel: block ubiblock0+AF8-7: created from ubi0:7(appfs.b)
+AD4-
+AD4- ...
+AD4-
+AD4- kernel: SQUASHFS error: Unable to read directory block +AFs-4b6d15c:e=
d1+AF0-
+AD4- kernel: SQUASHFS error: Unable to read directory block +AFs-4b6f15e:1=
25+AF0-
+AD4- kernel: SQUASHFS error: Unable to read directory block +AFs-4b6d15c:1=
dae+AF0-
+AD4- kernel: SQUASHFS error: Unable to read directory block +AFs-4b6d15c:e=
d1+AF0-
+AD4- (d-sysctl)+AFs-55+AF0-: systemd-sysctl.service: Failed to set up cred=
entials:
+AD4- Protocol error
+AD4- kernel: SQUASHFS error: Unable to read directory block +AFs-4b73162:1=
4f0+AF0-
+AD4- kernel: SQUASHFS error: Unable to read directory block +AFs-4b6f15e:8=
38+AF0-
+AD4- systemd+AFs-1+AF0-: Starting Create Static Device Nodes in /dev...
+AD4- kernel: SQUASHFS error: Unable to read directory block +AFs-4b6d15c:e=
d1+AF0-
+AD4- kernel: SQUASHFS error: Unable to read directory block +AFs-4b6d15c:e=
d1+AF0-
+AD4- kernel: SQUASHFS error: Unable to read directory block +AFs-4b6f15e:8=
38+AF0-
+AD4- kernel: SQUASHFS error: Unable to read directory block +AFs-4b6d15c:1=
dae+AF0-
+AD4- kernel: SQUASHFS error: Unable to read directory block +AFs-4b6f15e:1=
25+AF0-
+AD4-
+AD4- I've briefly tried adding some error info the the squashfs error
+AD4- messages, but it looks like it's getting bad data. I.e. one failure a
+AD4- sanity check of +AGA-dir+AF8-count+AGA-:
+AD4-
+AD4- if (dir+AF8-count +AD4- SQUASHFS+AF8-DIR+AF8-COUNT)
+AD4-       goto data+AF8-error+ADs-
+AD4-
+AD4- It fails with +AGA-dir+AF8-count+AGA- being 1952803684 ...
+AD4-
+AD4- So is this a case of wrong/bad timings?
+AD4-
+AD4- Miquel:
+AD4- I can tell from the code, that the READCACHESEQ operations are
+AD4- followed by NAND+AF8-OP+AF8-WAIT+AF8-RDY(tR+AF8-max, tRR+AF8-min). Fr=
om the Micron
+AD4- datasheet+AFs-0+AF0-, it should be NAND+AF8-OP+AF8-WAIT+AF8-RDY(tRCBS=
Y+AF8-max, tRR+AF8-min),
+AD4- where tRCBSY is defined to be between 3 and 25 +ALU-s.

I found a place in the ONFI spec states taht tRCBSY+AF8-max should be betwe=
en 3 and tR+AF8-max, so indeed we should be fine on that regard.

However, I asked myself whether we could have issues when crossing boundari=
es. Block boundaries should be fine, however your device does not support c=
rossing plane boundaries, as bit 4 (+ACI-read cache
supported+ACI-) of byte 114 (+ACI-Multi-plane operation attributes+ACI-) in=
 the memory organization block of the parameter page is not set (the value =
of the byte should be 0x0E if I get it right.

Anyway, our main issue here does not seem related to the boundaries. It doe=
s not seem to be explicitly marked anywhere else but on the front
page:
        Advanced command set
        +IBM- Program page cache mode (4)
        +IBM- Read page cache mode (4)
        +IBM- Two-plane commands (4)

        (4) These commands supported only with ECC disabled.

Read page cache mode without ECC makes the feature pretty useless IMHO.

Bean, Domenico, how do we know which devices allow ECC correction during se=
quential page reads and which don't? Is there a (vendor?) bit somewhere in =
the parameter page for that? Do we have any way to know besides a list of d=
evices allowing that? If so, can you provide one with a few IDs?

Thanks,
Miqu+AOg-l
