Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD807D9EAD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 19:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbjJ0RPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 13:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbjJ0RO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 13:14:58 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020003.outbound.protection.outlook.com [52.101.61.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AED67EF0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 10:08:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9EwNsOz+XH7wde+ZO06zVFH3fOEG19myfMdDvArtYm9Yd7wsUB6pyTx8f0r+mTrGlMLJJYQb/ypP4ThZnRMRsgC/XhfrExAOAeTXV/PR3RDI5Pt8NKt5J4rF8V0kpuUqjR2fUiDcWMYEawTdhiwPEhU3zqE/pzEIgQ00cFljelViu4XGET7NWj5L26zMYOocQMkAxEPvp3QD0hW54VZmmH5iKWQrbfC0/dT41lavWFkTHf0xuYi6XTG73rx9p/0VGMmIP5UtR8d/W27gK1+1ANhj2kC5hcch8W0pgi4toiOR3sUbiUQ9dpgj/fXefg5+44Vh9CbuWet7i6pJeyWcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axX2OJFhYimNVKiQxuM5BoG7hrbsQpWOabQMAeLt4XU=;
 b=eD8iJGiDes6miJ3f796+/jKaov8Ly8COVNuVjpTwFzwyot5l6cMIqoYiTkzMzt7Kee4MhfGplJ4St8wpu+7XTeyIzP4NOFVg0GivuJWQlaBmWM+YMKIIQ/a7rL0x4+0BJK/TsXxu5/DrEeZMBE6x44KKhMd01nlnoXvgzTUxbIrYdeyQdUFw/hFVxCStgfvO7JUTOyK4qYN5ywXXOulzOXnFxkkh8g1Lu14BvG+2+yK9OfJF6FCwnc0WrlZzQhtMza7dgb77YaGknN3dKvaHDYssXnNi7F4uJ8P5QeA78dRWSJD18W/uGY+/uhkquKxUUBPnYVHF7J38KDK6VixZGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axX2OJFhYimNVKiQxuM5BoG7hrbsQpWOabQMAeLt4XU=;
 b=Eb01UXgBqnpNqRdpUInG3QCZpPAsICYzmGEgVscEvRn+b84tKejYc4GuKRLfFLdYKHzI/sYOJtqpMiiMTU7zGaQXiV0PUB0uxTyueCIzDrmwTPlL8h6pYEPaaGcVGjWTYvGRZNhoyRXNG3xxiUfJB1aUytvgo4H2M6d9yyXuaJw=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH7PR21MB3164.namprd21.prod.outlook.com (2603:10b6:510:1d4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.8; Fri, 27 Oct
 2023 17:08:13 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1cab:1621:900d:fbc6]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1cab:1621:900d:fbc6%6]) with mapi id 15.20.6954.009; Fri, 27 Oct 2023
 17:08:13 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
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
Thread-Index: AQHaBtSo1KeOz02diUCTmiNYqoVgMbBbLUcggAAf5wCAAoVioIAAChaAgAAEaEA=
Date:   Fri, 27 Oct 2023 17:08:11 +0000
Message-ID: <BYAPR21MB1688E209BD2610B3704E207DD7DCA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20231024234829.1443125-1-rick.p.edgecombe@intel.com>
         <SN6PR2101MB169309ACB83862DA6E572A89D7DDA@SN6PR2101MB1693.namprd21.prod.outlook.com>
         <fd2426ee900e4f3a57659f3688c5bb652779785c.camel@intel.com>
         <BYAPR21MB1688E43151404FFB435ACF41D7DCA@BYAPR21MB1688.namprd21.prod.outlook.com>
 <3936d8f9abaf8eba98963a13ad75024931aeb930.camel@intel.com>
