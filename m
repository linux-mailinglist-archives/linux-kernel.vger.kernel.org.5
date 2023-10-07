Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27C57BC4E1
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 07:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343558AbjJGFqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 01:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbjJGFqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 01:46:45 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2053.outbound.protection.outlook.com [40.92.98.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DC9BB;
        Fri,  6 Oct 2023 22:46:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKDQX8NbTm0mcofOteVKoWaX27glQF5x/Sy6EBF9gDKKUHtfljva79kvoRU+F5kgXi9K6kh4uO1KbGhhMaZDwoUXwzPraILqCmQNqNTh/ZAPC3avA1yAkAPfw9sklxAQUETkIhKFzQ0WZZO1fhL5VEQQ5r1jowwJ1Vdz0Se1s6kusUYIemXU/lPi0XuK9unZigzMhSudOZcBKt/EKh6DyLGgESVfWsywEwqBFx+mv7e/9brn62XgmTa2QpkuSLxDRVB7BIB1QASWNT9UZSmPA9i5jTZHFZdwAzjJT0O/bWmHCHPQC/FTtolTl1GgNciU2hzgnwpXao2tbo0Bg7QM0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rv/pL2fjVNxtis7d5bcRD/9aPvQvl4RWFqlqcKGXFc=;
 b=bHyHaosfKcvyeEnpAMF9RUfApObs1TyrQypehVXmc+KCKLS5jvABlUBdEAbK5KbhL/64xAfqRb2BgpT+cz11UY6vM67IYZVlGoEAJa02VmQIeB8fpxBM3zbmxH+stddPqBmUnmPIimrUWbQVPhRPKaMj3tsryc3WHf1577gt9P+d8qMnvvmav05EghD8R2sntOaFXR296Pa5kF1grEJx751Y7CEHXK6mQdlbzdCzf4+iqBnkH3xlgABjEOdDrC+9lH8+uBYRpX/MUzFpCqA2MlKXgEwciijiogWi7vg10zgj7LkeF781sVX4dL7jDY00FehzVLjoEQIdv+Bsx4l14g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rv/pL2fjVNxtis7d5bcRD/9aPvQvl4RWFqlqcKGXFc=;
 b=b4vbCPUARpeYpSuRfR+TcZkwbfovZhgz2OhIx1cazdvq+tX6lfFjhUk+0YBaSVUhuYiXTDhR/imM6eOhDTVHiwclXmhEaS7R83wUnIK9Ri9m0E9VRxkaO8xvkVfM+q9iTts1dAivr4LIVaq/LwX5NkiWXoMsVsEQF/AsfRVFTX362dKBxejm5Dnu14Q1buYLKLjpOQW9DoCVZ0rhxplKxvxihDafz3+jcYVbbBnJdQho1g+SQgG0ip1GhtgKVAp4MxHdNyVcovcLzrOXMhvat/7xJONZfwKw5ZBhiuKYtTe7N3yXEdGgN4Mq4HuIlTSn0s6otw5e2qfyCUM5fkpHZg==
Received: from TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:158::13)
 by OS3P286MB2711.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1fe::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.35; Sat, 7 Oct
 2023 05:46:41 +0000
Received: from TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 ([fe80::6e83:1720:b996:1f72]) by TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 ([fe80::6e83:1720:b996:1f72%6]) with mapi id 15.20.6863.032; Sat, 7 Oct 2023
 05:46:41 +0000
From:   Peng Liu <pngliu@hotmail.com>
Cc:     lenb@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, liupeng17@lenovo.com
Subject: [PATCH] tools/power turbostat: Fix Bzy_MHz calculation equation
Date:   Sat,  7 Oct 2023 13:46:22 +0800
Message-ID: <TYCP286MB214616F6AE3E088C5D781A2EC6C8A@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [LV7Ejps8Hu+n/JQFxh+TNoEFsB63bNly]
X-ClientProxiedBy: SG2PR04CA0170.apcprd04.prod.outlook.com (2603:1096:4::32)
 To TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:158::13)
