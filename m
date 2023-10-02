Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CDD7B50CC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 13:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236613AbjJBLDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 07:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbjJBLC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:02:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE61ABD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 04:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696244575; x=1727780575;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QwaAx0fjIyj01+wAqpHGPrWIZOFDcQ/WmSXVE+pazt8=;
  b=M0tTp/fyUZ4PVEZfDcF4Ipq4kvIackcl65xfJ2YKGQDPbx9Xh1PKSVl3
   DRV2n/YnUSCeLoA1tpFl9zmUIQsjU9ED0hd/PMkYELqIs2u0np27lSlPa
   3rMADvYyFNvgfZm/Znc3fGBHMrc5+RaziG9ddcU5scc8Oa6Bj4lorWrbN
   /kSQdVhbmhjpA7PnACFluxg3jrmS5ssZmeYPWHjPbR1rknZU5VuJJJm+M
   TNgy78LG7qNx7ygWdYa8bdn1FzFVkM+hCk/u2s+8PdThtvzmCBacwOO7K
   QO2nJt6VxsyGBd+xpg+9KUxn77uMaxqo+RnknL/WSkkqoFzwD35FTfF67
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="446773155"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="446773155"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 04:02:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="1484868"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2023 04:02:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 2 Oct 2023 04:02:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 2 Oct 2023 04:02:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 2 Oct 2023 04:02:54 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 2 Oct 2023 04:02:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTiJTsCkWGdz4LJhuHM+yUyvVbjjlZfS7qxlmfbGC4yNQXQZJcG4AVaNRTIgYGU3mayAF+4cPeob49ANvG3UFq1yxhCJQGdxpK7KfDg2qBejNPCz2BxtjttJHZuDDDO8FTATpja9gSBKKySZYSo097orriHOHkNJcT3As8X6LB44aRvRQkGe6F9MK1K9CXsIjAyO+eZIcljnz9CbA6eDtCPz5nEwPZ5tnM+nzFyLv49xqn5fH5zav4e2DRZjqzDm64zY3YUc0v4QDolXtOdxSGlHmOlUq1cGlvDLOYNkm53XtbroKhzUY6UAk7pBVyM6Omfygm9nvBKasrx9K/4H1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QwaAx0fjIyj01+wAqpHGPrWIZOFDcQ/WmSXVE+pazt8=;
 b=HOB1vu+FdHqREvUzQBeGhSAeVVxhowHH8EQIeijwFmwN/upIZ48Vthw6q4vwf6WTGv6WsJRvSiKkL/QTBN5MGN4UQJxuSyqEA6SE2qEtPH/QD4tosWEWA3ltLhp+mLoLMO48m5u3q0PrLAFTR75m7EbT11FgiKXoFs98RyjWohzgujEfDcOqu4vEFgpGIOaoXF/zlZI7kQ5PRbXREnD0JL4qvKhJkHoC8t9LLI8ZPqB2Q1u8Ww9ZBqnJGV+5CvHcbPcjX3n+Sj3bnea5rg8rT9ecJ6eORkmfZmHGBAmcvp+GgiZXlGyFoI5PyJnJc7YzBWQFptJlXQrEl8Ph+bIHNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA1PR11MB6944.namprd11.prod.outlook.com (2603:10b6:806:2bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Mon, 2 Oct
 2023 11:02:51 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6838.030; Mon, 2 Oct 2023
 11:02:51 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Sun, Yi" <yi.sun@intel.com>
CC:     "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Su, Heng" <heng.su@intel.com>,
        "yi.sun@linux.intel.com" <yi.sun@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yan, Dongcheng" <dongcheng.yan@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3] x86/tdx: Dump TDX version During the TD Bootup
Thread-Topic: [PATCH v3] x86/tdx: Dump TDX version During the TD Bootup
Thread-Index: AQHZ87jmX4MFAy/aGEOpFNk0orU+u7A2Uc4AgAAGtQA=
Date:   Mon, 2 Oct 2023 11:02:51 +0000
Message-ID: <5085274727c34dd0a82468457231c27813ac9775.camel@intel.com>
References: <20230930161110.3251107-1-yi.sun@intel.com>
         <20231002103848.4e4pscg4wz7kxgxz@box.shutemov.name>
In-Reply-To: <20231002103848.4e4pscg4wz7kxgxz@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA1PR11MB6944:EE_
x-ms-office365-filtering-correlation-id: 85b760e2-7010-4d80-eb5a-08dbc3371eed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UZ3aH5HrdoLfTmdPAB6EqeBt3NTSJ3nr+J8rLibi5xRBFWc549KlHi+zXeglG5DMPJFIBTUJIOw9Xn9OuJrz9XSAyB4TwDkRZEN74ufNscUk5gY9vvG3TewVvicXJzduYP024ljgu28vEgO2QLqfdOGp2IOCAqkL3m3yOkw1QL/IJnyaf2HgGJgMmoQSouiHe8my5dZaEk3376C/qF03U7RRNHTIzUFY0Q/a+oY+dptEdD3H8uhEp33INeCZqTYbmAeSK3wIk6szY7GqtLATDxQZ22OWGQt3XpN9zfkKfPlMbumVKoMRFlO6Ue5T17J/NUH+5HKnI6SUty2iehzUW967m+o1eK3jtYDvq97TT8Me1/xS1HTK5Qgt+m2/c46Y0MZmlaJ1nozzUNEASOhmp+/rkN5TdpvP24Opd6AtF+vhWBJMwTMlgDMhfCkPU9Tu20n2674WX1+zz+TzWOabkHcIzV8HRnkUKKPfYCbLP5HuyeUgsoZWOmB3+s6COXbTWgLtuXjRFKhmwmG9YmUW8JW1NsE7b1CvJ/nRilC8dg7HLxc4N3s9DZOAid66AgD7XOja8rhptD0Gj0U3kRmRLXJlurmO4s2hGcGFxhkH4MestLaFruXGY6zvdfSvJblnjyci5nVQ20M5DM3/guqsBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(136003)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(2906002)(2616005)(6512007)(6486002)(6506007)(71200400001)(86362001)(966005)(82960400001)(36756003)(26005)(38100700002)(38070700005)(478600001)(122000001)(66556008)(66476007)(64756008)(66446008)(76116006)(5660300002)(54906003)(66946007)(110136005)(91956017)(316002)(8936002)(8676002)(6636002)(4326008)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amVLNkFpTHNLKzRHZDJSSEttUlB3YUU1R1c3QXlmcXZvOWZOeWZPMGVta1ow?=
 =?utf-8?B?M21malJKVnpIZXlpRW56QzRtN0FpcENicFJwQTR5K3dpZFVtVDlMMXF3OFNL?=
 =?utf-8?B?WHJDcEl3U3JUK2FleXEzQWRZV21EQUhzUisxY0V1bEhiSWRZdm92QS9kRUlx?=
 =?utf-8?B?bE1vK2MvWEFPNExDWTRJNUlabnFtQ1B2WUFnZFRIVnBuQWdmQXpGazAxV3cz?=
 =?utf-8?B?bEZIVTFVWmhuYklmQkc3K3h1ZHBRamJCb1Y0Y3AvckJOQjlyblUzTkNtYVFC?=
 =?utf-8?B?YUdaMXFXM3A1a1lRL2NaR3VqZE1xVXJKbnhPeGtNazhwYjFIa28wK1VxT0NN?=
 =?utf-8?B?QWtzaUpVMG1FYWNWR2p5cXB1MFRDdmxZa0taQUZtV1VSMzh6NXNPR1dPVS8w?=
 =?utf-8?B?c1ErRE5BMUxKLzE1bm9hWi9sdDhSSC9tY2R0YitNVTFlNE5xNnJiT0RDU2d0?=
 =?utf-8?B?TGQ3S2ozRFgxU2lFTVN0TCtmR1c2TFN6dENMbXlWejBoajdrMVR6Q2hWeXc3?=
 =?utf-8?B?VCt4RkpCNzE5b2tBbHNNYTM5MEIrc1ZRMnQwNElhVXEyeVV6SDlSR21kSlEw?=
 =?utf-8?B?T3paY2MvajI2NmMzbEtuZks3VmZxaTdnTHFEWUlJMlBWKy9xWWJnOXJXaWx4?=
 =?utf-8?B?dzJVQyt5ci9ybUU3R1FmUUhJNS8rbk5rYmtITUEvNllHbGNmUjhRWWxpTE9w?=
 =?utf-8?B?NkpEeDN5SEZaTldHeTl2L0xBekZ2Q2RDc2FLajR0R0M3M0tZNTNVcWtPc3hW?=
 =?utf-8?B?L2FmeFRqUDFTVmdxL1EyYk1wV3AyVnZMNCt5VmpzTVFuNzJVdVFIamNUZzZN?=
 =?utf-8?B?eC9TUHlpd0l2aEpxckJVaXJRcXJLR2Jjd3ZmYVF2Y2xGd3pUYmdUUHMwejN1?=
 =?utf-8?B?RkJlbUhRYWdMK1JHWDREVy9qY1A0amV0V3I2SXBUYXVxN2h0QytvNCt2UWZL?=
 =?utf-8?B?d2U4OFVxaUxSeGpOdmxjK2YxODB4cWxjRWxmdUFNelQ3YU1WSHh0VUl2OWxn?=
 =?utf-8?B?OUdtWWpObVdrSmtYeFN5ZGZKSEJnOFB4bURjcmNlc1hOOWx4MXgwTlpuN0Iv?=
 =?utf-8?B?TjRrc3VpUEJISTFMR05FMGtlTW12NUVpVkQzTThSSlVISkp4VlQ1OFZ5UFdW?=
 =?utf-8?B?ZWt3T3Z1MUpmTXFHTUZtSURMVmRmb1dRcUYxbFkxL3hKV3B2RzR2Z1lhaWw2?=
 =?utf-8?B?VW0xY2lsM2ZYbzV4MGdZOXhFeUM5MUIvaGFManl6cGxhaFBqV1AvbUd5WWRx?=
 =?utf-8?B?NkZCRklBdktjNW1DdFpRYWt6YWFwQWhtK2ZUa0tPeU9FMmhqUE1zckRqYndC?=
 =?utf-8?B?ai9tYWN2enBCREtjcHQweVFQRFYzSGZYWnhQUDhoVTFEU3AwSUhMd3F0S21E?=
 =?utf-8?B?bmR4akdQK2Y3Sy9EY1VIakdnTkZUTmNYVUVQdnpKeTV0RGxoRmRoYjZHQlUv?=
 =?utf-8?B?WXJCWEJqeG9jNVRXUHloVGNuYjBRdW1Fb0FBVWdOeXZNbFEyUS8xUCtpeWtY?=
 =?utf-8?B?aHdJODFYNnpzNUZLVmVqREhsZE1zS2xZcFRKU2xvZVpFQkhWZ3huTTZPeFBU?=
 =?utf-8?B?OWtnc1BKN2JIVXJaNHd4UHRKeit4eDZkSjZqMHZUeU5sQjBIRjROeTBWNXU2?=
 =?utf-8?B?WFh3RExtLzIzL3ZsR3BJcXVwM2NJd25ObGtJNmtlU1Y5SHVJdVZFWnlzWUxK?=
 =?utf-8?B?R1QrVlVYWUJBVGVLK2YzdWlvbGM4Wnk2K0NLK3ZrZTFqR1RYTzc1L0IrVTh6?=
 =?utf-8?B?OUdQZS9MVTdBR1RFVW9mQjV5MCtVa0J2Y0dDV2NNRHREY2g5QTIwRnhXeldN?=
 =?utf-8?B?eEtkU3dnbTFKeFAzaFFZaThDdEFTQitJUTFXeDB5TWFtd01ETnpWMTZaVm1y?=
 =?utf-8?B?Y3A0aVF5ekpLMzhlZC9ZKzMxQk1DdjJHSWtwVDlFU2pqUjNlbnVLMVdUaTFp?=
 =?utf-8?B?Q2NOTmVIdGlBaU91Nmc0V2E0MVhSU0dDaTV3QzV5MW02ZEJDMTFOaE01OVZX?=
 =?utf-8?B?Y0R5ck1NcWZoV085NU5UTEpaME1hL2d1emlXU21kL1BoSTlOa01XY21GOWw4?=
 =?utf-8?B?K2RsSzJiZ1MvNlZBSVR0VUdjWmdoQlZiTGFibU90bndLUkpUSnhwQ1d2OFl1?=
 =?utf-8?B?Y1l4SnpsVWV5M1RhV01EOGVSSHMyVkFUVHVVN091SUc2WGY5Y2xZZWREMDhp?=
 =?utf-8?B?WUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <75321436C8191B4F85C8F36215C808E4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b760e2-7010-4d80-eb5a-08dbc3371eed
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 11:02:51.2047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qBWLBw9JJ5z5FFiyNuw9vFfuOaKTuhTMwfc0RlzuByVt+OogKqet8/3HySz1apOSJ+fiF7m8corhRhPwEmyNWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6944
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTEwLTAyIGF0IDEzOjM4ICswMzAwLCBraXJpbGwuc2h1dGVtb3ZAbGludXgu
aW50ZWwuY29tIHdyb3RlOg0KPiBPbiBTdW4sIE9jdCAwMSwgMjAyMyBhdCAxMjoxMToxMEFNICsw
ODAwLCBZaSBTdW4gd3JvdGU6DQo+ID4gSXQgaXMgZXNzZW50aWFsIGZvciBURCB1c2VycyB0byBi
ZSBhd2FyZSBvZiB0aGUgdmVuZG9yIGFuZCB2ZXJzaW9uIG9mDQo+ID4gdGhlIGN1cnJlbnQgVERY
LiBBZGRpdGlvbmFsbHksIHRoZXkgY2FuIHJlZmVyZW5jZSB0aGUgVERYIHZlcnNpb24gd2hlbg0K
PiA+IHJlcG9ydGluZyBidWdzIG9yIGlzc3Vlcy4NCj4gPiANCj4gPiBGdXJ0aGVybW9yZSwgdGhl
IGFwcGxpY2F0aW9ucyBvciBkZXZpY2UgZHJpdmVycyBydW5uaW5nIGluIFREIGNhbiBhY2hpZXZl
DQo+ID4gZW5oYW5jZWQgcmVsaWFiaWxpdHkgYW5kIGZsZXhpYmlsaXR5IGJ5IGZvbGxvd2luZyB0
aGUgVERYIE1vZHVsZSBBQkkNCj4gPiBzcGVjaWZpY2F0aW9uLCBiZWNhdXNlIHRoZXJlIGFyZSBz
aWduaWZpY2FudCBkaWZmZXJlbmNlcyBiZXR3ZWVuIGRpZmZlcmVudA0KPiA+IHZlcnNpb25zIG9m
IFREWCwgYXMgbWVudGlvbmVkIGluIHRoZSAiSW50ZWzCriBURFggTW9kdWxlIEluY29tcGF0aWJp
bGl0aWVzDQo+ID4gYmV0d2VlbiB2MS4wIGFuZCB2MS41IiByZWZlcmVuY2UuIEhlcmUgYXJlIGEg
ZmV3IGV4YW1wbGVzOg0KPiA+IA0KPiA+IE1TUiBOYW1lCQlJbmRleAkJUmVhc29uDQo+ID4gLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+IElBMzJfVUFS
Q0hfTUlTQ19DVEwJMHgxQjAxCQlGcm9tIHYxLjUNCj4gPiBJQTMyX0FSQ0hfQ0FQQUJJTElUSUVT
CTB4MDEwQQkJQ2hhbmdlZCBpbiB2MS41DQo+ID4gSUEzMl9UU1hfQ1RSTAkJMHgwMTIyCQlDaGFu
Z2VkIGluIHYxLjUNCj4gPiANCj4gPiBDUFVJRCBMZWFmCVN1Yi1sZWFmCVJlYXNvbg0KPiA+IC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+IDB4NwkJMgkJRnJvbSB2
MS41DQo+ID4gMHgyMgkJMAkJRnJvbSB2MS41DQo+ID4gMHgyMwkJMH4zCQlGcm9tIHYxLjUNCj4g
PiAweDgwMDAwMDA3CTAJCUZyb20gdjEuNQ0KPiA+IA0KPiA+IER1cmluZyBURCBpbml0aWFsaXph
dGlvbiwgdGhlIFREWCB2ZXJzaW9uIGluZm8gY2FuIGJlIG9idGFpbmVkIGJ5IGNhbGxpbmcNCj4g
PiBUREcuU1lTLlJELiBUaGlzIHdpbGwgZmV0Y2ggdGhlIGN1cnJlbnQgdmVyc2lvbiBvZiBURFgs
IGluY2x1ZGluZyB0aGUgbWFqb3INCj4gPiBhbmQgbWlub3IgdmVyc2lvbiBudW1iZXJzIGFuZCB2
ZW5kb3IgSUQuDQo+ID4gDQo+ID4gVGhlIFREQ0FMTCBUREcuU1lTLlJEIG9yaWdpbmF0ZXMgZnJv
bSBURFggdmVyc2lvbiAxLjUuIElmIHRoZSBlcnJvcg0KPiA+IFREQ0FMTF9JTlZBTElEX09QRVJB
TkQgb2NjdXJzLCBpdCBzaG91bGQgYmUgdHJlYXRlZCBhcyBURFggdmVyc2lvbiAxLjAuDQo+ID4g
DQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBEb25nY2hlbmcgWWFuIDxkb25nY2hlbmcueWFuQGludGVs
LmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBEb25nY2hlbmcgWWFuIDxkb25nY2hlbmcueWFuQGlu
dGVsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZaSBTdW4gPHlpLnN1bkBpbnRlbC5jb20+DQo+
IA0KPiBMb29rcyBnb29kIHRvIG1lLg0KPiANCj4gUmV2aWV3ZWQtYnk6IEtpcmlsbCBBLiBTaHV0
ZW1vdiA8a2lyaWxsLnNodXRlbW92QGxpbnV4LmludGVsLmNvbT4NCj4gDQo+IEJ1dCB5b3UgbmVl
ZCB0byBzZW5kIGl0IHRvIHg4NiBtYWludGFpbmVycy4gSSd2ZSBDQ2VkIHg4NkAsIGJ1dCB5b3Ug
bWlnaHQNCj4gbmVlZCB0byByZXNlbmQgaXQgcHJvcGVybHkgdG8gbWFpbnRhaW5lcnMuDQo+IA0K
DQpJIGxvb2tlZCBhdCB0aGUgcGF0Y2ggb24gbG9yZS5rZXJuZWwub3JnOg0KDQpodHRwczovL2xv
cmUua2VybmVsLm9yZy9hbGwvMjAyMzA5MzAxNjExMTAuMzI1MTEwNy0xLXlpLnN1bkBpbnRlbC5j
b20vVC8NCg0KSXQgc2VlbXMgaXQgaGFzbid0IGJlZW4gcmViYXNlZCB0byB0aGUgbGF0ZXN0IHRp
cC94ODYvdGR4IHlldCwgd2hpY2ggaGFzIHBhdGNoZXMNCnRvIHVuaWZ5IFREQ0FMTC9URFZNQ0FM
TCBhc3NlbWJseS4NCg==
