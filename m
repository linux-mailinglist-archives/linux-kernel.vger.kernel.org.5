Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4494F7EA28F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 19:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjKMSJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 13:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMSJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 13:09:39 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F47DB;
        Mon, 13 Nov 2023 10:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699898975; x=1731434975;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oCPqqTuyXU7hHqvttl9FSkvlJFyayzeXXdrZNPAkKjY=;
  b=JwgoP7vxzM8sBRBJzfG1pycphX150lXUS+Te8z9fRmFJOb5/rUt4NYKS
   ZcRrLkz/FSrwBkTQp3iNDTovNVzFfhr/UpLolaITnYSHdqmZccyoiyj5Y
   epmA0O9rFreblUHdgQZebRTzcz470ch0YTaDoVnC3zNgUNAtCbNKeG2X2
   jp5nuAjKUBxWufo5QQ/+S3XEVm50Rrthr1EFMtWKWHHV8PnKVZYrQSJKk
   rYxpZ0WHYzdiOhksywVmjVef2X7v/cCxIySYh4LiUDrc2ONAuZTEidEPE
   1FcRX91zUgyClqwq0bsl8Eosngk3A17CaSXyMyGE5MzzlNcrhO9BvV1TG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="375515648"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="375515648"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 10:09:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="12527788"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2023 10:09:20 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 10:09:18 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 10:09:16 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 13 Nov 2023 10:09:16 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 13 Nov 2023 10:09:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6P8fUUzllBgH8s+4v17OE0DCOrZG1ok6ONylpOXP5he0d3G5CeR/Zjvt1JlxVcF1mMveVSA4/SCk3oCT3XjBycLUasIfNaMelN5PrGcaQW1bKsLI3b8uEYrgRZk95pd7/HGotPdEwpDbP3yP2HJiisY+3G3M6lUzURW1ESaH8J35MHtshsePr/6AgCypESQVPc62B0KwfpNirchPH2Xow0IwC7XQMp40OquLJkJ89vWQSUb1nybOrNVy9uLZdMy/f2lYNdOCvFST7sb2rLPwmDm4gi4Nyh4cQf8d39hmtmO4fvQyRCBV6Epom30xPk8eGrQQzVKSuDKyWE/VjqDFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCPqqTuyXU7hHqvttl9FSkvlJFyayzeXXdrZNPAkKjY=;
 b=Gqt/LI85qV7V7U48Sw1BJwObXZW9rpXvH0Xbz+Yj0I1IJEKkVeUdBONbk2opbmh3oycyYfJxkyi+6X9t7BJYw1wqEV233Yj5p4K3WqNNvk5HpzS0aoMUyMY7RUhT9L0aHHiOxOnUnKGaYzJN10iuK31pdH+qM1PuvwAo/3vDG1/NWF4t5m741876YSIA/y7YBho+bVepBXoMI1dZgUKLzk/wTWWFWRMz13x0brTseXPPPFEk4pHRmkRJFWCeZUuduAKKzslFJzd1OK7Kg1lGApwDxHuFfDI3PCew0yD0qIlmGwYOtUiQHXg94fJ7cC1LyARfipfoMZ91GKir+uVOYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by PH7PR11MB7593.namprd11.prod.outlook.com (2603:10b6:510:27f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.26; Mon, 13 Nov
 2023 18:09:06 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::6da1:a4b7:4771:14e1]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::6da1:a4b7:4771:14e1%4]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 18:09:05 +0000
From:   "Chiu, Chasel" <chasel.chiu@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     Simon Glass <sjg@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rob Herring" <robh@kernel.org>,
        "Tan, Lean Sheng" <sheng.tan@9elements.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Dhaval Sharma <dhaval@rivosinc.com>,
        "Brune, Maximilian" <maximilian.brune@9elements.com>,
        Yunhui Cui <cuiyunhui@bytedance.com>,
        "Dong, Guo" <guo.dong@intel.com>, Tom Rini <trini@konsulko.com>,
        ron minnich <rminnich@gmail.com>,
        "Guo, Gua" <gua.guo@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        U-Boot Mailing List <u-boot@lists.denx.de>
Subject: RE: [PATCH v7 2/2] schemas: Add some common reserved-memory usages
Thread-Topic: [PATCH v7 2/2] schemas: Add some common reserved-memory usages
Thread-Index: AQHZ8LGvpttG6mvEz0WlU57NBrVnTbB0GT1wgAEi2gCAA4/1oA==
Date:   Mon, 13 Nov 2023 18:09:05 +0000
Message-ID: <BN9PR11MB548303B09536EB1577472029E6B3A@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20230926194242.2732127-1-sjg@chromium.org>
 <20230926194242.2732127-2-sjg@chromium.org>
 <BN9PR11MB5483FF3039913334C7EA83E1E6AEA@BN9PR11MB5483.namprd11.prod.outlook.com>
 <CAMj1kXFG92NpL7T7YocOup0xLKyopt3MnSCp0RL8cLzozzJz7A@mail.gmail.com>
