Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6017E67A9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbjKIKRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233433AbjKIKRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:17:04 -0500
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11012002.outbound.protection.outlook.com [40.93.200.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC5730FC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 02:17:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xr44BGvOjrCqNE3QxeDOmuvqge0gPOJ4AZTF3J3n4qypvL+xoH/7qxkNwzx0zdZ+qpQrCOCoiwnjZqbAdmR0/Mgsc+LF2Itx4RuM47fWBJdcFqK7rNQ2cO0CUjho8n0PfWRsqB9WfQEEPZMuTiEFn0rNhOajk5Jwumo6feCd8a85ZmHERrgYVBqnc04i4hRMnSfUKaH6IcADz8rCBuBCUU3nVXUMP9nt3Msjk/FOSpI2ciq9xOCVQ8BOQKjJtLyha8JDaXrQrlDDNXxIuOAv1hObnZcbHEqiCD8LzRDdzF3/guf7afykn4QwaC2kmqoeJFHQ0CMNvOv+eqOUipAV+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4brdDH/hZXx+KLjMAn5HsDRDTtB36YUGG2IrI/hIBIg=;
 b=TdtFvL9iFTRJzs3u3yeWaib8VdbaLuLhQqdgWBqpCmEjqfIU4GuD4ZozB9EWaiYVTAEUUA+tSHYRfN+rUCs1qkEWlbBOz5TpSNRqurZxGMz8l/3G0YVsI3+AsMilLo2UpYoRZg+HfAf8Ch8d5I/VNN8A4kLNuw0KfMezlAdLCzfxf4tS1DwtG3f9rNJ1YvIPRf7Lsg4nbp0g5DmhJ+00r+ZX5LfsDurS0hUjs5wt3tLFPqhzL1vAAcACNW/mfpP2UYFat0AF+to6KSFRBTl8I1fr1ckddLMnyZF2y3bEQEwDJ8ZRVHRuXBJkvN1ZwjmdkVxi7v2GqS7emvTMhEV4QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4brdDH/hZXx+KLjMAn5HsDRDTtB36YUGG2IrI/hIBIg=;
 b=fnXG6FT2T82EjFSEfrcVsVduxPUHNkKi7hRRIrcdflNiEVU58LG0a5qvihUevhhKfv86Fu8/Tn6dVRhNDImD+4cfucElyKs54o/5/ZWSgVpdzJON8gZCuuL/mbE+qEFaBC6MEzj/SbDtLVyG9BFVqPxiDEdt1QwA/zAB460VNU4=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by SJ2PR05MB9856.namprd05.prod.outlook.com (2603:10b6:a03:4f2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Thu, 9 Nov
 2023 10:16:57 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e6fc:9264:2535:6ce2]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e6fc:9264:2535:6ce2%6]) with mapi id 15.20.6954.028; Thu, 9 Nov 2023
 10:16:57 +0000
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
Thread-Index: AQHaCwJWAIN/MoWKfkqwslHpJdh5ILBiSanQgA2TzACAAfg3gA==
Date:   Thu, 9 Nov 2023 10:16:57 +0000
Message-ID: <C47A7C40-BE3E-4F0F-B854-D40D4795A236@vmware.com>
References: <20231030072540.38631-1-byungchul@sk.com>
 <20231030072540.38631-3-byungchul@sk.com>
 <63C530D3-3A1D-4BE9-8AA7-EFF5B895BE80@vmware.com>
 <20231030125129.GD81877@system.software.com>
 <20231108041208.GA40954@system.software.com>
