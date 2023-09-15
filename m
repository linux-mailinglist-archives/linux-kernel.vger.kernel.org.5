Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AAD7A1AEF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbjIOJoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbjIOJoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:44:00 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2077.outbound.protection.outlook.com [40.107.20.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F57119BC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5de9P6blzGhytrmp3ovTvUNy8cXEn8GoK7iBXCq1H4=;
 b=J4VBDo/uRfMk5REx+/U0vz4lJEGVhEhpkl7Y1BddJ+u+qUfz5kfE0F+kgIXZ7/DVLyjioE+VKx1+9BQzUxQaQKOYQ4n0wSmJvYjlofpsvkvekxQhj0BacBWHNpmcAmB8DlngPoG+D2zf4Sv+p49Hs+FALcjwi0hLKEpNZR1aNRQ=
Received: from DU7PR01CA0036.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::25) by AS8PR08MB9386.eurprd08.prod.outlook.com
 (2603:10a6:20b:5a9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 15 Sep
 2023 09:42:56 +0000
Received: from DBAEUR03FT007.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:50e:cafe::a1) by DU7PR01CA0036.outlook.office365.com
 (2603:10a6:10:50e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 09:42:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT007.mail.protection.outlook.com (100.127.142.161) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.21 via Frontend Transport; Fri, 15 Sep 2023 09:42:56 +0000
Received: ("Tessian outbound d084e965c4eb:v175"); Fri, 15 Sep 2023 09:42:56 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 240affc03f652910
X-CR-MTA-TID: 64aa7808
Received: from 937c3b1f2673.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id B2391B64-9582-46D9-99E2-F54DCC56FD09.1;
        Fri, 15 Sep 2023 09:42:50 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 937c3b1f2673.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 15 Sep 2023 09:42:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCEf16pKDzWWY13WW5bXyYtIVwhNWxn0cSwYVdaRkv3t4pBxjNz/xlclgxwrMsuR2QFJWDZqh25a9+fUgyVNJRXrfSVm8eRF+aaOuTQ6peiiUCCZMJqP5USJYhody5Sydg+n1c4Af1K7PvcK/vSWSBgpmd9V7/P96tY0sb/OtJQcP4+G/5jSb54axus9BrTzE96RDwk1XU9Ja0YJ1n4eC5p4KKQs/Ff8WgW/RP+F1VLmHhKFwuOv7c6lrHgQs2vVREUynoVXTkUc54FmEUNpn9Y8bCXSZYztazrTd2lr9kW3vxMGLLeu1XQXevJkytWtIFhWy5AleIqEMGzPc/t9Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5de9P6blzGhytrmp3ovTvUNy8cXEn8GoK7iBXCq1H4=;
 b=RKXy9Mghb6hWwouvdMhDN8Jr5FZQ6ZMGJTVggalG89u4lRJBi9wI3KA9Qc2ZRQHFI5vwWvNRwvJJxu7ZSmMn5+iFv9iWziGIwXkjgIpDQcZw0M9pnhd/nf2L/AwPpbTM3RduT3hUo31HVmGQ9YDnNj40WpQw5HSslYTOhiArfGmY5pflhtbvCRbLq+so3V05VXvtla/J1Kwe5VuIPgaXKhLJuBD0Vrp0rchqYaK+ErKgkuLdp/fBJo7RVAlaYXWSLUFh3Eqk84QddM5gYEh9g4YkPTqxpkYLTb+eXf8iYBuvDRlOMcNGp8w430yjK/pxtOgC0twpVnnsWqvxgWHATw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5de9P6blzGhytrmp3ovTvUNy8cXEn8GoK7iBXCq1H4=;
 b=J4VBDo/uRfMk5REx+/U0vz4lJEGVhEhpkl7Y1BddJ+u+qUfz5kfE0F+kgIXZ7/DVLyjioE+VKx1+9BQzUxQaQKOYQ4n0wSmJvYjlofpsvkvekxQhj0BacBWHNpmcAmB8DlngPoG+D2zf4Sv+p49Hs+FALcjwi0hLKEpNZR1aNRQ=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by GV1PR08MB7313.eurprd08.prod.outlook.com (2603:10a6:150:1c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 09:42:44 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::7e2f:184:7fc7:6448]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::7e2f:184:7fc7:6448%7]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 09:42:43 +0000
