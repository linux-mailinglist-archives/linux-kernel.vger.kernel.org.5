Return-Path: <linux-kernel+bounces-26299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE6B82DE3C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03BC328303D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2C017C8D;
	Mon, 15 Jan 2024 17:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PW44al+O"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC5417C6E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 17:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705338729; x=1736874729;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=xGXnKYlI3DgCW9p0Sisslodda0oX+3NotOC7TkoaiwM=;
  b=PW44al+OIlMl4l4PFh65Zj+ai9/gEeXMJam/Nn9UlgglBYTm4x3K2PNy
   lwjpBePv/3keD9ZRCClP04CCxj+WBV2g5dwONcqzQvnyvAIhzecJTVJIo
   g4I4zvVeh+C/CtJTfmPbgcz5q02jNNL4fk6PnERyiKiSCU6TvtI5hCumj
   adrzL1EXi+tamNczBvI3QZ93sFw7/qBLoocYtv2o6dm4GZWrOk0HEJHLf
   8b44Hip7V/cHDipjIDXJ5IGmiRBFg/9KUJCChqVA5DarD6Y4FJVTPCIyv
   7U/oWgA1bKm1BrOHcepkgvZG+rmgY8DoFhIJx8dAHSnycuCx5xqc6F5BN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="13014889"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="13014889"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 09:12:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="787148441"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="787148441"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jan 2024 09:12:06 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Jan 2024 09:12:04 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Jan 2024 09:12:03 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Jan 2024 09:12:03 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Jan 2024 09:12:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBLBb0u3XrQX3Se4KwZbYXIV/cKIRUTrMv7TyLFdzG4YXEWVERPGkKHAWFBYJw9DutMpi76p7RfCBt3G9PpOdJq3G+6OYUhES4ZyuL+J0Ag+WH26t+2LNNhpK+yGOGSviHWyz2+T9m/9/56cDqAlzrQuVZ6j6GMu5ao9WbZOZJ33jF2g3DEwH761hRSlxgbyLvB4RBHvsGQivbqRhQwvcGW8Obv01RyHFHlhk3s7U0fZrTP1tG1cO2KzZvHZAYJUDIUEPGY5xTDURXIZsEeTlWhGIj6sm9bA/BoPSRWmv90ckhSoc70k4lJieAi19mTVYCnt1dGngwIyest12GmzQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37B95n5ElusS98gg+lT9xxjeOhJ8t/HubRSITPhEffA=;
 b=S54narPAOi7+51Z5RSrYPlVYrxLIN7uKhBo2qk8Z37bYPP7DVONeHI0kuBRtW9ltV8TZeSK99Ao6gFnQse+ZDMIFHt+D21I2qnLJqcnenqKjZbnmaEDcUd7AewnGc39SzttemYre49J70WqEwD/0ZZZc/mDHNzMNtf8CUmwxEIHBuyXzPIsnkza1efFfSYI6oTjWF0d374c41klP+dtTI8G/g1NFxuVlEq5jSH+9gaqjraST1/K0hzQEf4zA+yNMflnZbCrB2Cs5qS3qZVa1j2aj3zUzMScTmlyepWMJ4S4USedx5o3r9bqE4Wyj3U0CTXAZb+p6+DwBMYgy0ZCcpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) by
 SA2PR11MB5178.namprd11.prod.outlook.com (2603:10b6:806:fa::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.19; Mon, 15 Jan 2024 17:12:01 +0000
Received: from DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::f105:47dd:6794:6821]) by DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::f105:47dd:6794:6821%4]) with mapi id 15.20.7181.020; Mon, 15 Jan 2024
 17:12:01 +0000
Date: Mon, 15 Jan 2024 18:11:57 +0100
From: =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
To: Maxime Ripard <mripard@kernel.org>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Michal
 Wajdeczko <michal.wajdeczko@intel.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, "Javier
 Martinez Canillas" <javierm@redhat.com>, =?utf-8?B?TWHDrXJh?= Canal
	<mcanal@igalia.com>
