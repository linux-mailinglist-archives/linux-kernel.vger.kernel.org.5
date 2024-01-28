Return-Path: <linux-kernel+bounces-41682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E07E83F652
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AF2A1F217FE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C778F3C482;
	Sun, 28 Jan 2024 16:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UyNt1npP"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF553C087;
	Sun, 28 Jan 2024 16:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706457988; cv=fail; b=QUTN8CArYqHeacz+IHh5N6HSTGZgr5yOWc/eadC8fl0woQHFrGV0Gln/iOMkkyDCQEqh078cSj8anGE7zR1JaOPG/YX9c7etA2QSmwtgoXRJyplukFagkq6ZIqCjmps1Xyb4K7AlHCBrFU9FXfpN731+RHDVQn5mI0L88N8yVmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706457988; c=relaxed/simple;
	bh=3ZnSo9izPRXOfglTqu5D2GWEwJvFgrARFrCeQO/p1fw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hvIRTpoyU6mh4ZRQ41km7BIla/W+oyoK2VO1BdPFxVarIf6McwxHMdV6CIIeiABs0MiT3ZQfFZ9zdJSziDY576Ai8bVfcr0fnB53k643YhajO4iSBMn+FfG5wWkggfQ4luLOhRFq1Es0cZuDWyzVbn/kFrsPohK/V0YBD8lp3K4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UyNt1npP; arc=fail smtp.client-ip=40.107.237.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGfJ0K2C1QudKXCV8EABVyuzaAkv8E4zEVdy0hVOLS8k4IOTQbbSg7z8+X6KXN/ED2wIemtWl/vojNrf414ooEuOSEEZk8uWB65cBKGuAmp3EhMtQZ/Cf/XxLAKuNXqF261W8QH78K3f8esGCni8zo1rT21rhJvFCdoVJkv0wUtspftT8kHb7G9QWtroWB2XFYOW6L/CvrO4+hteDCEeVJUZsevvWn6v2EbylH9PViXZyd3XU3i2aPOP5Bv7ebWDXHxHEYBQfwdh8Y5PTVKmAgMaZsW7oLx6+9bhEYr9rC4f3/ELDKFDomYL28tiJ+mGiC0qGaLHJoIXaWHCq3O3xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKrSeqX3yQ6LSki8ZPLEC5cYEUaNnu9bwYcMHEUDEPQ=;
 b=aZi30AkXl6lofHMjG+iMWx760IM+e+DlE9gj1umuHIEJ6t3Yn/O1uwtNBq4DPHXIUMcPeVMdpr8dIDxU5F3vGPFJ+L2bhgdjinVPK0P4DUt+UluqZ3Ogwu1AMgDnpn+bSrVcYfb04UTS+w0Al4GDYqjkvfuQ0gSfqFVwwukMpWUgjujyViMSUWYr0ERy5xqbkkwW/ewKDq3QNVsrKF3S2edwlT9sRgtX+Q9643n6PHT74KOIQXKXJJOjUfYIcuLW83s488SqIxmmSz3pSqC7n23WxD4ma43eCMqLYIUpwgCqDgzLSo1eNzCqPxjhvNJZNMROEya6nKGBJ8SHqXQsGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKrSeqX3yQ6LSki8ZPLEC5cYEUaNnu9bwYcMHEUDEPQ=;
 b=UyNt1npPrc3AgeLeuy1xi2sJY9tM6o+z1A3k7OjlAqWNImzBoGlVxAeG1f6G+XZNrrvRNS/qm5c+HOp7qShJ4bRGvrhZH6xwlBRLkKeqoOT8fueDUkyWTeZNRVZUltozi4EV1pwJm6vJuQI1gvdg3YnjA8lB3CFmKMcPRTCDSGQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN0PR12MB5857.namprd12.prod.outlook.com (2603:10b6:208:378::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.31; Sun, 28 Jan
 2024 16:06:22 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64%4]) with mapi id 15.20.7228.029; Sun, 28 Jan 2024
 16:06:21 +0000
Message-ID: <8cf38c26-c8ec-401e-8aab-527ef811af90@amd.com>
Date: Sun, 28 Jan 2024 10:06:18 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] usb: typec: ucsi: Adding support for UCSI 3.0
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-usb@vger.kernel.org
Cc: pmalani@chromium.org, jthies@google.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hans de Goede <hdegoede@redhat.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Prashanth K <quic_prashk@quicinc.com>,
 Rajaram Regupathy <rajaram.regupathy@intel.com>,
 Saranya Gopal <saranya.gopal@intel.com>, linux-kernel@vger.kernel.org
References: <20240126183930.1170845-1-abhishekpandit@chromium.org>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240126183930.1170845-1-abhishekpandit@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0214.namprd04.prod.outlook.com
 (2603:10b6:806:127::9) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN0PR12MB5857:EE_
