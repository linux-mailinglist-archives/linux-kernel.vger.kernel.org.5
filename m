Return-Path: <linux-kernel+bounces-107352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A2087FB5A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1016A1F21FFF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715C97EF03;
	Tue, 19 Mar 2024 09:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iesy20.onmicrosoft.com header.i=@iesy20.onmicrosoft.com header.b="ms54zftV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=iesy20.onmicrosoft.com header.i=@iesy20.onmicrosoft.com header.b="AP30MSO/"
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2132.outbound.protection.outlook.com [40.107.127.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FAC7E0E4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.127.132
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710842138; cv=fail; b=GIoQ067g3o8yWzoYFl2qyqPDKi3x/RjoVk0uxl1DPqvE8odqjf0YMcMbrRsa7jkXG7Ry4+GE0k275cgiIglDrGGXxLgitlqMTKNi40RpaIfM2RXKfagDJQxDNWk8jZ6H9pZW9UfaZCNMsm5QJ5XWc8kVSmvyM/GkvVuJFlsoO+s=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710842138; c=relaxed/simple;
	bh=xyvrYzCOYunIbgjt/FjVrP7eRKUI/1zQ32GYMCDcqPU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qpOce//znXMGIZD3bhi99+rsuzRcyFpmiYC7rfVC7aSGO283LMVqbyu++IOztN47F5eyid4ybhd+mX+7XmYrOgVQV3GfiwHo75imk+DzvrmLB7aPlkIWjxDoWPTPSpwx4Za2X92S2wFhvJ3AbcUE0ajEqFw0Qkh6sHO586VyoF0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iesy.com; spf=pass smtp.mailfrom=iesy.com; dkim=pass (1024-bit key) header.d=iesy20.onmicrosoft.com header.i=@iesy20.onmicrosoft.com header.b=ms54zftV; dkim=fail (1024-bit key) header.d=iesy20.onmicrosoft.com header.i=@iesy20.onmicrosoft.com header.b=AP30MSO/ reason="signature verification failed"; arc=fail smtp.client-ip=40.107.127.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iesy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iesy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iesy20.onmicrosoft.com; s=selector1-iesy20-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8zvdVpkiWNQql52whz+mm9C0+gKFEiBfT4BcJ5io6Y=;
 b=ms54zftVD+L2byKA5pRHEJdTX8WsKeQBUOQ3AqEPoed4UN4qXu7JAmSKho0cwmRDSeH4aHGwQEqWBEoO27GmAV4fwvXllxCUygh1CDpzFFT79v31PIafPLwGf+M8hUxa5TzSSV5bcjhx3+L0oeq4WqkglRVw2zVqRbVDfnkp2wU=
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=fail;
 b=GViMdKPpKII8UOws9EZQ4/K6NxNtpy8FaKftVphoVwakMNr4rWhIO+KZ9AHWVgygwUbfSdrwbU0FhXIm6IzhO8ZIcIk+UWZ1dEhnmEunR+Qflvi+j3R25vVZKBoVnDN+Epr8Lx/R0iofmaXDJ77x5hpFw4HXuH5LQIm+FFN5VO7CeFex6Sv1rmy3udd/ABTOx7nv4BWXFh8iRijnXV5xEQTHQROeXVCt9osouiqF0SmamxB5ruhGPIdG77rJ3Xwti/PofCV2Zn6FyX7ufkMMJ3G+xid48sF+Px+vqNDo9svmy6nS6EFanViKRVLwzHzS2um6fdlzL6jsQXY4u5F69g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8zvdVpkiWNQql52whz+mm9C0+gKFEiBfT4BcJ5io6Y=;
 b=crq8h7vOmlzG8iSXWN53vT+Ql+EfHHHlYKnNrkzaT9HmIa12FUCIJDwQyymZyVwHXiXAw4PWdKsGdflrGWe60AU4FMbtV1HSivc5CCHtCKWAPkrnR3cGWOMscVejpd8eHbPEsBS6VlcOjOjzrRfuhEHNqSscunGxNAovlGVUa6OwedJSSC+L8M58yywDtMyaKNTcsDkRpPHVzi+p3gY6yfZbyWnoBSxw/sH5auUa2nYbhHdmQVE4aorewRpiKwcTar46iLxJhxnuaWgljKb83NZvD1aTIBICyOyrKcau0EpRJkFPQ0omSb6RHgAW22K/QtRIpPNONnw52qWOY4XuBg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=fail (sender ip is
 20.79.220.33) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=iesy.com;
 dmarc=none action=none header.from=iesy.com; dkim=fail (body hash did not
 verify) header.d=iesy20.onmicrosoft.com; arc=fail (47)
Received: from FR0P281CA0047.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:48::18)
 by FR2P281MB1461.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:90::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Tue, 19 Mar
 2024 09:55:32 +0000
Received: from FR2PEPF000004EF.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48:cafe::8) by FR0P281CA0047.outlook.office365.com
 (2603:10a6:d10:48::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.27 via Frontend
 Transport; Tue, 19 Mar 2024 09:55:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 20.79.220.33)
 smtp.mailfrom=iesy.com; dkim=fail (body hash did not verify)
 header.d=iesy20.onmicrosoft.com;dmarc=none action=none header.from=iesy.com;
