Return-Path: <linux-kernel+bounces-160481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 480728B3E14
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00CA028934B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A71E1802CA;
	Fri, 26 Apr 2024 17:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="jaAhSWul"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04olkn2041.outbound.protection.outlook.com [40.92.74.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176D417F384;
	Fri, 26 Apr 2024 17:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.74.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714152195; cv=fail; b=CNs2cobhpHqW25IFB9cLlmVTZmkXha0vc2bGglQcmfbBe5GNd6J0eo0F+/wgzjJYhH8ZL7lZySLu41/RBlqqkHveU/jYvZwMCa+TTFhSjgXIQ1dRARVpssyCrA54cKmYV+BW85u8GDMZvLlH6eTfFD42WDTw3e3jgm+QFQPXkIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714152195; c=relaxed/simple;
	bh=iudRaaIS67dlRO4nUDe9jgE4mVWzmuVIrw11dOl0TUA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ltEjiU2dXpSUyNFBhjEuQY7jzD9I+VT0vVPSby6KRjCFBeaqty8nkEOXzwTF5CDFTwdLL0tMBX0Xj7cg+Y/z1UPQNpwxG6eummma1aPmKVvbaJLklcN6nxYn7fBznmUDVz3suC8l5K4mV0T3xRkhDGIev69lVjDnN2jRR5Ia83U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=jaAhSWul; arc=fail smtp.client-ip=40.92.74.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRptDGstk+NkpR/E8ENhw3olDLL4nWUtcdUcmJ+XNWT+7NuOJofqwfbRMW6rpisHBOgb9WXJ2+csx9AoDHOOjMTUcp/F6h8GsHzoh/249lt8lB7iP9QDVGiWNFVZcyQa5V4BeFArBAdKoPARTmHFtwRJsyRN4YZNyxR4jeyYSnZ2hhva4Tq+X9tIa6phEER9HHkuItT5SLkxhmnaf1AWac4loG1iMSghHBdyutGooDucMY8WTrV/UqEyd9ICUdOManIAvbV6zIMXhFjnsnlGCJ1BaGCp0rNh0OTmQYRVBD4MYCdEF+WxwwW1wOV1i5wVRNmaFP4Wxsc4gO7UDUbCLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65Yc1y4uvrPYju/Iqust+aNE2j+zZuMT/pa+4v+q7BM=;
 b=Al69cfdscoPyFIa2ceiKbaKyA6JlToMAEav9gHlltapDENHEsacJU5hqT3ZUFSJlrFl43cL95qKoyietVQ7SM+c0sV6EZskSFmOwcGpbpsbwNCD9A+3rqduwWneB3Gdb2SjiRX+Se9bXfgmpHscqPSgu2FbGWGXlswv9yDapEc7dfirFXm8UOlmeWJwrTymyukjptTOI25dSDS4qpcKoIEHFX1k0pnmJP31W3bLQ/vXdrcK756GhiQrGVoEENkqcMDYGxBvLHORJfzuhMBogBMcddaqsl5+mWxGz4d7cyYuy86Na+4okws1aZFjf+IYEzInmyzVY81YCBYlDK+EGag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65Yc1y4uvrPYju/Iqust+aNE2j+zZuMT/pa+4v+q7BM=;
 b=jaAhSWulP4JBxL4TfG3rMdBuXNES+7oZ75VeOpnsLySjhodA6brjqdJGhj9JWYBO0h/OAZKB+JPh9s2Ifdq4+9bJwxBJ+G0+8dVdEQfPZf5Rto8FO6ngpDPcxsZiAjlsTF4zco/4k7+8haE174y6T7DMULkG5WIG1I5j5NJTLScs4td6+3dFoo2VMzaOEiwTJRr2gf4zw9bWmegs4srlc+fn5ufDR5hgHzv393KLe/QGPo5LwjGr0tshEWY5Wgp21MZmxDTAHLGEQtNPw69jkPmj/FNcmstRE+idJy/eXCYKw2Zxhto2upZVsEkBfgVxBrCA1ZmqOoJAvtFu42DwlQ==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by PAXPR02MB7799.eurprd02.prod.outlook.com (2603:10a6:102:220::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23; Fri, 26 Apr
 2024 17:23:09 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7472.045; Fri, 26 Apr 2024
 17:23:09 +0000
From: Erick Archer <erick.archer@outlook.com>
To: Marek Lindner <mareklindner@neomailbox.ch>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <a@unstable.cc>,
	Sven Eckelmann <sven@narfation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Erick Archer <erick.archer@outlook.com>,
	b.a.t.m.a.n@lists.open-mesh.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2] batman-adv: Add flex array to struct batadv_tvlv_tt_data
Date: Fri, 26 Apr 2024 19:22:47 +0200
Message-ID:
 <AS8PR02MB723756E3D1366C4E8FCD14BF8B162@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [ZKALE+CcnBE5Mjctco2WLv7KCWHKlbRr]
X-ClientProxiedBy: MA3P292CA0010.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2c::12) To AS8PR02MB7237.eurprd02.prod.outlook.com
 (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240426172247.17025-1-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|PAXPR02MB7799:EE_
X-MS-Office365-Filtering-Correlation-Id: a70a962e-1970-4ca3-e564-08dc66158a7b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|1602099003|3412199016|440099019|1710799017;
X-Microsoft-Antispam-Message-Info:
	frKMW5OtkMJkmDUhov9yQnSPB68OSXWcJNqkaSdNchpquIAIhhwslF16XhvjpLKyEhcsPoFw/cpAf7K0DWserM2TZK5DvVc0p+c7OpjC6oUZosX2AopVezfk8YEEwa2LQsNc/K+nqy0bDOoB5S7cY7ymjaYDzdMkLuaP3PHpstAFfkd8AWG9qF8VJtZ37ToUtqKKCgXz+MTdwX/R6FzA3g+n/051ZayFne0ZY6wWScdiPSkKSt6uzvxsBFmIQ37pojY1DiCTCtg/oE9GMSal51mAfN1+2p0Z4mtyyp+B3PtOxu3MBtRxkTRUzXG7V/3ALSV0SjBe8AdJk8LXklUM0k2+9+1EysPrNGMTx5DPKq35j8RWe8je+bq9GTNmfiqIk1ZrnmT+dvSkaOq3Bwx9+nDi2ZskXy8HnbX0cMDXoBzad2e+ySuLkpsw0DSMCOdaqdhbrXGvCfECti/E3e+9ofmucAbRykJ5KE1kQq5F9V+WYXhQZQ3s36LqapAGJPkjCiEwDMfuagpqC5rJmroyEYs2YQpdgyaCw860KYeel/sz0wLowPFb/R+zv7F93j4DsI4V3XbdsWP+1/q5WS4AuaQVPLSlxLRNPcBdsv3zYZZ3s0t1+0DsNFkFQ/38Wb1OUg72d8e8eMTsvi8kG3f/QkGSHv95TwFshaYaqXDek3Iprfsg8LqxDMp/gn4rBJ/O+z+fv30U6V52jxQ1Aa0GKw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5WxEpzbjp4OPiV8jHYWKKdMJS+qYF/M8OqXYS8CjsPtRkKE7ZE000+Ksjgn8?=
 =?us-ascii?Q?GIXXWvUyNcQKOihiUqg34/zmrkYMSc+sqYNkgBmWiSvDC1iQoEcckg77MFrN?=
 =?us-ascii?Q?2JJIqN9m1eW6DzOhBrNYsThgWM9Gc5SdGaRxtKaWWVU8i6fM+mwFmq+cLC6/?=
 =?us-ascii?Q?sqqM9qwNB8pZI+mCvLzZo2sJYEWWkOjd61zYGuEFLsjgsiY6Qp04dpf7QpQo?=
 =?us-ascii?Q?IYasBwSb5hVMP3Ivz2/AAvMjRGIvNjcQy2ntAC9b9S5n/f1izu78LU6Nb9v4?=
 =?us-ascii?Q?Nd2OF66cWq9WbKTNc/RWZ2dQC1YzYsqfzvr8nH/6eU+RQujdNCy3yFOrubsp?=
 =?us-ascii?Q?GogvZX3ggvdGiq7tdUFoszyRJX4hQG+h6Y3FNMFnFit9KLP7r7iJ9Mq1RA8J?=
 =?us-ascii?Q?6tVpzqmZ511IlUk/ecV0Fjkyad9Gx4w06hySmWf9PbwsGkuDRIJnu2y+td7e?=
 =?us-ascii?Q?rT7lnfZpSDdNL0X5zUp1rOFClD9b/8nH1qXUgoR8gnJeX5/9AmWtLZlAFhfl?=
 =?us-ascii?Q?iOiFxcpyZysP93184pkLPNVKvVAMZWAJy0dKGsHADxJmoE1pDjZsL08QQ2iS?=
 =?us-ascii?Q?QZXXzmSus5wm/CYqBeCRVLTcLQFpupK30hPD5U92GTBrqsTtpjDXbO2xvDh9?=
 =?us-ascii?Q?Q7KIcnqjQQc9rKJCRG7F+61rRMSAGyreHHz+iIqzmLOhC1Pt9vmZtpyyNz1v?=
 =?us-ascii?Q?npFxEQB/ZRzExRauj0tdBT6CBga5KtaoPVvLLClLBP0OZyHuXr+3OetpNV8O?=
 =?us-ascii?Q?0h449B8VNm2hNCb55CeFEh9Y3J897G8qx4/LoO84+3GCgaIOyNXvDl4llqNb?=
 =?us-ascii?Q?ZNzu7JIZf4bUsKdMFEXuI/El45c9b8ZBv1Qj0hJ0biyRIgMlIcWyaRi0o87L?=
 =?us-ascii?Q?zL/LNwqW6amelzwfF+1/wf5zrfXFiCSl3tfWwV1290r4gBsKR2+mOhFaHO7L?=
 =?us-ascii?Q?uNxCxSNKXl3qa0qJf4s9GKZNKUpzLlUzK/mmIAAs19K57qrSmoqxmaFieaJM?=
 =?us-ascii?Q?HptCcF3dpGB0yL72WkzMKpllu8/X7hPIGqhRxzQQ7pOdcdXX2toVE4byEY0x?=
 =?us-ascii?Q?a0u/8jUiMZR1gpFaFzZybquqNrRx9qeAPkHhS9bi2dpr18GnzGc+Izl/UYLL?=
 =?us-ascii?Q?ApfQGJlXGIFAw9ImohcpRmQFU8Uzx5SkVywsQKtp+hl8oYcu2i4S0y4cf2AS?=
 =?us-ascii?Q?UzyzjwB5YdfNgUl5HeBjNpRO+fXoDtEFcA+FII68EZzStc5NYIEkXVnReyjR?=
 =?us-ascii?Q?mUmAQM7RSp7+tW9qSOHB?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a70a962e-1970-4ca3-e564-08dc66158a7b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 17:23:09.1555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR02MB7799

The "struct batadv_tvlv_tt_data" uses a dynamically sized set of
trailing elements. Specifically, it uses an array of structures of type
"batadv_tvlv_tt_vlan_data". So, use the preferred way in the kernel
declaring a flexible array [1].

At the same time, prepare for the coming implementation by GCC and Clang
of the __counted_by attribute. Flexible array members annotated with
__counted_by can have their accesses bounds-checked at run-time via
CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE (for
strcpy/memcpy-family functions). In this case, it is important to note
that the attribute used is specifically __counted_by_be since variable
"num_vlan" is of type __be16.

The order in which the structure batadv_tvlv_tt_data and the structure
batadv_tvlv_tt_vlan_data are defined must be swap to avoid an incomplete
type error.

Also, avoid the open-coded arithmetic in memory allocator functions [2]
using the "struct_size" macro and use the "flex_array_size" helper to
clarify some calculations, when possible.

Moreover, the new structure member also allow us to avoid the open-coded
arithmetic on pointers in some situations. Take advantage of this.

This code was detected with the help of Coccinelle, and audited and
modified manually.

Link: https://www.kernel.org/doc/html/next/process/deprecated.html#zero-length-and-one-element-arrays [1]
Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]
Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
Changes in v2:
- Add the #include of <linux/overflow.h> for the "flex_array_size"
  helper (Sven Eckelmann).
