Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04EC87EBCDF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 06:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbjKOFzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 00:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKOFz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 00:55:29 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B98F8E;
        Tue, 14 Nov 2023 21:55:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vds0bihFQq131GuzaYxpR+6toCufaVkJYvukYbrXE8vvXW57wghlKDoLyTesOB3fr5JKTpBpKe5fBFawjv3V5QbwopcqBK+7fANkZ98Gvt8AcjT27QWzJDKbEWSFavWpRQxxWAZv9o7jUr1qUdj46UE+D2BgyHpPT9ZLiU4MqE1UMMVOKEcxPCI4fKbc7eFOZ79Mw4j9LryeFCpFa+00AweXeQQzK9BmOTQ2cBzwhVj+wOP7u1Emn1t3pn42+sXywzxB5a6Nv4NzU/rfqA0BKNby6Z2fB2KVrGPeYo3pOtDcqZjBKFTJwaXXYu61fKs7UiNz4e3+hmfoAsixUZ3P7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YUwmwVyYZIAiWhdxHilmCXnCbh9W5I/iefHKun4NeU=;
 b=CwkQ8G4CiNqKdDwAyDRaVulVmfJ4LBuFcARrNorPMni3xf1+L9M9al6xjD0bos7/77aDnwSyD3ajNk+PS4bT81UUFkLDpaXeBqScp6dyf9RN7GhwdPDiDZfvoOb0K88pfH4Rf9uE1jrZUi8jqMDoETZE3JCz0Tb0MshdXaUa0W+ifYh5lKnzWsqaySqih6kDSGMiPJcvj2f/YC/EMzcTVxvEzCTzytO7Sh7CIC4fjrwVTg1yUnVybZkDOXkk0G37SxGDHe5NHzkrt4T1dFL/BX+L/ZOqxNWChvSXEfPIr4ET7u6UfzwD5BMHU1Ku8n+ltlHUZgd8T1iGptBBOta/UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YUwmwVyYZIAiWhdxHilmCXnCbh9W5I/iefHKun4NeU=;
 b=iBOl8IYNuPp796hAmAk1VLedlG/12ka1vGq7znYrPKTSDPQYIEva1rm/Z0JqS8vgGnoiLyUlStXwx+2D8rMmpA77G5CQMRkLCNn5BeyhBkmnj8e5AjsKPVlbBkI+w7tc5vqzer/pD+aHnYhdTDHNlmjq0TNNKMO070vhIG07zAs=
