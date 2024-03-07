Return-Path: <linux-kernel+bounces-95421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88056874D70
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D92280E7B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E1E1292DC;
	Thu,  7 Mar 2024 11:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Wj/lTS9n"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2041.outbound.protection.outlook.com [40.107.7.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF26DDC9
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 11:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811126; cv=fail; b=UvfCRfzWDKrL2E/NJaiGmPP5NnU562+7XjLct6M6zEPF1h6s5Q6GkYP3TfaBOgRjYXnxFjUANRHhabE/ZWMXzZ0nSmx2EdfB4SHwrqZZU+SPzJOGoU1Xf1JfYfwk/jrPBb4J7YB5IenhqjWb2xuQM0387XETcbQAWt24kbSiF7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811126; c=relaxed/simple;
	bh=xR+FIRH7ZnGEZQelDPt9vSsQgzkpmU9wO6mWxK0tzNI=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q5dZBu1hS5cWqqXI9TNl0BiT5pAVKBt69wOxbdryuhPz8vqDQ7LCR8a/R+6w2uUJwFErKhSbVt/ETiWpgiVNCP1RBO2MDas4LtmYINX1txEgeFRSfflz//+p3xm/fhdZ2CouPKaiXRAgbO/bajjLgfClRGAdoRi1EA0/yOJrWEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Wj/lTS9n; arc=fail smtp.client-ip=40.107.7.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+oUZm9r2cycUcneMBKCPmFhGOEpRIdzid9xfldOWTth+9bxqN0qYOw3xL9dSBiYd0c2dS8a5D784WQv2TXauSsu7ABBUvCLjl1JUDTm4oeapRmPWBUZQ2qVt1QvlJcIRI5mG04wZG8qL5uo54v6ui7wkErqDpqFBH9RvQ3uEk0Won9p1BWzl/OwKVMZZ+zholGMG/xIuXEJrvF4BLfNWo2IWVhORJfSGNBBVIdkdyvTWAMu73bRX70wC9jPEEJkJgQBypyKgu6cpw12eZgtWFaNzEWTkmks0JxTwYY/3talrz0tOrceX+tJn5FjfTcyX4darDNZolzhqcjabHBRpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51Q7mjXPIbS7CrfTJb1g1h0l6RM5WCmhQNItF0b7b0s=;
 b=G5BuawLMsuY7tyiPFLmMnrQ3pJcxLJi5F8lBZiGCEGxvyEFAq8FxLugGr3jM28gcxCWeD0TRaSg4QaWtd+jf8mgPRhtvokZKj/FX5qZp1qU+4oouuPTOMfewtzFew8h/FIRCvKERlfNzK3KlkEwb7HJZfofDqVWPofiCvuD7sxJAElRciRqjM+8Vpb0jVIhwMUASt8+X8b2IFvB5tw7ELSNY6/11AHDpE+GmgXPQz98QpkIzZMZGnrGTmdFY75nFVGCOL+9nCKn80zymP5ETGRREaAlIe2f8GmQ5QK5ra1uqADxtZ2DmFRxaNOtNtKHw1KCShnswOlrZ2oveW1jaSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51Q7mjXPIbS7CrfTJb1g1h0l6RM5WCmhQNItF0b7b0s=;
 b=Wj/lTS9nK0cGn2+2KykkH+XWJrY+6HROfoZhHD1Wia836TQO5mjZ1BL+WmEMqqf7+3QrsFVnVkhDtuKJkkOKktvofQE8Kxy0FcB/oK/9pcok2d6JHgBdZyqOqfjs47B+r/H+3h/ISzkyYDikw4Koi2x924AGnrpD6vbfiAiEaSs=
