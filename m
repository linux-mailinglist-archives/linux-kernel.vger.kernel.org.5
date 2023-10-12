Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635D17C71C2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 17:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379172AbjJLPne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 11:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjJLPnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 11:43:31 -0400
Received: from DM4PR02CU002.outbound.protection.outlook.com (mail-centralusazon11013001.outbound.protection.outlook.com [52.101.64.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4430C0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 08:43:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGAZqhCcIGl5n/Wh28fdP6jnaR1NCABbEaYedQTyiNL/KhJLK+wzo9y0Z634iEXYH4OThuZb5CfazjAmn0LQe+sNA3wgA8D90wYhyAp2GjtWFruwvgcJOObvdrrTwwHRfRn11LdeZnCWU/Xv33CUyivg1ahuQ5AoSzeEQTtxvmtZHVSnb5PFETu3/NyQqQYaRJ0Gzg02iAoxwYfeOMD4ywGwoYujLAkeYX0uOGFTMnNyIbd2xmwroOB0WNFRqTVrKkdhvbNjCYgJb8CC/AFw3iBSKt6AAYjvUOLpLHL1zqoWqbg+lm1xuk3F1vlhz7AGab7sANFuazeQMTKgThVAYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zz34zatvhV+kd4gVhzFU6zbKFZdibhl87mzjsSbSTuw=;
 b=VYS4ycR3g9U/vTj8ICovxYpWvRCV0fYXlDgUdRm2tQCidPhJJFnVlZvygolV4lTAJvQlMILP0fYEQLCaCrKUl9X9Iq/RTf1V6qh8/ZBNUHbcxEg+o3ybI2xNTQB+96NcS3HC32s14QNToV0/46LCa5KGjyZGuYdTbxCEEz9Cp5nT6uW+1fRZx5TnP3BfR8Y71O1Mr3I/ng5ayCXqNoVxT+C2LLx1a4ChJuQlAFVo+HHDgaOzW37seEyvvMw6FZcBJrH8YPn2BYLXGrJMBX8NSnz/2dng+IYIFMMwhcXgqQqb1xdiejWZAH/JFSVHHKEyEIm9OznzwSCGVS2msWPk7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zz34zatvhV+kd4gVhzFU6zbKFZdibhl87mzjsSbSTuw=;
 b=a0y29POZfHydl822T9rPyyNZdo3d910Hwdy2yYRepa3MWMJL5mYMkKqOIm60bI4V1yYH73CpjhB8dV6nXf/DeknmQ5JwMLpNxzlEe3VbkbiHMofgtY4x708J7P+2ia9fy49q85nH+VrSa6PJImUfpNJ8B1i93F7VhqQ/ae4ms3Q=
Received: from SA1PR05MB8311.namprd05.prod.outlook.com (2603:10b6:806:1e2::19)
 by SA0PR05MB7210.namprd05.prod.outlook.com (2603:10b6:806:b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.40; Thu, 12 Oct
 2023 15:43:27 +0000
Received: from SA1PR05MB8311.namprd05.prod.outlook.com
 ([fe80::cbd2:31a1:4175:2d]) by SA1PR05MB8311.namprd05.prod.outlook.com
 ([fe80::cbd2:31a1:4175:2d%7]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 15:43:26 +0000
From:   Ankit Jain <ankitja@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "yury.norov@gmail.com" <yury.norov@gmail.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "qyousef@layalina.io" <qyousef@layalina.io>,
        "pjt@google.com" <pjt@google.com>,
        "joshdon@google.com" <joshdon@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Srinidhi Rao <srinidhir@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        Vamsi Krishna Brahmajosyula <vbrahmajosyula@vmware.com>,
        Ajay Kaher <akaher@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>
Subject: Re: [PATCH RFC] cpumask: Randomly distribute the tasks within
 affinity mask
Thread-Topic: [PATCH RFC] cpumask: Randomly distribute the tasks within
 affinity mask
Thread-Index: AQHZ/BNsdynFPMpzJ0mlzh+uh57DDLBEai+AgAAO3gCAAdRsgA==
Date:   Thu, 12 Oct 2023 15:43:26 +0000
Message-ID: <AEC49756-BB90-4F6A-8584-EC5E2451DFD4@vmware.com>
References: <20231011071925.761590-1-ankitja@vmware.com>
 <20231011105329.GA17066@noisy.programming.kicks-ass.net>
 <20231011114642.GA36521@noisy.programming.kicks-ass.net>
In-Reply-To: <20231011114642.GA36521@noisy.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR05MB8311:EE_|SA0PR05MB7210:EE_
x-ms-office365-filtering-correlation-id: 948181f6-525c-4d7d-82fd-08dbcb39f9d2
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cp9q/IAlfK20XKj0INA0nhgh5f1tFEKCN6L0by75OPKLcD5ov0ScjfbtTgQz2B/eZMNkqW1TMqOl+ZWxNqL1aee7MXAyUITK8DD+i/mVeUbdHnZ4Wb69u7nCD3vPUMgBTWWSx1qWnEXAHOU8izp9AjN3Is7eLVCmLQKn2/62HZVqJ8yHxGzhVBf4TSk/55q4YKYtqPlq5NSl7S3z4/mlwArLT/61/7sZTwaKESmxAw2tM7Lbl5+E6fV9z50OTExz+NAaC2q1GveuDR093wONjrTTsmynk6mABE4OdSnh7q0cKck1Ryl6doZ+EMke5Gjr8N82ruBxRX/ljwY7rla+j2fyq2XWvCqi9ev1ltFov4CYQQPzPgRF3Jz/G837vXoTVk8GzpLE1U1Ce5Xv3NjAMhsgMpgUxYOVQ4YHw2t/3CPyV7+86+Xr//yvAHHy8Lc+UziNV8cPJoUP7gjsuDVv2GKmrS7M+Epw4cW9UUWF71Notm5skDGp+ECzM6c/x1jWNJXvcBpw35Mkii8ZDA+1+pQzPm3abayLPyre1cREawMsxCeQQnZSk6zx3RusKZr6q1OYmnYDVj8w44C3EI9ibVXnvgyEx+yYOc3CJKysi6+h6vMMiAM0IkecV2YARk8Jkf+DkCigVLadbbQeud00W/EzWMVPkfHsEMHoLA+7p8m8zK4EeH0M/whbOPI7U1jWv3iQZSkKOAUCoH8SeQUZ7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR05MB8311.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(366004)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(53546011)(6506007)(6512007)(26005)(71200400001)(36756003)(6486002)(478600001)(2616005)(91956017)(66946007)(83380400001)(64756008)(66476007)(316002)(66556008)(6916009)(66446008)(54906003)(38100700002)(76116006)(122000001)(41300700001)(4326008)(8936002)(8676002)(5660300002)(38070700005)(66899024)(2906002)(86362001)(7416002)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGYxSGhqK0VMTURkSk05Z2hTaVNIWmdyWmN4QTlsTjNVcDVvWXpCbXpLWW9R?=
 =?utf-8?B?SG1nUE9zUGE1OVd3SmZmWi9mNGZYNWN4Y05Nekd6b0NyQStIOWlkTEpjc1Zr?=
 =?utf-8?B?UGV5eHV6VE5JOFd0amwvTGVLVU9UZTNZdjkyaHpjdDdreEhLSVA3N2I3alc5?=
 =?utf-8?B?VEt0cVExTyt2S1BEY0lFenUrUVlreno4NCtYY00wTGQ4U0VwMExKOTdMa0Mv?=
 =?utf-8?B?eWpDeGdUL2FUTkVDYzB1ZWhESXcvTG1MOFFZM3Y5Rk5ESGpPMEpGRXdFc09I?=
 =?utf-8?B?NUFIZ0s1ZzBDZkpoVEN6eWM3MW1wTmRpczBaK2U3TFBDSWRnc0c2blU3WW9i?=
 =?utf-8?B?dEVIK0gwUXBsNng5VTI2K1hxQnB4enhON29xN0pJdzFoRm1nem0vd2dwYkpo?=
 =?utf-8?B?Qk1xZCtSY050SzdoUXVLd09FZk5mU0xwK3dzcENjM05FREpCVXBWcmF4SnVs?=
 =?utf-8?B?NlZWdFdicUZ5QmwwR2ZlMGNUWU9BeEhiNGJKelNMSXZTYURmMzQxMXN0aXRs?=
 =?utf-8?B?RXFrZ2tCUzZic2hIWmREZUVHMGRZM0FyM2xHdFdSTUlEOGRxWW0xcGZaWXFS?=
 =?utf-8?B?dTNaeVZsejlVa1FMcDdXUm5PbmY5bUF1VDRCWTh2SVowVlJNejFaUWxjakly?=
 =?utf-8?B?RHErOWM4Q293dUxMRDlQRUs4bWdhWHV0RmtPbkl3ajQ3UkZFZ3BDdlMrdmhO?=
 =?utf-8?B?OU9TbG1yNzBja1RLaUxJMStBQVdyOWU5dTNtdllUTHB4R3dRcGdvQTA1dmwr?=
 =?utf-8?B?TGgzQ2tET215YlJFQ0hlSTB3bVR5UitnRDA1bWFIajRLVXMya1dUQVF5SGRl?=
 =?utf-8?B?R1pVZEI2d1drYU9OcTFtZ1ZTRkY5a3cyRk90b25DSzBLZTVJSVVHeEkvT3lP?=
 =?utf-8?B?bitzRlZmaXlRcy9ZSDZ4UVc2YUh1b3hsdTMyeUM4NkZoeWpwRnhyWE4wR04r?=
 =?utf-8?B?dkg4c01yZlpkeFNyVG1Pai9GU2MrMjl0TlJUSEhaMTM0NTFTSWV0eHZ1b3BY?=
 =?utf-8?B?VDBkZ3M3K3g2SVlHMVVPVS9GRkJUTDJ5T0JhK0hXaDI4dE9Idnp3Z2hjeStw?=
 =?utf-8?B?dGZwWFh4V25iWU5ZV2tWdXRmRU9UeTlJSUdXUW9peTJCRHF2TlE2TW1hdWdH?=
 =?utf-8?B?TEMxNFY0NUVBZzZPRjEwR0d5VmdDQlJLeEkwSkd6ZWxuRWZzTnJmSDcvZ3k2?=
 =?utf-8?B?VWtSTzEzeGpSbUh5VkJ0NGpOZkF1SzR4bnVYLzF4M1doN2dtRmc5bkJYdlh4?=
 =?utf-8?B?eDFDY25OZ1k2cHh1Nm9BZGJQSDcwUFllODlzeEJ6YndnNzFjMG9tbnJyNEtO?=
 =?utf-8?B?NUlhWVJSbjdqY3lMbEJ0alkxbTFPV2JEVmN4K0g4em9iaUI3RHpqV2dacUE3?=
 =?utf-8?B?YUJPTjFTZGdXZHc5SjU1U0pIMm56QlJQUXhxMUEvK3pEd3hvbXdZbUhQdzFh?=
 =?utf-8?B?N2MxV3ZLdnpDNEhIM1VIUmFuN2VFdUVVaVRxV1NWT2JTa21IeTMrNWM3eTE0?=
 =?utf-8?B?OC92VGFmcFZvVzIrQTRxNU9PSFRkZmJUMVFPc2xBMVpGNUVKL1VVU1lncFJE?=
 =?utf-8?B?UUdaSTI5T2NJRHR6aTVYWGNSN000TGhXNHVub2hJYVZGMTVqZU1XWmN4bzFW?=
 =?utf-8?B?alVyRkZROWhrSDB1cnV3QXV3ZVM2V0dwbUpURFBkazBVaVZoSlhFRmtHZVc5?=
 =?utf-8?B?aXlZZ1NHK2orWWMxZlJ1WTZ5RG9qdHo4T3hQYnNkYWNpMkJ2NFhRNk1HNjJq?=
 =?utf-8?B?Y3FuaHNndFJlSmZ5QmtOaGFBb1NmWEg1SlEvWkhnYU9lRUt0SWdnMm5XbDlO?=
 =?utf-8?B?Qlg3K0pySzFUNUxDK1BhRGc5SUdjVUhFVDlHTlI4U2cveFVXang3a2EySHZ6?=
 =?utf-8?B?QzVhTE5kNWsrcGZZSHZ1MlI5NUhqZDJzN2gwVC9CN3dnaHpVYUhrQVhlRjBV?=
 =?utf-8?B?ZjBUM1R2YXNENlBLajgwdTg5NUdOWm5RTk8ycnZCa2JZODI1Ni9ZaEh2YXJr?=
 =?utf-8?B?L2FoeCtuRDZlRzl1RW9vTGVucnhpTERMWUxLRlF5MW4rMnhjUnVNdDk1T2Z6?=
 =?utf-8?B?bVBoakVhSitLZEc5c2pLN0tBZDduYUxDalJ6NmV6Z0IySGNuMnJ1aytJNjE3?=
 =?utf-8?Q?p1igJQm+1NvpcQny/f+NULGQu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E27A1D0A71971948ABC7E9777F52C6DF@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR05MB8311.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 948181f6-525c-4d7d-82fd-08dbcb39f9d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 15:43:26.7729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UK0EFXZC3K9uBfDRU6Q2CNTmo2ylSatmDFM+DQwkYcm3b1fuV1FYupJH0eVmTrf50lyq8obyEimLIUqkO3xk5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR05MB7210
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gMTEtT2N0LTIwMjMsIGF0IDU6MTYgUE0sIFBldGVyIFppamxzdHJhIDxwZXRlcnpA
aW5mcmFkZWFkLm9yZz4gd3JvdGU6DQo+IA0KPiAhISBFeHRlcm5hbCBFbWFpbA0KPiANCj4gT24g
V2VkLCBPY3QgMTEsIDIwMjMgYXQgMTI6NTM6MjlQTSArMDIwMCwgUGV0ZXIgWmlqbHN0cmEgd3Jv
dGU6DQo+PiBPbiBXZWQsIE9jdCAxMSwgMjAyMyBhdCAxMjo0OToyNVBNICswNTMwLCBBbmtpdCBK
YWluIHdyb3RlOg0KPj4+IGNvbW1pdCA0NmE4N2IzODUxZjAgKCJzY2hlZC9jb3JlOiBEaXN0cmli
dXRlIHRhc2tzIHdpdGhpbiBhZmZpbml0eSBtYXNrcyIpDQo+Pj4gYW5kIGNvbW1pdCAxNGUyOTJm
OGQ0NTMgKCJzY2hlZCxydDogVXNlIGNwdW1hc2tfYW55Kl9kaXN0cmlidXRlKCkiKQ0KPj4+IGlu
dHJvZHVjZWQgdGhlIGxvZ2ljIHRvIGRpc3RyaWJ1dGUgdGhlIHRhc2tzIGF0IGluaXRpYWwgd2Fr
ZXVwIG9uIGNwdXMNCj4+PiB3aGVyZSBsb2FkIGJhbGFuY2luZyB3b3JrcyBwb29ybHkgb3IgZGlz
YWJsZWQgYXQgYWxsIChpc29sYXRlZCBjcHVzKS4NCj4+PiANCj4+PiBUaGVyZSBhcmUgY2FzZXMg
aW4gd2hpY2ggdGhlIGRpc3RyaWJ1dGlvbiBvZiB0YXNrcw0KPj4+IHRoYXQgYXJlIHNwYXduZWQg
b24gaXNvbGNwdXMgZG9lcyBub3QgaGFwcGVuIHByb3Blcmx5Lg0KPj4+IEluIHByb2R1Y3Rpb24g
ZGVwbG95bWVudCwgaW5pdGlhbCB3YWtldXAgb2YgdGFza3Mgc3Bhd24gZnJvbQ0KPj4+IGhvdXNl
a2VlcGluZyBjcHVzIHRvIGlzb2xjcHVzW25vaHpfZnVsbCBjcHVdIGhhcHBlbnMgb24gZmlyc3Qg
Y3B1DQo+Pj4gd2l0aGluIGlzb2xjcHVzIHJhbmdlIGluc3RlYWQgb2YgZGlzdHJpYnV0ZWQgYWNy
b3NzIGlzb2xjcHVzLg0KPj4+IA0KPj4+IFVzYWdlIG9mIGRpc3RyaWJ1dGVfY3B1X21hc2tfcHJl
diBmcm9tIG9uZSBwcm9jZXNzZXMgZ3JvdXAsDQo+Pj4gd2lsbCBjbG9iYmVyIHByZXZpb3VzIHZh
bHVlIG9mIGFub3RoZXIgb3Igb3RoZXIgZ3JvdXBzIGFuZCB2aWNlLXZlcnNhLg0KPj4+IA0KPj4+
IFdoZW4gaG91c2VrZWVwaW5nIGNwdXMgc3Bhd24gbXVsdGlwbGUgY2hpbGQgdGFza3MgdG8gd2Fr
ZXVwIG9uDQo+Pj4gaXNvbGNwdXNbbm9oel9mdWxsIGNwdV0sIHVzaW5nIGNwdXNldHMuY3B1cy9z
Y2hlZF9zZXRhZmZpbml0eSgpLA0KPj4+IGRpc3RyaWJ1dGlvbiBpcyBjdXJyZW50bHkgcGVyZm9y
bWVkIGJhc2VkIG9uIHBlci1jcHUNCj4+PiBkaXN0cmlidXRlX2NwdV9tYXNrX3ByZXYgY291bnRl
ci4NCj4+PiBBdCB0aGUgc2FtZSB0aW1lLCBvbiBob3VzZWtlZXBpbmcgY3B1cyB0aGVyZSBhcmUg
cGVyY3B1DQo+Pj4gYm91bmRlZCB0aW1lcnMgaW50ZXJydXB0L3JjdSB0aHJlYWRzIGFuZCBvdGhl
ciBzeXN0ZW0vdXNlciB0YXNrcw0KPj4+IHdvdWxkIGJlIHJ1bm5pbmcgd2l0aCBhZmZpbml0eSBh
cyBob3VzZWtlZXBpbmcgY3B1cy4gSW4gYSByZWFsLWxpZmUNCj4+PiBlbnZpcm9ubWVudCwgaG91
c2VrZWVwaW5nIGNwdXMgYXJlIG11Y2ggZmV3ZXIgYW5kIGFyZSB0b28gbXVjaCBsb2FkZWQuDQo+
Pj4gU28sIGRpc3RyaWJ1dGVfY3B1X21hc2tfcHJldiB2YWx1ZSBmcm9tIHRoZXNlIHRhc2tzIGlt
cGFjdHMNCj4+PiB0aGUgb2Zmc2V0IHZhbHVlIGZvciB0aGUgdGFza3Mgc3Bhd25pbmcgdG8gd2Fr
ZXVwIG9uIGlzb2xjcHVzIGFuZA0KPj4+IHRodXMgbW9zdCBvZiB0aGUgdGFza3MgZW5kIHVwIHdh
a2luZyB1cCBvbiBmaXJzdCBjcHUgd2l0aGluIHRoZQ0KPj4+IGlzb2xjcHVzIHNldC4NCj4+PiAN
Cj4+PiBTdGVwcyB0byByZXByb2R1Y2U6DQo+Pj4gS2VybmVsIGNtZGxpbmUgcGFyYW1ldGVyczoN
Cj4+PiBpc29sY3B1cz0yLTUgc2tld190aWNrPTEgbm9oej1vbiBub2h6X2Z1bGw9Mi01DQo+Pj4g
cmN1X25vY2JzPTItNSByY3Vfbm9jYl9wb2xsIGlkbGU9cG9sbCBpcnFhZmZpbml0eT0wLTENCj4+
PiANCj4+PiAqIHBpZD0kKGVjaG8gJCQpDQo+Pj4gKiB0YXNrc2V0IC1wYyAwICRwaWQNCj4+PiAq
IGNhdCBsb29wLW5vcm1hbC5jDQo+Pj4gaW50IG1haW4odm9pZCkNCj4+PiB7DQo+Pj4gICAgICAg
IHdoaWxlICgxKQ0KPj4+ICAgICAgICAgICAgICAgIDsNCj4+PiAgICAgICAgcmV0dXJuIDA7DQo+
Pj4gfQ0KPj4+ICogZ2NjIC1vIGxvb3Atbm9ybWFsIGxvb3Atbm9ybWFsLmMNCj4+PiAqIGZvciBp
IGluIHsxLi41MH07IGRvIC4vbG9vcC1ub3JtYWwgJiBkb25lDQo+Pj4gKiBwaWRzPSQocHMgLWEg
fCBncmVwIGxvb3Atbm9ybWFsIHwgY3V0IC1kJyAnIC1mNSkNCj4+PiAqIGZvciBpIGluICRwaWRz
OyBkbyB0YXNrc2V0IC1wYyAyLTUgJGkgOyBkb25lDQo+Pj4gDQo+Pj4gRXhwZWN0ZWQgb3V0cHV0
Og0KPj4+ICogQWxsIDUwIOKAnGxvb3Atbm9ybWFs4oCdIHRhc2tzIHNob3VsZCB3YWtlIHVwIG9u
IGNwdTItNQ0KPj4+IGVxdWFsbHkgZGlzdHJpYnV0ZWQuDQo+Pj4gKiBwcyAtZUxvIGNwdWlkLHBp
ZCx0aWQscHBpZCxjbHMscHNyLGNscyxjbWQgfCBncmVwICJeICAgIFsyMzQ1XSINCj4+PiANCj4+
PiBBY3R1YWwgb3V0cHV0Og0KPj4+ICogQWxsIDUwIOKAnGxvb3Atbm9ybWFs4oCdIHRhc2tzIGdv
dCB3b2tlbiB1cCBvbiBjcHUyIG9ubHkNCj4+IA0KPj4gWW91ciBleHBlY3RhdGlvbiBpcyB3cm9u
Zy4gVGhpbmdzIHdvcmsgYXMgYWR2ZXJ0aXNlZC4NCj4gDQo+IFRoYXQgaXMsIGlzb2xjcHVzIHJl
c3VsdHMgaW4gc2luZ2xlIENQVSBiYWxhbmNlIGRvbWFpbnMgYW5kIGFzIHN1Y2ggd2UNCj4gbXVz
dCBub3QgZGlzdHJpYnV0ZSAtLSB0aGVyZSBpcyBubyBsb2FkIGJhbGFuY2luZy4NCj4gDQo+IElk
ZWFsbHkgd2UnZCByZWplY3Qgc2V0dGluZyBjcHVtYXNrcyB3aXRoIG11bHRpIGJpdHMgc2V0IG9u
IGRvbWFpbnMgbGlrZQ0KPiB0aGF0LCBidXQgYWxhcywgdGhhdCB3b3VsZCBicmVhayBoaXN0b3Jp
Y2FsIGJlaGF2aW91ciA6Lw0KDQpUaGFuayB5b3UgUGV0ZXIgZm9yIGludmVzdGluZyB5b3VyIHRp
bWUgaW4gcmV2aWV3aW5nIHRoaXMgY2hhbmdlLg0KSSBjb21wbGV0ZWx5IGFncmVlIGFuZCB1bmRl
cnN0YW5kIHRoYXQgY3B1bWFzayB3aXRoIG11bHRpIGJpdHMgDQpzaG91bGQgbm90IGJlIHNldCBm
b3IgZG9tYWlucyBsaWtlIGlzb2xjcHVzIGFuZCBzaG91bGQgcHJvYmFibHkNCmJlIGFkZHJlc3Nl
ZCBpbiB1c2VyIHNwYWNlLg0KDQo+IA0KPiBOb3csIGxvb2tpbmcgYXQgdGhlIGNvZGUsIEkgZG9u
J3QgdGhpbmsgdGhlIGN1cnJlbnQgY29kZSBhY3R1YWxseQ0KPiBiZWhhdmVzIGNvcnJlY3QgaW4g
dGhpcyBjYXNlIDotKCwgc29tZXdoZXJlIGFsb25nIHRoZSBsaW5lIHdlIHNob3VsZA0KPiB0cnVu
Y2F0ZSBjcHVfdmFsaWRfbWFzayB0byBhIHNpbmdsZSBiaXQuIExldCBtZSBzZWUgd2hlcmUgdGhl
IHNhbmUgcGxhY2UNCj4gaXMgdG8gZG8gdGhhdC4NCj4gDQo+IA0KPiANCj4gISEgRXh0ZXJuYWwg
RW1haWw6IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgdGhlIG9yZ2FuaXph
dGlvbi4gRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBy
ZWNvZ25pemUgdGhlIHNlbmRlci4NCg0K