In-Reply-To: <CAMj1kXFG92NpL7T7YocOup0xLKyopt3MnSCp0RL8cLzozzJz7A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5483:EE_|PH7PR11MB7593:EE_
x-ms-office365-filtering-correlation-id: 781c6217-171e-4b37-58f6-08dbe4739fe8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H5IqpNAKgoASdbvP6g5zZ9kAxFkkZF/f89LfFzkMo+uL+Cl1YSmuEsG+oq0LL9x44L6iI8qtCS2ksBzsxDc9PY2ym2kKms25IoFkZr6teBudAEIS9uMp6h470XgXjLOJxvGw7rP2bEp2+arFpfaWtBEe2q1AJ48606OpfOhIA1/anOINp9FEiytw2hNM6kh+M86g8A+L52OIYINgmghSadv95/LCFxvldikb9bPLt7ar5mQpOnX/+tjepbLnB3P1Ylce01H5G31OFit9pzTlBXCLtEWvWHdS0sKY+5/sY3J4FE4Cu9Pif8YAMymNgmu86sYGlsZIDXiKYRz5xdFM/qDrVva7eKSQ806rkfRac6V1+H0LTwXbUuDweUqfFEQydu7cl5AWQGot7MV37aJZwFWCSKoEdmNjL1awVGFHx+2cEHXBwvW18llWrrY8h6v0xfF5fDbn2DfXBiLtRfYlyzWBNlX9I7XA2kHYaHM4fCUb1QeIbl8SLRVDKAB06HT1lrUDkBgFMRoDnC3MkiXvu6HKVApN+g9ThtLxVkQyxGdmySb5KcTHkFvSkri/kLmItIx4r1xDU6DEhgh9FA1mFoejwwwU9kzo8ABjcgnCz+M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(396003)(376002)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(316002)(55016003)(54906003)(9686003)(6916009)(66476007)(66446008)(76116006)(66946007)(66556008)(83380400001)(38100700002)(64756008)(82960400001)(8676002)(8936002)(4326008)(122000001)(478600001)(966005)(6506007)(53546011)(7696005)(52536014)(5660300002)(86362001)(71200400001)(7416002)(38070700009)(2906002)(26005)(33656002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlVtNUNEdi9NWkpCODVQdWROK2ZuUzNwTWtZYUhnUjR3RFd2MzNscVRxdW5u?=
 =?utf-8?B?NHVOaG13dkdFTEF1MVZ3cmcrNXE1TkZXa3FSUk0xRnRUMVo3VktuRFhuaVU1?=
 =?utf-8?B?R0NxK1poNTZKRkVOOFQwTVQxVFpFZUtPL3UwYWY2b3VGc0k2ZFRiT0hucGNn?=
 =?utf-8?B?UkhrY2FzcldoUkpHZGRaczh5WWl6Zk1SaGNKaEpkdjF3VWdzVTFxQ0hMUEpX?=
 =?utf-8?B?SWlFbERKVFJRN0NrR1VTMnFZNHd3Z2JGZ3d3Z2dqZmpOM05yYzNnNFArK0VY?=
 =?utf-8?B?YmJlRzRMbGFZcVJ2ZTVFZmFvcXF0dWh4K0tYUytjbkdtNTlYTzhrY1FtZ1o4?=
 =?utf-8?B?and3c3V0aGRJRm8yR2dad1MrYlJQUFo1bTRwR0toOXdTL3EzdENIbDB2Y0FQ?=
 =?utf-8?B?T1NkMnluWTNJNnMxekVlMWpHRy8xM1BuZ0tIOFpwQzJLRHF1WHk5Y00vVVNj?=
 =?utf-8?B?SzB5UTNpR0RWV0w1Wm1iQTVPNWsrS0JYV2UzMUlXdy9oK2MrSzFrNEgzY284?=
 =?utf-8?B?Zi9QaitvRHV5QVlVYjdmVFM1TjNnY1JZYXg1d3gwcmpZM1N0OFdQYkZrcTds?=
 =?utf-8?B?MEpLSDk3ZmFYQXAzaTU3aTFtQ2xTa1ZHWEJXSm1MdXpGcTNJQk9MSXNBRU4v?=
 =?utf-8?B?cXVoRnFkQldNZmRka1dnZXdidE4xMXdWTndiYTVwZ1BoZFVmNFVKK2x4Z1Mx?=
 =?utf-8?B?b3Vhb2tDK08rRnk2SjNOKzh4a0Y0WEhVUGJpcWkrNEdHR1FQRWhzcTlsdXBH?=
 =?utf-8?B?aDRRUnVVM1lHSXpPOFRFbEVzMDI0dFNZKzk0V0R5OVFhczlWT0tEREIzbHA4?=
 =?utf-8?B?RVE0ZzRxcEJZNnVxK0Uza0VCVnpwejMxOVl6bUNLNHhRc2dMWGdqcVlZQzZm?=
 =?utf-8?B?V2hGd2dYOFh0aWZreEFoNEFTS0JyZU5mbzF0dXlmelllOFA1d0ZscC81d1E3?=
 =?utf-8?B?L05FNjFvZnhrOVBtTzVqbjBPVXpvOFlNWmVJMC9rbDZFOVZ5UDhZT2d4b2Jv?=
 =?utf-8?B?MFBYR2c4RnN4bk52aFNYME1Yc3RRSFhwdi9Ec2lkOHVCbytpS0VFaG1IUFJW?=
 =?utf-8?B?NFp1enI3bytXU2oyWmtRMzNVMjF5aEJlL3ZGd2dyUzgxdEp3OHhKcFAyYWhE?=
 =?utf-8?B?NWRveXQzS3FnL1RWMmJDR2Nsa2xtNExDMWc0ZXRaUmhuQlJUWTNkTXNZZ3d6?=
 =?utf-8?B?RGdpVitOcko1SHdScy9VWXBhZEhWc28xMDUxMFdWaG5VWnR4Z0FUSVhVZTlX?=
 =?utf-8?B?N0I1Q2FSVjVBWGY0WDZkSjJRUTdaOFlRNFdZU2l2aEp1K05wVGdwa0tHRGpY?=
 =?utf-8?B?ZGJkeEZldFJOcmlhZHZqSXZ5bm9rS1J2N0ppbjIvcGw3VWdraXdNQVIwWHpa?=
 =?utf-8?B?enY1dlEvWHZ3cVhKeHBBL01oREdPU0RWQkc2TG9rSHdkaEQvSzlMUG1GeUpj?=
 =?utf-8?B?U25DaEpNUlZsZGNrNUtuaFJEK2lZMHlUdDlQNFA0RjZSVlRodFZBUkt4ZVlT?=
 =?utf-8?B?cFU0dEVIQTROcmdwTCtDNFhJc1FnaEY1cmdaYUxUdDJ5dS9uUDAvMXFubTln?=
 =?utf-8?B?bEZtOFpQM3g0cmIydTI0Z2Z6YVpvS2hiekpwNFk5ZGpUb2E0RlZuVXVPaDFq?=
 =?utf-8?B?RXg0QklVWHNleUdHbnRZSEY3c0F1Y3Z6K0hjWGNnRkF5YzBLWTRBeXB4VlB5?=
 =?utf-8?B?ZkRlczRkWUgzUmRUbHBBMEpUTHpJcVViUGFSc2dLek9vZVEzN29FRUI1S2VG?=
 =?utf-8?B?d1Q2NUdUVC9peVhGMUorSmtTaXVSZzcwV2FPdDB3TlQxdkF5WjhMaXcwOWRQ?=
 =?utf-8?B?aUN4Q2E2TlV4NnhhYUtIdGxQRFJIS2JoM0JjUW9RVjNGWlpZeS9pM2Z1QlBS?=
 =?utf-8?B?RmtuUFhGV3ZwNTB5ekt0Ukc0V2VxL1lHZlhYUTk0YXQ3OWxhZG5Cd01RRytW?=
 =?utf-8?B?MGZDR2s3QUNtVTRqVVBFQTAzN3Y0YldUK2lldFd4UGwvRUtVeDh5ZnF0eE12?=
 =?utf-8?B?L3JhUjZxdDBkd3JOT1I4Y1pobzZPRlcyZ0NHOXZCTExwNkJKbWZHK1pRWlJK?=
 =?utf-8?B?WUNvdGVuMVdhY1EzbmZvR0pmV3ZzZi9BdWppczNYdmZIRUtoTVJ4MnQ1MnBR?=
 =?utf-8?Q?POnrwbbdVfrX0AHr6QDYfXVZw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 781c6217-171e-4b37-58f6-08dbe4739fe8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2023 18:09:05.7306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ekS46u9ymapPlqEp6Z03rfiUln+CftsXdHf3hMs3i2rhzMFjvJ6WDv8hBSUhipfKiBrPuvij3LfhfvUaTN6Gpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7593
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBBcmQsDQoNClBsZWFzZSBzZWUgbXkgcmVwbHkgYmVsb3cgaW5saW5lLg0KDQpUaGFua3Ms
DQpDaGFzZWwNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFyZCBC
aWVzaGV1dmVsIDxhcmRiQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFNhdHVyZGF5LCBOb3ZlbWJlciAx
MSwgMjAyMyAzOjA0IEFNDQo+IFRvOiBDaGl1LCBDaGFzZWwgPGNoYXNlbC5jaGl1QGludGVsLmNv
bT4NCj4gQ2M6IFNpbW9uIEdsYXNzIDxzamdAY2hyb21pdW0ub3JnPjsgZGV2aWNldHJlZUB2Z2Vy
Lmtlcm5lbC5vcmc7IE1hcmsgUnV0bGFuZA0KPiA8bWFyay5ydXRsYW5kQGFybS5jb20+OyBSb2Ig
SGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsgVGFuLCBMZWFuIFNoZW5nDQo+IDxzaGVuZy50YW5A
OWVsZW1lbnRzLmNvbT47IGxrbWwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBEaGF2
YWwNCj4gU2hhcm1hIDxkaGF2YWxAcml2b3NpbmMuY29tPjsgQnJ1bmUsIE1heGltaWxpYW4NCj4g
PG1heGltaWxpYW4uYnJ1bmVAOWVsZW1lbnRzLmNvbT47IFl1bmh1aSBDdWkgPGN1aXl1bmh1aUBi
eXRlZGFuY2UuY29tPjsNCj4gRG9uZywgR3VvIDxndW8uZG9uZ0BpbnRlbC5jb20+OyBUb20gUmlu
aSA8dHJpbmlAa29uc3Vsa28uY29tPjsgcm9uIG1pbm5pY2gNCj4gPHJtaW5uaWNoQGdtYWlsLmNv
bT47IEd1bywgR3VhIDxndWEuZ3VvQGludGVsLmNvbT47IGxpbnV4LQ0KPiBhY3BpQHZnZXIua2Vy
bmVsLm9yZzsgVS1Cb290IE1haWxpbmcgTGlzdCA8dS1ib290QGxpc3RzLmRlbnguZGU+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjcgMi8yXSBzY2hlbWFzOiBBZGQgc29tZSBjb21tb24gcmVzZXJ2
ZWQtbWVtb3J5DQo+IHVzYWdlcw0KPiANCj4gT24gU2F0LCAxMSBOb3YgMjAyMyBhdCAwNDoyMCwg
Q2hpdSwgQ2hhc2VsIDxjaGFzZWwuY2hpdUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4NCj4g
PiBKdXN0IHNoYXJpbmcgc29tZSB1c2FnZSBleGFtcGxlcyBmcm9tIFVFRkkvRURLMiBzY2VuYXJp
by4NCj4gPiBUbyBzdXBwb3J0IEFDUEkgUzQvSGliZXJuYXRpb24sIG1lbW9yeSBtYXAgbXVzdCBi
ZSBjb25zaXN0ZW50IGJlZm9yZQ0KPiA+IGVudGVyaW5nIGFuZCBhZnRlciByZXN1bWluZyBmcm9t
IFM0LCBpbiB0aGlzIGNhc2UgcGF5bG9hZCBtYXkgbmVlZCB0bw0KPiA+IGtub3cgcHJldmlvdXMg
bWVtb3J5IG1hcCBmcm9tIGJvb3Rsb2FkZXIgKGN1cnJlbnRseSBnZW5lcmljIHBheWxvYWQNCj4g
PiBjYW5ub3QgYWNjZXNzIHBsYXRmb3JtL2Jvb3Rsb2FkZXIgc3BlY2lmaWMgbm9uLXZvbGF0aWxl
IGRhdGEsIHRodXMNCj4gPiBjb3VsZCBub3Qgc2F2ZS9yZXN0b3JlIG1lbW9yeSBtYXAgaW5mb3Jt
YXRpb24pDQo+IA0KPiBTbyBob3cgd291bGQgRURLMiByZWNvbnN0cnVjdCB0aGUgZW50aXJlIEVG
SSBtZW1vcnkgbWFwIGZyb20ganVzdCB0aGVzZQ0KPiB1bmFubm90YXRlZCAvcmVzZXJ2ZWQtbWVt
b3J5IG5vZGVzPyBUaGUgRUZJIG1lbW9yeSBtYXAgY29udGFpbnMgbXVjaA0KPiBtb3JlIGluZm9y
bWF0aW9uIHRoYW4gdGhhdCwgYW5kIGFsbCBvZiBpdCBoYXMgdG8gbWF0Y2ggdGhlIHByZS1oaWJl
cm5hdGUgc2l0dWF0aW9uLA0KPiByaWdodD8gQ2FuIHlvdSBnaXZlbiBhbiBleGFtcGxlPw0KDQoN
CkhlcmUgd2UgbGlzdGVkIG9ubHkgdHlwaWNhbGx5IG1lbW9yeSB0eXBlcyB0aGF0IG1heSBjaGFu
Z2UgY3Jvc3MgZGlmZmVyZW50IHBsYXRmb3Jtcy4NClJlc2VydmVkIG1lbW9yeSB0eXBlIGFscmVh
ZHkgY2FuIGJlIGhhbmRsZWQgYnkgcmVzZXJ2ZWQtbWVtb3J5IG5vZGUsIGFuZCByZXN0IG9mIHRo
ZSB0eXBlcyB1c3VhbGx5IG5vIG5lZWQgdG8gY2hhbmdlIGNyb3NzIHBsYXRmb3JtcyB0aHVzIGN1
cnJlbnRseSB3ZSBjb3VsZCByZWx5IG9uIGRlZmF1bHQgaW4gZ2VuZXJpYyBwYXlsb2FkLg0KSW4g
dGhlIGZ1dHVyZSBpZiB3ZSBzZWUgYSBuZWVkIHRvIGFkZCBuZXcgbWVtb3J5IHR5cGVzIHdlIHdp
bGwgZGlzY3VzcyBhbmQgYWRkIGl0IHRvIEZEVCBzY2hlbWEuDQoNCg0KDQo+IA0KPiA+IEFub3Ro
ZXIgdXNhZ2UgaXMgdG8gc3VwcG9ydCBiaW5hcnkgbW9kZWwgd2hpY2ggZ2VuZXJpYyBwYXlsb2Fk
IGlzIGEgcHJlYnVpbHQNCj4gYmluYXJ5IGNvbXBhdGlibGUgZm9yIGFsbCBwbGF0Zm9ybXMvY29u
ZmlndXJhdGlvbnMsIGhvd2V2ZXIgdGhlIHBheWxvYWQgZGVmYXVsdA0KPiBtZW1vcnkgbWFwIG1p
Z2h0IG5vdCBhbHdheXMgd29yayBmb3IgYWxsIHRoZSBjb25maWd1cmF0aW9ucyBhbmQgd2Ugd2Fu
dCB0bw0KPiBhbGxvdyBib290bG9hZGVyIHRvIG92ZXJyaWRlIHBheWxvYWQgZGVmYXVsdCBtZW1v
cnkgbWFwIHdpdGhvdXQgcmVjb21waWxpbmcuDQo+ID4NCj4gDQo+IEFncmVlZC4gQnV0IGNhbiB5
b3UgZXhwbGFpbiBob3cgYSBFREsyIHBheWxvYWQgbWlnaHQgbWFrZSBtZWFuaW5nZnVsIHVzZSBv
Zg0KPiAncnVudGltZS1jb2RlJyByZWdpb25zIHByb3ZpZGVkIHZpYSBEVCAgYnkgdGhlIG5vbi1F
REsyIHBsYXRmb3JtIGluaXQ/IENhbiB5b3UNCj4gZ2l2ZSBhbiBleGFtcGxlPw0KDQoNClJ1bnRp
bWUtY29kZS9kYXRhIGlzIHVzZWQgYnkgVUVGSSBwYXlsb2FkIGZvciBib290aW5nIFVFRkkgT1Mg
d2hpY2ggcmVxdWlyZWQgVUVGSSBydW50aW1lIHNlcnZpY2VzLg0KUGxhdGZvcm0gSW5pdCB3aWxs
IHNlbGVjdCBzb21lIHJlZ2lvbnMgZnJvbSB0aGUgdXNhYmxlIG1lbW9yeSBhbmQgYXNzaWduIGl0
IHRvIHJ1bnRpbWUtY29kZS9kYXRhIGZvciBVUEwgdG8gY29uc3VtZS4gT3IgYXNzaWduIHNhbWUg
cnVudGltZS1jb2RlL2RhdGEgZnJvbSBwcmV2aW91cyBib290Lg0KSWYgVUVGSSBPUyBpcyBub3Qg
c3VwcG9ydGVkLCBQbGF0Zm9ybUluaXQgbWF5IG5vdCBuZWVkIHRvIHByb3ZpZGUgcnVudGltZS1j
b2RlL2RhdGEgcmVnaW9ucyB0byBwYXlsb2FkLiAoYWx3YXlzIHByb3ZpZGluZyBydW50aW1lLWNv
ZGUvZGF0YSBzaG91bGQgYmUgc3VwcG9ydGVkIHRvbykNCg0KDQo+IA0KPiA+IFVuZGVyIGJlbG93
IGFzc3VtcHRpb246DQo+ID4gICAgICAgICBGRFQgT1MgaW1wYWN0IGhhcyBiZWVuIGV2YWx1YXRl
ZCBhbmQgdGFrZW4gY2FyZSBieSByZWxldmFudA0KPiBleHBlcnRzL3N0YWtlaG9sZGVycy4NCj4g
PiBSZXZpZXdlZC1ieTogQ2hhc2VsIENoaXUgPGNoYXNlbC5jaGl1QGludGVsLmNvbT4NCj4gPg0K
PiANCj4gSSBhbSBzb3JyeSBidXQgSSBkb24ndCBrbm93IHdoYXQgJ0ZEVCBPUyBpbXBhY3QnIG1l
YW5zLiBXZSBhcmUgdGFsa2luZyBhYm91dCBhDQo+IGZpcm13YXJlLXRvLWZpcm13YXJlIGFic3Ry
YWN0aW9uIHRoYXQgaGFzIHRoZSBwb3RlbnRpYWwgdG8gbGVhayBpbnRvIHRoZSBPUw0KPiB2aXNp
YmxlIGludGVyZmFjZS4NCj4gDQo+IEkgYW0gYSBtYWludGFpbmVyIGluIHRoZSBUaWFub2NvcmUg
cHJvamVjdCBteXNlbGYsIHNvIGl0IHdvdWxkIGhlbHAgaWYgeW91IGNvdWxkDQo+IGV4cGxhaW4g
d2hvIHRoZXNlIHJlbGV2YW50IGV4cGVydHMgYW5kIHN0YWtlaG9sZGVycyBhcmUuIFdhcyB0aGlz
IGRpc2N1c3NlZCBvbg0KPiB0aGUgZWRrMi1kZXZlbCBtYWlsaW5nIGxpc3Q/IElmIHNvLCBhcG9s
b2dpZXMgZm9yIG1pc3NpbmcgaXQgYnV0IEkgbWF5IG5vdCBoYXZlIGJlZW4NCj4gY2MnZWQgcGVy
aGFwcz8NCg0KDQoNCg0KSSdtIG5vdCBmYW1pbGlhciB3aXRoIEZEVCBPUywgYWxzbyBJIGRvIG5v
dCBrbm93IGlmIHdobyBmcm9tIGVkazItZGV2ZWwgd2VyZSBzdXBwb3J0aW5nIEZEVCBPUywgSSB0
aGluayBTaW1vbiBtaWdodCBiZSBhYmxlIHRvIGNvbm5lY3QgRkRUIE9TIGV4cGVydHMvc3Rha2Vo
b2xkZXJzLg0KV2UgYXJlIG1vc3RseSBmb2N1c2luZyBvbiBwYXlsb2FkIGZpcm13YXJlIHBoYXNl
IGltcGxlbWVudGF0aW9uIGluIGVkazIgKGFuZCBvdGhlciBwYXlsb2FkcyB0b28pLCBob3dldmVy
LCBzaW5jZSB3ZSBoYXZlIGFsaWduZWQgdGhlIHBheWxvYWQgRkRUIGFuZCBPUyBGRFQgbW9udGhz
IGFnbywgSSdtIGFzc3VtaW5nIEZEVCBPUyBpbXBhY3QgbXVzdCBiZSB0aGVyZSBhbmQgd2UgbmVl
ZCAob3IgYWxyZWFkeSBkb25lPykgRkRUIE9TIGV4cGVydHMgdG8gc3VwcG9ydCBpdC4gKGFnYWlu
LCBtYXliZSBTaW1vbiBjb3VsZCBzaGFyZSBtb3JlIGluZm9ybWF0aW9uIGFib3V0IEZEVCBPUykg
DQoNCkluIGVkazIgc3VjaCBGRFQgc2NoZW1hIGlzIFVlZmlQYXlsb2FkUGtnIGludGVybmFsIHVz
YWdlIG9ubHkgYW5kIHBheWxvYWQgZW50cnkgd2lsbCBjb252ZXJ0IEZEVCBpbnRvIEhPQiB0aHVz
IHdlIGV4cGVjdGVkIHRoZSBtb3N0IG9mIHRoZSBlZGsyIGdlbmVyaWMgY29kZSBhcmUgbm8tdG91
Y2gvbm8gaW1wYWN0LCB0aGF0J3Mgd2h5IHdlIG9ubHkgaGFkIHNtYWxsIGdyb3VwIChVZWZpUGF5
bG9hZFBrZykgZGlzY3Vzc2lvbi4NCkFyZCwgaWYgeW91IGFyZSBhd2FyZSBvZiBhbnkgZWRrMiBj
b2RlIHRoYXQncyBmb3Igc3VwcG9ydGluZyBGRFQgT1MsIHBsZWFzZSBsZXQgdXMga25vdyBhbmQg
d2UgY2FuIGRpc2N1c3MgaWYgdGhvc2UgY29kZSB3ZXJlIGltcGFjdGVkIG9yIG5vdC4NCg0KDQoN
Cg0KPiANCj4gDQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBG
cm9tOiBTaW1vbiBHbGFzcyA8c2pnQGNocm9taXVtLm9yZz4NCj4gPiA+IFNlbnQ6IFR1ZXNkYXks
IFNlcHRlbWJlciAyNiwgMjAyMyAxMjo0MyBQTQ0KPiA+ID4gVG86IGRldmljZXRyZWVAdmdlci5r
ZXJuZWwub3JnDQo+ID4gPiBDYzogTWFyayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT47
IFJvYiBIZXJyaW5nDQo+ID4gPiA8cm9iaEBrZXJuZWwub3JnPjsgVGFuLCBMZWFuIFNoZW5nIDxz
aGVuZy50YW5AOWVsZW1lbnRzLmNvbT47IGxrbWwNCj4gPiA+IDxsaW51eC0ga2VybmVsQHZnZXIu
a2VybmVsLm9yZz47IERoYXZhbCBTaGFybWENCj4gPiA+IDxkaGF2YWxAcml2b3NpbmMuY29tPjsg
QnJ1bmUsIE1heGltaWxpYW4NCj4gPiA+IDxtYXhpbWlsaWFuLmJydW5lQDllbGVtZW50cy5jb20+
OyBZdW5odWkgQ3VpDQo+ID4gPiA8Y3VpeXVuaHVpQGJ5dGVkYW5jZS5jb20+OyBEb25nLCBHdW8g
PGd1by5kb25nQGludGVsLmNvbT47IFRvbSBSaW5pDQo+ID4gPiA8dHJpbmlAa29uc3Vsa28uY29t
Pjsgcm9uIG1pbm5pY2ggPHJtaW5uaWNoQGdtYWlsLmNvbT47IEd1bywgR3VhDQo+ID4gPiA8Z3Vh
Lmd1b0BpbnRlbC5jb20+OyBDaGl1LCBDaGFzZWwgPGNoYXNlbC5jaGl1QGludGVsLmNvbT47IGxp
bnV4LQ0KPiA+ID4gYWNwaUB2Z2VyLmtlcm5lbC5vcmc7IFUtQm9vdCBNYWlsaW5nIExpc3QgPHUt
Ym9vdEBsaXN0cy5kZW54LmRlPjsNCj4gPiA+IEFyZCBCaWVzaGV1dmVsIDxhcmRiQGtlcm5lbC5v
cmc+OyBTaW1vbiBHbGFzcyA8c2pnQGNocm9taXVtLm9yZz4NCj4gPiA+IFN1YmplY3Q6IFtQQVRD
SCB2NyAyLzJdIHNjaGVtYXM6IEFkZCBzb21lIGNvbW1vbiByZXNlcnZlZC1tZW1vcnkNCj4gPiA+
IHVzYWdlcw0KPiA+ID4NCj4gPiA+IEl0IGlzIGNvbW1vbiB0byBzcGxpdCBmaXJtd2FyZSBpbnRv
ICdQbGF0Zm9ybSBJbml0Jywgd2hpY2ggZG9lcyB0aGUNCj4gPiA+IGluaXRpYWwgaGFyZHdhcmUg
c2V0dXAgYW5kIGEgIlBheWxvYWQiIHdoaWNoIHNlbGVjdHMgdGhlIE9TIHRvIGJlIGJvb3RlZC4N
Cj4gPiA+IFRodXMgYW4gaGFuZG92ZXIgaW50ZXJmYWNlIGlzIHJlcXVpcmVkIGJldHdlZW4gdGhl
c2UgdHdvIHBpZWNlcy4NCj4gPiA+DQo+ID4gPiBXaGVyZSBVRUZJIGJvb3QtdGltZSBzZXJ2aWNl
cyBhcmUgbm90IGF2YWlsYWJsZSwgYnV0IFVFRkkgZmlybXdhcmUNCj4gPiA+IGlzIHByZXNlbnQg
b24gZWl0aGVyIHNpZGUgb2YgdGhpcyBpbnRlcmZhY2UsIGluZm9ybWF0aW9uIGFib3V0DQo+ID4g
PiBtZW1vcnkgdXNhZ2UgYW5kIGF0dHJpYnV0ZXMgbXVzdCBiZSBwcmVzZW50ZWQgdG8gdGhlICJQ
YXlsb2FkIiBpbiBzb21lDQo+IGZvcm0uDQo+ID4gPg0KPiA+ID4gVGhpcyBhaW1zIHRvIHByb3Zp
ZGUgYW4gc21hbGwgc2NoZW1hIGFkZGl0aW9uIGZvciB0aGUgbWVtb3J5IG1hcHBpbmcNCj4gPiA+
IG5lZWRlZCB0byBrZWVwIHRoZXNlIHR3byBwaWVjZXMgd29ya2luZyB0b2dldGhlciB3ZWxsLg0K
PiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFNpbW9uIEdsYXNzIDxzamdAY2hyb21pdW0ub3Jn
Pg0KPiA+ID4gLS0tDQo+ID4gPg0KPiA+ID4gQ2hhbmdlcyBpbiB2NzoNCj4gPiA+IC0gUmVuYW1l
IGFjcGktcmVjbGFpbSB0byBhY3BpDQo+ID4gPiAtIERyb3AgaW5kaXZpZHVhbCBtZW50aW9uIG9m
IHdoZW4gbWVtb3J5IGNhbiBiZSByZWNsYWltZWQNCj4gPiA+IC0gUmV3cml0ZSB0aGUgaXRlbSBk
ZXNjcmlwdGlvbnMNCj4gPiA+IC0gQWRkIGJhY2sgdGhlIFVFRkkgdGV4dCAod2l0aCB0cmVwaWRh
dGlvbikNCj4gPiA+DQo+ID4gPiBDaGFuZ2VzIGluIHY2Og0KPiA+ID4gLSBEcm9wIG1lbnRpb24g
b2YgVUVGSQ0KPiA+ID4gLSBVc2UgY29tcGF0aWJsZSBzdHJpbmdzIGluc3RlYWQgb2Ygbm9kZSBu
YW1lcw0KPiA+ID4NCj4gPiA+IENoYW5nZXMgaW4gdjU6DQo+ID4gPiAtIERyb3AgdGhlIG1lbW9y
eS1tYXAgbm9kZSAoc2hvdWxkIGhhdmUgZG9uZSB0aGF0IGluIHY0KQ0KPiA+ID4gLSBUaWR5IHVw
IHNjaGVtYSBhIGJpdA0KPiA+ID4NCj4gPiA+IENoYW5nZXMgaW4gdjQ6DQo+ID4gPiAtIE1ha2Ug
dXNlIG9mIHRoZSByZXNlcnZlZC1tZW1vcnkgbm9kZSBpbnN0ZWFkIG9mIGNyZWF0aW5nIGEgbmV3
IG9uZQ0KPiA+ID4NCj4gPiA+IENoYW5nZXMgaW4gdjM6DQo+ID4gPiAtIFJld29yZCBjb21taXQg
bWVzc2FnZSBhZ2Fpbg0KPiA+ID4gLSBjYyBhIGxvdCBtb3JlIHBlb3BsZSwgZnJvbSB0aGUgRkZJ
IHBhdGNoDQo+ID4gPiAtIFNwbGl0IG91dCB0aGUgYXR0cmlidXRlcyBpbnRvIHRoZSAvbWVtb3J5
IG5vZGVzDQo+ID4gPg0KPiA+ID4gQ2hhbmdlcyBpbiB2MjoNCj4gPiA+IC0gUmV3b3JkIGNvbW1p
dCBtZXNzYWdlDQo+ID4gPg0KPiA+ID4gIC4uLi9yZXNlcnZlZC1tZW1vcnkvY29tbW9uLXJlc2Vy
dmVkLnlhbWwgICAgICB8IDcxICsrKysrKysrKysrKysrKysrKysNCj4gPiA+ICAxIGZpbGUgY2hh
bmdlZCwgNzEgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkdHNjaGVt
YS9zY2hlbWFzL3Jlc2VydmVkLW1lbW9yeS9jb21tb24tDQo+ID4gPiByZXNlcnZlZC55YW1sDQo+
ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2R0c2NoZW1hL3NjaGVtYXMvcmVzZXJ2ZWQtbWVtb3J5
L2NvbW1vbi1yZXNlcnZlZC55YW1sDQo+ID4gPiBiL2R0c2NoZW1hL3NjaGVtYXMvcmVzZXJ2ZWQt
bWVtb3J5L2NvbW1vbi1yZXNlcnZlZC55YW1sDQo+ID4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0K
PiA+ID4gaW5kZXggMDAwMDAwMC4uZjdmYmRmZA0KPiA+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ID4g
KysrIGIvZHRzY2hlbWEvc2NoZW1hcy9yZXNlcnZlZC1tZW1vcnkvY29tbW9uLXJlc2VydmVkLnlh
bWwNCj4gPiA+IEBAIC0wLDAgKzEsNzEgQEANCj4gPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiBHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlICVZQU1MIDEuMg0KPiA+ID4gKy0tLQ0K
PiA+ID4gKyRpZDoNCj4gPiA+ICtodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9yZXNlcnZl
ZC1tZW1vcnkvY29tbW9uLXJlc2VydmVkLnlhbWwjDQo+ID4gPiArJHNjaGVtYTogaHR0cDovL2Rl
dmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ID4gPiArDQo+ID4gPiArdGl0
bGU6IENvbW1vbiBtZW1vcnkgcmVzZXJ2YXRpb25zDQo+ID4gPiArDQo+ID4gPiArZGVzY3JpcHRp
b246IHwNCj4gPiA+ICsgIFNwZWNpZmllcyB0aGF0IHRoZSByZXNlcnZlZCBtZW1vcnkgcmVnaW9u
IGNhbiBiZSB1c2VkIGZvciB0aGUNCj4gPiA+ICtwdXJwb3NlDQo+ID4gPiArICBpbmRpY2F0ZWQg
YnkgaXRzIGNvbXBhdGlibGUgc3RyaW5nLg0KPiA+ID4gKw0KPiA+ID4gKyAgQ2xpZW50cyBtYXkg
cmV1c2UgdGhpcyByZXNlcnZlZCBtZW1vcnkgaWYgdGhleSB1bmRlcnN0YW5kIHdoYXQgaXQNCj4g
PiA+ICsgaXMgZm9yLCAgc3ViamVjdCB0byB0aGUgbm90ZXMgYmVsb3cuDQo+ID4gPiArDQo+ID4g
PiArbWFpbnRhaW5lcnM6DQo+ID4gPiArICAtIFNpbW9uIEdsYXNzIDxzamdAY2hyb21pdW0ub3Jn
Pg0KPiA+ID4gKw0KPiA+ID4gK2FsbE9mOg0KPiA+ID4gKyAgLSAkcmVmOiByZXNlcnZlZC1tZW1v
cnkueWFtbA0KPiA+ID4gKw0KPiA+ID4gK3Byb3BlcnRpZXM6DQo+ID4gPiArICBjb21wYXRpYmxl
Og0KPiA+ID4gKyAgICBkZXNjcmlwdGlvbjogfA0KPiA+ID4gKyAgICAgIFRoaXMgZGVzY3JpYmVz
IHNvbWUgY29tbW9uIG1lbW9yeSByZXNlcnZhdGlvbnMsIHdpdGggdGhlIGNvbXBhdGlibGUNCj4g
PiA+ICsgICAgICBzdHJpbmcgaW5kaWNhdGluZyB3aGF0IGl0IGlzIHVzZWQgZm9yOg0KPiA+ID4g
Kw0KPiA+ID4gKyAgICAgICAgIGFjcGk6IEFkdmFuY2VkIENvbmZpZ3VyYXRpb24gYW5kIFBvd2Vy
IEludGVyZmFjZSAoQUNQSSkgdGFibGVzDQo+ID4gPiArICAgICAgICAgYWNwaS1udnM6IEFDUEkg
Tm9uLVZvbGF0aWxlLVNsZWVwaW5nIE1lbW9yeSAoTlZTKS4gVGhpcyBpcyByZXNlcnZlZCBieQ0K
PiA+ID4gKyAgICAgICAgICAgdGhlIGZpcm13YXJlIGZvciBpdHMgdXNlIGFuZCBpcyByZXF1aXJl
ZCB0byBiZSBzYXZlZCBhbmQgcmVzdG9yZWQNCj4gPiA+ICsgICAgICAgICAgIGFjcm9zcyBhbiBO
VlMgc2xlZXANCj4gPiA+ICsgICAgICAgICBib290LWNvZGU6IENvbnRhaW5zIGNvZGUgdXNlZCBm
b3IgYm9vdGluZyB3aGljaCBpcyBub3QgbmVlZGVkIGJ5IHRoZQ0KPiBPUw0KPiA+ID4gKyAgICAg
ICAgIGJvb3QtY29kZTogQ29udGFpbnMgZGF0YSB1c2VkIGZvciBib290aW5nIHdoaWNoIGlzIG5v
dCBuZWVkZWQgYnkgdGhlDQo+IE9TDQo+ID4gPiArICAgICAgICAgcnVudGltZS1jb2RlOiBDb250
YWlucyBjb2RlIHVzZWQgZm9yIGludGVyYWN0aW5nIHdpdGggdGhlIHN5c3RlbSB3aGVuDQo+ID4g
PiArICAgICAgICAgICBydW5uaW5nIHRoZSBPUw0KPiA+ID4gKyAgICAgICAgIHJ1bnRpbWUtZGF0
YTogQ29udGFpbnMgZGF0YSB1c2VkIGZvciBpbnRlcmFjdGluZyB3aXRoIHRoZSBzeXN0ZW0gd2hl
bg0KPiA+ID4gKyAgICAgICAgICAgcnVubmluZyB0aGUgT1MNCj4gPiA+ICsNCj4gPiA+ICsgICAg
ZW51bToNCj4gPiA+ICsgICAgICAtIGFjcGkNCj4gPiA+ICsgICAgICAtIGFjcGktbnZzDQo+ID4g
PiArICAgICAgLSBib290LWNvZGUNCj4gPiA+ICsgICAgICAtIGJvb3QtZGF0YQ0KPiA+ID4gKyAg
ICAgIC0gcnVudGltZS1jb2RlDQo+ID4gPiArICAgICAgLSBydW50aW1lLWRhdGENCj4gPiA+ICsN
Cj4gPiA+ICsgIHJlZzoNCj4gPiA+ICsgICAgZGVzY3JpcHRpb246IHJlZ2lvbiBvZiBtZW1vcnkg
dGhhdCBpcyByZXNlcnZlZCBmb3IgdGhlIHB1cnBvc2UgaW5kaWNhdGVkDQo+ID4gPiArICAgICAg
YnkgdGhlIGNvbXBhdGlibGUgc3RyaW5nLg0KPiA+ID4gKw0KPiA+ID4gK3JlcXVpcmVkOg0KPiA+
ID4gKyAgLSByZWcNCj4gPiA+ICsNCj4gPiA+ICt1bmV2YWx1YXRlZFByb3BlcnRpZXM6IGZhbHNl
DQo+ID4gPiArDQo+ID4gPiArZXhhbXBsZXM6DQo+ID4gPiArICAtIHwNCj4gPiA+ICsgICAgcmVz
ZXJ2ZWQtbWVtb3J5IHsNCj4gPiA+ICsgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+
ID4gKyAgICAgICAgI3NpemUtY2VsbHMgPSA8MT47DQo+ID4gPiArDQo+ID4gPiArICAgICAgICBy
ZXNlcnZlZEAxMjM0MDAwMCB7DQo+ID4gPiArICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJib290
LWNvZGUiOw0KPiA+ID4gKyAgICAgICAgICAgIHJlZyA9IDwweDEyMzQwMDAwIDB4MDA4MDAwMDA+
Ow0KPiA+ID4gKyAgICAgICAgfTsNCj4gPiA+ICsNCj4gPiA+ICsgICAgICAgIHJlc2VydmVkQDQz
MjEwMDAwIHsNCj4gPiA+ICsgICAgICAgICAgICBjb21wYXRpYmxlID0gImJvb3QtZGF0YSI7DQo+
ID4gPiArICAgICAgICAgICAgcmVnID0gPDB4NDMyMTAwMDAgMHgwMDgwMDAwMD47DQo+ID4gPiAr
ICAgICAgICB9Ow0KPiA+ID4gKyAgICB9Ow0KPiA+ID4gLS0NCj4gPiA+IDIuNDIuMC41MTUuZzM4
MGZjN2NjZDEtZ29vZw0KPiA+DQo=
