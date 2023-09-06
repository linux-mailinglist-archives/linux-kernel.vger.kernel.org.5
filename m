Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173EE7933B6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 04:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241151AbjIFCUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 22:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjIFCUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 22:20:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314D0ED;
        Tue,  5 Sep 2023 19:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693966840; x=1725502840;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FITRqiKOAmMhwwCnDzy8NoklZXleLWA57Gu6sJXJ6gI=;
  b=dAcH2PdHr947ybGXBwS0QjYKelkFf4blPooRHkDlEUtwzKT75heIGTVU
   QA3H2UlN4foN0NxTFWC2WvJu3rhzQqfEkL3FAcJih3iDWw/kS2BSXSi8/
   q+KrjEGBEXB2Ppx6+Fxy512/Jsapz7PJ6PZYz9np71RwYC6HWLuVhwOMO
   UTfZ0BcstFoonm88C17BOtTkozv5joGc9Y+cKzoFV51FwkCikc7YB08ue
   Kq80LjMEwO/BdrC3ryCcNoZceMcso253m4fFS35jRySHYnbWju5b5qbEA
   RSV3VshRWDt2d4c3AzWqHNAs0z1rmZHtSCWlr8BRneSYnmOTBeCGfjmF9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="380756383"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="380756383"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 19:20:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="988045313"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="988045313"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 19:20:37 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 19:20:37 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 19:20:37 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 19:20:37 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 19:20:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmcvSZ0Qi3sU0YrkKDnq9DLyNYFdXwIIaTh5wCGG+PJVRD0PANFyl44TL0GcZbVxQZRqZovnStsoTE5nzMDTuxQxuL3rR5Jvfja3JbQ/rRh/CtcFCxLZakvKXbNam1bDGPOsgPUXOlNg2IemiIqZpA/AmkIez2gNDonCBTQugSk/lmz0p9qeirWkeXZk+ybTAx41UHSs+B38YJYTjw53cIEhrECPmTWrDmkXQq+9jnh2DGbj88NZhYXJ2mjZaJSdh/jb+W4516IiWrQDHOjtaVHAo/rNnHLiENA0vLOc5NqnEr4qGUtRhZFGq3SwgvStvQv8dS4qQxGdCvqWh4k5mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FITRqiKOAmMhwwCnDzy8NoklZXleLWA57Gu6sJXJ6gI=;
 b=obkW9Mmon8LfhEI5xTadv4kfSF2xs3DclQe81slmTUi7757QQWaDr1sR/odUUGK9dK/mDXjEcs1I6gFpGPY5xzTt7yTq/5yBcJ6PoeBFFCwE0fMg5LxzbT5YzmM6vk+2su7dI6KYdSyk66hSKL/GEBIj1tDhfFB7GWgJxHb7DcYcaYgFN3fHvn9H5W2cZm7zhopgt62lLwUQiEZu+7gIb/2WJFH4NQ/h0wWQjAu+PBG/RK6K/tTQmfWQlrFfFrSG6DqeEV51GttpcEawX+qxno5DqlVQEic8qRctFrPWp90VmRRuGdOH253mslDpctzBEtTfXu2zi0DvhqAshn4s/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by CH3PR11MB8519.namprd11.prod.outlook.com (2603:10b6:610:1ba::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 02:20:34 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::b077:468b:fc83:6489]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::b077:468b:fc83:6489%5]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 02:20:34 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Pawnikar, Sumeet R" <sumeet.r.pawnikar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] powercap: intel_rapl: Fix setting of Power Limit 4 to 0
