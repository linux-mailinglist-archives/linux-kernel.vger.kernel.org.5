Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7463F7D7914
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 02:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjJZAHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 20:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJZAHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 20:07:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD01910A;
        Wed, 25 Oct 2023 17:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698278854; x=1729814854;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QAl07UNlMuM8paCikAlNU3zXTrg0HquVAX3Tc5ANE7A=;
  b=XwA/isI6aNV34NXw7Ny358kjHV4+0rqPFyMmk8TTwa0+7B/E210zSRaU
   /6IbdiAttmSj2JUeMKpuz03U7RVqe/sfqTk8Hf9HYzo/CKGYzJcJUbRv/
   O3cX6FM9oGNnAN0U3irYACamB7D+uvgp9LkAGs9Y7ShAL53hlXTGimXhG
   d4ugwRZqlfx8CSweCNsdDhyCPd1L5eZQgAL75MmblYdS86NKif32fowhO
   kxOVprqn1XBqBbqWphxkDMLhrQ1PeWHMWWbZft6Uv3absH9Wv/g1A/LiO
   hfKfROF5bP99x8JbiAd7F4YYIkbt8E9DQnQsQbajAI8xsDPolqVPjc3kf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="386305067"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="386305067"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 17:07:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="752516633"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="752516633"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 17:07:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 17:07:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 25 Oct 2023 17:07:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 25 Oct 2023 17:07:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 17:07:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnquGZGnxYHyLZ+EflUYBHE+1cf0QPo9DxVOGDs6+4MPE9t6h4odOVPV2JYH88MZ2zZzElbjBkYsnWUM3LbuxYctgEZsLAAhsAl27LO3GcCzXiTCj3KSp4W1WxMoYubh8bo6ssdz3nSkFDUib6rBW7JKY6ZV8CzG7H8/Syao1ZzA9StGf/AbMOPzQHFZPrKU0hP2h3+tpBSKtrXnriPLnBQadcE/Qa7TSkwhlpaQkAkcHqVBK22d9iieYy9KztmsFOfe+d4lzOFCVursN2KW8mscEzK567fAv5/f4U4rVTHm2Kenpvvq6cVoDYiFyNqood7rEOvXZH1SkAAZ17aS/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAl07UNlMuM8paCikAlNU3zXTrg0HquVAX3Tc5ANE7A=;
 b=T/crmtdpUb8XO9McD4DGZbRqZ2UGRntwAtj+g7SQwYL1YdhfeNP62F0iBFpDRxtLvqne3oUwlnYnbMBa8fjcLE8yF9KYXyAcZPH3LtOcmrMlSQsTsCB6zlIUxEZIiqADSd0fhGkxYROrtderu8caU0wDGgb0wQbr7p9uwdjUoCiMS+K/o3QCBADe8kcd+zyMIG+n16WPupJP9xTjbZRx0frlXF51901Ul6oP/qfG7S96scUC4mdWrcL8r0U0gvJGqcj2XFH8SDY4OIKaWdczhZTtr18mHEOM6jZ8y5Shx98P5/L16xl7xKSvJisNDN/L7oVl1g4oFokLc4ZL+NixtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA2PR11MB5082.namprd11.prod.outlook.com (2603:10b6:806:115::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Thu, 26 Oct
 2023 00:07:29 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3ffb:89e2:2724:4c5]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3ffb:89e2:2724:4c5%2]) with mapi id 15.20.6907.025; Thu, 26 Oct 2023
 00:07:28 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "babu.moger@amd.com" <babu.moger@amd.com>
CC:     Peter Newman <peternewman@google.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH] x86/resctrl: mba_MBps: Fall back to total b/w if local
 b/w unavailable
Thread-Topic: [PATCH] x86/resctrl: mba_MBps: Fall back to total b/w if local
 b/w unavailable
