Return-Path: <linux-kernel+bounces-81828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B294867AD7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82506B32F15
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550A512BF05;
	Mon, 26 Feb 2024 15:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cktBhUVR"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2085.outbound.protection.outlook.com [40.92.99.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B3F12BE87;
	Mon, 26 Feb 2024 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.99.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962177; cv=fail; b=Pj9QkBskM+upYCXhf3SW9/DfREQ/UEjT5sADAQoEzoVo87yWULFNG1Mcz8noLv/mqkPHtx6OoDzezDrIoCE3Tx2/EuXUF7O3xG82tASR15QhttuGhRyBrNjn5vQYpMIVPgJ3ChYv+tPmub8XyUFm0ut2PnLpO3vOXjUeIfU0JAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962177; c=relaxed/simple;
	bh=oJJzHKYqtsvh/UGMLnaNtO1m8lE3lvK9HK06CAghhQA=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JSmZ3LRr25vs/b+0NSPuhCa+UXhyYaVRaV2Nn7KzlCUP7OHgD9nyChamC2ONzraWGQ46/QfWiAT4US2zsVI3TaPsDoVC124hULCXCABjTzeAbISUJ54SUbUeLYZqJqt8PCDhGlMbx4K5F5qbvtLsUsQNoAlYko8Y6Si+hUNbIGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cktBhUVR; arc=fail smtp.client-ip=40.92.99.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bu0dFc9VAo4ymjogDmavjMA/EWMqbpCIHuu4oOSYvxGV+UwX6tmHdWDwCi6kGCYvqyaYaKD8Ax9TXQFcDqcXSZx8I7bFneG9MwjSgKLwaYlTg3ibYtx39/eEaq9JsGFUqV7qaM8XLr2DUFbXFqx6XwTZVhamX6fZZn4ziWb+HTwBWBrRUGHWDjS2A/N0WVTfMXr6qw8khbB5tFV2dCNe6ncTrfn0jxPL3RqyfaBEusqrZSO/poUsgJx9fBfFs/A1kVx05Oko+PZEQuGkvfzg6gr/knDCLE/wPcy8W/WxfrDEuqonBn/eSlO0w3vDrcej3NBf9yksBkeuXyhI3/IJ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJJzHKYqtsvh/UGMLnaNtO1m8lE3lvK9HK06CAghhQA=;
 b=iuk+3QXW+W7BAdzcBlyqmtp0oKU/AttlJBBMBRiO1VA4GNtVcQL0LZBT8zgmvidyvv8/vF2Dg9mk0d42cfHXODqgASLP4DCrQxrjGhF/h19SRB2E9zFk5ppE3E4Ul/aEwVwi2xPb7wAOCuZNSIB2PbE9vLsvzVXdcDraFfm1jhuke5TTEEbOsxEDWvdH1BbgM49YNMub59sg3mQkwcbhOTV/Up3oSbDbNiCcXf37hg4Tc9ympfnKzqqwUX0tlVXgjckBquxjWbPvxIJoXDGnNqTnSTKomY04NmYVMl5F4U5SHRmK5++MCe3nlh7CL0x8tI9XLbL69V/9rwZFw0xd+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJJzHKYqtsvh/UGMLnaNtO1m8lE3lvK9HK06CAghhQA=;
 b=cktBhUVRVO313aAMD06uE7es4zUFcXCgbztxq1XoMGra7HctK1PMBAN1bA0djFg3EDWkMJumV1e2EYcVUmAG9LSTb+3ucVsEe6LjoTzvfQRGcOS8r5vSGIz77JKBLew5FDce+YcJqC61kmeiPjZ3B7GArkWRvuNRe1LDiYTrMOX8pD72KnNb7XjdQ4jr8Ndml6NjI7vxp3+ouD9oyyyYX1WiMunrWMablOQOC7A/SN3GLaj8OjANyuWf7uKprF25WI8LAY+HzPY709tnnA8XuEPXlshCcgL5N79BlUz0F7ZTFScVVKkLocBQfPs/N9He5gAaM/ZAQ9CTEEx2BNtMkw==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by OS3P286MB2149.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:194::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.31; Mon, 26 Feb
 2024 15:42:52 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::58f5:1590:22a9:6f6]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::58f5:1590:22a9:6f6%4]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 15:42:52 +0000
Message-ID:
 <TY3P286MB2611E440DA1D914C1A0307F7985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date: Mon, 26 Feb 2024 23:42:49 +0800
User-Agent: Mozilla Thunderbird
From: Shengyu Qu <wiagn233@outlook.com>
Subject: Re: [PATCH v1] net: sfp: add quirks for ODI DFP-34X-2C2
To: Andrew Lunn <andrew@lunn.ch>
Cc: wiagn233@outlook.com, "Russell King (Oracle)" <linux@armlinux.org.uk>,
 hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <TY3P286MB2611C0FA24318AA397DB689B985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <ZdyahVYAhPgf2Xqn@shell.armlinux.org.uk>
 <TY3P286MB2611BD62C30B37A5BE02D3C5985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <ZdyiigYNGf8WVZNu@shell.armlinux.org.uk>
 <TY3P286MB261155090B2D07593901C0DE985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <b8fdb5df-57e4-491a-b310-e8e13a89d331@lunn.ch>
