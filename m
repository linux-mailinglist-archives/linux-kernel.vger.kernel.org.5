Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FC87FB31E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343866AbjK1Hru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbjK1Hrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:47:48 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A08C183;
        Mon, 27 Nov 2023 23:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701157672; x=1732693672;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/52T/OGL2GVLGaQziXpoXeYANTZ4L026z4ukzefe0Oc=;
  b=R536tj6iAJ+2jsIOIocQnYbPcxqHMbrLkTqcD+rNIqltgcNCvi5TiOPa
   V1BrR0aXoDdo43kuAndbX7l5wHHd2wzNCAxsfEFj9Yl6sUT8lkWbsvQXv
   SBhQoOF5A36fNd33Hmtusl7KHdaGfg1WAYoq8U3zHZV6n0CTJ7A+bkDw8
   f1J+i0HGy82NMEtIj/aBiJU9mNtk0w7lZSEmm+BSHq/d8BvcUyxNR3+NO
   8Ksk2utqALmiBcbyxlgCKuyD/LXkyPMLwGGj3mLtvu1HLmULk7KGuivdJ
   Rv0Q78M4l56rUuLYEnU4HKkqHeGpqTLRYeAmQwvwkk20oeaUE+WBziZao
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="424022661"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="424022661"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 23:47:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="886317836"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="886317836"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2023 23:47:51 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 23:47:50 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 23:47:50 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 27 Nov 2023 23:47:50 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 27 Nov 2023 23:47:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzmuPRwe0qaJbS+RMivILc0ln4xT9U26K284Zt9y744e8fosud9k9h1ZLnG6v5QsD47isXeWPdNt/c5PxbT4OYkYsYoWx47rqCs/QpSrAa3KfuFyaia/87Zj5ZtUZzPnYjeCXs3801Ed0RjAMaKrruu0hydnmMmMK2uvzW22cKaENIE945wWX9qEf6o7GEWcGoN6TOt3eaKrwkLtyT3CHXwb0gDMSj17UZ0Pvxa9prS7cnLlvqOV8yXdJxKMHkNYWEk7O6uDjqQiryRx1SjnNws/a8fJoyWIM7w+MfhzXrxAOj4Tip5P+J+q2XRP6R+V1ixOY/JXUybxlIk9g/baXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXPFJ0r/jzQ+8pyjEprFuu3Un7rJEu0+eb38rJ2pKyc=;
 b=YXo+1Nalbzd5iq9tFxa3wz2VWhjWE0kSf6JKU65hAsB8RkOpuu/L5F/jVwJszlzlsd+PCuL8l8AwMpQfZe1hFHPYNy/wbKYcShjcRTFNBK2SwexV81hvxecEXE5EEUhAAZTVJRFZtwaHze7LAt2T1yvYZSR/0tjUg9rqTmlH2Jt3ZGPcRA7S3qv/OZx1+XIiy22XNwW2Xxd7dXXnCbSYROzXRLBaKzDy6Toz5Pj0Gdkd1JfQjJOnhrjWeKB+sN7/x4Le+UmfK4KEW2cLOUPFjw3sF9a9c+H1fi1DNV4c7PtflvxMvFE9+YFRFt2QHp4AgrVnpTSp+p3d5fOs+LZDSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by PH7PR11MB7516.namprd11.prod.outlook.com (2603:10b6:510:275::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 07:47:48 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::6a88:3d6c:99ec:d988]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::6a88:3d6c:99ec:d988%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 07:47:47 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Abhinav Singh <singhabhinav9051571833@gmail.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "rric@kernel.org" <rric@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] driver : edac : Fix warning using plain integer as
 NULL
Thread-Topic: [PATCH v2] driver : edac : Fix warning using plain integer as
 NULL
Thread-Index: AQHaIXqYcQohcxYLxEecXXKMHCjQsLCPWaOw
Date:   Tue, 28 Nov 2023 07:47:47 +0000
Message-ID: <CY8PR11MB7134D203710F24755B7651E889BCA@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20231127202906.GIZWT8EgKxGzLQTRtw@fat_crate.local>
 <20231127214156.432669-1-singhabhinav9051571833@gmail.com>
