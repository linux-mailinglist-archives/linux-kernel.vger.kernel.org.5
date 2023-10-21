Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AA27D1D74
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 16:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjJUO1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 10:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjJUO1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 10:27:19 -0400
Received: from MW2PR02CU002.outbound.protection.outlook.com (mail-westus2azon11013010.outbound.protection.outlook.com [52.101.49.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825CED41
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 07:27:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FG0OVw0F1j5quQryhgqSqt35aZkfoEIHaITmQ61fCsdMwciBtpcCbCgap5HutHyX6ggjSdpeHA/f4uRT0/wayn3nou1JHBPRQZBW4zWIMx/m9GJmv8TMDJI/p6Q8MP4NHxG7Jh09TI7cPfzfSLMm/p46MRmtBbrQ2485ICRhH4VpYPqs09q4IAGSLTe/6o9jPKbM6GckMdggn7bkE+OLGrbKNnR/bUYYWuT5ri/aVCWi/4/4XUze9TQV9u3G+bNXU7bKF2SxXyNVTuN4FbAIDTX9wjgyH0mAGwdEDpW3W8ej3HJra3SEwnO8lCoMvYMa4vEVb70qBHLle86jBhRZJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0hlfQqg5d5WhCv+r6FEOG9MJrTZP1Vw8HGSplQ0z98=;
 b=G9l0PtLBFtsU1Oik6Zo6Ij2wL7pIPJjkn9ggxe0yTYok5Xg+k9+hP60h6LUFvkSB+Gn/1CDOQVhxaFOR3HsKbYQJqPhz4MnSfR2/HxcCcQplNqoMXN6JmWP+o9q5VRqrsp2aj1oOOG3+QQV9kbm1cVl3Km89co4bvdvKIMbNYHoIAUwzH2F5X6JsLgSX6bifLva0GOeCXv2/INqcXriGvkkBd9tD/jJXHhQK29R9dXrslcmOT1079oUJF12AUghZY/kY4VNCpB1dr/x9WC6LqrE9exekqi1PIfSbRHMM1lDhi6aP+Q/aospPyFN9ERcI+yihVpRGmHtSng70xIinuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0hlfQqg5d5WhCv+r6FEOG9MJrTZP1Vw8HGSplQ0z98=;
 b=vlbOol2luuod9b/sc4WSS00h5KX5Ad5J5ABJC+uTqJhmjrlldZa1zeBi++yTR8oKnQtS9qcQf6hH/cBJj4vxUKHhdn2pwyym5Ith6kGwP1wPd9UJksAEYHKY6YtFPOFRmeTrxHLaDdElGaxDuhTnOCRhIpS6Ey8s5r83Iwfyu68=
Received: from SA1PR05MB8534.namprd05.prod.outlook.com (2603:10b6:806:1dd::19)
 by MW4PR05MB8700.namprd05.prod.outlook.com (2603:10b6:303:12b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Sat, 21 Oct
 2023 14:27:11 +0000
Received: from SA1PR05MB8534.namprd05.prod.outlook.com
 ([fe80::3e01:4551:f655:e4c]) by SA1PR05MB8534.namprd05.prod.outlook.com
 ([fe80::3e01:4551:f655:e4c%6]) with mapi id 15.20.6907.025; Sat, 21 Oct 2023
 14:27:11 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Uros Bizjak <ubizjak@gmail.com>
CC:     the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/percpu: Introduce const-qualified const_pcpu_hot
Thread-Topic: [PATCH] x86/percpu: Introduce const-qualified const_pcpu_hot
Thread-Index: AQHaA3FUvRhGmgK1IU+85EkVA8xGKrBUTmkA
Date:   Sat, 21 Oct 2023 14:27:10 +0000
Message-ID: <46C29ACB-0CC2-4484-A3D3-11F33FD08BEB@vmware.com>
References: <20231020162004.135244-1-ubizjak@gmail.com>
In-Reply-To: <20231020162004.135244-1-ubizjak@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR05MB8534:EE_|MW4PR05MB8700:EE_
x-ms-office365-filtering-correlation-id: 8401b7b2-7400-46f0-416b-08dbd241d035
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tbOz2JH5j2urPyBKdhiqxSLnAgxpDJ2ZIDX8Kp3a8nx61OiAGBRblFITrPYWMtu/k15IBDpySx3MQkHnL9yZFNaVCVEwpCfAMIAtYQizlfoSgcTBJ5HwDwL4R54AUMUPfaO69QyZyiEIEMdUON1avZ8rDOwCjLXRSUKwQ+AWzzK0aFDZ8yzTefNyvRDLSAnt1ZWHSL6rIfKhhJcNlQZp8/2OWXUixIO911yE/IyIQoDU2jpbO0uQ8R7dG3JoaaBTrs981RQxZTX/QutKMjdQ977f3Q95Q8qZ/aui35h+3TTWAGJxo0dDf8gy6MD+zHAAEZ2p+5/CBy9pflQMzn04y856Yh4gQssN/VLz9kpvc1dvD+xGEtI1XoZVKsiaQDFbHqcfz5mK65i1Kk7yUzC8EX8n5egP1zqSK4JIF71pGpIjhPEgwq1MRdDFl5UuiXkdTpQ5vIY0jHC9h/geBvY1kpb6NGuTskBXUmGL2toPr9u7yleujEhueFI2DZKDc3mY8KNre4wQbKOthB57ixH4yOpC7UO0FrJp7xptyZ7u5UfYp89lANbH9Ip4jZXqgRixVPCF8lvvksDNVAv/8dXHZOR/D4Ma8NTJAIa1UiExPLszlkVmqSASRj+Qjs95DqDoJ2+hE8Udfe/xxYY/eZq8LehYuZmWL/Iw7vl81jGpOQVKN9Rf2CYL6xkC/nm5MSecVAtobpLn8cVbeBM99LvEZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR05MB8534.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(376002)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(4744005)(2906002)(38100700002)(91956017)(76116006)(316002)(6916009)(66946007)(66556008)(66446008)(64756008)(54906003)(66476007)(122000001)(2616005)(26005)(478600001)(6506007)(71200400001)(6512007)(53546011)(6486002)(41300700001)(5660300002)(7416002)(36756003)(86362001)(33656002)(4326008)(8936002)(8676002)(38070700009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Si9KYmJVeXVKUjh2eE5uemJKdGhqSTdoV3E1L2hTOVpVeklKYytuaGtIaC96?=
 =?utf-8?B?UlQrRzZ1c2ZVaTJrNlJ2SmVLUHhiSVBWQVRjNUJLN3NPSFY0ODFCWURJUFR3?=
 =?utf-8?B?Y2p3SUtMM2puaFN2bmFaNGZTUUFkeGNoM1ovZ21GRXJ0Q1Vabndsdi82dWZL?=
 =?utf-8?B?Yks3WTZjSDFSMWpvbmRFVHFPNlp4S213NlNVY2hTcWZlRmJWK0VWbTVJdGNQ?=
 =?utf-8?B?YTF5a1lxblZpMllqQnJsdDNTblZ1SHd1WWpaODRPb2srL0ZxcHduVHcyYjBD?=
 =?utf-8?B?R3BqS1M0K0FqRk1nVnZmV2hRUUtUSEpWakJnbVAxNjNtOTFVMldIMUFIMG1q?=
 =?utf-8?B?RkNlVmJCWWlDdFRzZHUxUzV1ZlpVQmhnNDhFOURseVY2Yld6blU2R1UrazFa?=
 =?utf-8?B?RjkxUW82M0JsNjY3cUdvcGt5dzBEaHlwVmkvVFNkclY0UGhiaE1NckJSVEQr?=
 =?utf-8?B?WGlnV09YRklPdTRuZkxFZldKUFh3czlHc2x3d2lFbVM5VXlnQTROb25zdFZq?=
 =?utf-8?B?MjFWYmdCelNSQVB5MXJpNjlzR0tISGZ0YmwrekFXMURGSDVFOHFFZmVxcG43?=
 =?utf-8?B?eW1aZUNSYnE0MkRKcDBhWjEvd04xUlIvbldGY1ZVWGdZaW5BN1BrWloxNXJL?=
 =?utf-8?B?UzhVRUpRT0dUVjNaS1g5cjZCSW9Kb3BReGFicS9FSWJORzFZZVNPZVFtSnl4?=
 =?utf-8?B?YlE3RmZlVlBtaGpiWDBsV1NOK3V2WnNxYklGVmMyRCt4dzBUUkZUMk82eHVy?=
 =?utf-8?B?T1N4RFN4Z2IxQktVUXFFN0RJVmtySHlxc0JueisxWHFibmF6VXFmTERWVG82?=
 =?utf-8?B?ZnYxME5VMzRZcXF5SkNxeUlWYS9BUEdNZ1VhRzFzR3V5RnBvMzdnd1VWRlg5?=
 =?utf-8?B?V050blZuZHl0Ujl4S1JtM0RNazhMd1ZFVjZkZzFYMUFEZUoycXFXQWJXUHZj?=
 =?utf-8?B?bVpYVmlUOTlwWVVjZVRSb2NLeWJwaTh4czlQeXVCNHN0S2FJYTVlNE11S0g5?=
 =?utf-8?B?M1E4UytSQnVuRzRCTGdEZ3pnSE5HbWhvRkwxNkR2V3RvNHZlVDZQNzFwN2NJ?=
 =?utf-8?B?R2ZlbFFOUzd2c1h1OVBIQjBYRGpDNmgrR0gzQWNLZDlKbDMyQkhpRUxXcWl5?=
 =?utf-8?B?S3QrNWpvUXliWlVWQzNEZ3FxNFV6dFFVQnJxTlNsQlBkS1ZIUXRYYjRvU050?=
 =?utf-8?B?Q25ZWk96R3pMN3l3bDAvYnlxSzF3MklkMTlNY2JYbTNPVDVQWEpUNmQvVkp3?=
 =?utf-8?B?OFd3S2ZjZVJZVmduWHp6MVhWNVpja2NPZWpQUFEzclZoenhTeW1YMmVROStS?=
 =?utf-8?B?OEJudkErWElLMHNXcjVLRjNTS0JobjlaOVRaUHcvS1FwUUFJV3hJdy9EYWM1?=
 =?utf-8?B?M3BtUkZ3RGkyRXVpY2R4OGh1U3hYcWl0QzNoSEdhSnJCSFo5cE9WUFRvUjhs?=
 =?utf-8?B?UTBTTTRLUTV2NE9BM283NW5tZjhzNTZhZEN6OXZlUW5oRWZRMS9JbTNCU0F2?=
 =?utf-8?B?aldtSk1rV096azNmT2k4TS8vU2doUmxhcHM3NVVZS1I1YkRzTzgva0lZUmt0?=
 =?utf-8?B?WE1LVGFzOFF3UVJkcjVXeWdDWVpuenJuVGp5a3JZZFZpVEhSMFZsZU9xNkRX?=
 =?utf-8?B?MW0veWhUOGtIc0pkWnQyemtmanphajlhcjR4YkNBWEtVZnBwd1BJdGpBSllT?=
 =?utf-8?B?L1l5bGR2c3phc3VoVHkxSytjRUV0Nm12aDhpZ3RIZ3E0Y1RPMEpXWWMzSmli?=
 =?utf-8?B?cFlFWXBhTWFjalBWWVpXSG5VWW1FWWV1SFVxZTdYRzgvZVAwUU14VWd5Q2Za?=
 =?utf-8?B?MGQ5bmNJcEp5M1lOV3UxMzhkWUtNVGJhRWluUyt0VHhyREJsZU9PQlBzZ1gw?=
 =?utf-8?B?Q1IxeDVhd1pkVWlPSDVvcmJ5UjJRRlRSMnBFQU1KR01wNFNvaVJqY3c2TTVQ?=
 =?utf-8?B?UmV2bnRyMjFCVjQvWUYxZFBVUTdDRURETjZSWWptSXdQUlhNUExWNHNOUE1R?=
 =?utf-8?B?VmpUeHFhNk95bitybXVkci93RU5jRUlXSzdIaURHUGYvTm54VnVGaGpoK095?=
 =?utf-8?B?RzV3NG9LcHhLcWNRaHk5bjM3azBoODFuNlJtc1FtZG1JdGVUeWhkc09nYnVx?=
 =?utf-8?Q?Tu5iyRuv5e1VkDRwSE14vJ8oH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C6A8823B48F36439423D8F64ADD6E78@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR05MB8534.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8401b7b2-7400-46f0-416b-08dbd241d035
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2023 14:27:11.0898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LgyMmTti1M/0SKCTI/uDg+gOQUNI1viXBkgaP79oe9wVgX3uaJ5TQg1HMpOkz9YZPqYTu2FOYmzdHXd6E92Kcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR05MB8700
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gT2N0IDIwLCAyMDIzLCBhdCA3OjE5IFBNLCBVcm9zIEJpemphayA8dWJpempha0Bn
bWFpbC5jb20+IHdyb3RlOg0KPiANCj4gQnkgaW1wbGVtZW50aW5nIGNvbnN0YW50LXF1YWxpZmll
ZCBjb25zdF9wY3B1X2hvdCwgdGhlIGNvbXBpbGVyIGNhbg0KPiBlbGltaW5hdGUgcmVkdW5kYW50
IHJlYWRzIGZyb20gdGhlIGNvbnN0YW50IHZhcmlhYmxlcywgcmVkdWNpbmcgdGhlDQo+IG51bWJl
ciBvZiBsb2FkcyBmcm9tIGN1cnJlbnRfdGFzayBmcm9tIDM3NjYgdG8gMzIxNyBvbiBhIHRlc3Qg
YnVpbGQsDQo+IGEgLTE0LjYlIHJlZHVjdGlvbi4NCg0KVGhhbmtzIGFnYWluIGZvciBkb2luZyB0
aGF0LiBMR1RNISBbKl0NCg0KLS0NCg0KWypdIFRoZSBuZWdhdGl2ZSBzaWduIGhlcmUgaXMgdW5u
ZWVkZWQsIGJ1dCB0aGF04oCZcyBqdXN0IG1lIGJlaW5nDQogICAgbmVnYXRpdmUuIDstKQ0KDQog
