Return-Path: <linux-kernel+bounces-103947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5C587C6E4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 02:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7921C21817
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 01:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C727259C;
	Fri, 15 Mar 2024 01:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="R7U3qawj";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="afqRW+GS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="QVe8sEJA"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB296FA9;
	Fri, 15 Mar 2024 01:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710464529; cv=fail; b=sK4Stu+6nJxIDOD/UlTAr6TySv4FgoEhe5eZALGu5r1DxPCSKsRPpNJbiWZmDQvOEUK/2E0ZqealYFGyNPN6sY/be3UXgC57h3F5b/NN+FeTv3RTS1Qp5SkAPWZl9aIkelpqCXM1GOHObdu8Bk8y5kE82couZf+gJpvPIS8g9js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710464529; c=relaxed/simple;
	bh=PBEh0sQ5xBA2CT5N/ylm0gPLPt7ttLnsZgDltFyujtI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=goIP3YeaLB3oIGeW9Gv3y78ZOADb8cyfp/p3r9HFV8aH7Nt8TTGfdpnAjGQX/aWKnNppTUR2+4lSYOCsmO7YE1/sGuS6GOrPDuLh4s3BQYIsHN1M4Ekg6aLKhkDBmp1DkxABNVSkEwq5HkCR76G0EXthG+uL3Z3qpnYENdZsqdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=R7U3qawj; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=afqRW+GS; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=QVe8sEJA reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42EMPAte015419;
	Thu, 14 Mar 2024 18:01:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=PBEh0sQ5xBA2CT5N/ylm0gPLPt7ttLnsZgDltFyujtI=; b=
	R7U3qawjNQS9EVMt6dxg72zBcM2YtMheUn++SwE1IR52KOeCovlb2bB8GcTyIE3w
	ck3C3PJdPVTDmYbwAA4eg3QU22uE6/vwo6ttB4E8DKd6eVunrFE4WHhh/sygF+0o
	skIxB583LHTmX+Hh7by3bvoMJy+IXuHZqhpFTC3q7JOLkkhaZ1ANkyXDl/iSQTM6
	B3pDkXU5vAVz1wKOmVt+7WJKPrrBQ45fSjuioGpNnRo5KsN+Zbk5Do5ph/HLjr45
	enSnsLy/UERKXHkBe4KL+Qck4DF02devThv5Wfjo+wZkFUBopI+ZWxy772sMcGSA
	zM9H+kzATj8RBTr5LGTatA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3wva058eyf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 18:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1710464515; bh=PBEh0sQ5xBA2CT5N/ylm0gPLPt7ttLnsZgDltFyujtI=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=afqRW+GS7stvThyF0MscY2tfJzt1ZOoxbeplw/Ikt4gUD+mYN3Ric4kzWk8GneWfI
	 V6+ayPJUc/OrTMPFif+jaGGJScRNLYYuzHrRIS9qNcE80WVBgYfi6F/iBC/Z9Ip/QL
	 qoE1P1bBIE6WoAtw/j4XSRoslwXUjBYvmcWvF+JhtkQLaa8ftNIm2RE/pbxi6fuUvM
	 LIulqGXbP6NmAmx3ucqZSDFdw2NTN0oHdNEmaBfuLYQ/f3R+qdjIg9+US6Lw7urpMq
	 SlBmYzPjVRTv0BeZs8mOBvthFufXlh/XbAl/+TlCHVdPj7GmIBcjuv4AXwYJ1xCRx7
	 9q+JX1agO6NOA==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D6DA5400A2;
	Fri, 15 Mar 2024 01:01:54 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 76EF1A00AA;
	Fri, 15 Mar 2024 01:01:54 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=QVe8sEJA;
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id B4DCD40361;
	Fri, 15 Mar 2024 01:01:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ON3rBuJJCz98P1B5DqyZMFD7B5HLBNTScbO2wMXqTR6OWXOltRjVf8ZZ5tOe4saIhYgNgTnAEMTD4yciGXEiuZvkZB41P+BEF7SXkyKtqJVNIezjsiW/E7luhO2iEMHft3PWkuRivFPBQp0/PI2gxpEADEhrc+nl6bCFjGEIiTdISUez4rOOhZV9BhYH/x6ZDZAAPZqg0k2Ll59IcHbKZrl/jNFnYrDkP00lkq7uyC1Mg90Sc3g9Po02kOVtGKoYmn4YlHnxQJkjKhV+VZe0jzplj3HEqvAsE1VZMFPnMcS0ic2ojr2bm2kyZTdsWs0XVl0s/qKpMv7J1Zl4eJTPhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBEh0sQ5xBA2CT5N/ylm0gPLPt7ttLnsZgDltFyujtI=;
 b=Bb1NQbuxOjUk7VECJk3Eyz17MAVIZn4OxJKYcjc4HM9HUIWJptNUHE/ijgdjrfUpbWr+PTGJG6I5yFSpo8gtupGvxdT/xlTc5e4NPtprO/B8NGckPpJEy/7hiyLWcblIrwxvpC02pHRibRqE6acX1xijxEZs3LlXfPJrcvgw4GycvK0TzJxzQquV1zpBc/8JWwI17biofiMmm9XpqDQ8bxOx+oTapTNkODSUYlzw0IwMg7khy8q2CAvwdaZV2uUUNz714TgdBbctKwc0y0lvFW+GMg6ktic5OLk+ATDHbGy9d7cgfXYz+C3BdI8CTIMY/T3iMPDhgDb9c0U5btu8Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBEh0sQ5xBA2CT5N/ylm0gPLPt7ttLnsZgDltFyujtI=;
 b=QVe8sEJAhiWeFPYiHmBOVg7MTcTVIS6VRVpD0NxEmz/zME7y898QESIsO5jEWvvTDhcnA4oZIHdLx4eDuKaalwf3Wcy2xQFvNkyS8rfdKTQNsVn1JJ79bT/gtc5PFokYAKCgiIdb+pgdlmrHZml68XD0Je5ecuddyujwqmA+Ldc=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH7PR12MB7330.namprd12.prod.outlook.com (2603:10b6:510:20d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.37; Fri, 15 Mar
 2024 01:01:48 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c%3]) with mapi id 15.20.7362.035; Fri, 15 Mar 2024
 01:01:48 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Michal Simek <michal.simek@amd.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: Re: [PATCH v2] usb: dwc3: core: enable CCI support for AMD-xilinx
 DWC3 controller
