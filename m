Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50387B7FA3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242475AbjJDMsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242467AbjJDMsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:48:32 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8EBA1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:48:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rqjwm4jIc/6VcbT++zOKKb7f4EMQ0ugPjhcAkydhMtM6LSDXno8zWpyrrCrpy+YA2WcnAE7+jicbKPQCrC5xZFhmDJm8LwEkGG0McRsJbMgK5YJZCOIKaP0GfzzACuHx881rLNSfXACOP4TlOWtmSYECmbYUftaAWEPuVStmmlByp6uv9+DaIHVW61iqLwJ13DrEQ1Zs4hjv/ThxXTehjMfgjPvnzdTjTkGMjsOOoVG33e2evC9UT2FsGj7NTbqkXOBCMdyv4NHdSXwIV5bwTlsnHMS2yaLE7j5vAA1jWRfwmIooPpvjv4fsl2qFc2U8iufmV/y2YSduK+lVughbFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCdVfYTHRz2X4WNBVoY2iP8nVEbtBtbdcZwn0WebAJ0=;
 b=YNWditCMoS4ra5xwZwAu4dFL0BFxIvuXtPSkUYbl0mX46HqrnlnM8LqxLNmcozO/r2xtyJbYUuDJm/7HPe2Z/sHkVKcNkN5MOhjBA1lMwJCgB3x9l+g54ZbFOZz1sGrDStQ7Le9LvkiMGVRZOlUlsdYlEENTo8ONx/GlJzqAKy/cuWjm7HCfXMfMmM7zR0iuV9OweHltw9X/IO8SDusxU3ir0VgQ57FJ4jlForuCIqIHY8c3XjJWqaCAXqZ2R6iuQ3lhewqGuHPjDE+GbtRPjsBHtLajMIODoMb08Q+E4MHIwyDSrwm+LhbBth/NEd3PV+r/STtH8DhYINQM0dy//g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCdVfYTHRz2X4WNBVoY2iP8nVEbtBtbdcZwn0WebAJ0=;
 b=LxZOlKDPLPyZWzjoJ/x3+BZG54TI7udmMDahZrUm/0czbhyYi81Rnf3Yn11gJNih346fa730zCH8P7pt3LqqVmXm323pfkyjdebBTCjbWjGFjFr7KLD52jmVgriJE/HRvNE4+OY48bnyTzjmQdFd/CaMripgXERo5SKxScXSKlQ=