Received: from DB8PR03CA0019.eurprd03.prod.outlook.com (2603:10a6:10:be::32)
 by DB9PR02MB7066.eurprd02.prod.outlook.com (2603:10a6:10:226::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 11:31:59 +0000
Received: from DU2PEPF0001E9C4.eurprd03.prod.outlook.com
 (2603:10a6:10:be:cafe::b0) by DB8PR03CA0019.outlook.office365.com
 (2603:10a6:10:be::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Thu, 7 Mar 2024 11:31:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF0001E9C4.mail.protection.outlook.com (10.167.8.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Thu, 7 Mar 2024 11:31:59 +0000
Received: from pc52311-2249 (10.0.5.60) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 7 Mar
 2024 12:31:58 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>
CC: Johannes Berg <johannes@sipsolutions.net>, Ingo Molnar <mingo@kernel.org>,
	<oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<kernel@axis.com>, Richard Weinberger <richard@nod.at>,
	<linux-um@lists.infradead.org>
Subject: Re: pcap-dbus.o:undefined reference to `dbus_message_demarshal'
In-Reply-To: <4ee83195-99f5-4823-b4d0-339ef4127013@cambridgegreys.com> (Anton
	Ivanov's message of "Thu, 7 Mar 2024 10:49:56 +0000")
References: <202403052336.y6DkUd8a-lkp@intel.com> <pndzfvbibgm.fsf@axis.com>
	<87cfca1e-3f53-4935-a274-0920bce86373@cambridgegreys.com>
	<463be980baf66b967031e3294c3b9745b07aa058.camel@sipsolutions.net>
	<2cc222b7-618c-46a9-b78b-eb099d0f4be7@cambridgegreys.com>
	<a485fbdea26e19afe00f603bd65c83e2be20abe6.camel@sipsolutions.net>
	<4ee83195-99f5-4823-b4d0-339ef4127013@cambridgegreys.com>
User-Agent: a.out
Date: Thu, 7 Mar 2024 12:31:58 +0100
Message-ID: <pndle6ui8gh.fsf@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C4:EE_|DB9PR02MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c8557b3-5c13-47d9-085d-08dc3e9a33e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kRTDbF+EWg3KE8OcxR01eeXnKP/Hla8LeXkzoM+dmtCfYqrFanCu4yfpH+zdJ7d0WMW2L7uZEN2WEzlmfaw/7DN9+WCJqou/IE4OlCIQYblSD/JeDoj3sKt+dW32j9LMnk3Rc9zgPz0i8T4NlwiRz38MJb/hSX8xoq/M2gPERQodUq4qBZA7vzYSK5BvoNh1lqwCXDXfKLECoB1xfnInLB3tJWaArgciXM1kWeTxciXIE3v6UfbLlYVo8DRnXZwME8wufIuI5cZqA590Y9tJ1tgdz5zpPzUkdhDQe0vTTYtHWtKv6q3qEzx52YBnbV14nC3Y3KGX6T68MRTA3frFWyLrwaf8LhC1dLFPSIklEQiOw7cVJYcu7oFP4lNFP5cP28ibTNenINVGUzBfr0ln6L4d56dnLHw2tLfGmCegHbM0eYw9yrCAAa+x2Pnn0E+4rcfUT7AyGjBctz4m4rHvpEMJiPPpHGArHWelTnBVbA5RAXFokYjDalM/Xw8/iC6aC6DrBVKyHAVNtAzcPB4zh2B6PSDzm/I/ILBXOljFXxylCjXzjW+OHJc43Ll/lf8Vsvsd2KRwNMpDsjZ7MpFaxTQcvAhtb2YbDyUWPJxIliUB6vUpCuK0koYgsFXWfrqJt4oRhtHmJ6zHxoaOThOOZeqKhDd7L2RQzkhzUCRfUI5NmofkRQ6LJvctLT6LKnHXzBGfsTTdKqInqSFPsMgcHOyvmCEg8IIJoFPeU0NK1SGc1LgDoWLVnvsn/HoWoYDO
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 11:31:59.5258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8557b3-5c13-47d9-085d-08dc3e9a33e1
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C4.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB7066

On Thu, Mar 07, 2024 at 10:49 +0000 Anton Ivanov <anton.ivanov@cambridgegreys.com> wrote:

> On 07/03/2024 10:29, Johannes Berg wrote:

[...]

>> Yeah, that makes sense, this is all kind of special configuration
>> anyway, and given that it's been broken forever ...
>> I actually doubt anyone would scream if we just removed it, so maybe
>> just remove it and if they do scream, point to the above, including said
>> 3-liner in the response?
>
> Let's make it so.

I'm guessing Johannes (or Anton) will create the patch for removing it
and no further action is needed from my side.

Thank you for your swift responses! 

