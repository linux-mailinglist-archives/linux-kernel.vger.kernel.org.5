Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B64D7EEB06
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 03:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345557AbjKQCXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 21:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjKQCXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 21:23:02 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5854F1A5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 18:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700187778; x=1731723778;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Tip3OPS1gAw5anoiVlDZs2gCeGNhQioeAeJA+WsqdDY=;
  b=WE+K4+QUh79nouaJ/2JoVdVFXwP6WIdrr2PYWdoq2PgHXhkX5xyiUSKZ
   wh1Q4jVBLNb2S6WAVaXuaWAMUuHDUQUly5tt172tUGMhAUCfXA5X3oCNG
   17Xz6+LFBMqUwrKV6JM/Jw7rlabNBfxKOfjfcZ4sJWGwdggwdO3GqJWYY
   TNWKtVeHw11kYab/0hVSDUjDnEw/jUD+L9KX2QKeu8q6QVA9SemeMBiGr
   nhZ87FF4OMxgMZRh4ETWViVe/VUF75gMFRMI1vpqoV1D0NvV0Q0xgk/Q8
   4EkSu9AVGtUlwH5McPMKXheNHqQvognnhB0Wb3mor4bttnJNZwxxeA8f+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="4350671"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="4350671"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 18:22:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="1012795040"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="1012795040"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2023 18:22:55 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 18:22:55 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 18:22:55 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 16 Nov 2023 18:22:55 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 16 Nov 2023 18:22:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZloespxemTmAGvPbI6M1Ikd27vh5Hmk8Wn/9C+0mQAuzonLI01G4bTXA6b9n7J24miwVH2wwkNNlWli1l0PpyLFcAI163KM/TPJkhVLAReS4xyATMdPLMDJqTbp16Lnr+MEGUV/ZpQgBX4rbHBLBtwGUCRDeSO4HkjUWKnr3KrItfyO9latVwKdzx4OZC5KOYkzKJbivoz72qPje+9zyl0FYUVmaoylbfTQwPYXILR94aGbpjABasKRn05qf5W8rqCcymk/sFWfdYp7xTIaAhjJGbPtSaT6JP6D1qBob8jpZAeISjU6mnAaw6JpiRw8JX6ck81lin1nH3dCasGFRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tip3OPS1gAw5anoiVlDZs2gCeGNhQioeAeJA+WsqdDY=;
 b=SXR1mGNOtE5vDsD0Kim3vvXwYbOwPf9NscMHKsJt/IAPpyPOycjP4RydR3bVqgntck3h/dgQ6y0qtHIDLoms8hf9xcau/OI9RqWdpCxyXtAdW3BCArTKartcuMBC4SikjooH4LlkfKo2g71BeHK0FvtJXJUbNAu7ryfX6XkdluYrfmxBvfFmzGE5n80y5h5mplqKBn1GWlNEc4jHVFe63uAhkv1AVe/MjJeLILbPltCH38ekqW7K/9bPq5Zxwt4tUKyNoa8Y0YvHdog4XmWR07oNzHA1RquUthToMyCgOnnSGgTP4WO/+uI1zEIQBd0x3wEzRwsUZawcis6jDvsd6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB7002.namprd11.prod.outlook.com (2603:10b6:510:209::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Fri, 17 Nov
 2023 02:22:52 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7002.021; Fri, 17 Nov 2023
 02:22:52 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Disable PCI ATS in legacy passthrough
 mode
Thread-Topic: [PATCH 1/1] iommu/vt-d: Disable PCI ATS in legacy passthrough
 mode
Thread-Index: AQHaFpgBxWBJti3g4kChnloBJh6r1bB8ka6AgAAMNYCAARplAIAAFBTQ
Date:   Fri, 17 Nov 2023 02:22:52 +0000
Message-ID: <BN9PR11MB5276108778052CFA9BDAF3AE8CB7A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231114011036.70142-1-baolu.lu@linux.intel.com>
 <20231114011036.70142-3-baolu.lu@linux.intel.com>
 <0f8c95f3-c16e-497e-9734-85936ae08f82@linux.intel.com>
 <BN9PR11MB52761B8ECFC7A5724A61894E8CB0A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4643b52a-432b-48a7-9dcc-da5deead0a81@linux.intel.com>
In-Reply-To: <4643b52a-432b-48a7-9dcc-da5deead0a81@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB7002:EE_
x-ms-office365-filtering-correlation-id: 750d4aec-8c12-43ff-108a-08dbe71419c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: THLmFcECIwDNnV2xjmz4+//xxq4fqknQz6QXuxtiiiWtg3X6li9lwTMBm5o69h3RALc/GtqAFy7MyjmgTuvm183cfZHwTD4fhyIpYy7leJqZ7YX0Hq9pLBqR/c3PFd2H/YmC55gpQ6T7FgnFm/khDSsb/A7jWQVEuFZSaH9HYoRn36PovS/U44Vi0vJvUg++kAw4QY2zniwpuwbsceRe2eOUiGSTFmEsa5ric8PBsw60/hrJxfvkwXtuFAkhwQOEhx3V38HkddHWL5AKtfOog5Zy0t3Vfa8JzsqUwRAd8JtnEgRes2yfCaBK1YKxlm1uHR+kB536DyYev2u00rCkDiQPpCg7YMJtazfoFXSVC/L15DI8L76KEaet1loOdkXBRp8FMv9J6q8fZYrT8E6zXps2LczaQw43S1D6C4NWlBHi3xt1LR8hkt3scoerb5PyyuFLtgHYqdyjga+MM2NuYspW4v2gBF/P4a4/AXqXHXmP2+cKLjAzmAHKsWt4k0AFHMGTqgP27s/NOcm2pEAZ7U8p6kOHeBhCeDk1cjDafsYZNOu2vQV0ZUfZuakv4S8pNfqHElHt6V4M6U4dnukpYfo8+4AVBBCRVtyU/2VedktIvmjVvdQC8j6cgXnYldol
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(136003)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(66446008)(86362001)(66476007)(66556008)(54906003)(64756008)(66946007)(316002)(110136005)(76116006)(38100700002)(26005)(8676002)(8936002)(38070700009)(33656002)(5660300002)(4326008)(52536014)(2906002)(83380400001)(9686003)(82960400001)(71200400001)(6506007)(7696005)(122000001)(55016003)(478600001)(53546011)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUtaeG9uUHZIa3FVRkw1M3pMQS9QcVJ3MHFvWE91NU0xZlA1YmdjRXlGQUY4?=
 =?utf-8?B?WkFRcHFhU09JMVF6QmRrejN2WFNybFc4QzlGM09EUTlMdTg0enNqL1FaRVk3?=
 =?utf-8?B?NWdxNWtkSW9ld0hCeDA5RnVLZTBNekZGVHBTTURqZ3RDK05udTRxYVZUMWdE?=
 =?utf-8?B?VjNrNnhPQjByS21vYTFWREQ3R2JsS2pHS3lld2M1amIzbVV3dkxOeXNVZktR?=
 =?utf-8?B?cXlwWVhRQ2J2WHM2ek1UOUlsb1JHdlk1SnkveCtHNzFhM2dlSXIzQ2VKU3lK?=
 =?utf-8?B?RG93L21IUW9wU3RENE8vRXVxUVVuKzFLTTdCd3NrNS9TZmg0NzVWU3N3OEVJ?=
 =?utf-8?B?ajBOdDc1cUN2SXZUMGFWRTF0RHZGN2VwbjFuSnAyRnBUc1p5THlRRmUvRUd1?=
 =?utf-8?B?V3E0Mmx3M3VGWjZFcE9TekZLVkZOdi83SkV5d0w3NGpMMHJzRjFRaHRMUlRp?=
 =?utf-8?B?SmlmaUk1djB5SnYzY0JuZFJQWmFyVGkzcDIvbVdBeENtdUxnNWJwQWN1VExz?=
 =?utf-8?B?cUV3dEo3RE1tL2pQYWJRVUwwT2t1a0U3NXhvM25VVnI5RGhCV2szSkkxMVNw?=
 =?utf-8?B?Z1pXdGNSWm9EamFIOWFEZXZPbjZkN0RKOHFDb2NtTmgwOHllSnZuaXJyQTJM?=
 =?utf-8?B?eVU1WFNaL3V1b2NCb1VFRlY0eklEbmhxOE5NdTc3ZXVZSlZ6RCtsdmxMSjQx?=
 =?utf-8?B?aXljVHMrTStabmxmQTYralorUjA4b281dWJYWjIrbGlWNmg4Q1IvdVF6NXIy?=
 =?utf-8?B?a1liUGVJMmIwZDVneGh2OWo3eVRrTWhuQkdCMVFFeW5DSThEV3VyWTJmblJk?=
 =?utf-8?B?cTNpMGRRam53MFZ3M25XQVpRWTgxK2tDaEIvRDFyQWtNUFE0YU1US0p2WlJ4?=
 =?utf-8?B?Wmc4ZnJiMlp0Qk1OSWxjcGxtbC9BMFVQYUJVNEJhTTV5UXZFcENJS3ExblF3?=
 =?utf-8?B?RTlsL1FGRUlXakw2bUlYSjMyamQvSDlXRjE5bDVwZ2g1Y21obVVIeUxUSDZz?=
 =?utf-8?B?WFBCVFhPQWRaQVpVakV0YlNCTkVWVGJzdU8rUkZOY0ViV3BEbnVDamI3S3p6?=
 =?utf-8?B?ejBUTnBIeDZPdUxVYzl5eFk0S1JieDJqTnpBN2tnZFBXeTludktuS3pqQ3Rv?=
 =?utf-8?B?R1JqNzh6WXp4eEVsS25DdHI1MkRLVWtQMlEwZ0txUWIzWEFJNUdqWklCS0RG?=
 =?utf-8?B?WnNOQlQwcmI5YkE4TVF6TGZXZloxNTArWlhVelM2dkwwSHBKeCtDMFB3YzhG?=
 =?utf-8?B?RGtOSnRsMUxDZm5NV1pIOVNWUVczS09Mc2FSa01zVDdCeGdLaEptMXdaUXJF?=
 =?utf-8?B?WU43d3NVb0lkcTNpWHZtNzZwM1dWOHc5c2xNR280enZ0UEt5aEpzcjBlUTRU?=
 =?utf-8?B?TE9ScVZIWEVXVDJIa3J3NCtwWkhadktBdmNtTU9QcGxjQmE4dXcrM2pSME9k?=
 =?utf-8?B?bEIyU2xEZ2xqbEUrMmp6Uk9RYktQY2dsY1RvTzBEZTUvYkZMU2YzdGFQS3Bs?=
 =?utf-8?B?YVB1dW5oN0ZCQVg1L0h3WHVSbHQ1TzRibWZhYzA4eDU2cDdyQ0xjT1BYVDhG?=
 =?utf-8?B?Zlc4VmNBOW9wVDJvajQ2dHhtWkNWdlNnUUp0ejNqc1BvSm5TcnBHLzJZZW9X?=
 =?utf-8?B?NnpNdzN5M1VKMFVPVWttQXgvQVJ3ZnNvQmt1aU9RZVdxZVB6WitmaTFKY3R5?=
 =?utf-8?B?aXB6eFFES1JWMThCQnVReVQ0SkpuK1BuOE9BQ3dpKzNXYmVJUGNPT1dCOHlG?=
 =?utf-8?B?Sld3bktJVnlaaFVnbmdNRWQrZnE4SElRYTdVOVQ0bXNSQWFjRHE2am44U1Mr?=
 =?utf-8?B?c2d5cWlpNFFVcmVMcWtiQ1RPZE1ScVVyc00xeWJpU1hIRUJPRUowSCsxdlNM?=
 =?utf-8?B?ZHpFNXBtTUl6L1FDMEJPdWE4aVN2dFBVMlFXbUZmNjAwZm9FcUJTK2ZUTENo?=
 =?utf-8?B?NDdSOUU1K1dHSzhSeEVpcWlhcW5RL3NYZ2lBVjlaUEMvWEI3YmlYU3hJMG5O?=
 =?utf-8?B?M3l0UFc2TnMyNnFJNjZmcTRBR2hMcU5jWlBnQ0hGQmJ3bjFkQVBLR003dTN6?=
 =?utf-8?B?RXc2VTBFSk9mR1hkdCs5VmhXbFBNQm0xTGhPR1dYbjNzWkJsZ1l0KzU2NDVh?=
 =?utf-8?Q?Ra0SJWGj/5MYy9nb7ojwPUwZ5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 750d4aec-8c12-43ff-108a-08dbe71419c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2023 02:22:52.0581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uXl0S0FAbhk2LjuarSaDK/TTpeuMbox5Ys6bLP/L1OZ0UMuvT3TEZ47seYa8l0SYXSXrjQn5ZPL6oGM0/iBK/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7002
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBGcmlk
YXksIE5vdmVtYmVyIDE3LCAyMDIzIDk6MTAgQU0NCj4gDQo+IE9uIDExLzE2LzIzIDQ6MjQgUE0s
IFRpYW4sIEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXgu
aW50ZWwuY29tPg0KPiA+PiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgMTYsIDIwMjMgMzozNSBQ
TQ0KPiA+Pg0KPiA+PiBPbiAyMDIzLzExLzE0IDk6MTAsIEx1IEJhb2x1IHdyb3RlOg0KPiA+Pj4g
V2hlbiBJT01NVSBoYXJkd2FyZSBvcGVyYXRlcyBpbiBsZWdhY3kgbW9kZSwgdGhlIFRUIGZpZWxk
IG9mIHRoZQ0KPiA+PiBjb250ZXh0DQo+ID4+PiBlbnRyeSBkZXRlcm1pbmVzIHRoZSB0cmFuc2xh
dGlvbiB0eXBlLCB3aXRoIHRocmVlIHN1cHBvcnRlZCB0eXBlcw0KPiAoU2VjdGlvbg0KPiA+Pj4g
OS4zIENvbnRleHQgRW50cnkpOg0KPiA+Pj4NCj4gPj4+IC0gRE1BIHRyYW5zbGF0aW9uIHdpdGhv
dXQgZGV2aWNlIFRMQiBzdXBwb3J0DQo+ID4+PiAtIERNQSB0cmFuc2xhdGlvbiB3aXRoIGRldmlj
ZSBUTEIgc3VwcG9ydA0KPiA+Pj4gLSBQYXNzdGhyb3VnaCBtb2RlIHdpdGggdHJhbnNsYXRlZCBh
bmQgdHJhbnNsYXRpb24gcmVxdWVzdHMgYmxvY2tlZA0KPiA+Pj4NCj4gPj4+IERldmljZSBUTEIg
c3VwcG9ydCBpcyBhYnNlbnQgd2hlbiBoYXJkd2FyZSBpcyBjb25maWd1cmVkIGluDQo+IHBhc3N0
aHJvdWdoDQo+ID4+PiBtb2RlLg0KPiA+Pj4NCj4gPj4+IERpc2FibGUgdGhlIFBDSSBBVFMgZmVh
dHVyZSB3aGVuIElPTU1VIGlzIGNvbmZpZ3VyZWQgZm9yIHBhc3N0aHJvdWdoDQo+ID4+PiB0cmFu
c2xhdGlvbiB0eXBlIGluIGxlZ2FjeSAobm9uLXNjYWxhYmxlKSBtb2RlLg0KPiA+Pj4NCj4gPj4+
IEZpeGVzOiAwZmFhMTlhMTUxNWYgKCJpb21tdS92dC1kOiBEZWNvdXBsZSBQQVNJRCAmIFBSSSBl
bmFibGluZyBmcm9tDQo+ID4+IFNWQSIpDQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBMdSBCYW9sdSA8
YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiAgICBkcml2ZXJzL2lv
bW11L2ludGVsL2lvbW11LmMgfCA0ICsrKysNCj4gPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKykNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pbnRl
bC9pb21tdS5jDQo+IGIvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jDQo+ID4+PiBpbmRleCAx
MTY3MGNkODEyYTMuLmMzZWMwOTExOGFiMSAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvaW9t
bXUvaW50ZWwvaW9tbXUuYw0KPiA+Pj4gKysrIGIvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5j
DQo+ID4+PiBAQCAtMTQxMyw2ICsxNDEzLDEwIEBAIHN0YXRpYyB2b2lkIGlvbW11X2VuYWJsZV9w
Y2lfY2FwcyhzdHJ1Y3QNCj4gPj4gZGV2aWNlX2RvbWFpbl9pbmZvICppbmZvKQ0KPiA+Pj4gICAg
CWlmICghZGV2X2lzX3BjaShpbmZvLT5kZXYpKQ0KPiA+Pj4gICAgCQlyZXR1cm47DQo+ID4+Pg0K
PiA+Pj4gKwlpZiAoIXNtX3N1cHBvcnRlZChpbmZvLT5pb21tdSkgJiYgaW5mby0+ZG9tYWluICYm
DQo+ID4+PiArCSAgICBkb21haW5fdHlwZV9pc19zaShpbmZvLT5kb21haW4pKQ0KPiA+Pj4gKwkJ
cmV0dXJuOw0KPiA+Pj4gKw0KPiA+Pj4gICAgCXBkZXYgPSB0b19wY2lfZGV2KGluZm8tPmRldik7
DQo+ID4+Pg0KPiA+Pj4gICAgCS8qIFRoZSBQQ0llIHNwZWMsIGluIGl0cyB3aXNkb20sIGRlY2xh
cmVzIHRoYXQgdGhlIGJlaGF2aW91ciBvZg0KPiA+Pg0KPiA+PiBQZXJoYXBzIHdlIGNvdWxkIG1v
dmUgdGhlIGNoZWNrIGludG8gdGhlIGNhbGxlciBhbmQgbWFrZSB0aGlzIGhlbHBlcg0KPiA+PiB0
cmFuc3BhcmVudCB0byB0aGUgaW9tbXUgbW9kZSBhbmQgZG9tYWluIHR5cGU/DQo+ID4+DQo+ID4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMgYi9kcml2ZXJzL2lvbW11
L2ludGVsL2lvbW11LmMNCj4gPj4gaW5kZXggMTE2NzBjZDgxMmEzLi45YmRkZDRmYmJkZjggMTAw
NjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYw0KPiA+PiArKysgYi9k
cml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMNCj4gPj4gQEAgLTI0OTIsNyArMjQ5Miw4IEBAIHN0
YXRpYyBpbnQgZG1hcl9kb21haW5fYXR0YWNoX2RldmljZShzdHJ1Y3QNCj4gPj4gZG1hcl9kb21h
aW4gKmRvbWFpbiwNCj4gPj4gICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPj4gICAg
ICAgICAgIH0NCj4gPj4NCj4gPj4gLSAgICAgICBpb21tdV9lbmFibGVfcGNpX2NhcHMoaW5mbyk7
DQo+ID4+ICsgICAgICAgaWYgKHNtX3N1cHBvcnRlZChpbmZvLT5pb21tdSkgfHwgIWRvbWFpbl90
eXBlX2lzX3NpKGluZm8tDQo+ID5kb21haW4pKQ0KPiA+PiArICAgICAgICAgICAgICAgaW9tbXVf
ZW5hYmxlX3BjaV9jYXBzKGluZm8pOw0KPiA+Pg0KPiA+DQo+ID4gSU1ITyBib3RoIG9sZCBhbmQg
dGhpcyBuZXcgdmVyc2lvbiBhcmUgY29uZnVzaW5nIHJlZ2FyZGluZyB0byB0aGF0DQo+ID4gdGhl
IGNvbW1pdCBtc2cgdGFsa3Mgb25seSBhYm91dCBBVFMgYnV0IHRoZSBhY3R1YWwgY29kZSBkaXNh
YmxlIGFsbA0KPiA+IHBjaSBjYXBzLiBJdCdzIGNvcnJlY3QsIGJlaW5nIHRoYXQgb25seSBBVFMg
aXMgcmVsZXZhbnQgaW4gbGVnYWN5IG1vZGUsDQo+ID4gYnV0IHRoZSByZWFkYWJpbGl0eSBpcyBu
b3QgZ29vZC4NCj4gDQo+IFRoZSBmdW5jdGlvbiBuYW1lIGlzIGEgYml0IG1pc2xlYWRpbmcsIGJ1
dCBpdHMgYWN0dWFsIHB1cnBvc2UgaXMgdG8NCj4gZW5hYmxlIHRoZSBBVFMgZmVhdHVyZS4gUEFT
SUQgaXMgZW5hYmxlZCB3aXRoaW4gdGhpcyBmdW5jdGlvbiBkdWUgdG8gYQ0KPiBzcGVjaWZpY2F0
aW9uIHJlcXVpcmVtZW50IHRoYXQgcHJldmVudHMgbW9kaWZpY2F0aW9ucyB0byBQQVNJRCByZWdp
c3RlcnMNCj4gYWZ0ZXIgQVRTIGFjdGl2YXRpb24uDQo+IA0KPiA+DQo+ID4gd2hhdCBhYm91dCBp
bnRyb2R1Y2luZyBhIGhlbHBlciBlLmcuIGRldmljZV9kb21haW5fYXRzX3N1cHBvcnRlZChpbmZv
KQ0KPiA+IHdoaWNoIGluY2x1ZGVzIGFib3ZlIGNoZWNrcyBwbHVzIGluZm8tPmF0c19zdXBwb3J0
ZWQgYW5kIHRoZW4gdXNlIGl0DQo+ID4gdG8gcmVwbGFjZSBpbmZvLT5hdHNfc3VwcG9ydGVkIGlu
IGlvbW11X2VuYWJsZV9wY2lfY2FwcygpPw0KPiA+DQo+IA0KPiBJIGhhdmUgYSBwYXRjaCBzZXJp
ZXMgdW5kZXIgdGVzdCB3aGljaCBtb3ZlcyB0aGUgQVRTIGNvbnRyb2wgb3V0IHRvIHRoZQ0KPiBk
ZXZpY2UgZHJpdmVycyBvciB1c2VycyAodGhyb3VnaCBzeXNmcyBub2RlKS4gV2l0aCB0aGF0IGRv
bmUsIHdlIGNvdWxkDQo+IHNpbXBseSByZW1vdmUgYWxsIHRoZXNlIGFuZCBnaXZlIHRoZSBjb250
cm9sIHRvIGRldmljZSBkcml2ZXJzIG9yIHVzZXJzLg0KPiANCj4gSG93IGFib3V0IGNvbnNpZGVy
aW5nIGFib3ZlIGFmdGVyIEkgcG9zdCB0aGF0IHNlcmllcz8gQW5kIGZvciBub3csIHdlDQo+IGNh
biBtYWtlIHRoZSBmaXggcGF0Y2ggcXVpY2sgYW5kIHNpbXBsZS4NCj4gDQoNClRoZW4gcGxlYXNl
IGFkZCBhIGNvbW1lbnQgZm9yIHRoZSByYXRpb25hbGUuDQo=
