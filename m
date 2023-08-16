Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADAE77E1E4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 14:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245300AbjHPMsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 08:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244553AbjHPMsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 08:48:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F04C7;
        Wed, 16 Aug 2023 05:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692190095; x=1723726095;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iLDK4Vws4V2qyu/AqqSEawCPvM/e614sJ5ZMbpVgLkE=;
  b=aDt3Q487eh0cxVu6neNzbACI/YzJBkQt4e0hcNjrK8eUbhhLYkjkno+K
   SE2jE8s3Lx3sdwlDGfABJkcCMX8nmfP7LayYshB+a8hDvKP7q9x8OVWEw
   iVSGQ9zEuuosH5wpQ3TcN2NzOFvv9bLR4EeyH1zG3Q4+vb0F0uB68/AmY
   C9jt63CGORxOyhhhuUV1rxddqOahxcg4w3FB9iSp0k6sYEsawL6peDjQw
   vuCVqUMYetXdCt3YRrt89L5yc+ZoxhQQ9ZmxVWyzzoFwQW0i5HOYaT2vk
   aoyP7ISlQQUOw8osqOIPOEdGwmtp70oKpCu3LLjjoUc8sq3KHFg8m89AJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="376250956"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="376250956"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 05:48:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="799565782"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="799565782"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 16 Aug 2023 05:48:09 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 05:48:09 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 05:48:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 16 Aug 2023 05:48:08 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 16 Aug 2023 05:48:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEluI4E+1k3ibLBtKaiQhclSKY5fgSmanPLjjxHaaQzwFNBdmFeqEHk/37D+UDn2tA1iWrKq0APtANFPCjWfoxIp2JKlKZ0D5XyUSmcoW46x58GoSnQA8DI57dkomR/hCL04Q9IX3uOmXVjDBZBzJ6FMlGcLBPRCmucPSOCxQxqKuA05XV6/ohv8ZPnipj/IT/+2vf9F6HOZBoKjCWl0mHwMQmdz/04i4B5+RH8q6Q39Zn0NFBW41EWjd04AXGIg5RNJ/qPUlakktU6O2JYJ9mLkbf1kpCXXe9VUAAbBwqeW9QOulEJEuepp5eKtsrv6Nghb15DLrbbUaj3Cc8tMjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLDK4Vws4V2qyu/AqqSEawCPvM/e614sJ5ZMbpVgLkE=;
 b=BTAp7NSjffs+c7anv475pRAin2xLvBB0DyxTNMJk2vBT6pPS0eePjk7MUp/kz9/h2MYHoGYq/ZKCgwsQQlGW7URBEbcij5aibf5Tsc0N9aLTjnWK8w9P8OFgiU4PeEWKbfBJzqbz7Oo60b3TB/Dq3+otStezS/U2idaCX1uVJOcxWTMNfkb81fzHcD5SOlyP82LcbJ4Wb4t+28AJkEgB91GCxRB5D7c3Ti6UGddbFx0O2SZzg/Pfwe5pKch7YxHcv4/Xu85gXgcLtFTvKICYIxI8n9xUe+7XHuXfccQosWshLNBKPvRiC+jx8rPFO6EK0qWov7LsUQfCcSbqVt7s4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3521.namprd11.prod.outlook.com (2603:10b6:208:7b::32)
 by MN2PR11MB4760.namprd11.prod.outlook.com (2603:10b6:208:266::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 12:48:06 +0000
Received: from BL0PR11MB3521.namprd11.prod.outlook.com
 ([fe80::2a21:609b:312:5cac]) by BL0PR11MB3521.namprd11.prod.outlook.com
 ([fe80::2a21:609b:312:5cac%6]) with mapi id 15.20.6652.028; Wed, 16 Aug 2023
 12:48:06 +0000
From:   "Romanowski, Rafal" <rafal.romanowski@intel.com>
To:     "Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        "Zaremba, Larysa" <larysa.zaremba@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "Jakub Kicinski" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH net-next 0/3] virtchnl: fix fake 1-elem
 arrays
Thread-Topic: [Intel-wired-lan] [PATCH net-next 0/3] virtchnl: fix fake 1-elem
 arrays
Thread-Index: AQHZwWvPztHAxz6yDkSQq64moOz0Wq/aYUKAgAAY5ACAAAB+AIASgjEA
Date:   Wed, 16 Aug 2023 12:48:06 +0000
Message-ID: <BL0PR11MB35210EC2D7D1D38B9E27D20E8F15A@BL0PR11MB3521.namprd11.prod.outlook.com>
References: <20230728155207.10042-1-aleksander.lobakin@intel.com>
 <88dce445-180c-72d9-c7a5-f0a18a18c747@intel.com>
 <2e163fb1-492e-8a1f-9df1-270c652e9799@intel.com>
 <bbf73a71-7ef3-3c43-18aa-bcdeb470a125@intel.com>
In-Reply-To: <bbf73a71-7ef3-3c43-18aa-bcdeb470a125@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3521:EE_|MN2PR11MB4760:EE_
x-ms-office365-filtering-correlation-id: 0e184c96-73b9-4a8b-1e7e-08db9e570976
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OMpEbCpCopJqchHZ0p961DmNuO2bG//dqqe21Me5n7n+XiU0cZX3qaEWcnLdv81kR4B5bX6cFGwGyBDEbJpmxe5vcA3zJmm3xnL6DZh5PNUNbTND72UtmcayFxpJ+J3bG2LtkCXXy8MAkj5z2Wr+ONDr4HhU6tzfbNg9w0o4GPK581FUeTv6MORg+4+JlackdzAnLi9RN2msywEP5/OR0eAzmGna65LOykbhY9KW++TsoSiDTXHkghNCx0qyd+1Sp8gSIACxM52dgijTK3j8occjIaPZtDu21k88lwSYBjMB5nr3AV95F/nd/5m46K+Y3McbR4ITBk6zq4d/o7wTFVnCKAqCIut/d5PCMtRB3/W5CP2USYW35T459TnWCLgSg7Vegfnhznp3g/JHtWruuZdmvYLJtBHz3sjapEm4Y64c4szGECS99z8U1Guq4m0RqRjCaMEZHsEmVoawAEf4NSqJTDUzyUTZKsZsjHmRinE6z9wUXW3ocDQ95nthaTzkuxEU0+g+8hrLomwEMiQw9XmHuv3BfKZPIN9/tehBVYYuv8QoErpwiqVMTUDBipJ+pCN69tKyIZSld2i8X9mQTlDHaSBdCLsXmJ95EkxA74o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3521.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(54906003)(6636002)(76116006)(66946007)(64756008)(110136005)(66476007)(66556008)(66446008)(122000001)(966005)(41300700001)(52536014)(5660300002)(66574015)(38070700005)(38100700002)(8676002)(4326008)(8936002)(82960400001)(2906002)(83380400001)(26005)(55016003)(478600001)(7416002)(86362001)(9686003)(53546011)(33656002)(7696005)(6506007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmlIaGpxbXNWTkFPRklYVEV0V2ZtZUlBZHlud0xYZTRjM0MzeTNCRjBwcGt2?=
 =?utf-8?B?WmUzOS93eXpReUZzcUs2eEsvR0gwcXEwTjlCRTdjVUpJRExJckNZZ1RES1pO?=
 =?utf-8?B?KzRrQ3liN0NlNVo4ZFZQU204V1FuemNrRjJqTXlWRzNqaitFUmdGUHV3RTZW?=
 =?utf-8?B?NjQvUmVUNHZYSzhEMzhjU3hjZ2lCNkdDdzRwZUthNXAvMGJudFhpVk44dTZi?=
 =?utf-8?B?c3FyaitKd29yam5hckNMbi9LRzluRE1ua3YyUTdRbEF0ZUhJdk1XNHdWalRJ?=
 =?utf-8?B?K2ZNZjZNTmNINDluUlNUcWVncjJmYnlFampLTVh0MFBjT1Eyd29zdkMrZjE2?=
 =?utf-8?B?K01FQk5WMkhoYU9BdlMrVXdhdzEyN1N6MWxEOFhwRkpMdGcwT3JLSHpnSnht?=
 =?utf-8?B?dit4bDFDOWRqNFJ1aXMyL0pkRUJ5c3RuQ1lqUjBqR01McHIrRG1VRGxYc0FV?=
 =?utf-8?B?VzBqaVd4S01iMXpRMkFqWDFvUzBJa2pyNEZUWENMWTBjTUZLTi9SdFduSHNI?=
 =?utf-8?B?MEUreVVtMno0RU9RS1c0cnFsQ3ZrV1lwMWRnUWppZVN3cTJNSkFQeit6VlFj?=
 =?utf-8?B?Sk92SlBFNVFtTDJ0SnpzSU1JZ1Q0UVI4VWZxd2xRZUNCUUZNOVVHWXRCSENv?=
 =?utf-8?B?QzM3K0hjNWh5RFFqaXlsejF3RlF2U1lQelZKcGlYQWh4anl6VmQ4bCtYS3Jr?=
 =?utf-8?B?c0s5d3hDUDdFbkZCb0o3cEhXOHJVVHBiWll0MnRSOUFTRUZQcEorRG5xUWx6?=
 =?utf-8?B?a1RTWFk4MzBGRG1HOGRVZmpPakYyTmd1TTRZTG50NnZuREs1UVcwbXh2VVQz?=
 =?utf-8?B?b1Qwamg5U2dwY1Jadjc1dnRjSnA3NERpTWE4dXNUeldVUTVGRnFMdU5XK1hL?=
 =?utf-8?B?ckJIMFF5V2pvTlI0NHJlODYvc2Y4V290R1FldVhEKzJqOUVWSFgwaG5DTGt5?=
 =?utf-8?B?WE9JdkZCZXBzSVI1MmV0Z0FaTm9SZ3gwSWZhK3FiaHNRODlsQ0tvRlpveFZ6?=
 =?utf-8?B?UWZvVWlaZUVmK1JLVG5SeklFNnZxWk9sOFVIVzBwNGVEWDNIUldBR3p1eEVH?=
 =?utf-8?B?MWpiZjV4U3ZDNWYxUFNWWUJGK2d6cnlkMzBNczJKOW9wWkI3ZUlmTStvOURl?=
 =?utf-8?B?Qm1kYUFKTHQ4UzV5eWVXTll6ZmtQc0lPUXRpTnFwRDhheDQ4eVVZTVVYRWZR?=
 =?utf-8?B?YktiVUE1WUhkbXlMVGdsK25rVUVKUjhjSWc0SFQyS09BTHltaUsyWHZpQXFo?=
 =?utf-8?B?dGdUdE5QOTBSNndObDltUmNGQUNncmlSdXRhQkQ3eU9xQTkrdmpFUXBTaEdi?=
 =?utf-8?B?TWRxcmNyTkdnQ3dOb2I4UzYrRkxEaCtSdkFDSXNsYk9lNE1CazBacGNkOFcr?=
 =?utf-8?B?ZGdiREljT1hvYitPenhVVDZENTJFRTdKQmhGOU5VdzcxRm1RMWF5TmxlZVlp?=
 =?utf-8?B?amdSckw2eDhPSHVJMHJ3ODJpYjZtSEdSdG1FOWhzY3BkaFFVZ2RZWFZ3M1g5?=
 =?utf-8?B?cjgyWVViakVtb1UyQTBRRVZybFo0WnVWRm00Q0w3cmlYRHovdXIxdmdueDhS?=
 =?utf-8?B?ajJsMHdCbnN3QU1RSmU4dFZWeWdGeDRUUWNKblNaRmtBMkZ0ekF6VFp4RGRh?=
 =?utf-8?B?NTBBQ3MyR0JUWEU1U3VGamcvZ0NtNWc3Y2ZUS0dmWGFuNEpFSGN1NkVnbUxT?=
 =?utf-8?B?UXlXWG96U2F0dTI5d1JNRTJ1MVJqWmNWdm1mR0cyMkU3RGpwQjRXTUcvY05o?=
 =?utf-8?B?UmNuM1Bqbno1Y1Q4UzZjejhFRlo1dWptbUNaTktmUlpSU1lHOHFUdUJGWnFx?=
 =?utf-8?B?L24rdGYvMHhXck14M0x1Tmk3ek1BaVVFeVRTMEV1QU5xRWt2UXBoQTFKSHN4?=
 =?utf-8?B?WTR2UytCMng0L2VYaFBWNzkyc2pmQ2VBcFNidzNnR2Jub1Rwdi9VWUlBejV6?=
 =?utf-8?B?eXFLSFBTcE1jREd0ektoNGpTWTZoNnBTRUdSbHMvaUJ0Y0twQm9RRUVqU3F1?=
 =?utf-8?B?NDVZaHpqRG9mNUZTSDBrQitYd2xzUkxtd241ZE5BelBIR0ZpaEdhTzJveGll?=
 =?utf-8?B?NGJvby82RDh3QitnQzl2ejN1ZkQ0NGRYWEpIQXk4SEEvVGFQZFdsN3E3WGd2?=
 =?utf-8?B?cEhyT0FsLytqbGtKUVRacW1mNGlxVHFqR1E4ZDNWZ1MzRzFxUHNqblN2V2Ur?=
 =?utf-8?B?Q3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3521.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e184c96-73b9-4a8b-1e7e-08db9e570976
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 12:48:06.0574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jVb6XDGQMKnrzGUDWpvQylbtpqSYTOkTHOrhMWZgAKt1l++DVhK4WXVxUUPk1Yg752D5izOhnOVLyK12MNr+qVPM9So6b/RqQl3wBS5yyaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4760
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZg0KPiBBbGV4YW5k
ZXIgTG9iYWtpbg0KPiBTZW50OiBwacSFdGVrLCA0IHNpZXJwbmlhIDIwMjMgMjA6MDkNCj4gVG86
IE5ndXllbiwgQW50aG9ueSBMIDxhbnRob255Lmwubmd1eWVuQGludGVsLmNvbT4NCj4gQ2M6IEFu
ZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPjsgS2VlcyBD
b29rDQo+IDxrZWVzY29va0BjaHJvbWl1bS5vcmc+OyBaYXJlbWJhLCBMYXJ5c2EgPGxhcnlzYS56
YXJlbWJhQGludGVsLmNvbT47DQo+IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IEd1c3Rhdm8gQS4g
Ui4gU2lsdmEgPGd1c3Rhdm9hcnNAa2VybmVsLm9yZz47DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IGludGVsLQ0KPiB3
aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9yZzsgbGludXgtaGFyZGVuaW5nQHZnZXIua2VybmVsLm9y
ZzsgSmFrdWIgS2ljaW5za2kNCj4gPGt1YmFAa2VybmVsLm9yZz47IFBhb2xvIEFiZW5pIDxwYWJl
bmlAcmVkaGF0LmNvbT47IERhdmlkIFMuIE1pbGxlcg0KPiA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD4N
Cj4gU3ViamVjdDogUmU6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRDSCBuZXQtbmV4dCAwLzNdIHZp
cnRjaG5sOiBmaXggZmFrZSAxLWVsZW0NCj4gYXJyYXlzDQo+IA0KPiBGcm9tOiBUb255IE5ndXll
biA8YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+DQo+IERhdGU6IEZyaSwgNCBBdWcgMjAyMyAx
MTowNzoxNCAtMDcwMA0KPiANCj4gPiBPbiA4LzQvMjAyMyA5OjM4IEFNLCBBbGV4YW5kZXIgTG9i
YWtpbiB3cm90ZToNCj4gPj4gRnJvbTogQWxleGFuZGVyIExvYmFraW4gPGFsZWtzYW5kZXIubG9i
YWtpbkBpbnRlbC5jb20+DQo+ID4+IERhdGU6IEZyaSwgMjggSnVsIDIwMjMgMTc6NTI6MDQgKzAy
MDANCj4gPj4NCj4gPj4+IDYuNS1yYzEgc3RhcnRlZCBzcGl0dGluZyB3YXJuaW5nIHNwbGF0cyB3
aGVuIGNvbXBvc2luZyB2aXJ0Y2hubA0KPiA+Pj4gbWVzc2FnZXMsIHByZWNpc2VseSBvbiB2aXJ0
Y2hubF9yc3Nfa2V5IGFuZCB2aXJ0Y2hubF9sdXQ6DQo+ID4+Pg0KPiA+Pj4gW8KgwqAgODQuMTY3
NzA5XSBtZW1jcHk6IGRldGVjdGVkIGZpZWxkLXNwYW5uaW5nIHdyaXRlIChzaXplIDUyKSBvZg0K
PiA+Pj4gc2luZ2xlIGZpZWxkICJ2cmstPmtleSIgYXQNCj4gPj4+IGRyaXZlcnMvbmV0L2V0aGVy
bmV0L2ludGVsL2lhdmYvaWF2Zl92aXJ0Y2hubC5jOjEwOTUNCj4gPj4+IChzaXplIDEpDQo+ID4+
PiBbwqDCoCA4NC4xNjk5MTVdIFdBUk5JTkc6IENQVTogMyBQSUQ6IDExIGF0DQo+ID4+PiBkcml2
ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC8NCj4gPj4+IGlhdmYvaWF2Zl92aXJ0Y2hubC5jOjEwOTUg
aWF2Zl9zZXRfcnNzX2tleSsweDEyMy8weDE0MCBbaWF2Zl0NCj4gPj4NCj4gPj4gWy4uLl0NCj4g
Pj4NCj4gPj4+IMKgIC4uLi9ldGhlcm5ldC9pbnRlbC9pNDBlL2k0MGVfdmlydGNobmxfcGYuY8Kg
wqDCoCB8wqDCoCA5ICstDQo+ID4+PiDCoCBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pYXZm
L2lhdmYuaMKgwqDCoMKgwqDCoMKgIHzCoMKgIDYgKy0NCj4gPj4+IMKgIGRyaXZlcnMvbmV0L2V0
aGVybmV0L2ludGVsL2lhdmYvaWF2Zl9jbGllbnQuYyB8wqDCoCA0ICstDQo+ID4+PiDCoCBkcml2
ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pYXZmL2lhdmZfY2xpZW50LmggfMKgwqAgMiArLQ0KPiA+
Pj4gwqAgLi4uL25ldC9ldGhlcm5ldC9pbnRlbC9pYXZmL2lhdmZfdmlydGNobmwuY8KgwqAgfMKg
IDc1ICsrKysrLS0tLS0tDQo+ID4+PiDCoCBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2Uv
aWNlX3ZpcnRjaG5sLmMgfMKgwqAgMiArLQ0KPiA+Pj4gwqAgaW5jbHVkZS9saW51eC9hdmYvdmly
dGNobmwuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxMjcNCj4gPj4+ICsr
KysrKysrKysrLS0tLS0tLQ0KPiA+Pj4gwqAgNyBmaWxlcyBjaGFuZ2VkLCAxMjQgaW5zZXJ0aW9u
cygrKSwgMTAxIGRlbGV0aW9ucygtKQ0KPiA+Pj4NCj4gPj4NCj4gPj4gVG9ueSwgY291bGQgeW91
IHBsZWFzZSB0YWtlIGl0IHZpYSB5b3VyIG5leHQgdHJlZT8gSSdkIGxpa2UgdGhlDQo+ID4+IHZh
bGlkYXRpb24gdG8gbWFrZSBzdXJlIG1vcmUgZGlmZmVyZW50IGhvc3QgPC0+IGd1ZXN0IHBhaXJz
IHdvcmsuDQo+ID4+DQo+ID4+ICh3aXRoIEtlZXMnIHRhZ3MsIGFzc3VtaW5nIGhlIHJldmlld2Vk
IGFuZCBhcHByb3ZlZCB0aGUgd2hvbGUgc2VyaWVzLA0KPiA+PiBJDQo+ID4+IMKgIGFza2VkIGFi
b3V0ICMyIGFscmVhZHkpDQo+ID4+DQo+ID4+IFRoYW5rcywNCj4gPj4gT2xlaw0KPiA+DQo+ID4g
T2ssIHdpbGwgYXBwbHkgaXQgdG9kYXkuIEZvciB0aGUgZnV0dXJlIGlmIHlvdSB3YW50IGl0IHRo
cm91Z2ggSVdMLA0KPiA+IGNhbg0KPiANCj4gR3JlYXQsIHRoYW5rcyENCj4gDQo+ID4geW91IHRh
ZyBpdCB3aXRoIHRoZSBpd2wtKiB0YXJnZXQgKGFuZCBoYXZlIElXTCBpbiB0aGUgVG8pPyBTaW5j
ZSB0aGlzDQo+ID4gaGFkICduZXQtbmV4dCcgYW5kIHdhcyAnVG8nIG5ldGRldiBtYWludGFpbmVy
cywgSSB0b29rIGl0IHRoYXQgeW91DQo+ID4gd2FudGVkIGl0IHRha2VuIHRocm91Z2ggbmV0ZGV2
Lg0KPiANCj4gU3VyZSwgSSBrbm93LCBqdXN0IGZvciBzb21lIHJlYXNvbiB0YXJnZXRlZCB0aGlz
IGRpcmVjdGx5IHRvIG5ldCBhdCBmaXJzdCwgYnV0DQo+IHRoZW4gcmVhbGl6ZWQgaXQgd291bGQg
YmUgYmV0dGVyIGZvciB0aGlzIHRvIGdvIHZpYSBJV0wNCj4gOmNsb3duZmFjZToNCj4gDQo+ID4N
Cj4gPiBUaGFua3MsDQo+ID4gVG9ueQ0KPiANCj4gVGhhbmtzLA0KPiBPbGVrDQo+IF9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IEludGVsLXdpcmVkLWxh
biBtYWlsaW5nIGxpc3QNCj4gSW50ZWwtd2lyZWQtbGFuQG9zdW9zbC5vcmcNCj4gaHR0cHM6Ly9s
aXN0cy5vc3Vvc2wub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtd2lyZWQtbGFuDQoNCg0KVGVz
dGVkLWJ5OiBSYWZhbCBSb21hbm93c2tpIDxyYWZhbC5yb21hbm93c2tpQGludGVsLmNvbT4NCg0K
DQo=