Content-Language: en-US
Autocrypt: addr=wiagn233@outlook.com; keydata=
 xsFNBGK0ObIBEADaNUAWkFrOUODvbPHJ1LsLhn/7yDzaCNWwniDqa4ip1dpBFFazLV3FGBjT
 +9pz25rHIFfsQcNOwJdJqREk9g4LgVfiy0H5hLMg9weF4EwtcbgHbv/q4Ww/W87mQ12nMCvY
 LKOVd/NsMQ3Z7QTO0mhG8VQ1Ntqn6jKQA4o9ERu3F+PFVDJx0HJ92zTBMzMtYsL7k+8ENOF3
 Iq1kmkRqf8FOvMObwwXLrEA/vsQ4bwojSKQIud6/SJv0w2YmqZDIAvDXxK2v22hzJqXaljmO
 BF5fz070O6eoTMhIAJy9ByBipiu3tWLXVtoj6QmFIoblnv0Ou6fJY2YN8Kr21vT1MXxdma1e
 l5WW/qxqrKCSrFzVdtAc7y6QtykC6MwC/P36O876vXfWUxrhHHRlnOxnuM6hz87g1kxu9qdr
 omSrsD0gEmGcUjV7xsNxut1iV+pZDIpveJdd5KJX5QMk3YzQ7ZTyiFD61byJcCZWtpN8pqwB
 +X85sxcr4V76EX85lmuQiwrIcwbvw5YRX1mRj3YZ4tVYCEaT5x+go6+06Zon3PoAjMfS1uo/
 2MxDuvVmdUkTzPvRWERKRATxay28efrE5uNQSaSNBfLKGvvPTlIoeYpRxLk7BN0xi/KZIRpS
 lIf0REc1eg+leq2Hxv7Xk/xGwSi5gGxLa6SzwXV8RRqKnw2u6QARAQABzSFTaGVuZ3l1IFF1
 IDx3aWFnbjIzM0BvdXRsb29rLmNvbT7CwY4EEwEKADgWIQSX5PUVXUNSaGVT2H/jUgzJGSnI
 5wUCYrQ5sgIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRDjUgzJGSnI57GwD/9O6kei
 9M3nbb1PsFlDE1J9H27mlnRWzVJ2S3yJ8G1oJo8NSaRO7vcTsYPBYpEL1poDQC5MEGh6FXSi
 OnyyHrg8StmGLksQE9awuTnlnQgvXDQMVtm87r1abBAavP5ru2R9x/Tk63+W/VT2hPekMfHa
 JwFi1KATSI1AhsF3CVoj0yDulz1u0uZlircKdbeEDj+raMO0LA12YxWaWtL/b9XaoAqV9vor
 aKhx+0DsZS5bWoUvs+715BArPBr4hPqKavsBwOWfzWDTKln2qv8d+glWkmk6dgvZFcV/9JEJ
 Q8B7rOUMX614dqgwi1t71TI0Fbaou3nhAnES1i1it/aomDUCLvRwjGU2oarmUISFgvZoGYdB
 9DfVfY3FWKtfDJ9KLUk9k3BFfBZgeAYoLnFZwa3rMyruCojAGTApZtaaLZH/jzQf7FpIGGhD
 YnvGKXS01nLCHuZSOEvURLnWdgYeOtwKW1IIcnWJtB12Ajz2yVu3w4tIchRT3wekMh2c3A3Z
 DeEjszezhFyXgoRpNYDBzNl6vbqhnopixq5Wh/yAj6Ey0YrIUbW9NOhIVCGkP4GyJg756SGz
 yPny0U4lA+EP7PS3O7tE0I3Q5qzDH1AEH2proNlsvjZeG4OZ9XWerI5EoIxrwZcOP9GgprB4
 TrXUR0ScTy1wTKV1Hn+w3VAv6QKtFM7BTQRitDmyARAA0QGaP4NYsHikM9yct02Z/LTMS23F
 j4LK2mKTBoEwtC2qH3HywXpZ8Ii2RG2tIApKrQFs8yGI4pKqXYq+bE1Kf1+U8IxnG8mqUgI8
 aiQQUKyZdG0wQqT1w14aawu7Wr4ZlLsudNRcMnUlmf0r5DucIvVi7z9sC2izaf/aLJrMotIp
 Hz9zu+UJa8Gi3FbFewnpfrnlqF9KRGoQjq6FKcryGb1DbbC6K8OJyMBNMyhFp6qM/pM4L0tP
 VCa2KnLQf5Q19eZ3JLMprIbqKLpkh2z0VhDU/jNheC5CbOQuOuwAlYwhagPSYDV3cVAa4Ltw
 1MkTxVtyyanAxi+za6yKSKTSGGzdCCxiPsvR9if8a7tKhVykk4q2DDi0dSC6luYDXD2+hIof
 YGk6jvTLqVDd6ioFGBE0CgrAZEoT0mK6JXF3lHjnzuyWyCfuu7fzg6oDTgx3jhMQJ2P45zwJ
 7WyIjw1vZ3JeAb+5+D+N+vPblNrF4zRQzRoxpXRdbGbzsBd5BDJ+wyUVG+K5JNJ34AZIfFoD
 IbtRm3xt2tFrl1TxsqkDbACEWeI9H36VhkI3Cm/hbfp2w2zMK3vQGrhNuHybIS/8tJzdP3Ci
 zcOmgc61pDi/B6O2IXpkQpgz+Cv/ZiecDm1terRLkAeX84u8VcI4wdCkN/Od8ZMJOZ2Ff+DB
 bUslCmkAEQEAAcLBdgQYAQoAIBYhBJfk9RVdQ1JoZVPYf+NSDMkZKcjnBQJitDmyAhsMAAoJ
 EONSDMkZKcjnnIcP/1Px3fsgNqOEwVNH7hm0S2+x/N/t3kz50zpKhczHZ8GWbN3PPt4wkQkd
 bF+c7V4uXToN4a17bxGdUnA9qljxt8l3aEqd4jBqLn2OJriu21FSnrZOpxb1EwWwvnVUwrLx
 CuV0CFQJdBlYp2ds64aV8PcBOhQ62y1OAvYpAX1cx5UMcHsNVeqrWU0mDAOgvqB86JFduq+G
 mvbJwmh3dA8GnI2xquWaHIdkk06T55xjfFdabwEyuRmtKtqxTP/u6BzowkV2A/GLxWf1inH5
 M81QgGRI2sao6To7sUt45FS+y2zhwh62excOcSxcYqKzs/OiYEJjWMv9vYRwaqJGEVhbfGFO
 jeBOYr+ZCCeARh+z4ilo1C2wupQT8VPsFiY9DRYgkAPKlbn9OqJvoD7VhvyelJagSNuRayrr
 mnEaZMsoRdS22fneCVWM0xlGSgPCVD0n9+6unTnVbmF/BZsEg5QufQKqlFSomu1i23lRDPK/
 1aPc2IoxcQPh2fomy8spA5ROzOjLpgqL8ksEtQ75cBoF1K5mcC2Xo1GyDmdQvbIZe+8qwvQ3
 z9EDivvFtEByuZEeC5ixn4n/c9UKwlk+lQeQeN+Bk7l8G9phd4dWxnmWXQ/ONR/aLzG+Fguu
 GNZCPpu5dVQH44AXoFjoi9YVscUnWnv8sErY943hM8MUsMQ5D0P2
