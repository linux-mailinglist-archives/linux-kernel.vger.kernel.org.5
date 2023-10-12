Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11847C71C6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 17:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379480AbjJLPo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 11:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379475AbjJLPoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 11:44:22 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A94B8;
        Thu, 12 Oct 2023 08:44:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kh9Kj8MUT22HB3ms3RfAP6hkFSnxB+ohUTR286/ST1oCeH3Q+zxlHg4/A4JQ2QL5egXyS9txpuxD2saEFg0V1LbPscjJXo4W4tH/MIQT8hghDo5DDAfmpAeBOn8T0XD7g56X0sq3w9X80WpZsHBl3+5zsTOp1BciNSVujAndNVqQ6lm1sgGre9zqGx6azLMuOlk+PPkbWN60aF1494kiGnlrakz9eYAlttnS1s7Prv9ifytNcipYiZzSfGo1iRBTxYNpVmryl0RqZm1w5sSR+VT7Dk3PLsQKmtFXyLdsypj2Lvh14w+M5ABDZoUxXztt2KzemL4u1bFRKKhK7UC/jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4xensMLyemAYEW8rYkY8ygvBhEIJOa/eLusj9csggQ=;
 b=fqXV2dRsTtEDERlgjy5K5rxwB1oBpBB/o2yngbwj59uKFqJUg0vLwZqo5GtyygDoghVQut1or16y5UQTXZbDBU1g5xRA5knKTRNzOpKAKmn0UuUscR4nQ08FMlO6Orn+4aLVFaLt/ieCqN/DeygwdejF/ybTrl+Bub2SFvev75xlXggZAJfWtHVKEuOZCzmjKJdMMjYyk6LU+3go52bwAU5ApF76TGz+jztKbEjEh1TC9EK/i5GmcFM1usJpfn2l+ukoqtT1/2ElqKzrpVGbSzMbogjFW3+kK0Dv8Pqnora4zyaKArll1cq2l6sK7IwonVv1v9za1apodibrRoI1/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4xensMLyemAYEW8rYkY8ygvBhEIJOa/eLusj9csggQ=;
 b=dL+yIl2itjVAVuVLZkTi+yYyo0IAmnf9iXbo8HNJcwqFZ6RPI56gUyKBSEv7cpVBqdwYYWCc3UElQsO/iru3vqBbSR7f4qPi0rjKHFTYpsx9Vn11okS8HxpkFMuWbo7WFPm+5zMlcfeHqLaJ3W5qlfbEqw56FI5ucXuzSMckiLE=
