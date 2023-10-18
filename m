Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA3A7CE53A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjJRRto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjJRRtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:49:42 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2047.outbound.protection.outlook.com [40.107.22.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C44BB8;
        Wed, 18 Oct 2023 10:49:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6zwpFw8USFyVf2Icbgo4rhx5AjnQ1yXxaZ98s/A7vuwSKi8inNiIKa8MXg8Mf6FXeOobM87KkPx/HZW3qAN3zOsjcrDEE+Dd14cx4v6zAw1bfL7uCUzBvykh5qBzaVtMgN87UBYxF1u7XaCGXQk8+jnNvVf+w8ajqYJWrf5CVXqZe0ZPt07FLeFF9hQFsTUTnKKSFrXLgUYb7nUGaa7dsXXPN5XzjZPFP73e+Wt/32m1WNQ0I1xTiJ3pRV1GM6uLfLQY67B2sjUrTAC3XIkTPGxJTHWx/V4x3YLPLLcbS0sppfJ3u21sMRaX3HDGxwgxBTe3U0wnOCUaeUrIuYfwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvIzARjqD75jzFUedT6hy86JYljIzAuniYal2n2L4JQ=;
 b=UoXSYvApaCFeS6fkXayFLughLPhDAOiCoVAK5C0pexMbGHIFejTzdlV6PTOG6/yNcQmxigNcLkYQ9LLkYpSxvfX3CaGSkGJn3rQxg9/4EmurocgMBzzj4z7SBxN+sEHnW8DVAFF6g1d7vDTV1aV9/76EGXhIlTquJX9mqXIagOHSqwC7pN1Np887tcJrryMjqIv03EjznUkqkzR9z1KzEeEv0MJU6wY+V/Etv1Z8VoyAcxNRC1w6ZfwqzqbIi+LosJ6qAinA/eowTjI/pb7AF6Tg6yYpL+0THlweNf91gJS0PNpFkHttb4/T91q9jn4cg9I7Nl2Nt9+9XXtHFSBp4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvIzARjqD75jzFUedT6hy86JYljIzAuniYal2n2L4JQ=;
 b=QjkcaxZttqQo1eG/nRYbAVfxOaXPUrMJpD9KsAtRV/AAvBOORgq7oSCjPKPQoueUs6V1SRD1wFrwvOngFKToUzkhOzZ4VXkx+pXhmsquId2nZnjWHpskkfrqAFpQUO4FDR+LrItIhXgD0zqqAQWO2apwOyUdmt7OF7p4EkOr3rc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by AS8P193MB1478.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:350::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 17:49:37 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::550d:2425:c0ed:3e59]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::550d:2425:c0ed:3e59%3]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 17:49:36 +0000
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com
Cc:     u.kleine-koenig@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH v4 0/7] Fixes and improvements for RS485
Date:   Wed, 18 Oct 2023 19:48:33 +0200
Message-Id: <20231018174840.28977-1-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: FR0P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::17) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|AS8P193MB1478:EE_
X-MS-Office365-Filtering-Correlation-Id: 47119b83-c4ab-40ae-c09b-08dbd0029832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zmwYKs+UuF+9VmuXENlmffMDvRQNZr1BysnKAJWuR+2RkE9kYkiQ78q2dFCVmf7TIWI7hXnQyDhZP1AqL608Y9cm4mUkhyn6CpbiewxSyczNJVqyI4bVRSblnBC9eL2xbq5M/Ty1KgLCZyPB/J4DJ/FYyURKis5tf6dsm+EvyC+8n8Ab8MuJjw9OL+jgiDj2EzBNPR5N7svf5yT+6VNszvdiJAMB+lASRGTiPpBVSBnSPVbgeAJF134MTwOuz/eH83ZDCbul+7E1/FWbpqJo6amFNbDUXmEU/LNSQVYKKjmTSOoMwc/QEdkp040BcOnzaOHfA8mBoSHXOjqJ2k0Zy9MRrO3jkWxvZfGPv2d4Gm4JoL5RuSOZGxpkkxj0l+ch8Gvv3MSmr4OHBa358Svk1ELv0YKFWve7azyeaVsx2z1FKR6hkA6KJgrWS63kmd85/BBXhmrbhriVWmGJ3XVtgARdewTOlsy02rW63sykgL0lKtOUurejc+O7o1IxP8e0aYIrV3a+HpHhp6ynt1GiizsEJnunpNHGBRhUNiAsvOUow8Yqjc77OxjfTzunapcX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39840400004)(376002)(346002)(366004)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(36756003)(66946007)(66556008)(66476007)(86362001)(38100700002)(1076003)(107886003)(2616005)(83380400001)(6666004)(6512007)(52116002)(6506007)(7416002)(6486002)(316002)(478600001)(5660300002)(4326008)(8676002)(41300700001)(2906002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUlkUkg5TDU3dVZ1Q09DTldRWTVKd3M2SGJqdzFNTUVMN3cxdkdWamJydHVY?=
 =?utf-8?B?SGcxcHVWYVhtN296REl3SC8yMUhsK0xZYktZNVJiRUdmOU1wc242bmoxeUJ4?=
 =?utf-8?B?RjZJVE0vQ3hRM0FHK25uWFF0Q21BaDMvZHBONEs5K2pqcjNUMjQ3MzdPOHFR?=
 =?utf-8?B?OG5kaDlyUldHVnp6QU5VMGpDTk94NXJwU1QyTlNHeHlTZ1B2MW1UMnEvaFJQ?=
 =?utf-8?B?bi9VMTJHZlMwQzlpWFdRbkFRbzRrRGtvRUdsSGd0MFM2dWJXRzZ6UkpKVWll?=
 =?utf-8?B?TGYrQ0lnRzBIRmxRTVBHVG9pQ0tsYVlidlJzTExPQmpyZGY5dHFnbFpIZzkx?=
 =?utf-8?B?dVRmNUozbzlRS2hKc01qM2NsTisvOTBTT2cvWGFYbHpHOUFLMWZlSlNIRXJU?=
 =?utf-8?B?bVc5YW9jbGE1REg5b1NEbEI0QUNCRXUzdnVlc1VYak80ZndPb25BZUZNOHFM?=
 =?utf-8?B?S1U5R2RaRTRmd01vVDRhUUt6NmZEaGRzRTRwdGgzL0lCci9Ja0J0TjBiaUFq?=
 =?utf-8?B?dFlJSnI2NDFDdW5nZkdzSVRMbjYyeGNZUG9HdDJ3MlNmK2VkcVU3djVjZEJX?=
 =?utf-8?B?d3FZcXVaTkZzeDV3YVhkS2EvZVFQblpYczZ1MSt6WGVEK2hxV20xamNGK3hh?=
 =?utf-8?B?TjBNSkpZOFlrYnZ0MFZFQ0R1U1N2YVNBQ2lNWCtJLzg0Z1Q0UU5Dait5Znoz?=
 =?utf-8?B?SWV3Nm1HKzlaTjFOTjMrcUtSUkZQU1NjbWgrL295cytlUW9mRjN1MWJjaXcx?=
 =?utf-8?B?SllPSTdBN3dQTHZ0WWpCSndjdCs4QnlzK1Y3aDJUR0Q2S2loc0tzbEJLOThD?=
 =?utf-8?B?ZWdOWE9ob2JJaHc4RkpjN2wyNERpVVlvMFdrdmM1WUswN3dibUFJRkptdGh5?=
 =?utf-8?B?ZHRHNll2TXU5bmFEVEpzK3ErQmJsRGlvQXV6ZjJ3ajJiaklwVEEwZmZraHMy?=
 =?utf-8?B?VFFzK3dDa2hPVzJEUEg4RVNBaWlPS0twN2tXN1hRanhzOUhvY0FWb1VESnl2?=
 =?utf-8?B?ajRsUDRWYXZVVGs2WiszOEFBMWYybUJlNXdURXZONm5rWk1sclI2VjM5T3ZZ?=
 =?utf-8?B?dERjTmovVHVWbTBBYTc0c25iY0U4UENOSDJQM3hiQjJQZ3orYkd2c2lRcEtE?=
 =?utf-8?B?bW9Odi8vdG44M29pNVhSb0ZwejUxa1BnSyt5UUxrUXFSZnpSZlBYMklEOU5h?=
 =?utf-8?B?ZERXWXh5ZWo5d0F6TnF2dStGajBiY3lSSDdvdEhJblNKTHVRMVRWd1J2M1I5?=
 =?utf-8?B?YmMvak51dWxQTnZZNWZRT3hyamNWcjlac1ZDeks1c1I3c04zc09uVUxoV21u?=
 =?utf-8?B?TWVCRGFrV2pnVExrTFozSmprakQzL1hYSjdDTytJbnVEQ01xNytPOWt4Yytx?=
 =?utf-8?B?dFltdEJxWjZ0L0xuRjR5eWFSa0hSaCtaQ0treUh3UEtKL2k2citOT2ZBVUVO?=
 =?utf-8?B?bWpPSUNoZTFCVWVtbmFPWmZTUjBYS1NKN0RUR3RiSENyd0RKMjJhL0xVM3Nn?=
 =?utf-8?B?WE5zL3dSTTV3ekpHMkY3S1Z2ZXdJdmpMeGRsb1gyRlNPYThaS1VCT041WU1E?=
 =?utf-8?B?YllLaytKYU9UcFZLRnRnSVpPcHQ1TlR4R1BtMnJrL0UrcHNBb3U1M05xN3FE?=
 =?utf-8?B?SnZMVDI3ZzA5MURpcEh2ZnlUTklYNjN1WjBLRU15bzFORXBPbDVPWDFEVFdh?=
 =?utf-8?B?OTJWSkVVcEpUTGJ5L25DRlJJMUluVDFKVEFnd0xrTXh3QnVFWDJvMi9FNWFp?=
 =?utf-8?B?dUhnbTdQemoxb3JPSk51ODFRNEdtd1A1Tmp6OHJXUmg1OFlIS2dYZU1CaDdT?=
 =?utf-8?B?WTBsMDVZVjVTL05Sc0MzaVFURUdiYW5KQSt0dUpONnB1bFJldXNkNThzd2Ev?=
 =?utf-8?B?MkxsMkxaV3ZIU1JBdEFleEFqMVhkQXdPV2JQcmVWSUJZMjNlTjFsN2xxUkp2?=
 =?utf-8?B?V0Y4MmcybGRxQUZRaGpaN2luUS9UbUxDZE92eW5KWFBCSjlJV0Rwdkt3dGZq?=
 =?utf-8?B?QjRzeFNEVEk1TzJGaW0rS1NUTzBxK0hlK3REeGl1QU45MWVYZ2g4VENGQ21P?=
 =?utf-8?B?c1lPTXorTFlKV2s5QXp3Q1BLNS9aRHpydHNCU0NRamNHTVU0aHNoRnV0RDhm?=
 =?utf-8?B?dWhSV2RsOHYvWkxQN0RCa25kWDI1SDNWWXRKVE5nUVFQanpHZ0FhcllkdXcv?=
 =?utf-8?Q?EllowupWYDqYaomZqbzf8zdFhGNj5o7qCG3KWdU2qciP?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47119b83-c4ab-40ae-c09b-08dbd0029832
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:49:36.6706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GkbGnjbDUYe8IJUFUmF5okip2SdKOCvJXYFGRRcfBuMMMhjJ/9mLyU86Bg8YqfLq6Vyk3J5n9tAjNNKYsmAsbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P193MB1478
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGZvbGxvd2luZyBzZXJpZXMgaW5jbHVkZXMgc29tZSBmaXhlcyBhbmQgaW1wcm92ZW1lbnRz
IGFyb3VuZCBSUzQ4NSBpbgp0aGUgc2VyaWFsIGNvcmUgYW5kIFVBUlQgZHJpdmVyczoKClBhdGNo
IDE6IERvIG5vdCBob2xkIHRoZSBwb3J0IGxvY2sgd2hlbiBzZXR0aW5nIHJ4LWR1cmluZy10eCBH
UElPClBhdGNoIDI6IHNldCBtaXNzaW5nIHN1cHBvcnRlZCBmbGFnIGZvciBSWCBkdXJpbmcgVFgg
R1BJTwpQYXRjaCAzOiBmaXggc2FuaXRpemluZyBjaGVjayBmb3IgUlRTIHNldHRpbmdzClBhdGNo
IDQ6IG1ha2Ugc3VyZSBSUzQ4NSBpcyBjYW5ub3QgYmUgZW5hYmxlZCB3aGVuIGl0IGlzIG5vdCBz
dXBwb3J0ZWQKUGF0Y2ggNTogaW14OiBkbyBub3Qgc2V0IFJTNDg1IGVuYWJsZWQgaWYgaXQgaXMg
bm90IHN1cHBvcnRlZApQYXRjaCA2OiBvbWFwOiBkbyBub3Qgb3ZlcnJpZGUgc2V0dGluZ3MgZm9y
IHJzNDg1IHN1cHBvcnQKUGF0Y2ggNzogZXhhcjogc2V0IG1pc3NpbmcgUlM0ODUgc3VwcG9ydGVk
IGZsYWcKCkNoYW5nZXMgaW4gdjQ6Ci0gYWRkIGNvbW1lbnQgZm9yIGZ1bmN0aW9uIHVhcnRfc2V0
X3JzNDg1X2dwaW9zIGFmdGVyIGhpbnQgZnJvbSBIdWdvCi0gY29ycmVjdCBjb21taXQgbWVzc2Fn
ZSBhcyBwb2ludGVkIG91dCBieSBIdWdvCi0gcmVwaHJhc2UgY29tbWl0IG1lc3NhZ2VzCi0gYWRk
IHBhdGNoIDcgYWZ0ZXIgZGlzY3Vzc2lvbiB3aXRoIElscG8KCkNoYW5nZXMgaW4gdjMKLSBEcm9w
IHBhdGNoICJHZXQgcmlkIG9mIHVzZWxlc3Mgd3JhcHBlciBwbDAxMV9nZXRfcnM0ODVfbW9kZSgp
IiBhcwogIHJlcXVlc3RlZCBieSBHcmVnCgpDaGFuZ2VzIGluIHYyOgotIGFkZCBtaXNzaW5nICdG
aXhlcycgdGFncyBhcyByZXF1ZXN0ZWQgYnkgR3JlZwotIGNvcnJlY3RlZCBhIHR5cG8gYXMgcG9p
bnRlZCBvdXQgYnkgSHVnbwotIGZpeCBpc3N1ZSBpbiBpbXggZHJpdmVyIGluIHRoZSBzZXJpYWwg
Y29yZSBhcyBzdWdnZXN0ZWQgYnkgVXdlCi0gcGFydGx5IHJlcGhyYXNlIHNvbWUgY29tbWl0IG1l
c3NhZ2VzCi0gYWRkIHBhdGNoIDcKCkxpbm8gU2FuZmlsaXBwbyAoNyk6CiAgc2VyaWFsOiBEbyBu
b3QgaG9sZCB0aGUgcG9ydCBsb2NrIHdoZW4gc2V0dGluZyByeC1kdXJpbmctdHggR1BJTwogIHNl
cmlhbDogY29yZTogc2V0IG1pc3Npbmcgc3VwcG9ydGVkIGZsYWcgZm9yIFJYIGR1cmluZyBUWCBH
UElPCiAgc2VyaWFsOiBjb3JlOiBmaXggc2FuaXRpemluZyBjaGVjayBmb3IgUlRTIHNldHRpbmdz
CiAgc2VyaWFsOiBjb3JlOiBtYWtlIHN1cmUgUlM0ODUgY2Fubm90IGJlIGVuYWJsZWQgd2hlbiBp
dCBpcyBub3QKICAgIHN1cHBvcnRlZAogIHNlcmlhbDogY29yZSwgaW14OiBkbyBub3Qgc2V0IFJT
NDg1IGVuYWJsZWQgaWYgaXQgaXMgbm90IHN1cHBvcnRlZAogIHNlcmlhbDogb21hcDogZG8gbm90
IG92ZXJyaWRlIHNldHRpbmdzIGZvciBSUzQ4NSBzdXBwb3J0CiAgc2VyaWFsOiA4MjUwX2V4YXI6
IFNldCBtaXNzaW5nIHJzNDg1X3N1cHBvcnRlZCBmbGFnCgogZHJpdmVycy90dHkvc2VyaWFsLzgy
NTAvODI1MF9leGFyLmMgfCAgNSArLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9pbXguYyAgICAgICAg
ICAgIHwgIDggLS0tLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9vbWFwLXNlcmlhbC5jICAgIHwgIDgg
KystLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jICAgIHwgNTMgKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9zdG0zMi11c2FydC5jICAg
IHwgIDUgKy0tCiA1IGZpbGVzIGNoYW5nZWQsIDQ2IGluc2VydGlvbnMoKyksIDMzIGRlbGV0aW9u
cygtKQoKCmJhc2UtY29tbWl0OiA1ODcyMDgwOWY1Mjc3OWRjMGYwOGU1M2U1NGIwMTQyMDlkMTNl
ZWJiCi0tIAoyLjQwLjEKCg==
