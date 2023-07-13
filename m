Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26782751838
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 07:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbjGMFgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 01:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjGMFgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 01:36:32 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20615.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::615])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1428119
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 22:36:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/kOgdwz57fToEaTXQhFySRumhQ7FxvagXFAedGQ6xuIj8k6djYmvxQzVJDQN18n0W+yQvGz2lvVFEfhbbjWuELe4KVFUmDxlNu86nzcVxbUB4An5Te7CjpKluut8qpk7rQNATwtlk05wRBjTHl0Pk0y9/Vt1RSio+vqfNa9zHc8yrlQAYr8DPT8mbgKsTF5/bea8Ne5I04KfieCCRGzAYLNthRqBT3VXS61jUfwXUgQoFE8fH9FAJFp2wAvSfg9KzQVIzQkOA9ETyimzw5wkZrJRljTJR1jRaVDBOKhHdhg3t81AgH8O3etU9u10luVFP2RDt9Dd1fMkr1K5kOqSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7uVdiAIX3LPAdIQNeIKky1S1cviTKUFcyLfIplm5qE=;
 b=aDp4wOmprJIpkL6N+CNmRET8+aroRsNtExqXs3tF41FCOgfkjiUeLNz2hkjpdhAzO2uD+O8ukrv+GWZQ4cHx5IFk/ISmWWXihv3FgLLpvF8RbyyoHsGE56v372GvOpLpO1stRwhL2RIrgGlNt3q424Ve1W2+KybDvyL+/hxMudVZMaadTar9yWSZHKUBgoAid7GQj9Vjm19+LvTjmDYcl49c/38ubhr2056JrqPUdpgN4MZiQaoFj4HtTtxx+95xC6ydZBzq1CKtXUFagrGjjomgnzHVlTxldIH51AQoiezfAAOA221KYCzXumbHGuRVB9sdpmX8OMH1NLZWYZbw0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7uVdiAIX3LPAdIQNeIKky1S1cviTKUFcyLfIplm5qE=;
 b=cRjKiznUzqBQL/ceWNhxdOLFHhiRyHEweebITNJXx51AtiUrwEqQPkCvV9b0U39Rpyv1o+nacickykET/CZ2SmsqEs5iBVInRfxcDEf6DQstMeny1qxWDBQ018PhBAcHTs4YuRQXG5Yc06nRtT1klDcR0ZlRiJqfIhyMg0Ekl0A=
Received: from DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:102::7) by
 SJ2PR12MB8875.namprd12.prod.outlook.com (2603:10b6:a03:543::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Thu, 13 Jul
 2023 05:36:27 +0000
Received: from DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::8d98:f5c2:35b:e9ff]) by DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::8d98:f5c2:35b:e9ff%6]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 05:36:26 +0000
From:   "Gangurde, Abhijit" <abhijit.gangurde@amd.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gupta, Nipun" <Nipun.Gupta@amd.com>,
        "Agarwal, Nikhil" <nikhil.agarwal@amd.com>,
        "Gupta, Puneet (DCG-ENG)" <puneet.gupta@amd.com>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Jansen Van Vuuren, Pieter" <pieter.jansen-van-vuuren@amd.com>
Subject: RE: [PATCH 3/4] cdx: create sysfs resource files
Thread-Topic: [PATCH 3/4] cdx: create sysfs resource files
Thread-Index: AQHZs/Eml7wv+9Hf8ECAZ85drm3xW6+0mECAgAF+O2CAACfLAIAA7OJA
Date:   Thu, 13 Jul 2023 05:36:25 +0000
Message-ID: <DM4PR12MB7765AEF30AA787C246852C0C8F37A@DM4PR12MB7765.namprd12.prod.outlook.com>
References: <20230711121027.936487-1-abhijit.gangurde@amd.com>
 <20230711121027.936487-4-abhijit.gangurde@amd.com>
 <2023071148-grievance-gulf-0841@gregkh>
 <DM4PR12MB776565FAF9F3797643C9AFA78F36A@DM4PR12MB7765.namprd12.prod.outlook.com>
 <2023071231-drinking-unskilled-3c00@gregkh>
