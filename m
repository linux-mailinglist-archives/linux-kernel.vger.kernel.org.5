Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485B77ADF4C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 20:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbjIYSxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 14:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjIYSxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 14:53:12 -0400
X-Greylist: delayed 84 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 25 Sep 2023 11:52:20 PDT
Received: from us-smtp-delivery-162.mimecast.com (us-smtp-delivery-162.mimecast.com [170.10.133.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6108B3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 11:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
        t=1695667939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qtpcUyuPJOUNQoqxf4liLvpNNYt/cUSFiqIC5bH3+vo=;
        b=SPom6+QX9RdAh1Gx+BZcSFNrfFh+Zm4bJGZbU04rIj7NVNsztoaln3xx4JkVa2rP5vwo8R
        ZCRG9/xwN6fumetaYMjkDY0eOIN1Lq3UGy8WLeYadpMmPMr2novgqsIfwYDE50ejGfWWck
        cpeNfxwd59817uzLjM4hqyD27ByYd/g=
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-VzN-tcv5Mv2mMfiVMXVYnA-1; Mon, 25 Sep 2023 14:50:49 -0400
X-MC-Unique: VzN-tcv5Mv2mMfiVMXVYnA-1
Received: from PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:160::10)
 by DM4PR84MB1661.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:48::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30; Mon, 25 Sep
 2023 18:50:47 +0000
Received: from PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::fcd9:a00c:8e6:175e]) by PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::fcd9:a00c:8e6:175e%3]) with mapi id 15.20.6813.017; Mon, 25 Sep 2023
 18:50:47 +0000
From:   "Lopez, Jorge A (Security)" <jorge.lopez2@hp.com>
To:     Armin Wolf <W_Armin@gmx.de>,
        "markpearson@lenovo.com" <markpearson@lenovo.com>
CC:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 2/2] platform/x86: hp-bioscfg: Fix reference leak
Thread-Topic: [PATCH v4 2/2] platform/x86: hp-bioscfg: Fix reference leak
Thread-Index: AQHZ77yS7gm+eBVN2kCEcd8lSsLGjLAr4taA
Date:   Mon, 25 Sep 2023 18:50:47 +0000
Message-ID: <PH0PR84MB19531F6C3BEF17629E6692DFA8FCA@PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM>
References: <20230925142819.74525-1-W_Armin@gmx.de>
 <20230925142819.74525-3-W_Armin@gmx.de>
