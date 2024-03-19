Return-Path: <linux-kernel+bounces-107016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AD587F6C4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF4E9B21BAD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710CF446CF;
	Tue, 19 Mar 2024 05:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SM3ensT+"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2096.outbound.protection.outlook.com [40.107.92.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEF042062;
	Tue, 19 Mar 2024 05:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710826699; cv=fail; b=IXICsw+HCLWBOfoQxuZj4DGzy9TQt+Q1wfOrLC9wrw2SCM3Bne1Ec0fV2sLQ1SO/taQSL9J9lfVcyoSmwbdHqi3gusCbbL09WfZRZ44JmuKAUSqSnCBHOJAl9ntU9h1gY2J0t4dgqE1ZArhElOIbyMTAAMijhdvYliddNNPtfKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710826699; c=relaxed/simple;
	bh=w0BFYVF2z0LDeL81a/Khft9Sq2DMWvRmiAwY/fuYGvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FIm9VOTrSfEDj7UK8UjXiioFhsnXc6OyGfN0iYXMJ6n3mfe39l0mYJHxSDEv9imtybfe1FQoH08Sn/ZTKTSwcDIuO5/xIDTpSKoX81cgRCY1AVAvzHOnw96kZm03iwaJkuWMGU3KISwIBAGZJmiTQsU9dL7NzbEURMcSPWL6mPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SM3ensT+; arc=fail smtp.client-ip=40.107.92.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6CKnechRzRfpMRuYCbugaknN38uA15YrQw2jUrLxeBUzVPvEZJRPHyngblUcXoqToql3FAtbUZP/8PdvWaxTheqf8Ip3LiN9K5/GZwjK63y4v0bwMqeeI9LhJHkh8CGhmng1OJ3UDAoiq3eWnDuvVOksdanrFh9YooGbRnzEFPiKpyxjLSZh7n8o9XJT9t3c5xmkEj/Ypg4jcMYz1acu7RYoaZL2t7YyJeTjIItIbQenDtI+I0Xxm5RIWQs00Xd/s0//KzkmDV1JxmfobWGf18LKiJkV50JqKjGKBHV/wwmqAj1iBki8wlXPG7yDmQGF2WWc2i4BNI2biB+OKWkkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Okk7p/qibxt1pFVKbHOIjHkKUqne06BOVmglraMveSI=;
 b=OkHsHzdiZaGFaeAidAHYGq9FV7X/CqQRCvSRoVW8cNjgQLAAnkeWLIcxjBkWLXSralc3DKQIV8RD20g76jTC8c0R1ieKdQAdCtfNia+hNvb9Ad+C35yD2k5pCxdpi/U7aJtAubtkGJVBgHw28wf5vNb/ZnG5jOXUucuKbDFTgY4L3ZFp65dRj+H0weYhKGWenBTRR40dtSiw1+MF62YaOvIwsXlEfxzQO3wa/En07Gh+gKcvJap7qMF7u3BuU949HGS7cyi6al8CIg56sk8njmnjp9a70GQ61C/P4seLEcQTyqpgYXhO7MwAvSCw9kp4sRjXRtH6r3gWRGNUC0XDkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Okk7p/qibxt1pFVKbHOIjHkKUqne06BOVmglraMveSI=;
 b=SM3ensT+qF9pBRVhWDlWbcI8+KAKDviMuz8edZzt30ryTW/Z0aRuisxtlUlcT3fsrYuSXoAAQIfFb/CofOj6FkSb5dGEuU+7hIDrjOoD0jP52G6h1/RSzG7dGsC9qPhkSwSVG6D2ucY4uyp14TevGzzce9n65at2GXcFsaWfm5s=
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by DM4PR12MB5723.namprd12.prod.outlook.com (2603:10b6:8:5e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.27; Tue, 19 Mar 2024 05:38:15 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::e7a:5022:4b7d:ade1]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::e7a:5022:4b7d:ade1%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 05:38:14 +0000
Date: Tue, 19 Mar 2024 13:37:53 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Yuan, Perry" <Perry.Yuan@amd.com>,
	"Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
	"Petkov, Borislav" <Borislav.Petkov@amd.com>,
	"Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Huang, Shimmer" <Shimmer.Huang@amd.com>,
	"Du, Xiaojian" <Xiaojian.Du@amd.com>,
	"Meng, Li (Jassmine)" <Li.Meng@amd.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 0/8] AMD Pstate Fixes And Enhancements