Thread-Topic: [PATCH v2] usb: dwc3: core: enable CCI support for AMD-xilinx
 DWC3 controller
Thread-Index: 
 AQHaZpDfVUYctKsozU2uHIlcC3QiPbEYiAkAgAAFHQCABge4gIAM/9wAgABlHICADCG3AA==
Date: Fri, 15 Mar 2024 01:01:48 +0000
Message-ID: <20240315010142.qmgx7dugwwb2ort2@synopsys.com>
References: <1708717523-4006664-1-git-send-email-radhey.shyam.pandey@amd.com>
 <20240223224940.y34qflo2azxrvksy@synopsys.com>
 <20240223230758.s7rodlxbsfa44frw@synopsys.com>
 <MN0PR12MB5953B24F0CB175D8C167E73FB7592@MN0PR12MB5953.namprd12.prod.outlook.com>
 <20240307014402.omtcsltp4pxpraf7@synopsys.com>
 <5e87b406-3301-410b-a479-d561d5b19f62@amd.com>
In-Reply-To: <5e87b406-3301-410b-a479-d561d5b19f62@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH7PR12MB7330:EE_
x-ms-office365-filtering-correlation-id: 75a9b37f-f099-4b6a-5dc4-08dc448b7dc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 EZDTxTigdZuxrYLOGsHOM2SHL34aPJIEm8hpyJinAldYGJkrjq9tqzPtweq9hFF6Bfqb/rZG1IbiLW/H9ZP1kFXRjVSMZHI8u4Is4DdavbNZJZOE44THiC3MLIRtMHPVOypOZs5B63IKe9UOMjKxGUStlQLM8OhDvmm1HmC5lJMmveyRTa4oPJjakBzHyzEvZcsdSxlqE8gezZ8BP9LO7oRA7aDN2oB7s+MNC6FaVC5viooBN71ytDEtuLAAWI4FsMqjerBm0aENeiVFOaozXGuQDfYCIrEWd4pwXfUZFNIxnEX3MTz28p8zSzfYVCmYyx9OLA/ZyajJ3x3e/w5T8jLbNSpMZWUDSdptdd7L/R8F63a0H/EzJ3WszMrjz/Z+pMcOVFk3kWxa3AG1CpiBtjbTsbOVX3X8U6vNzh+f3LG/AnpHpzpox8pd7WDXC4pKn8eK+YgAkRsQqeWOzGFuJWIsImorBVmeyX+2onxxzzsMzMqiKsviD7I2QQdJoD4/J4J8xBm1J3uOoGzUI/itNOe0jpJO12tsB20QakK5u92ms9ehY1f/A7PXWj2iI2rGhY4qWqk+R8Y0joCsQoNA2Peq6v11cZpjmQjPbnQ5HpdgXVXASYimw2xD/Ey803YKXrS5Xnoj4/tq9/+Z/SAclwocuF6lVtuGAy0EKaC1MZRiiHK985wpm9k+2C9ayOaXvFpUNCqZYjrDrHnENCa0v34F8NTS/j4jpwfajSU/Bs0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TnB6cE5YeXRiTDZia3E3em55czJjY3oyRTNEd1JoN3htMHdpaHhJcXZuSEJz?=
 =?utf-8?B?WXpPS2IzRFA3cUJFVU9sQmJkajBrUjVIL2w4Ull0dlVlanMzTnVRb1ROKzk3?=
 =?utf-8?B?VEtKanluc0J1WG9lS2RSS3I0UG1yYVF5RHB5NldEMWk0SnFxRVlacDd4QjFw?=
 =?utf-8?B?b2U0UytkWDRWQ0tJYVJDclpVaUpCT3AzM1ZDWWUvVzVmRExaUGZjcVJxSHFN?=
 =?utf-8?B?cGRmMkQ0SjI4bVYyQWsraEh0elN2dWdGZklEUjBhRlZhTXJVaDF5cVFsd25V?=
 =?utf-8?B?US9yV2tmaXNsK1JzN2sxZEtpbHFwVEl6eGhaYWZkaVJBejczV0FVZWRXdWNP?=
 =?utf-8?B?RlpMaldZSGowUzBnbS8zcmFNa1dDUlNNT2doTE82bWdRRUhlcUJzdnJUNCtD?=
 =?utf-8?B?Ujgwb3FkUWNkcjduOVVVKzVSS1liVEw4MmRFUVA0RWllcVE5dEdsZmdzcjBo?=
 =?utf-8?B?bnEyT1RRKzVGUXF6VkxOeTBpOTlWdDNXRU5ZREo0ZU5iTWhnVXZaTjFBM2RQ?=
 =?utf-8?B?SGNYNGRLQVJLQ1Rlam5PNS8xQldVWmw0NkdqK2gvdHU3dndTSGFQbWFhRGl4?=
 =?utf-8?B?c05idk9zZVlaM3ZENW9ROTMyNU5zL3hhdnBBd3pKMitvMDJ5UzkxTGtUbHc4?=
 =?utf-8?B?OE9DcUpnaEoxQzE1RTRadXpVOFhRcGQ0L0hCYmJVcHlzNmVWd1dGcTJaMHpI?=
 =?utf-8?B?bjZyTlFaWVc2VzFscHJIamwwTGg4YkkzdlpXWWprWGRpM3FqKzhyZWtWcXFI?=
 =?utf-8?B?ZGRqSjA3QVZBbFM1cnVEUW5IempIbHB3OVRoMmRvSXBPbnZJQXZkS1l6N0dD?=
 =?utf-8?B?bjhqMHpqbVV5RTBPOFp4dlJWU1BxTkxXYUE1eXhKZ2VzaXdnYUpPVG1LVXgy?=
 =?utf-8?B?Tkd5cHlHT1ppaFVHZmgweG52R3hPcGFNcVB5OWxyMDlXNDg3d2FFQWsvYVEr?=
 =?utf-8?B?YmxRVEV0ZW4vUjVBUC9YVGVyUG1Fb3FTWVhSVWNtTVdVK2UrN0ZNN3hJdVpZ?=
 =?utf-8?B?N0pPVDNIMmtwK1RuOHR3QVlDTEVZb25RVEVCYXVra0RZcWljM1JJcjBtbXJH?=
 =?utf-8?B?dEZ1c2hNSEVCcWIwWTVFTWx6QTlETGlWQVAxUTFlK1JSa2RLQVg5UEFhQmMr?=
 =?utf-8?B?SGNMU0pnSEdGVkdJcVdoZmk5UlZFdHgzNGpRSTJQN1ZQUTZQSU9tNjRvS0ly?=
 =?utf-8?B?cG9HS0FFRXNuTWgwMlZCZEQyeTFDNmlNeHFsTkxFQk5rWk5SRkVKb2dGN1hN?=
 =?utf-8?B?elF1c3NhZ2JuOG55cW1GK0w4TTE1MEdFb2JnVUI0dFVLcUxRQ2NCTU9RMHdZ?=
 =?utf-8?B?eWxNbHI0UzNBekYvRDVLNlZqeGZjLzJPRW5qNG5Xa0F6bk1OSDVydWU3NHI3?=
 =?utf-8?B?aEZVUytWZ2djcGRwZi9zK1B4VktkTGY4WXdqWnd2bnp1TmduUk5NMzZYRENQ?=
 =?utf-8?B?Y25DWHU5RVRneC9pOHNuNFpBZE9TUGdVUUxHUEVxUFZqYitWUVNyTkdESUVF?=
 =?utf-8?B?SmcvR0FraHh6U0ZZU3hKRll1NWsyWUxJRG9yd0NqL2FGeXVrOEx3QmVaSVI3?=
 =?utf-8?B?SkFwUWhSaWUvN25uMEtYeU5FWjlHR3VwMHloaDJPRHkxeHpXNjhXUzBxNXFj?=
 =?utf-8?B?QW8rWWdpSzZjQzNjMDZoaTR6bGpnaEN0RzZvMnNCZC9mVS9wV2FkQmlmZzR0?=
 =?utf-8?B?VThVbGgydERSaVZyK0lzOGlld3VSOVBUYnV0VXhjRld3VlpnRUphKzZYSThz?=
 =?utf-8?B?SXYrMFpuMWxneE1vRWJSbUF6aE45bm9nNko1bU0zRVM3ZUlKMGkydy9seEsr?=
 =?utf-8?B?bWNBMGM0TmU5WlNLWmJMV0VwQnJPdDAyR0pXaWFVTjQrOVlCNjlvUDJGanlq?=
 =?utf-8?B?ZXVpZTkwWWk3aHgwMjk1dnZFMndWVE9haE1iMGUxaThBaWtFczNaeE1aRDVl?=
 =?utf-8?B?TStqQXJCYmdRSDBjWEw0bm9qLzAwWnN3Qm9ma1EyQ2Z4Z2NmNXBFeWNxYk9J?=
 =?utf-8?B?N29YNmlSNjc3aUgvYTBycFg4TFJ4cmN4YUNPZnZOeGNwbzB5djkyeG9Nc3ls?=
 =?utf-8?B?aGkzU0JvSkR2bEl0ZmRWcy9TL2NvVWZydVA1WEtUaHhqdG5ZL3gxL0d5bW9r?=
 =?utf-8?Q?xvR7HyO/tuifc/yxgEl10kQf2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14535D720F989844844B855EBB2E16F6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/9DwDkJtVzl4LL9f9hyRfkW20fqdZvDYbYsmNzYE2rY5isFCmmD/pY1rnEUGiDJF6lF8BOXHK+dPyl6jwHjlfuUWxOiQNbj7JBlHp50AgF0Z9bcQadzzCsG8ObFippuvA/1SOXlPNzWKJL+bIRv9SNQaZV/grFsC9flB4o2ETK/4gubRv7wdg7fdA0AH2ExHYJQsjSpZUnr0RPOyk3rSNBGY4LI9yN+qCpu2Up46Q0AwFzKxpJV7wG/GlCWxg2E0AWGdM3jHUUvfWpZx8VuBlg/PDIKa/CcOq/hkTCqLSE5qqbgDxFx/FVV0N5oGXGRgUeOi/WncwlaZc+LJ7UJXejhaDB8YAbzVCyXM7Sm1C1uF372u2JGIpYFlNgEC96l/gSv44huoq1e9On2lmcJ01VTpqjAJo9xZp/4kGvrkcRqkZ5gzke0fUyNBlODa4ckrxHsDXR/8Gtryr2yJgrN6EA6XebfjJ59qmPUgqKtB0q3CqPoM3GUEzbA0JTPfCjtJZFg8Jod51gy+Wf4qswqMv5X9nXDWLqBwT+0YqTsOnyA25VoLjvd+fCXHi+REvmO3+T3aNNOhwwQgIduSKYDvANIBczsc+vBZGqFBsIp1VvFGa7g8RxQVSUyzy6R/5KePCnO3VdeIY58n0iZto9pGuA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a9b37f-f099-4b6a-5dc4-08dc448b7dc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 01:01:48.0826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oJV7IISy622MUFdr9y8wLW4lQtfH6XtYarN2rEe/H/24FHYw9eEZtWDkLjqYusUOc/Qw9v8xVE15zHwOvTLv9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7330