In-Reply-To: <b8fdb5df-57e4-491a-b310-e8e13a89d331@lunn.ch>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------EIwCMn8VKILnlpgaLfJAodlK"
X-TMN: [2vftrkZeUVqkIvdy1/L1Gn17IA/H6KHYlk9MLLSTFaMjJaZAT72seeD5oCQpxUJU]
X-ClientProxiedBy: PUZP153CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:301:c2::16) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID:
 <aee3bd70-dfa5-4fad-b36f-610a4e49a6be@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|OS3P286MB2149:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b6bfb4f-0c23-44a8-a086-08dc36e197d4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JGtGp4SKd7HOxp7Azqohe2KlkMnsgEBye3tRljrEKOQZ1iMetr0T86HJzunA1WVVI116kJApBZX64pJ8JTtOPSudZ6vD3NtN3JhOoxCw8IcGA4RgWaIjLUFWbFNaqOuw32BS0xZ98aR1r7bBxbUeaoO9l5ZSjWOZhAUp3GCfsHSmPyZGwn0+M+9JO0GWh6uWgeej+dpf898d4t2OS4YVXsPAmF0Y6qpWQNhDDE3yT9YAtOnW8VXbHOHhfL3hr9cr4lx0PLTqexxVc/yohfeC6HZaVL2tKmEdgrrCxrEkVltwaR2VDRWd3HASNgwmYEVLVO9Asamq+UGaP60LvRYc8ABGf85M14scapCRHOvdK158p4QvRfZoT/5xsHeajMg8kCQ9nDbpsZfOiA6WQgttTkOKVrOyQmI0kmCmymVHfy2qp/5SvGhJr6i5xBr5ly+cFvVejsbMR+hXlZJ5XfgFnSEpoTpJ6lwnQXb5IJSyjJbW3o/7hw+vzm2Wrrfa5wQO0MX5eNgXddoSFUNZIn8YEBR9qOnzXd7MNrG17kg6TOyBVA+gFwt7Dk4LT/T6u4BImMVBgp479/to1rUvvkMgNKYHdXZvRfqTBTbqTlNGubdTm6OvqjsnLFEWNPs6X4yEVXCIegL+ARJP9Gf3UYoB8Q==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTN0SnNPSGRMZWNNT0ZFbXJGVnJnWnhYQ0dBVHJoY3RxR3J2MXNIS2NSYzRu?=
 =?utf-8?B?d0ZwNG8yQThtRFI3YWNVQnovM2x6STFVN3lmVkpFalRCcFNiKysyS0dDSEtI?=
 =?utf-8?B?cDFBN3o0Ny9LOUJwN1RtUTk5clRac2hxMFVpN2pSSS9pNHQwV1IyNktvOWRq?=
 =?utf-8?B?V0s4MG9VVkE2OGpHN2wvUXNWSjAwb1ppUTRmU1pndFpEbWJYR3lGNllseHpm?=
 =?utf-8?B?OXVYbUM1U0RtMGxuMjFobThoRjRrcVoyQ3JLQjBRU040a2RnQWRQYW1ZVjU1?=
 =?utf-8?B?dlZwSVhMWXZWekFVb20wQjB1ZUN4TWdtaFljU1lUVzdVcDh4YjNnaGsvdHVm?=
 =?utf-8?B?L3Rob3dwc0tNY0pjbkJaZHgraHVsbllkL2RETjVBQktaZ0V2SVhJS2FnVm1I?=
 =?utf-8?B?cEVqMVJDNCtDTFNNK3B1bHp5QmVya0QycHhzU0QwRnRIZDUxT25VSHFhY0J6?=
 =?utf-8?B?YmRsRndtenJxMEhadng5UUgxRjVkdWQrZWNwNml6RDF0QW9OdUVyNVdYN1RE?=
 =?utf-8?B?aENpenN6cHFxMEZsa0RsWnBvSmZWQ1Fwc0ZpTEt4SEJCajVjczAyVGZiTkNX?=
 =?utf-8?B?SDlHd1Rsa3liMmN2YkEzQjcvQXgyQi8xS1J2UE5LNzhzRkxHdDNOeUFkL016?=
 =?utf-8?B?S0Z3RmRaaWs2YTNESXlHUWFMTGlaMFZzeCtXRHRzbnFnc2poNEI2Wmt4VDc4?=
 =?utf-8?B?Qjlmcm11c2xMNXhQUmdZaVo0WTUybG5XcjhDYkxvbml6UVR2aHZGN084R0JE?=
 =?utf-8?B?Y1B3OFo0aVNiRS8vOWNIOTVnb3NHT3FCYTIrWitIZTUzR0hudktYVlFJM284?=
 =?utf-8?B?S2lid3IybE5DSE1STHFoUkVnRVpkUFZFcDg1SUVSRzdmWWlwa0J3NzhhY2xJ?=
 =?utf-8?B?TVU1ZmRBT05tQ2NpSHUzZEZoeDFIQTA0SVhNZ1lnNG15c1djSE5zYk9temYv?=
 =?utf-8?B?a2hONkhBMU9RcGNTbGxjNThJWDd3ZEZReGs4dkRCaUs1OGZ0RERVTHAyVkFR?=
 =?utf-8?B?NmdlRDVWcy9JakxmUkh4VjVPV1R2bDNkVVk5NGluQitVMEVmZWU4ZmhaQUpq?=
 =?utf-8?B?VFl4Z2U4c3FIZ0ZpRUdsbVl3cTB3RnZYTkQ4ejBPQ1o0VGRaTlh4MHB1a05W?=
 =?utf-8?B?VFRDcFVjN3hBOUR3Rk8rejZ6c1p0VE40b3N2WTZXN0R2a011akR5N013c2Ex?=
 =?utf-8?B?dVg3QzIyOFB0RmJaUkJXTjVtTExWWkM5SGJKQTE5VzRFTnNkRFF0UHc3OWp5?=
 =?utf-8?B?U255YUw5b2lUTkViUnQ0RGlJTHZ4M2txRUpsczJ1VU5NbEl4dm03ODk5MDZT?=
 =?utf-8?B?WDBTV3hKZVpNdU9kUTBMMSt4bTNQOEhCMC9Cb2d2T2RET0dKMWxsNWFJaGsy?=
 =?utf-8?B?THk2YjhzSW13ekhmRnJyencyZ1pjczhneDVjVmsyWk1xTENNS0VmaWx5bWts?=
 =?utf-8?B?VnJta2xMdmY1bWF0L1JTMSsxSmJ3WTZSVGlwMm9WUkxmZURpamphYkU2VHE5?=
 =?utf-8?B?T2lSN3cvZTFUWEYxdittaWFQRisrL1Q5M24zL0tmRlM0TEcxNGtaYndmaW4z?=
 =?utf-8?B?U0JzTjBuMUhuMm1Gdzl0a2RpT01yY3Vvak8xTVdlRHRPMUEwVm1PeHFPZWR2?=
 =?utf-8?B?c2lOODZJR29wOEJUakp6MmtxcmxBZHJiaThoVmtJQXVHQkplZzRqVnVydmVa?=
 =?utf-8?B?Zzk5OGZ2VlJ4L0ZTcTNRTUthWlBhRDE3VEtPMjEvTXpmN2dFS3R4M0YyVFN4?=
 =?utf-8?Q?L7Pw240zgLY0RqMOd8=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b6bfb4f-0c23-44a8-a086-08dc36e197d4
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 15:42:52.4087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2149

