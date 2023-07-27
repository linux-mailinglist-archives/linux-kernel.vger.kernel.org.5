Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED2C764563
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjG0FUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjG0FUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:20:39 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7268E26A1;
        Wed, 26 Jul 2023 22:20:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIfeBYyTZ8+n5GLCtdnxhVyssf48gf3AXlbRhyWINj/zb+g504NauMZSY5p6bT3Frqbn+q9CEgbyuBoFG+0+dBvUGcfd4gkfw20UI7r0XiIJnMwzDWIIV9ezozU6no/GVtJgBpJ1lGwAbk+eismWBQB/oEHR7CNT76PvkhV1Xh+ZDycs2WcacmeEvdFhI+42uhWx9Yc6nrdv24N3x82ZeMKC/HjFHEVYsoyWsySeYKson1o2x4YCQsXs2A3SKbtRknZeXC+AimdVnb1tynUZg6knqZXVeknwJmJZOiltnh7H8G4hh92ybwIlhFZ5Ul5eJJagKMloul7qZm1IsDcxhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2GNU0g0m2oe9PflDYEyYgfMgJtBovy4Hyy9k2bSj06w=;
 b=d0ZJJpZY+hz91Zow7Osuz+D8KZ7ei/12CJBL4DN6pqv74sSxdhjsaQVnhrNu9Rp+JIRgpUOPLWgZ+VBhmNy6VnMbg+sJy+rPCraZ7CjB4MzJx4yZbBOYugKwB0A35X9OFC1Z+kwOBDNaNWdk1Smrmo3g6zi7p1KvNNA1dXU4lu24dgy227xJLz7Yrk8JtCSU5wf5m3eFzSrFHP9X5/V2amlWU0TDLleHOIHLvqUw2xFbNFWB69IbCaDfb+e/TZyu+L15DtOqyozI1euC3zZpe7T2hPo1AhXbNIEcSmdZLaNVDaUHwVA0PqmEKVET63UeWZpvznrQXnt01Lotdjl7dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GNU0g0m2oe9PflDYEyYgfMgJtBovy4Hyy9k2bSj06w=;
 b=YK7/zY8ItSA38cMwLaz31InyzAIjK3Jp2M/jrhAQcy/mM9WsavLS+LinovbFbao0eI7el7tvqpXNkR43S8CgjmzwSezi4yfsUANomYgIOcOC0Agj7nhIOTxZ39xqBaIAGTfkxMsaTf4i2JKl7jMxDEO9ZbL5Sx08NADwtbDAVXs=
Received: from BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10)
 by MW3PR12MB4441.namprd12.prod.outlook.com (2603:10b6:303:59::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 05:20:34 +0000
Received: from BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::4c72:3393:cbd5:2091]) by BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::4c72:3393:cbd5:2091%7]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 05:20:34 +0000
From:   "Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>
To:     "Shah, Tanmay" <tanmay.shah@amd.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Levinsky, Ben" <ben.levinsky@amd.com>,
        Marek Vasut <marex@denx.de>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Arnd Bergmann <arnd@arndb.de>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "saikrishna12468@gmail.com" <saikrishna12468@gmail.com>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v2 2/4] firmware: xilinx: Add version check for TRISTATE
 configuration
Thread-Topic: [PATCH v2 2/4] firmware: xilinx: Add version check for TRISTATE
 configuration
Thread-Index: AQHZvguAM6SwWwOBZUCINjvA0T+Ip6/JCn8AgAQL85A=
Date:   Thu, 27 Jul 2023 05:20:34 +0000
Message-ID: <BY5PR12MB425886B7CB3E062C00673A5CDB01A@BY5PR12MB4258.namprd12.prod.outlook.com>
References: <20230724084554.1924378-1-sai.krishna.potthuri@amd.com>
 <20230724084554.1924378-3-sai.krishna.potthuri@amd.com>
 <cde3fef1-7ab0-cd3b-df1a-c29c47770e73@amd.com>
