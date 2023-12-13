Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3AA812020
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 21:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442614AbjLMUlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 15:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLMUle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 15:41:34 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0DC9C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 12:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702500101; x=1734036101;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uRI32y/9NvOZzxx6xboj1n/JnkthfWvojPB+6ypJ3N0=;
  b=M/DoMG/iL/qlmpeEOn88J7CRWPkEJNzBWBxvyv+htCLIq6FAX+UqFnQG
   rPwS1aljVm4W0iy1nMqXzpBhPpyz/f5b61a5VAykWg1zSU8DFd73QYESu
   j46KYFW49foMZ5emPxvPvY8NOE1aEI8noAvmIKXyReliX6YJt24t/+7lj
   Ljyq6yaL813hl0mPVu+OyidfrXiqLUiGPmDAy/I4HqQvthbOFoC7hH/F4
   +J2ND96vMun8h8tFFNJjRWYiGIZme9Y3k+bieExzmqtVSivPs+cy3ZvZP
   26+hSv8HnFytjA52m6IXVT5GJyDBZzNJ3+2vGmf4rSq3YoV5tgPAPp1EU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="2167729"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="2167729"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 12:41:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="22120918"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2023 12:41:41 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 12:41:39 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 12:41:39 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Dec 2023 12:41:39 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Dec 2023 12:41:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWLZ48JbTV8YmLcev+LqCjkBTw2PX0euXlCEVVSalRYxCwyrua1QqxCpUr6W41OET+WSnmpzC2HWYRKWJlZ6ua5G4OvEzeZZ2SpnJiq+JxL+GFbUtYGNXtCidByIwlXTSzJ+LSYbbXOoICb7Mhoe/suk0oOjYJbcnW+D5PpN9e68c3yEQoXz3imnCwFK07PfV3x1VXsrqezmD6iZNO5O+czUcpBDsvivejbyPbqAW9MBOucycjHu2hXnXhBd+k/mJ21Kay2Ujqx3rw0m/tzAmuy5h0QaMaVMEAs7tL5E9Ajw4UQ/2Oe6FeuppI9F2kVuyQAU0GaUIyaIFW6+K1g4mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRI32y/9NvOZzxx6xboj1n/JnkthfWvojPB+6ypJ3N0=;
 b=gouJZ02O7Ak7Bi6N751VTEHqXK72Ufc7dw7kEj9sZ8afYiRccKPQJQT+OvW7CU/TZLB4fMTCDLg1/W2LkMi2WHxtd+hrPcXPU0m8xxH+pLGrn4NeYB2bbPuqxbo5RsCRSqiU25xr7qRRYaD+WJ5Z2umisBwgWfpP0l13ZqKqhIzVJsjNXSoftaQK2seLMY9VeRxohAnxrEmAKg0z3AG7Wn9Ue0udQZ4QpJhdf24dTqFlS7Q6u2x/1vw40GVQxH4j6iuaxYEqiK7yqwJ2QvvRfaJnR2n+DnD5XJzYDyyKPprW/jQI0aMLhwZ9BwARDw+0nmuMxNqqQ7PgszjmbPteag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SN7PR11MB7974.namprd11.prod.outlook.com (2603:10b6:806:2e7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 20:41:37 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%7]) with mapi id 15.20.7068.033; Wed, 13 Dec 2023
 20:41:36 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>
CC:     "arnd@kernel.org" <arnd@kernel.org>,
        "Yao, Yuan" <yuan.yao@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCH] x86: tdx: hide unused tdx_dump_mce_info()
Thread-Topic: [PATCH] x86: tdx: hide unused tdx_dump_mce_info()
Thread-Index: AQHaLUNkbx3M70MeHUWOqNlrwdFerLCmLZaAgADwT4CAAIicgIAAAJUAgAAH5IA=
Date:   Wed, 13 Dec 2023 20:41:36 +0000
Message-ID: <0ee20c6422a9e1d53c2a1f9112d5dd8308eea1ba.camel@intel.com>
References: <20231212213701.4174806-1-arnd@kernel.org>
         <39cf0ad5-bbef-4fb9-81a3-9d2891cc7450@intel.com>
         <20231213120215.64wcryk5k75cymop@box>
         <044e2990b5ca28d04c7305de3d2d412071975ec1.camel@intel.com>
         <de67b856-369c-41a2-8835-d25641eaeab6@intel.com>