X-MS-Office365-Filtering-Correlation-Id: a72ba11b-074a-4519-70ff-08dc201b11ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4G3Irvt4QQPLhsDT2jFFau4wsHGZpG0OmgjC+Gvf3lJuKb7e2FPOBCYrM5o3rNfVY7jZdjvmbzSgChOpHP6VwF2nuxQOltNC3O5YxegzIZhzVTcg4aE0UJ6F3i2qzVDqrg+DlrXW64Ggfj0vol1H25dNUINgkqH1SZN5cVPvWuCCAux25XOXWZ0dxIyNY1irSHqa3CqRldQwfrZXbTSA1UvINjtGD8Mhb61L4zlnDlgIdbT5k1VjjL6XIc4VNqD6xfiD8a/hRUU7atJGMvv/sqr7NEOkYWXmLIE0Qru+IBdmdYXWChmReTHV9HS1PaVzgkEcQXl0WNpyBjSclf3gncP2MGHUhzoVdHLY1sWDjDWcKcwB7vSLQPmzJVYM04L4vSBGU2TpTQAsjEnQtMYWK55gXSp0LZNYJEcXeh83UwKsaoREo152uw1sNkgeC/rkUyV7obbv5iBLQQSRJomliV+geAF1FOyZjohW77D16CPWTxnjpf1qcAZIzY23BUxDxhkcWUPGoMEBrNPJ7Lu/fXhPp8L+sW9CwFry1zf20SJwvfe1Xd0ShtgRxmhwIS6XdRLzU5Ol6kRAHc8qn9X7kow/ywZ1O6dNFBkdQslU0382s41ndnODVkNZ8nLgpZmb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(376002)(366004)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(41300700001)(31696002)(478600001)(45080400002)(6666004)(966005)(2616005)(53546011)(6512007)(6506007)(6486002)(86362001)(38100700002)(44832011)(5660300002)(2906002)(7416002)(66946007)(110136005)(66476007)(316002)(66556008)(54906003)(8676002)(8936002)(4326008)(31686004)(83380400001)(26005)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NE9CenplNjFZbnVwVTNSTG1hUjc5d2pWZVExSnp5OHhRTUVUUG00bDM1VWVy?=
 =?utf-8?B?VFpIajgxc2QxQ2kwdm5WdFViNXVHTWY2Z0x3ZW5ob1JUQ2pLenV2UFNrUmMx?=
 =?utf-8?B?VlVZUWJzNDBRblZKcnZKOWVBSzNDeUFKZkxyNGV2YkorQ0tSSDVxeXlWZG9y?=
 =?utf-8?B?TTQrN1kwTTIwMmlYZEVrdWpmc21PYU1vR1RXQm4yNndqR2JCWGRLYUdmMk1W?=
 =?utf-8?B?UUZ6d0JzcXh1RW9wdHFpSTVJMGMva2RnMVV3NHpqemc2Zmhxc0NhUzhrbC9s?=
 =?utf-8?B?K0loL25KS2dUOVRRamZCNFczczFmYkozc0RoL2ZOcnRFbUNid2Qwcm81WExJ?=
 =?utf-8?B?VHpZWjd3NnBmL2MwTUl0aFVkNU5LMXBWSVVHazJ1UWF3K1NVTHI1MStZeFFT?=
 =?utf-8?B?RTJja0ZDOTlhWnhkbStsSDl6bENaR3Zvd3ZCd3dNS3VYcEFCWjN6N0tNMzNy?=
 =?utf-8?B?Uncwd1lscHNOQWtaeHl5NWRjT0NQeXZDMjllaUlseU9LSVNoeUxtQVNRQ0Zo?=
 =?utf-8?B?N2h5YWdvajFsNE9WS0o4VU1JaCtaeEtvV2QzV3J0Mk85czBybURUQVlHbnFS?=
 =?utf-8?B?L1lwUW1Ld2ZvVk5wcUJaTnBhRzBPNW9GTnB2U3VxUUJJL2hrbFRxMVFVZTNx?=
 =?utf-8?B?aXg5djVZSDdrejdyZzBJbVBhRUtIdUdFcXJuTUR5S3N5T1hHOFVUTXZFZ0V6?=
 =?utf-8?B?R3RDOCtTOHVUeEg1eU5LVHZVc3MyWGNsdFcrdmprTFViNlEwckpYRG1hM0VM?=
 =?utf-8?B?a0lPd21ieExJWUpheVorL3B5eHU4WGpCczB5YnpzR1Bxb0lidFVSTzM2WDM4?=
 =?utf-8?B?V1d1WUFFUVZ6N1JvS3poVlM1MG0wTFNnTGVycnVwVmxrUHpGc2tNS1ZyWFBR?=
 =?utf-8?B?SkNBUGlqUTNZTjd1aDRGU2xUa09qNXNLUmdONnZvUTB4UmpHbjZWdHpYdHlm?=
 =?utf-8?B?TlVnR1ExV0U2VEw2OXR1WUpEY2I0cUk1RWNraDMvb0NyT0VISTRqN0VteEdF?=
 =?utf-8?B?YnBUTmZHd3Z1MUMxeVY3ZHZ2WUZ6WFVKVXJyak90R1I2WktJUG9HcVZSbE5G?=
 =?utf-8?B?N3VLWGNJUnRLOXEvUHZNYytxNEhVYlVQUU1JQzdhQ1NRbFJnRjZ6M3ZISnZy?=
 =?utf-8?B?OGFoMkg0VzJKUlBVWHF3R1VuRVFyMGpRZDU0WHBEeVdDSVpKOVpIK3FBcVdw?=
 =?utf-8?B?ODNYa05valVyc3BBZC9CZ3VXVjhHdEcxZ3VTbTRJYnpoUFo4RjRFaC91Ykd3?=
 =?utf-8?B?VWFhbU9lRTQrb0p4VkJSYXU4T3VjWVBnaFdrUm0veUJSUTI5dnJYdkpaRkdI?=
 =?utf-8?B?UWQvTGU2SjVGY0ovU0dVOWZFM2I2aC8xTTUwWTFmMGplUEhWOVpiOGp6Ullh?=
 =?utf-8?B?RnVIbDU2Mm0xNC90OW9DcGtkL0pRQ0c1WStmNklkNU9HNi9EVUtmTVZjMUZD?=
 =?utf-8?B?VlkwR3o2ZUlVck9qWWRzWkVzRkVzcHlMSk1Sb3VvT3VEc0VKcWkxeHN6TVlX?=
 =?utf-8?B?aXh0cHBWUVlvY0xyakZITmV4WERxazVEQXpPYkpnckdETi81N3hYUWNsRURL?=
 =?utf-8?B?eHJ0eFpQeEMxcnEyS1hDMWNZYW5WSE94UVJQVEdFM05rWlU2Ni9QVjY1cTc2?=
 =?utf-8?B?bXBrV3NoQ2oxdExxeFl1Um5zTE1kanBzaGY3U1lMVHR4bmJZQWlCejFvcFBy?=
 =?utf-8?B?RTd6ejFCaTdPRlBSQmlTbjlaNmxLNTBQTjlPVlhZTjVUL29kck9Wamhzd2h5?=
 =?utf-8?B?YXN4aHBDdGdDUWFNNXlCTnRHMlhsYTc3YlczZURCOUFZZEcvdFVLb3hpMTUr?=
 =?utf-8?B?blBPUTJWek9ndmFUWWlzVXNJWk9rMTkwV3lrbXZ1Nlc3cUFjRFlzY2NJaGJM?=
 =?utf-8?B?dm5vQ1NzWDRvc2FYY3Y0VzgxVXZBN0NZZWU3cVRqTTUyMHp4TjhLK0ZTWVBp?=
 =?utf-8?B?RlFWekY1U2g5K2VVMklqMVYwVkVOaWp5OGNxZkxBa0JkMlZ0R1dBcWhZWUY1?=
 =?utf-8?B?ZEpzc25lTEdZSzJQWkVjMUo5NUk0MGRLbUtQMHlDYmZXbTkzV0djWGl6Wjg5?=
 =?utf-8?B?bWFMQ1NRenVLZWtIMzdUWUE1NWJsd1pGS2NzdVFPQy9ObGl4YWs3ZXpXdlFM?=
 =?utf-8?Q?LO55OajejYjtce4SnzBEiLetb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a72ba11b-074a-4519-70ff-08dc201b11ce
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2024 16:06:21.8132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MyjwdJBMUQ+q4UYQw2RadI2OZCtVWD0GObf8bYhp3t9w86D6Rsvc3+DrEBzU3gZop6pJB28yUskZxyLUJBogZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5857