X-Proofpoint-ORIG-GUID: rqQklpxC1kkvcMUFukY7SPzy5T4DqjEg
X-Proofpoint-GUID: rqQklpxC1kkvcMUFukY7SPzy5T4DqjEg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 clxscore=1011
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403140001 definitions=main-2403150004

T24gVGh1LCBNYXIgMDcsIDIwMjQsIE1pY2hhbCBTaW1layB3cm90ZToNCj4gDQo+IA0KPiBPbiAz
LzcvMjQgMDI6NDQsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBIaSwNCj4gPiANCj4gPiBPbiBU
dWUsIEZlYiAyNywgMjAyNCwgUGFuZGV5LCBSYWRoZXkgU2h5YW0gd3JvdGU6DQo+ID4gPiA+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+IEZyb206IFRoaW5oIE5ndXllbiA8VGhp
bmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCj4gPiA+ID4gU2VudDogU2F0dXJkYXksIEZlYnJ1YXJ5
IDI0LCAyMDI0IDQ6MzggQU0NCj4gPiA+ID4gVG86IFBhbmRleSwgUmFkaGV5IFNoeWFtIDxyYWRo
ZXkuc2h5YW0ucGFuZGV5QGFtZC5jb20+DQo+ID4gPiA+IENjOiBncmVna2hAbGludXhmb3VuZGF0
aW9uLm9yZzsgbGludXgtdXNiQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+ID4gPiA+IGtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IGdpdCAoQU1ELVhpbGlueCkgPGdpdEBhbWQuY29tPg0KPiA+ID4g
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSB1c2I6IGR3YzM6IGNvcmU6IGVuYWJsZSBDQ0kgc3Vw
cG9ydCBmb3IgQU1ELXhpbGlueA0KPiA+ID4gPiBEV0MzIGNvbnRyb2xsZXINCj4gPiA+ID4gDQo+
ID4gPiA+IE9uIEZyaSwgRmViIDIzLCAyMDI0LCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gPiA+
ID4gT24gU2F0LCBGZWIgMjQsIDIwMjQsIFJhZGhleSBTaHlhbSBQYW5kZXkgd3JvdGU6DQo+ID4g
PiA+ID4gPiBGcm9tOiBQaXl1c2ggTWVodGEgPHBpeXVzaC5tZWh0YUBhbWQuY29tPg0KPiA+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gPiBUaGUgR1NCVVNDRkcwIHJlZ2lzdGVyIGJpdHMgWzMxOjE2XSBh
cmUgdXNlZCB0byBjb25maWd1cmUgdGhlIGNhY2hlIHR5cGUNCj4gPiA+ID4gPiA+IHNldHRpbmdz
IG9mIHRoZSBkZXNjcmlwdG9yIGFuZCBkYXRhIHdyaXRlL3JlYWQgdHJhbnNmZXJzIChDYWNoZWFi
bGUsDQo+ID4gPiA+ID4gPiBCdWZmZXJhYmxlLyBQb3N0ZWQpLiBXaGVuIENDSSBpcyBlbmFibGVk
IGluIHRoZSBkZXNpZ24sIERXQzMgY29yZQ0KPiA+ID4gPiBHU0JVU0NGRzANCj4gPiA+ID4gPiA+
IGNhY2hlIGJpdHMgbXVzdCBiZSB1cGRhdGVkIHRvIHN1cHBvcnQgQ0NJIGVuYWJsZWQgdHJhbnNm
ZXJzIGluIFVTQi4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogUGl5
dXNoIE1laHRhIDxwaXl1c2gubWVodGFAYW1kLmNvbT4NCj4gPiA+ID4gPiA+IFNpZ25lZC1vZmYt
Ynk6IFJhZGhleSBTaHlhbSBQYW5kZXkNCj4gPiA+ID4gPHJhZGhleS5zaHlhbS5wYW5kZXlAYW1k
LmNvbT4NCj4gPiA+ID4gPiA+IC0tLS0NCj4gPiA+ID4gPiA+IGNoYW5nZXMgZm9yIHYyOg0KPiA+
ID4gPiA+ID4gTWFrZSBHU0JVU0NGRzAgY29uZmlndXJhdGlvbiBzcGVjaWZpYyB0byBBTUQteGls
aW54IHBsYXRmb3JtLg0KPiA+ID4gPiA+ID4gVGFrZW4gcmVmZXJlbmNlIGZyb20gZXhpc3Rpbmcg
Y29tbWl0IGVjNWViNDM4MTNhNCAoInVzYjogZHdjMzogY29yZToNCj4gPiA+ID4gPiA+IGFkZCBz
dXBwb3J0IGZvciByZWFsdGVrIFNvQ3MgY3VzdG9tJ3MgZ2xvYmFsIHJlZ2lzdGVyIHN0YXJ0IGFk
ZHJlc3MiKQ0KPiA+ID4gPiANCj4gPiA+ID4gUmVnYXJkaW5nIHRoYXQgY2hhbmdlIGZyb20gUmVh
bHRlaywgaXQncyBhIHNwZWNpYWwgY2FzZS4gSSB3YW50IHRvIGF2b2lkDQo+ID4gPiA+IGRvaW5n
IHBsYXRmb3JtIHNwZWNpZmljIGNoZWNrcyBpbiB0aGUgY29yZS5jIGlmIHBvc3NpYmxlLiBFdmVu
dHVhbGx5LCBJDQo+ID4gPiA+IHdhbnQgdG8gbW92ZSB0aGF0IGxvZ2ljIGZyb20gUmVhbHRlayB0
byBpdHMgZ2x1ZSBkcml2ZXIuDQo+ID4gPiA+IA0KPiA+ID4gPiBCUiwNCj4gPiA+ID4gVGhpbmgN
Cj4gPiA+IFRoYW5rcy4gQXMgeW91IHN1Z2dlc3RlZCBJIHRyaWVkICJ0ZW1wb3JhcmlseSBtZW1v
cnkgbWFwIGFuZCB1cGRhdGUgdGhpcw0KPiA+ID4gcmVnaXN0ZXIgaW4geW91ciBYaWxpbnggZ2x1
ZSBkcml2ZXIuIEl0cyB2YWx1ZSBzaG91bGQgcmV0YWluIGFmdGVyIHNvZnQgcmVzZXQiLg0KPiA+
ID4gDQo+ID4gPiBEaWQgaW9yZW1hcCBmb3IgY29yZSByZWdpc3RlciBzcGFjZSBvbmNlIGFnYWlu
IGluIGdsdWUgZHJpdmVyIGJ1dCBpdCByZXN1bHRlZA0KPiA+ID4gaW4gYmVsb3cgZXJyb3I6DQo+
ID4gPiBkd2MzIGZlMjAwMDAwLnVzYjogY2FuJ3QgcmVxdWVzdCByZWdpb24gZm9yIHJlc291cmNl
IFttZW0gMHhmZTIwMDAwMC0weGZlMjNmZmZmXQ0KPiA+ID4gZHdjMy14aWxpbnggZmY5ZDAwMDAu
dXNiOiBlcnJvciAtRUJVU1k6IGZhaWxlZCB0byBtYXAgRFdDMyByZWdpc3RlcnMNCj4gPiA+IA0K
PiA+ID4gU28gdG8gYXZvaWQgcmVtYXBwaW5nLCBub3cgZ2V0IHRoZSBzdHJ1Y3QgZHdjMyBwbGF0
Zm9ybSBkYXRhIGhhbmRsZSBpbiBnbHVlDQo+ID4gPiBkcml2ZXIgYW5kIHBhc3MgaXQgdG8gZHdj
M19yZWFkbC93cml0ZWwoKSBsaWtlIHRoZSBiZWxvdyBzZXF1ZW5jZS4gSXMgdGhhdCBmaW5lPw0K
PiA+ID4gSWYgeWVzIEkgd2lsbCByZXNwaW4gdjMgd2l0aCB0aGVzZSBjaGFuZ2VzIGFuZCBhbHNv
IGRvIHNvbWUgbW9yZQ0KPiA+ID4gc2FuaXR5IHRlc3RzLg0KPiA+ID4gDQo+ID4gPiBkcml2ZXJz
L3VzYi9kd2MzL2R3YzMteGlsaW54LmMNCj4gPiA+ICNpbmNsdWRlICJpby5oIg0KPiA+ID4gDQo+
ID4gPiA8c25pcD4NCj4gPiA+IHJldCA9IG9mX3BsYXRmb3JtX3BvcHVsYXRlKG5wLCBOVUxMLCBO
VUxMLCBkZXYpOw0KPiA+ID4gaWYgKHJldCkgew0KPiA+ID4gCWRldl9lcnIoZGV2LCAiZmFpbGVk
IHRvIHJlZ2lzdGVyIGR3YzMgY29yZSAtICVkXG4iLCByZXQpOw0KPiA+ID4gICAgICBnb3RvIGVy
cl9jbGtfcHV0Ow0KPiA+ID4gfQ0KPiA+ID4gDQo+ID4gPiBkd2MzX25wID0gb2ZfZ2V0X2NvbXBh
dGlibGVfY2hpbGQobnAsICJzbnBzLGR3YzMiKTsNCj4gPiA+IHByaXZfZGF0YS0+ZHdjMyA9IG9m
X2ZpbmRfZGV2aWNlX2J5X25vZGUoZHdjM19ucCk7DQo+ID4gPiBkd2MgPSBwbGF0Zm9ybV9nZXRf
ZHJ2ZGF0YShwcml2X2RhdGEtPmR3YzMpOw0KPiA+ID4gaWYgKG9mX2RtYV9pc19jb2hlcmVudChk
ZXYtPm9mX25vZGUpKSB7DQo+ID4gPiAJcmVnID0gZHdjM19yZWFkbChkd2MtPnJlZ3MgLCBEV0Mz
X0dTQlVTQ0ZHMCk7DQo+ID4gPiAJcmVnIHw9IERXQzNfR1NCVVNDRkcwX0RBVFJEUkVRSU5GT19N
QVNLIHwNCj4gPiA+ICAgICAgICAgICAgICAgIERXQzNfR1NCVVNDRkcwX0RFU1JEUkVRSU5GT19N
QVNLIHwNCj4gPiA+ICAgICAgICAgICAgICAgIERXQzNfR1NCVVNDRkcwX0RBVFdSUkVRSU5GT19N
QVNLIHwNCj4gPiA+ICAgICAgICAgICAgICAgIERXQzNfR1NCVVNDRkcwX0RFU1dSUkVRSU5GT19N
QVNLOw0KPiA+IA0KPiA+IEl0J3MgYSBiaXQgb2RkIHRvIHVzZSAibWFzayIgYXMgdmFsdWUgaW5z
dGVhZCBvZiBzb21lIGRlZmluZWQNCj4gPiBtYWNyb3MvdmFsdWVzLg0KPiA+IA0KPiA+ID4gCWR3
YzNfd3JpdGVsKGR3Yy0+cmVncyAsIERXQzNfR1NCVVNDRkcwLCByZWcpOw0KPiA+ID4gfQ0KPiA+
ID4gDQo+ID4gDQo+ID4gUGVyaGFwcyBpdCBtYXkgYmUgYmV0dGVyIHRvIGFkZCBhIG5ldyBpbnRl
cmZhY2UgZm9yIHRoZSBjb3JlIHRvIGludGVyYWN0DQo+ID4gd2l0aCB0aGUgZ2x1ZSBkcml2ZXJz
LiBUaGUgY29yZSBjYW4gdXNlIHRoZXNlIGNhbGxiYWNrcyB0byBwcm9wZXJseSBzZXQNCj4gPiBw
bGF0Zm9ybSBzcGVjaWZpYyBjb25maWd1cmF0aW9uIGF0IHNwZWNpZmllZCBzZXF1ZW5jZSBvZiB0
aGUgY29udHJvbGxlcg0KPiA+IGluaXRpYWxpemF0aW9uLiBJdCB3aWxsIGJlIGJldHRlciBkZWZp
bmVkIGFuZCBtb3JlIHByZWRpY3RhYmxlIHRoYW4gd2hhdA0KPiA+IHdlIGhhdmUgaGVyZS4gV2hh
dCBkbyB5b3UgdGhpbms/DQo+IA0KPiBOb3Qgc3VyZSBJIGZ1bGx5IHVuZGVyc3RhbmQgd2hhdCB5
b3UgbWVhbiBieSBtb3JlIHByZWRpY3RhYmxlLg0KPiBBcmUgeW91IGFza2luZyBmb3Igc2ltcGxl
IHJlYWQvd3JpdGUgaW50ZXJmYWNlIHRvIGR3YzMgY29yZSBJUD8NCj4gRG8geW91IHdhbnQgdGhl
cmUgYW55IGxpbWl0YXRpb24gZm9yIGFjY2Vzc2VzIHRvIGJlIGFibGUgdG8gY29udHJvbCBpdD8N
Cj4gDQo+IEkgZG9uJ3QgdGhpbmsgd2UgaGF2ZSBhbnkgaXNzdWUgd2l0aCB5b3VyIHN1Z2dlc3Rp
b24gYnV0IGl0IGlzIHVuY2xlYXIgaG93DQo+IGV4YWN0bHkgaXQgc2hvdWxkIGxvb2sgbGlrZS4N
Cj4gQ2FuIHlvdSBwbGVhc2Ugc2tldGNoIGl0Pw0KPiANCg0KSGksDQoNClNvcnJ5LCBteSBzdWdn
ZXN0aW9uIHdvdWxkIHJlcXVpcmUgYSBoYW5kbGVyIGZvciB0aGUgZ2x1ZSBkcml2ZXIgYW5kIHRo
ZQ0KY29yZS4gQnV0IHRoZSB2YXJpb3VzIGltcGxlbWVudGF0aW9ucyBpbiBkaWZmZXJlbnQgZ2x1
ZSBkcml2ZXJzIGFyZQ0KaGFuZGxlZCBpbiBzdWNoIGEgd2F5IHRoYXQgd29uJ3QgYmUgc2ltcGxl
IHRvIHBhc3MgdGhpcyBoYW5kbGUgYXJvdW5kLg0KVGhpcyBjYW4gZ2V0IGhhaXJ5IHF1aWNrbHku
Li4NCg0KTGV0J3Mgc2NyYXRjaCB3aGF0IEkgc3VnZ2VzdGVkLg0KDQpJbnN0ZWFkLCBwZXJoYXBz
IHdlIGNhbiBkbyBpdCBhcyBmb2xsb3dpbmc6DQogKiBLZWVwIHRoZSBzZXR0aW5nIG9mIHRoZSBj
b250cm9sbGVyIHJlZ2lzdGVycyBpbiB0aGUgY29yZQ0KICogQ3JlYXRlIGEgc29mdHdhcmVfbm9k
ZSB0byBwYXNzIGEgc29mdHdhcmUgcHJvcGVydHkgdG8gdGhlIGNvcmUNCg0KVGhlc2Ugc29mdHdh
cmUgcHJvcGVydGllcyB3aWxsIG5vdCBiZSBkb2N1bWVudGVkIGluIHRoZSBkZXZpY2V0cmVlDQpi
aW5kaW5nLiBKdXN0IGRvY3VtZW50IHRoZW0gaW4gdGhlIGRyaXZlciBjb3JlIGhlYWRlci4gVGhl
eSBhcmUgc2ltcGx5DQpkcml2ZXIgcHJvcGVydGllcyB0aGF0IGdldCBwYXNzZWQgdGhyb3VnaCBz
b2Z0d2FyZSBub2RlLg0KDQpZb3UgY2FuIGFkZCB0aGUgc29mdHdhcmUgbm9kZSB1c2luZyBkZXZp
Y2VfYWRkX3NvZnR3YXJlX25vZGUoKS4gVGhpcyBjYW4NCmJlIGRvbmUgYmVmb3JlIGNhbGxpbmcg
b2ZfcGxhdGZvcm1fcG9wdWxhdGUoKSBpbiBkd2MzLXhpbGlueCAoY2FuIGJlDQpkb25lIGluIHBs
dGZtX2luaXQoKSkNCg0KTGV0IG1lIGtub3cgaWYgdGhpcyB3b3JrcyBmb3IgeW91Lg0KDQpUaGFu
a3MsDQpUaGluaA==