Message-ID: <ZfkksfgB9cIUkWlu@amd.com>
References: <cover.1710754409.git.perry.yuan@amd.com>
 <CAJZ5v0iQnJCVX0kHNxtOWLcnTXRRjR1HZ6m4CFhKZcQVp1SbEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iQnJCVX0kHNxtOWLcnTXRRjR1HZ6m4CFhKZcQVp1SbEA@mail.gmail.com>
X-ClientProxiedBy: SI1PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::9) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|DM4PR12MB5723:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BsmZvUnsGoqYAmyAaRNl6aCh0NiSQ5/R7c7CzQ992BfQ2QyraoMQ6Uz7SOV4aoKYMn7tRI4sTt6myhnRaK18lFX1TPCtRDWzqCvQzgBPSUTO1vgOxQ7Z2wq1GlHvHNwOvuJzaMN7GL91qcH42KTMeR7WQsjqVisx/t/xE5QxHXrJh7IYx3uaL1Uxx6ez+T0rbTQ8hcNbnWJPhnCTw2rhhzOUapWsTq/IFHFJw+x4zg2xxM5gx08paakTF5Jx+v2BZKIzlPk8644GKMiv7OGFD8mgfPs+sYt234KhcycuZcI9DxcPw2yQCPGNNAHxL0gJvczcS4cKjz8aF1y9kJb3hMXgvFFjjSSQW1rKU/Qaq6zr9MPkW6afVuFGtTg1AP42XTp2Ur3PWT25a9kOMeUXaAStebLjm6B4K3lV9f1hBk2jUX6qJL53M4oti6dPZaJk2elX6tbh4ChdoTTcdTbjm0EZkRWxIm0lTfUldHfvi2GOWjhdOhe31x/5T6adM/sgR7B6Msojq9tv6sNTYRkipHrcLPDzOr4F6sjmBeXB6dMT9HghKm/sZzHeH1rd9HU9OWatZ8mO0KoIsiJjSqRe8f3tZew43pjsgJAe+HXMoGo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8690.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1JFUERjRUZ0MUpsL1U2MDVMVGZRVUdZZnNCNGJIMVdQY0I2RmNMak1BTVFi?=
 =?utf-8?B?S0hkcGJvQzUvM0hsb1lrOEU4cjhuaWxWR0tHUjIrNTVtYkhYYWZQR3pvbWxk?=
 =?utf-8?B?UmdtMVdqNFJYa0piZ2NzL0FDRmZSaFRqWmNqZk51aWxtL1QzdVVnZUc1RGVI?=
 =?utf-8?B?UG9EVTk2L3J1VVVMcXRyYUlrS0JiYmYzMXRYZUxZMlUzWEF3NGUwdnpVaWVp?=
 =?utf-8?B?NEJKOUFoaGtXQVdhbkJxZlk5NWJSb3RzaGpvQ3o5c1JBRjcvdEpDQk5talBY?=
 =?utf-8?B?MVJWT1pmTTRhQ1VacTA2Tlg0RGRkSHJRRjc4d2thUUFnc3o4QittWDE4ZkRp?=
 =?utf-8?B?dHZ3MkE1REpMdHVLeW1aTFhBNUR2bUpiRVNPc1NVRzhNYitsS1k2OWp4U2ds?=
 =?utf-8?B?SHZHNlhMeTh4eDdvZHpYdnUvVUtPNnFZM21mSFBMbWhUWGQ1ZzJwcy9TclJF?=
 =?utf-8?B?RlVGZzZ3SVZNN0QrTGNrUzlJUWdOR0thK2hWRjIzdWR6dDAvOVVVV01kNHpo?=
 =?utf-8?B?dkhabzdVcU5yQTU2SVBZNGZkODdKWlFWNkgyTGkrUTFkTS9sRWx5QmtCOGs3?=
 =?utf-8?B?eDVnYlpTekNyVmk2UmJtMVJRam5USHNUckVqanNkVUdOWnpvOUlLdFNCUmcv?=
 =?utf-8?B?cUhiUk81dUhxQ0FOZHdkVTlUL0VDN3pqUXdFUW4vaXdpZDBCd1A0d3FGUDU5?=
 =?utf-8?B?MXB1MmlXU3BUV1RjZ2FCTXVUTjNhdGtYVmpNdkNxcnNKSlMwM2xwaUNFaHVQ?=
 =?utf-8?B?RURXNlg0bEh0MGxhQWE3Wkl1azduK2RCUnZXSG5rbVdxZlMwSlpCcnhRYU12?=
 =?utf-8?B?cU1TZGY4ZU15U09DcEc5OGlEcVJNVks2VklvS1gvbDR5V21FdXhEckpQTFo3?=
 =?utf-8?B?bG1kaUJpbkNnU1JvUmUvT1NhazBPdFhNV2pSZ21YSVF5eVgrc1FjY1JYbEhy?=
 =?utf-8?B?b3VuOGs3bE5yMnZEN3FxSDh6YXMvS1V0d3Rlb1d2VTVYaXFQRTdTcnNtWGZ2?=
 =?utf-8?B?U0Nja2JIRXJ0Rk41VGRDM0NOSi80Q0k2ZWdXakRYMXE3OGp6cXBsZDZTQmFw?=
 =?utf-8?B?MXVCQWZwNXJMdVlkSzkvUUdaSFJ5UksvVW9BbXZNZXdwUXVYMm56RjZncSs3?=
 =?utf-8?B?ZEF5Mk8wclRQaXp2aW83MExNOU1TSXp6WDJvVUpoM3duMG52YmNoTy94R0RU?=
 =?utf-8?B?aWdWNlVFM2MxOUI0N21hdUhTeFNKWmlqREpMQW9scDNuNDhUQjFHVy9ITEdx?=
 =?utf-8?B?VGZiZERqTzkxRW1oQXMveXNZSGxubW93OU80aUxPQWFvM21pQWl6MWdJczR5?=
 =?utf-8?B?Y0xxNTNQWXByRUNtM1ZSbmJZYm9DTVZWR3BsUlI1SnBEUy9TazgyKzRpRXNL?=
 =?utf-8?B?TE9KZHltV3hheVE0SWNSQWtRNzVFcThLQlF2SEt3L201NjE3ODZpczBNR1c4?=
 =?utf-8?B?OGtJNUlUOG10UUo1V2dodTN1QkRjc2lnOVFGM3hmRG5QNGNuSlBEZTRXcWlZ?=
 =?utf-8?B?dFBXRzFuMEpaRys2b201ZjhMd1FwajA4NWtDaEkyRlVqd2lmV1d3Y1dhcytN?=
 =?utf-8?B?ZGx4dWtxdTV3WHVlUk5TWHJGeEYwb2ErcW5lb2Q1cHk1cUo2Q1dEZGZWNVhO?=
 =?utf-8?B?Y0pGejU2OWV6QkQrajczcDBmRTVEVitjRnkrL2JyN284T0dVbGhUbEVEa29n?=
 =?utf-8?B?T3BBZG04WWZUMmNKdzYxR1U0Z0Jld3lZOWgrOXZtRmRFbHRHMlZYZTRZNytK?=
 =?utf-8?B?cVpCbTZLNEw2L1ZNejZIMFlGeks3cVZWZ00zTUp1ckZJZVNTakN0Mi9ZOFdq?=
 =?utf-8?B?Nkx4Z2E3aGJndFAvWkxYMHFRNWR5UDlsdmllYmFscGJCRUFKOFU4bU4yY1FG?=
 =?utf-8?B?QkptSmttamlDMmludWRzYy9xN2JDSzlGV2hzeGR1U1A0bFAyNmkxUzVwTzNw?=
 =?utf-8?B?WEd6emIvNElWOExJSENpVERWaGZYanY4dTNNeVBJU1dHNGtlc3kzd29LV0w2?=
 =?utf-8?B?S2lTdVJrWVpLM1Y3TFRvRzA1RlYwL000a1kxYmhrV1JpN1JzMzhFRFdxVDVB?=
 =?utf-8?B?RkFxeGJEdUhLdWUvU250SFRvWTlZRTJzM0oyN2VzSDBvck03aUZDVnA2QVlB?=
 =?utf-8?Q?3bxpVdlbQrCIT64SmpDL4H6v0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a19b3c-ce3b-4f02-3017-08dc47d6c59b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 05:38:14.6874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1AIaxCTABz+la8MRP5/mi/mN1uoraKUXbqT/LjkgQtOtZOeVxMwnda7lLdmf+XRwebRy8QqknjX71Jdbs9LImA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5723

