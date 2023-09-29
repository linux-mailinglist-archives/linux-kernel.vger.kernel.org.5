Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E1C7B32AF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 14:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbjI2Miz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 08:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjI2Miy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 08:38:54 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46D81A4;
        Fri, 29 Sep 2023 05:38:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ttwx5pBGzc4LN1aGZ6MK8dnmSHxfmtYMgmGF/uB66ENNqeyzhq2AhJQleuJuDdYRnqLj0gE+p5S/wI1VCZSzQig1qY0xuKf991gA/JcbdsDA3nSW7glKP9UyspzZ3BLu4DTAOAu/50o1AyZSbYs5NvsNxpo3RaWgDGpt6ihgGmZ4VSAvCTE6wHXgYnLmSU0m7VVaCk8Yv3oI1SOgJniXQlAjrM2UWmMC6YwfJjNOCs7+6Zz9zgUZ/CdUsIMqo/r3HLVRFRmVDy3O7MImTa/4isP5vAQwWqzqy9G8pjuOQ9D5TrukZO/jA/nHwcZOyga+exI4N4bvj24XzCSHmUt8yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lzqpy2KVObG2NzCwX4WRzoK8upumTyvHb5/PwSXU0oI=;
 b=UFMTjMV8wHBt9L16z1N/MA2sm7f4/pMiqcOZlmgobM6DRZ3CQXacBaDjvlTGTYO/S5DId4XoOnVpzw9EIlHB75mIc3eDFY2Gi8pDPUd8VVdmyMXDZucpFywRokXkfg8aNX0544cV4dzbHj9k3dkSzlF00+RnVncYo16JPEeCUWdXBpdns9jzOSyl+b0eSEe9DBMh/lsspcZFRqiHzDbeuXD9C7bcNpQSfIHXZyulSyvB2fFzfQvMCBDz9mm6DaPUltLNQOrem+oa2JOrrdhu0mVcZzTu8Ri+zX5LFr6snCzhGf0DI0Fel7hQ8Q9z2AW7/r34xyUGr1Ebm+aE6iRuAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lzqpy2KVObG2NzCwX4WRzoK8upumTyvHb5/PwSXU0oI=;
 b=fBVhihz1Jvwxr/4t6OlQ1P2F8vhQg4aWQV95F2AZwR8VFbfIiWAo9Rdj5Emm9ezXWvJpftmzgChAzm6j1zeozgBMdsqtZE4f8sYR13noQFP07aw4B6/MLhnUz1emk1S83wy2jr6uXugB+YV+FXQACbvR4i+kX88ZCQPvbdJ9sKk=
