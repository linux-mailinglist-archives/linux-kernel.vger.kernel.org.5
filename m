Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D1A79406C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240937AbjIFPc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjIFPcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:32:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053931733;
        Wed,  6 Sep 2023 08:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694014337; x=1725550337;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rLzcn82eIOVSXfci4BxyAXGGD7fn3Rep8dMqyHIJ36A=;
  b=COaAxWieKP9n2qEqaVWbXnLwagcZtbUnCL2Df485IOVeY9BMh0kkltZX
   Lu2+1Pw5HYo46eVDv80Rb0h0CpgLzg0yeSoCFXi9J16VgGxpko5g2qls8
   OS677b1bfM8q3/AAYsTBlPOYVIq3CuDcTYFKZzckG50kLCSbh3e2D1ic/
   3dd2PXd/aNej0sNvw1d/uTfwlu2JdQnA0O+2+joxCXuwkl7mlew2kne0D
   ou1/GF+yd7otDOISMWNATUaIxf/jMtV/d1mqmc5hXAlarQx9Bgkb58L3u
   9twEaDT66Ylbjnvpt9tmpN/UWeMMFOE/LKh4Cfyuhye7vsDGk4SInSTNc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="463474694"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="463474694"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 08:32:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="856489050"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="856489050"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Sep 2023 08:32:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 6 Sep 2023 08:32:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 6 Sep 2023 08:32:14 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 6 Sep 2023 08:32:14 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 6 Sep 2023 08:32:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTH/yw/TxuRPIQeovn8i56I6U5Ya1qa6uR5PRXjKsKf6wd+RT79azPCQW6pRzR+8K9Dq+S1sPKqf77xHueQdc05uSenLvnPT7Sb4qua2N2T8qwJBk6/72RLTzHFSd3In/L2fGwsSIC0jPjGojb4P4SmIOTJAAXCumqHYzlNoVYK1Ei36oWkGzjGBcnpCYj5PgYJ3mVW0ujV15Mb14PBJIQkOR5dL9p2pO3wqbyqo1YZ0ERRd2cNWpiTq9fblHgY3dOB7KgbRFJWSFZUbgorSHakR/ZKG3/QC6SoWh0TpcaAkSvQ/07lZYpEPk29ZhGHp37BAZfL/XQpOevfifpR+5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLzcn82eIOVSXfci4BxyAXGGD7fn3Rep8dMqyHIJ36A=;
 b=OWtRhca6p/M/j9xIT6Q0qpF/VcvJq/9bn5/RCmOy8ZW3+1SkMNo5u6fg/O6Mr/6/vXH/kXty/Tt094ZA3TQRC16VRljh5pgv61zaD3ZYSWugihnv2pMKw/xi2CUBd9Uh1I+Zks0fgsk3IWZ5mWoaM++y5FU/tBifT3fYjD8fmrqcL0exY0mZogWHlRoifW+HFGAYw/UNR1GZ2Hy4ORUVgSM2MQTb0RcQ3aeCBI5biwybLn31Vb2EucgfUHIVs2ceAxjF4tpQE5/e0nO3AqcTHtwfMmdgzdb8bGm3X9ZeFlFR/7eg3qguNHGltGtgrZWJFL2jlto3JQPrXLJgw3yr8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 CH3PR11MB7819.namprd11.prod.outlook.com (2603:10b6:610:125::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.27; Wed, 6 Sep
 2023 15:32:12 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::7c37:22cc:1c1d:f285]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::7c37:22cc:1c1d:f285%7]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 15:32:12 +0000
From:   "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 09/15] powercap/intel_rapl: Cleanup Power Limits
 support
Thread-Topic: [PATCH v2 09/15] powercap/intel_rapl: Cleanup Power Limits
 support
Thread-Index: AQHZ38FPg9hjKezf5kW1OEeaAcAlGbANIOAAgADOOIA=
Date:   Wed, 6 Sep 2023 15:32:12 +0000
Message-ID: <2b936d88a51ca62d29a15c4b04265c5ae2e7352f.camel@intel.com>
References: <20230419024419.324436-1-rui.zhang@intel.com>
         <20230419024419.324436-10-rui.zhang@intel.com> <ZPbJBanVmoMuOhMR@intel.com>
         <ae58059aed29f2c9e1e99ad67046881e43942eaf.camel@intel.com>
