Return-Path: <linux-kernel+bounces-128814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDBA895FE4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE28AB230DD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAC63E487;
	Tue,  2 Apr 2024 23:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="l2yHmJ8c";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="K/phMi8T";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Eyfj6/Aj"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E162260B;
	Tue,  2 Apr 2024 23:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712099182; cv=fail; b=rbvkKmPXwBWp5I5wRxAif33GPH2MjpTzPTwX4FLitGFBuW6+wOMfKnM7dHeIGLf35oPiN4h/ks6awwxsOa3Kb4d0rvEgbIkjn6J9dsVOYQ1LRlKsVvUY7Jmg2DcuSmm+cyrE1xsZvJdLfyW+SQD5o/ebi/SJ1aHUH2Gbo17RYEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712099182; c=relaxed/simple;
	bh=LSip8HG1CMDMtqI+7umoMQJEfZ137DjMeh2ohiWwKL0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LrEk2TJcozAu5/lM1keywLixcTqZGMMv0zTDytRMHwJEMzWzZ3ZPjuCzRWqJfPEkpA0OjNWpMx8jGwTrCf1SZzosqWv3NQTb4Ojv/lvrJ1MaeJO6Yzu4oWqkSe+D61ZhYNVdQ38bNZ2YrTEVZMuXTiVQPRs70evWN8Aj2alk7wA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=l2yHmJ8c; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=K/phMi8T; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Eyfj6/Aj reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 432IO3JC013531;
	Tue, 2 Apr 2024 16:06:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=LSip8HG1CMDMtqI+7umoMQJEfZ137DjMeh2ohiWwKL0=; b=
	l2yHmJ8cp7XNnsCcxfdVd9RDKDsQQXQ9fhBdde8tbKEuiod+BLhfTnXmCJEjmMfM
	/fYfViJqydBCigby3w/vy2ZwP7j2Mgw8pkDwUyJTJUATKJE5alQBi2inSmNTiv1d
	IJKqd6b+n7B8kG3MrGd+uJ6V1Ou/4v4ULyDgdAHMDAj17Rpc/sDy6DqGS5YhfyGI
	GtuF9LTGgPsdTwY05YI7ZtiMUKtMiezKbfVcYJ+3ALlPpRKAmOY80CGOmnRerHcn
	pZPt+ar0Jc/X+8ye0/3dRLhwNidt4QCH0CFuzxEbLyKGjFa+vAmvH1VSNgHNJk+K
	+wFo+VxUhj9ar0mce/OxKA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3x8q82gyxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 16:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1712099171; bh=LSip8HG1CMDMtqI+7umoMQJEfZ137DjMeh2ohiWwKL0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=K/phMi8TSEcGeEM3+od/8X5d6XYoPlHpxYlFJKsi9xBzNo7V4ZYnB8YeNwYY9BQRY
	 SD2sOsU65yXZPpSBMcZzFaEDXaYcpEsMMYLYGl25wlj5B73raZoQmaYmBRkwtOOxkA
	 MT2Kq0IHFeuO0rR69FE62pE0e4bO/O8mZjSl07ljYIpej+OvI9+XKMXN45ZiDh8dSI
	 L8SZ9b91K0dcyqZURpqhftXg/Crt4U6ug3jzRLoHnBWVFfH7ToKoKRpzB8yBIAlGRQ
	 L2MKQtVSGLUjRl81y5wKYV8ccyc5iF0Gk5vBv0CA1PXqj5Hw6E9EDhcCEkSegtbUSx
	 UI8AKbQUw86qQ==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D878F40349;
	Tue,  2 Apr 2024 23:06:10 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 3E3D3A0070;
	Tue,  2 Apr 2024 23:06:10 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Eyfj6/Aj;
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 6F8174034A;
	Tue,  2 Apr 2024 23:06:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GoIp+/8sHdt5pO828Su54WngJMNWIrODXNDi1wq3D0A7gi+vJo2euHKbakCbOIVRXFBwwF3AbrUbIRCPAhWD1N94jbcHo8kl6hJKPDO8qY/yRF0DER7XWA2jV251+ELSJKMujqoh0A+Ehx2sX7Mqfck1R7bVlehSSl9okxxVoPbuFXZVMG/Ps6Szi+GJVqgN2+8dZKFKo7ZMQh0Ii0o+YbrkJQXhO7fv0GD3m8qBjZovoGyJqL/CDLdsh5nps08oJv1Wr0853a8QWlf0gC/ABze6sh1EtE9wkEQC2p+ucF8rxO3DpSBPAnSvmp3Wwp0bUYbZ7PLHZj8UdgcJL0Z2rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSip8HG1CMDMtqI+7umoMQJEfZ137DjMeh2ohiWwKL0=;
 b=eQFGRTi5AyUy3/Fq4N9r3hRJU1ofUU6TfNm16A54D3ckwx0dauOlOAgrUyvs/TRunTtBoWXVyfNn520QjR1QuWaIHYVyddNw3bUYLGXSEB0OBLb1cKWXgTWPVKLhdinMLrIFP49tooZp0tMgJc9oTchmacvxkVQSWRJr+DoyUC7jE12tvNmmmZRVShGt5dAqyQXnlkeqieodkd4ieHsv2Nat5EKbkr8y7k8JksMzhb1UbK+pVfJD4HBajRfyTj3bzDGRBoaGYUxvSa2fb5OvD8dBtYJuOWhm1YAwDjqoB7NDfbq9tKAVUGwTi0fpPzpYdsVoSpWwJg1gdCz8cQloCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSip8HG1CMDMtqI+7umoMQJEfZ137DjMeh2ohiWwKL0=;
 b=Eyfj6/AjwjHhK21VHbtYKVYSUEjlR6F7nM37JrUVdYTlD/+vKeez1JLJJdT6DaGkWUK2EYojCsGyMTnevGueab8G5v1oR+xzVYDlR6khqUUkRMdP7rBcAzu5kKspA40eecP1rCsxSyCxxy+yjyozgKl4qDu+FqssJiPsnabyYKc=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.42; Tue, 2 Apr 2024 23:06:05 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 23:06:05 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: gadget: check drained isoc ep
