Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FCB7C5B1A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346289AbjJKSQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235145AbjJKSQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:16:18 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2041.outbound.protection.outlook.com [40.107.6.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15607E5;
        Wed, 11 Oct 2023 11:16:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJMh+HfJAapuUDXSiFnJcZ5wZkw/cun9KKwYmltx4LEz1tt368wyq/9Dr8mNL/2iefS2E4/3xsL3CKOhLiAlD+CSa4Cb6MTnrp8zK0gDCR9TisS3RPeRKxKSzh2TdrMOj6xavFkPwSHCu3IvMCG7SD60iQrZa3aXuQGm2EpOUfFqdb9v9cuT9Q5PXVghQ+0RG/Bt5TCn2KgqhzSaQVBNgoQWc6SunvzKnU802eI3nJthL8DImEf5lk/IIDV9CV+fUaanfJesXXdUm130A4FF+dceLWTFINvNRNMemixzmv/5I5MABiaQD9wTUDj7iAomndt+MJIvJx68ca3G0m4hUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KQh/iKhf9LXRW6pVMZ1tYdiYaWX6FeHAsXrrGRngEU=;
 b=m/6m+9dZBljNANWRsZP/JaSMsMGLfFo6cH1xB62lo3+GxoIj+mhnlqG8Z/8R3hcR0/z6hxjGInpY8oa+iFJ5Q0sK36qI0vBerzEkUwWFUKklEdPy0YQg7StbQ7wrY9ZsYk5zWq40/LvVSFO/2skaq2NxRoffDi3BGmVpneTcxk7HtTmRqCFch+GoyTncBnZ0vwA48q4PqGKhTqI+RVMsXp4bH3fzunboeKpZNidURw4IpHg9Y0qLQD480Doosx1g9fmJosZ+27iFqkQ0J2zBHSxsDMBg6JDJLiAgk07n5Sv2oJEZQffIJiT812cvf8GE1O5V35nO27nGY23YJQXJFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KQh/iKhf9LXRW6pVMZ1tYdiYaWX6FeHAsXrrGRngEU=;
 b=m/jUMRZ34/i6WEEHihlwTI/6UyJqy0VzBJcYOaATzUgGmHz8T5Tclm/k81DB2R69EXp41EouNr12/CvdzhQIU1AMAGmGeUpj/OhdhSAj70+74jj50Bqe5o9KXBgnabdvyLRWA8ugo7C6qIMv8hNuYJDzyP3Zg0wlpVhABsPm0I0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by DB9P193MB1497.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:26f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.41; Wed, 11 Oct
 2023 18:16:10 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::550d:2425:c0ed:3e59]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::550d:2425:c0ed:3e59%3]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 18:16:10 +0000
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        cniedermaier@dh-electronics.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, LinoSanfilippo@gmx.de,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        stable@vger.kernel.org
Subject: [PATCH v3 1/6] serial: Do not hold the port lock when setting rx-during-tx GPIO
Date:   Wed, 11 Oct 2023 20:15:39 +0200
Message-Id: <20231011181544.7893-2-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231011181544.7893-1-l.sanfilippo@kunbus.com>
References: <20231011181544.7893-1-l.sanfilippo@kunbus.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::9) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|DB9P193MB1497:EE_
X-MS-Office365-Filtering-Correlation-Id: c516f870-7ac6-4a98-ed74-08dbca86256e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z1yNtvjSSbYkbCFaHtHQpVy2frvfV17lirdrLjUVA60sjDg/3MPz/4R7jp0sLpXweCv90b5rR8Is/e/Pesgo0eHcWJFcfK83x74L0E2nIBNJCcoVO7NnWiugxdleHHN2mQkZCXLKPHBE2LKyTeFfAAr0uxLpdZwy6c6uEXHvv6yQxmsu8Qfl+DXnVipUPOlZlFB0GYYJv6fNUQ/IKJ7nw4OtxU3A4Cwg5kJPqtBSmgTHvFYHLcuKfQCBk/HVqYp/YcHG7bqwCdqVhol5jSSMXACKNxHV0xIryPfF28fnNxU/nZlj0//bkVLUa1Ok5PViCyCrhIIX5lOnIpTM6IUuIQ480deZV023Z9LuZHqDZRzi/T58tH8A2MbpfgqlDGeLvTMWY/IuVvm+R1UP4gaVzPNG2dJ0tsgheZqOl5TfNnUrCvMQv+n6672cnrwauww4SIvZSBT+lazsturB69Siips3rNswAvB6v4Yi7j4eG15zYYUTB7smIOchOnDVhHfVd7bE67kervLJMnBGva/TSsfs+WSNkUW03UPPDBE5ptLxh/kt5iiN5o4iqhK1pNYt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39840400004)(376002)(346002)(136003)(366004)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(52116002)(6666004)(6506007)(478600001)(6486002)(6512007)(38100700002)(86362001)(36756003)(2906002)(5660300002)(7416002)(83380400001)(1076003)(2616005)(316002)(66946007)(8936002)(4326008)(8676002)(41300700001)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NMgxcCyxUTPkjNSD5JJ6kDg1D+pLMjTr8NAgT8XKZINBANxj9/pwBQtIlxdw?=
 =?us-ascii?Q?cflVPBIEDmdHpBK6sgi5vw/biimnJL1/AyxdF5wBc5XPPpsKTpSl3QCkhxnZ?=
 =?us-ascii?Q?3K9bXteX2cOMTLFh/8RZPhhmBC0FZYmtnXcAsW3Fjgm/tN6WCwDdrUQjcM/x?=
 =?us-ascii?Q?ejTeVVwyDjVauX8AX3LK7qv+JR9IDjnUTIsB9iZXMtT+TOlN/o+SIRuNgyF8?=
 =?us-ascii?Q?ZkEgCSs/3HLOkUtDCqS9qAPq9ragAEt8Mp4LSr/eOcHUpJDbfKOPLYWN9q5z?=
 =?us-ascii?Q?TSUuRjIf7VNcqIxbd6mj4vh8QwCsGYki2vF6vNdkZzHaG3gLfBlbiWgxK2s+?=
 =?us-ascii?Q?9GiXVOxVNu9c4NkiSk6aWADzqyu2d5tsHlx5LuxXfdxOp9WgfBV5tU++4TCb?=
 =?us-ascii?Q?rEjj3+3S+6mfXA3X8M0JPpDTDoI1g9IAUYRu9aZmmY7kfFcfweZfgqJpwo3l?=
 =?us-ascii?Q?q5vQAWjHV3fqyFc7ZjZbycx8/fL2dVUPDXQLhaF65+NCjPD3r+7KUDT7Hy67?=
 =?us-ascii?Q?MFfJ9yg9M+TXemK1AJRPRDIU/rYB7f+Yxj6+qM7kQ3RsTAtbIRK3n//NMdvY?=
 =?us-ascii?Q?pZmduqO5vCGHRbEExFv5H9DF7qeO2V7NV0a1LGOKMagt19zMqci1OI/4EVYc?=
 =?us-ascii?Q?vHrkX/614EB0WRIrwh9NfOPkXsvU/Ajri8wY/PF5eYbS4PbTcrQZ3Pe4FrUC?=
 =?us-ascii?Q?icQ1VK9HCQXe79bnABXQ3OLKzsDOZJbNUGv3rvZND7yDTAUk1bV00Uhmuu4U?=
 =?us-ascii?Q?jPtCVJbBwqQOFvE/LNdLJulsjtg4g9G0GBmObP5JCagiu0s9tljUXZkjw9Km?=
 =?us-ascii?Q?j1Jr7T0vrBz/XqwDxUoB/o8VGCeWFTvcRk3nlKP727RDWIjZy87+LGHHnoR0?=
 =?us-ascii?Q?NXtwKgKRmoh3dDBLN+nm5emL+EqCs5fPHIFM706Fk2aAP6jjVyhJbWuRIXOE?=
 =?us-ascii?Q?5p8VhaDLaYMP1KxcWYQCVl8og8QHug+EkCXV0n/ZIqEQ63kRCKV1RCw2p/nb?=
 =?us-ascii?Q?ROCRHf3lisg25kMBYDl1jLvqABfr/AQ/Iwjj4pVynSF7jEhTPpZ3sOtJPYv7?=
 =?us-ascii?Q?1a0XaJneHGRHPVDvBaKrrK8MmLhusKKjKivyvorxmxos4rR3DZum7bROgp0L?=
 =?us-ascii?Q?lsYqeq2Hh3DtcSVevFo41d0rbvtgmuQ1orf2Za6OSRXsGKfBlj3XZoDXWzuh?=
 =?us-ascii?Q?5N4evqaHGzTooTkSvoktDSILiaZbmUDx2v5yDTktw29uSuV08CRyxPqLUQ7+?=
 =?us-ascii?Q?mBZFbvqFSi8c8nbl6x9qkkQMpY0vr6OFCEdmhrswplSq5ONGoM5C3Qkqr7Gy?=
 =?us-ascii?Q?bRcH8D6wC1OpvYaZO4fADAXd9lSkqQHLaRKVWu5xpR3J49/IfNQvejkMLWew?=
 =?us-ascii?Q?oVUHcBKDvy3xkPoFD0zigQB3zAWbROw69e8g/SsBNF3VG0i5RK+o0QuL2KOK?=
 =?us-ascii?Q?9rxmf92l/oL5WkgJ0uJa0ayxK9lfepe3ylWpLmCsk50ASu+0uxCVcCbuyMFW?=
 =?us-ascii?Q?k68zVEpcwAGZnkjTlB2Fkh9jyrejYNAbppXvthrisLuKBVfiHteccXof7hBA?=
 =?us-ascii?Q?505YH0FPj2dTOiPd6XfSZLsDiS6AAWYvmkPy4faj6IdhM7w57mPue1B1u+aR?=
 =?us-ascii?Q?vgt8X/Tp1O7rD7gbmLD3oN0wWSNiv/tDoA0dwgak/Hnn?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c516f870-7ac6-4a98-ed74-08dbca86256e
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 18:16:10.7169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /PVWPRpN2NsAEQX68DA3vZdpmN7bEKdye0FutcYi9Lz6LxVa2ExQm5cbNYIqYxPyUcEOTC1G0NDkD4to2ZBiLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P193MB1497
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_BASE64_TEXT,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qm90aCB0aGUgaW14IGFuZCBzdG0zMiBkcml2ZXIgc2V0IHRoZSByeC1kdXJpbmctdHggR1BJTyBp
biB0aGUKcnM0ODVfY29uZmlnKCkgZnVuY3Rpb24gYnkgbWVhbnMgb2YgZ3Bpb2Rfc2V0X3ZhbHVl
KCkuIFNpbmNlIHJzNDg1X2NvbmZpZygpCmlzIGNhbGxlZCB3aXRoIHRoZSBwb3J0IGxvY2sgaGVs
ZCwgdGhpcyBjYW4gYmUgYW4gcHJvYmxlbSBpbiBjYXNlIHRoYXQKc2V0dGluZyB0aGUgR1BJTyBs
aW5lIGNhbiBzbGVlcCAoZS5nLiBpZiBhIEdQSU8gZXhwYW5kZXIgaXMgdXNlZCB3aGljaCBpcwpj
b25uZWN0ZWQgdmlhIFNQSSBvciBJMkMpLgoKQXZvaWQgdGhpcyBpc3N1ZSBieSBzZXR0aW5nIHRo
ZSBHUElPIG91dHNpZGUgb2YgdGhlIHBvcnQgbG9jayBpbiB0aGUgc2VyaWFsCmNvcmUgYW5kIGJ5
IHVzaW5nIGdwaW9kX3NldF92YWx1ZV9jYW5zbGVlcCgpIGluc3RlYWQgb2YgZ3Bpb2Rfc2V0X3Zh
bHVlKCkuCgpTaW5jZSBub3cgYm90aCB0aGUgdGVybSBhbmQgdGhlIHJ4LWR1cmluZy10eCBHUElP
IGFyZSBzZXQgd2l0aGluIHRoZSBzZXJpYWwKY29yZSB1c2UgYSBjb21tb24gZnVuY3Rpb24gdWFy
dF9zZXRfcnM0ODVfZ3Bpb3MoKSB0byBzZXQgYm90aC4KCldpdGggbW92aW5nIGl0IGludG8gdGhl
IHNlcmlhbCBjb3JlIHNldHRpbmcgdGhlIHJ4LWR1cmluZy10eCBHUElPIGlzIG5vdwphdXRvbWF0
aWNhbGx5IGRvbmUgZm9yIGFsbCBkcml2ZXJzIHRoYXQgc3VwcG9ydCBzdWNoIGEgR1BJTy4KCkZp
eGVzOiBjNTRkNDg1NDM2ODkgKCJzZXJpYWw6IHN0bTMyOiBBZGQgc3VwcG9ydCBmb3IgcnM0ODUg
UlhfRFVSSU5HX1RYIG91dHB1dCBHUElPIikKRml4ZXM6IGNhNTMwY2ZhOTY4YyAoInNlcmlhbDog
aW14OiBBZGQgc3VwcG9ydCBmb3IgUlM0ODUgUlhfRFVSSU5HX1RYIG91dHB1dCBHUElPIikKQ2M6
IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKU2lnbmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBvIDxs
LnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KLS0tCiBkcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMgICAg
ICAgICB8ICA0IC0tLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jIHwgMTAgKysr
KysrLS0tLQogZHJpdmVycy90dHkvc2VyaWFsL3N0bTMyLXVzYXJ0LmMgfCAgNSArLS0tLQogMyBm
aWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9pbXguYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9pbXguYwpp
bmRleCAxM2NiNzgzNDA3MDkuLmVkYjJlYzZhNTU2NyAxMDA2NDQKLS0tIGEvZHJpdmVycy90dHkv
c2VyaWFsL2lteC5jCisrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9pbXguYwpAQCAtMTk0NywxMCAr
MTk0Nyw2IEBAIHN0YXRpYyBpbnQgaW14X3VhcnRfcnM0ODVfY29uZmlnKHN0cnVjdCB1YXJ0X3Bv
cnQgKnBvcnQsIHN0cnVjdCBrdGVybWlvcyAqdGVybWlvCiAJICAgIHJzNDg1Y29uZi0+ZmxhZ3Mg
JiBTRVJfUlM0ODVfUlhfRFVSSU5HX1RYKQogCQlpbXhfdWFydF9zdGFydF9yeChwb3J0KTsKIAot
CWlmIChwb3J0LT5yczQ4NV9yeF9kdXJpbmdfdHhfZ3BpbykKLQkJZ3Bpb2Rfc2V0X3ZhbHVlX2Nh
bnNsZWVwKHBvcnQtPnJzNDg1X3J4X2R1cmluZ190eF9ncGlvLAotCQkJCQkgISEocnM0ODVjb25m
LT5mbGFncyAmIFNFUl9SUzQ4NV9SWF9EVVJJTkdfVFgpKTsKLQogCXJldHVybiAwOwogfQogCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYyBiL2RyaXZlcnMvdHR5
L3NlcmlhbC9zZXJpYWxfY29yZS5jCmluZGV4IDdiZGMyMWQ1ZTEzYi4uZWYwNTAwYmUzNTUzIDEw
MDY0NAotLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYworKysgYi9kcml2ZXJz
L3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYwpAQCAtMTM5MSwxNCArMTM5MSwxNiBAQCBzdGF0aWMg
dm9pZCB1YXJ0X3Nhbml0aXplX3NlcmlhbF9yczQ4NShzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LCBz
dHJ1Y3Qgc2VyaWFsX3JzNAogCW1lbXNldChyczQ4NS0+cGFkZGluZzEsIDAsIHNpemVvZihyczQ4
NS0+cGFkZGluZzEpKTsKIH0KIAotc3RhdGljIHZvaWQgdWFydF9zZXRfcnM0ODVfdGVybWluYXRp
b24oc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwKLQkJCQkgICAgICAgY29uc3Qgc3RydWN0IHNlcmlh
bF9yczQ4NSAqcnM0ODUpCitzdGF0aWMgdm9pZCB1YXJ0X3NldF9yczQ4NV9ncGlvcyhzdHJ1Y3Qg
dWFydF9wb3J0ICpwb3J0LAorCQkJCSBjb25zdCBzdHJ1Y3Qgc2VyaWFsX3JzNDg1ICpyczQ4NSkK
IHsKIAlpZiAoIShyczQ4NS0+ZmxhZ3MgJiBTRVJfUlM0ODVfRU5BQkxFRCkpCiAJCXJldHVybjsK
IAogCWdwaW9kX3NldF92YWx1ZV9jYW5zbGVlcChwb3J0LT5yczQ4NV90ZXJtX2dwaW8sCiAJCQkJ
ICEhKHJzNDg1LT5mbGFncyAmIFNFUl9SUzQ4NV9URVJNSU5BVEVfQlVTKSk7CisJZ3Bpb2Rfc2V0
X3ZhbHVlX2NhbnNsZWVwKHBvcnQtPnJzNDg1X3J4X2R1cmluZ190eF9ncGlvLAorCQkJCSAhIShy
czQ4NS0+ZmxhZ3MgJiBTRVJfUlM0ODVfUlhfRFVSSU5HX1RYKSk7CiB9CiAKIHN0YXRpYyBpbnQg
dWFydF9yczQ4NV9jb25maWcoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCkKQEAgLTE0MDcsNyArMTQw
OSw3IEBAIHN0YXRpYyBpbnQgdWFydF9yczQ4NV9jb25maWcoc3RydWN0IHVhcnRfcG9ydCAqcG9y
dCkKIAlpbnQgcmV0OwogCiAJdWFydF9zYW5pdGl6ZV9zZXJpYWxfcnM0ODUocG9ydCwgcnM0ODUp
OwotCXVhcnRfc2V0X3JzNDg1X3Rlcm1pbmF0aW9uKHBvcnQsIHJzNDg1KTsKKwl1YXJ0X3NldF9y
czQ4NV9ncGlvcyhwb3J0LCByczQ4NSk7CiAKIAlyZXQgPSBwb3J0LT5yczQ4NV9jb25maWcocG9y
dCwgTlVMTCwgcnM0ODUpOwogCWlmIChyZXQpCkBAIC0xNDQ5LDcgKzE0NTEsNyBAQCBzdGF0aWMg
aW50IHVhcnRfc2V0X3JzNDg1X2NvbmZpZyhzdHJ1Y3QgdHR5X3N0cnVjdCAqdHR5LCBzdHJ1Y3Qg
dWFydF9wb3J0ICpwb3J0LAogCWlmIChyZXQpCiAJCXJldHVybiByZXQ7CiAJdWFydF9zYW5pdGl6
ZV9zZXJpYWxfcnM0ODUocG9ydCwgJnJzNDg1KTsKLQl1YXJ0X3NldF9yczQ4NV90ZXJtaW5hdGlv
bihwb3J0LCAmcnM0ODUpOworCXVhcnRfc2V0X3JzNDg1X2dwaW9zKHBvcnQsICZyczQ4NSk7CiAK
IAlzcGluX2xvY2tfaXJxc2F2ZSgmcG9ydC0+bG9jaywgZmxhZ3MpOwogCXJldCA9IHBvcnQtPnJz
NDg1X2NvbmZpZyhwb3J0LCAmdHR5LT50ZXJtaW9zLCAmcnM0ODUpOwpkaWZmIC0tZ2l0IGEvZHJp
dmVycy90dHkvc2VyaWFsL3N0bTMyLXVzYXJ0LmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvc3RtMzIt
dXNhcnQuYwppbmRleCA1ZTljZjBjNDg4MTMuLjhlYjEzYmYwNTVmMiAxMDA2NDQKLS0tIGEvZHJp
dmVycy90dHkvc2VyaWFsL3N0bTMyLXVzYXJ0LmMKKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL3N0
bTMyLXVzYXJ0LmMKQEAgLTIyNiwxMCArMjI2LDcgQEAgc3RhdGljIGludCBzdG0zMl91c2FydF9j
b25maWdfcnM0ODUoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwgc3RydWN0IGt0ZXJtaW9zICp0ZXIK
IAogCXN0bTMyX3VzYXJ0X2Nscl9iaXRzKHBvcnQsIG9mcy0+Y3IxLCBCSVQoY2ZnLT51YXJ0X2Vu
YWJsZV9iaXQpKTsKIAotCWlmIChwb3J0LT5yczQ4NV9yeF9kdXJpbmdfdHhfZ3BpbykKLQkJZ3Bp
b2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKHBvcnQtPnJzNDg1X3J4X2R1cmluZ190eF9ncGlvLAotCQkJ
CQkgISEocnM0ODVjb25mLT5mbGFncyAmIFNFUl9SUzQ4NV9SWF9EVVJJTkdfVFgpKTsKLQllbHNl
CisJaWYgKCFwb3J0LT5yczQ4NV9yeF9kdXJpbmdfdHhfZ3BpbykKIAkJcnM0ODVjb25mLT5mbGFn
cyB8PSBTRVJfUlM0ODVfUlhfRFVSSU5HX1RYOwogCiAJaWYgKHJzNDg1Y29uZi0+ZmxhZ3MgJiBT
RVJfUlM0ODVfRU5BQkxFRCkgewotLSAKMi40MC4xCgo=
