Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC82752FB2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 05:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbjGNDGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 23:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbjGNDGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:06:43 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2047.outbound.protection.outlook.com [40.107.14.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F1E26A5;
        Thu, 13 Jul 2023 20:06:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PsjKENEETaoK8urcR9izZcdqSQomqIgFJZW7YIRCk4lK/L9UCHDXxNDVLIuHITAu1vfUMkKbbbhw7Sf5TB/pzDidjgcqnmItI09iel93H/XX+e56A56EUnX4cNV7Zc70uLkdntQQt4lP86uggikYJrSYXR6NlhjhidNpIAUH4sNm+uypNbECmvVK9y+7OM5Mu3ISafcAWXREIU0ZAeqsxN5l521SvGU+cVHWVj3JE2F34jLchYyv3drgk49K8YBXRPFWO6f3xrZQycrKrInmmIXaH3XInU7wEFyhZdIhQ8Sbng3uGqRLeCF2vpCFJbvoMrffEY+j6LQYdEM4K1CB/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27Urh9IsD/DamBxqXdFBWA94kAni+ZWECMQrpX2zWiU=;
 b=UTTnn75GquSsd3Pwyzta/ZinwD7PYpltAG6XdW+hP7GwUJw3Pv9jPG7gEnw9EFnNvPF3US+w0awpGVSCciluRr9RMQ6wXrl/TxXVNzQk4GtRNil4D/OrudgeUE3QGNQIgpXyAdd9VgaKkIf8bCm4qm6Kn4HNv46iJD3HFZHR3AP44affJA3Xf4vCCekDzkZOTKPtzPnjQNuFa49sAWH/kRKUsuqeG9kwF9RYh+wXGmi3kRy6nfA37QPZJmND3PxDw3bHGWaVJ/Xc7SIgDKYygg4OrAnYI5a3e3W3CFtIELc/hfqdXD8xv/dTA4HP30w3DAARQ2mnWuZSobIpHcqrNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27Urh9IsD/DamBxqXdFBWA94kAni+ZWECMQrpX2zWiU=;
 b=QhwdKAGvm7W5/TsoIX6EdcA27hMfK0MYRA4nCK+7b74lBCZTvVvCTfCxRmRcxzZ4YUjckk7QlGa1unKeX/KffXac5Si6WJG62J3QR7DwB/yjwR2Ovyp6/BPZn5zpF1GJYjhHb1B0Ilmah9qceZs/MK/9yegThxUIbGZ3jIu9da4=
Received: from HE1PR04MB3148.eurprd04.prod.outlook.com (2603:10a6:7:1d::16) by
 GVXPR04MB9802.eurprd04.prod.outlook.com (2603:10a6:150:110::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 03:06:37 +0000
Received: from HE1PR04MB3148.eurprd04.prod.outlook.com
 ([fe80::94dc:3b07:140f:5f2d]) by HE1PR04MB3148.eurprd04.prod.outlook.com
 ([fe80::94dc:3b07:140f:5f2d%5]) with mapi id 15.20.6588.017; Fri, 14 Jul 2023
 03:06:38 +0000
From:   Wei Fang <wei.fang@nxp.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxim Georgiev <glipus@gmail.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        =?utf-8?B?S8O2cnkgTWFpbmNlbnQ=?= <kory.maincent@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Gerhard Engleder <gerhard@engleder-embedded.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        Simon Horman <simon.horman@corigine.com>,
        Casper Andersson <casper.casan@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v7 net-next 07/10] net: fec: delete fec_ptp_disable_hwts()
Thread-Topic: [PATCH v7 net-next 07/10] net: fec: delete
 fec_ptp_disable_hwts()
Thread-Index: AQHZtYRNMufXqmf+XUyjhz+62LtBnK+4lUhQ
Date:   Fri, 14 Jul 2023 03:06:37 +0000
Message-ID: <HE1PR04MB3148CFA008F1E89C9F8F6B9E8834A@HE1PR04MB3148.eurprd04.prod.outlook.com>
References: <20230713121907.3249291-1-vladimir.oltean@nxp.com>
 <20230713121907.3249291-8-vladimir.oltean@nxp.com>
In-Reply-To: <20230713121907.3249291-8-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HE1PR04MB3148:EE_|GVXPR04MB9802:EE_
x-ms-office365-filtering-correlation-id: 057551c7-fff7-4326-df32-08db841756d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JWI0q/CLuJlsgGZlVYae3+DHSPX8yfdWUY15rR2/llmD1Wc75JQ+QZr0pObNmScfK+ciUW1fPKkG34b7oBl+BO5p3MbfVFIfIUF7VUDkkz08LmvTd+O8VDEuyp6s6BcBMn4u1ww8gu0ER9eCft+J5nDVhfk/gxDSubMxnjbHxiMkftCrYKf3J1UjhrnbZ5xZbIMhyL2bz1gSaYBQ0c+61xfM5L9kMWFHRt8hD1agfPPwCdlZcOmHspnxpEX+y3vZ01SzIY5QfQ9kr7kGT1p3jcvDEz7xgMicyHR0VapCzpgcPSlnnoDcqjVmQnD1vkAs4HVsTwZ9YzQsYYuHHV1CFpgWvBpd21izIv8Xw3ayBHL3W+NKPWbhZ2JliKCmJ3pZZ/AfXOECdLSaOCyeOIMj1o6Z4pmuR4wEAZWwgVDKyvK4SqmQys2X5xgm2mXZkVLUzpxWC0pG+pq71b8Ys5VJ89e9cNA+vm3lCB179HQg+pzxkDHs8xU0RZB5BUi0JX3PigtLcaiur0Ouh3OAznjiAkktizdq5IU7078rjycZiNyhWh0VS2ju9+/MiWXv3yXelNCVhTX+QAyidAN5l4NZml6Ci8PHd3oUDgRGnLVRSkV4NR9cWIDzBst7AVgs+voU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR04MB3148.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(451199021)(55016003)(83380400001)(66574015)(66476007)(64756008)(66446008)(478600001)(76116006)(316002)(66556008)(9686003)(4326008)(71200400001)(7696005)(66946007)(2906002)(54906003)(110136005)(6506007)(186003)(44832011)(7416002)(53546011)(41300700001)(5660300002)(8676002)(52536014)(26005)(8936002)(38100700002)(122000001)(86362001)(38070700005)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1orQXRrRStFZ2dBcXc5eHFhU3ptY0dOSzc3cTFhbUppb0xISnNHd3MrdExs?=
 =?utf-8?B?UUZZQ0xIekJWeFltUm16Uno1b01ld2xOVXJLbVJIek91WVlLM2ozL2JpQitz?=
 =?utf-8?B?TmZ0RGJXd1RiZURzYjdhZk53eVdpYjNaMmpSbkwzQU02MG9SejZoMmVnUEhi?=
 =?utf-8?B?UTdNRStQTGpQOHFZSTlSRkJSL2tuMzQrYTcwVjBrc0NCczllbkpLajNTSzho?=
 =?utf-8?B?VkNCUi90cWtvb0oxdHBWbDFYVFp6NGRjVkg4dlNMbzd6VXZpeFN3UjYrQW02?=
 =?utf-8?B?L0NjaTFOZTN4MmpSSUZSVmh1dlFHclVRNlVPazZ5NjBQcTNxT2xLblZ4cHMv?=
 =?utf-8?B?eHpLWHk3NFpTbzg0TDQ1STVYK1pBSTJOazFsK3JuYjlQTnJ4QzliMEova04y?=
 =?utf-8?B?K21YbEFqcEE3NmdrZkNxa1RuQ28yU2FHU3JnV3dWNU9JcjFpaEZKMmQ3K1ZT?=
 =?utf-8?B?UktjTFdheXh5M0kxSCtUd3dPY1FxVDAvMVo0eVhFQXZPaTJIR0pDcWpYOTlV?=
 =?utf-8?B?ZkxVSjdPRk1TSzQxbSs0ZGY4M2NQVENiR0tyT0JqTmFvYUNEZHF1aXVzRnU3?=
 =?utf-8?B?cDVoMVdhL09Ra1pFcHZlaDNuWDFUU3VxUktBVzNDTnRxZWJ5R1pUMzlwRm1T?=
 =?utf-8?B?c3BYa0s4VUkzOXNwYmlJaG0zZTdWMEt3OGpyQkpaT0NSVXVBT21BRVBnSGk0?=
 =?utf-8?B?Zjl1dmZaamFoa2RxbjVuVDRlcXlzc0x2OEtMUVNqdW03dU5ZZUpVM2svbEhZ?=
 =?utf-8?B?dFl3N2doRUxUVEowRXQ1UmMwS09UTTF3dk1mbGtSOGplRWU3N0d3aDg2c3VD?=
 =?utf-8?B?RmtYaG1jSXFSaFBkNHgrVDhac0J5eEhwL1E4MmVzYUJxYzlXVjY3bThRVEI3?=
 =?utf-8?B?djZMVTVUREF5OVJCVkxNd0g4S3daT0EzdVNBQWQ2Z2VEWVhZL3BEdU1teUQx?=
 =?utf-8?B?UjF1eURWL3NsNFlDR2F6VXF4dnBuck9ybjFsamg4TVBpRFA5VlhhSWZIZEFS?=
 =?utf-8?B?Uk1wNHhvcExHL0Z4QVBDMnZVVlZaTmg5RlVXbWplNlk3ZkdmNmUzTS8xNFFq?=
 =?utf-8?B?TmdmdXJ6cFFZTlBTamtpL0pVL0hYbkxtZVg3cUk5TUZEWXlzY3FhWnlBL2tW?=
 =?utf-8?B?ZDNvc3dSREJDS1VMSmVIS0IxekorYkNldXU2TUVUaStwSXVnZUppUkx6RTAr?=
 =?utf-8?B?Rmova3dMUmw1S1lUYXZBMFVYRlZDZSsyTGRQcmVMYSs2YytocDZZYTNwckdQ?=
 =?utf-8?B?M2VhZXhaR25EZGRkWUhsT0pHYWpERHNyRnhvcndTWXlCUERQelZiL1JGczJP?=
 =?utf-8?B?NldGdzR6RStYaCs0SXg5ZXlnZGttTlRiTVZmMUlaNmhUbGovZURxcjF0b0Vw?=
 =?utf-8?B?WXR5Sms3QnhMeTR4RkpzT1o3K3YrUWtaQ1k3cU5Gd0NDbVRzeSsvQTBvampB?=
 =?utf-8?B?UFJKSk5mUFhZQm0yUkNLOG4yRjNOd0U2cVo5Qm1VUmFVbWxRam1iNUVMWTIv?=
 =?utf-8?B?ZGxLZlI2TzB4TnBEZ0M0cW5SMWpPRFU1eTF2RVhXU0UxRWdwSTJFNllvU0k4?=
 =?utf-8?B?RTlUSXpGM2xSTGgvWER5NWlsdTdPNlJ5bnlWekNDYUhRa2FheW52ZytnVHBD?=
 =?utf-8?B?NXcyNWVkd0Uwb2NDaEdFM2FtZlR1dm5BSkdEa2ZRWi9KSXhsWjZmaGVmZmN4?=
 =?utf-8?B?cS9icmI2TndjZmMzUVVRbEpRMEhsOFhCcEdXMXdESk1sWHhuWlBJQ0RuK2Fn?=
 =?utf-8?B?STNSY2lYL2JMcEN5QS84dTl2LytCU0dxNEtBS0JPZDV0bFI5SXA2VkdEakpB?=
 =?utf-8?B?RTA5R3pDRnFJVTI1MzA4N0hFVW12YWxUL1RHRVFEMCtaZFBJajRIazhpK3l6?=
 =?utf-8?B?d0YvU1U4dCtEK2xyclFiT2lCL3VpMHhNZEFPdUlPRnpxMnBUVmIzNEtMM3Rt?=
 =?utf-8?B?aEdxSDFMMU9PbUlNanorRmswcFNlYWZjUHBBSnQ4RitWN1ZqTHpjK3RLOHlq?=
 =?utf-8?B?TDZmOU1DUjlBUGdUd0Vxai9LNTQ2S0d4U2QweHhIM21qMmJBMUZNZXUvMWdu?=
 =?utf-8?B?azV0MmltSWF0ZFlrQ3RDY1VXNjNEQnZIc3hCYmY2Qm9jVlNGUEpKdzNkc2VV?=
 =?utf-8?Q?+wLc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR04MB3148.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 057551c7-fff7-4326-df32-08db841756d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 03:06:37.8710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l3zM2Lxbl491s3sj3Qa1orJzEsm0pXqgXjFWtrOgwDzmvdTZilJBnkJRlFVyp1yp4hPpDgzST+hkLdEkcnVXHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9802
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWbGFkaW1pciBPbHRlYW4gPHZs
YWRpbWlyLm9sdGVhbkBueHAuY29tPg0KPiBTZW50OiAyMDIz5bm0N+aciDEz5pelIDIwOjE5DQo+
IFRvOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnDQo+IENjOiBEYXZpZCBTLiBNaWxsZXIgPGRhdmVt
QGRhdmVtbG9mdC5uZXQ+OyBFcmljIER1bWF6ZXQNCj4gPGVkdW1hemV0QGdvb2dsZS5jb20+OyBK
YWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8gQWJlbmkNCj4gPHBhYmVuaUBy
ZWRoYXQuY29tPjsgQW5kcmV3IEx1bm4gPGFuZHJld0BsdW5uLmNoPjsgRmxvcmlhbiBGYWluZWxs
aQ0KPiA8Zi5mYWluZWxsaUBnbWFpbC5jb20+OyBNYXhpbSBHZW9yZ2lldiA8Z2xpcHVzQGdtYWls
LmNvbT47IEhvcmF0aXUgVnVsdHVyDQo+IDxob3JhdGl1LnZ1bHR1ckBtaWNyb2NoaXAuY29tPjsg
S8O2cnkgTWFpbmNlbnQNCj4gPGtvcnkubWFpbmNlbnRAYm9vdGxpbi5jb20+OyBNYXhpbWUgQ2hl
dmFsbGllcg0KPiA8bWF4aW1lLmNoZXZhbGxpZXJAYm9vdGxpbi5jb20+OyBSaWNoYXJkIENvY2hy
YW4NCj4gPHJpY2hhcmRjb2NocmFuQGdtYWlsLmNvbT47IFZhZGltIEZlZG9yZW5rbw0KPiA8dmFk
aW0uZmVkb3JlbmtvQGxpbnV4LmRldj47IEdlcmhhcmQgRW5nbGVkZXINCj4gPGdlcmhhcmRAZW5n
bGVkZXItZW1iZWRkZWQuY29tPjsgSGFuZ2JpbiBMaXUgPGxpdWhhbmdiaW5AZ21haWwuY29tPjsN
Cj4gUnVzc2VsbCBLaW5nIDxsaW51eEBhcm1saW51eC5vcmcudWs+OyBIZWluZXIgS2FsbHdlaXQN
Cj4gPGhrYWxsd2VpdDFAZ21haWwuY29tPjsgSmFjb2IgS2VsbGVyIDxqYWNvYi5lLmtlbGxlckBp
bnRlbC5jb20+OyBKYXkNCj4gVm9zYnVyZ2ggPGoudm9zYnVyZ2hAZ21haWwuY29tPjsgQW5keSBH
b3Nwb2RhcmVrIDxhbmR5QGdyZXlob3VzZS5uZXQ+Ow0KPiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhw
LmNvbT47IFNoZW53ZWkgV2FuZyA8c2hlbndlaS53YW5nQG54cC5jb20+Ow0KPiBDbGFyayBXYW5n
IDx4aWFvbmluZy53YW5nQG54cC5jb20+OyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29t
PjsNCj4gVU5HTGludXhEcml2ZXJAbWljcm9jaGlwLmNvbTsgTGFycyBQb3Zsc2VuIDxsYXJzLnBv
dmxzZW5AbWljcm9jaGlwLmNvbT47DQo+IFN0ZWVuIEhlZ2VsdW5kIDxTdGVlbi5IZWdlbHVuZEBt
aWNyb2NoaXAuY29tPjsgRGFuaWVsIE1hY2hvbg0KPiA8ZGFuaWVsLm1hY2hvbkBtaWNyb2NoaXAu
Y29tPjsgU2ltb24gSG9ybWFuDQo+IDxzaW1vbi5ob3JtYW5AY29yaWdpbmUuY29tPjsgQ2FzcGVy
IEFuZGVyc3Nvbg0KPiA8Y2FzcGVyLmNhc2FuQGdtYWlsLmNvbT47IFNlcmdleSBPcmdhbm92IDxz
b3JnYW5vdkBnbWFpbC5jb20+Ow0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIIHY3IG5l
dC1uZXh0IDA3LzEwXSBuZXQ6IGZlYzogZGVsZXRlIGZlY19wdHBfZGlzYWJsZV9od3RzKCkNCj4g
DQo+IENvbW1pdCAzNDA3NDYzOThiNjcgKCJuZXQ6IGZlYzogZml4IGhhcmR3YXJlIHRpbWUgc3Rh
bXBpbmcgYnkgZXh0ZXJuYWwNCj4gZGV2aWNlcyIpIHdhcyBvdmVybHkgY2F1dGlvdXMgd2l0aCBj
YWxsaW5nIGZlY19wdHBfZGlzYWJsZV9od3RzKCkgd2hlbg0KPiBjbWQgPT0gU0lPQ1NIV1RTVEFN
UCBhbmQgdXNlX2ZlY19od3RzID09IGZhbHNlLCBiZWNhdXNlIHVzZV9mZWNfaHd0cyBpcw0KPiBi
YXNlZCBvbiBhIHJ1bnRpbWUgaW52YXJpYW50IChwaHlfaGFzX2h3dHN0YW1wKCkpLiBUaHVzLCBp
ZiB1c2VfZmVjX2h3dHMNCj4gaXMgZmFsc2UsIHRoZW4gZmVwLT5od3RzX3R4X2VuIGFuZCBmZXAt
Pmh3dHNfcnhfZW4gY2Fubm90IGJlIGNoYW5nZWQgYXQNCj4gcnVudGltZTsgdGhlaXIgdmFsdWVz
IGRlcGVuZCBvbiB0aGUgaW5pdGlhbCBtZW1vcnkgYWxsb2NhdGlvbiwgd2hpY2gNCj4gYWxyZWFk
eSBzZXRzIHRoZW0gdG8gemVyb2VzLg0KPiANCj4gSWYgdGhlIGNvcmUgd2lsbCBldmVyIGdhaW4g
c3VwcG9ydCBmb3Igc3dpdGNoaW5nIHRpbWVzdGFtcGluZyBsYXllcnMsDQo+IGl0IHdpbGwgYXJy
YW5nZSBmb3IgYSBtb3JlIG9yZ2FuaXplZCBjYWxsaW5nIGNvbnZlbnRpb24gYW5kIGRpc2FibGUN
Cj4gdGltZXN0YW1waW5nIGluIHRoZSBwcmV2aW91cyBsYXllciBhcyBhIGZpcnN0IHN0ZXAuIFRo
aXMgbWVhbnMgdGhhdCB0aGUNCj4gY29kZSBpbiB0aGUgRkVDIGRyaXZlciBpcyBub3QgbmVjZXNz
YXJ5IGluIGFueSBjYXNlLg0KPiANCj4gVGhlIHB1cnBvc2Ugb2YgdGhpcyBjaGFuZ2UgaXMgdG8g
YXJyYW5nZSB0aGUgcGh5X2hhc19od3RzdGFtcCgpIGNvZGUgaW4NCj4gYSB3YXkgaW4gd2hpY2gg
aXQgY2FuIGJlIHJlZmFjdG9yZWQgYXdheSBpbnRvIGdlbmVyaWMgbG9naWMuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBWbGFkaW1pciBPbHRlYW4gPHZsYWRpbWlyLm9sdGVhbkBueHAuY29tPg0KPiAt
LS0NCj4gQ2hhbmdlcyBpbiB2NzoNCj4gLSBQYXRjaCBpcyBuZXcNCj4gDQo+ICBkcml2ZXJzL25l
dC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjLmggICAgICB8ICAxIC0NCj4gIGRyaXZlcnMvbmV0L2V0
aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jIHwgIDUgKy0tLS0NCj4gIGRyaXZlcnMvbmV0L2V0
aGVybmV0L2ZyZWVzY2FsZS9mZWNfcHRwLmMgIHwgMTIgLS0tLS0tLS0tLS0tDQo+ICAzIGZpbGVz
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjLmgNCj4gYi9kcml2ZXJzL25l
dC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjLmgNCj4gaW5kZXggZDRhZTBlN2MwYTQ0Li5lMjczMTI5
ZDQ0YzkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWMu
aA0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjLmgNCj4gQEAgLTY5
MCw3ICs2OTAsNiBAQCBzdHJ1Y3QgZmVjX2VuZXRfcHJpdmF0ZSB7DQo+ICB2b2lkIGZlY19wdHBf
aW5pdChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LCBpbnQgaXJxX2lkeCk7DQo+ICB2b2lk
IGZlY19wdHBfc3RvcChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KTsNCj4gIHZvaWQgZmVj
X3B0cF9zdGFydF9jeWNsZWNvdW50ZXIoc3RydWN0IG5ldF9kZXZpY2UgKm5kZXYpOw0KPiAtdm9p
ZCBmZWNfcHRwX2Rpc2FibGVfaHd0cyhzdHJ1Y3QgbmV0X2RldmljZSAqbmRldik7DQo+ICBpbnQg
ZmVjX3B0cF9zZXQoc3RydWN0IG5ldF9kZXZpY2UgKm5kZXYsIHN0cnVjdCBrZXJuZWxfaHd0c3Rh
bXBfY29uZmlnDQo+ICpjb25maWcsDQo+ICAJCXN0cnVjdCBuZXRsaW5rX2V4dF9hY2sgKmV4dGFj
ayk7DQo+ICB2b2lkIGZlY19wdHBfZ2V0KHN0cnVjdCBuZXRfZGV2aWNlICpuZGV2LCBzdHJ1Y3Qg
a2VybmVsX2h3dHN0YW1wX2NvbmZpZw0KPiAqY29uZmlnKTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jDQo+IGIvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMNCj4gaW5kZXggYzBiNjhmYzNlYzhiLi4wODc0NGU4
MTY0ZTMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNf
bWFpbi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5j
DQo+IEBAIC0zODc4LDExICszODc4LDggQEAgc3RhdGljIGludCBmZWNfaHd0c3RhbXBfc2V0KHN0
cnVjdCBuZXRfZGV2aWNlDQo+ICpuZGV2LA0KPiAgCXN0cnVjdCBmZWNfZW5ldF9wcml2YXRlICpm
ZXAgPSBuZXRkZXZfcHJpdihuZGV2KTsNCj4gIAlzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2ID0g
bmRldi0+cGh5ZGV2Ow0KPiANCj4gLQlpZiAocGh5X2hhc19od3RzdGFtcChwaHlkZXYpKSB7DQo+
IC0JCWZlY19wdHBfZGlzYWJsZV9od3RzKG5kZXYpOw0KPiAtDQo+ICsJaWYgKHBoeV9oYXNfaHd0
c3RhbXAocGh5ZGV2KSkNCj4gIAkJcmV0dXJuIHBoeV9taWlfaW9jdGwocGh5ZGV2LCBjb25maWct
PmlmciwgU0lPQ1NIV1RTVEFNUCk7DQo+IC0JfQ0KPiANCj4gIAlpZiAoIWZlcC0+YnVmZGVzY19l
eCkNCj4gIAkJcmV0dXJuIC1FT1BOT1RTVVBQOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19wdHAuYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2Zy
ZWVzY2FsZS9mZWNfcHRwLmMNCj4gaW5kZXggM2Y1M2I4YWU1N2RkLi41NWNmOTg1NTdlMDIgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfcHRwLmMNCj4g
KysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19wdHAuYw0KPiBAQCAtNjA2
LDE4ICs2MDYsNiBAQCBzdGF0aWMgaW50IGZlY19wdHBfZW5hYmxlKHN0cnVjdCBwdHBfY2xvY2tf
aW5mbyAqcHRwLA0KPiAgCX0NCj4gIH0NCj4gDQo+IC0vKioNCj4gLSAqIGZlY19wdHBfZGlzYWJs
ZV9od3RzIC0gZGlzYWJsZSBoYXJkd2FyZSB0aW1lIHN0YW1waW5nDQo+IC0gKiBAbmRldjogcG9p
bnRlciB0byBuZXRfZGV2aWNlDQo+IC0gKi8NCj4gLXZvaWQgZmVjX3B0cF9kaXNhYmxlX2h3dHMo
c3RydWN0IG5ldF9kZXZpY2UgKm5kZXYpDQo+IC17DQo+IC0Jc3RydWN0IGZlY19lbmV0X3ByaXZh
dGUgKmZlcCA9IG5ldGRldl9wcml2KG5kZXYpOw0KPiAtDQo+IC0JZmVwLT5od3RzX3R4X2VuID0g
MDsNCj4gLQlmZXAtPmh3dHNfcnhfZW4gPSAwOw0KPiAtfQ0KPiAtDQo+ICBpbnQgZmVjX3B0cF9z
ZXQoc3RydWN0IG5ldF9kZXZpY2UgKm5kZXYsIHN0cnVjdCBrZXJuZWxfaHd0c3RhbXBfY29uZmln
DQo+ICpjb25maWcsDQo+ICAJCXN0cnVjdCBuZXRsaW5rX2V4dF9hY2sgKmV4dGFjaykNCj4gIHsN
Cj4gLS0NCj4gMi4zNC4xDQoNClRoYW5rcyENClJldmlld2VkLWJ5OiBXZWkgRmFuZyA8IHdlaS5m
YW5nQG54cC5jb20gPg0K
