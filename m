Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DE3770555
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbjHDPzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjHDPzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:55:10 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9833F170F;
        Fri,  4 Aug 2023 08:55:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9lEK7bs24lQZf7EHSWJfrWFfozvGGxZR+1n2n4Wr7WKOEFdeLUakJy0ATKjqSRuJanW1ItkI/MNErMpbChUmSVBM2tCnPmL4fIupDn6D6FhGQWeCszAB5/eOidqhpnl4IRNkIrk3bGxHjVbqAFetCMhf70Hj0lWwG/wRrNBD5tw/GuKnJykn68bZWLP+/WPaB0TQS2stv/+F2Lf3UrbcvAK4xi0mb5aEbH8JEdFk9NjiNS+UZSXZ7BmSrbr9nek9TrorCglIJ9ZNcqtxqvJSrxSr9ID6o7sO60++CDGnl01+6jRBae4z+paHWxw5EaWEhONH+gSYDbIaKrXTYvuLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIDjbRCA4FLCPboIWW35UmCFg28dx1thcEMxDD5rXdU=;
 b=lPIfYy/3o7nlchoRVM0olsRD6ZKJg7qy0xHmvJ/34pAGwrhiJ2UUQtGSTeeRSmgFZhZPoEukvEBFfqkh5URk4PNUheu8XM5Skli5FwrjFiRZVslPAFgZEBW1XxY1R9kcYVegDQu4S1J21HxiigGYoycZzInIRqH9hk4IWGr0MkPTr9nv1c0F9Nz6WZoyyzdb1KCk6F6EIyoiqq9TlB7ua8SvkcHAE0VX1zq/MU4aAdHhh3IZT4+riq97ELjB0GeE8P7j/ef76JIfBnAhsslnHaolPG1VO16cdTssIfLSIgQUOtlaQXiTSK6VApudKZeNO6ETWyLdM4hJQN3B4g5tDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIDjbRCA4FLCPboIWW35UmCFg28dx1thcEMxDD5rXdU=;
 b=P+/KEHRrdB6cC6KS+RO3mGpsFWHJqmnOlE83XSEHOxQKEgP/BF8WD7rw9+ie1Yqxejl+N/zA/OtyG01tpw8ANmW/BeuQ0pWBat0oc7ajEhqMBKSxHNilJ44TaxqS21L1H4pcti6/goBWwBVFegDDaiGSnvMncSQcQofaqIEAgbh2TsEfqOG89aOAVcMBgmWV0ZORyHlT1FfddGdnNjnG62ERyLqsPOGf5qsDrbwzrh2Qq2k8HWYaPPTm+QY+WaurUbdBQyvWXEYFZudvRjRFEBI0tNjy+k1nUbQvlHacgklrRX0iTJrUCkVkbCc1Q07PIvxwaAAHbBrI327J6P6GFg==
