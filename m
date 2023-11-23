Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0333A7F5649
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 03:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbjKWCKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 21:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233995AbjKWCJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 21:09:54 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2058.outbound.protection.outlook.com [40.107.105.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877E5191;
        Wed, 22 Nov 2023 18:10:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mf4fqNNw85EW+sX4TiQpekAy3Dr/dEMk26+pwUckZq23h7vxTJKvahW5I53bA/U5lLDzt/x5a4PW+YTq4ZwmrZV4rARYK+wtffr/kypgk3aFzSJ58dVfy/ivs8f2vsZykILYnMR7IgMqT7+HLPEuecH0DSdeD9Y/IRZMcLXY+MXkpP4F9yQm/7Fkh0Y1UuVNARfoYm396G6DSAyQD3iTyqcRm6c8X47v5EowI/7lbmEoHKZ/GX6C2M83+y/oKU05H1X8uf+SKj2Oa8pkWgSBatCkQU666UuUh+KLBc1umHK9cCCJLHx+lP8ahaSRgNLk52+6VdJj0tCxh6Jl6iNjKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDMg5hT6lKm9++8UI2N6JL+hR7fkKxMuGnfxkLQKcqU=;
 b=lQjcVrRtHMJZx+yBNnevD2nBTozThrxniw8nIxyuq4GN3/77GCWo5ShPZ5PSBLxBigQcKtCC3ZY9b2gg0jEXbaQIST5lTMTHDuuu7eDAHU2MTH6P2RBj9yU3KMuUIpbW6bMX7d/yeDv6EjR3OMDicb5s9oIIJ7FuVO3FBVWin2y6x5hMSkiS+QLFMAt/8mJr+Tepp57GkIHouIzgtMZXPy28p1pXc0O8gA4j5t+c5P+8II3s45JlDFKcy5H8/KG+fMz0zQBa6R214wZ7rYZY1247K8egWnQcuVVY/B3lcPtF8sGU/E7iM98Jys2dwdLHL+RDBB143lWLW5TKvXCCzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDMg5hT6lKm9++8UI2N6JL+hR7fkKxMuGnfxkLQKcqU=;
 b=Zhv103KqgNEXioqJS8CTxuKEgCkHGDI6RnrsEDvs3l1FLZ7fL1Gr/fpI5GEssYEi5Kv/lX9HJcyvB5bB4smEkrKprqD01bUurkh0++wXMGh7D/4zNUPFXO7+pVXlXLvlZDf/oOpMudP4jHTVv5oVxbv+3jzphlZbY/bcChCMa3k=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by DU2PR04MB8552.eurprd04.prod.outlook.com (2603:10a6:10:2d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.13; Thu, 23 Nov
 2023 02:09:57 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::d6ee:d372:176b:1786]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::d6ee:d372:176b:1786%5]) with mapi id 15.20.7046.012; Thu, 23 Nov 2023
 02:09:57 +0000
From:   Wei Fang <wei.fang@nxp.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] net: enetc: add ethtool::get_channels support
Thread-Topic: [PATCH net-next] net: enetc: add ethtool::get_channels support
Thread-Index: AQHaHS917D/cb/ehxEmfQla/ZuWTk7CGLBMAgAD4QYA=
Date:   Thu, 23 Nov 2023 02:09:57 +0000
Message-ID: <AM5PR04MB3139E96BF99E55E563EF71B888B9A@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20231122102540.3766699-1-wei.fang@nxp.com>
 <20231122110120.crs4rh2utjweswsc@skbuf>
