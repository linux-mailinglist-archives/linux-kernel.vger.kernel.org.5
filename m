Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC1E78829E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 10:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243128AbjHYIsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 04:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243078AbjHYIrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 04:47:40 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B78119A9;
        Fri, 25 Aug 2023 01:47:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJvKacoRFvU04eBNHpDJ9j8xPAAzSxPTkmBFUhAgCDrEL5KC8A4zhRuiJ0cj5oFCkqaXnulz17+ubhrNrJ20Ol2wgx419FmHGVbGknOJVzHvB7Haiw2mzsJCfW3GUk5DlR17PMkMmBdwOIklA0SIjwNkbYKHQA2sl3jmkqQ6oy8jj3V8Ce4tT0FLL2kmM+/+FH603Uyixc7tiYkRQA/UBAshfhsDAyPNDFgWmDLTcdWU1DynJl2T/5aKab/zDSriihicSP5+Gt+Y6lw5dfpjxKObAHsK8pRsJTXMcH5MKrYtdKpH6oijCpdVwQ6XMjBxWK40sLFH5lWwi1JnBE4UEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FrMrpIPnXngfHrJ+kxoO6GTNSlrgv5c5W23rk2nBX5M=;
 b=Mjzy2Piur7hVPQcr/p4cWW3ObYPW5edKlc6yrZzDv8ZVbRPfuBuMGWkKmuZoScV/pymfP/MDkCmGhsR17BnWetyUAoOB05ZSskn8E1tM0d+LC09Br1Yp6qQYVe5aoUXEqGW+0voFLAzug/oOpFU0/ogUMd3SHgW+E+ov+Awcir215D6y70HD6FFCTz0Id9r8E9i2jvX/WhjgrLs6sCCLV3pSfEO0Oibofj0dDrjeB5bdGmH+Wv8TZLRXexu67lFuPTGrCQEyK8guW752v5dhw6jX5Wk98f4wwCuV2SRRpATgXDv28mw+K1RXXQb3z4TNP7C+cc8+2Xnb3oAOSXwWsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrMrpIPnXngfHrJ+kxoO6GTNSlrgv5c5W23rk2nBX5M=;
 b=GG3APmlr752GjymBD7VAMwU/fIxT8NJu7ZfUTEHCU7hWjJRyMsor9vVbCHx65VWMnKDxmf/b4Wmx7uY60jihT2akzQanGet6AZqgXmEKBGzid4ih9Hs9xvOShYVeajOdrn9fZ1uzT1DfVJac/15bsrfFMsW4yEppMu39IUZCf8w=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DS7PR12MB8371.namprd12.prod.outlook.com (2603:10b6:8:e9::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.27; Fri, 25 Aug 2023 08:47:32 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::56a5:d451:bf62:2b06]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::56a5:d451:bf62:2b06%7]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 08:47:31 +0000
From:   "Quan, Evan" <Evan.Quan@amd.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
        "horms@kernel.org" <horms@kernel.org>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: RE: [V9 4/9] wifi: mac80211: Add support for WBRF features
Thread-Topic: [V9 4/9] wifi: mac80211: Add support for WBRF features
Thread-Index: AQHZ0YP/B13SPusbBkCb6GFrMZwmdq/0hSCAgAY4ZXA=
Date:   Fri, 25 Aug 2023 08:47:31 +0000
Message-ID: <DM6PR12MB2619D03B8199D5943B724DB6E4E3A@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230818032619.3341234-1-evan.quan@amd.com>
         <20230818032619.3341234-5-evan.quan@amd.com>
 <e167e97797a90d3d6ea09840ac909325537d6034.camel@sipsolutions.net>