- Add the "ntohs" function to the "flex_array_size" helper removed
  by mistake during the conversion (Sven Eckelmann).
- Add the "__counted_by_be" attribute.

Previous versions:
v1 -> https://lore.kernel.org/linux-hardening/AS8PR02MB7237987BF9DFCA030B330F658B3E2@AS8PR02MB7237.eurprd02.prod.outlook.com/

Hi,

In this version I have worked on the "sparse" warnings. The difference
in "sparse" warnings before and after this patch is as follows:

net/batman-adv/translation-table.c:534:21: warning: using sizeof on a flexible structure
net/batman-adv/translation-table.c:819:25: warning: expression using sizeof(void)
net/batman-adv/translation-table.c:819:25: warning: using sizeof on a flexible structure
net/batman-adv/translation-table.c:819:25: warning: expression using sizeof(void)
net/batman-adv/translation-table.c:819:25: warning: using sizeof on a flexible structure
net/batman-adv/translation-table.c:819:25: warning: expression using sizeof(void)
net/batman-adv/translation-table.c:898:25: warning: expression using sizeof(void)
net/batman-adv/translation-table.c:898:25: warning: using sizeof on a flexible structure
net/batman-adv/translation-table.c:898:25: warning: expression using sizeof(void)
net/batman-adv/translation-table.c:898:25: warning: using sizeof on a flexible structure
net/batman-adv/translation-table.c:898:25: warning: expression using sizeof(void)
net/batman-adv/translation-table.c:2892:16: warning: expression using sizeof(void)
net/batman-adv/translation-table.c:2892:16: warning: using sizeof on a flexible structure
net/batman-adv/translation-table.c:2892:16: warning: expression using sizeof(void)
net/batman-adv/translation-table.c:2892:16: warning: using sizeof on a flexible structure
net/batman-adv/translation-table.c:2892:16: warning: expression using sizeof(void)
net/batman-adv/translation-table.c:3338:21: warning: expression using sizeof(void)
net/batman-adv/translation-table.c:3338:21: warning: using sizeof on a flexible structure
net/batman-adv/translation-table.c:3338:21: warning: expression using sizeof(void)
net/batman-adv/translation-table.c:3338:21: warning: using sizeof on a flexible structure
net/batman-adv/translation-table.c:3338:21: warning: expression using sizeof(void)
net/batman-adv/translation-table.c:3942:30: warning: using sizeof on a flexible structure
net/batman-adv/translation-table.c:3946:27: warning: using sizeof on a flexible structure
net/batman-adv/translation-table.c:3950:21: warning: expression using sizeof(void)
net/batman-adv/translation-table.c:3986:30: warning: using sizeof on a flexible structure
net/batman-adv/translation-table.c:3990:27: warning: using sizeof on a flexible structure
net/batman-adv/translation-table.c:3992:23: warning: expression using sizeof(void)