--------------EIwCMn8VKILnlpgaLfJAodlK
Content-Type: multipart/mixed; boundary="------------FjqLCVDAbKV8xiWvO0bcHrOg";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: wiagn233@outlook.com, "Russell King (Oracle)" <linux@armlinux.org.uk>,
 hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Message-ID: <aee3bd70-dfa5-4fad-b36f-610a4e49a6be@outlook.com>
Subject: Re: [PATCH v1] net: sfp: add quirks for ODI DFP-34X-2C2
References: <TY3P286MB2611C0FA24318AA397DB689B985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <ZdyahVYAhPgf2Xqn@shell.armlinux.org.uk>
 <TY3P286MB2611BD62C30B37A5BE02D3C5985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <ZdyiigYNGf8WVZNu@shell.armlinux.org.uk>
 <TY3P286MB261155090B2D07593901C0DE985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <b8fdb5df-57e4-491a-b310-e8e13a89d331@lunn.ch>
In-Reply-To: <b8fdb5df-57e4-491a-b310-e8e13a89d331@lunn.ch>

--------------FjqLCVDAbKV8xiWvO0bcHrOg
Content-Type: multipart/mixed; boundary="------------IhKoCY1d5BjC5gom5SgA7nil"

--------------IhKoCY1d5BjC5gom5SgA7nil
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgQW5kcmV3LA0KDQpTbyBJIHNob3VsZCBkZXNjcmliZSBpbiBjb21taXQgbWVzc2FnZSB0
aGF0IHVzZXIgc2hvdWxkIHNldCB0aGUgc3RpY2sgdG8NCjIuNWcvYXV0b21hdGljIG1vZGUg
YW5kIGluY2x1ZGUgdGhlIGxpbmsgaW4gcHJldmlvdXMgbWFpbD8gSXMgdGhhdCBlbm91Z2g/
DQoNCkJlc3QgcmVnYXJkcywNClNoZW5neXUNCg0K5ZyoIDIwMjQvMi8yNiAyMzowNiwgQW5k
cmV3IEx1bm4g5YaZ6YGTOg0KPj4gV2VsbCwgdGhhdCBzZWVtcyBzb21lIGtpbmQgd2VpcmQg
dHJpY2sgaW1wbGVtZW50ZWQgaW4gdGhhdCBjaGlwJ3MgU0RLIChtYXliZQ0KPj4gaGFyZHdh
cmU/KS4gSXQgd291bGQgYXV0b21hdGljYWxseSBkZXRlY3QgdGhlIHNwZWVkIHJhdGUgdGhh
dCBob3N0IHVzZXMgYW5kDQo+PiBzd2l0Y2ggdG8gdGhhdCByYXRlLiBUaGUgc3lzdGVtIGxv
ZyBvZiB0aGUgc3RpY2sgc2hvd3MgdGhhdC4NCj4gDQo+IFBsZWFzZSBjb3VsZCB5b3Ugc2hv
dyBzb21lIGV4YW1wbGVzIGZyb20gdGhlIHN5c3RlbSBsb2cuDQo+IA0KPiBJZiB0aGlzIHBh
dGNoIGlzIGFjY2VwdGVkLCB0aGVzZSBkZXRhaWxzIG5lZWQgdG8gYmUgaW4gdGhlIGNvbW1p
dA0KPiBtZXNzYWdlLCB0byBleHBsYWluIGhvdyB0aGlzIGFjdHVhbGx5IHdvcmtzLCB3aGVu
IGl0IHNob3VsZCBub3QNCj4gYWN0dWFsbHkgd29yay4uLi4NCj4gDQo+ICAgICAgICAgQW5k
cmV3DQoNCg==
--------------IhKoCY1d5BjC5gom5SgA7nil
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBGK0ObIBEADaNUAWkFrOUODvbPHJ1LsLhn/7yDzaCNWwniDqa4ip1dpBFFaz
LV3FGBjT+9pz25rHIFfsQcNOwJdJqREk9g4LgVfiy0H5hLMg9weF4EwtcbgHbv/q
4Ww/W87mQ12nMCvYLKOVd/NsMQ3Z7QTO0mhG8VQ1Ntqn6jKQA4o9ERu3F+PFVDJx
0HJ92zTBMzMtYsL7k+8ENOF3Iq1kmkRqf8FOvMObwwXLrEA/vsQ4bwojSKQIud6/
SJv0w2YmqZDIAvDXxK2v22hzJqXaljmOBF5fz070O6eoTMhIAJy9ByBipiu3tWLX
Vtoj6QmFIoblnv0Ou6fJY2YN8Kr21vT1MXxdma1el5WW/qxqrKCSrFzVdtAc7y6Q
tykC6MwC/P36O876vXfWUxrhHHRlnOxnuM6hz87g1kxu9qdromSrsD0gEmGcUjV7
xsNxut1iV+pZDIpveJdd5KJX5QMk3YzQ7ZTyiFD61byJcCZWtpN8pqwB+X85sxcr
4V76EX85lmuQiwrIcwbvw5YRX1mRj3YZ4tVYCEaT5x+go6+06Zon3PoAjMfS1uo/
2MxDuvVmdUkTzPvRWERKRATxay28efrE5uNQSaSNBfLKGvvPTlIoeYpRxLk7BN0x
i/KZIRpSlIf0REc1eg+leq2Hxv7Xk/xGwSi5gGxLa6SzwXV8RRqKnw2u6QARAQAB
zSFTaGVuZ3l1IFF1IDx3aWFnbjIzM0BvdXRsb29rLmNvbT7CwY4EEwEKADgWIQSX
5PUVXUNSaGVT2H/jUgzJGSnI5wUCYrQ5sgIbAwULCQgHAgYVCgkICwIEFgIDAQIe
AQIXgAAKCRDjUgzJGSnI57GwD/9O6kei9M3nbb1PsFlDE1J9H27mlnRWzVJ2S3yJ
8G1oJo8NSaRO7vcTsYPBYpEL1poDQC5MEGh6FXSiOnyyHrg8StmGLksQE9awuTnl
nQgvXDQMVtm87r1abBAavP5ru2R9x/Tk63+W/VT2hPekMfHaJwFi1KATSI1AhsF3
CVoj0yDulz1u0uZlircKdbeEDj+raMO0LA12YxWaWtL/b9XaoAqV9voraKhx+0Ds
ZS5bWoUvs+715BArPBr4hPqKavsBwOWfzWDTKln2qv8d+glWkmk6dgvZFcV/9JEJ
Q8B7rOUMX614dqgwi1t71TI0Fbaou3nhAnES1i1it/aomDUCLvRwjGU2oarmUISF
gvZoGYdB9DfVfY3FWKtfDJ9KLUk9k3BFfBZgeAYoLnFZwa3rMyruCojAGTApZtaa
LZH/jzQf7FpIGGhDYnvGKXS01nLCHuZSOEvURLnWdgYeOtwKW1IIcnWJtB12Ajz2
yVu3w4tIchRT3wekMh2c3A3ZDeEjszezhFyXgoRpNYDBzNl6vbqhnopixq5Wh/yA
j6Ey0YrIUbW9NOhIVCGkP4GyJg756SGzyPny0U4lA+EP7PS3O7tE0I3Q5qzDH1AE
H2proNlsvjZeG4OZ9XWerI5EoIxrwZcOP9GgprB4TrXUR0ScTy1wTKV1Hn+w3VAv
6QKtFM7BTQRitDmyARAA0QGaP4NYsHikM9yct02Z/LTMS23Fj4LK2mKTBoEwtC2q
H3HywXpZ8Ii2RG2tIApKrQFs8yGI4pKqXYq+bE1Kf1+U8IxnG8mqUgI8aiQQUKyZ
dG0wQqT1w14aawu7Wr4ZlLsudNRcMnUlmf0r5DucIvVi7z9sC2izaf/aLJrMotIp
Hz9zu+UJa8Gi3FbFewnpfrnlqF9KRGoQjq6FKcryGb1DbbC6K8OJyMBNMyhFp6qM
/pM4L0tPVCa2KnLQf5Q19eZ3JLMprIbqKLpkh2z0VhDU/jNheC5CbOQuOuwAlYwh
agPSYDV3cVAa4Ltw1MkTxVtyyanAxi+za6yKSKTSGGzdCCxiPsvR9if8a7tKhVyk
k4q2DDi0dSC6luYDXD2+hIofYGk6jvTLqVDd6ioFGBE0CgrAZEoT0mK6JXF3lHjn
zuyWyCfuu7fzg6oDTgx3jhMQJ2P45zwJ7WyIjw1vZ3JeAb+5+D+N+vPblNrF4zRQ
zRoxpXRdbGbzsBd5BDJ+wyUVG+K5JNJ34AZIfFoDIbtRm3xt2tFrl1TxsqkDbACE
WeI9H36VhkI3Cm/hbfp2w2zMK3vQGrhNuHybIS/8tJzdP3CizcOmgc61pDi/B6O2
IXpkQpgz+Cv/ZiecDm1terRLkAeX84u8VcI4wdCkN/Od8ZMJOZ2Ff+DBbUslCmkA
EQEAAcLBdgQYAQoAIBYhBJfk9RVdQ1JoZVPYf+NSDMkZKcjnBQJitDmyAhsMAAoJ
EONSDMkZKcjnnIcP/1Px3fsgNqOEwVNH7hm0S2+x/N/t3kz50zpKhczHZ8GWbN3P
Pt4wkQkdbF+c7V4uXToN4a17bxGdUnA9qljxt8l3aEqd4jBqLn2OJriu21FSnrZO
pxb1EwWwvnVUwrLxCuV0CFQJdBlYp2ds64aV8PcBOhQ62y1OAvYpAX1cx5UMcHsN
VeqrWU0mDAOgvqB86JFduq+GmvbJwmh3dA8GnI2xquWaHIdkk06T55xjfFdabwEy
uRmtKtqxTP/u6BzowkV2A/GLxWf1inH5M81QgGRI2sao6To7sUt45FS+y2zhwh62
excOcSxcYqKzs/OiYEJjWMv9vYRwaqJGEVhbfGFOjeBOYr+ZCCeARh+z4ilo1C2w
upQT8VPsFiY9DRYgkAPKlbn9OqJvoD7VhvyelJagSNuRayrrmnEaZMsoRdS22fne
CVWM0xlGSgPCVD0n9+6unTnVbmF/BZsEg5QufQKqlFSomu1i23lRDPK/1aPc2Iox
cQPh2fomy8spA5ROzOjLpgqL8ksEtQ75cBoF1K5mcC2Xo1GyDmdQvbIZe+8qwvQ3
z9EDivvFtEByuZEeC5ixn4n/c9UKwlk+lQeQeN+Bk7l8G9phd4dWxnmWXQ/ONR/a
LzG+FguuGNZCPpu5dVQH44AXoFjoi9YVscUnWnv8sErY943hM8MUsMQ5D0P2zsFN
BGK0OekBEACw8Ug2Jo4DF9q3NFOZ7/Vwb6SlKpj3OdBjGTPwRZjV4A5CzbEqXrkl
TKFNE9CRbxyoNXN1UXXrBb7VHKgyu0rnGPqOb0rtUABz+wMvYuShKOPcWmg6n9Ex
9UGIsYBMJ01IQMU87qcZUmfxo5eYfniyBnOGB+pbVf1jhOhZWIXlVdmxYbMc+xeh
W+VHI98BiL14vXWFmpBWFc85BO4AbijDzPtkZhPvB9mj2he+z/XUND+nG3to7xAY
I0Kxacw55w8HL35Nuv+G7EtUWX5uhpO/dDB0BMcW05s6L6rebpEAAMFVBKIAJUKy
pvTYcAN+E7yfQAzvl8mNtcVMsFHTr54wTSHR0Xx32G72Ad7dkeqy8HhfkT1Q/5V/
xzUz1qgmtQtWgA6jnSCYISGOXMjnFhzMG3DVuE5cI/RaPlybHfBsqrtQoxeMMoX1
qD3Tt3TvwFojOEw4KE3qz1zTcozqLHScukEbNhlcLRUv7KoqSIcnN56YEnhjMu9/
ysIbFuDyQo9DaieBBWlwTiuvq5L+QKgHsGlVJoetoAcDojCkZxw6VT7S/2sGCETV
DMiWGTNzHDPGVvutNmx53FI9AtV09pEb2uTPdDDeZZhizbDt0lqGAianXP+/2p1N
Zh0fMpHJp+W4WXPQ+hRxW4bPo/AXMPEZXkaqqDrMcsTHrwrErCjJ5wARAQABwsOs
BBgBCgAgFiEEl+T1FV1DUmhlU9h/41IMyRkpyOcFAmK0OekCGwICQAkQ41IMyRkp
yOfBdCAEGQEKAB0WIQRP/KgY/enlmX5EpW5fvkoEB8mxGQUCYrQ56QAKCRBfvkoE
B8mxGVNQEACNCgyibR1+BY00hem9CCIZGHqyWfJn9AfiPYIY1OB80LUJXhJULtT8
DeUUOgMZtywhJvu4rIueOufVzeuC5P0lfO4htBmi2ATQu8bT2h0YxcNL3YKYFoqe
+FiVI7RxR1G2C+fDecyCXUrPtry++NiXdLVeFdDxumCuHZKffqiqFpL/8yDLnaoc
3aVHPT2Wv0iDU1JeSOC5LKPWFNznA5ZX6uxfiKzSc4E1qi/vr+1twXqwiwfIc9Ib
NniN59mzfXyKd64Geu1UT2wf1dZzVAcsXWDM4orCyx11eVh7ZKPmmVe9mpwcdh+s
4t76/WDFbbUe6ZSixOwINRUn16CvUNBxpCKI5RXmpCLj8Z+oUBpyR6c1sdw0uk7F
o4TcjBsvQXtpkewqyXXyy4NcCpveWPICbh8RmvZx4ScTufXH0FmLMkthuRgH+TqD
HHFvKNyhHoXWeIQT7oez28oY2a81CKQ+m/TkgNeA6vqmBZYJ1kKK6nc3vbFLc4Jk
2SRVCNpIvr+E38hxHz5e2n6dtgfgCCb2EEA83TjmX8/2dWZJA4ndML7AaCjw3Xqr
NbTrVgP99oH+D+7tFxJ+LlLAhIjKs1efKEFlOsXH7QqyO13BUYldhFL+2KjrNFoG
X9s7f57xIaqwdTd/okf4eBNYkg1+Pcj/AMgEAvRcagMATy2pAGmxMF2YD/9Z6y3I
oPB+lkSrP3AE1fhBRL/OH7UaLB4pyCpeGLhG5X8xdM9dwRPX+kadflKH2F0GPqUi
x5O1tJUMEdCb/WpQ9gUAb6Ct1Zntis8hd8pNQIGUT+kpwnpiLVEhbeg5DX459ho8
N+o6erYR34cUz4o0WFa1TVNFQGKRTWfzyUxxGUUcW2QC5mCwPCPZv69zvW5c0Ddi
RwUcYGGruslC7cHWXbO8zQ/R2zQcCjnyIniqoyQDTsQlK1oBM6iQMALhej6fsMe7
zWlA8/0FNj27Ub6biaWmK9aohWTkZtv7bD3IKaQRaq/lBg+2OmDGrSHNREt5T4EO
85QqMJLnjzQ2/FbA62E+piWzRaChJVUy0Ol6SVJHGascnqT4fWBX0lpZx9A7+XQh
CtCbX7ETzHPzugeXXyAhVuleaV+yzoSc9+aF2y38WrFczSzFX5APegWZ/8JxEbhJ
KqOwqSlC+IMwblPA3naZbCiKuTYxiU0Ys3CSdZeFFvSXuvhLJk185anQQjQS874J
8pkvTd2ueYxp46hde0rCZaAKlhNrp3G1NNUpt5QpjLan6NhmpQ42XfILC4v1Qg7A
T4vGG0QPhmMhbGgPn+44EYuh8/941mkyaYL0fXyu6l2HoKEZiLerr8vqgc08NvAl
QW/1QnKz4zA5XUvOrxQsLFF9ie2eG6DWJkdh1M7BTQRitDoIARAAtZRhbhuAfenu
NS2kPytShodMn4bfP1lSNi/P6vSWVym6s+bQPIbuRYfNvMZMKR1hPF93ERpSCAx9
bEsLtXJ3w9p2gFOUkn77sw/14v0jPJokQbTfg3dO0PKb+/89q1oVuOyGLhgXW1P/
ZGdIred56i2vsVfz7NmvPkSATr1bPTocYgpqdGf1+FQp8pDN60aXQ0RJ7rZpOTGx
/5BvgeraLXCbpy3ibaJF92HDU5QM1AeBs7LpXybFc+DZ+wktULeKemAF2EDnFauQ
CfGi66MHXGz2Dgy77ladSpz+OvpLTMpubzVeiGXwkNsa/Fs6lv1+arY2dUtHjvvU
0kLf/arNT+mOCMD8c2aOapgUQhOhM2U2OwRgbJ1y6OVKyN0UN76kDpKSpSsQelpV
/TfUk4LMTOB+rIfeAwG0NfKsYCzxV2dvX9E4wgAupsryeHYhidFuUwQncPqckOVg
xXCwOA6GGtMVEQFR0snuVn4ulLgAJy0rJXbYSj8vac4V67X6l2CK8xvgvZUgm2C/
MoV9XcjoxQzNIMySFDNBmM+rtTOW7Rxn1mlI7se5TOKAlnq+cTuLAu+L/LKNRSoe
dKYsUUTjHGmewyUNlcHHHQcjMS3jwzZ2a9+YP5KpKJCsT/eqBZoiPAL6V9iCBiM+
02BKe2R86wK8OqehvxvR2mpFwVPk/H8AEQEAAcLBdgQYAQoAIBYhBJfk9RVdQ1Jo
ZVPYf+NSDMkZKcjnBQJitDoIAhsgAAoJEONSDMkZKcjn/ecQAJ1Da87OZQnYugWr
vPQOfsdV9RfyyXONrssGXe8LD/Y6rmzZVu+Bm49F9TF0Qxc+VOrJpv9VVsfOqFJi
0wykOwyESdVngNrAW9ZWzfIvkEDSpTlaxvzbNEY7pBpvb1xFoSMrou1ro3299XKf
tlA29RYHiwH1HIC1JPJBWsS4tlahZ9AtGo5p5wVoEKxN6D/SrjLCcFiQJlH1yISc
sZVFm3qgTuo2g0uzJM0o1Y2B7T8mK/rsm3hUHJlbCrPl/rkYEAlhSUKpawKhldRh
OeqUUCcjnfdmFgTH/HtTMIlEQA+Ck/T8M5+Zp/nhCpPCx0pTuDdUTRo3tWHL+Nri
wK+AuZNR+0pevuTYOyD6CV0Hng/3lU86i3gN16GVxNWQjUdQ1ps9InaQhLxsgevQ
msgzOqo6GUiHQIdxvAtcG7pXv7HRhxsZA+68h8lixiMeE1W30PH1nxn5gN/Ekldj
c5F9xBu1/vTSX9dGzer1zZZFn4J8lbD6R+keOaroF8Q9S1cYnQbh3vASshmzNgi+
ISmLtR1a4zjxY2AlKNv+jkdpItjot5dewxVeU5x5i1sXWJ3Dt4xNyFSs2PZs1IuP
Solmy00hVZdFiGmr8QuMmOo6YagSdVvrryw812k5vAskD5AMC9EGru1Y8e9FddsL
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------IhKoCY1d5BjC5gom5SgA7nil--

