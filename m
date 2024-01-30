Return-Path: <linux-kernel+bounces-45291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 503EF842E21
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 763A81C247E9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58886E2AA;
	Tue, 30 Jan 2024 20:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u+zRbT6D"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE9D5B1F6;
	Tue, 30 Jan 2024 20:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706647636; cv=fail; b=PJuvZRrAuWxmG/rhPIXi07LBzNExuNbkgTQofi+oiNrRWnj2AvV4s4GNNFskSfSeNLOj1ZVIF9VSNdD1CMNplIyXE405vOJ7vd3tE0kMiEdCWvIHBKBAApr9zzTBAOknEMlN03zeKUobUKss4r6AgmBSeQlDL9Cg1fRWwT8dxhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706647636; c=relaxed/simple;
	bh=z5//H4wKUUwlgwhf3C1OaqCyixOg9407VIBBDiy4uxs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vEs4EC7Q73eeYEP5DDuLSiJw102H93ZvyDH6tZ2x8FSvA9io6rP1eP2qSTRy8WEt5TAeAPeCvHotfu5Vw2Mse5oRgG64KdugNSLwBviMZEQZJ8oZZXZ2sWwYEpFKC2vqlAgp6hQw/cu/2b7ew9bheQ3HRxmGnY1vvZjJEBPEQgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u+zRbT6D; arc=fail smtp.client-ip=40.107.94.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRjLYVSDubI+vcMaGrYR+J/sr4za9qBjWLS09GrRjp0g3EXif/X5OTQCb7vubP73OlQUjFDNqFh6ZiB1kG1HZsFghT2+rSDObb94fOEvZlzr3lYdQ9rMaxKFO6f+5PAnrHHrFkT4B914irPnbHDKYq4KrX7QxLhmNv0o0TlPctEMKk5Ba3RKVUm5Sa7cUb0/cy4NkdBUeZ3tPxyRfqYKGldLDSEuy/1bZ+4F9ga638undJai70fB5FH3nJpyFecSGYstqXwuhbfUxLnMxynzvIKi7KEU5APfynz31iMwt937ptTb/GBCl8BCfvwBFw7XFKAlaoTCNR7UaM8VXbc60Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSYyN57EBC23U7BIe9S1ko7qxdjqFrRZyXYbeObGkx0=;
 b=CbqqFbZuViBgCekfHNVhLs3L/mcDaXPSBtBazWG/xSwR33/pw/6gF7U4nx179B+2cBeQmSeFnTL3eAd6vg0UeVSZShVbd/VP5ul11MaMKHA1qV42dGHS0qwLPLZfDflvv/PmnDUjrSQAB2xEJBP2Fl5KQRfD6J6qefTLgqVcR9pgrDUueaaVHtTq3htkYnl6mSxMb6PKpZT9Bx1dIoPh+ZohIMQTVrXbPRE02vK23HcZDL5tjO+hkIo8T3rH8tIbIaHPGsxur19RNYpt2Ao7kWrtvlZ6Dvr6vlWHRSQ+Vi02+/75qPpMweGfRqLweQaGVg5wec8qEA/NtFZodHiPKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSYyN57EBC23U7BIe9S1ko7qxdjqFrRZyXYbeObGkx0=;
 b=u+zRbT6D0xuq7z983K0f3RguRt5MZZDOpQg5nmPcK0i3/yZPHOyVMLvYqL6hGd4vqNTBo8d4TxvPlmrFAdDzP+125K7VzojPBl62+SD3+C0pTnzuW5ljKLxgul19I9e9ebjawzJNWz3PeFjYsa8DLh//Av6Kysb3Xk/76j0WNiQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 20:47:10 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::251:b545:952c:18dd]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::251:b545:952c:18dd%7]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 20:47:10 +0000
Message-ID: <ae93ee54-21ee-478d-8a24-f8c8347126fa@amd.com>
Date: Tue, 30 Jan 2024 14:47:07 -0600
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v9 3/3] remoteproc: zynqmp: parse TCM from device tree
Content-Language: en-US
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: "andersson@kernel.org" <andersson@kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "Simek, Michal" <michal.simek@amd.com>, "Levinsky, Ben"
 <ben.levinsky@amd.com>,
 "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240110213504.3626468-1-tanmay.shah@amd.com>
 <20240110213504.3626468-4-tanmay.shah@amd.com> <ZagjbaGtz/zqoJ6Z@p14s>
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <ZagjbaGtz/zqoJ6Z@p14s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR12CA0030.namprd12.prod.outlook.com
 (2603:10b6:5:1c0::43) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|DM4PR12MB6254:EE_