In-Reply-To: <20230925142819.74525-3-W_Armin@gmx.de>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-bromium-msgid: 5839d27f-ac8d-461a-b3f3-ff0165d776d1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR84MB1953:EE_|DM4PR84MB1661:EE_
x-ms-office365-filtering-correlation-id: 3a1a7ca7-57e5-4c4e-411f-08dbbdf85492
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: d/gp/I+iHRc6KLR2x9TElmbwiN/4e99/1AfJkAkiLQkeNKlBP5odxo5HuAZiZdqlEO22ONWujuDR5VUQgM4wbr/L0HkfZa03L3MpUbpBC+YU8OSxeSrvCtKQqWnWsmuxpG87aIuTDpsr6vG7bUd4PA2aT6EEsryeJGAtxcT32EpujaFV3vmzntWUYvCc90LN2LeKWt7XWCR+Gh+kE0jjVOeVz9Kc4urL7gUgXm0R9bbBcmZ8Fb6giLDu2jq1UzLleezMVpglxbGALOqEa6qwjy+XVtQ7F7g9NQ4Bp75jC0XyJ64PIk3W/YO9OZ0mVI05B05ss4Z3mPW0s504X30caqrUqDCFlvSYIUJNrnDmBuOgNoEidr0gCksjMCYlEHIjYcMsT9bxIyu1I1y5BEVFjpIMlwBKJlbMwYzbtgwK4/UGU5iIEwBhS/RkQRQBN5QFC7OSqYJzvEBJSDYO6o2Aef7Tbo4gYKzrcJbxISyN4oZybwtjxF31eeeCHSTF1zs+9F+1MJjYzxTNQQjYDVdHJd1GxepwYOaLI4w6pW+l8lX3M+eBPECCDKlNwKfZzRg2/ByE5MYGBwPcO4JlvT2gFRqbsbWPnH1Q8CJKSmtdpdFBmNUPXKZevOaouj75fcTL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(39860400002)(376002)(230922051799003)(1800799009)(186009)(451199024)(26005)(316002)(8936002)(8676002)(54906003)(64756008)(110136005)(4326008)(76116006)(66946007)(66446008)(66476007)(66556008)(9686003)(5660300002)(52536014)(55016003)(41300700001)(71200400001)(86362001)(2906002)(82960400001)(38100700002)(38070700005)(122000001)(478600001)(83380400001)(66574015)(7696005)(6506007)(33656002)(53546011)(55236004);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z25STWltakxkSmRHZWFmeXdMUllSNWM3Qi9nRlpEeWhML2taMEtmQjA0RnEr?=
 =?utf-8?B?TEo4SkJEZUNoQXJ5bU84M1g4cjNuTVpCK0QxNnRFR3FTYmZmSldDOW1PVXFo?=
 =?utf-8?B?cElUYmJQRlFIaGdGOGM1eUg3VHJwaHNVMDlqRUw5VjNod2k2N1VsZnlCZFpa?=
 =?utf-8?B?c28wamc3VlNTS1piU1ZxcnpKVUg4UEJlMUZDUFBKZm5jV0xGN1ZTb2IyZmhi?=
 =?utf-8?B?YkdMNnRSR0Y2M2ZQZ2VCbWUwQ29MTmQvazJzTStDMEZVM21vQU5Ldk9ML0NX?=
 =?utf-8?B?dWxKcEkwTDFpbjdsbE1odFFWdGl5VHE5WUN3WTlyeWdUNGlGeXlTQUhwVGJn?=
 =?utf-8?B?cURuZ1AwQTNyd0QrcWVpVUhFZk9jSkdNWDFlMk01VHc2WmtYMXg1TFZ3Mm5j?=
 =?utf-8?B?SFlweUFyQVJrL0dWNnlrL2FBSjhhNUUvd2FCUnQ1c09EM1p1eVFFM29RSDc5?=
 =?utf-8?B?TmpBb240Z2FXWGtYdUxNRmd5YlJ3cVE2SXhIOFZLUExWR0xqcjgrVDQvbGxj?=
 =?utf-8?B?blpQaVlLL3A4NG85T1F6eXRNNlAzcTVSRThvc05Bc3U3aG5hamRjbzdRbSta?=
 =?utf-8?B?S01obVEzeUozTHRnUDRzQnZ5a3MwTkxPSUV4NjhlYnR2QlhGdW85K2c0UWU3?=
 =?utf-8?B?cE1LUkJYV1Y1ZUowZGtsWC9FdlFjQkZZb3d5SW1GeElCTWF0K3VRcCtEVnpq?=
 =?utf-8?B?ZWFIMS9FQ29IMlFiR3NBY0N5NVZpb3lFbCtOZ2JFZHg3L204MkdLa2Vhbi94?=
 =?utf-8?B?SmNqVnlUZnJVMmllU2RONjBnN0pQeTl6eW81ekxxUStvcWRoWGljNlQwWkRn?=
 =?utf-8?B?UWJRRkNTNDV6UnFNRnJtN3BhVTNmSGdSVUxnZjFwNmNRbGkxYTdkLzRGZjYy?=
 =?utf-8?B?T21YdkxpbVN3ZkFOQ1V6VG5GSG9rWGxjY1dTaTRYTzRmaW5VUHZOcjE4V2ZK?=
 =?utf-8?B?MzVkQkpVSFg3ZUpwcXlVbWk4V3lQOWovOXQzRFhhdCtVLy95N1oxdGJWNnNI?=
 =?utf-8?B?NVdIbkFSM0RPQWJPSHpicjdYeHZ5aUwxN2Ewa2xEY0ZEaTRHUTNaaGUwL3dV?=
 =?utf-8?B?bHZEWXRXdnpzQmsrMXlTQzcrK0ZiUXVUS1RDdU41TzFSMlVFYTRsb2RBZHA4?=
 =?utf-8?B?N2ZWVHFEcTg0RHBmT3AwUk9ELytVQkdrSmRxTVNvOUJDVXUwQi9CMXljUi8v?=
 =?utf-8?B?eExqQWRPQi9ZSmUrMDhINERuYit6U3hmcStIMXlIbDJld0hSamJVQnJ3MjJi?=
 =?utf-8?B?aTRSSHBtdWdPK3gvemZMM2l6NzlvM0htNXRCNlBOR3BaYWVyejJGU1VDWWNa?=
 =?utf-8?B?cFlBdmlHQWZQZkswUkxsM2p1T1V1V0VvSVlobE5Ubkd0aUt6MmE5SFFZZmdy?=
 =?utf-8?B?ZUVTR3ZEbm9sQ2FXWlFzQVF1UURlZ1FzbkFoQXUyYktPMkxYNWI5d01FQzNY?=
 =?utf-8?B?TjVHSU1ma1ZvMk9mdFllbEFESjNORDU0ODdieVlNR0xvRkhDR25rQ1NXdTNz?=
 =?utf-8?B?WFpISnlZbytqeHJDS1NwMkgrQzQ3dmFwVTFQbmI5YVhYbUdsdS81QTNGdG1I?=
 =?utf-8?B?YTRyRnJudVRUbHlqdk03UjR1U1ZuQ0xaM0Qzc0lJWmNlaFd1VlU3SmQ1VUVP?=
 =?utf-8?B?UklCYkJQb1kydlVrTHZWdWdTL2U1OGdnT0RabUFKemRRL3RGQlhaMmlmb0RK?=
 =?utf-8?B?dUhSWmlEeFlwOFdNa3I0cnI0SG13enM5UHdxVU9FOHhseVZ3dUFsNHdyNTJY?=
 =?utf-8?B?SFpJcFVSZGJxcWVaKzU2YmVxbGFlbm9RRERtZmYyZ0lwa2JMN3RlTklrSGFE?=
 =?utf-8?B?QTRDY1RBNVczQVhmK1BQamphVHRoY0k4SDVERGJGTlB4UndBZnU5a1NLMjRG?=
 =?utf-8?B?Z091Q2ZtNTJxTVlkTGhKWUdEQkFUYmlSMC9BeTFtN2QyZGYyaWh3TU5OMkJZ?=
 =?utf-8?B?TWo1ZGQ1Z2lTaHR5V1hqS2xlM2ROSGZHN0lTK1RrUE04SmFiTlZYeDVsYlI0?=
 =?utf-8?B?Z1Z4UHNmU0o5aUxIRjk2RzFvVThHNmR0TnlKamlablhzbDN4eWhWZmxYa2t6?=
 =?utf-8?B?MmdnN0MzL0NiaVhQQW5pKzJCZFV1Y1VXeTZNTmNlRU81QlVGZlRWQVI4R2RE?=
 =?utf-8?Q?TkpNM1021PAM8KMitBA2W98pM?=
