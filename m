Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDB07F560E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 02:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjKWBtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 20:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKWBtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 20:49:45 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81AF197;
        Wed, 22 Nov 2023 17:49:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjS84IJmDw1+oHpNjSt73z2uTEHYNkL0a5hUd4BoWIcUUrWQ6ivYfGzpkItUVOCCS5Qw47NgAY3QSaUba1VinhK9tVo6jU0AhOi8B3WAlEBmc8eVg48UgN1HplzI3123EPgsl6rgqtu0HIjDFtz5XEk2Bg5Swt+zWKpzRm4ISCHODB3Cal8vsepmniL486VAmd6sNjqygrIZB/YjMcgLv7nqhE5AUhw+XijUin0V5Jw6u3NoK0c451tzPlOYc0lhvRypCDSHv+OJML2T8gR91YiUwiDmprkquj6+IcXDX96ze4r49ej4Ch4V2ZvcAd989SRoQSfgKj6qnYhVEJTsHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKDjR9FU+0qGlMqJnsDw0+hVjRu/85pIQaACRE5ddD4=;
 b=drNBh7ppIQA4MqS894e/+a9fVjQDor9v9Hs1IICt5GBztmW2KVrmGkKenZGTOtEp29+LlGDL+Fpck4EQL6CzjdgP11lz8uc2am5Gpm7HJtTuIzeygigFr86HU0eyXSTi4nwBIG165DCgzkKmvmgU0+P8SOoRzYa4SsUN3PxpAzeqIJtbEt4nVtxu4yuNtnd01KQjKHhDTmgQ0j1cOVd+yGsk3rmwKGco+NHEsXRlLOwwiPWnb4QuzKaqFUC6diDq7QVP8g3TApRqAosrcytYpEUDzWnS96Afb/cPvsAQQmSJeGSfebX1lGQcYhA9rx1608VS69B4qHEglNzC6v6d5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKDjR9FU+0qGlMqJnsDw0+hVjRu/85pIQaACRE5ddD4=;
 b=tCDExPvA0+9sA+wc6/MFyLYZLrv7z4GrhgUBuuR4/aTfNvEvCMUdQHLcp+lDHeAU2MTW9SWBnGWnLWW9KU97XR8JbqOgYrUj3yWqjJRlXs1qv/mRBqCAajg8R6j5bq1C1RRYV+YFdCjy5cIu81eC4+G9jXcj1JKlVauUpYHxz90=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by PAXPR04MB8944.eurprd04.prod.outlook.com (2603:10a6:102:20f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Thu, 23 Nov
 2023 01:49:48 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::d6ee:d372:176b:1786]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::d6ee:d372:176b:1786%5]) with mapi id 15.20.7046.012; Thu, 23 Nov 2023
 01:49:48 +0000
From:   Wei Fang <wei.fang@nxp.com>
To:     Suman Ghosh <sumang@marvell.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] [PATCH net-next] net: enetc: add ethtool::get_channels
 support
Thread-Topic: [EXT] [PATCH net-next] net: enetc: add ethtool::get_channels
 support
Thread-Index: AQHaHS917D/cb/ehxEmfQla/ZuWTk7CGKNAAgAD5xZA=
Date:   Thu, 23 Nov 2023 01:49:48 +0000
Message-ID: <AM5PR04MB3139C7E45EA346E77F060D1588B9A@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20231122102540.3766699-1-wei.fang@nxp.com>
 <SJ0PR18MB5216A0B9582DAE0DF8B6F1E3DBBAA@SJ0PR18MB5216.namprd18.prod.outlook.com>
