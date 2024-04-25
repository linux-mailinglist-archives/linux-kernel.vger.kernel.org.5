Return-Path: <linux-kernel+bounces-159087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CA68B2921
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCADEB22A69
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B9238FB6;
	Thu, 25 Apr 2024 19:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bfciu46/"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B60282FD;
	Thu, 25 Apr 2024 19:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714074485; cv=fail; b=I/GV7SiUQP6jDpR0FeOHLhp3SrQjV2s7gr/uTmYW3GcdcNd5xTEwFVvAXhcAS67CsJUz9fjQd+kHtLQcIdqsahmttkxd2uQP7wtacWPncwEnvPYfDbbcT7k13ytJDQ+r9Hs3T733KTH7gfolpPeytinsRi5FpOsVjpFNaMi+wAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714074485; c=relaxed/simple;
	bh=JR6fCjG77PJzRM3VfiLyuvKt/ibFW8CBGUSv9GGzP+w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BTqTlTu562kPl73MOEzWftAC2isJkUC6yYWsvGhFNA6UB7emlfHapttKlkDqXH7jUHFVjebPDrD4A0MIHAWxMJy6TuAGA6fFeBlgOfU2ljfLq8h9xAPdp3AQMwwina70srZLudUouofMOEPgTOcK+YLEGtjSs4PDkmGV5OwJDoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bfciu46/; arc=fail smtp.client-ip=40.107.220.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVQTsSOAD3lK1hdRiR49fosOfB3K67PGpjfdtxxY3R+jYF6MzZZuYJXSbC+5vDHXjPN9VLlMHvFZd+xlPeJBX5XDfzSL7jrMkmwFbObWBEvl/bB6rviVwfPM6pnPg84ek2VuPODMccB3IJzq2UzWDqvtAolczXN2ooEN4BBgumyCkgOVaty6jcUQgGaI3HehTkaO2JPC/IP60BtpNu1ReQVGVjejtejMQhiM+arh5FJySo15W2RD0CRICC6TdXaK06BOgN2l2c3XFupiTJfsJR1rlCy4aiSWQ4+yjp+aYeSw8A29zV5smdamQo4Wt0bhPtZGw4A2oEKyEg5Dt/s4IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JR6fCjG77PJzRM3VfiLyuvKt/ibFW8CBGUSv9GGzP+w=;
 b=V0tXaICsQjJ3Yz1dpo1152m2v1X15di/Gnn2IVlF4lgg5+GkpH05Wz42VZBsZJxUDUuGLHW46M/RskbKiRzU1Z60ACVR/mhcKWTkFvGjlqa8Jbh/Z9L2fpzg/Urdd162nOObeRqkoAiGnW3JrWWbpPhJ3zaqhucAnMRarFBtqrm+YwfR5hV850Hzao3v18atvqDbhArsgW3w9K0zPW5pnG5imAu7XmSsIBaSgpespia8R1pURz1I73Jmj9q9noCdRhKxRr2o7egaCcT5aaOGeDypuw+2RHVO0ci9z6gs8+ngn39HR7DkFsP6kk6SrROMuVAw7mNE7X84NFqkSA5WGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JR6fCjG77PJzRM3VfiLyuvKt/ibFW8CBGUSv9GGzP+w=;
 b=bfciu46/LcgN1ldXaM5wDfJb3/w0FW7Ob3CS5RAlbSSJz6X7tnb3XtFBkR3sZ26s2MZVz76jRuEnH4CBDnXEg6mqsr+GUM+nVLlJUIM0nok3zNTENnm3xdMOJ9C4EaTreO1hI1MWBAewf+Jn1Yxk07cg265FNDPxWUNx1gBI5ypqlRFQ4yGRXk7V4jiIAOB6hWhyKKTueMXqzlivslcuzTrkcx26nrDbqIeDiDSU98W4koS013R+/uks0eBq/f3DSO87gdRuDNs5zK/jRX4vIpRhi8HxQnRbVGsOkb5UOwGCciiUAGBms7OmPxw8fFYhwZcmw3JWlYVnrJBDfC4udg==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by IA1PR12MB6601.namprd12.prod.outlook.com (2603:10b6:208:3a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 19:47:56 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::a8dd:546d:6166:c101]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::a8dd:546d:6166:c101%4]) with mapi id 15.20.7519.023; Thu, 25 Apr 2024
 19:47:55 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "almasrymina@google.com" <almasrymina@google.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "ilias.apalodimas@linaro.org"
	<ilias.apalodimas@linaro.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jacob.e.keller@intel.com"
	<jacob.e.keller@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>, Jianbo
 Liu <jianbol@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [RFC PATCH] net: Fix one page_pool page leak from skb_frag_unref
