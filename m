Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3B77536BB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbjGNJgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235742AbjGNJg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:36:28 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2111.outbound.protection.outlook.com [40.107.113.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A5A3581;
        Fri, 14 Jul 2023 02:36:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSYdsiRbVhGf+GalTuDhnC9Fix7eA+DahN08tWsvkUi7uJPT4ro7qfjF9D3hNFgdxs3O1F80Tly/CDgPWi9gWv8eFWEtTCDDtPT1Gsh7jQ1v8Z1yJGCvO3AvX0N+tPor3LwHfFTAyVZsgqgBYMbP0sTpzH7ISE2ZOWajQ7YjcEInFBdqlolOclXv8ZZ+e4e4u8/5AMts5fGsUIbTEZtxG8TdVInc5ctTnhlIGdExCPtfQGwj6Ez3ihCsQLUMqaaIoQHMK3AyLTOzPixTI9pZzBKHR4iXku/R64TPNQIHITSMaqFM6Q9+tEfWdYqrPKmC91ulscdoCRB9iYkIKSyjTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxpoC3UDQERzUBSYnZt4ln0CJFjNB2Wbn2iAPJoAGKE=;
 b=lj7Gk0lSHeX2++Z9G77vmkr3uDhRzTsAr9abt1+N5NwehJKdhCAYsd2nyqUw2sPZHKmQj7KB4V90DuvqWt6ND8FIvP+tIr8tkT6m3Ve1cpRXvYdWKoOkSvac2y4c68tozyhhK6HNk1dPFz/z/cN3pe8Ydl68Lkk4LhwYk1RYvuK8Re0o2UEtauv4OclZqYtA6YpB89jSq0NCUiEA11NzlU4HO2d57zRH8xC3Y16ImiQVqX3y1qCg4acnh29vaHY7CWOUwkwy6Av6qL7DEmHS3RG+9R7ou7AzZ2MfJm92wgErC+aXxV2RLf6QGRKvN/s8jh/xfBddG5nI6VC6CoUoiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxpoC3UDQERzUBSYnZt4ln0CJFjNB2Wbn2iAPJoAGKE=;
 b=i93gUAEZHIT94TBNbSlD+zD78RZJ5K/xTe13RAYVGxDJvsXF8++wcFUNG3/odN318Xr0s+i2aPyUorMftMIhJmGWb7ezjbzQrXXBf5PeRATpYHbatHxKBnHt6VEZw2fE1mGFQhPcMqynaEAnI7fCrXeQ+SGIxAx/ld2CVX3dTSg=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by OSZPR01MB7818.jpnprd01.prod.outlook.com (2603:1096:604:1b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 09:36:18 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::97db:c5f3:bb48:c03b]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::97db:c5f3:bb48:c03b%2]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 09:36:18 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: RE: [PATCH v2 3/5] spi: Add support for Renesas CSI
Thread-Topic: [PATCH v2 3/5] spi: Add support for Renesas CSI
Thread-Index: AQHZpP1zFctKcaLpHUujhHkndUbaba+rEJGAgAzi07CAABM2AIAAW2ZggACeHICAAB9gsA==
Date:   Fri, 14 Jul 2023 09:36:18 +0000
Message-ID: <TYWPR01MB87756EB073312FDFCAE3E48DC234A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20230622113341.657842-1-fabrizio.castro.jz@renesas.com>
 <20230622113341.657842-4-fabrizio.castro.jz@renesas.com>
 <ZKVI4XPbPXfzQa9J@surfacebook>
 <TYWPR01MB8775144ADA4B4FF2CB9B940BC237A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
 <CAHp75VcJvRq7BotoODW_BOh84+TD_1Q3vbXSQv3FCiJfnBx8Vw@mail.gmail.com>
 <TYWPR01MB8775E433ACFA2F78D357FF05C237A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
 <CAMuHMdUPOQZAM=Rq8tMLj8ikoCz_ff4kYF3_uuX7PKtBwaMGwA@mail.gmail.com>
