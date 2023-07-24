Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582DD75F476
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 13:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjGXLHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 07:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjGXLHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 07:07:38 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D271732
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 04:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690196837; x=1721732837;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WCzzU2U2k6F1eG9R9CIKeDTOXRIzcFemTU+IkQqP0Qs=;
  b=G/SmK+kMZSfGOKt1Ns7LYCJYdnCVi9uGFDmWDdMQbqdjcwQYMBs2JasZ
   II1lh/5u/UcSNopMYBR1X116M3FBMbGSgnmdfU1VzSFCCsK9ccCQoT9Mb
   UrjlRQO30udKDCb/bgKXLdn8AVxNA0rZm7KI3T0xQkccIwW7P1sYZROSn
   7hewiMFVHVYl5ADwBkYW4ZFwRJs3brfPOX4L1svZa8M+pdgnZGW+8kgld
   PKZhZ2f1fdEsKRLcPUSw3wvSjgf9aJBVHZxA36EDEXgL6UJULNPDTTw+7
   us8xUtUy0xoyW4DIczvBsHYeq9wxoPPNyS2VA7wxf+dUjgBkVS70xs00K
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="431206779"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="431206779"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:06:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="972219342"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="972219342"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 24 Jul 2023 04:06:05 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 04:06:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 04:06:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 24 Jul 2023 04:06:04 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 24 Jul 2023 04:06:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlk+BEdcuk53H72u5UwAHeODzOJhGxhhU7EQ7YiClgBfDGckahYz3cBqqowjTgzee6CY0Ph+ssVR9Tb5tGsOxajFI4veRZ+lMnhVwV5U4oxS/RJr2pp5AntCqXJbha25PZUECmeeRxOwZSs3V0sDsntfrTL1y0CTOyHWawzVwl/d3KGaFk+rbxtrAHct9/wkyEWYHTmpebh1BVppEv0cUVCHsx4V/dzt2e9ZKNQqytYi0f5VduS9iAN3iS+HK0IvT3HUTk518uEfh/Y5+H8LjkYmUALaRx8u1Qaq6rqYO1CC5SZjOOsS4c9SNRmj4XhDwBIdWiScPhXwo20lnoXKnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9BiO0l+VOjqoMg30VggF4g5UO3GT7rC2xOu7krujmJ0=;
 b=HsZfsGpHe1mfLH9GeLz6bmZO6AMeegKvAPeG8lL7qb85XrGIp1e/U/HfzKKXpXYNrmKVCRtFuEhvoosGtVQTNvhmvrVF8tfiaGMaB9/4ZJjN6aQRZ7QVLKligNTK2Pjag2l4wN8qGhdoaqvWugabdAn/LvCUEZeSik4h72USEIeZGHmDOOowJHsPG0hSN2Z7fZ9mRRVSg/14ktrcof9tb9eb/R+Tw87vvHw8UqBoNTTiHRjMZOLR4l+6aNHCJouZvQQjkNeFnJAW+vOWQI3J//1kjaTUO6IDzA2v41LDOw2MbIgrCMBBzxLOB359Q1ouZv9f3lMZRGvHKRo0GjwNAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6257.namprd11.prod.outlook.com (2603:10b6:930:26::22)
 by CH0PR11MB5218.namprd11.prod.outlook.com (2603:10b6:610:e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 11:06:02 +0000
Received: from CY5PR11MB6257.namprd11.prod.outlook.com
 ([fe80::12c9:6f97:4016:eabb]) by CY5PR11MB6257.namprd11.prod.outlook.com
 ([fe80::12c9:6f97:4016:eabb%7]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 11:06:02 +0000
From:   "Lu, Brent" <brent.lu@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhi, Yong" <yong.zhi@intel.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        "Bhat, Uday M" <uday.m.bhat@intel.com>,
        Terry Cheong <htcheong@chromium.org>,
        "Chiang, Mac" <mac.chiang@intel.com>,
        "R, Dharageswari" <dharageswari.r@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: RE: [PATCH 1/2] ASoC: Intel: maxim-common: get codec number from ACPI
Thread-Topic: [PATCH 1/2] ASoC: Intel: maxim-common: get codec number from
 ACPI
Thread-Index: AQHZuqoaXCiyShA7oEmUALJNRLZwbK/Ip3CAgAAMRwCAABEQ8A==
Date:   Mon, 24 Jul 2023 11:06:02 +0000
Message-ID: <CY5PR11MB62579D3B679BB437017529D79702A@CY5PR11MB6257.namprd11.prod.outlook.com>
References: <20230720092628.758834-1-brent.lu@intel.com>
 <20230720092628.758834-2-brent.lu@intel.com>
 <dc6de509-6984-1434-b53f-9600e8bc7c49@linux.intel.com>
 <ZL5Jzod5NBETv9Dp@smile.fi.intel.com>
In-Reply-To: <ZL5Jzod5NBETv9Dp@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6257:EE_|CH0PR11MB5218:EE_
x-ms-office365-filtering-correlation-id: 85e80954-0870-4cc8-1322-08db8c35f7d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XY7mr4Y2dXj0Utifi+2SOKm10Db1Mmg+qX5NK1/DUoQXTSxecMuT8UPdlyb0ndSItPUymTQftLdUJLA6Z40QM0mUy5QJUEy+fNg4LKalsiNXvQveSa6G46MwLZpxuuo9vxw4fIKPvdmr1ikuCoObUgCx9+QLX5Uv8jsra8S90B17DsuLbYqwdnqfjRdc3FsmP65WVi1bYyNB37LcchHZR8HqoRPcufGBFZdisOXiXr33M5ZZq89zKIwuM6eaNE0heAj9l6Y++lm9DWaCxkXuH+3Oeg2xttUEhll+pHRmrcNrGOGgH4hE/EdjjEBL6UYkPZfm+cHLoHE9fX0maBwa8RCO7Shn7Fb7+lJVzgDZTQTflDxcocWqxlME3F0vPHWZKRMANawCodNAu0rqgtCbmih05Smn0BIPoSkkmrDAakEUC+CwYert0QJ8NKunDiIrApvLr+PbpDOILN98XzosSmveKvATnRmjbHtL2PaL+oGmPMBhGxbWVFJEjmxT4xaaotD6hqMAofSOEfKiGfSf52oWacx5uoxzNUm5+V0iytyPeNlopumBW+p7gqcMBUP0/+NHFZBnQivpWg2huELcw6+f8P79NB20aZwsKIIrvtQLJ11P37prfyvqGq5l6Mxr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6257.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199021)(7696005)(71200400001)(55016003)(122000001)(82960400001)(478600001)(54906003)(110136005)(7416002)(8936002)(8676002)(52536014)(2906002)(5660300002)(33656002)(86362001)(38070700005)(38100700002)(4326008)(76116006)(66446008)(64756008)(66946007)(66556008)(66476007)(41300700001)(316002)(6506007)(26005)(9686003)(186003)(966005)(11716005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yoQXSjFXpIOs0Vk+/igd7KoDCp4tCQr+w2voDRHImDNI8jDCbatAZ8ZyFIsN?=
 =?us-ascii?Q?B3zi7TpqhElo8S8IXD6EMLuRA2nl0uINwjmeooA6ittH4j9euM3NtMYb2VrL?=
 =?us-ascii?Q?8ENHdxFGV3nBBFaTxJK/4dSE0rKvtSibN1Sz+1Q3n261xAmXUDAeEtrDPaUs?=
 =?us-ascii?Q?ygYC/1uzN1Tbq1luDeUd2pXaDzBKyLeHDzVtwed64NIQc1ocZMK8B7FjClPM?=
 =?us-ascii?Q?ksQPY96CjlgblmuoC3IP2XOcEZIRHIan7kvDPmquIoqVGKNJEkbTnN9MW5i1?=
 =?us-ascii?Q?QGjrWPDln0FVdkz2ajZf62jP2tjCzSYwkfSYBy00UtczM5VE6AISX0T/M6eq?=
 =?us-ascii?Q?Yr4faHi+NDEuMDGpBO16xcVOC5YLmXnOeoDefCrAZNYRticK4/zGzS5aHaCu?=
 =?us-ascii?Q?ov1jC4veQoUQhTkb6k5T+BLIw/e1eFfBDipD4MBvGS7lCNlSlWWziiur6u1+?=
 =?us-ascii?Q?pjXcqRXpgfEyGKr7paEfr2HX/9UtJEhyO2cizLQJ/kV/3Sa2kooukyWrfLH7?=
 =?us-ascii?Q?CI7qK5fWJ7GUj5yBR+QfvxN3PjNLvxRC3r3brcnsVKmAvZVpPBV8IEP7VXqN?=
 =?us-ascii?Q?MTSblc2uUVQ5TrrjT2W5aeMqAoquO64W6g9ODF2rrNcUGrZw+d+zphuyypTc?=
 =?us-ascii?Q?AnN4+unD5l0tTpVB6UntPhj8IFc4YaVlTRXvmhojSrR1PSM3r7o2FULYbVhm?=
 =?us-ascii?Q?7vofybl2ZvO9oDfoWD7O+xe/BTD3+CBmbOnikCs3ZFKXSslQLQxzYiP5ZzBz?=
 =?us-ascii?Q?gFvG1DH/gr0wwTDLKE6GDAbDQGwx8qk+JO/RjXLCk4Z0kHTS0g2ndkDuDmmN?=
 =?us-ascii?Q?2uvh+U6rEmmAkyIGRbXPAv5/ZUT3AFE/Akbp3LeVMTXDvgpI6gNuTcbuaDTj?=
 =?us-ascii?Q?8tMLLycvXWLz+cNoLGfdnkLaShvJNwUBTuAYdSNiqNaOWUMrlk3P37j3Tn5e?=
 =?us-ascii?Q?k9Ik8B17DYu/a2XXu9xP/yu1MJd3jE1+ljxHuEzDjEFCbASb8k4LgYsmLAix?=
 =?us-ascii?Q?NETqo4QOMwYtrWXyZD6tIXaUIZmns13UpekpS9t9fLY6U1/+i/fQJ3EVTtPs?=
 =?us-ascii?Q?6IK2jA/L9plillvpgdDbNgoDqAYtfj9YXabIVWVRjw5FHqS3lB5MMzDKz/kT?=
 =?us-ascii?Q?WDOqJMxlApmG7oy/Sq6SftYKLmH8laySI4jJ2ch+QGd57uImlq1ImcBAjHus?=
 =?us-ascii?Q?rEBQIpAoZJCCaVGmcIBUGg5vomAoypx1YtjkD5tkbyYsMbcvVxIOebWB3uAM?=
 =?us-ascii?Q?ibkYQeUrTMHXwLRZTCd6U72upyql/2LT+FpTtc4EdRpt9jj2X4bEcFRrxy96?=
 =?us-ascii?Q?+QHMD5xYbcczIlTyAKxrMtx4yP6USnn2Fg8hYjVMIhfxWcqbXojKNSbsQfkP?=
 =?us-ascii?Q?BahQKYmXSYpm6nNxviMDIvce2owA2cr7Uac3zn4HatyEG0cBZgHw9X4vKw7u?=
 =?us-ascii?Q?0Bn3PfvzuIA40djvK/eXnuj+MYDEbsMEc0RGiYi9sZot+DLe8LkACpO9hvMw?=
 =?us-ascii?Q?7W4HK2Vriwys3ZecfTksc4WjUUUBFTLj4YpTrRUpCFZthbIhUjEx7XOnQOlC?=
 =?us-ascii?Q?UIti6ynPQcb5FiGwpCg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6257.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e80954-0870-4cc8-1322-08db8c35f7d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 11:06:02.1903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JoCIJTTLjMeW3CoNIIkg219rKXCOy1UcvYg0ndGzaWy64uK/MUgMmbrpmwI2Z7IWGSoBifc0+fBul0dsKMd7og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5218
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > > +/* helper function to get the number of specific codec */
>=20
> ...and leak a lot of reference counts...
>=20
> > > +static int get_num_codecs(const char *hid) {
> > > +	struct acpi_device *adev =3D NULL;
> > > +	int dev_num =3D 0;
> > > +
> > > +	do {
> > > +		adev =3D acpi_dev_get_next_match_dev(adev, hid, NULL, -1);
> >
> > Humm, I am a bit worried about reference counts.
> >
> > See
> > https://elixir.bootlin.com/linux/latest/source/drivers/acpi/utils.c#L9
> > 16, it's not clear to me where the get() is done.
> >
> > Adding Andy to make sure this is done right.
>=20
> Thank you for Cc'ing.
>=20
> Yes, the above code is problematic. One has to use the respective for_eac=
h macro
> (defined nearby the used API).
>=20
> > > +		if (adev)
> > > +			dev_num++;
> > > +	} while (adev !=3D NULL);
> > > +
> > > +	return dev_num;
> > > +}
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20
Hi Andy,

Each invocation of acpi_dev_get_next_match_dev() calls acpi_dev_put() to re=
lease the
adev from previous call. And the last call returns NULL. It seems to me the=
 reference count
should be fine. Is my understanding correct?

I saw the macro for_each_acpi_dev_match and re-write the function as follow=
. Thanks for
suggesting using the macro.

/* helper function to get the number of specific codec */
static int get_num_codecs(const char *hid) {
	struct acpi_device *adev;
	int dev_num =3D 0;

	for_each_acpi_dev_match(adev, hid, NULL, -1)
		dev_num++;

	return dev_num;
}

Will test it in next few days.

Regards,
Brent