Thread-Topic: [PATCH v2] usb: dwc3: gadget: check drained isoc ep
Thread-Index: AQHahUf+Fjbt0R5rsESCdAPrKfiIcbFVmhGA
Date: Tue, 2 Apr 2024 23:06:05 +0000
Message-ID: <20240402230555.xgt5uilc42diyr4m@synopsys.com>
References: 
 <20240307-dwc3-gadget-complete-irq-v2-1-8c5e9b35f7b9@pengutronix.de>
In-Reply-To: 
 <20240307-dwc3-gadget-complete-irq-v2-1-8c5e9b35f7b9@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DM4PR12MB6373:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 dNRTktTQWnmr42CBbhggAn8Y6SikCmkcBrdfsaCT616CUy/mcFqJLmh7vxFYEPfDYgJ0P0IPGUai4CRb1st1tD8bASUDO2KtdxzjmwgH08r7prJ3ztSe8OF8c06g9uEllawaY3sziTzBm656cVqw6U0bvZUoaEMhj7AbndfpoxZG6IDd9C8kdosDY3o0N4OniTKNKGzXHVMqgXRwAZUXxkxfX/4Ks9AtffI1ObqJolyGbRosTz7MeOjPoOpUbBTuDp8tY+tKqZ1ySohOhftK+zojG6kxO9EC/3DOGx+jtlxkK2jL+C5b2F16RlCHdc4UnHMBzMDT+ijv/XTJnG1EFLsGzzPfaQyf6qGgHn3IexbHWq+nWK/Rj1IWW7T+pvFeWKDjOUiCRxXWWZZmMLNiGGVVxh+iMeDvn03lSLaWu8w2FipIqi3WCjmU37nf7mo7dnZenKdbxLwG8iBz+ckFkEGWNj+w3B69zLaHrk1l3XEUo0hfZdfQqNdDWEc6UzQf9v6MNN85opl8N4/WUWoKliWziXwCDti9W8l2rehEArvGyzzXOtL4GXClbmt/7iGzcoQzWj4hR3QIk0fZVC9ixL1+A9+qlZMx6W/KBfPIVJk=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SGdnWE54UmpBQ3F4cWJiQjBqS042SGxJMzZ3Y21WS3I5UzNDZGRGZVZwVDdM?=
 =?utf-8?B?MVJKUGdjYkR0N0Y2Lzc4dzlma2EybVQ4SVhkcnZXeHZ1U3FzeTZ5RXRQWldY?=
 =?utf-8?B?NnU0U1lYMlBGOU4xNW1ZMGhvS2NkdVh0eElsTnZmK05iZE9RYkg2MlYvSy9k?=
 =?utf-8?B?Vy83VUIycFQ5VkJqZG9CaXlXM0VkN0ZyME1rQm1lTVgxNjZXdGtNelJOb0h2?=
 =?utf-8?B?TDFUQzdieGJrQTZqbDlPN3FvWitpcXhYVDB0NlM1UC8wWGNKMnc0WU04TDNh?=
 =?utf-8?B?UTJWbFN4eVJrOS9DYnNWNFZqd3BRZ2hGcDBUNTZXeDN3dm9UUkw5ZEMwZGtl?=
 =?utf-8?B?elBUZ0lmSnI1WVNEbGFWQjF1ejMxK3NINTNaV3dLcGtldDlheWI5ekJiRVJh?=
 =?utf-8?B?UWszeFFUQlhiY1htOUJJaUgvc2ZET3ordGYwcm1FZUoveUR3VU5OeTNxdXZ2?=
 =?utf-8?B?SjREbWNROU5IZW43WE5KaUFDVFpLRG4rb0g3SzlxNEdraXpQaHhmcGJFaDhE?=
 =?utf-8?B?MDZxUm5rM2Y4RGExamZwaWJDN0RvMlZ2YXZxZDhPVlROZ0ZaYXBJTnNGYW9H?=
 =?utf-8?B?aTR1U2JFWjZqK0tMbFB1YjBlMElBOHBISjEvb0UyRWpkUTdrL2svMHYvUnJ2?=
 =?utf-8?B?MENCbXlZZ3hDNnY5cGZkejVTZ0ZDVXRsVjZVMmR6ZnY3TlVzSTNDYmtuaWlh?=
 =?utf-8?B?Z2dqaXRyZno1R3JzRXNrV3AzRFVhd1RLNXlsa0NvNzh1Z3lWYWFHNnF1bEVK?=
 =?utf-8?B?Nm5aYmxWWTVMeHQ0T01VRUVzamJ4bkJXR1RVajZrNUtJMVpKVUhjRlZTM1VK?=
 =?utf-8?B?bXY1ZFhyS3NpWTJ3bnp4L0hER2tlYlVPeVdEcHo2M0tSS1pqUkpKRVQvM0JJ?=
 =?utf-8?B?S2pOdmNwRTloanJ3dEtCL1FyQWhpVS9rREFoblZHQkJZRitKbjRSanNLNVZZ?=
 =?utf-8?B?VXpQSkp3S3pLN1dRQ3lEN0k0dHc1b1NhMXgrTFRCU0RUWlNSZnMrelk3Z3VY?=
 =?utf-8?B?dUgzZVIyUTJPY0xieE9vdDl4dHVWYXVCK1d1YVVJczR1SCsrU0sxK0FPdjVG?=
 =?utf-8?B?U004MjZUVlBGZUtDMmIxcWx5dHhhQTgxSnA2NitpaGNJWVpuSElyZmV3YTlD?=
 =?utf-8?B?UVpPYUVxZ0ViVWZNVWF4a0Y0N3IwbE1TMGhuUzRTZmFKbEs0RkxQY3FRcUl0?=
 =?utf-8?B?UUNXQUFjY3dNcFBmMHFWQWVCbVdHeWgzbUJ4cDZHQncrM0I2MHR1enp4S0VQ?=
 =?utf-8?B?aSszQ2JYRHF2WGpkMjhJV1Y3YWRxbzVUMU1IcWFKNzdNUjNTL2lkT0x1blVl?=
 =?utf-8?B?cDdKcWg3c2s5QWdrYWFLb1BQOUw5Qk9hc0pESGdMQnhxZGxlcC85bm4xSDZY?=
 =?utf-8?B?bjBKYVNMU3paNkptSng4eXVUTjJZQXFmaEVkRjVmSEhNUzlwbzBwWVN2c0RQ?=
 =?utf-8?B?VnhSQnlWZ0M5V0NBcGFMTVcxVy9xQjB1ZDVaZXZySUV2L1oxaXpKV3AvaUl0?=
 =?utf-8?B?WmUxNm0vOVphNjM4dkVkN2h6dUNnaW5FNFRCQUR1czBRb3BYOTdPZ3RtOEc5?=
 =?utf-8?B?UzV2dFdSNGwvOUNER0tEZTA1djVweStvVjlRcElpdnR5YXBZZXlVL1VheENt?=
 =?utf-8?B?WUZucFZyMWhlckN1T3FSOElmekhJd3A1TmJ5S0xEVi9zZDdoMWcvK3dHazZo?=
 =?utf-8?B?RWhuMm9aSUlTelNMaWhNWDJWZUUwTEtBd1F6cU5OdUN0bkNRODlFc0hwbXRG?=
 =?utf-8?B?cmljUWsvMGNrUXdINnZDcTM3SGt0OHhFUDFURGZLVEc1SXFRSkhNOG5PM2JI?=
 =?utf-8?B?QXR1citWSm80RkI0T2NRT0hzYkRXUHFEd0pNS0YzNUY4UmtCa2kxYW1nL2RI?=
 =?utf-8?B?bld0dEhQQ3YvdUEwNXh3REYwQm1ORWpGYStVZjN3ZnhFY1VQcnoyd3dHUDdU?=
 =?utf-8?B?aHZ6TDJyUWI3L1RKQ3hYY1FjWnB3ZEpBWlhRSHREd25qUFVnTDNTQnZTL04z?=
 =?utf-8?B?NW9TbUdJU1kvZThiVVRkU1FqVTNlSGkwbTBFLzVObzdVTGUzblc3YStSUFM1?=
 =?utf-8?B?eWVZU3kxNDF4UGdsNWl5bHlCbmJhVnhNRXAwOW50MW5hYStUemVDc2tCYlJK?=
 =?utf-8?B?MHlzNGFFT014djQrczl0c01oaitGRVRjeGhBMWZFdlJnUW1jc2c5aXU3QzEr?=
 =?utf-8?B?ekE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <734E44D0984F2244B199C10487A7710D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	wXSSyUzGZDOgpUYbamF07QVUW3r+BgUqc6i/9EL1N+rPZcYf+P/KOgTZgJYq8Cj8aDqsC5OJdHmka3QKxIKh+oUrpMbsq9bCd5NoNLG9wGrMWy14v3C788RylcX6gpqgX74rZ2CY3ZrV3ACA7h6EfEWBWT1RltNNcXwCp3UGFAxpqqlP+zldXxnWWuwDFw7XsiLu6CF3xj+OvWcJ9k9tj5SaY43nBowF5XGdmMwbqnSbgGrxnghkWTuMMucI+Hv8Q22HMwr6WLfVCI73sEGq2UHCW3MBDRRKyVsDjdjIX4y8BWyJQGGECO+eMGXY1s8vAB7wecSFTjOlU0dze9fBegjNrACjyeCFdhhlGpmO+mZV7qWr5F3+X3ng1O+sTAeeiSzlRs3rs/gXf+7aH4Gj/ix0VRg8ZtHxbI5NupqssrEmfkkhGBAI8yKm3UfVxVr1U/46E7JE9tolTsmffDmU76KTfcRFAohCG3fff97Ljjs94ogLGRuaxrZu7P/N5ewhB5Cj0uoW8Io3q1mWKAACdRQH7Nsqj2ncF+x+JPFBmV1YBhvjQh0uOnKVaJJtTPjIJeOAqG5DrQKf/d4qx4oZSxZaYrKXKz97GaOWjOJVJ7lbDB9/kMPVp+MzizxGsd7gP9LXc7rx4WRDxhcn1rkRrw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 330c6ef6-8d00-4095-ebc2-08dc5369797b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 23:06:05.4511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T2qDQ/n/TnsZwChz8NhH8gKeAjwnysUKVX7tTimQba8M2kDnraT/N2Or+FGueelaXc2QtQkVzm3a0BYM/FtOGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6373
