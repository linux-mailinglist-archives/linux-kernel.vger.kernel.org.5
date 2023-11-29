Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C47E7FD60F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbjK2LxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjK2LxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:53:17 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAC510D1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:53:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q76unpK5IoeqYsJcR5iTCGGtLLLMFh/unIdD85l4tYHM922BZRhV+Bcwwk5tmSbJ3sW7I1s8U56J2lZ9xzZBpWfSFInuirt70Mxt6uK37Ox0G5bmubH4IlwxUWVGddlnEohyJq4egnOj1c1PyRdLM1Hard28TABZL+iuvwfvSn+fW+7VcqqAzW2G3SE1bvo0LYSyPuRV1QyYdUMhsPiRf7Wkx1kbMbocOeFuP8zRzsdLGdoM3493H/jOlB6OYx1QsHRZsVM7hV3narEaRQk3ZzD1XLvytUfufIBWu5Qv3f3bbnHJyxQZCSMTsg7vkBfEkqUpKywbT+RaGP9BECgPHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEqPdD/iG4/Krbj7I2anU7KThg90rrsAlS1U8DNIqys=;
 b=WLgI2KiyCB3fjFHdehUE75R/xwLlSdsws+gl9FJoaJxA2nMlOshUyF7/+muzgk5y+6PWi2yBAl+66cF1ZZAyPbU4HXBLO0eozRCE2xi+dZFwPg4tZ0uR+NYk6g58RD/Hg3yOOjPVidUsdExIARMKbmW9rNsj3fI1ykb52Qa8V2//9GH5Ai0B72CtvGFARqkKRvB23b16PDJ8oZbstmmJu+rkOr2qHzptNYizUysGorU8gPo1WAjMsgbTQx7Z7AWYdHTqNwhOtmTRdUP3jvY7xPy6fI6AGcuQDbCEqM0cgx1Wyt3xIE++YqlbKkAYdQ6WMkqMv8+OP7BvOUNig2KdHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEqPdD/iG4/Krbj7I2anU7KThg90rrsAlS1U8DNIqys=;
 b=TFVBXBMpq2eRsG8mPoa1ON5HHPMtKDeOK9nbPnB/cfo3O/lXUPAIdKliMk/Jhsz5Apne/4vTG8h1vC2zCAN9yWINaNB78lq7io1TzTk0OJWsJEbBP03So1qI+IvjP177UAX/GWbGfvvS8y4+G7s7hMpeKOILUkuDkMXLqO9mH44=