As far as I know, these warnings cannot be removed. However it can be
safely ignored since:

Case 1: Warning "using sizeof on a flexible structure"

The commit 1a88f2f24619 ("flex-array: warn when using sizeof() on a flexible array")
in the sparse git repository says

   Using sizeof() on a structure containing a flexible array
   will ignore the 'flexible' part. This is maybe what is expected
   but maybe not, so add an option -Wflexible-array-sizeof to
   warn on such usage.

In this patch we take care of using or ignoring the flexible part
when necessary. Therefore, these warnings can be safely ignored.

Case 2: Warning "expression using sizeof(void)"

This warning is implied by the use of the "struct_size" helper and
"flex_array_size" helper because they both use the "__is_constexpr"
macro. And this macro is defined using "sizeof(void)".

/*
 * This returns a constant expression while determining if an argument is
 * a constant expression, most importantly without evaluating the argument.
 * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
 *
 * Details:
 * - sizeof() return an integer constant expression, and does not evaluate
 *   the value of its operand; it only examines the type of its operand.
 * - The results of comparing two integer constant expressions is also
 *   an integer constant expression.
 * - The first literal "8" isn't important. It could be any literal value.
 * - The second literal "8" is to avoid warnings about unaligned pointers;
 *   this could otherwise just be "1".
 * - (long)(x) is used to avoid warnings about 64-bit types on 32-bit
 *   architectures.
 * - The C Standard defines "null pointer constant", "(void *)0", as
 *   distinct from other void pointers.
 * - If (x) is an integer constant expression, then the "* 0l" resolves
 *   it into an integer constant expression of value 0. Since it is cast to
 *   "void *", this makes the second operand a null pointer constant.
 * - If (x) is not an integer constant expression, then the second operand
 *   resolves to a void pointer (but not a null pointer constant: the value
 *   is not an integer constant 0).
 * - The conditional operator's third operand, "(int *)8", is an object
 *   pointer (to type "int").
 * - The behavior (including the return type) of the conditional operator
 *   ("operand1 ? operand2 : operand3") depends on the kind of expressions
 *   given for the second and third operands. This is the central mechanism
 *   of the macro:
 *   - When one operand is a null pointer constant (i.e. when x is an integer
 *     constant expression) and the other is an object pointer (i.e. our
 *     third operand), the conditional operator returns the type of the
 *     object pointer operand (i.e. "int *"). Here, within the sizeof(), we
 *     would then get:
 *       sizeof(*((int *)(...))  == sizeof(int)  == 4
 *   - When one operand is a void pointer (i.e. when x is not an integer
 *     constant expression) and the other is an object pointer (i.e. our
 *     third operand), the conditional operator returns a "void *" type.
 *     Here, within the sizeof(), we would then get:
 *       sizeof(*((void *)(...)) == sizeof(void) == 1
 * - The equality comparison to "sizeof(int)" therefore depends on (x):
 *     sizeof(int) == sizeof(int)     (x) was a constant expression
 *     sizeof(int) != sizeof(void)    (x) was not a constant expression
 */