In-Reply-To: <20231122110120.crs4rh2utjweswsc@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|DU2PR04MB8552:EE_
x-ms-office365-filtering-correlation-id: 05f12c63-f5c6-48b8-c865-08dbebc94ac5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZgQ6IgBjuXt0XuhfL2LjsIkwAlTl/C02WwFloXkPntKkvN1dtNE6yQRB3pkNjbgy5faOVxBhmLBRGS1Pb4VbpJY2A5W7umKLVz0zy+sxXTKL4pCEUIbktBM8Ouq98PjYp7Jr3w2vowUqDQg2ejbmKMMsnfog/i1v/Cw4O5LYR73E+boayxjJDg+2fWiRThGbmVPLqivBqVvo+PRpTtZEg/YiL49ywtuq+hjPbYYMCtM63fgiy3oKsHrys49tnRpfrgA+jaYLKF/Bu0qAM2UbhuRu/iypfoToLF4YOZVJgSscd35Cc5EweUPqYxjhS7/IEUDQ8+Mbkj5VMz/PK3V18mpbwHGja7l85PBqg8jlrR3eB5g1XgK8cyitt5UUTdY37hhtvwDfYdg107CXF02uS1txQxc+uw/bYtGlFxjqhXyxFHErb526hWgAvnwD665e3t4VeoK0rhqo5hVXZq+0EBSpJkaFaGEEQNsfCBTp63hsRyDulvmq8a3ZAkO/0X4e4psV7dDc/XILCwDov5lyRdIVY5Z22HgGw8ag2LOnQKHbzsEDkLCcsvhq3qLqWMEuAfeYu6weXMJrqTyo1NwINBZ7eCWCPT5Emzl7iDD1+G0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(39860400002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(26005)(83380400001)(53546011)(6506007)(7696005)(71200400001)(9686003)(44832011)(5660300002)(6862004)(52536014)(41300700001)(2906002)(478600001)(966005)(316002)(4326008)(8936002)(8676002)(6636002)(76116006)(54906003)(66446008)(64756008)(66556008)(66476007)(66946007)(86362001)(33656002)(38100700002)(122000001)(55016003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?WWhOZlQ0NjE2MmNQRFlrQTJoK0NqSFlITDdTRHdXdlk2Z1hLU21uWUtwa2FK?=
 =?gb2312?B?ZVJXMVE4a3ZJODhMRzB4YVNlSzJhZnFTMjJpdjQrdTVMbGdOZWhueXpoNkli?=
 =?gb2312?B?S3ZmS2hyZE9obTZsRW1PWHE0UlJnbkRCZktDOU5PcGZVK3VWMEdzakFYdDhH?=
 =?gb2312?B?SWJ4cUJyNFhtSG5QVEZkZXMxanBLczlMRGkxQXUrWjd4MDhCZTN5SjlWVU9N?=
 =?gb2312?B?RzBSd1VZaC9Ud2Q3V2MzSi9xV1F5bXJsbzlVcms0cFBtZFlCYTRMQUNRemd4?=
 =?gb2312?B?Rk5mTWdUTFl0ZWkvNFpkaERTL2dBWUFoenFRR0k0S1RjYTE4Zzdkd0RBeFR3?=
 =?gb2312?B?aWtER2MyM2FJSlN1QlY0ZzVNOGlPUDNTZ0pyY29rTGZjdzFqcnU0blNXSFFD?=
 =?gb2312?B?c3AvNU5zdEg3VXlOeHo3Rytab2ZhWjA1Y1k1cjBHNTNickRtSitKdEZZU0pm?=
 =?gb2312?B?c2p4NUVxSHkzUWVreU82OVBJbGorUGI1Y09DQnJYTHI5aUZXMjNYNnVkL2Uz?=
 =?gb2312?B?YWZMR0Y2cUR2b1VwQlYzbTBwMWVyYnlBZWNSWTB0YkpacFZOWlRwKy9RTHBr?=
 =?gb2312?B?UzhTeGlMSHA3M1RIbWZWWXM4djFIRzhnQUh2QzBtbkhtSm9DMlFwZGtiN0hl?=
 =?gb2312?B?U3NOcTRCdDVjdGY4ZHdaaHEzci93eXNQN2Y4TGVYai8wUlNzQVYwcTMzbS9a?=
 =?gb2312?B?c2hnTldmQk1CK2tPbDNwU3RJSDVSZmxyTDUyNDlqbmR4MXhmNDVjWGZUWVdq?=
 =?gb2312?B?WTVMbG0rMXhqR0d4RFlEM1pvWWY3NStxckd3T0diZjNJSlJoWFNNMkQ5TXpV?=
 =?gb2312?B?NTlnNTJ3QVYzbWo0dGVWd0pqUkMwcGQxUWE2RWFvV1RTZ0ZqbmlXcTlzcWZE?=
 =?gb2312?B?UWRRTE44a1lkU2hOb1Q4SFZZUmI1Mi82ekJCanI3K21tcE5tUlpJMlBjS0Zp?=
 =?gb2312?B?eDlLaVV6ejhUdEVMaEluT2FlVzN6NW91Rzd6YysrUjVReE5BWHBVUFo5aWhl?=
 =?gb2312?B?YjBNK1Z0Q216SVRaVE56MmdhU0JMYkJ5Z0RURmNPQS9ydHpIK2FXUFBITXlF?=
 =?gb2312?B?OWpua253ekJSd1JxMUQrOFpSUlpMaVBIMS9kVmtPYS9VU0pHRlM0TUE4SHVy?=
 =?gb2312?B?YlgybThXdWdERFkxZEpPOVY4MEkyMGZyVjM1YkJSMnR4enhVUUFKSXFWS2dM?=
 =?gb2312?B?cFUwSGJaMmJhbVJ6QVdYanRxaklNUHhjVFlGclE5UTFEdlYrVW9XL1BuU3Aw?=
 =?gb2312?B?M29pYmllc0UvckxRSTRuUlB2UmFYY3Rzc0tDVlRmKytRYXRJd2RKZWdLZ0JE?=
 =?gb2312?B?ZTlONkxzMFZQYS9nL2dHcE4rSmg3VDJtV3lMYkUwVGJlWE9xS2tBMzY5aVE1?=
 =?gb2312?B?RFViTDlJaUNSWTVmL1RTcjVpQmpUSm9MczlDV3E3d3QyT1UvaVZDbHo1QlBW?=
 =?gb2312?B?TitDS25hL2xpbFBJN3VHK2w5NjE1L2tVejh4ZzRPbUYwaENRS3lnZ2ZPcmRv?=
 =?gb2312?B?OFRCazQzcmhTYUNCT3Jod0FLUStxd2t2SnV2cThPb3cwMDM3RGU1NENDb3V6?=
 =?gb2312?B?cDhaY2xwMm9VeWFNaEZHZG5sYUNaa0FoOE5kenNnbjVUdXpNeFhXZkR1dGZK?=
 =?gb2312?B?aVl3bllkQVo1RmFyZkhjZlVPaVROSGtBOVdrbzgwV0wraEE0SENYVEVVWG14?=
 =?gb2312?B?dTdNWWU0cEVQdU50NjZXNlplbUpFbGZYOFpRbTJ6YW5ZKzhlVHpaRlZuWUNs?=
 =?gb2312?B?d3hRUjhrK21rSFBXSk4zejU0ZGt6VUQybVM2TjBWZnNaenk3bjlhVTBpZm1t?=
 =?gb2312?B?T05ReHBDck9iNXR1bmdTMEFSWUJSVTVENVgreGJMMDN1TjI4MlJ2WElEQVhS?=
 =?gb2312?B?djlqaXFicmcrTFRuN2I4M0hlVjI0eWZSRUMrdVI5VExIRGRHUnRyWjkzOC9p?=
 =?gb2312?B?TG55NllRYmxlaHpDcHY4TnVVOGdpM2U3dFRCcDdlUmVUS2hqcXdkS3F3MTR3?=
 =?gb2312?B?c21rY2RWN2k0VmdHcWFOckJQN1RCaDdjK0V5Rk1jc05kMEhSMzE4aXJURFEw?=
 =?gb2312?B?YzFHMWE0MFdRaGRuQXkyTFVFREg1S3dPUXgwM0pVcDM1OHIyTFZ2WWFuRlNM?=
 =?gb2312?Q?DrXk=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f12c63-f5c6-48b8-c865-08dbebc94ac5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2023 02:09:57.8439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GhsUprmzF0Wc/AFVZSAKI0koohVJpvpXRuKT5Vp7b8CkGGYHvbWq9sUHupg+Pk6Kcw07FGGK4FVVnV6DKuhAQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8552
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
YWRpbWlyLm9sdGVhbkBueHAuY29tPg0KPiBTZW50OiAyMDIzxOoxMdTCMjLI1SAxOTowMQ0KPiBU
bzogV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+DQo+IENjOiBkYXZlbUBkYXZlbWxvZnQubmV0
OyBlZHVtYXpldEBnb29nbGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7DQo+IHBhYmVuaUByZWRoYXQu
Y29tOyBDbGF1ZGl1IE1hbm9pbCA8Y2xhdWRpdS5tYW5vaWxAbnhwLmNvbT47DQo+IG5ldGRldkB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDog
UmU6IFtQQVRDSCBuZXQtbmV4dF0gbmV0OiBlbmV0YzogYWRkIGV0aHRvb2w6OmdldF9jaGFubmVs
cyBzdXBwb3J0DQo+IA0KPiBIaSBXZWksDQo+IA0KPiBPbiBXZWQsIE5vdiAyMiwgMjAyMyBhdCAw
NjoyNTo0MFBNICswODAwLCBXZWkgRmFuZyB3cm90ZToNCj4gPiBTaW5jZSBFVEhUT09MX01TR19S
U1NfR0VUIG5ldGxpbmsgbWVzc2FnZSBbMV0gaGFzIGJlZW4gYXBwbGllZCB0bw0KPiA+IGV0aHRv
b2wgdHJlZSwgdGhlcmUgaXMgYSBuZXRsaW5rIGVycm9yIHdoZW4gdXNpbmcgImV0aHRvb2wgLXgg
ZW5vMCINCj4gPiBjb21tYW5kIHRvIGdldCBSU1MgaW5mb3JtYXRpb24gZnJvbSBmc2wtZW5ldGMg
ZHJpdmVyLCBhbmQgdGhlIHVzZXINCj4gPiBjYW5ub3QgZ2V0IHRoZSBpbmZvcm1hdGlvbiwgdGhl
IGVycm9yIGxvZ3MgYXJlIGFzIGZvbGxvd3M6DQo+ID4NCj4gPiByb290QGxzMTAyOGFyZGI6fiMg
Li9ldGh0b29sIC14IGVubzANCj4gPiBuZXRsaW5rIGVycm9yOiBPcGVyYXRpb24gbm90IHN1cHBv
cnRlZA0KPiA+DQo+ID4gVGhlIHJhdGlvbmFsZSBpcyB0aGF0IGV0aHRvb2wgd2lsbCBpc3N1ZSBh
IEVUSFRPT0xfTVNHX0NIQU5ORUxTX0dFVA0KPiA+IG5ldGxpbmsgbWVzc2FnZSB0byBnZXQgdGhl
IG51bWJlciBvZiBSeCByaW5nLiBIb3dldmVyLCB0aGUgZnNsLWVuZXRjDQo+ID4gZHJpdmVyIGRv
ZXNuJ3Qgc3VwcG9ydCBldGh0b29sOjpnZXRfY2hhbm5lbHMsIHNvIGl0IGRpcmVjdGx5IHJldHVy
bnMNCj4gPiAtRU9QTk9UU1VQUCBlcnJvci4NCj4gPg0KPiA+IFsxXToNCj4gPiBodHRwczovL2dp
dC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9qa2lyc2hlci9ldGh0b29sLmdp
dC9jDQo+ID4gb21taXQvP2lkPWZmYWI5OWMxZjM4MjBlMjFkNjU2ODZlMDMwZGNmMmM0ZmQwYThi
ZDANCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFdlaSBGYW5nIDx3ZWkuZmFuZ0BueHAuY29tPg0K
PiA+IC0tLQ0KPiANCj4gSSB0aGluayB3ZSBoYXZlIDIgcHJvYmxlbXMgb24gb3VyIGhhbmRzLg0K
PiANCj4gMS4gZW5ldGMgaXMgbm90IHRoZSBvbmx5IGRyaXZlciB0aGF0IGRvZXNuJ3QgcmVwb3J0
DQo+IEVUSFRPT0xfTVNHX0NIQU5ORUxTX0dFVC4NCj4gICAgU28gaXQgaXMgYSBnZW5lcmFsIGlz
c3VlIGZvciBTdWRoZWVyIE1vZ2lsYXBwYWdhcmkncyBpbXBsZW1lbnRhdGlvbg0KPiAgICBvZiAi
ZXRodG9vbCAteCIgdXNpbmcgbmV0bGluay4gVGhlIGlvY3RsLWJhc2VkIGltcGxlbWVudGF0aW9u
IHVzZWQgdG8NCj4gICAgbG9vayBhdCBFVEhUT09MX0dSWFJJTkdTIHdoaWNoIHdhcyBoYW5kbGVk
IGluIHRoZSBrZXJuZWwgdGhyb3VnaA0KPiAgICBldGh0b29sX29wcyA6OiBnZXRfcnhuZmMuDQo+
IA0KPiAyLiBJIHVzZWQgdG8gaGF2ZSBhIGRpZmZlcmVudCBpbXBsZW1lbnRhdGlvbiAoYW5kIGlu
dGVycHJldGF0aW9uKSBvZg0KPiAgICBFVEhUT09MX01TR19DSEFOTkVMU19HRVQgZm9yIGVuZXRj
IGFueXdheSwgd2hpY2ggYXNzb2NpYXRlZA0KPiBjaGFubmVscw0KPiAgICBub3Qgd2l0aCByaW5n
cywgYnV0IHdpdGggaW50ZXJydXB0IHZlY3RvcnMgKG1ha2luZyB0aGUgcmVwb3J0ZWQNCj4gICAg
Y2hhbm5lbHMgY29tYmluZWQpOg0KPiANCj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9w
cm9qZWN0L25ldGRldmJwZi9wYXRjaC8yMDIzMDIwNjEwMDgzNy40NTENCj4gMzAwLTYtdmxhZGlt
aXIub2x0ZWFuQG54cC5jb20vDQo+IA0KW1dlaV0gU29ycnksIEkgZGlkbid0IG5vdGljZSB5b3Ug
cGF0Y2ggYmVmb3JlLCBJIHRoaW5rIHlvdSBwYXRjaCBpcyBtb3JlIGJldHRlciB0aGFuDQptaW5l
IGFmdGVyIEkgcmVhZCB0aGUgImNoYW5uZWwiIGludGVycHJldGF0aW9uIGluIG5hcGkucnN0IGRv
Yy4NCg0KPiBJIHdvdWxkIHN1Z2dlc3QgZmluZGluZyBhIHdheSBmb3IgdGhlIHVzZXIgc3BhY2Ug
aW1wbGVtZW50YXRpb24gdG8gbm90DQo+IGFzc3VtZSB0aGF0IEVUSFRPT0xfTVNHX0NIQU5ORUxT
X0dFVCBpcyBpbXBsZW1lbnRlZCBieSB0aGUgZHJpdmVyLg0KDQpbV2VpXSBJTU8sIHRoZSBpc3N1
ZSB5b3UgZW5jb3VudGVyZWQgaXMgdGhhdCBsaWJicGYgd2lsbCBwZXJmb3JtIGFuIA0KRVRIVE9P
TF9HQ0hBTk5FTFMgb3BlcmF0aW9uLiBUaGUgaXNzdWUgSSBlbmNvdW50ZXJlZCBpcyB0aGF0ICJl
dGh0b29sIC14Ig0Kd2lsbCBhbHNvIHBlcmZvcm0gYW4gRVRIVE9PTF9HQ0hBTk5FTFMgb3BlcmF0
aW9uLiBCZXNpZGVzLCBUaGVyZSBhcmUgb3RoZXINCmFwcHMgdGhhdCBkbyB0aGUgc2FtZSBvcGVy
YXRpb24gYXMgdGhpcywgc28gSSB0aGluayBpdCdzIGJlc3QgZm9yIGZzbC1lbmV0YyBkcml2ZXIN
CnRvIHN1cHBvcnQgcXVlcnlpbmcgY2hhbm5lbHMuDQpCZWNhdXNlIHlvdXIgcGF0Y2ggaXMgbW9y
ZSByZWFzb25hYmxlIHRoYW4gbWluZSwgSSB0aGluayB5b3Ugc2hvdWxkIHN1Ym1pdA0KdGhpcyBw
YXRjaCB0byB1cHN0cmVhbSBzZXBhcmF0ZWx5IGZpcnN0Lg0K