Received-SPF: Fail (protection.outlook.com: domain of iesy.com does not
 designate 20.79.220.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.220.33; helo=de1-emailsignatures-cloud.codetwo.com;
Received: from de1-emailsignatures-cloud.codetwo.com (20.79.220.33) by
 FR2PEPF000004EF.mail.protection.outlook.com (10.167.240.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Tue, 19 Mar 2024 09:55:32 +0000
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (104.47.7.168) by de1-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 19 Mar 2024 09:55:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hy9cmKXiy7Q8ClBda8B4deXxuNSJt7ECBsJx/vQuUHviGLv5qaDeKcNwLIQuOx4ilx3SUCFFjEkiWD3ZrCAE/P1GjdyJs1xyOT0JRRayvLZ4232mPn6bu1ZQNwrTxFQybg67jOeoUgVgsh/IH9E4oLpuvhWrfIvSf+b8Tq7oCjj0yetxswTQfKi68X8C01pGS3K6X40CXeKw89AnczU7qapZUD6ILq3nbiErCPQO+/AlnfWvcZ2zdjLKgcZHNN5pp5Ss9TyfAMSfPqCV1oi7DaxHNSf9FABwj1kWWUzAnZ+sw+bDbO996Y36L3JDz3izJ3iSa880AodW660wdwHBSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFJS3vZIzt/HW9WyYtkAS3ZklIblj/gBNcqsxTqBYUI=;
 b=iWOUcwWdA2ytVFm4TIAcvLLTwotLrYU7pMyKLTXeZwEnzZOoG2iXaYGzPJVfNfusKIGJMtg5Y+dIm/0YbjoqF0teSoOCuwJ202UiiuGSZt6KgbyQLy075QVSbBbllaBjfSzgSdqfAN2jzRqwLLT1Vc7OxCQHLqDzJdvLGr4MbF1YM/oYJhehSBjpx6Yutr+QlXdKt92aY8jv6gWSAxmjF0QkOEYRuZwBwesc+T+xD4Juh2xNhGFVrJY4fym1Tk+bSmE/EwWKM1DyuDzwhFrYecGOFuDNgRErQVy+omMr7LWBBhtz4TicrtNEv0ZS6Hz+1MI/44ulmUsGrnbU5w1u9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iesy.com; dmarc=pass action=none header.from=iesy.com;
 dkim=pass header.d=iesy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iesy20.onmicrosoft.com; s=selector1-iesy20-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFJS3vZIzt/HW9WyYtkAS3ZklIblj/gBNcqsxTqBYUI=;
 b=AP30MSO/dNpGQNl3w2x9IfIJNW3t1KGcrC6R30UTyAZX3n0d0z7zP7rsa9WnFfb2Enrtqreu6X9jSVBRd8UGMEk1W8Xg09bFaL98omI+4edPEMEf1PpYdUvgIcC6bst5AVQlfEG8Ei3jfGW19kTP4yf1wvRb+TWzfkcRQ5BhRsE=
Received: from FR2P281MB2393.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:39::12)
 by FR6P281MB3872.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:110::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Tue, 19 Mar
 2024 09:55:30 +0000
Received: from FR2P281MB2393.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8af4:a741:edb6:e851]) by FR2P281MB2393.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8af4:a741:edb6:e851%3]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 09:55:30 +0000
From: Dominik Poggel <pog@iesy.com>
To: robh+dt@kernel.org
CC: Dominik Poggel <pog@iesy.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Tianling Shen <cnsztl@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Ondrej Jirman <megi@xff.cz>,
	Andy Yan <andyshrk@163.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm64: dts: iesy: add support for iesy PX30 SoM OSM-S
Date: Tue, 19 Mar 2024 10:54:00 +0100
Message-ID: <20240319095411.4112296-2-pog@iesy.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240319095411.4112296-1-pog@iesy.com>
References: <20240319095411.4112296-1-pog@iesy.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::12) To FR2P281MB2393.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:39::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-TrafficTypeDiagnostic:
	FR2P281MB2393:EE_|FR6P281MB3872:EE_|FR2PEPF000004EF:EE_|FR2P281MB1461:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 O74QK5jdaltFRoBBuHBcsPVIK5i/J4nzxuCN6lLPKMAxAIMeYSCj00svoEPKweBRyrVdZ0K0yCHFbL+M5SgPYny1SmiEc1kztqgL9vcB/JJiQsFUMgGHhHE4V3aoCiBh2fKzauz9WvXkdSswDDcMQZdGx0ksT1A94IxRwFItMIaFhH/bXAUDwuuF72bxRK6UDkIDVixUlWIKCByhnwh16c6FiskAP6uTV4RNcOiaVT0wpMC64qVIfEYUuCNDTR6Nh+t1jPP1ZxEAG5/tfEOReLhWBv2olFzyE+j6SnYOxqeHFDMnUL2+JZYe0fqxUsGfTeKJn3MlyNH9AMtae/7KWHwwMCx1Wgjey0t717mmyIk4nDxBKQfRaQN5mZjAQeirxFSJZSj8ZL+lwxoaDvS2TiVlNeH+jlR+IaXpSOo5IcN+Yh+ZgnQCriG6zeXdch7Nm7LrHaP48o2kEiJ9HGRFJFvCzD21OgVzYOtkBThCsZ/sYVg1XTxAC+11HZ750IZMr/cZY+DRrX/9ZPksmts4G9ZVs2wPjrM+EwCl/Bvn4p/LaD/v8xXmP8t1gADLezyWDF9FGFScL6/CJq+WewMQYW0E8DvmvRlBEnAKnfbTwEOo3QjE1NQH3JW1ydTvuvNzTiFrqmbC2F4Y56WHBJYnGisY4y6+85J+CeQ5i5QW6t372wFRo6chva1LblNo9nJCU6Sza+QzM2y5Lr4dGqSqVQ==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2P281MB2393.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR6P281MB3872
