Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24849774CB7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236331AbjHHVO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235963AbjHHVOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:14:34 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BC6A267;
        Tue,  8 Aug 2023 13:24:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3hKAfkm6pBkFrPKceCtirzrWGU6CWE9qHO2GgrUKAw413kec3eS1aoJpVHicIqiYsxPLoVceiVHOMFokIVplpl1iespawausnZ8q5J6Agg3z5GtXBjVCLDC7aCpP/vTyigwtCXav/i1vpxE0K/JOGe+OtX8TN9YeMGJUCcBygREv04RQMXv2F21Q+3Ke85k9XOBlonVAWVyd1zG/LsfgH1DasULPbeIEDvNt69kDeTEh4+Rxyro04/wXjdqIYPVqJaDra8mQU5xvSjAe5ObwroO4UvlTWa0DycPla0FK9MEiDg363i0sv3oJ8kMz5oY5Kxk8uadyZ9D5y02fEjfrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hnt9pQO0sp6L/frjpiGpoz6jLhNjj3IELdVXRo3+VL4=;
 b=HXpQJNwUyuDyr7GCSBTMGskVXJNLHJLeqhBdATVWdeadPzSL4Wy6j/aJnSahtkI2kkOTuhjh596J2ckGX5fX5dAsyMPcyrtyY3vrCn2LyVTDv+YdvQjZULq7Rfp5jwg2p+2/L0CI7EEQl91Zj4HBwNLEJDUIRD3wnzhr6Sj0uqp0ax9FbyWHXP+M2mG8Y7k3NgHx3XhzafCW0UMJzBU/2EMdsICB3euPRBJ4tcCg/dCUN85qGWRnA6QL8O7xzshBydCVJbdUcZADAtzum/aQIY4Gd3ZvQR8R2LnD5T9FpCnJAEBSBGrpc8orirWuH973E+6r5AyzWhH8dzGvOUDsSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hnt9pQO0sp6L/frjpiGpoz6jLhNjj3IELdVXRo3+VL4=;
 b=ftX/xlH6M7TWspHjGlkHlYvT5sbgOeUa8kbmLXpcbnGSHWq39HvrUbfETXmj4tvgSfzqOaWE49vlRJYNMFbAJygW5w9QxeRtE1ECHxMf0FUonI1NA+bheESJXbpQwM30q102xoaDvbrNmn6vMHS9P0uizMiv0MugKO+iN1D7pdR2DCUb4z/FGJ7IkRyqHdfgGOvueQf1+m+tmidI49qkdwKHqc2f8vhExRXKSJeU0RrLL6ZM111BhM3GDVwyLHl/GST9kDlk/jNaR+snKaVpk6xFArMutMs0/ABMOUz0/6GlAmTeF/gN0KxH4aqV7aa5RfRfGVATxikXEfPAKTzIWA==
