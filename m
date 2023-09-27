Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9237B0A55
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjI0Qd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjI0QdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:33:24 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1FD9C;
        Wed, 27 Sep 2023 09:33:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kuWI9NtsmbxqFHgeVukhslNPhb3sLH/ohnIpvt/efjDGRMZbHhLoBjj/BVd5ExfWYRKp3fF92vW+BNd/Z4OcHKT5GGdLFxAAOR7yYBhPIfzYdLhG69p+n43cLDYF4vEk/055F5sdgqETgXXK9NYNYoS0+XkU63Kye7pYjgJqishya4wqe0+boYGhn7va7q6k6wRaffJm+6hN1XjJ88Mf0LvAVgVQ8QUGhfztKhB7X1c7oAjndbW3wHKbtr9ATz+uKnKd0LIc3ZREn8EX0jist5EgCicnVb8+IjUmyzc9mEdesm9IN0KbcEtMn7Zc6m0VxEERqoaSKOiz2zzFLCoSQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0O3aoUMpC3fOxfGnIjg/XtUawwJH9IjE/KCIA9Tmdgg=;
 b=ZG1ubZJFRoPUe/V8vlAxqw/q7ael5l6pv7R14nlULQOKefYu7VerZPScmcyZpPdykx5C74hlv0OTJBU8516WtWUjQFW5wTZiXVbk7lHto6Lv+k7dbXg+xtG6CBb9cJdgjYYOiqZ82fopsanf3vCRaTBww7mle9cQ/b1YDJIRVrWxegWav0gNCJxPoq1EcsI7i7r9loFmQVOfKOXbdZqo7eI5vz8kwmGl9nJTESWvgYd4UEdGC3L3tJhiV3ryTyd6kQAFzAUlYfMIEZXuKAsb35JTKyB51Qo/hZ5AOesYSkw+/spufFcxFoTP8PLrueutIYYXdY79VuTsO78lmx+ohw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0O3aoUMpC3fOxfGnIjg/XtUawwJH9IjE/KCIA9Tmdgg=;
 b=nGkrL/uhTnrsW2nz3j123konoOG2XbE4TeLvZEY00xuttHAZGoy/GYrB4vpyAA81V6DVAD0XjTqRM1yrPqLLFe2hAcNJ56DsKOu1Cbm71vGzo0m8JoIZdi/HqPiRBKolvVUVq6N/Ymb53K31pg6pZ/y7fj+O6KvPuJZ0PMQxXuY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by CO1PR11MB5041.namprd11.prod.outlook.com (2603:10b6:303:90::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 16:33:17 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::d6c8:4cb6:2594:d8f3]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::d6c8:4cb6:2594:d8f3%4]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 16:33:16 +0000
From:   =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH v2 0/9] wfx: implement Remain On Channel
Date:   Wed, 27 Sep 2023 18:32:48 +0200
Message-Id: <20230927163257.568496-1-jerome.pouiller@silabs.com>
X-Mailer: git-send-email 2.39.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: DS7PR06CA0052.namprd06.prod.outlook.com
 (2603:10b6:8:54::30) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|CO1PR11MB5041:EE_
