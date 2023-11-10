Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5726C7E8570
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 23:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjKJWSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 17:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjKJWSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 17:18:15 -0500
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11012010.outbound.protection.outlook.com [40.93.200.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A11448C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 14:18:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TaEBsEkRG91AH7ELZvrig67xq8bsflW29J1Y71cWBvHNpVJsvZNISwxa6tpCXOVbwfABcBP1yVttZD9C2ThfdkG+qZFJyTydn7RmSgpa3Ttg23i4n0k71VfEilIn0/CoQHkCtP2kKbFyYa3c2pRDxWtc+nePkTHKl1NrEVkg1qXAEuQrgXFmVZ9CCG6uwSaVrXeyPtCgBBTtLE0Zei1oc0q5FYIQYg7XuyVYA9al99hKuZY98jSmXD7zz4Tha2EjfpIzLzmJMtI4AAg8WVrP8PPy42ciJzBdvJlr1ArhMbO94ClhQdWGZa7EnkhTNhUV3GDXZpxt/E5mNI68fJmqwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46gzcnoSyZADUcHbUqt0fnn3IQqLE5FE1WtQtQW6Sdg=;
 b=g0xqJ/PMsUOMR+KILCOyzYmEGTkhe2ZZ5afrlNTuYRKWCl1n3giYtHLqD1r6vZ/bdvGIiW9ap72OEKo0ziEHfA2arRAZAARls5AcsPQQRQjcVhMEWl5QuDsKrfHt3CC1XnS3Hoav++wEgqZ0caI5RtaQ2xjNuAL4vMPnwtjk4rTfuFzoLgyTNIc8V8QJ79vFTnqNRCCGwcl0iXydWROYaz2ijbbP3wjSWRWewmCBgFcwg/HLhr4/V3GwUneUG6OvBEsle5akSFlLCT7rjahSwre70PTZ4PR7q1wzH2stYAK/vvJ7ZUsHp0fbASDgw/qpk5KmVEC3m6zWxYpAgd1Tzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46gzcnoSyZADUcHbUqt0fnn3IQqLE5FE1WtQtQW6Sdg=;
 b=fd+rR8RRj3E8uQafknPRjtjj6gz9PN/HbOxeOQhlZwZWMm79tqc/7i6TsjlmQ3cgQZAGqx8lYgKOO9G9Xar6v1HubofxFWlMO1ozFzpwI/HS0Cmw6IcU8kzQ9JvW6Ag1ptr7GqWKD63049O0DA34yFw8IO5QA66MfdXmMKbI+p4=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by SA0PR05MB7260.namprd05.prod.outlook.com (2603:10b6:806:c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Fri, 10 Nov
 2023 22:18:08 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e6fc:9264:2535:6ce2]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e6fc:9264:2535:6ce2%7]) with mapi id 15.20.6977.020; Fri, 10 Nov 2023
 22:18:08 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Byungchul Park <byungchul@sk.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "kernel_team@skhynix.com" <kernel_team@skhynix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "xhao@linux.alibaba.com" <xhao@linux.alibaba.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "hughd@google.com" <hughd@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "david@redhat.com" <david@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [v3 2/3] mm: Defer TLB flush by keeping both src and dst folios
 at migration
Thread-Topic: [v3 2/3] mm: Defer TLB flush by keeping both src and dst folios
 at migration
Thread-Index: AQHaCwJWAIN/MoWKfkqwslHpJdh5ILBiSanQgA2TzACAAu+c9oAAJMCAgAE7nQA=
Date:   Fri, 10 Nov 2023 22:18:06 +0000
Message-ID: <0EC1ED50-2370-4EA6-9A02-D36E1913224E@vmware.com>
References: <20231030072540.38631-1-byungchul@sk.com>
 <20231030072540.38631-3-byungchul@sk.com>
 <63C530D3-3A1D-4BE9-8AA7-EFF5B895BE80@vmware.com>
 <20231030125129.GD81877@system.software.com>
 <20231108041208.GA40954@system.software.com>
 <C47A7C40-BE3E-4F0F-B854-D40D4795A236@vmware.com>
 <20231110010201.GA72073@system.software.com>
 <20231110031347.GA62514@system.software.com>