In-Reply-To: <CAMuHMdUPOQZAM=Rq8tMLj8ikoCz_ff4kYF3_uuX7PKtBwaMGwA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|OSZPR01MB7818:EE_
x-ms-office365-filtering-correlation-id: 80715c5a-832a-4ecd-7d0d-08db844dc6a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o18TdfSo9dO2Yxw6DCcH2KCykl2rQBwDGYagGzOKyl+PFwdLV2A0SkV66MBSXAWH2Tf4Gv6KnGyMZ+OcOjO3XNZhQObsM4fpnUsu0bw7zWYZUxSA/C5xVmhVHgZYG6++nbeJTNjt6QPa+gly9Ekc5Iyagv01jdGOZFsXTpNn775nxlQsVJXG5R2BUXDBbpHb4YkOLz6F7G5v8ICjvCnZscdJsMirP2ecnyNBIfxaWvN4W/PoQ9NKng+9Z5wcAcpty2kGr6QH3kDFGeaxmjP3joRBJC9bLsa+g0N2G9z7yJk7PqKlzZ8IaFjpqcgl+ip5bF/P6EawEEp6bflVcVbuOm2CGrjqmwgCMVEzbfIwngmsL7Gd1zVCibxjdK9lQ7sBEQkJgNWaYEc8tfFy76SzzfBxO2FobSdc/sEAHHO6o0Vu4mdWWFZCyQnMMARqN9h828AKGA7ENzggZzpcCl57PN7YKVuPJw3Wp0pvPQZKnQ1RBDJUD7V+3pEo3HYkW3qjK8ELeYLjjZo/OM1kKpuXfFxsUja4irWdRufYEColcECJ7cVfksRpq9fHhpmp3/OjwLP4cAuuF+Iuo6yVyeL2YKVgxpLelYVd5pnozuztmdsylcFx7MlpGNJlg2BGw2l2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(451199021)(107886003)(8676002)(8936002)(83380400001)(33656002)(2906002)(38100700002)(122000001)(38070700005)(86362001)(53546011)(6506007)(52536014)(55016003)(5660300002)(26005)(186003)(316002)(66946007)(66476007)(66556008)(76116006)(66446008)(64756008)(71200400001)(6916009)(7696005)(4326008)(9686003)(478600001)(41300700001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFhNOVhUSldnSGRzMmFtS0VEOVoyYTdTT0hDY1FDRDIydFJZWUhReWRKWVVK?=
 =?utf-8?B?UHB1NjlQTGM4LzFEdzBoWnl6a3BlSEVsekZHcjlCWHF4dUFKS2ozaE42Sk43?=
 =?utf-8?B?dmg1aVFQWlhqT2dNbVVIQTRzNDlDSnNscHROcDJCRnFnS3d1TlVXbFhOQVZG?=
 =?utf-8?B?VlZBR1NCWHB1QUhENFdLdkFlYUl6dmM2RkhNditFN0twaENkODN4S1ZjcVNT?=
 =?utf-8?B?SEZuWFhzVXRmS2gzZnJQMnkvZGRoRmt6a2ROaTdacWJjL2F0dGNzbVZSQUVW?=
 =?utf-8?B?NEh5ekpRZFFFK2ZiSEJoak5tV3lXa25LTTVaSXZ0dFljb0FqakJzbHNnMW9M?=
 =?utf-8?B?MktjbktNVzF4bTdsSVRDK1Vma2FEenNCanJ6YjFXTUU2QmpsOFY0aG8zVGQx?=
 =?utf-8?B?UTQ2UlBnTWJEcGp2NWVnalVIbmpDTy9JSkpTMHRQd3d5SjNlaS9oRjM1eHlt?=
 =?utf-8?B?MnRFWFFidVoxdUpLN2RuNHJQb2ZJemh6cW1CaXQ5TGh3WlhkN1Z6d05od3FE?=
 =?utf-8?B?QXpmMG52b0lYZjJqdzdFUHU0eHBwNkdLNFE3a1N1Z2NtazJFb3JIUDl6YnBP?=
 =?utf-8?B?dFR5dVlkdHRlTGZNOFQyUUl0c3g3Z21QUUIwbVpLeklqcy90SjV2UmhXTTdF?=
 =?utf-8?B?UDBJNk5zdUFGd2dCREd6ME9UQVBrblAvUzZ5VjBBa25WTmx4TDVUayt0emxK?=
 =?utf-8?B?UE1LNjZwK3E5Vm9VajBta1FodUdXZk1BcHNRMjdNSEFoTHBpM2dDcjllUlNY?=
 =?utf-8?B?TXAwSFJ0REdLTWhpL08vQ2RPUnJNS3Z2S2gyOGVyMkpZZHdILzFNQ1ZkNXJm?=
 =?utf-8?B?T3hUNzdQblY5UTlGMmtJNnVLTG1qdTkrWmgwSEpnWlM0c0ZncFJ4MzRrV0ls?=
 =?utf-8?B?U09KSWdJcXVnL3JNYzFkRjZZbWc1dFlLWVN4YjE2ZDN1SW5QUzhZTXhwdkwz?=
 =?utf-8?B?RkpKMS96WERJQWdzcUJncmt3bWNZYnU5SzNxUkJYQk5Wai9WT3o1bmZWMElK?=
 =?utf-8?B?bDFlaDJqT1hvcVJiZS9VWjRKQ2xIZXNXd3FCQzE1Q2lZSUhLV3dQZFJnOGN2?=
 =?utf-8?B?UG9OY3lxWm1OS09iQVJlUGl2eFpQRHhtTGZHODRNM3BnRVNaMCt4a01rYnNj?=
 =?utf-8?B?b1JhUnFHVGJFdFdwcjlHT1IyZzF4eCs5SDBpMVhIeUZxeURqUWR4WmZmWE9D?=
 =?utf-8?B?aTdxZ2g1Z0xYYWtPbFJoWFF5MEFIMkgvM1hoWDYvcVkzNlo5VVE4anJkdGw2?=
 =?utf-8?B?K0lPNndWemdlSCtNeUgvTjBsOFoweE1ZZWQ3NjZmVVppVmE1WVAyY2pWTXlX?=
 =?utf-8?B?bkxwRDhiRGJod2xQUE1JN3V3VVQ1Y1JYT2pLeFA2MWtZaGtKMkRMa2Y3QlQw?=
 =?utf-8?B?Rm9GQjVrUEV2Nmp6NUkxR2M3TG5TeVhTNk1JQ0ZNSy84YjhLN0xONk1aT1da?=
 =?utf-8?B?b216N1EwY0IxQWhHZXhlMDRvaTBsUnQ3Yk96ajllbFFjVTJiUzEzU3h3UHVo?=
 =?utf-8?B?c3lFN1ZEVmFzTzdvMEFSTDREcGhtVWRkS09CeDc3RXZOeERQK3A4ZTVjWkZp?=
 =?utf-8?B?dGhtTlVKcDJra3NGaE50RUtleTFOalBJWUdOTEtJU1hnZlloc0FDVHd6MlFh?=
 =?utf-8?B?RVEzbFZJa3ZrVldicGRGQTNPa3hXcXlkd3NweGFlbmhKd2g2eVhKR1QweEY4?=
 =?utf-8?B?THg0QUxCdkFzY2xmMHZaQkhLWTVIM0RiQTBkWDR5UlB0SXUzblNIekJFaUdF?=
 =?utf-8?B?c1Yra0hIUFRZMTJMV2ZIbk90akxOYzVhcmdYQkVnZlIybDQyc2VSNlEvNmhk?=
 =?utf-8?B?RVBzbEUzb0Q1YjJGY0xYYjRSbE0vTFB6a3ZuQ1NvN2tQWEZ1enBWcFUzOURL?=
 =?utf-8?B?UExEeVlkQm51NmlWalBsZHN2ZGpaQVdUTVg2ZlhXMW8xS3JQSCtYTGlKUHZC?=
 =?utf-8?B?enlzSnpkVWFkZWlBbnFCcVpPSmhSa0xtaTZQTXNFY2NnRG5Fem5SeHdncW5O?=
 =?utf-8?B?QUJIMmliMDRUK3Y0RTkzcy83b29hRWR5RTRXMU1CVVkrVUlCSXZzYm5xUWtS?=
 =?utf-8?B?a3VKMHlwYzdBbmRHY2ZPaElKUzZrNGJWUk9DclA1dWRYU0gwbXVQd2hKVGJM?=
 =?utf-8?B?M3NBQlh3VHB1cDI3a0w5c3NyM3didFNFbVZnTVhkbnJUODZ4bTEzOEFmbWc4?=
 =?utf-8?B?eUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80715c5a-832a-4ecd-7d0d-08db844dc6a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 09:36:18.2473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3zUnEa8JLrY7+92BiVwyateDC7OqAfi/wX7M2j4ifc7gjmCu+sKRl95QXDLbo2ywZQBQwd5QQ18YXzUj7Ity2le60u5v6Z0NL62EFEEUrtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7818
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyB5b3VyIHJlcGx5IQ0KDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhv
ZXZlbiA8Z2VlcnRAbGludXgtbTY4ay5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMy81
XSBzcGk6IEFkZCBzdXBwb3J0IGZvciBSZW5lc2FzIENTSQ0KPiANCj4gSGkgRmFicml6aW8sDQo+
IA0KPiBPbiBGcmksIEp1bCAxNCwgMjAyMyBhdCAxMjozNeKAr0FNIEZhYnJpemlvIENhc3Rybw0K
PiA8ZmFicml6aW8uY2FzdHJvLmp6QHJlbmVzYXMuY29tPiB3cm90ZToNCj4gPiA+IEZyb206IEFu
ZHkgU2hldmNoZW5rbyA8YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT4NCj4gPiA+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjIgMy81XSBzcGk6IEFkZCBzdXBwb3J0IGZvciBSZW5lc2FzIENTSQ0KPiA+
ID4NCj4gPiA+IE9uIFRodSwgSnVsIDEzLCAyMDIzIGF0IDY6NTLigK9QTSBGYWJyaXppbyBDYXN0
cm8NCj4gPiA+IDxmYWJyaXppby5jYXN0cm8uanpAcmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+ID4N
Cj4gPiA+IC4uLg0KPiA+ID4NCj4gPiA+ID4gPiA+ICsjZGVmaW5lIENTSV9DS1NfTUFYICAgICAg
ICAgICAgICAgIDB4M0ZGRg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSWYgaXQncyBsaW1pdGVkIGJ5
IG51bWJlciBvZiBiaXRzLCBpIHdvdWxkIGV4cGxpY2l0bHkgdXNlIHRoYXQNCj4gPiA+IGluZm9y
bWF0aW9uDQo+ID4gPiA+ID4gYXMNCj4gPiA+ID4gPiAoQklUKDE0KSAtIDEpLg0KPiA+ID4gPg0K
PiA+ID4gPiBUaGF0IHZhbHVlIHJlcHJlc2VudHMgdGhlIHJlZ2lzdGVyIHNldHRpbmcgZm9yIHRo
ZSBtYXhpbXVtIGNsb2NrDQo+ID4gPiBkaXZpZGVyLg0KPiA+ID4gPiBUaGUgbWF4aW11bSBkaXZp
ZGVyIGFuZCBjb3JyZXNwb25kaW5nIHJlZ2lzdGVyIHNldHRpbmcgYXJlDQo+IHBsYWlubHkNCj4g
PiA+IHN0YXRlZA0KPiA+ID4gPiBpbiB0aGUgSFcgVXNlciBNYW51YWwsIHRoZXJlZm9yZSBJIHdv
dWxkIGxpa2UgdG8gdXNlIGVpdGhlcg0KPiAocGxhaW4pDQo+ID4gPiB2YWx1ZQ0KPiA+ID4gPiB0
byBtYWtlIGl0IGVhc2llciBmb3IgdGhlIHJlYWRlci4NCj4gPiA+ID4NCj4gPiA+ID4gSSB0aGlu
ayBwZXJoYXBzIHRoZSBiZWxvdyBtYWtlcyB0aGlzIGNsZWFyZXI6DQo+ID4gPiA+ICNkZWZpbmUg
Q1NJX0NLU19NQVhfRElWX1JBVElPICAgMzI3NjYNCj4gPiA+DQo+ID4gPiBIbW0uLi4gVG8gbWUg
aXQncyBhIGJpdCBjb25mdXNpbmcgbm93LiBTaG91bGRuJ3QgaXQgYmUgMzI3Njc/DQo+ID4NCj4g
PiAzMjc2NiBpcyB0aGUgY29ycmVjdCB2YWx1ZS4NCj4gPg0KPiA+IENsb2NrICJjc2ljbGsiIGdl
dHMgZGl2aWRlZCBieSAyICogQ1NJX0NMS1NFTF9DS1MgaW4gb3JkZXIgdG8NCj4gZ2VuZXJhdGUg
dGhlDQo+ID4gc2VyaWFsIGNsb2NrIChvdXRwdXQgZnJvbSBtYXN0ZXIpLCB3aXRoIENTSV9DTEtT
RUxfQ0tTIHJhbmdpbmcgZnJvbQ0KPiAweDEgKHRoYXQNCj4gPiBtZWFucyAiY3NpY2xrIiBpcyBk
aXZpZGVkIGJ5IDIpIHRvIDB4M0ZGRiAoImNzaWNsayIgaXMgZGl2aWRlZCBieQ0KPiAzMjc2Niku
DQo+ID4NCj4gPiA+DQo+ID4gPiA+ICNkZWZpbmUgQ1NJX0NLU19NQVggICAgICAgICAgICAgKENT
SV9DS1NfTUFYX0RJVl9SQVRJTyA+PiAxKQ0KPiA+ID4NCj4gPiA+IFdoYXRldmVyIHlvdSBjaG9v
c2UgaXQgd291bGQgYmUgYmV0dGVyIHRvIGFkZCBhIGNvbW1lbnQgdG8gZXhwbGFpbg0KPiA+ID4g
dGhpcy4gQmVjYXVzZSB0aGUgYWJvdmUgaXMgbW9yZSBjbGVhciB0byBtZSB3aXRoIEJJVCgxNCkt
MSBpZiB0aGUNCj4gPiA+IHJlZ2lzdGVyIGZpZWxkIGlzIDE0LWJpdCBsb25nLg0KPiA+ID4gV2l0
aCB0aGlzIHZhbHVlKHMpIEknbSBsb3N0LiBEZWZpbml0ZWx5IG5lZWRzIGEgY29tbWVudC4NCj4g
Pg0KPiA+IFRvIGNhdGVyIGZvciBhIHdpZGVyIGF1ZGllbmNlIChhbmQgbm90IGp1c3QgZm9yIHRo
b3NlIHdobyBoYXZlIHJlYWQNCj4gdGhlDQo+ID4gSFcgbWFudWFsKSwgSSB0aGluayBwZXJoYXBz
IHRoZSBiZWxvdyB3b3VsZCBwcm9iYWJseSBiZSB0aGUgYmVzdA0KPiBjb21wcm9taXNlOg0KPiA+
DQo+ID4gLyoNCj4gPiAgKiBDbG9jayAiY3NpY2xrIiBnZXRzIGRpdmlkZWQgYnkgMiAqIENTSV9D
TEtTRUxfQ0tTIGluIG9yZGVyIHRvDQo+IGdlbmVyYXRlIHRoZQ0KPiA+ICAqIHNlcmlhbCBjbG9j
ayAob3V0cHV0IGZyb20gbWFzdGVyKSwgd2l0aCBDU0lfQ0xLU0VMX0NLUyByYW5naW5nDQo+IGZy
b20gMHgxICh0aGF0DQo+ID4gICogbWVhbnMgImNzaWNsayIgaXMgZGl2aWRlZCBieSAyKSB0byAw
eDNGRkYgKCJjc2ljbGsiIGlzIGRpdmlkZWQgYnkNCj4gMzI3NjYpLg0KPiA+ICAqLw0KPiA+ICNk
ZWZpbmUgQ1NJX0NLU19NQVggICAgICAgICAgICAgKEJJVCgxNCktMSkNCj4gDQo+IE9yIEdFTk1B
U0soMTMsIDApDQoNClllYWguDQoNCj4gDQo+IEFzIHdlIGhhdmUNCj4gDQo+ICAgICAjZGVmaW5l
IENTSV9DTEtTRUxfQ0tTICAgICAgICAgIEdFTk1BU0soMTQsIDEpDQo+IA0KPiBhbmQgYml0IDAg
bXVzdCBvZiB0aGUgQ0xLU0VMIHJlZ2lzdGVyIG11c3QgYWx3YXlzIGJlIHplcm8sIHRoZSBhY3R1
YWwNCj4gZGl2aWRlciBpcyBpbmNpZGVudGFsbHkgRklFTERfR0VUKEdFTk1BU0soMTQsIDApLCBj
bGtzZWwpLg0KPiBObyBpZGVhIGlmIHRoYXQgY2FuIGJlIHVzZWZ1bCB0byBzaW1wbGlmeSB0aGUg
Y29kZSwgdGhvdWdoIDstKQ0KDQpUaGFua3MgZm9yIHBvaW50aW5nIHRoaXMgb3V0LiBXaWxsIGhh
dmUgYSBsb29rLCBidXQgbm8gcHJvbWlzZXMgOy0pDQoNCj4gDQo+ID4gPiA+IHN0YXRpYyBpbmxp
bmUgdW5zaWduZWQgaW50IHhfdHJnKHVuc2lnbmVkIGludCB3b3JkcykNCj4gPiA+ID4gew0KPiA+
ID4gPiAgICAgICAgIHJldHVybiBmbHMod29yZHMpIC0gMTsNCj4gPiA+ID4gfQ0KPiA+ID4NCj4g
PiA+IE9LLCBidXQgSSB0aGluayB5b3UgY2FuIHVzZSBpdCBqdXN0IGlucGxhY2UsIG5vIG5lZWQg
dG8gaGF2ZSBzdWNoDQo+IGFzIGENCj4gPiA+IHN0YW5kYWxvbmUgZnVuY3Rpb24uDQo+ID4NCj4g
PiBUaGUgYWJvdmUgaXMgYWN0dWFsbHkgZXF1aXZhbGVudCB0byBpbG9nMigpDQo+ID4NCj4gPiA+
DQo+ID4gPiA+IHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IHhfdHJnX3dvcmRzKHVuc2lnbmVk
IGludCB3b3JkcykNCj4gPiA+ID4gew0KPiA+ID4gPiAgICAgICAgIHJldHVybiAxIDw8IHhfdHJn
KHdvcmRzKTsNCj4gPiA+ID4gfQ0KPiA+ID4NCj4gPiA+IEJlc2lkZXMgYSBiZXR0ZXIgZm9ybSBv
ZiBCSVQoLi4uKSB0aGlzIGxvb2tzIHRvIG1lIGxpa2UgTklIDQo+ID4gPiByb3VuZHVwX3Bvd19v
Zl90d28oKS4NCj4gPg0KPiA+IHJvdW5kZG93bl9wb3dfb2ZfdHdvKCkuDQo+ID4NCj4gPiBJIGhh
dmUgdGVzdGVkIHRoZSBkcml2ZXIgd2l0aCBzL3hfdHJnL2lsb2cyIGFuZA0KPiA+IHMveF90cmdf
d29yZHMvcm91bmR1cF9wb3dfb2ZfdHdvIGFuZCBpdCBsb29rcyBsaWtlIEkgYW0gbG9zaW5nIHRp
bnkNCj4gYml0IG9mDQo+ID4gcGVyZm9ybWFuY2UgKHByb2JhYmx5IGRvd24gdG8gdGhlIHVzZSBv
ZiB0ZXJuYXJ5IG9wZXJhdG9ycyBpbiBib3RoDQo+IG1hY3JvcykNCj4gPiBidXQgSSB0aGluayBp
dCdzIG9rYXksIGxldCdzIG5vdCByZWludmVudCB0aGUgd2hlZWwgYW5kIGxldCdzIGtlZXANCj4g
aXQgbW9yZQ0KPiA+IHJlYWRhYmxlLCBJJ2xsIHN3aXRjaCB0byB1c2luZyB0aGUgYWJvdmUgbWFj
cm9zLg0KPiANCj4gWW91IG1lYW4gdGhpcyBpcyBub3QgbG9zdCBpbiB0aGUgbm9pc2Ugb2YgdGhl
IGJpZyBsb29wIGluDQo+IHJ6djJtX2NzaV9waW9fdHJhbnNmZXIoKSwgd2hpY2ggaXMgZXZlbiB3
YWl0aW5nIG9uIGFuIGV2ZW50Pw0KPiBJIGZpbmQgdGhhdCBhIGJpdCBzdXJwcmlzaW5nLi4uDQoN
ClRob3NlIGNhbGN1bGF0aW9ucyBnZXQgZG9uZSB3aGVuIG5vIFRYL1JYIGlzIGluIHByb2dyZXNz
LCBhbmQgdGhleSBhcmUNCmV4ZWN1dGVkIGZvciBldmVyeSBidXJzdCAoYXMgdGhleSBhcmUgdXNl
ZCB0byBkZWNpZGUgaG93IG1hbnkgYnl0ZXMNCmluIHRoZSBGSUZPcyB0byB1c2UgZm9yIHRoZSBj
dXJyZW50IGJ1cnN0KSwgdGhlcmVmb3JlIHRoZXkgYWRkIGEgZGVsYXkNCnRvIHRoZSB3aG9sZSB0
aGluZy4NCg0KSXQncyBvbmx5IGEgdGlueSBkcm9wLCBhYm91dCAwLjQlIC4NCg0KQ2hlZXJzLA0K
RmFiDQoNCj4gDQo+IEdye29ldGplLGVldGluZ31zLA0KPiANCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgR2VlcnQNCj4gDQo+IC0tDQo+IEdlZXJ0IFV5dHRlcmhvZXZlbiAtLSBUaGVyZSdzIGxv
dHMgb2YgTGludXggYmV5b25kIGlhMzIgLS0NCj4gZ2VlcnRAbGludXgtbTY4ay5vcmcNCj4gDQo+
IEluIHBlcnNvbmFsIGNvbnZlcnNhdGlvbnMgd2l0aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNhbGwg
bXlzZWxmIGENCj4gaGFja2VyLiBCdXQNCj4gd2hlbiBJJ20gdGFsa2luZyB0byBqb3VybmFsaXN0
cyBJIGp1c3Qgc2F5ICJwcm9ncmFtbWVyIiBvciBzb21ldGhpbmcNCj4gbGlrZSB0aGF0Lg0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0tIExpbnVzIFRvcnZhbGRzDQo=