MIME-Version: 1.0
X-OriginatorOrg: hp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a1a7ca7-57e5-4c4e-411f-08dbbdf85492
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 18:50:47.1088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ca7981a2-785a-463d-b82a-3db87dfc3ce6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dlLpo1rhhWSv0yELB56AFMX0f+HnX008HAbKTJHp0LYlIjtGkHdHYd2lte2CkN1T8PzkegI28MnbBUW0pwDLxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1661
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hp.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmV2aWV3ZWQtYnk6IEpvcmdlIExvcGV6IDxqb3JnZS5sb3BlejJAaHAuY29tPg0KDQoNCj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXJtaW4gV29sZiA8V19Bcm1pbkBnbXgu
ZGU+DQo+IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDI1LCAyMDIzIDk6MjggQU0NCj4gVG86IG1h
cmtwZWFyc29uQGxlbm92by5jb207IExvcGV6LCBKb3JnZSBBIChTZWN1cml0eSkNCj4gPGpvcmdl
LmxvcGV6MkBocC5jb20+DQo+IENjOiBoZGVnb2VkZUByZWRoYXQuY29tOyBtYXJrZ3Jvc3NAa2Vy
bmVsLm9yZzsNCj4gaWxwby5qYXJ2aW5lbkBsaW51eC5pbnRlbC5jb207IHBsYXRmb3JtLWRyaXZl
ci14ODZAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0K
PiBTdWJqZWN0OiBbUEFUQ0ggdjQgMi8yXSBwbGF0Zm9ybS94ODY6IGhwLWJpb3NjZmc6IEZpeCBy
ZWZlcmVuY2UgbGVhaw0KPiANCj4gQ0FVVElPTjogRXh0ZXJuYWwgRW1haWwNCj4gDQo+IElmIGEg
ZHVwbGljYXRlIGF0dHJpYnV0ZSBpcyBmb3VuZCB1c2luZyBrc2V0X2ZpbmRfb2JqKCksIGEgcmVm
ZXJlbmNlIHRvIHRoYXQNCj4gYXR0cmlidXRlIGlzIHJldHVybmVkIHdoaWNoIG5lZWRzIHRvIGJl
IGRpc3Bvc2VkIGFjY29yZGluZ2x5IHVzaW5nIGtvYmplY3RfcHV0KCkuDQo+IFVzZSBrb2JqZWN0
X3B1dCgpIHRvIGRpc3Bvc2UgdGhlIGR1cGxpY2F0ZSBhdHRyaWJ1dGUgaW4gc3VjaCBhIGNhc2Uu
DQo+IEFzIGEgc2lkZSBub3RlLCBhIHZlcnkgc2ltaWxhciBidWcgd2FzIGZpeGVkIGluIGNvbW1p
dCA3Mjk1YTk5NmZkYWINCj4gKCJwbGF0Zm9ybS94ODY6IGRlbGwtc3lzbWFuOiBGaXggcmVmZXJl
bmNlIGxlYWsiKSwgc28gaXQgc2VlbXMgdGhhdCB0aGUgYnVnIHdhcw0KPiBjb3BpZWQgZnJvbSB0
aGF0IGRyaXZlci4NCj4gDQo+IENvbXBpbGUtdGVzdGVkIG9ubHkuDQo+IA0KPiBGaXhlczogYTM0
ZmMzMjliMTg5ICgicGxhdGZvcm0veDg2OiBocC1iaW9zY2ZnOiBiaW9zY2ZnIikNCj4gU3VnZ2Vz
dGVkLWJ5OiBJbHBvIErDpHJ2aW5lbiA8aWxwby5qYXJ2aW5lbkBsaW51eC5pbnRlbC5jb20+DQo+
IFJldmlld2VkLWJ5OiBJbHBvIErDpHJ2aW5lbiA8aWxwby5qYXJ2aW5lbkBsaW51eC5pbnRlbC5j
b20+DQo+IFNpZ25lZC1vZmYtYnk6IEFybWluIFdvbGYgPFdfQXJtaW5AZ214LmRlPg0KPiAtLS0N
Cj4gQ2huYWdlcyBpbiB2NDoNCj4gLSBmaXggbWlzc2luZyB3aGl0ZXNwYWNlDQo+IC0gYWRkIFJl
dmlld2VkLWJ5DQo+IENoYW5nZXMgaW4gdjM6DQo+IC0gbm8gY2hhbmdlcw0KPiBDaGFuZ2VzIGlu
IHYyOg0KPiAtIGFkZCBwYXRjaA0KPiAtLS0NCj4gIGRyaXZlcnMvcGxhdGZvcm0veDg2L2hwL2hw
LWJpb3NjZmcvYmlvc2NmZy5jIHwgMTQgKysrKysrKysrKy0tLS0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxMCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcGxhdGZvcm0veDg2L2hwL2hwLWJpb3NjZmcvYmlvc2NmZy5jDQo+IGIvZHJpdmVycy9w
bGF0Zm9ybS94ODYvaHAvaHAtYmlvc2NmZy9iaW9zY2ZnLmMNCj4gaW5kZXggOGM0ZjllMTJmMDE4
Li41Nzk4YjQ5ZGRhYmEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2hwL2hw
LWJpb3NjZmcvYmlvc2NmZy5jDQo+ICsrKyBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2hwL2hwLWJp
b3NjZmcvYmlvc2NmZy5jDQo+IEBAIC02NTksNyArNjU5LDcgQEAgc3RhdGljIGludCBocF9pbml0
X2Jpb3NfcGFja2FnZV9hdHRyaWJ1dGUoZW51bQ0KPiBocF93bWlfZGF0YV90eXBlIGF0dHJfdHlw
ZSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgY2hh
ciAqZ3VpZCwgaW50IG1pbl9lbGVtZW50cywNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgaW50IGluc3RhbmNlX2lkKSAgew0KPiAtICAgICAgIHN0cnVjdCBrb2Jq
ZWN0ICphdHRyX25hbWVfa29iajsNCj4gKyAgICAgICBzdHJ1Y3Qga29iamVjdCAqYXR0cl9uYW1l
X2tvYmosICpkdXBsaWNhdGU7DQo+ICAgICAgICAgdW5pb24gYWNwaV9vYmplY3QgKmVsZW1lbnRz
Ow0KPiAgICAgICAgIHN0cnVjdCBrc2V0ICp0ZW1wX2tzZXQ7DQo+IA0KPiBAQCAtNzA0LDggKzcw
NCwxMSBAQCBzdGF0aWMgaW50IGhwX2luaXRfYmlvc19wYWNrYWdlX2F0dHJpYnV0ZShlbnVtDQo+
IGhwX3dtaV9kYXRhX3R5cGUgYXR0cl90eXBlLA0KPiAgICAgICAgIH0NCj4gDQo+ICAgICAgICAg
LyogQWxsIGR1cGxpY2F0ZSBhdHRyaWJ1dGVzIGZvdW5kIGFyZSBpZ25vcmVkICovDQo+IC0gICAg
ICAgaWYgKGtzZXRfZmluZF9vYmoodGVtcF9rc2V0LCBzdHJfdmFsdWUpKSB7DQo+ICsgICAgICAg
ZHVwbGljYXRlID0ga3NldF9maW5kX29iaih0ZW1wX2tzZXQsIHN0cl92YWx1ZSk7DQo+ICsgICAg
ICAgaWYgKGR1cGxpY2F0ZSkgew0KPiAgICAgICAgICAgICAgICAgcHJfZGVidWcoIkR1cGxpY2F0
ZSBhdHRyaWJ1dGUgbmFtZSBmb3VuZCAtICVzXG4iLCBzdHJfdmFsdWUpOw0KPiArICAgICAgICAg
ICAgICAgLyoga3NldF9maW5kX29iaigpIHJldHVybnMgYSByZWZlcmVuY2UgKi8NCj4gKyAgICAg
ICAgICAgICAgIGtvYmplY3RfcHV0KGR1cGxpY2F0ZSk7DQo+ICAgICAgICAgICAgICAgICBnb3Rv
IHBhY2tfYXR0cl9leGl0Ow0KPiAgICAgICAgIH0NCj4gDQo+IEBAIC03NjgsNyArNzcxLDcgQEAg
c3RhdGljIGludCBocF9pbml0X2Jpb3NfYnVmZmVyX2F0dHJpYnV0ZShlbnVtDQo+IGhwX3dtaV9k
YXRhX3R5cGUgYXR0cl90eXBlLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGNvbnN0IGNoYXIgKmd1aWQsIGludCBtaW5fZWxlbWVudHMsDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IGluc3RhbmNlX2lkKSAgew0KPiAtICAg
ICAgIHN0cnVjdCBrb2JqZWN0ICphdHRyX25hbWVfa29iajsNCj4gKyAgICAgICBzdHJ1Y3Qga29i
amVjdCAqYXR0cl9uYW1lX2tvYmosICpkdXBsaWNhdGU7DQo+ICAgICAgICAgc3RydWN0IGtzZXQg
KnRlbXBfa3NldDsNCj4gICAgICAgICBjaGFyIHN0cltNQVhfQlVGRl9TSVpFXTsNCj4gDQo+IEBA
IC03OTQsOCArNzk3LDExIEBAIHN0YXRpYyBpbnQgaHBfaW5pdF9iaW9zX2J1ZmZlcl9hdHRyaWJ1
dGUoZW51bQ0KPiBocF93bWlfZGF0YV90eXBlIGF0dHJfdHlwZSwNCj4gICAgICAgICAgICAgICAg
IHRlbXBfa3NldCA9IGJpb3NjZmdfZHJ2Lm1haW5fZGlyX2tzZXQ7DQo+IA0KPiAgICAgICAgIC8q
IEFsbCBkdXBsaWNhdGUgYXR0cmlidXRlcyBmb3VuZCBhcmUgaWdub3JlZCAqLw0KPiAtICAgICAg
IGlmIChrc2V0X2ZpbmRfb2JqKHRlbXBfa3NldCwgc3RyKSkgew0KPiArICAgICAgIGR1cGxpY2F0
ZSA9IGtzZXRfZmluZF9vYmoodGVtcF9rc2V0LCBzdHIpOw0KPiArICAgICAgIGlmIChkdXBsaWNh
dGUpIHsNCj4gICAgICAgICAgICAgICAgIHByX2RlYnVnKCJEdXBsaWNhdGUgYXR0cmlidXRlIG5h
bWUgZm91bmQgLSAlc1xuIiwgc3RyKTsNCj4gKyAgICAgICAgICAgICAgIC8qIGtzZXRfZmluZF9v
YmooKSByZXR1cm5zIGEgcmVmZXJlbmNlICovDQo+ICsgICAgICAgICAgICAgICBrb2JqZWN0X3B1
dChkdXBsaWNhdGUpOw0KPiAgICAgICAgICAgICAgICAgZ290byBidWZmX2F0dHJfZXhpdDsNCj4g
ICAgICAgICB9DQo+IA0KPiAtLQ0KPiAyLjM5LjINCg0K