X-MS-Office365-Filtering-Correlation-Id: f3a2364f-df8c-49ec-eb90-08dc21d4a12d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y6Qs5GlKykEHHTzxbAvS7h8RZntJX8mdDiudJjHTOWAeDly8WkOBFilwuI1AYjC7QU/xrZq761EWRmfVnWBkrB0GlTi6yDT5qYupntjK+nTyOBQlFcub7SRgL5YKLvO56elWnpqpy7tWyDlY9Yr3FMyiXhlUTxDtUn+pWUjScawg1t7xQTPXaEcyQMHf/yOb3Ue9URH5C5U46uTOs5x3St9u8dX/jjlCkGyuHyc8QYP2wZD5jEoPO6R6BpExWlZhUTQUmniKb094s7gq0lYgeGfnXC00hCbo4nzXEbJFPYIkcgsuxUY4G8syz7KOniZcLmMgJj//ZfLExbkwO2waemDvJ24NRM7Nv5jdUz3V44KuTmkVt2Osx76Q0mY7tDAh0eekIVcoY0/3N9ZTjRtWxPEwiPAKByC/mbbysizdQVZFEIG0df4X9m+bNAiGY/RYL+n6p5qydGYSWO644yFYW/WEp4E7FAKVXRFxqxKJqebeIM5zbOX2dR9adMmQ03S1HtAUnpWHZdLQX4R4pNAeNV4hq221uss3+8ZaXI213VY5Plz4y/Bc0+rE2oM3mbCzdQa74N8yeWuzaPAKA+Yalgy2gHKwc13G4hOOBSIL5vSQUlmEVQwauIumoOC41rVlAFgW6PAGvFiAn92x+ohPYg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66946007)(66899024)(26005)(4326008)(6486002)(31696002)(36756003)(38100700002)(83380400001)(478600001)(86362001)(41300700001)(44832011)(8676002)(8936002)(66476007)(6916009)(54906003)(66556008)(316002)(2906002)(2616005)(6512007)(30864003)(6666004)(6506007)(53546011)(5660300002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXl2ZVMvamtXZmVubTF2RmlhUmVRMnRVTktpY3ZiRkEyWk54RGc1bit6UjlU?=
 =?utf-8?B?MVh0MmEzZ1VXcC9vQTdwRFZWVWlxOWlGRDNwZVIvMTAzbmRzZ05sRVZ1R0RS?=
 =?utf-8?B?dVlqRWRjQlZwemh1ZFBGWjJEaG93Q0pQR2U5K3kxMCtSQnJsU1hIWVlDQ1Bz?=
 =?utf-8?B?TS9ITFE5eGJXSElvMk9pazl6R2pUTE9CQ21PQS9XT0luYU13TXB0TzQ0NG9m?=
 =?utf-8?B?M3ZxMnhuNGhYam9TVnB6aG9CTjVPSlJKem1WWTZTd2dZMGxLNUQ2OTRQVzhV?=
 =?utf-8?B?UHFENCtQZktxT25uZWxPOUxlb20yTGRqaE1WQkZ5akIvSVV5VG5zenJTaUZG?=
 =?utf-8?B?VmpRcXJiWjVObWpndjNMN3RCZFN0cGFZazM2UitEUTNXaHNheFJraDVHM2JU?=
 =?utf-8?B?VDRaUmtCc3BLWWxGVjBnU1dqeC85N3k3NzZVci9ZZXdDRmZHRktFNzhpS1RL?=
 =?utf-8?B?Q1NvczhSMStOVjMyT2R3NXNyQzJLYlBqMnFMSFN0TVRIWkw5VnVCbVFuVGw4?=
 =?utf-8?B?U2YrS3J0bE42b3B6UHM5OS9INHVITFBENVlyVkprUW9KdXNsbS94Qy9HMUhn?=
 =?utf-8?B?RWt6a1c4aTlkV1hjbG9oUXFUcmlyOFdxcFZUY1BwK2cza0plQzkzd0Q2a0o3?=
 =?utf-8?B?TEFsNXcyN2czem9ncU9BdThtMGpYQnZQTG50L21xUFJXc0dESjV5V1JTVXJU?=
 =?utf-8?B?NEdBcmU5VDNYNi9mMTFlcGxHSDE4U1FpdHBrNWw5b3U1OVR3OTlTU3hRczFl?=
 =?utf-8?B?dlNWK1B6aHY5ZTdCTWpmY2hpK2tSRkZNVGFlWHp2bWpEUEJjdHAvSVpGbVpm?=
 =?utf-8?B?Rzd0clh0KzQwc2NxOXUrbk1VSHQrUlg4UXMwdkJSRnVsbCtyNG5Vc3RxcFJm?=
 =?utf-8?B?NTBGMWtSM2ZoUVVxZXVMTWxNMUxTanVmZ3VoaTlaSm1sV3l0bHAyang4dHk4?=
 =?utf-8?B?eDVtaHowUlR3TFBoUjU3VUpab0hIK1ZDUFI5OHRjbUU4VUJ3Vk5vTTMrYmZE?=
 =?utf-8?B?bVAxQjBzdEo0eE5NN3podk0yRHFWMDFMcUhNd3lEQzNFODJiNnZHczRMdDJG?=
 =?utf-8?B?TER6aVllcytjVlRpditITkFVcGR2TlUwUHhMZ2hZelppS3B2U3V2bTZnaDlF?=
 =?utf-8?B?UGw5eTZCQWZiVEZDSTMxMG1tWVhySmdRSUhQTW1QRzIzZXQzQThjNWlvOUdk?=
 =?utf-8?B?dnZQd1RsRFNvNEVkVmpyNVZ0WWNQeVVBdkpjMWk1Um01WkJ1RnBtdlVzVlVN?=
 =?utf-8?B?eW9NL0JJMnkyNGF4SnNHMk9YOHhJV25ScWpYSzBoUS91aG9WckRPb3VUMUJG?=
 =?utf-8?B?eGZDUW1Mdk9DM3A0U0IvL0RWTFh1M0Qyd3VNTzRKU1J5emp4QXA2VnZ6RUdm?=
 =?utf-8?B?M0hob0JXdUIzSFNOQzlWV2Z6Sis1ckswOWZYc21iVCtsM3EzaXQydWl3TStX?=
 =?utf-8?B?VHJ2MVVzOW5BMnpFcFpOK1dsMmI0b2NseXN5dmk4amJGeEdaQkV3WHQyQW1p?=
 =?utf-8?B?STc3QnAwM05WM3FjZUM4b2ZDbVAyK1ZKRzZSRkNCaXYxclF0cW1hYWd1Q0Na?=
 =?utf-8?B?b0JWajUvYmJjVUEzckFOMnY1NGhodHlBWTJJN1c1Yko4dUVaR0ViNVZJbXpY?=
 =?utf-8?B?TkFjazk4WlNFbU9DUlBjS3cyOEg1LzBNUU90VkIyVmpRZVkvSGVkR04xVTdZ?=
 =?utf-8?B?WHUvS3RxMFV5ZWtiTUd5ZzNtOTI2MzNlc2JyMzd6NWM5UzRjZVgvakRWYmNz?=
 =?utf-8?B?UTFWRThLUE9GeitwSWRKM2xvRGdVWCtTRjg0T3hOajQyclBKK1JUalhsM3dh?=
 =?utf-8?B?Qlhac0VMUHZ1eFpvWjZoTlJyc1o0NlJkdFJidVNDMzFwTEFCN3cwTGowNGQ0?=
 =?utf-8?B?N2N6N2NRU2Rtd2FhaDRjRk1Qc2xKRFNHWllueEJQTDYyZXRSWjlmT0FIRWx6?=
 =?utf-8?B?RjJMdUl3ZmdoOVBzSEtXRDd0UjV0bE4yUHRXM0NrUkVxeGRyQ25ZN21CVHph?=
 =?utf-8?B?bXlINUlreklXU1hzWTVubVJLblh0eE1BVmh1WUVjV1ZBcGJJWmF5RUFxTmQ5?=
 =?utf-8?B?eHBXV0dOVFAxeGd2Q0RkNTJMNnNJVVk5cUlSMkJ2ckswREd6emtnZzlqVk9V?=
 =?utf-8?Q?ocQujOmfEQCmsSPycSW6FQiAa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a2364f-df8c-49ec-eb90-08dc21d4a12d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 20:47:10.1933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ej5gFe9zt+xQai+9AdoMlgfkBtz2pp0DKLgA7B2YcR8+/hlhXC9G89CXTDoTEmw9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6254