Received: from DM6PR12MB3371.namprd12.prod.outlook.com (2603:10b6:5:116::27)
 by MW6PR12MB7070.namprd12.prod.outlook.com (2603:10b6:303:238::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 15:55:07 +0000
Received: from DM6PR12MB3371.namprd12.prod.outlook.com
 ([fe80::ed2:99a4:2e77:89bc]) by DM6PR12MB3371.namprd12.prod.outlook.com
 ([fe80::ed2:99a4:2e77:89bc%5]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 15:55:07 +0000
From:   Jeshua Smith <jeshuas@nvidia.com>
To:     "keescook@chromium.org" <keescook@chromium.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "gpiccoli@igalia.com" <gpiccoli@igalia.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: RE: [PATCH V2] ACPI: APEI: Use ERST timeout for slow devices
Thread-Topic: [PATCH V2] ACPI: APEI: Use ERST timeout for slow devices
Thread-Index: AQHZtREytrmSwIEvT06Ibqr95x6guq/abXNg
Date:   Fri, 4 Aug 2023 15:55:07 +0000
Message-ID: <DM6PR12MB3371BA50E3B76D2266273901DB09A@DM6PR12MB3371.namprd12.prod.outlook.com>
References: <20230712223448.145079-1-jeshuas@nvidia.com>
In-Reply-To: <20230712223448.145079-1-jeshuas@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3371:EE_|MW6PR12MB7070:EE_
x-ms-office365-filtering-correlation-id: 4c7722b3-d84e-42b6-ece4-08db95032ce5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xXV8IanphENRpTPNOzOl/xnNo8W0245Q7pXT7ZS35rc17y7V5l4AD2vy6jY3j+jrnw9xOGSrydNTtcI8RjUzbgNdV73CvnaKMJe4JIHw0z0Y+avGi9dg3N+wQakLYzy9j3poU55oeusHCBundlaPX/ZsKe/QOniU6Op9daIpy8DPg+xfgj2Q7tCi5RFModuv0bDvrUzeJlhuAIhS6OowGuWgf1aDARK9LPKTY8nqUxZBsTnVLaJ5ERgQeKGGTlnsS60xStb530au9o9QRZ3nmubQ2i+ns1+QT+W2AJjWsgau70FgrIhl2W/9ewm74KjI47iQNylgD//8J6wHWp2nrTSH0zDkUNE4+aAG60MrxDpFCtXyyF9NJzKPwBgKjyU6O6pUHHYONzI34FlQXqCpY803PLE5l/FVDqpKlMylZSfvGWoxvZlFaf6Hlgyyh2wMnQyte+ndEpfgcvzJxl0mvy1HVcafMFadeUKjlcjcaljxWSJMBZW6cHJRp0/r56TupiDW4t0sW56WNtBTBHJ06kC08PhT6uyOk/xfr4uBQC3fxzjiubooX6eqHZrHLckaHglDudlT+ijw7yF3Lb34MyCE5C5bJq0oaXHtUrpGpaLzTQcYOY7sdWU0vOGqvuRl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3371.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(186006)(451199021)(1800799003)(52536014)(66476007)(66946007)(66446008)(66556008)(64756008)(4326008)(76116006)(2906002)(122000001)(38100700002)(38070700005)(53546011)(6506007)(7416002)(83380400001)(54906003)(110136005)(55016003)(86362001)(9686003)(26005)(107886003)(478600001)(7696005)(33656002)(71200400001)(8936002)(8676002)(5660300002)(41300700001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?s7CgU3IFc7DVj3pnqqOxAQWMT1UcOOgaYARxd9q1vTrvK+C73+WGfRvGss8g?=
 =?us-ascii?Q?LHWGHGghtRiffDX0jxHpuR/huVpIbaFhHNMMIFB+eAkN+3KNbY0tFfuNvFaG?=
 =?us-ascii?Q?liRQwLb6g+Rh4UNfUhA4MbTDw7Py3rKY7/QA8Qrj66bM6o0qdDyCltIo2vgi?=
 =?us-ascii?Q?BOU95TcuQGx3oT0xlATakXzcbrGKLcpU2rpGjHTvbFJkBTyNBM8mBck8UmPf?=
 =?us-ascii?Q?0rJBFrly+GDlQ5tlR2ohzL1c/X6T+RJ57T2LbIduls+hUueoGIkoMCM+iIux?=
 =?us-ascii?Q?gUEN+Oe/R50eygvLSHrBXscbDbKboXFk49UgXA7KsTnkUHV5jK2E257xrUCi?=
 =?us-ascii?Q?v/YukBcAkMKSdknyVZ7S18RWEDfHJMl7571dOZz5NAVOC5oMYp44B9BL25n+?=
 =?us-ascii?Q?cStou0EV4qKcBglC/exT+iMCogc2USvwjPDC0+Tc/YflDroWKBivgFnWSWJm?=
 =?us-ascii?Q?6pVXiB5zA0/WquPsI69EF5pKcwfppgUUw444DQfSDQ4oSD+aT6+uL31gFxT2?=
 =?us-ascii?Q?ZHiBTmAo4owJ3dScuqKXx6x6ewtqgtH768PlyPDw2bdiZ9ZZOAsvSZu/jwvd?=
 =?us-ascii?Q?dsAZUf9kXXHgxnUuc4fPavLVRHIoq0ITrfSGLo7vKMj9xlVSOkj1scOIE/L1?=
 =?us-ascii?Q?9R9F9TmysleNzQR+XpIETBazpKJX8d7sM4ycWr4tDb2gocTU1o+Bu+s+5NAW?=
 =?us-ascii?Q?EBrUEB5LiRCBImoWCIKTJhiumVTjABGSyNQX6rp/p/KlxZmrnDWymZYF+A4X?=
 =?us-ascii?Q?F9XZjfhTbM/IfAnQQaAHyd6A2fHTzMZ+eL5nD4xoiqpMKba9TpSiUtEKf0yT?=
 =?us-ascii?Q?X6nqnCgklBtvjuxEh7MMPBxIif7OnV2B0zuX3Mlriw/DT3cmJLmFrNuHmD5K?=
 =?us-ascii?Q?U4UPKXaW5QQMqF7L9huFHgD1GMo11nWSE9lh7d+5IemTCBflehJdRTouMPuY?=
 =?us-ascii?Q?hu+g+PH/K2+tC8pLZ6Xqtog/pqKM/8re/JF1B/7N78f+M/aDt7Ct1TaWy1i7?=
 =?us-ascii?Q?iT0HRZKMAqbb5epMALbwt1Hncncm0+g/bg9BX2oOuoh/rIwut08bImompRh6?=
 =?us-ascii?Q?JZGIK69kdD4SUVnigM5sEfFUqgtD/oMWGWkBBirESt5j1Qq5aU5fUlpSslGn?=
 =?us-ascii?Q?khxmJe8WWT8aw+uoTyJpZxn8Rt1FAieFWs08YKJT4sAkhoGZz/TnguUtEpKy?=
 =?us-ascii?Q?RB6lG1o486h7uA2FpcvgKtUTLsAghY10ymXIMh4ahgdAMwpIW5iqh2ghstSZ?=
 =?us-ascii?Q?kj6tby7m4sgKRX1+trYO8Iegegzbi13JGgOSM5wweKC7R3Qmn4xgEnZe+5k8?=
 =?us-ascii?Q?6cqo57pB8f1oc2nzsW1AGnC8qeUYpyU8xiKXrEYyh3Gv2BXPDI/FNhStXUjE?=
 =?us-ascii?Q?4p5xP5OjFNFBrTdBHv9Qy1KiKyjgaggz1e5uYcwxfwwIa0ueABfQDshwmEON?=
 =?us-ascii?Q?umj8KVzdDPuYDa3UnZCfT3K8B+mwTFPNoFTK1POd5mr/8jF3kIc9ztXvKwT/?=
 =?us-ascii?Q?Lqa5DqixnRS0AZTybrcW1uA9QmwJZPjt/N82Eq85w0dv75PZIT12KuaS7vNF?=
 =?us-ascii?Q?7r6z6Pqsaab8QLE0teG/DR50lQ1kgtdQQCXOGJ/J?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3371.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c7722b3-d84e-42b6-ece4-08db95032ce5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 15:55:07.3473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: giQzM9foSVaqRUkpSRyZv2j4bvKFxZCiqiFJyCa26WrIjL9LfSSaABa6DHo1UiXGSEtFgOVsGBKBut6lkTVMCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7070
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can the maintainers please respond to my patch?

-----Original Message-----
From: Jeshua Smith <jeshuas@nvidia.com>=20
Sent: Wednesday, July 12, 2023 4:35 PM
To: keescook@chromium.org; tony.luck@intel.com; gpiccoli@igalia.com; rafael=
@kernel.org; lenb@kernel.org; james.morse@arm.com; bp@alien8.de
Cc: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-hardeni=
ng@vger.kernel.org; linux-tegra@vger.kernel.org; Thierry Reding <treding@nv=
idia.com>; Jonathan Hunter <jonathanh@nvidia.com>; Jeshua Smith <jeshuas@nv=
idia.com>
Subject: [PATCH V2] ACPI: APEI: Use ERST timeout for slow devices

Slow devices such as flash may not meet the default 1ms timeout value, so u=
se the ERST max execution time value that they provide as the timeout if it=
 is larger.

Signed-off-by: Jeshua Smith <jeshuas@nvidia.com>
---
v2:
* no longer add copyright.
* no longer add unused ERST_EXEC_TIMING_TYPICAL defines.
* set timings to 0 if the ACPI_ERST_EXECUTE_TIMINGS operation isn't support=
ed,
  which will result in the default timeout being used.

 drivers/acpi/apei/erst.c | 41 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c index 2479=
89060e29..bf65e3461531 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -59,6 +59,10 @@ static struct acpi_table_erst *erst_tab;
 #define ERST_RANGE_NVRAM	0x0002
 #define ERST_RANGE_SLOW		0x0004
=20
+/* ERST Exec max timings */
+#define ERST_EXEC_TIMING_MAX_MASK      0xFFFFFFFF00000000
+#define ERST_EXEC_TIMING_MAX_SHIFT     32
+
 /*
  * ERST Error Log Address Range, used as buffer for reading/writing
  * error records.
@@ -68,6 +72,7 @@ static struct erst_erange {
 	u64 size;
 	void __iomem *vaddr;
 	u32 attr;
+	u64 timings;
 } erst_erange;
=20
 /*
@@ -97,6 +102,19 @@ static inline int erst_errno(int command_status)
 	}
 }
=20
+static inline u64 erst_get_timeout(void) {
+	u64 timeout =3D FIRMWARE_TIMEOUT;
+
+	if (erst_erange.attr & ERST_RANGE_SLOW) {
+		timeout =3D ((erst_erange.timings & ERST_EXEC_TIMING_MAX_MASK) >>
+			ERST_EXEC_TIMING_MAX_SHIFT) * NSEC_PER_MSEC;
+		if (timeout < FIRMWARE_TIMEOUT)
+			timeout =3D FIRMWARE_TIMEOUT;
+	}
+	return timeout;
+}
+
 static int erst_timedout(u64 *t, u64 spin_unit)  {
 	if ((s64)*t < spin_unit) {
@@ -191,9 +209,11 @@ static int erst_exec_stall_while_true(struct apei_exec=
_context *ctx,  {
 	int rc;
 	u64 val;
-	u64 timeout =3D FIRMWARE_TIMEOUT;
+	u64 timeout;
 	u64 stall_time;
=20
+	timeout =3D erst_get_timeout();
+
 	if (ctx->var1 > FIRMWARE_MAX_STALL) {
 		if (!in_nmi())
 			pr_warn(FW_WARN
@@ -389,6 +409,13 @@ static int erst_get_erange(struct erst_erange *range)
 	if (rc)
 		return rc;
 	range->attr =3D apei_exec_ctx_get_output(&ctx);
+	rc =3D apei_exec_run(&ctx, ACPI_ERST_EXECUTE_TIMINGS);
+	if (rc =3D=3D 0)
+		range->timings =3D apei_exec_ctx_get_output(&ctx);
+	else if (rc =3D=3D -ENOENT)
+		range->timings =3D 0;
+	else
+		return rc;
=20
 	return 0;
 }
@@ -621,10 +648,12 @@ EXPORT_SYMBOL_GPL(erst_get_record_id_end);
 static int __erst_write_to_storage(u64 offset)  {
 	struct apei_exec_context ctx;
-	u64 timeout =3D FIRMWARE_TIMEOUT;
+	u64 timeout;
 	u64 val;
 	int rc;
=20
+	timeout =3D erst_get_timeout();
+
 	erst_exec_ctx_init(&ctx);
 	rc =3D apei_exec_run_optional(&ctx, ACPI_ERST_BEGIN_WRITE);
 	if (rc)
@@ -660,10 +689,12 @@ static int __erst_write_to_storage(u64 offset)  stati=
c int __erst_read_from_storage(u64 record_id, u64 offset)  {
 	struct apei_exec_context ctx;
-	u64 timeout =3D FIRMWARE_TIMEOUT;
+	u64 timeout;
 	u64 val;
 	int rc;
=20
+	timeout =3D erst_get_timeout();
+
 	erst_exec_ctx_init(&ctx);
 	rc =3D apei_exec_run_optional(&ctx, ACPI_ERST_BEGIN_READ);
 	if (rc)
@@ -703,10 +734,12 @@ static int __erst_read_from_storage(u64 record_id, u6=
4 offset)  static int __erst_clear_from_storage(u64 record_id)  {
 	struct apei_exec_context ctx;
-	u64 timeout =3D FIRMWARE_TIMEOUT;
+	u64 timeout;
 	u64 val;
 	int rc;
=20
+	timeout =3D erst_get_timeout();
+
 	erst_exec_ctx_init(&ctx);
 	rc =3D apei_exec_run_optional(&ctx, ACPI_ERST_BEGIN_CLEAR);
 	if (rc)
--
2.25.1

