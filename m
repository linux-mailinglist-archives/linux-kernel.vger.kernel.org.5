Return-Path: <linux-kernel+bounces-91361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0A4871008
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F1781C20DE2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7227BAEF;
	Mon,  4 Mar 2024 22:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kkF2O3J7"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B511C687;
	Mon,  4 Mar 2024 22:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709591073; cv=fail; b=UCSX2l7tozn0O45MpSqgAc5aZh0huOCUDAA38BcPqA/XyZgyy0BFH1yWwugJizvmC4T+wEyLY6R0PhBhLhhUcROGFTrRKeEgjVT7EeREI/I5lnGM2Fe9nC3bA+2lYOygXl3DIk//zJDYq02Idsl+6omRVlL+M9dP3A74peZ44CQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709591073; c=relaxed/simple;
	bh=3S+X/o8r9vzdhLG1y2LCP40uuP+E1VXcaACT/CFqlP0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I67WWmgVY0qhBU7vJvtEvQhW5Rr0hc+V9fsQxnGYh2qIlWfab8Hp64t27p70h5d0LXK7yCJHtlsmvj9pqRCerR1qKIvDXs41VFFrk18N/mj56sy4gofPJX76svgPSnB6Venqh4wmmdHSC6DmrmqPsWYDpv7oRQr5NhdjvqCMVkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kkF2O3J7; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+fNqXUEOww5PLeAc4fIATf9MmukrOII3piLWx3KNTy7YasPZw+IaAvwnL0CcuFLXcqRDbfkQV1Fnyt9VOz+dM78mxh13CWGKPnr0Y1jCZfh0fFrAtInmGr0fWiNgmeWXmk5XmTu2PShlcvI8XmV4k0iqcIoIp547SVifDgflaY1ImPb5QXGKg89h4T6JGsu4WGw40/Wan2SZFKzyqgCjiqErPMOBGbxp2V9yiryNiN2nDyNU7FzgYGghEX5xOWmugWjZNrbAl+sZ7GfaQkW0P5JHj9HIrP88N8ta93LoTgttvcXQGWB/j/NH4dUhpRF56wDZJ8WPh+IpaZzQzORBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/HCdLsLu5ImRHk/OQiH/NhlyLsoAvor3NKlqj0ZLbk=;
 b=nS50VxD43epaEy4PBxNyxTLiuL1PDmn2JEokX/RAHKxaF66PrzuuytrR+U+4VLqEje/FYwLQKCQIA1sGujLUzOr7G0W0smzKGxpYpl4H+xKG+FhWRYUBUNX1BOrycbP+rdIA4QPhLh/nZptC0+VO0azVUYa1uqfD3m+XC4haRJaKUlRqpqPeShS/bDviKUZJgpfTuTG1R0cX0K4g4lZlwWkg5d3H097N5FYIWzAsJQmnvMrBZbVLDniAlHt32s00cxt4V7V6u/Y6MU1X0VeQCpi1M7nHtQQZ1E/VOXuuoH3jwznQrkOJEF1taIUZOa5fUJ3I+eyY0n17L9njiWXPZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/HCdLsLu5ImRHk/OQiH/NhlyLsoAvor3NKlqj0ZLbk=;
 b=kkF2O3J7EgB0J6dfJjYnvNYQTYqcw6+ZqxlhSV71mED8lvlgKtS30JBvH0LeNUK4uqCaklaiX/TJc8Eq1ZUhPDIai0PDBCe+H+eE0JpOvjNzL9KEgyvoylU5SK9cEbTxUEVxDljpYCTf/fVZZ6erhxMzxmwDxhu77S740l4h7l8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ2PR12MB7823.namprd12.prod.outlook.com (2603:10b6:a03:4c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 22:24:29 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b49d:bb81:38b6:ce54]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b49d:bb81:38b6:ce54%5]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 22:24:29 +0000