Received: from BL0PR12MB4673.namprd12.prod.outlook.com (2603:10b6:207:1d::16)
 by PH7PR12MB7305.namprd12.prod.outlook.com (2603:10b6:510:209::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Thu, 12 Oct
 2023 15:44:18 +0000
Received: from BL0PR12MB4673.namprd12.prod.outlook.com
 ([fe80::262d:85ff:ef23:629e]) by BL0PR12MB4673.namprd12.prod.outlook.com
 ([fe80::262d:85ff:ef23:629e%7]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 15:44:18 +0000
From:   "Sridharan, Vilas" <Vilas.Sridharan@amd.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     "Duran, Leo" <leo.duran@amd.com>,
        "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        David Rientjes <rientjes@google.com>,
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
        "prime.zeng@hisilicon.com" <prime.zeng@hisilicon.com>,
        "kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>,
        "wanghuiqiang@huawei.com" <wanghuiqiang@huawei.com>
Subject: RE: [RFC PATCH 2/9] memory: scrub: sysfs: Add Documentation entries
 for set of scrub attributes
Thread-Topic: [RFC PATCH 2/9] memory: scrub: sysfs: Add Documentation entries
 for set of scrub attributes
Thread-Index: AQHZ5/onsXhE7XQ22EC/SjWOQvHCtrAmAXoAgACrR4CACRvJAIAK3KYAgAI1jgCAAACIEIAIFsaAgAFfnSCAABiZAIAAC0TQ
Date:   Thu, 12 Oct 2023 15:44:18 +0000
Message-ID: <BL0PR12MB4673059A5AC97F648CD00FB1EAD3A@BL0PR12MB4673.namprd12.prod.outlook.com>
References: <20230915172818.761-1-shiju.jose@huawei.com>
        <20230915172818.761-3-shiju.jose@huawei.com>
        <CACw3F50jRzJnr9h7qYyD3t+6h7Uw9QMfkCkgu7a=7Lv0Tpi8Zg@mail.gmail.com>
        <20230922111740.000046d7@huawei.com>
        <CACw3F539gZc0FoJLo6VvYSyZmeWZ3Pbec7AzsH+MYUJJNzQbUQ@mail.gmail.com>
        <92f48c1c-3235-49b2-aabd-7da87ad3febc@google.com>
        <20231006140224.000018a2@Huawei.com>
        <BL0PR12MB4673F5E024B62D64B065DBE4EAC9A@BL0PR12MB4673.namprd12.prod.outlook.com>
        <20231011173553.00001b39@Huawei.com>
        <BL0PR12MB4673336E2BD4686AFF5EE737EAD3A@BL0PR12MB4673.namprd12.prod.outlook.com>
 <20231012160224.00003f87@Huawei.com>
In-Reply-To: <20231012160224.00003f87@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=90a3db85-b3c3-41b3-ac97-0ecdfcef6d87;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-12T15:42:42Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB4673:EE_|PH7PR12MB7305:EE_
x-ms-office365-filtering-correlation-id: de531250-1dc9-48f5-12ee-08dbcb3a186b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xgLQOAyYF0nbnRK6AWOTOVi9y6y01Kl2pW9wjYoifF/oPq0mRImTT1VygQDgbXEO2mXo9PzAIEBG3LtJwBK7tVu+SU9Kpf+oOpVGoFNTk3TzOYG6EkHGhF8wzxd9qVpiBxJOXsZnrCgWMhj6PkRgCdePzUjqhDoKquscIUTjrgURgPcrx4+O6JsnwCH1DIfUtyXvnqdB82j2CjS/XV8bEOof3nsVAdivIKUvBJYtFmrYJGeUpSdPRGukn7K7d9pVVFQnQbKQsuAwDqEfgd4KqHEZUO4CISYs+ftrkV9L5qBe8igjTnnGO5NrWjLARyoqjiag5c7JBAzHuo59svfRjSa2nFitQnlTpqz9vvUdPGE+4E6XB9W2zIfDg1U58bVcA2SWl0ASHBM4oixKq1rVxX+MBWcNZUGB7ndUc7qjgn1nDTOHTh0ZvH8/TEA8djOl9mAWDRUp+a25Rd8IKTzPvSyiS39pdyNCCOWfB6jFJ6m5PK3+H17rIiRFJ66Dz2aufo0hAIhEA12+2QiD7Ngz2ZmjdBsdH3viOth56ffIH7MnO91WzFF6Kimloui6zyfehiXbvrDjKb2fLgTVFgEwKfKmd9SclIoVzaI9k+Vnrrzk8qG0I8fO/Kc7Ubv1b8FL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4673.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(366004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(7416002)(4326008)(8676002)(5660300002)(8936002)(52536014)(2906002)(66946007)(41300700001)(66446008)(64756008)(66476007)(54906003)(316002)(66556008)(76116006)(66899024)(6916009)(26005)(33656002)(83380400001)(55016003)(6506007)(7696005)(122000001)(86362001)(9686003)(53546011)(38100700002)(478600001)(38070700005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g+C7W4QqKu4vWODFJFAb8zcb50QfK1opehX6hqiG9v2RcDWZtNjhe68I6VL5?=
 =?us-ascii?Q?I6OD1ihe9fASuIjZ9WJHDfO0E/EHlfmHMgTE02eZrbOjGPQGPNzbWJBUiIOp?=
 =?us-ascii?Q?PqRwBMmnHPJuZDhfHINy20ZUjfELPQG29v+ofCU7sDU3wnBD5J02Yxs8NzEr?=
 =?us-ascii?Q?+L3em+f/K1L++AMQvo5BI0GI+UweOEQJgm3BupgfwbX/AT7S1141k7dHqh8C?=
 =?us-ascii?Q?0TK6f87fB9QbDEdJr+QGqtuBjUuLwCq4ov1GKH8kuV9XNDDVdBPWyb554N5z?=
 =?us-ascii?Q?aapweTkfr6DJnxEa9OadwbCkapPf0+jhJYU1yodHlovq1IsTgaz67C/vfM9B?=
 =?us-ascii?Q?7JdFAJW4x3vRl5eLrHFvnsj+AN14A9FzuV7GT2u4RH2MGgA4TNW0cXy4/iMX?=
 =?us-ascii?Q?GNuJbEy6+BL51u+z5vaROA86MAM/58c1NcS1OxWnYncKu8n3Y8NXs8PzStXb?=
 =?us-ascii?Q?tjZdHjLi1fZqH/jY6YWBQw8xqQeV01XBEqfyuJByoQ/xAaAk5bkmAa52W2Iz?=
 =?us-ascii?Q?qUkHFP12u5T9hh5xmJNhgoOtFJ6UXbP1odPpwCtmC9BUl653voGh9s//45/G?=
 =?us-ascii?Q?GwsHoBhcxtJQFeMffI7GPxcBbUGDOpmtikLo1lVoJRTVME6y5lNVkge8jxRB?=
 =?us-ascii?Q?q3M6wwDIdYNuFM51YgSrMhGkW5wKCxzksGvzwCo94PSAvfknU/EQCQk1NkNb?=
 =?us-ascii?Q?Hspn3jmlDr93ZNdbyf/ztrzxo5t27WFuTqxZVPTZHygl++ky17/eZx33d6z+?=
 =?us-ascii?Q?z6eJNg/UGGW4TRTxrfgbGwKcj8GZh7MLrXYsr+kc+3tBrZ53J6D3rzOyzjYu?=
 =?us-ascii?Q?AaX5KYZ6x3zUJCEGPHXcpeYXFqyvt/iwdJiL9qnJ2yVshJZL7YKgFjH8nSWB?=
 =?us-ascii?Q?gl3tOKzxEAyW4VX/DmmV3hAeuzgi67wZQ2cYKq2XNQwlrRK8Q8Jsj0j1C6wP?=
 =?us-ascii?Q?Ugj6bO/O+06HQ0F4pZGEvyj2XSMKbXXpQrMHYMDXd0BKXfuBInYHEMEGTjhU?=
 =?us-ascii?Q?F6RDYARebNkydxiqDqSU/Hyvg0x6m0zjaCabeBlUEKE04VXEqevow9ehB0m3?=
 =?us-ascii?Q?BXk6pPsP0KvlehOfngO9y8nXd+4kWgjLE+IULolRrzUJPRfYzcCFsY08aHmb?=
 =?us-ascii?Q?c918RVLZ6a2r51rdbjx6TjFRKM3dYTx5+7EhKY9vT/bFkOUAT2qkbABeJUKv?=
 =?us-ascii?Q?CfUb36TwPheLONWkso8LAlEiWa51b9PZAcA4aelutTOrlPS+dyi3Ah+/HFY5?=
 =?us-ascii?Q?HzTUYJAAsZ9vLvINnDwv4GJ1SRoLUE5oeDqNMnzamNLYQvHwgexoXSwkOOiC?=
 =?us-ascii?Q?9FlGKIfSOn5ybl/bjbwWOOLfbrqnLIDiAmy0fiikik9aJK8Rgqo8M/fPQ0GK?=
 =?us-ascii?Q?D0WrNy0JB6/r87vOO4qj+9B+7WWBmdJIycM9IhYcg4X0RtVLIeVKxSCIyZf8?=
 =?us-ascii?Q?0NKpbMEqR2WXf2rRgpxVimlp8ngD/KMaR7tYdbVx5R/9+fHvveS7fn+uMty4?=
 =?us-ascii?Q?2ZoYVu9NfzgES7MnR/dQvsqogmk3liBMFtadeFByEHR9DW0Dj889IHHcqn8M?=
 =?us-ascii?Q?KBzgR55+vHSvy3r5jZQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de531250-1dc9-48f5-12ee-08dbcb3a186b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 15:44:18.0670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n+iyoNZYofRej8ut1CcEOCeCQIVscofs6bdnmXU0M7SGHskX3okD5v9DnlPDdNwOLzg9EbIDjNdIzyT35JPDqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7305
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

> Are you thinking a code first proposal?  If you think doing this through =
the standards body is a good idea then perhaps message back here so we know=
 when to look for further proposals in mantis.

I am not super familiar with what you mean by 'code first proposal', but we=
 are thinking about crafting an ECN (or a set of ECNs) for ACPI, that will =
be made public through ACPI's normal process.

    -Vilas

-----Original Message-----
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Sent: Thursday, October 12, 2023 11:02 AM
To: Sridharan, Vilas <Vilas.Sridharan@amd.com>
Cc: Duran, Leo <leo.duran@amd.com>; Ghannam, Yazen <Yazen.Ghannam@amd.com>;=
 David Rientjes <rientjes@google.com>; Jiaqi Yan <jiaqiyan@google.com>; Luc=
k, Tony <tony.luck@intel.com>; Grimm, Jon <Jon.Grimm@amd.com>; dave.hansen@=
linux.intel.com; linuxarm@huawei.com; shiju.jose@huawei.com; linux-acpi@vge=
r.kernel.org; linux-mm@kvack.org; linux-kernel@vger.kernel.org; rafael@kern=
el.org; lenb@kernel.org; naoya.horiguchi@nec.com; james.morse@arm.com; davi=
d@redhat.com; jthoughton@google.com; somasundaram.a@hpe.com; erdemaktas@goo=
gle.com; pgonda@google.com; duenwen@google.com; mike.malvestuto@intel.com; =
gthelen@google.com; tanxiaofei@huawei.com; prime.zeng@hisilicon.com; kangka=
ng.shen@futurewei.com; wanghuiqiang@huawei.com
Subject: Re: [RFC PATCH 2/9] memory: scrub: sysfs: Add Documentation entrie=
s for set of scrub attributes

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


On Thu, 12 Oct 2023 13:41:19 +0000
"Sridharan, Vilas" <Vilas.Sridharan@amd.com> wrote:

> [AMD Official Use Only - General]
>
> + Leo and Yazen

Hi All.

+ Kangkang and Wanghuiqiang (Henson),

>
> We looked at RASF and RAS2 again. We don't think RASF is worth fixing. Ou=
r preference is to coalesce around RAS2 because we think it can be extended=
 in interesting ways.

Absolutely agree. I'm guessing RAS2 was previous go at fixing RASF though I=
 haven't done the archaeology.

>
> The patrol scrub function probably needs some changes to be more general =
across different types of hardware (there are some baked-in assumptions tha=
t don't always hold true).

Agreed. One aspect I'd love to see improved is expanded discoverability of =
what the hardware can do.

>
> We will look at some spec changes to fix the patrol scrub function, and w=
e are going to start thinking about other functions that can be added to RA=
S2.

Feel free to reach out if you want some early input on this. Are you thinki=
ng a code first proposal?  If you think doing this through the standards bo=
dy is a good idea then perhaps message back here so we know when to look fo=
r further proposals in mantis.

Thanks,

Jonathan
>
>     -Vilas
>
> -----Original Message-----
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Wednesday, October 11, 2023 12:36 PM
> To: Sridharan, Vilas <Vilas.Sridharan@amd.com>
> Cc: David Rientjes <rientjes@google.com>; Jiaqi Yan
> <jiaqiyan@google.com>; Luck, Tony <tony.luck@intel.com>; Grimm, Jon
> <Jon.Grimm@amd.com>; dave.hansen@linux.intel.com; linuxarm@huawei.com;
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
> On Fri, 6 Oct 2023 13:06:53 +0000
> "Sridharan, Vilas" <Vilas.Sridharan@amd.com> wrote:
>
> > [AMD Official Use Only - General]
> >
> > I do not believe AMD has implemented RASF/RAS2 at all.
> >
> > We are looking at it, but our initial impression is that it is
> > insufficiently flexible for general use. (Not just for this feature,
> > but for others in the future.)
> >
> >     -Vilas
>
> Hi Vilas,
>
> So obvious question is - worth fixing?
>
> I'm not particularly keen to see 10+ different ways of meeting this requi=
rement.
>
> Probably not too bad if that's 10+ drivers implementing the same userspac=
e ABI, but definitely don't want 10 drivers and 10 ABIs.
>
> Jonathan
>
> >
> > -----Original Message-----
> > From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > Sent: Friday, October 6, 2023 9:02 AM
> > To: David Rientjes <rientjes@google.com>
> > Cc: Jiaqi Yan <jiaqiyan@google.com>; Luck, Tony
> > <tony.luck@intel.com>; Grimm, Jon <Jon.Grimm@amd.com>;
> > dave.hansen@linux.intel.com; Sridharan, Vilas
> > <Vilas.Sridharan@amd.com>; linuxarm@huawei.com;
> > shiju.jose@huawei.com; linux-acpi@vger.kernel.org;
> > linux-mm@kvack.org; linux-kernel@vger.kernel.org; rafael@kernel.org;
> > lenb@kernel.org; naoya.horiguchi@nec.com; james.morse@arm.com;
> > david@redhat.com; jthoughton@google.com; somasundaram.a@hpe.com;
> > erdemaktas@google.com; pgonda@google.com; duenwen@google.com;
> > mike.malvestuto@intel.com; gthelen@google.com;
> > tanxiaofei@huawei.com; prime.zeng@hisilicon.com
> > Subject: Re: [RFC PATCH 2/9] memory: scrub: sysfs: Add Documentation
> > entries for set of scrub attributes
> >
> > Caution: This message originated from an External Source. Use proper ca=
ution when opening attachments, clicking links, or responding.
> >
> >
> > On Wed, 4 Oct 2023 20:18:12 -0700 (PDT) David Rientjes
> > <rientjes@google.com> wrote:
> >
> > > On Wed, 27 Sep 2023, Jiaqi Yan wrote:
> > >
> > > > > > 1. I am not aware of any chip/platform hardware that
> > > > > > implemented the hw ps part defined in ACPI RASF/RAS2 spec.
> > > > > > So I am curious what the RAS experts from different hardware
> > > > > > vendors think about this. For example, Tony and Dave from
> > > > > > Intel, Jon and Vilas from AMD. Is there any hardware
> > > > > > platform (if allowed to disclose) that implemented ACPI
> > > > > > RASF/RAS2? If so, will vendors continue to support the
> > > > > > control of patrol scrubber using the ACPI spec? If not (as Tony=
 said in [1], will the vendor consider starting some future platform?
> > > > > >
> > > > > > If we are unlikely to get the vendor support, creating this
> > > > > > ACPI specific sysfs API (and the driver implementations) in
> > > > > > Linux seems to have limited meaning.
> > > > >
> > > > > There is a bit of a chicken and egg problem here. Until there
> > > > > is reasonable support in kernel (or it looks like there will
> > > > > be), BIOS teams push back on a requirement to add the tables.
> > > > > I'd encourage no one to bother with RASF - RAS2 is much less
> > > > > ambiguous.
> > > >
> > > > Here mainly to re-ping folks from Intel (Tony and Dave)  and AMD
> > > > (Jon and Vilas) for your opinion on RAS2.
> > > >
> > >
> > > We'll need to know from vendors, ideally at minimum from both
> > > Intel and AMD, whether RAS2 is the long-term vision here.  Nothing
> > > is set in stone, of course, but deciding whether RAS2 is the
> > > standard that we should be rallying around will help to guide
> > > future development including in the kernel.
> > >
> > > If RAS2 is insufficient for future use cases or we would need to
> > > support multiple implementations in the kernel for configuring the
> > > patrol scrubber depending on vendor, that's great feedback to have.
> > >
> > > I'd much rather focus on implementing something in the kernel that
> > > we have some clarity about the vendors supporting, especially when
> > > it comes with user visible interfaces, as opposed to something
> > > that may not be used long term.  I think that's a fair ask and
> > > that vendor feedback is required here?
> >
> > Agreed and happy to have feedback from Intel and AMD + all the other CP=
U vendors who make use of ACPI + all the OEMs who add stuff well beyond wha=
t Intel and AMD tell them to :)  I'll just note a lot of the ACPI support i=
n the kernel covers stuff not used on mainstream x86 platforms because they=
 are doing something custom and we didn't want 2 + X custom implementations=
...
> >
> > Some other interfaces for scrub control (beyond existing embedded ones)=
 will surface in the next few months where RAS2 is not appropriate.
> >
> > Jonathan
> >
> >
>