In-Reply-To: <de67b856-369c-41a2-8835-d25641eaeab6@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.50.2 (3.50.2-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SN7PR11MB7974:EE_
x-ms-office365-filtering-correlation-id: 00a8b553-2aa0-43d4-9d18-08dbfc1be6c9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tSGdrPVkrVOlZsRZo94WnRxWru3kG4YgpR83+e3TOBpYK8TMbbL7n6KI9+a6BMBT/o5FHSXUW2Tg6nygy5hXKQqbCmF2WxUSN63QYSLD9XP7sPBDCLRpl7+3E4i1r9xRdbKpLw4rPCDI55VbrCmPBmLckj4vN9urNTykCTFYiGW0UkhGaleHMZAXuY0pbP89dvk1nnapvi/zKwmoCFBcT7VrgzjSfqjYFU2c+uEXeCaQv6pYz7lMHXGcml5aIwROmTOghN0zQD1sdxHGNqeMDpsu/Odt8y5mE+qzFolKDkDx4C+J0w1a8Lg4Si/AAG18AypGk0RbcKoujqTaPKuvG+1S4Azkd2NahBFXOURjfKnGbG5pNvKNwiiMpfRcOwagbmGVcXwyEJdUwHbG3yR8CAEv0GstjnX27LOg+NvZE7GTm08tGpAVY3JO0pe72QNKSC3NHVWzO5z9QlZAgdirF1DY3opH7Omin9UL7MxWhw954Ukd8h2P8y3bXLI3hZS5h6fqpWW0r8nfaCR9IC9V0AsxVtaLOjPwr7q0c45O+GfW5kWpQzsWRFqab/y/Hr2aiig5o5JPIh8n4S/PtxnlgHK4GG9SBAJ7yuq63+Pbwp66FPgCfwj23fUZ+JTjKfyd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(6512007)(53546011)(6506007)(5660300002)(26005)(2616005)(36756003)(7416002)(38070700009)(64756008)(4001150100001)(66446008)(76116006)(91956017)(66556008)(6636002)(66476007)(4744005)(6486002)(54906003)(66946007)(2906002)(82960400001)(86362001)(478600001)(41300700001)(8936002)(8676002)(4326008)(122000001)(110136005)(71200400001)(316002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akdZeGV1TFlDSlQ3YTVzd0V3L2Z2RVE5T1pkWHMxdlZublByK2YxZit5SFdh?=
 =?utf-8?B?clArbS9ZV1hqa0xGYUNLaHozbVV1UmM1NDdPck1ZZ1QyNG9IYXU2Q2tLQzNI?=
 =?utf-8?B?TDNQb2lHbVp3UXpkUk1TaVpxWWc1MnhEbDVnVVFzRWN5TnlYYWU0VkdQdk92?=
 =?utf-8?B?cms1eXRUVGZkS21BUndQQVp1cSttYXRyU2c2VGlYMXR2MVRobUl4SnpPNlQ4?=
 =?utf-8?B?SElvTWtvazg1QThjRXhPR3NXSzA0TlF6aSsyR21pQlQxZGMvSURNNWIxU2x5?=
 =?utf-8?B?MzJjdm5BQVppQlcwRlZZZGROUTQrNUVOaW5HakNPRVltcVRnMkpzUlppMHhX?=
 =?utf-8?B?SW10VlBzUVFYNWNacXdvUDVCS0IwanRFTUkrdXUxZFdPVmRnbGdORGdkS3gx?=
 =?utf-8?B?aFRiRTVPQ04wWVBweStFdk5PZmg3OWg0ODNReVBERHd3M2dhalUvUHg3eHF3?=
 =?utf-8?B?aWFUb0huU3c4Y1BvVG4yYjlYSjkyYWZhY2xXU1pHekJsQ0lsVmJzTWtWZ09C?=
 =?utf-8?B?bk1mTVp3ZnlqbGljQkRIWm8rY29QZ01ZcWxRRFJjOXV3b09saVFjeHBMN053?=
 =?utf-8?B?a1ZLeTF4MEJkZHcvMzNDQ21WQlNIV0dJRVFWckFsREE4bGlpdStBL1JHK2xt?=
 =?utf-8?B?bG9vL0IvQTBBUCtEUktlU3lFaS92VHNVeE9pR3hiVzNUbGQyd2FCaG5PSkl4?=
 =?utf-8?B?WENoS1VYcFk3ZDRkcFRidmtoSTVMSU5xVDBMSjl6WEFHcExJT3hnMGwrRHlD?=
 =?utf-8?B?OXJrcytVQWlvMEswVURzekM1M1ljUUl3UW03c3E3ZFpVYU9Sb293OUZzMklH?=
 =?utf-8?B?YUthMVhWMmpVdTFsMjVpVHlOeDN4VEU1dm5JL3hjTk9VcDVwT3p6TUdrb2RX?=
 =?utf-8?B?Um45M2tCU29xN0I2VFQzK0xXNjlmdURlVkM2ektkRzUrV1BhU2ZZelY5K0Vt?=
 =?utf-8?B?MVJ0bVJmcFJ5VVVnZFB6RXVUVTdKbEFDeThUVE9Ubzg5Q2psYTducVJJMllh?=
 =?utf-8?B?VitXZllkSG01MkQrS2d3aWlWQlRzMlJnRFZ0cmhBbG5sWEp5cFYxeW0yT3dV?=
 =?utf-8?B?aEl0d2ZFOGo0ZVBveVlFN2lqMEdVbkxkU3I1UmtoVW5NaFFlRTIrYlEyckJo?=
 =?utf-8?B?OGdvT1pYd1hrQkhPZ2lOU1lWRnVDcmx4UXR1bUJ3cEhiaDRQbGExUWs0eWJX?=
 =?utf-8?B?QWc1azJIdmxsWHdVbHBZWFdyQlhobVdhV21VTUlacXJBM0U1UlZrNVpsV1h0?=
 =?utf-8?B?c1VSZmpxU0JadHRvOEs0a0JVTFArT29SN3RoZlVzT2dXOXltdmFnSW9Gd0Nn?=
 =?utf-8?B?KzAzanF0RGZIZU9nLzZhUUFTRDRibFR3K2JOSlZHeUc4ZWYvekdJaWp1ZEF3?=
 =?utf-8?B?cHAxOGNUVjg3MDUrRE03OXIvV2o3MmxKTTRTZjIrd0pmTnpaODBPbm52cjJT?=
 =?utf-8?B?OUVtRDFRYllWemo1eDRRZFZ4dlIzSjFzMUc4blRjQnpBNGZiQk5veG15V1Za?=
 =?utf-8?B?Qm9WRHd3ZzFsSVhFTGZSRUV5akdkTk1jUFJUM05TUTdZWHM5c2NFVHR1M0Fj?=
 =?utf-8?B?bEN0dit1VTRGOXgwY3czUFRSYlY2ak1jUVJxbVBVUU9mTmdjc01lckxDWDdY?=
 =?utf-8?B?dGJYK3VYejBmb1ZDQmhDYnBVekQ2NzJPc0VKb05VRE9oZkl5RmtpRXFyYXIr?=
 =?utf-8?B?Y0xJcmIyaE5aSU5EbnFlK290MWw1bHc0M205aVdxVG9MaXFJZTIwNGM5ejAx?=
 =?utf-8?B?RjJpdlZBNEEzYTJSSTNaVWtvTmxzbkg2RFlTUDRLZDhnTWR2V3hCMDZiSitK?=
 =?utf-8?B?VjhyQzRuRXU0aExTNnpMMm5HaHhGYXduYXZBNnZKeVZ6RTkvZzFqRk9LbnRK?=
 =?utf-8?B?cmMwc3lkcEhwUGJ4Y3VJU0s4Y0JCb0NRWVY0RWRsTnJINEhUNlhRUGtTcnB5?=
 =?utf-8?B?UWI1WHdQN2RqcVB5U1U3c2hpYTdMM09UTytmNCt2eVBkc0l5K2lQSnFvSTdX?=
 =?utf-8?B?Vk9oaTdZcFNmYTU2bjEvSEYwMDJ2Q25QUENGNXZ6MFJpWnhoU3lRcFV6c2pJ?=
 =?utf-8?B?MXVLanZKNHRZTUFkaldkb3c4OG5pQmR0ZElyL1dXZDQxWDZ6L1hieTBZbG8y?=
 =?utf-8?B?R21WRzZ2MFNJRVFVMDNwZTJ3RlZwMFlsc2R6SXR1cUthUTNVemZSVTBNVDhM?=
 =?utf-8?B?TEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4B524A84B288C449452DB3B4364425D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a8b553-2aa0-43d4-9d18-08dbfc1be6c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 20:41:36.0532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BF42+o3LUg9wPjqrPmJSNMJMB9FJeJpyM1BCnp0+Ivr75poPx24QgF6EXmJwNHh15Fjq+mWlCskNTP8X7da1Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7974
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTEyLTEzIGF0IDEyOjEzIC0wODAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gMTIvMTMvMjMgMTI6MTEsIEh1YW5nLCBLYWkgd3JvdGU6DQo+ID4gPiAiVGhlIG1hY2hpbmUt
Y2hlY2sgZXhjZXB0aW9uIGhhbmRsZXIgaXMgZXhwZWN0ZWQgdG8gYmUgaW1wbGVtZW50ZWQgaW4g
dGhlDQo+ID4gPiBWTU0uIg0KPiA+IEkgYWxzbyBhZ3JlZS4gIFRoYW5rcy4NCj4gDQo+IEthaSwg
Y291bGQgeW91IHBsZWFzZSBzZW5kIGEgcGF0Y2ggdG8gZml4IHRoaXMgYnVpbGQgcHJvYmxlbSB0
aGF0IEFybmQNCj4gcmVwb3J0ZWQ/DQoNClR1cm5zIG91dCBJTlRFTF9URFhfR1VFU1Qgc2VsZWN0
cyBYODZfTUNFLCBJIHRoaW5rIHdlIGNhbiBhbHNvIGp1c3Qgc2VsZWN0DQpYODZfTUNFIGZvciBU
RFggaG9zdD8NCg0KY29uZmlnIElOVEVMX1REWF9HVUVTVA0KICAgICAgICBib29sICJJbnRlbCBU
RFggKFRydXN0IERvbWFpbiBFeHRlbnNpb25zKSAtIEd1ZXN0IFN1cHBvcnQiDQogICAgICAgIGRl
cGVuZHMgb24gWDg2XzY0ICYmIENQVV9TVVBfSU5URUwNCgkuLi4NCiAgICAgICAgc2VsZWN0IFg4
Nl9NQ0UNCgkNCg==
