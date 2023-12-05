Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4325380490E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 06:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjLEFCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 00:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjLEFCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 00:02:05 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2040.outbound.protection.outlook.com [40.107.255.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC97CA;
        Mon,  4 Dec 2023 21:02:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4ifA1pUnjQZuM7Sxm31lMJyptcfNEVUTJQ0YVk6yjoJsM98b6SWnHyjkwGLsYaCVb87Ki+1vbqMehAyqmN7DA8gxcsAriY5o6AR4CQXsVq1LNn/tb0SgWgf6RQNmnQ+lTRUJ36MscT19AllTnbREkg6GrBb326so8Oaf7me6oUMsQ6nsPaZUDaWeltu16zDPXBTAS7Ji7ac9CBFqMMSpFFX0QcNJXbhRIr3sFWdjs5PIhhvKw/d5Q827BdIVYOBAn6/uEc0M1CvMS+EyTYk4NKXetJZPcFDUU29mXxUdk25PIam+1/rAhjX+ZEh7rOLzcncOwNaRo7oo5++zRUCcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhmPpOxj1866uFzjZn2CnhomtnfDtkNMRYLnftdaCBc=;
 b=gPewlIlB1Ol3wwVe/7vfhts3atXYeycirS32/O3i1M9eTGwlI4eVCOVlFTIxRsxVXW26Sfb7tJyZ6x5kkyCJ04di1q8C9bKWzT7UV/RcUDY8FAmtNDWD7AQYG/Xgd9iNAQghUqxSpQyYFcQcjVlgBckqWDzvLxfZ94BPbYyjZ2J+lm1HiZs19r9ChGG72wQ6vxAvWtz26HTtzlsmoYw4WEzoAn5Zn4u0IWV3GqfQQcHtRt3S9QTcCt9pje8D/XBhCTr2eJjVuUBNf/WyiiLuIQAm/DeJeoocAYdGDu8hAZGSuAiPdWS0qADR7sLH4prQE+ShhXJfC2qyN1hcgGf9ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nuvoton.com; dmarc=pass action=none header.from=nuvoton.com;
 dkim=pass header.d=nuvoton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhmPpOxj1866uFzjZn2CnhomtnfDtkNMRYLnftdaCBc=;
 b=PY8vXwpmAN6YAp0l2DjqqTjGiQc1xPbhka+roee3sXGogywSQrRWUuRGTBkkkJkmlFVBsFK+8o0PslhBywGDhFK7pooR0l1m7S/8+8N7qh0vMuZiOucAtVc5e4ZU2cTbM9TCR1c5bl/018sPV0L0rrpJocvxh8kCjooIrTPCD+g=
Received: from TYZPR03MB7712.apcprd03.prod.outlook.com (2603:1096:400:427::13)
 by TYZPR03MB8839.apcprd03.prod.outlook.com (2603:1096:405:a5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 05:02:06 +0000
Received: from TYZPR03MB7712.apcprd03.prod.outlook.com
 ([fe80::4e00:675:a059:2c3c]) by TYZPR03MB7712.apcprd03.prod.outlook.com
 ([fe80::4e00:675:a059:2c3c%5]) with mapi id 15.20.7046.033; Tue, 5 Dec 2023
 05:02:05 +0000
From:   "KCFENG0@nuvoton.com" <KCFENG0@nuvoton.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        "baneric926@gmail.com" <baneric926@gmail.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "KWLIU@nuvoton.com" <KWLIU@nuvoton.com>,
        "DELPHINE_CHIU@wiwynn.com" <DELPHINE_CHIU@wiwynn.com>,
        "Bonnie_Lo@wiwynn.com" <Bonnie_Lo@wiwynn.com>
Subject: RE: [PATCH v1 2/2] hwmon: Driver for Nuvoton NCT736X
Thread-Topic: [PATCH v1 2/2] hwmon: Driver for Nuvoton NCT736X
Thread-Index: AQHaJnbU4ZBrj/L3wEmxSAmpa05B37CYs+qAgAFvLqA=
Date:   Tue, 5 Dec 2023 05:02:05 +0000
Message-ID: <TYZPR03MB7712AD5A08E3DD97541C39FDF085A@TYZPR03MB7712.apcprd03.prod.outlook.com>
References: <20231204055650.788388-1-kcfeng0@nuvoton.com>
 <20231204055650.788388-3-kcfeng0@nuvoton.com>
 <87c11991-8f74-4f71-972e-373ffa1fddb1@roeck-us.net>
In-Reply-To: <87c11991-8f74-4f71-972e-373ffa1fddb1@roeck-us.net>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nuvoton.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7712:EE_|TYZPR03MB8839:EE_
x-ms-office365-filtering-correlation-id: 1184775b-e3d5-4d29-e84a-08dbf54f5370
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S7VyrlEZFyXX6q6B59uZv+MB8j5/hs795JRImbiXORPhpTdcfzeIV6Vq+puG2/9vLsM1tUAZfMfmZdI7QSeWxbXtSEMUUJ+9So0SxXC2Q793UT6cGwzG7b5c9nApHI6IoFtHuE0Z5L0/uI30PbQAWeahRHGU+qVtFWEioVg23qVXi51EWUBNp6bkPOA5dKdgpBleAb74TS9yBrXB6cT+n/+7MbGsJdY7uQQdFV0aoLgukIr3GsDKhnYVHkpbRB44kFkmdpCV7tSUXyRlzeVkQcJHRKb4q34EBBCnAkuEGBalvg9ZbirE3i91Oh3FWKHwgfIu9gxl0jUHDRNUxJ8mdnnWu0V0oShQ2DQiMoK1T0OoKU8hKLZZdRR2GmOc+q1HViwHgTn/7N3OKcrbhidlYm9QDQAAaMb6BfslxcWN9wpdFjoRGDgdHA9D5/9txcjStXy49yoXFI272eLhAXauwRgOEXZAx/Oh2w3Pus0yeVPb4ge5zWFVI+WTwjxLPrYGbxmAVApJRUA1JNqCaAPbZfSpUYl1cr6olMmpfnyTKIuPXJ0D41j0QRq8vUVWUeiEMgHekXO9v3Wy2EAbiiHjzEYeL4scTfyph++whyJo45JgV7p4UULsUKAGOtLVv6L7iOUpstZRwJ6TkM93SUzD6Khm2vunTIN+fG+L9XHCFwEQY10a6GCYevnnvCrXfA7iQruekXkmhfcKe+AK6jBjPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7712.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(376002)(136003)(230273577357003)(230173577357003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6506007)(7696005)(9686003)(33656002)(71200400001)(26005)(41300700001)(53546011)(122000001)(55016003)(38100700002)(83380400001)(478600001)(76116006)(110136005)(64756008)(54906003)(66946007)(66556008)(66476007)(66446008)(316002)(38070700009)(8676002)(4326008)(52536014)(8936002)(5660300002)(2906002)(7416002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlpzL0VsdGgrcTRONkR0VU5LNGIwS2dlNGU2OW1oQXA3eVl2VnRCY2ljMjQ5?=
 =?utf-8?B?YWZXcEZXanZnZm9oelFPeURnU0hNS1NNKzEyQ3RuekI4YXpWTU5LNVd4UTQ1?=
 =?utf-8?B?a2ZBbTU1bFY4SHBwV20wMnlvNzZkT28vZzlTUWtQb1VibStLT2pTZWxNaDA3?=
 =?utf-8?B?WVZMK2UwOE5RckNVbWtrTmFmS2o5OXlyVkkwQ2x3OVp6K1NVYmljQUtRb2FI?=
 =?utf-8?B?N1hUbE9JNmppbzU5Q0R4T3RZRjNpRWJUK2JSdmNhcFFrZXJ5ZXNUcjEwYmpa?=
 =?utf-8?B?MmJpRmNxT3BoOU9UWTArL2NqSW5XcmFzeXRHckJOMnpTZDlhZk94VTlhMlFm?=
 =?utf-8?B?cXlPdjgzTStEWmVwa0hnczJMR1JNYTMreTZxME1zWW9OaStCVElnT25IYzIz?=
 =?utf-8?B?NEdWTmxBdnVYT3B3RVJrK1M4d0grRWZwc0lHQ2lrRFpwQ0JGbFhVWG02N0M3?=
 =?utf-8?B?M1c0dmRGdmR4TnpvaHRkeFgwMkJiY01LVTVwekhLZER6RGtvYlFZS3VCN0Nt?=
 =?utf-8?B?bFRxQzVsNWUrUTc3RC9ubzlOT1dGU08yY1hyRXhEOEEwZTVycUVET0phTDJ4?=
 =?utf-8?B?dlhPMHV4THREaHRubm5yOGR3MllKYUNOQ1YwNklqSmovVmdqVGFmVHZIY0k1?=
 =?utf-8?B?VXJrWWc2elJZUWhZOGtCSGFHOXJyREp1dG45dnJnUmVUUGNiZG1VSkFRUklh?=
 =?utf-8?B?d25XNzVHcTJmQk53YmhlajNFYnYraHJLQXNYVDh4TGFuU2lOTDEwalVKOHho?=
 =?utf-8?B?aTd5ZklYUFlEKzlTalROdnl1K25uTktrNmRVMCtNWHoya2pCaXgybUVzTEV1?=
 =?utf-8?B?Mldjcm8raGxRbXYwb2lxV0xTNGdQU0Jxc1lMaG9Wd1BycjlBNjI0VmlMQ3E4?=
 =?utf-8?B?Z054RTBNUnZCZWVDdHVtUC9uaFBRTUI2blBIcS9PNHZaaHJETlAwaWwvUGJB?=
 =?utf-8?B?MG9yYjZMazVDZDlLU2MrSm54SjR6NlJ2U0kwSW9CV3pzcDY0ZmVjSGwzLzNY?=
 =?utf-8?B?V3U0RS9veVBsdS80VTVhUnFWRmRMTmkxaG5IcjB0RC85bWhwU1JqMzFJMVhs?=
 =?utf-8?B?dVhsZGM4K0RGU21FVjFjRXNVMi9ZeHlxVmtvZEtRR251SGlMSG95TmVqWjhU?=
 =?utf-8?B?M2x2NVlDbWZOUFRMbFlZN29aZzJpT29VdjN3RlNNQlpRbFptUHB6d0dVQUQ1?=
 =?utf-8?B?S2t5YXdsemFxa2JQQWFqMHVDME01d3FjVGdoZTAraHJPV1JpYWlJZnB5S204?=
 =?utf-8?B?NEdvc1NDZThiTEx0dFRPUmIwa0lNUzRWTWVqbG9UVXprbml6Qy8vYzRENFNt?=
 =?utf-8?B?ckdEQTFKVncrUnV4cGVObElqOTlpK0VSV0R1Q3pWeGQ4SUhvamFLd0htVCt2?=
 =?utf-8?B?TmhHczFaOEtmbng4bEU2Sks0dWZnOTJTWnEyZlpZU3JDTXZiUDhhQVlvaXRZ?=
 =?utf-8?B?d25yYnJWdFBYK1BhVmcvU1FoWlVKRnhYSUdzM2tOM0Q0MlMwMWJZQ2RUNDFn?=
 =?utf-8?B?OWRCNk9iVXdwSUJlY21YT0hKYXNpTmg3eVN4SSs5WHdMekNFQ2RWZUVVY0ZI?=
 =?utf-8?B?aUNXTmVxYm9kYkNlS0NTVms5VkVFMDJWZ0NXUHFFQjF0WHlzL2JNUnJ2MEZq?=
 =?utf-8?B?cnBRamlQYW9RUkRPRmRWcUFmZzRuZUwrQ1hBN1VpU01DV3hEemZNWnppdE1j?=
 =?utf-8?B?WWlEWkZjOU9EaDhkMEtYRUFjUDQzODZ2Ull0cnA4OHFKTlR4UUtBNTRpMFZJ?=
 =?utf-8?B?RzJUK3IzK3kwQ0NPL0xGbXRuc2R5NUh2VTBkTHlhVVE2QTRuNXBueUgrZGhO?=
 =?utf-8?B?NEtLRm1UbjRYWVZ3ZE0rWnF2dC9WclBrNUhVNGhFZzY2c2ZuYnh0L2Urdm9N?=
 =?utf-8?B?OEFoQjZtOVcxQkxMckM2azhzczFlR0lXVGpmM0Q1Y2JHRUJqb1E2dTJYdi9W?=
 =?utf-8?B?dVhVcDJFOGVBQzMzTmJhcFBQMmFuQXU4NEtIckc0T0xsUEI5Nks3d1QvT3Bm?=
 =?utf-8?B?dDZQSDRVUWRiY0ZYQ0lweTdCZk12SGkraDRyQWV5L2JhNzFGUVVFZ2RaazhD?=
 =?utf-8?B?UjBJRFh4SjRyRk1xdmhhTjFQVVJTQ2I1ZDRBbFU5QlBuejlKeXlwSHpONFEx?=
 =?utf-8?Q?ovFGsYlx+u0SfdCYpMGg04RdP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7712.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1184775b-e3d5-4d29-e84a-08dbf54f5370
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 05:02:05.3877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zBPk+LIx/oALnxR7VZ6vzSN9iJLDdqEcS0QADLtgHyfrzmKitPOnuApWNXBhXucfSsKR+eolHPOqo+rQAbVEhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8839
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3VlbnRlcg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogR3VlbnRlciBS
b2VjayA8Z3JvZWNrN0BnbWFpbC5jb20+IE9uIEJlaGFsZiBPZiBHdWVudGVyIFJvZWNrDQpTZW50
OiBNb25kYXksIERlY2VtYmVyIDQsIDIwMjMgMzowNyBQTQ0KVG86IGJhbmVyaWM5MjZAZ21haWwu
Y29tOyBqZGVsdmFyZUBzdXNlLmNvbTsgcm9iaCtkdEBrZXJuZWwub3JnOyBrcnp5c3p0b2Yua296
bG93c2tpK2R0QGxpbmFyby5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7IGNvcmJldEBsd24ubmV0
DQpDYzogbGludXgtaHdtb25Admdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVs
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtZG9jQHZnZXIua2VybmVs
Lm9yZzsgb3BlbmJtY0BsaXN0cy5vemxhYnMub3JnOyBDUzIwIEtXTGl1IDxLV0xJVUBudXZvdG9u
LmNvbT47IENTMjAgS0NGZW5nMCA8S0NGRU5HMEBudXZvdG9uLmNvbT47IERFTFBISU5FX0NISVVA
d2l3eW5uLmNvbTsgQm9ubmllX0xvQHdpd3lubi5jb20NClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEg
Mi8yXSBod21vbjogRHJpdmVyIGZvciBOdXZvdG9uIE5DVDczNlgNCg0KQ0FVVElPTiAtIEV4dGVy
bmFsIEVtYWlsOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3Mg
eW91IGFja25vd2xlZGdlIHRoZSBzZW5kZXIgYW5kIGNvbnRlbnQuDQoNCg0KT24gMTIvMy8yMyAy
MTo1NiwgYmFuZXJpYzkyNkBnbWFpbC5jb20gd3JvdGU6DQo+IEZyb206IEJhbiBGZW5nIDxrY2Zl
bmcwQG51dm90b24uY29tPg0KPg0KPiBOQ1Q3MzZYIGlzIGFuIEkyQyBiYXNlZCBoYXJkd2FyZSBt
b25pdG9yaW5nIGNoaXAgZnJvbSBOdXZvdG9uLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBCYW4gRmVu
ZyA8a2NmZW5nMEBudXZvdG9uLmNvbT4NCj4gLS0tDQpbIC4uLiBdDQoNCj4gKyAgICAgaHdtb25f
ZGV2ID0gZGV2bV9od21vbl9kZXZpY2VfcmVnaXN0ZXJfd2l0aF9ncm91cHMoZGV2LA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjbGll
bnQtPm5hbWUsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGRhdGEsIGRhdGEtPmdyb3Vwcyk7DQoNClBsZWFzZSByZXN1Ym1pdCB1c2lu
ZyBkZXZtX2h3bW9uX2RldmljZV9yZWdpc3Rlcl93aXRoX2luZm8oKS4NCkRyaXZlcnMgdXNpbmcg
ZGVwcmVjYXRlZCBBUElzIHdpbGwgbm90IGJlIGFjY2VwdGVkLg0KDQpJJ2xsIGNvbnZlcnQgdG8g
ZGV2bV9od21vbl9kZXZpY2VfcmVnaXN0ZXJfd2l0aF9pbmZvIGluIFBBVENIIHYyLg0KDQpHdWVu
dGVyDQoNCg0KVGhhbmtzLA0KQmFuDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCiBUaGUgcHJpdmlsZWdlZCBjb25maWRl
bnRpYWwgaW5mb3JtYXRpb24gY29udGFpbmVkIGluIHRoaXMgZW1haWwgaXMgaW50ZW5kZWQgZm9y
IHVzZSBvbmx5IGJ5IHRoZSBhZGRyZXNzZWVzIGFzIGluZGljYXRlZCBieSB0aGUgb3JpZ2luYWwg
c2VuZGVyIG9mIHRoaXMgZW1haWwuIElmIHlvdSBhcmUgbm90IHRoZSBhZGRyZXNzZWUgaW5kaWNh
dGVkIGluIHRoaXMgZW1haWwgb3IgYXJlIG5vdCByZXNwb25zaWJsZSBmb3IgZGVsaXZlcnkgb2Yg
dGhlIGVtYWlsIHRvIHN1Y2ggYSBwZXJzb24sIHBsZWFzZSBraW5kbHkgcmVwbHkgdG8gdGhlIHNl
bmRlciBpbmRpY2F0aW5nIHRoaXMgZmFjdCBhbmQgZGVsZXRlIGFsbCBjb3BpZXMgb2YgaXQgZnJv
bSB5b3VyIGNvbXB1dGVyIGFuZCBuZXR3b3JrIHNlcnZlciBpbW1lZGlhdGVseS4gWW91ciBjb29w
ZXJhdGlvbiBpcyBoaWdobHkgYXBwcmVjaWF0ZWQuIEl0IGlzIGFkdmlzZWQgdGhhdCBhbnkgdW5h
dXRob3JpemVkIHVzZSBvZiBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24gb2YgTnV2b3RvbiBpcyBz
dHJpY3RseSBwcm9oaWJpdGVkOyBhbmQgYW55IGluZm9ybWF0aW9uIGluIHRoaXMgZW1haWwgaXJy
ZWxldmFudCB0byB0aGUgb2ZmaWNpYWwgYnVzaW5lc3Mgb2YgTnV2b3RvbiBzaGFsbCBiZSBkZWVt
ZWQgYXMgbmVpdGhlciBnaXZlbiBub3IgZW5kb3JzZWQgYnkgTnV2b3Rvbi4NCg==