Received: from DM6PR12MB4465.namprd12.prod.outlook.com (2603:10b6:5:28f::17)
 by DM8PR12MB5496.namprd12.prod.outlook.com (2603:10b6:8:38::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Wed, 4 Oct
 2023 12:48:25 +0000
Received: from DM6PR12MB4465.namprd12.prod.outlook.com
 ([fe80::ac8d:39d3:c560:3c81]) by DM6PR12MB4465.namprd12.prod.outlook.com
 ([fe80::ac8d:39d3:c560:3c81%4]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 12:48:25 +0000
From:   "Buddhabhatti, Jay" <jay.buddhabhatti@amd.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "Simek, Michal" <michal.simek@amd.com>,
        "Shah, Tanmay" <tanmay.shah@amd.com>,
        "Manne, Nava kishore" <nava.kishore.manne@amd.com>,
        "Levinsky, Ben" <ben.levinsky@amd.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "marex@denx.de" <marex@denx.de>,
        "Shaikh, Izhar Ameer" <izhar.ameer.shaikh@amd.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "ruanjinjie@huawei.com" <ruanjinjie@huawei.com>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2 4/6] drivers: soc: xilinx: Fix error message on SGI
 registration failure
Thread-Topic: [PATCH v2 4/6] drivers: soc: xilinx: Fix error message on SGI
 registration failure
Thread-Index: AQHZ9qcr/EmiiCTEQkagzQwutOFF6rA5i4eAgAACjqA=
Date:   Wed, 4 Oct 2023 12:48:25 +0000
Message-ID: <DM6PR12MB4465A8A84D28A1AC444AB53C9DCBA@DM6PR12MB4465.namprd12.prod.outlook.com>
References: <20231004094116.27128-1-jay.buddhabhatti@amd.com>
 <20231004094116.27128-5-jay.buddhabhatti@amd.com>
 <2023100425-chivalry-pound-78d0@gregkh>
In-Reply-To: <2023100425-chivalry-pound-78d0@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4465:EE_|DM8PR12MB5496:EE_
x-ms-office365-filtering-correlation-id: 2dcdce9b-4665-4853-ac9a-08dbc4d8334e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R/9HblHAh05HCrWtelYQM7jgpau0AtJajJ90M8bNAYb0kwaurK5c+eubTj8LAOUREwan+y34NqGH6Kl5AcYra89ZESfxF1dLDAb9CYYfx/37usBL3YNkpVcgzILOWyYV7CJrs/Bn+Pf4jKapnZnWogfO93D+8CZ8sUIh74WsPlVbBoInQV99Heyl4SV8lbHZoljD22U6HE05Yar3wIdWYTfJeSxqAXnLIqFt8EEkufxRhFEFs89qsQJ5obkmJZEngR690Drop1yIJ25UGtKU8o+tFiyjyXpn1Ii6DW7nKau+SmprUZUOo2ckz1e9kpymd3Orq+U5YFWYZeySuDl4pD6Iv2ZXBgYn6dyjU3ffvyyq0TbQLLRrhf6PH/Xo3Dq4Oz40lvolU/eBpEfgUSfNTisAxAaS7EU0Wva1FlzCp7OzwgcJbgWYi+K0E1U2U41NxgayAHUPh6naLEyZQg6Je2SiKZ8jYbcVc6fzdPGzCnmHHzOHvlGdLq+1uPYX362m29+yyRG+fdSakLo2ybqzkSNCwTMwG+Hncl/hmcKmKwYi5lylBIINrDZRGZIKH1X+LewQgFXRaxERGq7ZSpSCt8NCwhZL5uJlbKg7xg/SFE0Stoti/E8fxE/FUR+hH4w1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4465.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(366004)(346002)(396003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(9686003)(26005)(53546011)(6506007)(478600001)(7696005)(71200400001)(15650500001)(2906002)(66446008)(83380400001)(54906003)(66946007)(8936002)(316002)(6916009)(4326008)(64756008)(76116006)(8676002)(41300700001)(52536014)(66556008)(66476007)(5660300002)(33656002)(86362001)(122000001)(38070700005)(38100700002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8tefdCn53kn3Fx+iVNv91fo1C5eGS3JhpzbinZ0kghPNAIwtgNqAQNLkbxa6?=
 =?us-ascii?Q?r4wy+7ns3/ovhV8cqtKCj+MNqi8Qi/QEFko0pW8jQY4Wjtq3SrZ4xbMomf6z?=
 =?us-ascii?Q?AACLIThIxyB4Vr/71tF5sedEwP1YXSBqaXdMV9sFD+XVk7H77byOTTereQiD?=
 =?us-ascii?Q?w/tLq+ozw9ahCqAFNOm7jjpmRIokn43oCPbsZ17+ObXn65VU3/WvQwgWFcCE?=
 =?us-ascii?Q?X013vtcJI1bA5U9T7eY8UrgwuMrDagd+Nr1QVaqTFdUONuLK8KKZzmaJmPpI?=
 =?us-ascii?Q?6zxIi82d6GQODtnFBJwv4CkVDXFByIXmZF/bNBEqJRLbRpjmgB6CaEYks0Qg?=
 =?us-ascii?Q?HPb46VBLVoiNHdLYA7jAnGNMxLBD3oF7q0qRzBonxIKF8t8c+nx+2XVqlygB?=
 =?us-ascii?Q?xSHQS6SPHabx2TXweE0GQDJcjw+oUdMKzbm5HdY+k4f8rtzGl7iFHdWv0+tt?=
 =?us-ascii?Q?U22j2lS2/jQm4tvnyhwFSOKMsf3LAqF/uqqeIT6BnETYSM3BksT8XLaktc4c?=
 =?us-ascii?Q?mV034/lGskyASOy/UiVdM+bthwpYgnM7AxsWeXr3LBUiTxFtwJkr0IfvShXQ?=
 =?us-ascii?Q?DCLHQoqkAQc3RacyuzYBMmNTut0i53y2vxIXciIR9vcfXCw2XqGWfFvhYQfH?=
 =?us-ascii?Q?b7gANo/JSiiVTEma65AaWeJgZwXGW0zfNME2T3yGzQcSi+uLh6d8aEoJWjg7?=
 =?us-ascii?Q?JJmAqzu9wdxPWRcQGYblCUVoGSnRdxPeUsV0DqKJobLoHCdJwEarrZ2vmAul?=
 =?us-ascii?Q?sBIJUbUoy1Sb+VOIpGwRifeDvhOTvWEWcIw7TdMFogYKveU3AbK694cZDJp+?=
 =?us-ascii?Q?MqSZfdZGRsUcUF1sP+Y6zsX187TBG/vgPYFzuu8QRV25349MOrntlg/Jyqt1?=
 =?us-ascii?Q?+hS+CSU1qVv2PV9Xsrmnk9oFEtPrT6ZSUPhDmrxgwE3dWdAfovQypsHVoqFU?=
 =?us-ascii?Q?ZXpCubkGRCWApbe/eN3xYpJSC0s3dybf4SQHA8xqMpqjKZBvjA+oww3IqjwL?=
 =?us-ascii?Q?rF1Ed5FOWVwJaC6fK+Qn+jMFat3ZoY5jg/cop/p3N/gnR9NXOP0D7vquf5RL?=
 =?us-ascii?Q?LLCYIAovl6D/xShSBG+5qG52xil6pKtasA/QKWxcT7htGC0+3OmQYBz8wOQW?=
 =?us-ascii?Q?ZlkQgykxUaHS0lWoa+DGOEtn7LFk35zTrnKaqnAOtekMlucru88mklAnEUuN?=
 =?us-ascii?Q?ndw75uLo9PMW+ySz6KQUUMxy3X4YGSJ8GP90RxlXPbPsemeu3pXf6FcjYUNb?=
 =?us-ascii?Q?GJ/5+0SkzhHqLPALLluYWCXS1xVUmm3A8rWIF3zBXphT5XJGXLPfJZJXEyRU?=
 =?us-ascii?Q?16rgcLdvmyIia0RsdpddpJ5BzIf0A5ZjygXmxJgahqv2GwF6zzqdkguRVink?=
 =?us-ascii?Q?/VfHPaV32SmyxZVDS+Tt1vFTgCsOiFytgk9IG1BsbEAdpHjsfq1EpaN9+q3h?=
 =?us-ascii?Q?mZvP7w3DuuK/maToO1HacihN1+Cmomod/7bvHcOXfsATkGloUl3LciiYWHhA?=
 =?us-ascii?Q?j+v8TFMRDxoxSsrb95G8gzmX5TVN0zIh8xPmvo9mYgKLPQStxQNS7Ok8K1Ak?=
 =?us-ascii?Q?RZaIuIwYGMYY/az9fzE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4465.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dcdce9b-4665-4853-ac9a-08dbc4d8334e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 12:48:25.5281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o17xt3dhtTr6aVmVshEJk8HfkgfjMAHnzF2/Xy1CjjLIg/fuHB16oTNfzwlNAarnmWwasp6E6IhkUjkCmYV0gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5496
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Wednesday, October 4, 2023 5:45 PM
> To: Buddhabhatti, Jay <jay.buddhabhatti@amd.com>
> Cc: Simek, Michal <michal.simek@amd.com>; Shah, Tanmay
> <tanmay.shah@amd.com>; Manne, Nava kishore
> <nava.kishore.manne@amd.com>; Levinsky, Ben <ben.levinsky@amd.com>;
> robh@kernel.org; dhaval.r.shah@amd.com; marex@denx.de; Shaikh, Izhar
> Ameer <izhar.ameer.shaikh@amd.com>; arnd@arndb.de;
> ruanjinjie@huawei.com; mathieu.poirier@linaro.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH v2 4/6] drivers: soc: xilinx: Fix error message on SG=
I
> registration failure
>=20
> On Wed, Oct 04, 2023 at 02:41:14AM -0700, Jay Buddhabhatti wrote:
> > Failure to register SGI for firmware event notification is non-fatal
> > error when feature is not supported by other modules such as Xen and
> > TF-A. Add _info level log message for such special case.
> >
> > Also add XST_PM_INVALID_VERSION error code and map it to -EOPNOSUPP
> > Linux kernel error code. If feature is not supported or EEMI API
> > version is mismatch, firmware can return XST_PM_INVALID_VERSION =3D 4 o=
r
> > XST_PM_NO_FEATURE =3D 19 error code.
> >
> > Co-developed-by: Tanmay Shah <tanmay.shah@amd.com>
> > Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> > Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
> > ---
> >  drivers/firmware/xilinx/zynqmp.c        | 4 +++-
> >  drivers/soc/xilinx/xlnx_event_manager.c | 7 ++++++-
> >  include/linux/firmware/xlnx-zynqmp.h    | 1 +
> >  3 files changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/firmware/xilinx/zynqmp.c
> > b/drivers/firmware/xilinx/zynqmp.c
> > index 00ea2508f692..de09d77cf1e4 100644
> > --- a/drivers/firmware/xilinx/zynqmp.c
> > +++ b/drivers/firmware/xilinx/zynqmp.c
> > @@ -92,6 +92,8 @@ static int zynqmp_pm_ret_code(u32 ret_status)
> >  		return 0;
> >  	case XST_PM_NO_FEATURE:
> >  		return -ENOTSUPP;
> > +	case XST_PM_INVALID_VERSION:
> > +		return -EOPNOTSUPP;
> >  	case XST_PM_NO_ACCESS:
> >  		return -EACCES;
> >  	case XST_PM_ABORT_SUSPEND:
> > @@ -379,7 +381,7 @@ int zynqmp_pm_register_sgi(u32 sgi_num, u32 reset)
> >
> >  	ret =3D zynqmp_pm_invoke_fn(TF_A_PM_REGISTER_SGI, sgi_num, reset,
> 0, 0,
> >  				  0, NULL);
> > -	if (!ret)
> > +	if (ret !=3D -EOPNOTSUPP && !ret)
> >  		return ret;
> >
> >  	/* try old implementation as fallback strategy if above fails */
> > diff --git a/drivers/soc/xilinx/xlnx_event_manager.c
> > b/drivers/soc/xilinx/xlnx_event_manager.c
> > index 38cfc161a713..bfa5cf4a0cab 100644
> > --- a/drivers/soc/xilinx/xlnx_event_manager.c
> > +++ b/drivers/soc/xilinx/xlnx_event_manager.c
> > @@ -653,7 +653,12 @@ static int xlnx_event_manager_probe(struct
> > platform_device *pdev)
> >
> >  	ret =3D zynqmp_pm_register_sgi(sgi_num, 0);
> >  	if (ret) {
> > -		dev_err(&pdev->dev, "SGI %d Registration over TF-A failed with
> %d\n", sgi_num, ret);
> > +		if (ret =3D=3D -EOPNOTSUPP)
> > +			dev_info(&pdev->dev, "PM firmware event notification
> not
> > +supported\n");
>=20
> Why is this "info"?  Why not error?
[Jay] Because it is non-fatal error which will not cause kernel crash.

>=20
> And what is userspace supposed to do with this information if it sees it?
[Jay] This message indicates that SGI registration is not supported by othe=
r modules like TF-A or Xen. So user need to use TF-A with this support if t=
hey want to use event management driver.

Thanks,
Jay
>=20
> thanks,
>=20
> greg k-h
