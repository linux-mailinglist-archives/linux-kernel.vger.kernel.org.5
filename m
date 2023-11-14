Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390E67EB39D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 16:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbjKNPb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 10:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbjKNPb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:31:56 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087C011F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 07:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699975912; x=1731511912;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vFm9T5Wug48Wd92oztk+xZ57LVbdWHcLueG/4R0t8jc=;
  b=PuPafFVtLvxCBpUBiaDzPzN/R+bBIKvogCH9YP+PxXvWZacTmj3WtC0i
   D5Oe2R4woQU2t7phtXu4oLu0jOKy/jdqNmvxcn8Ieg/VXMWx6wJoR8gB+
   +3cHKVjppIgesVD2FjkfjNtpIDLv57Y6tgeirqpbtZDHV4WHubTfHsWlg
   gww4IQALq4X7Fj3MPZm2iItiNAaCcErhT/0G7wiw+n1BFzwWj4VX1hmGJ
   +OIFPxyGThcphA122vSjqDyzXKHFE+ROYUzDL1/HnRpEOdqNXPXU4e+ON
   JkLIk+PVodguTBWv3+wDBwMZljwWXA4d4VHssWXgpbP7wLOzleS8xyVfk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="394593401"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="394593401"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 07:31:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="888281151"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="888281151"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Nov 2023 07:31:46 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 07:31:46 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 07:31:45 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 14 Nov 2023 07:31:45 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 14 Nov 2023 07:31:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EX9801ZUIsCnSKLNkOvnXa4wLxL29cYrVKtf5idIIpjKS2IMnVo4RKjtqpogs2eOuw5tTbPPVWq5o0Zpkcy2o3CfGL0egjmKQLV237T1MUMBirLm7M578lpYLW2AFDJ0EsKrSsshB0zzb8mT0H/GGn0Y7YeSXydDIhPXiB/i2veyrUO/c1/WVNT2vpMMZMIEDpoIRusn+J3zRgpMn2FuoCra8QFcwwfuADXapGpM1PxkTFRt+tCyRsbFDmOQVIdWFtRVbwOvoVms50RA0v0CBAffv3jyqtgkBA/4LX0oR71VQ/XCGgkYnUm4xQBTiQM/rHfgseNSWIPgR0cbNzFAAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFm9T5Wug48Wd92oztk+xZ57LVbdWHcLueG/4R0t8jc=;
 b=FGYDjhOIZjKyPnnNConu80v56ViaRHfllOgKQczsP/azwAQtzfxLygLSBDsMfksmZClE7wJrm1JNpXdOPE3oJ6/FEddXydMfySWMvRRzWktUX99HAJDB8JDKpeaLzJgBX/XPavEFIA0SzrUep30iG/nDmXBZz9+5j5VxjaCqfHSHgowS4S4axBCFxb2yfDMDXwrOzeFlcNqaLpTC7Ho0gYmVGK12dyLTwrUotjBCShecf1hViAprGE/HF8RIBrNdMVFtoCBQR4U9+DMyO5RB2bXRRiw//eKZTFnnZf8B/jjEcIPSDTuYOMZI753nNkgYXE5NViQvY1u9G38P5X/cvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 SN7PR11MB7973.namprd11.prod.outlook.com (2603:10b6:806:2e6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Tue, 14 Nov
 2023 15:31:34 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::d070:1879:5b04:5f57]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::d070:1879:5b04:5f57%4]) with mapi id 15.20.7002.015; Tue, 14 Nov 2023
 15:31:34 +0000
From:   "Teres Alexis, Alan Previn" <alan.previn.teres.alexis@intel.com>
To:     "ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>,
        "Winkler, Tomas" <tomas.winkler@intel.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>
Subject: Re: [char-misc-next 3/4] mei: pxp: re-enable client on errors
Thread-Topic: [char-misc-next 3/4] mei: pxp: re-enable client on errors
Thread-Index: AQHaFwMFEhJhnau7g0KvfxNFJWcULbB58UMA
Date:   Tue, 14 Nov 2023 15:31:34 +0000
Message-ID: <ade96d9edd8bce1bc63dba4e2f1a92517180d774.camel@intel.com>
References: <20231011110157.247552-1-tomas.winkler@intel.com>
         <20231011110157.247552-4-tomas.winkler@intel.com>
         <ZVN9e3BczixJy_1H@intel.com>
