Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874787D3CD3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjJWQrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjJWQrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:47:41 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020014.outbound.protection.outlook.com [52.101.61.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDF4100;
        Mon, 23 Oct 2023 09:47:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbblPQREhWOl1fNfJ0RqjoyZIaeM2sTLn2gs2/v76NASLMRs8Jw/yswZJelXushvp62PnAM35eh2HPTNHAvnBiGg8HSfUXGlk7pLORHitcj9DK+JD/boTHWFRJJ+8pu294G7o37OSLF0rqhjTCbi5aVk6Kne+gbce9KuiEhNIjum3u5Xyo2BYTP/PpDfoVrJ5ybGYY2JIxSKsvkh9jUz9GbLhYrH3m1tMKL99IVunBzZ4MNdkUwOunJ1+ZWmAHd6cY4LdIbmqDnLLYW/BqZgjmDLeVb4HF75aBhJBHMflLC11Od0Ys+bVVsJdeUJ/3bOOb0U5nERPwZ9ZpJTqKayyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8AqMZh2tbAwhq1Jt3ncYeTNtXJFsF19ZOdSheseEtEY=;
 b=FtcRpVwapEz86emGxui//fDSLaoeo0vA9ogHkUvw7OfSflz0ApCAlmQAzFqjnR+0qLlNRf7+uCw0CJ+eJ+1QMzO0xamoaldQ1flkBY1d/akQZO47yoEFtRdYIchaYrEXIgVGoUFJJYydSkRK8gagQSbU43R+P2EascBx6julKBV9gTajvtc96KOvxuxCimRZY2PX8r6En5uq/HOPIfFvKUSDUQUf31Lf/u2W692BeRL70oCvWzwty4rIDGHNlh0G0h/HDOC+YXix8HcnwRDIiTRN6p56qtQ5UJiDZ3hntK0BQyCuNZBNePQltGjhIuvS7NHIoifCcWabdXCbQbx1sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AqMZh2tbAwhq1Jt3ncYeTNtXJFsF19ZOdSheseEtEY=;
 b=U1PijItj2q14FN5dIFnDavDpmt+OctDdZfmkUd8J2iKPQTnbsBF6GPYrxojlkaM1PgRWrqH8YqRIaMng4zeiwyIDn2YJXEuBeR+ASOnrfsqe7EEkniRmfHryMBdMVftni0TDFdKnJ4Me80HFwFFw8c1IT9FyFSQOiI1l24I1a7o=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DS7PR21MB3366.namprd21.prod.outlook.com (2603:10b6:8:82::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.11; Mon, 23 Oct 2023 16:47:34 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::d76f:495c:b9f6:5caf]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::d76f:495c:b9f6:5caf%6]) with mapi id 15.20.6954.003; Mon, 23 Oct 2023
 16:47:34 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "elena.reshetova@intel.com" <elena.reshetova@intel.com>,
        "isaku.yamahata@intel.com" <isaku.yamahata@intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        Dexuan Cui <decui@microsoft.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
Subject: RE: [PATCH 00/10] Handle set_memory_XXcrypted() errors
Thread-Topic: [PATCH 00/10] Handle set_memory_XXcrypted() errors
Thread-Index: AQHaATgU1SKIcgO1qEWZEcRffoxgHrBRTisAgAAwCQCABgjKgA==
Date:   Mon, 23 Oct 2023 16:47:33 +0000
Message-ID: <BYAPR21MB16883646AA820D5FD7EA2C1AD7D8A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20231017202505.340906-1-rick.p.edgecombe@intel.com>
 <BYAPR21MB1688075D6262FAA18941E40AD7D4A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <73b02835-dbd6-4662-91f9-e8324d8cbf98@intel.com>
