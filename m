Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0798C7902DB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 22:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350729AbjIAUgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 16:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbjIAUgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 16:36:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36F0E7E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 13:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693600562; x=1725136562;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=e6jnYYKl3ZLXZmIIsKZ20DAbzeyxIrro/34wFSY2Uus=;
  b=jUsc+Ay7YQtkYG9tmzjMOmSktpgk1l7MQf00qUDBqsEvlJ4h+W5KSu7W
   6VytGcGTIqJ7Yv/mxo2SzfXoYuQXwnQnFjIyZ91yT4HJtLS6E3GVL/pIs
   LNG9taAhCfbI4gNyfobvGXmZrEWIAk/2Ug+oFNdCCgnZSmlajgnsb5D1D
   xGmZA2G7pIshXPmCWokoMANQt7p5KSU/LEt8q0O5DXRnNflTigfcLNMDj
   C4WrZwIsNdk3pmQwPn6qWJGTTAlfZaXVmEKCTJbjI1ENVLXWFTApD/uyy
   y/vVxeisPeyrmJMmdwfoBrws2c5h7Ukzg1DsOD2TaT9CL+KSPotoj8Oo4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="442701486"
X-IronPort-AV: E=Sophos;i="6.02,220,1688454000"; 
   d="scan'208";a="442701486"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 13:36:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="863672973"
X-IronPort-AV: E=Sophos;i="6.02,220,1688454000"; 
   d="scan'208";a="863672973"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Sep 2023 13:36:02 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 1 Sep 2023 13:36:02 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 1 Sep 2023 13:36:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 1 Sep 2023 13:36:01 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 1 Sep 2023 13:35:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WyLY+t00gxtlz58OFkYxIvaBK+APSWHIDqhQF9zghNPn4Ve9bPkQ1t68W1YZPbLlm1UwZ6f2fd5akstJDqrs1WnF8SseL5G4idHJ87pV126VeGesyZEnQcM2Bb0bPEAxfuJoy3C1H6gm3kIVdls/PpUllVRB8a0HY67S3DbTVzpX3u0UR4H9zYRcDNwcGz6pnxO5Nxg2DSd74NKdzg6juGJ90qCPVxRrcMqBTFlgtKgdTPqso0uhXBUxKRO8khyMlRe9joESs5NTFmlIMkUchwvCJz8LaG85cW5PDUB2vVvh0pQd91sHiqXZY7npnxvwWzgjgfcws5T7MqoEctuIaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6jnYYKl3ZLXZmIIsKZ20DAbzeyxIrro/34wFSY2Uus=;
 b=VN3gzVYEFxVwPH03dslZf8JVz3T/0aFMrwL169RdDro0Tt8VTfZyfsAU6HZXlT7T+MKO9QQBoafuLudo01ooVE8MYhMUdVrjlUEzq4iThopkpHZxJrlE9HvlPG1VC9IIODBRvWkxuoCGW7gwQ2OcTOo1SHZo4HRRGsBHRgM1HKs0sfQcQWBRy/+avccYLIKH/k0CmbKOvKyrgOq1UPYCHKmuCO0UXiCMLcb8cJGl1P10Vk70dRxIuBqxElqShCanzXIrVrvZch61z6a6lFPsVLFybSEJKRePrX1vS50TaWcMkslpZM8O3YJBrnAuAcooXZyGDYIfhyH1fqrJQ6BxBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CO1PR11MB4915.namprd11.prod.outlook.com (2603:10b6:303:93::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Fri, 1 Sep
 2023 20:35:50 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259%3]) with mapi id 15.20.6745.020; Fri, 1 Sep 2023
 20:35:49 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [PATCH] selftests/x86: Update map_shadow_stack syscall nr
Thread-Topic: [PATCH] selftests/x86: Update map_shadow_stack syscall nr
Thread-Index: AQHZ3QCRI1z+rI8HBEKSGAcvQRk7hLAGXFwAgAARa4A=
Date:   Fri, 1 Sep 2023 20:35:49 +0000
Message-ID: <b92afa6dbd074409095e525204d538f451ee4823.camel@intel.com>
References: <20230901181652.2583861-1-rick.p.edgecombe@intel.com>
         <e2ae1d89-9abf-338e-e56a-dc4be19b9bfc@intel.com>
