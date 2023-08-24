Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9BB78746E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 17:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242259AbjHXPje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 11:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238726AbjHXPjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:39:12 -0400
Received: from HK2P15301CU002.outbound.protection.outlook.com (mail-eastasiaazon11020019.outbound.protection.outlook.com [52.101.128.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A92CCB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 08:39:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akiIoPCyRU3N61MA02l51sNYGh+sMNxvpO2vrUcw7i5gBiS6SkZ83egsImsjGI6b7oF6CUN6RJWafuHqtUMFUblBTC4exG3uqf+l3HqrT0RYBSk1qjaA3kSsda+g6EN002S/4q9ZRwkDT6QqYk+3xf1YrJmWu3LMgH7CfUO9BHQpbqU5dKZKPAx44Aor9JWZ6J7X05Ba5o4AjE0gd8xStHicpptRtix6nHybrzl0VMAciXtz+PW+/m9cvF+o+w38tX5mTmnkqbR14nAc/lm61DjSNjm3An8JHbd7ltuJfLIDQ/2ieXcEbof3GeY53GtXHuwEGDcUmbj5UAG6kcZkbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjgO6jLPfJh19NcpdB2W1sZ3C+ua6Pkbgg2us23oD3w=;
 b=hIvOUJD3LGr8wr289GTXD/wmSUk4n+nZbSngrBS/YSzrGrkckjjKFvWcrgzrq0KWCoqbYvrlnG4ktAR8DQjdQlFpgXIXksFsUA4I81wuw7/jFVFKR+zHtJnoX/iD0pVoHZv9Za2lJZgbsYDTIA4UTZu4tJ+t9oCh9ok+FQrzOZA69wR83rArQVcoT9z772E3jkTYL3yX0nfPEOIRBHmDHUix+BA2Frido8aH1rIy631iS/zchGMBgoiVHkyoNwGQHpJiAerunuR2L1MS3tRKsej3S6gFh+aRtrVkHREl0NPDHblD4DexwPwkA081R8Ktnuex4isGbapqcvzkuW3gvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjgO6jLPfJh19NcpdB2W1sZ3C+ua6Pkbgg2us23oD3w=;
 b=WHeCoq4lFl5+mSjFmP/wuSwA45KgAtar/5+sp8lcJbpzLpPV9kh8GsdXgZ42Ps/K85oLVGiVtitBoIf7i0uguBEm7WpfBpPXqrz1S2D6YI6XjR2hALpDxil/BcCmf1+572fu+KfpYLs0MDl3PjbzYsvAxk4kCvKnuhudzc9nZGw=
Received: from PUZP153MB0635.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e2::8) by
 KL1P15301MB0498.APCP153.PROD.OUTLOOK.COM (2603:1096:820:57::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.6; Thu, 24 Aug 2023 15:39:05 +0000
Received: from PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
 ([fe80::4153:b8b:7077:5188]) by PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
 ([fe80::4153:b8b:7077:5188%6]) with mapi id 15.20.6745.006; Thu, 24 Aug 2023
 15:39:04 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     Zach O'Keefe <zokeefe@google.com>,
        David Hildenbrand <david@redhat.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Yang Shi <shy828301@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH v3] mm/thp: fix "mm: thp: kill
 __transhuge_page_enabled()"
Thread-Topic: [EXTERNAL] Re: [PATCH v3] mm/thp: fix "mm: thp: kill
 __transhuge_page_enabled()"
Thread-Index: AQHZ1l4o+1bj/0Z0xEGVITWhRquq0a/5eaYAgAABs4CAAAubgIAABfwA
Date:   Thu, 24 Aug 2023 15:39:02 +0000
Message-ID: <PUZP153MB06350A5DC9CCB8448C98E4EEBE1DA@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
References: <20230821234844.699818-1-zokeefe@google.com>
 <37c2b525-5c2c-d400-552c-9ccb91f4d7bf@redhat.com>
 <CAAa6QmSHF6-9aFa68WDcb+WATh2Yz=wXyp8VBLDNv6yPp2SS5Q@mail.gmail.com>
 <3e08d48b-7b70-cc7f-0ec1-12ad9b1a33db@redhat.com>
 <CAAa6QmSNvx7wbZzfhFOyhODTMoBbf6PimnOf2xeAw5NkD1eXVg@mail.gmail.com>
In-Reply-To: <CAAa6QmSNvx7wbZzfhFOyhODTMoBbf6PimnOf2xeAw5NkD1eXVg@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ba88d646-d44a-466e-a825-af1e45ca230d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-24T15:08:28Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0635:EE_|KL1P15301MB0498:EE_
x-ms-office365-filtering-correlation-id: a8c19c9f-d10e-40c9-4332-08dba4b83dce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SEMLSCQ59hSVpkCKx7EgCdp/YgJpjx5PZoBi06oCo/7jaiA25U7bJvGUTaWMKAwICBJGP26B9ClSNVnuv7Hqh6LLzvz/r4WTCoM540s8iy20pglhgcuF9+A61/wxjFtzBDaRLrjuoManLPvqbh7vV//U7ehg0ZRFiAkpdgENF24lZO+BrwMiD5Lencx4rD93rZ1TC9L4sQB7Sa40/bw+Gf7cowDeAlnQaaLO+lcjHG9Q92j7nZdwhi9BgY5hu0hYiEuLcJzMrueypj1Qs+oDyMvp54wjz5RQsUjplM1KoFXYOS4JpHQJTvr26Nf55ByeB0lNod+36/hITX8zivpb9dqpk6mLry0F5ZnyV4Yeduv+3GlQ287HVgNPbJXsOGMk8q5EbGGkf+bSyKp7ZiTjRmtupb9GgqNHZlS98iikO1U2tcvfMViG8F409GhYFFHVz0dUc/LJn8D4l/B1pf5oSAhv0yYcdFkaT3sWlsf44CcsVY6PkPCZqXMpnDB1xoDRLEjzVnlSrGafkm+q2/NVU3GoM2tN+cWa1bot2Nc2nvkhCVITlgnTvvzCMO0JPabnB0b7rW5dliJRBDyFKxaJ3WklG8wM453p4a1QsFqGVsItZQjSube5A8urR7X64DSTc4BCXY2ElRTTI6d+W2a4CfthOSTIWVOO7B6JYZIW7DYfgqtwvWW38kK0FyQLDlFneCJ8ofSTeKoiiIb8oaEhaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0635.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199024)(186009)(1800799009)(52536014)(8676002)(8936002)(4326008)(55016003)(107886003)(9686003)(83380400001)(53546011)(71200400001)(478600001)(10290500003)(86362001)(33656002)(6506007)(7696005)(66946007)(41300700001)(66446008)(66556008)(54906003)(110136005)(64756008)(66476007)(76116006)(316002)(82950400001)(12101799020)(122000001)(82960400001)(2906002)(38070700005)(38100700002)(5660300002)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZXlkdEM0NEpwRHpVVUt0YTRERXcrWllkOHVSbDhENUdZQk9XYkpvcTdyZkdV?=
 =?utf-8?B?VUhqdWpjTVkvckw5RkkrOEJZYjBBRm1Kb0x6ckhWRlltNkU2aDZvQU1xanI1?=
 =?utf-8?B?NWMwRlpkZXl0aDY3YVdFaFpuQ0lHWERGL3JBbVcraEpSRFR1aHdmWVVjdWZK?=
 =?utf-8?B?V1ozTkVPTDArazI5bU5XdWcwQ2R0ZTh0QlphSURZQkxpdFdsWW9pL1hPUmJI?=
 =?utf-8?B?YnEySjE1ZldrT1YvZVhWYTdWSXk1K25wSjNHcWlFRnd4eERtRFk1amNoM3ov?=
 =?utf-8?B?aGtZUXJUYmM1V0NDSWI4alc5RlZzUUtUNnNZTVFNenBqNjNDMzRHY25BTE5O?=
 =?utf-8?B?blJraHc1eW9YMERra2VlakV3UkJ1OS9XQWNXWkhhanJVK2xHd0wvR01tQ3BM?=
 =?utf-8?B?R2tmUnFLVlBuVFJHdVhYWFFxTEtZWVZDYXR4L20xR0xsaU1sSUltWS9MdTU1?=
 =?utf-8?B?d0NFZ0psZEkxditCMEtMeGNLTlRwRnJRTlVwZ2ZZSEFDQ2Q4dGx1UEZrTW9k?=
 =?utf-8?B?VWZieERmaE96bzFzVXFTc2FDM29Dc2NrNnhkUm9zQlpnSE55TGxRRHB3STZ3?=
 =?utf-8?B?cE5RUlcwNFk1bTBZaTBMMVI5Y2w1bzVUNlMwK0x1N1F2Vmt5WS9ROGdKemtE?=
 =?utf-8?B?VS9ZYXUyWVp4OTk0WndnL1VkRmpnRTU2RXJ3SzlIK1JtamxWQkQzbnVxMTF0?=
 =?utf-8?B?eVBPQXhQQUl4clFSZy85ZXA2QzNOSTZGZkhoWGc3dHVQekttMUdoa0hQMGZn?=
 =?utf-8?B?aStzZDZyQzZLZTBmYUhnTXJzZDVHY3AwTWpBZkJMdzA1TFVLY0gxaGMzOGdi?=
 =?utf-8?B?Z2dFcnMxV3RjNTR5bldnSlVubWxwMEE2OGQvNlpZWU1aNTJuNWJ4WURXVnRV?=
 =?utf-8?B?WG9aNjExNFlCM1pGZ1BOT01Ea0k5RXJkNE85cDZjbHhlNnNWVUVXYTQyRG42?=
 =?utf-8?B?VHNSN3VCZTErSTA5NzArRzc2SEhrV2NEakpVZmwvTUNoZXo3N0VmWDNWRmJm?=
 =?utf-8?B?aUNMSlpQcFBmcGlPQ2NLaW1FeVBCc01OQnUxQTZkQ2xlZFNGMnljRWRZRG9N?=
 =?utf-8?B?dzh6YzA5c0RFaWpoU2JNeHlwY29CYzlrcUtDcDZ3S3hmc2dERDRJS3lKWEkz?=
 =?utf-8?B?MnVLQkJlUXZYVStWeWNEUmpYRTJxVDk1Vnc1cHIxL2Z4RVdjbEZNMlp1eUhx?=
 =?utf-8?B?cTBIWWhLeThtL1FIRDZvNXBUQmJWTi95M0wrdTNEVHE5NGRJOHdoODNYSnVi?=
 =?utf-8?B?Wmlmc3JQT3pwcFcyV0s1bEh1bFpPNG5mS0EySnc4TDQ4NUFJVEhndEhqQ1Jk?=
 =?utf-8?B?TWlCems0RTBHTk1zMzJES2F5ZG43ZDZpR1BNMGJYeldMbVJlV2hSSlY5NXQx?=
 =?utf-8?B?KzhUSTJGQWlmNXF6S2pJY2hTVldmSmkwREJKcTlNcGNjR2phdVhUd3N4VnV5?=
 =?utf-8?B?Yk5YeVdqVEZTKzB4WVp2ZmdZRVI3MkMwQk5NUnd4VWozalFCbzhMSlJ3T01y?=
 =?utf-8?B?eG5wc2ttNW9lTjlZeklpcUltaytyNDZmenVHZXFMdVRkNDZuaGRaaDNIV05l?=
 =?utf-8?B?WjB2aW1sRy9PdTMranB5c29ZM0lUenRRM0dKSjNIV29ERm4zdFBHVTBCM283?=
 =?utf-8?B?Ny9iQWUzK3hudlpSWURYZytWc0NRTHlvamptM1dtcWsvUXh6cjFuMGdvQm5m?=
 =?utf-8?B?a0lUdmdyYnkwVllxRVdvYytBK2hDcnFlZEFTbUpmZGdjd0VPNUZ4WmNwOVF2?=
 =?utf-8?B?ek5wSE1UVHdMTEtQWVVxeWc2LzJuWE5GbHBFTGJwdGErbExPTHU1UnZ5WVB6?=
 =?utf-8?B?bVJ1Y3lFOUwzZXF1SkhVVzkrbHNjSEZhQmhYWUJseUlCNUsraFVUTGZNL3c1?=
 =?utf-8?B?Tmg4WVZMdmFKYzJVSWRmVy9nd3RaK01OcHNmL2FwS1pEWEw3NHZWNzBSOHda?=
 =?utf-8?B?ejI3TDZzVmY3cU95a2ZHeVBxTzJlRW5jSVFYeU0zMVlqYmR0V1BJRVo0dzdN?=
 =?utf-8?B?MTVxeGZaWkFtd1dVb0hBdEVpZHVCOWVUWjJhSVpkTlJ3N2xpR295L0R3NVI5?=
 =?utf-8?B?Y1Z0NlBFa3pWcGphQXg0NCt0Tm00TEJ1VVdNM0dWcmlyWXplT001OFBPN3lM?=
 =?utf-8?Q?HRsGaNC66boYubLjfAKSzGbn7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c19c9f-d10e-40c9-4332-08dba4b83dce
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 15:39:02.0448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FXuuNfNKhqjF2QK9LOt/Ie7vEmqdFWVy5IDgu0DdEudEEoYzAj7I94zGM36Kvd3+1pt47MN1wICHKV2dt2jNcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0498
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBUaHUsIEF1ZyAyNCwgMjAyMyBhdCA3OjA14oCvQU0gRGF2aWQgSGlsZGVuYnJhbmQgPGRh
dmlkQHJlZGhhdC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gT24gMjQuMDguMjMgMTU6NTksIFph
Y2ggTydLZWVmZSB3cm90ZToNCj4gPiA+IE9uIFRodSwgQXVnIDI0LCAyMDIzIGF0IDEyOjM54oCv
QU0gRGF2aWQgSGlsZGVuYnJhbmQNCj4gPGRhdmlkQHJlZGhhdC5jb20+IHdyb3RlOg0KPiA+ID4+
DQo+ID4gPj4gT24gMjIuMDguMjMgMDE6NDgsIFphY2ggTydLZWVmZSB3cm90ZToNCj4gPiA+Pj4g
VGhlIDYuMCBjb21taXRzOg0KPiA+ID4+Pg0KPiA+ID4+PiBjb21taXQgOWZlYzUxNjg5ZmY2ICgi
bW06IHRocDoga2lsbA0KPiA+ID4+PiB0cmFuc3BhcmVudF9odWdlcGFnZV9hY3RpdmUoKSIpIGNv
bW1pdCA3ZGE0ZTJjYjhiMWYgKCJtbTogdGhwOg0KPiA+ID4+PiBraWxsIF9fdHJhbnNodWdlX3Bh
Z2VfZW5hYmxlZCgpIikNCj4gPiA+Pj4NCj4gPiA+Pj4gbWVyZ2VkICJjYW4gd2UgaGF2ZSBUSFBz
IGluIHRoaXMgVk1BPyIgbG9naWMgdGhhdCB3YXMgcHJldmlvdXNseQ0KPiA+ID4+PiBkb25lIHNl
cGFyYXRlbHkgYnkgZmF1bHQtcGF0aCwga2h1Z2VwYWdlZCwgYW5kIHNtYXBzICJUSFBlbGlnaWJs
ZSINCj4gY2hlY2tzLg0KPiA+ID4+Pg0KPiA+ID4+PiBEdXJpbmcgdGhlIHByb2Nlc3MsIHRoZSBz
ZW1hbnRpY3Mgb2YgdGhlIGZhdWx0IHBhdGggY2hlY2sgY2hhbmdlZA0KPiA+ID4+PiBpbiB0d28N
Cj4gPiA+Pj4gd2F5czoNCj4gPiA+Pj4NCj4gPiA+Pj4gMSkgQSBWTV9OT19LSFVHRVBBR0VEIGNo
ZWNrIHdhcyBpbnRyb2R1Y2VkIChhbHNvIGFkZGVkIHRvIHNtYXBzDQo+IHBhdGgpLg0KPiA+ID4+
PiAyKSBXZSBubyBsb25nZXIgY2hlY2tlZCBpZiBub24tYW5vbnltb3VzIG1lbW9yeSBoYWQgYSB2
bV9vcHMtDQo+ID5odWdlX2ZhdWx0DQo+ID4gPj4+ICAgICAgaGFuZGxlciB0aGF0IGNvdWxkIHNh
dGlzZnkgdGhlIGZhdWx0LiAgUHJldmlvdXNseSwgdGhpcyBjaGVjayBoYWQgYmVlbg0KPiA+ID4+
PiAgICAgIGRvbmUgaW4gY3JlYXRlX2h1Z2VfcHVkKCkgYW5kIGNyZWF0ZV9odWdlX3BtZCgpIHJv
dXRpbmVzLCBidXQNCj4gYWZ0ZXINCj4gPiA+Pj4gICAgICB0aGUgY2hhbmdlcywgd2UgbmV2ZXIg
cmVhY2ggdGhvc2Ugcm91dGluZXMuDQo+ID4gPj4+DQo+ID4gPj4+IER1cmluZyB0aGUgcmV2aWV3
IG9mIHRoZSBhYm92ZSBjb21taXRzLCBpdCB3YXMgZGV0ZXJtaW5lZCB0aGF0DQo+ID4gPj4+IGlu
LXRyZWUgdXNlcnMgd2VyZW4ndCBhZmZlY3RlZCBieSB0aGUgY2hhbmdlOyBtb3N0IG5vdGFibHks
IHNpbmNlDQo+ID4gPj4+IHRoZSBvbmx5IHJlbGV2YW50IHVzZXIgKGluIHRlcm1zIG9mIFRIUCkg
b2YgVk1fTUlYRURNQVAgb3INCj4gPiA+Pj4gLT5odWdlX2ZhdWx0IGlzIERBWCwgd2hpY2ggaXMg
ZXhwbGljaXRseSBhcHByb3ZlZCBlYXJseSBpbg0KPiA+ID4+PiBhcHByb3ZhbCBsb2dpYy4gIEhv
d2V2ZXIsIHRoZXJlIGlzIGF0IGxlYXN0IG9uZSBvY2N1cnJlbmNlIHdoZXJlDQo+ID4gPj4+IGFu
IG91dC1vZi10cmVlIGRyaXZlciB0aGF0IHVzZWQgVk1fSFVHRVBBR0V8Vk1fTUlYRURNQVAgd2l0
aCBhDQo+IHZtX29wcy0+aHVnZV9mYXVsdCBoYW5kbGVyLCB3YXMgYnJva2VuLg0KPiA+ID4+DQo+
ID4gPj4gLi4uIHNvIGFsbCB3ZSBkaWQgaXMgYnJlYWsgYW4gYXJiaXRyYXJ5IG91dC1vZi10cmVl
IGRyaXZlcj8gU29ycnkNCj4gPiA+PiB0byBzYXksIGJ1dCB3aHkgc2hvdWxkIHdlIGNhcmU/DQo+
ID4gPj4NCj4gPiA+PiBJcyB0aGVyZSBhbnkgaW4tdHJlZSBjb2RlIGFmZmVjdGVkIGFuZCBuZWVk
cyBhICJGaXhlczoiID8NCj4gPiA+DQo+ID4gPiBUaGUgaW4tdHJlZSBjb2RlIHdhcyB0YWtlbiBj
YXJlIG9mIGR1cmluZyB0aGUgcmV3b3JrIC4uIGJ1dCBJIGRpZG4ndA0KPiA+ID4ga25vdyBhYm91
dCB0aGUgcG9zc2liaWxpdHkgb2YgYSBkcml2ZXIgaG9va2luZyBpbiBoZXJlLg0KPiA+DQo+ID4g
QW5kIHRoYXQncyB0aGUgcHJvYmxlbSBvZiB0aGUgZHJpdmVyLCBubz8gSXQncyBub3QgdGhlIGpv
YiBvZiB0aGUNCj4gPiBrZXJuZWwgZGV2ZWxvcGVycyB0byBiZSBhd2FyZSBvZiBlYWNoIG91dC1v
Zi10cmVlIGRyaXZlciB0byBub3QNCj4gPiBhY2NpZGVudGFsbHkgYnJlYWsgc29tZXRoaW5nIGlu
IHRoZXJlLg0KPiA+DQo+ID4gPg0KPiA+ID4gSSBkb24ndCBrbm93IHdoYXQgdGhlIG5vcm1hbCBw
b2xpY3kgLyBzdGFuY2UgaGVyZSBpcywgYnV0IEkgZmlndXJlZA0KPiA+ID4gdGhlIGNoYW5nZSB3
YXMgc2ltcGxlIGVub3VnaCB0aGF0IGl0IHdhcyB3b3J0aCBoZWxwaW5nIG91dC4NCj4gPg0KPiA+
IElmIHlvdSBkZWNpZGUgdG8gYmUgb3V0LW9mLXRyZWUsIHRoZW4geW91IGhhdmUgYmUgcHJlcGFy
ZWQgdG8gb25seQ0KPiA+IHN1cHBvcnQgdGVzdGVkIGtlcm5lbHMgYW5kIGZpeCB5b3VyIGRyaXZl
ciB3aGVuIHNvbWV0aGluZyBjaGFuZ2VzDQo+ID4gdXBzdHJlYW0gLS0gbGlrZSB1cHN0cmVhbSBk
ZXZlbG9wZXJzIHdvdWxkIGRvIGZvciB5b3Ugd2hlbiBpdCB3b3VsZCBiZQ0KPiA+IGluLXRyZWUu
DQo+ID4NCj4gPiBTbyB3aHkgY2FuJ3QgdGhlIG91dC1vZi10cmVlIGRyaXZlciBiZSBmaXhlZCwg
c2ltaWxhcmx5IHRvIGhvdyB3ZQ0KPiA+IHdvdWxkIGhhdmUgZml4ZWQgaXQgaWYgaXQgd291bGQg
YmUgaW4tdHJlZT8NCj4gDQo+IEkgZG9uJ3Qga25vdyBtdWNoIGFib3V0IGRyaXZlciBkZXZlbG9w
bWVudCwgYnV0IHBlcmhhcHMgdGhleSBhcmUgLyBuZWVkIHRvDQo+IHVzZSBhIHByaXN0aW5lIHVw
c3RyZWFtIGtlcm5lbCwgd2l0aCB0aGVpciBkcml2ZXIgYXMgYSBsb2FkYWJsZSBrZXJuZWwgbW9k
dWxlLg0KPiBTYXVyYWJoIGNhbiBjb21tZW50IG9uIHRoaXMsIEkgZG9uJ3Qga25vdy4NCg0KWW91
IGFyZSBjb3JyZWN0IFphY2guIFRoZSAib3V0LW9mLXRyZWUiIGRyaXZlciBoYWQgYmVlbiBzZWFt
bGVzc2x5IG9wZXJhdGlvbmFsDQpvbiB2ZXJzaW9uIDUuMTksIGxldmVyYWdpbmcgdGhlIGtlcm5l
bCdzIGNhcGFiaWxpdHkgdG8gaGFuZGxlIGh1Z2UgZmF1bHRzIGZvcg0Kbm9uLWFub255bW91cyB2
bWEuIEhvd2V2ZXIsIHRoZSB0cmFuc2l0aW9uIHRvIGtlcm5lbCB2ZXJzaW9uIDYuMSBpbmFkdmVy
dGVudGx5DQpsZWQgdG8gdGhlIHJlbW92YWwgb2YgdGhpcyBmZWF0dXJlLiBJdCdzIGltcG9ydGFu
dCB0byBub3RlIHRoYXQgdGhpcyByZW1vdmFsIHdhc24ndA0KaW50ZW50aW9uYWwsIGFuZCBJIGFt
IG9wdGltaXN0aWMgYWJvdXQgdGhlIHBvdGVudGlhbCByZXN0b3JhdGlvbiBvZiB0aGlzIGZlYXR1
cmUuDQoNCkhlbGxvIERhdmlkLA0KDQpHaXZlbiB0aGUgY29udGV4dCwgSSBhbSBjdXJyZW50bHkg
ZXhwbG9yaW5nIHBvdGVudGlhbCB3YXlzIHRvIGFkZHJlc3MgdGhlIGlzc3VlDQp3aXRoIHRoZSAi
b3V0LW9mLXRyZWUiIGRyaXZlci4gSSBoYXZlIHJlY29nbml6ZWQgYSBjaGFsbGVuZ2UgcG9zZWQg
YnkgdGhlIGtlcm5lbCdzDQptZW1vcnkgbWFuYWdlbWVudCBmcmFtZXdvcmssIHdoaWNoIG5vdyBp
bXBvc2VzIHJlc3RyaWN0aW9ucyBvbiBodWdlIGZhdWx0cw0KZm9yIG5vbi1hbm9ueW1vdXMgdm1h
LiBNeSBpbmNsaW5hdGlvbiB0byBjb250cmlidXRlIHRoaXMgZHJpdmVyIHRvIHRoZSBtYWlubGlu
ZQ0Ka2VybmVsIHJlbWFpbnMgc3Ryb25nLiBJZiB0aGVyZSdzIGEgcG9zc2liaWxpdHkgb2YgZW5n
YWdpbmcgaW4gZGlzY3Vzc2lvbnMgb3INCmNvbGxhYm9yYXRpdmUgZWZmb3J0cyB0byBhbGlnbiB0
aGlzIGRyaXZlciB3aXRoIHRoZSBwcmVzZW50IGZyYW1ld29yaywgSSdtIGZ1bGx5DQpjb21taXR0
ZWQgdG8gdGhlIHByb2Nlc3MuIFlvdXIgc3VnZ2VzdGlvbnMgd291bGQgYmUgZ3JlYXRseSBhcHBy
ZWNpYXRlZCwgYXMgSQ0KYW0gZWFnZXIgdG8gZW5zdXJlIHRoZSBjb21wYXRpYmlsaXR5IG9mIHRo
ZSAib3V0LW9mLXRyZWUiIGRyaXZlciB3aXRoIHRoZSBrZXJuZWwncw0KZXZvbHZpbmcgZnJhbWV3
b3JrLg0KDQotIFNhdXJhYmgNCg0KPiANCj4gQnV0IHlvdXIgcG9pbnQgaXMgdmVyeSB2YWxpZCBv
dGhlcndpc2UuDQo+IA0KPiANCj4gPiAtLQ0KPiA+IENoZWVycywNCj4gPg0KPiA+IERhdmlkIC8g
ZGhpbGRlbmINCj4gPg0K
