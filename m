Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA737B230F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjI1Q6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbjI1Q6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:58:23 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2060.outbound.protection.outlook.com [40.107.100.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F67A1A5;
        Thu, 28 Sep 2023 09:58:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqRKDqfMmKkixB1dlmgEl3Y8/0y934P6s0p3On3xBhlZcYjpqHWwo8i2+O3uuedGr8+MRnERyUr6IeyZdo/VICK9sNrU2DTzlatk/9k0OSf1lBldOt5pDyH0MKjS/Q9jXd+h5RwbZKGjLYhaYZQrwgPbJk/cJLJ13k+LJ7iV9MeaKYA71EsAmLkrp3HfwK0WOATrcaOZa8+XfsLruHLoavLoAB0o5FZq0UazQcTI4R4zBMJFHk2f1eHcstz7wqQT+to3KSnktovGFN9dJlG/H/GhYtPOr+25l9rOZeAnGmolOEdK7+iRD9kH3JtWVEyw1Jpgpv8Pebx2JFzukDXU5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kh5ZL+lRJvjYlrEVWFtd00QzBg50X16vkYbVpY6yri0=;
 b=gRz9uTog5PFJ4uJXWBBUyPGLvC5UbnG9md+fc5G4JfMRtIh6i17OOKf4U2rW05DUyM29eTb0IJXgCITI4j973bMZxF4reLdEOgIMI7+juTKyoJ1PMj8tD1vNhyLZdY58zDCAGeDIUVwVwJxmZFmW8zWyKQVye8vSFbLMWK6MPwMSRSIQJ98qJV/Yucvn7s0dkb9/0ru0C2dWwkOCvOlCqWQAUoQ+dTvVmesuko9X0OE1cDuVYPJQ9Crg5y+71ZUz3x38/1nC9X8TXs1XfA3DlrV7gJWfJbfHqI7DdUEOrTTmpY0Q1DI6aEQkGNUf1Xe4FitSHiSUivP84LkByL4FyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kh5ZL+lRJvjYlrEVWFtd00QzBg50X16vkYbVpY6yri0=;
 b=38pwbUFp+1lv1ljvl2clatmmKi23W9nzSxVwxSXhOQTRJZubryEWGwKHhRl+g6J7s3788VxteoiiJ7sWBmuPTnNgbaplTJzZNky4BiYUMhAVpgkv5OImmWWY79R6DnhzYdVAYqNvPtwcNnIiqxLMVWOHV3TMe+sSiIk1hBlLeP0=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SA3PR12MB7783.namprd12.prod.outlook.com (2603:10b6:806:314::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Thu, 28 Sep
 2023 16:58:18 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a2bb:870f:8aaa:1ba2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a2bb:870f:8aaa:1ba2%7]) with mapi id 15.20.6838.024; Thu, 28 Sep 2023
 16:58:17 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Sebastian Reichel <sre@kernel.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Ma, Jun" <Jun.Ma2@amd.com>
Subject: RE: [PATCH 1/3] drm/amd: Fix detection of _PR3 on the PCIe root port
Thread-Topic: [PATCH 1/3] drm/amd: Fix detection of _PR3 on the PCIe root port
Thread-Index: AQHZ8inH0rgCz1p9eUSNJTFOxJxMPbAwdXlA
Date:   Thu, 28 Sep 2023 16:58:17 +0000
Message-ID: <BL1PR12MB5144F0B3B6D1696062A2E313F7C1A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230926225955.386553-1-mario.limonciello@amd.com>
 <20230926225955.386553-2-mario.limonciello@amd.com>