In-Reply-To: <e167e97797a90d3d6ea09840ac909325537d6034.camel@sipsolutions.net>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=da0843dd-7d16-402c-8385-ecd8bb3ccc3d;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-25T08:43:53Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|DS7PR12MB8371:EE_
x-ms-office365-filtering-correlation-id: ae146eef-70c4-4629-8e0d-08dba547eb99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o0acA6vWTFuW7bqJjcKG/VMaAZWu5u7PJubDbPDZ+1KxpIejpU7kKDgiPtzkW37pibkzCZrq33zEhTpVkdW++ZAPnkrQ0yI/C3hKAfDzSVwoHhTJAwUMHsoKlA1aalFMkogIU7xCUQXt7fS5q6UJgwiKw9FA9s1aMvLsasJAUFQGxbTnNe6X7slJFIMvkXl+2ZMgd/oxjK5kbvH/U60ngUfLZE8wXfnkXoWbOVkq8Q8gYrpLv95tcADwDn/mueX0VTWiJqzOTxSkvjxsTUClFYimHe6+rypqcd1jmMg9aVegtFs59iQs+MnTxqNUdoONjTpLQjnnFBQnHNWhavZenVgGZNkESTMhCV287y9jwleymAbMFo7S90VZ1Kw1Chu8QJQGXiLvSSFrnGAMXno5Vu3woO8CykIR63fsI+9zlaj356Wf0OosSrLJp0NS0bB8sX6VvHIBoUfv4YiCXoD/G+Qf85V2Wd5TWCSYpEn31+qH+4z0RJbcB7eqdJOOwOfupeOQTQV627uht/LVodRTJCI15ju4PTGUaK9wVoCNYQpjMN9KS8Qd4/DFXwFU9EfCHM3IL9QFI4rGFH3sLpfM+ZQ9bA0daPyZSL4R8oNRTlL3KVHczWBWt0d0Dz1Dcvnt4oKvQFe50bLEV2KfSQz9mg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2619.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(136003)(366004)(1800799009)(186009)(451199024)(52536014)(5660300002)(4326008)(8676002)(8936002)(83380400001)(7416002)(33656002)(55016003)(71200400001)(921005)(38100700002)(38070700005)(122000001)(66556008)(66946007)(66476007)(7696005)(6506007)(66446008)(64756008)(54906003)(76116006)(316002)(110136005)(478600001)(53546011)(41300700001)(2906002)(9686003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFZrZzJtb3VXekxPZXJiMXk4WG43RHJwcGdEMkFFNE1iM2RzeVBnQjRPb09Y?=
 =?utf-8?B?KzIwS3k5T0lQdnZueGpDYUVwRmY2RytCSC9qN3BhSURMam5GQ0hGZkRTTDZx?=
 =?utf-8?B?ajVhV2tCRGl5WWU0bTZBMjk4d2xvZjhLK1lRS2MzSXpYTThBZVZZb25Bajgw?=
 =?utf-8?B?QU5udzkzbjdndGVZQnovaVdTS1JaM0JVdE0wYzAva2xrSnc3dDRNaVNEc21G?=
 =?utf-8?B?MnZhM1B2SDVqM0I2L1dKdXdoNXVSSXNNbFJtaVlUMUZXTE1Ebnc1dGFrTEpY?=
 =?utf-8?B?SE5mRUdCNWtOandCZWJ3VEx5OVFNN0l4d05GTkpaT3lXQkZtVXJ2ZmwwclRS?=
 =?utf-8?B?YU1Ia1h2bkNZckJ4Ty9CYXN0cWtTNzByMS9vbURuajV2UU5RZHFxeHdONk12?=
 =?utf-8?B?NnBnM1dFbFlwRkExMEdWMmJYNTNSTTVQbDM0N2QvMG9WeGNMNkNNanhoUTVM?=
 =?utf-8?B?N0ZFQjEybzg3dmdobkVYVGZtdW5wZkZOTFQ1OU8rMXpvWGdVb29mMTVqUFB4?=
 =?utf-8?B?ZlFiRjJrV0Q0VmVnZVl0NUVXcTNjUWgydDRoMWtBajVuZG5DdVhTM1BENTZ5?=
 =?utf-8?B?ZXhEVWIrb0lJOEt4NnM2UytTc3dRWVhhL0gvUU9oaFVzZGtueVRNRDRNdExk?=
 =?utf-8?B?MWwzekhPVmswWU54ME9DS3RJbmhuN1lJZm5FaDBkUStiNnZNVlB3MDMvRUJi?=
 =?utf-8?B?aklvMk92MkNhMk5yRk96UkdDaTgzYkpndytnODRiKzhqdWQ1djl2VTJkUnhG?=
 =?utf-8?B?T0g3Q1pOY2w2dmcvWGN1VWQzaUw1N3BFR1diU1F0TkVZMGlRbG1wRy9iRmRM?=
 =?utf-8?B?VjBxN2JPSks0NDRtSnlobEJwR1M4RUZtUDMwb3pDbkUwNkFIVXVTTWVFc3k1?=
 =?utf-8?B?UCtwYkp3UzY3bldMMjhQZldPdlMvYWEzdkdqcWJpMTREMDRlQVByR3VhMHlt?=
 =?utf-8?B?Y2JrRGYxOFNMbnBBNXUwRGpoS3dOdGRPT1BRTmtCQlV4OG5xS01kVHFPRUJ5?=
 =?utf-8?B?YnhnMWlIdzd2c0NyZ0E1SEJPN3RreUJRZk9YUXRxSHBncWU0cXJtSUxwVWl6?=
 =?utf-8?B?SmhmcEs0MUEvS0d4UmgybjJHTkQrM2xiTFBmUTVYQ3lCbXJIaXJtZlNhVmR6?=
 =?utf-8?B?Vnc0cGJmY2hIOHpmbzU3Mm5jc2JyaWVVMEJmRW00dXBhVkM1RThDcllsRko3?=
 =?utf-8?B?MGdFWXYrQjl5MHBhQituZkMybDV4Nnk0TWFJQkZ1ck5VSVRlQlhxYi9qZFM2?=
 =?utf-8?B?b3V3N0Q0c3RuL3J3OEUwdTNkRTBtQ0J4T1pTYXd6cy9JejZhYjN2UGw0K2Vs?=
 =?utf-8?B?R3hPN2swWERJaEhhN2thWXRlNVR3bzZlOG5lRlJoNEIvSk9QbzNvWG1meHlJ?=
 =?utf-8?B?YjdJYm0zbk5vTGF3TnZjUkNVZnBqN0J2Wk44WElTYW1zZnNvdGl1b3NQdjJY?=
 =?utf-8?B?Qlpmb002NGZVekxSS2JsMFcwbjVTaThrQkNyOTZZTWJLc1htcURxWllHUGJG?=
 =?utf-8?B?Mzd4RVU0RzM2WWhqalM5aDUwU0VUVVhUejBCbG9meDQwZ3ZxcnRzVjFBRlJt?=
 =?utf-8?B?VklpbTY5eEJIbk5pTWtwVkxnWk9iVi9IWWg2L0FxMEZ0WjZqOTdFU2FidWx1?=
 =?utf-8?B?STNTbzl3SDZoVlRPU1g2b1VrRHFYTGtMNnFseDBiZmxKQUlwbnJidkNFdWxZ?=
 =?utf-8?B?YnFuTXR5SzRpTmlqNXZZTDI4V2NtTVFRRXgwbzMvL2E0eFdNTTdLNGZWdTho?=
 =?utf-8?B?MUVidUFwRWFCcVl3Y0Fsakp2VUlMT29BTE9jM2R3b2pWVzdyK25CRU9EVEtI?=
 =?utf-8?B?SWhTQnJQTlVhS3cwbFdaNkc2S0RmaEc3VUV1UEhqWWNzeTJvWkVzV0lPWGVk?=
 =?utf-8?B?ZmVTQXZGdWtWUi9CY1gzSWFQMFYvVXhwOGkyd2tYMW1WQks5SFZXMXovbUhJ?=
 =?utf-8?B?aU1UU20zYXk2QytOdm5WZjl5QVJJYTQ4VFh4WUhWOTRVbVRGV0FxVU45UnJB?=
 =?utf-8?B?dGdXSnV2Q3FUdFFvRmNhMm5NNjZqUVI4ZVl4YXJEU2NDR0x6YmtmcjV4MW9Y?=
 =?utf-8?B?QUdiV1VCRGRmQjJNQzlCRnl4S1IvUFZOazhnZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae146eef-70c4-4629-8e0d-08dba547eb99
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2023 08:47:31.6852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bBFoMaCcyNDWAA2FU3XnWbA0A0dMOZUk8dzRWUk/+QVHWl9+mikmnW6dCMMvAMmr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8371
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogSm9oYW5uZXMgQmVyZyA8am9oYW5uZXNAc2lwc29sdXRpb25zLm5l
dD4NCj4gU2VudDogTW9uZGF5LCBBdWd1c3QgMjEsIDIwMjMgNTo0NCBQTQ0KPiBUbzogUXVhbiwg
RXZhbiA8RXZhbi5RdWFuQGFtZC5jb20+OyBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsNCj4g
cmFmYWVsQGtlcm5lbC5vcmc7IGxlbmJAa2VybmVsLm9yZzsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsN
Cj4gZWR1bWF6ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOyBwYWJlbmlAcmVkaGF0LmNv
bTsgRGV1Y2hlciwNCj4gQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgYW5k
cmV3QGx1bm4uY2g7DQo+IHJkdW5sYXBAaW5mcmFkZWFkLm9yZzsgcXVpY19qam9obnNvbkBxdWlj
aW5jLmNvbTsgaG9ybXNAa2VybmVsLm9yZw0KPiBDYzogbGludXgtZG9jQHZnZXIua2VybmVsLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGFjcGlAdmdlci5rZXJu
ZWwub3JnOyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgbGludXgtDQo+IHdpcmVsZXNz
QHZnZXIua2VybmVsLm9yZzsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgTGltb25jaWVsbG8sIE1h
cmlvDQo+IDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1Y5IDQv
OV0gd2lmaTogbWFjODAyMTE6IEFkZCBzdXBwb3J0IGZvciBXQlJGIGZlYXR1cmVzDQo+DQo+IE9u
IEZyaSwgMjAyMy0wOC0xOCBhdCAxMToyNiArMDgwMCwgRXZhbiBRdWFuIHdyb3RlOg0KPiA+IFRv
IHN1cHBvcnQgdGhlIFdCUkYgbWVjaGFuaXNtLCBXaWZpIGFkYXB0ZXJzIHV0aWxpemVkIGluIHRo
ZSBzeXN0ZW0NCj4gPiBtdXN0IHJlZ2lzdGVyIHRoZSBmcmVxdWVuY2llcyBpbiB1c2Uob3IgdW5y
ZWdpc3RlciB0aG9zZSBmcmVxdWVuY2llcw0KPiA+IG5vIGxvbmdlcg0KPiA+IHVzZWQpIHZpYSB0
aGUgZGVkaWNhdGVkIGNhbGxzLiBTbyB0aGF0LCBvdGhlciBkcml2ZXJzIHJlc3BvbmRpbmcgdG8N
Cj4gPiB0aGUgZnJlcXVlbmNpZXMgY2FuIHRha2UgcHJvcGVyIGFjdGlvbnMgdG8gbWl0aWdhdGUg
cG9zc2libGUgaW50ZXJmZXJlbmNlLg0KPiA+DQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBNYXJpbyBM
aW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBNYXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4NCj4gPiBDby1k
ZXZlbG9wZWQtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4NCj4NCj4gRnJvbSBXaUZpIFBPViwg
dGhpcyBsb29rcyBfYWxtb3N0XyBmaW5lIHRvIG1lLg0KPg0KPiA+ICtzdGF0aWMgdm9pZCB3YnJm
X2dldF9yYW5nZXNfZnJvbV9jaGFuZGVmKHN0cnVjdCBjZmc4MDIxMV9jaGFuX2RlZg0KPiAqY2hh
bmRlZiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHdi
cmZfcmFuZ2VzX2luICpyYW5nZXNfaW4pIHsNCj4gPiArICAgdTY0IHN0YXJ0X2ZyZXExLCBlbmRf
ZnJlcTE7DQo+ID4gKyAgIHU2NCBzdGFydF9mcmVxMiwgZW5kX2ZyZXEyOw0KPiA+ICsgICBpbnQg
YmFuZHdpZHRoOw0KPiA+ICsNCj4gPiArICAgYmFuZHdpZHRoID0gbmw4MDIxMV9jaGFuX3dpZHRo
X3RvX21oeihjaGFuZGVmLT53aWR0aCk7DQo+ID4gKw0KPiA+ICsgICBnZXRfY2hhbl9mcmVxX2Jv
dW5kYXJ5KGNoYW5kZWYtPmNlbnRlcl9mcmVxMSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICBiYW5kd2lkdGgsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgJnN0YXJ0X2Zy
ZXExLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICZlbmRfZnJlcTEpOw0KPiA+ICsN
Cj4gPiArICAgcmFuZ2VzX2luLT5iYW5kX2xpc3RbMF0uc3RhcnQgPSBzdGFydF9mcmVxMTsNCj4g
PiArICAgcmFuZ2VzX2luLT5iYW5kX2xpc3RbMF0uZW5kID0gZW5kX2ZyZXExOw0KPiA+ICsNCj4g
PiArICAgaWYgKGNoYW5kZWYtPndpZHRoID09IE5MODAyMTFfQ0hBTl9XSURUSF84MFA4MCkgew0K
PiA+ICsgICAgICAgICAgIGdldF9jaGFuX2ZyZXFfYm91bmRhcnkoY2hhbmRlZi0+Y2VudGVyX2Zy
ZXEyLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYmFuZHdpZHRoLA0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnN0YXJ0X2ZyZXEyLA0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmVuZF9mcmVxMik7DQo+ID4gKw0K
PiA+ICsgICAgICAgICAgIHJhbmdlc19pbi0+YmFuZF9saXN0WzFdLnN0YXJ0ID0gc3RhcnRfZnJl
cTI7DQo+ID4gKyAgICAgICAgICAgcmFuZ2VzX2luLT5iYW5kX2xpc3RbMV0uZW5kID0gZW5kX2Zy
ZXEyOw0KPiA+ICsgICB9DQo+ID4gK30NCj4NCj4gVGhpcyBoYXMgdG8gc2V0dXAgcmFuZ2VzX2lu
LT5udW1fb2ZfcmFuZ2VzLCBubz8NClllcywgYmV0dGVyIHRvIGhhdmUgdGhhdC4gSSBhZGQgdGhp
cyBpbiBWMTAuDQo+IChBbHNvIG5vIHJlYWwgZ29vZCByZWFzb24gZm9yIG51bV9vZl9yYW5nZXMg
dG8gYmUgYSB1NjQsIGJ0dywgc2luY2UgaXQgY2FuDQo+IG9ubHkgZ28gdXAgdG8gMTEpDQpNYWlu
bHkgZm9yIGRhdGEgc3RydWN0dXJlIGFsaWdubWVudC4gU2luY2Ugb3RoZXIgbWVtYmVycyBjb21l
IHdpdGggdTY0Lg0KU28sIHRvIG1ha2UgdGhlIGRhdGEgc3RydWN0dXJlIG5hdHVyYWxseSBhbGln
bmVkLCAnbnVtX29mX3JhbmdlcycgYWxzbyBjb21lcyB3aXRoIHU2NC4NCg0KRXZhbg0KPg0KPiBX
aXRoIHRoYXQgZml4ZWQsIHlvdSBjYW4gYWRkDQo+DQo+IFJldmlld2VkLWJ5OiBKb2hhbm5lcyBC
ZXJnIDxqb2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0Pg0KPg0KPiBqb2hhbm5lcw0KDQo=