From:   Justin He <Justin.He@arm.com>
To:     Robin Murphy <Robin.Murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: RE: [PATCH] dma-mapping: fix dma_addressing_limited if dma_range_map
 is scanned
Thread-Topic: [PATCH] dma-mapping: fix dma_addressing_limited if dma_range_map
 is scanned
Thread-Index: AQHZ5VTJb5HgcbylTEiPRH8iRHuc47AXFd0AgASO8NA=
Date:   Fri, 15 Sep 2023 09:42:43 +0000
Message-ID: <DBBPR08MB4538A34E4C8ADF6344956AC3F7F6A@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <20230912084002.2168-1-justin.he@arm.com>
 <2b4a7aee-1997-cf2f-e8e8-19ab4adc09b5@arm.com>
In-Reply-To: <2b4a7aee-1997-cf2f-e8e8-19ab4adc09b5@arm.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: DBBPR08MB4538:EE_|GV1PR08MB7313:EE_|DBAEUR03FT007:EE_|AS8PR08MB9386:EE_
X-MS-Office365-Filtering-Correlation-Id: 2234d4e3-0f7d-480b-e3e9-08dbb5d02402
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: OectdTmuGarwAPxRGul6HcAeFsHt90O7F7dvd7gICROwaTiuJd2NFndATk8Wv5LoODkQmcdNyWb9r8pVLmfpgAmSMD4j7k9ZVa3d3+t4qMMolBx37d35Usflbo0WoY8//XfZ8H4gEWZ1Z3s8IJzZfJHzXF+uMiQ4wbytcHRHCGPcf3Rz8YI/mV1kW6lbkzUYu6+lKhKY0fm8CZOSiAQByQpxJmhRczVUlc4qwTa1RX9bEnGMiugiOkHVw4Goh0KYVoenyU9ORXQa4MYBl8s6LKmAZTYHlIAwRxkft3k/HhcGK/N19YpKrL1AgcUpbZ+80cpFFu8QI8+nKOJ0qke2Z2kn0Afa1p2W4/KLr+/1rib1F6mhNaIH6/2YoKnxkBmSHSjHe38gOoEgmZd0ByrB9PADFq51L9FulmGxk5acKzkgrx9K4p/MLuMOMZSoSkV/Ed2Te+MCHc+LzlMxHoDGWnjNXd1uAemNojO/8HxN+Ccc4qGCRkr93tXWcvONprsfyzS5UpDVw4TVoIzPy7MUnplYjVL73FZtghRjEBt79qp1QsUht0DU9lZVwifSbG6T2H1a7e0O5Sgo6LhsEsN6nXGuPdLor/f+ScCJQNberkTOhEDdeAjFiaDmDcR4q+WZ
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(396003)(366004)(346002)(1800799009)(186009)(451199024)(66946007)(76116006)(110136005)(55016003)(41300700001)(66446008)(54906003)(64756008)(66556008)(66476007)(9686003)(316002)(5660300002)(26005)(83380400001)(52536014)(33656002)(122000001)(38070700005)(2906002)(86362001)(38100700002)(8676002)(4326008)(8936002)(71200400001)(6506007)(478600001)(7696005)(53546011);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7313
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT007.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 92f2f0b3-7a40-4ac9-2f0c-08dbb5d01c2b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SNJM8Jo90oJyd8gvpJssQGn63WBbD6Oe/b2t1efUSzq5nkFXud6hnamQxyBZxR0+GmoaSEVMGVRRc41ng/LS0rSW4/gRKnijLcPYDX9u8Zx19DHymF6UMasceonQKWabwCQ+quVZXtUZYzpQSewcC0hvO9W/yGRNmUmcG47VYr7kAlWn1LWTABUB4GLErfcJyFLcrZw5fRo56+U+kSupgB/XMB8Mf8wLHBQ9I0bnMKfQp/rRIExhhBuLOnTbmEq4sxO0G9xgZTNnqJWTq7Jc8c5HtfIBmwGPB9Zuu0tPEYH0Loqw2klWauoVMvyr7EgVqxnjc70rSBkXvBUxgFaU1xVJCyPaFTyoNz/zlBUJmwErl1fx/e8ThT8ZD6AuCeSbw27v4dViCPhFwaLXghFZDt+R1EmWFW6pGXwidgFNX0Y3slS/A10VULj2cUt04Thnk9j2WwHbMEl7wxYfNKwLKKk5vPAIktwEA0EtRnRLrKZem+1ZdnTlb0K2I93mbGuguARbPJADJrQd2KUcA2xkAUpQcY3h39t/5DhMV6Q5+SiwS515D9aKkkrxhxA4UjI66KHqbZ/FpeSSzZTxumSBEfTtYx/JP6MAi5TE64UB9cN7w4Nnlp/0n2zMPc2X+osifTa9/kCbpGS3AQqZbGObM9iy9P+2gz6qVsbON6yD6cRN+f3uiUyG/LCbLHgrs/4QwwTCR1cd47ywcNUJ+Y8lMBAdolK+YL3idcChXnNf5cUs6bHzxPf3bUfscQihRqCw
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(1800799009)(82310400011)(186009)(451199024)(46966006)(40470700004)(36840700001)(82740400003)(40460700003)(26005)(52536014)(81166007)(5660300002)(8676002)(4326008)(8936002)(83380400001)(33656002)(36860700001)(86362001)(2906002)(40480700001)(47076005)(336012)(55016003)(356005)(70206006)(110136005)(54906003)(53546011)(7696005)(6506007)(70586007)(478600001)(41300700001)(9686003)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 09:42:56.5051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2234d4e3-0f7d-480b-e3e9-08dbb5d02402
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT007.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9386
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iaW4sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iaW4g
TXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4NCj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVy
IDEyLCAyMDIzIDc6NTcgUE0NCj4gVG86IEp1c3RpbiBIZSA8SnVzdGluLkhlQGFybS5jb20+OyBD
aHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT47IE1hcmVrDQo+IFN6eXByb3dza2kgPG0uc3p5
cHJvd3NraUBzYW1zdW5nLmNvbT47IGlvbW11QGxpc3RzLmxpbnV4LmRldg0KPiBDYzogbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkbWEtbWFwcGlu
ZzogZml4IGRtYV9hZGRyZXNzaW5nX2xpbWl0ZWQgaWYNCj4gZG1hX3JhbmdlX21hcCBpcyBzY2Fu
bmVkDQo+IA0KPiBPbiAxMi8wOS8yMDIzIDk6NDAgYW0sIEppYSBIZSB3cm90ZToNCj4gPiBBZnRl
ciBzY2FubmluZyB0aGUgZG1hX3JhbmdlX21hcCwgaWYgaXQgaXMgZm91bmQgdGhhdCBub3QgYWxs
IG9mIHRoZQ0KPiA+IHN5c3RlbSBSQU0gcmFuZ2VzIGFyZSBlbmNvbXBhc3NlZCB3aXRoaW4gaXQs
IGFuIGluY29ycmVjdCBjYWxjdWxhdGlvbg0KPiA+IG9jY3VycyBmb3IgZG1hX2FkZHJlc3Npbmdf
bGltaXRlZCgpLCB3aGljaCBwcmV2ZW50cyB0aGUgbnZtZSBkZXZpY2UNCj4gPiBkbWEgbWFwcGlu
ZyBpbiB0aGUgY2hlY2tpbmcgcGF0aCBvZiBwaHlzX3RvX2RtYSgpLg0KPiANCj4gTml0OiB0aGUg
c3ViamVjdCBhbmQgdGhpcyBkZXNjcmlwdGlvbiBhcmVuJ3QgdmVyeSBjbGVhciAtIHRoZSBrZXkg
cG9pbnQgaGVyZSBpcyB0aGUNCj4gdW51c3VhbCBjYXNlIHRoYXQgdGhlIHJhbmdlIG1hcCBjb3Zl
cnMgcmlnaHQgdXAgdG8gdGhlIHRvcCBvZiBzeXN0ZW0gUkFNLCBidXQNCj4gbGVhdmVzIGEgaG9s
ZSBzb21ld2hlcmUgbG93ZXIgZG93bi4gVGhlcmUncyBubyBpc3N1ZSB3aXRoIHRoZSBtb3JlIHR5
cGljYWwNCj4gY2FzZSB3aGVyZSBzb21lIFJBTSBleGlzdHMgYWJvdmUgdGhlIHRvcCBvZiB0aGUg
cmFuZ2UgbWFwLCBzaW5jZQ0KPiBidXNfZG1hX2xpbWl0IHdpbGwgY2FwdHVyZSB0aGF0IGFuZCB3
b3JrIGFzIGV4cGVjdGVkLg0KPiANCk9rLCBob3cgYWJvdXQgDQpkbWEtbWFwcGluZzogZml4IGRt
YV9hZGRyZXNzaW5nX2xpbWl0ZWQgaWYgZG1hX3JhbmdlX21hcCBjYW4ndCBjb3ZlciBhbGwgc3lz
dGVtIFJBTQ0KDQo+ID4gRS5nLiBPbiBhbiBBcm12OCBBbXBlcmUgc2VydmVyLCB0aGUgZHNkdCBB
Q1BJIHRhYmxlIGlzOg0KPiA+ICAgTWV0aG9kIChfRE1BLCAwLCBTZXJpYWxpemVkKSAgLy8gX0RN
QTogRGlyZWN0IE1lbW9yeSBBY2Nlc3MNCj4gPiAgICAgICAgICAgICAgew0KPiA+ICAgICAgICAg
ICAgICAgICAgTmFtZSAoUkJVRiwgUmVzb3VyY2VUZW1wbGF0ZSAoKQ0KPiA+ICAgICAgICAgICAg
ICAgICAgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgIFFXb3JkTWVtb3J5IChSZXNvdXJjZUNv
bnN1bWVyLCBQb3NEZWNvZGUsDQo+ID4gTWluRml4ZWQsIE1heEZpeGVkLCBDYWNoZWFibGUsIFJl
YWRXcml0ZSwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgMHgwMDAwMDAwMDAwMDAwMDAw
LCAvLyBHcmFudWxhcml0eQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAweDAwMDAwMDAw
MDAwMDAwMDAsIC8vIFJhbmdlIE1pbmltdW0NCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
MHgwMDAwMDAwMEZGRkZGRkZGLCAvLyBSYW5nZSBNYXhpbXVtDQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgIDB4MDAwMDAwMDAwMDAwMDAwMCwgLy8gVHJhbnNsYXRpb24gT2Zmc2V0DQo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgIDB4MDAwMDAwMDEwMDAwMDAwMCwgLy8gTGVuZ3RoDQo+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgICwsICwgQWRkcmVzc1JhbmdlTWVtb3J5LCBUeXBl
U3RhdGljKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgIFFXb3JkTWVtb3J5IChSZXNvdXJjZUNv
bnN1bWVyLCBQb3NEZWNvZGUsDQo+ID4gTWluRml4ZWQsIE1heEZpeGVkLCBDYWNoZWFibGUsIFJl
YWRXcml0ZSwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgMHgwMDAwMDAwMDAwMDAwMDAw
LCAvLyBHcmFudWxhcml0eQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAweDAwMDAwMDYw
MTAyMDAwMDAsIC8vIFJhbmdlIE1pbmltdW0NCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
MHgwMDAwMDA2MDJGRkZGRkZGLCAvLyBSYW5nZSBNYXhpbXVtDQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgIDB4MDAwMDAwMDAwMDAwMDAwMCwgLy8gVHJhbnNsYXRpb24gT2Zmc2V0DQo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgIDB4MDAwMDAwMDAxRkUwMDAwMCwgLy8gTGVuZ3RoDQo+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgICwsICwgQWRkcmVzc1JhbmdlTWVtb3J5LCBUeXBl
U3RhdGljKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgIFFXb3JkTWVtb3J5IChSZXNvdXJjZUNv
bnN1bWVyLCBQb3NEZWNvZGUsDQo+ID4gTWluRml4ZWQsIE1heEZpeGVkLCBDYWNoZWFibGUsIFJl
YWRXcml0ZSwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgMHgwMDAwMDAwMDAwMDAwMDAw
LCAvLyBHcmFudWxhcml0eQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAweDAwMDAwMDYw
RjAwMDAwMDAsIC8vIFJhbmdlIE1pbmltdW0NCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
MHgwMDAwMDA2MEZGRkZGRkZGLCAvLyBSYW5nZSBNYXhpbXVtDQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgIDB4MDAwMDAwMDAwMDAwMDAwMCwgLy8gVHJhbnNsYXRpb24gT2Zmc2V0DQo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgIDB4MDAwMDAwMDAxMDAwMDAwMCwgLy8gTGVuZ3RoDQo+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgICwsICwgQWRkcmVzc1JhbmdlTWVtb3J5LCBUeXBl
U3RhdGljKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgIFFXb3JkTWVtb3J5IChSZXNvdXJjZUNv
bnN1bWVyLCBQb3NEZWNvZGUsDQo+ID4gTWluRml4ZWQsIE1heEZpeGVkLCBDYWNoZWFibGUsIFJl
YWRXcml0ZSwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgMHgwMDAwMDAwMDAwMDAwMDAw
LCAvLyBHcmFudWxhcml0eQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAweDAwMDAwMDcw
MDAwMDAwMDAsIC8vIFJhbmdlIE1pbmltdW0NCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
MHgwMDAwMDNGRkZGRkZGRkZGLCAvLyBSYW5nZSBNYXhpbXVtDQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgIDB4MDAwMDAwMDAwMDAwMDAwMCwgLy8gVHJhbnNsYXRpb24gT2Zmc2V0DQo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgIDB4MDAwMDAzOTAwMDAwMDAwMCwgLy8gTGVuZ3RoDQo+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgICwsICwgQWRkcmVzc1JhbmdlTWVtb3J5LCBUeXBl
U3RhdGljKQ0KPiA+ICAgICAgICAgICAgICAgICAgfSkNCj4gPg0KPiA+IEJ1dCB0aGUgU3lzdGVt
IFJBTSByYW5nZXMgYXJlOg0KPiA+IGNhdCAvcHJvYy9pb21lbSB8Z3JlcCAtaSByYW0NCj4gPiA5
MDAwMDAwMC05MWZmZmZmZiA6IFN5c3RlbSBSQU0NCj4gPiA5MjkwMDAwMC1mZmZiZmZmZiA6IFN5
c3RlbSBSQU0NCj4gPiA4ODAwMDAwMDAtZmZmZmZmZmZmIDogU3lzdGVtIFJBTQ0KPiA+IDg4MDAw
MDAwMDAtYmZmNTk5MGZmZiA6IFN5c3RlbSBSQU0NCj4gPiBiZmY1OWQwMDAwLWJmZjVhNGZmZmYg
OiBTeXN0ZW0gUkFNDQo+ID4gYmZmODAwMDAwMC1iZmZmZmZmZmZmIDogU3lzdGVtIFJBTQ0KPiA+
IFNvIHNvbWUgUkFNIHJhbmdlcyBhcmUgb3V0IG9mIGRtYV9yYW5nZV9tYXAuDQo+ID4NCj4gPiBG
aXhlcyBpdCBieSBjaGVja2luZyB3aGV0aGVyIGVhY2ggb2YgdGhlIHN5c3RlbSBSQU0gcmVzb3Vy
Y2VzIGNhbiBiZQ0KPiA+IHByb3Blcmx5IGVuY29tcGFzc2VkIHdpdGhpbiB0aGUgZG1hX3Jhbmdl
X21hcC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEppYSBIZSA8anVzdGluLmhlQGFybS5jb20+
DQo+ID4gLS0tDQo+ID4gICBpbmNsdWRlL2xpbnV4L2RtYS1tYXBwaW5nLmggfCAgOCArKysrKy0t
DQo+ID4gICBrZXJuZWwvZG1hL21hcHBpbmcuYyAgICAgICAgfCA0NQ0KPiArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDUxIGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9s
aW51eC9kbWEtbWFwcGluZy5oIGIvaW5jbHVkZS9saW51eC9kbWEtbWFwcGluZy5oDQo+ID4gaW5k
ZXggZjBjY2NhMTZhMGFjLi5kOWQxYzY3Yzg1NzkgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9s
aW51eC9kbWEtbWFwcGluZy5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9kbWEtbWFwcGluZy5o
DQo+ID4gQEAgLTE0NCw2ICsxNDQsNyBAQCBib29sIGRtYV9wY2lfcDJwZG1hX3N1cHBvcnRlZChz
dHJ1Y3QgZGV2aWNlDQo+ICpkZXYpOw0KPiA+ICAgaW50IGRtYV9zZXRfbWFzayhzdHJ1Y3QgZGV2
aWNlICpkZXYsIHU2NCBtYXNrKTsNCj4gPiAgIGludCBkbWFfc2V0X2NvaGVyZW50X21hc2soc3Ry
dWN0IGRldmljZSAqZGV2LCB1NjQgbWFzayk7DQo+ID4gICB1NjQgZG1hX2dldF9yZXF1aXJlZF9t
YXNrKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ID4gK2Jvb2wgYWxsX3JhbV9pbl9kbWFfcmFuZ2Vf
bWFwKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ID4gICBzaXplX3QgZG1hX21heF9tYXBwaW5nX3Np
emUoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gPiAgIHNpemVfdCBkbWFfb3B0X21hcHBpbmdfc2l6
ZShzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiA+ICAgYm9vbCBkbWFfbmVlZF9zeW5jKHN0cnVjdCBk
ZXZpY2UgKmRldiwgZG1hX2FkZHJfdCBkbWFfYWRkcik7IEBADQo+ID4gLTQ3NSw4ICs0NzYsMTEg
QEAgc3RhdGljIGlubGluZSBpbnQgZG1hX2NvZXJjZV9tYXNrX2FuZF9jb2hlcmVudChzdHJ1Y3QN
Cj4gZGV2aWNlICpkZXYsIHU2NCBtYXNrKQ0KPiA+ICAgICovDQo+ID4gICBzdGF0aWMgaW5saW5l
IGJvb2wgZG1hX2FkZHJlc3NpbmdfbGltaXRlZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gICB7
DQo+ID4gLQlyZXR1cm4gbWluX25vdF96ZXJvKGRtYV9nZXRfbWFzayhkZXYpLCBkZXYtPmJ1c19k
bWFfbGltaXQpIDwNCj4gPiAtCQkJICAgIGRtYV9nZXRfcmVxdWlyZWRfbWFzayhkZXYpOw0KPiA+
ICsJaWYgKG1pbl9ub3RfemVybyhkbWFfZ2V0X21hc2soZGV2KSwgZGV2LT5idXNfZG1hX2xpbWl0
KSA8DQo+ID4gKwkJCQkJCWRtYV9nZXRfcmVxdWlyZWRfbWFzayhkZXYpKQ0KPiANCj4gTml0OiBp
bmRlbnRhdGlvbg0KPiANCj4gPiArCQlyZXR1cm4gdHJ1ZTsNCj4gPiArDQo+ID4gKwlyZXR1cm4g
IWFsbF9yYW1faW5fZG1hX3JhbmdlX21hcChkZXYpOw0KPiA+ICAgfQ0KPiA+DQo+ID4gICBzdGF0
aWMgaW5saW5lIHVuc2lnbmVkIGludCBkbWFfZ2V0X21heF9zZWdfc2l6ZShzdHJ1Y3QgZGV2aWNl
ICpkZXYpDQo+ID4gZGlmZiAtLWdpdCBhL2tlcm5lbC9kbWEvbWFwcGluZy5jIGIva2VybmVsL2Rt
YS9tYXBwaW5nLmMgaW5kZXgNCj4gPiBlMzIzY2E0OGY3ZjIuLmFiNDA3ZGViODFiOCAxMDA2NDQN
Cj4gPiAtLS0gYS9rZXJuZWwvZG1hL21hcHBpbmcuYw0KPiA+ICsrKyBiL2tlcm5lbC9kbWEvbWFw
cGluZy5jDQo+ID4gQEAgLTE0LDYgKzE0LDcgQEANCj4gPiAgICNpbmNsdWRlIDxsaW51eC9vZl9k
ZXZpY2UuaD4NCj4gPiAgICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQo+ID4gICAjaW5jbHVkZSA8
bGludXgvdm1hbGxvYy5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvZG1hLWRpcmVjdC5oPg0KPiAN
Cj4gTml0OiBwbGVhc2Uga2VlcCB0aGUgaW5jbHVkZXMgc29ydGVkIGFscGhhYmV0aWNhbGx5LCBo
b3dldmVyIEkgZG8gd29uZGVyDQo+IHdoZXRoZXIgdGhpcyB3aG9sZSB0aGluZyBzaG91bGRuJ3Qg
YmVsb25nIGluIGRtYS1kaXJlY3QgYW55d2F5Lg0KVGhlIGRtYS1kaXJlY3QuaCBpcyBmb3IgaW5j
bHVkaW5nIHN0cnVjdCBidXNfZG1hX3JlZ2lvbiBvbmx5Lg0KTWF5YmUgSSBuZWVkIHRvIG1vdmUg
c3RydWN0IGJ1c19kbWFfcmVnaW9uIHRvIGEgcHJvcGVyIGhlYWRlciBmaWxlPw0KDQo+IA0KPiA+
ICAgI2luY2x1ZGUgImRlYnVnLmgiDQo+ID4gICAjaW5jbHVkZSAiZGlyZWN0LmgiDQo+ID4NCj4g
PiBAQCAtODE5LDYgKzgyMCw1MCBAQCBzaXplX3QgZG1hX29wdF9tYXBwaW5nX3NpemUoc3RydWN0
IGRldmljZSAqZGV2KQ0KPiA+ICAgfQ0KPiA+ICAgRVhQT1JUX1NZTUJPTF9HUEwoZG1hX29wdF9t
YXBwaW5nX3NpemUpOw0KPiA+DQo+ID4gKy8qDQo+ID4gKyAqIFRvIGNoZWNrIHdoZXRoZXIgYWxs
IHJhbSByZXNvdXJjZSByYW5nZXMgYXJlIG1hcHBlZCBpbiBkbWEgcmFuZ2UNCj4gPiArbWFwDQo+
ID4gKyAqIFJldHVybnMgMCB3aGVuIGNvbnRpbnVvdXMgY2hlY2sgaXMgbmVlZGVkDQo+ID4gKyAq
IFJldHVybnMgMSBpZiB0aGVyZSBpcyBzb21lIHJhbSByYW5nZSBjYW4ndCBiZSBtYXBwZWQgdG8N
Cj4gPiArZG1hX3JhbmdlX21hcCAgKi8gc3RhdGljIGludCBjaGVja19yYW1faW5fcmFuZ2VfbWFw
KHVuc2lnbmVkIGxvbmcNCj4gPiArc3RhcnRfcGZuLA0KPiA+ICsJCQkJICB1bnNpZ25lZCBsb25n
IG5yX3BhZ2VzLCB2b2lkICpkYXRhKSB7DQo+ID4gKwlwaHlzX2FkZHJfdCBlbmRfcGFkZHIgPSAo
c3RhcnRfcGZuICsgbnJfcGFnZXMpIDw8IFBBR0VfU0hJRlQ7DQo+IA0KPiBUaGlzIGNvdWxkIHN0
aWxsIHdyYXAgdG8gMCBvbiAzMi1iaXQuIEkgdGhpbmsgdGhlIHJvYnVzdCB0aGluZyB0byBkbyBp
cyBlaXRoZXIgc3ByYXkNCj4gc29tZSBleHRyYSAtMXMgYW5kICsxcyBhcm91bmQgdG8gbWFrZSBh
bGwgdGhlICJlbmQiIHZhbHVlcyBpbmNsdXNpdmUgbGltaXRzLCBvcg0KPiBtYXliZSBqdXN0IGRv
IGV2ZXJ5dGhpbmcgaW4gdW5pdHMgb2YgcGFnZXMgcmF0aGVyIHRoYW4gYnl0ZXMgKGkuZS4gdXNl
DQo+IFBGTl9ET1dOKCkgb24gdGhlIGJ1c19kbWFfcmVnaW9uIGVudHJ5IHZhbHVlcykuDQo+IA0K
T2ssIGxldCBtZSB0cnkgdGhlIGxhdHRlciBvbmUsIHdoaWNoIGxvb2tzIGVhc2llciB0byBtZS4N
Cg0KPiA+ICsJcGh5c19hZGRyX3Qgc3RhcnRfcGFkZHIgPSBzdGFydF9wZm4gPDwgUEFHRV9TSElG
VDsNCj4gPiArCXN0cnVjdCBkZXZpY2UgKmRldiA9IChzdHJ1Y3QgZGV2aWNlICopZGF0YTsNCj4g
PiArCXN0cnVjdCBidXNfZG1hX3JlZ2lvbiAqcmVnaW9uID0gTlVMTDsNCj4gPiArCWNvbnN0IHN0
cnVjdCBidXNfZG1hX3JlZ2lvbiAqbTsNCj4gPiArDQo+ID4gKwl3aGlsZSAoc3RhcnRfcGFkZHIg
PCBlbmRfcGFkZHIpIHsNCj4gPiArCQkvLyBmaW5kIHJlZ2lvbiBjb250YWluaW5nIHN0YXJ0X3Bh
ZGRyDQo+IA0KPiBOaXQ6IGluY29uc2lzdGVudCBjb21tZW50IHN0eWxlIChhbHRob3VnaCBpdCdz
IG5vdCBhIHBhcnRpY3VsYXJseSB2YWx1YWJsZQ0KPiBjb21tZW50IGFueXdheSwgSU1PIHRoZSBs
b29wIGl0c2VsZiBpcyBjbGVhciBlbm91Z2gpLg0KPiANClN1cmUsIGxldCBtZSByZW1vdmUgaXQu
DQoNCg0KLS0NCkNoZWVycywNCkp1c3RpbiAoSmlhIEhlKQ0KDQoNCg==