In-Reply-To: <20231108041208.GA40954@system.software.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|SJ2PR05MB9856:EE_
x-ms-office365-filtering-correlation-id: 17fe0f40-86ea-46c0-37d4-08dbe10d015c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OAxSe0uxKt7xPwDx9ffJky5qn2i324iOXR09kp1sGpQBBQPECFyPChhoWTNkImEr1qSuI9fCrRsRYu9YmbNvaXW/m86VO4BDtGCg4SebG75REWz/3u28b9QLyEqeYIrQRRzrxYo4AXuhtdcKJWVGNLZH6MnAnc9cx84C6o5aq3PDQvrvOxP1xKbWreFi4xmoXnDVFIH+emc/1JeXMIPj7wGZ1lrCtNwmzo/kv/Gv8UWjHe1qsyYRjaWM/d4Ed++gb0il1nViRK+WW/jraVekAdfmawzyyqIKW9IkuKJ2dcC+ncNfh8A4ixtzwBz6xQrRA/cZAnJKcOwtO7PLlfvVY6PjpwI28jRYrWKd2asCmqQ09LRLC5rTDt+osNFfmIi3VU9cZepWSZyfkZciIi017SkMUlY0jRWOiOm5Lo7lt1fDNVa2NT/4cbM2RvzjXzmqy5wrjTEqY+CnIFKUX57nocjfhBpx/bo/z7fPpRdnirPGj8+T0aSVcGYJokpQbaDkhqpUFHpagdYzeFndP3JdzjX+Ne+5Zbz50tshBmwaNg6UG97tqoU1cO5gOakPEjkkAy0XYsFwxFMj9Acx46fUkz1f9cAAVFIYj2T2vWOlGTkU+yveb9g7LQ0aPQt/BFtqeNKYVhZuE4tZSBNKrgzSPv6NE1V/er/kGPisdbruIRb5kQc0rWPUNN6VCGZpa4MTS1Oahdm54UepynlWk1oNvi8Fx6Vjp/crlG/+8N1I/iM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(136003)(376002)(230173577357003)(230273577357003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(26005)(6506007)(53546011)(6512007)(2616005)(38070700009)(38100700002)(122000001)(86362001)(33656002)(36756003)(83380400001)(5660300002)(66556008)(7416002)(66946007)(6916009)(76116006)(316002)(66476007)(64756008)(66446008)(54906003)(91956017)(6486002)(8676002)(4326008)(8936002)(41300700001)(71200400001)(478600001)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bndPemFxUW8rMkRaeHUzTzJkYW80cTNUdzd0a2pzY3JuUGljdmJKVktEWUto?=
 =?utf-8?B?M2NNYS9FNHZRUGtjbkpvYnNKbkhZSmdORzZQL1dWQ1JTWldOQzE4aTBST2NX?=
 =?utf-8?B?Z0w0WnNEUTR2MkZoT1FVY2tqVnA2Y0NIcnNRWTltcEp5OUJBQlJIVzVKWGwr?=
 =?utf-8?B?V0xLWkd5R2NBZXI5Q29PNUVlOHRFOThZZUsxRy9NT0xZRndMbXhkZmpCWmxQ?=
 =?utf-8?B?aEFIeVl6WWZmNjJjWTJBSUV3Z284dUNpYTFDZVhRcWtxLzJQRkYvT2doZ0FC?=
 =?utf-8?B?UDE2YlhCdFZCR2xXZkc4Y1l2VVpYTkNmNlJiSTRpanVIa0EvNEZjZmx1L3Uy?=
 =?utf-8?B?WXord0VkRFNXbFdwUEJJMDUrdmhFNC9ZeGtBRGx0anp4RjJxbTduc1FKaG03?=
 =?utf-8?B?SHNPSHp4eHNEK0NqRkJrMTJoY25PQ3N2Z0k0dkdWd25mdlZZMGNrNzNpelBN?=
 =?utf-8?B?RUVxa1JodE9kTGxQWHdMSHB0eFV5L3NGNFJQVXU3VmhKbEZBdVM5dGloRTRr?=
 =?utf-8?B?UXlvQmNXbjFhZURoKzRXK0UzaVJVY29xdmtFZjZLK25LZ3RxMmVnSlloWmdJ?=
 =?utf-8?B?Z0JQYkZlQ3c5VjN1b21xbUE0dURqRzZ5Y3dVUXJlV3h5WGxCNFZvdC84U3VK?=
 =?utf-8?B?ZzZYRnJGRXd0bEtFNjhzQUN5V3AzOEJpczVQbWN3enJsd2N4ZE1QNVV4cHJn?=
 =?utf-8?B?L1MxQWY3UENaVjN0Y2h1cU5LOGQwTDd0WVpJM0JseVdkZm90UjVvK2RWLzMv?=
 =?utf-8?B?Ni9nRDRsQ0FCQjJxcmNueW1VNzVZYzBhOVhrY0RjWVRjR0p0MWpEbUZLZFJZ?=
 =?utf-8?B?OHpOZVRRZU1Ka1RwRE0wcGFwQ1oyb2w5NXJLbUZzWnI5cmFvMC9GL3dRVTZy?=
 =?utf-8?B?R2ttNnhHdWltRUJKak5tbDlITEUwdlhzd0F1bVhMemsySzN3VTZOck1aSlJF?=
 =?utf-8?B?WUJxNzE1clZsTUs2aVlGMFBNZ2xjODcrZ0JGMU5zcVUxaUh5dmZuYzJaRmFa?=
 =?utf-8?B?SWU2NWlodVlLYWsyWEJpcThWZlJCWEtSYm5GL1N4NG5KR2JHek93L1l4YUZ5?=
 =?utf-8?B?V1p1TE1wY1BzbFVCdSt2UXdoeXhrNXVySFRxK3ViUnFCRzN6VDM0SGFpamJz?=
 =?utf-8?B?YmVhdEk3b29ISWt6bFZyN3ZraGlWUmNlY0wvdVVKZUszUi9PZGtBWnFhYldW?=
 =?utf-8?B?T1NCMlc2L0xHN1o4bEF3RVZETzFDcWMzTjhmbVdpQVdZZDZuQU53V2l4U05X?=
 =?utf-8?B?M0tvQmRqYTMvMEpqT20wQUVBb3cvQjcxT1MyQ21qbElMemJWQ28rditKSXgv?=
 =?utf-8?B?Q1FCTVZlMVRxMGxrZWx0bG1WNHVFajZ1TzFrN2w2eWpmMFNKajJZR0lOamxt?=
 =?utf-8?B?WldUSkdGN0tON2VkejBrb3hmdTFoMkFKcUpFdzFDa09vMDRwQ2laMkVHelFP?=
 =?utf-8?B?QW5tQXF3NEl3ZFNjVHprOVY5TEtiWDhNa0NMeVluQXlXdnhYdGFtZmtVWGtU?=
 =?utf-8?B?aVFXTXpld1MxdzlCRXhEV1hBZ2NKNkxlMmVUM2VxSlJUb0FSaVFLYlJQNHpN?=
 =?utf-8?B?OWZWOG5kcHdKSkYzdk5qUWo5NnlDSkJTbU8veWZPMkMrbkJyODhPZUk5NlVQ?=
 =?utf-8?B?VWZIcFlWSXhIY0ZBQXVQWGJKajk3YmJUY09ETTYwTE83b1BMWVZIcnh4QW9l?=
 =?utf-8?B?RWlNQm05U3daRnIrUFFNUWs2NkxjYkErdWR5QWJjR2RkSm5YUlIwTERjUi9i?=
 =?utf-8?B?Rms0MUtPMDBFS0xySHEyRThPZ1EvZlJHUThRZ0ZtakJYVDlobkUzdVVjaXFh?=
 =?utf-8?B?UmtzN0tMSUliejg5TVJJQ2Uva1IvNVlNcUJiVTU3dFhiQXU4NTBxVDU1R3hv?=
 =?utf-8?B?elJmVndTdnUvblJTb21pS24yQklBb3hRN0FVbk5vUkswR0FnMmV3N3hYZFJP?=
 =?utf-8?B?SzExRkRoblVvazVSa1dlYjNodnZIcWh0aDQrWk9uUTZreWRCem1Jb2w4eXpX?=
 =?utf-8?B?TlpxeTRiNzN1Rk1nSnFwcHM0bEYzb1pDOEIvNEovZk5EN0R4VTROcnZRZU9B?=
 =?utf-8?B?NVVJM2FkZjNnbTJSdkhIOHVPNXQzYlBhdHFoWDM4ZXNOQnc3Skc1UUtRZ1ZU?=
 =?utf-8?Q?+OpKJP21o1g4oTMYveCzU3EMH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB35BE88D894504BA6BD439FBD787759@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17fe0f40-86ea-46c0-37d4-08dbe10d015c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 10:16:57.6634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sPnA7z1SUuKq/q9HJmmEqG9sPJAlEwXBc+gLgOffBmwOk+l36d0BUn3V7FTYDKR8/fdZQgzX6/EYej1vVMX+cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR05MB9856
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTm92IDgsIDIwMjMsIGF0IDY6MTIgQU0sIEJ5dW5nY2h1bCBQYXJrIDxieXVuZ2No
dWxAc2suY29tPiB3cm90ZToNCj4gDQo+ICEhIEV4dGVybmFsIEVtYWlsDQo+IA0KPiBPbiBNb24s
IE9jdCAzMCwgMjAyMyBhdCAwOTo1MTozMFBNICswOTAwLCBCeXVuZ2NodWwgUGFyayB3cm90ZToN
Cj4+Pj4gZGlmZiAtLWdpdCBhL21tL21lbW9yeS5jIGIvbW0vbWVtb3J5LmMNCj4+Pj4gaW5kZXgg
NmMyNjRkMmY5NjljLi43NWRjNDhiNmUxNWYgMTAwNjQ0DQo+Pj4+IC0tLSBhL21tL21lbW9yeS5j
DQo+Pj4+ICsrKyBiL21tL21lbW9yeS5jDQo+Pj4+IEBAIC0zMzU5LDYgKzMzNTksMTkgQEAgc3Rh
dGljIHZtX2ZhdWx0X3QgZG9fd3BfcGFnZShzdHJ1Y3Qgdm1fZmF1bHQgKnZtZikNCj4+Pj4gIGlm
ICh2bWYtPnBhZ2UpDQo+Pj4+ICAgICAgICAgIGZvbGlvID0gcGFnZV9mb2xpbyh2bWYtPnBhZ2Up
Ow0KPj4+PiANCj4+Pj4gKyAvKg0KPj4+PiArICAqIFRoaXMgZm9saW8gaGFzIGl0cyByZWFkIGNv
cHkgdG8gcHJldmVudCBpbmNvbnNpc3RlbmN5IHdoaWxlDQo+Pj4+ICsgICogZGVmZXJyaW5nIFRM
QiBmbHVzaGVzLiBIb3dldmVyLCB0aGUgcHJvYmxlbSBtaWdodCBhcmlzZSBpZg0KPj4+PiArICAq
IGl0J3MgZ29pbmcgdG8gYmVjb21lIHdyaXRhYmxlLg0KPj4+PiArICAqDQo+Pj4+ICsgICogVG8g
cHJldmVudCBpdCwgZ2l2ZSB1cCB0aGUgZGVmZXJyaW5nIFRMQiBmbHVzaGVzIGFuZCBwZXJmb3Jt
DQo+Pj4+ICsgICogVExCIGZsdXNoIHJpZ2h0IGF3YXkuDQo+Pj4+ICsgICovDQo+Pj4+ICsgaWYg
KGZvbGlvICYmIG1pZ3JjX3BlbmRpbmdfZm9saW8oZm9saW8pKSB7DQo+Pj4+ICsgICAgICAgICBt
aWdyY191bnBlbmRfZm9saW8oZm9saW8pOw0KPj4+PiArICAgICAgICAgbWlncmNfdHJ5X2ZsdXNo
X2ZyZWVfZm9saW9zKE5VTEwpOw0KPj4+IA0KPj4+IFNvIG1hbnkgcG90ZW50aWFsIGZ1bmN0aW9u
IGNhbGxz4oCmIFByb2JhYmx5IHRoZXkgc2hvdWxkIGhhdmUgYmVlbiBjb21iaW5lZA0KPj4+IGlu
dG8gb25lIGFuZCBhdCBsZWFzdCBtaWdyY19wZW5kaW5nX2ZvbGlvKCkgc2hvdWxkIGhhdmUgYmVl
biBhbiBpbmxpbmUNCj4+PiBmdW5jdGlvbiBpbiB0aGUgaGVhZGVyLg0KPj4gDQo+PiBJIHdpbGwg
dHJ5IHRvIGNoYW5nZSBpdCBhcyB5b3UgbWVudGlvbi4NCj4+IA0KPj4+PiArIH0NCj4+Pj4gKw0K
Pj4+IA0KPj4+IFdoYXQgYWJvdXQgbXByb3RlY3Q/IEkgdGhvdWdodCBEYXZpZCBoYXMgY2hhbmdl
ZCBpdCBzbyBpdCBjYW4gc2V0IHdyaXRhYmxlDQo+Pj4gUFRFcy4NCj4+IA0KPj4gSSB3aWxsIGNo
ZWNrIGl0IG91dC4NCj4gDQo+IEkgZm91bmQgbXByb3RlY3Qgc3R1ZmYgaXMgYWxyZWFkeSBwZXJm
b3JtaW5nIFRMQiBmbHVzaGVzIG5lZWRlZCBmb3IgaXQuDQo+IFNvIHNvbWUgcmVkdW5kYW50IFRM
QiBmbHVzaGVzIG1pZ2h0IGhhcHBlbiBieSBtaWdyYyBidXQgaXQncyBub3QgdGhhdA0KPiBoYXJt
ZnVsIEkgdGhpbmsuIFRoYW5rcy4NCg0KTGV0IG1lIGV4cGxhaW4gdGhlIHNjZW5hcmlvIEkgYW0g
Y29uY2VybmVkIHdpdGguIEFzc3VtZSBwYWdlIFAgaXMgUk8sIGFuZA0KbW92ZXMgZnJvbSBQc3Jj
IHRvIFBkc3QuIFBvaW50ZXIg4oCccOKAnSBwb2ludHMgdG8gUC4gSW5pdGlhbGx5ICgqcCA9PSAw
KS4NCg0KTGV04oCZcyBhbHNvIGFzc3VtZSB3ZSBhbHNvIGhhdmUgYW4gYXRvbWljIHZhcmlhYmxl
IOKAnGHigJ0uIEluaXRpYWxseSAoYSA9PSAwKS4NCg0KSSBob3BlIEkgZ290IHRoZSBtaWdyYXRp
b24gZnVuY3Rpb24gbmFtZXMgcmlnaHQsIGJ1dCBJIGhvcGUgdGhlIHByb2JsZW0NCml0c2VsZiBj
YW4gYmUgY2xlYXIgcmVnYXJkbGVzcy4gDQoNCkNQVTAJCQlDUFUxCQkJQ1BVMgkJQ1BVMw0KLS0t
LQkJCS0tLS0JCQktLS0tCQktLS0tDQoJCQkodXNlci1tb2RlKQkJKHVzZXItbW9kZSkJCQ0KDQoJ
CQlBY2Nlc3MgKnANCgkJCVtQc3JjIGNhY2hlZCBpbiBUTEJdDQogDQptaWdyYXRlX3BhZ2VzX2Jh
dGNoKCkNCi0+IG1pZ3JhdGVfZm9saW9fdW5tYXAoKQ0KDQpbIFBURSB1cGRhdGVkLCANCiAgc3Rp
bGwgbm8gZmx1c2ggXQ0KDQoJCQkJCQkJCW1wcm90ZWN0KHAsDQoJCQkJCQkJCQlSVykNCg0KCQkJ
CQkJCQlbIFBzcmMgaXMNCgkJCQkJCQkJICBSVyBdDQoNCgkJCQkJCQkJWyBmbHVzaA0KCQkJCQkJ
CQkgIGRlZmVycmVkXQ0KDQoNCgkJCQkJCSpwID0gMSAgIyBQZHN0DQoJCQkJCQkNCgkJCQkJCXhj
aGcoJmEsIDEpDQoJCQltZmVuY2UNCgkJCWlmIChhID09IDEpDQoJCQkgIGFzc2VydCgqcCA9PSAx
KTsNCg0KDQoJCQkJDQpOb3cgYXQgdGhpcyBwb2ludCB0aGUgYXNzZXJ0aW9uIG1pZ2h0IGZhaWwu
IENQVTIgd3JvdGUgaW50byBQZHN0LCB3aGVyZWFzDQpDUFUxIHJlYWRzIGZyb20gUHNyYy4gQnV0
IGJhc2VkIG9uIHg4NiBtZW1vcnkgbW9kZWwsIHVzZXJzcGFjZSBtaWdodCBub3QNCmV4cGVjdCB0
aGlzIHNjZW5hcmlvIHRvIGJlIHBvc3NpYmxlLCBoZW5jZSBsZWFkaW5nIHRvIGJ1Z3MuDQoNCg0K
DQoNCg0KDQo=
