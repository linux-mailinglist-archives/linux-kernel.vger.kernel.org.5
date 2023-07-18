Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757BA757481
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjGRGmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjGRGmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:42:11 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2111.outbound.protection.outlook.com [40.107.114.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD1CFD;
        Mon, 17 Jul 2023 23:42:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcvnEG1PkpXqE67NeMPWA2edm7OeXP6bG+wo1d4SbysvQhCe7KL3Qg3HB2e4oA9FCVAkhDF31Y/nyWOF7gPAxhznitFcwrlNfyxtaL6DHy14YUFqrxMVvrVxsSMFvw4RlQ1XVL3GxgTOeWaJyvN4OIg+Im341HJl39pbPCGgOZOSWnAqf6/KOlaiUXMZtmSExlejYB1W9UJEzCw4rafkrNdtEW5tbFmBQZFtixVnvHudhKNwX32FQxQvWSMJ+94hSD0FHb5jn2MKkHawTSxI+R4YPw1f9C2JmHykg+TZQNJiiPYFJ7P3VfiCnsp03sazX9v4lBZdFDogrR1XxrO8Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TfAbINQNCOh0FpZ6w9mUTUGMXCALyF/kj2DBu0i5RQ=;
 b=nwDzLCPdOdrcEDWUwqsOd9z7HMcww5card6Fpjh4rspEU8BtyNhZ5jvppUGKq+MyP0Pg01HtETX+JulMJgztqissX1t7u46dRJisqHrfWm936ZoFFxz9U9/9z6RzaqLaBqbetDerkCZr8ciwpU0qAbxxFe16esXUNMyhcG2m+NXRkPY3PmMr80YttApkxzcxV2DE0SMjCYOskLMHNUdCJE4Xx7WIPgkL/9r15F/p8pou9dw6Hp0r+m/c1A9wlTv6TC3RTew0YnQM7U0LSyBuxoW8WW8/YzqcbxwQYwwvX1pFPDvyxyzDngmoKJLJcNbFMKH/Lbhgg2seqxForENkvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TfAbINQNCOh0FpZ6w9mUTUGMXCALyF/kj2DBu0i5RQ=;
 b=fKLf7Ov4ek7wEUPHS0g/mhZ7Et5gqNvatrWbUHQURIZHajfETroZGcyBX9/aOhKiYEwL/uIakf/qBcMVTFBJ5stKhQrd9jFCidtR2c3siRsTSSpvk7NYvvpSOVrTcKJN1yLn2v3dq4P3ad8Y/IppF05KQUJznonvJukyze0w7Cw=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS0PR01MB5684.jpnprd01.prod.outlook.com (2603:1096:604:be::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 06:42:06 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 06:42:06 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Randy Dunlap <rd.dunlab@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
CC:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: RE: [PATCH] pwm: fi pwm-rz-mtu3.c build errors
Thread-Topic: [PATCH] pwm: fi pwm-rz-mtu3.c build errors
Thread-Index: AQHZuTz3JvYeSdheY0298OUyurLS6a+/EjSAgAAAdkA=
Date:   Tue, 18 Jul 2023 06:42:06 +0000
Message-ID: <OS0PR01MB5922C3D065F47297A9620A4A8638A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <8a4de6c6-8d7c-a115-2a14-d264d6d28ccf@gmail.com>
 <d31387c2-7411-ae98-93d3-418b9d5b87f6@gmail.com>
In-Reply-To: <d31387c2-7411-ae98-93d3-418b9d5b87f6@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS0PR01MB5684:EE_
x-ms-office365-filtering-correlation-id: 1638ff8d-51b7-4823-5caa-08db875a1a6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wm/nywyaJaQionnUkm4Il3VD6u74AQ690pGZ/ZsvTbWxiwy8WcabUGLcpsXga8yzUd2whI8sFMcm9PpHP/FCtvABc+pPPh1rSqnTeB5biEYO8hPEDbRSybU9w2UhNAvVJlxuqXEGe/x0K+Btizwdb5JzJEG4AfeGXSD9tXVaSjREU9MjdkntXdKz26eI4N7PaTIVsls4yF5/kLBswKs9NDrgqbJJc+CxvB5qINduN+ZrwxCiEfSCCSa01Epy8LqN+UVBIOE4oqXP8CTj8/JZo6A1AvyHJkSgzd2e52mK+E5FRzr2RiJn7/lcsNVQC9SfZgcNUNuHGHUvwZ/IrwHyvU2OGEfGcpLZX5/SBM8OO0rrYkcHqetEwljlDCGAkB2H7qa3gcpF8jBBRwEYLEfkZnBRI1WX4Cgw22T35G0aZWZZQoUQliYdmF9J+VtQGYWpEVWBM5CGPzdAkBlSsxBO9U3/37tyKd/ucmvUU34Pbvfb6KA1dT/MnFsW539XWpahHetgsarRvsiOgC5YY+suWMXR2wwUxMeI2rkkkzpdatTprwiUtXXJvo1WXj0sbfvsUzTGOi35VGQWywMJ3Ti0N0JTRuKGqptYEV1Ba9oK3+j5HjBEE5r7Efxuthwc/XE4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(451199021)(478600001)(5660300002)(66946007)(66476007)(66446008)(66556008)(64756008)(4326008)(52536014)(316002)(76116006)(8676002)(54906003)(8936002)(55016003)(2906002)(41300700001)(4744005)(110136005)(71200400001)(6506007)(9686003)(53546011)(7696005)(26005)(38100700002)(33656002)(186003)(83380400001)(122000001)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWVjazVhL2tNVlIzYzVzMk5wam5vMzM1QmlqN1lraDdMTGtHYlQ2RDhBaGNv?=
 =?utf-8?B?UjRrYXEyNEJqZDFHN3o3VHNsWkRuMmZwK1ZyajQ5MUJjVVJHaEdSRHlidTM0?=
 =?utf-8?B?bEpEbnFNVnhWWEk3aTZxdFNsUjZ0YWlBWXV2Unp0dWZReFVrNDFSV2dMb3JF?=
 =?utf-8?B?a1g1bDQ0TW5nOVVJR3hyT1J3Y3AvcFN3aTFXVlQ5Z25iUTB1Um1sSDhreGdh?=
 =?utf-8?B?amFWK1YrdFJnQ0xURnVKa2VPZWc4ZUpXeXRFb1ZHbm5TSXdtYkNCYSszNmNm?=
 =?utf-8?B?bHJud1lhWDd4SndqMENoL0ttUkd4TVExOG5XOGd2SW9jU29sTSsvVWN5Q3VP?=
 =?utf-8?B?bzUxTzlPS0FVQkNTZEZxYUlnQnFoOG96VDdNQWx4eEk5eUczZzFvQ0JuOHhH?=
 =?utf-8?B?Y1dYV2lpWFJMb2ZOT0MrN2xTNmRlREExd3dPdFdQdnp4OVFvUWY4bDFmNVd5?=
 =?utf-8?B?a1Rsa1QvSzVrOEl3L0kwVlpybS9mcHRhdlVNVzF0R3hzcGc1MXFIbTFiOWtW?=
 =?utf-8?B?VXNyS1dZVGZSR01EVmk1d1hWWkNneHB6UmxEQzJhUG1KeTZuQ2cxNlJyMTlZ?=
 =?utf-8?B?Um1jNzVQRDV1cG1PWHNEcS8xTSt1dkgrbXZ6S2NVclJMb3kxcks3U005aVB2?=
 =?utf-8?B?K1NWUUNXMnFuMHBmNVg3UWloV3RJSHYyNnZobWNha1dNLzVaaFFYdzlqcTVS?=
 =?utf-8?B?M2R0NUZkY3pTNVVkcFF2ZUhEeVJpdVFUTHZlWC9EMnoyd2tYK3BQclZvS0dv?=
 =?utf-8?B?SVFzNlJyYnJ5dEFGK2NpNmtIakpuVzlLUjI0aGQrOTc0SVJKbzVPKzNQTC9N?=
 =?utf-8?B?TjJwOUJnZXZUWVVyL0dFVTRqSHZ5T0I5TUpwRVh1eU53VW1sbUsyMmhDRWVP?=
 =?utf-8?B?TURvSWJzSGI1UzdjcjE4SWdYS0N2VnJWSEM0eENHWUt5YzJubEFOS0RkUDhH?=
 =?utf-8?B?ZG43Tmg5WDRHUFpzUU11eVZzVmEzMkxSOVAyZnRPalM0MzFZNTUwdG41OGk2?=
 =?utf-8?B?MWN5WjdXUkxtV3NWejloQUpmcnZlU2FveFBqMVJWU3I1clg3UUdRcXZMcUNJ?=
 =?utf-8?B?MUJDaHpiOEF3cTd6S3paQ283N0hEWXJGRFpKWHJnZ01UUVB5UXFQWHVjWkVF?=
 =?utf-8?B?WlpiWkVzeDJER1NmR1pWTVc5TndGdHdkZWVuV04vdTFoQ1hjZTJ6ZnlobUs0?=
 =?utf-8?B?Rzhia1JwNGxvczdyRFlSam9yT3BycHlaNHE1anJYLzJrZTNRS0JaL2QyV2RK?=
 =?utf-8?B?WHpoTm9lcEl1d01TZzQxcXFkWWpHbitnVmhNdll6bGxhMmJqczNrTkdaNFlH?=
 =?utf-8?B?VEtKTE9mUUlBYzdkL21kQUZLeW5SV0ZrRFpXVkdvQ1dVakdHREswNjhCYThw?=
 =?utf-8?B?L2JPWnZpblpwYTF0dlRyMm9ET1VXQStuaFdXQ2VGUzA4ejVTOU9ZZWN5RnFy?=
 =?utf-8?B?MjYxR0hRVGt1MVQxc2NiY1R2QkhqK0ZNSkovWWJIWUNKRnpwaUtaQ2ZvdlE2?=
 =?utf-8?B?N251ZDNvWmdnbGxFcHNmMmNQaURnUmRBL3dPVkQ5MVFFbXBoRjdqbzhwcWpj?=
 =?utf-8?B?TC9FdkIzbmRZTlpHa0NkeFRVUUtuRXltdnJHc2xVMGFVbzRiWk81cG5NTGc2?=
 =?utf-8?B?UGowRWtuc3E3bVdLVU1YSk9Tc0JUejF0b2hqY1NKOHBLV2dmZVBDcHYwWWNh?=
 =?utf-8?B?RHNZVHU0dEw3LzNtWlc1aUxFajRnUDVyOWFBNnZ2UkVnaWM0eHhJNXI5NnFu?=
 =?utf-8?B?T0Rod3ZUbkJ1NkdrWUZyTlVlNWtGSmxQMTlPQXJabWtJRXpCU0J3SDd1NkdD?=
 =?utf-8?B?VGRnZUlKVkZCelJybWFYTE9weUFXam8zSndmK2pLemgrUnkwdGVqdHF4S0tW?=
 =?utf-8?B?WkJXTUpzcXZJSHhxMXhVdW9rR1RkK0EwbUZMV1NvQktJbkdxTEZDWGFlNVVE?=
 =?utf-8?B?dGoyOGsxemFmODZBMFhTcEp6ZnJwWlhTWk9zb25HZWFtdzVEL3ZHZUFqUnc0?=
 =?utf-8?B?ZHZrbWlQWkl3cWJDcU5qUUxuL0F6NlA2MXRFbG13S1Y0QkNzWnMxWS9nRkdQ?=
 =?utf-8?B?bytpWFpxU1V4ZzdmTjdiMFpza0VWRS8yeHJGemsrcTMyREE3azh4UHhRaGV5?=
 =?utf-8?Q?pQAGohwHgB+WsyNiwQI273t7u?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1638ff8d-51b7-4823-5caa-08db875a1a6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 06:42:06.2943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h7KqjflbeI9vhbqcdU9ERRRtY/hzLun4udhzcY/iopivm0fqMbkvK3+WQ3Rm28MDsDJuILO9hfP4lm8+SgT1zYT5vNpL3Y0RPdrHF1952Ik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5684
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFuZHkgRHVubGFwIDxy
ZC5kdW5sYWJAZ21haWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBKdWx5IDE4LCAyMDIzIDc6Mzgg
QU0NCj4gVG86IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXB3bUB2Z2VyLmtl
cm5lbC5vcmcNCj4gQ2M6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0
cm9uaXguZGU+OyBUaGllcnJ5IFJlZGluZw0KPiA8dGhpZXJyeS5yZWRpbmdAZ21haWwuY29tPjsg
QmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIXSBwd206IGZpIHB3bS1yei1tdHUzLmMgYnVpbGQgZXJyb3JzDQo+IA0KPiBPbiA3LzE3LzIz
IDIyOjU5LCBSYW5keSBEdW5sYXAgd3JvdGU6DQo+ID4gRnJvbTogUmFuZHkgRHVubGFwIDxyZHVu
bGFwQGluZnJhZGVhZC5vcmc+DQo+ID4NCj4gPg0KPiA+IEZpeGVzOiAyNTRkM2E3Mjc0MjEgKCJw
d206IEFkZCBSZW5lc2FzIFJaL0cyTCBNVFUzYSBQV00gZHJpdmVyIikNCj4gPiBTaWduZWQtb2Zm
LWJ5OiBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4NCj4gDQo+IE9vcHMsIEkg
c2hvdWxkIHJlc2VuZCB0aGF0IHdpdGggY29ycmVjdGVkIGVtYWlsIGFkZHJlc3Nlcy4gU29ycnku
DQoNCkFsc28gdHlwbyBpbiBwYXRjaCBoZWFkZXIgInB3bTogZmkgcHdtLXJ6LW10dTMuYyBidWls
ZCBlcnJvcnMiID8/DQoNCk5vdCBzdXJlIGZpeGVzIHRhZyBzaG91bGQgYmUNCmI4YjI4YjcxOGRk
ZCAoIm1mZDogQWRkIG1vZHVsZSBidWlsZCBzdXBwb3J0IGZvciBSWi9HMkwgTVRVM2EiKQ0Kb3IN
CjI1NGQzYTcyNzQyMSAoInB3bTogQWRkIFJlbmVzYXMgUlovRzJMIE1UVTNhIFBXTSBkcml2ZXIi
KQ0KDQpDaGVlcnMsDQpCaWp1DQo=