In-Reply-To: <ae58059aed29f2c9e1e99ad67046881e43942eaf.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|CH3PR11MB7819:EE_
x-ms-office365-filtering-correlation-id: 5b20d6c1-2037-4b61-7613-08dbaeee70dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1lfz2VkZY6X6YtrD4ek6xJ1qi71bcRVhZ0AvaaEx2hTFK64RstgtaHZWPtuRSk1qA2K1hD1a9V6Mh8FuTWTGtGgDvgzf930iRSNPIzbBhX7ZCtgPRTXsMVEVdRMkAt8lAuVlj3mQX98PFMmG0TTPJPZeHkOgflsAozTIZvWKh4xrx+ruYNCtnlIgIb0j90jlpZJlndYP9t0xBCP+vQ5LFw+zDchQy5j5Oh+k6o+by9MZ15sqqOrFJXSbqnzFjrFt+0YEXWM62e2t2r95B0js08kGrwZSqoXShE3sCGoytQ3aWk5G5pronaaVtNlU73WNDBcbhLOCOWL1JyfFjZNY3K6TzdC+CdB3IoFsPpETOmOdMKHPl93UEqxKIo23vMCsLmy8+8A8G25xZ+5fI9zZxZfZSquXJ2367aE1MmQjUDpEREJDJ2kb2vHK+0rnLIlUA5GQmYRJIsVyF2ZvvFSLL8gJ35pnhl+LnIcudv0/2wgkXbenaUlr8A8hTMeJ9Vl2fRdmsALKYZH19VWb47c/foDw0Fw1yzOILphMLh6c2eceADzE5Zax2ZVi3RfXnYHCwyxzzaMKwBC2cIEuPdii1i2HrF90kodQN0+8ilYLaa1TDxXv9UP/mQkZj8UjTJQf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(39860400002)(366004)(1800799009)(186009)(451199024)(83380400001)(316002)(36756003)(41300700001)(26005)(2906002)(2616005)(82960400001)(38070700005)(122000001)(5660300002)(38100700002)(4326008)(8676002)(71200400001)(8936002)(6512007)(478600001)(110136005)(6506007)(86362001)(91956017)(66556008)(6486002)(66446008)(54906003)(66946007)(64756008)(66476007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkJLZk9jeXVFSnQ3TEZ2S3JEb285eUVzTEZGd0xaSkdtSGN6YStuNHdwb2d6?=
 =?utf-8?B?TnljSzJ4c1FhUzNhY2lCMzIzOFcraWMrRDlUcnpZc3R1SUdHVFU2YTdwbGhm?=
 =?utf-8?B?UXp1MUo2dmRlR1hIRzlpQ0tMTjQ5Ty9GVms2NXhpZmMzY2Y3RVNEcXl3L2FL?=
 =?utf-8?B?UlA4Y05jNTZBRll3MEU2YWdjVTYrb0FXZ3RHcjlkeFBNTk4yZTNDR0lmRy9r?=
 =?utf-8?B?Z1RkU3hIT29NQUtoWi90eW5aVExndTdPdnVLaCtHNEN2TlFMdy9CNGV2YlBq?=
 =?utf-8?B?T21XRTRBSTRyRkZ0d3VDWDMwWGlGdzZEYkpTTmYwbWVvbWxlS29pWWt1eWts?=
 =?utf-8?B?bm5TQk1oOXhTOE02amRRV2kxdnMrZWxJYXFWMTFhQTJuTWQyZVFRYUpCQU1n?=
 =?utf-8?B?VkUzRTNoS1VRQmRLQXVCZzhraXEySjAxc1JkVFFtc05tbjIrdVpjTlVKMmY4?=
 =?utf-8?B?cDQzTG1tbjlIOFU5aHdJR3l1aHZ2UG9xYzRTTEtnTlZOVENhb1luZXJxZmpw?=
 =?utf-8?B?WXRBY1hVWGZzZ0VkaGR2UDNoNFVPTk5uMVVPNjdPNzkvL08yN3BETXpEUXYy?=
 =?utf-8?B?OTdMdTZXUjVVS2FpbHRlZ1U2a05CZk5rOG1SNE9ycVRGUGRsbHhIbElXTGFC?=
 =?utf-8?B?Y3JtV3lTWnRBT05kZ2pRZzIyTWRtdDNmM28wSXB3NlpzRnhYTEF4U3dRQVVT?=
 =?utf-8?B?cGowLzQxTldFS0IySlJvQ0NKM3dsM25YVnR4UFkwN2JxVEtRaFRER1pKOThS?=
 =?utf-8?B?SVhDa3BERWJlNlg4cEFOakgxZVRGR2N3K1dNNjI5TkFZUGFuci92VVBNajV3?=
 =?utf-8?B?N3c2YmFiZHVMTTJhRWd2b211Rm1nV216dFF3T1NOcmhBVldjMVg0ZW5Ccmww?=
 =?utf-8?B?THRSWUsycFJUKzN0enR2Nnl5ZC8vOGlKMUsvRFFSbW95ak9NbHdlNTA2Q3Vv?=
 =?utf-8?B?UEgzczJuM2U3TlJUWWJGbkRDQzhBYXpqVXFBNnZuSzlHMExmL0xlUVRhZ2ww?=
 =?utf-8?B?a0w0OFdpUDdBRFhwYy9DdC9xZkpJYkx5V3V5OVVUOHBhS2srekF6dW5jejNk?=
 =?utf-8?B?eXVGNE1iR3R4V2UvRThOWTAwbHZZa21QWnE0UVBUaHViSmdXbmQ2bDdmZ1Ny?=
 =?utf-8?B?Yi9DL0tJY3FZT29yV2czZ3RmNnphZjdZWExVOFpOZHh1NUdjd0FIQ3VzUjBZ?=
 =?utf-8?B?VVFFdGxrdlN3VXFydXBOaTFiL2MyTjV1bERPWGtaQTJuN0xaTk5mbzhIRlk1?=
 =?utf-8?B?ajdwRmR6SnI4SUZHZnQ3QVFVQkVCd2Fkck1XUjhRU01OcmJLaFFwSjRDc0Y4?=
 =?utf-8?B?YzZib3BNdUg3YmZod3JMdnhzUzVyYmQ0Zy9EMmdkdTVFZDl2dCtZWS9wQzlu?=
 =?utf-8?B?cENTVTdvelRmeVpiTkVhN0hHM1hxR1ViU2wyV3RkYXhUOFM3Zi9XSGFkUnNh?=
 =?utf-8?B?c2orb2VJMDVHbzN1azRCV0oxc0FWVkhzc0xlNURxUzlZMG43MDlVOVBaYVNS?=
 =?utf-8?B?bVlzVTJDdGJUVGFrNG9vcTUvNlFBT0xDbGtOd2ZJV256ZmJ1MnBHWEJkaVhw?=
 =?utf-8?B?Sk5MbW4xOW1JWTNFaVNlOVVHMjZsWW5OM2JGejA4NlY3WEJwTHFKSWpndnRm?=
 =?utf-8?B?RFUzcWwwd0V0TStIREl6bU43SXMvMWZzN1RaRDR2V0dFZkZSL2hsRjlOTmNN?=
 =?utf-8?B?RmZFTU5mM0VURWdITTB2emdMR1FnbGkyd0o1UitVc0NjVXVrM0tJenJmOUQr?=
 =?utf-8?B?ajRIYmoydUo4aWx5TkszdHlHVkcwdzhxTHNMamUybHdjYlN3RFdQdjk5bS9E?=
 =?utf-8?B?QnRQV0FwbzN6ZEszMEdRbk51WlppeVZVbHpTRHBBN1FWbmdlbjR5bHdKd1ZP?=
 =?utf-8?B?TGwwSm5Sbjd5TDdoU3RZcm5UUUZ2TDNSOWVLTVdRRVF5dHZtRGh2UzY1MUVQ?=
 =?utf-8?B?TEZQcjl4bnMwSVl0eTE5MG8valBsUHJUVHc3WGhvQnVwT1NmZk0yeGM1MUxT?=
 =?utf-8?B?Nlg4NmlnaVNUWFlFdVJNUmUzS0dGdGZKbUltZmkzbnpDZk5JaG51Zk1vSHQ2?=
 =?utf-8?B?TGZOS1lXdk41VXU0eCtnbTRzM2w4RU5xR1ZwNmNjVkl3dDNtZGRVbTZNOGRJ?=
 =?utf-8?B?MjV2cEdwUEViSi9pYTFocXhxZVBGTy9vNkFpeWNMNVRkaHRLQWdTMWVLYjI1?=
 =?utf-8?Q?59uXMqueZEyepdeJIHg4lbU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE62A1CEB4363744805F8ECE386CBD70@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b20d6c1-2037-4b61-7613-08dbaeee70dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 15:32:12.1541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g2aPJM1nC2QtxW1U1QkADrnA65ndRZtyYQEa745RkizRGr+ArHACOa6TN2rSJLeJeKyRJ+I8nT5hYhzGLnZ5GIYdEAarTXWseRTxewMkuQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7819
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA5LTA2IGF0IDAzOjE0ICswMDAwLCBaaGFuZywgUnVpIHdyb3RlOg0KPiBI
aSwgVmlsbGUsDQo+IA0KPiANClsuLi5dDQoNCj4gVGhlIGJlbG93IGNoYW5nZSBrZWVwcyB0aGUg
cHJldmlvdXMgbG9naWMsIGNhbiB5b3UgY29uZmlybSB0aGlzPw0KPiANCj4gSU1PLCB0aGUgbmV3
IGxvZ2ljIGlzIHJpZ2h0IGJlY2F1c2UgbWFraW5nIGFueSBjaGFuZ2UgdG8gYSANCj4gbG9ja2Vk
IHBvd2VyIGxpbWl0IGlzIG1lYW5pbmdsZXNzLg0KPiANCj4gU3Jpbml2YXMsDQo+IA0KPiBEbyB3
ZSBjaGVjayBpZiBhIGRvbWFpbi9wb3dlcl9saW1pdCBpcyBsb2NrZWQgYmVmb3JlIHdlIGVuYWJs
aW5nIGl0DQo+IGluDQo+IHRoZXJtYWxkPw0KVGhlcmUgaXMgbm8gd2F5IHRvIGNoZWNrIGxvY2tl
ZCBiaXQgZnJvbSB1c2VyIHNwYWNlLg0KDQpUaGlzIHdhcyBhbiBpc3N1ZSBzZXZlcmFsIHllYXJz
IGJhY2sgYW5kIHRoZXJtYWxkIGFkZGVkIGxvZ2ljIHRvIGF2b2lkDQp0cnlpbmcuDQoiDQogICAg
ICAgICAgICAgaWYgKHJldCA9PSAtRU5PREFUQSkgew0KICAgICAgICAgICAgICAgICAgICAgICAg
dGhkX2xvZ19pbmZvKCJwb3dlcmNhcCBSQVBMIGlzIEJJT1MgbG9ja2VkLA0KY2Fubm90IHVwZGF0
ZVxuIik7DQogICAgICAgICAgICAgICAgICAgICAgICBiaW9zX2xvY2tlZCA9IHRydWU7DQp9DQoi
DQoNCkJ1dCBoZXJlIGl0IHNlZW1zIHRoYXQgaXNzdWUgd2l0aCBzdXNwZW5kL3Jlc3VtZS4gdGhl
cm1hbGQgZG9lc24ndCBkbw0KYW55dGhpbmcgZHVyaW5nIHN1c3BlbmQvcmVzdW1lLg0KDQpUaGFu
a3MsDQpTcmluaXZhcw0KDQo+IA0KPiB0aGFua3MsDQo+IHJ1aQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvcG93ZXJjYXAvaW50ZWxfcmFwbF9jb21tb24uYw0KPiBiL2RyaXZlcnMvcG93ZXJj
YXAvaW50ZWxfcmFwbF9jb21tb24uYw0KPiBpbmRleCA1YzJlNmQ1ZWVhMmEuLmY2ODE2YTkxZDAy
NyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wb3dlcmNhcC9pbnRlbF9yYXBsX2NvbW1vbi5jDQo+
ICsrKyBiL2RyaXZlcnMvcG93ZXJjYXAvaW50ZWxfcmFwbF9jb21tb24uYw0KPiBAQCAtODkzLDcg
Kzg5Myw3IEBAIHN0YXRpYyBpbnQgcmFwbF93cml0ZV9wbF9kYXRhKHN0cnVjdCByYXBsX2RvbWFp
bg0KPiAqcmQsIGludCBwbCwNCj4gwqDCoMKgwqDCoMKgwqDCoGlmICghaXNfcGxfdmFsaWQocmQs
IHBsKSkNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVJTlZBTDsN
Cj4gwqANCj4gLcKgwqDCoMKgwqDCoMKgaWYgKHJkLT5ycGxbcGxdLmxvY2tlZCkgew0KPiArwqDC
oMKgwqDCoMKgwqBpZiAocmQtPnJwbFtwbF0ubG9ja2VkICYmIHBsX3ByaW0gPT0gUExfTElNSVQp
IHsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwcl93YXJuKCIlczolczolcyBs
b2NrZWQgYnkgQklPU1xuIiwgcmQtPnJwLT5uYW1lLA0KPiByZC0NCj4gPiBuYW1lLCBwbF9uYW1l
c1twbF0pOw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRUFDQ0VT
Ow0KPiDCoMKgwqDCoMKgwqDCoMKgfQ0KPiANCj4gDQo+IA0KPiANCj4gDQoNCg==