#define __is_constexpr(x) \
	(sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))

Therefore, these warnings can also be safely ignored.


The Coccinelle script used to detect this code pattern is the following:

virtual report

@rule1@
type t1;
type t2;
identifier i0;
identifier i1;
identifier i2;
identifier ALLOC =~ "kmalloc|kzalloc|kmalloc_node|kzalloc_node|vmalloc|vzalloc|kvmalloc|kvzalloc";
position p1;
@@

i0 = sizeof(t1) + sizeof(t2) * i1;
..
i2 = ALLOC@p1(..., i0, ...);

@script:python depends on report@
p1 << rule1.p1;
@@

msg = "WARNING: verify allocation on line %s" % (p1[0].line)
coccilib.report.print_report(p1[0],msg)

Regards,
Erick
---
 include/uapi/linux/batadv_packet.h | 28 +++++++++--------
 net/batman-adv/translation-table.c | 49 ++++++++++++------------------
 2 files changed, 35 insertions(+), 42 deletions(-)

diff --git a/include/uapi/linux/batadv_packet.h b/include/uapi/linux/batadv_packet.h
index 6e25753015df..dfbe30536995 100644
--- a/include/uapi/linux/batadv_packet.h
+++ b/include/uapi/linux/batadv_packet.h
@@ -592,19 +592,6 @@ struct batadv_tvlv_gateway_data {
 	__be32 bandwidth_up;
 };
 
