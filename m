Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CA37C6F74
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378887AbjJLNl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235537AbjJLNlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:41:25 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26984BA;
        Thu, 12 Oct 2023 06:41:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QgAfCx8KnyBoyMxmI5/lXTSS6xQIromsuSY+xYTm3d4PtHtfHx50HYeOcVShVKLJ35GQYApNhrGbLzpIHt7CNM/G9bfCU08Ehzz0Ro64dFRvCiZSsGwiOBKWT+K/muN+IurEgek6bX76XLS6UwNmatL+ZFjTKXNA7UFhqz2SxCc3aB4Z196Fo2Um3OYKSBZYhOOZiwR7cAqo2dtYaqBhOo5V1dLy365IrIvtQ5mGlqeU3ZVdTyFMWnE72Xns0Bh8pDQ6eDT84ZwO6m4iZisZO/Ab3EeTzw+O7i73MGqILcsvWDrIjunmO7HnxLnN9bqO3qE2sWJmlyLxO3th1WX2zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TX1L4Aa6HtbiqgV2RZH7kbOx7zvLs3wzZPeQ2HbBl7k=;
 b=Y8nP0yNXLjjdDu2cw2ZrvMIxUSkf1RNqD7zhm6pKFFkIVW1JFumrsttPIzf2LoUopvDcBRt3xB/J73YsfuPxdZEuMm4xOYmKm4wMUgjrciUGETxKyrrO/qfHYk8ZfZvfFC1fRXNxhpgdBg5OL0qBu1lKRsMZrkxisxFtQmqxMEC3lfx4OcgDxCq8b0azYJF7BTV1pnfrwLtQmbuK7Hn1N0ap8I5k94C/K2NbQe7VBwMp1QQ8+24VegOlCkapx7eupha7tw6wXRmrvR8W4ViLyE06zMX5aZP4hdCa6SLkOZacARdhvIm1GA+qoUfZt+tsZLEzt9zEzur2pR0cY1ezjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TX1L4Aa6HtbiqgV2RZH7kbOx7zvLs3wzZPeQ2HbBl7k=;
 b=jy5UBTDpxWXRwNKVhdWOHulFMVD4VYzgryFLgzejUdCKDMm1u8j5Bo2azyzMrCBdOoPlX3EE/MrwDdYmB082WHEpyEOcigo/pM+Z3qANgO4bl623PVeEh1RLJHHODG7lencT6rqCTozkb//x8N9ltb9AndJLvg+puhY1WvEuahk=
