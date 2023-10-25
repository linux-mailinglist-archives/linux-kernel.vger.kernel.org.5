Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7D07D6F5E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344837AbjJYOJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235088AbjJYOJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:09:45 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA901BB;
        Wed, 25 Oct 2023 07:09:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZCPITE0TMsf3nT4uMg/jjk3BggyKUzd7bmHo5XFth2MrTnqPAltjSASnDAMKodfZmRhsq8syfcwOCb4+31cME24ELJL0mSip1nxrsnZy9T17oSDt26ZvMIPwlANn9jzDppcY1yNqtIeZpKBX7Sk/qe5yARJNU1fFXWs4yA8tb6Xuyez5DaSZVxx0I646OAzsLygtvKMCAUhwSSk8mLbq5CqIFse6e/e0ThmQmjBb1wDDaLQG9PshCZFKgg0LND5UeeZK9p4HwUJIShmRn5XIdFM3WhI64WkR2TBL88odbrSnQYQTG1Mfhq9giD7bNjT+bEDvroK5kONK7Yk08Jbqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jU2QGedqxjEf1hAHg5fNZDKvpfUQ2jne84kUNiKuW/w=;
 b=cAVuAg/pcWXC7Q10yP8tFGIAeGnl0IqZc+y+EcU/eoZHvoJcWAlBv18XKcloAF8SAsGYH4Mg4u6e5axtKxHTf4hTAKWxwBpZYeuxwIFypdWRwml2gtC5pgvzK/E3a+rYfOFVa8ssmz/9y/zZLpknADQ2+2EySpIizp7+oPNU9FcYSow3b/ZqcTJenHVCkC4fPHluXdcAwHdOZWsC2ZFcmHL2TFgoO0dDZx+DRv2pvvsIKUtm+mkZZnQxXBhxTjAt1tGDOn1jfrH+6O1anR50cDEXAhee7yf2bbjXMcfk5NqbcxCxK5AUa+ROHLXdQOxI+Q9NPXcDwvAfiODBJSewTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jU2QGedqxjEf1hAHg5fNZDKvpfUQ2jne84kUNiKuW/w=;
 b=Uy5u/y3q8d+PNLwulmCgSpy41OJo/2GWegFpDqxg5Meat0UaSlvDgjoYy/0Slmgl9oSLtTSzCke3FfZHpITUM9pBkAMFOFtSSN9DpIB0nWNSVuB6gKhnSNVYZS6vaotuHpxC8qBjW7x2OrQG4kvGLRFV5qhKCoZg/o3P1A4hFFTWkVFlv1mdLJIW/N2sWA7dsxM/gb9WwMlThmc5kxgb1jaPcPA0AnzA5s1tiWji5uF56dn2FUlrxWfcmEvbtLBiB7R1IhAKdZEj9EAGx8JIKiwN8wNIQRV1qchY/h21hVch9NmzxK0IPJGk44y42NMFMLYMGdB0f+mfZ4LBAcMdcA==
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (2603:10b6:208:c8::33)
 by BL3PR12MB6642.namprd12.prod.outlook.com (2603:10b6:208:38e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Wed, 25 Oct
 2023 14:09:37 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::d7d4:8615:9647:179]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::d7d4:8615:9647:179%4]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 14:09:37 +0000
