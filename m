Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB2E7BB895
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbjJFNHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 09:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjJFNG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:06:57 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B7483;
        Fri,  6 Oct 2023 06:06:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVjIKgKMMRahQnwFhWAq1XUVfKgT4Xx7+7t/31t8KR7ZTJnCt++0B7Gjh3QxqacRlYXaV4YzkD/usvhwkuuWMr3z10/QF3rCrQz7FevsFIpJdyElCrovP+wM3hpNnZMrsAapQFsZ9UKfYG/1qdDo8IEFpX0S5L9wxDova3YeSKesMgamijNOpBF8isTzqQ8CcX/cpDDl4zY+ss9UjlYq24Yvpj3hhk3rH535AKQMccE7edtqhkgZbTZBpbLqoeNyroMivI3Ah1+gnlGqEmLWylVeKaCIZPHXy05V4JDnIobX54z0Dx+pLd4zy3ybR8lI/KmDgsfJ2iICrzX8yjbedw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPTIV5DY86LBxAqGFwEWwsqWQwez+QCW4Ri052boiXY=;
 b=jobI5ExxJMz/5j0iZ+JL54DwFPYkCFUWv72gHD/1gWRjTfLbRYI3OdQBK8sFy5YIRbm5M8pIsKGTnBhcq37zX9esLm29zKsUCPtc9JHCTcNheUMUIPJQmZK4zIPUEs0r2p8R40MxTHTLVOBLGzP4ILexu8KsogO9IJ6WZ30qSy8j8BM73H8TbdATSdL76YP+0zgn0f7FgUyeFfFChY3gCLVWCDi/Fcm79Btd0EOONcJmYevfIfAJykL18lPBQsDToYQlWR/IyixPZ1qKOw8BSvF2AjghG+7fYGxpWDUjEVVE5uIi9EiMgbTD/3UOx2FKIO4hH34rYmLYjtSDx02kKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPTIV5DY86LBxAqGFwEWwsqWQwez+QCW4Ri052boiXY=;
 b=3ZJBF7XWkz2eI0MLhYQT/wHVsTi8vjupEBFhXm+T+lvROSxdzhv9I7smTTnNKfvcaAlsPp5X4tvLgOAWN2vI7ScDYdv3THa4MrzLhNG/OubVc6IPG7uy10LAEt66gMgXps/14YdC304KKdLbcdEVM7P5t5jfgMzpsXkrgwRaHKE=