In-Reply-To: <3936d8f9abaf8eba98963a13ad75024931aeb930.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0f4d4ced-7fe9-4fc0-98db-c1dc27c25cfc;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-10-27T17:02:25Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH7PR21MB3164:EE_
x-ms-office365-filtering-correlation-id: c4ccc75d-82b7-47e7-2bed-08dbd70f4d0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BExud6e3gXXE1ffqHS+LEv73sy+P5E1jXe/ldI+v4pxU9Hxm7gQcLBv29pWEAVrNhC9VE7qhrbaZ6wJcSoEZFMclBqjLD8ec0AEc9CiqIVRxjE0x0CuY1yb3h9V3TpOOJb8YtGt0oHu8KRu/WA0hGuneC9800TFRGDdS+HazoyEvN1CZkhaXmGirNQp77nL/piYY7IkgOArVeL8PLOVUlqSTiz2wD7b1O5i+qg+jINNTNE3Yw4ivjx1iK5cwnQjzYOduD0Ri5oY2e9UpAExvLN+9obE5uiz3zIVJm+4BwKGx288z9i63RA905R4M5fLU3uJNvtQqW1noceq6tqVpAbI55QjG8imkwyFGK6i8q3lHDZlU72KuklUKh7wGMHi3EckvfMkf8zqmgn9vIsb1itQ2cPlMNJk6pNIU4dhC/nYAOAoytOYjelm2Wt+WADzAzCAUCA6BZpAzMz5gEYRY31/QAS+d4AkwQxi/kMRKFd8Jxs97Oj4POo9P1eQIFLt2yJuDN4p9k5BTebpvTfi8VMAo8xjAfqq89z2TB6y/2Xtb/pVogXMqyZFMMpZFn6oQI4I+c78B2PF54tK19CJyCK28THdb12tUSXqs7XtrnLIgLrqV981HvY+UBbFj8mnkHUnqoZno+DtIB/owQO/dDsMNcf+f6NSus/t2WOD8YcxxPQsoJrFh+85/IR0bNidsSMcZBJH48lZD5hJfTJUHLzx4OLeDRVFOjXXgDmOU7tc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(366004)(396003)(230273577357003)(230173577357003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(38070700009)(921008)(55016003)(9686003)(6506007)(71200400001)(7696005)(478600001)(10290500003)(66446008)(86362001)(33656002)(122000001)(82950400001)(38100700002)(82960400001)(7416002)(316002)(5660300002)(8990500004)(4001150100001)(2906002)(26005)(83380400001)(110136005)(41300700001)(66946007)(64756008)(8936002)(76116006)(66476007)(52536014)(66556008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDRKSUkreGpjMlhGSlVxa21ENlp0c2hNd2ZwZzdRRlNVSFN0RjFtWXlvWFN0?=
 =?utf-8?B?WXBVUGFNMWtZT0lUZlRiV1c2WXVyN214OGlldG5RWkkvdTBuRWZhSENabXUw?=
 =?utf-8?B?aFRReSsxUlJaU1d2bE9odmRLMXVqakhpemNtUC9OWnVKWVhIWWJmQ0ZILzE0?=
 =?utf-8?B?RmZXQ0dGRFBTVVdaejRLa2FBV3pUbmV4ZmJhcUl6OVFTT1JtM0FMMk1XcnRm?=
 =?utf-8?B?K0ZsUTRVSXBnUy9EY1hWejk3bUlYZ1podW4weDFlZkZ4bkhHQW9DN2Y1MXhM?=
 =?utf-8?B?QXdnL1RaUXUvOG4xYnpqR0dqTFRraHVraXdycldidFc1TjdTYzhEYUZVbmwy?=
 =?utf-8?B?ajRqMjBFTi9WcStFTERtS1ZhaS95REhzZVhoZDIrN0VTUUluT0k5dVdYcCtI?=
 =?utf-8?B?OW0zd25TYW9sc2ZCeUZiMWlmaGxrM1pWUHAwVEU0bkVKUGd5K1Yrc2hkM3k4?=
 =?utf-8?B?RnIxUnp3eWtIYy9rS1hYcW9TeG5DSXREckNOVU9uS1JEQU43OEd0eXh5L2p5?=
 =?utf-8?B?OXBEa1NCY1VMODJUZXRFS0EwZEtTbjFYT2JXZDd5TUU2YmRTVWVSWGlMU2Zm?=
 =?utf-8?B?eitDRDQ3RFlzaUZDT2I0SDE2bENwenQyZDloUjNSR29YR2R0c1pMS1NNb3RD?=
 =?utf-8?B?NzYyckluOXoyeVdMTmdYb21TUUNJZ2hoK1lHKzZGdEpnOFhlM1NMQkdYTnZN?=
 =?utf-8?B?VFJ3dk11ajRiYUZMUzNGclBkcGhtN1ZFcWpqbUV6MmtsTldUSE9aV01DeUJt?=
 =?utf-8?B?MFJVN0dWV1BiY0VrS2drMnQvTUhsSUZPd0k4YWkzU0JINDVGMGozaGpuUnJP?=
 =?utf-8?B?dGU5VktmYmtCZVBhYlVoVGRqUjViR3V1S2ZBVUpWNlNZY2w0QU4vczZGa25V?=
 =?utf-8?B?UHhiZW1ldEs2L1J6TEhHUGFOM0h4eG1lblFOaWVCTnN5cUJWd2FyRjBnNUhY?=
 =?utf-8?B?Qk5UTGtwaVFnMkh6ci8xM1phZ1hMV2x1bkFCcURHMTkyQklwYkp1cUZoeTBy?=
 =?utf-8?B?N0JPOVlBbitiTmxkbSt5K3ZXbGpuRjVYWWs0ekFJTVJDaHMyRGx4dTliR3Rq?=
 =?utf-8?B?RDVZYnJOVXlDZlNjZm5JOEJSbUpKWTRWN2Zid3pzTnI2VG54SEg5d1AzeGUz?=
 =?utf-8?B?cXQzMVI1T3c5NGlEWUhmQkFSNThsTzNCNTY0K0tKTUdTa2x2Q1l2cjdLbTBF?=
 =?utf-8?B?NVRxclJmbkU1SXRCZVdMVGk5SUxWUXVGR1oyNlBkSXppdUpVNmVXVGFITkVt?=
 =?utf-8?B?QklDdGN6TjM3QnhhbGN6aW4vbThhVDVCaXhLQXpIeHNObmtCTk9TVmNzMytn?=
 =?utf-8?B?Z0FWNGY3aWN3WWtpU25IUm1TSzYwRmdaemtaV3dFakNod2pLbjFZanA1WCsv?=
 =?utf-8?B?THI3RkpadkFnM2VqbTdpUzRBZWJTRStQV3d2a3U0NFhOWm5Ba2VsMElXaytT?=
 =?utf-8?B?aWZRVUtnemhRZjFJb2FDaWh1MU9TZ0N4UTJSU0NNR0JGbVpRb1p5ZWpLK3Bn?=
 =?utf-8?B?RjlyZ0lIWkM3WVMyMklyUVkvcytNQmJzbnFBN2JxUlZmUUp3OG52enZlekV0?=
 =?utf-8?B?TXRxSEptTE5vak8zSmNRL0NSK0N5WWs0SjBhY2dHcUNqRTNzN1FXd0Jza3Vl?=
 =?utf-8?B?SWZkdTcwOWRPdWRIWUtLQnZ1L0I2ZERTRzNNbkRvL0NTUHJEU3FvNWY0a1Ix?=
 =?utf-8?B?UkxuTUFWY2NValI1MHVyZWlScU4wNkpSWG5mRVBRR053d3hSZmF4V3VNVUNv?=
 =?utf-8?B?dGdjeUkwRGs1S05nZXhpV1V2NUtkb0VyU29PcHBMZk5mRU9XQkQ4ZnR3b2ox?=
 =?utf-8?B?WVJqRDB6TFhWeEZDZUcxc3lXZ2Y3Uit3NnNCUXdFVW1QUC9PT2dqcXdYa1JB?=
 =?utf-8?B?ZnFhdGk1UFdpYlExdzN2T05xUEZDZ3lwRFVFSFo2dzRUbUZKU0Flem93Q3ht?=
 =?utf-8?B?bjRPZU9uWG8yeUtna1kvd3VNWUtiREdBTjlXL3diQ1RpWGZoa3ZYRFF1RmhW?=
 =?utf-8?B?MlZITU9FSzZ2ZlBwVHpJNG1kYmxoY3NIQ1EvQXUxRkhFSUFqNWd3OGpMZHZU?=
 =?utf-8?B?dFJyc245SUVuaE1uZkh6enB2SUhocDUwc3ovNXI5bGF5NW9jeDdlK2QyREM4?=
 =?utf-8?B?VHZtMGVoTWFrUXN0VVlkRDZtOVZHM2JCNkwrZnVHajd2YmVFbFpIZzVtbmt5?=
 =?utf-8?B?aWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ccc75d-82b7-47e7-2bed-08dbd70f4d0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 17:08:11.9773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oOmLQ5sZDp2UdbZMAGQA4T4MTkxUwpIHuySHBSfVY+W2Xa4hDdX7M98Mo4ewKR/gy36/n52W4EIR7HdKtpo6CKRN/+A6SDtkFLP7lUwFmzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3164
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRWRnZWNvbWJlLCBSaWNrIFAgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPiBTZW50
OiBGcmlkYXksIE9jdG9iZXIgMjcsIDIwMjMgOTo0NyBBTQ0KPiANCj4gT24gRnJpLCAyMDIzLTEw
LTI3IGF0IDE2OjM3ICswMDAwLCBNaWNoYWVsIEtlbGxleSAoTElOVVgpIHdyb3RlOg0KPiA+IFdo
ZW4gYSBjYWxsZXIgZ2V0cyBhbiBlcnJvciBmcm9tIHNldF9tZW1vcnlfZGVjcnlwdGVkKCksIGl0
IHdpbGwNCj4gPiB0YWtlIHN0ZXBzIHRvIHRyeSB0byBnZXQgdGhlIG1lbW9yeSBiYWNrIGludG8g
YSAiZ29vZCIgc3RhdGUgc28NCj4gPiB0aGF0IGl0IGNhbiBwdXQgdGhlIG1lbW9yeSBiYWNrIG9u
IHRoZSBmcmVlIGxpc3QuwqDCoCBJZiBpdCBjYW4ndCBnZXQNCj4gPiB0aGUgbWVtb3J5IGJhY2sg
aW50byBhIGdvb2Qgc3RhdGUsIHRoZW4gaXQgd2lsbCBsZWFrIHRoZSBtZW1vcnkuDQo+ID4gSSB3
YXMgdGhpbmtpbmcgYWJvdXQgaG93IHRoZSBjYWxsZXIgd2lsbCBtYWtlIHRoYXQgZGV0ZXJtaW5h
dGlvbi4NCj4gPiBJcyBpdCBiYXNlZCBvbiB3aGV0aGVyIHNldF9tZW1vcnlfZW5jcnlwdGVkKCkg
c3VjY2VlZHM/wqAgSSB0aGluaw0KPiA+IHRoYXQgd29ya3MsIGFzIGxvbmcgYXMgKGZvciB4ODYg
YXQgbGVhc3QpIHNldF9tZW1vcnlfZW5jcnlwdGVkKCkNCj4gPiBlbnN1cmVzIHRoYXQgdGhlIGd1
ZXN0IFBURXMgYXJlIGFsbCBtYXJrZWQgInByaXZhdGUiIGJlZm9yZSBpdA0KPiA+IHJldHVybnMg
c3VjY2Vzcy4NCj4gPg0KPiA+IFNvIG1heWJlIG15IGNvbW1lbnQgYXBwbGllcyB0byB0aGUgY2Fs
bGVyIGluIHRoZSBzZW5zZSBvZg0KPiA+IHVuZGVyc3RhbmRpbmcgd2hhdCBzdGVwcyB0aGUgY2Fs
bGVyIHNob3VsZCB0YWtlIHRvIHJlY292ZXIgZnJvbQ0KPiA+IGFuIGVycm9yLCBhbmQgdGhlIHBv
c3NpYmxlIG91dGNvbWVzIGZyb20gdGhlIGF0dGVtcHRlZCByZWNvdmVyeS4NCj4gDQo+IFNpbmNl
IEkgd2FzIGRyb3BwaW5nIGZyZWVfZGVjcnlwdGVkX3BhZ2VzKCkgaGVscGVyLCBJIHdhcyB0aGlu
a2luZyB0bw0KPiBhY3R1YWxseSBqdXN0IGxlYWsgdGhlIHBhZ2VzIGlmIHNldF9tZW1vcnlfZGVj
cnl0ZWQoKSBmYWlscy4gQXMgaW4sIG5vdA0KPiB0cnkgdG8gcmVjb3ZlciB0aGVtIHdpdGggc2V0
X21lbW9yeV9lbmNyeXB0ZWQoKS4gU28gdGhlIGtlcm5lbCB3aWxsIGRvDQo+IHRoZSAzIHJldHJp
ZXMgdGhhdCB0aGUgcmVjZW50IEh5cGVyViBmb2N1c2VkIHBhdGNoIGFkZGVkLCBhbmQgdGhlbiB3
YWxrDQo+IGF3YXkuDQo+IA0KPiBUaGUga2VybmVsIHdpbGwgYWxyZWFkeSBiZSB3YXJuaW5nIGFi
b3V0IHRoaXMgc2l0dWF0aW9uLCBzbyB3ZSBhcmUgbm90DQo+IGV4cGVjdGluZyBmb3IgaXQgdG8g
YmUgY29tbW9uLiBGb3IgcmFyZSBjYXNlcywgaXQgc2VlbXMgc2ltcGxlciB0byBqdXN0DQo+IGxl
YWsgaXQsIGFuZCB0aGVuIHNldF9tZW1vcnlfZW5jcnlwdGVkKCkgY2FuIGJlIHNpbXBsZXIgYXMg
aXQgZG9lc24ndA0KPiBuZWVkIHRvIHdvcnJ5IGFib3V0IGhhbmRsaW5nIG1peGVkIHJhbmdlcyBy
ZXR1cm5pbmcgc3VjY2Vzcy4NCj4gDQoNCkkgbGlrZSB0aGF0IGFwcHJvYWNoIGV2ZW4gYmV0dGVy
IHRoYW4gdHJ5aW5nIHRvIGZpeCB0aGluZ3MgdXAgYW5kIGdldA0KdGhlIG1lbW9yeSBiYWNrIG9u
IHRoZSBndWVzdCBmcmVlIGxpc3QuICBJIGFncmVlIHRoZSBlcnJvciBjYXNlIHNob3VsZA0KYmUg
cmFyZSwgYW5kIEknbSBnZW5lcmFsbHkgbGVlcnkgb2YgcHV0dGluZyBtZW1vcnkgb24gdGhlIGZy
ZWUgbGlzdA0Kd2hlbiB0aGVyZSdzIHNvbWUgZG91YnQgYWJvdXQgdGhlIHByaXZhdGUvc2hhcmVk
IHN0YXRlIG9mIHRoZSBwYWdlDQpmcm9tIHRoZSBob3N0L1ZNTSBzdGFuZHBvaW50Lg0KDQpNaWNo
YWVsDQoNCj4gSSdsbCB1cGRhdGUgdGhlIGxvZyB0byBjbGFyaWZ5IHRoZSBpbXBvcnRhbmNlIG9m
IHRoZSBQVEUgYmVpbmcgbWFya2VkDQo+IHNoYXJlZCBpbiB0aGUgZ3Vlc3QsIGFuZCBwb3N0IGEg
djIuDQoNCg0K