Received: from DM4PR12MB5938.namprd12.prod.outlook.com (2603:10b6:8:69::9) by
 MW4PR12MB6921.namprd12.prod.outlook.com (2603:10b6:303:208::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.17; Wed, 15 Nov 2023 05:55:22 +0000
Received: from DM4PR12MB5938.namprd12.prod.outlook.com
 ([fe80::6397:2723:2d20:5d8b]) by DM4PR12MB5938.namprd12.prod.outlook.com
 ([fe80::6397:2723:2d20:5d8b%6]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 05:55:22 +0000
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
Thread-Index: AQHaFvj4QMudblc/L0uc3zBCSY9LkrB6UCsAgACFcMA=
Date:   Wed, 15 Nov 2023 05:55:22 +0000
Message-ID: <DM4PR12MB593888B73B65D25E42490EF29DB1A@DM4PR12MB5938.namprd12.prod.outlook.com>
References: <20231114124748.581850-1-mubin.sayyed@amd.com>
 <20231114124748.581850-2-mubin.sayyed@amd.com>
 <d37db10b-f9fa-49b0-8b1e-36e20acbcfd6@linaro.org>
In-Reply-To: <d37db10b-f9fa-49b0-8b1e-36e20acbcfd6@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5938:EE_|MW4PR12MB6921:EE_
x-ms-office365-filtering-correlation-id: fb5439fd-9399-4179-05e8-08dbe59f74f6
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KEULrTleTOmwPcu+/Qp/68XD0LSo/lV/EQfjFbSFl62XdyWjUqeNCRtZloiuki0MxQspTbPELc4BjxEuSrX7qGA1TPqvPlhiF2ADGZndifF/KRqI36VMrHNnURk0hxEQCr9h/Yesyx7tNUsGoOnNFCdNvbqxNgeV1StB+9ZwfJYQbUUs+zSy5fFmKKolnFK3OAojDS8/3zY5gk9CFCPM8usFYOEEBqT9TFWL7AJBCKOk1NjjalPq/N6OkpO6ttjWFEtUKPFEya2YEwWa3TF2VIxDvTDrEZyR3K/BZamgq/0AbIFCFgRPyM1jgfjzYWFqNc/tG00VbaIXuStnZgfZ+Uv876bDcbBXttDDlvBbG6kgQkHdd4gvtcyiXEc3EsRdMAvG4OXOSGU1cXK3hQmxWvQTS8VUIhwtArnosvBsRHRznnimELSBjc0V0GmUh9z5uu01yKXqW0kvGKNlWA/k9VnP4zJGBn46Wb69uovE5Yi8G5A2BocSdmvb08hsIvdEm7oVyUgOrTMV8SMJxpzrih6o52So9gjE4XiEUIMsuUU00HmUiHyCbkISFXPoKLGH+D/vQxSUw8oZ3Z0Rpa6zkA1adPh34JTgXsJEcGEOZ0U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5938.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(39860400002)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(71200400001)(26005)(53546011)(7696005)(6506007)(9686003)(83380400001)(4326008)(8936002)(5660300002)(8676002)(7416002)(52536014)(41300700001)(2906002)(966005)(478600001)(316002)(86362001)(6916009)(64756008)(66446008)(66476007)(66556008)(66946007)(54906003)(76116006)(122000001)(33656002)(38100700002)(38070700009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0pQdEU5VnBKQWZLczZyZDdvZWpxWk1NdGlVc2g5bmduS3VnMGFyRmhzWDYx?=
 =?utf-8?B?VXdwOVlMSFY3UXd2eDY3aFdqem1PY1VIRHdZalBJQ2E4eHJOQzNEamtLcXM4?=
 =?utf-8?B?encrSjVjMEJueXlabVVzaEZybGlIbldYZFhlTlRYQUFHTUZHWkJMcmMwa0Ix?=
 =?utf-8?B?dGxJTEpWRy90VVVDQ0lhdGVKNzJxYTRFY0dZVElEZ1lQMTdWd1V0K3Q4RlVz?=
 =?utf-8?B?SHhlMEJ5VEZ2TEpFV0J6WlAybWxzUXZHWWpKWTFvUmpLVHh4R3cyYlo4ZDBp?=
 =?utf-8?B?b0NqNERYbExPMGdIc3kwN1c2dTlUSE9QOU1ZVU43VnZucm1PeVhSVkJ2bG5U?=
 =?utf-8?B?Rno3YjdDaFhqYWppWlpXakxRem1QczhkWkdsZ09NYnBsQWx2a0Q1WkVneSsy?=
 =?utf-8?B?MC9NUDI5NFZ6OUkwbHV6WlJrUy9QM0ZVMlVBYmVlbWJqcmpiNHBlSGtlNnZX?=
 =?utf-8?B?RUdPZGxLU0hlYTRBdHgvNURJSmlzTUY1UlYrQ2ttd3U2d0ZRT2l1Uk1YVXBH?=
 =?utf-8?B?MzJNNmZQbmJNOHFoRlMyV0oxK0ZpTmJ0dDJ0bHBoNkt1cE9BemZDbUVKNmVO?=
 =?utf-8?B?TlM3dVIwM1BuSTBVc0pqYlJVeG1yaVIwbWtOK1dFcTFkRnNTY1dRcmRvUkVw?=
 =?utf-8?B?aUp0Q3Y0WjR1b2tCSUFRbHUvOXJ4aERDbTVhTTgwMVlqWGZxS0VqQTI3QWJi?=
 =?utf-8?B?TGdmdS9ybm9GaHk3RkY3NFQrcDhBOFR2c1M2SG1kY01iYlF2UVNSRmNodlZW?=
 =?utf-8?B?UEhiVTlGU2lpdjJGWmpvbW9EendpNGF2ZjBpMnZ2NDRZTGF0Z0FnekkzbE1q?=
 =?utf-8?B?ZFNjTTNtZU41ODF1L0M5Uk1QS2RSVTZYVXNocWJhZTNxamdZcC8zb3JCV29s?=
 =?utf-8?B?TnlJWFhIRzlOZnc3SUpwcURxNlRlWjVTY1d1QklwTnh2MzNNa2FDMUJhTHpv?=
 =?utf-8?B?UWNmbnhDWDljN3o2ZytrWUVvb0xqbFNFUjhpOXRQYkpIeU9jdVUzbVBwclNw?=
 =?utf-8?B?cXNyUmhCMldyT1NXS1cvZUM0MGppN2x2M0p4WGpXTUc5UHNqd0Y0b2wzVUta?=
 =?utf-8?B?T3NVSFN5eUR6NTRldFF6d3RSZGtuaDIwTExwSDVhVFBqcnpZNVVTbWdUMS9R?=
 =?utf-8?B?ZmVFS21OcWtCZjArNm9vY05HRWFBN0ZFeFNkL2FMWVZUOUFRSHIxWng5eFAz?=
 =?utf-8?B?eWliankyQmlMQVNjcGozRGU4N0tDR2V5d01PSlJ6UjRrU2ludllibVpEQWxk?=
 =?utf-8?B?ckpTOEpzeFVKd0Y4d0NxNm9iVnlLeXU1TEFZYnBFMlpVcDNsNHBCZFJNaitn?=
 =?utf-8?B?a2gyeFZ4eWpZbEtyUzlsSEZUL29JNkRHR0ttcHJlbHBKdk9KSkl3TjNSeGZC?=
 =?utf-8?B?RDA2NEZNaFphWW1jU1ZoUlNqRkFjU00rdDNUVmZ1djNLVGgzUlVrRk1oQmdH?=
 =?utf-8?B?RU53cEJlT00xZzcwYTNXUml1aDROYkt2QmRlOHdFVDEzTnpIVTd0WGZ2UGxU?=
 =?utf-8?B?MDBSb0Z0b0JLMC90RTY1bDdFSkEvZzBCeTE5TnowOFoxTlhFY2R4bXkyWk96?=
 =?utf-8?B?TGdlbEpETytDOTR2TXRLTHA3ZHFIOFdsR0l5ZU0yMGhvcmJRNmpiVUhWaS9l?=
 =?utf-8?B?eURBM2kyMHNkR1JDaEM2d3A1T0tlSUJOZGIweWJ4M1hNckZiRERTNWYvZmNq?=
 =?utf-8?B?K1ZMSFpsZmdwTXdYc2FaWDBRTDlSK3NqTFdtczRWOVJJb3RpclcrLy9CKzU3?=
 =?utf-8?B?RHVrOGRzRXhVdHlTNTZaMEZzMy9kbkxmeTdjRkVVYy9QelNSb0ZkQ2U3ZzFn?=
 =?utf-8?B?VVRjeXc0bUdYdDZmL0pmL1dLdlZJUXRlaGgyZ3RFUWJFL0JNYU5ndGZYVTIx?=
 =?utf-8?B?MmN4Q2pxc1FPSkJMRUpYSUc5dkJsRVJ4MFNZNnBoQzZOL1VxamlXekRsZlg1?=
 =?utf-8?B?dDkrN3Vqcm9ZYWl5NDFJV05FOW9keCt4TFVKQUVDU2ZBQTA4cjlva2FJVTlX?=
 =?utf-8?B?RXNGMmJpK3RoMGtHZjN1WEp2U3grOHlmWWV4eWxxeUlycFA0bjFnRWovM3Bt?=
 =?utf-8?B?N2cybmtQci9XNWxEYWNidS82QkdRZWNBSWhUOFdlcmhTZEVGZXpnNHZvM0Jh?=
 =?utf-8?Q?VvUQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5938.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5439fd-9399-4179-05e8-08dbe59f74f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 05:55:22.7746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UR9I/s5oPwm9tmhyuvbgZKYv732DoGdLVOXejGFFYPOhrFfmnd1zuhHI92P+6zZv9Bsk6cEamgXvQHAPNYHK2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6921
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtv
emxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNk
YXksIE5vdmVtYmVyIDE1LCAyMDIzIDI6NDEgQU0NCj4gVG86IFNheXllZCwgTXViaW4gPG11Ymlu
LnNheXllZEBhbWQuY29tPjsNCj4ga3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnOyB1
LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU7DQo+IHRoaWVycnkucmVkaW5nQGdtYWlsLmNv
bTsgcm9iaCtkdEBrZXJuZWwub3JnOyBjb25vcitkdEBrZXJuZWwub3JnOw0KPiB0Z2x4QGxpbnV0
cm9uaXguZGU7IGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc7IFNpbWVrLCBNaWNoYWwNCj4gPG1p
Y2hhbC5zaW1la0BhbWQuY29tPg0KPiBDYzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtcHdtQHZnZXIua2VybmVsLm9yZzsgZ2l0IChBTUQtWGlsaW54KQ0K
PiA8Z2l0QGFtZC5jb20+OyBtdWJpbjEwQGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW0xJTlVY
IFBBVENIIHYyIDEvM10gY2xvY2tzb3VyY2U6IHRpbWVyLWNhZGVuY2UtdHRjOiBEbyBub3QNCj4g
cHJvYmUgVFRDIGRldmljZSBjb25maWd1cmVkIGFzIFBXTQ0KPiANCj4gT24gMTQvMTEvMjAyMyAx
Mzo0NywgTXViaW4gU2F5eWVkIHdyb3RlOg0KPiA+IFRUQyBkZXZpY2UgY2FuIGFjdCBlaXRoZXIg
YXMgY2xvY2tzb3VyY2UvY2xvY2tldmVudCBvciBQV00gZ2VuZXJhdG9yLA0KPiA+IGl0IHdvdWxk
IGJlIGRlY2lkZWQgYnkgcHdtLWNlbGxzIHByb3BlcnR5Lg0KPiA+IFRUQyBQV00gZmVhdHVyZSB3
b3VsZCBiZSBzdXBwb3J0ZWQgdGhyb3VnaCBzZXBhcmF0ZSBkcml2ZXIgYmFzZWQgb24NCj4gPiBQ
V00gZnJhbWV3b3JrLg0KPiA+DQo+ID4gSWYgcHdtLWNlbGxzIHByb3BlcnR5IGlzIHByZXNlbnQg
aW4gVFRDIG5vZGUsIGl0IHdvdWxkIGJlIHRyZWF0ZWQgYXMNCj4gPiBQV00gZGV2aWNlLCBhbmQg
Y2xvY2tzb3VyY2UgZHJpdmVyIHNob3VsZCBqdXN0IHNraXAgaXQuDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBNdWJpbiBTYXl5ZWQgPG11YmluLnNheXllZEBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+
IENoYW5nZXMgZm9yIHYyOg0KPiA+ICAgICAtIEFkZGVkIGNvbW1lbnQgcmVnYXJkaW5nIHB3bS1j
ZWxscyBwcm9wZXJ0eQ0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLWNh
ZGVuY2UtdHRjLmMgfCA3ICsrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9u
cygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xvY2tzb3VyY2UvdGltZXItY2Fk
ZW5jZS10dGMuYw0KPiA+IGIvZHJpdmVycy9jbG9ja3NvdXJjZS90aW1lci1jYWRlbmNlLXR0Yy5j
DQo+ID4gaW5kZXggMzJkYWFhYzliMTMyLi5mOGZjYjFhNGJkZDAgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9jbG9ja3NvdXJjZS90aW1lci1jYWRlbmNlLXR0Yy5jDQo+ID4gKysrIGIvZHJpdmVy
cy9jbG9ja3NvdXJjZS90aW1lci1jYWRlbmNlLXR0Yy5jDQo+ID4gQEAgLTQ3Nyw2ICs0NzcsMTMg
QEAgc3RhdGljIGludCBfX2luaXQgdHRjX3RpbWVyX3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpDQo+ID4gIAl1MzIgdGltZXJfd2lkdGggPSAxNjsNCj4gPiAgCXN0cnVjdCBk
ZXZpY2Vfbm9kZSAqdGltZXIgPSBwZGV2LT5kZXYub2Zfbm9kZTsNCj4gPg0KPiA+ICsJLyoNCj4g
PiArCSAqIElmIHB3bS1jZWxscyBwcm9wZXJ0eSBpcyBwcmVzZW50IGluIFRUQyBub2RlLA0KPiA+
ICsJICogaXQgd291bGQgYmUgdHJlYXRlZCBhcyBQV00gZGV2aWNlLg0KPiA+ICsJICovDQo+ID4g
KwlpZiAob2ZfcHJvcGVydHlfcmVhZF9ib29sKHRpbWVyLCAiI3B3bS1jZWxscyIpKQ0KPiA+ICsJ
CXJldHVybiAtRU5PREVWOw0KPiANCj4gWW91IHdpbGwgaW50cm9kdWNlIGRtZXNnIGVycm9ycywg
c28gcmVncmVzc2lvbnMuDQo+IA0KW011YmluXTogSSB3aWxsIGNoYW5nZSBpdCB0byAicmV0dXJu
IDAiIHRvIGF2b2lkIGRtZXNnIGVycm9ycy4NCg0KPiBUaGlzIGRvZXMgbm90IGxvb2sgcmlnaHQu
IFdoYXQgeW91IHdhbnQgaXMgdG8gYmluZCBvbmUgZGV2aWNlIGRyaXZlciBhbmQNCj4gY2hvb3Nl
IGRpZmZlcmVudCBmdW5jdGlvbmFsaXR5IGJhc2VkIG9uIHByb3BlcnRpZXMuDQpbTXViaW5dOiAg
SSBhbSBkb2luZyBpdCBiYXNlZCBvbiBlYXJsaWVyIGRpc2N1c3Npb24gcmVsYXRlZCB0byBBWEkg
VGltZXIgUFdNIGRyaXZlci4gIEl0IHdhcyBzdWdnZXN0ZWQgdG8gdXNlICNwd20tY2VsbHMgcHJv
cGVydHkgZm9yIGlkZW50aWZ5aW5nIHJvbGUgb2YgZGV2aWNlKFBXTS9jbG9ja3NvdXJjZSkgaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtZGV2aWNldHJlZS8yMDIxMDUxMzAyMTYzMS5HQTg3
ODg2MEByb2JoLmF0Lmtlcm5lbC5vcmcvLiANCgkNClRoYW5rcywNCk11YmluDQo+IA0KPiBCZXN0
IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=
