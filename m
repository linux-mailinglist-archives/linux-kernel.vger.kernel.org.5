Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD627F05EA
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 12:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjKSLcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 06:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbjKSLb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 06:31:56 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2065.outbound.protection.outlook.com [40.107.104.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611E33874;
        Sun, 19 Nov 2023 03:30:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffHUZxP6X1XCfwENwfK4oFGuJ3ytDTaGbrfzNgYGD+cOn+ITNMnnFf5i1OgDCLgrpwTnI/XitF2QbZXHg71830CLW0DR2/9OEg8njDYav6+40CrUcuLDI3/qpxLwoQ0eBS9NZydH1lYJsKkNXflMRozOm3IOanacbREMhF1ohEp6yw8wb6Krd2OXYccti6MwDM8erFFjoqDJ1YlbYBPNmUhn/ZDYrDA3Whc/d/+zLubp15NeOhfMRaPgj2MNbH3aVMSyYY/2kt0CvY5gAqQb25dquh1lI9JSrhvAvSBCb7iz5duy7zM6p5X74S6oGtHXyrQUD5Q7kbuGfYfXg6FrJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+YOTlv4fFpBwWqW+ic1F06SjLNaWiy0dZ1p8DofigA=;
 b=f1WG+xBMj6csXQV9zqwj4yE8GJb7V/IpRuHWHQEkZF00uGWfg7Bd7i3bm5Ddm2+UD6le2SThQM+Q3Hm9jl8FafzLYSupVDeSq4sBv3A7eqR6BYTlBgExoPBjilmC3O5/ukUfz1i5RQzP8gMXrr8xkpljKbUIq4IIx2D3Kuao870IG9wH00zoxe+mrinrpE+QL29BlXkPFtwX8e12Njxwu0gb2QP2HBzw+2DcrZkrZ735RsBslMqflHIUg5PNmusi7ALhULTSgGZVba9sU0+lF8azfJC2GS2J3ETGVUyj2LPQbppq1ssA3V034ooBxekNjlhEq2N7dUhjBZmyXWvaWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+YOTlv4fFpBwWqW+ic1F06SjLNaWiy0dZ1p8DofigA=;
 b=nSbxM+LW/4pv6UBOyf4LbR2WM/WcSMszBIyBdmpMma+fphoScJx+uj9/a/IwjQ9kO3BfcD4kG09Eia4Iu/Ptm7u3O4wbvguyhBnJfoi+R6xQtG+np/OzrmFPmxgNb5aVfT0m0bT9hOv0EHGG89BtpO0OHQBXwmdLTGTiHgW5Nqw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by AM8P193MB1060.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Sun, 19 Nov
 2023 11:29:59 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06%5]) with mapi id 15.20.7002.025; Sun, 19 Nov 2023
 11:29:58 +0000
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com
Cc:     u.kleine-koenig@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [RESEND PATCH v4 0/7] Fixes and improvements for RS485 (RESEND)
Date:   Sun, 19 Nov 2023 12:28:48 +0100
Message-ID: <20231119112856.11587-1-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.42.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: FR5P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::17) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|AM8P193MB1060:EE_
X-MS-Office365-Filtering-Correlation-Id: d930aba1-4660-46a0-4232-08dbe8f2dc74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ShozBxtbYSqDHKMI4XDiEgzdXLOcoWOqZdMOVNhvjzkI3t1dpYFtAPOSqQWIUTM24525ZfxvljgNEp03UezuhF1sk+frT+5Bm/vozW/hPMJeJZ2+1XDBIIq0INgsHba/lSwLIRWXnutpWzrwwwbrXZsLi+OdsRWcbaQfDMc6JEc1B5b9prxmTH0Sg2+UrAq6P/ZAMzI/0f7xSqhJfdrojwPzp8dS3S/iQSuXV3YWxaBhTX7VTt4vuMtr7DSrB0MWJGWal1JeqOSL3Rl1n9jvhykFQD2U1pGq+yELhxFxgxjLkCcQGaMYXBhSHGVSjRUlXG2z+0zbnV70/HHlJTUwndORY6Xn2qotyoat3qfKOq88dMOSnMusK97KIankkw5KyYV1wTyOsvwCqcwthzLTET2AXDbsIFvWuRD6yd8nvYQTiN9RqKTs9VwvHAXTiE9gqGWtoqHR3/uyRD+zMngenWK74yklw3oyqqmgS3foesi+r0eyPlZsNmlFnl7LocT4IYzxRs4L4M7tioHLan6mP1OFRZ2fIFI6Qyyp0GKb50fBemLNvq0sIHBKdmQttIOa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(39830400003)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(6506007)(6512007)(52116002)(66946007)(66556008)(316002)(4326008)(8676002)(8936002)(66476007)(6486002)(478600001)(83380400001)(1076003)(2616005)(107886003)(38100700002)(6666004)(5660300002)(7416002)(2906002)(86362001)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGozUVBnL0V5SFNsaUFMVHB3TlpwZ1ZicnRMRnBEYzJwekZpWnpCbjFUb0F2?=
 =?utf-8?B?cURpMEFhN2h2dmJISGR2UDBnUmQ3cGxQT1Q5YXVKeTRoS2huRHV6VkRkZ1Vy?=
 =?utf-8?B?SElVd1ZSNFhRL0U2bndMcnRXYXZ0RmJ5UnlwTk45UlpnWXQzTnhjN2tBelZl?=
 =?utf-8?B?YktVZEo5blJqVkd1dExsRExLYzRBRFFNL2gyTSt3SEVucU5hTW96UjdhTllu?=
 =?utf-8?B?VUlqdmJ6emxVb25PVUdnejFRTWNvTUsrQlhrSDRsVjM2OE1qOXV5cmVEVDNv?=
 =?utf-8?B?RDA2dE4rV3FLakxONWFHL3UvemprZDZvTFdmd3lpUk0xV0p5dzBHZzR5L3M2?=
 =?utf-8?B?QUgydDBiU0lnenhnd1lvNFl1N3QrV3RTQVd6SnNnNzhwUHZLWjF2N01yY25u?=
 =?utf-8?B?K1hUNEdncWxnell1TktZOVRGcnlsbTlZSE16ZkkzUlk5UG5XZEs4K3NnUURH?=
 =?utf-8?B?QWFUbmZxWnBxaVVsTmZuZXBpWDBKQWhOdzJPaGNFYTNoTDFPRDU3UFpLbUpv?=
 =?utf-8?B?dTRMdTV0MnkvNVh2bU96TjZuTGdXbzgrU1BYa0xIT2c4aThDMXQxblIzRXZ5?=
 =?utf-8?B?RlpQZWVvdGVUZFNEbUxlYXpWMDNKdkVWRTZkRWl0YzJ1R09PVTM0UlJQOUsx?=
 =?utf-8?B?dzUrMkl0QXd5Y2NDVDJzV1hrcjZINlNvNjJEK203WE54VDNHM0VpV0VHNHYw?=
 =?utf-8?B?T0dCMStkVDcyVkRON05FaXFWL1lveHFacEhsL2haQ0hlZ29lazdYa25yTjFT?=
 =?utf-8?B?dlJ5cEFjaWtOV3QxT0FnYjZEdXNZbUZLWFllSlpMVEFQSGhHZGd2VTFBejhB?=
 =?utf-8?B?RzBVNUpkZU5ZdGtUNFpYTTJaMFdQcTA1cTdSbXo1eVhIR2lZbW5uUzkvRVpw?=
 =?utf-8?B?RGNVQVpkUk5CZzVENHZGa1Zkb0pPZ0R1d0Z2OTZxK216aHJyK1ZsakNEQWhw?=
 =?utf-8?B?Y2dOOUtwWWVKZmNybXJtS2JLaEgzK3dtTFFWWUhkb1l3VXpReFA5eXRMUlo4?=
 =?utf-8?B?S3Y5OThXalpHK1IyOTRSb3lBeXBBTXM0bTBXSVo0b09JaVU0WHlRbW85RVJx?=
 =?utf-8?B?dnlzWVBaVkl1aVJEdUVtamFlWnIyYmM0L2V5alMraWppWFl6VncyN01WTXBD?=
 =?utf-8?B?Z2g1U2pzdElEUXpKVjVtak1nM0FydW5LbHcrYmVKbTlEK1NLZCtJL1Y0amdr?=
 =?utf-8?B?SGt4R2g0VVhPaHlzWTNCdzJLbkhhUzdEcS9JQzJoYitmc000bnpoSWplb3p6?=
 =?utf-8?B?eldJRjh1enRoNEJKbmVIQmZ3VW0rTmV0Rk5pZEpURkdPaDVVdXFVbHRnMDJn?=
 =?utf-8?B?Vm1DYkpJeVhlbzBmSTV3ZWRxb1EyRWRaQURxbU9YNjFGdkhoaW1wZzdHejBz?=
 =?utf-8?B?ZEo0dFFCMThaOTZybFJaOHdTQXNsUFZoQVJJOG1udVdyblIxQXRKK0d3c212?=
 =?utf-8?B?VDJ4bWdDc3FDRGMxS05LVWRlemxKMkFINmwyUEgzME9nZmo5MHpoaUZ3OTNj?=
 =?utf-8?B?U3k2dUpKd1pYTGVuaWF5V2V5bnBiWmE5K01TWDhpLzZhcjhPTkJkWFlLaHNT?=
 =?utf-8?B?eDIrbkIxT3lneGRmdEVvZjVIVWc3VkE2RXA1MnlPeFF4L3dmcnNQZFRFaTJZ?=
 =?utf-8?B?L3dOWW1mVW5NcitXUkthZ3AzNU9oSW0rdkYzR2JseFhYQ2dkTlZkeVA0QStn?=
 =?utf-8?B?UUJvQjBDanUycEN5cGljclR4NFdSYTY1cVFVY2Jad1RpUEdHK3NVZXJMNTY0?=
 =?utf-8?B?WXpvc3Z3UnplaHdYRGhTTG05bHRPSnA3cFlzV2syZ2xyU2ZyY0k2bmdHazZR?=
 =?utf-8?B?OXVGdzRWbmZGcGtKSkh4R1hEOVkrbitIWlRBa2MwbVZjdUpKK3NJRHFlN0hN?=
 =?utf-8?B?bHVQQ3ZJWHB5UEx0amF1WndIUjlYdDFDZnNqQ29CazhRMkVHRjBzaFNhNnpM?=
 =?utf-8?B?NDNjNEJnVmtlSGxSd05BYlI1WHJuVC9NOWpwdndwUlpTdmhtT002R0dMRnVR?=
 =?utf-8?B?NENVaWxIVzJWZGorcnhLMnRkZ1hrUXlSVVF2d2dibTM2b292RGZSenJFSmln?=
 =?utf-8?B?VS9mclJrWkRJYUExaS9ISm94ME1kMVpiYkpFSTJPM3YvWGVDR3czTDhPaE9l?=
 =?utf-8?B?eWRtdGl3cEJhWFNjYU9SUytmaVFNTkswdTRVeXhpSHNvOW02ZHpTODNSK2Jh?=
 =?utf-8?Q?sfPmagmEcEYPU84PygXwZswSnU0PgUI9lQqtj5lkSuCT?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d930aba1-4660-46a0-4232-08dbe8f2dc74
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2023 11:29:58.6139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eV2C1C7sztmUDgEK4ed97WIHODYy1mx1DfVrh/+V7LuqpBvI9s5+wylvkofE8G5JWL4qpmzpp/zPe6w5WdEH2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB1060
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbmdlcyBpbiB2NDoKCi0gYWRkIGNvbW1lbnQgZm9yIGZ1bmN0aW9uIHVhcnRfc2V0X3JzNDg1
X2dwaW9zIGFmdGVyIGhpbnQgZnJvbSBIdWdvCi0gY29ycmVjdCBjb21taXQgbWVzc2FnZSBhcyBw
b2ludGVkIG91dCBieSBIdWdvCi0gcmVwaHJhc2UgY29tbWl0IG1lc3NhZ2VzCi0gYWRkIHBhdGNo
IDcgYWZ0ZXIgZGlzY3Vzc2lvbiB3aXRoIElscG8KCkNoYW5nZXMgaW4gdjMKLSBEcm9wIHBhdGNo
ICJHZXQgcmlkIG9mIHVzZWxlc3Mgd3JhcHBlciBwbDAxMV9nZXRfcnM0ODVfbW9kZSgpIiBhcwog
IHJlcXVlc3RlZCBieSBHcmVnCgpDaGFuZ2VzIGluIHYyOgotIGFkZCBtaXNzaW5nICdGaXhlcycg
dGFncyBhcyByZXF1ZXN0ZWQgYnkgR3JlZwotIGNvcnJlY3RlZCBhIHR5cG8gYXMgcG9pbnRlZCBv
dXQgYnkgSHVnbwotIGZpeCBpc3N1ZSBpbiBpbXggZHJpdmVyIGluIHRoZSBzZXJpYWwgY29yZSBh
cyBzdWdnZXN0ZWQgYnkgVXdlCi0gcGFydGx5IHJlcGhyYXNlIHNvbWUgY29tbWl0IG1lc3NhZ2Vz
Ci0gYWRkIHBhdGNoIDcKCkxpbm8gU2FuZmlsaXBwbyAoNyk6CiAgc2VyaWFsOiBEbyBub3QgaG9s
ZCB0aGUgcG9ydCBsb2NrIHdoZW4gc2V0dGluZyByeC1kdXJpbmctdHggR1BJTwogIHNlcmlhbDog
Y29yZTogc2V0IG1pc3Npbmcgc3VwcG9ydGVkIGZsYWcgZm9yIFJYIGR1cmluZyBUWCBHUElPCiAg
c2VyaWFsOiBjb3JlOiBmaXggc2FuaXRpemluZyBjaGVjayBmb3IgUlRTIHNldHRpbmdzCiAgc2Vy
aWFsOiBjb3JlOiBtYWtlIHN1cmUgUlM0ODUgY2Fubm90IGJlIGVuYWJsZWQgd2hlbiBpdCBpcyBu
b3QKICAgIHN1cHBvcnRlZAogIHNlcmlhbDogY29yZSwgaW14OiBkbyBub3Qgc2V0IFJTNDg1IGVu
YWJsZWQgaWYgaXQgaXMgbm90IHN1cHBvcnRlZAogIHNlcmlhbDogb21hcDogZG8gbm90IG92ZXJy
aWRlIHNldHRpbmdzIGZvciBSUzQ4NSBzdXBwb3J0CiAgc2VyaWFsOiA4MjUwX2V4YXI6IFNldCBt
aXNzaW5nIHJzNDg1X3N1cHBvcnRlZCBmbGFnCgogZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1
MF9leGFyLmMgfCAgNSArLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9pbXguYyAgICAgICAgICAgIHwg
IDggLS0tLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9vbWFwLXNlcmlhbC5jICAgIHwgIDggKystLS0K
IGRyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jICAgIHwgNTMgKysrKysrKysrKysrKysr
KysrKysrLS0tLS0tLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9zdG0zMi11c2FydC5jICAgIHwgIDUg
Ky0tCiA1IGZpbGVzIGNoYW5nZWQsIDQ2IGluc2VydGlvbnMoKyksIDMzIGRlbGV0aW9ucygtKQoK
CmJhc2UtY29tbWl0OiBiODVlYTk1ZDA4NjQ3MWFmYjRhZDA2MjAxMmE0ZDczY2QzMjhmYTg2Ci0t
IAoyLjQyLjAKCg==