--------------FjqLCVDAbKV8xiWvO0bcHrOg--

--------------EIwCMn8VKILnlpgaLfJAodlK
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmXcsXoFAwAAAAAACgkQX75KBAfJsRlI
hQ/7BfKXGnCvVyA8lG5zi9Ssu9+Z95lX2RaSC5QM+zp8Wv/vJlcbHYMfj363CPdwU7GsOTFJMjCc
klQD8nNWLhac3NH21m5qk+WKhFACRdIyB43oFrsNijGc7TBlu+5zzlayfufqJgL19RQMX3QBrXy+
jHTReDiii9XmB+C64KDktx/ywRSabGWwZcn5Miul0MZ1soUddI7Z5GNh4bfzaHw2O3QRC43st5cu
3Hc6wDNlFCwORMm5Lv1mJVmbBUmKsdmC1J6c8N7X8YEvlINxs7pGqKPlgZ9ojcA8FgSb6N0qK/FK
z859v8lK3KyJxiM6y7dPCi6GEz1SXrWmpHibsALSfg85VJbEFK9ZdnP43w/ektJeJEPkxD9PZDgO
0oiQu4cKJ6rzGvBvexw8g8tGllN3FTYYKbq/5Iv29DsIhxrgKg8J7iXpyhpQ3fp8FXtmPZ1z4VZC
uqUbn60fbNQiJ/O4lXt4xjGhOLSoj5G9qX8dThw5JRLLGxPYRmgLA2hGYLfOSU1gL7qLxAYufLo/
za6SKjQBPBgNYboxjdqhTSXhDfO6+lMy0NOJYNgrmrc0dNnNSs7F0xcWni3jjAP7TFwizk2Ptuft
XEE9SpiZ8PJag21FI1PbddODIKqdaJovouzWdO7KJ0n9kTg8WdbVWN3YQFudq/FD5XGVknSJaLPi
/F4=
=LbST
-----END PGP SIGNATURE-----

--------------EIwCMn8VKILnlpgaLfJAodlK--