In-Reply-To: <2023071231-drinking-unskilled-3c00@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=81762e48-3f46-492a-bcb3-6090ed54868e;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-13T05:18:55Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB7765:EE_|SJ2PR12MB8875:EE_
x-ms-office365-filtering-correlation-id: e34871f2-5836-4422-9073-08db836319b2
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c7KCL6m0T3LQE0ptQkAmkbypUrg2pmzsD1rfp0940dFTfryg8qLVCKu/RVZ/UtV3y0URbbreHZuIXHXI04jVyU6v4rOlKQaonIiSX8nexna29yB6AjWW/SES9Q+s3Vu1L5iKBB+dvVHLDFoIRL325+5ehSCbas0pMKpZGllk9cgVdjwKorPi7lY5O7f8ZuD7sZ+++69Av+U/Dp8QjSncOI5xp2nWk3yz3K0C6uh2VoJrUoghibp86vTcnyv5RzmjL8EhCcVIlzXI1gbycx13lwBJ2A/yuNaxKJICibeeWcHYmOxLsUZjlfq05ZUe8ce5iO3LimnS77bfk7/VpcEtiZILAkL/C3TMGHSDSphAF59+tWqM4qqPHvYncEFw1KoO1t2yfwTSQMJsrSe4+fpCHjVpDtuXwGIW5X4/AZ0xdb7ru9ETwFk/medadjJpS/ge4oPRxzTO9EaYZPR9FJ0acH0J7woTMeAeNPM2SHRlAJE5BXqopunzfPHRKuBEWbjpCZn2DmygkLk68X/H6jTXOdaKRITpeoHpSn5nlwXrEH7Wx4bMCpHxGHFsw7t5itxLfhFmN770XqoccPGbW6gVFLfN+Qdb5TVmaD+Rz3mekr+gwx/0fJdZxtVRgK5b2w5r
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7765.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199021)(186003)(52536014)(26005)(5660300002)(33656002)(6506007)(76116006)(9686003)(6916009)(66446008)(8936002)(2906002)(64756008)(4326008)(83380400001)(41300700001)(316002)(66556008)(66946007)(66476007)(8676002)(478600001)(7696005)(54906003)(71200400001)(55016003)(122000001)(38100700002)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WcPta9SvjiKn2mXDY0fXn0iWeqwBk3hLDUUYLQBYtgrH2Mf1jaCRnkGqNdvB?=
 =?us-ascii?Q?sVRQN7GJ8L6+9lTI6eoTkCLBg2Un6HeXquspIq1XCJwn+Dn46XX1e6jmZb4r?=
 =?us-ascii?Q?0P2Y8FcSFu1cJh5fDQJrxmFg0xmb65aHMBZ0w93YScGc6an6wqd25M5+YeYi?=
 =?us-ascii?Q?l9LJNTW5qkfUg1l0uF/A8Vi/gSGkMy8FRSjoNNsTZdFPnPvZKQo4+7jEC5gP?=
 =?us-ascii?Q?BQ/mpaQLl85olCr9c2mH9NkZ4tElo1lABVuQ3kOZ5nQy9kVI3X/0GR0JgTrq?=
 =?us-ascii?Q?7lGsYH3GODCsTK5gaF5s8hhOD4RAkh085BcUBlgwIuJL8XvJIAyVQfgzE0tW?=
 =?us-ascii?Q?mwoKnhUxdLRFo5AOLqUrKx4jk6M1KS2z51K8UjIR8+XsYPpjU8bvNowEHtM5?=
 =?us-ascii?Q?wFVvDzv9NWONDxN95OdH0faGISK57JeSd7MhtEGNsnSGpyKzBesvQoiTl1nQ?=
 =?us-ascii?Q?Zi5YxwGG0CSRAHiYunM2uAf/wHROxtQtYoDi7RA+uIIHt1EJsPoA5wntn5ZN?=
 =?us-ascii?Q?MpQHuiSkmFlq2Ju0aHUfHY8BD+ExjQoaPnp///YhmEqAMArxRV7C5u4TNx8v?=
 =?us-ascii?Q?JjmrAvd7p8iM03kyUroYzZio5am9y1l4LZCEnHFPBDKaXTyCPz4Qq0ibWSHy?=
 =?us-ascii?Q?VpqaixFzQQ9zjC5bkz8HRBVRQNI3CJoaOM0mF4PTNX3OXOmKzO0SYoTLsBe4?=
 =?us-ascii?Q?d0qc9Mp2BOgB218Jo2GbQpnG37DxC6z9DLEgWNh8TVzFL0WaBmFiurG1wLDI?=
 =?us-ascii?Q?aNTikFsrjhjDA6q5XG4c4RMFugiG2+DSbrHnu0VpCnqKLoofsx7Is6e85OHQ?=
 =?us-ascii?Q?I3my+qoy2c2oFwh4f3F8hqfT1E2x2//QV3t8MAmwzlczBLXBG/0DL4JslryE?=
 =?us-ascii?Q?TMJke81f1GYa0K5yrVwn8n7x/ID5fMpO6nF4Y2nWMAHeAQsmXcRAdLPZZDY1?=
 =?us-ascii?Q?Q4iyXOAhkEXhuf90CX1BRktFvxxRnWPAr+EN7SkUhrlOHv+aZgVadDh7Mc7h?=
 =?us-ascii?Q?HCqebTXfObAfhL7xTX3/4z9/dTj6SgcAFz+Y6oHK/UBYHVs77EKN3CcYfYiN?=
 =?us-ascii?Q?qfRtoHwLECAuXY7V8+LDRQyydM+Mx5tyHDLwhgpm43Fhft19vT7gAkLdLbZ/?=
 =?us-ascii?Q?rSz/3fu+d2VJyOT/aA1NpiiJs5Ah4eYTWXxtQM9YCqct5ahStB0mUdI5dnmd?=
 =?us-ascii?Q?YNP+j2YcHm8vWlhhNRoe6dPWDWW3o0hBPCq5JGkg+xkouNNbTtdAjHVHKEiA?=
 =?us-ascii?Q?o2yAL1XJ4MDJUdbmx7sUhBU3lckxldYkr9SKxVLRZl3qSP/mB4w1z6jX59j9?=
 =?us-ascii?Q?cNPmw38ju1B4WPxLtyw1CIQLYaAnmeAWMBGZNx6Q03izum0HSjs8beLtKZpD?=
 =?us-ascii?Q?UiYcqwyVjPBm1hCvIGKPkZ8TICcQ8WnnrqiMrOTg9Pk7+ntFjC6bgUz3QExI?=
 =?us-ascii?Q?FWUxUW2Wf0kvmqgiN8uHQUwO7+Pa6Ihbpfy6Itu7trJ79+yGtaTQUi0eOMS+?=
 =?us-ascii?Q?KhpGkSE4Kut297YGDQzVqTrssSuFCHPas0RMH0SvrErgzfs33Ozg/cAql5tf?=
 =?us-ascii?Q?a49Xm2SJEaJw7og1D80=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7765.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e34871f2-5836-4422-9073-08db836319b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 05:36:25.8665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BliBzrAgYm7xwJRbykZwFohQ0kchJUfMEH90iwL38yV/8ip/lVhM4+bPPNSBkNDzh6kfmD7KjG+D6TztlpDJqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8875
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

