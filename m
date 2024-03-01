Return-Path: <linux-kernel+bounces-88393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B7E86E0FC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 232251F257F1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C569A6E60B;
	Fri,  1 Mar 2024 12:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="CVlhy3gc"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2046.outbound.protection.outlook.com [40.107.22.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214EA69E1C;
	Fri,  1 Mar 2024 12:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709295817; cv=fail; b=DtlHvORPqc9EeIW+phTKnKKzMOLrJHHRy5Xn4WNqL+L0U8k3snuLl56HqIa/wrOn52ulVoocP8n9RoNwG4nC8coxzJcB2VOyncOivkDjRzP9c0dA5ur9kGhWJsldAfXoRNGwknDyhbKjgjEA9NykivyA7OvSo8AxY4gMLAbyuuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709295817; c=relaxed/simple;
	bh=/j2y7NTbr2oIcY+etchdDMNbaS0b+W8KnlzTPmvL/34=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bF4cUE2hxQKp7non945yQojWuhpyWIRKk1glOjmTvOyGcYwpA3e4+e5cWCaSuBkTmacmhWZnJALLyFPnu2Mr5sSjxvAFJ7yBs0xcT1pqOhYA6YX4EhPS/Sedc74eF8I9AZam2WscWy0RU7FOPt0qCB5k0q68XTRs/BK72NvqbUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=CVlhy3gc; arc=fail smtp.client-ip=40.107.22.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eur5O/g/GJ74judM4EToozCtBhqy656a1nk/ku22IzzfZM8UVsrB4NhoL2hC5VPyE45hW88mAFSc0z0wNbT23oW9eFS/0xdJvdrp1MhuamjWwT4CuBeoJlE0srFLoPYWveTDuCYTyBBBaRXjkuGQug/tLhOAVPpyeqoGPDWcok1lPxJmuZCsbP4MXCWFmByMfWneRdeRfRT+RhJ11xxq4iJrCqnidYq4sZdKi6Peul3IpC4Ez44IU0umGUihblYy+dETOO7v8VqlZiGdm0Tyu7awscHORZL7255xqf/uPBrCSu+/Xbc/W46f4uFCmS7UOYVEN98iMpZdyCy2Eqx2xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/j2y7NTbr2oIcY+etchdDMNbaS0b+W8KnlzTPmvL/34=;
 b=F4j+d5uDCVYNFuGlXkqe56XbWzenuxxIG0X5XjN4N0BiSa8FIHMdAV3kOcFRIOV0xmFygzdc6DK9l89HCL4pcuz34fNYpHOaj5vmG7dUkLY4yIwtiOaaXsLNTEXd4YOeAszB+sezmRxEYbirdMremyDDkHXChWxOUrRhcirereeiXGrtpU5DtKbiYdrsj5iUCrSXawe7UDG8xHlwdA3NNyHRf1J2s/k3CBSB+i0WjXDfRmUYSEL98U3iL25PVvMU7Nl7qfvidIREijU3uleS2qRBgxv6f3adnKceMVQ+XZbjRzE6C1Llkw67L/HIgSqljJqa5qlR+2HHjGyFOOtkGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/j2y7NTbr2oIcY+etchdDMNbaS0b+W8KnlzTPmvL/34=;
 b=CVlhy3gcwszsbmB9XrmNOsRp0cdGuVisa4MUG4S2oXWnzf6u7QoS6xjuUtxm6gtYiSa2WNkDK4M4g3mHd6Zo7CaGMHmIxaAYWHuSgZgUc87DmAETL563qt4Fgyir/o/wHprA2JKo/la0cLKsTuSX0HaFvkxWhm29NgZdVjIKaFs=
Received: from AM0PR02CA0152.eurprd02.prod.outlook.com (2603:10a6:20b:28d::19)
 by DU0PR02MB9540.eurprd02.prod.outlook.com (2603:10a6:10:420::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 12:23:31 +0000
Received: from AM4PEPF00025F98.EURPRD83.prod.outlook.com
 (2603:10a6:20b:28d:cafe::c7) by AM0PR02CA0152.outlook.office365.com
 (2603:10a6:20b:28d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32 via Frontend
 Transport; Fri, 1 Mar 2024 12:23:31 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00025F98.mail.protection.outlook.com (10.167.16.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7339.0 via Frontend Transport; Fri, 1 Mar 2024 12:23:31 +0000
Received: from pc52311-2249 (10.0.5.60) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 1 Mar
 2024 13:23:31 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: Alessandro Zummo <a.zummo@towertech.it>, <linux-rtc@vger.kernel.org>,
	<kernel@axis.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] rtc: Add driver for Epson RX8111
In-Reply-To: <0c3e1b03f276da47b26ac50f5d0ddf5c67aabe5c.1700491765.git.waqar.hameed@axis.com>
	(Waqar Hameed's message of "Mon, 20 Nov 2023 15:49:25 +0100")
References: <cover.1700491765.git.waqar.hameed@axis.com>
	<0c3e1b03f276da47b26ac50f5d0ddf5c67aabe5c.1700491765.git.waqar.hameed@axis.com>
User-Agent: a.out
Date: Fri, 1 Mar 2024 13:23:30 +0100
Message-ID: <pndcysep2d9.fsf@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F98:EE_|DU0PR02MB9540:EE_
X-MS-Office365-Filtering-Correlation-Id: 39804dc3-e8af-4fc3-66c9-08dc39ea685e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nB+GsdYY+2o5TJkEj/FtA7GmEvDR6uDhXbbwvBl4DJB4+uB/aYS++O9c6nxr0kz+gBz+sugv84k8NLACKGEJhLSUX6Ap550UnBfFKwlSPtP62SZBpLnIZj/xFCaKlcp4Gq+haQ8CT+LmAWgm4oqWLjqe+6t08dH8+zV72nIAlpbGRWC3dHU1haIHcXxKbnA1qHaymZt7NnT+TB+UfYkHjw5/akCaBikAWESH6RB1j0wXrg3HrOclv7d/C6VfCUeF+bfnq/xR/m7sh4hMeyrVslYsCpDwlMZrQlK7bU95hAbBsM0CIw0ovKkEdJmQGG3ae4KGqObJOqST2ShH0xdpxRKDlDnPyqQknQ7KPrvjC9sCwjXCCWmmvAKHWRvwwvfhAYe4y0mbdkdZTzc/ljvyyLeAuFTbU2ruUBoQfTCLx9Eo0FyA5JWtJaWL2hSEo5mXP8uLN/iqSztneuhFl4PzMvlaxrg/ncVORVoDuJ5S41BTp6Sf2kLY3JMT8Wc8Bml94GL1fzG9kwvPid4Elzw2Hlr2JvnVtgzkSfWmSBYSbpDkUDrs/jbm24CfJwf9MnMaSutQM7sHS27ofbj+/qurDpu3Eb5kK5Xg+Y2ehT+kgp8WgI+6jKsE3n8aOXqt+s2S0850bOAIZ++olbb3NDyATMD/tS6W+/jvKoR1t15M+JFWyjq5J4b5zgUyF9k4TJXK8zq0eyDSYkK3TA4bZYkuCjFZvxen+lIzU/tFdaa0dhqcdJZpdtbiOhgu6TcDOw4p
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 12:23:31.4821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39804dc3-e8af-4fc3-66c9-08dc39ea685e
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F98.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB9540

On Mon, Nov 20, 2023 at 15:49 +0100 Waqar Hameed <waqar.hameed@axis.com> wrote:

> Epson RX8111 is an RTC with alarm, timer and timestamp functionality.
> Add a basic driver with support for only reading/writing time (for now).

Friendly ping incoming!