Subject: Re: Re: [PATCH v4 6/6] drm/tests: managed: Add a simple test for
 drmm_managed_release
Message-ID: <fcwozeyyg5didfpiy42kn5vscrktt6exi55hio2lba5s6btitm@n7slxall6y63>
References: <20240105101324.26811-1-michal.winiarski@intel.com>
 <20240105101324.26811-7-michal.winiarski@intel.com>
 <2mgrb5lrm5oskkcauhdbegdb5jwhqx6unzlaltz6e2bzaqrzyr@dnkbsr3ykj7k>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2mgrb5lrm5oskkcauhdbegdb5jwhqx6unzlaltz6e2bzaqrzyr@dnkbsr3ykj7k>
X-ClientProxiedBy: FR0P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::19) To DM4PR11MB5373.namprd11.prod.outlook.com
 (2603:10b6:5:394::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5373:EE_|SA2PR11MB5178:EE_
X-MS-Office365-Filtering-Correlation-Id: aeee82f4-7f7e-44cb-cbee-08dc15ed16c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F3U0996Mx40Cl1viYQLWyM5Idf0JlM0/gFpC/7N6wL227eU1WZSn5DhG3F/Uk8O7qahFvtD6ALOn+o96aS9fuZ6dXL5gH0PBQSpoo2Brk9n5922o82JHLcDe6x7FAxPvMQQcw6cov5GYiss6yFHMHIdK/ojkN+rs+HuOriJDCaOairGQkuhAy6fOSN96f9ZTg80Y+bnq03kboUrntd+tdrW5KtqZr//ZYZcK2MeBh1EoiMaIcEG6d3BNOu1DTLfcroHThJTSLjZ4FXkzZ2STsP3jKMmUx52wL6xjvJ+dfL5fvuY9erRzeMlIXI4lZQDP+uVUIGN4vtCOmJ8ki+EDN2Z558XtHMsGHFPGutiY9Z4CNSuZGtzmJgPjqeK7ZFB0f8nHfXPj3O0UxoNfnEaOp1E/rF5CiKsqLrf2XmLzXZlQAFaqcX9sr2InrPs1mH9cp+2+7cwShZD/WJ788LL7GKPlNdytbD0oY9PrJXoh8Gwv8tAmsE3rgPg1mtHIMmW+IjjxJhABW5XeSv1PqnuWwkh9aO7Vd4iIDjf2AkQB8T0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(396003)(366004)(376002)(346002)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(6486002)(6506007)(6512007)(6666004)(26005)(9686003)(83380400001)(33716001)(82960400001)(38100700002)(86362001)(41300700001)(478600001)(8676002)(4326008)(8936002)(5660300002)(66946007)(66476007)(66556008)(6916009)(2906002)(316002)(54906003)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWhMVW1vYWljT2s3cFZsTGx1bHdIOGs4QmhPZmhaQmR2VlorS2dLNUhJTzJ2?=
 =?utf-8?B?OW00V3lCZy9iSGpBMEY2YjNCRko2dnovR1h4Wm1HZDRMdXlrUFhUbnErMUd5?=
 =?utf-8?B?dXBHMHN4TGJUaEoyVktTYjdmRm1hcjIyWUtVYkNYNmlWaFRsWDNaMXlnVlpi?=
 =?utf-8?B?dDZ2Zy9FYVlCR2lXb2lHMkxvaVdic0pmVGRWdHRROExmakdFK1dXd1Nta2NW?=
 =?utf-8?B?a09HQTVKYkxUMzkvWWY5UVdmbEc2MHlhUVFkcmF2M0ZYWFZGVHkzb3J0VU1Z?=
 =?utf-8?B?Q2l1QmNObXlzTjc0RkVZcmY1eW5lSWhnL0hjalhuOWNVODFjNDZyTlBGVHVa?=
 =?utf-8?B?OHplZmJwUHRuejhUNkpJbXBBS2lsMW1MZktYTzBYbkg2aGtRWElwSzBTU1VO?=
 =?utf-8?B?b0Z5Q0k3ZEV6SWFNOXI3ZzRTam1RUU8wTjNaUVBHOWc2QWJsTzRsVUVYdVFX?=
 =?utf-8?B?ek5YOUVieVZ1Y29QQjhXaXczcE9mTmRIajNvZ2RCVDZxdmtUTVZuaEUzaWxz?=
 =?utf-8?B?ZklIdmlKaUFUTDJtbkVMRU4rdjhRbitEcHo0VTdXckpJTXBDV1JlVDhLN0dy?=
 =?utf-8?B?bGsybjN0alpCdmhuMWNVUENFZTIvVlJYbVhiL2VvVzFHTzVmTkxnUWtUeURT?=
 =?utf-8?B?Wk84eE5Sa1VzWFk1UXVlWjRTM2pvYXRnamhQSzdzaC9ZY3Z6TUV2YWdQeVpC?=
 =?utf-8?B?NmZYVGEzeVZkOTJ3eDJuNzg0VTZ3MHF3MnlZVXJaZE5JbjF5V2hhQmN2R0l2?=
 =?utf-8?B?YjZ0SlIrR1RkWWRwenR3NEVKbjd6b2JCVmpPVjc5SURtaGpReDlkTWMvNGlM?=
 =?utf-8?B?S3Vqc2MrUytJQ0FNajBzUW9HTHYrOE9YRzE1VSswelJDaXVhT1BzT1NYc3Na?=
 =?utf-8?B?aUZseXhGSDJxR3BkcUpjdnBnYmVvZER0NnJaMFZSY3h3TjF5Nkd1NWF4by85?=
 =?utf-8?B?ZzdUSGlENzlWcXBqWWUwbXJFYUV1VGhaNmxMdzB5bHd4RG9zL3QycjlQRGpC?=
 =?utf-8?B?OTJBUHRTaXN6VmprVzRhRnErN2UzNXdVNDFQM2h3RlFIQ2VSeHVIbjJad1BM?=
 =?utf-8?B?WGlhc1hLbHRxS1J2QitJQVZpcERuNnowdUJqbDZNYmVCU1hteWZNdEZnK1JS?=
 =?utf-8?B?MTJGbUloSHZzLzVGUU16T0VVUUJnalNXYW5Bc2dBMFpZMWpzdlpBR1QzcnMr?=
 =?utf-8?B?bW0wNzZIem5ZdjRqRVNPaHlEeTMyeDdzSDQwaFdpaW9jcmhHL1lwbVdsandw?=
 =?utf-8?B?L0JUYlprTm1PejFkS3V1UGxPU2NzTExnZk5SWUw2OUorckVuRW5sSnpNd2Rl?=
 =?utf-8?B?dnJqZTlmM0dFQTNzWVlxUFhzSDNKdE1IVnZJVlBoTEtpUS9TRVF5dlJab2lC?=
 =?utf-8?B?SWZqdlRzTXEzZUZINWh3NDlLdkgxdmJkTzFORzhRbzVXenN3L0x0TlFuRllM?=
 =?utf-8?B?aE1EUlBrODBweC9LRHhJUzFFSTE0U3RGRk5iNjgvVzhXc2ljUHd1QS9JYUJ0?=
 =?utf-8?B?eVBSM091MVo1WXZqaGxpZFJMS21VQUoyaWhZVis5OXR6TkpmK3o4bDJtbklF?=
 =?utf-8?B?TjJRL1JCNHBxZTR3V1IzWTFBVExoRVhPMDdVYnhiellqYTRkVk9GQldOdDlY?=
 =?utf-8?B?MlRNMXNWSWdLMXo0U240Ky9xUzZTTUZjMm1QS3k1RWg5bUxNQjZWRnhvMWc0?=
 =?utf-8?B?ZXpxcjBkTWcrV0xZTzg2RmFtMXROcVA3c2lpM1dYenhsUTU5czgxSDB3dUZH?=
 =?utf-8?B?NXNqN2xWUC8xM3IxOGh3b3psQUdIRmhPTG5UWEltK09JSVJpZ21oNW9VMTB5?=
 =?utf-8?B?bEZsbDc1RnpSa1lIRXFaYmdCY2FvdWt0c0YwTTVwbDdRRys1SURFMGRndmRY?=
 =?utf-8?B?Z2x6L25PTnpTbWJzeDkvV1RRVE9YT3dEd283dWl3dW1lc3ZPbXV0MXNDaFlN?=
 =?utf-8?B?WWQrMXZ6c0cwdWxtMUVibTZtaENYRlRTNVlxMW9aVnBLSmNDVmdva0NPdXI3?=
 =?utf-8?B?ZmMrOVRBdTAvdzlQaFlxS1VXV2VBb1kxZisybFcwbmJsSWRxYWUzL2Z0SkIz?=
 =?utf-8?B?MzdnL2gvRjNPMDFDcXU2bVo5Z1hZOWV2dW53aGpUQ25yT01EWmNZR3JaMTNT?=
 =?utf-8?B?UXM0aEd0VmN3K0VHU2tYbkdNbklrZFdHbjFTdSttL0Y3eXM0R2REbXRvLzE0?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aeee82f4-7f7e-44cb-cbee-08dc15ed16c0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 17:12:01.5128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lQ30jyfiyG4mLQP5jpV1bvCt7pEyrwauor9xMaYNRUSgWTbIZW30nLzMT5zEsDA0Lqo7dYoLNjBBqbKmXvQfYH0V1rWGK7f0mbgJookxU30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5178
X-OriginatorOrg: intel.com

On Wed, Jan 10, 2024 at 04:56:27PM +0100, Maxime Ripard wrote:
> On Fri, Jan 05, 2024 at 11:13:24AM +0100, Michał Winiarski wrote:
> > Add a simple test that checks whether the action is indeed called right
> > away and that it is not called on the final drm_dev_put().
> > 
> > Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
> > ---
> >  drivers/gpu/drm/tests/drm_managed_test.c | 28 ++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/tests/drm_managed_test.c b/drivers/gpu/drm/tests/drm_managed_test.c
> > index c1fc1f0aac9b2..91863642efc13 100644
> > --- a/drivers/gpu/drm/tests/drm_managed_test.c
> > +++ b/drivers/gpu/drm/tests/drm_managed_test.c
> > @@ -41,6 +41,33 @@ static void drm_test_managed_run_action(struct kunit *test)
> >  	KUNIT_EXPECT_TRUE_MSG(test, priv->action_done, "Release action was not called");
> >  }
> >  
> > +/*
> > + * The test verifies that the release action is called immediately when
> > + * drmm_release_action is called and that it is not called for a second time
> > + * when the device is released.
> > + */
> > +static void drm_test_managed_release_action(struct kunit *test)
> > +{
> > +	struct managed_test_priv *priv = test->priv;
> > +	int ret;
> > +
> > +	ret = drmm_add_action_or_reset(priv->drm, drm_action, priv);
> > +	KUNIT_EXPECT_EQ(test, ret, 0);
> > +
> > +	ret = drm_dev_register(priv->drm, 0);
> > +	KUNIT_ASSERT_EQ(test, ret, 0);
> > +
> > +	drmm_release_action(priv->drm, drm_action, priv);
> > +	KUNIT_EXPECT_TRUE_MSG(test, priv->action_done, "Release action was not called");
> > +	priv->action_done = false;
> > +
> > +	drm_dev_unregister(priv->drm);
> > +	drm_kunit_helper_free_device(test, priv->drm->dev);
> > +
> > +	KUNIT_EXPECT_FALSE_MSG(test, priv->action_done,
> > +			       "Unexpected release action call during cleanup");
> > +}
> > +
> 
> I guess we can have something simpler if we switch action_done to a
> counter and just check that the counter didn't increase.
> 
> And I think the custom messages should be removed there too.
> 
> Maxime

I'll drop the custom messages here and in the previous patch.

I'll also simplify this test in the way you suggested in previous
revision, to not check for release action call on cleanup.

Thanks,
-Michał