> > > > Resource files provides the basic MMIO regions info to the
> > > > user-space. Also, resources<x> devices can be used to mmap the
> > > > MMIO regions in the user-space.
> > > >
> > > > Co-developed-by: Puneet Gupta <puneet.gupta@amd.com>
> > > > Signed-off-by: Puneet Gupta <puneet.gupta@amd.com>
> > > > Co-developed-by: Nipun Gupta <nipun.gupta@amd.com>
> > > > Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> > > > Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> > > > Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-
> > > vuuren@amd.com>
> > > > Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> > > > ---
> > > >  Documentation/ABI/testing/sysfs-bus-cdx |  15 +++
> > > >  drivers/cdx/cdx.c                       | 139 ++++++++++++++++++++=
+++-
> > > >  include/linux/cdx/cdx_bus.h             |  10 ++
> > > >  3 files changed, 163 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/Documentation/ABI/testing/sysfs-bus-cdx
> > > b/Documentation/ABI/testing/sysfs-bus-cdx
> > > > index d9e00058471d..6ca47b6442ce 100644
> > > > --- a/Documentation/ABI/testing/sysfs-bus-cdx
> > > > +++ b/Documentation/ABI/testing/sysfs-bus-cdx
> > > > @@ -76,3 +76,18 @@ Description:
> > > >             For example::
> > > >
> > > >               # echo 1 > /sys/bus/cdx/devices/.../remove
> > > > +
> > > > +What:              /sys/bus/cdx/devices/.../resource
> > > > +Date:              July 2023
> > > > +Contact:   puneet.gupta@amd.com
> > > > +Description:
> > > > +           The resource file contains host addresses of CDX device
> > > > +           resources. Each line of the resource file describes a r=
egion
> > > > +           with start, end, and flag fields.
> > >
> > > If you documented what this file looked like here, it would be obviou=
s
> > > that this is not an acceptable sysfs file in any sense of the word.
> > >
> > > Please do so, and then fix the patch to not do that at all.
> >
> > Similar interface exist for pci and we intended to keep it same way. Co=
uld you
> please elaborate on this.
> >
> > # cat /sys/bus/pci/devices/0000\:01\:00.0/resource
> > 0x0000000092100000 0x00000000921fffff 0x000000000014220c
> > 0x0000000000000000 0x0000000000000000 0x0000000000000000
>
> Please don't propagate incorrect decisions in the past.
>
> Why do you need all of these "resources" in userspace?  What tool is
> going to read and parse them and do something with them?
>
> This really violates the "one value per file" sysfs rule, you are going
> to have to have a huge reason why this is not applicable here, AND you
> are going to have to document it very very well and get everyone to
> agree with it.

We don't have any strong reason apart from that this is being used by some
test and debug applications. Will drop this one now and revisit later by
complying to the specifications.

Thanks,
Abhijit
