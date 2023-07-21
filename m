Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9882375BD41
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 06:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjGUE1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 00:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjGUE1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 00:27:44 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020025.outbound.protection.outlook.com [52.101.61.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03978E43
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 21:27:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLkVVJJLcah53R5BLb847LS3nfRA50zOjmrCADvmSWcet//PjRoKcWncQOcaVFdS6Zqr/cthuhry8soo0JL23BZPK7+ujdm1xlqZp+CgiEvxbvXF3VcynknxS3D5AE7UOGXLZW88YiBCXuxg0xHGzdJzfUUq9nF4gn50whknGW1pubs6ex9NijxQfwN7bRrUFw2DdApAs+uGimc00SsaGywqVdmzs5ZP/4ncaQ4MtHd4ogPwEpcuW9JQjPAeRz+jg3FVfDjGvVp/fSo4s0Ta2BP6LE1OQVdgbRPYa3taVectlP0IkHM98NRo5M1D1nImgumQaf5irIB7Ts9dxrDRbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Wqosoj5MsNqI/B+MYvYptOESuzwfWf9aUINjtjRYjs=;
 b=nguEYuqiXFmAAejejt3+X5HnV95+nZHMvvd7bLurDvFPwgcIrXLGNjtLTua1wRshxvl/9EeOUAFq1tFU10N0dRjEAyr31gdhJhDdrpfmVZSfIautKAOMs9aldvsKZlvnfN4OG64QWlN3Dr8VOh5t5IQMNgSemOU1h0lNCERlKrHtfB1fzysffg6+et3YWOjPoPkQkGJeM9LjOdWEYucrZxahORIaWVV/BdA1VbOi9uqs8e7FxBDOBaWvmZXpjVbpkj+wMfLxMhEknH6Yw8so6WrB3i9fm3TEG8HdYKZU+kM12isaHaiYvtRMvlQiwEIuGSFRU/gLRVbgGb743P9QDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Wqosoj5MsNqI/B+MYvYptOESuzwfWf9aUINjtjRYjs=;
 b=Sb1AMFGbG3d0DwGqpCHtqX0vy7359QjGuPSjKnMVqO2d8Fw58GxOK2OF3XKfXApTsIvJI+E43qY/xE9qR64S/qTX5eU/tUreXbUYWXoIFwv4mtxMBrpxG9+fihAafVMNVVBaPATfMNvwBTUwvIFqRivOFA10nDogmokY3Dqmh4Y=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DM4PR21MB3707.namprd21.prod.outlook.com (2603:10b6:8:af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.16; Fri, 21 Jul
 2023 04:27:39 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::c164:97f6:174e:4136]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::c164:97f6:174e:4136%4]) with mapi id 15.20.6631.014; Fri, 21 Jul 2023
 04:27:39 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: RE: [patch 51/58] x86/apic: Provide apic_update_callback()
Thread-Topic: [patch 51/58] x86/apic: Provide apic_update_callback()
Thread-Index: AQHZuQeeYvF2m0gSxkCKdshiOvN2x6/Do9EA
Date:   Fri, 21 Jul 2023 04:27:39 +0000
Message-ID: <BYAPR21MB16885B21A0572AE4BE12C3B2D73FA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230717223049.327865981@linutronix.de>
 <20230717223226.118922473@linutronix.de>
