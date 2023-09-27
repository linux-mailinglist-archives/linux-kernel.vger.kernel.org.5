Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90507B0A63
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjI0Qdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbjI0Qdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:33:31 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCADE5;
        Wed, 27 Sep 2023 09:33:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEBnJZEVJnX2shs4eWB4KGe+cpi39/InfRmTbDsHTyRh9YHl/gy3Fi58+BEfnY+CX3Loqrj0qUBzgKDjuGwkiJSC5Qe9NX1m62BLlTHkxVrYVOGujBrpyjG6pozJW+jMZPBISxGX+voE95/E51PRM+szvYEhn6lKEfrucpmVi67cWw4jLkkmux+L0OSvu9EHPy+5mUhsRH6RLDgyUx4CnaU8cHU9miHPdKvIpXympTbWAUFaYlB8NlGmkdQis6lmnHj/oc303O6lJFXWg+yTnTK9SiiaFRIl9+69Ic/JWcGBG2aL8uoWnCkplqo6lFU8Bzsux+1Bripojh+HlHzvCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nFqrlsCNFUBc16Ioc8XPt2MHtqcMhvTI8S6mM1dcgY=;
 b=Lpcu9pnCexadUwrHWlRrUloHNv0EP43n3r3BrqCSHwCFv+rahGrZFbk0QAGB9ZyNhdlDX1vSrFf7eKJ/j39am16spUPUIJUZUM0kCg5L2KxadFG+JkwOAc8Jciu1PVBv4c8GLwAGzPjLAVLnsMC221oCwktOG2FMFj5954KxKPmsa/rSI+Ldy7aN6vyO800Syky2C6CAeev4IoPSYWrat/6Dxt2J8u4FHmAFZQs9H9buOG5J8l393xd5Fx1bWpbTux+Q3GiSjVMbq2qAa2X3Km4JRBhI8VlV7HL8b1VIu5rY4fN7dC3uXtaVZex2/wiYTSr0qHcR2nFqEk167oaK3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nFqrlsCNFUBc16Ioc8XPt2MHtqcMhvTI8S6mM1dcgY=;
 b=i1q0Me3l7H0/z+yUJXEgYv0r83r4x/rEegrBr8lJuqXBSWne+yyHz02kxYYqw83lKpb8vMn1dg+LDqHRmTF+t/kaChSc68pxFAAjrXnysHTnGJRx/bxaHCm1ISKpcT2PeTkttwr3eGwFC3xB8mGwh9KRqTZFLcJrc/bFGfihE5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by CO1PR11MB5041.namprd11.prod.outlook.com (2603:10b6:303:90::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 16:33:23 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::d6c8:4cb6:2594:d8f3]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::d6c8:4cb6:2594:d8f3%4]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 16:33:23 +0000
From:   =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH v2 4/9] wifi: wfx: introduce hif_scan_uniq()
Date:   Wed, 27 Sep 2023 18:32:52 +0200
Message-Id: <20230927163257.568496-5-jerome.pouiller@silabs.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230927163257.568496-1-jerome.pouiller@silabs.com>
References: <20230927163257.568496-1-jerome.pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: DS7PR06CA0052.namprd06.prod.outlook.com
 (2603:10b6:8:54::30) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|CO1PR11MB5041:EE_