On Mon, Mar 18, 2024 at 08:49:55PM +0800, Rafael J. Wysocki wrote:
> On Mon, Mar 18, 2024 at 10:48 AM Perry Yuan <perry.yuan@amd.com> wrote:
> >
> > The patch series adds some fixes and enhancements to the AMD pstate
> > driver.
> > It enables CPPC v2 for certain processors in the family 17H, as
> > requested
> > by TR40 processor users who expect improved performance and lower system
> > temperature.
> >
> > Additionally, it fixes the initialization of nominal_freq for each
> > cpudata
> > and changes latency and delay values to be read from platform firmware
> > firstly
> > for more accurate timing.
> >
> > A new quirk is also added for legacy processors that lack CPPC
> > capabilities which caused the pstate driver to fail loading.
> >
> > Testing done with one APU system while cpb boost on:
> >
> > amd_pstate_lowest_nonlinear_freq:1701000
> > amd_pstate_max_freq:3501000
> > cpuinfo_max_freq:3501000
> > cpuinfo_min_freq:400000
> > scaling_cur_freq:3084836
> > scaling_max_freq:3501000
> > scaling_min_freq:400000
> >
> > analyzing CPU 6:
> >   driver: amd-pstate-epp
> >   CPUs which run at the same hardware frequency: 6
> >   CPUs which need to have their frequency coordinated by software: 6
> >   maximum transition latency:  Cannot determine or is not supported.
> >   hardware limits: 400 MHz - 3.50 GHz
> >   available cpufreq governors: performance powersave
> >   current policy: frequency should be within 400 MHz and 3.50 GHz.
> >                   The governor "powersave" may decide which speed to use
> >                   within this range.
> >   current CPU frequency: Unable to call hardware
> >   current CPU frequency: 3.50 GHz (asserted by call to kernel)
> >   boost state support:
> >     Supported: yes
> >     Active: yes
> >     AMD PSTATE Highest Performance: 255. Maximum Frequency: 3.50 GHz.
> >     AMD PSTATE Nominal Performance: 204. Nominal Frequency: 2.80 GHz.
> >     AMD PSTATE Lowest Non-linear Performance: 124. Lowest Non-linear Frequency: 1.70 GHz.
> >     AMD PSTATE Lowest Performance: 30. Lowest Frequency: 400 MHz.
> >
> > If someone would like to test this patchset, it would need to apply
> > another patchset on top of this in case of some unexpected issue found.
> >
> > https://lore.kernel.org/lkml/cover.1707297581.git.perry.yuan@amd.com/
> > It implements the amd pstate cpb boost feature
> > the below patch link is old version, please apply the latest version
> > while you start the testing work.
> >
> > I would greatly appreciate any feedbacks.
> 
> There are missing changelogs and S-o-b tags in a few messages in this series.
> 
> Overall, I would like someone, preferably at AMD, to take
> responsibility for the amd-pstate driver, review patches modifying it
> and ACK the approved ones.
> 
> Huang Rui, who is listed in MAINTAINERS as the official maintainer of
> it, does not seem to be interested in it any more.
> 
> Can this be addressed, please?

Hi Rafael,

Sorry, I was occupied by other task a couple of months ago. I will talk
with AMD colleagues and figure out the way to make sure the amd-pstate
patches will be actively reviewed and tested. Will give you the feedback.

Thanks,
Ray