In-Reply-To: <ZVN9e3BczixJy_1H@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.50.0-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|SN7PR11MB7973:EE_
x-ms-office365-filtering-correlation-id: 2b74847e-590f-4318-2ebc-08dbe526c90b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /+1cA73TKzK9pz6MwPFGk3IM8PTPyj9XTWxe8dR8Gxx0n5N8EXDf36EvcgI6PtDl9+/0XRWZmzN3tMLTPH9NZZGuYpyqGo0rM7e7/zYC8kBI19E62oN+u1JRHF2pKQonlz+GbqOpeLqXQf8iCu8OK3xmLkJv6roCG9Y1GRh9b30SUNymBIachvy5lTApa5BrS75qWktfxrFuKst/Na9R7VBTzyozh0b4LEEvK0ckHyWWE4QVKx7XVvzq0UviB7/rcS8vSTjynMDkbtC8s0iPcI1unr7C4wOw/e4sOjsQ+97UnDqDdlimRsZ98RevdJYENCQmIoE/dw+AF5JAvukFSBMwAebwpx3TzMoDieDiy4mhiiu6kLwY88o87lF9N3FOKKlC8XQculo2R7YuwdjPLkdcCNEmXyeMox5Qh5EDstfrnh7JELnSdbI7K6Z+VEg/8jhnzTWfmEiiB2+IXDMAPcRW4k5hN5Tf/w3azRWNyk6X1b0ge2JyDZtpHqt3lkuzyZhI4WF1mhZuEOXvIdjr7tYRmAeFmhaZ575FYYkPMSGhGjlRthAuTX2fv0GuczAXiIaKAqJ5IIIDYXFIqJJ8v+PRgk0nw1f9vI3hy8+t6LSzfgs+89R/oSyvz98t0cIP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(376002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(66946007)(83380400001)(26005)(6512007)(66574015)(6506007)(110136005)(478600001)(4001150100001)(71200400001)(6636002)(64756008)(54906003)(76116006)(91956017)(66476007)(66446008)(8936002)(66556008)(316002)(41300700001)(122000001)(36756003)(86362001)(38100700002)(82960400001)(2616005)(5660300002)(38070700009)(6486002)(4326008)(2906002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1JOdWZXMjRScDJGM1NNY0V0ai9wU3VnY3RxeVllQ281b0kxQXdzUGsvUjE5?=
 =?utf-8?B?YytTZ2xoWGNsSVdWZFJBS28vTmc5cEc0V1cydE5iblNwVitlOVV1U3FOVlJH?=
 =?utf-8?B?SWEwQzZaN3JDcU9hUndJMlA0NElGdk5RYnZPRUt1Zkh0N3lkcGZFcE9GTUVD?=
 =?utf-8?B?T0IwQWF3MXk3dTY1bDFQbFQ0UlIvak40TGtJYlFsdnYyVGROWkJWOFBldEpJ?=
 =?utf-8?B?TXNQOFBQckxTdFF2cUZqVGNROERXUy9qeHZwKzFIZFJHQ1lKMUpVOE1pOW1s?=
 =?utf-8?B?dFdhSWl0WWZJV2VIVmZhem9QZTViMzk1UEp2aGxWYUJST3dHOU5EdkU5NDlq?=
 =?utf-8?B?bzJBeVkxU1NMZ3ZFTnhiMHlUNUV6aXNVWGZJN25oUkhMbVh5WU04eHpSQmdp?=
 =?utf-8?B?aFZ6VGxJU1BiUkRDcy9ZMmFOS1dhRlZOalNJd1VSMnR1T2czZVd4SHQxVFlz?=
 =?utf-8?B?aGdjSDkwWXY5Y1pvZ0VOV2txM1NPR2JiWkxyTjh0elFVWnI4RGFDc21UQ3VV?=
 =?utf-8?B?V2plTXIzZ0NKSEo1UnN6WGhKbkx4YzVWUjZEaER4dXJaaXRYdDlhK3lrM01z?=
 =?utf-8?B?dlh2WnF5ZlE0Lzk2MmhheVdseFRtOFRLbWFqZkdPRklFdDlJdjA1ZWx4UmZQ?=
 =?utf-8?B?ZVJuS1NrbGtMZXVpYlJMNUNmcFRuYkZ0TXJ0ejJxQmVpcVN3SmFQajlYY09Y?=
 =?utf-8?B?NVlQbXNpUWJDcVRzQmg1blMxSnlGWVlRRkprNFQ3SVg0aGtneStzN0NmaEVT?=
 =?utf-8?B?LzFmclJUTlAwUUZOckFlc1I5QnhscWFXbDdRU1RPNXo0T1VpTXByQkUxR09q?=
 =?utf-8?B?azVuUko0SHVibjBSOW5PZ3hPOUNRendnUkl6UHEzMmZNWVVJR1pyQWxWNmk0?=
 =?utf-8?B?TVl6SlVmN1ZjeWNMdDZZUXc4YVpOeC9yYmxiUXZ3Mk13UEQ3aktNMFRCanY0?=
 =?utf-8?B?RzVQMUxDTU5ZbGdmUWkyYkJraTBXRTMwQTEwejBjMWk2THZ2YmkrWkRmS2hr?=
 =?utf-8?B?Q1ZUa0s4Z1ZwVFFhNWNVY0UrajVPMnNaT1hjek1EaTVzdDllRnZWQ1VQWFRw?=
 =?utf-8?B?NWJUZ0tTVHVkUis2SzVNMXloUXJXbmxjS2hyNjZtYXBOVjYydUlWeWJ2OEVB?=
 =?utf-8?B?SVNPdU1haGRGcm1UR3ovak1OWkJFWW1tWkZGR3FxSk9mcGM2RWcrTjl0U2hD?=
 =?utf-8?B?NzgvYkpkb2J5Vk9IVXQvdGZBL1ppRmJlL1lJOVRSNE43NEwyYjYzdTYrWHpV?=
 =?utf-8?B?OXF3UitkSlVBUzlDYjVXNjF5U0hYbVREWTQweXgxeXMrUkpoMDZSWCtTQzh1?=
 =?utf-8?B?MkFIcnFCU3VESE5tbWxVSy9pc2RkOFdpOGZCL0FHQTNCK3AwNGZ6QnJ5WlJK?=
 =?utf-8?B?R2FTM1QxWFcyRDVEb1BLM01Qb1I0SEVkNFpHMkZ2bzRJRDJReW8yUGI4ekcv?=
 =?utf-8?B?bjRJanJKbkU3YzhqT3ExQTVYbW1UNG4vRVVoQk5kN3hYa1MvY0xtVmhxNFV4?=
 =?utf-8?B?YU5zNDU0cFkxZldPMDNGUmpOLy9rbWh1LzFjQ3pQK1Y1dVhWL3d2ZFM1Q1pw?=
 =?utf-8?B?akJQbHZZcnBNM0U4aUFkWEFGbUk4RUdWQ3ZtWHJWekFac0Fhek42THRoMkxi?=
 =?utf-8?B?c045aFZvUEZ5YnZXZTNJeUt0RllLdncvbStZZVNKekJ2UVFoakNNb2tEZUZv?=
 =?utf-8?B?NnNhZ2ZQT3JZY3lWVjk0NDhuVHg3dDh2RzRGR2M4aGFSamtueG5ud2w3V2hR?=
 =?utf-8?B?dnFLV0pucmJwMUV0eXY1dGF0UGFScmsyaWtFUVA4Y2VNODNMNkVZb2pmcVR6?=
 =?utf-8?B?MS9kUkxvdk1IZGhVOG5qeWE4dkdFMm10ZjRRYTM1VzJGa1VSSDJCd3hVTzRG?=
 =?utf-8?B?NnZPUGFOZFJBcDZqM2VyTEJtQjA5VW1ybDJJMU1UK05jc3oyU1VpNUZZL2x1?=
 =?utf-8?B?WHg2Tkd6eWtyYjltbUxPY21EWm16WTh1bTRoWTIyNW83NlY0WFJ1Qmw3SmlQ?=
 =?utf-8?B?THFEYS9NU1BwSHlyL2ZMbEwvVTlna2tMWDQvQ2lrZlF3NUtleHVmcVU0cGpI?=
 =?utf-8?B?eHhSWkpRZzRxNENmaitwdTJSK1B5dzhyVE9SeWhWTEUwSGd1U09aV0NyTEpp?=
 =?utf-8?B?Q3pOamZCdFJxazhqQTRvUWdDOVFJc3VVUy9rR1RMR09lMEo4UDhmZFhzUFpZ?=
 =?utf-8?Q?6pkh+pIXGSDo/y7HvqoWR2c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <83CC621024AD05418FAE345347E7993C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b74847e-590f-4318-2ebc-08dbe526c90b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 15:31:34.6987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0hJq0OS5hgA5mupnPAVIDobmpWLenwk4B2mL3rApBlUpdiQ54OyBpBOhwEKCL03RGWt3n+x9v1RwLICw17PmjkP/8Q+A/PjZPtJEBxM6WwM8Kps2uKC3YULpMOXHrqd3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7973
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

T24gVHVlLCAyMDIzLTExLTE0IGF0IDE2OjAwICswMjAwLCBWaWxsZSBTeXJqw6Rsw6Qgd3JvdGU6
DQo+IE9uIFdlZCwgT2N0IDExLCAyMDIzIGF0IDAyOjAxOjU2UE0gKzAzMDAsIFRvbWFzIFdpbmts
ZXIgd3JvdGU6DQo+ID4gRnJvbTogQWxleGFuZGVyIFVzeXNraW4gPGFsZXhhbmRlci51c3lza2lu
QGludGVsLmNvbT4NCj4gPiANCj4gPiBEaXNhYmxlIGFuZCBlbmFibGUgbWVpLXB4cCBjbGllbnQg
b24gZXJyb3JzIHRvIGNsZWFuIHRoZSBpbnRlcm5hbCBzdGF0ZS4NCj4gDQo+IFRoaXMgYnJva2Ug
aTkxNSBvbiBteSBBbGRlcmxha2UtUCBsYXB0b3AuDQo+IA0KDQoNCkhpIEFsZXgsIGkganVzdCBy
ZWxvb2tlZCBhdCB0aGUgc2VyaWVzIHRoYXQgZ290IG1lcmdlZCwgYW5kIGkgbm90aWNlZA0KdGhh
dCBpbiBwYXRjaCAjMyBvZiB0aGUgc2VyaWVzLCB5b3UgaGFkIGNoYW5nZWQgbWVpX3B4cF9zZW5k
X21lc3NhZ2UNCnRvIHJldHVybiBieXRlcyBzZW50IGluc3RlYWQgb2YgemVybyBvbiBzdWNjZXNz
LiBJSVJDLCB3ZSBoYWQNCmFncmVlZCB0byBub3QgZWZmZWN0IHRoZSBiZWhhdmlvciBvZiB0aGlz
IGNvbXBvbmVudCBpbnRlcmZhY2UgKG90aGVyDQp0aGFuIGFkZGluZyB0aGUgdGltZW91dCkgLSB0
aGlzIHdhcyB0aGUgaW50ZW50aW9uIG9mIFBhdGNoICM0IHRoYXQgaQ0Kd2FzIHB1c2hpbmcgZm9y
IGluIG9yZGVyIHRvIHNwZWMgdGhlIGludGVyZmFjZSAod2hpY2ggY29udGludWVzDQp0byBzYXkg
emVybyBvbiBzdWNjZXNzKS4gV2Ugc2hvdWxkIGZpeCB0aGlzIHRvIHN0YXkgd2l0aCB0aGUgb3Jp
Z2luYWwNCmJlaGF2aW9yIC0gd2hlcmUgbWVpLXB4cCBzaG91bGQgTk9UIHNlbmQgcGFydGlhbCBw
YWNrZXRzIGFuZA0Kd2lsbCBvbmx5IHJldHVybiB6ZXJvIGluIHN1Y2Nlc3MgY2FzZSB3aGVyZSBz
dWNjZXNzIGlzIHNlbmRpbmcgb2YNCnRoZSBjb21wbGV0ZSBwYWNrZXRzIC0gc28gd2UgZG9uJ3Qg
bmVlZCB0byBnZXQgYmFjayB0aGUgImJ5dGVzIHNlbnQiDQpmcm9tIG1laV9weHBfc2VuZF9tZXNz
YWdlLiBTbyBpIHRoaW5rIHRoaXMgbWlnaHQgYmUgY2F1c2luZyB0aGUgcHJvYmxlbS4NCg0KDQpT
aWRlIG5vdGUgIHRvIFZpbGxlOiwgYXJlIHlvdSBlbmFibGluZyBQWFAga2VybmVsIGNvbmZpZyBi
eSBkZWZhdWx0IGluDQphbGwgTUVTQSBjb250ZXh0cz8gSSByZWNhbGwgdGhhdCBNRVNBIGZvbGtz
IHdlcmUgcnVubmluZyBzb21lIENJIHRlc3RpbmcNCndpdGggZW5hYmxlIHB4cCBjb250ZXh0cywg
YnV0IGRpZG4ndCByZWFsaXplIHRoaXMgaXMgYmVpbmcgZW5hYmxlZCBieQ0KZGVmYXVsdCBpbiBh
bGwgY29udGV4dHMuIFBsZWFzZSBiZSBhd2FyZSB0aGF0IGVuYWJsaW5nIHB4cC1jb250ZXh0cw0K
d291bGQgdGVtcG9yYXJpbHkgZGlzYWJsZWQgcnVudGltZS1wbSBkdXJpbmcgdGhhdCBjb250ZXh0
cyBsaWZldGltZS4NCkFsc28gcHhwIGNvbnRleHRzIHdpbGwgYmUgZm9yY2VkIHRvIGJlIGlycmVj
b3ZlcmFibGUgaWYgaXQgZXZlciBoYW5ncy4NClRoZSBmb3JtZXIgaXMgYSBoYXJkd2FyZSBhcmNo
aXRlY3R1cmUgcmVxdWlyZW1lbnQgYnV0IGRvZXNuJ3QgZG8gYW55dGhpbmcNCmlmIHlvdSdyZSBl
bmFibGluZyBkaXNwbGF5ICh3aGljaCBJIGJlbGVpdmUgYWxzbyBibG9ja3MgaW4gQURMKS4gVGhl
DQpsYXR0ZXIgd2FzIGEgcmVxdWlyZW1lbnQgdG8gY29tcGx5IHdpdGggVnVsa2FuLg0KDQouLi5h
bGFuDQoNCg0K