In-Reply-To: <e2ae1d89-9abf-338e-e56a-dc4be19b9bfc@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CO1PR11MB4915:EE_
x-ms-office365-filtering-correlation-id: 930eca98-96c0-4a58-4dad-08dbab2b0768
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MJpMAjfEtUX3Onfis8dW9ST6Nvq+JSPpKx3dR+/tMCfCBJD21lCw4WcelaispxkMjz3YorGYkrVqHwAu3z8I3xCuxT6/qec75c6yz1AZpnkhkFYZsK/R3DZoeagEx/btJH4VSYY9G4Wz28nCcg1sVpLye4Gnl5+8/e+hsIkGqL5h1w/lr8iwBS5ZMRW/vBvx/3RV3YYjVOXcmQ3+3B1yE9YF4YrGuQG70OUhvdMqEV9f4N4cO0R0rs3dssMJy8VoY2d/+hq0K9aPSC5nFPgHZ/Qc9uyKJZQ8/iSEO2A+tOpF0FUbRaHyxNIxKKnOQuqJvB/VXqIkPfAbM2xBnuHWxnEBYZCXE8nzka94KnTawQDwORyiaZFg2ZFLZxnWcPXsKb5G27AdHmWQN74DpF+lFrS/jSssJwHtlWlLxamd8Vp4sqgrYReNf0gkP3C1rOwl6X9xwAGCoGRcVj5PZ9EmUtErlwc7PsGXD9Jv+ET8b2WZmRxXRgbvE5TfZXYhWMfcGFlcE1yhOzVTWqmZU68Nof0InkfsEdLEdlyHZ5yiTm0D1Haeq2X2jxvhGeMdSlMLYQLlJ3tMausoYfl7EnUUh8CRehY3+9zVsUQGzjPi5mDieKG4H7kmJAuyzLUO4/SE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(376002)(396003)(39860400002)(1800799009)(451199024)(186009)(36756003)(7416002)(83380400001)(6486002)(4326008)(86362001)(41300700001)(5660300002)(8936002)(8676002)(6506007)(26005)(53546011)(71200400001)(6512007)(2616005)(38070700005)(76116006)(15650500001)(110136005)(966005)(2906002)(478600001)(122000001)(38100700002)(66946007)(921005)(91956017)(66476007)(64756008)(316002)(66556008)(66446008)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnMyWEdDWjR4RWxIbVM2S1ZubFdHM2dzdk5iblNQbWR1bmRRc09EbGZqeWhU?=
 =?utf-8?B?cnVMSzZTWElGQ3RyM3V5VUppNlk3ak9CR2haNG55cEN1SDZ1V05JYkpkc1Ns?=
 =?utf-8?B?K3JSWXNPdW1ObXBoeitEQVYrRHNiYnpXc2d5cWlnRU1oMUNNZzIxOUVIRDJy?=
 =?utf-8?B?KzRtVm1IN24xbEsrby9nYXNMUURyTTE0VHpqeG1UQmIrM1RjdU5lemI3M0dS?=
 =?utf-8?B?LytmaSt2Tk9zNHYyZHJ4NWkyZjFFeFJrVC9PVU90L29lcGhyRnRxZ2ladFJO?=
 =?utf-8?B?TTk4T1orNlhVeTh2UU9IZVl4dGgzSFBXaFBWeUZpVHBEV0lTOWJ2Q2lnZjFu?=
 =?utf-8?B?ZlVudWNKeHpCQVAyd3hmZkRKMXBYelh6Vyt0dG1GZ1ZzQndJeE1nc1Q2SnFq?=
 =?utf-8?B?WXBpT1plbTlKVU42bHlCaVV2TVA0NnM2VUhOT3hhTUMzV3V3eTNSYmU5LzAz?=
 =?utf-8?B?cCt2MVhGTkhobVlPNUQ2WTczNytDay9NaDVQNkpycUhPK1FoRzVNeUdmbDcr?=
 =?utf-8?B?aTZXUXVJWG4vMlhPWmsxSFkrbE4xWkFEdUJMcUM3a2NqMzhKSGJqaUVoZ3pJ?=
 =?utf-8?B?VmxxbElHMFh2SVVqKzdadnZ6UmRDRVU4M1hncmR2eU1sMXlEOWdxeGhGUGtp?=
 =?utf-8?B?TDN4ekNnK0x6R2VKOUR1QlV5TzAycUpHNHZVMXZxQlJjNi9VZ3NMM1VibURN?=
 =?utf-8?B?YjFUL0hoOThVMStVZDF4NUdDeTduU1dMc3Bycld6VVVCVjFzaUllUUdNVitX?=
 =?utf-8?B?aGFyQWw3bEhyb3RuR0JHMlVxcThEL0V1WG5SWTVIcHlVenIrbC9HWTNoOWwv?=
 =?utf-8?B?bkhXN1U0RytsR3ZlbnNqQlQ1QWRNaCtqRWVjQWx0Mis4Y1ZHcC9zZ1dGQ3JR?=
 =?utf-8?B?OFZTL3VGYnJKWXNDZ3laTFFvdm55Nm16dWxXWmRkYlNtNkZmaDJ4c2IxSEZ3?=
 =?utf-8?B?c3RZNGIwK2ZtcklKN254VE03SWNXOTg1d0c3NFZLeXdsSEo2cVZPWlRHUVNv?=
 =?utf-8?B?SE5QcFBiOHRZbHV4ajRkYzZyK21RR2VZdGhSaGVtQS9KYlJhaHhKa1AzWkEv?=
 =?utf-8?B?V0QwZUN4ZW8vYWFERDhLczdWMlRoTjRWU2tYeTNYMjlJejgvckRLM2RuWXZX?=
 =?utf-8?B?V0dOV1FSNTRJZVJ0VW1aamxCYVpGYUlwaDQ2UXlmSGR2WU9MY0lIa2tKaW1l?=
 =?utf-8?B?c3hhc1M1MzFRK05QdCs2MmhSU3V4d2FnTG5QVGRXYmMwYnowT0RIaUNBRysw?=
 =?utf-8?B?N0s0OElwZG1IUHVBSFgzWGlZMVdBYkdpLzBaTkF3WWw1M2RmTjRNdnMrVjVk?=
 =?utf-8?B?TEMrc3ZMZ0Y1Zit2dnhJa21mQU5oTVpDajJwNUZBS0E5VUYrbnlnTXVOTEh5?=
 =?utf-8?B?MnJ2SFNnNlFBaXpkcmEvK29oY1VwVkc0akdXNStLMGFUeGozcXg3ekFjOENR?=
 =?utf-8?B?SG1GcU5HTU9WKy9pZXZhWXNVV1ozNjFPWENqa3VDOCtIOEErREhlU3RmY21G?=
 =?utf-8?B?cVIwcEl0Skl1eS9md1N1S2lVdkRoUDdESEpub0d3dFYzaFBxYko2b0xNODlh?=
 =?utf-8?B?V3psYjltME9RNnFrbUJmZi9MZnFyQXpnalZnYjNDSjZ3cTRmaXVEcXR2blZN?=
 =?utf-8?B?bUdDU01JTnJPTDRHUTdiS1g2dXhpanU2RXREWUZjaVB0ZEFvWUFkMXk2ekpm?=
 =?utf-8?B?ejl1UlVCaU1kUTZ0M2R0dEtUYm54aUFJRGtJcUtWVzZsakhzakJkMlhibExF?=
 =?utf-8?B?WXZML0dWcG0vc1hMUHp0WXhzb0FQWk1Ed0pVcTFDM0U4MHY1YVNiWlNaeWxr?=
 =?utf-8?B?ZEEzSmFVRmVMUUt0ZDd6VzAzN1orNm5zbGRPMUMvQkNxcXB2UUZNR2NuNjlT?=
 =?utf-8?B?cUNYclM2UUlEbWFkeFh1bWVveXJLUWdEeWRHQ010eGlRODRwRkdxME1Pbzhr?=
 =?utf-8?B?R0hnVzBFZjE2cGZoblY1RnRCeEFQeXhENTladElpNWpxSTM1dEplVWNWbldL?=
 =?utf-8?B?eHd4K1RGRC8yT21mTGdPOGN4SGFWc0F5Y1Bicm9DSTdlcWwvMnFUYWhVYUlL?=
 =?utf-8?B?Q2YzVllRNGs2UHhLYk5hZWZFTFdSYmdyRkFvV0MwNXowbXY4TkVacHc4QXRj?=
 =?utf-8?B?bXRmdm9QQ3ZVTU5Ea1RqTEpyVFNlZjBtRGRZaUFyZm94QzJHYi9nSVVCMTJn?=
 =?utf-8?B?eWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15357BD751417A41AA1939B9FFBEFA0F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 930eca98-96c0-4a58-4dad-08dbab2b0768
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2023 20:35:49.8758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZDA3zv7/qSpI7nEh/bPtexB9m3ruvd5cyFOAyZlhk3ERF0KAPC03Tgr7Wj/OypvTlUBR3nalSbinpy734yoGBm1EnFUbVvFvDy8+6ahCPcM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4915
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