Received: from PAWPR02MB10280.eurprd02.prod.outlook.com
 (2603:10a6:102:34f::18) by DB9PR02MB6908.eurprd02.prod.outlook.com
 (2603:10a6:10:22b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 12:38:48 +0000
Received: from PAWPR02MB10280.eurprd02.prod.outlook.com
 ([fe80::ae8a:f8e:f622:d3db]) by PAWPR02MB10280.eurprd02.prod.outlook.com
 ([fe80::ae8a:f8e:f622:d3db%6]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 12:38:48 +0000
From:   Vincent Whitchurch <Vincent.Whitchurch@axis.com>
To:     "ansuelsmth@gmail.com" <ansuelsmth@gmail.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "liuhangbin@gmail.com" <liuhangbin@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "joabreu@synopsys.com" <joabreu@synopsys.com>,
        "rajur@chelsio.com" <rajur@chelsio.com>,
        Vincent Whitchurch <Vincent.Whitchurch@axis.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "pkshih@realtek.com" <pkshih@realtek.com>
Subject: Re: [net-next PATCH 2/3] net: stmmac: improve TX timer arm logic
Thread-Topic: [net-next PATCH 2/3] net: stmmac: improve TX timer arm logic
Thread-Index: AQHZ7UXFMH518vb/aUem6NYvI1/ESLAxyT0A
Date:   Fri, 29 Sep 2023 12:38:48 +0000
Message-ID: <0a62a2b6bff4fd01065e0de6a8703c96e344f1dc.camel@axis.com>
References: <20230922111247.497-1-ansuelsmth@gmail.com>
         <20230922111247.497-2-ansuelsmth@gmail.com>
In-Reply-To: <20230922111247.497-2-ansuelsmth@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1+deb11u1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR02MB10280:EE_|DB9PR02MB6908:EE_
x-ms-office365-filtering-correlation-id: b24d742b-b27f-4ef7-0fdd-08dbc0e90767
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O+0aUbpfCt/AK+1yyz24llBWCWNe6oXMsiRetXnUdl3um34rvOYiqCuxXxoCKT6+mQCrUBQpDblLs5Rwb+ARgWcpImZqMjZDr5B6HL7yH0Urxf5KnGj6JK6Sa9hDNBLXQe8jeTEOjF+ufd50IH6Bf6vBvVVVY6x5O2uA2gN8g30urKD9gem8J3P137wOESNJwzhaNwFlu5XD9X4O7zvzT1hpIDvlMoz92nKq509IwdiuA2jag7Rf4dAXnybgFJccKjCFBspOG2th4UOtDUNkCiejr/ULzlEV6FKGloChLK9RNdcqHcIW3V8+A7N+l1eWOqZr6Nmj/kD8lZcE9Fc/R6lZ1WjMpzapz1ymxfm5MwNdp3XyxXuRMz0S8rqfeLrEzxmxaBQ3/XG4B6KxO01cavezvOyZr5oD/eje8JYLWH+R6Ba7PB8dK3y+0xm5lGt/W24QPfGGS6MLcyjvqOlA0diuSpukXn+YMk44c3xecAquLWmEjw9VfCgnaZNdEKSpNEr0H7JGB4woaF4Xjwd7dDOaGtOQWEJa6KpibvNdrq6qT0SJbtvF3C7PjMyRknzKDGImJCQFMK/+Qek7TS/xLshRp7reLF9cSzPJFHEVOl8MEf54GcgWgAuOeg9uHZ+X
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR02MB10280.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(39860400002)(366004)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(36756003)(41300700001)(5660300002)(316002)(8936002)(8676002)(7416002)(2906002)(110136005)(71200400001)(478600001)(26005)(86362001)(6486002)(6506007)(6512007)(38070700005)(921005)(2616005)(91956017)(38100700002)(122000001)(64756008)(66556008)(66476007)(76116006)(66446008)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkpHUU1kOG5mTis5UHIzSEF0cFNVeDBZYXhkQXNiYUlXYitLZXA2bk10VGl4?=
 =?utf-8?B?NEcrZ2l6Y25RWm4rcm9hUnkya0l1UVRheW9qSlk3WjR4WFB4RnVPbmJzRHMx?=
 =?utf-8?B?WXh0eVpEZTh6bG93dDcrNUJpQUQrNHRNYXlNNG9OSFFZTHZhUmwyVk4rcU4z?=
 =?utf-8?B?VEpxc2MrSEswaXJnQThPRVgzbzdFekZrMGVlL0lrMjAyaWh1SEdVVUcvMXFK?=
 =?utf-8?B?NnhDSFZTamRTWTZLemgzQm5MWkpLTnltcjdpS3ZxNUpaSHFDR3VnS05xTDFN?=
 =?utf-8?B?Y01QcVBCYUVOb1NZTHZ5YjFuWHJnV1gwT3o2aytZU1pRTjVYSTRqV2EweWdB?=
 =?utf-8?B?QzUyTjg2cUZMQ1FlOGpSUy94eDlCZXgzeURFT1A5Y0FRbzY3dTMzZzlIT0lN?=
 =?utf-8?B?SDJXVzc4YkJWQURQeDRtaDhpWHRVSXlvZVdwM3B3dEg5RnNGbHVieUU4SGhl?=
 =?utf-8?B?Nmh2SUlxL1JRUjNXT1gwZkdEM3BvbkZBczhYWlFVdkNES1NKeVZhMnFmMWJ6?=
 =?utf-8?B?d3RiWUFlVGU4K3lQYnZoWmRzb3M5SVdPalQ3YjRJT0JXSzBaS0R6MWZCdFRh?=
 =?utf-8?B?WWhsVVpiWnFBRnE0YXovUUxaaXltUWVKU1hMTTh1ZFNGdnFlUGowYkRqRDNS?=
 =?utf-8?B?RzhHazVPN004Vi8vRjJnZkpFQTdqRitQb1Z5d2JGaStaaUp1ZjFmbGZSYUhC?=
 =?utf-8?B?UTZWMjkzUXZtcjBCMWorWVdmbkp5VXR1MVRLM2ZIRFVvZUZ5YXlPc0UxWmdL?=
 =?utf-8?B?N0tndUFQRGhRZFF2L0tjSlhoZG9pQ3cxTFlUUW9mRXluNkdqdjVJaTdQZndB?=
 =?utf-8?B?bE9MZitUNmVEdlcwZ0FONVJrdXl2V2NqdnJ0VEdwWWUvenozRGZrcTJlOUFP?=
 =?utf-8?B?Rm04ZmtTYTRjVitWblRaZ0pRRFpwUTdQcmtMVWJQTnN0SWJxc3FwS1VOcnhH?=
 =?utf-8?B?SnJZcFdHUGYwSXJrZnV6blVyOFZrYWs2QzFYU0tjL0J0KzNRMlU1cXd2ZTRy?=
 =?utf-8?B?aEhsSEZEYnBVbTlhb1E1MWhPWllQQmcxTG1XVVRJNS9PSEhRcEZ6WlYyUzhL?=
 =?utf-8?B?b0pnMnZ3U1FnVjFPOUNKR2ZYTXBGVk1Bbm9KeFZKWGdVN2hrV2hQU0FmdEEx?=
 =?utf-8?B?NWxJdmdOSHNKZ1FVYXgyVStKbGg5UDJVei9KMmR2bXE5VEhDM1JLOStYTHNz?=
 =?utf-8?B?OGRRM1BFWWZYTzZ5aXpNc05uaC83d1AwcmROZ1hVL080R3lJbCtNRHBVSmdY?=
 =?utf-8?B?dkNBV1RQallwWldOdDNKbHNONWNiWko5b1prUU5Vak84Rk4ycFg3N010emtO?=
 =?utf-8?B?RkdJd01kbjZqYXZKbitSdWNyYzdUalZ0WFZkTk1KUmhvaFV5bS9vU2tpWWZW?=
 =?utf-8?B?N0loVEY4dmI4Q0pla0pod01MbUZNK3JFVUVpS1hLVmR2MGRCOFdlSnFoR0k5?=
 =?utf-8?B?aWlhazVnTm0vVlFZaG14V3o5ZFlNN2trdGJaRDhoM0hWSUZDZ2RtTTlTajRL?=
 =?utf-8?B?dmllZllxcDE0cTZ4VTQ4N2R0UmdwTW9oWVZRcXZNdVFtVDZoQ3ltczBnYkE5?=
 =?utf-8?B?TG9SdW1xTWdsMGlvMVFweGZYR3FzUHhGblpJWGxMTTVXTGZ3NFBwdENZK2VT?=
 =?utf-8?B?MGFTaEFPU3dvTnpVNTdaQmR1dzVQaS9MVGp4RXJUMVRWVWsxbVFDdWVnYzlw?=
 =?utf-8?B?U3VUYlVVWlZUMEFzc3VlUERudUlRWlRud2JDZFU4VlN0aUU1MDZkbDV2Z3M2?=
 =?utf-8?B?NHhJSkQ0NitpZ0pMVGdlanM5WERDWVV2N2dUTkF1aFNua2NyczcvYTlkSUxQ?=
 =?utf-8?B?bGFJWDR6N3VTK3J6NkFVY0FQdHl5RSttWnhvUWZpa052OHRDTms4WkxmbTlx?=
 =?utf-8?B?enBUQW1kS3BKdmFZL1lsenZiVmFIMXBZVjlNaXNhdkRUY05sd29vUVNpQjd3?=
 =?utf-8?B?M01KZlBvV1gyUU5ORnp6MFJHcks1bGRoZzhqQ1ZNdmowRzFDRkthOEU5MXZx?=
 =?utf-8?B?MCtleXd0aWlMNThMYmFrcVkwL05mQ09IWGFlS0xSV2U3RFJsVS8vODllVWFw?=
 =?utf-8?B?dGlnMW41bzdpV2RNVHNlQVltRkdOck5OZFVhclFoeFNnNytRSkFLRStPaGVD?=
 =?utf-8?Q?BvoToep+IQ+VPfb9Z8Ic4t8hp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00049F08DF168E4AA442F5FEBBDC37F9@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR02MB10280.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b24d742b-b27f-4ef7-0fdd-08dbc0e90767
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2023 12:38:48.6919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4G+ORQzwNMVlCEwZeL5wL95aFo10VE2PVED38efQT09DzkA8m/W+Bf54L+VIewPP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6908
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA5LTIyIGF0IDEzOjEyICswMjAwLCBDaHJpc3RpYW4gTWFyYW5naSB3cm90
ZToNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL3N0
bW1hY19tYWluLmMgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9zdG1tYWNf
bWFpbi5jDQo+IGluZGV4IDkyMDFlZDc3OGViYy4uMTRiZjZmYWU2NjYyIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL25ldC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9zdG1tYWNfbWFpbi5jDQo+ICsr
KyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL3N0bW1hY19tYWluLmMNCj4g
QEAgLTI5OTQsMTMgKzI5OTQsMjUgQEAgc3RhdGljIHZvaWQgc3RtbWFjX3R4X3RpbWVyX2FybShz
dHJ1Y3Qgc3RtbWFjX3ByaXYgKnByaXYsIHUzMiBxdWV1ZSkNCj4gwqB7DQo+IMKgCXN0cnVjdCBz
dG1tYWNfdHhfcXVldWUgKnR4X3EgPSAmcHJpdi0+ZG1hX2NvbmYudHhfcXVldWVbcXVldWVdOw0K
PiDCoAl1MzIgdHhfY29hbF90aW1lciA9IHByaXYtPnR4X2NvYWxfdGltZXJbcXVldWVdOw0KPiAr
CXN0cnVjdCBzdG1tYWNfY2hhbm5lbCAqY2g7DQo+ICsJc3RydWN0IG5hcGlfc3RydWN0ICpuYXBp
Ow0KPiDCoA0KPiANCj4gwqAJaWYgKCF0eF9jb2FsX3RpbWVyKQ0KPiDCoAkJcmV0dXJuOw0KPiDC
oA0KPiANCj4gLQlocnRpbWVyX3N0YXJ0KCZ0eF9xLT50eHRpbWVyLA0KPiAtCQkgICAgICBTVE1N
QUNfQ09BTF9USU1FUih0eF9jb2FsX3RpbWVyKSwNCj4gLQkJICAgICAgSFJUSU1FUl9NT0RFX1JF
TCk7DQo+ICsJY2ggPSAmcHJpdi0+Y2hhbm5lbFt0eF9xLT5xdWV1ZV9pbmRleF07DQo+ICsJbmFw
aSA9IHR4X3EtPnhza19wb29sID8gJmNoLT5yeHR4X25hcGkgOiAmY2gtPnR4X25hcGk7DQo+ICsN
Cj4gKwkvKiBBcm0gdGltZXIgb25seSBpZiBuYXBpIGlzIG5vdCBhbHJlYWR5IHNjaGVkdWxlZC4N
Cj4gKwkgKiBUcnkgdG8gY2FuY2VsIGFueSB0aW1lciBpZiBuYXBpIGlzIHNjaGVkdWxlZCwgdGlt
ZXIgd2lsbCBiZSBhcm1lZA0KPiArCSAqIGFnYWluIGluIHRoZSBuZXh0IHNjaGVkdWxlZCBuYXBp
Lg0KPiArCSAqLw0KPiArCWlmICh1bmxpa2VseSghbmFwaV9pc19zY2hlZHVsZWQobmFwaSkpKQ0K
PiArCQlocnRpbWVyX3N0YXJ0KCZ0eF9xLT50eHRpbWVyLA0KPiArCQkJICAgICAgU1RNTUFDX0NP
QUxfVElNRVIodHhfY29hbF90aW1lciksDQo+ICsJCQkgICAgICBIUlRJTUVSX01PREVfUkVMKTsN
Cj4gKwllbHNlDQo+ICsJCWhydGltZXJfdHJ5X3RvX2NhbmNlbCgmdHhfcS0+dHh0aW1lcik7DQoN
CldoZW4gdGhpcyBmdW5jdGlvbiBpcyBjYWxsZWQgZnJvbSB3aXRoaW4gdGhlIG5hcGkgcG9sbCBm
dW5jdGlvbg0KKHN0bW1hY190eF9jbGVhbigpKSwgTkFQSV9TVEFURV9TQ0hFRCB3aWxsIGFsd2F5
cyBiZSBzZXQgYW5kIHNvIGFmdGVyDQp0aGlzIHBhdGNoIHRoZSAiV2Ugc3RpbGwgaGF2ZSBwZW5k
aW5nIHBhY2tldHMsIGxldCdzIGNhbGwgZm9yIGEgbmV3DQpzY2hlZHVsaW5nIiBsb2dpYyB3aWxs
IG5ldmVyIHN0YXJ0IHRoZSB0aW1lci4gIFdhcyB0aGF0IHJlYWxseQ0KaW50ZW50aW9uYWw/DQoN
Cg==