Received: from LV8PR12MB9206.namprd12.prod.outlook.com (2603:10b6:408:186::21)
 by PH0PR12MB8005.namprd12.prod.outlook.com (2603:10b6:510:26c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Wed, 29 Nov
 2023 11:53:19 +0000
Received: from LV8PR12MB9206.namprd12.prod.outlook.com
 ([fe80::198c:81ec:7ee4:cb16]) by LV8PR12MB9206.namprd12.prod.outlook.com
 ([fe80::198c:81ec:7ee4:cb16%5]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 11:53:18 +0000
From:   "Jain, Ronak" <ronak.jain@amd.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        "Simek, Michal" <michal.simek@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>,
        "Shah, Tanmay" <tanmay.shah@amd.com>,
        "Levinsky, Ben" <ben.levinsky@amd.com>,
        "Manne, Nava kishore" <nava.kishore.manne@amd.com>,
        Rob Herring <robh@kernel.org>,
        "dhaval.r.shah@amd.com" <dhaval.r.shah@amd.com>,
        Marek Vasut <marex@denx.de>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] xilinx: firmware: Add sysfs to get last reset reason
Thread-Topic: [PATCH 2/2] xilinx: firmware: Add sysfs to get last reset reason
Thread-Index: AQHaHHaDG9siT7/w/EaE/xT1XrS8RbCRO5LA
Date:   Wed, 29 Nov 2023 11:53:18 +0000
Message-ID: <LV8PR12MB92068766389708E9209DA8338683A@LV8PR12MB9206.namprd12.prod.outlook.com>
References: <20231121112056.1762641-1-ronak.jain@amd.com>
 <20231121112056.1762641-3-ronak.jain@amd.com>
 <35f4c415-1d26-447f-91bd-eb192201c998@app.fastmail.com>
In-Reply-To: <35f4c415-1d26-447f-91bd-eb192201c998@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR12MB9206:EE_|PH0PR12MB8005:EE_
x-ms-office365-filtering-correlation-id: 4de2db40-254e-4065-3fe6-08dbf0d1c772
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZvmFxVUvgUpctHSsnav74Dvjzo+yoIJOdYr6yTVdr5d7QEf9LK/44u/cda8WncwY4mFKGnvwBuUmmtj8syzuZnv1lUxDUxzVQqx9369L1V3l5x4v4qWaflvsVSe82ISlY9gE6eh8zvj+D3RiEpmm2q8pgVGv+1kWZuN7DKKHWGDvpGHNR5dWO/kUBIibx3O+srIz8Cw2qnekYUj0ibXGj6oE7sOJT6jYXEFMHE2hXuZ8EeTpdzxPumNG1JoezgEiWbkOTXwRpoGQsBtSktaJ+ABWrvxopyafnZ9tkyKQnr3SSPBxiDoXI4DFB0hk9d+Q/2PMSNf8EWe7i15JWvON3JScDIJMT0DwQq5D/nV77hCtTt+TxYk4MFIeblQBjwEjuXQiSKgNBaZBj+42Y+jQnI5nDbD51j2rI2xCsRbQebLdR5+d+rUSPocwLxtPdlcRI6XioBU8nGzJSnVgro8YOTj5F0v/6Rx6ogGnZdhR4xty8XANMMcDVndBaBRFSyluL9yQH3q4hYSPJuf0vhFiAhadMcPjdpc/BEMpf/VJa6u4tvBessOl++PxrEMsn6VtJkdpYDkHcnUHar6NnK0k4jmyBfMox/7s9rDHWpsVBzFeJGpM7K4rDFP46IufZx6D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9206.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(366004)(396003)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(38100700002)(41300700001)(921008)(86362001)(33656002)(38070700009)(122000001)(55016003)(83380400001)(5660300002)(26005)(71200400001)(9686003)(53546011)(7696005)(6506007)(2906002)(52536014)(4326008)(8676002)(8936002)(478600001)(6636002)(66946007)(64756008)(66556008)(76116006)(66446008)(110136005)(66476007)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6m351ON1JCoUg/wYDtg8Yuy5SWiKQ0+jopbrFcfVgaoNtOmIfi3K8D7SjDiw?=
 =?us-ascii?Q?/oNEKnvyOiRMloIL7eofR8cj6RkJcT2OClGhjVK6onQYYp8cbn3Gzzi28u2i?=
 =?us-ascii?Q?sHDHaHTMfssC7SNTR+W9DCZD6Ts4ew0z64lMvhPs5r3bJMcx0L4+q0tYQyWO?=
 =?us-ascii?Q?MwHniIDDpv+BXVAgrH9/E/AkNxBrFZmSUi9KG5E1du7SgtLb6olYhaSrk6bT?=
 =?us-ascii?Q?+SC/SicQ0tHsj5VPu1gtFBSFrGPOXjxFcC+N9O6+qm2Ev4ble84U7s+/MD4F?=
 =?us-ascii?Q?IgQlGfdYwddX92TuAr3UskGVC45KIaS/wI1yNc3U5Ydtub+M7d4GgLuaDpuP?=
 =?us-ascii?Q?/YTR5KEsy2HpMMXfPDvoLl25RlzMNv/Zb3Fe9qOmPZCLELDkpbOPKy6EqCqa?=
 =?us-ascii?Q?0SpoV9tBFZl+MDJH/1j7Y35UloR5oaB/m44u7w72exVFVZJyc4HWaDzEfr6V?=
 =?us-ascii?Q?KVwuPUWBa5VMwuIq0V5ZW8/Csj4COBjCjB0j5JTrEKR3wG+fu3f8pPY+zN6P?=
 =?us-ascii?Q?psZi6xxPLGWwcnJ7wKKlttAat1LjRcxqGFI3v8BgOTHZ+yom8DZxk7mYeJZr?=
 =?us-ascii?Q?YAOaz96HWJJ2PWL+Mk//EJ3kw8h6ChoxHHgy2MNebk2g7kzdU1G0mm4sRwOq?=
 =?us-ascii?Q?JJ2tiV2Pa08gD/jc86DurSBjcBZmFxZjvjhDWcmDRJqK93aWpNNVcoBWGRMM?=
 =?us-ascii?Q?qiPBwcFJbdgtajx6cbfRO+E9CiylMsTSjySawEEhFPEtZT5M2wZm+vjLlRUu?=
 =?us-ascii?Q?TZmB41PiX64MLEDAbqM/IKZePJBsDNd17qfRNjAZj8FR9vd9YUtHFugJhzw7?=
 =?us-ascii?Q?6rixup09XqC4xX7NGc5OSRvaDAhPkK3U7wdSmtP2vLFxxVDmELUME6wzDqp6?=
 =?us-ascii?Q?Qyb3dwCjI9gk74bhmOFJLmVnaiNuWiRBK2orZ1d0K7zD0oKWGYrBfD6Ppfai?=
 =?us-ascii?Q?VmsgljSwz4OL2/KPZsQ2ND1evdaeKiE4fsW4VGBcu+uvzyY2EGB7nt/AalJv?=
 =?us-ascii?Q?8UCTqOWGZ5KFe40WQa9N5zzRAJCiB/fHpAc2E1P6D8Z5THJob57ijyA+/5X9?=
 =?us-ascii?Q?fsiaosY/fbfLPSVuviZQjwqBTbPdEtupjGU20B57zAVQeRINqqo5BluswVkJ?=
 =?us-ascii?Q?R4zy9klYz2zFSGw6K2Pvghq+rob85r9/zkG+Q0/T9cHC4aOOFJblZFb5F9kt?=
 =?us-ascii?Q?8AAy26WSeS3oI2y4Zy73TqWt69NoVNAvsAENklQ6rzziJGrjwZhZL5d3xPre?=
 =?us-ascii?Q?SplgSRxTtYYqJ0ksYdXVE2WbI4Q93PajGAHd75S+uF2i+S20dnz3P7PqAFi5?=
 =?us-ascii?Q?E7n+ed6MQ920d4Uft4u3o9geM8s3Wx5FTgc66rvN8PFtu31TtFgiXZ8KMvUT?=
 =?us-ascii?Q?nPCMuqteehOCdz7JD2OKGXtLNTXT79ahF0m73M/sJIUz2NdLNwnAFVRBjYtR?=
 =?us-ascii?Q?O8GcxXFwO4pGcRsllsXvae/5bmUI39sIfB5b7wex/IfHj5HHz+VTJGED7wy0?=
 =?us-ascii?Q?AoOV6H5UjQ8aHabgfBl3D21BSIjMN/WoHUOK+3p/x1XDqpKofQhr1krF+oLp?=
 =?us-ascii?Q?4A3T5YTndlLwO6/mh28=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9206.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de2db40-254e-4065-3fe6-08dbf0d1c772
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2023 11:53:18.7461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OF9yDegxYFjoShjkbHg0DFUl/YVveX/rXfskWsTt3mqZbJzA6l/ixRV2wprtxnDn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8005
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

> -----Original Message-----
> From: Arnd Bergmann <arnd@arndb.de>
> Sent: Tuesday, November 21, 2023 6:01 PM
> To: Jain, Ronak <ronak.jain@amd.com>; Simek, Michal
> <michal.simek@amd.com>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; Linus Walleij <linus.walleij@linaro.org>;
> Potthuri, Sai Krishna <sai.krishna.potthuri@amd.com>; Shah, Tanmay
> <tanmay.shah@amd.com>; Levinsky, Ben <ben.levinsky@amd.com>; Manne,
> Nava kishore <nava.kishore.manne@amd.com>; Rob Herring
> <robh@kernel.org>; dhaval.r.shah@amd.com; Marek Vasut
> <marex@denx.de>; Roman Gushchin <roman.gushchin@linux.dev>; Mathieu
> Poirier <mathieu.poirier@linaro.org>; Datta, Shubhrajyoti
> <shubhrajyoti.datta@amd.com>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 2/2] xilinx: firmware: Add sysfs to get last reset re=
ason
>=20
> On Tue, Nov 21, 2023, at 12:20, Ronak Jain wrote:
> > Add sysfs interface to get the last reset reason of the system from
> > a user space.
> >
> > When the system reset happens whether intentionally or due to some
> > errors, the firmware used to store the last reset reason and the same
> > be queried by using the IOCTL API or the sysfs entry to know the
> > reason behind the system reset and accordingly, the error can be
> > diagnostic.
> >
> > Signed-off-by: Ronak Jain <ronak.jain@amd.com>
>=20
> I'm fairly sure we already have other interfaces to access
> the reset reason, please see if you can either reuse one
> of the existing ones, or come up with a generic one that
> can be used by others as well.
Could you please provide more information regarding the interface you're ta=
lking about?

Thanks,
Ronak
>=20
>       Arnd