On 1/26/2024 12:39, Abhishek Pandit-Subedi wrote:
> 
> Hi Heikki,
> 
> This series starts the work adding UCSI 3.0 support to the UCSI driver.
> 
> There's a couple of pieces to start here:
> * Add version checks and limit read size on 1.2.
> * Update Connector Status and Connector Capability structures.
> * Expose Partner PD revision from Capability data.
> 
> These were tested against on a 6.6 kernel running a usermode PPM against
> a Realtek Evaluation board.
> 
> One additional note: there are a lot more unaligned fields in UCSI now
> and the struct definitions are getting a bit out of hand. We can discuss
> alternate mechanisms for defining these structs in the patch that
> changes these structures.

On the Windows side I notice that Microsoft explicitly checks the UCSI 
version to decide what data structures to use.

https://learn.microsoft.com/en-us/windows-hardware/drivers/usbcon/ucsi#ucm-ucsi-acpi-device-for-ucsi-20-and-greater

Perhaps doing something similar makes sense in Linux?

> 
> Thanks,
> Abhishek
> 
> Changes in v3:
>    - Change include to asm/unaligned.h and reorder include.
> 
> Changes in v2:
>    - Changed log message to DEBUG
>    - Formatting changes and update macro to use brackets.
>    - Fix incorrect guard condition when checking connector capability.
> 
> Abhishek Pandit-Subedi (3):
>    usb: typec: ucsi: Limit read size on v1.2
>    usb: typec: ucsi: Update connector cap and status
>    usb: typec: ucsi: Get PD revision for partner
> 
>   drivers/usb/typec/ucsi/ucsi.c | 49 +++++++++++++++++++++++++--
>   drivers/usb/typec/ucsi/ucsi.h | 64 ++++++++++++++++++++++++++++++++---
>   2 files changed, 107 insertions(+), 6 deletions(-)
> 