In-Reply-To: <73b02835-dbd6-4662-91f9-e8324d8cbf98@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b9db1ab3-af79-4125-bcb1-a43025beaf43;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-10-23T15:22:20Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DS7PR21MB3366:EE_
x-ms-office365-filtering-correlation-id: 64ad2cb2-891a-4ea3-1f75-08dbd3e7c16b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1cSCYSiqOTibxJRjPfZzHlc02+x4aJUiPZ+uBhQf90dQZBXecWDzJPjZPXDCb05mTQkiFQecBDm4EuiwkjYEQYhfKYX3QL8+59Iu6UEIn432IJV/hN0gxjpfWPxdQi1/axOWaCrlV5UOSxVtnuoUAHAQEEXydmTjAmz7r7vL1unCDM/R7sw2f7NzI/NEYXATx25myhMwEOxWClL9rqID3I8tAUkcYV+PKgzlKDrhjGiWA6ymC7yY+y4XyZmB5Uo6gcEQN5aMlZGbHIPMTFVV+jjF6W/4F2CBScIb2CUG21QLhVDwOUfjn4RDnMvA04SOhpT6/1FCeSTfaH5kt0U7jeQrt/eqdGJNCYidYVAkMw+SRqUIRDFM3/7o6VvQNKt1sGe/els+Uygxxtn323HVKjFO/iQRg3iWT58p/RYxx3J5rRC3FCXF5D1Hugcx1dWOc5PkTbaYWWf8k6c+pDhBw/OKx+49GgKoL8O5YTf790DS7XOA/NKGZih2msM/a1RbfFLxCIVli8nEC/409GHrHYz+NcBYbI+mdCWVskH3iHR1gQzrEefP9gkBIA8mvDaAQI9a8Nxc+UxiRLSkZcT0p/F2iQY7JLwSDjZA5ICXltzk3j1JXAGK8xmEwf9D/wJJBpS2X9vVO8TAX2tn9qCJSHotwa2sJjs2qRr87ssn6zzvNuC27MsEd/mdrEI5CRU4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(7416002)(55016003)(2906002)(5660300002)(52536014)(316002)(8990500004)(66446008)(66476007)(66556008)(64756008)(76116006)(8936002)(8676002)(41300700001)(66946007)(110136005)(82950400001)(38100700002)(122000001)(83380400001)(82960400001)(53546011)(6506007)(7696005)(9686003)(86362001)(33656002)(921008)(38070700009)(26005)(478600001)(10290500003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzRSKytCWVlHUE9HRTUxYzVCVG56ZzNXZWtZTHo0a05YQThLT0EvclBHVGRl?=
 =?utf-8?B?aHdIbDRyeTViTG55RGlDYVY0R09Vc1E1NklaSEM2VnhoRnJKV2tRc1NsUW5V?=
 =?utf-8?B?WDR6Z3AwV0dDOUJQam95Q0dlKzlkdjFLSFhDckNRN3ZPWFM3eVhMWW54NFpo?=
 =?utf-8?B?T2xnejNiQXRDUEw3ZE1mT3BOQlhmYnVvNDUyY3pBQXdiZ1BrVWgxandDNm9Z?=
 =?utf-8?B?aGdGa1p4S2tTbUFyRzVvY2tBcjFISDRGdTdXYzZ4eFRiU3crakh1OFVGRTJ6?=
 =?utf-8?B?U1lzSjExV0o0WTIwWHhGMXFnTmNoRUNOamlzYS9BNmh6Slh1OFhNMXlEVUxR?=
 =?utf-8?B?QmhLT0lpN1J0aWVHTEZwelpHSStvYmw1NU5rZUJkNHIzYklwZ0dFdDUwN09X?=
 =?utf-8?B?VWtVTU8wNE4wcU12aWJGU2lPenF2dTQ1N2RobW9FZEZ1bUZBMFJzYUh4RG5P?=
 =?utf-8?B?SjJlOE92TVlnaEpzZUZjUFJvMy9KeDNIOGF5eGlnRmh0WUpUNzVNN1dMM0d0?=
 =?utf-8?B?TmhNQUsrQWtqa0xmaUpWQ1NteFF0cWtkTFNBZko5enZ5Ylk5WEZlRWRtcm1J?=
 =?utf-8?B?Q3ZLdzNSSXN6RHJkTHFqSzZtODZ6MVFUVkNYd0ZFUHRic2RFME0zLzVsOVZQ?=
 =?utf-8?B?ZEZpYkNzWnRwMlZYSC9QZVVoSlRmNi9FbWlPbFE5b3Z3QnJoQlV0TlF1cTV3?=
 =?utf-8?B?aUhUcStySW5wTENHMXpPSDdIWlhvKzRLRmNROEtUak9RNCtYaERGOE9ScWZi?=
 =?utf-8?B?Zy9mVTdCYU1IM21PVnlma0FQVThoYjBFTFkvbGxRdVNSUWJHb1RlV1RJY1Mx?=
 =?utf-8?B?Wnl4c1VlekUzVE1VaDNNa014L2o1QjJ0NWM3LzhERXFmRHA0ZjBMZ1ByWTY3?=
 =?utf-8?B?dWJwQWZOSy8yS2FFTkphWlBsUHJWTWJ1ODFtb0VRc1ZIR1AyYUlJLzBvSlB1?=
 =?utf-8?B?N3lGMWt3WENuWDJLNEZLbEpnV1l5YmhiOUI3Y09tVEoyVC9LWEhNTUZVU1Jn?=
 =?utf-8?B?WmJZU2N2UUoxYlhSaFZlSzAwRkR3RS85akt1Q1FLYmRPc0lIRFlqWEQ2TWZp?=
 =?utf-8?B?clNlMG41SnNJbE5YYmg3LzhIUXNBN2RSaVpHcEwzUHQ5TE1YbElac1hxeGZE?=
 =?utf-8?B?MXBvdUdlZkcxNjVJYnZ3MHlEYklyencybk5oVlpHMEozVy9lRDlKY2dvMENH?=
 =?utf-8?B?VnZKL0NNN01MMms1N2RjRndPOUFQc1BOTHZPeWNDQU9BWG1BNHlyamQ3MzFM?=
 =?utf-8?B?YW1YdnJJL3gvSHR4OGtCeS9OaFp0MGZtVTBQWWdxZklMRFMySVpZemU2WnBu?=
 =?utf-8?B?elducGVudDBadzUxb2hJdjBibDJ4VnhkMm90MG83b29kbkpkcmZ2cjhtbnl1?=
 =?utf-8?B?YXI1V0I1Y2JvcVZtdWswSHNWQ25iN2c5MGtjK0x2cTRRN2ExakpJNEMxbnVx?=
 =?utf-8?B?bGJQSHgwOEdNclJIN01ETUxDb3lKQVJ3UlMxalRNSEUxOFZQUU5nZlVkc0Fl?=
 =?utf-8?B?Q2ZOMVJ5OS96Q0txSDU3cEV5UEFMSkdGMnJ0TEkzYUw4RFdreDdCUkN3Q1Vl?=
 =?utf-8?B?NXM3aE1NMUpkQ1RzdS9udVp0S3pCa0pZeldhV3dGNStpUjR1WFVUaDVjc3Jy?=
 =?utf-8?B?U0FVQzJTaEljUjdEMUtIcTZOQm52ZHhIYVhVaUFQL0xBb1dKZXh5SlFyZkpz?=
 =?utf-8?B?MURBYmlqbVBZaGJnTkc2NEs1NUpFbnFaS3lKUEFqTllmZUpMTlpaVGk5dnNS?=
 =?utf-8?B?aU5odVVOTmJnZ3JmVTVjSzU1TFNqVkdEeTBKSWpxSUZiYkU3cndTaCtVejhQ?=
 =?utf-8?B?M3FXZktYYzRKOEFTTzRNOURJdVl5ZUJNcG82WEVvSURMNEpSbEk0djlpdnds?=
 =?utf-8?B?TFF3cXJES2hoRHJOOTRIUG9PK0kva1dyZkM4bXljNWtWNlh0dnFJckdiUzZs?=
 =?utf-8?B?WDhjZGFxRUJ0U2FXRlhuTDJKK1FIc010OFRNVGI1NVNIS3RXRzJRM1Q3MGx0?=
 =?utf-8?B?MEIyc2dPR3FacjBnWVlQaWFyc2ZMKzI4eU9WWTZNZnMxNEFTdW9xY3NENlpk?=
 =?utf-8?B?MzJLbTE1R0h3TWszc21zY09MUzRSMGpBYm1lZlB0K3g2RndOZDhxR1Vpd0tG?=
 =?utf-8?B?MkhXQzZMbnAzSDRNYzVBdjQ5TnVwcWtRYSs2WGdFZzFhV21ZOGhCeFVNdk9x?=
 =?utf-8?B?RUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ad2cb2-891a-4ea3-1f75-08dbd3e7c16b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 16:47:33.8672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UgKBqXV++wKry9lVvTN36FpcRxn/eSF4HdA4/6GD2WFz/oiovB2Z7N4L0s7M8WzRAfyOpLomebHmhTURvgYGLubPBfCbJpugy8sXh0pau+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3366
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGludGVsLmNvbT4gU2VudDogVGh1cnNkYXks
IE9jdG9iZXIgMTksIDIwMjMgMTI6MTMgUE0NCj4gDQo+IE9uIDEwLzE5LzIzIDEwOjA1LCBNaWNo
YWVsIEtlbGxleSAoTElOVVgpIHdyb3RlOg0KPiA+IEknbSBtb3JlIGluIGZhdm9yIG9mIHRoZSAi
c2ltcGx5IHBhbmljIiBhcHByb2FjaC4gICBXaGF0IHlvdSd2ZSBkb25lDQo+ID4gaW4geW91ciBQ
YXRjaCAxIGFuZCBQYXRjaCAyIGlzIGFuIGludHJpZ3Vpbmcgd2F5IHRvIHRyeSB0byBnZXQgdGhl
IG1lbW9yeQ0KPiA+IGJhY2sgaW50byBhIGNvbnNpc3RlbnQgc3RhdGUuICBCdXQgSSdtIGNvbmNl
cm5lZCB0aGF0IHRoZXJlIGFyZSBmYWlsdXJlDQo+ID4gbW9kZXMgdGhhdCBtYWtlIGl0IGxlc3Mg
dGhhbiAxMDAlIGZvb2xwcm9vZiAobW9yZSBvbiB0aGF0IGJlbG93KS4gIElmDQo+ID4gd2UgY2Fu
J3QgYmUgc3VyZSB0aGF0IHRoZSBtZW1vcnkgaXMgYmFjayBpbiBhIGNvbnNpc3RlbnQgc3RhdGUs
IHRoZW4gdGhlDQo+ID4gb3JpZ2luYWwgcHJvYmxlbSBpc24ndCBmdWxseSBzb2x2ZWQuICAgSSdt
IGFsc28gbm90IHN1cmUgb2YgdGhlIHZhbHVlIG9mDQo+ID4gaW52ZXN0aW5nIGVmZm9ydCB0byBl
bnN1cmUgdGhhdCBzb21lIGVycm9ycyBjYXNlcyBhcmUgaGFuZGxlZCB3aXRob3V0DQo+ID4gcGFu
aWMnaW5nLiAgVGhlIHVwc2lkZSBiZW5lZml0IG9mIG5vdCBwYW5pYydpbmcgc2VlbXMgc21hbGwg
Y29tcGFyZWQgdG8NCj4gPiB0aGUgZG93bnNpZGUgcmlzayBvZiBsZWFraW5nIGd1ZXN0IFZNIGRh
dGEgdG8gdGhlIGhvc3QuDQo+IA0KPiBwYW5pYygpIHNob3VsZCBiZSBhIGxhc3QgcmVzb3J0LiAg
V2UgKmFsd2F5cyogY29udGludWUgdW5sZXNzIHdlIGtub3cNCj4gdGhhdCBzb21ldGhpbmcgaXMg
c28gYmFkIHRoYXQgd2UncmUgZ29pbmcgdG8gbWFrZSB0aGluZ3Mgd29yc2UgYnkNCj4gY29udGlu
dWluZyB0byBydW4uDQo+IA0KPiBXZSBzaG91bGRuJ3QgcGFuaWMoKSBvbiB0aGUgZmlyc3QgbGl0
dGxlIHRoaW5nIHRoYXQgZ29lcyB3cm9uZy4gIElmDQo+IGZvbGtzIHdhbnQgKnRoYXQqLCB0aGVu
IHRoZXkgY2FuIHNldCBwYW5pY19vbl93YXJuLg0KPiANCj4gPiBNeSBjb25jZXJuIGFib3V0IFBh
dGNoZXMgMSBhbmQgMiBpcyB0aGF0IHRoZSBlbmNyeXB0aW9uIGJpdCBpbiB0aGUgUFRFDQo+ID4g
aXMgbm90IGEgcmVsaWFibGUgaW5kaWNhdG9yIG9mIHRoZSBzdGF0ZSB0aGF0IHRoZSBob3N0IHRo
aW5rcyB0aGUgcGFnZSBpcw0KPiA+IGluLiAgQ2hhbmdpbmcgdGhlIHN0YXRlIHJlcXVpcmVzIHR3
byBzdGVwcyAoaW4gZWl0aGVyIG9yZGVyKTogIDEpIHVwZGF0aW5nDQo+ID4gdGhlIGd1ZXN0IFZN
IFBURXMsIGFuZCAyKSB1cGRhdGluZyB0aGUgaG9zdCdzIHZpZXcgb2YgdGhlIHBhZ2Ugc3RhdGUu
DQo+ID4gQm90aCBzdGVwcyBtYXkgYmUgZG9uZSBvbiBhIHJhbmdlIG9mIHBhZ2VzLiAgSWYgIzIg
ZmFpbHMsIHRoZSBndWVzdA0KPiA+IGRvZXNuJ3Qga25vdyB3aGljaCBwYWdlcyBpbiB0aGUgYmF0
Y2ggd2VyZSB1cGRhdGVkIGFuZCB3aGljaCB3ZXJlDQo+ID4gbm90LCBzbyB0aGUgZ3Vlc3QgUFRF
cyBtYXkgbm90IG1hdGNoIHRoZSBob3N0IHN0YXRlLiAgSW4gc3VjaCBhIGNhc2UsDQo+ID4gc2V0
X21lbW9yeV9lbmNyeXB0ZWQoKSBjb3VsZCBzdWNjZWVkIGJhc2VkIG9uIGNoZWNraW5nIHRoZQ0K
PiA+IFBURXMgd2hlbiBpbiBmYWN0IHRoZSBob3N0IHN0aWxsIHRoaW5rcyBzb21lIG9mIHRoZSBw
YWdlcyBhcmUgc2hhcmVkLg0KPiA+IFN1Y2ggYSBtaXNtYXRjaCB3aWxsIHByb2R1Y2UgYSBndWVz
dCBwYW5pYyBsYXRlciBvbiBpZiB0aGUgcGFnZSBpcw0KPiA+IHJlZmVyZW5jZWQuDQo+IA0KPiBJ
IHRoaW5rIHRoYXQncyBPSy4gIEluIHRoZSBlbmQsIHRoZSBwYWdlIHN0YXRlIGlzIGNvbnRyb2xs
ZWQgYnkgdGhlIFZNTS4NCj4gIFRoZSBndWVzdCBoYXMgemVybyBjb250cm9sLiAgQWxsIGl0IGNh
biBkbyBpcyBtYWtlIHRoZSBQVEVzIGNvbnNpc3RlbnQNCj4gYW5kIGhvbGQgb24gZm9yIGRlYXIg
bGlmZS4gIFRoYXQncyBhIGdlbmVyYWwgc3RhdGVtZW50IGFuZCBub3Qgc3BlY2lmaWMNCj4gdG8g
dGhpcyBwcm9ibGVtLg0KPiANCj4gSW4gb3RoZXIgd29yZHMsIGl0J3MgZmluZSBmb3IgQ29DbyBm
b2xrcyB0byBiZSBwYXJhbm9pZC4gIEl0J3MgZmluZSBmb3INCj4gdGhlbSB0byBzZXQgcGFuaWNf
b25fe3dhcm4sb29wcyx3aGF0ZXZlcn09MS4gIEJ1dCBpdCdzICpOT1QqIGZpbmUgdG8gc2F5DQo+
IHRoYXQgZXZlcnkgVERYIGd1ZXN0IHdpbGwgd2FudCB0byBkbyB0aGF0Lg0KDQpUaGUgcHJlbWlz
ZSBvZiB0aGlzIHBhdGNoIHNldCBpcyB0byBub3QgcHV0IHBhZ2VzIG9uIHRoZSBMaW51eA0KZ3Vl
c3QgZnJlZSBsaXN0IHRoYXQgYXJlIHNoYXJlZC4gIEkgYWdyZWUgd2l0aCB0aGF0IHByZW1pc2Uu
ICBCdXQNCm1vcmUgcHJlY2lzZWx5LCB0aGUgYmVzdCB3ZSBjYW4gZG8gaXMgbm90IHB1dCBwYWdl
cyBvbiB0aGUgZnJlZQ0KbGlzdCB3aGVyZSB0aGUgZ3Vlc3QgUFRFIGluZGljYXRlcyAic2hhcmVk
Ii4gIEV2ZW4gaWYgdGhlIGhvc3QgaXMNCm5vdCBhY3RpbmcgbWFsaWNpb3VzbHksIGVycm9ycyBj
YW4gY2F1c2UgdGhlIGd1ZXN0IGFuZCBob3N0IHRvIGJlDQpvdXQtb2Ytc3luYyByZWdhcmRpbmcg
YSBwYWdlJ3MgcHJpdmF0ZS9zaGFyZWQgc3RhdHVzLiAgVGhlcmUncyBubw0Kd2F5IHRvIGZpbmQg
b3V0IGZvciBzdXJlIGlmIHRoZSBob3N0IHN0YXR1cyBpcyAicHJpdmF0ZSIgYmVmb3JlDQpyZXR1
cm5pbmcgc3VjaCBhIHBhZ2UgdG8gdGhlIGZyZWUgbGlzdCwgdGhvdWdoIGlmDQpzZXRfbWVtb3J5
X2VuY3J5cHRlZCgpIHN1Y2NlZWRzIGFuZCB0aGUgaG9zdCBpcyBub3QNCm1hbGljaW91cywgd2Ug
c2hvdWxkIGJlIHJlYXNvbmFibHkgc2FmZS4NCg0KRm9yIHBhcmFub2lkIENvQ28gVk0gdXNlcnMs
IHVzaW5nIHBhbmljX29uX3dhcm49MSBzZWVtcw0Kd29ya2FibGUuICBIb3dldmVyLCB3aXRoIGN1
cnJlbnQgY29kZSBhbmQgdGhpcyBwYXRjaCBzZXJpZXMsDQppdCdzIHBvc3NpYmxlIGhhdmUgc2V0
X21lbW9yeV9kZWNyeXB0ZWQoKSByZXR1cm4gYW4gZXJyb3IgYW5kDQpoYXZlIHNldF9tZW1vcnlf
ZW5jcnlwdGVkKCkgZml4IHRoaW5ncyB1cCBhcyBiZXN0IGl0IGNhbiANCndpdGhvdXQgZ2VuZXJh
dGluZyBhbnkgd2FybmluZ3MuICBJdCBzZWVtcyBsaWtlIHdlIG5lZWQgYQ0KV0FSTiBvciBzb21l
IGVxdWl2YWxlbnQgbWVjaGFuaXNtIGlmIGVpdGhlciBvZiB0aGVzZSBmYWlscywNCnNvIHRoYXQg
Q29DbyBWTXMgY2FuIHBhbmljIGlmIHRoZXkgZG9uJ3Qgd2FudCB0byBydW4gd2l0aCBhbnkNCmlu
Y29uc2lzdGVuY2llcyAoYWdhaW4sIGFzc3VtaW5nIHRoZSBob3N0IGlzbid0IG1hbGljaW91cyku
DQoNCkFsc28sIGZyb20gYSB0cm91Ymxlc2hvb3Rpbmcgc3RhbmRwb2ludCwgcGFuaWNfb25fd2Fy
bj0xDQp3aWxsIG1ha2UgaXQgZWFzaWVyIHRvIGRpYWdub3NlIGEgZmFpbHVyZSBvZg0Kc2V0X21l
bW9yeV9lbmNyeXB0ZWQoKS9kZWNyeXB0ZWQoKSBpZiBpdCBpcyBjYXVnaHQNCmltbWVkaWF0ZWx5
LCB2ZXJzdXMgcHV0dGluZyBhIHBhZ2Ugd2l0aCBhbiBpbmNvbnNpc3RlbnQgc3RhdGUgDQpvbiB0
aGUgZnJlZSBsaXN0IGFuZCBoYXZpbmcgdGhpbmdzIGJsb3cgdXAgbGF0ZXIuDQoNCk1pY2hhZWwN
Cg==
