Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2638C7EE1B7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 14:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345228AbjKPNmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 08:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjKPNmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 08:42:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC39D4B;
        Thu, 16 Nov 2023 05:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700142126; x=1731678126;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JNZj0VeqGakIRzyE7XlplM8wUXURoS9mOZ1Q++UDIWA=;
  b=AUMiscHrRFMhsI7pQThPDuA94nOYYgDjwnMY3LJxAzcyKVfJ4mS0el2E
   legCt/YUIDp6XiDFpuMR1+xOKiL0hoVJF0eh3tyWECnPG8EtCSBZ86WqK
   Cnr22EpuPvbD6Wi0jO+WfeaDHKdmBz7+Lu17Hf3BFmxfVrv4E+5D1B8BE
   sz773Y0mMVqEtNhwL7Xewktvc/z7Q3QAjYbUO2YcqYVO1IQqRI7KTM4Ot
   AlLaZjOHcfGzgt9BUm8/DzzP2b57kbwMXYeCECIEWuNiRJ19npSHw5RyX
   yibi4Mie1JG2FjtddGmpz4k9rGEAHkogkoSSOFAngMkOg+xzkiu5feAMf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="4165179"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="4165179"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 05:42:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="758834031"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="758834031"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2023 05:42:05 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 05:42:05 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 05:42:04 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 16 Nov 2023 05:42:04 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 16 Nov 2023 05:42:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHlMKggUih5JYHM/6Iy+MDLw8Hn9isKSCV58/l83uLJf1SbXWcosqh1meSZEog44N4DvpzDX+2G3axLjCfD3GNgJlKYSSHjtelcIwukz66w2ZYGnIItSXdQdYnWjNKbXg8jKLviB15LeMqKuoA5ci7ckNBsPkCSA+33jJlWxPU+FtZZi97JskTPKESl/YMM5HH4gxEjVSvkBX6NWz+oAOWwWW7bKYiLW+7OSBYXPBZt90emhqElgNSlzyJFR7J1P8MAo+3AOBgCeBvP2NeKFiwhD53Zno62+SrMg+5VpeKVLJ4cwDDJ+mro0/MpCRctukTloo0g2YYdgFvi3+I7Ubg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYQVEgp33jR1vJrXKrklkG7+YUDjwTUTk1GeSxZHcDI=;
 b=SgluVr4gOJbhhw68Mq8fJSmpO+ItvqpDQTJPc5gQZp+3csU7aJNuYjxNy15o6KuI2U149Xmq+SgqdMkT78ecU2wxJCrvkue3lnvoAn8w8V41ldCr4M0uLvSKCwK1yJvun0K9EKGT/T/shuCwNWs1yaAkL8dtrMgpG/OZrUIgFVm6FhB1nTLzDTF2gFJS2AbDLdbp+QfXS5SWy3hihmtCrT1b6kEivjAkf21n45qGV8J1K0Yf+B8QgKZ63KGaRzHHD3ZHd+RXtwwH0iX4WQWx4HzrEaZycteDHVamDB9VMNRcbI9M05rUORXxZXLbCQ1kKxi3Y5oenx4jJ/vWov53cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3521.namprd11.prod.outlook.com (2603:10b6:208:7b::32)
 by CH3PR11MB8434.namprd11.prod.outlook.com (2603:10b6:610:176::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Thu, 16 Nov
 2023 13:41:56 +0000
Received: from BL0PR11MB3521.namprd11.prod.outlook.com
 ([fe80::2a7:165b:5c95:7a5d]) by BL0PR11MB3521.namprd11.prod.outlook.com
 ([fe80::2a7:165b:5c95:7a5d%7]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 13:41:56 +0000
From:   "Romanowski, Rafal" <rafal.romanowski@intel.com>
To:     ivecera <ivecera@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "Drewek, Wojciech" <wojciech.drewek@intel.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        Simon Horman <horms@kernel.org>,
        "Keller, Jacob E" <jacob.e.keller@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH net v2] i40e: Fix adding unsupported
 cloud filters
Thread-Topic: [Intel-wired-lan] [PATCH net v2] i40e: Fix adding unsupported
 cloud filters
Thread-Index: AQHaEAenTBr/sLVOWEaQ2WLzKu4YDLB9BSvA
Date:   Thu, 16 Nov 2023 13:41:56 +0000
Message-ID: <BL0PR11MB3521D6872712EAFF01B239B58FB0A@BL0PR11MB3521.namprd11.prod.outlook.com>
References: <20231105164602.1107498-1-ivecera@redhat.com>
In-Reply-To: <20231105164602.1107498-1-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3521:EE_|CH3PR11MB8434:EE_
x-ms-office365-filtering-correlation-id: 0b2350f0-1738-4ed6-ffe2-08dbe6a9ccde
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eA2/wq4m50fn+un2V6NteHT3f8lkhJ8FCIabm9Qjt8aoyvFrE8JI3sEaiWwhsr0d9RlhO2/ktpKmsscOcPi1W1BNhgbB54m5kNMOwWxldI7+3nI2bt43avGZh2kA5Lg3l7UsKSXxPW2J37i96uvT8eCQ8vMqoeyjVc4HDjQAvn1Wo44YHcqWGJP90+x0cCrNn+B1ACKubNoTt5qfZOrtsXdZdblyO5eJeSKPM737yjO6OhjFinlvdY6dLdmAXM4J/p4rNPkCTZkVxqE4lOmNjzxR0SfXUti9uu06STFD/Y8pWPFx3m1u2xgSxrRJkS247HnUhqYvpy6l2la8qZ09InK6P+5bTmVbtdaWhtT0LxNXVEUmPLeqQNemHAKM0KpICSil7acSuxCGtuageWAPSrItGatZHOrcc3Xv/46x2pfh8VVkW0q4345JUVIuuyi7UfGCYvfzqRKgUG08nh8jk7X8DhrD86nTdru0VheX4d+9ql4F5wmvgQkZUV2rGEsKkpj2jabmL4Fp+FiMWENknFs07sillD3BAA+iHxMJsH+C9OKbYGWMfc7njqYZOJSwAeIA5OQoB/4QGYpR485D13DjuDIjF7eCB1R4qLKjATS8tamNDY/+A0fmAVWIjAtS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3521.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(41300700001)(122000001)(38070700009)(38100700002)(6506007)(76116006)(7696005)(53546011)(26005)(5660300002)(55016003)(9686003)(316002)(8676002)(64756008)(66946007)(110136005)(66476007)(54906003)(66556008)(82960400001)(4326008)(8936002)(66446008)(52536014)(71200400001)(83380400001)(33656002)(2906002)(478600001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/39neU4JN4A3o8poaE08s1Y8lGhfetEDDXUurVIKJpojxigMCrdjeGg1KVsK?=
 =?us-ascii?Q?kc6aIr8TkbY+9lLqVoHB7BzPiBUh1yzfpq06sWrJe4OK7MzRTxHmkuwg1AoV?=
 =?us-ascii?Q?JegBGtGckrs+Gr2Q2X5aEKuYoStXt9GV3AzZJv+jHVUPThxc0U6C4gy3V+DK?=
 =?us-ascii?Q?pM4XB6+OaV1u4FrTsREtxgnMh432qHHrDbmQIop/EAXR3TtVmc3i3AKQC4p5?=
 =?us-ascii?Q?A3WD5N5BpWxvnI5BlQ3V6rRAl27ZzNfzVZMeq0AgUloxznkU/WbGc4y3LBpc?=
 =?us-ascii?Q?wOD2JoHq1xuqb6B2/+R2KbUR7lK1lswMdO2DcvPmyeKNazovbvGQcNumWFXD?=
 =?us-ascii?Q?pHMZZCqVwo1HWGno4U88UoVXBkIS82JzUOs/p0mwkKUyaNdZuB09ftFIgmhK?=
 =?us-ascii?Q?9WU/ZUBFimXFGvRMTnj+VkZPSDIEbilhFxRh686DF4ZBlh6GQTZf6cydHPGP?=
 =?us-ascii?Q?s1QrLvUax28uxtRM4sBHkEbZfhIvIIx1BCVgSZACV5lrso/hS6Labhro/vKM?=
 =?us-ascii?Q?u7pGgSX1GoFZYzod+/p252plWabQQfzTehU8RYAOVmqGijyMVRQSv+mwpoja?=
 =?us-ascii?Q?0lsm6Y4XBEtqgWYeKxu9+vM1EFBlSO3ERjhSQn1Rqg7TWsE90xNVd1mT4Z+0?=
 =?us-ascii?Q?Ywwheu62whAXY8QW93/1vWlw5eAA/NYGNwPFmx/IR5z13D+NJ00vknFU/A4V?=
 =?us-ascii?Q?waxylXm5TYCf2bNGtg7joGio1pjrX857zwcEIR9Nok1a65y/274hKtTNoqD+?=
 =?us-ascii?Q?OxQU1HrpHystrRSyYLbu2tCRoWYU8243/sPcZWDbQXnSzGIa5QUVk0USfxmc?=
 =?us-ascii?Q?4Q02AgaaNbXg5GPjsjbprwgAvqZ5ZXkItUUBbXCR3SjJdjeVrIVidh4glxzB?=
 =?us-ascii?Q?+1Du9ZOphZJfGVVaA6YaXYeV8HJ3Jzscc0n18ZhwWrVRy86PX43yt3bWiE0e?=
 =?us-ascii?Q?7QTC6g0u2zQMZeko+AwtTLoZTkudHiRV9VtLjPwOkvzex/tGQD7x3zbjPKV9?=
 =?us-ascii?Q?CITaxoKjPWhPpy4sGBX+7hvQeiod4zhVeZsVq+zHfrjaSNIwh230p1oYgs7Q?=
 =?us-ascii?Q?8jLmEtuoPih7fgZQnUb9wD24e57unLPvYCtiunSVihI/mF4/STOotcFLqFMc?=
 =?us-ascii?Q?eqLwGynMBn12Z7O1Dd+tZKKQ0LKQ9CFvw28U7lbxcdEvSeXLPgpkblgytOPr?=
 =?us-ascii?Q?Q0GsPo9+lyQE3yj3fEaGV62EqYup8QA0Mi436Bhvh2alPqS3qdjf+PtW3650?=
 =?us-ascii?Q?tXWcSeYgM+F+YuNQf3kD7IHSj8VZ1mHuvuaDC6FFFAtB9RP2wwU9M7QVg1LD?=
 =?us-ascii?Q?rlGCRgG0reHyS3w0rFeF80bCuzXpXxgKy27PM+SitSNJ7a2CR0JFBswB2t+8?=
 =?us-ascii?Q?Rz5rpc5UjBBLIqTF013hSON6MkJHpKy81Z72xFIDSDuRfh8C5oHCR5gY1hwF?=
 =?us-ascii?Q?rxKUp9km6PSCJRUORTSJyK53nvhaKVM/GY5R5zdOR0bHxFu/f3Es/Lmr0CzL?=
 =?us-ascii?Q?jgE5PV/UgL8c3+83pmvyRaO6BXRmQDsBs/Bstn4qqIT1NWbM6dyUtOrrhIhD?=
 =?us-ascii?Q?iWBxoGlr1TnKbqpF+2s+o2n3M8BnASeeMFT0K5Znk9kmt+lFjoL8p6GZYHkl?=
 =?us-ascii?Q?0Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3521.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2350f0-1738-4ed6-ffe2-08dbe6a9ccde
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 13:41:56.3882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ddHc7p1SlYsMGNEq+97Vm6Mv/jwj9dhAiPFLjSfKatPCdmwsD/QnshPmxHJixS3XVaMTyQzvD2kbvsOOCCmVKsLdhLT5pVYQ6r2zvu+RN+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8434
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Ivan Vecera
> Sent: Sunday, November 5, 2023 5:46 PM
> To: netdev@vger.kernel.org
> Cc: Drewek, Wojciech <wojciech.drewek@intel.com>; intel-wired-
> lan@lists.osuosl.org; Brandeburg, Jesse <jesse.brandeburg@intel.com>; lin=
ux-
> kernel@vger.kernel.org; Eric Dumazet <edumazet@google.com>; Nguyen,
> Anthony L <anthony.l.nguyen@intel.com>; Simon Horman
> <horms@kernel.org>; Keller, Jacob E <jacob.e.keller@intel.com>; Jakub Kic=
inski
> <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; David S. Miller
> <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH net v2] i40e: Fix adding unsupported cl=
oud
> filters
>=20
> If a VF tries to add unsupported cloud filter through virchnl then
> i40e_add_del_cloud_filter(_big_buf) returns -ENOTSUPP but this error code=
 is
> stored in 'ret' instead of 'aq_ret' that is used as error code sent back =
to VF. In
> this scenario where one of the mentioned functions fails the value of 'aq=
_ret'
> is zero so the VF will incorrectly receive a 'success'.
>=20
> Use 'aq_ret' to store return value and remove 'ret' local variable. Addit=
ionally
> fix the issue when filter allocation fails, in this case no notification =
is sent back
> to the VF.
>=20
> Fixes: e284fc280473be ("i40e: Add and delete cloud filter")
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  .../net/ethernet/intel/i40e/i40e_virtchnl_pf.c   | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index 08d7edccfb8ddb..3f99eb19824527 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -3844,7 +3844,7 @@ static int i40e_vc_add_cloud_filter(struct i40e_vf


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>


