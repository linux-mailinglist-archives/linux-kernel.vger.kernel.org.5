Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70A277AFCD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 05:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjHNC7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 22:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbjHNC7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 22:59:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE82BE6C;
        Sun, 13 Aug 2023 19:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691981960; x=1723517960;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HOXr6jlkiDJOaQwdCgGVG0m8dFmN/lQr8DLSVNTU8/8=;
  b=NNio2GJDa7nQykX0UtCBV28rWbXX0+ZC17YqIcEAP0L3LTqa3hlIup/6
   WzUETN1blleSkud2ATHNjDcJg72wsjwowj7SnOqOa5DZsiCNHNTVSbgwZ
   KH/Tlkx916f7DPEZmEXvS7x7zwEAIDGoK0e1NqnCWEVbaqpigFQU66GW/
   Yn2QP9hyel3gik5lZ8joarPcRFUrlOu8gVXrVHOjolXknH7BkM5looeUM
   j9rkSikRwKPN1ChvH7T2wmxJNgROS2ICjatweWVOz2s9LVJNMMponm6cr
   a8ECn3xTwZvzUcYWUZcr88/Rt+UwGnij4u4DtsNGmjPPPJW+XrvC2bTFJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="352275033"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="352275033"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2023 19:59:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="876792144"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 13 Aug 2023 19:59:18 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 13 Aug 2023 19:59:14 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 13 Aug 2023 19:59:14 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 13 Aug 2023 19:59:14 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 13 Aug 2023 19:59:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQs70hFZJDIw5zC1DnF07aMcrJ2ElFgkQPEmJsT9tBDX1rYnD1SDlEYTzbTqMlBE36o/RenmkuSfmTBK6baP1D9ZUvEA1kRNcAHUZnVbmhDnJWyDVg+xlG6Wbko2Y3CkDTVmlPASw+r69WPxabzgLbjg0ruevM41bXvcsdRM/6yfH5nz3gpM/EgZ6F92yq+eE857KSFpXgFNOM7a+iWxNtajq8o8fW9RfAYD2tmUZElSmzu+jXmtDC8omYnX2rjQVbxPdyGZOme9VeGAd/jqADIe6MMY8ejlUoMOS/+2jn+yC2Pa+/H7Pw/VvLbEaZ1YMh1iO8gj4bSsjyRj7ZD+mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOXr6jlkiDJOaQwdCgGVG0m8dFmN/lQr8DLSVNTU8/8=;
 b=iVRSjQ3o6l5rH6JpIwVR1TcywgxLEpLdYxakTzLkn9tgTgrTbvN7440aoIf7IccuPUfIelYJb1LhYASo5HNJZK53FEROIQgSfHntggl1gtRnnt55erCjc1f4GZmdyEHISNar6hojDehn/K8vyCbAMhM/3fcTl9O6+826h5xE9v9xTH5fGmjhoQQNHfw+y6NYPFWUkT1ocHJrtI10q/8vp+Vg6wx1mRuBEDgUfH4fXegbjSI2xhWInsrtF+jnX70RwHGCE6IWKJQlyeXNYjzrr/akF4dEhc3rtUCkNGZIRm1xamgdz0TvcbM8Z/qvhlDqtZyGhPEhKDOi4pt+3WqfRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3291.namprd11.prod.outlook.com (2603:10b6:5:d::10) by
 DS0PR11MB7786.namprd11.prod.outlook.com (2603:10b6:8:f2::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.24; Mon, 14 Aug 2023 02:59:11 +0000
Received: from DM6PR11MB3291.namprd11.prod.outlook.com
 ([fe80::cf83:5843:b3c9:10af]) by DM6PR11MB3291.namprd11.prod.outlook.com
 ([fe80::cf83:5843:b3c9:10af%6]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 02:59:10 +0000
From:   "Rabara, Niravkumar L" <niravkumar.l.rabara@intel.com>
To:     Dinh Nguyen <dinguyen@kernel.org>, Stephen Boyd <sboyd@kernel.org>
CC:     "Ng, Adrian Ho Yin" <adrian.ho.yin.ng@intel.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Turquette, Mike" <mturquette@baylibre.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "wen.ping.teh@intel.com" <wen.ping.teh@intel.com>
Subject: RE: [PATCH v2 4/5] clk: socfpga: agilex: add clock driver for the
 Agilex5
Thread-Topic: [PATCH v2 4/5] clk: socfpga: agilex: add clock driver for the
 Agilex5
Thread-Index: AQHZxBQZa8xdU8B4rEiYPY9MMMVjqq/iiDYAgAW3uhCAAOtsgIAAAtlA
Date:   Mon, 14 Aug 2023 02:59:10 +0000
Message-ID: <DM6PR11MB3291DF72DBF679A2FB80D0AAA217A@DM6PR11MB3291.namprd11.prod.outlook.com>
References: <20230618132235.728641-1-niravkumar.l.rabara@intel.com>
 <20230801010234.792557-1-niravkumar.l.rabara@intel.com>
 <20230801010234.792557-5-niravkumar.l.rabara@intel.com>
 <d58e289b54f66c239ae09e94728716b7.sboyd@kernel.org>
 <DM6PR11MB32915E1D8C2981100A83B4ABA216A@DM6PR11MB3291.namprd11.prod.outlook.com>
 <bc6858ef-833f-2eb8-7f19-02ba9063ac0f@kernel.org>
In-Reply-To: <bc6858ef-833f-2eb8-7f19-02ba9063ac0f@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3291:EE_|DS0PR11MB7786:EE_
x-ms-office365-filtering-correlation-id: ee377117-e19e-47af-70e7-08db9c726f24
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZhTE113lKItRO50NCRvBLu9vOaam+YgMBDLFOVZ2dTKx7iuGu1og45VNHp7xWrM24xdVOJv6MnXriVPTZjOFrByWt9BLvCtqGtWjq234VgVzUiJwD8edzdzHqvBL9KmQq2lLNFRDMoRnN+IT9c/EDF/RYFdP8YXoCr8YmCSWbchO2gPmu6kTZUtb81teWjgdVxHPXJz3GS1SVRIEatE9kjuGitvZpvQ+IeAMdn3IGU0bG4tPQebgpnmvG6UsR2G2wJ5msPw6Dz315EFH/A7cZhwobnhARscXWTD7F2SCRpiqmYoRTtKxbq9IBhu36anhYj3lXiqjlfFqx9M/P5bFlmqLfTdvZwUVt7JhlBfk0K3xbhWu16KyqszEMFqpYfJbbuQU5517Z514QwVBdEwhQx8r0NxlVWBkN4/+6g12hKWO9YTHs+xHjmX+sVNzOshqejyZ/aMFtPjo3cNiY4B3NGdQGVtvZg5Mx6tOcvP9EFOQZs/fWUP8IDmUk9xrDBo/Sd8bjnPX36DSvDDyrt5VJ+Ennc8tkAqh8MNIDXWFGacUGIyNLWvJDcWK15smZtnmr7ZGYUoevw+OaXa/ZDwQqwWKreG6QcrLlQg8UcWoglBe6sndTx2AB8R7YlT4VYi3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3291.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(136003)(396003)(366004)(39860400002)(1800799006)(186006)(451199021)(478600001)(71200400001)(110136005)(76116006)(6506007)(7696005)(26005)(107886003)(53546011)(9686003)(66946007)(2906002)(55016003)(7416002)(41300700001)(8936002)(8676002)(66556008)(66476007)(66446008)(64756008)(54906003)(316002)(4326008)(52536014)(5660300002)(38100700002)(38070700005)(122000001)(82960400001)(86362001)(33656002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkZrMGQwaFdXaXpmaVYyVHBHeCtyQUdlSm5aVXlTV21iaXVpK2s1dHZFRElF?=
 =?utf-8?B?dUV4T3FKTFFwMW1mdnR2c0pIWFVHdXQ1YmZVMGJPSVk4aTZubXQ5cmlQaDV5?=
 =?utf-8?B?Z3VIREVJczBDZXNvMEt0UnNtWjdhSlIvYlRCTk9aWTQ0U09TUDdOVGlIL0la?=
 =?utf-8?B?VTRCL3pjRnh6NWozRFNWL2lCdGU1eUJWQmwyMFhUUmhoNmJ4RjFPUndUZXBq?=
 =?utf-8?B?emluOXVkMDRWZXdCWjdKY3dkMmI4cVkyT3BVYUFlZkcyYUVGS2JBdXZOdEQ5?=
 =?utf-8?B?NnZUL0NsSXhnb2s0QUZjWmpnbmxwSHJsQksvU0lBdjZTcS9ySzBYaGdxNUph?=
 =?utf-8?B?ZEQwcjRkb3ZURjIrNEhNL3ZQd2p3bWRnU3VXMll2UFBNbFlSUUdaekRhZ203?=
 =?utf-8?B?RlZiZXJreXVRZXhEMWRrdTZBcVVQS3RZcitydEJ6OGtPMzB1N2tXdmY1RDY2?=
 =?utf-8?B?ZWc1T0YwNmwrWHlmdXlJQVlocERLNmFmQmRPYnhYaEFxcjVOVTQvbTQ2R3Q1?=
 =?utf-8?B?cXg1ZmFVbmlaSEp5bTUzeWhFUHBMc04yUVMrdzFqY1k1a2RqL2JLSlNjZnF4?=
 =?utf-8?B?Snh0RUwxdVdMemZHUWcyYW9lS1B3M0VEK3RVNk9KVGhEM3hBcllUYUhWSEkz?=
 =?utf-8?B?MGtRTDBtQnU4SzhXK1BLaVZlSmhObWV0aXJraWRMeFdSM0NHTmh3UUVEVmFI?=
 =?utf-8?B?TlBWT2JGd1JsV25KVlJLRkM1aFMwOWFac3I0SVdmcEN3cFZsaXUvRFBSNnd6?=
 =?utf-8?B?dmxrWEJiRVNPQ0hhUU55bnJhZkozOXZhbnlRemY0RGNCNDhOeVdrWUhRaHhT?=
 =?utf-8?B?MWtuVTVmRm45cGpFMzBRS1FyUXhNQXBrcGVuaVh0TkUxa04yY3lJNExWY0F1?=
 =?utf-8?B?R2RROTdDVUUweG9xVUdMUDI4bnExSzR3SlFKQ1BqWGRGRSt4SjlQTXQxNEll?=
 =?utf-8?B?YWQ0OW5EZWMvZVJzNXNVZ3VCcU45KzE2SG1CcFFFZGtMdGJVU0NqMk5PMkpX?=
 =?utf-8?B?K0hXOElQTzY0RStXVWFZUzNlaXUyR3c1TzdROHlueDlKZjBjUFBYQnZCZWE1?=
 =?utf-8?B?amJxM05UWjNlQlZCYXErN25DOFI0N2FTb2pxbjR1cmpNNjRINDN2MEZ3cnRr?=
 =?utf-8?B?aFg5TlhTcTNyRE42RnJYdEtkSFg2TDZyN3NqYyt2ODNTbklUU3laSkcxem5N?=
 =?utf-8?B?Wlo5SFh0RnNIdElyTW5kR3N3YVZuMGlCTFh3WnBDRXZVSXh1QXZvSkVQSUJC?=
 =?utf-8?B?RkV3dkMzM1FzYnJkcFpEamJRcmNpdG1RWkx5Y0VCSUszNy9jbVFESUtjZWJC?=
 =?utf-8?B?SGVDS2J3Wm5vMVR5WUxnQytyVkVKRnNCZnpvRnoxeFd1LzJ5bG1rUzRtczJW?=
 =?utf-8?B?WDdvRFRuV2NMUTZxSHZYQTJ1SmRvUEpwT0dOU2RmZU9EWHQrb05vcm9xMmtN?=
 =?utf-8?B?eEtlU2h3ekVLa1NqNnR2bEU3U2FIMHR4VCs1R1ZEK0Fyck41SnEvOFhBT1Nk?=
 =?utf-8?B?bU0xS3BJRmxDYVlsNjV6UGpIb0VjcW1hSjBNNERKOG5DOGF6aGlmRFh0YlFS?=
 =?utf-8?B?QWxPb3BZai96c1hybHJIZm1lMTZVQjBjSjQ2M2cva20rNnNqU2o4WWV3YzhY?=
 =?utf-8?B?Q3VlSDh4c3JMQTRtTlhJMWp4Uk5pcEdYc3BaTjdZREdFMXUrazB4TFBVWHZt?=
 =?utf-8?B?b2NaZVAvNkZPNlJ0OVlCMFRtK1dqZkZ3WWQ3R1h0N2k1NHAwTzA2TERJSE9J?=
 =?utf-8?B?RG9EM2NVRmU1b0Z6MGZockErYm03RWVuejdXNW9SaHluZDdyZlpUNmt2eWRp?=
 =?utf-8?B?TTBScUIralBvYi9lSUtqZ2JpTVRlelNKSWFQWGU5YmNSNWR5UVI4eUtYTi9X?=
 =?utf-8?B?c1VjRVF2L051Vk4vY1Q3UGRWL0g4YktPMTNYaEFOVTFSaWlRalRiSll4blQ3?=
 =?utf-8?B?Q2pMMnRJOWNLK1FxWURWOEN1VXFrUnI3eGdHVHhPNXRreGMzMnNSZ3R2RXFn?=
 =?utf-8?B?Z2VuR0ZRVFFIa0pXY1dCNlFGWllPT01Ca2RoTmFZRkNGZ01ON0VhbDBNaDcv?=
 =?utf-8?B?TnJ3bGFwTUFGY2lia3hIZ1I4WnAvVzdqWXc3Z2o1cTdyS2JQRG4ydHdNNU1r?=
 =?utf-8?B?a2NPY01UT2JmUTQwNVlXWDJxT1BIbjBJd2tzcmxZclA0cGZkaCtyeStiMEVZ?=
 =?utf-8?B?Rmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3291.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee377117-e19e-47af-70e7-08db9c726f24
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 02:59:10.7482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9OB0GSBRmjTzzFkYtqrlKZaEdrYdIFyRFriq4KbhcIcQGCcC3sm9er0a4D6EI5Y13e7gnIS9+AGB2wR/5FO0RGqzfOWx6kLz8HCbeCRGBJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7786
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGluaCBOZ3V5ZW4gPGRp
bmd1eWVuQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IE1vbmRheSwgMTQgQXVndXN0LCAyMDIzIDEwOjQ4
IEFNDQo+IFRvOiBSYWJhcmEsIE5pcmF2a3VtYXIgTCA8bmlyYXZrdW1hci5sLnJhYmFyYUBpbnRl
bC5jb20+OyBTdGVwaGVuIEJveWQNCj4gPHNib3lkQGtlcm5lbC5vcmc+DQo+IENjOiBOZywgQWRy
aWFuIEhvIFlpbiA8YWRyaWFuLmhvLnlpbi5uZ0BpbnRlbC5jb20+OyBhbmRyZXdAbHVubi5jaDsN
Cj4gY29ub3IrZHRAa2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGty
enlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsgbGludXgtY2xrQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFR1cnF1ZXR0ZSwgTWlrZSA8bXR1
cnF1ZXR0ZUBiYXlsaWJyZS5jb20+Ow0KPiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBwLnphYmVs
QHBlbmd1dHJvbml4LmRlOw0KPiByaWNoYXJkY29jaHJhbkBnbWFpbC5jb207IHJvYmgrZHRAa2Vy
bmVsLm9yZzsgd2VuLnBpbmcudGVoQGludGVsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYy
IDQvNV0gY2xrOiBzb2NmcGdhOiBhZ2lsZXg6IGFkZCBjbG9jayBkcml2ZXIgZm9yIHRoZQ0KPiBB
Z2lsZXg1DQo+IA0KPiANCj4gDQo+IE9uIDgvMTMvMjMgMDc6NTMsIFJhYmFyYSwgTmlyYXZrdW1h
ciBMIHdyb3RlOg0KPiA+DQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
Pj4gRnJvbTogU3RlcGhlbiBCb3lkIDxzYm95ZEBrZXJuZWwub3JnPg0KPiA+PiBTZW50OiBUaHVy
c2RheSwgMTAgQXVndXN0LCAyMDIzIDU6MjcgQU0NCj4gPj4gVG86IFJhYmFyYSwgTmlyYXZrdW1h
ciBMIDxuaXJhdmt1bWFyLmwucmFiYXJhQGludGVsLmNvbT4NCj4gPj4gQ2M6IE5nLCBBZHJpYW4g
SG8gWWluIDxhZHJpYW4uaG8ueWluLm5nQGludGVsLmNvbT47IGFuZHJld0BsdW5uLmNoOw0KPiA+
PiBjb25vcitkdEBrZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gZGlu
Z3V5ZW5Aa2VybmVsLm9yZzsNCj4gPj4ga3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3Jn
OyBsaW51eC1jbGtAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gPj4ga2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgVHVycXVldHRlLCBNaWtlIDxtdHVycXVldHRlQGJheWxpYnJlLmNvbT47DQo+ID4+
IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IHAuemFiZWxAcGVuZ3V0cm9uaXguZGU7DQo+ID4+IHJp
Y2hhcmRjb2NocmFuQGdtYWlsLmNvbTsNCj4gPj4gcm9iaCtkdEBrZXJuZWwub3JnOyB3ZW4ucGlu
Zy50ZWhAaW50ZWwuY29tDQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgNC81XSBjbGs6IHNv
Y2ZwZ2E6IGFnaWxleDogYWRkIGNsb2NrIGRyaXZlcg0KPiA+PiBmb3IgdGhlIEFnaWxleDUNCj4g
Pj4NCj4gPj4gUXVvdGluZyBuaXJhdmt1bWFyLmwucmFiYXJhQGludGVsLmNvbSAoMjAyMy0wNy0z
MSAxODowMjozMykNCj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9zb2NmcGdhL2Nsay1h
Z2lsZXguYw0KPiA+Pj4gYi9kcml2ZXJzL2Nsay9zb2NmcGdhL2Nsay1hZ2lsZXguYw0KPiA+Pj4g
aW5kZXggNzRkMjFiZDgyNzEwLi4zZGNkMGYyMzNjMTcgMTAwNjQ0DQo+ID4+PiAtLS0gYS9kcml2
ZXJzL2Nsay9zb2NmcGdhL2Nsay1hZ2lsZXguYw0KPiA+Pj4gKysrIGIvZHJpdmVycy9jbGsvc29j
ZnBnYS9jbGstYWdpbGV4LmMNCj4gPj4+IEBAIC0xLDYgKzEsNiBAQA0KPiA+Pj4gICAvLyBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiA+Pj4gICAvKg0KPiA+Pj4gLSAqIENvcHly
aWdodCAoQykgMjAxOSwgSW50ZWwgQ29ycG9yYXRpb24NCj4gPj4+ICsgKiBDb3B5cmlnaHQgKEMp
IDIwMTktMjAyMywgSW50ZWwgQ29ycG9yYXRpb24NCj4gPj4+ICAgICovDQo+ID4+PiAgICNpbmNs
dWRlIDxsaW51eC9zbGFiLmg+DQo+ID4+PiAgICNpbmNsdWRlIDxsaW51eC9jbGstcHJvdmlkZXIu
aD4NCj4gPj4+IEBAIC05LDYgKzksNyBAQA0KPiA+Pj4gICAjaW5jbHVkZSA8bGludXgvcGxhdGZv
cm1fZGV2aWNlLmg+DQo+ID4+Pg0KPiA+Pj4gICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvY2xvY2sv
YWdpbGV4LWNsb2NrLmg+DQo+ID4+PiArI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2Nsb2NrL2ludGVs
LGFnaWxleDUtY2xrbWdyLmg+DQo+ID4+Pg0KPiA+Pj4gICAjaW5jbHVkZSAic3RyYXRpeDEwLWNs
ay5oIg0KPiA+Pj4NCj4gPj4+IEBAIC00MSw2ICs0Miw2NyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IGNsa19wYXJlbnRfZGF0YQ0KPiBtcHVfZnJlZV9tdXhbXSA9IHsNCj4gPj4+ICAgICAgICAgICAg
Lm5hbWUgPSAiZjJzLWZyZWUtY2xrIiwgfSwNCj4gPj4+ICAgfTsNCj4gPj4+DQo+ID4+PiArc3Rh
dGljIGNvbnN0IHN0cnVjdCBjbGtfcGFyZW50X2RhdGEgY29yZTBfZnJlZV9tdXhbXSA9IHsNCj4g
Pj4+ICsgICAgICAgeyAuZndfbmFtZSA9ICJtYWluX3BsbF9jMSIsDQo+ID4+PiArICAgICAgICAg
Lm5hbWUgPSAibWFpbl9wbGxfYzEiLCB9LA0KPiA+Pg0KPiA+PiBXZSdyZSBhZGRpbmcgc3VwcG9y
dCBmb3Igc29tZXRoaW5nIG5ldz8gT25seSBzZXQgLmZ3X25hbWUgaW4gdGhhdA0KPiA+PiBjYXNl
LCBhcyAubmFtZSB3aWxsIG5ldmVyIGJlIHVzZWQuIFRvIGRvIGV2ZW4gYmV0dGVyLCBzZXQgb25s
eSAuaW5kZXgNCj4gPj4gc28gdGhhdCB3ZSBkb24ndCBkbyBhbnkgc3RyaW5nIGNvbXBhcmlzb25z
Lg0KPiA+Pg0KPiA+IFllcyB3ZSBhcmUgYWRkaW5nIEFnaWxleDUgU29DRlBHQSBwbGF0Zm9ybSBz
cGVjaWZpYyBjbG9ja3MuDQo+ID4gSSB3aWxsIHJlbW92ZSAubmFtZSBhbmQgb25seSBrZWVwIC5m
d19uYW1lIGluIG5leHQgdmVyc2lvbiBvZiB0aGlzIHBhdGNoLg0KPiA+DQo+ID4+PiArICAgICAg
IHsgLmZ3X25hbWUgPSAicGVyaV9wbGxfYzAiLA0KPiA+Pj4gKyAgICAgICAgIC5uYW1lID0gInBl
cmlfcGxsX2MwIiwgfSwNCj4gPj4+ICsgICAgICAgeyAuZndfbmFtZSA9ICJvc2MxIiwNCj4gPj4+
ICsgICAgICAgICAubmFtZSA9ICJvc2MxIiwgfSwNCj4gPj4+ICsgICAgICAgeyAuZndfbmFtZSA9
ICJjYi1pbnRvc2MtaHMtZGl2Mi1jbGsiLA0KPiA+Pj4gKyAgICAgICAgIC5uYW1lID0gImNiLWlu
dG9zYy1ocy1kaXYyLWNsayIsIH0sDQo+ID4+PiArICAgICAgIHsgLmZ3X25hbWUgPSAiZjJzLWZy
ZWUtY2xrIiwNCj4gPj4+ICsgICAgICAgICAubmFtZSA9ICJmMnMtZnJlZS1jbGsiLCB9LCB9Ow0K
PiA+Pj4gKw0KPiA+PiBbLi4uXQ0KPiA+Pj4gKw0KPiA+Pj4gICBzdGF0aWMgaW50IG41eF9jbGtf
cmVnaXN0ZXJfY19wZXJpcChjb25zdCBzdHJ1Y3QgbjV4X3BlcmlwX2NfY2xvY2sNCj4gKmNsa3Ms
DQo+ID4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IG51bXMs
IHN0cnVjdA0KPiA+Pj4gc3RyYXRpeDEwX2Nsb2NrX2RhdGEgKmRhdGEpICB7IEBAIC01MzUsNiAr
OTE3LDUxIEBAIHN0YXRpYyBpbnQNCj4gPj4+IG41eF9jbGttZ3JfaW5pdChzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQ0KPiA+Pj4gICAgICAgICAgcmV0dXJuIDA7DQo+ID4+PiAgIH0NCj4g
Pj4+DQo+ID4+PiArc3RhdGljIGludCBhZ2lsZXg1X2Nsa21ncl9pbml0KHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpIHsNCj4gPj4+ICsgICAgICAgc3RydWN0IGRldmljZV9ub2RlICpucCA9
IHBkZXYtPmRldi5vZl9ub2RlOw0KPiA+Pj4gKyAgICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYgPSAm
cGRldi0+ZGV2Ow0KPiA+Pj4gKyAgICAgICBzdHJ1Y3Qgc3RyYXRpeDEwX2Nsb2NrX2RhdGEgKmNs
a19kYXRhOw0KPiA+Pg0KPiA+PiBNYXliZSBjYWxsIHRoaXMgc3RyYXRpeF9kYXRhIHNvIHRoYXQg
Y2xrX2RhdGEuY2xrX2RhdGEgaXMNCj4gc3RyYXRpeF9kYXRhLmNsa19kYXRhLg0KPiA+DQo+ID4g
V2lsbCBmaXggdGhpcyBpbiBuZXh0IHZlcnNpb24uDQo+ID4NCj4gPj4NCj4gPj4+ICsgICAgICAg
c3RydWN0IHJlc291cmNlICpyZXM7DQo+ID4+PiArICAgICAgIHZvaWQgX19pb21lbSAqYmFzZTsN
Cj4gPj4+ICsgICAgICAgaW50IGksIG51bV9jbGtzOw0KPiA+Pj4gKw0KPiA+Pj4gKyAgICAgICBy
ZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOw0KPiA+
Pj4gKyAgICAgICBiYXNlID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKGRldiwgcmVzKTsNCj4gPj4N
Cj4gPj4gVGhpcyBpcyBhIHNpbmdsZSBmdW5jdGlvbiBjYWxsLCBkZXZtX3BsYXRmb3JtX2lvcmVt
YXBfcmVzb3VyY2UoKS5pDQo+ID4NCj4gPiBOb3RlZC4gV2lsbCBmaXggaW4gbmV4dCB2ZXJzaW9u
Lg0KPiA+DQo+IA0KPiBXaGVuIHlvdSByZXNlbmQgYSBWMywganVzdCBzZW5kIHRoaXMgcGF0Y2gu
IEkndmUgYWxyZWFkeSBhcHBsaWVkIHRoZSBvdGhlciA0DQo+IHBhdGNoZXMuDQo+IA0KPiBEaW5o
DQoNCk5vdGVkIERpbmguDQoNClRoYW5rcywNCk5pcmF2DQo=