In-Reply-To: <SJ0PR18MB5216A0B9582DAE0DF8B6F1E3DBBAA@SJ0PR18MB5216.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|PAXPR04MB8944:EE_
x-ms-office365-filtering-correlation-id: 88a2e231-f042-4eaa-5500-08dbebc67a07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DZA0yeTVJNB8DgZ30nJolNqIBOlDxQa30NfMVRSRvJo1cFTzKaWlJq7MWBWSTdVvqVRgxrV4zF2ELFI+d9KeHbgcCnqmhfzVkFR+ljh1meFcPzJewjrG3bQ1Nv/bOSPyBwUSjufi3QkfLvGTprGiDZE0VWPfOWrTtMTCEyVj/Zn75NDfqh4Q8e3d4s1PzNBDcUTlWclxfgM79bQmO72XZrKe5DapYu+sqo/PV5e80Pq49Ik6e8VUVNtNuSkmdK/IKLpW43vwIn8gs0pxouGNe8BURfTgSkbL/bOkE5AJ4eRFSxxSi3I5ib8jNb20ADPwMuSX0hGxED8VxUhITGScS+Q+ymwzIc9F4tufWVRB+i0avuVLVps4msV78sPBpeIf31pR1HJRcWp3qeXnT+ee291xLTmWHHrxxCSq/tzDIrYYEvjnn25Qoqs/V+ncPSrcuAXE1wdP5pDCu2zVkIzIbyFENoDpA9gqrS/n122HNPayQaEKgHA3w7/xpdx8MueBZorfRvoo4G+FGkUzoarnP3vnfmnQuPuWU42GEacC0R2rO8TGJ+26oR22YbuKqi9P5JLFuS+zWVaV5T4v/m854CplLdgzbtKNMGF+C9BLbah705/1uqUI6ClfhmQpQNLcXPcXLdcMjQo3qUcfAvcsFF7yvffJWYAn50Op1+nrI7k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(366004)(39860400002)(230273577357003)(230922051799003)(230173577357003)(451199024)(186009)(1800799012)(64100799003)(83380400001)(26005)(9686003)(45080400002)(478600001)(6506007)(7696005)(71200400001)(2906002)(5660300002)(44832011)(110136005)(41300700001)(19627235002)(76116006)(66556008)(66476007)(8936002)(66946007)(8676002)(4326008)(66446008)(316002)(52536014)(64756008)(53546011)(122000001)(38100700002)(38070700009)(33656002)(86362001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?cnhYcnJrQlJzOEhpUm1XS05udEU3bTFUeU02Y25kU2x3cmlDWXVVV0ZzK3Z0?=
 =?gb2312?B?a1NUR3FuMEhHQlhhOGM5MjNPc3pRMU5lUDlRZUE4QklyMllsMEF1Y2ZRKytn?=
 =?gb2312?B?c1JZUGtzNWFXRnJ4Yk9aTDF2VnlpMzJnUklqdFdkUkUycHR0K0Y1S0l6NitY?=
 =?gb2312?B?T2lXZDlodS8reTJORU9FL1NxUXdsVG8zc29DUVB6cG1nY1pDSnNJclB6UlUz?=
 =?gb2312?B?NytYR2U4QzBIS0NFbk5peU52QWZ6OTMvTVJIbW1nVTFRNmRENFFQeUE2U0ls?=
 =?gb2312?B?RTdlNzdscEYvM0svSXcxckhhaWFIQnYyTWo5K2dhWGVpRGRaUVNxMm9hUk5k?=
 =?gb2312?B?NmVhQkNYWmhjMEc3MW12bW04UEdPUDczUlJGdWxFYko1UEdTQ0tqT3hLbHhr?=
 =?gb2312?B?V0x5WC9JY0FxRGN0UXZmbjYxcU9lOStJWmJkb3oxZEtwbzBqQzZWMlhSc05x?=
 =?gb2312?B?RXMzOWE1YlRKd0FybC9PQXpyWUVaN1dVNVRXdm8vOVUrMzVkN2s2MTdDTDls?=
 =?gb2312?B?amxaR0ZvdXU2bUx4SzUreUowaEFDYWpSZUxBaVh0ZFRsWHJPMkh3Tk1tSlBZ?=
 =?gb2312?B?MEZ6RXIyN2NHSTh6NVBPNjl0L3M0TEY3aGFLR2lkRCtzdHNFbDNJeDZMYldv?=
 =?gb2312?B?ZHlhaDhhYTNUcGVJV3pPYks0VWJiMklNZmx6U3VqckVzQ3J1My8rUTlQNWkz?=
 =?gb2312?B?L1ZFRDZTMHdpYVUxaEtLd3VUazQxRlZSeWhremZPRkxYT1BwYWxBWnZUWnkz?=
 =?gb2312?B?SEh3U3Q3NjB4b2N4WVdlbU96aWhia3kwN1Z6clg4WEpZdU8zb2VNemFDYVJj?=
 =?gb2312?B?T3pDRzdpTmhLTk9PK01EMWd1bXhKNFFGTExvcVV3bzJGZmVrclBHWElHeFJH?=
 =?gb2312?B?TnJQSmdTbzRqK1ZyZmtlVEtQVlB1MmdHS2xtYkpFS3VBMU1jbU1oV0xhenZp?=
 =?gb2312?B?TnFMdDJNUTN1ZmJkUlhOMmRHNVBJRGQxa3cvYkdQWGVwRlNVSHU0NzFiMTJs?=
 =?gb2312?B?OG5mREdNUWZIaVN2Ny9EZHQ3ZVlHN0x4WnpPQUp3TCtLdjJjNUlhUWd5R3pI?=
 =?gb2312?B?VnhLVzZFZnhUSjFrUG9oVGQ1cmd1MW56ck5PQkVFY0h3dlpMeVdTQThlS2JT?=
 =?gb2312?B?NUlIVC9CbitTQWVSaVN3d2tRNHFRTDBadWJIOVlZNEtUMnpwUVQ1V1hRaGdp?=
 =?gb2312?B?c3pYZ1JnSHpad3RQNk9mVlhaT1dXbmhmbHNUNEFFMFBmVmdxYmVGL3A4SlVr?=
 =?gb2312?B?MHFlT0VvZDdreUtwZktEWkJDUXZvaDV5VC9iL0lwUDc2VGtWeUFVSVlwRGtv?=
 =?gb2312?B?eXRSZFdJTUdidkg1dFAzdTlBMzRZWlhmeW1DL29Zc1VxZ3BuYkRmNUcyTGR2?=
 =?gb2312?B?ZGhXUGxVcU5WcUdXUyt5YlRSOHRveFNOelA1SWIxcmF6TkFKNktKQ29FcTNM?=
 =?gb2312?B?QzlOUG1sWjRUbDRzQ2g2V1NjOU91T1pFNDQxWGl1MUhMeFRtK283aGM1eFMx?=
 =?gb2312?B?QW1xK2hnY0tVcTZlYjNLMjFaUU5GcVNJRjR5TXBnRG9VQ2ZCYmd3M2U2STFF?=
 =?gb2312?B?VHZDWnRhNzNxa0MyK3JXbTRaVVhjK3JySmRETmpLUm5NcDluaFFlcW5YSzQ0?=
 =?gb2312?B?Z1MvZDNQaXNmSzQ5ZUZ1NjZZKzlCc2l2dk5IQzhwWDFtV2JxMEVUd1JXRUp4?=
 =?gb2312?B?ZEdXOHJHVDdaaVR2UllybXIzOUkyd2lCa0RtMGJWdWRFWkxKTzdjRzZMcG5n?=
 =?gb2312?B?L0NkWTcxWEw1MlZxTm1FSWFLVVNwdnN1Uk1hUFlVSTlaK0NjM28zL2ZOMmt6?=
 =?gb2312?B?cjh4NC9xY2tiU1RVVnZ0UmorNXlkRDFWbHQzUFRkcFZRM2NWUXZUZkdGTWZk?=
 =?gb2312?B?ZEhXeEpZbHU5TCtqZzJCd0hOU2JZZ2ZYZVlIelpFbDZtSzFSSndHZFZ0dTNM?=
 =?gb2312?B?cXBoT3ZTZWJLOEhSTkR3MGZ5bUdjanRBZEZLMUNNZ2Uxd0FUWVBlaGYvbEcw?=
 =?gb2312?B?QWxaVEdqcUdlcmVtdStwcG56S1BvYkw5SG5rVWxqQUVOVkhJYVlZcjZaaFNy?=
 =?gb2312?B?WG81NEl4U3hjaVNVeWViNU1keTBienVvT3VLM1AzL1lmUjBiVUtYa0c4UFFr?=
 =?gb2312?Q?eSSI=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a2e231-f042-4eaa-5500-08dbebc67a07
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2023 01:49:48.5998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 46p6VVv3zka86hXEYYC5wFdgL7cBV0Q8Yt5x/vWq0+kYKb3yIGxsRlBI9jqk3ixSi5GpTGBp2aAJ1nJY9SwCFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8944
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdW1hbiBHaG9zaCA8c3VtYW5n
QG1hcnZlbGwuY29tPg0KPiBTZW50OiAyMDIzxOoxMdTCMjLI1SAxODo1MA0KPiBUbzogV2VpIEZh
bmcgPHdlaS5mYW5nQG54cC5jb20+OyBkYXZlbUBkYXZlbWxvZnQubmV0Ow0KPiBlZHVtYXpldEBn
b29nbGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7IHBhYmVuaUByZWRoYXQuY29tOyBDbGF1ZGl1DQo+
IE1hbm9pbCA8Y2xhdWRpdS5tYW5vaWxAbnhwLmNvbT47IFZsYWRpbWlyIE9sdGVhbg0KPiA8dmxh
ZGltaXIub2x0ZWFuQG54cC5jb20+OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnDQo+IENjOiBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJFOiBbRVhUXSBbUEFUQ0ggbmV0
LW5leHRdIG5ldDogZW5ldGM6IGFkZCBldGh0b29sOjpnZXRfY2hhbm5lbHMNCj4gc3VwcG9ydA0K
PiANCj4gPlN1YmplY3Q6IFtFWFRdIFtQQVRDSCBuZXQtbmV4dF0gbmV0OiBlbmV0YzogYWRkIGV0
aHRvb2w6OmdldF9jaGFubmVscw0KPiA+c3VwcG9ydA0KPiA+DQo+ID5FeHRlcm5hbCBFbWFpbA0K
PiA+DQo+ID4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID5TaW5jZSBFVEhUT09MX01TR19SU1NfR0VUIG5ldGxp
bmsgbWVzc2FnZSBbMV0gaGFzIGJlZW4gYXBwbGllZCB0bw0KPiA+ZXRodG9vbCB0cmVlLCB0aGVy
ZSBpcyBhIG5ldGxpbmsgZXJyb3Igd2hlbiB1c2luZyAiZXRodG9vbCAteCBlbm8wIg0KPiA+Y29t
bWFuZCB0byBnZXQgUlNTIGluZm9ybWF0aW9uIGZyb20gZnNsLWVuZXRjIGRyaXZlciwgYW5kIHRo
ZSB1c2VyDQo+ID5jYW5ub3QgZ2V0IHRoZSBpbmZvcm1hdGlvbiwgdGhlIGVycm9yIGxvZ3MgYXJl
IGFzIGZvbGxvd3M6DQo+ID4NCj4gPnJvb3RAbHMxMDI4YXJkYjp+IyAuL2V0aHRvb2wgLXggZW5v
MA0KPiA+bmV0bGluayBlcnJvcjogT3BlcmF0aW9uIG5vdCBzdXBwb3J0ZWQNCj4gPg0KPiA+VGhl
IHJhdGlvbmFsZSBpcyB0aGF0IGV0aHRvb2wgd2lsbCBpc3N1ZSBhIEVUSFRPT0xfTVNHX0NIQU5O
RUxTX0dFVA0KPiA+bmV0bGluayBtZXNzYWdlIHRvIGdldCB0aGUgbnVtYmVyIG9mIFJ4IHJpbmcu
IEhvd2V2ZXIsIHRoZSBmc2wtZW5ldGMNCj4gPmRyaXZlciBkb2Vzbid0IHN1cHBvcnQgZXRodG9v
bDo6Z2V0X2NoYW5uZWxzLCBzbyBpdCBkaXJlY3RseSByZXR1cm5zIC0NCj4gPkVPUE5PVFNVUFAg
ZXJyb3IuDQo+ID4NCj4gPlsxXToNCj4gPmh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rp
b24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRnVybGRlDQo+ID5mZW5zZS5wcm9vZnBv
aW50LmNvbSUyRnYyJTJGdXJsJTNGdSUzRGh0dHBzLSZkYXRhPTA1JTdDMDElN0N3ZWkuZg0KPiBh
bmclNDANCj4gPm54cC5jb20lN0NjYjI5NTIyYTg4NjM0ZjM5ODgyZDA4ZGJlYjQ4YzZiMCU3QzY4
NmVhMWQzYmMyYjRjNmZhDQo+IDkyY2Q5OWM1Yw0KPiA+MzAxNjM1JTdDMCU3QzAlN0M2MzgzNjI0
NzAwMjY0NTczMzMlN0NVbmtub3duJTdDVFdGcGJHWnNiMw0KPiBkOGV5SldJam9pTUM0DQo+ID53
TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdD
MzAwMCUNCj4gN0MlN0MlN0MNCj4gPiZzZGF0YT1qOGclMkZpbGpqMG1uZWlWRWJSbG4xUXB4RnRC
YnVkbVFEZnpxQnF5ZlA5JTJCWSUzRCZyZXNlcnYNCj4gZWQ9MA0KPiA+M0FfX2dpdC5rZXJuZWwu
b3JnX3B1Yl9zY21fbGludXhfa2VybmVsX2dpdF9qa2lyc2hlcl9ldGh0b29sLmdpdF9jb21taXQN
Cj4gPl8NCj4gPi0zRmlkLQ0KPiA+M0RmZmFiOTljMWYzODIwZTIxZDY1Njg2ZTAzMGRjZjJjNGZk
MGE4YmQwJmQ9RHdJREFnJmM9bktqV2VjMmINCj4gNlIwbU95UGF6DQo+ID43DQo+ID54dGZRJnI9
N3NpM1huOUx5LVNlMWE2NTVrdkVQSVlVMG5ROUhQZU4yODBzRVV2NVJPVSZtPS0NCj4gPjZiVzNG
YUNLYXU3amlvNlhTVVdEWnczSUVxZGV0SXdoVV9CZ2N2ODdRY25qeU1ER0Qwc2xKR1FZRmxiVng3
DQo+IGwmcz04dk1ldg0KPiA+WSBVRXZOa3lDak1ETzI3OGo2N2lyNGRhTXF1azZRSzl3UjY1TlNR
JmU9DQo+ID4NCj4gPlNpZ25lZC1vZmYtYnk6IFdlaSBGYW5nIDx3ZWkuZmFuZ0BueHAuY29tPg0K
PiA+LS0tDQo+ID4gLi4uL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5ldGMvZW5ldGNfZXRodG9v
bC5jICAgIHwgMTMgKysrKysrKysrKysrKw0KPiA+IDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRp
b25zKCspDQo+ID4NCj4gPmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2Nh
bGUvZW5ldGMvZW5ldGNfZXRodG9vbC5jDQo+ID5iL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVz
Y2FsZS9lbmV0Yy9lbmV0Y19ldGh0b29sLmMNCj4gPmluZGV4IGU5OTNlZDA0YWI1Ny4uNWZhMTAw
MGI5YjgzIDEwMDY0NA0KPiA+LS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2Vu
ZXRjL2VuZXRjX2V0aHRvb2wuYw0KPiA+KysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNj
YWxlL2VuZXRjL2VuZXRjX2V0aHRvb2wuYw0KPiA+QEAgLTc0MCw2ICs3NDAsMTcgQEAgc3RhdGlj
IGludCBlbmV0Y19zZXRfcnhmaChzdHJ1Y3QgbmV0X2RldmljZSAqbmRldiwNCj4gPmNvbnN0IHUz
MiAqaW5kaXIsDQo+ID4gCXJldHVybiBlcnI7DQo+ID4gfQ0KPiA+DQo+ID4rc3RhdGljIHZvaWQg
ZW5ldGNfZ2V0X2NoYW5uZWxzKHN0cnVjdCBuZXRfZGV2aWNlICpuZGV2LA0KPiA+KwkJCSAgICAg
ICBzdHJ1Y3QgZXRodG9vbF9jaGFubmVscyAqY2gpIHsNCj4gPisJc3RydWN0IGVuZXRjX25kZXZf
cHJpdiAqcHJpdiA9IG5ldGRldl9wcml2KG5kZXYpOw0KPiA+Kw0KPiA+KwljaC0+bWF4X3J4ID0g
cHJpdi0+bnVtX3J4X3JpbmdzOw0KPiA+KwljaC0+bWF4X3R4ID0gcHJpdi0+bnVtX3R4X3Jpbmdz
Ow0KPiA+KwljaC0+cnhfY291bnQgPSBwcml2LT5udW1fcnhfcmluZ3M7DQo+ID4rCWNoLT50eF9j
b3VudCA9IHByaXYtPm51bV90eF9yaW5nczsNCj4gW1N1bWFuXSBtYXhfcngvdHggYW5kIHJ4L3R4
X2NvdW50IGNhbiBiZSBkaWZmZXJlbnQgcmlnaHQ/IFRvIG1lIGl0IHNlZW1zIGxpa2UNCj4gbWF4
X3J4L3R4IHNob3VsZCByZWFkIHRoZSBtYXggdmFsdWUgbm90IHRoZSBjdXJyZW50IGNvbmZpZ3Vy
ZWQgdmFsdWVzLg0KDQpbV2VpXSBZZXMsIGJ1dCB0aGUgY3VycmVudCBmc2wtZW5ldGMgZHJpdmVy
IGRvZXNuJ3Qgc3VwcG9ydCB0byBkeW5hbWljYWxseSBjb25maWd1cmUgdGhlDQpudW1iZXIgb2Yg
dHgvcnggcmluZ3MsIHNvIGV2ZW4gd2UgaGF2ZSBtb3JlIGF2YWlsYWJsZSByaW5ncyB0aGFuIHBy
aXYtPm51bV9yeF9yaW5ncywNCndlIGNhbiBvbmx5IHRoZSB1c2UgcHJpdi0+bnVtX3J4X3Jpbmdz
IHJpbmdzLiBTbyBJIG1ha2UgdGhlIG1heF9yeCA9IHJ4X2NvdW50Lg0K