Message-ID: <41ca7504-c3fb-ddb6-e149-4ff82019d678@amd.com>
Date: Mon, 4 Mar 2024 16:24:24 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
 James Morse <james.morse@arm.com>, corbet@lwn.net, fenghua.yu@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, Peter Newman <peternewman@google.com>
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, eranian@google.com
References: <20231201005720.235639-1-babu.moger@amd.com>
 <cover.1705688538.git.babu.moger@amd.com>
 <2f373abf-f0c0-4f5d-9e22-1039a40a57f0@arm.com>
 <474ebe02-2d24-4ce3-b26a-46c520efd453@amd.com>
 <b6bb6a59-67c2-47bc-b8d3-04cf8fd21219@intel.com>
 <3fe3f235-d8a6-453b-b69d-6b7f81c07ae1@amd.com>
 <9b94b97e-4a8c-415e-af7a-d3f832592cf9@intel.com>
 <1ae73c9a-cec4-4496-86c6-3ffcef7940d6@amd.com>
 <32a588e2-7b09-4257-b838-4268583a724d@intel.com>
 <088878bd-7533-492d-838c-6b39a93aad4d@amd.com>
 <9b20589b-6220-4ae7-bfc4-4a826b7114b1@intel.com>
 <5ddb7031-a828-4001-bfdf-5477cb85e9ed@amd.com>
 <1738493b-3248-4c9e-82a8-1599a033440d@intel.com>
 <369ab28a-f3fa-4359-8e73-4dcf214c9b6e@amd.com>
 <54687d59-d0e4-4fe7-b25f-dc1fead01ea1@intel.com>
 <11487a31-908e-d474-50c6-65617d417deb@amd.com>
 <c73f444b-83a1-4e9a-95d3-54c5165ee782@intel.com>
 <55b545fd-2851-0d0f-ac37-ec59838fb4b4@amd.com>
 <1f366890-d9ff-4ac4-9af9-1ea3128a87fc@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <1f366890-d9ff-4ac4-9af9-1ea3128a87fc@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0158.namprd04.prod.outlook.com
 (2603:10b6:806:125::13) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ2PR12MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: 5defdcbe-e5e5-423a-5809-08dc3c99db84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	f6+NJ6FG2fXjvjG4KBfe9Mj93TcKL4jj5974LBmXpi8WGYIqncnUILk9e1Xuas4o0ET1i28V6TL+02Vre6KzPyWtL4jU6cBInIiJshA1FRGUSmbgCNEVSMSUE+DnQfHuALRUV3DLIrYt7FS3onM+FG0qEokRN72pC13aXM4gP+yPv2X/dLj2XHqwero2o0TOC4e4ZNcB1tEjijuH1LHFnttDc4HJ4VCytNvYVsLqvO/fta8zTa6ZLWbyPP6XBLOoGEIE/xv1CCxBx0SEw8db4txZVlA9vawOZPrZ6OUrxDdPpTSr0tVmJFFLRlIdXSp1xs/OfFVaICF+mbKc4igE4imy0mVtwMX8BRK8VbMtDf2mIyda0VVFemz8BpKuSB6xgpsaK47xLq4GS6kmgbjiSFfu2fOk/o7MLDvFUdfXPB4oRwCokNBAdwVBhhzCtBjyGS7vS9U/3ZZtFwy3bERA/y1wuqk9zJqiQHyThfTfrhWNYpzIAEQnKDuOq7DgmM8EkuiJAAEDdNqArK93LhW5jyEVSoUuckB9BjXb9HOsLLVW8NIJsWDFmsppmYmfzKxsaTL39h6d0sQu5F+i4eXQ0sFR3kDQeOsEL2z9gbrMj48nMm3cFW6lHTJYsIbRMpot+gz/p5xmu4gjPZVia7BvTffW3URjtTNXv9ifYlVh3hs32gk1gfdZCZb3TpHcwbmqsFHw1wkLSaf6zVkJOoKnSQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkRPWG5OMmNNMW11aXAwN293T0t6TXFqQzFCdVE2cGtoRHB2ZHNZYmdySzR0?=
 =?utf-8?B?dW1UU1ZxYmphcVVPcjVsQXhid2w2WTRTajVTRmpjYlM5QVVzRUFxRVlSR0RD?=
 =?utf-8?B?R0lkeGcxYzFoMnlCN2ZZa0V0NC93QTErNlg3MDBVcU9JUzROUThtTlp2UnpT?=
 =?utf-8?B?NXF2M1EzdnE5Y0w0SXF1TVYyaHNDN1MrdHlORzNlQVJGdHFDWkM4UWo1WHRy?=
 =?utf-8?B?bFNDMFRhZEY5cmtwOUxMSnA1QmtNUkV2SVZhbitBLzdhcVJTTWg0bVA1a1lV?=
 =?utf-8?B?NXdsNERrSVJzQ25CcnVpYXpHZGZjV2xPZUxpb3d2VXhIdVdrditNNjVlMDBP?=
 =?utf-8?B?SEkrWGx6aWlDRCtOdjRkVTUzSTNsanNQamF3ZDlwQUpPM2Q0YjB2a1JBTHlC?=
 =?utf-8?B?NnlmTTc2T09rcXMvbGgwd3daejhjVEtocFFVdXBMRlN3UmVnMEx4d0cyTjhq?=
 =?utf-8?B?cEpLVlpSRUYyVXNpTlBKdWxhVHdsUnpoZWVoU2ovdmhiSnZWcnFJYTJrOUxS?=
 =?utf-8?B?WnRXV3c5dEpBc2gvYXcyUDUyVkxSL055bUc5S3ZEaWtxTmRHRUxqVkJrZENP?=
 =?utf-8?B?MlE0b1lJejIyVjhLK05PRjlzaXV6VEJ0ZFVOL0lDSU1qWkZ3MEFMR1F1UnRI?=
 =?utf-8?B?dElUd2lYNTNDcytLMnF2OEpiOUpBai9DSDNUQ2E3UDJ4TDdpU0UxNjNPRG1V?=
 =?utf-8?B?cjg5cFVzdjZGVUZYWlFDbHI0NElreW01UEphQ2Q0UnRadjhxejY5ZTZMbTdN?=
 =?utf-8?B?NnlvNmgxZ29UeEJpL2ZqK0FEUzZGUHpvUlgydk8xSlNEV3FoQmt4UThEUXNu?=
 =?utf-8?B?d0UwQTJTYnpTNWNlQ0I2ZjIzK1JVaHgzVDkzZktSdzJTN0dudmJjb3hjcThq?=
 =?utf-8?B?aUcvb0J5TVArSmhleldMU1hnVUdhSld0VzRXVng1bUsyanMxQ1doL25FRXBa?=
 =?utf-8?B?R0VTcUY4Q2J2QXBMb3FyZmJIYzRXdWpXSHpncVN6MFliQ0t4MmFVb0ZyMjJM?=
 =?utf-8?B?dGs3VENrMndWQzFWVTdQb1YyMHdOdkFveE9RMUt1a3VkQ2dXSENReFltaEpz?=
 =?utf-8?B?eUVlRFhsN2pRempxbXpFVHFVbXhMNWw4SkVPZFhLK3E5bW85cWI5WnIxSDFR?=
 =?utf-8?B?Um0rU1BGcnVqTWVWejJGTVp3TUFGVVhVMmJZWERldHJtd2xadThMR0lGN2RS?=
 =?utf-8?B?N2hqSHltK1NKSkpEKzNOa3gyVjRUM2xJWFB3eTJZSHZPN3FmS2dDeVB0bGFx?=
 =?utf-8?B?blFjSzhtZDdYc2d5djRzNnZVTnVDT09Ia2Y0aXE4V0FxcUpXMlVUaGUrWjk0?=
 =?utf-8?B?WTVDZVBPdThhbFU1VmlNYjRzbytYRzh0anE3UGxrcE5mUGtONTNNQkhJZytL?=
 =?utf-8?B?QThyNmV2b3ZjeWxNdEpzc0IzbGJRQS9nOW1pa3VPTzkrVExhVXJTcjlpazN4?=
 =?utf-8?B?b3B5VFM4OFlqSmdHd2lpd05nWk5MR2laZEY3WkVZU0gxbnZXS2dSeTFGR25t?=
 =?utf-8?B?bVhibE5OMWxuczU5VlRKdFo3aktWdCtCaGVidVBIZndCN0tZVFF1K3RndmJJ?=
 =?utf-8?B?S3JpSVBldk1heHBkandnTlk0ZHAzUURoaklJdWdTb2Y2OGxZb0hqdWhRS1I0?=
 =?utf-8?B?TlpDUGNRaTJwcTlyUi8zQkF6U1U1aUM0WTUvdEMzZU5nNy9qV1dNUXFCZUlT?=
 =?utf-8?B?Ky9zUGFFMGx0bjNLR3pBSzNhQUZBdjJ1Mm1XL29PdnV1QTU2TVkxcWdXWVNu?=
 =?utf-8?B?MDJEako3RURHZExPSGcxMHlGSHJraUt1N0RaSzB3bjllVlBDM0tvc0NNaXBO?=
 =?utf-8?B?NXc0QXlzTUUxQmdXYWRmS1UrWFk0V3pDQkVkL1RhZENLZ3ZIZ3RET1dHVmNu?=
 =?utf-8?B?NFNTZi95NUY5WW5Ec1JSVndBRnY5S1JQVjRzaDd1UEl0Syttc0hKMCt3cUJk?=
 =?utf-8?B?VDhHRThDMFAzN1ZHaDhYKyt2RnNIUlZXSkxZZEsrQ2xQU0ZjbTFJT0UvemhM?=
 =?utf-8?B?bkUxdEtGOGVjZE1aTkNXNnRDZkRjekJYN05HRTlGVkxNam8zL0dkZGFJRDVj?=
 =?utf-8?B?aWRUNm5ydWJ3djkzWXhjSk9FaENBYkQ1bFN3RTNLL0c2RkpUNno0MDlDQThB?=
 =?utf-8?Q?Z+aE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5defdcbe-e5e5-423a-5809-08dc3c99db84
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 22:24:29.1620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a00R4GrP/xbn8wnn013dme704Fgl5hJHCug+qq/IcDYJNN8Vv16t+qidW++01wkn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7823