Thread-Topic: [PATCH] powercap: intel_rapl: Fix setting of Power Limit 4 to 0
Thread-Index: AQHZ4FYImPFBZ2J8zEWDkWCKQ+r6jrANEMAA
Date:   Wed, 6 Sep 2023 02:20:34 +0000
Message-ID: <8fc7d9236bfa968b5f202d458e99e2e729fed343.camel@intel.com>
References: <20230906000640.2919607-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20230906000640.2919607-1-srinivas.pandruvada@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|CH3PR11MB8519:EE_
x-ms-office365-filtering-correlation-id: a2c1bf9e-e291-4815-68fa-08dbae7fd9cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f53GxRYqHKA6eGspkEAp+ujzdXmQEVYy7z5k2YMawk8W3bJhb9aszvPbO1827tP1o0XiVpcdJeYjSzZ+mZj6d8K9PT6cuZbE1x7unM/arbaeSEa6ey6ESuF7P8JNx52GiEhVW7ruui1teXAGqZ9nJS3mn5C1Fouos6xX2kJ/VfCL9LuAujtL39/AIJ37NaHJUo+z+rccfgS63cMPIrykQhJ84s2Q6WmwkRdh7G10reqwfIwEqe2tma3jvOrwvXWFKzJm/HhNuYE10LFu3Ux2o8gT7nIr49HkgdgOXb7/Sv6O6cgpDzRowR5ntz/gamPhjoMyDj/pXRUGlcqHRKWaAKTLmr6DeBmsQ0CIXTeEpGnKvMlP00nzyALTYXT6pn8k5I0oaqPvrEfXNdSrEV8Fa5Ux4kvATrJH7h9J4zQZm2Mbk3c/JK873rLhmy4NtzRFHug06kSCRAFUCFHd2lHBYHqlg0lGNVHVjk4PkokF4CS7HaV+yTtB2iYdvTImcifCYMHcnS9og+8ISH+9HZhxVo+ZJUky/EQ2CqYwAiVCHwF3f6m0paaLf+hwXqKsVb1nlssUxPfUBdNno3eJJ64QUiK/xnQ12MHO/hV8biAzMTaGPgHd4EJZ+voOgw/KhRub
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(136003)(366004)(376002)(1800799009)(186009)(451199024)(8936002)(8676002)(4326008)(2616005)(41300700001)(26005)(5660300002)(91956017)(83380400001)(2906002)(71200400001)(478600001)(316002)(110136005)(6512007)(6486002)(6506007)(64756008)(76116006)(66946007)(66556008)(66446008)(66476007)(54906003)(36756003)(86362001)(82960400001)(38070700005)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejNwTHlaM053cXhxWkcrbVVlMzJ2aWd0UVhoQUdFQWZyRWFKNUNqY21uRnNZ?=
 =?utf-8?B?dTBKTkdNcGd5aGczQWhLVFZjR0lFWFZnRGdkMnkyNmgybUUxa00xRGVGaGRC?=
 =?utf-8?B?WmFtZ0F0NmVRQ3VaK3pQdWQvNk82bGVsaW5pVEdKUGdMR2o0aWpLaGxRY1Nl?=
 =?utf-8?B?UVh5ZllpbW5SQmloR3ZNQ01PTUdJS1FSV2w5NlZXS1RQYUdrczVoRlU4d1ZR?=
 =?utf-8?B?RzhPTjZqLzlONzkxT0o5UElIY2xWVHVtODh0cThpakZLM0Y3SG9EWUt4bEtY?=
 =?utf-8?B?VEVoQzVLT3d3aTk4aWhOR2k1MHU2cDdOejdweGZZcEpSdmJmSUV1MWsyR01Z?=
 =?utf-8?B?dGZ4S21qKzVLWkgyQmlOOUdhUHg3aDdVNUw0bTU2YjNmTVg0aHBkL3U2eGhB?=
 =?utf-8?B?Mk5ub3haTEd3cnZ1ejhLVC9qK2hmb1ZDRmhNOGpZYVovdG1HVUpUcHpkQ0Uz?=
 =?utf-8?B?endaYUhVWDM5R1BXcGdjOXZMNFJiempyMk95OWJaWmF5RHo3VTY3RWRDL1dm?=
 =?utf-8?B?SXJSdUUrVmI3L3V6RmNXSmdmd3Z0L01OdlFLZm12Y2o3eVZmVTI1Ri81ZUMw?=
 =?utf-8?B?cFM1eHZaRjVLak51WVJLMzBidDhlT1pEN0ZzWWZaaWZrZEN3MDRRUVptb0gx?=
 =?utf-8?B?Nis2SS9RbXNBQVduZHpTRkg2NDJFc0hLZTYrUHBXYVJXRThYM2Y4Q3QvVlNw?=
 =?utf-8?B?QTJ1N1Qxbzc2eXFsZUZnRzJ1WkQxZmpXaGhlQTh4SUpuSTVDdFdKV3NZT2tL?=
 =?utf-8?B?OUd6ZldaaXlsaVJKUDJSNWllSkVOVkExaUMwUUdSQkhndDUwRG5ndnJlQlJ5?=
 =?utf-8?B?OUNoS3JxeEI5UWU3RmFqb3VvdjZ2YmRTcFF0Z2VBV2M5TXRYQ2VXVncwSEww?=
 =?utf-8?B?ZVlvYm5HdndPdFIyLzFQQldTeWJYV2FQT2VjMVY1ZVlNSmtPUjFkNExoL1pG?=
 =?utf-8?B?bDZ6M3hvMlRNMitKNHdBaTQ4UDFFNGh4dS8ydi9zNE55VEl0ZlhqL0FUT1dh?=
 =?utf-8?B?L3JnaDNHc3FEblZrNlY1eVZQbXFNOER2VHRrcGl5MlN5dHRvNGpLM091Ykpi?=
 =?utf-8?B?VndqMzhHdXJwSDRySno2VmNOd2Jab0hWc1VPSis5N1lXcUNHQkFrTG9KaC93?=
 =?utf-8?B?R3VoQ3lvamRBWWNUZ3RSbW4vN1JWcCsyYVB6TDNLRTJyMExkam8rQ2YyZ211?=
 =?utf-8?B?VEdvV3dQaFFsY3I5VFA4TjRWSUgwNXRwTWlsT1ZJMERHbThNZlhvSUpzR2NM?=
 =?utf-8?B?dDNhMUhlcDlPK1RaRGhsdjdleEVoSUlYVnUxdXlWTEFveUxPb0FBdmFuUjVS?=
 =?utf-8?B?d3JOWnNEZktiNGFYU0lnYi9sU2d2UXQ4cUxDUlZ2R0NXZmloR2JVRG5uNWht?=
 =?utf-8?B?TXZJcUsxVXJ2L21kd0thaVptMWN3T1RUdGE3TEt5WnJNL2F0VmFOeWFvZGZk?=
 =?utf-8?B?dkl0cTd2b090dU9ETnBFOVFGR3VwcG9ydHoyd2ZEbUl3VFI4YTBvS09aRVNY?=
 =?utf-8?B?ZXMvTjk5Tm5yUmNMN1o5WVJUNHhUS0JlSjNmMU1DdVJhS0ZnS2xSTjloUnpt?=
 =?utf-8?B?Wlc2OGd6WEd5RndLUkc1MG9SYkpOUTZxdGRoMmxBZEYzYjAzQnZVbmovWnd5?=
 =?utf-8?B?WG9xRCtTaUhwQkVidUgvOEovSDMyYzNtYk9hOENZcXdFdlNSMXVWVFNkSFNh?=
 =?utf-8?B?c0tCSmxSNndpeWdySjBZZHlTZlpuY3VhbkpOUlRDdDhCODZzNVZ2UHBWb3J6?=
 =?utf-8?B?QTZ6TlhrZGNQUVVZSmZHTFFURFRjL3BxSGxmOFZiRWJpRklhTGtTSVBOQ21X?=
 =?utf-8?B?cW5zQUYrUHJQTytFSnlDTStZa2crRlEvN3RJTlhWa3dESEJ6QVV3Q3JGclAv?=
 =?utf-8?B?dkwydjZXWk9pa1VieVg2YkJtYmZHUHdNMUVSUStEd21JLzF2RnE4UEhUaVRC?=
 =?utf-8?B?RjZrekp6R1ptNkEyaThxM09uLzRReVRJUkVCZXFSM0NRUDQ0cWFNb0hTNjRN?=
 =?utf-8?B?bnU4TDFqTk40VEt3bGVoNUhEYkRLeXpVNXJhSzZWTGVkU282dE1kSVhiYXFv?=
 =?utf-8?B?TTNqa0pLaGdSeUJobGVJNDgwT3RYKzFHS2lZWVFYbFlyamx2QWtIZFFJcnpw?=
 =?utf-8?Q?Frwx52nU6m/kt1Uf/wpiSwunM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1871F546763B1443B766A0845BD4365E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c1bf9e-e291-4815-68fa-08dbae7fd9cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 02:20:34.0627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vUj18a+OwiKdgqIkC14KEy3vA6rmXK6xR0lcssQB0wHO+3XpMRDFuDAum3TawLJROW/3o2DblRv7W0VFaxLgeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8519
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNyaW5pdmFzLA0KDQpUaGFua3MgZm9yIHRoZSBwYXRjaC4NCg0KT24gVHVlLCAyMDIzLTA5
LTA1IGF0IDE3OjA2IC0wNzAwLCBTcmluaXZhcyBQYW5kcnV2YWRhIHdyb3RlOg0KPiBTeXN0ZW0g
cnVucyBhdCBtaW5pbXVtIHBlcmZvcm1hbmNlLCBvbmNlIHBvd2VyY2FwIFJBUEwgcGFja2FnZSBk
b21haW4NCj4gImVuYWJsZWQiIGZsYWcgaXMgdG9nZ2xlZC4NCj4gDQo+IFNldHRpbmcgUkFQTCBw
YWNrYWdlIGRvbWFpbiBlbmFibGVkIGZsYWcgdG8gMCwgcmVzdWx0cyBpbiBzZXR0aW5nIG9mDQo+
IHBvd2VyIGxpbWl0IDQgKFBMNCkgTVNSIDB4NjAxIHRvIDAuDQoNClRoaXMgaXMgdGhlIGJ1Zy4g
U2V0dGluZyBlbmFibGVkIGZsYWcgc2hvdWxkIG9ubHkgYWZmZWN0IHRoZSBFbmFibGUgYml0DQpi
dXQgbm90IHRoZSBvdGhlciBiaXRzLg0KDQo+ICBUaGlzIGltcGxpZXMgZGlzYWJsaW5nIFBMNCBs
aW1pdC4NCj4gVGhlIFBMNCBsaW1pdCBjb250cm9scyB0aGUgcGVhayBwb3dlci4gVGhpcyBjYW4g
c2lnbmlmaWNhbnRseSBjaGFuZ2UNCj4gdGhlIHBlcmZvcm1hbmNlLiBFdmVuIHdvcnNlLCB3aGVu
IHRoZSBlbmFibGVkIGZsYWcgaXMgc2V0IHRvIDEgYWdhaW4uDQo+IFRoaXMgd2lsbCBzZXQgUEw0
IE1TUiB2YWx1ZSB0byAweDAxLCB3aGljaCBtZWFucyByZWR1Y2UgcGVhayBwb3dlciB0bw0KPiAw
LjEyNVcuIFRoaXMgd2lsbCBmb3JjZSB0aGUgc3lzdGVtIHRvIHJ1biBhdCB0aGUgbG93ZXN0IHBv
c3NpYmxlDQo+IHBlcmZvcm1hbmNlLg0KPiANCj4gVGhpcyBpcyBjYXVzZWQgYnkgYSBjaGFuZ2Ug
d2hpY2ggYXNzdW1lcyB0aGF0IHRoZXJlIGlzIGFuIGVuYWJsZSBiaXQNCj4gaW4gdGhlIFBMNCBN
U1IgbGlrZSBvdGhlciBwb3dlciBsaW1pdHMuDQoNCk1TUiBSQVBMIGRvZXNuJ3QgaGF2ZSBQTDQg
ZW5hYmxlIGJpdCwgYnV0IFRQTUkgUkFQTCBkb2VzIGhhdmUgcGVyIHBvd2VyDQpsaW1pdCBlbmFi
bGUgYml0Lg0KDQo+IA0KPiBJbiBmdW5jdGlvbnMgc2V0X2Zsb29yX2ZyZXFfZGVmYXVsdCgpIGFu
ZCByYXBsX3JlbW92ZV9wYWNrYWdlKCksIGNhbGwNCj4gcmFwbF93cml0ZV9wbF9kYXRhIHdpdGgg
UExfRU5BQkxFIGFuZCBQTF9DTEFNUCBmb3Igb25seSBwb3dlciBsaW1pdCAxDQo+IGFuZCAyLiBT
aW1pbGFybHkgZG9uJ3QgcmVhZCBQTF9FTkFCTEUgZm9yIFBMNCB0byBjaGVjayB0aGUgcHJlc2Vu
Y2UNCj4gb2YNCj4gcG93ZXIgbGltaXQgNC4NCg0KSU1PLCB0aGUgcm9vdGNhdXNlIGlzIHRoYXQg
d2UgZXhwb3NlIGFuIG5vbi1leGl0cyBQTDRfRU5BQkxFIHByaW1pdGl2ZQ0KZm9yIE1TUiBJbnRl
cmZhY2UsIGFuZCBldmVuIHdvcnNlIHdlIGV4cG9zZSBpdCB3cm9uZ2x5IHRoYXQgdGhlDQpwcmlt
aXRpdmUgdXNlcyB0aGUgcG93ZXIgbGltaXQgYml0cy4NCg0KQ29tbWl0IDkwNTBhOWNkNWU0YyAo
InBvd2VyY2FwOiBpbnRlbF9yYXBsOiBDbGVhbnVwIFBvd2VyIExpbWl0cw0Kc3VwcG9ydCIpIHBv
a2VzIHRoZSBNU1IgaW50ZXJmYWNlIFBMNF9FTkFCTEUgcHJpbWl0aXZlIGFuZCBleHBvc2VzIHRo
aXMNCmJ1Zy4NCg0KU3VtZWV0IGlzIHRlc3RpbmcgdGhlIGJlbG93IGZpeCByaWdodCBub3csIGFu
ZCBJIHN1cHBvc2UgaGUgd2lsbCBnaXZlDQpzb21lIHVwZGF0ZSBzb29uLg0KDQp0aGFua3MsDQpy
dWkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcG93ZXJjYXAvaW50ZWxfcmFwbF9jb21tb24uYyBi
L2RyaXZlcnMvcG93ZXJjYXAvaW50ZWxfcmFwbF9jb21tb24uYw0KaW5kZXggOGZhYzU3YjI4Zjhh
Li5kNDA3ZjkxODg3NmYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3Bvd2VyY2FwL2ludGVsX3JhcGxf
Y29tbW9uLmMNCisrKyBiL2RyaXZlcnMvcG93ZXJjYXAvaW50ZWxfcmFwbF9jb21tb24uYw0KQEAg
LTY1OCw4ICs2NTgsNiBAQCBzdGF0aWMgc3RydWN0IHJhcGxfcHJpbWl0aXZlX2luZm8gcnBpX21z
cltOUl9SQVBMX1BSSU1JVElWRVNdID0gew0KIAkJCSAgICBSQVBMX0RPTUFJTl9SRUdfTElNSVQs
IEFSQklUUkFSWV9VTklULCAwKSwNCiAJW1BMMl9DTEFNUF0gPSBQUklNSVRJVkVfSU5GT19JTklU
KFBMMl9DTEFNUCwgUE9XRVJfTElNSVQyX0NMQU1QLCA0OCwNCiAJCQkgICAgUkFQTF9ET01BSU5f
UkVHX0xJTUlULCBBUkJJVFJBUllfVU5JVCwgMCksDQotCVtQTDRfRU5BQkxFXSA9IFBSSU1JVElW
RV9JTkZPX0lOSVQoUEw0X0VOQUJMRSwgUE9XRVJfTElNSVQ0X01BU0ssIDAsDQotCQkJCVJBUExf
RE9NQUlOX1JFR19QTDQsIEFSQklUUkFSWV9VTklULCAwKSwNCiAJW1RJTUVfV0lORE9XMV0gPSBQ
UklNSVRJVkVfSU5GT19JTklUKFRJTUVfV0lORE9XMSwgVElNRV9XSU5ET1cxX01BU0ssIDE3LA0K
IAkJCSAgICBSQVBMX0RPTUFJTl9SRUdfTElNSVQsIFRJTUVfVU5JVCwgMCksDQogCVtUSU1FX1dJ
TkRPVzJdID0gUFJJTUlUSVZFX0lORk9fSU5JVChUSU1FX1dJTkRPVzIsIFRJTUVfV0lORE9XMl9N
QVNLLCA0OSwNCg0KDQoNCg==