X-Microsoft-Original-Message-ID: <20231007054622.54613-1-pngliu@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2146:EE_|OS3P286MB2711:EE_
X-MS-Office365-Filtering-Correlation-Id: 74d0ad0d-0158-42fc-406c-08dbc6f8c754
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: icLPgAKM5V88AYpV9iR3Gs1MyVuZfTvQEQTK4+MD2aS3TFmEKHyISywi4FwxPQfneckKj+YCFoyOx9uykFD5KC4fbDD1mGcYcMe7C3BhOQ6Wp639HQ497/xfgyauE9rBkmrp/h7aKwfabI2OdKByy6v8wzvh+Y4zBMCO9py7HdBGOEmpf8QvicWFM5RSTvtLw3e5gLf38BWe4lDxE7TzmA09hVg+SyeI9ExLjGEAn4XclxxGGg9Xp2/8fXMDzfH5hv7j4CJ5Pw4m5TQPIIOIwpoZbdnlA3JWoIg9aU9hnOmZiwfCAjtjweiqQH3t232HYP9hqeHO0ue30puqt593mBNVPIy7dHqnCkFU38prPLu31TF6q23EJx2uOeQCuS+O5hRZD4zulJ5bQJL+PlQhZ6vmctOSKl85VJNfcNoiPgIW7xsI45cm2OTd77MHp4byPGjWwIXt9ZTaXqACF93QiDiY0e0oLvW9LTvNLrJIO8YRihPk9DRL4ALHmuCkE6DwVjbwUqGpVwi4wZv/uEdPY2Mi3R53HPCHc/IZZ+0YjxfFiJ9DRb9yOZWENA75Icom
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nz6PZkUHqlYdoy0yxkqvii8JySGiiQwCzAYAUQ8FwXQReyGSBaDZAA9PmK4j?=
 =?us-ascii?Q?hRNkfpRvxSod4KJDL7mYrtTlPbxNMf/X3+cWEldjCH2IivWmvTJHcnqSnuqV?=
 =?us-ascii?Q?/3C0muFYcbOcLBZDgmSGRRKmGQaKyrJ5W5UrUPLF0Uuk6Xnn+lYGEy2MxhKI?=
 =?us-ascii?Q?TBMqKtCNOnJI7UoOxzGxHUClrUDXCZR9iUhGxSYIYbRiNUbdnMvtc8vt4TUY?=
 =?us-ascii?Q?1j9ZYe1XBAfoHb6hXRXYsRUGf8D8l/nUBys5yE+FbAnJFKjsLdt/ywOKmnbs?=
 =?us-ascii?Q?31PIcWpBaNY+DY//uZN9vPvbfR46yaPj3B+bQgmCtwkDCe97A7bmf+rn5LVC?=
 =?us-ascii?Q?Ngi2K8CdQ3eqNKQ3Dc+JXaSGOM+ohs3zZUBTJ1eTclgqI4Sv/gU1t4aeuM1T?=
 =?us-ascii?Q?IgQREGVIOtOoKIPWT5TJfmdriBsHi1Li4pKknT/c0dt9ri61b+8PCdcnwCWH?=
 =?us-ascii?Q?12MmOac5x+FrUMQkp1fQoGUoENLJechoL+cXSJb5oeQ6kmTD1dFwn2pphnso?=
 =?us-ascii?Q?YlguhKRYDqKREu/wjBTlbVwhw57df6MzLeHNSrmCbsn8+V3wFIQgZqSJNkjH?=
 =?us-ascii?Q?tWpnTcKq9zaVh3h3XsG0gwa9Mci7C9obOJf0Farqgo75D1zXEonF3Pa2h1oZ?=
 =?us-ascii?Q?b520qz1df13ocQM1E/fNdXCOufkLeWIa6kniAF28jtCiL8lF5nIaXmJG+2rk?=
 =?us-ascii?Q?NOEJ1tAuqNTdZ9D/pE9+KkwLCGQn5gJpTDgonH7hb2I1CE2pGEmN27TOM8or?=
 =?us-ascii?Q?uB8ZKt3ksEeN1wDyTaMuzjkX2wqYtzpAy0ksj5u5Y2y/qYryVjIy2lCGidF9?=
 =?us-ascii?Q?YYWfkQO6GgU11lFC2BFmh5PjQxA7WU/r0L3xQRTWh70hxndCB1F7iaHL/xue?=
 =?us-ascii?Q?gdNArTWG4Q6rhH1lvBuBaydjcvfn5ZPSj9Eu6lBcE6vqd8W56rrZvnDmFGE7?=
 =?us-ascii?Q?DDgjrN2biNG3zUVrpxZyYX+N9IQVmi8xRU6BR8aEpfFv0XBml995Nckw3SVD?=
 =?us-ascii?Q?Sa4R9n3DO0iRh1dIYF/G+sIscAAA5DnvULSgyZn1H+YhlM7gb2gqeamZ+fwP?=
 =?us-ascii?Q?x/rXlB2DUcTHJaTl8h4HG2nJXH2vbjSvwCdyYljKquoWerXovp2nVhA3nan8?=
 =?us-ascii?Q?mtQ/UsdXoWvK7GzR/g4fP4rr0PuwK8u8NLLNML6psxGH+yETwXZZfv+u5jG+?=
 =?us-ascii?Q?+YyzZu5wp2Wsa0hMaN9CnJkFhN7qFyfGOTMTdw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d0ad0d-0158-42fc-406c-08dbc6f8c754
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 05:46:41.4400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2711
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Liu <liupeng17@lenovo.com>

To calculate Bzy_MHz, TSC_delta should multiply APERF_delta instead
of dividing it.

Signed-off-by: Peng Liu <liupeng17@lenovo.com>
---
 tools/power/x86/turbostat/turbostat.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index 8f08c3fd498d..1ba6340d3b3d 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -370,7 +370,7 @@ below the processor's base frequency.
 
 Busy% = MPERF_delta/TSC_delta
 
-Bzy_MHz = TSC_delta/APERF_delta/MPERF_delta/measurement_interval
+Bzy_MHz = TSC_delta*APERF_delta/MPERF_delta/measurement_interval
 
 Note that these calculations depend on TSC_delta, so they
 are not reliable during intervals when TSC_MHz is not running at the base frequency.
-- 
2.34.1