Received: from BN9PR12MB5068.namprd12.prod.outlook.com (2603:10b6:408:135::21)
 by PH7PR12MB5808.namprd12.prod.outlook.com (2603:10b6:510:1d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 20:24:46 +0000
Received: from BN9PR12MB5068.namprd12.prod.outlook.com
 ([fe80::acc8:7a8:c30d:eec8]) by BN9PR12MB5068.namprd12.prod.outlook.com
 ([fe80::acc8:7a8:c30d:eec8%7]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 20:24:46 +0000
From:   Liming Sun <limings@nvidia.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        David Thompson <davthompson@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6] mmc: sdhci-of-dwcmshc: Add runtime PM operations
Thread-Topic: [PATCH v6] mmc: sdhci-of-dwcmshc: Add runtime PM operations
Thread-Index: AQHZxyuq+HOsHtVXXkaFYWsKN9h+fa/gKjSAgAA5XSCAAA5rAIAAbBeA
Date:   Tue, 8 Aug 2023 20:24:46 +0000
Message-ID: <BN9PR12MB5068255F69BCD64A0E95914FD30DA@BN9PR12MB5068.namprd12.prod.outlook.com>
References: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
 <20230804233015.173957-1-limings@nvidia.com>
 <CAPDyKFprnX=37FDdBxiNyyr5X_6zpp87Kt7o1hxdRePZhMJO4A@mail.gmail.com>
 <BN9PR12MB506823B5AF3069C0C8350BE9D30DA@BN9PR12MB5068.namprd12.prod.outlook.com>
 <CAPDyKFq+S544LFH_fMNucd8B8mrV9ORbL+v05q2EnWtgg+8ggA@mail.gmail.com>
In-Reply-To: <CAPDyKFq+S544LFH_fMNucd8B8mrV9ORbL+v05q2EnWtgg+8ggA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5068:EE_|PH7PR12MB5808:EE_
x-ms-office365-filtering-correlation-id: da9e41d5-4cbb-485f-4ab0-08db984d81fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TggOzQ9s6aJgjB9wXEfK++G5v5V4OPtLksd/G4374a4m9NUuMoor8Wund6TpJKU0rxPxXzcNns7g/re8Bxp5pvtLNh9ImKeUKA2oktpDMVHgyDD7HR/0Xz6jRJBNqvhqJeQ1TVTXACuHNcH5jMJZ3OG7FZiWjYzdYZ1Mm7njCguZFErYKqcBNCAgTJ/YzSCQMzmP6aTuKsRmRQfeXAcY5u+BowsoN82mSm+8nHHst7Ra3Fm++iKrN1M0D6VlLf58mvysEQjqUlpt2SVQncjudTyV6r8no7TFX7B3X32RAiD6ErWYxdJfRNCBZmnKdOCqXt8/EjzyPmhYCsJerhkmQS8a3TkTOqH7u6jWVKStlm5vtDwtGOGZmLTTxtEZYpJ9DyLfvD3RwtC22zn2HIyqMMNIk1h/vp+L9HQ9NGtXAXP/Uu7f6BaYNgkHmJw3KYJLtggvveUpzoFGmwOuTOwtRmeA5IDf90ZcDVoW80J5uttlTgwDJ4A/gcqy8YXBc1hPA5+tm32EdmghysU0qERMmR7Tlpq1iKtwDvPKP8XfJ0wu60Dqxu5TYWkyle7/uB/qzNSjbMK39mhOHS04nwMTNLPl9TMf1LkFsTwXZJhG/tOgl/PmBVkM0wlZhcEtyZzXaR0hNO2+I8S8Y+BCs5i16Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5068.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(186006)(1800799003)(451199021)(83380400001)(55016003)(6916009)(2906002)(54906003)(4326008)(316002)(5660300002)(8936002)(38070700005)(66446008)(64756008)(8676002)(66946007)(52536014)(76116006)(66476007)(38100700002)(66556008)(71200400001)(33656002)(478600001)(122000001)(86362001)(9686003)(7696005)(26005)(41300700001)(6506007)(53546011)(133343001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGx6QlNNSkZWblhMRms1SEZZeCs0VGdaMyt5UlpvWU1VU2lTSjA0WU9EK1Bu?=
 =?utf-8?B?Z2EydG1Da050dVlsdFJVV2E5eVVkN25NVHpFTGJITTNPUS9DSEtIQjN3cTlU?=
 =?utf-8?B?WTVOVjFWc3FCQ2VDVzcrTmtjY3paQkJUT0RlTEI4SHlPczcwQ1ViQUJqa1Z4?=
 =?utf-8?B?K01WWUJXV1UweExOem0rakNyNlh6cnB2Qm9xaFRYdkM1dHRYUGc3d1RacW4w?=
 =?utf-8?B?SDYzUnBvN2FaM2pBZjMxRDdZd2VwOHIwNkRvam9KcFQzSjllQjdTeHBiQzFk?=
 =?utf-8?B?b3lyUUpEMng3OWNiY0RZWXZkQnd5OVErZ0FWNmVoSEMrMUdBVTI3SXRsOGtR?=
 =?utf-8?B?VzZTUUgyaWZXaFFabnZPWEJ4NEg4R2xEei9hNVdPazRETVNzcGkvM2tZSFox?=
 =?utf-8?B?SGdBUDZHY3FlWHZySlFTVjF5OWJHSldhU21USmlxViszdWlXNmZSSVZqZldZ?=
 =?utf-8?B?RGRNMDNZRU54cFJQUVFOQVZXVmJOY2x4L1VkRy91R2ovVytVVjBoSmdQVnJR?=
 =?utf-8?B?YzhQOHBSVW9OWWVFTDZhZnYxMm1IWXJsQXFNc3U2MjE1eGc4YnJzWHU1V1JH?=
 =?utf-8?B?dzk4bU1xcjlqa0pLTEM0MTNjWFZ5TnNITWVjYWdXTFZYU0kvQTM1NjhHYkNL?=
 =?utf-8?B?U0NROE50WHhrdUlYcVFwYlNLdGFSTW02TlU4dy9pYVg4bFdOaDFHMmxxUEZz?=
 =?utf-8?B?UmkzYVhLZmp1WkI2L0RNdnlTcjFHUUkrc1dZZ085bys2N0RCdVlxUVMxVDFF?=
 =?utf-8?B?eGlIWnpGbitPOEhOOFlnd1pwSHFTdENrZm05YThneU8rTGM5YVhwRlpCSllR?=
 =?utf-8?B?UklTRVhjbWtRVVl1ZEY3ZWFObXArVXJEWGgvLzNuTXNiTXdFNDFwTFppbjNP?=
 =?utf-8?B?RmQzN3BITCt6dkpPN05MSWoyVTI4WjQ4RStTbC8xZDQwdlMrdU9ZUHkzclNn?=
 =?utf-8?B?QTJJTVpPWEtOUERDZ2MxT1BVMjF4bUxlaDdhaTRpZ1huaGgvQnYxMk8zeElr?=
 =?utf-8?B?OTRmVGdydVNqZlpQY0JLemxabnJMYjRqZjk2Q2pnZDRjcE9peU8wNlNURFAz?=
 =?utf-8?B?SndUVzZFbG5WN3Fidk01MjVaNDE0czVpbE9YMUFXYmxXQ3hqT1RLcVhVSENG?=
 =?utf-8?B?OW91cHp3U05qcG5QdXZJdUUzL0E5bTE5L1FCa2NGeDZuZExCUXU3aXRTZDFr?=
 =?utf-8?B?ZkxSeTV2Z2pYWnprZXhmZlh2Yk5jM092WUxwejd5SDhyUmNsZm1obTNZRzNJ?=
 =?utf-8?B?OUlGcG5ZcjJ3MVRUMWhiaDlhMTl0RlR3NzVHaVJRSkJXUmhKV0hsaVVxdXow?=
 =?utf-8?B?STl4eXAxRTkyZkZuLzAyQm9idjNYOFZPVGQ0NW9rL01PUHBVUEJvU2RRaTJx?=
 =?utf-8?B?S1kxT3Qyak1DV2tVbitmSVZjTkVkQXgra011eGEwZ0F4aGFYNmZ1YmErZEh2?=
 =?utf-8?B?QmZYbTZwblpLMUhaN3VrL3lpcE8xTXl4Y2VFVHN1WXFWTGNEWGJ4Q2FWRzRL?=
 =?utf-8?B?eXhPcFVzNGdtbUh0SHVDNFZocHhROFNKYlNLYXVLSTU0Q0Q1Mkhqa1ZWUzlC?=
 =?utf-8?B?cnExMmdZcUxyWk1ITXBkMGg3OWtIcEFkajRJQjdKb2ExRHg1Z1VacTlEcG5X?=
 =?utf-8?B?RGZxNFhMWmE4aEYrTFl3OFRXUmE3a3dVYVdTUFM1NzNVTEluTG0rbjFPZGhl?=
 =?utf-8?B?SjgyOGFlS29oaU9ZVmkyM3JtdlZNdWExWWp4cE5hb29RckFvKy9iQ21TV2k0?=
 =?utf-8?B?TG1ZYVZZVDN3OGsxcGhWMXBxTzcyT1lMaGNOZURmWDhXMEY1ZThUblY3K2Jv?=
 =?utf-8?B?T2REOXNZaDVYZmNMcEpPMXgrVDBlM2dEdnFUYTdHTGJIdnVmRW0yTDlJMzV6?=
 =?utf-8?B?R0UvUFc3NCtKS1pKNHAzbmhSb3ptcXVITUhDV0phQTJidlRsQ3N3S0xPSkp2?=
 =?utf-8?B?VWl2YVpUOUZyMDV5WDgwL3lxODFyZHJrSmdxWHRIR0tPem9QTUg5NjcyR1Zw?=
 =?utf-8?B?SFRmSHZteERuUXZBR0YzL3ZZT0ZSZ05FVEwxSWwya3JRMWo4NTRrWUl3dXJW?=
 =?utf-8?B?TTJBb1YwMVFmc1pqYjdkSjB1eGdWU2VxYnI3VENXdzVyMDVUUjQxWkVTdFEv?=
 =?utf-8?Q?HZGg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5068.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da9e41d5-4cbb-485f-4ab0-08db984d81fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 20:24:46.3283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zD/KEFKm8t3oBBjcQJs8WrEa55apO9KCOMciwr+Lu0D5W/ppL9PFzURyOXckmQdV0FDE4br/5Uln7jrFgVyb0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5808
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVWxmIEhhbnNzb24gPHVs
Zi5oYW5zc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCA4LCAyMDIzIDk6
NTcgQU0NCj4gVG86IExpbWluZyBTdW4gPGxpbWluZ3NAbnZpZGlhLmNvbT4NCj4gQ2M6IEFkcmlh
biBIdW50ZXIgPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsgRGF2aWQgVGhvbXBzb24NCj4gPGRh
dnRob21wc29uQG52aWRpYS5jb20+OyBTaGF3biBMaW4gPHNoYXduLmxpbkByb2NrLWNoaXBzLmNv
bT47IGxpbnV4LQ0KPiBtbWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjZdIG1tYzogc2RoY2ktb2YtZHdjbXNoYzog
QWRkIHJ1bnRpbWUgUE0gb3BlcmF0aW9ucw0KPiANCj4gT24gVHVlLCA4IEF1ZyAyMDIzIGF0IDE1
OjIxLCBMaW1pbmcgU3VuIDxsaW1pbmdzQG52aWRpYS5jb20+IHdyb3RlOg0KPiA+DQo+ID4NCj4g
Pg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFVsZiBIYW5z
c29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPg0KPiA+ID4gU2VudDogVHVlc2RheSwgQXVndXN0
IDgsIDIwMjMgNTo0MCBBTQ0KPiA+ID4gVG86IExpbWluZyBTdW4gPGxpbWluZ3NAbnZpZGlhLmNv
bT4NCj4gPiA+IENjOiBBZHJpYW4gSHVudGVyIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT47IERh
dmlkIFRob21wc29uDQo+ID4gPiA8ZGF2dGhvbXBzb25AbnZpZGlhLmNvbT47IFNoYXduIExpbiA8
c2hhd24ubGluQHJvY2stY2hpcHMuY29tPjsNCj4gbGludXgtDQo+ID4gPiBtbWNAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4gPiBTdWJqZWN0OiBSZTog
W1BBVENIIHY2XSBtbWM6IHNkaGNpLW9mLWR3Y21zaGM6IEFkZCBydW50aW1lIFBNDQo+IG9wZXJh
dGlvbnMNCj4gPiA+DQo+ID4gPiBPbiBTYXQsIDUgQXVnIDIwMjMgYXQgMDE6MzAsIExpbWluZyBT
dW4gPGxpbWluZ3NAbnZpZGlhLmNvbT4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+IFRoaXMgY29t
bWl0IGltcGxlbWVudHMgdGhlIHJ1bnRpbWUgUE0gb3BlcmF0aW9ucyB0byBkaXNhYmxlIGVNTUMN
Cj4gPiA+ID4gY2FyZCBjbG9jayB3aGVuIGlkbGUuDQo+ID4gPiA+DQo+ID4gPiA+IFJldmlld2Vk
LWJ5OiBEYXZpZCBUaG9tcHNvbiA8ZGF2dGhvbXBzb25AbnZpZGlhLmNvbT4NCj4gPiA+ID4gU2ln
bmVkLW9mZi1ieTogTGltaW5nIFN1biA8bGltaW5nc0BudmlkaWEuY29tPg0KPiA+ID4gPiAtLS0N
Cj4gPiA+ID4gdjUtPnY2Og0KPiA+ID4gPiAgICAgLSBBZGRyZXNzIEFkcmlhbidzIG1vcmUgY29t
bWVudHMgYW5kIGFkZCBjb29yZGluYXRpb24gYmV0d2Vlbg0KPiA+ID4gPiAgICAgICBydW50aW1l
IFBNIGFuZCBzeXN0ZW0gUE07DQo+ID4gPiA+IHY0LT52NToNCj4gPiA+ID4gICAgIC0gQWRkcmVz
cyBBZHJpYW4ncyBjb21tZW50IHRvIG1vdmUgdGhlIHBtX2VuYWJsZSB0byB0aGUgZW5kIHRvDQo+
ID4gPiA+ICAgICAgIGF2b2lkIHJhY2U7DQo+ID4gPiA+IHYzLT52NDoNCj4gPiA+ID4gICAgIC0g
Rml4IGNvbXBpbGluZyByZXBvcnRlZCBieSAna2VybmVsIHRlc3Qgcm9ib3QnOw0KPiA+ID4gPiB2
Mi0+djM6DQo+ID4gPiA+ICAgICAtIFJldmlzZSB0aGUgY29tbWl0IG1lc3NhZ2U7DQo+ID4gPiA+
IHYxLT52MjoNCj4gPiA+ID4gICAgIFVwZGF0ZXMgZm9yIGNvbW1lbnRzIGZyb20gVWxmOg0KPiA+
ID4gPiAgICAgLSBNYWtlIHRoZSBydW50aW1lIFBNIGxvZ2ljIGdlbmVyaWMgZm9yIHNkaGNpLW9m
LWR3Y21zaGM7DQo+ID4gPiA+IHYxOiBJbml0aWFsIHZlcnNpb24uDQo+ID4gPiA+IC0tLQ0KPiA+
ID4gPiAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1kd2Ntc2hjLmMgfCA3Mg0KPiA+ID4gKysr
KysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA3MCBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1kd2Ntc2hjLmMNCj4gYi9kcml2ZXJzL21tYy9o
b3N0L3NkaGNpLQ0KPiA+ID4gb2YtZHdjbXNoYy5jDQo+ID4gPiA+IGluZGV4IGU2OGNkODc5OThj
OC4uYWFmNjYzNThmNjI2IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL21tYy9ob3N0L3Nk
aGNpLW9mLWR3Y21zaGMuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9m
LWR3Y21zaGMuYw0KPiA+ID4gPiBAQCAtMTUsNiArMTUsNyBAQA0KPiA+ID4gPiAgI2luY2x1ZGUg
PGxpbnV4L21vZHVsZS5oPg0KPiA+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L29mLmg+DQo+ID4gPiA+
ICAjaW5jbHVkZSA8bGludXgvb2ZfZGV2aWNlLmg+DQo+ID4gPiA+ICsjaW5jbHVkZSA8bGludXgv
cG1fcnVudGltZS5oPg0KPiA+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L3Jlc2V0Lmg+DQo+ID4gPiA+
ICAjaW5jbHVkZSA8bGludXgvc2l6ZXMuaD4NCj4gPiA+ID4NCj4gPiA+ID4gQEAgLTU0OCw5ICs1
NDksMTMgQEAgc3RhdGljIGludCBkd2Ntc2hjX3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZp
Y2UNCj4gPiA+ICpwZGV2KQ0KPiA+ID4gPg0KPiA+ID4gPiAgICAgICAgIGhvc3QtPm1tYy0+Y2Fw
cyB8PSBNTUNfQ0FQX1dBSVRfV0hJTEVfQlVTWTsNCj4gPiA+ID4NCj4gPiA+ID4gKyAgICAgICBw
bV9ydW50aW1lX2dldF9ub3Jlc3VtZShkZXYpOw0KPiA+ID4gPiArICAgICAgIHBtX3J1bnRpbWVf
c2V0X2FjdGl2ZShkZXYpOw0KPiA+ID4gPiArICAgICAgIHBtX3J1bnRpbWVfZW5hYmxlKGRldik7
DQo+ID4gPiA+ICsNCj4gPiA+ID4gICAgICAgICBlcnIgPSBzZGhjaV9zZXR1cF9ob3N0KGhvc3Qp
Ow0KPiA+ID4gPiAgICAgICAgIGlmIChlcnIpDQo+ID4gPiA+IC0gICAgICAgICAgICAgICBnb3Rv
IGVycl9jbGs7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICBnb3RvIGVycl9ycG07DQo+ID4gPiA+
DQo+ID4gPiA+ICAgICAgICAgaWYgKHJrX3ByaXYpDQo+ID4gPiA+ICAgICAgICAgICAgICAgICBk
d2Ntc2hjX3JrMzV4eF9wb3N0aW5pdChob3N0LCBwcml2KTsNCj4gPiA+ID4gQEAgLTU1OSwxMCAr
NTY0LDE1IEBAIHN0YXRpYyBpbnQgZHdjbXNoY19wcm9iZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2
aWNlDQo+ID4gPiAqcGRldikNCj4gPiA+ID4gICAgICAgICBpZiAoZXJyKQ0KPiA+ID4gPiAgICAg
ICAgICAgICAgICAgZ290byBlcnJfc2V0dXBfaG9zdDsNCj4gPiA+ID4NCj4gPiA+ID4gKyAgICAg
ICBwbV9ydW50aW1lX3B1dF9zeW5jKGRldik7DQo+ID4gPiA+ICsNCj4gPiA+DQo+ID4gPiBUaGUg
YXN5bmMgcG1fcnVudGltZV9wdXQoKSBpcyBwcm9iYWJseSBzdWZmaWNpZW50IC0gYW5kIGl0IHdv
dWxkIGFsbG93DQo+ID4gPiB0aGUgcHJvYmUgdG8gY29tcGxldGUgYSBiaXQgInNvb25lciIuDQo+
ID4NCj4gPiBTdXJlLCB3aWxsIHRlc3QgYW5kIHVwZGF0ZSB0aGUgbGluZSBpbiB2Ny4NCj4gPg0K
PiA+ID4NCj4gPiA+ID4gICAgICAgICByZXR1cm4gMDsNCj4gPiA+ID4NCj4gPiA+ID4gIGVycl9z
ZXR1cF9ob3N0Og0KPiA+ID4gPiAgICAgICAgIHNkaGNpX2NsZWFudXBfaG9zdChob3N0KTsNCj4g
PiA+ID4gK2Vycl9ycG06DQo+ID4gPiA+ICsgICAgICAgcG1fcnVudGltZV9kaXNhYmxlKGRldik7
DQo+ID4gPiA+ICsgICAgICAgcG1fcnVudGltZV9wdXRfbm9pZGxlKGRldik7DQo+ID4gPiA+ICBl
cnJfY2xrOg0KPiA+ID4gPiAgICAgICAgIGNsa19kaXNhYmxlX3VucHJlcGFyZShwbHRmbV9ob3N0
LT5jbGspOw0KPiA+ID4gPiAgICAgICAgIGNsa19kaXNhYmxlX3VucHJlcGFyZShwcml2LT5idXNf
Y2xrKTsNCj4gPiA+ID4gQEAgLTYwNiw2ICs2MTYsMTIgQEAgc3RhdGljIGludCBkd2Ntc2hjX3N1
c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ID4gPiAgICAgICAgIGlmIChyZXQpDQo+ID4g
PiA+ICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ID4gPg0KPiA+ID4gPiArICAgICAg
IHJldCA9IHBtX3J1bnRpbWVfZm9yY2Vfc3VzcGVuZChkZXYpOw0KPiA+ID4NCj4gPiA+IENhbiBk
d2Ntc2hjX3N1c3BlbmQoKSBiZSBjYWxsZWQgZm9yIGEgZGV2aWNlIHRoYXQgbWF5IGJlIGF0dGFj
aGVkIHRvDQo+ID4gPiB0aGUgQUNQSSBQTSBkb21haW4/DQo+ID4NCj4gPiBCbHVlRmllbGQgU29D
IGlzIHRoZSBvbmx5IGNoaXAgdGhhdCB1c2VzIEFDUEkgaW4gdGhpcyBkcml2ZXIgZm9yIG5vdyBh
bmQgaXQNCj4gZG9lc24ndCBzdXBwb3J0IFN5c3RlbSBTbGVlcC4gVGh1cywgdGhlIGR3Y21zaGNf
c3VzcGVuZCgpIHdvbid0IGJlIGNhbGxlZC4NCj4gQnV0IEkgZ3Vlc3MgaXQgbWlnaHQgYmUgcG9z
c2libGUgd2hlbiBvdGhlciBuZXcgY2hpcCBzdXBwb3J0IGlzIGFkZGVkIGludG8gdGhpcw0KPiBk
cml2ZXIuIElzIGl0IGEgY29uY2Vybj8NCj4gDQo+IFRoZSBBQ1BJIFBNIGRvbWFpbiBkb2Vzbid0
IHN1cHBvcnQgZHJpdmVycyB1c2luZw0KPiBwbV9ydW50aW1lX2ZvcmNlX3N1c3BlbmR8cmVzdW1l
KCkuIFVubGVzcyB0aGF0IGhhcyBiZWVuIGNoYW5nZWQNCj4gd2l0aG91dCBtZSBrbm93aW5nIGFi
b3V0IGl0Lg0KPiANCj4gQW55d2F5LCBpdCBsb29rcyBsaWtlIGl0IHNob3VsZG4ndCBiZSBhIHBy
b2JsZW0gYXQgdGhpcyBwb2ludC4gV2UgY2FuDQo+IGFsc28gYWRkIHNlcGFyYXRlIGNhbGxiYWNr
cyBmb3Igb3RoZXIgU29DcywgaWYgdGhhdCBjb21lcyBpbnRvIHBsYXkNCj4gZ29pbmcgZm9yd2Fy
ZC4NCg0KVGhhbmtzLiBTbyBubyBmdXJ0aGVyIGNoYW5nZXMgZm9yIG5vdy4NClBvc3RlZCB2NyAo
Zm9yIHRoZSBvdGhlciBjb21tZW50KS4NCg0KPiANCj4gWy4uLl0NCj4gDQo+IEtpbmQgcmVnYXJk
cw0KPiBVZmZlDQo=
