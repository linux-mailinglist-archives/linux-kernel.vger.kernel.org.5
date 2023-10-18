Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAB97CE53B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjJRRtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjJRRtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:49:43 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2047.outbound.protection.outlook.com [40.107.22.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF6A112;
        Wed, 18 Oct 2023 10:49:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJMFDHnUNSKyDjDufaULtC/PvwznpBvduHHHhBlZqGKkMRPIT3YpJY+hp+vEOnxMKkO8YUJdIUhLDtPAD6sESs7TkenWZmeYahhqNkpMvtMKrvJQqYqffSmyASxVwGtxCQQH5doYP6VBx4KwZpJ2Lo/jrDG0qGm7FQdNdBz+y3DdzrbHPWmRRfr2aZKt/kge9sNh/emzDEX8CgkWTglMHVGRHTZ9QAm38fwqQ2ZyxXdDe9ENJpy5mDQqFqjl32qA10k/IY9XtHlOC5Qhn8o05BR0kClYzU70MqgHUD5uP2GFCrN96pkm/ox/cYrM3Cn7/fxMdnw9XNY9r7lqONwk7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kig7DXAIM3jbV8RnY2R78WbZepJvDlAZxse7gk0wTaQ=;
 b=PTECnKq3pP1/XA5RRiKHUSFx2lMLOkm5T7kYxEXFmPuG3IUOzxurRWLQXMVP1a65WhbUX+gg9VtANJXSTMoNMbIhm62BACUEXpq34YDKw9iWGKc0GoKv4yHq5Kb/p0dBeX8pgC7YnO6DNl5KEev028J3AjD0LdsyvpIdzB6DWr18r5yLTQbYHcdwzFtLhBySQ+7TjemyGlp7fUo5InBPgAcND+4FGFrHzbIFOn1EjR/Rkskkx/fOaxvytErOL4PWWEhK/16oS+b7HqOHLoo+9O73CpcpaFkzOGyqSrQkAN/KwMKA5ZpFWxY7QpuWRXhbjMhl90svB48yfoK3rAJSTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kig7DXAIM3jbV8RnY2R78WbZepJvDlAZxse7gk0wTaQ=;
 b=GUD+rpoE3gNaAKX/aB0nTbYTdQ+IG/cdHb6jNJTtAMZs82d1KVxX+/nn7kwBx2wi9UeoqkWib1T1ODAdeq2aUzaGKyMpla05Ps/xA3Z0F85zX61/tuWe4VcbLHEwuO4dgq2wBwrh8nru2vRCSfciuWyjDl5+Ar61+04Q1+aPgaI=
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
 17:49:37 +0000
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com
Cc:     u.kleine-koenig@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        stable@vger.kernel.org
Subject: [PATCH v4 1/7] serial: Do not hold the port lock when setting rx-during-tx GPIO
Date:   Wed, 18 Oct 2023 19:48:34 +0200
Message-Id: <20231018174840.28977-2-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018174840.28977-1-l.sanfilippo@kunbus.com>
References: <20231018174840.28977-1-l.sanfilippo@kunbus.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::17) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|AS8P193MB1478:EE_
X-MS-Office365-Filtering-Correlation-Id: df67c3bb-bcd5-4e5d-4540-08dbd0029899
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zVuJrcLoriTOHM1JYrJky0Z5WHGN5rPnXGVQACkTIrIYvRUecpBsHpY2CI3ai5qLSEbDzIj8QWbOLxjnXg2xaCfqBGgsovT3OzhQohraoRFzuOpDg5+VANWny39G0ytw/1nQOaLY7bVPt5+H9Xhj4oQQb+CMbImsW3zsJb6v2b7V/3hB8HrAsc5GNbjQSg62kL6OeOJS8MOilXEtCkS0uEWMZ+IklIpr38HEpS3a18FuxF7s1nOCM2xUYIqGNsnZe/9JewHtZUIKqsgcd1F23ySj0O0Z+sIe0mo4cwdwzkiASBzJbCPRvS/Uk+FQX4b9h7rHimpWQCV2OVsR3xNQez31au9wXi81FdF9pYiosTFpNkMErJFHw1YpZ4ZPLeynNhE/iOZ3KjThyBeeEr3pqd87aSfXcv62GHK3EDGNvKK47D4/IgHmvEGElZa5h1qddUeYS2zqIhG/TgZU9I3YT6oXJ9kpX3V5UGMBNIlm1QWb38rnAXcxmHjd/IJWFs74pwFH8z1K6TzqneoT0+QCzLIpgrmHpZWahqYrqBlHFSQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39840400004)(376002)(346002)(366004)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(36756003)(66946007)(66556008)(66476007)(86362001)(38100700002)(1076003)(2616005)(83380400001)(6666004)(6512007)(52116002)(6506007)(7416002)(6486002)(316002)(478600001)(5660300002)(4326008)(8676002)(41300700001)(2906002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vBvekx8VX1rcwvvmhxBGQrT4TM8YbhB0Cm6Ka9lfPE5p6ojGn+ZPnO25Blds?=
 =?us-ascii?Q?uKwQwquwLQ728F+L+znhwniiwSG8339uUh3fK5+/cWcAE2SiXvwSAKPG5+7I?=
 =?us-ascii?Q?dB9DBWSveVmrCbAxzTjxMKWk/G1/xUgojTmn3K2czQ7V/kQqSWAuzMWp9npj?=
 =?us-ascii?Q?ymFt5dWL5kx0wPBF/h4ovhC7X1SaGP93tY7mqL8CB4YpgYIOZP2Eb8/OjkWD?=
 =?us-ascii?Q?ZgzJGtcoFA2fNxqGWJEE6E63PG4ihflPdt3e2ntomeducl77PCU728Bnqg9f?=
 =?us-ascii?Q?qGChbUvCkUEzFrVket48psinKdmftPJ4uZZMgG/D4lrUu2PQwvlpX4OgSeIG?=
 =?us-ascii?Q?4V/SK6hBfT923Uf2C+eXEBr0zo9oaS6O1iuRn5T4RFl4jkZnS+dXK+in+7T/?=
 =?us-ascii?Q?yFur0H5i5lg5X/39zKng12L+CreM/2fwxi5RNgsZw6Uoxarws+1+bjCfIFhA?=
 =?us-ascii?Q?OZ9vkBdmnCfEYOGfWvW7Sdc1LaRH1ZZVJ7Hfd1h+7x/NY5JCRGNf0K5ID5XY?=
 =?us-ascii?Q?vSNdIiPfevkZbSBglK9Ml7Eycs6yUhx9ya4cXFCJzKx7cLX3DCJpjRg79KzE?=
 =?us-ascii?Q?mbGEzh5Xr1tTB5JAdH6BtObtDIk5J+tf6czKagD77ynVPc50HkJxMUGG5VOb?=
 =?us-ascii?Q?XzwAif4amKIyIfCS4Yc4QTolCTTTl6kxUU0cuZv6cHISyjEEml1l/o1GFjD7?=
 =?us-ascii?Q?NnhZkCOgoHD6WVuurfOKVBL4NVWJ3s3RacET3KKHLuxoG1ijrK0Tc/nQTIBX?=
 =?us-ascii?Q?JXN63o1aStAEqkII+vvaYDnkYBkJzwNSz2A3iVEodrKRnUBKpPdteVH9mBIg?=
 =?us-ascii?Q?HuXbPuPKjljBVuWfcfEXPd+WfchS8wQPcrR1d1an9Rzqb16Wtso67/xQWeZt?=
 =?us-ascii?Q?uglb7yhrPPWE0JEBIQ0nYGSSEAs9HFd1vwdQ8y5ljWWj9gO75y6FujySU9XH?=
 =?us-ascii?Q?ihCIgwSA5ak7P1fauOlhLUq5DNyYiDqTLa7hWvS7VMQ52bQITnFXw84NLV8h?=
 =?us-ascii?Q?gQAISx6mwzO50ts9HLA+0mqtcBOpVtJF7kD5YaScqwX3ukD18K7CqJSDZx6l?=
 =?us-ascii?Q?xh4Vs2AwL0mr+hnpbmtXl4aDNUfPZqxm+6SNINllrr0Xuphubpx6LkdneGPs?=
 =?us-ascii?Q?IizF8tdA8+wmZrVHqgBTNOT69axL77rdD1iRvKNRa4ScnZN3iRuOSNkQ30nP?=
 =?us-ascii?Q?S4+UUYm790DiHBGAzASwJm9EUiXboD6+g/lg8hiTxqj8aZzC3SBrEJ9RYaHA?=
 =?us-ascii?Q?/bbVkQJNQhzv+Gf+HP/FjBj9EDD9wDG/1tizgqqYFaYd5voviV0bxeVPmpiB?=
 =?us-ascii?Q?u1nSRLXX9ekOhj8SIJKyDe5Q8o/hy6pPSC8yedrEF+3fhMjXXs2txMn4+X5o?=
 =?us-ascii?Q?ruCvDJtyieq3ZBikrMW0T7iIZP2zgDMFdHtCEddG/bsY/NekDeDjwfA4gGyM?=
 =?us-ascii?Q?dQYXqKwyhZbJTzqjMIUOOfDH1m/5tYHP+ix9XGDSpxYszVNx/z6LDLT6fhCY?=
 =?us-ascii?Q?IiA57Dy95B+Rcb6Yvw8jN77m+GueRQEsqALCUHPpwNF487o6cCIbn42ZIhn4?=
 =?us-ascii?Q?o3dJhKG5KPkQFKT/8JV9bt3lwBX185OfSmnbQ7eeLRbahffzdvgfP/0gGYnj?=
 =?us-ascii?Q?0OsPUbS8KNSArxqJ1tDaAmcKDGXlL3uISQoCHG67vLOd?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df67c3bb-bcd5-4e5d-4540-08dbd0029899
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:49:37.3227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dwcD3vU1XL3VB/zRaSK5EE8tX9LeKWKLBmOzFAzMO1IYEcbM3poO9fpJvz5eVVMD0lT173xsiN1B6A53TG/pSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P193MB1478
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_BASE64_TEXT,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qm90aCB0aGUgaW14IGFuZCBzdG0zMiBkcml2ZXIgc2V0IHRoZSByeC1kdXJpbmctdHggR1BJTyBp
biByczQ4NV9jb25maWcoKS4KU2luY2UgdGhpcyBmdW5jdGlvbiBpcyBjYWxsZWQgd2l0aCB0aGUg
cG9ydCBsb2NrIGhlbGQsIHRoaXMgY2FuIGJlIGFuCnByb2JsZW0gaW4gY2FzZSB0aGF0IHNldHRp
bmcgdGhlIEdQSU8gbGluZSBjYW4gc2xlZXAgKGUuZy4gaWYgYSBHUElPCmV4cGFuZGVyIGlzIHVz
ZWQgd2hpY2ggaXMgY29ubmVjdGVkIHZpYSBTUEkgb3IgSTJDKS4KCkF2b2lkIHRoaXMgaXNzdWUg
YnkgbW92aW5nIHRoZSBHUElPIHNldHRpbmcgb3V0c2lkZSBvZiB0aGUgcG9ydCBsb2NrIGludG8K
dGhlIHNlcmlhbCBjb3JlIGFuZCB0aHVzIG1ha2luZyBpdCBhIGdlbmVyaWMgZmVhdHVyZS4KClNp
bmNlIGJvdGggc2V0dGluZyB0aGUgdGVybSBhbmQgdGhlIHJ4LWR1cmluZy10eCBHUElPIGlzIGRv
bmUgYXQgdGhlIHNhbWUKY29kZSBwbGFjZSwgbW92ZSBpdCBpbnRvIGEgY29tbW9uIGZ1bmN0aW9u
LgoKRml4ZXM6IGM1NGQ0ODU0MzY4OSAoInNlcmlhbDogc3RtMzI6IEFkZCBzdXBwb3J0IGZvciBy
czQ4NSBSWF9EVVJJTkdfVFggb3V0cHV0IEdQSU8iKQpGaXhlczogY2E1MzBjZmE5NjhjICgic2Vy
aWFsOiBpbXg6IEFkZCBzdXBwb3J0IGZvciBSUzQ4NSBSWF9EVVJJTkdfVFggb3V0cHV0IEdQSU8i
KQpDYzogU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPgpDYzogU2FzY2hhIEhhdWVyIDxz
LmhhdWVyQHBlbmd1dHJvbml4LmRlPgpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwpTaWduZWQt
b2ZmLWJ5OiBMaW5vIFNhbmZpbGlwcG8gPGwuc2FuZmlsaXBwb0BrdW5idXMuY29tPgotLS0KIGRy
aXZlcnMvdHR5L3NlcmlhbC9pbXguYyAgICAgICAgIHwgIDQgLS0tLQogZHJpdmVycy90dHkvc2Vy
aWFsL3NlcmlhbF9jb3JlLmMgfCAxNSArKysrKysrKysrKy0tLS0KIGRyaXZlcnMvdHR5L3Nlcmlh
bC9zdG0zMi11c2FydC5jIHwgIDUgKy0tLS0KIDMgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9u
cygrKSwgMTIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL2lt
eC5jIGIvZHJpdmVycy90dHkvc2VyaWFsL2lteC5jCmluZGV4IDEzY2I3ODM0MDcwOS4uZWRiMmVj
NmE1NTY3IDEwMDY0NAotLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMKKysrIGIvZHJpdmVy
cy90dHkvc2VyaWFsL2lteC5jCkBAIC0xOTQ3LDEwICsxOTQ3LDYgQEAgc3RhdGljIGludCBpbXhf
dWFydF9yczQ4NV9jb25maWcoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwgc3RydWN0IGt0ZXJtaW9z
ICp0ZXJtaW8KIAkgICAgcnM0ODVjb25mLT5mbGFncyAmIFNFUl9SUzQ4NV9SWF9EVVJJTkdfVFgp
CiAJCWlteF91YXJ0X3N0YXJ0X3J4KHBvcnQpOwogCi0JaWYgKHBvcnQtPnJzNDg1X3J4X2R1cmlu
Z190eF9ncGlvKQotCQlncGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAocG9ydC0+cnM0ODVfcnhfZHVy
aW5nX3R4X2dwaW8sCi0JCQkJCSAhIShyczQ4NWNvbmYtPmZsYWdzICYgU0VSX1JTNDg1X1JYX0RV
UklOR19UWCkpOwotCiAJcmV0dXJuIDA7CiB9CiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3Nl
cmlhbC9zZXJpYWxfY29yZS5jIGIvZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMKaW5k
ZXggZDViYTZlOTBiZDk1Li4zNWUwMTRmODM0NjUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdHR5L3Nl
cmlhbC9zZXJpYWxfY29yZS5jCisrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5j
CkBAIC0xMzkxLDE0ICsxMzkxLDIxIEBAIHN0YXRpYyB2b2lkIHVhcnRfc2FuaXRpemVfc2VyaWFs
X3JzNDg1KHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsIHN0cnVjdCBzZXJpYWxfcnM0CiAJbWVtc2V0
KHJzNDg1LT5wYWRkaW5nMSwgMCwgc2l6ZW9mKHJzNDg1LT5wYWRkaW5nMSkpOwogfQogCi1zdGF0
aWMgdm9pZCB1YXJ0X3NldF9yczQ4NV90ZXJtaW5hdGlvbihzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0
LAotCQkJCSAgICAgICBjb25zdCBzdHJ1Y3Qgc2VyaWFsX3JzNDg1ICpyczQ4NSkKKy8qCisgKiBT
ZXQgb3B0aW9uYWwgUlM0ODUgR1BJT3MgZm9yIGJ1cyB0ZXJtaW5hdGlvbiBhbmQgZGF0YSByZWNl
cHRpb24gZHVyaW5nCisgKiB0cmFuc21pc3Npb24uIFRoZXNlIEdQSU9zIGFyZSBjb250cm9sbGVk
IGJ5IHRoZSBzZXJpYWwgY29yZSBpbmRlcGVuZGVudGx5CisgKiBmcm9tIHRoZSBVQVJUIGRyaXZl
ci4KKyAqLworc3RhdGljIHZvaWQgdWFydF9zZXRfcnM0ODVfZ3Bpb3Moc3RydWN0IHVhcnRfcG9y
dCAqcG9ydCwKKwkJCQkgY29uc3Qgc3RydWN0IHNlcmlhbF9yczQ4NSAqcnM0ODUpCiB7CiAJaWYg
KCEocnM0ODUtPmZsYWdzICYgU0VSX1JTNDg1X0VOQUJMRUQpKQogCQlyZXR1cm47CiAKIAlncGlv
ZF9zZXRfdmFsdWVfY2Fuc2xlZXAocG9ydC0+cnM0ODVfdGVybV9ncGlvLAogCQkJCSAhIShyczQ4
NS0+ZmxhZ3MgJiBTRVJfUlM0ODVfVEVSTUlOQVRFX0JVUykpOworCWdwaW9kX3NldF92YWx1ZV9j
YW5zbGVlcChwb3J0LT5yczQ4NV9yeF9kdXJpbmdfdHhfZ3BpbywKKwkJCQkgISEocnM0ODUtPmZs
YWdzICYgU0VSX1JTNDg1X1JYX0RVUklOR19UWCkpOwogfQogCiBzdGF0aWMgaW50IHVhcnRfcnM0
ODVfY29uZmlnKHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQpCkBAIC0xNDExLDcgKzE0MTgsNyBAQCBz
dGF0aWMgaW50IHVhcnRfcnM0ODVfY29uZmlnKHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQpCiAJCXJl
dHVybiAwOwogCiAJdWFydF9zYW5pdGl6ZV9zZXJpYWxfcnM0ODUocG9ydCwgcnM0ODUpOwotCXVh
cnRfc2V0X3JzNDg1X3Rlcm1pbmF0aW9uKHBvcnQsIHJzNDg1KTsKKwl1YXJ0X3NldF9yczQ4NV9n
cGlvcyhwb3J0LCByczQ4NSk7CiAKIAlzcGluX2xvY2tfaXJxc2F2ZSgmcG9ydC0+bG9jaywgZmxh
Z3MpOwogCXJldCA9IHBvcnQtPnJzNDg1X2NvbmZpZyhwb3J0LCBOVUxMLCByczQ4NSk7CkBAIC0x
NDU1LDcgKzE0NjIsNyBAQCBzdGF0aWMgaW50IHVhcnRfc2V0X3JzNDg1X2NvbmZpZyhzdHJ1Y3Qg
dHR5X3N0cnVjdCAqdHR5LCBzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LAogCWlmIChyZXQpCiAJCXJl
dHVybiByZXQ7CiAJdWFydF9zYW5pdGl6ZV9zZXJpYWxfcnM0ODUocG9ydCwgJnJzNDg1KTsKLQl1
YXJ0X3NldF9yczQ4NV90ZXJtaW5hdGlvbihwb3J0LCAmcnM0ODUpOworCXVhcnRfc2V0X3JzNDg1
X2dwaW9zKHBvcnQsICZyczQ4NSk7CiAKIAlzcGluX2xvY2tfaXJxc2F2ZSgmcG9ydC0+bG9jaywg
ZmxhZ3MpOwogCXJldCA9IHBvcnQtPnJzNDg1X2NvbmZpZyhwb3J0LCAmdHR5LT50ZXJtaW9zLCAm
cnM0ODUpOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL3N0bTMyLXVzYXJ0LmMgYi9k
cml2ZXJzL3R0eS9zZXJpYWwvc3RtMzItdXNhcnQuYwppbmRleCA1ZTljZjBjNDg4MTMuLjhlYjEz
YmYwNTVmMiAxMDA2NDQKLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL3N0bTMyLXVzYXJ0LmMKKysr
IGIvZHJpdmVycy90dHkvc2VyaWFsL3N0bTMyLXVzYXJ0LmMKQEAgLTIyNiwxMCArMjI2LDcgQEAg
c3RhdGljIGludCBzdG0zMl91c2FydF9jb25maWdfcnM0ODUoc3RydWN0IHVhcnRfcG9ydCAqcG9y
dCwgc3RydWN0IGt0ZXJtaW9zICp0ZXIKIAogCXN0bTMyX3VzYXJ0X2Nscl9iaXRzKHBvcnQsIG9m
cy0+Y3IxLCBCSVQoY2ZnLT51YXJ0X2VuYWJsZV9iaXQpKTsKIAotCWlmIChwb3J0LT5yczQ4NV9y
eF9kdXJpbmdfdHhfZ3BpbykKLQkJZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKHBvcnQtPnJzNDg1
X3J4X2R1cmluZ190eF9ncGlvLAotCQkJCQkgISEocnM0ODVjb25mLT5mbGFncyAmIFNFUl9SUzQ4
NV9SWF9EVVJJTkdfVFgpKTsKLQllbHNlCisJaWYgKCFwb3J0LT5yczQ4NV9yeF9kdXJpbmdfdHhf
Z3BpbykKIAkJcnM0ODVjb25mLT5mbGFncyB8PSBTRVJfUlM0ODVfUlhfRFVSSU5HX1RYOwogCiAJ
aWYgKHJzNDg1Y29uZi0+ZmxhZ3MgJiBTRVJfUlM0ODVfRU5BQkxFRCkgewotLSAKMi40MC4xCgo=