K01hcmssIHJlZ2FyZGluZyBtYXRjaGluZyBtYXBfc2hhZG93X3N0YWNrIHN5c2NhbGwgbnVtYmVy
cy4NCg0KT24gRnJpLCAyMDIzLTA5LTAxIGF0IDEyOjMzIC0wNzAwLCBTb2hpbCBNZWh0YSB3cm90
ZToNCj4gSGkgUmljaywNCj4gDQo+IE9uIDkvMS8yMDIzIDExOjE2IEFNLCBSaWNrIEVkZ2Vjb21i
ZSB3cm90ZToNCj4gPiBTaGFkb3cgc3RhY2sncyBzZWxmdGVzdCB1dGlsaXplcyB0aGUgbWFwX3No
YWRvd19zdGFjayBzeXNjYWxsLiBUaGUNCj4gPiBzeXNjYWxsIGlzIG5ldyB3aXRoIHRoZSBmZWF0
dXJlLCBidXQgdGhlIHNlbGZ0ZXN0cyBjYW5ub3QNCj4gPiBhdXRvbWF0aWNhbGx5DQo+ID4gZmlu
ZCB0aGUgaGVhZGVycyBmb3IgdGhlIGtlcm5lbCBzb3VyY2UgdHJlZSB0aGV5IGFyZSBsb2NhdGVk
IGluLg0KPiA+IFRoaXMNCj4gPiByZXN1bHRlZCBpbiB0aGUgc2hhZG93IHN0YWNrIHRlc3QgZmFp
bGluZyB0byBidWlsZCB1bnRpbCB0aGUgYnJhbmQNCj4gPiBuZXcNCj4gPiBoZWFkZXJzIHdlcmUg
aW5zdGFsbGVkLg0KPiA+IA0KPiANCj4gSSBhbSB3b25kZXJpbmcgd2h5IGEgZGVmaW5pdGlvbiBm
b3IgX19OUl9tYXBfc2hhZG93X3N0YWNrIGlzIG1pc3NpbmcNCj4gaW4NCj4gaW5jbHVkZS91YXBp
L2FzbS1nZW5lcmljL3VuaXN0ZC5oPw0KPiANCj4gV291bGRuJ3QgdGhpcyBtZWFuIHRoYXQgZXZl
biBpZiBzb21lb25lIHdlcmUgdG8gaW5zdGFsbCB0aGUgaGVhZGVycw0KPiB0aGV5DQo+IHN0aWxs
IHdvdWxkbid0IGdldCB0aGUgc3lzY2FsbCBudW1iZXIgZGVmaW5pdGlvbi4gQW0gSSBtaXNzaW5n
DQo+IHNvbWV0aGluZz8NCg0KVGhlcmUgaXMgc29tZSBhdXRvZ2VuZXJhdGlvbiB0aGF0IGhhcHBl
bnMgZnJvbSB0aGUgLnRibCBmaWxlcy4NCg0KPiANCj4gPiBUbyBhdm9pZCB0aGlzLCBhIGNvcHkg
b2YgdGhlIG5ldyB1YXBpIGRlZmluZXMgbmVlZGVkIGJ5IHRoZSB0ZXN0DQo+ID4gd2VyZQ0KPiA+
IGluY2x1ZGVkIGluIHRoZSBzZWxmdGVzdCAoc2VlIGxpbmsgZm9yIGRpc2N1c3Npb24pLiBXaGVu
IHNoYWRvdw0KPiA+IHN0YWNrIHdhcw0KPiA+IG1lcmdlZCB0aGUgc3lzY2FsbCBudW1iZXIgd2Fz
IGNoYW5nZWQsIGJ1dCB0aGUgY29weSBpbiB0aGUgc2VsZnRlc3QNCj4gPiB3YXMNCj4gPiBub3Qg
dXBkYXRlZC4NCj4gPiANCj4gPiBTbyB1cGRhdGUgdGhlIGNvcHkgb2YgdGhlIHN5c2NhbGwgbnVt
YmVyIGRlZmluZSB1c2VkIHdoZW4gdGhlDQo+ID4gcmVxdWlyZWQNCj4gPiBoZWFkZXJzIGFyZSBu
b3QgaW5zdGFsbGVkLCB0byBoYXZlIHRoZSBmaW5hbCBzeXNjYWxsIG51bWJlciBmcm9tDQo+ID4g
dGhlDQo+ID4gbWVyZ2UuDQo+ID4gDQo+IA0KPiBIb3cgYWJvdXQgYWRkaW5nIGEgZml4ZXMgdGFn
IHRvIG1ha2UgaXQgYSB0aW55IGJpdCBlYXNpZXIgZm9yIHNvbWVvbmUNCj4gd2hvIGJhY2twb3J0
cyB0aGUgc2hzdGsgc2VyaWVzPw0KPiANCj4gRml4ZXM6IDgxZjMwMzM3ZWY0ZiAoInNlbGZ0ZXN0
cy94ODY6IEFkZCBzaGFkb3cgc3RhY2sgdGVzdCIpDQoNCkkgd2Fzbid0IHN1cmUgaWYgdGhlIHBy
b3BlciB0YWcgd2FzIHRoYXQgY29tbWl0IG9yIHRoZSBtZXJnZSBvbmUuIElmDQp0aGUgc2VsZnRl
c3QgY29tbWl0IGlzIGJsYW1lZCwgYW5kIGluIGEgYmFja3BvcnQgdGhlIG9yaWdpbmFsIGNvbW1p
dHMNCmFyZSBncmFiYmVkIHBsdXMgYW55IHRoYXQgYmxhbWUgdGhlbSwgdGhlbiB0aGUgc3lzY2Fs
bCBudW1iZXJzIHdvdWxkDQplbmQgdXAgbWlzbWF0Y2hlZC4NCg0KU28gSSB0aGluayBtYXliZT8N
CkZpeGVzOiBkZjU3NzIxZjlhNjMgKCJNZXJnZSB0YWcgJ3g4Nl9zaHN0a19mb3JfNi42LXJjMScg
b2YgWy4uLl0iKQ0KDQpCdXQgbWF5YmUgYWxzbyB0aGlzIHdob2xlIGR1cGxpY2F0ZSBkZWZpbmVz
IHRoaW5nIGlzIHF1ZXN0aW9uYWJsZS4NCg0KPiANCj4gPiBMaW5rOiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9sa21sL1klMkZpamRYb1RBQVR0MCtDdEB6bi50bmljLw0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCj4gPiAtLS0N
Cj4gPiDCoHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3g4Ni90ZXN0X3NoYWRvd19zdGFjay5jIHwg
MiArLQ0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
DQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3g4Ni90ZXN0
X3NoYWRvd19zdGFjay5jDQo+ID4gYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy94ODYvdGVzdF9z
aGFkb3dfc3RhY2suYw0KPiA+IGluZGV4IDIxODg5Njg2NzRjYi4uNzU3ZTY1MjdmNjdlIDEwMDY0
NA0KPiA+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3g4Ni90ZXN0X3NoYWRvd19zdGFj
ay5jDQo+ID4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMveDg2L3Rlc3Rfc2hhZG93X3N0
YWNrLmMNCj4gPiBAQCAtNDAsNyArNDAsNyBAQA0KPiA+IMKgICogd2l0aG91dCBidWlsZGluZyB0
aGUgaGVhZGVycy4NCj4gPiDCoCAqLw0KPiA+IMKgI2lmbmRlZiBfX05SX21hcF9zaGFkb3dfc3Rh
Y2sNCj4gPiAtI2RlZmluZSBfX05SX21hcF9zaGFkb3dfc3RhY2vCoMKgNDUyDQo+ID4gKyNkZWZp
bmUgX19OUl9tYXBfc2hhZG93X3N0YWNrwqDCoDQ1Mw0KPiA+IMKgDQo+ID4gwqAjZGVmaW5lIFNI
QURPV19TVEFDS19TRVRfVE9LRU7CoCgxVUxMIDw8IDApDQo+ID4gwqANCj4gDQo+IFJldmlld2Vk
LWJ5OiBTb2hpbCBNZWh0YSA8c29oaWwubWVodGFAaW50ZWwuY29tPg0KDQpUaGFua3MhDQoNCj4g
DQo+IEFwYXJ0IGZyb20gdGhpcyBwYXRjaCwgSSB0aGluayB3ZSBhbHNvIG5lZWQgc29tZXRoaW5n
IGxpa2UgY29tbWl0DQo+IDc4MjUyZGViMDIzYyAoImFyY2g6IFJlZ2lzdGVyIGZjaG1vZGF0Miwg
dXN1YWxseSBhcyBzeXNjYWxsIDQ1MiIpIHRvDQo+IHJlc2VydmUgdGhlIDQ1MyBzeXNjYWxsIG51
bWJlciBmb3IgdGhlIHJlc3Qgb2YgdGhlIGFyY2hpdGVjdHVyZXMuDQo+IA0KPiBTaG91bGQgSSBz
ZW5kIG9uZSBvdXQgaWYgeW91IGRvbid0IGhhdmUgc29tZXRoaW5nIHByZXBhcmVkIGFscmVhZHk/
DQoNCk9yaWdpbmFsbHkgdGhlcmUgd2VyZSBubyBvdGhlciBzaGFkb3cgc3RhY2sgZmVhdHVyZXMs
IGFuZCBzbyBpdCB3YXMNCm1heWJlIGdvaW5nIHRvIGJlIGFuIHg4Ni1vbmx5IHN5c2NhbGwuIEkg
Zm9sbG93ZWQgaW4gdGhlIGZvb3RzdGVwcyBvZiANCnRoZSBzZWNyZXQgbWVtIHN5c2NhbGwsIGJ1
dCB0aGF0IG9uZSBzZWVtcyB0byBoYXZlIGdyb3duIHNvbWUgc2ltaWxhcg0KcmVzZXJ2YXRpb24g
Y29tbWVudHMgc2luY2UgdGhlbi4gSXQgcHJvYmFibHkgbWFrZXMgbW9yZSBzZW5zZSBmb3IgdGhh
dA0Kb25lIHRob3VnaCwgc2luY2UgaXQncyBzb3J0IG9mIGEgZ2VuZXJpYyBmdW5jdGlvbmFsaXR5
LiBBbiBhbmFsb2dvdXMNCng4NiBzcGVjaWZpYyBzeXNjYWxsIHdvdWxkIG1heWJlIGJlIG1vZGlm
eV9sZHQsIHdoaWNoIGRvZXNuJ3QgcmVhbGx5DQpoYXZlIHJlc2VydmF0aW9ucy4NCg0KQnV0IG5v
dyB3ZSBhbHNvIGhhdmUgYXJtIHRoYXQgcGxhbnMgdG8gdXNlIGl0LiBTbyBtYXliZSBpdCBpcyB3
b3J0aA0KdHJ5aW5nIHRvIG1hdGNoIHN5c2NhbGwgbnVtYmVycz8gSSBjb3VsZCBpbWFnaW5lIHNj
ZW5hcmlvcyB3aGVyZSBpdA0KY291bGQgYmUgdXNlZnVsLiBBbmQgSSBndWVzcyB0aGVyZSBpcyBh
bHNvIHRoZSBzY2VuYXJpbyB3aGVyZSBhIGdlbmVyaWMNCnR5cGUgc3lzY2FsbCBpcyBhZGRlZCwg
YnV0IG9ubHkgaW1wbGVtZW50ZWQgb24gbm9uLXNoYWRvdyBzdGFjaw0KYXJjaGl0ZWN0dXJlcy4g
U28gdGhlbiB3aGVuIGl0IG1ha2VzIGl0J3Mgd2F5IGFyb3VuZCwgaXQgY2FuJ3QgbWF0Y2guIEkN
CmhhZG4ndCB0aG91Z2h0IGFib3V0IGl0IGJlZm9yZSwgc28ganVzdCB0aGlua2luZyBpdCB0aHJv
dWdoLi4uDQoNClNvIHNvdW5kcyByZWFzb25hYmxlIHRvIG1lLiBJIGRvbid0IGhhdmUgYW55dGhp
bmcgcHJlcHBlZC4NCg0KPiANCj4gVGhhbmtzLA0KPiBTb2hpbA0KPiANCj4gDQoNCg==