In-Reply-To: <cde3fef1-7ab0-cd3b-df1a-c29c47770e73@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4258:EE_|MW3PR12MB4441:EE_
x-ms-office365-filtering-correlation-id: db3e93cd-6b74-4245-b676-08db8e613420
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /WqieTvypa35bTCf7KZCOOPaXkCTdGlJf9hBBVFqpNyewHf8Ta+I3OBvyA6y/24E+gqby4Ls+GQy9s+NFB/EJY9JA5JDm9GzzNI+D0eQiJ+pIKjdiU5EkrcvTDoVAVwPcexTSl1hOGiaoKOne+sFjOLEJfK7OH2ykvR5fDh76q7cr3ut92BErEEKc5YyMruY0SVc6BgprxByMpwMHSnCNPxU2oJbThG+iZMCxLp1ec6AdWrd7eZreneChVcEeow/LJocV2vB6jSk/Mz7aTH7PUwSrf93GEPnJsI5KCojtQdAWyrD+wyUqIfz4Ohz4YxziqxlSxQbdyMrtpP4jH5fiaHECNcBEtW088WOyitVQ4mI8FvjR7uqblqYbFunUQX/0vo3n6v+fimMxc693PM3U/P1G3lhctcMxPuarrHv5OKWtC3YlZ3iZM0RaHXUBwRt76l4pZVZuR8QXIgTmMr37NpT9q1sh1TvW8f3mNafDtxssoLn6o2EgqV7f8b/uXyEVTlck3UyDfDlpRBS7r+l95qRJCcTC473JMnmKiGDdil/YOnaodEEpk5h1yuFnwvvtWD25l2XDcNGMOZD0OsIThxvbae3yaY5OLgtiGFmrUtTC4hQDoe2g7A1Hfm8dpW75rqZxLgbb5t7vWZLOtcrtw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4258.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(366004)(346002)(451199021)(54906003)(110136005)(7696005)(9686003)(26005)(83380400001)(478600001)(55016003)(38070700005)(33656002)(86362001)(2906002)(66556008)(66476007)(53546011)(66446008)(186003)(6506007)(71200400001)(122000001)(921005)(38100700002)(64756008)(66946007)(76116006)(4326008)(316002)(41300700001)(8936002)(5660300002)(52536014)(8676002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmxiWHBtT0x4VUN0R3RvL2hNMC9LSHZxVG51SVFFaDB5eTF3NHpsMUNQWWZZ?=
 =?utf-8?B?U2ZORWo4QU9YeUx2VTBoQVJHWERVQW51emFsRTluK0xzeGpyTnZCVW9yaDFm?=
 =?utf-8?B?WkJDT2ZQVEUrdlJKZGFNSE1wNjg4aWxzS1VjOC94WkdvSU1TaHYxeXV0S0Fh?=
 =?utf-8?B?S1d2a0x3bis2MjJTaDNsOXhud2dUeXV2Y3lTa3FBN2Iybzg5a0lPcW5WMkNG?=
 =?utf-8?B?d3NGT2dpUTZ3Ym8rajJKZDNXRzZoazFIakJzd3ROSHBtWnFPcVVZUTM2MUtk?=
 =?utf-8?B?eU9YUGphYjh3UHBxZDlhdXpqOWJVelpwTUVRSlFOc0VDcThsQjMyU3REeTNl?=
 =?utf-8?B?cHo0OXp2UTloUmlkZ3hxRk9Udy9sdERGYlY3a2IxRWZUUy9naWlvaUh1K0V4?=
 =?utf-8?B?WWRqVS9zd1BETnQyN3lzcjcxM0J4ZnNJREhxQ2czTjZTRXMydEQ2N055TWEy?=
 =?utf-8?B?VHhZSG5RRCtRQkVRTjhoYXR2Um1INjVlV29wK0Q0ekw1OEdtcDFUUktORFhn?=
 =?utf-8?B?MnROTDhnWC9FSWxDTUVkU1pZd0d0cWJCTmtuRFl2dGxYdndZc2F1SkRYRVow?=
 =?utf-8?B?NjQ0QjBlQUFKMnVGaEkvV1crbjFGWmdVazNsK0Qva25FN0pPSnRQMDQ2ZnY0?=
 =?utf-8?B?NWdEMU4wRTFWNzlCM0dtUmUxaTRma2daZHFiTXJvbXNNOURXa1BHWk1nM0ht?=
 =?utf-8?B?dEpuTTBMZTAzRUE4Y1lxanJHRnBWVitXbXpUMjI5VmhUNnZ6RXM2RThFelF4?=
 =?utf-8?B?RVVTdnVBYW9NMXhmWFphUzE0bkpHSzFxL1lOUWZ2dmpnK1JhM2JuRDFHWkRS?=
 =?utf-8?B?N2k1djlCNTRYc1dWblpBVmlPZVhMdlNYZmFNSVBFaVhqNFUyaUtlbE92alFM?=
 =?utf-8?B?eitLUEx5bzBwN0YrMWZxNlJUZ21KdWxoMFFUMEJKY0VSUEsrcXhpRERoRWZo?=
 =?utf-8?B?c3haRzRzdXJUODZCMU8yOTFDaVc3UTlFZzE3NVFUYlRObEtzeDRVZytKcmtp?=
 =?utf-8?B?VFphNnFRVHFETm13b2dZYkFjUlp5WktkaW9Mb1ViL1hHNVdaeVZmTC9CQi9E?=
 =?utf-8?B?RTBZc0NKeVFVNFoyU0xoMEp0YmwzbUdnaE9hSjBwY08vd3hEa2prblFJRG9p?=
 =?utf-8?B?b2piUmY2bnFHU3JMb1dRQVZXRnd2YVhUSVBqMjNMSTZiSEFPQ3ROckc0dERI?=
 =?utf-8?B?dDJDVGNhM2NOZGxzWnVHZmxVT2FCRDNnbVUzdk9SRzFMTFBiZGpZK1ZBNWw2?=
 =?utf-8?B?SHNYeFRGM21PaXl4aE03Tm4rS1pLM2FIUk8ySXpVOExoam5XdXBhZFZWQ2ZH?=
 =?utf-8?B?bUdPWGFwK2wxR2NDMU54T2trd1hIdDVvalhEblJ2TjNSTEd3YnhJZnZqcElV?=
 =?utf-8?B?TjZwRVVOcnFkN0tuaXU1eENwWDFyeDF0enVqak5CT0E1Y1BpSERpanR4Y3ZT?=
 =?utf-8?B?N1RRMVh5VEJna2ZFdDNZWENtN0k1RWFYU1dWbkw4WExOM1VhWHhqVHdrR1hs?=
 =?utf-8?B?ZmVZamJkdUtIM29xN1JISmpNZWRCVTFsd0NaTzRML1ppNnpYSWNYc1ZrZmdF?=
 =?utf-8?B?Zy9pV1pUSVUyZTJGdm1ENWFpY3J0YlNMZmI2Z3ZLM2JvbG5WSlg2M1JaM28r?=
 =?utf-8?B?aWMycHRITlB0eEhMZmkrKzloaTFZQ1FCN0lqamQrNG1PRUJoRW9PUzI0L2dE?=
 =?utf-8?B?VGVBTVNJRXlhZmtxOFFKb0RDMi9TUWtDOThmMTQ3a0NWNnEyeWdFUFZ0WWtM?=
 =?utf-8?B?VVErMDFMUWQ0VlZTc0FDTll2MmtoZDdoR2s0M29IaE5VN0l5WHNITTk2dytH?=
 =?utf-8?B?UmwwNk4wWEdXUXhBWDdLUkVZNGFIRXJpSnU2MGpyS1V6dlRld21pSkNROWZt?=
 =?utf-8?B?dHIrL3FldnlrM2ZwWTNqMy9ndXVQZURpY24xd3dWNTN2bG1yT3N0b3JvTUdi?=
 =?utf-8?B?M2k5aEtGM2pjcGg3QW0reHB4c0ZuQW5QOHVadktpN3l2b1NCQXZ5eVVvdVEz?=
 =?utf-8?B?TGVXVXl2ckJ1ZUdHWVFRS0FkdmlaZlVJU0U3UHdPbHpGUm9pYUlQa0JmUzd3?=
 =?utf-8?B?T004N0JKZHlvb3dvSXpsKy9mQmpXc0RiVmZDckFLS3g2WmI5T29IZ2NWQWlP?=
 =?utf-8?Q?4/dE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4258.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db3e93cd-6b74-4245-b676-08db8e613420
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 05:20:34.0518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: scq1KV4Mc552fqoLZd3VUGxl6wdwsopanWeqChaXJR+KqoRxQllEzvdbAvgJIEnNOsi1ibTnF9Zd2nT9yprL/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4441
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkZyb206IFNoYWgsIFRhbm1heSA8dGFubWF5LnNoYWhAYW1kLmNvbT4gDQpTZW50OiBNb25k
YXksIEp1bHkgMjQsIDIwMjMgODo1NyBQTQ0KVG86IFBvdHRodXJpLCBTYWkgS3Jpc2huYSA8c2Fp
LmtyaXNobmEucG90dGh1cmlAYW1kLmNvbT47IExpbnVzIFdhbGxlaWogPGxpbnVzLndhbGxlaWpA
bGluYXJvLm9yZz47IFNpbWVrLCBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPjsgUm9iIEhl
cnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRv
Zi5rb3psb3dza2krZHRAbGluYXJvLm9yZz47IENvbm9yIERvb2xleSA8Y29ub3IrZHRAa2VybmVs
Lm9yZz47IE1hdGhpZXUgUG9pcmllciA8bWF0aGlldS5wb2lyaWVyQGxpbmFyby5vcmc+OyBMZXZp
bnNreSwgQmVuIDxiZW4ubGV2aW5za3lAYW1kLmNvbT47IE1hcmVrIFZhc3V0IDxtYXJleEBkZW54
LmRlPjsgUm9tYW4gR3VzaGNoaW4gPHJvbWFuLmd1c2hjaGluQGxpbnV4LmRldj47IEFybmQgQmVy
Z21hbm4gPGFybmRAYXJuZGIuZGU+DQpDYzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1ncGlvQHZnZXIua2Vy
bmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IHNhaWtyaXNobmExMjQ2OEBnbWFp
bC5jb207IGdpdCAoQU1ELVhpbGlueCkgPGdpdEBhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRD
SCB2MiAyLzRdIGZpcm13YXJlOiB4aWxpbng6IEFkZCB2ZXJzaW9uIGNoZWNrIGZvciBUUklTVEFU
RSBjb25maWd1cmF0aW9uDQoNCg0KT24gNy8yNC8yMyAzOjQ1IEFNLCBTYWkgS3Jpc2huYSBQb3R0
aHVyaSB3cm90ZToNClN1cHBvcnQgZm9yIGNvbmZpZ3VyaW5nIFRSSVNUQVRFIHBhcmFtZXRlciBp
cyBhZGRlZCBpbiBaWU5RTVAgUE1VRlcoWGlsaW54DQpaeW5xTVAgUGxhdGZvcm0gTWFuYWdlbWVu
dCBGaXJtd2FyZSkgQ29uZmlndXJhdGlvbiBQYXJhbSBTZXQgdmVyc2lvbiAyLjAuDQpJZiB0aGUg
cmVxdWVzdGVkIGNvbmZpZ3VyYXRpb24gaXMgVFJJU1RBVEUgYW5kIHBsYXRmb3JtIGlzIFpZTlFN
UCB0aGVuDQpjaGVjayB0aGUgdmVyc2lvbiBiZWZvcmUgcmVxdWVzdGluZyBYaWxpbnggZmlybXdh
cmUgdG8gc2V0IHRoZQ0KY29uZmlndXJhdGlvbi4NCg0KU2lnbmVkLW9mZi1ieTogU2FpIEtyaXNo
bmEgUG90dGh1cmkgbWFpbHRvOnNhaS5rcmlzaG5hLnBvdHRodXJpQGFtZC5jb20NCi0tLQ0KIGRy
aXZlcnMvZmlybXdhcmUveGlsaW54L3p5bnFtcC5jICAgICB8IDkgKysrKysrKysrDQogaW5jbHVk
ZS9saW51eC9maXJtd2FyZS94bG54LXp5bnFtcC5oIHwgMiArKw0KIDIgZmlsZXMgY2hhbmdlZCwg
MTEgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9maXJtd2FyZS94aWxpbngv
enlucW1wLmMgYi9kcml2ZXJzL2Zpcm13YXJlL3hpbGlueC96eW5xbXAuYw0KaW5kZXggZjk0OThl
N2VhNjk0Li4zMDc3MTdmMjRhOTggMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2Zpcm13YXJlL3hpbGlu
eC96eW5xbXAuYw0KKysrIGIvZHJpdmVycy9maXJtd2FyZS94aWxpbngvenlucW1wLmMNCkBAIC0x
MTUwLDYgKzExNTAsMTUgQEAgRVhQT1JUX1NZTUJPTF9HUEwoenlucW1wX3BtX3BpbmN0cmxfZ2V0
X2NvbmZpZyk7DQogaW50IHp5bnFtcF9wbV9waW5jdHJsX3NldF9jb25maWcoY29uc3QgdTMyIHBp
biwgY29uc3QgdTMyIHBhcmFtLA0KIAkJCQkgdTMyIHZhbHVlKQ0KIHsNCisJaW50IHJldDsNCisN
CisJaWYgKHBtX2ZhbWlseV9jb2RlID09IFpZTlFNUF9GQU1JTFlfQ09ERSAmJg0KKwkgICAgcGFy
YW0gPT0gUE1fUElOQ1RSTF9DT05GSUdfVFJJX1NUQVRFKSB7DQorCQlyZXQgPSB6eW5xbXBfcG1f
ZmVhdHVyZShQTV9QSU5DVFJMX0NPTkZJR19QQVJBTV9TRVQpOw0KKwkJaWYgKHJldCA8IFBNX1BJ
TkNUUkxfUEFSQU1fU0VUX1ZFUlNJT04pDQorCQkJcmV0dXJuIC1FT1BOT1RTVVBQOw0KSGkgU2Fp
LA0KSWYgeW91IGdldCB2ZXJzaW9uIDEgYXMgcmVzcG9uc2Ugb2YgZmVhdHVyZV9jaGVjayB0aGVu
LCBpdCBpcyBwb3NzaWJsZSB0byBoYW5kbGUgY2FsbCBhcyBwZXIgb2xkIHBheWxvYWQgYXJndW1l
bnRzPw0Kc29tZXRoaW5nIGFzIGZvbGxvd2luZzoNCmlmIChyZXQgPT0gMikgew0KwqDCoMKgIC8v
aGFubGRlIG1vZGlmaWVkIHBheWxvYWQgYXMgcGVyIHYyIG9mIHRoaXMgY2FsbA0KfSBlbHNlIGlm
IChyZXQgPT0gMSkgew0KwqDCoMKgIC8vaGFuZGxlIG9yaWdpbmFsIHBheWxvYWQgb2YgdGhpcyBj
YWxsIGFzIGZpcm13YXJlIGlzIG9sZC4NCn0gZWxzZSB7DQrCoMKgwqAgLy9mYWlsIGhlcmUgd2l0
aCAtRU9QTk9UU1VQUCBhcyB3ZSBkb24ndCBzdXBwb3J0IHRoaXMgdmVyc2lvbi4NCn0gDQpUaGlz
IHdheSB3ZSBjYW4gbWFpbnRhaW4gYmFja3dhcmQgY29tcGF0aWJpbGl0eSB3aXRoIG9sZCBmaXJt
d2FyZS4NCg0KSGkgVGFubWF5LA0KDQpUUklTVEFURSBmZWF0dXJlIHN1cHBvcnQgYWRkZWQgaW4g
dmVyc2lvbiAyLjAsIGhlbmNlIHdlIGFyZSBjaGVja2luZyB0aGUgU0VUIFBBUkFNDQp2ZXJzaW9u
IGlmIHRoZSByZXF1ZXN0ZWQgY29uZmlndXJhdGlvbiBpcyBUUklTVEFURS4gSWYgdGhlIHZlcnNp
b24gaXMgMi4wIHRoZW4gd2UgYXJlDQphbGxvd2luZyB0aGUgY2FsbCBvdGhlcndpc2Ugd2lsbCBy
ZXR1cm4gZXJyb3IuIFRoaXMgY2hhbmdlIHdpbGwgbm90IGltcGFjdCB0aGUgb3RoZXINCmNvbmZp
Z3VyYXRpb25zIGFuZCBub3QgaW1wYWN0IHRoZSBiYWNrd2FyZCBjb21wYXRpYmlsaXR5IGFzIHdl
IGFyZSBjaGVja2luZyB0aGUNCnZlcnNpb24gb25seSBmb3IgdGhlIFRSSVNUQVRFIGNvbmZpZ3Vy
YXRpb24uDQoNClJlZ2FyZHMNClNhaSBLcmlzaG5hDQoNCg0KKwl9DQorDQogCXJldHVybiB6eW5x
bXBfcG1faW52b2tlX2ZuKFBNX1BJTkNUUkxfQ09ORklHX1BBUkFNX1NFVCwgcGluLA0KIAkJCQkg
ICBwYXJhbSwgdmFsdWUsIDAsIE5VTEwpOw0KIH0NCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L2Zpcm13YXJlL3hsbngtenlucW1wLmggYi9pbmNsdWRlL2xpbnV4L2Zpcm13YXJlL3hsbngtenlu
cW1wLmgNCmluZGV4IGQ3Zjk0YjQyYWQ0Yy4uNjM1OWVlZWE4ZGQ3IDEwMDY0NA0KLS0tIGEvaW5j
bHVkZS9saW51eC9maXJtd2FyZS94bG54LXp5bnFtcC5oDQorKysgYi9pbmNsdWRlL2xpbnV4L2Zp
cm13YXJlL3hsbngtenlucW1wLmgNCkBAIC0zNCw2ICszNCw4IEBADQogLyogUE0gQVBJIHZlcnNp
b25zICovDQogI2RlZmluZSBQTV9BUElfVkVSU0lPTl8yCTINCiANCisjZGVmaW5lIFBNX1BJTkNU
UkxfUEFSQU1fU0VUX1ZFUlNJT04JMg0KKw0KICNkZWZpbmUgWllOUU1QX0ZBTUlMWV9DT0RFIDB4
MjMNCiAjZGVmaW5lIFZFUlNBTF9GQU1JTFlfQ09ERSAweDI2DQogDQo=