X-CodeTwo-MessageID: b78b1fd9-f066-4a59-9a41-49280c8f3aa9.20240319095531@de1-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 FR2PEPF000004EF.DEUP281.PROD.OUTLOOK.COM
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a27d150e-06c6-4fca-0005-08dc47fab788
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YN9WaL1ASdt3wGFW3DrJdTLE5tNaSfuSVyl2wn6CUI901BrdYfroMR0/ZS4FHA6XF1pXjouqgVfbTuL6BH1WQ/2Kq6sYXlNHomrGqQDzW4OegIK/834YRD/sgtRthAshz/om1D/HUF6xkul/vdsnZIqI1Uc0fu/Iolq0zQzEwQZOYrNwwSPRSmNwIt6ItWkoHlT4zUrvXMN9oYYH+kZZ1R6LOfpf80YtMiBBBSB+JCliIYe9Tnu8E3bCrThsB/8vkoos9kNABhzrvaJ3f1oqV660kW+1FMuB9+x+Sb2NRiAQgK4wDrIFQHuKq6fjuiibS2m5NPUVXRcrZ1gjYBpNQO8Vx28OnnBOG9WBcJAHnk5x5Jo6K5hk2RA1Fr6GOyj+Sqk40hHO5d8YYebO3qMscomBNkiUT1ufTEHU0Eg4YfodC7uBRjbPcXJ7sUqdnBInNw55sSMsneI8ON3dcP7gxXsyVm+XdClKkyBlADGNuzJB5gy44RDAqBtYWeqmoe9a1unqr4EMTl7X04V9XdMoGnNnCEfFibn8YZuRIoUGoS6HPinVIEH67wzCcMdJXMKxxym6bYRrOurZ9sygaBy0y2gS8+mFF0XF5TWD3altbCeyfnG41K4GAUeYnP4I1tuHwwuKTyGjOLHiPq4SVYmpCnt0ruYIHIstyAs026UpKuKeseGbyCIm0vA9lAhCRHmvcEe5zQuA3edAkcN8PNsaBQLk2wcckr5nEv+f2d1rNnU53PANo9xk289lTYMZ3zr/
X-Forefront-Antispam-Report:
	CIP:20.79.220.33;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:de1-emailsignatures-cloud.codetwo.com;PTR:de1-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1102;