Received: from BL0PR12MB4673.namprd12.prod.outlook.com (2603:10b6:207:1d::16)
 by DM4PR12MB5215.namprd12.prod.outlook.com (2603:10b6:5:397::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 13:06:53 +0000
Received: from BL0PR12MB4673.namprd12.prod.outlook.com
 ([fe80::262d:85ff:ef23:629e]) by BL0PR12MB4673.namprd12.prod.outlook.com
 ([fe80::262d:85ff:ef23:629e%7]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 13:06:53 +0000
From:   "Sridharan, Vilas" <Vilas.Sridharan@amd.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        David Rientjes <rientjes@google.com>
CC:     Jiaqi Yan <jiaqiyan@google.com>,
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
Thread-Index: AQHZ5/onsXhE7XQ22EC/SjWOQvHCtrAmAXoAgACrR4CACRvJAIAK3KYAgAI1jgCAAACIEA==
Date:   Fri, 6 Oct 2023 13:06:53 +0000
Message-ID: <BL0PR12MB4673F5E024B62D64B065DBE4EAC9A@BL0PR12MB4673.namprd12.prod.outlook.com>
References: <20230915172818.761-1-shiju.jose@huawei.com>
        <20230915172818.761-3-shiju.jose@huawei.com>
        <CACw3F50jRzJnr9h7qYyD3t+6h7Uw9QMfkCkgu7a=7Lv0Tpi8Zg@mail.gmail.com>
        <20230922111740.000046d7@huawei.com>
        <CACw3F539gZc0FoJLo6VvYSyZmeWZ3Pbec7AzsH+MYUJJNzQbUQ@mail.gmail.com>
        <92f48c1c-3235-49b2-aabd-7da87ad3febc@google.com>
 <20231006140224.000018a2@Huawei.com>
In-Reply-To: <20231006140224.000018a2@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=32d725df-ef94-48ef-a0c4-06f7ed44c8b0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-06T13:04:17Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB4673:EE_|DM4PR12MB5215:EE_
x-ms-office365-filtering-correlation-id: 92c18997-d812-4feb-76ba-08dbc66d1c87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: upMNeObUF+tvIY3GWKL4xYyoqOjc9WXD9lr/DlwkcCa5sfbLbPuYXNPHnv54mhyb3aS10XztCZhPHIEXyqZrx76Fhq8Cizj6xnU19jS1QTbSzNzNve2MQWtuEL02Jeoq51GzrtlrYjKj3BQswOkmR1AcwAbV4tbYWwDoOzU2B72fyP/y4z6TBXjSudT/uWcREdmCGDEkjby8CbL3MH7VesbLWREFp7r8kiuwVCSiRSPZu9Q84uqO3ZASVN5hjlgJDN0bH0+9sKZs+Uvo835MkKcSL9MuA4EXPcFZx9mu/3appF9yH0miTIz51WIJHs/gSUgowh3AOt47aGtIVZtioTtObGp/baTX+Wt5wMRhe3Vi7gSBSQTmBlrHRD8WCoy7SG5RYov4OnJrWXNTLs9nEu3X/HXxPx7NBIFcbzxP6GFe6t1elQ25HXXN8oyQ7DxFlENy3oi7PE1wKMPiLewZ4FR/IeeWZI/cdazRZgbgzNETUCEOiQcf4g31WJRPiDo5pujQrS5AhB7iTAcMR+NBniwakhsqCYLlJY5eyfz4WMQYTd59IwDdFqMDFTwAUjB7dCzoA/5JyFCSI8wjopUuCxmx6QgKmCJd756/P+VhFIF4Kw3sp3LeVJQxwnRDUlFo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4673.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(53546011)(8936002)(66899024)(52536014)(55016003)(5660300002)(83380400001)(7416002)(122000001)(2906002)(38070700005)(86362001)(33656002)(38100700002)(8676002)(4326008)(66476007)(66446008)(478600001)(110136005)(66946007)(76116006)(54906003)(64756008)(66556008)(316002)(9686003)(41300700001)(7696005)(6506007)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VEenSy1xg8Q3b2xFTFLprF6nHTCOgs82amEkDxnymuakve1MgADnrWowGCue?=
 =?us-ascii?Q?zZSJygq2GscfIlb8a+ug8K8IlXhH81781WyJT/y1iHoUpIMrW+BsdXy25xYN?=
 =?us-ascii?Q?LEdnwgABBVWDqIPYxfLKulZxSdaWxtzqqEOQDjs10G0OHMJcNU0g0LaL1mJP?=
 =?us-ascii?Q?SR2+BgvnzB6VHVHFvKVmsd0SQBSdXRHNZxcZ/8U5meZXvkzIshvqI0aDz8e9?=
 =?us-ascii?Q?/Oh6aQIxRUbLQzPIY/AiU2Vd56FcUs90tG8fPs2XlSA621S4fmGvzSfQt2JK?=
 =?us-ascii?Q?/k6eD3LMuMdVUpE70HTveu/wulwL9slUUPHfeqPs1eDSf/G+AuGOJARmljaN?=
 =?us-ascii?Q?dcPvEkImQZYp9E7de1gMRX85qjVTOeUnxwiNPQUHswAFKvGW34jYYG0pqn7s?=
 =?us-ascii?Q?uBVLg4gJ/bh354A73ptyrdfJERhH/xD+H+VM+mi2HqbvZJcIKOrydf9kYR2O?=
 =?us-ascii?Q?P7/3ivFQh0p4vQcm4k3JB/ovOhg8klPDigF0m2G5F+i49GfL5gFHygvZNQUJ?=
 =?us-ascii?Q?nVJJWVXV3g9UdHw2W2LeAWHKT8B8pvQ38ipmrtu76KuLouFK18NaDW+LFiww?=
 =?us-ascii?Q?B1xc08IEt4CVj+FluwlyJb0sg3uc67gXciEEsq2I/nhMUqWkF8MrewgHxpM5?=
 =?us-ascii?Q?X1AuT52wXC+0Jo+jw3LaiOFciDD8FfBeN/v7dLYb0nhf777dhBe/ZpS5GZka?=
 =?us-ascii?Q?1gUtuUzlcofDnFdLs6Oj1h4UpfNJ4iylu6oT9nV9RB43ujub1Nlf3U3MOKq3?=
 =?us-ascii?Q?NWNuecaSW5Mqu7JF5LQdN8NP6GR+Jxdy0XwWIJGZSMvvHFieVckC8m+YMiLL?=
 =?us-ascii?Q?7T2tlq5Sjrj8cjBd+uVNpXRHpY5VHFmTiH+AXHSPqR5qtubhVjdpnP9Rhilr?=
 =?us-ascii?Q?NrZ9q8B18rPUEBS3oODGMZUgsWOrUIKk88KoocARucLyxJvNkSXTQKJkdmGK?=
 =?us-ascii?Q?1vWjnu37wzCrHI7YoLAtWZbSGqMaUBV99fMMwHVQfUWGxndsPqVbIOfpVwoX?=
 =?us-ascii?Q?OrN9el6STjyFYJRfx2V90jlknqA40K9QBDdJ+R/NGNtgzbMVvVWjcTjumn8C?=
 =?us-ascii?Q?a5c5zNaduJswVSaKHNss75jaZlycmrfo2Xrhz/KbTv65tyzvdWMn5cO80Ggn?=
 =?us-ascii?Q?zn8qTsufuV1uzdCT3lyNj6N8J/hKAVBEIyihnwkj3elv3xK1E0UpkV5LE56b?=
 =?us-ascii?Q?varPBT2W6GdbpHTSv3xXhNNoaqkqTXRnwjvjNzH1IpFSnrpURCXqnkKCnmLn?=
 =?us-ascii?Q?fpE0L97rH6LrNOP2HSZSUdHNXmiqId1zQkgZG3E6nmN2q7s1bc+6dGw7aJst?=
 =?us-ascii?Q?4nxrGlo6rK50cMDH+HumBunul8x5UgFHYtdkhjtXr2a62j6s0K+qBc9E3Hmw?=
 =?us-ascii?Q?eCMkMcwIX+SpmTYZHYEuufc41fDeK9Lo8RrTPww8Div7KKYAIIsxIgjWzi1d?=
 =?us-ascii?Q?xu6KUA/NilBicMdNp6iegrk0NH7ABJyJw1ibb2KbLsNu/HtntYuJbxSLaWNy?=
 =?us-ascii?Q?iCTXuhy3bKBp+jE5RqKrsvUx//9+gXpF9TIylZDtJv2SLs1Dm9UKYifjnQ?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c18997-d812-4feb-76ba-08dbc66d1c87
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2023 13:06:53.5039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qfGzF7i0MjGDzFwSkYsZ6O/gz2gkwp9yqoRoEaF3so2m58b2GQexuqP/NU8XgSd0Jre1QE71FxqG92e22kB9RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5215
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

I do not believe AMD has implemented RASF/RAS2 at all.

We are looking at it, but our initial impression is that it is insufficient=
ly flexible for general use. (Not just for this feature, but for others in =
the future.)

    -Vilas

-----Original Message-----
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Sent: Friday, October 6, 2023 9:02 AM
To: David Rientjes <rientjes@google.com>
Cc: Jiaqi Yan <jiaqiyan@google.com>; Luck, Tony <tony.luck@intel.com>; Grim=
m, Jon <Jon.Grimm@amd.com>; dave.hansen@linux.intel.com; Sridharan, Vilas <=
Vilas.Sridharan@amd.com>; linuxarm@huawei.com; shiju.jose@huawei.com; linux=
-acpi@vger.kernel.org; linux-mm@kvack.org; linux-kernel@vger.kernel.org; ra=
fael@kernel.org; lenb@kernel.org; naoya.horiguchi@nec.com; james.morse@arm.=
com; david@redhat.com; jthoughton@google.com; somasundaram.a@hpe.com; erdem=
aktas@google.com; pgonda@google.com; duenwen@google.com; mike.malvestuto@in=
tel.com; gthelen@google.com; tanxiaofei@huawei.com; prime.zeng@hisilicon.co=
m
Subject: Re: [RFC PATCH 2/9] memory: scrub: sysfs: Add Documentation entrie=
s for set of scrub attributes

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


On Wed, 4 Oct 2023 20:18:12 -0700 (PDT)
David Rientjes <rientjes@google.com> wrote:

> On Wed, 27 Sep 2023, Jiaqi Yan wrote:
>
> > > > 1. I am not aware of any chip/platform hardware that implemented
> > > > the hw ps part defined in ACPI RASF/RAS2 spec. So I am curious
> > > > what the RAS experts from different hardware vendors think about
> > > > this. For example, Tony and Dave from Intel, Jon and Vilas from
> > > > AMD. Is there any hardware platform (if allowed to disclose)
> > > > that implemented ACPI RASF/RAS2? If so, will vendors continue to
> > > > support the control of patrol scrubber using the ACPI spec? If
> > > > not (as Tony said in [1], will the vendor consider starting some fu=
ture platform?
> > > >
> > > > If we are unlikely to get the vendor support, creating this ACPI
> > > > specific sysfs API (and the driver implementations) in Linux
> > > > seems to have limited meaning.
> > >
> > > There is a bit of a chicken and egg problem here. Until there is
> > > reasonable support in kernel (or it looks like there will be),
> > > BIOS teams push back on a requirement to add the tables.
> > > I'd encourage no one to bother with RASF - RAS2 is much less
> > > ambiguous.
> >
> > Here mainly to re-ping folks from Intel (Tony and Dave)  and AMD
> > (Jon and Vilas) for your opinion on RAS2.
> >
>
> We'll need to know from vendors, ideally at minimum from both Intel
> and AMD, whether RAS2 is the long-term vision here.  Nothing is set in
> stone, of course, but deciding whether RAS2 is the standard that we
> should be rallying around will help to guide future development
> including in the kernel.
>
> If RAS2 is insufficient for future use cases or we would need to
> support multiple implementations in the kernel for configuring the
> patrol scrubber depending on vendor, that's great feedback to have.
>
> I'd much rather focus on implementing something in the kernel that we
> have some clarity about the vendors supporting, especially when it
> comes with user visible interfaces, as opposed to something that may
> not be used long term.  I think that's a fair ask and that vendor
> feedback is required here?

Agreed and happy to have feedback from Intel and AMD + all the other CPU ve=
ndors who make use of ACPI + all the OEMs who add stuff well beyond what In=
tel and AMD tell them to :)  I'll just note a lot of the ACPI support in th=
e kernel covers stuff not used on mainstream x86 platforms because they are=
 doing something custom and we didn't want 2 + X custom implementations...

Some other interfaces for scrub control (beyond existing embedded ones) wil=
l surface in the next few months where RAS2 is not appropriate.

Jonathan