From:   Jeshua Smith <jeshuas@nvidia.com>
To:     Borislav Petkov <bp@alien8.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Luck, Tony" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gpiccoli@igalia.com" <gpiccoli@igalia.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: RE: [PATCH V2] ACPI: APEI: Use ERST timeout for slow devices
Thread-Topic: [PATCH V2] ACPI: APEI: Use ERST timeout for slow devices
Thread-Index: AQHZtREytrmSwIEvT06Ibqr95x6guq/abXNggAAKnoCAAI5FkIAVd3TwgCWuaxCAIP94MIAg+dpQgAF+QgCAAA8uAIAAD2Gg
Date:   Wed, 25 Oct 2023 14:09:37 +0000
Message-ID: <MN2PR12MB33738FA73A69BC6AEB64BD63DBDEA@MN2PR12MB3373.namprd12.prod.outlook.com>
References: <20230712223448.145079-1-jeshuas@nvidia.com>
 <DM6PR12MB3371BA50E3B76D2266273901DB09A@DM6PR12MB3371.namprd12.prod.outlook.com>
 <SJ1PR11MB6083426D3C663F47E707CF1AFC09A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <DM6PR12MB3371D86F80417641B8479B28DB0EA@DM6PR12MB3371.namprd12.prod.outlook.com>
 <DM6PR12MB3371FA3AEEA4D17D94C889D5DB1BA@DM6PR12MB3371.namprd12.prod.outlook.com>
 <DM6PR12MB337153EE2DDDB427096446F0DBF2A@DM6PR12MB3371.namprd12.prod.outlook.com>
 <DM6PR12MB3371083F4E6BCE4A8D2389E7DBC5A@DM6PR12MB3371.namprd12.prod.outlook.com>
 <DM6PR12MB33710C8FE59EB3CB1404ABC0DBD8A@DM6PR12MB3371.namprd12.prod.outlook.com>
 <CAJZ5v0g2TsBo4hxsJBo5a-ggD2Cj65VS=tokpoRaNwzWbPoeNw@mail.gmail.com>
 <20231024152708.GFZTfiTL9C6onZKn99@fat_crate.local>