On 1/17/24 12:58 PM, Mathieu Poirier wrote:
> Alright, I spent several hours looking at this patchset and the driver as a
> whole.  I certainly salute your efforts to heed my advice and make the code less
> brittle but I'm afraid we are not there.

Hi Mathieu,

I am back from vacation. Started looking into this. Thanks for spending time on this and helping

to make clean design of the driver. Please find my comments below.

> See below for a different way to proceed.
>
> On Wed, Jan 10, 2024 at 01:35:05PM -0800, Tanmay Shah wrote:
> > ZynqMP TCM information was fixed in driver. Now ZynqMP TCM information
> > is available in device-tree. Parse TCM information in driver
> > as per new bindings.
> > 
> > Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> > ---
> > 
> > Changes in v9:
> >   - Introduce new API to request and release core1 TCM power-domains in
> >     lockstep mode. This will be used during prepare -> add_tcm_banks
> >     callback to enable TCM in lockstep mode.
> >   - Parse TCM from device-tree in lockstep mode and split mode in
> >     uniform way.
> >   - Fix TCM representation in device-tree in lockstep mode.
> > 
> > Changes in v8:
> >   - Remove pm_domains framework
> >   - Remove checking of pm_domain_id validation to power on/off tcm
> >   - Remove spurious change
> >   - parse power-domains property from device-tree and use EEMI calls
> >     to power on/off TCM instead of using pm domains framework
> > 
> > Changes in v7:
> >   - move checking of pm_domain_id from previous patch
> >   - fix mem_bank_data memory allocation
> > 
> >  drivers/remoteproc/xlnx_r5_remoteproc.c | 245 +++++++++++++++++++++++-
> >  1 file changed, 239 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> > index 4395edea9a64..0f87b984850b 100644
> > --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
> > +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> > @@ -74,8 +74,8 @@ struct mbox_info {
> >  };
> >  
> >  /*
> > - * Hardcoded TCM bank values. This will be removed once TCM bindings are
> > - * accepted for system-dt specifications and upstreamed in linux kernel
> > + * Hardcoded TCM bank values. This will stay in driver to maintain backward
> > + * compatibility with device-tree that does not have TCM information.
> >   */
> >  static const struct mem_bank_data zynqmp_tcm_banks_split[] = {
> >  	{0xffe00000UL, 0x0, 0x10000UL, PD_R5_0_ATCM, "atcm0"}, /* TCM 64KB each */
> > @@ -102,6 +102,7 @@ static const struct mem_bank_data zynqmp_tcm_banks_lockstep[] = {
> >   * @rproc: rproc handle
> >   * @pm_domain_id: RPU CPU power domain id
> >   * @ipi: pointer to mailbox information
> > + * @lockstep_core1_np: second core's device_node to use in lockstep mode
> >   */
> >  struct zynqmp_r5_core {
> >  	struct device *dev;
> > @@ -111,6 +112,7 @@ struct zynqmp_r5_core {
> >  	struct rproc *rproc;
> >  	u32 pm_domain_id;
> >  	struct mbox_info *ipi;
> > +	struct device_node *lockstep_core1_np;
> >  };
> >  
> >  /**
> > @@ -539,6 +541,110 @@ static int tcm_mem_map(struct rproc *rproc,
> >  	return 0;
> >  }
> >  
> > +int request_core1_tcm_lockstep(struct rproc *rproc)
> > +{
> > +	struct zynqmp_r5_core *r5_core = rproc->priv;
> > +	struct of_phandle_args out_args = {0};
> > +	int ret, i, num_pd, pd_id, ret_err;
> > +	struct device_node *np;
> > +
> > +	np = r5_core->lockstep_core1_np;
> > +
> > +	/* Get number of power-domains */
> > +	num_pd = of_count_phandle_with_args(np, "power-domains",
> > +					    "#power-domain-cells");
> > +	if (num_pd <= 0)
> > +		return -EINVAL;
> > +
> > +	/* Get individual power-domain id and enable TCM */
> > +	for (i = 1; i < num_pd; i++) {
> > +		ret = of_parse_phandle_with_args(np, "power-domains",
> > +						 "#power-domain-cells",
> > +						 i, &out_args);
> > +		if (ret) {
> > +			dev_warn(r5_core->dev,
> > +				 "failed to get tcm %d in power-domains list, ret %d\n",
> > +				 i, ret);
> > +			goto fail_request_core1_tcm;
> > +		}
> > +
> > +		pd_id = out_args.args[0];
> > +		of_node_put(out_args.np);
> > +
> > +		ret = zynqmp_pm_request_node(pd_id, ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> > +					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> > +		if (ret) {
> > +			dev_err(r5_core->dev, "failed to request TCM node 0x%x\n",
> > +				pd_id);
> > +			goto fail_request_core1_tcm;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +
> > +fail_request_core1_tcm:
> > +
> > +	/* Cache actual error to return later */
> > +	ret_err = ret;
> > +
> > +	/* Release previously requested TCM in case of failure */
> > +	while (--i > 0) {
> > +		ret = of_parse_phandle_with_args(np, "power-domains",
> > +						 "#power-domain-cells",
> > +						 i, &out_args);
> > +		if (ret)
> > +			return ret;
> > +		pd_id = out_args.args[0];
> > +		of_node_put(out_args.np);
> > +		zynqmp_pm_release_node(pd_id);
> > +	}
> > +
> > +	return ret_err;
> > +}
> > +
> > +void release_core1_tcm_lockstep(struct rproc *rproc)
> > +{
> > +	struct zynqmp_r5_core *r5_core = rproc->priv;
> > +	struct of_phandle_args out_args = {0};
> > +	struct zynqmp_r5_cluster *cluster;
> > +	int ret, i, num_pd, pd_id;
> > +	struct device_node *np;
> > +
> > +	/* Get R5 core1 node */
> > +	cluster = dev_get_drvdata(r5_core->dev->parent);
> > +
> > +	if (cluster->mode != LOCKSTEP_MODE)
> > +		return;
> > +
> > +	np = r5_core->lockstep_core1_np;
> > +
> > +	/* Get number of power-domains */
> > +	num_pd = of_count_phandle_with_args(np, "power-domains",
> > +					    "#power-domain-cells");
> > +	if (num_pd <= 0)
> > +		return;
> > +
> > +	/* Get individual power-domain id and turn off each TCM */
> > +	for (i = 1; i < num_pd; i++) {
> > +		ret = of_parse_phandle_with_args(np, "power-domains",
> > +						 "#power-domain-cells",
> > +						 i, &out_args);
> > +		if (ret) {
> > +			dev_warn(r5_core->dev,
> > +				 "failed to get pd of core1 tcm %d in list, ret %d\n",
> > +				 i, ret);
> > +			continue;
> > +		}
> > +
> > +		pd_id = out_args.args[0];
> > +		of_node_put(out_args.np);
> > +
> > +		if (zynqmp_pm_release_node(pd_id))
> > +			dev_warn(r5_core->dev,
> > +				 "failed to release core1 tcm pd 0x%x\n", pd_id);
> > +	}
> > +}
> > +
> >  /*
> >   * add_tcm_carveout_split_mode()
> >   * @rproc: single R5 core's corresponding rproc instance
> > @@ -633,6 +739,21 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
> >  	r5_core = rproc->priv;
> >  	dev = r5_core->dev;
> >  
> > +	/*
> > +	 * In lockstep mode, R5 core0 uses TCM of R5 core1 via aliased addresses.
> > +	 * Aliased addresses are contiguous with core0 TCM and embedded in "reg"
> > +	 * property. However, R5 core1 TCM power-domains needs to be requested
> > +	 * from firmware to use R5 core1 TCM. Request core1 TCM power-domains
> > +	 * if TCM is parsed from device-tree.
> > +	 */
> > +	if (of_find_property(r5_core->np, "reg", NULL)) {
> > +		ret = request_core1_tcm_lockstep(rproc);
> > +		if (ret) {
> > +			dev_err(r5_core->dev, "failed to request core1 TCM power-domains\n");
> > +			return ret;
> > +		}
> > +	}
> > +
> >  	/* Go through zynqmp banks for r5 node */
> >  	num_banks = r5_core->tcm_bank_count;
> >  
> > @@ -689,6 +810,9 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
> >  		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> >  		zynqmp_pm_release_node(pm_domain_id);
> >  	}
> > +
> > +	release_core1_tcm_lockstep(rproc);
> > +
> >  	return ret;
> >  }
> >  
> > @@ -808,6 +932,8 @@ static int zynqmp_r5_rproc_unprepare(struct rproc *rproc)
> >  				 "can't turn off TCM bank 0x%x", pm_domain_id);
> >  	}
> >  
> > +	release_core1_tcm_lockstep(rproc);
> > +
> >  	return 0;
> >  }
> >  
> > @@ -878,6 +1004,95 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
> >  	return ERR_PTR(ret);
> >  }
> >  
> > +static int zynqmp_r5_get_tcm_node_from_dt(struct zynqmp_r5_cluster *cluster)
> > +{
> > +	int i, j, tcm_bank_count, ret, tcm_pd_idx;
> > +	struct of_phandle_args out_args = {0};
> > +	struct zynqmp_r5_core *r5_core;
> > +	struct platform_device *cpdev;
> > +	struct mem_bank_data *tcm;
> > +	struct device_node *np;
> > +	struct resource *res;
> > +	u64 abs_addr, size;
> > +	struct device *dev;
> > +
> > +	for (i = 0; i < cluster->core_count; i++) {
> > +		r5_core = cluster->r5_cores[i];
> > +		dev = r5_core->dev;
> > +		np = r5_core->np;
> > +
>
> Using r5_core->np doesn't work because it deals with the specifics of a single
> subnode when we need to deal with the subnodes of the entire cluster.

Correct. I think below mentioned design should resolve this problem.


>
> > +		/* we have address cell 2 and size cell as 2 */
> > +		tcm_bank_count = of_property_count_elems_of_size(np, "reg",
> > +								 4 * sizeof(u32));
> > +		if (tcm_bank_count <= 0) {
> > +			dev_err(dev, "can't get reg property err %d\n", tcm_bank_count);
> > +			return -EINVAL;
> > +		}
> > +
> > +		r5_core->tcm_banks = devm_kcalloc(dev, tcm_bank_count,
> > +						  sizeof(struct mem_bank_data *),
> > +						  GFP_KERNEL);
>
> Another problem is that when getting information from the DT, ->tcm_banks is
> always 2 whereas it varies (2 or 4) when using the static mem_bank_data arrays.
>
> We know the current driver works well when using static banks and everything is
> already in place to address the mode of operation (lockstep vs split). As
> such I suggest to reuse all that code by making function
> zynqmp_r5_get_tcm_node_from_dt() return a mem_bank_data array of 4 elements.
> That array would be instantiated using the information found in the DT,
> regardless of the mode of operation.  Once we have that array it could simply be
> inserted in function zynqmp_r5_get_tcm_node() and everything else in the driver
> works the same way.
>
> Note that for that work you will have to set the "reg" values of the second
> core to 0 when in lockstep mode, which is fine because they are not used anyway.

I agree to most part. I will have to modify bindings as well to accommodate above design.

I think the problem is in lockstep mode, where two memory regions are combined and presented as single

memory-region in table: *zynqmp_tcm_banks_lockstep*. First I will have to fix that.

If that is fixed, then no need to have two functions for lockstep and split tcm carveouts. They both can be

handled uniformly. Once that is fixed, bindings needs to be fixed i.e.

For lockstep mode, "reg" will have 4 entries and split mode "reg" will have only two entries.

We don't have to make "reg" of core1 as 0 in lockstep mode, as it's not being used anyway.

Once I change bindings as above, then it's very easy to implement changes as suggested.

We parse TCM information from dt if "reg" is available, and fill up the table in r5_core->tcm_banks and rest of the

driver remain same.

I will implement and test v10 accordingly. I think this should make design clean.

Only downside is, we are spliting contiguous region in lockstep mode, so after this change, firmware's linker script

needs to be updated accordingly for lockstep mode (If contiguous regions are considered which is not the case for Xilinx's firmwares).

I would consider current implementation as bug, and will send Fixes tag accordingly where needed.


Thanks,

Tanmay


> Thanks,
> Mathieu
>
> > +		if (!r5_core->tcm_banks)
> > +			ret = -ENOMEM;
> > +
> > +		r5_core->tcm_bank_count = tcm_bank_count;
> > +		for (j = 0, tcm_pd_idx = 1; j < tcm_bank_count; j++, tcm_pd_idx++) {
> > +			tcm = devm_kzalloc(dev, sizeof(struct mem_bank_data),
> > +					   GFP_KERNEL);
> > +			if (!tcm)
> > +				return -ENOMEM;
> > +
> > +			r5_core->tcm_banks[j] = tcm;
> > +
> > +			/* Get power-domains id of TCM. */
> > +			ret = of_parse_phandle_with_args(np, "power-domains",
> > +							 "#power-domain-cells",
> > +							 tcm_pd_idx, &out_args);
> > +			if (ret) {
> > +				dev_err(r5_core->dev,
> > +					"failed to get tcm %d pm domain, ret %d\n",
> > +					tcm_pd_idx, ret);
> > +				return ret;
> > +			}
> > +			tcm->pm_domain_id = out_args.args[0];
> > +			of_node_put(out_args.np);
> > +
> > +			/* Get TCM address without translation. */
> > +			ret = of_property_read_reg(np, j, &abs_addr, &size);
> > +			if (ret) {
> > +				dev_err(dev, "failed to get reg property\n");
> > +				return ret;
> > +			}
> > +
> > +			/*
> > +			 * Remote processor can address only 32 bits
> > +			 * so convert 64-bits into 32-bits. This will discard
> > +			 * any unwanted upper 32-bits.
> > +			 */
> > +			tcm->da = (u32)abs_addr;
> > +			tcm->size = (u32)size;
> > +
> > +			cpdev = to_platform_device(dev);
> > +			res = platform_get_resource(cpdev, IORESOURCE_MEM, j);
> > +			if (!res) {
> > +				dev_err(dev, "failed to get tcm resource\n");
> > +				return -EINVAL;
> > +			}
> > +
> > +			tcm->addr = (u32)res->start;
> > +			tcm->bank_name = (char *)res->name;
> > +			res = devm_request_mem_region(dev, tcm->addr, tcm->size,
> > +						      tcm->bank_name);
> > +			if (!res) {
> > +				dev_err(dev, "failed to request tcm resource\n");
> > +				return -EINVAL;
> > +			}
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  /**
> >   * zynqmp_r5_get_tcm_node()
> >   * Ideally this function should parse tcm node and store information
> > @@ -956,9 +1171,14 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
> >  	struct zynqmp_r5_core *r5_core;
> >  	int ret, i;
> >  
> > -	ret = zynqmp_r5_get_tcm_node(cluster);
> > -	if (ret < 0) {
> > -		dev_err(dev, "can't get tcm node, err %d\n", ret);
> > +	r5_core = cluster->r5_cores[0];
> > +	if (of_find_property(r5_core->np, "reg", NULL))
> > +		ret = zynqmp_r5_get_tcm_node_from_dt(cluster);
> > +	else
> > +		ret = zynqmp_r5_get_tcm_node(cluster);
> > +
> > +	if (ret) {
> > +		dev_err(dev, "can't get tcm, err %d\n", ret);
> >  		return ret;
> >  	}
> >  
> > @@ -1099,7 +1319,19 @@ static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
> >  		 * then ignore second child node.
> >  		 */
> >  		if (cluster_mode == LOCKSTEP_MODE) {
> > -			of_node_put(child);
> > +			/*
> > +			 * Get second core's device node only to use its power-domains.
> > +			 * Also, no need to use of_node_put on first core's device_node
> > +			 * as it is taken care by of_get_next_available_child.
> > +			 */
> > +			r5_cores[i]->lockstep_core1_np =
> > +				of_get_next_available_child(dev_node, child);
> > +
> > +			if (!r5_cores[i]->lockstep_core1_np) {
> > +				ret = -EINVAL;
> > +				goto release_r5_cores;
> > +			}
> > +
> >  			break;
> >  		}
> >  
> > @@ -1158,6 +1390,7 @@ static void zynqmp_r5_cluster_exit(void *data)
> >  		r5_core = cluster->r5_cores[i];
> >  		zynqmp_r5_free_mbox(r5_core->ipi);
> >  		of_reserved_mem_device_release(r5_core->dev);
> > +		of_node_put(r5_core->lockstep_core1_np);
> >  		put_device(r5_core->dev);
> >  		rproc_del(r5_core->rproc);
> >  		rproc_free(r5_core->rproc);
> > -- 
> > 2.25.1
> > 

