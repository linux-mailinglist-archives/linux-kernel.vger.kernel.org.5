Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0165A7D9E17
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 18:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjJ0Qhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 12:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjJ0Qhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 12:37:35 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2109.outbound.protection.outlook.com [40.107.223.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E220C128
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 09:37:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uxl498qPABE1mFgzBr2rbBydeqGfIIIqy0uCtoQH9pM2KuDhTqZ9MAeIIlQmRWPVnoOgsPNO1AujMIGmV/7JHoE2Yx21dIv/tr+zTNxdEPtfCKA9fZ76xqt2A6dmOZTdaTQ+lii7R62VFbNpv0Jg7eH7pbcButVNo91W5n4hTgSzje4orZxBSboNu0H/oRG2DBBDkfdn6EH8K26R6GxQzk2rBcH/OtwSw3ZIJh1g+r8fkPYoVJJQ++g4MVIv50g9bodFUmgmqCKhDuXzrmYIFj64PU8JkNeyTrN0UV5JlCGR8flwElm9MAvzU9e7CuQ3uOqNxwJiYJm3UnltgLO9rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gPJazHxcJ/Nmi74aj86XiaSjYVQhFrecAof5k0FUjI=;
 b=CYxSMHgJ3K2lReoPliG/fpkdZsVNtm+2e3IAVbUbGGktirXYgD+9qFKutAEsmqunwfttjjU1TL6QUFEQ71UdgtA3yMR2O0mXq2ON2VWl943w2fZtf54ZMkymRyUAV3MBmZNO1fLQaBSUH+uNoYrPml7LugxLsOSv/eFcBJBdNWZ6yx+lBxpmlFzYdVyQGeSLC1YxoytSGImSiuNrAsDupN2GYlEnoxLEi/oVmR2EaagiD1BoEqhPdO7aHVohMC5H3Ba4jhibTMJkXGzBx8Jsq8F4Cwr1xFflOk/ExG4uEwyLpvWGZ9MAjQDPHTy72aBrBAolP6eziTZBwm24OQxh3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gPJazHxcJ/Nmi74aj86XiaSjYVQhFrecAof5k0FUjI=;
 b=VEb6ba0E+/Ck7kETDG2mX+fyjp8e8IQY07guVKhZhGT/1qL39lQ4Zsr7H9jO+b9e0pbCmsun7fctBznVSJReyRuRTLbuQY1p3VxlVYUbPufUwAassGc2UFTyfGU/jANqly3+4gQJ7qh9NyAiLyrgqh08emxnDHTRwFi6CbO+0TA=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DM4PR21MB3609.namprd21.prod.outlook.com (2603:10b6:8:b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.11; Fri, 27 Oct
 2023 16:37:29 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1cab:1621:900d:fbc6]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1cab:1621:900d:fbc6%6]) with mapi id 15.20.6954.009; Fri, 27 Oct 2023
 16:37:29 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Dexuan Cui <decui@microsoft.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH] x86/mm/cpa: Warn if set_memory_XXcrypted() fails
Thread-Topic: [PATCH] x86/mm/cpa: Warn if set_memory_XXcrypted() fails
Thread-Index: AQHaBtSo1KeOz02diUCTmiNYqoVgMbBbLUcggAAf5wCAAoVioA==
Date:   Fri, 27 Oct 2023 16:37:29 +0000
Message-ID: <BYAPR21MB1688E43151404FFB435ACF41D7DCA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20231024234829.1443125-1-rick.p.edgecombe@intel.com>
         <SN6PR2101MB169309ACB83862DA6E572A89D7DDA@SN6PR2101MB1693.namprd21.prod.outlook.com>
 <fd2426ee900e4f3a57659f3688c5bb652779785c.camel@intel.com>