Received: from BL0PR12MB4673.namprd12.prod.outlook.com (2603:10b6:207:1d::16)
 by DM4PR12MB6230.namprd12.prod.outlook.com (2603:10b6:8:a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Thu, 12 Oct
 2023 13:41:20 +0000
Received: from BL0PR12MB4673.namprd12.prod.outlook.com
 ([fe80::262d:85ff:ef23:629e]) by BL0PR12MB4673.namprd12.prod.outlook.com
 ([fe80::262d:85ff:ef23:629e%7]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 13:41:19 +0000
From:   "Sridharan, Vilas" <Vilas.Sridharan@amd.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        "Duran, Leo" <leo.duran@amd.com>,
        "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
CC:     David Rientjes <rientjes@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Grimm, Jon" <Jon.Grimm@amd.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "shiju.jose@huawei.com" <shiju.jose@huawei.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "david@redhat.com" <david@redhat.com>,
        "jthoughton@google.com" <jthoughton@google.com>,
        "somasundaram.a@hpe.com" <somasundaram.a@hpe.com>,
        "erdemaktas@google.com" <erdemaktas@google.com>,
        "pgonda@google.com" <pgonda@google.com>,
        "duenwen@google.com" <duenwen@google.com>,
        "mike.malvestuto@intel.com" <mike.malvestuto@intel.com>,
        "gthelen@google.com" <gthelen@google.com>,
        "tanxiaofei@huawei.com" <tanxiaofei@huawei.com>,
        "prime.zeng@hisilicon.com" <prime.zeng@hisilicon.com>
Subject: RE: [RFC PATCH 2/9] memory: scrub: sysfs: Add Documentation entries
 for set of scrub attributes
Thread-Topic: [RFC PATCH 2/9] memory: scrub: sysfs: Add Documentation entries
 for set of scrub attributes
Thread-Index: AQHZ5/onsXhE7XQ22EC/SjWOQvHCtrAmAXoAgACrR4CACRvJAIAK3KYAgAI1jgCAAACIEIAIFsaAgAFfnSA=
Date:   Thu, 12 Oct 2023 13:41:19 +0000
Message-ID: <BL0PR12MB4673336E2BD4686AFF5EE737EAD3A@BL0PR12MB4673.namprd12.prod.outlook.com>
References: <20230915172818.761-1-shiju.jose@huawei.com>
        <20230915172818.761-3-shiju.jose@huawei.com>
        <CACw3F50jRzJnr9h7qYyD3t+6h7Uw9QMfkCkgu7a=7Lv0Tpi8Zg@mail.gmail.com>
        <20230922111740.000046d7@huawei.com>
        <CACw3F539gZc0FoJLo6VvYSyZmeWZ3Pbec7AzsH+MYUJJNzQbUQ@mail.gmail.com>
        <92f48c1c-3235-49b2-aabd-7da87ad3febc@google.com>
        <20231006140224.000018a2@Huawei.com>
        <BL0PR12MB4673F5E024B62D64B065DBE4EAC9A@BL0PR12MB4673.namprd12.prod.outlook.com>
 <20231011173553.00001b39@Huawei.com>
In-Reply-To: <20231011173553.00001b39@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b374e1d4-a78a-4b7e-a233-5b7a388c3597;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-12T13:34:21Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB4673:EE_|DM4PR12MB6230:EE_
x-ms-office365-filtering-correlation-id: 799efb24-510f-41eb-7829-08dbcb28ea98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1sF2rCr34QMODJV9JcigyRtljIelckZdi3c/8RFHOgou6wdh4yDguXCTfq9Mwe19pOly3kCaZvp7M4xVn8n/cJmTO/yC/rO31Cq7DFfH98DtfA7zxRNM18GT1tHGfHESk5uL4pG4/JVOlsGwob6P1zWSiBPv3CJL41mv69DcK/pKMCgl4Xxk32vEA1CN1NZXVtGQMab3qtlYrgcBSWlCA3OF2v5yOa2YsL3PfJSqD9+vB1vS8mYhz889UZx83bubKLGkjfYaFQn/scdoaKrRSH7UMv6vbN7Sk7Z+KiYo5Ar9F2DzjrBz991aZ+TYikOirON2JNDBnzrZyFxZLFpW+xPN8z7tyBLeOVLah+7feHP428xNDyVaD8RkEUKyl2KVHkdOojRQKj6EB9twPSliSCv4Mh9Tru6ZXKFn3ySx5G9W2+eArnhS3OrTUY7UV2QT9GVlPeNnvsPaAtvNwBX6PvsbriI7phBVj6aMq7nLjNi2kobnTW0y1vurOdpWF7a2VG3+EqyVp1x6hRncl8JnxmeVWDKXMQkMXrVibMn03rVEir6qcv3dI5pJMmeUzauTD1Mxt57/+4fCZUiiVgcqEnpER/hTdRjQNN1RYNPm55BKnnamivSNzorNaQI/u3qu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4673.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(39860400002)(346002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(26005)(6636002)(66946007)(66476007)(66556008)(66446008)(64756008)(54906003)(316002)(83380400001)(66899024)(55016003)(110136005)(76116006)(52536014)(5660300002)(86362001)(478600001)(6506007)(7696005)(53546011)(7416002)(71200400001)(8676002)(4326008)(122000001)(2906002)(8936002)(38070700005)(38100700002)(33656002)(9686003)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v+GEyu+NQsxwxE2+YxSY8dKld1p2GhJ3TrKm4KL2ldj9I9guxSUAZ0PXz6RT?=
 =?us-ascii?Q?r2FUs1a0whN2brHyC6+oOuQbX3T6mjMLKBO42CiAzGvXzMRyuetyxWFdHDpW?=
 =?us-ascii?Q?ENOF6aRZ3S1SRTJs4JYUsUDiHAKN3QVo6XBm0SsmVba4V92tgwj/3cv7Aeei?=
 =?us-ascii?Q?njyZlenpbqfLz3V6Jto43mZu2g8zuped3zVWag2jSKqV9NWlHuIOtk3QfgWf?=
 =?us-ascii?Q?s9gFtO0yPLDEXLFLsD/BIwKC0+eR9P8HnWw8Uxwn49G0/H0Tlsa9zvAqhsjI?=
 =?us-ascii?Q?2RFfwRIawSAEGHpDEVslE4FCZdcIqAwCxvGJ0H/UNoBAcscRdbK7Edudinvj?=
 =?us-ascii?Q?GnScFwlVpFCtAr5rboXugyQmFPUsFuzVXHxis4iiBv7vhF42efRPCE0HoAJW?=
 =?us-ascii?Q?QhuURm3m3+lXsa1i019focyJSh2ElAkgsajNfZqVJCXocOHdQsnbAKcZ4V0B?=
 =?us-ascii?Q?TgiKiUXvJwR8v9Z3mLBtAcEtFnB/jS6JM/bwjUh7HCWymj9kSWzUHHQt+3lv?=
 =?us-ascii?Q?2nxhhsyXJzo9w4Jf0as9BUEIrJ4fTC4q6BybH+m01UM6tLu5RPx3n7By+n7R?=
 =?us-ascii?Q?HbrthS3w3ZI3gt57paDFu8/Ff/EAoz4CZuIcrIIYF/1aJDJJ56o+BhkrnZsX?=
 =?us-ascii?Q?8WkIICM+ZzYUWV4L8MLSVZhYnWnaRplpw/LSK0oyVw7uo//4CFnALAO4x9jr?=
 =?us-ascii?Q?Vwd9OkNHbOt1hKazjlpRapCUsmvI7Zjakfyz8M59qH65Ct6mG6p6DLQzDJkw?=
 =?us-ascii?Q?ygF7ZNQ9kbrUOojDeWk8WjZAzNzV+wDzkslEVA8bx0jaTPy1rzHWp7gtsfiV?=
 =?us-ascii?Q?b3JwrsNIpqXCQ98HllrcuaCTc6pdVbM7Or+roMoLqKBDoFmV7L3PgVEQnX+U?=
 =?us-ascii?Q?WZLFOz2MYodyWjDoTl/K7HeSdK/hHpnldVW9mYV5r25Du0yvCZ/T0a+KuHol?=
 =?us-ascii?Q?9KHDhu/ORyDChtbgfnvFlK7I7DPImBoOTsm1XG/MV5EpipFw/vQKVw8hsSgP?=
 =?us-ascii?Q?6Fg31vu9IkIfMUfz54zUlzCWFIG8jrUrdE7HYgpkh6sisIr4O4p93WJvC0YX?=
 =?us-ascii?Q?SKCVCyibqdt9SlAImhjRd4Q1uM+4/MFrNxHRl7ycWVvJLqrtBKB9C47ojV0A?=
 =?us-ascii?Q?D55VFU0PsCYJhbdNm8nr4aFcMTtmqH1Zv5hcjRssxSbD29Db0+SchhlI8bwC?=
 =?us-ascii?Q?9Hx2W2sDhq0KTSeXav7gn/bKyWMBUWovuOQBKgy5OqPqKF0rz14qZ+79N8q/?=
 =?us-ascii?Q?ECxETZg9XEaWmdCzjLdf9bDYjuH4GHzwwJolU6ljZgR/jZAXJx0Ca9sYo3M4?=
 =?us-ascii?Q?2jpD8YnF+ORGeU89rhC4vR7VlTwicEtQcP2F7JpaeE9+b9gvWsWVZkOqIAzH?=
 =?us-ascii?Q?gz2q3HvO5YXRowZ1rzAZMWxR9SlLU+IBFrLposbngYfnw3mVcHhBF7jZt5gu?=
 =?us-ascii?Q?lp9NuZmo8MO5zSE/zKGuZKy+IlKazmrdF0liwPxa2xjHkPdTiGJXzNuKnsYA?=
 =?us-ascii?Q?2QkXj4+ThmiJAYu+Um0Lvw+ii2//Sio3udvRua7FYukNkSohJZHopZaqwFMG?=
 =?us-ascii?Q?3fAsPAJlLAQFFHny6nw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 799efb24-510f-41eb-7829-08dbcb28ea98
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 13:41:19.7676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wlv1kSCRZbETfLiOXKJ3fTlUM0CORmyMTBt84Y5RwepClNbVlmXPs6XHzjKLm1vh1+vSYrDpP8A+K0QLCIaqaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6230
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

+ Leo and Yazen

We looked at RASF and RAS2 again. We don't think RASF is worth fixing. Our =
preference is to coalesce around RAS2 because we think it can be extended i=
n interesting ways.

The patrol scrub function probably needs some changes to be more general ac=
ross different types of hardware (there are some baked-in assumptions that =
don't always hold true).

We will look at some spec changes to fix the patrol scrub function, and we =
are going to start thinking about other functions that can be added to RAS2=
.

    -Vilas

-----Original Message-----
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Sent: Wednesday, October 11, 2023 12:36 PM
To: Sridharan, Vilas <Vilas.Sridharan@amd.com>
Cc: David Rientjes <rientjes@google.com>; Jiaqi Yan <jiaqiyan@google.com>; =
Luck, Tony <tony.luck@intel.com>; Grimm, Jon <Jon.Grimm@amd.com>; dave.hans=
en@linux.intel.com; linuxarm@huawei.com; shiju.jose@huawei.com; linux-acpi@=
vger.kernel.org; linux-mm@kvack.org; linux-kernel@vger.kernel.org; rafael@k=
ernel.org; lenb@kernel.org; naoya.horiguchi@nec.com; james.morse@arm.com; d=
avid@redhat.com; jthoughton@google.com; somasundaram.a@hpe.com; erdemaktas@=
google.com; pgonda@google.com; duenwen@google.com; mike.malvestuto@intel.co=
m; gthelen@google.com; tanxiaofei@huawei.com; prime.zeng@hisilicon.com
Subject: Re: [RFC PATCH 2/9] memory: scrub: sysfs: Add Documentation entrie=
s for set of scrub attributes

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


On Fri, 6 Oct 2023 13:06:53 +0000
"Sridharan, Vilas" <Vilas.Sridharan@amd.com> wrote:

> [AMD Official Use Only - General]
>
> I do not believe AMD has implemented RASF/RAS2 at all.
>
> We are looking at it, but our initial impression is that it is
> insufficiently flexible for general use. (Not just for this feature,
> but for others in the future.)
>
>     -Vilas

Hi Vilas,

So obvious question is - worth fixing?

I'm not particularly keen to see 10+ different ways of meeting this require=
ment.

Probably not too bad if that's 10+ drivers implementing the same userspace =
ABI, but definitely don't want 10 drivers and 10 ABIs.

Jonathan

>
> -----Original Message-----
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Friday, October 6, 2023 9:02 AM
> To: David Rientjes <rientjes@google.com>
> Cc: Jiaqi Yan <jiaqiyan@google.com>; Luck, Tony <tony.luck@intel.com>;
> Grimm, Jon <Jon.Grimm@amd.com>; dave.hansen@linux.intel.com;
> Sridharan, Vilas <Vilas.Sridharan@amd.com>; linuxarm@huawei.com;
> shiju.jose@huawei.com; linux-acpi@vger.kernel.org; linux-mm@kvack.org;
> linux-kernel@vger.kernel.org; rafael@kernel.org; lenb@kernel.org;
> naoya.horiguchi@nec.com; james.morse@arm.com; david@redhat.com;
> jthoughton@google.com; somasundaram.a@hpe.com; erdemaktas@google.com;
> pgonda@google.com; duenwen@google.com; mike.malvestuto@intel.com;
> gthelen@google.com; tanxiaofei@huawei.com; prime.zeng@hisilicon.com
> Subject: Re: [RFC PATCH 2/9] memory: scrub: sysfs: Add Documentation
> entries for set of scrub attributes
>
> Caution: This message originated from an External Source. Use proper caut=
ion when opening attachments, clicking links, or responding.
>
>
> On Wed, 4 Oct 2023 20:18:12 -0700 (PDT) David Rientjes
> <rientjes@google.com> wrote:
>
> > On Wed, 27 Sep 2023, Jiaqi Yan wrote:
> >
> > > > > 1. I am not aware of any chip/platform hardware that
> > > > > implemented the hw ps part defined in ACPI RASF/RAS2 spec. So
> > > > > I am curious what the RAS experts from different hardware
> > > > > vendors think about this. For example, Tony and Dave from
> > > > > Intel, Jon and Vilas from AMD. Is there any hardware platform
> > > > > (if allowed to disclose) that implemented ACPI RASF/RAS2? If
> > > > > so, will vendors continue to support the control of patrol
> > > > > scrubber using the ACPI spec? If not (as Tony said in [1], will t=
he vendor consider starting some future platform?
> > > > >
> > > > > If we are unlikely to get the vendor support, creating this
> > > > > ACPI specific sysfs API (and the driver implementations) in
> > > > > Linux seems to have limited meaning.
> > > >
> > > > There is a bit of a chicken and egg problem here. Until there is
> > > > reasonable support in kernel (or it looks like there will be),
> > > > BIOS teams push back on a requirement to add the tables.
> > > > I'd encourage no one to bother with RASF - RAS2 is much less
> > > > ambiguous.
> > >
> > > Here mainly to re-ping folks from Intel (Tony and Dave)  and AMD
> > > (Jon and Vilas) for your opinion on RAS2.
> > >
> >
> > We'll need to know from vendors, ideally at minimum from both Intel
> > and AMD, whether RAS2 is the long-term vision here.  Nothing is set
> > in stone, of course, but deciding whether RAS2 is the standard that
> > we should be rallying around will help to guide future development
> > including in the kernel.
> >
> > If RAS2 is insufficient for future use cases or we would need to
> > support multiple implementations in the kernel for configuring the
> > patrol scrubber depending on vendor, that's great feedback to have.
> >
> > I'd much rather focus on implementing something in the kernel that
> > we have some clarity about the vendors supporting, especially when
> > it comes with user visible interfaces, as opposed to something that
> > may not be used long term.  I think that's a fair ask and that
> > vendor feedback is required here?
>
> Agreed and happy to have feedback from Intel and AMD + all the other CPU =
vendors who make use of ACPI + all the OEMs who add stuff well beyond what =
Intel and AMD tell them to :)  I'll just note a lot of the ACPI support in =
the kernel covers stuff not used on mainstream x86 platforms because they a=
re doing something custom and we didn't want 2 + X custom implementations..=
.
>
> Some other interfaces for scrub control (beyond existing embedded ones) w=
ill surface in the next few months where RAS2 is not appropriate.
>
> Jonathan
>
>

