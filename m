Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70967F7253
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 12:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345713AbjKXLDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 06:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345362AbjKXLDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 06:03:21 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62BCD53;
        Fri, 24 Nov 2023 03:03:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HsBke4St/MBmVYxZ+GgRKtfwhwt/GuxUDYro2sMuGwRfUGRxGr18ufCuSKCARN0H5iK5q6+Ht6sVLYDf3gQWJF6j8zubldNlCWk9mfIrEPBLRth3z9YrSbyP7OaQBgLXkYveZte6id8MvmiQyzlpSOVU96+4MCfooptkRY+BRZkAFtjZZLvIYEwaNXyZQYHY5LWDuEd0aHofxSEtptuAP4mv6UqDSK92onC7/UcC4ikjiJc36CfXTvny3292XFPtmwgQlb9/DfcbCfwdGLlv0i36SEApaFC8KumNF/y1hUJYeg9BfElF2cvZdybhLsAdsfX4LjmQGBN+HMQ0y1XF+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qNV0AVA0tl71Lad5M9DpIYInm04C+jnGEaD/xxjn+qo=;
 b=VJzSt/KVotquURuvWmbEFtbReiNQvRZNGe1iRW+H9SITzEgGYF7cXGfUUxAu9+BeHogR17xO+NCaLYonupKpCHx33P4Ntg/icaZhSlCdt0TmJ7rWh5ZoI30Uw9CDfgBeGInVPprIUEQkfCM6RnC03eLem1FXExBPqlK4VU6Hs9ygrhLzUeIBEePYiQNDj1BiTT4Qd+C9UFgdm1iclqSYygpiZvZN4i00svUmGLf0/BvBkiaorkhY51xwko/+kzMqDC22aTksNU++XLCDroowlgG0XGVYE3zSzwbALh8/AHOXBcDDycWP/4+ALkjZxnaMyf3l5KhXOr6hUwUhmw1Kag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qNV0AVA0tl71Lad5M9DpIYInm04C+jnGEaD/xxjn+qo=;
 b=z8NmzEfokQlLb4WH1Fhl14KCmpWZqBLg11GX3FQs9To+HlQJ8OjxWGpLOMA52ZCiXxPRFVMLfv2FTMFPpBjrvRAyh8q3llNMTth67qiW0217r1v5xbbK5hJZpJzcgFiCqU5bv0I20USQal2zakdd9CCialicbVqqhmWFSNtck+o=