Hi Reinette,

On 3/4/2024 1:58 PM, Reinette Chatre wrote:
> Hi Babu,
>
> On 3/4/2024 11:34 AM, Moger, Babu wrote:
>> On 3/1/2024 5:20 PM, Reinette Chatre wrote:
>>> On 3/1/2024 12:36 PM, Moger, Babu wrote:
>>>> On 2/29/24 15:50, Reinette Chatre wrote:
>>>>> On 2/29/2024 12:37 PM, Moger, Babu wrote:
>>>> To assign a counters to default group on domain 0.
>>>> $echo "//00=+lt;01=+lt" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>> It should not be necessary to use both "=" and "+" in the same assignment.
>>> I think of "=" as "assign" and "+" as append ("-" as remove).
>> Here are our options.
>>
>> a. assign one event (+)
> I prefer that we use consistent interface with what users may be used to
> in other kernel interfaces, like dynamic debug.
> Considering that, "+" will not be "assign one event" but instead
> (let me copy text from dynamic debug to help):
> "+    add the given flags"
>
> So + will add (append) the provided flags to the matching domain, it
> can be multiple flags and does not impact existing flags.

ok. Sure.


>
>> b. unassign one event (-)
> "-    remove the given flags" - it can be multiple flags that should be
> removed from domain.
>
>> c. assign both (++ may be?)
> No. Please do not constrain the interface with what needs to be supported
> for ABMC. We may want to add other flags in the future, do not limit it to
> two flags.
ok Sure.
>
>> d. unassign both (_)
> "=_" will unassign all flags without consideration of which flags
> are set. User can also use "-l" to just unassign local MBM, "-t" to
> unassign total MBM, or "-lt" to unassign local and total MBM specifically.

