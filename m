Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9259C76A43C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 00:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjGaWlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 18:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjGaWlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 18:41:12 -0400
Received: from mgamail.intel.com (unknown [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25D819A4;
        Mon, 31 Jul 2023 15:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690843270; x=1722379270;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LPtqNLOSBXofLyPZbbNbn9vXjrmaB0Yxcz7ybv08pn0=;
  b=QoUWTX4o4vFoD6PaGy2buL/k7FzJ9zPnt6h2Hf9BQmZ69KvqWC7o9m/m
   4HCQHZBJhW0IZm+nOHfriBhFHNO05sk9MINS1qYfBC3dtAklvwp3hzl+e
   ZE0UNYObnWXSOs6vdZU6htVK+gBifPjn4W8D4/zqldbfg74gkRVbEIu6o
   bbvbP1y+RH0LV1+5lXxgntUVaGWc48w6aVUHCcCOvF+EQ8Ifpqc709Ad8
   Pt8t+l0YIPfNEhXFZT/UChp0EfmvTh/qGhTbOMT7JgE3JvTDKpFZdHQ25
   kRf31lF+YyGWujcoms8twechhXwuICMdU3PB/6wVjTB0slFPmtAnJnvcu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="371853878"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="371853878"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 15:41:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="728442952"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="728442952"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 31 Jul 2023 15:41:10 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 15:41:09 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 15:41:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 31 Jul 2023 15:41:09 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 31 Jul 2023 15:41:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cfskwa5vNwtvK8WJdOdfv3RIHK9Emf6Vk1rA3HtfHzFO4aTlmpfeSTJwxX5Q02/5R35tL8f7di1a3Dod2IgfH+ItVinEgrjWPyDMhP9SY3+GrzPJXaujoLpblYzeg/pJ7UY0+U4KC6nw1iJB/XiXP16lf6iZJ/mXmEGUbMvDgoI3qyHLTl/oWqT8eNt7N1/AAH/W4TNBLgLqySBe+4B+zMXhaiqODGCIRIkw/HsqAmiL30fQ9+qywmMZc2imYF9msPhUmZv00lQtPw38JiBJUglKSj5wv/zP21zhEYktZdiF4OIsxnekBULSZ2GDhVgyAvYw0p/xcIH2yCiy6nafNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPtqNLOSBXofLyPZbbNbn9vXjrmaB0Yxcz7ybv08pn0=;
 b=J1cJvki6+l/YbQH0shl4/5Eh0W23qlhU7BqCTokgDKLqtK2+dv+5xtpsT3gFn82thyMOI4N1Xthe9AlIa7Ch4i1a0R6Xrp30Z/IjCr0KUGXqxhacDIRu8w6+OLoemQ3SESkWLhf+P+ydOfHfxgqgiT/mJg6giZqEFkNj4i8YMyPgh7wNUBel+J3H04uFYRvNh5TKLBlgilVrM2gN/+H11MFOImajT5Nanxosqe90hR/Z7QOxXSjCZmgMHTDr3idDni3B5azCqw5L9sPH2aHHzOU5+I3HmmUl08TvzPTRx4Q5V/89evjbN+YNlnyb63ch/AvvAFP9nkvwpc7VvHQ/Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA3PR11MB7612.namprd11.prod.outlook.com (2603:10b6:806:31b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 22:41:07 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 22:41:06 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>
CC:     "sameo@rivosinc.com" <sameo@rivosinc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "bp@alien8.de" <bp@alien8.de>,
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
Thread-Index: AQHZwYoTw9Njl1TosE69WJRoUv/G3a/PkhQAgAACuYCABBZAgIAA0gsA
Date:   Mon, 31 Jul 2023 22:41:06 +0000
Message-ID: <3ba03a0d0eafc6622eee9e485bd89d22778a7592.camel@intel.com>
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
         <CUE22P5RYPH3.1K05T2OCK1CN1@seitikki>
         <64c41aa5ba9ac_a88b29494@dwillia2-xfh.jf.intel.com.notmuch>
         <CUG9XAK3RNFF.GWCYLXSTWX5E@seitikki>
In-Reply-To: <CUG9XAK3RNFF.GWCYLXSTWX5E@seitikki>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA3PR11MB7612:EE_
x-ms-office365-filtering-correlation-id: 9b94d626-cb12-48e1-9453-08db92173a97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sbTh658mQN88kuo6gpNhCNMfBvOxSo0uSXznZA8T8ybKFgNvuio/7n7d/9lEW9INnXfXfs80mdO6lE1yoYpLUnQJrRF0LFlNjpUtckGKa4LvAKtum0wEBQ7JUrPblcM5bcbgGDuxf85idNRv7qIQQMKk7mZRAd33Vk6+K4iEfa5saC6Ub0iuAVjc9a8lkyODFXHYNIzpH4izQSu/+X8CcyfWOIOur2t6LS4vLQbrJarb2Ds2Z4jYqLYBLvyf40OcYQ15HULpu9KqpjQRPSlAVkNuswX94c9Iz0ZqB/p5Zt+CSSC6yspL0q0xcyZHAiN7xLnYpyYA/OAfhvvKD2k6EHKxL4izYxXVVZ511P1Om4nAE+8PXY35BeM4g1sYLnSyaU6N1aw9R6EU1+sMDjSseYDiuaQC3orPVTlM0kLUCB8noQm+OVpuBFYYusPeOQ0ZTLj+YF1cEnks3eooIbJTFXaA7jIbg2ocp1ZecUxYc+8ERSJJhH13x+8VbBvuEQV1M5EnJIsDImhTD+j9lNAdIkQw1d81QKIFRZ+ma/I49X3ajf7smeni5k1LQ1lAFB6gmCAxNAVLRtrfMgVowKoSqnGMXu5N7nihB8xgaXxl39gwCGkcLaO9A714iyOLrLmK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(396003)(346002)(39860400002)(376002)(451199021)(5660300002)(2616005)(186003)(8936002)(6506007)(8676002)(4326008)(26005)(316002)(7416002)(478600001)(76116006)(66446008)(54906003)(66946007)(66476007)(91956017)(66556008)(110136005)(64756008)(6486002)(86362001)(6512007)(41300700001)(71200400001)(38070700005)(4744005)(36756003)(2906002)(38100700002)(82960400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qk9KSFdYVGJ6VW9YNXdhUkxmZ0tTRE9FSGg2T2poM2p3U1Q3TVdveGJwbHFj?=
 =?utf-8?B?ek90RExXSklLa28xUW5nejU4aFBOMnlVbDJEVHJVazdoVHcrcDFrUTNyMGIr?=
 =?utf-8?B?eThZeTFhWGF2RnhRTVB6VXMxQ05GUUx0TVZnSDl6TlA2RWlHRGxXcHZsZERo?=
 =?utf-8?B?c29YNE51a2xieXltMWZKYkRaRUpWWnYzSzlIdDY1ZmtMWEJET0FJS0k2cFJE?=
 =?utf-8?B?cVphK1N0TUVMZ2xZc1pHZ1FUZGVsUUVtTkJjeUlsZDVaVGx5M0hzWHZiWTlp?=
 =?utf-8?B?UGNJY1NQZWdOUC9QL0FkcE5FdEF2Yk45bHdLNmtySitMb3JCY3FXN3U2c01v?=
 =?utf-8?B?RjZvOVhVZllLSEZhRXlGQlpTY00xZ3RMTCsrNFdPcUJxOFgyaDdxVmVJQ2tN?=
 =?utf-8?B?R2tXcXFtYnJ2VnpVaU5yTGY2cllGcnhJQ083OXVYNkN6dDNMSitCR0Q5V3Qv?=
 =?utf-8?B?THdrZkY1VUNEc2JYbzdQN21HV1pWSEVSckxwSFNCZENLMWVDd05sR1N5RnhJ?=
 =?utf-8?B?ZWNhVitRb2tCelZBQUhFUmF2RlhhdXNwQVA3alE4Y1hnMVIyaVFWRUltcmpS?=
 =?utf-8?B?L0RVcmFja1YvbXluRWttNllXdSt6K0FaSGt4SzMyTlRxbE9id2VWV3d2L0l5?=
 =?utf-8?B?ZDVQVllNaW9uQmxTSkF0VFFwZFJTUFZTdlR3dWVCd0VvQ0FqY1hRWVNvbS85?=
 =?utf-8?B?WElnQm0rZVF4RUo4ZUJrTjNOU0Yrd1dqRmgrbXJLZUQvNGN0eFNIQS9VMHAz?=
 =?utf-8?B?Unh3aTNLOUcreVhNS0pWbVhjOCtyTGtpcUVSdkQ2NGtyZEFJR0JuSWJPemUw?=
 =?utf-8?B?RUwrNUtBMWo5aVNFVmllemI0eWNBcm1hSVhFSlI1a1VFT0wvRy9VcDh3VlYw?=
 =?utf-8?B?ZjJuNTAvT1h1ZTljcWcxYWZpRmk4YW1jRDhwTktDVHZaTFpKbmlQdkE5OTlx?=
 =?utf-8?B?WGZQV2ZMVkJyUDhxcGxjMmF0RWc3QklCZEJ6V0c2bFJQMjQ1dnVURFl2Yzl4?=
 =?utf-8?B?dFFxRXJTV0ozejhEeXpBZUxBalEwK1hsaVdMTzRSUUd1UVgzVU5mVllUQmtT?=
 =?utf-8?B?cHJmSUJTaHZ0cDhLNXdIanhRUVZCS1I2amkrZExFRTdwbFlFWENqK1gvcitY?=
 =?utf-8?B?YlBMTHlvbjQvaUlhY0kzUW1QcUF2eVFXc0ZidVFuNm9la2pPSENXVk1sem15?=
 =?utf-8?B?Q0oyRVoxQzVhMyt4YjBNVURDalhxT0ttUlZDdjc3eG9VQTIvTGVDaFBnR045?=
 =?utf-8?B?VCtzWE5kTHdmejhCZE9YQnFlYmVlVGp0S2tMZ3h4UStIRWgwTHd2TXBFbUFZ?=
 =?utf-8?B?QXRGQ0lybEprVjI1NXA0MkZzTWlvUGovSDF6VWwxc1Q0N2FoYXFQV2FJa1M4?=
 =?utf-8?B?RFpVTzdINUxEbHRmd3JxamoxSlBqNHE4MUVYa1Vwa3hrdnRXTjdVS2RZVkRE?=
 =?utf-8?B?Z3IzRmlTdmVOc284WGx6U0F6TzBrcEJSR2NnVlB4RW5PdnROMWlMUUt3Y0ZR?=
 =?utf-8?B?RGFaay9nSEx6RVBkMStKS0RlYWxFMytTejIxbnBWNEJwaDJJUVJ0UUZOckho?=
 =?utf-8?B?bmlmOG5FZmtJZTd0QTdKUjZxaGsxWnVDSXBTMkNxTXgyeThjUSs5aEhjeXpt?=
 =?utf-8?B?SUk5d0xyTG9DUCtHM1lhclpRTVV1dVJ6bHI4M2FqSmdFSStEeXRsVlh0TE9Z?=
 =?utf-8?B?K0JGTHgxVDJIa3JreUdEbEJ3bTdnMXYzZWRQWmhHTDFCYjI3L2J6QittM2hM?=
 =?utf-8?B?Y1I3dCtwMzk5KzhCcDBrRGtuN3hRcjRxdDA4cENFRS9oOUFQMm91VGxUVGZP?=
 =?utf-8?B?MUQxcGtaTi9UODZOMnVtZnc1N3VIamhVQ2lBSU5TZXI5NmtVeThnMEthYmpn?=
 =?utf-8?B?U2NZS0JFUmZGeDBkUzY5VzBkRDAyakFMWmtPSFZkVGtmeHZzeTZWMG5QK0k4?=
 =?utf-8?B?MnM0Y1EvVExmZTJaYkxWRndFSUpnaE51SURmaUtTUjNMUjk4bDhYRGF3djVL?=
 =?utf-8?B?VFA1TFMyU1Y0cHVXRFo1UUVrZHQyWDJGbDNtMG5OQ0VEcEJRRS9raG5sR3l3?=
 =?utf-8?B?eWNrVUlHbnV0M1hnYSsxNlNHQmdpZVVHMFFrR3JhZUxRTWRYeW81M0MvemFr?=
 =?utf-8?Q?Mh4LyKhInKUwlAZSfxeT7QuZN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0855D7B0FDF3AF43822870F4054DBD68@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b94d626-cb12-48e1-9453-08db92173a97
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 22:41:06.7698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZwoGpaAPFkt+WG9Z4E0QVI9J39FE3gIm6/KIpRjwkgRnHfFmv/LoVmQfEgpBQQL7uhLL7bWt/K7IVs4g0Z1Xbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7612
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA3LTMxIGF0IDEwOjA5ICswMDAwLCBKYXJra28gU2Fra2luZW4gd3JvdGU6
DQo+ID4gVGhpcyBmYWNpbGl0eSBpcyBkaWZmZXJlbnQsIGl0IGlzIGp1c3QgYWltaW5nIHRvIHVu
aWZ5IHRoaXMgYXR0ZXN0YXRpb24NCj4gPiByZXBvcnQgZmxvdy4gSXQgc2NhbGVzIHRvIGFueSBk
cml2ZXIgdGhhdCBjYW4gcHJvdmlkZSB0aGUgLT5hdXRoX25ldygpDQo+ID4gb3BlcmF0aW9uLiBJ
IGhhdmUgdGhlIHNldi1ndWVzdCBjb252ZXJzaW9uIGluIHRoaXMgc2V0LCBhbmQgU2F0aHlhIGhh
cw0KPiA+IHRlc3RlZCB0aGlzIHdpdGggdGR4LWd1ZXN0LiBJIGFtIGhvcGluZyBTYW11ZWwgY2Fu
IGV2YWx1YXRlIGl0IGZvcg0KPiA+IGNvdmUtZ3Vlc3Qgb3Igd2hhdGV2ZXIgdGhhdCBkcml2ZXIg
ZW5kcyB1cCBiZWluZyBjYWxsZWQuDQo+IA0KPiBXaGF0IGFib3V0IFNHWCB3aXRob3V0IFREWD8N
Cg0KU0dYIGF0dGVzdGF0aW9uIGlzIGNvbXBsZXRlbHkgYW1vbmcgdXNlcnNwYWNlIGVuY2xhdmVz
LCBhbmQgdGhlIGV4aXN0aW5nIFNHWA0KdXNlcnNwYWNlIHN0YWNrIGhhcyBmdWxseSBhZG9wdGVk
IHdoYXQgaXMgbmVlZGVkIHRvIGRvIGF0dGVzdGF0aW9uLiAgV2h5IGRvIHdlDQpuZWVkIHRvIGNv
dmVyIFNHWD8NCg==