Received: from DM4PR12MB5938.namprd12.prod.outlook.com (2603:10b6:8:69::9) by
 CY8PR12MB8268.namprd12.prod.outlook.com (2603:10b6:930:6c::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.19; Fri, 24 Nov 2023 11:03:24 +0000
Received: from DM4PR12MB5938.namprd12.prod.outlook.com
 ([fe80::6397:2723:2d20:5d8b]) by DM4PR12MB5938.namprd12.prod.outlook.com
 ([fe80::6397:2723:2d20:5d8b%6]) with mapi id 15.20.7025.022; Fri, 24 Nov 2023
 11:03:24 +0000
From:   "Sayyed, Mubin" <mubin.sayyed@amd.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "mubin10@gmail.com" <mubin10@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "Simek, Michal" <michal.simek@amd.com>
Subject: RE: [LINUX PATCH v2 1/3] clocksource: timer-cadence-ttc: Do not probe
 TTC device configured as PWM
Thread-Topic: [LINUX PATCH v2 1/3] clocksource: timer-cadence-ttc: Do not
 probe TTC device configured as PWM
Thread-Index: AQHaFvj4QMudblc/L0uc3zBCSY9LkrB6UCsAgACFcMCAAHYrAIAOELBw
Date:   Fri, 24 Nov 2023 11:03:24 +0000
Message-ID: <DM4PR12MB5938CB10059DF7E39A2A0E239DB8A@DM4PR12MB5938.namprd12.prod.outlook.com>
References: <20231114124748.581850-1-mubin.sayyed@amd.com>
 <20231114124748.581850-2-mubin.sayyed@amd.com>
 <d37db10b-f9fa-49b0-8b1e-36e20acbcfd6@linaro.org>
 <DM4PR12MB593888B73B65D25E42490EF29DB1A@DM4PR12MB5938.namprd12.prod.outlook.com>
 <e0f28ec5-b980-490b-a857-5218fe521381@linaro.org>
In-Reply-To: <e0f28ec5-b980-490b-a857-5218fe521381@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5938:EE_|CY8PR12MB8268:EE_
x-ms-office365-filtering-correlation-id: 57aaabfc-cd9c-413c-4543-08dbecdcfaba
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q8hutmZBwH0V7572qm7DdwozfCFmA+AZvYXqiaj88Ki4PJ3c+awsTvObtnNYIKBdHDB7Bk2F86OSlLqu2phyuwENkqVrL59J3reQc23rM/YvxBak6Ilvm6qQiVr4SxaAQ8OfsDLDILJMSQ5fGdT95g4eWISR8HtBFFeRfGykmDnCrGdkOlNcztSt9oDAobZCm5Yjt7v2V227rfVr4sgExbEuTv1rrNRWChYPFB+TR/2ktHzLKv3d3rGggHnDpqEQPzjYA7nH99d8Ym/v1kYiYvWgJFyXcRgdBDHOyRO70e8XX6cWaRPWPpLUlzHJT92lq0MoUv81dt4QriW6+jYaWskrehmIy6ljJPwTDNf8UsAAlSKjqiNJqGftsyt40tUuLAHtL1YmWujft0WbbMOk9gNVrTNCpmJRjMFZKD58QKCN7fDC6Q2Lv8V8UxaeqHXAxTnyOtxxKDzjiJ17+X+Zr4Sv1Y+iq9CeRyfBpm8DX6tbUMPoss2LPQRq3c14uqjr9Fr4a5w2r5rQ+A1rMhO82F8Q1ZLufWNlYJ7bSfjiPslSWZL8jTa3CEZQvse/3WWO5bZ64w7ycM0idMfwkYqFzJGgu4FD48uvlgvIpPK8WrI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5938.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(39860400002)(346002)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(316002)(33656002)(122000001)(86362001)(38100700002)(38070700009)(83380400001)(6916009)(4326008)(8936002)(64756008)(5660300002)(8676002)(76116006)(66556008)(66446008)(66476007)(66946007)(7416002)(55016003)(41300700001)(52536014)(2906002)(53546011)(71200400001)(54906003)(7696005)(6506007)(9686003)(966005)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXBOOTZ5NzZTYmZWZytUeThNWTBuM2txTjlDRWp5bkkrVnZ6SkpLQ0Nlalo1?=
 =?utf-8?B?eWhnenNHZnd2Nmh5aittYmM5bFBEaDBvT3VTNnBaSk9rUXFhRW1wZWc1QzJo?=
 =?utf-8?B?TzBXcmpxZ0pwcEhtQTVtWkc4Snh1UC9iMCtQaGJUaFBBY1owZmEyY1NES21R?=
 =?utf-8?B?LzRoTlZDaE5tVlJjZm0rd3dxci90OWl1b0hpeDI1UnNwck1Lc2UrSk96allo?=
 =?utf-8?B?dVlIaXNBUjYwTis0Z2NFR29mb0dUaEU1UTdBZkpMaHpXTDlxWldLYXpPd1dK?=
 =?utf-8?B?WFJ3SVRMU1dua080V2tPaGlmNXQxQ3laNGNWcUFrNVVTWEduaFdncEJqV1ZG?=
 =?utf-8?B?NVpIelJOTkxlc1lLT3E3VE91VHpTZmZIOFp2cnZIR0FPY0luWURMWU9GVkgx?=
 =?utf-8?B?ZSs0UDhKamYvTGxJMUY2TlZ3cGdZWE5nU0RVZjFaeGpDWWpEQ1Zrak9QNUFy?=
 =?utf-8?B?WkFWRHZMc3JHZFRubGhWbmZlaU10NnMrK0xzWXNGeHRBMC9qZ3hhK0pzVDF6?=
 =?utf-8?B?T0NtTVlyYTFkdC9IeC95NnhWVjRmNU8vZ0tKdHhHR2NORkdNL3pwUW1KZnNZ?=
 =?utf-8?B?cGZGVkdMQ3BSWlRScU1pY1VadXNEeUN3R3YxeUpZUVBwdGtmWjBRUnFwcEhD?=
 =?utf-8?B?aG5TcklNRkRTUk5mRzUxd211dm8rWWxLU0UwUDJzWXpXTlpvZUpSdWdNZlh3?=
 =?utf-8?B?UTlBdmkyZC9tbHU4M2xLd21HK0gwT0ZFU0NPRXFEWVNINHBCLzRqNzN5MFF3?=
 =?utf-8?B?Z3NxQjI4aEJsN0M3N1FTUWU2MHZEZlkwNEk0UWlBQllwV1pqS01vaHF5K09O?=
 =?utf-8?B?VWFSc1E1dExnWlg1VGovQU5iTy9Vd1ZpMmkvUzFOdHluaEJNbFlIZWFtZWN0?=
 =?utf-8?B?V3ZJRFJkcjU4ZUNmdXAzSTRIcFJNYTNoTEx5RWZUNGdXVnNVc3dDRWVMYkls?=
 =?utf-8?B?V1BoLzU0YWpYcGlGRStxZERtYllWVUxsd003WUVzTmZ6V09jUFJrMEZDZ1po?=
 =?utf-8?B?YklTdVhVWmhrcVg0bDFIRWsyTnpOTTRtZWxndVA3ZDg0eU5RSERiVzJaZTdE?=
 =?utf-8?B?WWFaUmRCT0hyaTVJZHJUNTZNZ0FxVUhVTi9nTVEzSHJ5TnR4TkpkekUybFJp?=
 =?utf-8?B?eDQyQjl4bWgxckJmUUZrMXdBenE4b0J1d0tRdzJXQ1prZ2FJOUg2c3orcnFH?=
 =?utf-8?B?S3BmYXR2R2lUOXJMNnhSSkl0VkQzQUxiWWl2M3FMZ2FWVUdmWk1haFRQWG0x?=
 =?utf-8?B?Q3lkZzlzckFGRVgwYkExZlAxZlJNTVpDdlhvNndYSlpPWXJmRFJ5eWZENHd2?=
 =?utf-8?B?eU9HYmsxRjJtSGpqUGIwZjBtQkhpNUFYUnp3UXd1UUtiRE1NUVhhMVlicHFO?=
 =?utf-8?B?QmhwUHdGckhXc1R4UzUwbzFWV0pyRkRaQnhIN3FjZVlyYkpvVmJMTEl4QjV4?=
 =?utf-8?B?ZHlXc0hNZU5XUThZa0NIbEZjN0tTNmdEd3pNaytLNzJwSUJlRUF2S1NiRkF5?=
 =?utf-8?B?bk9RZmNZMVk4MjRpWUl6bVMxcjNnbEY5MGRBV2FqRWxITEZpV0k1OS8rRTcv?=
 =?utf-8?B?YUE0aWRUV1NvRHdxMWZCYXNmODhycjFxaE1obFpYd1k2M3JlWVJCd09qV0ZT?=
 =?utf-8?B?bllCNmQwK3I2YlZkTnJ0cC9qUThURHNXTDh1SDRNRU5DTW1PNzNTZlA3aGha?=
 =?utf-8?B?bTk0TjVidm03aXZPQ1V2MXVZMUlZL0tSOFVZUXlrVjc4MG5OTEhXS3o2NXA5?=
 =?utf-8?B?UVptc2NwNS9VWDUxc3RjaW5LUXhGNVIvMWRyMVM4NTkvOVllQmhjU2ZGVmx0?=
 =?utf-8?B?ZzBXUjVLWXRQUncxMldYeHZQc1dRRXVhSjNqbHBWZlgxNzBHZ3lBWjlNVTV4?=
 =?utf-8?B?UDRLd0hwdTEyMjRGdmpWZzk2TjVHcG5MUTduYi9sYmdpUUNMOWIxRVVaSi9m?=
 =?utf-8?B?cXErSjREaHM1WGlmTklyV1VXNzk3S1k2YVF1amQrSHVjRFMrc05qcWNtdVd6?=
 =?utf-8?B?bnFHVGpDQ0lwTmlac2xnUVUyRHYrVHBCQkdtSFVYaEFZTXRqMTQwY3E0S0Vh?=
 =?utf-8?B?SWh5TGY0ZEpzbE9VNllWYnpvczhmM0k3RjZLQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5938.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57aaabfc-cd9c-413c-4543-08dbecdcfaba
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2023 11:03:24.6203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OvHQYHa7WC1u7DEQvx2L4MzZ7HeYuIyPn8De+dXiVCF2WODqRuZ/yQ1jGcICbC0hy912Kwq8aA79sAz1HwAiWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8268
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEty
enlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gU2Vu
dDogV2VkbmVzZGF5LCBOb3ZlbWJlciAxNSwgMjAyMyA1OjQxIFBNDQo+IFRvOiBTYXl5ZWQsIE11
YmluIDxtdWJpbi5zYXl5ZWRAYW1kLmNvbT4NCj4gQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXB3bUB2Z2VyLmtlcm5lbC5vcmc7IGdpdCAoQU1ELVhp
bGlueCkNCj4gPGdpdEBhbWQuY29tPjsgbXViaW4xMEBnbWFpbC5jb207IGtyenlzenRvZi5rb3ps
b3dza2krZHRAbGluYXJvLm9yZzsNCj4gdS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlOyB0
aGllcnJ5LnJlZGluZ0BnbWFpbC5jb207DQo+IHJvYmgrZHRAa2VybmVsLm9yZzsgY29ub3IrZHRA
a2VybmVsLm9yZzsgdGdseEBsaW51dHJvbml4LmRlOw0KPiBkYW5pZWwubGV6Y2Fub0BsaW5hcm8u
b3JnOyBTaW1laywgTWljaGFsIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtMSU5VWCBQQVRDSCB2MiAxLzNdIGNsb2Nrc291cmNlOiB0aW1lci1jYWRlbmNlLXR0YzogRG8g
bm90IHByb2JlDQo+IFRUQyBkZXZpY2UgY29uZmlndXJlZCBhcyBQV00NCj4gDQo+IE9uIDE1LzEx
LzIwMjMgMDY6NTUsIFNheXllZCwgTXViaW4gd3JvdGU6DQo+ID4+PiArCS8qDQo+ID4+PiArCSAq
IElmIHB3bS1jZWxscyBwcm9wZXJ0eSBpcyBwcmVzZW50IGluIFRUQyBub2RlLA0KPiA+Pj4gKwkg
KiBpdCB3b3VsZCBiZSB0cmVhdGVkIGFzIFBXTSBkZXZpY2UuDQo+ID4+PiArCSAqLw0KPiA+Pj4g
KwlpZiAob2ZfcHJvcGVydHlfcmVhZF9ib29sKHRpbWVyLCAiI3B3bS1jZWxscyIpKQ0KPiA+Pj4g
KwkJcmV0dXJuIC1FTk9ERVY7DQo+ID4+DQo+ID4+IFlvdSB3aWxsIGludHJvZHVjZSBkbWVzZyBl
cnJvcnMsIHNvIHJlZ3Jlc3Npb25zLg0KPiA+Pg0KPiA+IFtNdWJpbl06IEkgd2lsbCBjaGFuZ2Ug
aXQgdG8gInJldHVybiAwIiB0byBhdm9pZCBkbWVzZyBlcnJvcnMuDQo+IA0KPiBObywgYmVjYXVz
ZSBzb2x1dGlvbiBpcyB3cm9uZy4NCj4gDQo+ID4NCj4gPj4gVGhpcyBkb2VzIG5vdCBsb29rIHJp
Z2h0LiBXaGF0IHlvdSB3YW50IGlzIHRvIGJpbmQgb25lIGRldmljZSBkcml2ZXINCj4gPj4gYW5k
IGNob29zZSBkaWZmZXJlbnQgZnVuY3Rpb25hbGl0eSBiYXNlZCBvbiBwcm9wZXJ0aWVzLg0KPiA+
IFtNdWJpbl06ICBJIGFtIGRvaW5nIGl0IGJhc2VkIG9uIGVhcmxpZXIgZGlzY3Vzc2lvbiByZWxh
dGVkIHRvIEFYSSBUaW1lciBQV00NCj4gZHJpdmVyLiAgSXQgd2FzIHN1Z2dlc3RlZCB0byB1c2Ug
I3B3bS1jZWxscyBwcm9wZXJ0eSBmb3IgaWRlbnRpZnlpbmcgcm9sZSBvZg0KPiBkZXZpY2UoUFdN
L2Nsb2Nrc291cmNlKSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC0NCj4gZGV2aWNldHJl
ZS8yMDIxMDUxMzAyMTYzMS5HQTg3ODg2MEByb2JoLmF0Lmtlcm5lbC5vcmcvLg0KPiANCj4gWW91
IGFyZSBtaXhpbmcgYmluZGluZ3Mgd2l0aCBkcml2ZXIuIEkgc2FpZCBoZXJlIGFib3V0IGRyaXZl
ciBhbmQgeWVzIC0geW91IG11c3QNCj4gdXNlIHB3bS1jZWxscyB0byBkaWZmZXJlbnRpYXRlIHRo
YXQuIEl0J3Mgb2J2aW91cy4NCj4gDQo+IFNvIGFnYWluLCBvbmUgZHJpdmVyIGJpbmRpbmcuDQpb
TXViaW5dOiBJIHdpbGwgZXhwbG9yZSB3aGV0aGVyIG1mZCBmcmFtZXdvcmsgY2FuIGJlIHVzZWQg
dG8gaGFuZGxlIHRoaXMuDQoNClRoYW5rcywNCk11YmluDQo+IA0KPiBXcmFwIHlvdXIgZW1haWxz
IHRvIG1haWxpbmcgbGlzdCBkaXNjdXNzaW9uIHN0eWxlLg0KPiANCj4gQmVzdCByZWdhcmRzLA0K
PiBLcnp5c3p0b2YNCg0K