oh ok. got it.


>
>> I think append ( "=") is not required while assigning.  It is confusing.
> "=" is not append. It is assign:
>
> " =    set the flags to the given flags"
ok.
>
>> Assign or Add both involve same action.
>>
>> How about this? This might be easy to parse. May be space (" ") after the domain id.
> Why a space?
>
>> <group>/<domain id> <action><event>; <domain id> <action><event>
>>
> <control group>/<monitor group/<domain id><action><flags or _>;<domain id><action><flags or _>


Based on our discussion, I am listing few examples here. Let me know if 
I missed something.

   mount  -t resctrl resctrl /sys/fs/resctrl/

1. Assign both local and total counters to default group on domain 0 and 1.
    $echo "//00=lt;01=lt" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control

    $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
    //00=lt;01=lt

2. Assign a total event to mon group inside the default group for both 
domain 0 and 1.

    $mkdir /sys/fs/resctrl/mon_groups/mon_a
    $echo "/mon_a/00+t;01+t" > 
/sys/fs/resctrl/info/L3_MON/mbm_assign_control

    $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
    //00=lt;01=lt
    /mon_a/00=t;01=t

3. Assign a local event to non-default control mon group both domain 0 
and 1.
    $mkdir /sys/fs/resctrl/ctrl_a
    $echo "/ctrl_a/00=l;01=l"  > 
/sys/fs/resctrl/info/L3_MON/mbm_assign_control

    $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
    //00=lt;01=lt
    /mon_a/00=t;01=t
    /ctrl_a/00=l;01=l

4. Assign a both counters to mon group inside another control 
group(non-default).
    $mkdir /sys/fs/resctrl/ctrl_a/mon_ab/
    $echo "ctrl_a/mon_ab/00=lt;01=lt" > 
/sys/fs/resctrl/nfo/L3_MON/mbm_assign_contro

    $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
    //00=lt;01=lt
    /mon_a/00=t;01=t
    /ctrl_a/00=l;01=l
    ctrl_a/mon_ab/00=lt;01=lt

5. Unassign a counter to mon group inside another control 
group(non-default).
    $echo "ctrl_a/mon_ab/00-l;01-l" > 
/sys/fs/resctrl/nfo/L3_MON/mbm_assign_control

   $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
   //00=lt;01=lt
   /mon_a/00=t;01=t
   /ctrl_a/00=l;01=l
   ctrl_a/mon_ab/00=t;01=t

6. Unassign all the counters on a specific group.
    $echo "ctrl_a/mon_ab/00=_" > 
/sys/fs/resctrl/nfo/L3_MON/mbm_assign_control

    $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
    //00=lt;01=lt
    /mon_a/00=t;01=t
    /ctrl_a/00=l;01=l
    ctrl_a/mon_ab/00=_;01=_

Thanks
Babu Moger


