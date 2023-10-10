Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD607BF24E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 07:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378538AbjJJFhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 01:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378065AbjJJFhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 01:37:50 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B86692;
        Mon,  9 Oct 2023 22:37:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q37mCP+QN163HsoUBFfB1gaFnTi49fxTzITduGoG/vGizIk6EciC8iwdsOnTnBEWIENSJaiaQ6NCXjKNRsbT1nWyrdutlrWPvyWRM4mY7dqFm9L7hfxIf8i/OcNM5aSI3VVKkGhDWrbCRb1HMqRkBdg4d0E6xeqq/OvfTwg54aVQbyOB8yacZwJYAmt9BtWMR4KiWtAc831jfLTkVFwYJ7yvNZt/aIcK+H5S2MK5VQHbDjkiGNLDkfaCyS7D42j/uwq8dv73J9MqCti/3Gb8NiL8CMg0tk9eoAPKoE3XJrznQEDdgtAcj0y/OSafheV3Q4pZNKXryE2BDdVUgUjLFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gieg+m4Fc337FpNv2Mqi7GyvTpCR5M6KwydoliDLs6o=;
 b=nEcYFzKdefus/PDqHWkQaIkkUnpyfCdp6/9wS4OaJ6W7WkUCgEap9A7sXgeGAtlPO8pr/fV5WuIlqQiW0xXHHJTxm31EFhAabO2mrq8CFe/1meklfCDmsJgKnwP2w2XJNBGXj0LYV5nO8P7IWIz/KAlbbhcLCDjFMWue35f+X6JyyY+TghFEaBYrKZ/7BJZjUByi5SxyM5P85yYkQPeXbfpeEwStu7DizJqRWw6Ne7mQB0x5ZeqzHHhS94ENYjKM6AcDYF7QLi5ROS4nOa2tpp4G5HiqK+AoufvcyGElYhJsRv/jGgXkPE8yvM8PJDrXx20Yk6PJPltcb6F3MjLbnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gieg+m4Fc337FpNv2Mqi7GyvTpCR5M6KwydoliDLs6o=;
 b=Hf604umczckJ4TObWth++zp2wCvALvjMyAjgcQgbLHyKPIJmgz1rjQEEOi8TW1XdNFEHAkNLnFKdtfR/OzbcfDBwmfGGjkzDg5W0Z040/y2aSSjcSVg2cfBdtjMrQOQafEqGtozFZayaLQmZRIHw+KV8cRgkb7IU95mKoweezSw=