Thread-Index: AQHaBqYtRjw2ybQBRkugDlcC/RU7LLBadVyAgACEJ/iAAACoAIAAMlzSgAAFpJA=
Date:   Thu, 26 Oct 2023 00:07:28 +0000
Message-ID: <SJ1PR11MB6083E960D5186787D4337C2AFCDDA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231024181600.8270-1-tony.luck@intel.com>
 <CALPaoChftF-H6GauKq4-c_qBJP1GJbR3-ByE5krsaQF4y4y9oQ@mail.gmail.com>
 <ZTluypa9bCWv4k2n@agluck-desk3>
 <e4994218-a7a2-4505-868e-a5c825ca4db0@amd.com>
 <b8ea0a74-347d-475f-a36d-8944ced16951@amd.com>
 <ZTmAFVuYlMuCbQHz@agluck-desk3>
 <88541b20-6745-28e3-6ba8-803a71554d6f@amd.com>
In-Reply-To: <88541b20-6745-28e3-6ba8-803a71554d6f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA2PR11MB5082:EE_
x-ms-office365-filtering-correlation-id: 75757c1d-c03f-45dc-fe7b-08dbd5b78ae6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /5ZTrbEowmsRDXVa/+hyriorcCATV67BsDirLBCP8l+I6iJYIaV5KhdLUVPWBD7VvLFLcnqOJlofmNist4QxvN6U7U6WCD5lXqdGo4Q0zM364+Z89/Zw8oz8mczgxDv81jR25RiIynUETRuIv6sT/6GplmxsP2WezCIAVByjVqgUDaGKmjz3CWVwig+yGplEIHXJ7CZjHskFWeer/M0/DNf8iECBYCOUo1h1qrTibn8UfqLZVjEUT+gDUo+K4XFmT37NU/plZ+urSCg4I9MwP4MNqGAlEtX0UNBmoFaWbZouglzSjFZZ+sodnnv8EmKOlEsPraKLo4j1Rhm5LFLbmHiIe4JueXRcvO9qA16PYnTQvM0MJFXq502xeA2sqxBprLpwvdH0GaYaACd0UUNRbbPv8kQZjQnQMc56vabCvnT5SZdGeLOXKtkQxUz6x9Q5lxcu022ERmFT1nq1k7+exNQqETopeVSM70QPokH2YIuzq0Wvu9eAgc9hDuidW5yPzZh5qAUzfVDDwF2+wLNADTl/5vLfdt7KSjwKN4PwjOmJStf3VaxxUC3ZQmpTX/krQ1id119h0ka0XYsXESurBHOXQqEiDtoyD5lJSHDKUPRFDL0SH4V5mMPYZtqs2eux
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(346002)(39860400002)(366004)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(2906002)(55016003)(38100700002)(52536014)(316002)(66446008)(54906003)(66476007)(64756008)(71200400001)(76116006)(6916009)(122000001)(82960400001)(478600001)(6506007)(66556008)(7696005)(41300700001)(4744005)(9686003)(83380400001)(86362001)(7416002)(5660300002)(33656002)(8676002)(4326008)(8936002)(66946007)(26005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFRCZlQxV2dsbnFKY0lEMStzb3lOOHNsNk9QSVVSWGFuempBNGJIaWdwODFD?=
 =?utf-8?B?SmNOTWVPMXFLT1pXY092MW9KRnFTdTVFenVBemVyQkRnRk1PTDl0bWxSWGtT?=
 =?utf-8?B?dXk0Nk5ya3JwanB4RFlrem4rWVhVMFJMV2Q5aDEwUDBpR3dUSTdNVk4rT3gr?=
 =?utf-8?B?WHRGNlczenpHWGdaMnZiUVlsV25mYVB0VmZTWmlzV1hPRVZRU2NwOGVmRnM3?=
 =?utf-8?B?M3M0ZHlMREh3SkJycnkyaWpESkNTVEVjL0pSQWZuYlM3amtPVkQ1Z21sWEk5?=
 =?utf-8?B?S0dLZm5ublZnWWhXRWRDd1JYZEpGbHJZOGtRU2I1K09rMGFDY3BYUFZxRHdw?=
 =?utf-8?B?MWlWK2xmUFRaN05zUzV1MzU4QXU5YmcwcmpMc3h5Qk1TYzRCSVhjeHBwT3dJ?=
 =?utf-8?B?YVRjQUxseko5ZXpZZHl2b1pDSnhQN3lYZTB4OHowZnhCZWFmMkRBUUlMY0ZY?=
 =?utf-8?B?bTFWT3hkMFBlT25CSUJBYmVKM0MwRWRPaEdPK1Jkam4xMkhKeldOZG1EMDhK?=
 =?utf-8?B?RWxkcDhCYlBid2xmSmlWWlRnMVdaalJERy9wWkNEQS9jQUppTkd0bVB5RnRF?=
 =?utf-8?B?bkJQWjRFZWI0VG9JTktlaDJFNFdEWU5wNzlzVzRBclI3T3RpNjBwckd4VjJl?=
 =?utf-8?B?WlNMa3NZWnc2TitPZUFOVEJ5c0tNeU80WHRDRzlQRitwZTlWZ01hR0crMzcr?=
 =?utf-8?B?RzYreHFRN2tCS1dFQUdWdVZkTTNUWkV2YU5nc3JDRDV2N256SEZhdkVTL1R4?=
 =?utf-8?B?WUwza2ErSXZ5Z1RHNkFsTHEwaUFDeVR6aDVZU1JLQ1JiaDBJVVBYOVJKZm9C?=
 =?utf-8?B?Y2JnVlRScXZHMzh6YVVMQXlUWGtGMnRyQ0lUYkgzNlNKWFNhR1c0Ym01Q0tq?=
 =?utf-8?B?TlhSckxUSkgwYlpkK2xWSFhXM1VFT3pzdlQvN0p4RTBaYmVJVjJsSGlabktU?=
 =?utf-8?B?bG5MRDE3U1IrU0VrVVlBeVBzM09aQ29McDVwQ09aMjlFYk1mdnBXaWF1eFRu?=
 =?utf-8?B?QVRJNnJaS0NVUm0wWXRITXIwa3Rwd2d4cm1PZ1ppMXI1SlRLWVo3OTIvVE1n?=
 =?utf-8?B?bW1xM1ptU29pYzZwYVF1VmVvUllzZ1hnNXJjbXhuR1F0Tm5LQ1BESzBCYSt5?=
 =?utf-8?B?bG95Rm5EWGlVdHh1alVzejNoVml2Z1lCcnRQZ3RXWG5BK0ZmbmNvaTlMRDl0?=
 =?utf-8?B?dyt4cFQ4SExvNDE1a1Q0SldVU2dGL0hzYnFRUjIxb0x4c1JRazVyUjVZNEE5?=
 =?utf-8?B?QzBxTjVvL29EaWFzZ09tcVZaR0U2alVYYXc1cUdIMmNkam5wVjJaK1Y3Z3A3?=
 =?utf-8?B?eVlSb21DSzNIZkVaSmNFeVI0SmJaUXVQYktveTIxNmxMMkNHcXNnUUZoWG9p?=
 =?utf-8?B?ait1UDQ1RkdMeStHZVdkNWJsS2NNUE1sQ0NJOVJYaFZpa08vNjFuTnB0a2Yz?=
 =?utf-8?B?WXA4eGxtRHZxMFd0WkRzNEorUTIrVjVCbXcxVEphSGxrUUxEWTQ1TVgwYmVB?=
 =?utf-8?B?bUVDR2l6UFJmMmFMbmdVMFB1anhxSzNBYllEYzBOV2xXNGM4aUQ3Ykcwendv?=
 =?utf-8?B?RmhqdnhxSG9haDNocmJHTG44RWNzanJWcUkwcUY5KzhzU2J2K0lycmdrRlFZ?=
 =?utf-8?B?WXZYb1N5RUJsTTFpaWp1eGVubnprMGNXckwzK1BkUlg2R1MxaHNZN1RZS2dH?=
 =?utf-8?B?aGpHcG9UOVdHWG9PbkxlV08ybzhweCsrc0VXa24rOFMrV2hHb2VTN1FyS1FW?=
 =?utf-8?B?NGlnR3p5QnB3ak1nNXIxNzlIT25vWWhUS3hpRUQ5VEc5dVZSY2xBZlZpUnYv?=
 =?utf-8?B?WjNRa0s4a3QvczB1KzBHNjBUY1RVTlJ0Tm5lUWduUHhWU2RqeTlxbWxVOTJB?=
 =?utf-8?B?UlhWMnJvSDFkV3BCd3N5R0tmVkQ5UTZqeUM5VGJUKzUwclgvNU9ZTEE3UG9m?=
 =?utf-8?B?M2ROK29IL0xhcWhuTXRqMndabmFiMkFxcnlpWXZMR1NJcno1TVVUZUN0VkEw?=
 =?utf-8?B?NVhpNm94QWZrWVNhbkxxZ2twM0hmQ0FBeTV3d29RbnlQQmhYRm5VOXB0OC95?=
 =?utf-8?B?UjBZaWVCM3Zoc0FSOUtiazN0QmRkS2taV0NzMGVKbi9NT3VLMnhLTzlSNW1r?=
 =?utf-8?Q?PuYx6MwDnW/SgSobcPuKdmxRm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75757c1d-c03f-45dc-fe7b-08dbd5b78ae6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 00:07:28.8735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zrg0+KrHhblu2ogGkBW2bbg92czXpLbvd6jC6McVugCQShbCZNNxR9q9XJhPuY36vjtxlOHYrio7T177d7AxJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5082
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBMZXRzIG5vdCBtYWtlIGl0IGdsb2JhbCB5ZXQuIFRoaXMgaXMgb25seSBhZmZlY3RpbmcgY291
cGxlIG9mIGZ1bmN0aW9ucyANCj4gd2hlbiBtYmFfTVBwcyBpcyBlbmFibGVkLg0KDQpTZWUgdjIg
KGp1c3QgcG9zdGVkKS4gSSBtYWRlIGl0ICJzdGF0aWMiIGluIG1vbml0b3IuYyBzaW5jZSBib3Ro
IHRoZQ0KZnVuY3Rpb25zIHRoYXQgbmVlZCBpdCBhcmUgaW4gdGhhdCBmaWxlLg0KDQo+PiB0aW1l
LiBObyBuZWVkIHRvIGNoZWNrIGV2ZXJ5IHRpbWUgdG8gc2VlIGlmIGlzX21ibV9sb2NhbF9lbmFi
bGVkKCkNCj4+IHNvbWVob3cgY2hhbmdlZCBhbmQgbG9jYWwgYi93IG1lYXN1cmVtZW50cyB3ZXJl
IHN1ZGRlbmx5DQo+PiBhdmFpbGFibGUhDQo+DQo+IFdoYXQgY2hhbmdlZCBzdWRkZW5seT8gQ2Fu
IHlvdSBwbGVhc2UgZWxhYm9yYXRlLg0KDQpOb3RoaW5nIGlzIGdvaW5nIHRvIGNoYW5nZS4gSWYg
dGhlIHN5c3RlbSBkb2Vzbid0IHN1cHBvcnQgbG9jYWwgbWVtb3J5DQpiYW5kd2lkdGggcmVwb3J0
aW5nIHdoZW4gaXQgYm9vdGVkLCBpdCBpc24ndCBnb2luZyB0byBzdGFydCBkb2luZyBzby4NClNh
bWUgaW4gcmV2ZXJzZS4gSWYgeW91IGhhdmUgbG9jYWwgYmFuZHdpZHRoIHJlcG9ydGluZywgaXQg
d29uJ3QNCmdvIGF3YXkuDQoNClNvIGF0IHJlc2N0cmwgaW5pdCB0aW1lIHdoZW4gZGlzY292ZXJp
bmcgd2hpY2ggb2YgbG9jYWwgJiB0b3RhbCBhcmUgc3VwcG9ydGVkLA0KanVzdCBzYXZlIHRoZSBl
dmVudCBpZCB0byB1c2UgZm9yIG1iYV9NQnBzIGF0IHRoYXQgcG9pbnQuDQoNCi1Ub255DQo=