In-Reply-To: <fd2426ee900e4f3a57659f3688c5bb652779785c.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=112f0b14-555f-474b-86bb-499b3097937e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-10-27T16:10:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DM4PR21MB3609:EE_
x-ms-office365-filtering-correlation-id: f2ce7735-1e4c-4837-1ca0-08dbd70b0305
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fd9IURlexKLDYMnZi815lrui9qg8g7M4xSslnC05Q6cbJhc0oodfWRiLjms957eVgyUCNqRh6O5JevihOcWil45KN12jyxi3vCQ97wJkr9hlwDHvEgU6kZAEYB/AFj1lAZfND/1HmOLA9J/2xYOYwTQXTHDPsCs3JfsjFmGGnB1BQG3+KysD34O+MpPB/XzDkrIX/lOWrMYakwkKJ5kO5tMdzJwVjdF1uH0nTz/TdWrJbz1X0uw5RaTER6E1HN3iiERelHugMKbNsvLeic1TwkGeZPlbXIqYODfNLe5v4onW4Ss5ptT34iRfuU9jd5acpGyQloo2NssZMjeilvFQgJ0owyrNhnYWKnILJTPrvIAHHoyD74xkkpzdqIQ7BQz2Hvbm5/tER/SHP338VaClnTIt1Q+ctqOt+npKWOJznESwXOIUjDZNdOSUIoh+837WQOXd7+VPzqr95oc87478h+AHfzwO0JFPC9EdPUkcedXJuETgdb8I41QDsvGr9TxBTZAdNc0gFtAPRr6L1RwRylynWsVAtraJ/SxOYf6K161Nlw1svnXzu/hTOi4udD04mQhljzhXf5+c1qMNReYPeAVtlKCOf9vwn7wQUjBUInAzjo9bY8VEGJleuwUD37/MEcM40R3wzS3WTcezWIsx1B4KbuMiifWgbXXw5PSWjb678qbO/w/39j8YAbvCwqJ9oP7DW9XhP9SCLJkdinIY9AgccDqMIj/iuaw0LOeP1UI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(376002)(396003)(366004)(230922051799003)(230373577357003)(230473577357003)(451199024)(64100799003)(186009)(1800799009)(66899024)(82960400001)(82950400001)(6506007)(9686003)(7696005)(10290500003)(478600001)(5660300002)(7416002)(8990500004)(2906002)(33656002)(4001150100001)(86362001)(921008)(38070700009)(41300700001)(64756008)(66556008)(76116006)(66446008)(66476007)(66946007)(316002)(110136005)(52536014)(8676002)(8936002)(66574015)(83380400001)(38100700002)(26005)(71200400001)(55016003)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXhsb0N1OW5TMm91UEVBY3dVbXFMeFpOazFRQWYrenJnck5UbzJJRHFpQVFq?=
 =?utf-8?B?MUFDdVVKaGdJT01xbTEySDVQMUh5VHpHa3VBZXVvN21TK1lHTGEvQS8ybmJ2?=
 =?utf-8?B?S2NPZ1NJSGY1RXBDcWlXSDNtTUd3WkJjOGl2d3kwYWlPRlJrbHdnelUwYnVY?=
 =?utf-8?B?ZUxVMStwOFpkUkdsOFkrSnVUanI4MXZJYU84Rm1neFhnSmlGNFVocm9nU2ti?=
 =?utf-8?B?K0E5cDhlOWlnMTJ4U2xYWVlzTlZmaHkxdVFFSVk3NFdNeGZxYk90ZWI4UVR6?=
 =?utf-8?B?ODByUWJEb2cvZFhXeENtelBlMzZNZFVieWptVHR4THpMeklyajc4SVVnRlRE?=
 =?utf-8?B?MG8vWS8wMGxaTUliQnl0UzFHclJhWWx1Z2VMaEJoZXdFMWE5alE0RXZJN3p3?=
 =?utf-8?B?SFA0SzhFTzJMN0dVUzAreisrOHRqVXRMMWpwcnUrWG8xL0V1aVJ5V09iVXZ6?=
 =?utf-8?B?c2k0WW5MS25LL1k3TkUxcjVVUFYrbDFxVkRZUG1vUnhkK015RkRpZWsvei84?=
 =?utf-8?B?NkYvSEZpWXZQQ2xNcnJoaDRqdHEvMWdPbVRwYmovOHhhN2J6WEtaRmZBUjRm?=
 =?utf-8?B?NEpVaUVUNmVncFJMUHdPTEJDMmZwWUlCR0hGSmUwQUhkamxWaWNWbjY3eFJu?=
 =?utf-8?B?dmlORDkwUkhaZzFmSGoxbGtRNmowQVMrRzNZSEFrRmN4Y3F5UHdhVDV5RlVF?=
 =?utf-8?B?dUdMclpBalBubjg0Zys3NEhKTUQ5SHMzSFBlcnNuQWhKV0dtVUZ4OFY0L3Rx?=
 =?utf-8?B?QUpWdFZIYm5MMW5YSjgyNFVmS0lYcm5mSnlTSXVGcnJybFNkQVlicXFnR1lU?=
 =?utf-8?B?TGVBRWJNaC9MTDd0OUZLMUVIaXkySFlvZjNyYTk1aDhtVDJqWGhHMTYzN2c5?=
 =?utf-8?B?UkpMd0o5NVkwbVFHd05DakdvaTNvWGNmMmcxQ2ZzL0M4NlJJVVpERFdkK2h5?=
 =?utf-8?B?YlFPbngxRE9jMlMxenp3S3BXM0M0M0dZTjQ0akNLWVMraXhWU2pHWkVGTDY1?=
 =?utf-8?B?VzZhd0hqTkUrSExVczRVeTRZVUp5NW9BWTZhWjFCd0NiNVRyTHVSa2l4M3Iv?=
 =?utf-8?B?bE9ZS1FYczdseW9FSWREOU11OEJNalVhWGd4ME9wYTM5WkcwRVJXclN3MTlo?=
 =?utf-8?B?Um8yMTcvK0N0VHdkZlFRYWQ0L2lPK1BQcVRZSjJuMjdNeXFmUFpBa0F3SlBw?=
 =?utf-8?B?RlN6dlcwK3dqcWlST3VxM2dTTkNMZW5IYWo1NDgxcEFiMnZaSXBmaU9VOHZp?=
 =?utf-8?B?L01YTkhtRHJqcCtMUys1YUlvOGMrWDk3TVVEdGJjNVUwNGtxT0E2ZFNTdktz?=
 =?utf-8?B?YUIyNjEvQ0I1cDNFK0FQNUwyNGw3VnY0cmVlUFpQMWFkN0VBcW9TM29SQW5B?=
 =?utf-8?B?NHJEdFB5OHJiay92YWEyQkNEWmE2ZU9wWmhjb2grTy9pdCtZUHo4WlA1WVlj?=
 =?utf-8?B?REZ2dk5GUitFSGJ3RWd4azlNZS91TW9hbHBSaW5wSjBWRDFRVnFSWFRHYUNB?=
 =?utf-8?B?TC85dmxrbkNkVkR0VXczWWZwYlRpUnNXZnYwSHhQYlZLTVV3YVNnSUlMVk8x?=
 =?utf-8?B?RWVhT253WS91TWJUb2Z1Y2V2NThJWFRmV29yV2JtbWpYb0NrN29Xc3dIbkxl?=
 =?utf-8?B?OC9BYndvTHlxOWpobTZBZ2ExbTZhQWRxNlR1OGhvQ1REcmRYalc1ajdMMVBX?=
 =?utf-8?B?dE9INE05Y3UvQlhuUFg4STJNS1liMmVNclZVVE9lUWUzN3VjVWtuYmJuNWwy?=
 =?utf-8?B?UnVodVA0a0hkaHBtSEFKWmVJcG85K0NjSVgweHdWbmJuM0c5RUFIL25CeWRI?=
 =?utf-8?B?VENEdENjL1U0bzZBMnBUZWRkT3Nvb0p6M0IxOHdDQkxZV05rMTZnUXlhV1U1?=
 =?utf-8?B?d3V4ZklVcjJkbW5KUXRDazU2T1hVTzNXK2RaQVUvSk1VNFF2Qlo3SmhJcnIr?=
 =?utf-8?B?em9PNWR3MWpROXdWY0VjRzdQcm5Jb2UvMXJXUkdScU9LSFQ0VmJOV1dtTmxI?=
 =?utf-8?B?Zzg4bGp0TGlISUc5eUdUekJnYXUzd2ZlaFJvSEx4UVczZlR5ZjE2NmdGdjBG?=
 =?utf-8?B?QW1maGk5YlFKdXc4c0NjK2o1QStOV1hhajFyODZDeUkvYXNhaUpFL0F6cmJT?=
 =?utf-8?B?dGNVTnM5dEhKNDlBVnViTEg1cVAxRElLVS9xV05Tcm44TFRwV2RIRDIreVNq?=
 =?utf-8?B?U0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ce7735-1e4c-4837-1ca0-08dbd70b0305
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 16:37:29.8194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ijtuH3omk71bg48aevKkUVJJHIPliKRgojUI6iKFtxt97wki4YQT0GIOnUfIQMsbgmSsqLD995pk75GqV41CitKKeUNvDIe87YlVGcDfHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3609
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRWRnZWNvbWJlLCBSaWNrIFAgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPiBTZW50
OiBXZWRuZXNkYXksIE9jdG9iZXIgMjUsIDIwMjMgNjo0MSBQTQ0KPiANCj4gT24gVGh1LCAyMDIz
LTEwLTI2IGF0IDAwOjM1ICswMDAwLCBNaWNoYWVsIEtlbGxleSAoTElOVVgpIHdyb3RlOg0KPiA+
IEkgdGhpbmsgeW91IG1lYW4gInNoYXJlZCIgYXMgaW5kaWNhdGVkIGJ5IHRoZSBndWVzdCBwYWdl
IHRhYmxlcyAodnMuInNoYXJlZCINCj4gPiBhcyB0aGUgc3RhdGUgb2YgdGhlIHBhZ2UgZnJvbSB0
aGUgaG9zdCBzdGFuZHBvaW50KS7CoCBTb21lIHByZWNpc2lvbiBvbg0KPiA+IHRoYXQgZGlzdGlu
Y3Rpb24gc2VlbXMgdXNlZnVsIGhlcmUgYW5kIGluIGZvbGxvdy1vbiBwYXRjaGVzIHRvIG1ha2Ug
Y2FsbGVycycNCj4gPiBlcnJvciBoYW5kbGluZyBiZSBjb3JyZWN0LsKgwqAgQXMgSSB1bmRlcnN0
YW5kIGl0LCB0aGUgcHJlbWlzZSBpcyB0aGF0DQo+ID4gaWYgdGhlIGd1ZXN0IGlzIGFjY2Vzc2lu
ZyBhIHBhZ2UgYXMgcHJpdmF0ZSwgYW5kIHRoZSBob3N0L1ZNTSBoYXMgbWVzc2VkDQo+ID4gYXJv
dW5kIHdpdGggdGhlIHBhZ2UgcHJpdmF0ZS9zaGFyZWQgc3RhdHVzLCB0aGUgY29uZmlkZW50aWFs
aXR5IG9mIHRoZQ0KPiA+IFZNIGlzIHByb3RlY3RlZC7CoCBUaGUgcmlzayBvZiBsZWFrYWdlIG9j
Y3VycyB3aGVuIHRoZSBndWVzdCBpcyBhY2Nlc3NpbmcNCj4gPiBhIHBhZ2UgYXMgc2hhcmVkLCBz
byBrZXJuZWwgY29kZSBtdXN0IGd1YXJkIGFnYWluc3QgcHV0dGluZyBtZW1vcnkNCj4gPiBvbiB0
aGUgZnJlZSBsaXN0IGlmIHRoZSBndWVzdCBwYWdlIHRhYmxlcyBhcmUgbWFya2VkIHNoYXJlZC4N
Cj4gPg0KPiANCj4gRm9yIFREWCwgdGhlIHNjZW5hcmlvIG9mIGNvbmNlcm4gaW4gdGhlIFZNTSBl
cnJvciBjYXNlIGlzIGlmIHRoZSBwYWdlDQo+IGlzIG1hcHBlZCBhcyBzaGFyZWQgaW4gdGhlIGd1
ZXN0IHBhZ2UgdGFibGVzICphbmQqIGl0IGlzIGVpdGhlciBhbHNvDQo+IG1hcmtlZCBhcyBzaGFy
ZWQgaW4gdGhlIEVQVCwgb3IgdGhlIFZNTSBzdXBwb3J0cyBhdXRvbWF0aWNhbGx5DQo+IGNvbnZl
cnRpbmcgaXQgb24gYWNjZXNzLsKgSW4gdGhlIGF0dGFja2VyIHNjZW5hcmlvLCBJIHRoaW5rIHRo
ZSBwcm9ibGVtDQo+IGlzIGp1c3QgdGhhdCBpdCBpcyBtYXJrZWQgc2hhcmVkIGluIHRoZSBndWVz
dC4NCg0KQWdyZWVkLg0KDQo+IA0KPiBJIGNhbiBjbGFyaWZ5IHRoYXQgaXQgbmVlZHMgdG8gYmUg
bWFwcGVkIHNoYXJlZCBpbiB0aGUgZ3Vlc3QgZm9yIHRoZXJlDQo+IHRvIGJlIGEgcHJvYmxlbSwg
YnV0IEkgZG9uJ3Qgc2VlIGhvdyBpdCB3aWxsIGhlbHAgdGhlIHBhdGNoZXMgdG8gZml4DQo+IHRo
ZSBjYWxsZXJzLiBJdCBzZWVtcyBsaWtlIHRvbyBtYW55IGRldGFpbHMgZm9yIHRoZSBjYWxsZXJz
IHRvIGtub3cNCj4gYWJvdXQuIEZvciBleGFtcGxlLCBJIHRoaW5rIHNvbWUgYXJjaGl0ZWN0dXJl
cyBkb24ndCBjaGFuZ2UgdGhlIFBURXMgYXQNCj4gYWxsLiBUaGUgY2FsbGVycyBhYnN0cmFjdCBz
aGFyZWQgYW5kIHByaXZhdGUgYXQgYSBoaWdoZXIgbGV2ZWwuDQo+IA0KDQpXaGVuIGEgY2FsbGVy
IGdldHMgYW4gZXJyb3IgZnJvbSBzZXRfbWVtb3J5X2RlY3J5cHRlZCgpLCBpdCB3aWxsDQp0YWtl
IHN0ZXBzIHRvIHRyeSB0byBnZXQgdGhlIG1lbW9yeSBiYWNrIGludG8gYSAiZ29vZCIgc3RhdGUg
c28NCnRoYXQgaXQgY2FuIHB1dCB0aGUgbWVtb3J5IGJhY2sgb24gdGhlIGZyZWUgbGlzdC4gICBJ
ZiBpdCBjYW4ndCBnZXQNCnRoZSBtZW1vcnkgYmFjayBpbnRvIGEgZ29vZCBzdGF0ZSwgdGhlbiBp
dCB3aWxsIGxlYWsgdGhlIG1lbW9yeS4NCkkgd2FzIHRoaW5raW5nIGFib3V0IGhvdyB0aGUgY2Fs
bGVyIHdpbGwgbWFrZSB0aGF0IGRldGVybWluYXRpb24uDQpJcyBpdCBiYXNlZCBvbiB3aGV0aGVy
IHNldF9tZW1vcnlfZW5jcnlwdGVkKCkgc3VjY2VlZHM/ICBJIHRoaW5rDQp0aGF0IHdvcmtzLCBh
cyBsb25nIGFzIChmb3IgeDg2IGF0IGxlYXN0KSBzZXRfbWVtb3J5X2VuY3J5cHRlZCgpDQplbnN1
cmVzIHRoYXQgdGhlIGd1ZXN0IFBURXMgYXJlIGFsbCBtYXJrZWQgInByaXZhdGUiIGJlZm9yZSBp
dA0KcmV0dXJucyBzdWNjZXNzLg0KDQpTbyBtYXliZSBteSBjb21tZW50IGFwcGxpZXMgdG8gdGhl
IGNhbGxlciBpbiB0aGUgc2Vuc2Ugb2YNCnVuZGVyc3RhbmRpbmcgd2hhdCBzdGVwcyB0aGUgY2Fs
bGVyIHNob3VsZCB0YWtlIHRvIHJlY292ZXIgZnJvbQ0KYW4gZXJyb3IsIGFuZCB0aGUgcG9zc2li
bGUgb3V0Y29tZXMgZnJvbSB0aGUgYXR0ZW1wdGVkIHJlY292ZXJ5Lg0KDQo+IA0KPiA+IFRvIG1l
LCB0aGlzIHNlbnRlbmNlIGRvZXNuJ3QgZnVsbHkgY2hhcmFjdGVyaXplIHdoeSBwYW5pY19vbl93
YXJuDQo+ID4gd291bGQgYmUgdXNlZC7CoCBZb3UgZGVzY3JpYmUgb25lIHJlYXNvbiwgd2hpY2gg
aXMgYSBjYWxsZXIgdGhhdCBmYWlscyB0bw0KPiA+IHByb3Blcmx5IGhhbmRsZSBhbiBlcnJvciBh
bmQgaW5jb3JyZWN0bHkgcHV0cyBtZW1vcnkgd2l0aCBhICJzaGFyZWQiDQo+ID4gZ3Vlc3QgUFRF
IG9uIHRoZSBmcmVlIGxpc3QuwqAgQnV0IGdldHRpbmcgYW4gZXJyb3IgYmFjayBhbHNvIGltcGxp
ZXMgdGhhdA0KPiA+IHNvbWV0aGluZyB1bmtub3duIGhhcyBnb25lIHdyb25nIHdpdGggdGhlIENv
Q28gbWVjaGFuaXNtIGZvcg0KPiA+IG1hbmFnaW5nIHByaXZhdGUgdnMuIHNoYXJlZCBwYWdlcy7C
oCBTZWN1cml0eSBmb2N1c2VkIHVzZXJzIHdvdWxkIG5vdA0KPiA+IHRha2UgdGhlIHJpc2sgb2Yg
Y29udGludWluZyB0byBvcGVyYXRlIHdpdGggdGhhdCBraW5kIG9mIHVua25vd24NCj4gPiBlcnJv
ciBpbiB0aGUgY29yZSBtZWNoYW5pc20gb2YgYSBDb0NvIFZNLg0KPiANCj4gSG1tLCB5ZWEgSSBj
b3VsZCBzZWUgdGhhdCBzb21lIHVzZXJzIG1heSB3YW50IHRvIHRha2UgYSBoYXJkIGxpbmUgYW5k
DQo+IHRlcm1pbmF0ZSBpZiBhbnl0aGluZyBsb29rcyBzdHJhbmdlLiBUaGUgY291bnRlciBwb2lu
dCBpcyB0aGF0IHRoZSBWTU0NCj4gaXMgYWN0dWFsbHkgcmV0dXJuaW5nIGEgbGVnYWwgZXJyb3Ig
aGVyZS4gSXQgbWF5IGJlIHN0cmFuZ2UgYmFzZWQgb24NCj4gdGhlIGRldGFpbHMgb2Ygd2hlbiBI
eXBlclYgYW5kIFFFTVUvS1ZNIHdvdWxkIHJldHVybiB0aGlzIGVycm9yLCBidXQNCj4gbm90IGFy
Y2hpdGVjdHVyYWxseS4NCj4gDQoNCkFncmVlZCwgaXQgbWF5IGJlIGEgbGVnYWwgZXJyb3IuICBC
dXQgZXZlbiB3aXRoIGxlZ2FsIGVycm9ycywgdGhlIGd1ZXN0DQpkb2Vzbid0IGtub3cgd2hldGhl
ciB0aGUgVk1NIGhhcyBsZWZ0IHRoZSBwYWdlIGluIGEgcHJpdmF0ZSBvcg0Kc2hhcmVkIHN0YXRl
LiAgIElmIHRoZSBndWVzdCBmaXhlcyB1cCBpdHMgUFRFcyB0byBhY2Nlc3MgdGhlIG1lbW9yeQ0K
YXMgcHJpdmF0ZSBhbmQgcHV0cyB0aGUgbWVtb3J5IGJhY2sgb24gdGhlIGZyZWUgbGlzdCwgdGhh
dCBjb3VsZA0KYmUgYSB0aW1lIGJvbWIgdGhhdCB3aWxsIGJsb3cgdXAgbGF0ZXIuICBNb3JlIHBh
cmFub2lkIGd1ZXN0cw0Kd2lsbCBwcmVmZXIgdG8gdGFrZSB0aGUgcGFuaWMgd2hlbiB0aGUgZXJy
b3IgaXMgZmlyc3QgcmVwb3J0ZWQuDQoNCj4gPg0KPiA+ID4gK3ZtbV9mYWlsOg0KPiA+ID4gK8Kg
wqDCoMKgwqDCoMKgV0FSTl9PTkNFKDEsICJDUEEgVk1NIGZhaWx1cmUgdG8gY29udmVydCBtZW1v
cnkgKGFkZHI9JXAsIG51bXBhZ2VzPSVkKSB0byAlcy5cbiIsDQo+ID4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgKHZvaWQgKilhZGRyLCBudW1wYWdlcywgZW5jID8gInByaXZh
dGUiIDogInNoYXJlZCIpOw0KPiA+DQo+ID4gSSdtIG5vdCBzdXJlIGFib3V0IG91dHB1dHRpbmcg
dGhlICJhZGRyIiB2YWx1ZS7CoCBJdCBjb3VsZCBiZQ0KPiA+IHVzZWZ1bCwgYnV0IHRoZSAlcCBm
b3JtYXQgc3BlY2lmaWVyIGhhc2hlcyB0aGUgdmFsdWUgdW5sZXNzIHRoZQ0KPiA+IGtlcm5lbCBp
cyBib290ZWQgd2l0aCAibm9faGFzaF9wb2ludGVycyIuwqDCoCBTaG91bGQgJXB4IGJlIHVzZWQN
Cj4gPiBzbyB0aGUgYWRkcmVzcyBpcyBvdXRwdXQgdW5tb2RpZmllZD8NCj4gDQo+IFVuZm9ydHVu
YXRlbHksIEkgZG9uJ3QgdGhpbmsgd2UgY2FuIHByaW50IHRoZSBrZXJuZWwgdmlydHVhbCBhZGRy
ZXNzDQo+IGJlY2F1c2UgdGhvc2UgYXJlIHN1cHBvc2VkIHRvIGJlIGhpZGRlbiBmb3Igc2VjdXJp
dHkgcmVhc29ucy4gSWRlYWxseSwNCj4gSSB3b3VsZCBwcmVmZXIgdG8gcHJpbnQgdGhlIFBGTiwg
YnV0IHdlIHdvbid0IGhhdmUgaXQgaGVyZSBpbiB0aGUgY2FzZQ0KPiBvZiB2bWFsbG9jJ3MuIEkg
dGhvdWdodCBpdCBtaWdodCBiZSB1c2VmdWwgdG8gc3RpbGwgaGF2ZSBzb21lIGFkZHJlc3MNCj4g
cHJpbnRlZCBmb3IgZGVidWdnaW5nIHB1cnBvc2VzLg0KPiANCg0KSSBkb24ndCBvYmplY3QgdG8g
ZWl0aGVyIGFwcHJvYWNoLiAgSSB3YXMgcmVhbGx5IGp1c3Qgbm90aW5nIHRoYXQNCndlIHdvbid0
IHNlZSB0aGUgYWN0dWFsIGtlcm5lbCB2aXJ0dWFsIGFkZHJlc3MuDQoNCk1pY2hhZWwNCg==