X-Proofpoint-ORIG-GUID: 1P1-my9k2YBkKXM3f_3icqYGs-zGYOIz
X-Proofpoint-GUID: 1P1-my9k2YBkKXM3f_3icqYGs-zGYOIz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_14,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1011 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2404020170

T24gVHVlLCBBcHIgMDIsIDIwMjQsIE1pY2hhZWwgR3J6ZXNjaGlrIHdyb3RlOg0KPiBUbyBhdm9p
ZCBhIHBvdGVudGlhbCB1bmRlcnJ1biBvZiBhbiBjdXJyZW50bHkgZHJhaW5lZCB0cmFuc2Zlcg0K
PiB3ZSBhZGQgYSBjaGVjayBmb3IgdGhhdCBzY2VuYXJpbyBpbiB0aGUgZHdjM19nYWRnZXRfZW5k
cG9pbnRfdHJic19jb21wbGV0ZQ0KPiBmdW5jdGlvbi4gSW4gdGhlIGNhc2Ugb2YgYW4gZW1wdHkg
dHJiIHJpbmcsIHdlIGNhbGwgdGhlIHN0b3BfdHJhbnNmZXINCj4gY21kIGFuZCBhdm9pZCB0aGUg
dW5kZXJydW4gdG8gb2NjdXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIEdyemVzY2hp
ayA8bS5ncnplc2NoaWtAcGVuZ3V0cm9uaXguZGU+DQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHYyOg0K
PiAtIGRyb3BwZWQgcGF0Y2ggInVzYjogZHdjMzogZ2FkZ2V0OiByZWNsYWltIHRoZSB3aG9sZSBz
dGFydGVkIGxpc3Qgd2hlbiByZXF1ZXN0IHdhcyBtaXNzZWQiDQo+IC0gZml4ZWQgcGF0Y2ggInVz
YjogZHdjMzogZ2FkZ2V0OiBjaGVjayBkcmFpbmVkIGlzb2MgZXAiDQo+IC0gZHJvcHBlZCBwYXRj
aCAidXNiOiBkd2MzOiBnYWRnZXQ6IGNoZWNrIHRoZSB3aG9sZSBzdGFydGVkIHF1ZXVlIGZvciBt
aXNzZWQgcmVxdWVzdHMgaW4gY29tcGxldGUiDQo+IC0gTGluayB0byB2MTogaHR0cHM6Ly91cmxk
ZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNDAzMDctZHdjMy1n
YWRnZXQtY29tcGxldGUtaXJxLXYxLTAtNGZlOWFjMGJhMmI3QHBlbmd1dHJvbml4LmRlX187ISFB
NEYyUjlHX3BnIVlKdUs0alpkVmxZemR6ZEU1bHQxY3otYWpkX2lHdGxPbDRHOUVSbHBfbjlDNVZQ
QlBRcGlraHZKM0JYTTJBWU5NZzF0LXFxLXZEeFEyZjdjajJ6Wmo4RXMwdnZ6a25adyQgDQo+IC0t
LQ0KPiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDIzICsrKysrKysrKysrKysrKysrKy0t
LS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91
c2IvZHdjMy9nYWRnZXQuYw0KPiBpbmRleCA0ZGYyNjYxZjY2NzUxLi4zZTljNjc3OTkyNTlhIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ICsrKyBiL2RyaXZlcnMv
dXNiL2R3YzMvZ2FkZ2V0LmMNCj4gQEAgLTM1ODIsMTMgKzM1ODIsMjYgQEAgc3RhdGljIGJvb2wg
ZHdjM19nYWRnZXRfZW5kcG9pbnRfdHJic19jb21wbGV0ZShzdHJ1Y3QgZHdjM19lcCAqZGVwLA0K
PiAgCWlmICghZGVwLT5lbmRwb2ludC5kZXNjKQ0KPiAgCQlyZXR1cm4gbm9fc3RhcnRlZF90cmI7
DQo+ICANCj4gLQlpZiAodXNiX2VuZHBvaW50X3hmZXJfaXNvYyhkZXAtPmVuZHBvaW50LmRlc2Mp
ICYmDQo+IC0JCWxpc3RfZW1wdHkoJmRlcC0+c3RhcnRlZF9saXN0KSAmJg0KPiAtCQkobGlzdF9l
bXB0eSgmZGVwLT5wZW5kaW5nX2xpc3QpIHx8IHN0YXR1cyA9PSAtRVhERVYpKQ0KPiAtCQlkd2Mz
X3N0b3BfYWN0aXZlX3RyYW5zZmVyKGRlcCwgdHJ1ZSwgdHJ1ZSk7DQo+IC0JZWxzZSBpZiAoZHdj
M19nYWRnZXRfZXBfc2hvdWxkX2NvbnRpbnVlKGRlcCkpDQo+ICsJaWYgKHVzYl9lbmRwb2ludF94
ZmVyX2lzb2MoZGVwLT5lbmRwb2ludC5kZXNjKSkgew0KDQpDYW4gd2UgZm9sbG93IHRoaXMgY29t
bWVudCBibG9jayBzdHlsZToNCg0KLyoNCiAqIGFiYyBkZWZnIHh5eg0KICogMTIzIDEyMzQNCiAq
Lw0KDQo+ICsJCS8qIEl0IGlzIHBvc3NpYmxlIHRoYXQgdGhlIGludGVycnVwdCB0aHJlYWQgd2Fz
IGRlbGF5ZWQNCj4gKwkJICogYnkgc2NoZWR1bGluZyBpbiB0aGUgc3lzdGVtLCBhbmQgdGhlcmVm
b3IgdGhlIEhXIGhhcw0KDQp0aGVyZWZvciAtPiB0aGVyZWZvcmUNCg0KPiArCQkgKiBhbHJlYWR5
IHJ1biBkcnkuIEluIHRoYXQgY2FzZSB0aGUgbGFzdCB0cmIgaW4gdGhlDQo+ICsJCSAqIHF1ZXVl
IGlzIGFscmVhZHkgaGFuZGxlZCBieSB0aGUgaHcuIEJ5IGNoZWNraW5nIHRoZQ0KPiArCQkgKiBI
V08gYml0IHdlIGtub3cgdG8gcmVzdGFydCB0aGUgd2hvbGUgdHJhbnNmZXIuIFRoZQ0KPiArCQkg
KiBjb25kaXRpb24gdG8gYXBwZWFyIGlzIG1vcmUgbGlrZWx5IGlmIG5vdCBldmVyeSByZXENCj4g
KwkJICogaGFzIHRoZSBJT0MgYml0IHNldCBhbmQgdGhlcmVmb3IgZG9lcyBub3QgdHJpZ2dlciB0
aGUNCg0KdGhlcmVmb3IgLT4gdGhlcmVmb3JlDQoNCj4gKwkJICogaW50ZXJydXB0IHRocmVhZCBm
cmVxdWVudGx5Lg0KPiArCQkgKi8NCj4gKwkJc3RydWN0IGR3YzNfdHJiICp0cmIgPSBkd2MzX2Vw
X3ByZXZfdHJiKGRlcCwgZGVwLT50cmJfZW5xdWV1ZSk7DQo+ICsJCXVuc2lnbmVkIGludCB0cmFu
c2Zlcl9pbl9mbGlnaHQgPSB0cmItPmN0cmwgJiBEV0MzX1RSQl9DVFJMX0hXTzsNCg0KVXNlIGJv
b2xlYW4uDQoNCmJvb2wgdHJhbnNmZXJfaW5fZmxpZ2h0ID0gISEodHJiLT5jdHJsICYgRFdDM19U
UkJfQ1RSTF9IV08pOw0KDQpDYW4gd2UgYWRkIGFuIGFkZGl0aW9uYWwgY29uZGl0aW9uIGZvciBp
bi1mbGlnaHQgY2hlY2s6DQoodHJiLT5jdHJsICYgRFdDM19UUkJfQ1RSTF9IV08pIHx8ICh0cmIt
PmN0cmwgJiBEV0MzX1RSQl9DVFJMX0NITikNCg0KVGhlcmUgY2FuIGJlIGEgY2FzZSB3aGVyZSBv
bmx5IHBhcnRpYWwgU0cgcmVxdWVzdCBpcyBwcmVwYXJlZCBiZWNhdXNlDQp0aGUgVFJCIHJpbmcg
aXMgZnVsbC4NCg0KPiArDQo+ICsJCWlmICgobGlzdF9lbXB0eSgmZGVwLT5zdGFydGVkX2xpc3Qp
IHx8ICF0cmFuc2Zlcl9pbl9mbGlnaHQpICYmDQo+ICsJCSAgICAobGlzdF9lbXB0eSgmZGVwLT5w
ZW5kaW5nX2xpc3QpIHx8IHN0YXR1cyA9PSAtRVhERVYpKQ0KPiArCQkJZHdjM19zdG9wX2FjdGl2
ZV90cmFuc2ZlcihkZXAsIHRydWUsIHRydWUpOw0KPiArCX0gZWxzZSBpZiAoZHdjM19nYWRnZXRf
ZXBfc2hvdWxkX2NvbnRpbnVlKGRlcCkpIHsNCj4gIAkJaWYgKF9fZHdjM19nYWRnZXRfa2lja190
cmFuc2ZlcihkZXApID09IDApDQo+ICAJCQlub19zdGFydGVkX3RyYiA9IGZhbHNlOw0KPiArCX0N
Cj4gIA0KPiAgb3V0Og0KPiAgCS8qDQo+IA0KDQpNeSBjb25jZXJuIGhlcmUgaXMgZm9yIHRoZSBj
YXNlIHdoZXJlIHRyYW5zZmVyX2luX2ZsaWdodCA9PSB0cnVlIGFuZA0KbGlzdF9lbXB0eShzdGFy
dGVkX2xpc3QpID09IGZhbHNlLiBUaGF0IG1lYW5zIHRoYXQgdGhlIHJlcXVlc3RzIGluIHRoZQ0K
c3RhcnRlZF9saXN0IGFyZSBjb21wbGV0ZWQgYnV0IGFyZSBub3QgZ2l2ZW4gYmFjayB0byB0aGUg
Z2FkZ2V0IGRyaXZlci4NCg0KU2luY2UgdGhleSByZW1haW5lZCBpbiB0aGUgc3RhcnRlZF9saXN0
LCB0aGV5IHdpbGwgYmUgcmVzdWJtaXR0ZWQgYWdhaW4NCm9uIHRoZSBuZXh0IHVzYl9lcF9xdWV1
ZS4gV2UgbWF5IHNlbmQgZHVwbGljYXRlIHRyYW5zZmVycyByaWdodD8NCg0KWW91IGNhbiB0cnkg
dG8gY2xlYW51cCByZXF1ZXN0cyBpbiB0aGUgc3RhcnRlZF9saXN0LCBidXQgeW91IG5lZWQgdG8g
YmUNCmNhcmVmdWwgdG8gbWFrZSBzdXJlIHlvdSdyZSBub3Qgb3V0IG9mIHN5bmMgd2l0aCB0aGUg
dHJhbnNmZXIgY29tcGxldGlvbg0KZXZlbnRzIGFuZCBuZXcgcmVxdWVzdHMgZnJvbSBnYWRnZXQg
ZHJpdmVyLg0KDQpCUiwNClRoaW5oDQo=