-/**
- * struct batadv_tvlv_tt_data - tt data propagated through the tt tvlv container
- * @flags: translation table flags (see batadv_tt_data_flags)
- * @ttvn: translation table version number
- * @num_vlan: number of announced VLANs. In the TVLV this struct is followed by
- *  one batadv_tvlv_tt_vlan_data object per announced vlan
- */
-struct batadv_tvlv_tt_data {
-	__u8   flags;
-	__u8   ttvn;
-	__be16 num_vlan;
-};
-
 /**
  * struct batadv_tvlv_tt_vlan_data - vlan specific tt data propagated through
  *  the tt tvlv container
@@ -618,6 +605,21 @@ struct batadv_tvlv_tt_vlan_data {
 	__u16  reserved;
 };
 
+/**
+ * struct batadv_tvlv_tt_data - tt data propagated through the tt tvlv container
+ * @flags: translation table flags (see batadv_tt_data_flags)
+ * @ttvn: translation table version number
+ * @num_vlan: number of announced VLANs. In the TVLV this struct is followed by
+ *  one batadv_tvlv_tt_vlan_data object per announced vlan
+ * @vlan_data: array of batadv_tvlv_tt_vlan_data objects
+ */
+struct batadv_tvlv_tt_data {
+	__u8   flags;
+	__u8   ttvn;
+	__be16 num_vlan;
+	struct batadv_tvlv_tt_vlan_data vlan_data[] __counted_by_be(num_vlan);
+};
+
 /**
  * struct batadv_tvlv_tt_change - translation table diff data
  * @flags: status indicators concerning the non-mesh client (see
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index b21ff3c36b07..d66fd900181c 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -28,6 +28,7 @@
 #include <linux/net.h>
 #include <linux/netdevice.h>
 #include <linux/netlink.h>
+#include <linux/overflow.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 #include <linux/skbuff.h>
@@ -815,8 +816,7 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 		num_entries += atomic_read(&vlan->tt.num_entries);
 	}
 
-	change_offset = sizeof(**tt_data);
-	change_offset += num_vlan * sizeof(*tt_vlan);
+	change_offset = struct_size(*tt_data, vlan_data, num_vlan);
 
 	/* if tt_len is negative, allocate the space needed by the full table */
 	if (*tt_len < 0)