X-MS-Office365-Filtering-Correlation-Id: 6756ae1d-7477-4d58-4c4a-08dbbf7776f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3+vvr1FaiJkvWRr5TfHBXSZg4rL+Arb+pvJt/CSzX2Hawv4XENUjQn+MmJ4pssNex3SNk1em8kUeirObn/DPyXi1IDhqGEznUYtjQ3bcMQ+fGvR6MsSShgibirc4cGpLH+y7FvWu6qTumnChu915mI5n4djAN7JMIYYWEd5L8M1XnmNpciHGdr3OJgjxmSKWChpdM5ICfvy3jvQi61Nwe0kaAB5wW0F9d29GGC/ruJJUqtsdnxR3X4/BL4TBCPpENnfOYGJ1lM90tVeGMgBkvZwf30zbEvEKhXjzQwXKMRz5NVhW8TtfkDY/25Xy4LWZ3tapJFHtUF2LtHUvSMF/AkNRZ79qPh32WxNPs1SHPN66B853rIYQYT2BBUiu8gzuFXl04pdIN8pF2C+reRKxCbQyeQegzGrVbvHpYkm//f9WK2E1y3sGr2mOXmpHQtzjWt54huBgurE8bi2Zq5A4wPYMyikeQvVamDmpy9/jYOZb3aTVu2cKViPaRVbd5X8gDOijGWNSx6kgmkc5be+/p41HCKy8NtlT/u0bXxuZLSCWeYV+xksGK6WBMzYzSxUl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39850400004)(396003)(366004)(230922051799003)(1800799009)(186009)(451199024)(6506007)(107886003)(66574015)(66556008)(66476007)(6666004)(1076003)(86362001)(6486002)(52116002)(6512007)(478600001)(38100700002)(2906002)(83380400001)(5660300002)(316002)(6916009)(36756003)(8936002)(8676002)(2616005)(66946007)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHNUd3dIMnBCUW93Z1pWZGE1RzRSdnFBazVsK2VZd3dIVEhsSHg3bGU5STJk?=
 =?utf-8?B?WlcxRlUwRjEvNXJ2dVltWUNCRnEvMjQvSGFoR0ZDTHV5elhnT3VKc2s1RjYw?=
 =?utf-8?B?MXZkQi9sWVZRZlNwRDlFUFZlWURLdlRnWk9HVUk4MmtuTCt0THRQWFFDbnFJ?=
 =?utf-8?B?c3MwVGdpV3JZanNmaEwvV1Z0ZHAyMUZ3RC85UkJwUnVyR3UzZkV0YmRVUW1Y?=
 =?utf-8?B?SUt6QjFac09mc0U1bmtlaWRrWFdvUmw0SElUTk9VVmZPN3VRUXFmeGUxRGNk?=
 =?utf-8?B?Qi9zaWEvck1lSTFwMjhTOVJDOHRCWkVmTGRFdXNVdVJPMUhtYW5xWVpLMzlU?=
 =?utf-8?B?YkFUNlRRRFpoQnRQbFBPZDJJd3VRYWgreDNWTk1NWWMrVkpGSFBiZUpRYnZj?=
 =?utf-8?B?TTMyaUozMExmaE02V21HRmNBSDloN2tjZ0o5aGtiak5LcVkyMVNnb1hYRUhs?=
 =?utf-8?B?Slo0Nmk2L0M5RWt1MDVEcEc3SWwrTjFNT1lSUkVINGVLcmxKNU9SOUxVNDV3?=
 =?utf-8?B?U28rTFNqVGFONHN6L1VBR0xqUkFueklKWVRLRWNqUFkzTW5EZ2ZmaUtRd3Vp?=
 =?utf-8?B?T2dKbnExRUtIQjE3dnV5eEF2UHIrN0FnbzZvVXdDTmN0N1UrdkM3VFhFdHY5?=
 =?utf-8?B?NVZrVkF1V3l4LzhkNG1oak5OSnhubldKTnJCbUtWWFRWVjUzY040aUd3SWNN?=
 =?utf-8?B?aHNYOTdDUzU5MjBsQkFmeDl0TkxTVlJYeDJNSVpYSkdxWk1MU2JSc29oTEMr?=
 =?utf-8?B?Nnc1blZmM1pMU1UvR3liekttM2lyaTJBVEdlNXU4bC9JbVZPZUpmaEovend0?=
 =?utf-8?B?WC9qZGJhWFp5Y0xhMTFXZWZpMTA2YUdBUkxocHRVWm5jQXpTTDZuY2lIU0pW?=
 =?utf-8?B?cHNEaVlHWU1PNk96dXl3YzVhWG4vRjVMZCtraGZ5dCtLV29aTDdJeG1ZSzRu?=
 =?utf-8?B?eFpIdHpnSWJrekZ0T0NuN1Iwa0laSDUzMW9HVWhBVklMcHVPcVRmUGo5dXcw?=
 =?utf-8?B?bmoxWjI5L0IxYmlMUUZBeDVLN0svRFVVeWtsdEo0eTFDRE1ucUNsUSsxc3Ja?=
 =?utf-8?B?bE9sSlpEWG1PTHNqcTAyaGduRjA4QTdLRWgva2wxeUhWN3JtQisrSThlRnJt?=
 =?utf-8?B?MEVzRGFVMEVMK1VyaU03T2c3U2UrQ3NRZG92MTFYRFBYa042eVd0YXNCMVht?=
 =?utf-8?B?RHpHakVPMTRyNEp4aHAvZ0srMlFoTjYwU3dYNmlTemdteHVnVGN2Z2NHdC8v?=
 =?utf-8?B?Y0VUZ0RlV01lSVpMRmF1Y0JqRk81Y1pPc2lnVWlIUlVJWGN5TVcwcHBIYWlW?=
 =?utf-8?B?c3NWUnJndlVNSkVUdDB2VVQ0Mmw0NmxsQUZ1aVBXb0FMTk1paHNFZEFmUWsy?=
 =?utf-8?B?NXhzVTA4ZExBK0lhUEFtOGhxN0k1b1VCb1B4UGdTcFJBRCsxOWdJanREN2dm?=
 =?utf-8?B?dXpFNXcvZUJ0dXA1RWlkckFaQUQ4SWx4RVlzcURZc3Z1bzBFZXh6ZnRGbzJG?=
 =?utf-8?B?M1pTRWxadFp5ODIxcnB4bmVJNGZuMTB0VVFOdmFjUmhybXluc1k4K1JDS1ht?=
 =?utf-8?B?aGkwR0hNa3EzRG1ta1lFbEdUTnlsdTNHR25kSlQ1N1JudUdsWnh5K0Q4S2VY?=
 =?utf-8?B?Sk5wQnUrQldpNi9Kek02QWZZNk9IZjRyYjA2YlR4dksvM2tWQjluT3l3VTJ2?=
 =?utf-8?B?TGY5aXNTZnc5V2lXczRESld3L2NwQ3Q2RnBhL0k1QUpFR2JielJHalRHbHpE?=
 =?utf-8?B?emNhb2NPQ0RQYitqaFVHNUpUZGNySm44N0IwSTVsSm94Y3NjY01uczhvQXdo?=
 =?utf-8?B?N2NDRDA1ZTNSMnBnQkMwU0FiY1BKQWdlUW4zUTlEWndFOEdRSklLcTR6R0Nq?=
 =?utf-8?B?RytZL3lLRnA3Vjlta0VjYWdZWG4vTHRuUkdVQ0xRMTV1K3RmRW5URjdOdUlH?=
 =?utf-8?B?K2Y5SkgyUWhNa3BGeTBsS2FBRWxBYitHS0FSZVNKWHRLV0VTK3hEd09udWwx?=
 =?utf-8?B?d3JLNmRSTkxLTWJoN3F1dzcyRjE2M2FHcUxIdlN2RHIyWGlPMkFYMmhmRkVk?=
 =?utf-8?B?bEZXUituaDhyR0FJZzRQWld6MVhEZHNvRVFQbjVXb0lXME40aDd4akNaVWJy?=
 =?utf-8?B?WmxHUjVzTlJzWG8yL2RGbFVJcTFxN1Yva0FoendsZmJLcmpWb0ZURTNlTVVS?=
 =?utf-8?Q?4ItNQ9c4e6FPOVOHo5U/BtfkMF8zSUB6NVMBRKamS7iN?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6756ae1d-7477-4d58-4c4a-08dbbf7776f5
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 16:33:22.3110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+WnMR7LViNCRDNKtYWlEfaKqNl5xuOLiauXqNXrD7lWBfdrVxpBkIkTBSj0me8ChZKZpEV94RpMID0HdZJvDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5041
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TGlrZSBob2Zfc2NhbigpLCBoaWZfc2Nhbl91bmlxKCkgaW52b2tlIEhJRl9TQ0FOLiBIb3dldmVy
LCBpdCBvbmx5CmFsbG93cyB0byBwcm9iZSBvbmUgY2hhbm5lbCBhbmQgZGlzYWJsZSBwcm9iZSBy
ZXF1ZXN0cy4gSXQgd29ya3MgdmVyeQp3ZWxsIHRvIGltcGxlbWVudCBSZW1haW4tT24tQ2hhbm5l
bC4KClNpZ25lZC1vZmYtYnk6IErDqXLDtG1lIFBvdWlsbGVyIDxqZXJvbWUucG91aWxsZXJAc2ls
YWJzLmNvbT4KLS0tCiBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2hpZl90eC5jIHwg
MjUgKysrKysrKysrKysrKysrKysrKysrKysrCiBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMv
d2Z4L2hpZl90eC5oIHwgIDEgKwogMiBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9oaWZfdHguYyBiL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvaGlmX3R4LmMKaW5kZXggZGU1YTMxNDgyZGYz
OC4uOWY0MDNkMjc1Y2IxMyAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJz
L3dmeC9oaWZfdHguYworKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2hpZl90
eC5jCkBAIC0yMzgsNiArMjM4LDMxIEBAIGludCB3ZnhfaGlmX3dyaXRlX21pYihzdHJ1Y3Qgd2Z4
X2RldiAqd2RldiwgaW50IHZpZl9pZCwgdTE2IG1pYl9pZCwgdm9pZCAqdmFsLCBzCiAJcmV0dXJu
IHJldDsKIH0KIAorLyogSGlqYWNrIHNjYW4gcmVxdWVzdCB0byBpbXBsZW1lbnQgUmVtYWluLU9u
LUNoYW5uZWwgKi8KK2ludCB3ZnhfaGlmX3NjYW5fdW5pcShzdHJ1Y3Qgd2Z4X3ZpZiAqd3ZpZiwg
c3RydWN0IGllZWU4MDIxMV9jaGFubmVsICpjaGFuLCBpbnQgZHVyYXRpb24pCit7CisJaW50IHJl
dDsKKwlzdHJ1Y3Qgd2Z4X2hpZl9tc2cgKmhpZjsKKwlzaXplX3QgYnVmX2xlbiA9IHNpemVvZihz
dHJ1Y3Qgd2Z4X2hpZl9yZXFfc3RhcnRfc2Nhbl9hbHQpICsgc2l6ZW9mKHU4KTsKKwlzdHJ1Y3Qg
d2Z4X2hpZl9yZXFfc3RhcnRfc2Nhbl9hbHQgKmJvZHkgPSB3ZnhfYWxsb2NfaGlmKGJ1Zl9sZW4s
ICZoaWYpOworCisJaWYgKCFoaWYpCisJCXJldHVybiAtRU5PTUVNOworCWJvZHktPm51bV9vZl9z
c2lkcyA9IEhJRl9BUElfTUFYX05CX1NTSURTOworCWJvZHktPm1haW50YWluX2N1cnJlbnRfYnNz
ID0gMTsKKwlib2R5LT5kaXNhbGxvd19wcyA9IDE7CisJYm9keS0+dHhfcG93ZXJfbGV2ZWwgPSBj
cHVfdG9fbGUzMihjaGFuLT5tYXhfcG93ZXIpOworCWJvZHktPm51bV9vZl9jaGFubmVscyA9IDE7
CisJYm9keS0+Y2hhbm5lbF9saXN0WzBdID0gY2hhbi0+aHdfdmFsdWU7CisJYm9keS0+bWF4X3Ry
YW5zbWl0X3JhdGUgPSBBUElfUkFURV9JTkRFWF9CXzFNQlBTOworCWJvZHktPm1pbl9jaGFubmVs
X3RpbWUgPSBjcHVfdG9fbGUzMihkdXJhdGlvbik7CisJYm9keS0+bWF4X2NoYW5uZWxfdGltZSA9
IGNwdV90b19sZTMyKGR1cmF0aW9uICogMTEwIC8gMTAwKTsKKwl3ZnhfZmlsbF9oZWFkZXIoaGlm
LCB3dmlmLT5pZCwgSElGX1JFUV9JRF9TVEFSVF9TQ0FOLCBidWZfbGVuKTsKKwlyZXQgPSB3Znhf
Y21kX3NlbmQod3ZpZi0+d2RldiwgaGlmLCBOVUxMLCAwLCBmYWxzZSk7CisJa2ZyZWUoaGlmKTsK
KwlyZXR1cm4gcmV0OworfQorCiBpbnQgd2Z4X2hpZl9zY2FuKHN0cnVjdCB3ZnhfdmlmICp3dmlm
LCBzdHJ1Y3QgY2ZnODAyMTFfc2Nhbl9yZXF1ZXN0ICpyZXEsCiAJCSBpbnQgY2hhbl9zdGFydF9p
ZHgsIGludCBjaGFuX251bSkKIHsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3Np
bGFicy93ZngvaGlmX3R4LmggYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2hpZl90
eC5oCmluZGV4IDcxODE3YTY1NzFmMGIuLmFhYjU0ZGY2YWFmYTYgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvaGlmX3R4LmgKKysrIGIvZHJpdmVycy9uZXQvd2ly
ZWxlc3Mvc2lsYWJzL3dmeC9oaWZfdHguaApAQCAtNTQsNiArNTQsNyBAQCBpbnQgd2Z4X2hpZl9i
ZWFjb25fdHJhbnNtaXQoc3RydWN0IHdmeF92aWYgKnd2aWYsIGJvb2wgZW5hYmxlKTsKIGludCB3
ZnhfaGlmX3VwZGF0ZV9pZV9iZWFjb24oc3RydWN0IHdmeF92aWYgKnd2aWYsIGNvbnN0IHU4ICpp
ZXMsIHNpemVfdCBpZXNfbGVuKTsKIGludCB3ZnhfaGlmX3NjYW4oc3RydWN0IHdmeF92aWYgKnd2
aWYsIHN0cnVjdCBjZmc4MDIxMV9zY2FuX3JlcXVlc3QgKnJlcTgwMjExLAogCQkgaW50IGNoYW5f
c3RhcnQsIGludCBjaGFuX251bSk7CitpbnQgd2Z4X2hpZl9zY2FuX3VuaXEoc3RydWN0IHdmeF92
aWYgKnd2aWYsIHN0cnVjdCBpZWVlODAyMTFfY2hhbm5lbCAqY2hhbiwgaW50IGR1cmF0aW9uKTsK
IGludCB3ZnhfaGlmX3N0b3Bfc2NhbihzdHJ1Y3Qgd2Z4X3ZpZiAqd3ZpZik7CiBpbnQgd2Z4X2hp
Zl9jb25maWd1cmF0aW9uKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LCBjb25zdCB1OCAqY29uZiwgc2l6
ZV90IGxlbik7CiBpbnQgd2Z4X2hpZl9zaHV0ZG93bihzdHJ1Y3Qgd2Z4X2RldiAqd2Rldik7Ci0t
IAoyLjM5LjIKCg==