X-OriginatorOrg: iesy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 09:55:32.4901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a27d150e-06c6-4fca-0005-08dc47fab788
X-MS-Exchange-CrossTenant-Id: ace663fd-5672-464f-8169-8d373312f6bc
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ace663fd-5672-464f-8169-8d373312f6bc;Ip=[20.79.220.33];Helo=[de1-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: FR2PEPF000004EF.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB1461

This adds support for the iesy SoM px30-iesy-osm-sf and the matching
evalboard px30-iesy-eva-mi V2.XX.

Signed-off-by: Dominik Poggel <pog@iesy.com>
---
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/px30-iesy-eva-mi-v2.dts | 624 ++++++++++++++++++
 .../boot/dts/rockchip/px30-iesy-osm-sf.dtsi   | 346 ++++++++++
 3 files changed, 971 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-iesy-eva-mi-v2.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-iesy-osm-sf.dtsi

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/ro=
ckchip/Makefile
index f906a868b71a..a46234ccbe15 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -3,6 +3,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D px30-evb.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D px30-engicam-px30-core-ctouch2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D px30-engicam-px30-core-ctouch2-of10.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D px30-engicam-px30-core-edimm2.2.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D px30-iesy-eva-mi-v2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D px30-ringneck-haikou.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3308-evb.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3308-roc-cc.dtb
diff --git a/arch/arm64/boot/dts/rockchip/px30-iesy-eva-mi-v2.dts b/arch/ar=
m64/boot/dts/rockchip/px30-iesy-eva-mi-v2.dts
new file mode 100644
index 000000000000..be1d709bbab0
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/px30-iesy-eva-mi-v2.dts
@@ -0,0 +1,624 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree for iesy RPX30 EVA-MI V2.xx (Eval Kit)
+ *
+ * Copyright (c) 2022 iesy GmbH
+ */
+
+/dts-v1/;
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/net/mscc-phy-vsc8531.h>
+#include "px30-iesy-osm-sf.dtsi"
+
+/ {
+	model =3D "iesy RPX30 EVA-MI V2.xx (Eval Kit)";
+	compatible =3D "iesy,rpx30-eva-mi-v2", "rockchip,px30";
+
+	leds {
+		compatible =3D "gpio-leds";
+
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_leds_bb138>;
+
+		/* BB138a: green user led (LD4) */
+		led@0 {
+			label =3D "USER_LED_00";
+			gpios =3D <&gpio3 RK_PA0 GPIO_ACTIVE_LOW>;
+			linux,default-trigger =3D "heartbeat";
+		};
+
+		/* BB138a: yellow user led (LD9)) */
+		led@1 {
+			label =3D "USER_LED_01";
+			gpios =3D <&gpio3 RK_PA1 GPIO_ACTIVE_LOW>;
+			default-state =3D "off";
+		};
+	};
+
+	/* BB138a: MAX9867ETJ+ audio codec */
+	max9867-sound {
+		compatible =3D "simple-audio-card";
+		simple-audio-card,name =3D "rockchip,max9867-codec";
+		simple-audio-card,format =3D "i2s";
+
+		simple-audio-card,widgets =3D
+			"Speaker", "Jack",
+			"Microphone", "Mic";
+		simple-audio-card,routing =3D
+			"Jack", "LOUT",
+			"Jack", "ROUT",
+			"Mic", "DMICL",
+			"Mic", "DMICR";
+
+		simple-audio-card,frame-master =3D <&cpudai>;
+		simple-audio-card,bitclock-master =3D <&cpudai>;
+
+		status =3D "okay";
+
+		cpudai: simple-audio-card,cpu {
+			sound-dai =3D <&i2s1_2ch>;
+			dai-tdm-slot-num =3D <1>;
+			dai-tdm-slot-width =3D <16>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai =3D <&max9867>;
+			clocks =3D <&cru SCLK_I2S1_OUT>;
+		};
+	};
+
+	/* regulator for USB OTG port */
+	usb_a_vbus_regulator: regulator@1 {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "usb_a_vbus_regulator";
+		regulator-min-microvolt =3D <5000000>;
+		regulator-max-microvolt =3D <5000000>;
+		gpio =3D <&gpio3 RK_PC0 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	/* regulator for USB host port */
+	usb_b_vbus_regulator: regulator@2 {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "usb_b_vbus_regulator";
+		regulator-min-microvolt =3D <5000000>;
+		regulator-max-microvolt =3D <5000000>;
+		gpio =3D <&gpio3 RK_PC3 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	user-buttons {
+		compatible =3D "gpio-keys";
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+		autorepeat;
+
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_buttons>;
+
+		/* BB138a: User-Button 1 */
+		user-button-1 {
+			label =3D "User Button 1";
+			gpios =3D <&gpio3 RK_PA2 GPIO_ACTIVE_LOW>;
+			linux,code =3D <KEY_X>;
+		};
+
+		/* BB138a: User-Button 2 */
+		user-button-2 {
+			label =3D "User Button 2";
+			gpios =3D <&gpio3 RK_PA3 GPIO_ACTIVE_LOW>;
+			linux,code =3D <KEY_Z>;
+		};
+	};
+
+	/* regulator for SD Card on BB138 */
+	vdd3v3_bb138: regulator@4 {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "vdd3v3_bb138";
+		regulator-min-microvolt =3D <3300000>;
+		regulator-max-microvolt =3D <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&display_subsystem {
+	status =3D "okay";
+};
+
+/* Display Serial Interface */
+&dsi {
+	status =3D "okay";
+	rockchip,lane-rate =3D <891>;
+
+	panel@0 {
+		compatible =3D "simple-panel-dsi";
+		reg =3D <0>;
+		power-supply =3D <&vcc3v3_lcd>;
+		prepare-delay-ms =3D <2>;
+		reset-delay-ms =3D <1>;
+		init-delay-ms =3D <20>;
+		enable-delay-ms =3D <120>;
+		disable-delay-ms =3D <50>;
+		unprepare-delay-ms =3D <20>;
+
+		width-mm =3D <68>;
+		height-mm =3D <121>;
+		dsi,lanes =3D <2>;
+
+		display-timings {
+			native-mode =3D <&timing2>;
+
+			timing1: timing1 {
+				clock-frequency =3D <74250000>;
+				hactive =3D <1280>;
+				vactive =3D <720>;
+				hfront-porch =3D <110>;
+				hsync-len =3D <40>;
+				hback-porch =3D <220>;
+				vfront-porch =3D <5>;
+				vsync-len =3D <5>;
+				vback-porch =3D <20>;
+				hsync-active =3D <0>;
+				vsync-active =3D <0>;
+				de-active =3D <0>;
+				pixelclk-active =3D <0>;
+			};
+
+			timing2: timing2 {
+				clock-frequency =3D <74250000>;
+				hactive =3D <1920>;
+				vactive =3D <1080>;
+				hfront-porch =3D <88>;
+				hsync-len =3D <44>;
+				hback-porch =3D <148>;
+				vfront-porch =3D <4>;
+				vsync-len =3D <5>;
+				vback-porch =3D <36>;
+				hsync-active =3D <0>;
+				vsync-active =3D <0>;
+				de-active =3D <0>;
+				pixelclk-active =3D <0>;
+			};
+		};
+
+		ports {
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+
+			port@0 {
+				reg =3D <0>;
+				panel_in_dsi: endpoint {
+					remote-endpoint =3D <&dsi_out_panel>;
+				};
+			};
+		};
+
+		/* should be defined to avoid kernel log errors */
+		/* vsp-supply is positive voltage supply, vsn-supply is negative voltage=
 supply */
+		/* will not be critical: is not even used in simple-panel devicetree exa=
mple */
+		/* vsp-supply =3D <???>; */
+		/* vsn-supply =3D <???>; */
+	};
+
+	ports {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+
+		port@1 {
+			reg =3D <1>;
+			dsi_out_panel: endpoint {
+				remote-endpoint =3D <&panel_in_dsi>;
+			};
+		};
+	};
+};
+
+&dsi_in_vopb {
+	status =3D "okay";
+};
+
+&dsi_in_vopl {
+	status =3D "disabled";
+};
+
+/* ARM Mali GPU */
+&gpu {
+	mali-supply =3D <&vdd_logic>;
+	shadercores-supply =3D <&vdd_logic>;
+	status =3D "okay";
+};
+
+&gmac {
+	phy-supply =3D <&vcc_phy>;
+	phy-handle =3D <&gmac0_phy>;
+	clock_in_out =3D "input";
+	assigned-clocks =3D <&cru SCLK_GMAC>;
+	assigned-clock-parents =3D <&cru SCLK_GMAC>;
+	status =3D "okay";
+
+	gmdio0: gmac0_mdio {
+		compatible =3D "snps,dwmac-mdio";
+
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+
+		/* BB138a: Ethernet PHY */
+		gmac0_phy: ethernet-phy@0 {
+			compatible =3D "ethernet-phy-id0007.0570";
+			reg =3D <0x0>;
+			max-speed =3D <100>;
+			vsc8531,vddmac =3D <1800>;
+			vsc8531,edge-slowdown =3D <76>;
+			vsc8531,led-0-mode =3D <VSC8531_LINK_100_ACTIVITY>;
+			vsc8531,led-1-mode =3D <VSC8531_LINK_100_ACTIVITY>;
+		};
+	};
+};
+
+&i2c0 {
+	/* BB138a: LM75 sensor */
+	sensor@4e {
+		status =3D "okay";
+		compatible =3D "lm75";
+		reg =3D <0x4e>;
+	};
+
+	/* BB138a: PFC85263 RTC */
+	rtc@51 {
+		status =3D "okay";
+		compatible =3D "nxp,pcf85263";
+		reg =3D <0x51>;
+	};
+
+	/* BB138a: AT24C64D EEPROM */
+	eeprom@53 {
+		status =3D "okay";
+		compatible =3D "atmel,24c64";
+		reg =3D <0x53>;
+		pagesize =3D <32>;
+	};
+};
+
+&i2c1 {
+	status =3D "okay";
+
+	/* BB138a: HDMI to MIPI converter */
+	lt8912@48 {
+		compatible =3D "lontium,lt8912";
+		reg =3D <0x48>;
+		ddc-i2c-bus =3D <&i2c1>;
+		/* driver needs a valid reset gpio to function */
+		/* use not connected pin as dummy */
+		reset-gpios =3D <&gpio3 RK_PD3 GPIO_ACTIVE_LOW>; /* n.c. */
+		status =3D "okay";
+	};
+
+	/* BB138a: MAX9867ETJ+ audio codec */
+	max9867: audio_codec@18 {
+		#sound-dai-cells =3D <0>;
+		compatible =3D "maxim,max9867";
+		reg =3D <0x18>;
+		status =3D "okay";
+		assigned-clocks =3D <&cru SCLK_I2S1_OUT>;
+		assigned-clock-parents =3D <&cru SCLK_I2S1_OUT>;
+		assigned-clock-rates =3D <50000000>;
+	};
+};
+
+&i2s1_2ch {
+	pinctrl-0 =3D <&i2s1_2ch_mclk &i2s1_2ch_sclk &i2s1_2ch_lrck
+				 &i2s1_2ch_sdi &i2s1_2ch_sdo>;
+	status =3D "okay";
+};
+
+&io_domains {
+	status =3D "okay";
+
+	vccio1-supply =3D <&vcc1v8_dvp>;
+	vccio2-supply =3D <&vccio_sd>;
+	vccio3-supply =3D <&vcc1v8_dvp>;
+	vccio4-supply =3D <&vcc1v8_dvp>;
+	vccio5-supply =3D <&vcc1v8_dvp>;
+	vccio6-supply =3D <&vcc1v8_soc>;
+	pmuio1-supply =3D <&vcc3v0_pmu>;
+	pmuio2-supply =3D <&vcc1v8_soc>;
+};
+
+&pinctrl {
+	headphone {
+		hp_det: hp-det {
+			rockchip,pins =3D <2 RK_PB0 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+
+	leds {
+		pinctrl_leds_bb138: pinctrl-leds-bb138 {
+			rockchip,pins =3D <3 RK_PA0 RK_FUNC_GPIO &pcfg_pull_none
+							 3 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	i2c0 {
+		i2c0_xfer: i2c0-xfer {
+			rockchip,pins =3D
+				<0 RK_PB0 1 &pcfg_pull_none_8ma>,
+				<0 RK_PB1 1 &pcfg_pull_none_8ma>;
+		};
+	};
+
+	i2c1 {
+		i2c1_xfer: i2c1-xfer {
+			rockchip,pins =3D
+				<0 RK_PC2 1 &pcfg_pull_none_8ma>,
+				<0 RK_PC3 1 &pcfg_pull_none_8ma>;
+		};
+	};
+
+	i2c2 {
+		i2c2_xfer: i2c2-xfer {
+			rockchip,pins =3D
+				<2 RK_PB7 2 &pcfg_pull_none_8ma>,
+				<2 RK_PC0 2 &pcfg_pull_none_8ma>;
+		};
+	};
+
+	gpiokeys {
+		pinctrl_buttons: buttongrp {
+			rockchip,pins =3D <3 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>,
+							<3 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	uart0 {
+		uart0_xfer: uart0-xfer {
+			rockchip,pins =3D
+				<0 RK_PB2 1 &pcfg_pull_none_2ma>,
+				<0 RK_PB3 1 &pcfg_pull_up>;
+		};
+
+		uart0_rts: uart0-rts {
+			rockchip,pins =3D
+				<0 RK_PB5 1 &pcfg_pull_none_2ma>;
+		};
+	};
+
+	uart1 {
+		uart1_xfer: uart1-xfer {
+			rockchip,pins =3D
+				<1 RK_PC1 1 &pcfg_pull_none_2ma>,
+				<1 RK_PC0 1 &pcfg_pull_up>;
+		};
+
+		uart1_rts: uart1-rts {
+			rockchip,pins =3D
+				<1 RK_PC3 1 &pcfg_pull_none_2ma>;
+		};
+	};
+
+	pwm0 {
+		pwm0_pin: pwm0-pin {
+			rockchip,pins =3D
+				<0 RK_PB7 1 &pcfg_pull_none_2ma>;
+		};
+	};
+
+	pwm1 {
+		pwm1_pin: pwm1-pin {
+			rockchip,pins =3D
+				<0 RK_PC0 1 &pcfg_pull_none_2ma>;
+		};
+	};
+
+	pwm2 {
+		pwm2_pin: pwm2-pin {
+			rockchip,pins =3D
+				<2 RK_PB5 1 &pcfg_pull_none_2ma>;
+		};
+	};
+
+	pwm3 {
+		pwm3_pin: pwm3-pin {
+			rockchip,pins =3D
+				<0 RK_PC1 1 &pcfg_pull_none_2ma>;
+		};
+	};
+
+	spi0 {
+		spi0_clk: spi0-clk {
+			rockchip,pins =3D
+				<1 RK_PB7 3 &pcfg_pull_up_4ma>;
+		};
+
+		spi0_csn: spi0-csn {
+			rockchip,pins =3D
+				<1 RK_PB6 3 &pcfg_pull_up_4ma>;
+		};
+
+		spi0_mosi: spi0-mosi {
+			rockchip,pins =3D
+				<1 RK_PB4 3 &pcfg_pull_up_4ma>;
+		};
+	};
+
+	spi1 {
+		/* spi1.sdo */
+		spi1_mosi: spi1-mosi {
+			rockchip,pins =3D
+				<3 RK_PB4 4 &pcfg_pull_none>;
+		};
+
+		/* spi1.csn PIN E17 used! */
+		spi1_csn: spi1-csn {
+			rockchip,pins =3D
+				<3 RK_PB0 4 &pcfg_pull_none>;
+		};
+
+		spi1_clk: spi1-clk {
+			rockchip,pins =3D
+				<3 RK_PB7 4 &pcfg_pull_none>;
+		};
+	};
+
+	u2phy {
+		u2phy_host_pin: host-port {
+			rockchip,pins =3D
+				<3 RK_PC3 1 &pcfg_pull_none_4ma>;
+		};
+
+		u2phy_otg_pin: otg-port {
+			rockchip,pins =3D
+				<3 RK_PC0 1 &pcfg_pull_none_4ma>;
+		};
+	};
+};
+
+&pmu_io_domains {
+	status =3D "okay";
+
+	pmuio1-supply =3D <&vcc3v0_pmu>;
+	pmuio2-supply =3D <&vcc1v8_soc>;
+};
+
+&power {
+	pd_vi-supply =3D <&vdd_logic>;
+	pd_vpu-supply =3D <&vdd_logic>;
+	pd_gpu-supply =3D <&vdd_logic>;
+	pd_usb-supply =3D <&vdd_logic>;
+	pd_mmc_nand-supply =3D <&vdd_logic>;
+	pd_vo-supply =3D <&vdd_logic>;
+};
+
+/* BB138a: PWM outputs on Pin Header */
+&pwm0 {
+	status =3D "okay";
+};
+
+&pwm1 {
+	status =3D "okay";
+};
+
+&pwm2 {
+	status =3D "okay";
+};
+
+&pwm3 {
+	status =3D "okay";
+};
+
+/* BB138a: SAR ADC inputs */
+&saradc {
+	status =3D "okay";
+	vref-supply =3D <&vcc1v8_soc>;
+};
+
+/* BB138a: SD card connector */
+&sdmmc {
+	bus-width =3D <4>;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	supports-sd;
+	card-detect-delay =3D <800>;
+	ignore-pm-notify;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	max-frequency =3D <135000000>;
+	vqmmc-supply =3D <&vccio_sd>;
+	vmmc-supply =3D <&vdd3v3_bb138>;
+	status =3D "okay";
+};
+
+&spi0 {
+	status =3D "okay";
+
+	spidev@0 {
+	   compatible =3D "memsic,mc3630";
+	   spi-max-frequency =3D <10000000>;
+	   reg =3D <0>;
+	};
+};
+
+&spi1 {
+	status =3D "okay";
+	cs-gpios =3D <&gpio3 RK_PB0 GPIO_ACTIVE_LOW>;
+
+	spidev@0 {
+	   compatible =3D "jedec,spi-nor";
+	   spi-max-frequency =3D <10000000>;
+	   reg =3D <0>;
+	};
+};
+
+&u2phy {
+	status =3D "okay";
+
+	/* BB138a: USB2.0 Host PHY */
+	u2phy_host: host-port {
+		phy-supply =3D <&vcc3v0_pmu>;
+		vbus-supply =3D <&usb_b_vbus_regulator>;
+		status =3D "okay";
+		pinctrl-0 =3D <&u2phy_host_pin>;
+	};
+
+	/* BB138a: USB2.0 OTG PHY */
+	u2phy_otg: otg-port {
+		phy-supply =3D <&vcc3v0_pmu>;
+		vbus-supply =3D <&usb_a_vbus_regulator>;
+		status =3D "okay";
+		pinctrl-0 =3D <&u2phy_otg_pin>;
+	};
+};
+
+/* BB138a: UART_A on MicroBus and Pin Header */
+&uart0 {
+	status =3D "okay";
+};
+
+/* BB138a: UART_B M.2 socket (not used) */
+&uart1 {
+	status =3D "okay";
+};
+
+&usb20_otg {
+	dr_mode =3D "otg";
+	status =3D "okay";
+
+	/* should be defined to avoid kernel log error */
+	/* vusb_d: digital usb supply, 1.2V */
+	/* vusb_q: analog usb supply, 1.1V */
+	/* no further info available */
+	/* vusb_d-supply =3D <???>; */
+	/* vusb_a-supply =3D <???>; */
+};
+
+&usb_host0_ehci {
+	/*vbus-supply =3D <&usb_b_vbus_regulator>;*/
+	status =3D "okay";
+};
+
+&usb_host0_ohci {
+	/*vbus-supply =3D <&usb_b_vbus_regulator>;*/
+	status =3D "okay";
+};
+
+/* Big Video Output Processor (VOPB) */
+&vopb {
+	status =3D "okay";
+};
+
+&vopb_mmu {
+	status =3D "okay";
+};
+
+/* Little Video Output Processor (VOPL) */
+&vopl {
+	status =3D "disabled";
+};
+
+&vopl_mmu {
+	status =3D "disabled";
+};
diff --git a/arch/arm64/boot/dts/rockchip/px30-iesy-osm-sf.dtsi b/arch/arm6=
4/boot/dts/rockchip/px30-iesy-osm-sf.dtsi
new file mode 100644
index 000000000000..18db50ca62b6
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/px30-iesy-osm-sf.dtsi
@@ -0,0 +1,346 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree for iesy RPX30 OSM SF (OSM Module)
+ *
+ * Copyright (c) 2023 iesy GmbH
+ */
+
+#include "../rockchip/px30.dtsi"
+
+/ {
+	aliases {
+		mmc0 =3D &emmc;
+		mmc1 =3D &sdmmc;
+		mmc2 =3D &sdio;
+	};
+
+	chosen {
+		bootargs =3D "earlycon=3Duart8250,mmio32,0xff160000 console=3DttyFIQ0 rw=
 root=3DPARTUUID=3D614e0000-0000 rootwait";
+	};
+
+	fiq-debugger {
+		compatible =3D "rockchip,fiq-debugger";
+		rockchip,serial-id =3D <2>;
+		rockchip,wake-irq =3D <0>;
+		/* If enable uart uses irq instead of fiq */
+		rockchip,irq-mode-enable =3D <1>;
+		rockchip,baudrate =3D <115200>;  /* Only 115200 and 1500000 */
+		interrupts =3D <GIC_SPI 127 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&uart2m1_xfer>;
+		status =3D "okay";
+	};
+
+	vcc_phy: vcc-phy-regulator {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "vcc_phy";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vcc5v0_sys: vccsys {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "vcc5v0_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt =3D <5000000>;
+		regulator-max-microvolt =3D <5000000>;
+	};
+};
+
+&cpu0 {
+	cpu-supply =3D <&vdd_arm>;
+};
+
+&cpu0_opp_table {
+	rockchip,avs =3D <1>;
+};
+
+/* eMMC on OSM module */
+&emmc {
+	bus-width =3D <8>;
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	supports-emmc;
+	disable-wp;
+	non-removable;
+	num-slots =3D <1>;
+	status =3D "okay";
+
+	vmmc-supply =3D <&vcc3v3_sys>;
+	vqmmc-supply =3D <&vcc1v8_soc>;
+};
+
+/* Rockchip General Register File (GRF) */
+&grf {
+	io_domains: io-domains {
+		/* should be defined to avoid kernel log error */
+		/* but no further info about vccio-oscgpi for PX30 available */
+		/* vccio-oscgpi-supply =3D <???>; */
+	};
+};
+
+&i2c0 {
+	status =3D "okay";
+
+	/* Power Management IC */
+	rk809: pmic@20 {
+		compatible =3D "rockchip,rk809";
+		reg =3D <0x20>;
+		interrupt-parent =3D <&gpio0>;
+		interrupts =3D <7 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names =3D "default", "pmic-sleep",
+				"pmic-power-off", "pmic-reset";
+		pinctrl-0 =3D <&pmic_int>;
+		pinctrl-1 =3D <&soc_slppin_slp>, <&rk817_slppin_slp>;
+		pinctrl-2 =3D <&soc_slppin_gpio>, <&rk817_slppin_pwrdn>;
+		pinctrl-3 =3D <&soc_slppin_rst>, <&rk817_slppin_rst>;
+		rockchip,system-power-controller;
+		wakeup-source;
+		#clock-cells =3D <1>;
+		clock-output-names =3D "rk808-clkout1", "rk808-clkout2";
+		//fb-inner-reg-idxs =3D <2>;
+		/* 1: rst regs (default in codes), 0: rst the pmic */
+		pmic-reset-func =3D <1>;
+
+		vcc1-supply =3D <&vcc5v0_sys>;
+		vcc2-supply =3D <&vcc5v0_sys>;
+		vcc3-supply =3D <&vcc5v0_sys>;
+		vcc4-supply =3D <&vcc5v0_sys>;
+		vcc5-supply =3D <&vcc3v3_sys>;
+		vcc6-supply =3D <&vcc5v0_sys>;
+		vcc7-supply =3D <&vcc3v3_sys>;
+		vcc8-supply =3D <&vcc5v0_sys>;
+		vcc9-supply =3D <&vcc5v0_sys>;
+
+		pwrkey {
+			status =3D "okay";
+		};
+
+		pinctrl_rk8xx: pinctrl_rk8xx {
+			gpio-controller;
+			#gpio-cells =3D <2>;
+
+			rk817_slppin_null: rk817_slppin_null {
+				pins =3D "gpio_slp";
+				function =3D "pin_fun0";
+			};
+
+			rk817_slppin_slp: rk817_slppin_slp {
+				pins =3D "gpio_slp";
+				function =3D "pin_fun1";
+			};
+
+			rk817_slppin_pwrdn: rk817_slppin_pwrdn {
+				pins =3D "gpio_slp";
+				function =3D "pin_fun2";
+			};
+
+			rk817_slppin_rst: rk817_slppin_rst {
+				pins =3D "gpio_slp";
+				function =3D "pin_fun3";
+			};
+		};
+
+		regulators {
+			/* SW1: 1V0 LOG */
+			vdd_logic: DCDC_REG1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt =3D <900000>;
+				regulator-max-microvolt =3D <1100000>;
+				regulator-ramp-delay =3D <6001>;
+				regulator-initial-mode =3D <0x2>;
+				regulator-name =3D "vdd_logic";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt =3D <950000>;
+				};
+			};
+
+			/* SW2: 1V0 ARM */
+			vdd_arm: DCDC_REG2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt =3D <950000>;
+				regulator-max-microvolt =3D <1350000>;
+				regulator-ramp-delay =3D <6001>;
+				regulator-initial-mode =3D <0x2>;
+				regulator-name =3D "vdd_arm";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt =3D <950000>;
+				};
+			};
+
+			/* SW3: 1V2 DDR */
+			vcc_ddr: DCDC_REG3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-name =3D "vcc_ddr";
+				regulator-initial-mode =3D <0x2>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			/* SW4: unused */
+
+			/* SW5: 3V3 IO */
+			vcc3v3_sys: DCDC_REG5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt =3D <3300000>;
+				regulator-max-microvolt =3D <3300000>;
+				regulator-name =3D "vcc3v3_sys";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt =3D <3300000>;
+				};
+			};
+
+			/* LDO1: 1V0 LDO1 */
+			vcc_1v0: LDO_REG1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt =3D <1000000>;
+				regulator-max-microvolt =3D <1000000>;
+				regulator-name =3D "vcc_1v0";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt =3D <1000000>;
+				};
+			};
+
+			/* LDO2: 1V8 IO1 */
+			vcc1v8_soc: LDO_REG2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt =3D <1800000>;
+				regulator-max-microvolt =3D <1800000>;
+
+				regulator-name =3D "vcc1v8_soc";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt =3D <1800000>;
+				};
+			};
+
+			/* LDO3: 1V0 LDO3 */
+			vdd1v0_soc: LDO_REG3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt =3D <1000000>;
+				regulator-max-microvolt =3D <1000000>;
+
+				regulator-name =3D "vcc1v0_soc";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt =3D <1000000>;
+				};
+			};
+
+			/* LDO4: 3V3 PMU */
+			vcc3v0_pmu: LDO_REG4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt =3D <3300000>;
+				regulator-max-microvolt =3D <3300000>;
+
+				regulator-name =3D "vcc3v0_pmu";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt =3D <3300000>;
+
+				};
+			};
+
+			/* LDO5: VCC SD */
+			vccio_sd: LDO_REG5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt =3D <1800000>;
+				regulator-max-microvolt =3D <3300000>;
+
+				regulator-name =3D "vccio_sd";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt =3D <3300000>;
+				};
+			};
+
+			/* LDO6: unused */
+
+			/* LDO7: unused */
+
+			/* LDO8: 1V8 IO2 */
+			vcc1v8_dvp: LDO_REG8 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt =3D <1800000>;
+				regulator-max-microvolt =3D <1800000>;
+
+				regulator-name =3D "vcc1v8_dvp";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt =3D <1800000>;
+				};
+			};
+
+			/* LDO9: unused */
+
+			/* Switch 1: unused */
+
+			vcc3v3_lcd: SWITCH_REG2 {
+				regulator-name =3D "vcc3v3_lcd";
+			};
+		};
+	};
+
+	/* RTC on OSM module REV3.00 */
+	rtc@68 {
+		status =3D "okay";
+		compatible =3D "adi,max31343";
+		reg =3D <0x68>;
+	};
+
+	/* CAT24C32 EEPROM on OSM module */
+	eeprom@50 {
+		status =3D "okay";
+		compatible =3D "atmel,24c32";
+		reg =3D <0x50>;
+		pagesize =3D <32>;
+	};
+};
+
+&pinctrl {
+	pmic {
+		pmic_int: pmic_int {
+			rockchip,pins =3D
+				<0 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		soc_slppin_gpio: soc_slppin_gpio {
+			rockchip,pins =3D
+				<0 RK_PA4 RK_FUNC_GPIO &pcfg_output_low>;
+		};
+
+		soc_slppin_slp: soc_slppin_slp {
+			rockchip,pins =3D
+				<0 RK_PA4 1 &pcfg_pull_none>;
+		};
+
+		soc_slppin_rst: soc_slppin_rst {
+			rockchip,pins =3D
+				<0 RK_PA4 2 &pcfg_pull_none>;
+		};
+	};
+
+	uart2-m1 {
+		uart2m1_xfer: uart2m1-xfer {
+			rockchip,pins =3D
+				<2 RK_PB4 2 &pcfg_pull_up>,
+				<2 RK_PB6 2 &pcfg_pull_up_2ma>;
+		};
+	};
+};
--=20
2.44.0