In-Reply-To: <20230926225955.386553-2-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=05c3d939-2ce4-41e4-a839-ed60a346c310;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-09-28T16:57:50Z;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SA3PR12MB7783:EE_
x-ms-office365-filtering-correlation-id: d0e60872-da70-4769-22c7-08dbc0441cdf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 24SLWgf63UNzO5atKgtO7NXZXb/+DOq12BW4qmTzmRTfVcGgZIzPv4NimsSsaHcJPyBIEAWtDk+yrjWBoe3vwrbI5XaGmhK9XXLEVJbuxpHwPqpUCghGF7wFS+TNXy/kM0TjJ9ssxgIzTXawMzY94QF+OcgldmL1mUDbDhKBU9Iny3lyXaTqVCIFzMZGtc11055vQ68Zs3qQdS/BE8OuaerXU7wVRTgAkhVYUvvjpeUv1rNW2wThFIOIisRXibvzRT9ECTfNbkdYFqD3MjRdrfax7wmRcdnLWrU1rbMJZvL8qNY5Sv/jvyBok5kqweMSWYIyRgIWRfzBQLt9RSWMfNoIDuaLXe2k69KBS5GfyIJNv0GJlvuaaOZdNU0B0tCt1MwdSuL3PQ6e6asdpe2yJv/CkJC6bS4E1dH1taQFG0ytz4ELw7nkIinY40AGz86BnjJXc1Gc5VbiGKsXICKUhkbwxva7j9AwgIPhu243OENVMhlKcUuvA/CHFz1IHIWLSuih4TjxGnxM6AVcBcyqT8ecRRPeyax5F2SC4ddRFE01vxPVWOFYjuS1IPiTHvcFPLssMYKJc9B0cw7jzwMcUk4z1zJExhodoQcHyrbC9dOhQNi1QbM8wk1acUSGDJ3L
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(366004)(346002)(376002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6506007)(53546011)(478600001)(38100700002)(71200400001)(7696005)(5660300002)(83380400001)(9686003)(86362001)(316002)(41300700001)(8676002)(33656002)(66556008)(110136005)(52536014)(8936002)(4326008)(76116006)(54906003)(66446008)(66946007)(66476007)(122000001)(38070700005)(26005)(2906002)(64756008)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UIt87i8/VAGwImQB0x6m0oXmh2/WKhLdrP/aheGzeT7KnxYVBnGUw+VMnIlN?=
 =?us-ascii?Q?lE51uC9fzu94++EANB2ds0LQV4vVf3nJncUa6lGk2iSEJIiJuJmC3GEhhKS7?=
 =?us-ascii?Q?mi+6+vw51yILAckFENVfoamrGKvxl8q7+DiRz0U+B3T4yQb4wfbPozj3tJmQ?=
 =?us-ascii?Q?FRr7p9QPZqKXvxPgxTLCl+DR0/+Q6iqd4QwI1KF58BJNnvWw0asrZx11VEX4?=
 =?us-ascii?Q?kBhDeZBy1EI6vm8CDuAhyzs408kEVS36o9JAUsBlB1KN/hwh9LLCKWoq4jSQ?=
 =?us-ascii?Q?FKu2KQP5YX7kWWQQDBtHVGIQ/RWeYGPcXIWxEyv0B9E4btSBJsgRH7e3zJ5O?=
 =?us-ascii?Q?BiD+3H5reUQzwJvXA6EG22OTjV+i/7O8XwhuGBb2yN1t+aqWfMEhzzckyokk?=
 =?us-ascii?Q?9jWcIstWWTiFBE+hWUgaAgb1XDMNu72ESgPp7lUiT3j45b4h68wy1APpkiAw?=
 =?us-ascii?Q?q8/ipc9SNhucd3UvsljUBH9Mh2r63zRWJb02WVsdN+1daYGB7ku/lF0NZrEy?=
 =?us-ascii?Q?4J9tMk/FQoxkXDzTj96vN2iqaUAx9WAWebEcZq0DWscviYFyQBkNR9hvn2CQ?=
 =?us-ascii?Q?EHwfXxqwmbkYk7EZc/PRM82SReRQmz/1gVwm337csd6KOqhPyGqqpPlb7ysO?=
 =?us-ascii?Q?GAq7JCogL9ZKYKJSquoCYm1iu/2RS3qpUCRmcwBmlXSGMGm6f90Ln6WMivlF?=
 =?us-ascii?Q?qmqblzTTRLpqyRBZxo0sYoBdtoWBssmO4jYg24x6ToKTRZE7f4PxlYB8Or3j?=
 =?us-ascii?Q?clzfbqral9avoVXrKPsTMPaawj1ZbPqAIL9Ve+ui4ZePHIPfd5DKqwYnxuzA?=
 =?us-ascii?Q?/+hxqLOem/T/EMqOisLSR00c3/wWXskOUpMjUcdT0v5J8NUGV5pqmQYffYn4?=
 =?us-ascii?Q?iTok+l01s5tbVX1cgIRn8C039gSTgRgvmaXqEup8PYYKJqHnHrvmFQYGEdjz?=
 =?us-ascii?Q?miRRmB639mreTDp8yhmAwE6MkyGn0mGFEClrFo+Wjj+9mofD9TBV58BXfl7q?=
 =?us-ascii?Q?V3Wrv08HhkXiQeRbzDI2KUYgRvAWJY7eHUzeM535H7u+Uc9JGrjbr/D4+V8p?=
 =?us-ascii?Q?jdx1MiiiEXAmdqeiCotK1rRXJ8N4+BnxcTeSp8WmF2QrtP25MtHtd3xutD+I?=
 =?us-ascii?Q?SIBYvEJ5DtUuf4ShGYNrDmV3M0t0VgPGrojLrthvNxyKVgVMKHrLSUua2ok2?=
 =?us-ascii?Q?fI4jEwClirKcFkJgRQ+HcVZiv2tKT3YU35y2XnIM/LMJBBfjSxEEr2NzgOfg?=
 =?us-ascii?Q?NhoHDJxgoPgt8cFrFf0sE97njpx0eeHoXH5YCup1JfeEzssI3PRhgO/ZQLd0?=
 =?us-ascii?Q?WuunS48PvEIM8KCZkSJrQKBqXe2VoZbJZK82g5bdQj7muOKz4QNke520O2pq?=
 =?us-ascii?Q?bS80SQXjgBewAgdyEdQEKm7fRMsvDyn7ySQ5qkjBUe4wNQBvoxsc3hvLXHEE?=
 =?us-ascii?Q?RIzjHvuJahT2lmSO6l3dNLZqyDZ0+L+ruUNhT2VxR6vWM7HTcIrEC3EP4c0S?=
 =?us-ascii?Q?2ZxoV9GZdpTfYAqggdTyOjSZ8nQ4b8joq1MCPrmfoi+O2ig3NkBKGdn9Lstu?=
 =?us-ascii?Q?9ocyRijWrzsUJwc3fh4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e60872-da70-4769-22c7-08dbc0441cdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2023 16:58:17.7668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V6OmWklPkR0TZc5SOOa4rRttSVuwhkhEPComi/38RCdOd45ydyUdz0wJoSWrNitlWOoPqGvhqNQ3boMkHPMEog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7783
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]

> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Tuesday, September 26, 2023 7:00 PM
> To: amd-gfx@lists.freedesktop.org; Sebastian Reichel <sre@kernel.org>;
> Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; Ma, Jun
> <Jun.Ma2@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>
> Subject: [PATCH 1/3] drm/amd: Fix detection of _PR3 on the PCIe root port
>
> On some systems with Navi3x dGPU will attempt to use BACO for runtime PM
> but fails to resume properly.  This is because on these systems the root =
port
> goes into D3cold which is incompatible with BACO.
>
> This happens because in this case dGPU is connected to a bridge between r=
oot
> port which causes BOCO detection logic to fail.  Fix the intent of the lo=
gic by
> looking at root port, not the immediate upstream bridge for _PR3.
>
> Cc: stable@vger.kernel.org
> Suggested-by: Jun Ma <Jun.Ma2@amd.com>
> Tested-by: David Perry <David.Perry@amd.com>
> Fixes: b10c1c5b3a4e ("drm/amdgpu: add check for ACPI power resources")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e4627d92e1d0..bad2b5577e96 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2238,7 +2238,7 @@ static int amdgpu_device_ip_early_init(struct
> amdgpu_device *adev)
>               adev->flags |=3D AMD_IS_PX;
>
>       if (!(adev->flags & AMD_IS_APU)) {
> -             parent =3D pci_upstream_bridge(adev->pdev);
> +             parent =3D pcie_find_root_port(adev->pdev);
>               adev->has_pr3 =3D parent ? pci_pr3_present(parent) : false;
>       }
>
> --
> 2.34.1