In-Reply-To: <20231110031347.GA62514@system.software.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|SA0PR05MB7260:EE_
x-ms-office365-filtering-correlation-id: 59c1eb63-f2ee-4152-a9d4-08dbe23aeaf2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K+H1nc9DHTUS/GbR43y9v1WjOeDxZ0Pg3c39hFAdLJ0JMOwqSYEz+GO6Zhno+G9MrUW6Q4uHUVq4Y2gU1JIgKOW+HoB6H417tLYxqFkCEZWmA18VcD9TGJMQQYJPsN9rKs2IBTio3C6NdpTOX460mSaE6rPyUyyNkFy8qSckfD4lieJGf09P2upqhQItCHwoRCCFURDijXXST9mVE3pVfWlbh4dZ+2lecoTqNXfK4QlgrN+bWgcrXIhLwH2gtK7XhHnZ8+A8my+9lMU4fF+w1xSx+Sgh97FZwb+lVsPbqAI7DHYmRHyDQR5KMDUPIfIA0Xf83mZvCAfoSP8Yy/ULpCmNpZdfWL8Q30x7gkHjxvbn92fes65HwShPV2cBeeI6/UNuZbnZiAL/73ISSOLIHRpbBGhzwTE3FPDSWk4WdefpezatqiwzIv/KMIKe5szuvejZtD++/8I5I+ilp1yqczKS80dBnAo9airsfVErok4pY/RvLYuCe3Ibp/eYFYQMxBEcYAyygGaJQxhO7z/r66rm2BaDhLbDlerNTDLXv9rCbP9noW0p3HGn/04LuSluhKMA7TUGt2YRSk7cHKON0ISHYAJKpT0KdpU5cGSc6bGYFDCEL0GJi2UKzhH7e09MzDWMDYSe/Yx0z6glgzL+X4Q0qMH19sbvphih0ybAIBp4yCLBJrlqIMIpboESBoca
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(376002)(136003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66476007)(66899024)(36756003)(38070700009)(33656002)(53546011)(71200400001)(6506007)(41300700001)(4326008)(5660300002)(6512007)(8936002)(8676002)(6486002)(316002)(54906003)(7416002)(2906002)(2616005)(64756008)(66446008)(6916009)(83380400001)(66556008)(26005)(478600001)(122000001)(66946007)(91956017)(86362001)(38100700002)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmtZZkFjMHIzeVF4TldacnMrVWgra3pmOWN2T3Z0YUxsa3RjdHBOOUlGSC9y?=
 =?utf-8?B?Y2ZwM0ZxUEFzdkYzUTRSRStpM241Y0h2Z0lscDFnYTRiQlNvT0hLZlg4bkEr?=
 =?utf-8?B?enB0ajJxRWhtQ0JZaHhjbFJwK0VJUDdIallDL016WE1FdFpwTXA0UUtHMDls?=
 =?utf-8?B?Ym1mcjZ1ZTJ3RE1idUxPZFdaYWVId0J2elRxang0dEdVOTVsOTFpWlNnTk1v?=
 =?utf-8?B?ZjBtZm1WZkJZZSs4cUNRQVNEN1VMdVY2cG82ZktzbTYweTkrNWJqWGo5NGlw?=
 =?utf-8?B?MWhmQ1gyZ0xtRUhkNDRwRHZwYkZrOGxFcUMwLzZXd1ZjV1cyRzh1bXowSUhk?=
 =?utf-8?B?cTdHTHFGRDZ4TXlIWW5SNG9CdkdRa2ltQlBCYmdIVk5aWVZpSzFRdnFBNHVw?=
 =?utf-8?B?MmJJODg0bHJGcTRMZmdySDNOTmdVTUd3WWJLVVdram51dGZ5NWNRUXZ6VDFh?=
 =?utf-8?B?eTJsSWc5emFLc0NzNEhvOTlwUlhnRXRGRS9xeVViUTJkbU5ibVZZNnlram1D?=
 =?utf-8?B?VGpQREpkRmxqZWNnODVYcmVSRUxZRVlzdzY3M1pqT0RVT2ZCUDBRdk1tVVk2?=
 =?utf-8?B?eVZNYUVQVTV6bUdKdnM3RjdYOHJIck9PSzJja1owUUllMGhEeVVsMFdzalU5?=
 =?utf-8?B?ZGxWc1hqYm9rTHBuRUNjQ2kwZVZ4YVEraHVwblNPS2tDVHA0RGVhWk5pS2Ux?=
 =?utf-8?B?VGoydUNXcEo3TFVVbzUwK3F1MlFYVVpsTG1GQkhkYzY3L3UyTnRtejVvOU9L?=
 =?utf-8?B?blp6akQ2eUhJUlVZNVFCTituU013QjZINVp4a2FuRFhNNWZpY0JleDYrVFc5?=
 =?utf-8?B?QTh1OEl1VHJBMzZKL1JXTFMzZm95Ri8vRnpONVRldkpMd2w0b1ZTaFhsb21Q?=
 =?utf-8?B?WWJIamRrR1FGRHZqV1VPQzZjbnd1Z0NkNWk4aE1Vd0VjenQ2Ti9SQzZVVC81?=
 =?utf-8?B?WjZsRXFNRGV0NmE3dGxmMWlQVkcwWTlubGJPTTNpZXR6ZnZRcE4xczBLaTVq?=
 =?utf-8?B?SkhxKzErYWJxVW1ZeE93NXZzZDhSZlowbzJreFEwdVhMUFF4cCtyK3VOdStS?=
 =?utf-8?B?K1lMVDlVRnNxNUNtMy81NG9wQlQ3cHZ0dStZb2U4VXVReXYrdFd3ejZjWSs5?=
 =?utf-8?B?UkkrMkNhMW44eGl0UzV6UnRwM0cyV0F3WTA0ak1nNXRCbzlvVkNMa1lPM1di?=
 =?utf-8?B?bHdQNlMzSStBV3puODdzbGdhN05UZXQ5d2Q0NEdOUXJ0aXVJQXZKNmxBWDMw?=
 =?utf-8?B?bDNRa1FMVUZlRHJzTmlWYm1QRUhlZkhQREc2TlFaVG1mbC9OR0xOajUzdGJl?=
 =?utf-8?B?cVZlckF3SHllT01WZkpJWE5YcFFEcm96bFVHOEpIZ2E4ai96Q1VqUkZucEwr?=
 =?utf-8?B?N1lVTXFZek1JUWpXNndGY1J0d3NkdHQ3L3preXF2RUwvdUIyOURmOGExL3lY?=
 =?utf-8?B?dGVNYlFBVzZJTGphc1k4VW1kWnI2SExnR3g5UU5EZmlzdlFMbEc2NER0bmEv?=
 =?utf-8?B?M29jdjNTTXBxYitLZVJyY2lGbmxMUWZjVkdsZ0xuNnVCdXFmT0dhcll2Tnlj?=
 =?utf-8?B?emN6SUdzKzQxOXJaZUxYT2VJS0I1cXI3dHFRWW9yTzBNS1F2dDFNUEVUNW45?=
 =?utf-8?B?Sm45UHc4ZmVkWTRudWVEbGVMRlAwMENNWWNUSFBZVm5TRHBRTFV0YUhKRnE2?=
 =?utf-8?B?L2Z3ZGlGNEtEV09JZ2VHeElMcmZJckRnajYyZVVhL1FtK0R3TzNDcGtBMGJl?=
 =?utf-8?B?ZUJIb2ZMdUpnVURTNlFrODQ0RDhqdXh5d1NhRTRvcDBsT0dGTExuSitSZkZq?=
 =?utf-8?B?cWVocDlsT2V0TFkvZlhpWmdLSkhlSnlPSVVzZzBGdkhEeUx6NEhrdzdESkM2?=
 =?utf-8?B?bUNsNkNqSFJoL0VlcjFXcWlGVjF2Z2l4M2NtSm5mc1pyK0kvZTdhZzVTc1pt?=
 =?utf-8?B?Q1AvdTNtSno4NkpsSXY4ckFmZjkyOU1GN0s0QTFFUlFHWllUZW83dHI5WndK?=
 =?utf-8?B?OUtScllacU1EeVNXOFBnQkdRKytEWmdXbWxMT0VIWWl1cTloSUs2TlJxcFpi?=
 =?utf-8?B?SUhDblEvazlIc2FZZ2pMbjltQjhtdE1ZbmZobEVjZWdPYUlQcUpkbDlHQzQ3?=
 =?utf-8?Q?ROfD9a3DTWdmBF12sUFw0CMXK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <95781DA79654DB4CB3386073E14CAFB0@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c1eb63-f2ee-4152-a9d4-08dbe23aeaf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 22:18:06.9079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cX7MaeYCU4RwqyT10HqCrkjqshVT9WKt2BDJDPEvF/9tWalKDyoM/dwChilrES/NXzuEUpE+o4YffoUMn6k/GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR05MB7260
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTm92IDEwLCAyMDIzLCBhdCA1OjEzIEFNLCBCeXVuZ2NodWwgUGFyayA8Ynl1bmdj
aHVsQHNrLmNvbT4gd3JvdGU6DQo+IA0KPiANCj4+IEhlcmUsDQo+PiANCj4+IG1wcm90ZWN0KCkN
Cj4+ICAgZG9fbXByb3RlY3RfcGtleSgpDQo+PiAgICAgIHRsYl9maW5pc2hfbW11KCkNCj4+ICAg
ICAgICAgdGxiX2ZsdXNoX21tdSgpDQo+PiANCj4+IEkgdGhvdWdodCBUTEIgZmx1c2ggZm9yIG1w
cm90ZWN0KCkgaXMgcGVyZm9ybWVkIGJ5IHRsYl9mbHVzaF9tbXUoKSBzbw0KPj4gYW55IGNhY2hl
ZCBUTEIgZW50cmllcyBvbiBvdGhlciBDUFVzIGNhbiBoYXZlIGNoYW5jZSB0byB1cGRhdGUuIENv
dWxkDQo+PiB5b3UgY29ycmVjdCBtZSBpZiBJIGdldCBpdCB3cm9uZz8gVGhhbmtzLg0KPiANCj4g
SSBndWVzcyB5b3UgdHJpZWQgdG8gaW5mb3JtIG1lIHRoYXQgeDg2IG1tdSBhdXRvbWF0aWNhbGx5
IGtlZXBzIHRoZQ0KPiBjb25zaXN0YW5jeSBiYXNlZCBvbiBjYWNoZWQgVExCIGVudHJpZXMuIFJp
Z2h0PyBJZiB5ZXMsIEkgc2hvdWxkIGRvDQo+IHNvbWV0aGluZyBvbiB0aGF0IHBhdGguIElmIG5v
dCwgaXQncyBub3QgcHJvYmxlbWF0aWMuIFRob3VnaHRzPw0KDQpQZXJoYXBzIEkgbG9zdCBzb21l
dGhpbmcgaW4gdGhpcyB3aG9sZSBzY2hlbWUuIE92ZXJhbGwsIEkgZmluZCBpdCBvdmVybHkNCmNv
bXBsaWNhdGVkIGFuZCBzb21ld2hhdCBoYXJkIHRvIGZvbGxvdy4NCg0KSWRlYWxseSwgYSBzb2x1
dGlvbiBzaG91bGQgcmVkdWNlIHRoZSBudW1iZXIgb2YgVExCIGZsdXNoaW5nIG1lY2hhbmlzbXMN
CmFuZCBub3QgaW50cm9kdWNlIHlldCBhbm90aGVyIG9uZSB0aGF0IHdvdWxkIGZ1cnRoZXIgaW5j
cmVhc2UgdGhlIGFscmVhZHkNCmhpZ2ggY29tcGxleGl0eS4NCg0KQW55aG93LCBJIGEgYml0IGNv
bnZvbHV0ZWQgMiBzY2VuYXJpb3MsIGFuZCBJ4oCZbSBub3Qgc3VyZSB3aGV0aGVyIHRoZXkNCmFy
ZSBhIHBvdGVudGlhbCBwcm9ibGVtLg0KDQooMSkgQXNzdW1lIHRoZXJlIGlzIGEgUk8gcGFnZSBt
aWdyYXRpb24gYW5kIHlvdSBza2lwcGVkIGEgVExCIGZsdXNoLg0KVGhlbiB5b3Ugc2V0IGEgUk8g
UFRFIGVudHJ5IGZvciB0aGF0IHBhZ2UuIEFmdGVyd2FyZHMsIHlvdSBoYXZlIG1wcm90ZWN0KCkN
CnRoYXQgdXBkYXRlcyB0aGUgUFRFIGZvciB0aGF0IHBhZ2UgdG8gYmUgUlcuDQoNCk5vdywgdGxi
X2ZpbmlzaF9tbXUoKSB3aWxsIGRvIGEgVExCIGZsdXNoIGV2ZW50dWFsbHkgaW4gdGhlIG1wcm90
ZWN0KCkNCmZsb3csIGJ1dCB1bnRpbCBpdCBpcyBkb25lLCB5b3UgbWlnaHQgaGF2ZSBvbmUgQ1BV
IGhhdmUgUk8gcG9pbnRpbmcgdG8NCnRoZSBzb3VyY2UgcGFnZSAobm8gVExCIGZsdXNoLCByaWdo
dD8pIGFuZCBhbm90aGVyIGhhdmluZyBSVyBhY2Nlc3MNCnRoYXQgd2VyZSBsb2FkZWQgZnJvbSB0
aGUgdXBkYXRlZCBQVEUuIERpZCBJIG1pc3MgYSBUTEIgZmx1c2ggdGhhdA0Kc2hvdWxkIHRha2Ug
cGxhY2UgYmVmb3JlaGFuZD8NCg0KDQooMikgSW5kZWVkIHdlIGVuY291bnRlcmVkIG1hbnkgcHJv
YmxlbXMgd2hlbiBUTEIgZmx1c2hpbmcgZGVjaXNpb25zDQphcmUgYmFzZWQgb24gUFRFcyB0aGF0
IGFyZSByZWFkIGZyb20gdGhlIHBhZ2UtdGFibGVzIGFuZCB0aG9zZSBkbw0Kbm90IHJlZmxlY3Qg
dGhlIHZhbHVlcyB0aGF0IGFyZSBoZWxkIGluIHRoZSBUTEJzLg0KDQoNCk92ZXJhbGwsIEkgdGhp
bmsgdGhhdCBhIHNvbHV0aW9uIGlzIHRvIGNvbnNvbGlkYXRlIHRoZSBUTEIgYmF0Y2hpbmcNCm1l
Y2hhbmlzbXMgYW5kIGhvbGQgcGVyIGEgZ3JvdXAgb2YgUFRFcyAoZS5nLiwgNTEyIFBURXMgaGVs
ZCBpbiBvbmUNCnBhZ2UtdGFibGUpIHRoZSBkZWZlcnJlZCBUTEIgZmx1c2ggZ2VuZXJhdGlvbi4g
VHJhY2sgdGhlIOKAnGRvbmXigJ0gVExCDQpmbHVzaCBnZW5lcmF0aW9uLCBpZiB0aGUgZGVmZXJy
ZWQgaXMgZ3JlYXRlciB0aGFuIHRoZSDigJxkb25l4oCdLCBwZXJmb3JtDQphIFRMQiBmbHVzaC4N
Cg0KVGhpcyBzY2hlbWUgaXMgYSBiaXQgc2ltaWxhciB0byB3aGF0IHlvdSB3ZXJlIGRvaW5nLCBi
dXQgbW9yZSBnZW5lcmFsLA0KYW5kIGVhc2llciB0byBmb2xsb3cuIEkgdGhpbmsgdGhhdCBpdHMg
dmFsdWUgbWlnaHQgYmUgbW9yZSBpbiBzaW1wbGlmeWluZw0KdGhlIGNvZGUgYW5kIHJlYXNvbmlu
ZyB0aGFuIGp1c3QgcGVyZm9ybWFuY2UuDQoNCklJUkMsIGl0IGtpbmQgb2YgcmVtaW5kcyB0aGUg
RnJlZUJTRCBkZWZlcnJlZCBUTEIgZmx1c2hpbmcgc2NoZW1lLg0KDQo=
