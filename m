Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AD876B39F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbjHALpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjHALpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:45:18 -0400
Received: from mgamail.intel.com (unknown [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE6DC7;
        Tue,  1 Aug 2023 04:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690890316; x=1722426316;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/e3SLzyvqweFeEb5AgkH3Sobn16O6DVGaoUUeUsiSyc=;
  b=gDEFSmaw9kXd1oTbdgH3FibWqHwtNxZH17DxSI041KHblBWxXd76QGxI
   v3OhuGinOY1jhWuPryMqqcP+5ccdihXomG39TesksmbpVVse9pyD1DbWk
   eGU8zAlUUR/MBuJjaLEg/l0y29eLa0fbOXaBZm9BsWlo0fCPFzk7oIkb9
   KdWEvMZVXHWygNLMl0/H6eDWmi3WR0E+SqLiVbQG+0woQstM0c/zcLuAC
   nZ7Qo3xSAucqLTpnG3SY0XYOFvFmSz7F/njbLd3fwP9n86o/+8NwC7Kvg
   fQO1fT7KX3e8XIxt+58qKkK2iNN70QTm+jryWe1EW4gFSEy1uSIOdNFiM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="359321471"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="359321471"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 04:45:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="728662363"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="728662363"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 01 Aug 2023 04:45:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 04:45:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 04:45:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 04:45:14 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 04:45:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImCtkqFmGo5raBqruHpvLIiEHfvL9fP0Q0YiG6J6K0jYtX7SyuDBIbP/T/z2x53+E4qpiJ7TcMExcTL1ZSnVT8PsOGT8Sz3uN3EyYmqKt6hTNuInWzxghsUrfweq+y8VyjjKMR1nUAnKPpuk9As0xxQ9g+0gi8RaQSCElLc3No7o38771hZvy5BMY7/pBAYkddeIXreLccYBFGUpNgHtebek8Gij+OVUH5w0QmRA9xQ/xogQfE2hzYyuY5g1GJWfJzqrjc7vAJ8QFHWpDdosoxEReCzFuLwBw3Au44L5fnAJqDb/LtDM98ciMolvjeiGeFTDVUBYvtI478c4ZFtHng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/e3SLzyvqweFeEb5AgkH3Sobn16O6DVGaoUUeUsiSyc=;
 b=N2C1BswRBGeQud5cvCv1+8k6SmSP6cLTy8rJxrmoLvpcdMxdZ4VQiSDRUg/D8OEydJHIUcS5k8roOOe9oQ3QrvvgEjyCDAQz3NV/Gb/2SKETfn/6PCHi7adpbaJQJCC37XJUJ4a9xqSzfiph0CULwIhQR7nDSclbOrOYB+zWdi2z2qDjAquW/xGR8Gg/RktD1ZGUgDL8tZ+rRiEapQh3+sOZFinB0B87QhJidf89qxWvIB+iWDKnhfI/vxk3hHLI6F0NYAMkFi0oN23alAqNPIlnTV5jXFRCBfAO5m5MvA++vdBYC8ef56lka3FA9qbTeOW1LxVkGwAARx2qh/PzKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH0PR11MB4965.namprd11.prod.outlook.com (2603:10b6:510:34::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 11:45:12 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 11:45:12 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>
CC:     "sameo@rivosinc.com" <sameo@rivosinc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "dionnaglaze@google.com" <dionnaglaze@google.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 0/4] keys: Introduce a keys frontend for attestation
 reports
Thread-Topic: [PATCH 0/4] keys: Introduce a keys frontend for attestation
 reports
Thread-Index: AQHZwYoTw9Njl1TosE69WJRoUv/G3a/RDr0AgACyhACAAIcTgIADD9cA
Date:   Tue, 1 Aug 2023 11:45:12 +0000
Message-ID: <6dec442c64faf2fecd21bcc77e4a6350e88948b9.camel@intel.com>
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
         <a507ef3302d3afff58d82528ee17e82df1f21de0.camel@HansenPartnership.com>
         <64c5ed6eb4ca1_a88b2942a@dwillia2-xfh.jf.intel.com.notmuch>
         <c6576d1682b576ba47556478a98f397ed518a177.camel@HansenPartnership.com>
In-Reply-To: <c6576d1682b576ba47556478a98f397ed518a177.camel@HansenPartnership.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH0PR11MB4965:EE_
x-ms-office365-filtering-correlation-id: b8c58da4-d8b4-4abb-b515-08db9284c404
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cMMGhLmRAFhpmnEL8WYE5Zpqlqf/IdhFgiw4H/577fsAXkyPs4hN6HzvFywxqDUdzWY9geHkuKYgKtrCp3cYGzlzuNkU5CgFPCUQuNAtHvcnF4f+rqOReYAs74RRrkjFzZ3jEL1CDlQqwl5k0V1zOmWssGiJUkvnvWsQYhNJs8bS92+tO5OcibNM/bRbS8mzVOIzad7dALKduqAbnG3Dh3pZfVYvEw7oFrjD5bcmM84zl+9dkjrb4yXF42I3/JUvVazHAJ3YEdo9IRUWlbtNQ7IubNNrmAvrbngioFVNt67uaQCc6wNn6O+KpkJ2/+jGozUZGf+7MzKD9YKscDJW0XPCZJDpoX0jcJahs1GPw147PzRw276fwod1/4u/ilkJQs9Q9i6oApjv50L4zyODBvmLz8nu+0ZCzhTVG6CJ0DGI5/6xhojC4g3pXnieLzG07RW63y4VP4qc7ajMGbhofMzzWh5ClDgg2glej04Hg4/QrXg4J+pXy4hdfjy15DI8MItnHA9lAgjrlOoKqfwYfeC0pmZ+swI+LYxkPjYZ7Bdtu8nZsuYWAUJGoP71i8F5gF36wfUuAQaNL99XQ6SjCrnbGULvtmYrm0KcrH4r2QQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199021)(38070700005)(8936002)(8676002)(36756003)(6486002)(41300700001)(478600001)(2616005)(2906002)(83380400001)(26005)(316002)(186003)(86362001)(6506007)(76116006)(5660300002)(7416002)(38100700002)(122000001)(966005)(91956017)(6512007)(54906003)(4326008)(110136005)(66446008)(66556008)(66476007)(64756008)(71200400001)(82960400001)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bytPdjh5eGxnSzVDYkY3Ujdocm5rdzhGUURDUEdNYm9PRnVvMU9hTlQ3Rng4?=
 =?utf-8?B?QytUYTVTdjEra3RxMk9lLy9lMnkxelBWd0NwN1VreE1QR3FZeTRndUZudnM1?=
 =?utf-8?B?RHR3TmVsMkNxZGdjM0pSeDdOcDBieHlFeUw4YlFSTUNvQjlTeU9pcGs5eWpo?=
 =?utf-8?B?WFZJVTBPbnJaTmdrZmNCQ2JWUTBzK1dyTmlzYnd1QTZGRkt0OHBhR1NuYVRV?=
 =?utf-8?B?SndCV2tvdkVzN1NJMkNZZEx2NXh4TWIvRmliNDFoUVA2NGViaVVPTm80cTJp?=
 =?utf-8?B?Q3RrU29qOHVnTTNZTG9yZDdOdmFid0Z4SWVNcFZvWjRvcEJ0REhMSmhpdzEw?=
 =?utf-8?B?SW0rckdNakZVT0N4ZlBrQnpSSXdQYWh2TzVYUllrZEo5VVJ0OTZtYzVjQ0sr?=
 =?utf-8?B?ZU1CTFVVcitiRGlmVXYza1ZXZTE5WGNtazlNZUI2SFQ3NWVqU0RINWJwZlpK?=
 =?utf-8?B?RmVYdy9uQU84MUFkNFhpM1kvV3V0Tzl6bzZBQnl0dGhsRGZOSXBBSXFKWmJ0?=
 =?utf-8?B?VVpIQ1pPUmUvUGNhZzloWVFXbmFDbS9ZMlhIaFpYb2t4SWJQd3FyZVV3UDls?=
 =?utf-8?B?V3RQVUlqM0pHWVgzRExmQ3BTa0ZHSmJ2THJWOERhZUtGd2hwUVExZDFKNGo0?=
 =?utf-8?B?UDNtaytjclNBOWJWbW5uQm1OVlczM3FOYmRRdTlLSzIxUTRUMFVkRWFXdThm?=
 =?utf-8?B?QTRDSlNlU2VsaUg3N1k4YUtjTFMyZ0Z1cHczc1VHcTZic1JJOGRVbkF4WmV2?=
 =?utf-8?B?dmxWNmhUNFp4VE0xcTZBRVptYWsxckx5TytTR3FVem1LcitwLy9rdGxHTVJ2?=
 =?utf-8?B?NkVuTzV0SjVKQ1RUK0E3QjNiTloyUTI3UFpvMUt5MVhjem45eUJIeFV2N3Ny?=
 =?utf-8?B?MCtOTmJ4L1c0ajZTZ0FwNTJrUXFMR1VaVUpuZWZEbURKL0FrU05lTVVMUkRO?=
 =?utf-8?B?aFp6MlZtNmw5cVZkc1l1a2Rjd2FFbE95NDJ4bVlOR1p1enZBYXJzdHF3bCtU?=
 =?utf-8?B?S0oyTnFmVEltRisyUE11MFloemFTcHMvTjQ4WmZESUdNTVJxWkduY0tDTVdq?=
 =?utf-8?B?Y1VISWtQcEU3NXc4U2FyV241bW1yNVdKZVpSMTBtS0FBaHcwVk4yRHYvOTAr?=
 =?utf-8?B?V0d1a2FBY2phZFJzM2E0Um5HRFJrdHd0cGZFZG9GczdmZmVMRjg0NEdrdnNF?=
 =?utf-8?B?WlJJY2hNRnI4OGdBRVZtY083QWZRNFIrbUtMb0pUSmlXeFROTlAyRkVSa0dU?=
 =?utf-8?B?SFhKRzRSU0dZcGNGL3VEZWhlZDVaaHJ0aFJrNXJiOXZJL2t1YWR5NW9xbTNI?=
 =?utf-8?B?TGsvbVU2cVEzUnMyazFQa2VDcHpqVFE2YzNXdk95Zno1YVFpbTlTL1UySUdl?=
 =?utf-8?B?LzExNmxHOGRJT1grOHlOV1k1M1JtR2FtTlU5SEg3VEFOK2ZPMnlTVjFsTDlp?=
 =?utf-8?B?OFdkV1B1cHN6RFgrLy9UenNNeDJkL2hxZ1duUTZNSVNBQ1drNHhudkh2QzlU?=
 =?utf-8?B?Wnp1WkJvTUUwdk9sKzVwVDhEQXI2dk1UaTRTakpZVVFzYkRDY1k1eXdKdEJR?=
 =?utf-8?B?SHN2VzBFQ21lWW02SkJDZFJJWVFZNjlXUkhnSnhoaWJvclpyM0szMHc2T250?=
 =?utf-8?B?S3R4cTZWODR1QUdudTByWnBNbTlQNHZkVzlkc2NJd0xCN3hpdjQxT3dMS0JG?=
 =?utf-8?B?NktBbW82emt6WVlMV2RFZTl1U0VqaFgyeWRDR0I2cVYzVjhuUUcrTVBOcG5o?=
 =?utf-8?B?MkIyVHFocUpmbGl3QXRVQWY0TmVHSTJLT2oxMnBXaWdlYldrNEFlZEprd0tW?=
 =?utf-8?B?MXA0Q05iTUl2V0pIdzQ0Q1JVUFNEUGdzQlZmK3Q0RjBjSGRDS0UxK2o4djFv?=
 =?utf-8?B?Y0hGVVUvNmlUMVVDUHJjWjRXOEZHMU4zV1owRXNsemJyZEd3cVlKK2hDVTFr?=
 =?utf-8?B?QVZJd2hmRFhvN2VIZk9LdTM1U0RjRFVUcjBzY01oVWdXU2pDVlRLL2VRL05a?=
 =?utf-8?B?YVd2WEF6cWRCWVg2c3c3OWhla3o5cVNGSEZUQ0ZKdTBGYmNBMmFmaS9wVTI2?=
 =?utf-8?B?REFuVUk1T25CMzZYcHRmbG54Z0Y5RjZTdUZxYzR5cENKQ09ZTFRpWU1vNllJ?=
 =?utf-8?Q?HgY2h7dbhQtobLGgq6oGLQW+E?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF9F3009A50A234B8F989D27C3FEA33D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c58da4-d8b4-4abb-b515-08db9284c404
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 11:45:12.4475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CIN6LtDmASbBI7GEGF2pGie3HhJ+dLsrP5YENuJilPini0rT3JpISsVHnrPR2VFHfksZ4L7DvxiXgVlEBZMclw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4965
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIzLTA3LTMwIGF0IDA4OjU5IC0wNDAwLCBKYW1lcyBCb3R0b21sZXkgd3JvdGU6
DQo+IE9uIFNhdCwgMjAyMy0wNy0yOSBhdCAyMTo1NiAtMDcwMCwgRGFuIFdpbGxpYW1zIHdyb3Rl
Og0KPiA+IEphbWVzIEJvdHRvbWxleSB3cm90ZToNCj4gPiA+IE9uIEZyaSwgMjAyMy0wNy0yOCBh
dCAxMjozMCAtMDcwMCwgRGFuIFdpbGxpYW1zIHdyb3RlOg0KPiA+ID4gPiBUaGUgYnVsayBvZiB0
aGUganVzdGlmaWNhdGlvbiBmb3IgdGhpcyBwYXRjaCBraXQgaXMgaW4gIltQQVRDSA0KPiA+ID4g
PiAxLzRdIGtleXM6IEludHJvZHVjZSB0c20ga2V5cyIuIFRoZSBzaG9ydCBzdW1tYXJ5IGlzIHRo
YXQgdGhlDQo+ID4gPiA+IGN1cnJlbnQgYXBwcm9hY2ggb2YgYWRkaW5nIG5ldyBjaGFyIGRldnMg
YW5kIG5ldyBpb2N0bHMsIGZvciB3aGF0DQo+ID4gPiA+IGFtb3VudHMgdG8gdGhlIHNhbWUgZnVu
Y3Rpb25hbGl0eSB3aXRoIG1pbm9yIGZvcm1hdHRpbmcNCj4gPiA+ID4gZGlmZmVyZW5jZXMgYWNy
b3NzIHZlbmRvcnMsIGlzIHVudGVuYWJsZS4gQ29tbW9uIGNvbmNlcHRzIGFuZCB0aGUNCj4gPiA+
ID4gY29tbXVuaXR5IGJlbmVmaXQgZnJvbSBjb21tb24gaW5mcmFzdHJ1Y3R1cmUuDQo+ID4gPiAN
Cj4gPiA+IEkgYWdyZWUgd2l0aCB0aGlzLCBidXQgLi4uDQo+ID4gPiANCj4gPiA+ID4gVXNlIEtl
eXMgdG8gYnVpbGQgY29tbW9uIGluZnJhc3RydWN0dXJlIGZvciBjb25maWRlbnRpYWwNCj4gPiA+
ID4gY29tcHV0aW5nIGF0dGVzdGF0aW9uIHJlcG9ydCBibG9icywgY29udmVydCBzZXZndWVzdCB0
byB1c2UgaXQNCj4gPiA+ID4gKGxlYXZpbmcgdGhlIGRlcHJlY2F0aW9uIHF1ZXN0aW9uIGFsb25l
IGZvciBub3cpLCBhbmQgcGF2ZSB0aGUNCj4gPiA+ID4gd2F5IGZvciB0ZHgtZ3Vlc3QgYW5kIHRo
ZSBldmVudHVhbCByaXNjLXYgZXF1aXZhbGVudCB0byB1c2UgaXQgaW4NCj4gPiA+ID4gbGlldSBv
ZiBuZXcgaW9jdGxzLg0KPiA+ID4gPiANCj4gPiA+ID4gVGhlIHNldmd1ZXN0IGNvbnZlcnNpb24g
aXMgb25seSBjb21waWxlLXRlc3RlZC4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoaXMgc3VibWlzc2lv
biBpcyBUbzpEYXZpZCBzaW5jZSBoZSBuZWVkcyB0byBzaWduLW9mZiBvbiB0aGUNCj4gPiA+ID4g
aWRlYSBvZiBhIG5ldyBLZXlzIHR5cGUsIHRoZSByZXN0IGlzIHVwIHRvIHRoZSBjb25maWRlbnRp
YWwtDQo+ID4gPiA+IGNvbXB1dGluZyBkcml2ZXIgbWFpbnRhaW5lcnMgdG8gYWRvcHQuDQo+ID4g
PiANCj4gPiA+IFNvIHdoeSBpcyB0aGlzIGEga2V5cyBzdWJzeXN0ZW0gdGhpbmc/wqAgVGhlIGtl
eXMgaW4gcXVlc3Rpb24gY2Fubm90DQo+ID4gPiBiZSB1c2VkIHRvIGRvIGFueSBrZXkgb3BlcmF0
aW9ucy7CoCBJdCBsb29rcyBsaWtlIGEgdHJhbnNwb3J0IGxheWVyDQo+ID4gPiBmb3IgYXR0ZXN0
YXRpb24gcmVwb3J0cyByYXRoZXIgdGhhbiBhbnl0aGluZyBrZXkgbGlrZS4NCj4gPiANCj4gPiBZ
ZXMsIGl0IGhhcyBlbmRlZCB1cCBhcyBqdXN0IGEgdHJhbnNwb3J0IGxheWVyLg0KPiA+IA0KPiA+
ID4gVG8gZ2l2ZSBhbiBhbmFsb2d5IHdpdGggdGhlIFRQTTogV2UgZG8gaGF2ZSBhIFRQTSBpbnRl
cmZhY2UgdG8ga2V5cw0KPiA+ID4gYmVjYXVzZSBpdCBjYW4gYmUgdXNlZCBmb3IgdGhpbmdzIGxp
a2Ugc2VhbGluZyAoVFBNIHN0b3JlcyBhDQo+ID4gPiBzeW1tZXRyaWMga2V5KSBhbmQgZXZlbiBh
c3ltbWV0cmljIG9wZXJhdGlvbnMgKGFsdGhvdWdoIFRQTSBrZXkNCj4gPiA+IHN1cHBvcnQgZm9y
IHRoYXQgaW4gMS4yIHdhcyBqdXN0IHJlbW92ZWQpLsKgIEhvd2V2ZXIsIGluIGRpcmVjdA0KPiA+
ID4gYW5hbG9neSB3aXRoIGNvbmZpZGVudGlhbCBjb21wdXRpbmc6IHRoZSBUUE0gZG9lcyBoYXZl
IGFuDQo+ID4gPiBhdHRlc3RhdGlvbiBpbnRlcmZhY2U6IFRQTTJfUXVvdGUgYW5kIFRQTTJfQ2Vy
dGlmeSAoYW1vbmcgb3RoZXJzKQ0KPiA+ID4gd2hpY2ggaXMgZGVsaWJlcmF0ZWx5ICpub3QqIHdp
cmVkIGluIHRvIHRoZSBrZXlzIHN1YnN5c3RlbSBiZWNhdXNlDQo+ID4gPiB0aGUgb3V0cHV0cyBh
cmUgaW50ZW5kZWQgZm9yIGV4dGVybmFsIHZlcmlmaWVycy4NCj4gPiA+IA0KPiA+ID4gSWYgdGhl
IGdvYWwgaXMgdG8gdW5pZnkgdGhlIGludGVyZmFjZSBmb3IgdHJhbnNwb3J0aW5nIGF0dGVzdGF0
aW9uDQo+ID4gPiByZXBvcnRzLCB3aHkgbm90IHB1bGwgdGhlIGF0dGVzdGF0aW9uIGlvY3RscyBv
dXQgb2Ygc2V2Z3Vlc3QgaW50bw0KPiA+ID4gc29tZXRoaW5nIGNvbW1vbj8NCj4gPiANCj4gPiBU
aGF0J3MgZmFpci4gSSBvcmlnaW5hbGx5IHN0YXJ0ZWQgb3V0IHdpdGggYSBkcmFmdCB0cnVzdGVk
LWtleXMNCj4gPiBpbXBsZW1lbnRhdGlvbiwgYnV0IGFiYW5kb25lZCBpdCBiZWNhdXNlIHRoYXQg
cmVhbGx5IHdhbnRzIGEgdlRQTQ0KPiA+IGJhY2tlbmQuIFRoZXJlIGlzIG5vIGtlcm5lbCBjb25z
dW1lciBmb3IgYXR0ZXN0YXRpb24gcmVwb3J0cyBsaWtlDQo+ID4gb3RoZXIga2V5IGJsb2JzLCBz
byB0aGF0IGxlYXZlcyBlaXRoZXIgYSBrZXktdHlwZSB0aGF0IGlzIGp1c3QgYQ0KPiA+IHRyYW5z
cG9ydCBsYXllciBvciBhIG5ldyBBQkkuDQo+ID4gIA0KPiA+IEkgaGF2ZSBhIHBlcnNvbmFsIGRp
c3Rhc3RlIGZvciBpb2N0bHMgYW5kIHRoZSBwcmVzZW5jZSBvZiB1c2VyLQ0KPiA+IGRlZmluZWQg
YmxvYnMgaW4gdGhlIEtleXJpbmcgc3Vic3lzdGVtIG1hZGUgbWUgdGhpbmsgIndoeSBub3QganVz
dA0KPiA+IGhhdmUgYSBrZXktdHlwZSB0byBjb252ZXkgdGhlIHBlci1UU00gYXR0ZXN0YXRpb24g
cmVwb3J0cyIuIElzIHRoYXQgYQ0KPiA+IGZhaXIgb2JzZXJ2YXRpb24/DQo+IA0KPiBUaGUgdHJv
dWJsZSB3aXRoIHRoaXMgYXJndW1lbnQgaXMgdGhhdCBpdCdzIGFuIGFyZ3VtZW50IGZvciBldmVy
eSBuZXcNCj4gaW9jdGwgYmVjb21pbmcgYSBrZXkgdHlwZS4gIFdlIGhhdmUgYSB0b24gb2YgaW50
ZXJmYWNlcyBmb3INCj4gdHJhbnNwb3J0aW5nIGluZm9ybWF0aW9uIGFjcm9zcyB0aGUga2VybmVs
IHRvIHVzZXIgYm91bmRhcnk6IHN5c2ZzLA0KPiBmaWxlc3lzdGVtLCBjb25maWdmcywgZGVidWdm
cywgZXRjIC4uLiBhbHRob3VnaCB0byBiZSBmYWlyIHRoZQ0KPiBmYXNoaW9uYWJseSBhY2NlcHRh
YmxlIG9uZSBkb2VzIHNlZW0gdG8gY2hhbmdlIGVhY2ggeWVhci4gIFNpbmNlDQo+IHRoZXJlJ3Mg
bm90aGluZyByZWFsbHkgdHJhbnNhY3Rpb25hbCBhYm91dCB0aGlzLCB3aGF0IGFib3V0IGEgc2lt
cGxlDQo+IHN5c2ZzIG9uZT8gIFlvdSBlY2hvIGluIHRoZSBub25jZSB0byBhIGJpbmFyeSBhdHRy
aWJ1dGUgYW5kIGNhdCB0aGUNCj4gcmVwb3J0LiAgQW55IGFkZGl0aW9uYWwgc3R1ZmYsIGxpa2Ug
dGhlIGNlcnQgY2hhaW4sIGNhbiBhcHBlYXIgYXMNCj4gYWRkaXRpb25hbCBhdHRyaWJ1dGVzPw0K
PiANCg0KU29ycnkgcGVyaGFwcyBhIGR1bWIgcXVlc3Rpb24gdG8gYXNrOg0KDQpBcyBpdCBoYXMg
YmVlbiBhZGVxdWF0ZWx5IHB1dCwgdGhlIHJlbW90ZSB2ZXJpZmlhYmxlIHJlcG9ydCBub3JtYWxs
eSBjb250YWlucyBhDQpub25jZS4gIEZvciBpbnN0YW5jZSwgaXQgY2FuIGJlIGEgcGVyLXNlc3Np
b24gb3IgcGVyLXJlcXVlc3Qgbm9uY2UgZnJvbSB0aGUNCnJlbW90ZSB2ZXJpZmljYXRpb24gc2Vy
dmljZSB0byB0aGUgY29uZmlkZW50aWFsIFZNLiDCoA0KDQpJSVVDLCBleHBvc2luZyBhdHRlc3Rh
dGlvbiByZXBvcnQgdmlhIC9zeXNmcyBtZWFucyBtYW55IHByb2Nlc3NlcyAoaW4gdGhlDQpjb25m
aWRlbnRpYWwgVk0pIGNhbiBwb3RlbnRpYWxseSBzZWUgdGhlIHJlcG9ydCBhbmQgdGhlIG5vbmNl
LsKgIE15IHF1ZXN0aW9uIGlzDQp3aGV0aGVyIHN1Y2ggbm9uY2Ugc2hvdWxkIGJlIGNvbnNpZGVy
ZWQgYXMgYSBzZWNyZXQgdGh1cyBzaG91bGQgYmUgb25seSB2aXNpYmxlDQp0byB0aGUgcHJvY2Vz
cyB3aGljaCBpcyByZXNwb25zaWJsZSBmb3IgdGFsa2luZyB0byB0aGUgcmVtb3RlIHZlcmlmaWNh
dGlvbg0Kc2VydmljZT8gIFVzaW5nIElPQ1RMIHNlZW1zIGNhbiBhdm9pZCBzdWNoIGV4cG9zdXJl
Lg0KDQpQcm9iYWJseSBleHBvc2luZyBub25jZSBpcyBmaW5lLCBidXQgSSBkb24ndCBrbm93Lg0K
DQpJbiBmYWN0LCBJIHJhaXNlZCB3aGV0aGVyIHdlIHNob3VsZCB1c2UgL3N5c2ZzIHRvIGdldCBU
RFgncyBURFJFUE9SVCAod2hpY2ggY2FuDQpvbmx5IGJlIHZlcmlmaWVkIG9uIGxvY2FsIG1hY2hp
bmUsIHRodXMgbmVlZHMgdG8gYmUgc2luZ2VkIGFzIGEgUXVvdGUgYnkgdGhlIFNHWA0KUXVvdGlu
ZyBFbmNsYXZlKSB3aGVuIHdlIHdlcmUgdXBzdHJlYW1pbmcgKHRoZSBmaXJzdCBwYXJ0IG9mKSBU
RFggYXR0ZXN0YXRpb246DQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMjA1MDEx
ODM1MDAuMjI0MjgyOC0xLXNhdGh5YW5hcmF5YW5hbi5rdXBwdXN3YW15QGxpbnV4LmludGVsLmNv
bS9ULyNtMThmZDUxNjdkZmEzMmM0NzAyZGQ2YjRiZDQ3MmFkOWU4ZjU3OWFkOA0KDQpRdW90ZSB0
aGUgcmVsZXZhbnQgcGFydCBoZXJlOg0KDQo+IA0KPiBJbXBsZW1lbnQgYSBiYXNpYyBhdHRlc3Rh
dGlvbiBkcml2ZXIgdG8gYWxsb3cgVEQgdXNlcnNwYWNlIHRvIGdldCB0aGUNCj4gVERSRVBPUlQs
IHdoaWNoIGlzIHNlbnQgdG8gUUUgYnkgdGhlIGF0dGVzdGF0aW9uIHNvZnR3YXJlIHRvIGdlbmVy
YXRlDQo+IGEgUXVvdGUgZm9yIHJlbW90ZSB2ZXJpZmljYXRpb24uDQo+IA0KPiBBbHNvIG5vdGUg
dGhhdCBleHBsaWNpdCBhY2Nlc3MgcGVybWlzc2lvbnMgYXJlIG5vdCBlbmZvcmNlZCBpbiB0aGlz
DQo+IGRyaXZlciBiZWNhdXNlIHRoZSBxdW90ZSBhbmQgbWVhc3VyZW1lbnRzIGFyZSBub3QgYSBz
ZWNyZXQuIEhvd2V2ZXINCj4gdGhlIGFjY2VzcyBwZXJtaXNzaW9ucyBvZiB0aGUgZGV2aWNlIG5v
ZGUgY2FuIGJlIHVzZWQgdG8gc2V0IGFueQ0KPiBkZXNpcmVkIGFjY2VzcyBwb2xpY3kuIFRoZSB1
ZGV2IGRlZmF1bHQgaXMgdXN1YWxseSByb290IGFjY2Vzcw0KPiBvbmx5Lg0KDQpUaGUgSU9DVEwg
dnMgL3N5c2ZzIGlzbid0IGRpc2N1c3NlZC4NCg0KRm9yIGluc3RhbmNlLCBhZnRlciByb3VnaCB0
aGlua2luZywgd2h5IGlzIHRoZSBJT0NUTCBiZXR0ZXIgdGhhbiBiZWxvdyBhcHByb2FjaA0KdXNp
bmcgL3N5c2ZzPw0KDQplY2hvIDxSRVBPUlREQVRBPiA+IC9zeXMva2VybmVsL2NvY28vdGR4L2F0
dGVzdC9yZXBvcnRkYXRhDQpjYXQgL3N5cy9rZXJuZWwvY29jby90ZHgvYXR0ZXN0L3RkcmVwb3J0
DQoNCkVhY2ggImVjaG8gPFJFUE9SVERBVEE+IiB0byAnL3N5cy8uLi4vcmVwb3J0ZGF0YScgdHJp
Z2dlcnMgdGhlIGRyaXZlciB0byBjYWxsDQpURENBTEwgdG8gZ2V0IHRoZSBURFJFUE9SVCwgd2hp
Y2ggaXMgYXZhaWxhYmxlIGF0ICcvc3lzLy4uLi90ZHJlcG9ydCcuDQoNClRoZSBiZW5lZml0IG9m
IHVzaW5nIElPQ1RMIEkgY2FuIHRoaW5rIG9mIG5vdyBpcyBpdCBpcyBwZXJoYXBzIG1vcmUgc2Vj
dXJlLCBhcw0Kd2l0aCBJT0NUTCB0aGUgUkVQT1JUREFUQSBhbmQgdGhlIFREUkVQT1JUIGlzIHZp
c2libGUgdG8gdGhlIHByb2Nlc3Mgd2hpY2ggY2FsbHMNCnRoZSBJT0NUTCwgd2hpbGUgdXNpbmcg
dGhlIC9zeXNmcyB0aGV5IGFyZSBwb3RlbnRpYWxseSB2aXNpYmxlIHRvIGFueSBwcm9jZXNzLiAN
CkVzcGVjaWFsbHkgdGhlIFJFUE9SVERBVEEsIGkuZS4gaXQgY2FuIGNvbWUgZnJvbSBhdHRlc3Rh
dGlvbiBzZXJ2aWNlIGFmdGVyIHRoZQ0KVEQgYXR0ZXN0YXRpb24gYWdlbnQgc2V0cyB1cCBhIHNl
Y3VyZSBjb25uZWN0aW9uIHdpdGggaXQuDQoNCg0KDQoNCg==
