Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2B377A666
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 14:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjHMMxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 08:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjHMMxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 08:53:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16BDE6F;
        Sun, 13 Aug 2023 05:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691931216; x=1723467216;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UKqVc2iSUbzXcMPKzObQz1hIXvCXmEq8deWBoAWQwz4=;
  b=SYpJtBbi3Ace5CEDk3uLhBxneRBYKqoiooNCXpvqzUYczTARmbbZE/0p
   nJqIVG3DrYKLSFb5yM4S4C2TyZk/ENMKryY7CYePe/2MaEnEEvhj10W6e
   zj0j0jmfwztnku6pQi/EUM4G2gdDeyA6hcsNUtiVHOu/2ggEGyKwU14kj
   24x0eKTTiyVnVYk+B0eHsxlDMP2yT5L+og72fRsmlikKzm0BD29h5Y9ly
   yzogCY4Fyg3PHSnV+npO1S7kdWePLICyz4R3WrQl3xlTlabdsD37o4qjK
   DjCFEEWiosUsxYysClOd8M7NVBi6IgpN+c630fUQMccxsXK0uuj4Hesx2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="370793839"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="370793839"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2023 05:53:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="847317783"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="847317783"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 13 Aug 2023 05:53:35 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 13 Aug 2023 05:53:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 13 Aug 2023 05:53:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 13 Aug 2023 05:53:35 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 13 Aug 2023 05:53:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWxAs9HchMQxqLlBRej5b0J3nQfJHh7CaiSGBPSA/FThFmDvalNdMytHx9PWZVm89Klw4JA7CKytPXmFnMMzog2VDkXox8iMUgHtuBPexEByhZYGxvTmjC20o3AdBZRMFQhHv95VrrS4P2Ha0d9Xq4EgwepQU98XlSsWH3jjnXVW14hYKQLVlewwSeXVTh8YvhXyijivCxOCF9fSVs6CfWuovDwRn+tyu8IyQWdgi5eO3qYGPcdQGTQXcM83vYvCp0/yLQ8wIvnJAfzSoJMF3kiQw/VPQqyFSM+YjmTf123FHIaQR4BUQnLkvLbQOvnq+gQNy/riDIaJaMjmiMs8DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKqVc2iSUbzXcMPKzObQz1hIXvCXmEq8deWBoAWQwz4=;
 b=YO3fKDauovPG608RclD0GRVMuyfep4nNDq3c06q8lO1UGH1J16Bag3kvXD0zUoDAVD0jqIlURyMxHhbMNpYdUGoBsYya7eLjUDESizKCR8pKwXJirRCkFZ4SxvkjfPT1dvV89pbrd0GD5SHTz9V159q6SZsd4I2Cm2YS6n9J2gZ4L6akiE2GAimKOdfpAEHIjIZH/m85IPAe1MK+YSwciLxI1F0ykAfytMbk3yQT7Cg+iH4WJe/3w2kAXgSpz2Dehy4zt7gUIfQPR52pzUnROVMS2Lhbp7xsUYR0h197kPJ72wxJINFFZi7plKRoNS9lEhEzRRc2StK5hixTZlVMWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3291.namprd11.prod.outlook.com (2603:10b6:5:d::10) by
 CH0PR11MB5284.namprd11.prod.outlook.com (2603:10b6:610:bf::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.24; Sun, 13 Aug 2023 12:53:33 +0000
Received: from DM6PR11MB3291.namprd11.prod.outlook.com
 ([fe80::cf83:5843:b3c9:10af]) by DM6PR11MB3291.namprd11.prod.outlook.com
 ([fe80::cf83:5843:b3c9:10af%6]) with mapi id 15.20.6678.022; Sun, 13 Aug 2023
 12:53:33 +0000
From:   "Rabara, Niravkumar L" <niravkumar.l.rabara@intel.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     "Ng, Adrian Ho Yin" <adrian.ho.yin.ng@intel.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
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
Thread-Index: AQHZxBQZa8xdU8B4rEiYPY9MMMVjqq/iiDYAgAW3uhA=
Date:   Sun, 13 Aug 2023 12:53:33 +0000
Message-ID: <DM6PR11MB32915E1D8C2981100A83B4ABA216A@DM6PR11MB3291.namprd11.prod.outlook.com>
References: <20230618132235.728641-1-niravkumar.l.rabara@intel.com>
 <20230801010234.792557-1-niravkumar.l.rabara@intel.com>
 <20230801010234.792557-5-niravkumar.l.rabara@intel.com>
 <d58e289b54f66c239ae09e94728716b7.sboyd@kernel.org>
In-Reply-To: <d58e289b54f66c239ae09e94728716b7.sboyd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3291:EE_|CH0PR11MB5284:EE_
x-ms-office365-filtering-correlation-id: 4cbfa9b1-1e87-428c-ae2f-08db9bfc4d38
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mb7CDsRh+pAeILy2XL42SdMrCt3pXoxuHrpNpN364M7f9i+VztLTeS66dNnB1U/k4raDzfBmBf8peigaZ6eiXGht5kZmHRbf/joSlnGmbzc6k6iHVK8Q8ThfEbsc/kV+qeLg99+6i2uH2PHXesZ/Sdc3ca1aCa3Us0Asgsh0la18Xud/NP77GpIwM61XDHXnY1AOrYqyiZ7vrpzSyyJrstKIYjKyWHMRb8/F6gLCDGFpu155bAqjauarctA72BmEWlxhB5N3hsaHhKI2ern7uiSjYER438pnwy81xPLiC5v+5wDRowZB7Oh4O2F1MjLB3YQSpGQXTz+Y7JIbNFHaXQKuswpy+bUxexgm+HDbGh8wybgahsDFr4XrnGyYGB0WW/Am4uYjv3C0ZG7NE63sP+BOBZopKR6ANET52e1FXgEcgkx+WJQCs+OMoVacyveRcrjAirmwwx3/tsU991VUkbxBYfUHRjDb9pEf9mh/SBfcKseOVDVGGZ3pkkWR9rBcW6Xz0DuCKiZnbC1fSR5m9LDzm8eChGybTOh2NjwScesElNkCsKsOUiHE/ERktaAQ8vKS6lkfe4bg94fWRFn9dJacvK5wJRHSyybPto53f1O1q/hBSmgZaNrhBwypNUqL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3291.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(346002)(136003)(376002)(396003)(186006)(1800799006)(451199021)(7416002)(2906002)(316002)(66556008)(83380400001)(66946007)(76116006)(66446008)(66476007)(54906003)(6916009)(64756008)(41300700001)(55016003)(71200400001)(53546011)(7696005)(6506007)(478600001)(26005)(9686003)(107886003)(5660300002)(86362001)(33656002)(8936002)(8676002)(4326008)(82960400001)(52536014)(38100700002)(38070700005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUdFTDVkcFdodWFUSTc2aHptcUpyVU1HNDI5d1E2QVQrNzFWeHVxbW9yM2U5?=
 =?utf-8?B?em5hcE44NWJsK1N4N0FNOXhoRXB6NmNCK3loZjd3b3MvY1oxVlpyaW54RXYw?=
 =?utf-8?B?Zk5JYStiMHcyTlBWcXA3b1NBMkYzMlY3aUZPeFBWaG8wb1VFU1JHL3VxZWtt?=
 =?utf-8?B?NWcySTFGS3FlMUtBTldDK3lpc3FRd1hnYTZzS2NzUXdqNGVjY0Vkd2Yvd3Vk?=
 =?utf-8?B?ZzNTN1lLOFRibHdoMkNvTG1ZZnhTNXFBUjYycERGK3F2UWRvSDBMMGI4WW1h?=
 =?utf-8?B?YlBEemd0UW9RQ3hpbDZnaHlaRWV4MHhuTjFpeVlKYjRTdXBYYmdZdkRYTE4y?=
 =?utf-8?B?bzBBcDJ3ZjQyTFJwTzU5VlZpQ2FRdnlLbDVOdTBCNFJCSXhOU2x4SnRZcWdB?=
 =?utf-8?B?MG5hcUwzVWg4OTQvdGV1aFg0NlY3VjJWNjlGVGJKdGxWQTJtT3FJZ0FwamRD?=
 =?utf-8?B?cmMxQjRNdUJVRmYyc3RRR24vODlJbmJsOHE2MUh3M3U1U0ZzWmlPMFNENTZm?=
 =?utf-8?B?WXZ6UFhGNUtIb2dHdzhOb3dBc1ozZEhycDdFT1dIVDJrd1RCU25QOUFWYUR5?=
 =?utf-8?B?QlIvVVdYYTN3WC93ZE9oVG9VV1lUaVc1eUlXcmhDVGM0b3JEeElJNHJtS3pO?=
 =?utf-8?B?WFRRM1lFc2YxV3F6YSs1dEpJNkZrRmp5V3lyY0dtZ3JKMXowc3F0aTJYY0Fw?=
 =?utf-8?B?VCsvNWIrdGY3NlJOQldsRW9FNXVoSkREK2RjR1pia2cxM1psVGs5bTlxRk04?=
 =?utf-8?B?eXdpMHIrbzFVRGpkcjFnekpvR1lvSEFrRDhwNHN1NHp0U3hpZTNaajBaemk2?=
 =?utf-8?B?VkJib0pZN09ocElqU3lNbFNvODNvL3B1UkEwOUkrbzJQRjdyQVdXVENEQWc5?=
 =?utf-8?B?QXZkL2FNbVlrZHBIbUJJV3BKSWRvRkdpeEpxNkFOTzY0SDJ5czBncE5MdWJx?=
 =?utf-8?B?ZXZzTmxueEp4NnVNbU53TEp2cDliMGZOQXJRTUxSdktMUnlNNHFheHNZaytN?=
 =?utf-8?B?TkNqWmsvVUluZTBlQStYck9aR1ZjbHZKSEorcklDTDdzblRLWWdhNjczWFBo?=
 =?utf-8?B?b2dJVWI5NkxwNkhFR0FJc1JRY1lvdUlNUk0yM2lubUl4YkVKR3JpY2FtOUFZ?=
 =?utf-8?B?ZXdRZ1EydG85U0F2TGVzNXBsTFV4eHVUMGZaczZ4MUx0L05xc3dHNkdXMEtz?=
 =?utf-8?B?WW5WM25CYS84QWFqY01sSFh5NkQ3NEhCNHV6Nnh4dEJ1MkhkWUt1YWhzT3Vz?=
 =?utf-8?B?c1p5TmJYd3VEN0ViVEY4NXZBbVVlTE5NNVNrS254VGVqc0MxQXBNVllEMmxC?=
 =?utf-8?B?MWpTakRucnRqZTJINlRjN0NLbDY5RXF2R2s1S0cybnBhRXNDNlJlVSttRDda?=
 =?utf-8?B?cldRS0VONzVYdnc0Lzh3bEpWUDFRMXBVWTZwd01UMlBweWxnWGYyWTNoMTBn?=
 =?utf-8?B?YjlqQzl2S2sxK1FyekVsZXFpTC93enRHTjEzWU9XNk1JQ0hLRVZqSEdoNThi?=
 =?utf-8?B?a0tianovUHZnejJDZ3JPOHBwdHRVSkh0enludkorSWVhMFlYSmc3Q2JmKzJv?=
 =?utf-8?B?RytFSkJ4VDIyMVJKZDVkbmllcS9vZzBKcDFPY2JpaHRQOGF5aG1Fay93aU9E?=
 =?utf-8?B?ZDF6elo1NktsQzk3ZmdnaTNZZEpRUWFiWGpCWHhTTlc1OVVlZWF5UUF1MGxh?=
 =?utf-8?B?V1VMQS9SMElTZkZtN2xKTU9nUlNETUNXNHAzWjZ3eGkvVHZZR09laDlUYlg4?=
 =?utf-8?B?SmhjeXAxZ0NqR3EyVmpKRzhydUV6blRkQ3Nwb1NxemZxT1pYY2FRa0pnbkg4?=
 =?utf-8?B?UnM4SXp3MzIzM0RGUE1yRDI3ZkFscTZNMERBeVQ5c09lZ1FOS1lDWEpCV25C?=
 =?utf-8?B?VXRLVE9qS1A2bWsvQ0M2TDdMTFhPL1FLcTFwRVNZUEZLTnBrck5kYmdSdW5u?=
 =?utf-8?B?a0hLOER3MEFraVBqSGhMV1ZkTVlwL0JKWExqblpmSjNFOFFMMVFjSnF4TGhr?=
 =?utf-8?B?UjVEaEtmYWczREo2bEFHc3F6NlFjN0ZIOXY3T2g2cmlZcEpQU1R1SHZKVlVK?=
 =?utf-8?B?bW41TGNjNGxXZGVFWGZWQnVSa2djcDlGK0RVcmo3WWtMQmxEQUp3VTU2aW9C?=
 =?utf-8?B?ZVF4M28xRzV1d253SmdaZXZDSXIzN2NLOWpKUkMyQnJqc3ErbUpaQnBUbWdh?=
 =?utf-8?B?ZkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3291.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cbfa9b1-1e87-428c-ae2f-08db9bfc4d38
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2023 12:53:33.2086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mq5EgslUKU6CrL1kgzkspAl4oIz8o2IMSaN3V0rW2w1fPReXebe89Ixmacahu2YVVfQM51qdHrnKwf5Vq1TrTwFdO5rsBk7H7+96c0Xt/hk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5284
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlcGhlbiBCb3lkIDxz
Ym95ZEBrZXJuZWwub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgMTAgQXVndXN0LCAyMDIzIDU6Mjcg
QU0NCj4gVG86IFJhYmFyYSwgTmlyYXZrdW1hciBMIDxuaXJhdmt1bWFyLmwucmFiYXJhQGludGVs
LmNvbT4NCj4gQ2M6IE5nLCBBZHJpYW4gSG8gWWluIDxhZHJpYW4uaG8ueWluLm5nQGludGVsLmNv
bT47IGFuZHJld0BsdW5uLmNoOw0KPiBjb25vcitkdEBrZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZn
ZXIua2VybmVsLm9yZzsgZGluZ3V5ZW5Aa2VybmVsLm9yZzsNCj4ga3J6eXN6dG9mLmtvemxvd3Nr
aStkdEBsaW5hcm8ub3JnOyBsaW51eC1jbGtAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgVHVycXVldHRlLCBNaWtlIDxtdHVycXVldHRlQGJheWxpYnJl
LmNvbT47DQo+IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IHAuemFiZWxAcGVuZ3V0cm9uaXguZGU7
IHJpY2hhcmRjb2NocmFuQGdtYWlsLmNvbTsNCj4gcm9iaCtkdEBrZXJuZWwub3JnOyB3ZW4ucGlu
Zy50ZWhAaW50ZWwuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgNC81XSBjbGs6IHNvY2Zw
Z2E6IGFnaWxleDogYWRkIGNsb2NrIGRyaXZlciBmb3IgdGhlIEFnaWxleDUNCj4gDQo+IFF1b3Rp
bmcgbmlyYXZrdW1hci5sLnJhYmFyYUBpbnRlbC5jb20gKDIwMjMtMDctMzEgMTg6MDI6MzMpDQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL3NvY2ZwZ2EvY2xrLWFnaWxleC5jDQo+ID4gYi9k
cml2ZXJzL2Nsay9zb2NmcGdhL2Nsay1hZ2lsZXguYw0KPiA+IGluZGV4IDc0ZDIxYmQ4MjcxMC4u
M2RjZDBmMjMzYzE3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY2xrL3NvY2ZwZ2EvY2xrLWFn
aWxleC5jDQo+ID4gKysrIGIvZHJpdmVycy9jbGsvc29jZnBnYS9jbGstYWdpbGV4LmMNCj4gPiBA
QCAtMSw2ICsxLDYgQEANCj4gPiAgLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAN
Cj4gPiAgLyoNCj4gPiAtICogQ29weXJpZ2h0IChDKSAyMDE5LCBJbnRlbCBDb3Jwb3JhdGlvbg0K
PiA+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMTktMjAyMywgSW50ZWwgQ29ycG9yYXRpb24NCj4gPiAg
ICovDQo+ID4gICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9j
bGstcHJvdmlkZXIuaD4NCj4gPiBAQCAtOSw2ICs5LDcgQEANCj4gPiAgI2luY2x1ZGUgPGxpbnV4
L3BsYXRmb3JtX2RldmljZS5oPg0KPiA+DQo+ID4gICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9jbG9j
ay9hZ2lsZXgtY2xvY2suaD4NCj4gPiArI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2Nsb2NrL2ludGVs
LGFnaWxleDUtY2xrbWdyLmg+DQo+ID4NCj4gPiAgI2luY2x1ZGUgInN0cmF0aXgxMC1jbGsuaCIN
Cj4gPg0KPiA+IEBAIC00MSw2ICs0Miw2NyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGNsa19wYXJl
bnRfZGF0YSBtcHVfZnJlZV9tdXhbXSA9IHsNCj4gPiAgICAgICAgICAgLm5hbWUgPSAiZjJzLWZy
ZWUtY2xrIiwgfSwNCj4gPiAgfTsNCj4gPg0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGNsa19w
YXJlbnRfZGF0YSBjb3JlMF9mcmVlX211eFtdID0gew0KPiA+ICsgICAgICAgeyAuZndfbmFtZSA9
ICJtYWluX3BsbF9jMSIsDQo+ID4gKyAgICAgICAgIC5uYW1lID0gIm1haW5fcGxsX2MxIiwgfSwN
Cj4gDQo+IFdlJ3JlIGFkZGluZyBzdXBwb3J0IGZvciBzb21ldGhpbmcgbmV3PyBPbmx5IHNldCAu
ZndfbmFtZSBpbiB0aGF0IGNhc2UsIGFzDQo+IC5uYW1lIHdpbGwgbmV2ZXIgYmUgdXNlZC4gVG8g
ZG8gZXZlbiBiZXR0ZXIsIHNldCBvbmx5IC5pbmRleCBzbyB0aGF0IHdlIGRvbid0IGRvDQo+IGFu
eSBzdHJpbmcgY29tcGFyaXNvbnMuDQo+IA0KWWVzIHdlIGFyZSBhZGRpbmcgQWdpbGV4NSBTb0NG
UEdBIHBsYXRmb3JtIHNwZWNpZmljIGNsb2Nrcy4gDQpJIHdpbGwgcmVtb3ZlIC5uYW1lIGFuZCBv
bmx5IGtlZXAgLmZ3X25hbWUgaW4gbmV4dCB2ZXJzaW9uIG9mIHRoaXMgcGF0Y2guIA0KIA0KPiA+
ICsgICAgICAgeyAuZndfbmFtZSA9ICJwZXJpX3BsbF9jMCIsDQo+ID4gKyAgICAgICAgIC5uYW1l
ID0gInBlcmlfcGxsX2MwIiwgfSwNCj4gPiArICAgICAgIHsgLmZ3X25hbWUgPSAib3NjMSIsDQo+
ID4gKyAgICAgICAgIC5uYW1lID0gIm9zYzEiLCB9LA0KPiA+ICsgICAgICAgeyAuZndfbmFtZSA9
ICJjYi1pbnRvc2MtaHMtZGl2Mi1jbGsiLA0KPiA+ICsgICAgICAgICAubmFtZSA9ICJjYi1pbnRv
c2MtaHMtZGl2Mi1jbGsiLCB9LA0KPiA+ICsgICAgICAgeyAuZndfbmFtZSA9ICJmMnMtZnJlZS1j
bGsiLA0KPiA+ICsgICAgICAgICAubmFtZSA9ICJmMnMtZnJlZS1jbGsiLCB9LA0KPiA+ICt9Ow0K
PiA+ICsNCj4gWy4uLl0NCj4gPiArDQo+ID4gIHN0YXRpYyBpbnQgbjV4X2Nsa19yZWdpc3Rlcl9j
X3BlcmlwKGNvbnN0IHN0cnVjdCBuNXhfcGVyaXBfY19jbG9jayAqY2xrcywNCj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgbnVtcywgc3RydWN0DQo+ID4gc3Ry
YXRpeDEwX2Nsb2NrX2RhdGEgKmRhdGEpICB7IEBAIC01MzUsNiArOTE3LDUxIEBAIHN0YXRpYyBp
bnQNCj4gPiBuNXhfY2xrbWdyX2luaXQoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4g
PiAgICAgICAgIHJldHVybiAwOw0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIGludCBhZ2lsZXg1
X2Nsa21ncl9pbml0KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpIHsNCj4gPiArICAgICAg
IHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAgPSBwZGV2LT5kZXYub2Zfbm9kZTsNCj4gPiArICAgICAg
IHN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ID4gKyAgICAgICBzdHJ1Y3Qgc3Ry
YXRpeDEwX2Nsb2NrX2RhdGEgKmNsa19kYXRhOw0KPiANCj4gTWF5YmUgY2FsbCB0aGlzIHN0cmF0
aXhfZGF0YSBzbyB0aGF0IGNsa19kYXRhLmNsa19kYXRhIGlzIHN0cmF0aXhfZGF0YS5jbGtfZGF0
YS4NCg0KV2lsbCBmaXggdGhpcyBpbiBuZXh0IHZlcnNpb24uIA0KDQo+IA0KPiA+ICsgICAgICAg
c3RydWN0IHJlc291cmNlICpyZXM7DQo+ID4gKyAgICAgICB2b2lkIF9faW9tZW0gKmJhc2U7DQo+
ID4gKyAgICAgICBpbnQgaSwgbnVtX2Nsa3M7DQo+ID4gKw0KPiA+ICsgICAgICAgcmVzID0gcGxh
dGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsNCj4gPiArICAgICAg
IGJhc2UgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoZGV2LCByZXMpOw0KPiANCj4gVGhpcyBpcyBh
IHNpbmdsZSBmdW5jdGlvbiBjYWxsLCBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UoKS5p
DQoNCk5vdGVkLiBXaWxsIGZpeCBpbiBuZXh0IHZlcnNpb24uIA0KDQo+IA0KPiA+ICsgICAgICAg
aWYgKElTX0VSUihiYXNlKSkNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIoYmFz
ZSk7DQo+ID4gKw0KPiA+ICsgICAgICAgbnVtX2Nsa3MgPSBBR0lMRVg1X05VTV9DTEtTOw0KPiA+
ICsNCj4gPiArICAgICAgIGNsa19kYXRhID0gZGV2bV9remFsbG9jKGRldiwgc3RydWN0X3NpemUo
Y2xrX2RhdGEsIGNsa19kYXRhLmh3cywNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgbnVtX2Nsa3MpLCBHRlBfS0VSTkVMKTsNCj4gPiArICAgICAg
IGlmICghY2xrX2RhdGEpDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPiA+
ICsNCj4gPiArICAgICAgIGZvciAoaSA9IDA7IGkgPCBudW1fY2xrczsgaSsrKQ0KPiA+ICsgICAg
ICAgICAgICAgICBjbGtfZGF0YS0+Y2xrX2RhdGEuaHdzW2ldID0gRVJSX1BUUigtRU5PRU5UKTsN
Cj4gPiArDQo+ID4gKyAgICAgICBjbGtfZGF0YS0+YmFzZSA9IGJhc2U7DQo+ID4gKyAgICAgICBj
bGtfZGF0YS0+Y2xrX2RhdGEubnVtID0gbnVtX2Nsa3M7DQo+ID4gKw0KPiA+ICsgICAgICAgYWdp
bGV4X2Nsa19yZWdpc3Rlcl9wbGwoYWdpbGV4X3BsbF9jbGtzLCBBUlJBWV9TSVpFKGFnaWxleF9w
bGxfY2xrcyksDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjbGtfZGF0YSk7
DQo+ID4gKw0KPiA+ICsgICAgICAgYWdpbGV4X2Nsa19yZWdpc3Rlcl9jX3BlcmlwKGFnaWxleDVf
bWFpbl9wZXJpcF9jX2Nsa3MsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgQVJSQVlfU0laRShhZ2lsZXg1X21haW5fcGVyaXBfY19jbGtzKSwNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBjbGtfZGF0YSk7DQo+ID4gKw0KPiA+ICsgICAgICAg
YWdpbGV4X2Nsa19yZWdpc3Rlcl9jbnRfcGVyaXAoYWdpbGV4NV9tYWluX3BlcmlwX2NudF9jbGtz
LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQVJSQVlfU0laRShh
Z2lsZXg1X21haW5fcGVyaXBfY250X2Nsa3MpLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgY2xrX2RhdGEpOw0KPiA+ICsNCj4gPiArICAgICAgIGFnaWxleF9jbGtf
cmVnaXN0ZXJfZ2F0ZShhZ2lsZXg1X2dhdGVfY2xrcywNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBBUlJBWV9TSVpFKGFnaWxleDVfZ2F0ZV9jbGtzKSwNCj4gPiArIGNsa19k
YXRhKTsNCj4gPiArDQo+ID4gKyAgICAgICBvZl9jbGtfYWRkX2h3X3Byb3ZpZGVyKG5wLCBvZl9j
bGtfaHdfb25lY2VsbF9nZXQsDQo+ID4gKyAmY2xrX2RhdGEtPmNsa19kYXRhKTsNCj4gDQo+IGRl
dm0/IE9yIHdoZW4gaXMgdGhpcyBwcm92aWRlciByZW1vdmVkPw0KDQpXaWxsIGZpeCBpbiBuZXh0
IHZlcnNpb24uIA0KDQo+IA0KPiA+ICsgICAgICAgcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+
ID4gIHN0YXRpYyBpbnQgYWdpbGV4X2Nsa21ncl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KSAgew0KPiA+ICAgICAgICAgaW50ICgqcHJvYmVfZnVuYykoc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqaW5pdF9mdW5jKTsNCg==