Thread-Topic: [RFC PATCH] net: Fix one page_pool page leak from skb_frag_unref
Thread-Index: AQHalmh2YwjSjfzzmU66VYtjn6H0WLF3q+gAgABPNgCAAKoVgIAAuWSAgAAHhQA=
Date: Thu, 25 Apr 2024 19:47:55 +0000
Message-ID: <63222bf6a298ae38e77b0c0f49d13581dd9d3a74.camel@nvidia.com>
References: <20240424165646.1625690-2-dtatulea@nvidia.com>
	 <4ba023709249e11d97c78a98ac7db3b37f419960.camel@nvidia.com>
	 <CAHS8izMbAJHatnM6SvsZVLPY+N7LgGJg03pSdNfSRFCufGh9Zg@mail.gmail.com>
	 <4c20b500c2ed615aba424c0f3c7a79f5f5a04171.camel@nvidia.com>
	 <CAHS8izPkRJyLctmyj+Ppc5j3Qq5O1u3aPe5h9mnFNHDU2OxA=A@mail.gmail.com>
In-Reply-To:
 <CAHS8izPkRJyLctmyj+Ppc5j3Qq5O1u3aPe5h9mnFNHDU2OxA=A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.4 (3.50.4-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|IA1PR12MB6601:EE_
x-ms-office365-filtering-correlation-id: 3928b958-4ba4-426b-9de9-08dc65609a40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?SU5SVHZlRHNJZisyU3hXTW8yVVg2VWVUOVBLazEvS0Zod1pGS0Y4WHF6TlZ1?=
 =?utf-8?B?MGZFVzlCaCsrbTQxMXd2ZmxiNHU0SU1Id3J3QmdBT1BpODQ3UWpidCtMdHZM?=
 =?utf-8?B?TEpPU1hFWFhrcnhxOUpKNisyUmt5eFJCTUFwTVNwWktjQjgwYlFiaHVOWFZD?=
 =?utf-8?B?TXdZSU9HTCs4bEo5S0hVaHg3bTV4aHIrUTJVWi9mM28zMEJ4YW1vSmhtWDhB?=
 =?utf-8?B?dzJvUVpTcFFReEZMMkVlZnV2OEEwR3VqUndpYk13UlQ3V0pYZlYxazVUTG1v?=
 =?utf-8?B?RENBSlB6NUJqNldxMS84TTlSSGZtUkNMN0tNL1Z6d0VkUTU1Ym1wUWVBT1R4?=
 =?utf-8?B?aUk5cWtKb0N0WlEySnpLYUxhYWczM2krM0NadHlVcWtTSHUrREZUS1pnRW5U?=
 =?utf-8?B?VE43SW9aMFJ6QWk5MG1SbytHa2kxVUJpT0xMVVhHMVhYMEF5c0pqUzZtVFhs?=
 =?utf-8?B?eHBYZmVzVysyM0NhdTVWSVUzZGhWaWx4Q0R1RS8yck1qckpJWW9VL3NDZHdR?=
 =?utf-8?B?aDBxR3pvOHl5blBadkRid0hNWlJLU2VJMVlKTkZSejY3WlpRN2s3QUZFYlB6?=
 =?utf-8?B?cnFvVmJJK0pQaE0yYWlOTUZzSHhSeUNPbDVGYWlNbTBGNTVVWmp1SFJjTFZJ?=
 =?utf-8?B?NTdpRzF6WDNaQm8zVjlEMFQyNUx6dlpmMTArL0h5RlF3d1YyODB3cmFNeXMv?=
 =?utf-8?B?S28vYjkwR0lHcTBPejR5Znl0bEVPZ0JBanp4a1JCczRaWnk0VlZNdldHK2NG?=
 =?utf-8?B?ZWpreEl5ZGllc3ZFR3k1Lys2OW9IMTEvYXlhRmpQQnV1SmE5NWVDUmE4T0l5?=
 =?utf-8?B?Wk0yTnByWlJrZ0FORGs2K2ZxcS85d1hpUTVtbit3eTF5UDdKNElCZjNnN3RY?=
 =?utf-8?B?K05QY0k3SmdVT1VDZXNPQ2t4Nk9ibVNieU1CcjRlWk1nSWZYUGZoTkJJUEdC?=
 =?utf-8?B?TWJobm5FZFI2YmlXMGJYd3VlWmxUT1Z5cFdhTldoK2RWMmVVVGlSdVh6WmE3?=
 =?utf-8?B?ckQwKzVPQUdDOVpPRzlZN3VUOU5TV1ZaRXd2a1FZcjVKNk1DeTVYMm9abVhF?=
 =?utf-8?B?QTFwbEZCZHBhVjZ3TXc3NTcyVng5WUlKMmxieW9Temo4b3VkNFFkYnB4UXQ0?=
 =?utf-8?B?Zk1NYjQ1dEFsUEY1SGVlQ0hWUkR0ZXFKdzlMUkRPYU5FM21DME5QWUdHbGlw?=
 =?utf-8?B?eG9YZmhxeWRVdlZsbTNyVnpRMXZjWGVJdmJCZFpZYm1QSzNCb0U4Z2VZSjZp?=
 =?utf-8?B?Y1pEQW8xTTVRdHFCa3VDQzNCbFZEenhBT1hSa3RvUnltWSswTW5MVW5ucEc5?=
 =?utf-8?B?L1FOY3grb3Z4NUcvS2dqM3NIYlZmK2Q5MFNNeHp6YkR6NCtER1dHN2pGL0RF?=
 =?utf-8?B?S01kZGFWWkphV05TQmx6cjZxMVFrUEVNQ3FqckdYa3FFMFY3dGNKdGxlUk83?=
 =?utf-8?B?OTV6Y0ZsUEhzd0hpZm1BVi9QcENjQlZNRXdhVTAweUxQNERCbWs3TGd1UWZ3?=
 =?utf-8?B?TWNZcm9MenhVSWQ5Y1RYb3hYcDhyanAvaGVvUkc1WU05L0tPbFNPSEd0Mys0?=
 =?utf-8?B?V1BtT1JyOVZSRkliTTJQYko2eEZsUHY1ck1CSGNNM2ZVTlRVTTV4eDllTmRr?=
 =?utf-8?B?MmpNeEk3NkQwMUs5YUhQbU56QTVnZ2orWUZDNlVhNTRhS240dlRIT3ZTc1BW?=
 =?utf-8?B?NEorV05OTGp1c0tCRjZQSGZDRUI2QTNvYldkY0twNkk4K1J3OEFsdVFrZmlW?=
 =?utf-8?B?QithSG1pWFk3VC82TlNMYVVlOE5hNHRibkRZRnhaU0E2bnk5NkNFQVlKblJN?=
 =?utf-8?B?Wlc3YmtFUi9pR0ovRFpaUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ME8vRHBkSW16Znd5c3BwQmZZRkZ1NEtzZnBvK2FtK1dBbzNxM25rZTh5algz?=
 =?utf-8?B?MnlSSm0vSXlrZWRhbnFoQ1pLOE9LWlczVFRYb1gxUWVCYVdtTUxiN2RaMkF3?=
 =?utf-8?B?NFN4aHpHNFpxTUhGcmdudGhyNXhidGw0K2JKSm05dCtJNGxJNlFPay80ZTlI?=
 =?utf-8?B?dFE3Si9pN3NGellqdEdhRnNJdkxMNWhJNXdwQW05Z2tqRVpQbnZsSzNNMnhm?=
 =?utf-8?B?TVJvY0xkMXJkdFAyV3VTT3ZQZzdzbmpCUWxKc2cwWjZST2tldzVaV2RQNXNt?=
 =?utf-8?B?VThwVmZacWNZVXdTMlIzWEtONEdWVDlTNDlKYUtqWHIzV0xlZzJlTUVianMz?=
 =?utf-8?B?MU5ncDVhMFE4S1BSN2JIRDJ2ZUdUazVnMGxWZWZBT0pmdTMwa1R3MlJYclNS?=
 =?utf-8?B?Nkp0ZnJDTVluVVlPN2Z0WldJeC9wNlUxcmk3K3Vxd21UOXJPbi9WQXZtc2Vw?=
 =?utf-8?B?U1VlUWREc3ZqalJNMTc5ZVZXNlM1akpKZ2h4bXpheG53WmhldXV2RVlqNi9M?=
 =?utf-8?B?MXQ2anBRS0MyTWlHbzN6KzBzd0kvM1QzV1VLQ1FOT1lMSEMzSytzeW9tRlhG?=
 =?utf-8?B?Y0pvT3lCL0NKa29mZmx6M0U5OGZQZ1d6OXIzY1BCUzJmNkpzN1NrYjRIY3Jq?=
 =?utf-8?B?bEdDRFZLaXY2RHdIc04rc3ZtbU50S1BNa3NSc1R0RU12dU5nRnRhbWtDbFBz?=
 =?utf-8?B?cWJLSGdiRmh6UlBYSlRpdHJzZlhxYVlZeHQ4VFZxZDBKTTVrWlh0aU9uMU5S?=
 =?utf-8?B?MDgvRVM0MjM3c1IrT3VVUCt4TFJrV1NZZUJRa3QxS0ZtNkpUQ3BnbVM5SDlR?=
 =?utf-8?B?VXRsbndibmRnK3VFWGthTFV0Y1ZaU3FXYTNpTGU0M3NtcnJibzJhMXEzQ1JN?=
 =?utf-8?B?T0N1aFViZUxySUdyK3Y5UTRmNmswWlhkQ2FMcjhxSTM0MDFoNjRlS2dGTTlL?=
 =?utf-8?B?SGRKaEpBazRjVHVMelpFbHZPSG9OMS9WOGNSRkdmdFhNNkdYZlNtTFAzYlVE?=
 =?utf-8?B?aFhwMXh2cUkydXMxRzhjUWpXbjZYOGRaWG1xb3h0T2VrT3p5Z3FBYmRaQ2dh?=
 =?utf-8?B?ZDNUSDF0NGpuWEtpeGx5aEZmV2NJbEN6TGRJWXhhWTZDT1JMTkE1bldyQjR5?=
 =?utf-8?B?U01uYis2ZUc0Y0tmVm5wT3JEVGRQVFZRMlcvVnM0MExUa2t3bmxMMVJHWm85?=
 =?utf-8?B?YWdhY1RSOUxibUNoN2NlTS9DN0t6c0s5VDN5bE9KS2ZTc04rOVRVZ0pJK3ZS?=
 =?utf-8?B?aW1LbUZVTTNGa1ZDampMcW9sMlIydHhwY2w3amo5clRqNTdqVzNvMFBEeDNI?=
 =?utf-8?B?WnJKam1hSFpQaGE0Z1RTM204RGVTZlhUQis2S3N3YmpLNFZ1MFhGV1NqQU9u?=
 =?utf-8?B?T2xXUkhRdEE0dnc0T004cHpSYjJUdS8rNUd2YkVHMDNISmlRTE11cHJvQ3pa?=
 =?utf-8?B?ckV1V1piUkRIaG5HQjhqbm1iTkdNbUxoUC8wT2ltK2VETEI4b0xPSkpLSzBJ?=
 =?utf-8?B?WHlBVXhQdHo2VVlaQUhxV1JCSDRLTGVuam9zQUJid2dtc2pWUTZCMnhhT1du?=
 =?utf-8?B?WTV3TnBSZlBHZ0JFbXFHYTl6WWwxSnFxeGlXY0NYSFJaeTJybFR3WWZ3RU1n?=
 =?utf-8?B?TTJ1ekRRTWxaQ0lYNWYzZk0vdjRvN0JxeUgxMkpES2tRTHNia3RBMTJlN1h5?=
 =?utf-8?B?UUtvY0hadmREdGd3OHZ2M2R3WFdscEFYN2FBL2lzNVdGeDQ2N1NKcTFOSEdG?=
 =?utf-8?B?V21wcWFyeG4rbHMyRkxkNThHbzM5YkdaanVjc0FscnBLVGliMkdRbGI0aDgw?=
 =?utf-8?B?Tmx2OGVqRC8vSWFxNzhvNWxnTGNkM2NsNVNYZTBwamZHRkNIZnhwQzZtdWxq?=
 =?utf-8?B?bWxCMEp5UEErL1k2RW90b1duZmIxODNiUkZseGYyTXVqOEhSWWxhNXhUT3dt?=
 =?utf-8?B?d3ptMFlsSlF6ZmhzK2hqdXd5N0s1VlVqbzQzWDBvclZFby84UDhFZHladDhJ?=
 =?utf-8?B?RFpRcVAxQlhMWE1Ealo4ZWo4K3ozQXV5YnF6ZURuT05JVFFyWDNWV3IvTHcv?=
 =?utf-8?B?d0wrT1orT1hmNDd1R0pEQXc1TUpkUGJTWE14UHdWMEE0U2tiTmVoL0xrWWJY?=
 =?utf-8?B?d1pTeWNKUE5jZzN5KzVjb3lVbmJYUEFRaElOam1ra05UbVBob0JZSGtsL0Fz?=
 =?utf-8?B?bFpEdUhMaFZacWlPRStqRGIvS0xhazhuZXYyZ3g4ZWo2aHRpZE1DeDJzeUxk?=
 =?utf-8?B?S25BN2F2SCtCRGZTR3JBL0NROGhnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02A37A5D6ED4C343A6162C712F06A1DE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3928b958-4ba4-426b-9de9-08dc65609a40
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 19:47:55.8609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vvIr4F0dDHza27Zi3IHPbrsJIiWdgaBz9WkLM9ewHhjJIuHNKEqy/EWOA6Wxomm0emA8nREkEgSE5P7v8L6kiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6601

T24gVGh1LCAyMDI0LTA0LTI1IGF0IDEyOjIwIC0wNzAwLCBNaW5hIEFsbWFzcnkgd3JvdGU6DQo+
IE9uIFRodSwgQXByIDI1LCAyMDI0IGF0IDE6MTfigK9BTSBEcmFnb3MgVGF0dWxlYSA8ZHRhdHVs
ZWFAbnZpZGlhLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gV2VkLCAyMDI0LTA0LTI0IGF0IDE1
OjA4IC0wNzAwLCBNaW5hIEFsbWFzcnkgd3JvdGU6DQo+ID4gPiAgSWYgdGhhdCBkb2Vzbid0IHdv
cmssIEkgdGhpbmsgSSBwcmVmZXINCj4gPiA+IHJldmVydGluZyBhNTgwZWE5OTRmZDMgKCJuZXQ6
IG1pcnJvciBza2IgZnJhZyByZWYvdW5yZWYgaGVscGVycyIpDQo+ID4gPiByYXRoZXIgdGhhbiBt
ZXJnaW5nIHRoaXMgZml4IHRvIG1ha2Ugc3VyZSB3ZSByZW1vdmVkIHRoZSB1bmRlcmx5aW5nDQo+
ID4gPiBjYXVzZSBvZiB0aGUgaXNzdWUuDQo+ID4gVGhpcyBpcyB0aGUgc2FmZXN0IGJldC4NCj4g
PiANCj4gPiBTbywgdG8gcmVjYXAsIEkgc2VlIDIgcG9zc2liaWxpdGllczoNCj4gPiANCj4gPiAx
KSBSZXZlcnQgYTU4MGVhOTk0ZmQzICgibmV0OiBtaXJyb3Igc2tiIGZyYWcgcmVmL3VucmVmIGhl
bHBlcnMiKTogc2FmZSwgYnV0IGl0DQo+ID4gd2lsbCBwcm9iYWJseSBoYXZlIHRvIGNvbWUgYmFj
ayBpbiBvbmUgd2F5IG9yIGFub3RoZXIuDQo+ID4gMikgRHJvcCB0aGUgcmVjeWNsZSBjaGVja3Mg
ZnJvbSBza2JfZnJhZ19yZWYvdW5yZWY6IHRoaXMgZW5mb3JjZXMgdGhlIHJ1bGUgb2YNCj4gPiBh
bHdheXMgcmVmZXJlbmNpbmcvZGVyZWZlcmVuY2luZyBwYWdlcyBiYXNlZCBvbiB0aGVpciB0eXBl
IChwYWdlX3Bvb2wgb3INCj4gPiBub3JtYWwpLg0KPiA+IA0KPiANCj4gSWYgdGhpcyB3b3Jrcywg
SSB3b3VsZCBiZSB2ZXJ5IGhhcHB5LiBJIHBlcnNvbmFsbHkgdGhpbmsgcmVmL3VucmVmDQo+IHNo
b3VsZCBiZSBkb25lIGJhc2VkIG9uIHRoZSBwYWdlIHR5cGUuIEZvciBtZSB0aGUgbmV0IHN0YWNr
IHVzaW5nIHRoZQ0KPiByZWd1bGFyIHtnZXR8cHV0fV9wYWdlIG9uIGEgcHAgcGFnZSBpc24ndCBn
cmVhdC4gSXQgcmVxdWlyZXMgc3BlY2lhbA0KPiBoYW5kbGluZyB0byBtYWtlIHN1cmUgdGhlIHJl
ZiArIHVucmVmIGFyZSBpbiBzeW5jLiBBbHNvIGlmIHRoZSBsYXN0IHBwDQo+IHJlZiBpcyBkcm9w
cGVkIHdoaWxlIHRoZXJlIGFyZSBwZW5kaW5nIHJlZ3VsYXIgcmVmcywNCj4gX19wYWdlX3Bvb2xf
cGFnZV9jYW5fYmVfcmVjeWNsZWQoKSBjaGVjayB3aWxsIGZhaWwgYW5kIHRoZSBwYWdlIHdpbGwN
Cj4gbm90IGJlIHJlY3ljbGVkLg0KPiANCj4gT24gdGhlIG90aGVyIGhhbmQsIHNpbmNlIDBhMTQ5
YWI3OGVlMiAoInBhZ2VfcG9vbDogdHJhbnNpdGlvbiB0bw0KPiByZWZlcmVuY2UgY291bnQgbWFu
YWdlbWVudCBhZnRlciBwYWdlIGRyYWluaW5nIikgSSdtIG5vdCBzdXJlIHRoZXJlIGlzDQo+IGFu
eSByZWFzb24gdG8gY29udGludWUgdG8gdXNlIGdldC9wdXRfcGFnZSBvbiBwcC1wYWdlcywgd2Ug
Y2FuIHVzZSB0aGUNCj4gbmV3IHBwLXJlZiBpbnN0ZWFkLg0KPiANCj4gSSBkb24ndCBzZWUgYW55
IHJlZ3Jlc3Npb25zIHdpdGggdGhpcyBkaWZmIChuZWVkcyBjbGVhbnVwKSwgYnV0IHlvdXINCj4g
dGVzdCBzZXR1cCBzZWVtcyBtdWNoIG11Y2ggYmV0dGVyIHRoYW4gbWluZSAoSSB0aGluayB0aGlz
IGlzIHRoZQ0KPiBzZWNvbmQgcmVmZmluZyBpc3N1ZSB5b3UgbWFuYWdlIHRvIHJlcHJvKToNCj4g
DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NrYnVmZl9yZWYuaCBiL2luY2x1ZGUvbGlu
dXgvc2tidWZmX3JlZi5oDQo+IGluZGV4IDRkY2RiZTlmYmM1Zi4uNGM3MjIyN2RjZTFiIDEwMDY0
NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3NrYnVmZl9yZWYuaA0KPiArKysgYi9pbmNsdWRlL2xp
bnV4L3NrYnVmZl9yZWYuaA0KPiBAQCAtMzEsNyArMzEsNyBAQCBzdGF0aWMgaW5saW5lIGJvb2wg
bmFwaV9wcF9nZXRfcGFnZShzdHJ1Y3QgcGFnZSAqcGFnZSkNCj4gIHN0YXRpYyBpbmxpbmUgdm9p
ZCBza2JfcGFnZV9yZWYoc3RydWN0IHBhZ2UgKnBhZ2UsIGJvb2wgcmVjeWNsZSkNCj4gIHsNCj4g
ICNpZmRlZiBDT05GSUdfUEFHRV9QT09MDQo+IC0gICAgICAgaWYgKHJlY3ljbGUgJiYgbmFwaV9w
cF9nZXRfcGFnZShwYWdlKSkNCj4gKyAgICAgICBpZiAobmFwaV9wcF9nZXRfcGFnZShwYWdlKSkN
Cj4gICAgICAgICAgICAgICAgIHJldHVybjsNCj4gICNlbmRpZg0KPiAgICAgICAgIGdldF9wYWdl
KHBhZ2UpOw0KPiBAQCAtNjksNyArNjksNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQNCj4gIHNrYl9w
YWdlX3VucmVmKHN0cnVjdCBwYWdlICpwYWdlLCBib29sIHJlY3ljbGUpDQo+ICB7DQo+ICAjaWZk
ZWYgQ09ORklHX1BBR0VfUE9PTA0KPiAtICAgICAgIGlmIChyZWN5Y2xlICYmIG5hcGlfcHBfcHV0
X3BhZ2UocGFnZSkpDQo+ICsgICAgICAgaWYgKG5hcGlfcHBfcHV0X3BhZ2UocGFnZSkpDQo+ICAg
ICAgICAgICAgICAgICByZXR1cm47DQo+ICAjZW5kaWYNCj4gICAgICAgICBwdXRfcGFnZShwYWdl
KTsNCj4gDQo+IA0KVGhpcyBpcyBvcHRpb24gMi4gSSB0aG91Z2h0IHRoaXMgd291bGQgZml4IGV2
ZXJ5dGhpbmcuIEJ1dCBJIGp1c3QgdGVzdGVkIGFuZA0KaXQncyBub3QgdGhlIGNhc2U6IHdlIGFy
ZSBub3cgcmVhY2hpbmcgYSBuZWdhdGl2ZSBwcF9yZWZfY291bnQuIFNvIHByb2JhYmx5DQpzb21l
d2hlcmUgYSByZWd1bGFyIHBhZ2UgcmVmZXJlbmNlIGlzIHN0aWxsIGJlaW5nIHRha2VuLi4uDQoN
ClRoYW5rcywNCkRyYWdvcw0KDQoNCg0K