In-Reply-To: <20231024152708.GFZTfiTL9C6onZKn99@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB3373:EE_|BL3PR12MB6642:EE_
x-ms-office365-filtering-correlation-id: c7d70d29-36d9-4aed-8a0f-08dbd56405e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wb5XgERlxshrCVU3MsBKBK+miMsM0aSHXswlHLXiSS2xBgtU5/xWqX4XXGK+gsHdPrAxd6uLixHNICpIuKISMrrEKrXi3rizrV3X6a7Tnc7B4Se/KJrOyyz6HX97CHqwqMvZJ231QIiG4Ft0/Nmo9pfvPLT9kiKIY7skIBHJt+ibF4ZufqM3OCN2D7RPtiPQKsq2oc3059fbsLeVOhzgVVy7V28C56RUFjgR3YQhktNPrgeUvxfQ0gE8xf5KV9TdNAjRx+fA3FhprhVsHFaxr7Or/WLu1xQjiccGM5Rob4PKTU1FjoSSKtbukugQt/tgCbL9bI1w25F3cjsp6NCbzJP3TDaMpviQeIbMhl4OLBtTtsffwfOk11VEUqkKFQ/+EQUpjFdTf9o99YVg9fNGfvgK/AxBuNunKtlImnyeOOIQSa4F+jX84U5/y17w/ORPzCFyCwEr0SASX4moFeMTddFwcokwYNmwdxZdUfi3zMQpKvQrATdENwKxxyzHcMFhCZywLUXPL6QQdwLlKCZU/3+2IYVAzNPKLNnWaFfbvpOo1EdmRtlfqFbpiJsG77iHLDCfMY0bfoT7drkwPSFvJqUNSB8DAQdYAd4aquP6t1VWjoP9gl2yfN7hIKlmA8638k9u/ixcqORKa6KHMezOFDw6/3zWCeztpzmRHPUeTJo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(2906002)(38070700009)(55016003)(478600001)(7416002)(5660300002)(66946007)(4326008)(8676002)(8936002)(6506007)(52536014)(41300700001)(316002)(966005)(76116006)(33656002)(71200400001)(86362001)(110136005)(64756008)(9686003)(7696005)(107886003)(26005)(122000001)(66476007)(54906003)(66556008)(83380400001)(38100700002)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEVqSWRPSEtQcUU3ZDJ2M0NhNEFCZ21TTFNvckdIT0laWHhuWFJBY0FIdjJU?=
 =?utf-8?B?eWQ1NzJPQytMSm5IY2l6LytWK0hucUozb0lJMXJSSWxiVzVWRElwUjh5dTNH?=
 =?utf-8?B?b2dIakp2UGRQMnZJTURrSlBMbjVxU0lZZkZMSGlnR2FMQ1hwd2FQaUNyY3Ur?=
 =?utf-8?B?ekdqUXdBSCtNaFdzaVJ1STNLWldQdThzTEJRVXVHcXN4MkJPUGJGdXFkNGZC?=
 =?utf-8?B?dWZhRGpSYWpKUVVCejdCMWszMHhLQ1BjOWlrbUhpVWJkTXlGU2JTSEdnMDBK?=
 =?utf-8?B?RkxBblphM3ZqVUcwdnR4dlhNKzYyYitOTXNLYUNOemhvRnJYbFFwaEd5YVhn?=
 =?utf-8?B?ekpxZWE3NlUzTXJnZUdhd0FHVXhVbjNDcjJuekNpR201RmMvOGJ6TGhRbU8w?=
 =?utf-8?B?RFczQTVLVng0SW9kM0V4S3JHZ1BPcE1VbXBxQ3Q2RjZXeEVKNkZPeHBmZDlI?=
 =?utf-8?B?TzdoRUhubEdJVFUyOXpwTzBlZWgvQUhhdEtVVjJ5NkdwbjMxajNFQTVNcnhw?=
 =?utf-8?B?RkZFUUdUWDB5b1NJeGZFRDM4ZG9XbXRaUE9MZm5YRjVQUDJEZGlHTHpibHJy?=
 =?utf-8?B?aGhzTVBrVUtUV1lNWkRjV2dDREYyZE1zZDhQVm1OdXE1QUJYbkVSWVlTSW5h?=
 =?utf-8?B?ODVSOHRCUU9UdytIaUp4Nmh6cmx1czJmWjBnNU5pZkcyZW13d3dZeUxVSUhU?=
 =?utf-8?B?elYvdnlLbzhNSzB6VW5nWnlWUWsyVWNwMUxJVk5lUm1ONU5PRHhtamtJeW1q?=
 =?utf-8?B?SGFkWkZldUZQTkRaMnNtS2FDTFdYUlR2cSt1UUQxNStCYTNUSWpWNnA5ZE1x?=
 =?utf-8?B?bTNsMkYvcnZ1VkY4R0JYK2puVkRCQWU3d1pMTlBkcXpPMjZoajVXWjRQeHk3?=
 =?utf-8?B?ek1nSzZUOVF6QWtKUmovdTd0aFo4dU9UWG9pZ3NLVmFXbXg0ZGJpQmRqYzFT?=
 =?utf-8?B?T0VEelJLTEFRVXVEbzB3Nmc1Ni9nK3BmREY0M1lsWW1jbFdrUzMyeUNkVGdD?=
 =?utf-8?B?K0txSi9GVFllM3JzTmx6Y0kweTlxaWE5YjZHT3puQWJRcG5ycHEwUUd6ekZa?=
 =?utf-8?B?MDRnSXJrOTVOczUrWXhRNkllN3c2NXAraGw4aGpnQ3loT0VnQ2xaRExqTVdi?=
 =?utf-8?B?dW56VXdEUk1VMlpIZFFPUC9qY253Y1I0QkROVTRHem03VjdqVmx4NTVzb3Iw?=
 =?utf-8?B?c1NheDRIV1dOSGZXeFdtTFhEOElRRHVkRElJdkYrSXB6a1h0TnMrMzEyRGpx?=
 =?utf-8?B?aTdkdE5LOW51OUpCOXpEWUlIRC9rVnVCd2kyYXFFVm03WWpHTUExUUlxUTJ5?=
 =?utf-8?B?VXRhOFdPUXB4ZmxNTW9XZmx5U2g0MzJUaWg5MHl0VUhjZGNEQUc2WFpGYjVa?=
 =?utf-8?B?ckxJaitKT2lUTUVrd1lRUTVWT01CYXdRRExocU1LMXJIK3BPb0JWZHhvV1lO?=
 =?utf-8?B?ZGZWck9JNWpja0NWSi9nRHB3MndiWnY3OXlEcWU0akkwL01Db2NDSzNxa3Ir?=
 =?utf-8?B?ZWd1OHFHaDA5cWxKSXQ3RDc1L3NteGIvaHY1cmhsZGVFNk5YTUtTL0VRV2pO?=
 =?utf-8?B?OHBnd3gvU0x0dzdtOHVrMEFZQ0htZkI5b05pTVR4Ym51Y3F2dVlQQzRPWTlR?=
 =?utf-8?B?aWVmRnF3bjJkMXpDa3R4ZDNkSFdFMjgyeGZ3UkRBL2Y1VkwrU2h5UTM5Vm5u?=
 =?utf-8?B?czhaODR3MHJRc2FUbVQzbllocTRYVHBiL3JuZUhqQ0dsUTZHZkZXNVVCUnNo?=
 =?utf-8?B?OVhjNlNOeXhlQVBRSWwvSnhLaitSeDR2Wk0yUXc3clpOOHlveE9XM29HVFRG?=
 =?utf-8?B?dTdKaVppRm5KVnFBOHhGNmM3bTFnTnM0ZEhMUGNDb0s3c3JQREIwV3JhTmho?=
 =?utf-8?B?Q0xBbEw0a1pNYnRMeldMYjRZRzFmcWVyTDlrZ3RjV1A4U2UrcG5jTlZOcUs4?=
 =?utf-8?B?eUJmQjluQkF1T2JWbnFDVkdNaTVBWUxnUFIvSEFWa0xLOGt1bXVTanhXQ3d2?=
 =?utf-8?B?eGVjVzhma1pkUnpCM2pLaUlNNWtiVUZWWDFZQmgyTzB0Z3h1ZDNRWUlDQXRK?=
 =?utf-8?B?K3JrbDkxMDdYVFdJUFhLOU1uWlhlZVBkbkFINkJmbkdTcFpWQUFIcU5saE5I?=
 =?utf-8?Q?NUUtUsSBt14Hf4x7+nT7iGea9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d70d29-36d9-4aed-8a0f-08dbd56405e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 14:09:37.5311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bo3HbBj/2K1bSJH5Aj6R7cmW2rCp0VxvxZGNtcXghoKNCdHSXvwqKY279Nn08OMzGcvwpo2rc5+Bovv7AKFzHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6642
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQm9yaXMsDQoNCllvdSBhc2tlZCBzZXZlcmFsIHF1ZXN0aW9ucywgYW5kIGl0J3Mgbm90IGNs
ZWFyIHRvIG1lIGlmIHlvdSBhcmUgc3VnZ2VzdGluZyB0aGUgYW5zd2VycyBiZSBzZW50IGFzIGVt
YWlsIHJlcGx5LCBvciBpZiB5b3UncmUgYXNraW5nIGZvciB0aGUgYW5zd2VycyB0byBiZSBhZGRl
ZCB0byB0aGUgY29tbWl0IG1lc3NhZ2UuIEJlbG93IGFyZSBteSBlbWFpbCByZXBsaWVzIHRvIHRo
b3NlIHF1ZXN0aW9ucy4NCg0KQm9yaXNsYXYgUGV0a292IHdyb3RlOg0KPiBXaGVuIEkgc2VlICJt
YXkiIGluIGNvbW1pdCBtZXNzYWdlcyAiU2xvdyBkZXZpY2VzIHN1Y2ggYXMgZmxhc2ggbWF5IG5v
dCBtZWV0IHRoZSBkZWZhdWx0IDFtcyB0aW1lb3V0IHZhbHVlIiB0aGVuIEkgd2FubmEga25vdyB3
aGF0IGRldmljZXMgYXJlIHRob3NlPw0KDQpUaGUgRVJTVCB0YWJsZSBzcGVjaWZpZXMgYW4gaW50
ZXJmYWNlIGZvciBob3cgdGhlIE9TIGNhbiBzZXJpYWxpemUgZXJyb3IgcmVjb3JkcyB0byBhICJw
ZXJzaXN0ZW50IHN0b3JlIi4gVGhlIGRldGFpbHMgb2YgdGhlIHBlcnNpc3RlbnQgc3RvcmFnZSBk
ZXZpY2UgYXJlIGltcGxlbWVudGF0aW9uIGRlZmluZWQuIFRoZSBFUlNUIHRhYmxlIHByb3ZpZGVz
IG1pY3Jvc2Vjb25kIHZhbHVlcyBmb3IgdGhlICJub21pbmFsIiBhbmQgIm1heGltdW0iIGFtb3Vu
dCBvZiB0aW1lIGl0IHRha2VzIGZvciB0aGUgaW1wbGVtZW50ZWQgZGV2aWNlIHRvIHByb2Nlc3Mg
YW5kIGNvbXBsZXRlIGFuIEVYRUNVVEVfT1BFUkFUSU9OIChhIHJlY29yZCB3cml0ZSwgcmVhZCwg
b3IgY2xlYXIgcmVxdWVzdCkuIFRoZSBjdXJyZW50IEFQRUkgRVJTVCBjb2RlIGhhcmRjb2RlcyB0
aGUgdGltZW91dCB0byAxbXMsIGFuZCBpZ25vcmVzIHRoZSBhY3R1YWwgdGltaW5nIGluZm9ybWF0
aW9uIHRoYXQgdGhlIHBsYXRmb3JtIGhhcyBwcm92aWRlZCBpbiB0aGUgRVJTVCB0YWJsZSBmb3Ig
dGhlIHBsYXRmb3JtJ3MgaW1wbGVtZW50YXRpb24uIFRoaXMgaXMgYSBwcm9ibGVtIGZvciBhbnkg
ZGV2aWNlIHRoYXQgY2FuIG9yIHdpbGwgdGFrZSBtb3JlIHRoYW4gMW1zIHdvcnN0IGNhc2UgdG8g
cHJvY2VzcyBhbmQgY29tcGxldGUgcmVxdWVzdGVkIG9wZXJhdGlvbnMuIE9uIGEgcGxhdGZvcm0g
dGhhdCB1c2VzIE5PUiBmbGFzaCBhcyB0aGUgInBlcnNpc3RlbnQgc3RvcmUiLCBmb3IgZXhhbXBs
ZSwgaXQgY2FuIGVhc2lseSB0YWtlIGxvbmdlciB0aGFuIDFtcy4NCg0KRGV0YWlsZWQgTk9SIGZs
YXNoIGV4YW1wbGU6DQpBIE1pY3JvbiBub3ItZmxhc2ggc3BlYyBzaGVldDogaHR0cHM6Ly9tZWRp
YS13d3cubWljcm9uLmNvbS8tL21lZGlhL2NsaWVudC9nbG9iYWwvZG9jdW1lbnRzL3Byb2R1Y3Rz
L2RhdGEtc2hlZXQvbm9yLWZsYXNoL3NlcmlhbC1ub3IvbXQyNXEvZGllLXJldi1iL210MjVxX3Fs
a3RfdV8wMmdfY2JiXzAucGRmP3Jldj05YjE2N2ZiZjJiMzY0NWVmYmE2Mzg1OTQ5YTcyZTQ1Mw0K
DQpQYWdlIDgyIGxpc3RzICJQYWdlIHByb2dyYW0gdGltZSAoMjU2IGJ5dGVzKSIgYXMgMTIwdXMg
dHlwaWNhbCwgMTgwMHVzIG1heC4NCg0KQSAzMktCIGVycm9yIGxvZyB3b3VsZCBiZSAoMzJLLzI1
NikgPSAxMjggbm9yLWZsYXNoIHBhZ2VzLg0KDQpXcml0aW5nIDEyOCBub3ItZmxhc2ggcGFnZXMg
d291bGQgdGhlbiB0YWtlIDEyMHVzICogMTI4ID0gMTVtcyB0eXBpY2FsLCBvciAxODAwdXMgKiAx
MjggPSAyMzAuNG1zIG1heC4NCg0KPiBXaGF0IGlzIHRoZSBhY3R1YWwgdXNlIGNhc2UgaGVyZT8N
Cg0KQWN0dWFsIHVzZSBjYXNlOg0KS2VybmVsIHBhbmljIC0+IFBzdG9yZSBjYWxscyBBUEVJJ3Mg
RVJTVCBjb2RlIHRvIHdyaXRlIHRoZSB+MzJLQiBlcnJvciBsb2cgdG8gcGVyc2lzdGVudCBzdG9y
ZSAtPiBFUlNUIGNvZGUgd3JpdGVzIHRoZSBlcnJvciBsb2cgdG8gbm9yLWZsYXNoLCB3aGljaCB0
YWtlcyBtb3JlIHRoYW4gMW1zIHRvIGNvbXBsZXRlLiBUaGlzIGlzIGV4cGVjdGVkLCBhcyBjb21t
dW5pY2F0ZWQgYnkgdGhlIHBsYXRmb3JtIHRvIHRoZSBPUyB2aWEgdGhlIG1heGltdW0gdGltZSBm
aWVsZCBpbiB0aGUgRVJTVCB0YWJsZS4NCg0KQ3VycmVudGx5IEFQSUUncyBFUlNUIGNvZGUgd2ls
bCBmbGFnIGEgdGltZW91dCBvZiB0aGUgd3JpdGUgb3BlcmF0aW9uIGFmdGVyIDFtcyBhbmQgcmV0
dXJuIGFuIGVycm9yIHRvIFBzdG9yZS4gTXkgcGF0Y2ggd2lsbCBsZXQgdGhlIHdyaXRlIChvciBy
ZWFkIG9yIGNsZWFyKSBvcGVyYXRpb24gdGFrZSBhcyBsb25nIGFzIHRoZSBtYXhpbXVtIHRpbWUg
RVJTVCBzYXlzIGl0IGNvdWxkIHRha2UgYmVmb3JlIGZsYWdnaW5nIGEgdGltZW91dCBhbmQgcmV0
dXJuaW5nIGFuIGVycm9yLiBUaGUgRVJTVCB0YWJsZSBoYXMgYSAiYXR0cmlidXRlcyIgZmllbGQg
dGhhdCBpbmNsdWRlcyBhICJzbG93IiBiaXQgdG8gYWxsb3cgdGhlIHBsYXRmb3JtIHRvIGluZGlj
YXRlIHRoYXQgdGhlIGFkZHJlc3MgcmFuZ2UgZm9yIHRoZSBlcnJvciBsb2cgImhhcyBzbG93IGFj
Y2VzcyB0aW1lcyIsIGJ1dCB0aGUgc3BlYyBkb2Vzbid0IGRlZmluZSB3aGF0IGlzIGNvbnNpZGVy
ZWQgYSBzbG93IGFjY2VzcyB0aW1lLiBNeSBwYXRjaCBhc3N1bWVzIHRoYXQgc2luY2UgdGhlIGN1
cnJlbnQgdGltZW91dCBpcyAxbXMsIGFueSBhY2Nlc3MgdGltZXMgZ3JlYXRlciB0aGFuIDFtcyB3
b3VsZCByZWFzb25hYmx5IGJlIGNvbnNpZGVyZWQgInNsb3ciLCBhbmQgdGhlcmVmb3JlIHRoZSBl
eHRlbmRlZCAoRVJTVC1kZWZpbmVkKSB0aW1lb3V0IGlzIG9ubHkgYXBwbGllZCBmb3IgaW1wbGVt
ZW50YXRpb25zIHRoYXQgaW5kaWNhdGUgdGhhdCB0aGV5IGFyZSAic2xvdyIuIEkgYXNzdW1lIHRo
YXQgcGxhdGZvcm1zIHdoaWNoIGJvdGhlciB0byBzZXQgdGhlICJzbG93IiBiaXQgd2lsbCBhbHNv
IHNwZWNpZnkgYWN0dWFsIHRpbWluZ3MsIGFuZCBwbGF0Zm9ybXMgd2hpY2ggZG9uJ3QgYXJlIE9L
IHdpdGggdGhlIGN1cnJlbnQgMW1zIHRpbWVvdXQuDQoNCj4gVXB0aHJlYWQgdGhlcmUncyBhIHF1
ZXN0aW9uIGFib3V0IHRoZSBBQ1BJIHNwZWMuIFRoYXQgc2hvdWxkIGJlIGV4cGxhaW5lZCB0b28u
IEJlY2F1c2UgSSBoYXZlIG5vIGNsdWUgd2hhdCAidGhlIEVSU1QgbWF4IGV4ZWN1dGlvbiB0aW1l
IHZhbHVlIiBpcy4NCg0KQXMgSSByZXBsaWVkIHRvIFRvbnkgdXB0aHJlYWQsIHRoZSBTZXJpYWxp
emF0aW9uIEFjdGlvbnMgdGFibGUgZW50cnkgZm9yIE9QRVJBVElPTl9USU1JTkdTIChodHRwczov
L3VlZmkub3JnL3NwZWNzL0FDUEkvNi41LzE4X1BsYXRmb3JtX0Vycm9yX0ludGVyZmFjZXMuaHRt
bCNzZXJpYWxpemF0aW9uLWFjdGlvbnMpIHNheXMgdGhhdCBpdCBpcyB0aGUgInZhbHVlIGluIG1p
Y3Jvc2Vjb25kcyB0aGF0IHRoZSBwbGF0Zm9ybSBleHBlY3RzIHdvdWxkIGJlIHRoZSBtYXhpbXVt
IGFtb3VudCBvZiB0aW1lIGl0IHdpbGwgdGFrZSB0byBwcm9jZXNzIGFuZCBjb21wbGV0ZSBhbiBF
WEVDVVRFX09QRVJBVElPTi4iIEJhc2VkIG9uIHRoZSBzcGVjLCBJIHRha2UgdGhhdCB0byBiZSB0
aGUgd29yc3QgY2FzZSB0aW1lIGJldHdlZW4gd2hlbiB0aGUgT1MgZG9lcyAiRVhFQ1VURV9PUEVS
QVRJT04iIGFuZCB3aGVuIHRoZSBPUyBzZWVzICJDSEVDS19CVVNZX1NUQVRVUyIgcmV0dXJuIEZB
TFNFIHJhdGhlciB0aGFuIFRSVUUsIGZvciB0aGUgd29yc3QgY2FzZSB0aW1lIG9mIGEgcmVhZC93
cml0ZS9jbGVhciBvcGVyYXRpb24gZm9yIHRoZSBtYXhpbXVtIHNpemUgc3VwcG9ydGVkIGJ5IHRo
ZSBwbGF0Zm9ybSdzIEVSU1QgaW1wbGVtZW50YXRpb24uDQoNCkRvZXMgdGhhdCBhbnN3ZXIgeW91
ciBxdWVzdGlvbnM/DQo=