X-MS-Office365-Filtering-Correlation-Id: 28ff285d-47b7-4092-cfcd-08dbbf7773a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nesa2XcywEmG0IbEbtIdOn1gHvotVo29+ec/jXvUQPnCdmbcEn47qQTHtocRQzEHawyv2bXKIQOdAitD56RSfx+rxGndtiU5WlfSM8qUNcz1SVXf4EokFMWRcvve25ijEv9Fue1uDL4+Vpt5h04kQD5RQuqfRNvuFJdA3qXK1nlAbCehNpW+LWzcDE+Ib+UHOuWZ7LNngIktgfvVj5Ulsoroj2NUAH1lk8VxBwCCVPbjHCyHACufDp6yS/K5it2splQYWOaBLQQ18BIGeDxKrDAUc80+2DVXv60maN72bWKr5dH7pfhDiyAAgW1ulZTXkwJhhEDxJUtXU3AyVFKJtKCqX0JO2bL8NSv8Xg/vqWzafFqqbatxMklwZT2fhy3PVnevZcpDfcBfeYb2iH7DGaPu/NZQRGDJKTRzp7ATPQM2prerLqMvnLv4LEzCECNdOU5l/8xG43y8Gdi0sTFg4L2NzkFT6QIvui49OrctQBW82Dry2w8l1i5oBrCLDD+UknQxqwVAO2IY5F43MPwVn0X/Fknv2cpfLlX5nzFeuzmYefTQjxH49LIVCw1X6uD6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39850400004)(396003)(366004)(230922051799003)(1800799009)(186009)(451199024)(6506007)(107886003)(66574015)(66556008)(66476007)(6666004)(1076003)(86362001)(6486002)(52116002)(6512007)(478600001)(38100700002)(2906002)(83380400001)(5660300002)(316002)(6916009)(36756003)(8936002)(8676002)(2616005)(66946007)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UE9GZ1Z6WjQ0WmxZVG5zOXh0eE5ydTZvekpBNlRwMkVQejlka0FOSXRVTVFT?=
 =?utf-8?B?OVVFcENtcE1BYzhjVytTNCtVelpFTUhDMlNENkdESk0xSjl2WHl2TEM4TU9w?=
 =?utf-8?B?b1QxanczYVlXSGxaSkdvV2V4aHRHRWVCZGREMjI0UFNldDNTZUNZek1xeHNn?=
 =?utf-8?B?alczSVo1N2lnRTJycmZsOUtlWXA3akZPN2VDK0piZDBCdjRNV3pZbU9HTjlJ?=
 =?utf-8?B?bHJVN01makh4WlZJbHlrL2UxdHlUdmNXRkw5TlpBaFRsVFNUTEQ1cExqY3Fi?=
 =?utf-8?B?UExGUTZtMU9pSm9YNVBxd0xkS2Y5ekI3RW5DblBNZDNqV1YyTVJDQjRvdHFi?=
 =?utf-8?B?a05CelVjK0dLZ2xqdjJ6UlBiVkhVMWxzSHJvU1lmMlNTS2ZMQmU3cXpKa3VK?=
 =?utf-8?B?N3JwVXI0NTc0Vko3UWlyL1UrajJyWThYZ3BXTTRMYVJQbXl4cXJnU0FXSi84?=
 =?utf-8?B?VWQ4WEpaTkw0WDRkYno2NmM5ZFhTcEt4Q0JhZXZWRGgrUU1kVUFHRG5XL3BT?=
 =?utf-8?B?Vm9QZGM3cWF2SWxuK3huQTFWbEJjU0RhR1RNTFBGdjZUa2Nzb1IyN1JsUnJk?=
 =?utf-8?B?dXFzMFNWT1liY1JJMG85cGVPTk0yK3pLejFwRFRieVRxTVoreTYzcDUrT2d1?=
 =?utf-8?B?bi9lM1FubVB3NVRFaTdKYzR5TStDeFNZNThKTy9GVzBVNVdvajQxSW94city?=
 =?utf-8?B?WVFIOFo2S1ZNeGVaYmNTNVRJZnJINGg5bHBtMlhTN0NWcFBVN1pZVGRTZytL?=
 =?utf-8?B?UXI0UnJPNHZaK0s4OGdPTHg4SFpCS2tCamQxVk9iNWZDaVZMTGIwekVUMTNT?=
 =?utf-8?B?c1J3UTZsR09abi9oVGhvbndYOERXZFpGVmV2aUxOV3pNcUdRdGtRamdBL3R6?=
 =?utf-8?B?K0xzUnBRQVh5VThlN1ErTGVIVEJtNXNuMVplMmt3WGJOZUFyNS8vcXM1SlBF?=
 =?utf-8?B?cGZiZ29HUGczdk52MnVVd2pES09XNTFqOFlxSklodGNEZGJERWJHcG9ReFNl?=
 =?utf-8?B?Z2hzZzJJenJjUnBnTHRUR3haWW5HYnRKUDI1SmFielgrRDJadExDLzE3V3JY?=
 =?utf-8?B?dm12cndpeVk2bTZ4aEw3K0FGSUcwcEIxMnhPVkNGZ2d0SmZ4VkUwTUR3QUd1?=
 =?utf-8?B?eC9ySGxERUp1UTNkNnlHWHQ3OEpPT1NkSGRyL2lCV0tlcldNVHBIQk1oQ2JK?=
 =?utf-8?B?NnQ4R01YdDJlTGgzMWxtSk5XVTgzSEhoUkVFZWdORWF0TnFaMzIrelBvb3cx?=
 =?utf-8?B?bEdEYzZXYmZtK1VhNDlBbU92WmZ5YTNtWThCVHpROGkveFF2TFFCaUFZVUtM?=
 =?utf-8?B?OWJLQmIrSFFEcWkxbktHSkY1WFJzQm1ZWDJXRGRRemZ5Q0QvbUtxWVI2TDRU?=
 =?utf-8?B?dE9UbTBnL1lRQTVONXErbTFRWFRWRGNId28vNmlQYVpXbTZCVmxtMEkvRlAx?=
 =?utf-8?B?ZTNKOXhoNDlqY2EwTmpKSWhScXBILzA5bUdJL3NXS0JVaCtmVS9Bbm9CcTZu?=
 =?utf-8?B?a0cxZjI2MUxPTmF3YWdWZFBSQWluUkNvaVpWU0UyL1VMYWREOTBsTFBHKzNn?=
 =?utf-8?B?Wk83T0ZrbFlNTm51aFhodzVrWHZYM1JjWGNPUlMweW9oTWRLaHpFWlVZbUtl?=
 =?utf-8?B?OXpCTVA2SWFYQzdKWkhzejdjakJ5YkVFVzhHeis1ZzJZc2JZVHV0b25abFht?=
 =?utf-8?B?NjQyWmNUVDF2NXpXMFBmYjg3Ylg4NDZ2TWdyTksycVl0bWFZWUQyNmNuaGtX?=
 =?utf-8?B?OFhVOXVhRTFsdEVCTHU2MnBWRzVQdHY2TEg5N1gyZU1CZFJqZEhOZmxuZk45?=
 =?utf-8?B?RktqUFRVYkRUYzYvSkE3aDFmZzYvZ2hoMnhHZ3Nsbkhkc3FEQjZDMHpZdFRo?=
 =?utf-8?B?NFphNFpualRRVy9maHlaMG9WbzF1OXBnYWNXYlcwMTgvVUFQQzQ0a21NVldx?=
 =?utf-8?B?VEFUVERqWHVFc0FBUTNoRnBWbUx0VzhNbHUzcVZiRE1kdmhoMzFjWk5Wc0VQ?=
 =?utf-8?B?K01LdGtkaVFnZXYydTNSVk9qMTlab3UxQXZoNlBYT3V5Q3NNei9IT2JOUjBO?=
 =?utf-8?B?RE9wZnlwNXZoc3ZwZWs4bXlNeVBFeXFsTXBxaEVldHVwUlJLY1hsL0JGckp2?=
 =?utf-8?B?U2doQlczQ0JZcmJDWVZZdWJOM0FYang5bUdwRHlreDdpenBySmtTQ1BaeUtS?=
 =?utf-8?Q?TMYd0o2wESfajOFHqrgVO8nDIu9Ts/9jYS9whOw1CHMG?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ff285d-47b7-4092-cfcd-08dbbf7773a6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 16:33:16.7880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ofdI3Tshx5pYf7N7sqG1s8zjB9Fj+RYZPuWmerlg7VARIJL1pBL7b5hvezq37PaTfPZTJAPm81JLJus1s3ZWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5041
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sCgpBcGFydCBmcm9tIHRoZSAzIGZpcnN0IHBhdGNoLCB0aGlzIHNlcmllcyBpbXBsZW1l
bnRzIFJlbWFpbiBPbiBDaGFubmVsIGZvcgpXRjIwMCBjaGlwcy4gVGhlIGltcGxlbWVudGF0aW9u
IGlzIGEgYml0IHR3aXN0ZWQgKEkgaGlqYWNrIHRoZSBzY2FuIGZlYXR1cmUKdG8gaW1wbGVtZW50
cyBSb0MpLiBIb3dldmVyLCBpdCBoYXMgYmVlbiBleHRlbnNpdmVseSB0ZXN0ZWQgd2l0aApEUFAv
RWFzeUNvbm5lY3QgYW5kIEkgaGF2ZSBub3Qgbm90aWNlZCBhbnkgaXNzdWUuCgp2MjoKICAtIFJl
YmFzZSBvbiBsYXN0IHN0YWJsZSB0cmVlCgoKSsOpcsO0bWUgUG91aWxsZXIgKDkpOgogIHdpZmk6
IHdmeDogZml4IHBvd2VyX3NhdmUgc2V0dGluZyB3aGVuIEFQIGlzIHN0b3BwZWQKICB3aWZpOiB3
Zng6IHJlbG9jYXRlIHdmeF9yYXRlX21hc2tfdG9faHcoKQogIHdpZmk6IHdmeDogbW92ZSB3Znhf
c2tiXyooKSBvdXQgb2YgdGhlIGhlYWRlciBmaWxlCiAgd2lmaTogd2Z4OiBpbnRyb2R1Y2UgaGlm
X3NjYW5fdW5pcSgpCiAgd2lmaTogd2Z4OiBhZGQgcGxhY2Vob2xkZXJzIGZvciByZW1haW5fb25f
Y2hhbm5lbCBmZWF0dXJlCiAgd2lmaTogd2Z4OiBpbXBsZW1lbnQgd2Z4X3JlbWFpbl9vbl9jaGFu
bmVsKCkKICB3aWZpOiB3Zng6IGFsbG93IHRvIHNlbmQgZnJhbWVzIGR1cmluZyBST0MKICB3aWZp
OiB3Zng6IHNjYW5fbG9jayBpcyBnbG9iYWwgdG8gdGhlIGRldmljZQogIHdpZmk6IHdmeDogZml4
IHBvc3NpYmxlIGxvY2stdXAgYmV0d2VlbiBzY2FuIGFuZCBSeCBmaWx0ZXJzCgogZHJpdmVycy9u
ZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9kYXRhX3R4LmMgfCA1NCArKysrKysrKysrKysrKysrLS0t
CiBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2RhdGFfdHguaCB8IDIxICsrLS0tLS0t
CiBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2hpZl90eC5jICB8IDQzICsrKysrKysr
KysrKysrKwogZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9oaWZfdHguaCAgfCAgMSAr
CiBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L21haW4uYyAgICB8ICA1ICsrCiBkcml2
ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3F1ZXVlLmMgICB8IDM4ICsrKysrKysrKystLS0K
IGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvcXVldWUuaCAgIHwgIDEgKwogZHJpdmVy
cy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9zY2FuLmMgICAgfCA2NiArKysrKysrKysrKysrKysr
KysrKysrLQogZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9zY2FuLmggICAgfCAgNiAr
KysKIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc3RhLmMgICAgIHwgNDEgKysrKyst
LS0tLS0tLS0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc3RhLmggICAgIHwgIDEg
LQogZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC93ZnguaCAgICAgfCAgOCArLS0KIDEy
IGZpbGVzIGNoYW5nZWQsIDIxOCBpbnNlcnRpb25zKCspLCA2NyBkZWxldGlvbnMoLSkKCi0tIAoy
LjM5LjIKCg==