@@ -835,7 +835,7 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 	(*tt_data)->ttvn = atomic_read(&orig_node->last_ttvn);
 	(*tt_data)->num_vlan = htons(num_vlan);
 
-	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(*tt_data + 1);
+	tt_vlan = (*tt_data)->vlan_data;
 	hlist_for_each_entry(vlan, &orig_node->vlan_list, list) {
 		tt_vlan->vid = htons(vlan->vid);
 		tt_vlan->crc = htonl(vlan->tt.crc);
@@ -895,8 +895,7 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 		total_entries += vlan_entries;
 	}
 
-	change_offset = sizeof(**tt_data);
-	change_offset += num_vlan * sizeof(*tt_vlan);
+	change_offset = struct_size(*tt_data, vlan_data, num_vlan);
 
 	/* if tt_len is negative, allocate the space needed by the full table */
 	if (*tt_len < 0)
@@ -915,7 +914,7 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 	(*tt_data)->ttvn = atomic_read(&bat_priv->tt.vn);
 	(*tt_data)->num_vlan = htons(num_vlan);
 
-	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(*tt_data + 1);
+	tt_vlan = (*tt_data)->vlan_data;
 	hlist_for_each_entry(vlan, &bat_priv->softif_vlan_list, list) {
 		vlan_entries = atomic_read(&vlan->tt.num_entries);
 		if (vlan_entries < 1)
@@ -2875,7 +2874,6 @@ static bool batadv_send_tt_request(struct batadv_priv *bat_priv,
 {
 	struct batadv_tvlv_tt_data *tvlv_tt_data = NULL;
 	struct batadv_tt_req_node *tt_req_node = NULL;
-	struct batadv_tvlv_tt_vlan_data *tt_vlan_req;
 	struct batadv_hard_iface *primary_if;
 	bool ret = false;
 	int i, size;
@@ -2891,7 +2889,7 @@ static bool batadv_send_tt_request(struct batadv_priv *bat_priv,
 	if (!tt_req_node)
 		goto out;
 
-	size = sizeof(*tvlv_tt_data) + sizeof(*tt_vlan_req) * num_vlan;
+	size = struct_size(tvlv_tt_data, vlan_data, num_vlan);
 	tvlv_tt_data = kzalloc(size, GFP_ATOMIC);
 	if (!tvlv_tt_data)
 		goto out;
@@ -2903,12 +2901,10 @@ static bool batadv_send_tt_request(struct batadv_priv *bat_priv,
 	/* send all the CRCs within the request. This is needed by intermediate
 	 * nodes to ensure they have the correct table before replying
 	 */
-	tt_vlan_req = (struct batadv_tvlv_tt_vlan_data *)(tvlv_tt_data + 1);
 	for (i = 0; i < num_vlan; i++) {
-		tt_vlan_req->vid = tt_vlan->vid;
-		tt_vlan_req->crc = tt_vlan->crc;
+		tvlv_tt_data->vlan_data[i].vid = tt_vlan->vid;
+		tvlv_tt_data->vlan_data[i].crc = tt_vlan->crc;
 
-		tt_vlan_req++;
 		tt_vlan++;
 	}
 
@@ -2960,7 +2956,6 @@ static bool batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 	struct batadv_orig_node *res_dst_orig_node = NULL;
 	struct batadv_tvlv_tt_change *tt_change;
 	struct batadv_tvlv_tt_data *tvlv_tt_data = NULL;
-	struct batadv_tvlv_tt_vlan_data *tt_vlan;
 	bool ret = false, full_table;
 	u8 orig_ttvn, req_ttvn;
 	u16 tvlv_len;
@@ -2983,10 +2978,9 @@ static bool batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 	orig_ttvn = (u8)atomic_read(&req_dst_orig_node->last_ttvn);
 	req_ttvn = tt_data->ttvn;
 
-	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(tt_data + 1);
 	/* this node doesn't have the requested data */
 	if (orig_ttvn != req_ttvn ||
-	    !batadv_tt_global_check_crc(req_dst_orig_node, tt_vlan,
+	    !batadv_tt_global_check_crc(req_dst_orig_node, tt_data->vlan_data,
 					ntohs(tt_data->num_vlan)))
 		goto out;
 
@@ -3329,7 +3323,6 @@ static void batadv_handle_tt_response(struct batadv_priv *bat_priv,
 	struct batadv_orig_node *orig_node = NULL;
 	struct batadv_tvlv_tt_change *tt_change;
 	u8 *tvlv_ptr = (u8 *)tt_data;
-	u16 change_offset;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Received TT_RESPONSE from %pM for ttvn %d t_size: %d [%c]\n",
@@ -3342,10 +3335,7 @@ static void batadv_handle_tt_response(struct batadv_priv *bat_priv,
 
 	spin_lock_bh(&orig_node->tt_lock);
 
-	change_offset = sizeof(struct batadv_tvlv_tt_vlan_data);
-	change_offset *= ntohs(tt_data->num_vlan);
-	change_offset += sizeof(*tt_data);
-	tvlv_ptr += change_offset;
+	tvlv_ptr += struct_size(tt_data, vlan_data, ntohs(tt_data->num_vlan));
 
 	tt_change = (struct batadv_tvlv_tt_change *)tvlv_ptr;
 	if (tt_data->flags & BATADV_TT_FULL_TABLE) {
@@ -3944,10 +3934,10 @@ static void batadv_tt_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 					  u8 flags, void *tvlv_value,
 					  u16 tvlv_value_len)
 {
-	struct batadv_tvlv_tt_vlan_data *tt_vlan;
 	struct batadv_tvlv_tt_change *tt_change;
 	struct batadv_tvlv_tt_data *tt_data;
 	u16 num_entries, num_vlan;
+	size_t flex_size;
 
 	if (tvlv_value_len < sizeof(*tt_data))
 		return;
@@ -3957,17 +3947,18 @@ static void batadv_tt_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 
 	num_vlan = ntohs(tt_data->num_vlan);
 
-	if (tvlv_value_len < sizeof(*tt_vlan) * num_vlan)
+	flex_size = flex_array_size(tt_data, vlan_data, num_vlan);
+	if (tvlv_value_len < flex_size)
 		return;
 
-	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(tt_data + 1);
-	tt_change = (struct batadv_tvlv_tt_change *)(tt_vlan + num_vlan);
-	tvlv_value_len -= sizeof(*tt_vlan) * num_vlan;
+	tt_change = (struct batadv_tvlv_tt_change *)(tt_data->vlan_data +
+						     num_vlan);
+	tvlv_value_len -= flex_size;
 
 	num_entries = batadv_tt_entries(tvlv_value_len);
 
-	batadv_tt_update_orig(bat_priv, orig, tt_vlan, num_vlan, tt_change,
-			      num_entries, tt_data->ttvn);
+	batadv_tt_update_orig(bat_priv, orig, tt_data->vlan_data, num_vlan,
+			      tt_change, num_entries, tt_data->ttvn);
 }
 
 /**
@@ -3998,8 +3989,8 @@ static int batadv_tt_tvlv_unicast_handler_v1(struct batadv_priv *bat_priv,
 	tt_data = tvlv_value;
 	tvlv_value_len -= sizeof(*tt_data);
 
-	tt_vlan_len = sizeof(struct batadv_tvlv_tt_vlan_data);
-	tt_vlan_len *= ntohs(tt_data->num_vlan);
+	tt_vlan_len = flex_array_size(tt_data, vlan_data,
+				      ntohs(tt_data->num_vlan));
 
 	if (tvlv_value_len < tt_vlan_len)
 		return NET_RX_SUCCESS;
-- 
2.25.1