In-Reply-To: <20231127214156.432669-1-singhabhinav9051571833@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|PH7PR11MB7516:EE_
x-ms-office365-filtering-correlation-id: 2e10a700-eaca-498b-7601-08dbefe65095
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5ljdJqnQmo6GwZV+j13hU2NWx6ttwjU/ajankCZhaizXHCMXVjhRmkW5YuRKreMxtkzRv905Jt+Ot3+5i6NOVDCJHwIZz4bPoMoyhZ6I7FWIis854fHQ43+Vy1mQ0yS9u62vHqehMikf5YXX7qW3DSkIB2CvMljk97BbqyRBaY9RfmVTF+A2eGaeqUea0KHWcQR/3LmvqN9D8Bxdcr1udWB7K2CmD2DlYWp0AGtK7/WbAr7N5i2JHzX5Wul+A9rd5ltZ1GcUi2k+HrJxqcPhGikf6upx1bWLtYl4qPF4bvfjO7Q7UR4Wuq23g7b3mFR49rdv8/Z5icYI5GZ67i+N29xLlQWrnNB1gbVabxDbxisumXy2zyay4aYByeyxKDO3UbS7KwBZupfGIh9xSiIb2VSklZWdOynhU8paZzOzOZi03cfMJSalaA7znhfado0Bq/nbhLJUUvhkSwXpZwxiUS9ZSi5fvQp5SpR1S5ANCONnX4SbU9kaIjAD5HN+0CUeSpTNsVJqC9/QiU+KK/Z5FQGEtHo7kjmhfU20qAkxhOYeIMNZHKaVyX/Qm8votKHadoJ4HlZWPl/5ujf/0f/MQFH9tGGSLBjyxShWFxGVRBBgHwJSoli3OnmX37a9fHYD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(366004)(376002)(396003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(38070700009)(55016003)(33656002)(122000001)(2906002)(4744005)(41300700001)(5660300002)(86362001)(71200400001)(9686003)(82960400001)(83380400001)(26005)(38100700002)(6506007)(7696005)(110136005)(478600001)(66556008)(66946007)(66476007)(54906003)(66446008)(4326008)(8676002)(8936002)(76116006)(316002)(52536014)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oyme5Uo5qLh+HClcU3dvG42rhynxE6XLunQbo6KmdHUd7XEFVTl1XYk+DtIO?=
 =?us-ascii?Q?liMjGJWyJvNXSnttWoaePBNP+Hlzubhiwce0kWXbN7K2/PlkKVPTFq33m5So?=
 =?us-ascii?Q?eVoesgqdUUC7Q+EwmEqLjdwim5urqKmeI639NOSqTXlAKU9ca7Kn1lOrpueu?=
 =?us-ascii?Q?oi58oBcouYPTwM9emHGA1zGsZ6PLG088yJbM8XzEOsn4eAKDrAzsglbFBU2I?=
 =?us-ascii?Q?/B0W7TQ1DnZKw5NliY+Q3iYFSkqyjPjPrAEqiLdzLyxTZMhNtQrERL5SBjQa?=
 =?us-ascii?Q?8MP1/Nv8HgTm7CryK65bbHHzCWJCmFR+P160bqtRWTzVTylIUcuCB1iR4Y4a?=
 =?us-ascii?Q?i5N0DOBTj16PE/2FUHvCmfuc95krlsWMTy1sj+JfKH4p0onJ+ifo7Zen6Hqm?=
 =?us-ascii?Q?9w7QKf7SDCO2JwSB98RLieWMoYIPGJnOK7g4EZlIPsCrc57fTj+hExRlcuKF?=
 =?us-ascii?Q?Yi9uqY/uo2gowCvc4YIOPUf1tPi7BBvr2Yf7dhscNTtHlaGC6uuA4t2/Zl8C?=
 =?us-ascii?Q?uFUYOOEH+GDkUPIBciiK5dSkgkMXgKcTvMBzN1gpPqYWjBp/9VhpHGn9KY+j?=
 =?us-ascii?Q?HX26mQ3pumInAXE4XoGgUdh8DKHhCx9aloYSqusg3LnDinni9LST3YTvomf0?=
 =?us-ascii?Q?+M42tbMB+ytiqjXLBYpYmyZ0ZlkXk4cTGqs6BxmOxu1c2MwXQDiDsNV+fkvU?=
 =?us-ascii?Q?1vC30CI9LNCmm+W4IGgpMFR1gsrp+OXNV2IHvlal4qBcYsbc19pnKEhgrL6r?=
 =?us-ascii?Q?Vsw5BCsYm1krmRibROrpS0ywXPnlSKKPHkmGS+ugEgPxaiELMVEt5VcUogy2?=
 =?us-ascii?Q?CeYZLJS1dU+W3ubm4mkAL0hedOln8RbuDcoSMztgRDPnEiwFiaD5Wh9v1C3i?=
 =?us-ascii?Q?yWzHMixsFHLeNjv5iAjwB2haYT2sWFPvmggCx2fhfAMQMgc3vA5euaCZRDkn?=
 =?us-ascii?Q?XjdaYell6Vg/QXtSZZWnDRSbX5dYDJywW5K/JIDfq2uA6CVS/J64Bm6auF5b?=
 =?us-ascii?Q?Z6FgxwqrSCebUZX3GXFHTfFoh8or7+3Z/3qaIU0PKUB/7ocYWrooRPqJCadX?=
 =?us-ascii?Q?8lnBqyn1+fRkqbFaCQm++9gyAsbiFEquaSiPi4w3VWmqY3WTCxr/btkp2bac?=
 =?us-ascii?Q?S+bwzbvUafMWV99KnnvLmrcI7ejifSLRLZnROVbFmc/lV8QI+Oy6NmN0Gyib?=
 =?us-ascii?Q?Rm8UPoxNpX393WVK3zOeM44oqfZuoG1kAtr/vcpikwrB/kedoFTwIue5zQlB?=
 =?us-ascii?Q?0rRA3RN2fSLeJE06WvCn7jnEQEopbD+TTipg7C5ZwRNVT0Ttppub3eJPrG4m?=
 =?us-ascii?Q?DWq/hK1Efi9etHt8gfBiz5QcHitksJ0Xl/ZSPf033qdNKbglJNixlCijAgb+?=
 =?us-ascii?Q?/SHPlsOXoD70tVa0QJyTWalOzGeSd6nJRL0YModD3Ba/3sL9ijkhODKQXNZ7?=
 =?us-ascii?Q?GP5sYZV2a+t370yBwTd3lfy3cWVV0tJIWCGa30N9CnhxhQZPGjrmgpwLOirZ?=
 =?us-ascii?Q?eMZI25PVXdjz2Tghcf7QHXu3mnzYTyV2YOoqV+rxtv1N1TkdzyXnZUuo8pAF?=
 =?us-ascii?Q?oLlTexycBrCRXY//pK1FRZcGImyuqvuhRwcQiv0G?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e10a700-eaca-498b-7601-08dbefe65095
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2023 07:47:47.6114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d+mESfcerucaQDGPjcmVw5UINw7gQQH4AoL8ENxLLXn4NsIWPoaeHudI3+qjB2uvcjLyQZcy7mjHlEQbA/gN6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7516
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Abhinav Singh <singhabhinav9051571833@gmail.com>
> ...
> diff --git a/drivers/edac/i7core_edac.c b/drivers/edac/i7core_edac.c inde=
x
> 08bf20c60111..4c76d0f180ec 100644
> --- a/drivers/edac/i7core_edac.c
> +++ b/drivers/edac/i7core_edac.c
> @@ -376,7 +376,7 @@ static const struct pci_id_table pci_dev_table[] =3D =
{
>  	PCI_ID_TABLE_ENTRY(pci_dev_descr_i7core_nehalem),
>  	PCI_ID_TABLE_ENTRY(pci_dev_descr_lynnfield),
>  	PCI_ID_TABLE_ENTRY(pci_dev_descr_i7core_westmere),
> -	{NULL,}			/* 0 terminated list. */
> +	{NULL,}			/* NULL terminated list. */
>  };
>=20
>  /*
> @@ -385,7 +385,7 @@ static const struct pci_id_table pci_dev_table[] =3D
> {  static const struct pci_device_id i7core_pci_tbl[] =3D {
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL,
> PCI_DEVICE_ID_INTEL_X58_HUB_MGMT)},
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL,
> PCI_DEVICE_ID_INTEL_LYNNFIELD_QPI_LINK0)},
> -	{0,}			/* 0 terminated list. */
> +	{0,}			/* NULL terminated list. */
>  };

The updated comment (NULL pointer) mismatches the code (zero value).