Received: from DM6PR12MB3993.namprd12.prod.outlook.com (2603:10b6:5:1c5::29)
 by BL1PR12MB5969.namprd12.prod.outlook.com (2603:10b6:208:398::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 10 Oct
 2023 05:37:44 +0000
Received: from DM6PR12MB3993.namprd12.prod.outlook.com
 ([fe80::7004:8096:33b7:c1c3]) by DM6PR12MB3993.namprd12.prod.outlook.com
 ([fe80::7004:8096:33b7:c1c3%5]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 05:37:44 +0000
From:   "Manne, Nava kishore" <nava.kishore.manne@amd.com>
To:     Xu Yilun <yilun.xu@linux.intel.com>
CC:     "mdf@kernel.org" <mdf@kernel.org>,
        "hao.wu@intel.com" <hao.wu@intel.com>,
        "yilun.xu@intel.com" <yilun.xu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
Subject: RE: [PATCH] fpga: versal: Add support for 44-bit DMA operations
Thread-Topic: [PATCH] fpga: versal: Add support for 44-bit DMA operations
Thread-Index: AQHZ9cl2nMPXzgW2BE2GmT0X/Yd8VbA98NiAgASXdQA=
Date:   Tue, 10 Oct 2023 05:37:43 +0000
Message-ID: <DM6PR12MB3993439C9BE6F52664D9C394CDCDA@DM6PR12MB3993.namprd12.prod.outlook.com>
References: <20231003071409.4165149-1-nava.kishore.manne@amd.com>
 <ZSEF1TOpd13BkCXL@yilunxu-OptiPlex-7050>
In-Reply-To: <ZSEF1TOpd13BkCXL@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3993:EE_|BL1PR12MB5969:EE_
x-ms-office365-filtering-correlation-id: 4a975a68-94f0-462d-b0a6-08dbc95306d7
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fs3BKEkNj4qJRO/ID8pN54L+l+aub3BWSp5K8GT6hqL8VFIdO5dbbIu7rhJ8jRuqHm/UEjs5GFewlReaSR+oHjLipbcCJqlWjJP86EX+vrpz0pm/L7sQVdTzG1dzaxQhtO0Jslz8XGuey+SdLvu4qUxlAsmDzZ4aH2i42pOOfnaX1pgDme5VFTN/dBT70W/0RvVRjHHtxxmNonogk5KAglhhPWNGx+ETTmhx+tdmRVJ3B4o0t7hv8CITOwy+hKgTuORq0+woj67SI4eo+mXJYbrep7zcQwDpKkSrqGUm5ZQw60Ut8p92LWFi+cUS8YD8vlvNWjRkvMGs3TQl5d43moXNf8gfpQX0ZXC8E0Ia7DXhhySOrPm9Yjt97kU/P5ZkKy3eKND5c/3KrLucnoNQTLt2tjLYk3T/Py4HJoMK3ZctAp/vxp5sNZal1hP5UK07PtRHLcorxXSuhWGHWB4vWD8jlF5UowtNZbfmQH9rcohcMJIGIRA+g2pg07xQW5oKWRyb8U71zRVzDdqCp0jv8j9mDmD0bWj4IbcuzD5R/ae0r14vfzNhd9tSZhX810MKLYAMBHoWZeODxNGoBzIIKgQb1JL2O3U6Pwb60v406iw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3993.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(366004)(396003)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(86362001)(38100700002)(122000001)(38070700005)(33656002)(55016003)(9686003)(2906002)(7696005)(478600001)(966005)(41300700001)(4326008)(8676002)(71200400001)(52536014)(5660300002)(64756008)(8936002)(6506007)(53546011)(83380400001)(54906003)(66476007)(6916009)(316002)(76116006)(66556008)(26005)(66946007)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OdzdVc0gvfNKJCbbhyt9JLWzb0Yd+faPBq6Y6KfrwerfBQctdFSNOlbjBOHp?=
 =?us-ascii?Q?TOCgZ+zHlz0w8KwfI1qWfQig6FDUXg5aAEBv13VGsYmhfs5n0WxPWYGUWD+O?=
 =?us-ascii?Q?Q5bZN4mql9p47B9Q9IIQruiGPquEuRfqqbpGKB1Z+W8WmapHKvP5MMmq5ba/?=
 =?us-ascii?Q?TqZT/i80JWXhyqg0DSGVPLpTcvdblGsOfuf7Uz9chpHCyFZFT19+Qkuuwnvr?=
 =?us-ascii?Q?xNeLKXQX60I5WUd9u2wy1EVcEST1XkR/qpEtORHNSAR8H6LzupW0set8NAqt?=
 =?us-ascii?Q?cuAnR/TUDM4kuG6cjcG6yuwhfKvpBaJ3EKfFDYku8muBgr8RwNtq9CDVqYs1?=
 =?us-ascii?Q?/MERhWT3OhJl2cFaK7gAxuLoI9HG9qiaOgjT1ZqIPURZt3nSLQiJ7D1ON9Bo?=
 =?us-ascii?Q?iv4ZFzPtXir81FqZ+IJeF7I1LOOXE7AAo0TKLPart6+rkN1LhR6Mi4pH44h1?=
 =?us-ascii?Q?ikvlR2ynB+tDo3UJQJcqgtBN3tvbAoA1WwL7MUvzYBEU1yO1+XGeEqnmX/8v?=
 =?us-ascii?Q?SAO0W5B7uwJ4tSKb8m+weCpqYM8YrBo0zhgvJTtPNUh3aB89om7DM6A5uwxg?=
 =?us-ascii?Q?ucT0ELzvEReAMeU26wzT3FyTgRN3DtUhbp/JGp6nJ2O/ibOxpe6xq/Mrs2Rn?=
 =?us-ascii?Q?ZFdtFw6kXdpSUz/7IKIqPbqZf+lo1kWbgBx+Tm8DKUUH8arSbz+irIRYYoOC?=
 =?us-ascii?Q?jcC7mFa3M/b8NPf65WrySukckeH7uMz9jw0UklowAmzn9UTu2+elou4vLaSW?=
 =?us-ascii?Q?/fg60J+h+AHIfIhpY/YLoEyrfVdDw0ZfFC8b/LoO42ep+s7RswDJAZvvK98d?=
 =?us-ascii?Q?nnFWafkfcLvbz53jn68AcdaBBwKz//o3hP7sxybH3yfl6Mrwg6tSM4S7qQH+?=
 =?us-ascii?Q?QEZmoFyrCLY3XXJptJjqGo7T4wToSLpLHdhuA9rOPgt3k5kv1Jr1VvQf0HHc?=
 =?us-ascii?Q?32+4URSuMb2t8doOp06u6m3D3r81mlM4IdTERLoKqiihHHU9qrb40DDt+nsn?=
 =?us-ascii?Q?9t4TKwz7ZceoK50fHOD18tGHZyaESrJVJKF0GnM1QfLFEbrGxY2W26iZjrT0?=
 =?us-ascii?Q?LowFj7on0H2Iq5eB3/RG+2jBW9IgVBr8Rlo292A7W0/O+uwYDVPp4Ieyw3FM?=
 =?us-ascii?Q?61GW01Iy6B/3lKN82eZ9I9m9+2qKYsoMydrHPphC73JKkF5JXPVxWbeV2Q8T?=
 =?us-ascii?Q?vrjJzAhdcJEcuyNBT5M5hJsnwFeBdHli3E1lDHjEBpYOtRlYL2o/vOYv2//g?=
 =?us-ascii?Q?6OgG5uaF9WPNzJNbFk/fX5y4xssqmT8VEMVy5yBMLIZCrpINeB1EyL8GRBJP?=
 =?us-ascii?Q?TwUqhNty2CgqEFIk0gwfb5qsXEEHz6t1uPjbNsnY9HEh24AbjQMyQZ8M0RH9?=
 =?us-ascii?Q?jFogV5X3NAnBoVvS19IszsJaKGRwFy4HMwrJ/DjEX81nUTykqWtwYLo5UmDR?=
 =?us-ascii?Q?AmtSmQnDyy/hKey7gO8DUdDaI7EOJjgqjgzcSsDhdlq1s+ReWlys9FYEKNoZ?=
 =?us-ascii?Q?ivHxNNr6Ri9eyTnlDYSVgJ3+OWN8ihdoxAkdLGr4zjBDXjkavOpF8MW4L+YV?=
 =?us-ascii?Q?/CxS/KhLMPgOVzMv/9A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3993.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a975a68-94f0-462d-b0a6-08dbc95306d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 05:37:43.7296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pc1xbnaw+EmTe07j8NTe7sflrW1JCA8StPpe2e8XwAHfr8UnEi8NmRu1sB2O2UX4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5969
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yilun,

	Thanks for providing the review comments.
Please find my response inline.

> -----Original Message-----
> From: Xu Yilun <yilun.xu@linux.intel.com>
> Sent: Saturday, October 7, 2023 12:47 PM
> To: Manne, Nava kishore <nava.kishore.manne@amd.com>
> Cc: mdf@kernel.org; hao.wu@intel.com; yilun.xu@intel.com;
> trix@redhat.com; linux-fpga@vger.kernel.org; linux-kernel@vger.kernel.org=
;
> Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>
> Subject: Re: [PATCH] fpga: versal: Add support for 44-bit DMA operations
>=20
> On Tue, Oct 03, 2023 at 12:44:09PM +0530, Nava kishore Manne wrote:
> > The existing implementation support only 32-bit DMA operation.
> > So, it fails to load the bitstream for the high DDR designs(Beyond 4GB)=
.
> > To fix this issue update the DMA mask handling logic to support 44-bit
>=20
> This is the HW defined DMA addressing capability. Does the device only
> support up to 44 bits DMA? Any Doc?
>=20
The versal platform supports a maximum physical address size is 44-bit in A=
Arch64.
For more details, please refer the Versal TRM (Memory space- section):
 https://docs.xilinx.com/r/en-US/am011-versal-acap-trm/Memory-Space

Regards,
Navakishore.