In-Reply-To: <20230717223226.118922473@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=463a5676-45f7-4637-b1a3-c20138249701;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-21T04:22:19Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DM4PR21MB3707:EE_
x-ms-office365-filtering-correlation-id: 5ef52ab6-02b0-403a-9bf8-08db89a2d156
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y6jKSLDKAdbFDoJeP482Aym88ggTGtRiO9UoUIMR7P6MYVPXNw9bP5NihvO+KKAxLlUTOlNKYRES1blTHQbHSqxT3/wjC+GyrQY3Ud6RPuCF9NSTrv+DElDT47mNUxyXs9kEiZurSXcKh8bYlUchKSX2akiepliyDMenxqpShJv3dh83ryjcVQwkfhEq2aTM/bMh09d+xO58AA+z2LIR4lSnI1smvLcpIeFJBb6lyHkuBI5ejMXb0rBT8Bi3ApFC8oSuR+TjoGfjORh7YztT9Vo8AxNpeb2JzsGdk+F4B02tGZEBaWOA1IlqeXIFX4bM5wf7+msYKgb5RA3pgrG4/jZnfZomt1oXWWWVE1YkCrOQplpHbfFYSPe+6mE01hRKk1KxGbeJ7inKn+NRNSy1v5BDj+RAg6rY8V6r7N1q5mEb7LNaeQi/QnaFUOzbu8Lq3dvUWkg01XY6xQ9J5lPHcr4Tw6vrK1AM8TxjzlBHO7NJe7Be2j0CGxCiSCk1kA3fLZn0VHGzxcjFNmlh37ctuHWUvio5S5g3rQENe0K5hvq6CoOVLhmS9mr/0AwUB+u9tvUU4U/WQnJKiyeMKCDzTa/4yuxRWhUbOUP2+YK5BvFLGuEMpDN3W5Fw2LMCtcfmCF0M7LJZ3z4WnqMGFuJ9FcLo31M+74w81GYpI2myLkI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(451199021)(8990500004)(2906002)(55016003)(38100700002)(122000001)(82960400001)(82950400001)(83380400001)(9686003)(186003)(26005)(6506007)(5660300002)(8936002)(52536014)(86362001)(8676002)(33656002)(38070700005)(7416002)(10290500003)(110136005)(54906003)(7696005)(71200400001)(478600001)(66556008)(4326008)(64756008)(66446008)(66476007)(66946007)(316002)(76116006)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkdLemJyWDc1OTZtOXRhaUY4RmJteWI0NDR4bG9qclpJQWZZeUJZbjFFbmsr?=
 =?utf-8?B?cXpzV2xqNnd5cE5xNVRmcXNxa2hnZXdmaUxYVWRBREt5SG1qQWd4REVFQ1FO?=
 =?utf-8?B?RGs4ZHpjT2lJQmRpQTIyNXNabVcvQnFMQ1VzUE03MWhLMW41ZDJROFluY3ov?=
 =?utf-8?B?WFRIenE1RkYvYkNCRDdLNnplWTF3OUZXd3dtcEk3ZU1welhnS3JlQStTV2pH?=
 =?utf-8?B?dVJtNXJuVzgyazlsZ2lGdklENkhYNGVjTWxQQ3JjazBlOTc3VitqdlRlQk9m?=
 =?utf-8?B?UGlWbFJ5NG91MnRBMVdseFpXdGJlSi9PYWFaVlk4Q2VDSHVPUDYxdElGUkx2?=
 =?utf-8?B?T0swL0ErRnBVMzBaOEovamU2NUdCay9zZGJsY20xZi8ydi9VVnpobk0rbklj?=
 =?utf-8?B?M1BYMkRXVkhUc0wvYzl5emFmclc3TGZ3MmwvL2lBem1iWDBtTVhPdC96RTF5?=
 =?utf-8?B?eHZ3Y1J5UkQ4LzNqUHg1d1BSUlhUSjhMUjAzbGsvNkpkZ1pQUWpvZy9SWUFa?=
 =?utf-8?B?M0NJZGMyMFhldUZ5V1VkM29QQUxxSXBQZzQzT0JXZDVwVGdBV2thS0J4U3RF?=
 =?utf-8?B?c2wwM0RucW51anp4QjhOZG5vdzFFQk84QU9hYVZwY0NIMHdnOWhlenlSSDZL?=
 =?utf-8?B?Z1d2ZFZjYWFkRUxGVUZoa04yVElRUHRuNDRBUVlWR3N5ME1Ca0tFQWczelNl?=
 =?utf-8?B?S3dWY3h4blVSMXJROXRweHNKYlp0WDhJejlYaFdlalMvRWVEaDVJUUZmRU1a?=
 =?utf-8?B?TzRNTG9SYS8reTUxdUtoTU5FK0R2RE5KbDlCWU1EUDd1ZU42bmtsb2FGTk9V?=
 =?utf-8?B?ZFVodE4xNUVUaDZKR3ltRmowMmlzaG83NDRsU3Z3WnplUUlRd2gyU1pNOFhs?=
 =?utf-8?B?NkdkMC9ua0VLK1FGb0Q1NHR0UjExUG53ZUpyZFZGTlhDUjd0TGo2UEd3cG0y?=
 =?utf-8?B?NFFBMnBMcTdZbnp0dG54eE04QUM5Zngvd0Q4R053Mk83UW0xejN3bGFwR2Fm?=
 =?utf-8?B?OTR6QS95ZjdKck8rdE1DYU0xMGM0OXU1QzRLdzVZN1VzSXlpaC9KU2p3ZzJi?=
 =?utf-8?B?V015TUo1UkJVUVpIZDNzamN2MHFkRUJsY0J0bUpHTFFHYzhpVXJzY2xYcFJw?=
 =?utf-8?B?UmJFQnhsMTdwQmdqZCtXbDFkcGpYRU42M2pBNCtjcXFtcGVFRkZrZUU2NlZu?=
 =?utf-8?B?UVNObi93ZXM4ZnBleFdpSjdNcTRUY1UyZGdTNzdtL0MrRFR5SEMwaC9XcHgz?=
 =?utf-8?B?ZThQWFcyTHVmYkh0V1pWN2g4RmNhWDFUd1VmOFMzbEpPNmpFLy9xdERhZk1W?=
 =?utf-8?B?T0l5aXBGNSs5QmtodUUyeEFHNWpxK3RlRVFqc0lUVDNIcE9mWjc5Z3QxNFoz?=
 =?utf-8?B?ZHFEVnJHcitEbXhadWtuTHNmK1pUL3ZRMXJGVVZ3ZFI5RENSY0tUbWF0Q1pv?=
 =?utf-8?B?bTMvNHI0c2VjYUVrbFYya1lYUUhtRnRkbnl3T1pieXh3SkNQcytUSVhybEhM?=
 =?utf-8?B?QnNYZS9pcmN0ZVJwT1EwcnFrK0J0QnFtYjlvVmlqYWhpZHloYVBQQ2tZRE1O?=
 =?utf-8?B?cEtIcU9UcEFYRWpvNGE0ZnYrWkZ5UmNKQmI2ZTIyLzdNWWVsajZjNmhHMlNt?=
 =?utf-8?B?dW03MG1VRlE4cTJvOHcrR0Naa1dJd2t5VHNqRmlvcDdTbGk1cTVtYmRwYzVh?=
 =?utf-8?B?S0RyaysrZk85OWdaRUJvbjJPc1FXYzcxdmZyK0pSS3c1NGtySFgvTVRaRzBp?=
 =?utf-8?B?OU1WYktmRVJwWjZybk85MGNjTGU0cThiY2FpWjg2enJYNk5wSUtMRHlWTXZF?=
 =?utf-8?B?NUZ4YVRQNUdGbVVZMFcvUXJ3Qk5FTVRpMklsZ1VrNXAvcUNkVEgreWJmd2di?=
 =?utf-8?B?cWhlNXNaUVJqaVZjWUFSODEvN0JCVTV4V2d5cEtNWW9LalUxVER3U3B2UXNJ?=
 =?utf-8?B?NWZtYlFIaWNuQlRXMUgzMTk0QnFaSUZicFNWQVp2cW9ESnkyanFOMi9YdjFP?=
 =?utf-8?B?ckNXbzZtYWdqRHpSUWkxVUpoK2pvcTBwcDBxUmJZRWI4WWM2dXJ3NHQ5UHJH?=
 =?utf-8?B?V3FUSVQzc0NYa29pZlpKNmRuck51bnhlazJCZVhqVDZ1RTdGQm9oelhYRGd4?=
 =?utf-8?B?VkZ0djJLa1FMN3VlVkU0aXVtUmRUMDhtNXJtS21aUHVFUUJUSFE5cXE4NjZZ?=
 =?utf-8?B?N1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef52ab6-02b0-403a-9bf8-08db89a2d156
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 04:27:39.2736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Diy39AVuuXI4P0fMI9NyfvG5GVvIM2b8O0Q4Usqc2DskoaSN8OR0IKMRkQCu9lbKBAM33iVqrgpDsRPMsT8hU+SrYsSfawk9Go44hEnUQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3707
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+IFNlbnQ6IE1vbmRheSwg
SnVseSAxNywgMjAyMyA0OjE2IFBNDQo+IA0KPiBUaGVyZSBhcmUgYWxyZWFkeSB0d28gdmFyaWFu
dHMgb2YgdXBkYXRlIG1lY2hhbmlzbSBmb3IgcGFydGljdWxhciBjYWxsYmFja3MNCj4gYW5kIHZp
cnR1YWxpemF0aW9uIGp1c3Qgd3JpdGVzIGludG8gdGhlIGRhdGEgc3RydWN0dXJlLg0KPiANCj4g
UHJvdmlkZSBhbiBpbnRlcmZhY2UgYW5kIHVzZSBhIHNoYWRvdyBkYXRhIHN0cnVjdHVyZSB0byBw
cmVzZXJ2ZSBjYWxsYmFja3MNCj4gc28gdGhleSBjYW4gYmUgcmVhcHBsaWVkIHdoZW4gdGhlIEFQ
SUMgZHJpdmVyIGlzIHJlcGxhY2VkLg0KPiANCj4gVGhlIGV4dHJhIGRhdGEgc3RydWN0dXJlIGlz
IGludGVudGlvbmFsIGFzIGFueSBuZXcgY2FsbGJhY2sgbmVlZHMgdG8gYmUNCj4gYWxzbyB1cGRh
dGVkIGluIHRoZSBjb3JlIGNvZGUuIFRoaXMgYWxzbyBwcmVwYXJlcyBmb3Igc3RhdGljIGNhbGxz
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXgu
ZGU+DQo+IC0tLQ0KPiAgYXJjaC94ODYvaW5jbHVkZS9hc20vYXBpYy5oIHwgICAyNSArKysrKysr
KysrKysrKysrKysrKysrKysrDQo+ICBhcmNoL3g4Ni9rZXJuZWwvYXBpYy9pbml0LmMgfCAgIDM5
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiAgYXJjaC94ODYva2Vy
bmVsL3NldHVwLmMgICAgIHwgICAgMiArKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA2NSBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9h
cGljLmgNCj4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vYXBpYy5oDQo+IEBAIC0zMDgsNiAr
MzA4LDIzIEBAIHN0cnVjdCBhcGljIHsNCj4gIAljaGFyCSpuYW1lOw0KPiAgfTsNCj4gDQo+ICtz
dHJ1Y3QgYXBpY19vdmVycmlkZSB7DQo+ICsJdm9pZAkoKmVvaSkodm9pZCk7DQo+ICsJdm9pZAko
Km5hdGl2ZV9lb2kpKHZvaWQpOw0KPiArCXZvaWQJKCp3cml0ZSkodTMyIHJlZywgdTMyIHYpOw0K
PiArCXUzMgkoKnJlYWQpKHUzMiByZWcpOw0KPiArCXZvaWQJKCpzZW5kX0lQSSkoaW50IGNwdSwg
aW50IHZlY3Rvcik7DQo+ICsJdm9pZAkoKnNlbmRfSVBJX21hc2spKGNvbnN0IHN0cnVjdCBjcHVt
YXNrICptYXNrLCBpbnQgdmVjdG9yKTsNCj4gKwl2b2lkCSgqc2VuZF9JUElfbWFza19hbGxidXRz
ZWxmKShjb25zdCBzdHJ1Y3QgY3B1bWFzayAqbXNrLCBpbnQgdmVjKTsNCj4gKwl2b2lkCSgqc2Vu
ZF9JUElfYWxsYnV0c2VsZikoaW50IHZlY3Rvcik7DQo+ICsJdm9pZAkoKnNlbmRfSVBJX2FsbCko
aW50IHZlY3Rvcik7DQo+ICsJdm9pZAkoKnNlbmRfSVBJX3NlbGYpKGludCB2ZWN0b3IpOw0KPiAr
CXU2NAkoKmljcl9yZWFkKSh2b2lkKTsNCj4gKwl2b2lkCSgqaWNyX3dyaXRlKSh1MzIgbG93LCB1
MzIgaGlnaCk7DQo+ICsJaW50CSgqd2FrZXVwX3NlY29uZGFyeV9jcHUpKGludCBhcGljaWQsIHVu
c2lnbmVkIGxvbmcgc3RhcnRfZWlwKTsNCj4gKwlpbnQJKCp3YWtldXBfc2Vjb25kYXJ5X2NwdV82
NCkoaW50IGFwaWNpZCwgdW5zaWduZWQgbG9uZyBzdGFydF9laXApOw0KPiArfTsNCj4gKw0KPiAg
LyoNCj4gICAqIFBvaW50ZXIgdG8gdGhlIGxvY2FsIEFQSUMgZHJpdmVyIGluIHVzZSBvbiB0aGlz
IHN5c3RlbSAodGhlcmUncw0KPiAgICogYWx3YXlzIGp1c3Qgb25lIHN1Y2ggZHJpdmVyIGluIHVz
ZSAtIHRoZSBrZXJuZWwgZGVjaWRlcyB2aWEgYW4NCj4gQEAgLTM0Myw5ICszNjAsMTcgQEAgZXh0
ZXJuIGludCBsYXBpY19jYW5fdW5wbHVnX2NwdSh2b2lkKTsNCj4gICNlbmRpZg0KPiANCj4gICNp
ZmRlZiBDT05GSUdfWDg2X0xPQ0FMX0FQSUMNCj4gK2V4dGVybiBzdHJ1Y3QgYXBpY19vdmVycmlk
ZSBfX3g4Nl9hcGljX292ZXJyaWRlOw0KPiANCj4gK3ZvaWQgX19pbml0IGFwaWNfc2V0dXBfYXBp
Y19jYWxscyh2b2lkKTsNCj4gIHZvaWQgX19pbml0IGFwaWNfaW5zdGFsbF9kcml2ZXIoc3RydWN0
IGFwaWMgKmRyaXZlcik7DQo+IA0KPiArI2RlZmluZSBhcGljX3VwZGF0ZV9jYWxsYmFjayhfY2Fs
bGJhY2ssIF9mbikgewkJCQkJXA0KPiArCQlfX3g4Nl9hcGljX292ZXJyaWRlLl9jYWxsYmFjayA9
IF9mbjsJCQkJXA0KPiArCQlhcGljLT5fY2FsbGJhY2sgPSBfZm47CQkJCQkJXA0KPiArCQlwcl9p
bmZvKCJBUElDOjolcygpIHJlcGxhY2VkIHdpdGggJXBzKClcbiIsICNfY2FsbGJhY2ssIF9mbik7
CVwNCg0KRldJVywgd2hlbiBJIHNhdyB0aGUgZG1lc2cgb3V0cHV0LCBJIHRob3VnaHQgdGhlIGRv
dWJsZSBjb2xvbiBpbiB0aGUgYWJvdmUNCm1lc3NhZ2Ugd2FzIGEgdHlwby4gIFdoZW4ganV4dGFw
b3NlZCBhZ2FpbnN0IHRoZSBuZWFybHkgYWRqYWNlbnQgQVBJQy1yZWxhdGVkDQptZXNzYWdlcyB0
aGF0IGhhdmUganVzdCBhIHNpbmdsZSBjb2xvbiwgaXQncyBhIGxpdHRsZSB1bmV4cGVjdGVkLg0K
DQpbICAgIDAuOTE0NTg3XSBBUElDOiBTd2l0Y2ggdG8gc3ltbWV0cmljIEkvTyBtb2RlIHNldHVw
DQpbICAgIDAuOTE4Mjg5XSBBUElDOiBTd2l0Y2hlZCBBUElDIHJvdXRpbmcgdG86IHBoeXNpY2Fs
IGZsYXQNClsgICAgMC45MjU1NzddIEh5cGVyLVY6IFVzaW5nIElQSSBoeXBlcmNhbGxzDQpbICAg
IDAuOTI4NDYwXSBBUElDOjpzZW5kX0lQSSgpIHJlcGxhY2VkIHdpdGggaHZfc2VuZF9pcGkoKQ0K
WyAgICAwLjkzMTg2Ml0gQVBJQzo6c2VuZF9JUElfbWFzaygpIHJlcGxhY2VkIHdpdGggaHZfc2Vu
ZF9pcGlfbWFzaygpDQpbICAgIDAuOTM1OTYwXSBBUElDOjpzZW5kX0lQSV9tYXNrX2FsbGJ1dHNl
bGYoKSByZXBsYWNlZCB3aXRoIGh2X3NlbmRfaXBpX21hc2tfYWxsYnV0c2VsZigpDQoNCkp1c3Qg
bXkgJC4wMiAuLi4uDQoNCk1pY2hhZWwNCg0KPiArfQ0KPiArDQo+ICBzdGF0aWMgaW5saW5lIHUz
MiBhcGljX3JlYWQodTMyIHJlZykNCj4gIHsNCj4gIAlyZXR1cm4gYXBpYy0+cmVhZChyZWcpOw0K
PiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvYXBpYy9pbml0LmMNCj4gKysrIGIvYXJjaC94ODYva2Vy
bmVsL2FwaWMvaW5pdC5jDQo+IEBAIC01LDYgKzUsMzcgQEANCj4gDQo+ICAjaW5jbHVkZSAibG9j
YWwuaCINCj4gDQo+ICsvKiBUaGUgY29udGFpbmVyIGZvciBmdW5jdGlvbiBjYWxsIG92ZXJyaWRl
cyAqLw0KPiArc3RydWN0IGFwaWNfb3ZlcnJpZGUgX194ODZfYXBpY19vdmVycmlkZSBfX2luaXRk
YXRhOw0KPiArDQo+ICsjZGVmaW5lIGFwcGx5X292ZXJyaWRlKF9fY2IpCQkJCQlcDQo+ICsJaWYg
KF9feDg2X2FwaWNfb3ZlcnJpZGUuX19jYikJCQkJXA0KPiArCQlhcGljLT5fX2NiID0gX194ODZf
YXBpY19vdmVycmlkZS5fX2NiDQo+ICsNCj4gK3N0YXRpYyBfX2luaXQgdm9pZCByZXN0b3JlX292
ZXJyaWRlX2NhbGxiYWNrcyh2b2lkKQ0KPiArew0KPiArCWFwcGx5X292ZXJyaWRlKGVvaSk7DQo+
ICsJYXBwbHlfb3ZlcnJpZGUobmF0aXZlX2VvaSk7DQo+ICsJYXBwbHlfb3ZlcnJpZGUod3JpdGUp
Ow0KPiArCWFwcGx5X292ZXJyaWRlKHJlYWQpOw0KPiArCWFwcGx5X292ZXJyaWRlKHNlbmRfSVBJ
KTsNCj4gKwlhcHBseV9vdmVycmlkZShzZW5kX0lQSV9tYXNrKTsNCj4gKwlhcHBseV9vdmVycmlk
ZShzZW5kX0lQSV9tYXNrX2FsbGJ1dHNlbGYpOw0KPiArCWFwcGx5X292ZXJyaWRlKHNlbmRfSVBJ
X2FsbGJ1dHNlbGYpOw0KPiArCWFwcGx5X292ZXJyaWRlKHNlbmRfSVBJX2FsbCk7DQo+ICsJYXBw
bHlfb3ZlcnJpZGUoc2VuZF9JUElfc2VsZik7DQo+ICsJYXBwbHlfb3ZlcnJpZGUoaWNyX3JlYWQp
Ow0KPiArCWFwcGx5X292ZXJyaWRlKGljcl93cml0ZSk7DQo+ICsJYXBwbHlfb3ZlcnJpZGUod2Fr
ZXVwX3NlY29uZGFyeV9jcHUpOw0KPiArCWFwcGx5X292ZXJyaWRlKHdha2V1cF9zZWNvbmRhcnlf
Y3B1XzY0KTsNCj4gK30NCj4gKw0KPiArdm9pZCBfX2luaXQgYXBpY19zZXR1cF9hcGljX2NhbGxz
KHZvaWQpDQo+ICt7DQo+ICsJLyogRW5zdXJlIHRoYXQgdGhlIGRlZmF1bHQgQVBJQyBoYXMgbmF0
aXZlX2VvaSBwb3B1bGF0ZWQgKi8NCj4gKwlhcGljLT5uYXRpdmVfZW9pID0gYXBpYy0+ZW9pOw0K
PiArfQ0KPiArDQo+ICB2b2lkIF9faW5pdCBhcGljX2luc3RhbGxfZHJpdmVyKHN0cnVjdCBhcGlj
ICpkcml2ZXIpDQo+ICB7DQo+ICAJaWYgKGFwaWMgPT0gZHJpdmVyKQ0KPiBAQCAtMTUsNiArNDYs
MTMgQEAgdm9pZCBfX2luaXQgYXBpY19pbnN0YWxsX2RyaXZlcihzdHJ1Y3QgYQ0KPiAgCWlmIChJ
U19FTkFCTEVEKENPTkZJR19YODZfWDJBUElDKSAmJiBhcGljLT54MmFwaWNfc2V0X21heF9hcGlj
aWQpDQo+ICAJCWFwaWMtPm1heF9hcGljX2lkID0geDJhcGljX21heF9hcGljaWQ7DQo+IA0KPiAr
CS8qIENvcHkgdGhlIG9yaWdpbmFsIGVvaSgpIGNhbGxiYWNrIGFzIEtWTS9IeXBlclYgbWlnaHQg
b3ZlcndyaXRlIGl0ICovDQo+ICsJaWYgKCFhcGljLT5uYXRpdmVfZW9pKQ0KPiArCQlhcGljLT5u
YXRpdmVfZW9pID0gYXBpYy0+ZW9pOw0KPiArDQo+ICsJLyogQXBwbHkgYW55IGFscmVhZHkgaW5z
dGFsbGVkIGNhbGxiYWNrIG92ZXJyaWRlcyAqLw0KPiArCXJlc3RvcmVfb3ZlcnJpZGVfY2FsbGJh
Y2tzKCk7DQo+ICsNCj4gIAlwcl9pbmZvKCJTd2l0Y2hlZCBBUElDIHJvdXRpbmcgdG86ICVzXG4i
LCBkcml2ZXItPm5hbWUpOw0KPiAgfQ0KPiANCj4gQEAgLTQxLDcgKzc5LDYgQEAgdm9pZCBfX2lu
aXQgYXBpY19zZXRfZW9pX2NiKHZvaWQgKCplb2kpKA0KPiAgCWZvciAoZHJ2ID0gX19hcGljZHJp
dmVyczsgZHJ2IDwgX19hcGljZHJpdmVyc19lbmQ7IGRydisrKSB7DQo+ICAJCS8qIFNob3VsZCBo
YXBwZW4gb25jZSBmb3IgZWFjaCBhcGljICovDQo+ICAJCVdBUk5fT04oKCpkcnYpLT5lb2kgPT0g
ZW9pKTsNCj4gLQkJKCpkcnYpLT5uYXRpdmVfZW9pID0gKCpkcnYpLT5lb2k7DQo+ICAJCSgqZHJ2
KS0+ZW9pID0gZW9pOw0KPiAgCX0NCj4gIH0NCj4gLS0tIGEvYXJjaC94ODYva2VybmVsL3NldHVw
LmMNCj4gKysrIGIvYXJjaC94ODYva2VybmVsL3NldHVwLmMNCj4gQEAgLTEwMTgsNiArMTAxOCw4
IEBAIHZvaWQgX19pbml0IHNldHVwX2FyY2goY2hhciAqKmNtZGxpbmVfcCkNCj4gDQo+ICAJeDg2
X3JlcG9ydF9ueCgpOw0KPiANCj4gKwlhcGljX3NldHVwX2FwaWNfY2FsbHMoKTsNCj4gKw0KPiAg
CWlmIChhY3BpX21wc19jaGVjaygpKSB7DQo+ICAjaWZkZWYgQ09ORklHX1g4Nl9MT0NBTF9BUElD
DQo+ICAJCWFwaWNfaXNfZGlzYWJsZWQgPSB0cnVlOw0KDQo=
