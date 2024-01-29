Return-Path: <linux-kernel+bounces-42954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 965C084093D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C7C6285E4D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674E31534F6;
	Mon, 29 Jan 2024 15:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wCOjhYzi"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C7A657A8
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 15:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706540579; cv=fail; b=masjYedti1Uzq7VuW+ELiHG9M6rVYTk6NIka6EcFMtdq4fK1Kplm3K/ek220oRHkAJGoXW4bxgKmYtWTEqeB7dfKrr6iaxcSSM+ZczHchXze65H0lWDn8C0BN1pMoAdTtQCcYCfVMRyCo3/9HwHVOGBlQWoT+cQVs25EfRF/rmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706540579; c=relaxed/simple;
	bh=mfcX6/yLXU4XB4ZdC6R/hjQyjUnOxZCdy8HS8XguvIo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=atWtH9xIMt+K3LdNxDQaNt6GJcMXM8o8UChvp1OpAoijzkkn/F/2NIykWWphrObGBoF9h6vL7DoGoNnE4p09AaWVElyIE3qwXd/Odu0uldzhRctPYUjIzFIENO+epqpvdQqdW61iBqdJaUDddg2lmOzcG4JfaJnkW+W5hQ1mI0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wCOjhYzi; arc=fail smtp.client-ip=40.107.220.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPzKgAnEPDcrnfjzeESrlL8ZPMgkeDL7wAG5A+LpAm+1yGrERdW8yTuZMb+HHUJpD30S4a05NxD8Nm1s6HbXEGHfCnWfP4qkxUlI2+l9TLaSU1F6wQVoBR0U1e6j7beH2nodldAgo/9ORV2buyzlEWIV1hcne6n3HmVJYscYeW/X5HMIpK2Pr81M+csMCdfd8bZzEOqwwEG1+DJRjnoaJXTmIVBxCn6Bb7S61+Lsx520bOJF0oYhZx+QJI6dLyWQJsX+cLr8o8YRmT8/MXaZNBld+oLzSBYgVny11USLLb1xo97ziB5SvycvARiR5s8omhV/wJW41Zz0BrdL5NgIfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIUAQR9M/r9MyFmWkU2YLmTLEtWFNRNBF4ALs4mhJg8=;
 b=CS8S70VgurI9xAlw9GELr5USpatFFcmSH4141aVf30yklISBOx8WcBcmsUMoPZ6QC4oIJdQmNrGVqCbaVpDmFKKM6z7LSBeyfxw7E04574HjpQXvPdW07Es4xioiPDRj7O4/7V2Zpm8kR8rsqRkO9HLuNeX0hI5WpHtuLd81/V1qrhToTSDVogjcQj7YmdPLeLTBhC6ucj5hbmtoVJE4KAj5+rAjniG9pDfYlLXrA67joVWFrSMfftwYoKcD2MCSqDsmVuLlaebJFZcTp2Qeb8FmUomZjwpHwPZkiUUQmTFuo/aeCJyYl64NX6NdlrXn+60E9QIa6RytqwRQldqHtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIUAQR9M/r9MyFmWkU2YLmTLEtWFNRNBF4ALs4mhJg8=;
 b=wCOjhYziasrsICfwVC4YDQA7pTKy5w4G2pBCCb8t/GlzfxW6rqZaOtiv5vY/V8gVDMMPQSpADpjOlvQ/Hc6qQj7EsWS87SBOCNmGbPrPZD6RZmYN3OdV55l7ns+rcNv5aSPlNPm45eZUjM3X+f0h9qGJobjFlTRVPhe1nMlbJuw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.34; Mon, 29 Jan 2024 15:02:52 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::200:c1d0:b9aa:e16c]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::200:c1d0:b9aa:e16c%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 15:02:52 +0000
Message-ID: <3fca61f2-6fe0-4431-818e-9c7b96c6a391@amd.com>
Date: Mon, 29 Jan 2024 09:02:49 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] x86/sev: Extend the config-fs attestation support
 for an SVSM
To: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Michael Roth
 <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1706307364.git.thomas.lendacky@amd.com>
 <10637f104d1ed7f21e281a4890f2c549d1e85985.1706307364.git.thomas.lendacky@amd.com>
 <CAAH4kHbjZY5J=EQsyXxvthTbpge-W9PTJc4WD-O2JaWZyZFPgA@mail.gmail.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 vFkWitqCJg==
In-Reply-To: <CAAH4kHbjZY5J=EQsyXxvthTbpge-W9PTJc4WD-O2JaWZyZFPgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR10CA0030.namprd10.prod.outlook.com
 (2603:10b6:806:a7::35) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|DM8PR12MB5430:EE_
X-MS-Office365-Filtering-Correlation-Id: dbaabfd9-d6e1-49a0-aeaa-08dc20db5dcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ja7+ZGovyHFE+iyRFPo2r68ZOuqDrwRIDl6Q5HgXump8T7U1utUp08LHMspUeO6MixRNhvd1OLyQ0awttXeJCVUEZ2MdLGcsh9l6CQPZ6wwWdyxbD8nT7JadlDjom5rjdKlI2JhGYRuST+kIl+A2xlNNjTXcciq4scWw+IpAJ1qy8bi24a6JWYO1lfyBE4DxnWiw6DtqtpsAFierMOfrbQy8XSU7lBRintFPGbS+kjomdDl4rmTmvyD1M1xDpfsZCC+aIJvgUkjl7+lMAiQ3wYzAiGzEn02iIGoXRcvZbsnTWa03DGwNrmV5xoyyC/xbGA9avIil49tRMNk5kCzMrCRcCHbYnC2FjzMuzpBhVU/d0cNRda411GOCEru50TgU754e1Jd5ENEEXVKqU8LCkO72TI7Pb8nd1who526cfEm9SCW8ggSK2Q5eGI9Qcb/4xNZEkWd++DkW+9S2ZIEJEfT+1UYuT5L3qCIJLJxdFlYR/+4IcfhvewOI1WaGREeOKa9ehVOu/2Ywkh5DDn4hI5+2yyml0Q1pm9Lp0SM+xuapvlTSWn0aPBNksyf4SkvW9nu1aRwoJNYWTemM2BbU5GNmFKYfFqlUnls9bywr3RHMG8KkuHPdg/Bc67iI9OhNUHXA3ZWn7818XjMWVBEaVoJJmIQgUuxUAwAFjZ/sy3U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(376002)(346002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(31686004)(2906002)(7416002)(6506007)(6666004)(5660300002)(53546011)(6512007)(2616005)(4326008)(66476007)(66946007)(966005)(6486002)(316002)(6916009)(66556008)(54906003)(26005)(30864003)(8676002)(38100700002)(478600001)(83380400001)(86362001)(31696002)(36756003)(8936002)(41300700001)(43740500002)(45980500001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0hrS0hHTnkyekxnTXcwcEovZys4aTJySXd5QWxPZ3ZTeGNLQ0pCQ3JPMHJQ?=
 =?utf-8?B?MU16bjh6VG14cXM1bUluRGFPYVVmUmMvRzYzbUZUUTZmUk12RExudGJ1UlJE?=
 =?utf-8?B?NFRUV0Z2YjIycG50VURFRGo5WXRsRTY1SzRBYWF3OXpLclRFRjJmbE5LNUYw?=
 =?utf-8?B?enZib0tpVjhaQUhhKzB4d21YNHZtY1lFUWxwaGszR2tWY0lJUmo2eURMNTZx?=
 =?utf-8?B?T2VnTm1OWUJ6bmJtTnBPUUJMK2srK0VheWFQTXQrK04zUGI0VFZySUEwejJE?=
 =?utf-8?B?Q3h4bHJoajBnVWdDRXlEaGFuL1dMbjA5WlkxamUyMUo1Skhoc29GVnV0cUpE?=
 =?utf-8?B?QzBLVk5VRFVab2lkMmdPNTVZV3RQak9HcGsxWFZtdEhiTEp5amdhYWhrRzFt?=
 =?utf-8?B?ZGVQSXExWXVuUmxWa2dDZnBLT3hqOFg3MFZGZldWbjhvS21VMmRNTngxRGFP?=
 =?utf-8?B?d3RPZmFyTnBtNnRzb1RZSWtuQk9MZStzTnhWVGZhUjBIYVlSOFRjamsrSXY3?=
 =?utf-8?B?WUZJRkJ0UnAxay92Uk5XbjZZUHRGM2txeVR0WlZkVG43aU1wengyb3VZTnlx?=
 =?utf-8?B?OEM2Z1B3SzZoOVNXTDJyQ25PR1Z1bkxwSEZZTHl1YVg2ZTlRRkdRZWVKLzRJ?=
 =?utf-8?B?RWtadXRIZDZlY3dhQ3M2TmZYa09lR2Jlb2tKajVVQXBWYmU4bTlNNGFXUlkv?=
 =?utf-8?B?K3JWVE4wZDVJL2RYeVFrNEo4ZlZ5ZnNDR2tlVHJnV1BaelhERk56MUFEeW5v?=
 =?utf-8?B?QjNOUHhYZjlhK09hRWZ5WG5PWjB6UVhSTU5NWjRwU1NQQ3FWY0d2QzFoaS9y?=
 =?utf-8?B?TGlrRWRCOXhDRituRFgyUTRORnNhMlR4c1RzTWdBRUdmNGJrZTRhNzNkdjh4?=
 =?utf-8?B?SXRmZFdzSHQyZEExQlZhUU9KZWFlSmtzYXNOZmFZazBYN0paM0NkMjU1TEtG?=
 =?utf-8?B?eERoWmx2THg5bk9vQyt2cmhuK0dNbkVpYTEzSUpSQ25NQ21vcXBNeno3eTU3?=
 =?utf-8?B?Q3JUUDl3a2s5Y0NjMmtjc0I1MjBRK0h4Qk5tdmlHbXoyajRmR3lSb0RONlhQ?=
 =?utf-8?B?N0RKT2poeVltM1BYQmpFVzFZckg4VGxnQUZnWENoSW5yNHVBeW54bXdBOHNj?=
 =?utf-8?B?cTF0eENxNk5WSjZJWGVUOXR2NUh1SXlUOFpQUEEzYlVySFBmTHVCdHk5VkpU?=
 =?utf-8?B?Tk15RExCM2hMVFJJb2pQM0IrTEhaK1BQMmhRR0N3cnFTbHNsS2x2MUl4eHpn?=
 =?utf-8?B?OWxVVE1maHROZUp6Q0ZSRVJJL3VseWpJLy9DamM2ZWxidWJlSU5CVW5NbGhO?=
 =?utf-8?B?cjZzakNZbWxXUTBpRVJMUDZ3VjNtWVIrOXFEaFlON2t6bDA2OFNnaWJaSkhv?=
 =?utf-8?B?MzVJWVd4aFViRVZBRTkwS1Zvb0VFWVh2MGU1czFZdlphYjZxM2tnR1BMM3dl?=
 =?utf-8?B?VnlzNDYxRVN5cmFwWDhCdGxIY2FaNVNzc21UbFpSU09ZalY5Zm91dkhoNXY3?=
 =?utf-8?B?NXlkejBtZzR3KzBsNHNXTU5Na21oUWJCUkI4KzFkVFJwWmV6N3M0emd5NTRq?=
 =?utf-8?B?dHpkYjc3LzliM2ZKc2dZQ0t1SXFicnlnS2ZZNzZJZVhQMEZmWGd6clFZcFcy?=
 =?utf-8?B?V0o4MlVtbWNrd1JLK1gzUkZ6T0RyaEV1Z1VBb0NtSEs1eEE4MXdhT3N4Mi9n?=
 =?utf-8?B?dGpMNkxwRENvZ0pJZDNLZmJaeWtpc3U1dEx2VVJPbE00c1lqNUtEV2JWQUh3?=
 =?utf-8?B?UEdzaE1JS0dvRG1VNFlHeUpidG5TcXB0M1hmemNTaVhvb2JGZ1BkbzhEb2hZ?=
 =?utf-8?B?ZkhVN1dUM2VRVzUrTDJMeXVtd2JUVXdEK1hnZ2tuOGY2bFlFaEYzV0VEeHg5?=
 =?utf-8?B?UFhrdzc4RzFrN3JrcEJ0ME5BdCtMWURCU2V2K3l2WTZMWDI3K2NFK1UzVmFK?=
 =?utf-8?B?VUtiK0FwcGxrbWlvTEh4MWF0anZaT2lUQU9pdWM3djNaS3gxbHhRQm1CRWND?=
 =?utf-8?B?QlFKc0MxTFdwNFlZdnJid0tlQWc3a1dFV1VLQzJ6ZVNCU1N6OFJ1TlEzeHEz?=
 =?utf-8?B?ckN2RzM3TnAxMElCOGxEQXZYMDBBa3g4emRLMWNIZlFhcjBzNkIwWkc0ellS?=
 =?utf-8?Q?vytB9iIPcsgaVGRJ2IfFsxaUm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbaabfd9-d6e1-49a0-aeaa-08dc20db5dcf
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 15:02:52.5956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oz/btu0Kc0pKksiGyGCtCszkqdjklilXBkhLrrFzicgziAXAJcGb2EnaLgjfF4CAizVM5bGmi8NnXpYcLo2EWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5430

On 1/26/24 19:27, Dionna Amalie Glaze wrote:
> On Fri, Jan 26, 2024 at 2:19 PM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>
>> When an SVSM is present, the guest can also request attestation reports
>> from the SVSM. These SVSM attestation reports can be used to attest the
>> SVSM and any services running within the SVSM.
>>
>> Extend the config-fs attestation support to allow for an SVSM attestation
>> report. This involves creating four (4) new config-fs attributes:
>>
>>    - 'svsm' (input)
>>      This attribute is used to determine whether the attestation request
>>      should be sent to the SVSM or to the SEV firmware.
> 
> This is where I'm torn. If there's an SVSM, it's there to provide
> paravirtualization for unenlightened guests /or/ it's there to protect

An SVSM is for enlightened guests. A para-visor would be for unenlightened
guests.

> runtime measurement registers. I don't see there being any particular
> value in bifurcating the attestation report space by adding this
> option. If there's an SVSM present, the configfs-tsm report should
> return the full SVSM attestation only.

I don't necessarily agree with that. The guest should still be able to
request a traditional attestation report.

Maybe I can remove the SVSM attribute and direct the call based on
requested VMPL level. If VMPL0 is requested, it goes through the SVSM.
If VMPL1+ is requested, it goes to the ASP.

That would mean that the privlevel_floor would need to stay at zero.

> 
>>
>>    - 'service_guid' (input)
>>      Used for requesting the attestation of a single service within the
>>      SVSM. A null GUID implies that the SVSM_ATTEST_SERVICES call should
>>      be used to request the attestation report. A non-null GUID implies
>>      that the SVSM_ATTEST_SINGLE_SERVICE call should be used.
>>
>>    - 'service_version' (input)
>>      Used with the SVSM_ATTEST_SINGLE_SERVICE call, the service version
>>      represents a specific service manifest version be used for the
>>      attestation report.
> 
> I know that this is specified for the SVSM, but I still don't know
> what the intended use case is such that we wouldn't simply always
> return the full service manifest.
> I can see an argument for an evidence requester not being ready for a
> new manifest version and wanting the older version until they can
> bridge the gap. I don't see that as needing configuration from the
> user space. We can either require new service GUIDs for new versions,
> require manifest ABIs to be internally versioned to be additive-only
> to not break verifiers that understand up to manifest byte X, or we
> allow breaking version changes through control plane configuration
> that's passed directly to the SVSM.
> 
> New versions get new GUIDs allows for gradual deprecation at the
> expense of size. I think that is a reasonable trade-off to keep from
> making tsm/report vendor-specific.

This was requested and discussed during the SVSM spec review and there
were no objections raised. See the this thread where this was discussed:

https://lore.kernel.org/linux-coco/09819cb3-1938-fe86-b948-28aaffbe584e@amd.com/

The changes you're requesting would require a new version of the spec
and updates to the protocol.

> 
>>
>>    - 'manifestblob' (output)
>>      Used to return the service manifest associated with the attestation
>>      report.
> 
> Given the above, I think we can just append the manifest to the report
> since the report size is known a priori.

We could have theoretically done the same thing with the auxblob (certs
data), but that is separate. I prefer the idea of having an individual
entry per piece of data being returned.

Thanks,
Tom

> 
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>   Documentation/ABI/testing/configfs-tsm  |  55 ++++++++++
>>   arch/x86/include/asm/sev.h              |  31 +++++-
>>   arch/x86/kernel/sev.c                   |  50 +++++++++
>>   drivers/virt/coco/sev-guest/sev-guest.c | 137 ++++++++++++++++++++++++
>>   drivers/virt/coco/tsm.c                 |  95 +++++++++++++++-
>>   include/linux/tsm.h                     |  11 ++
>>   6 files changed, 376 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/configfs-tsm b/Documentation/ABI/testing/configfs-tsm
>> index dd24202b5ba5..c5423987d323 100644
>> --- a/Documentation/ABI/testing/configfs-tsm
>> +++ b/Documentation/ABI/testing/configfs-tsm
>> @@ -31,6 +31,21 @@ Description:
>>                  Standardization v2.03 Section 4.1.8.1 MSG_REPORT_REQ.
>>                  https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/56421.pdf
>>
>> +What:          /sys/kernel/config/tsm/report/$name/manifestblob
>> +Date:          January, 2024
>> +KernelVersion: v6.9
>> +Contact:       linux-coco@lists.linux.dev
>> +Description:
>> +               (RO) Optional supplemental data that a TSM may emit, visibility
>> +               of this attribute depends on TSM, and may be empty if no
>> +               manifest data is available.
>> +
>> +               When @provider is "sev_guest" and the "svsm" attribute is set
>> +               this file contains the service manifest used for the SVSM
>> +               attestation report from Secure VM Service Module for SEV-SNP
>> +               Guests v1.00 Section 7.
>> +               https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
>> +
>>   What:          /sys/kernel/config/tsm/report/$name/provider
>>   Date:          September, 2023
>>   KernelVersion: v6.7
>> @@ -80,3 +95,43 @@ Contact:     linux-coco@lists.linux.dev
>>   Description:
>>                  (RO) Indicates the minimum permissible value that can be written
>>                  to @privlevel.
>> +
>> +What:          /sys/kernel/config/tsm/report/$name/svsm
>> +Date:          January, 2024
>> +KernelVersion: v6.9
>> +Contact:       linux-coco@lists.linux.dev
>> +Description:
>> +               (WO) Attribute is visible if a TSM implementation provider
>> +               supports the concept of attestation reports for TVMs running
>> +               under an SVSM, like SEV-SNP. Specifying any non-zero value
>> +               implies that the attestation report should come from the SVSM.
>> +               Secure VM Service Module for SEV-SNP Guests v1.00 Section 7.
>> +               https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
>> +
>> +What:          /sys/kernel/config/tsm/report/$name/service_guid
>> +Date:          January, 2024
>> +KernelVersion: v6.9
>> +Contact:       linux-coco@lists.linux.dev
>> +Description:
>> +               (WO) Attribute is visible if a TSM implementation provider
>> +               supports the concept of attestation reports for TVMs running
>> +               under an SVSM, like SEV-SNP. Specifying a empty or null GUID
>> +               (00000000-0000-0000-0000-000000) requests all active services
>> +               within the SVSM be part of the attestation report. Specifying
>> +               a non-null GUID requests an attestation report of just the
>> +               specified service using the manifest form specified by the
>> +               service_version attribute.
>> +               Secure VM Service Module for SEV-SNP Guests v1.00 Section 7.
>> +               https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
>> +
>> +What:          /sys/kernel/config/tsm/report/$name/service_version
>> +Date:          January, 2024
>> +KernelVersion: v6.9
>> +Contact:       linux-coco@lists.linux.dev
>> +Description:
>> +               (WO) Attribute is visible if a TSM implementation provider
>> +               supports the concept of attestation reports for TVMs running
>> +               under an SVSM, like SEV-SNP. Indicates the service manifest
>> +               version requested for the attestation report.
>> +               Secure VM Service Module for SEV-SNP Guests v1.00 Section 7.
>> +               https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
>> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
>> index b126e50a1358..4cafa92d1d3e 100644
>> --- a/arch/x86/include/asm/sev.h
>> +++ b/arch/x86/include/asm/sev.h
>> @@ -194,6 +194,27 @@ struct svsm_pvalidate_call {
>>          struct svsm_pvalidate_entry entry[];
>>   };
>>
>> +/*
>> + * The SVSM Attestation related structures
>> + */
>> +struct svsm_location_entry {
>> +       u64 pa;
>> +       u32 len;
>> +       u8 rsvd[4];
>> +};
>> +
>> +struct svsm_attestation_call {
>> +       struct svsm_location_entry report_buffer;
>> +       struct svsm_location_entry nonce;
>> +       struct svsm_location_entry manifest_buffer;
>> +       struct svsm_location_entry certificates_buffer;
>> +
>> +       /* For attesting a single service */
>> +       u8 service_guid[16];
>> +       u32 service_version;
>> +       u8 rsvd[4];
>> +};
>> +
>>   /*
>>    * SVSM protocol structure
>>    */
>> @@ -217,6 +238,10 @@ struct svsm_call {
>>   #define SVSM_CORE_CREATE_VCPU          2
>>   #define SVSM_CORE_DELETE_VCPU          3
>>
>> +#define SVSM_ATTEST_CALL(x)            ((1ULL << 32) | (x))
>> +#define SVSM_ATTEST_SERVICES           0
>> +#define SVSM_ATTEST_SINGLE_SERVICE     1
>> +
>>   #ifdef CONFIG_AMD_MEM_ENCRYPT
>>   extern void __sev_es_ist_enter(struct pt_regs *regs);
>>   extern void __sev_es_ist_exit(void);
>> @@ -287,6 +312,7 @@ void snp_set_wakeup_secondary_cpu(void);
>>   bool snp_init(struct boot_params *bp);
>>   void __init __noreturn snp_abort(void);
>>   int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio);
>> +int snp_issue_svsm_attestation_request(u64 call_id, struct svsm_attestation_call *input);
>>   void snp_accept_memory(phys_addr_t start, phys_addr_t end);
>>   u64 snp_get_unsupported_features(u64 status);
>>   u64 sev_get_status(void);
>> @@ -316,7 +342,10 @@ static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *in
>>   {
>>          return -ENOTTY;
>>   }
>> -
>> +static inline int snp_issue_svsm_attestation_request(u64 call_id, struct svsm_attestation_call *input)
>> +{
>> +       return -ENOTTY;
>> +}
>>   static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
>>   static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
>>   static inline u64 sev_get_status(void) { return 0; }
>> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
>> index 849df3aae4e1..83bc5efa8fcf 100644
>> --- a/arch/x86/kernel/sev.c
>> +++ b/arch/x86/kernel/sev.c
>> @@ -2378,6 +2378,56 @@ static int __init init_sev_config(char *str)
>>   }
>>   __setup("sev=", init_sev_config);
>>
>> +static void update_attestation_input(struct svsm_call *call, struct svsm_attestation_call *input)
>> +{
>> +       /* If (new) lengths have been returned, propograte them up */
>> +       if (call->rcx_out != call->rcx)
>> +               input->manifest_buffer.len = call->rcx_out;
>> +
>> +       if (call->rdx_out != call->rdx)
>> +               input->certificates_buffer.len = call->rdx_out;
>> +
>> +       if (call->r8_out != call->r8)
>> +               input->report_buffer.len = call->r8_out;
>> +}
>> +
>> +int snp_issue_svsm_attestation_request(u64 call_id, struct svsm_attestation_call *input)
>> +{
>> +       struct svsm_attestation_call *attest_call;
>> +       struct svsm_call call = {};
>> +       unsigned long flags;
>> +       u64 attest_call_pa;
>> +       int ret;
>> +
>> +       if (!vmpl)
>> +               return -EINVAL;
>> +
>> +       local_irq_save(flags);
>> +
>> +       call.caa = __svsm_get_caa();
>> +
>> +       attest_call = (struct svsm_attestation_call *)call.caa->svsm_buffer;
>> +       attest_call_pa = __svsm_get_caa_pa() + offsetof(struct svsm_ca, svsm_buffer);
>> +
>> +       memcpy(attest_call, input, sizeof(*attest_call));
>> +
>> +       /*
>> +        * Set input registers for the request and set RDX and R8 to known
>> +        * values in order to detect length values being returned in them.
>> +        */
>> +       call.rax = call_id;
>> +       call.rcx = attest_call_pa;
>> +       call.rdx = -1;
>> +       call.r8 = -1;
>> +       ret = svsm_protocol(&call);
>> +       update_attestation_input(&call, input);
>> +
>> +       local_irq_restore(flags);
>> +
>> +       return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(snp_issue_svsm_attestation_request);
>> +
>>   int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio)
>>   {
>>          struct ghcb_state state;
>> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
>> index 1ff897913bf4..3693373c4227 100644
>> --- a/drivers/virt/coco/sev-guest/sev-guest.c
>> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
>> @@ -783,6 +783,140 @@ struct snp_msg_cert_entry {
>>          u32 length;
>>   };
>>
>> +static int sev_svsm_report_new(struct tsm_report *report, void *data)
>> +{
>> +       unsigned int report_len, manifest_len, certificates_len;
>> +       void *report_blob, *manifest_blob, *certificates_blob;
>> +       struct svsm_attestation_call attest_call = {};
>> +       struct tsm_desc *desc = &report->desc;
>> +       unsigned int size;
>> +       bool try_again;
>> +       void *buffer;
>> +       u64 call_id;
>> +       int ret;
>> +
>> +       /*
>> +        * Allocate pages for the request:
>> +        * - Report blob (4K)
>> +        * - Manifest blob (4K)
>> +        * - Certificate blob (16K)
>> +        *
>> +        * Above addresses must be 4K aligned
>> +        */
>> +       report_len = SZ_4K;
>> +       manifest_len = SZ_4K;
>> +       certificates_len = SEV_FW_BLOB_MAX_SIZE;
>> +
>> +retry:
>> +       size = report_len + manifest_len + certificates_len;
>> +       buffer = alloc_pages_exact(size, __GFP_ZERO);
>> +       if (!buffer)
>> +               return -ENOMEM;
>> +
>> +       report_blob = buffer;
>> +       attest_call.report_buffer.pa = __pa(report_blob);
>> +       attest_call.report_buffer.len = report_len;
>> +
>> +       manifest_blob = report_blob + report_len;
>> +       attest_call.manifest_buffer.pa = __pa(manifest_blob);
>> +       attest_call.manifest_buffer.len = manifest_len;
>> +
>> +       certificates_blob = manifest_blob + manifest_len;
>> +       attest_call.certificates_buffer.pa = __pa(certificates_blob);
>> +       attest_call.certificates_buffer.len = certificates_len;
>> +
>> +       attest_call.nonce.pa = __pa(desc->inblob);
>> +       attest_call.nonce.len = desc->inblob_len;
>> +
>> +       if (guid_is_null(&desc->service_guid)) {
>> +               call_id = SVSM_ATTEST_CALL(SVSM_ATTEST_SERVICES);
>> +       } else {
>> +               export_guid(attest_call.service_guid, &desc->service_guid);
>> +               attest_call.service_version = desc->service_version;
>> +
>> +               call_id = SVSM_ATTEST_CALL(SVSM_ATTEST_SINGLE_SERVICE);
>> +       }
>> +
>> +       ret = snp_issue_svsm_attestation_request(call_id, &attest_call);
>> +       switch (ret) {
>> +       case SVSM_SUCCESS:
>> +               break;
>> +       case SVSM_ERR_INVALID_PARAMETER:
>> +               try_again = false;
>> +
>> +               if (attest_call.report_buffer.len > report_len) {
>> +                       report_len = PAGE_ALIGN(attest_call.report_buffer.len);
>> +                       try_again = true;
>> +               }
>> +
>> +               if (attest_call.manifest_buffer.len > manifest_len) {
>> +                       manifest_len = PAGE_ALIGN(attest_call.manifest_buffer.len);
>> +                       try_again = true;
>> +               }
>> +
>> +               if (attest_call.certificates_buffer.len > certificates_len) {
>> +                       certificates_len = PAGE_ALIGN(attest_call.certificates_buffer.len);
>> +                       try_again = true;
>> +               }
>> +
>> +               /* If one of the buffers wasn't large enough, retry the request */
>> +               if (try_again) {
>> +                       free_pages_exact(buffer, size);
>> +                       goto retry;
>> +               }
>> +
>> +               ret = -EINVAL;
>> +               goto error;
>> +       case SVSM_ERR_BUSY:
>> +               ret = -EAGAIN;
>> +               goto error;
>> +       default:
>> +               pr_err_ratelimited("SVSM attestation request failed (%#x)\n", ret);
>> +               ret = -EINVAL;
>> +               goto error;
>> +       }
>> +
>> +       ret = -ENOMEM;
>> +
>> +       report_len = attest_call.report_buffer.len;
>> +       void *rbuf __free(kvfree) = kvzalloc(report_len, GFP_KERNEL);
>> +       if (!rbuf)
>> +               goto error;
>> +
>> +       memcpy(rbuf, report_blob, report_len);
>> +       report->outblob = no_free_ptr(rbuf);
>> +       report->outblob_len = report_len;
>> +
>> +       manifest_len = attest_call.manifest_buffer.len;
>> +       void *mbuf __free(kvfree) = kvzalloc(manifest_len, GFP_KERNEL);
>> +       if (!mbuf)
>> +               goto error;
>> +
>> +       memcpy(mbuf, manifest_blob, manifest_len);
>> +       report->manifestblob = no_free_ptr(mbuf);
>> +       report->manifestblob_len = manifest_len;
>> +
>> +       certificates_len = attest_call.certificates_buffer.len;
>> +       if (!certificates_len)
>> +               goto success;
>> +
>> +       void *cbuf __free(kvfree) = kvzalloc(certificates_len, GFP_KERNEL);
>> +       if (!cbuf)
>> +               goto error;
>> +
>> +       memcpy(cbuf, certificates_blob, certificates_len);
>> +       report->auxblob = no_free_ptr(cbuf);
>> +       report->auxblob_len = certificates_len;
>> +
>> +success:
>> +       ret = 0;
>> +
>> +error:
>> +       free_pages_exact(buffer, size);
>> +
>> +       return ret;
>> +}
>> +
>>   static int sev_report_new(struct tsm_report *report, void *data)
>>   {
>>          struct snp_msg_cert_entry *cert_table;
>> @@ -797,6 +931,9 @@ static int sev_report_new(struct tsm_report *report, void *data)
>>          if (desc->inblob_len != SNP_REPORT_USER_DATA_SIZE)
>>                  return -EINVAL;
>>
>> +       if (desc->svsm)
>> +               return sev_svsm_report_new(report, data);
>> +
>>          void *buf __free(kvfree) = kvzalloc(size, GFP_KERNEL);
>>          if (!buf)
>>                  return -ENOMEM;
>> diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
>> index d1c2db83a8ca..33fa26406bc6 100644
>> --- a/drivers/virt/coco/tsm.c
>> +++ b/drivers/virt/coco/tsm.c
>> @@ -35,7 +35,7 @@ static DECLARE_RWSEM(tsm_rwsem);
>>    * The attestation report format is TSM provider specific, when / if a standard
>>    * materializes that can be published instead of the vendor layout. Until then
>>    * the 'provider' attribute indicates the format of 'outblob', and optionally
>> - * 'auxblob'.
>> + * 'auxblob' and 'manifestblob'.
>>    */
>>
>>   struct tsm_report_state {
>> @@ -48,6 +48,7 @@ struct tsm_report_state {
>>   enum tsm_data_select {
>>          TSM_REPORT,
>>          TSM_CERTS,
>> +       TSM_MANIFEST,
>>   };
>>
>>   static struct tsm_report *to_tsm_report(struct config_item *cfg)
>> @@ -119,6 +120,77 @@ static ssize_t tsm_report_privlevel_floor_show(struct config_item *cfg,
>>   }
>>   CONFIGFS_ATTR_RO(tsm_report_, privlevel_floor);
>>
>> +static ssize_t tsm_report_svsm_store(struct config_item *cfg,
>> +                                    const char *buf, size_t len)
>> +{
>> +       struct tsm_report *report = to_tsm_report(cfg);
>> +       unsigned int val;
>> +       int rc;
>> +
>> +       rc = kstrtouint(buf, 0, &val);
>> +       if (rc)
>> +               return rc;
>> +
>> +       guard(rwsem_write)(&tsm_rwsem);
>> +       rc = try_advance_write_generation(report);
>> +       if (rc)
>> +               return rc;
>> +       report->desc.svsm = !!val;
>> +
>> +       return len;
>> +}
>> +CONFIGFS_ATTR_WO(tsm_report_, svsm);
>> +
>> +static ssize_t tsm_report_service_guid_store(struct config_item *cfg,
>> +                                            const char *buf, size_t len)
>> +{
>> +       struct tsm_report *report = to_tsm_report(cfg);
>> +       size_t guid_len;
>> +       int rc;
>> +
>> +       guard(rwsem_write)(&tsm_rwsem);
>> +       rc = try_advance_write_generation(report);
>> +       if (rc)
>> +               return rc;
>> +
>> +       /* Obtain the GUID string length */
>> +       guid_len = (len && buf[len - 1] == '\n') ? len - 1 : len;
>> +       if (guid_len && guid_len != UUID_STRING_LEN)
>> +               return -EINVAL;
>> +
>> +       if (guid_len == UUID_STRING_LEN) {
>> +               rc = guid_parse(buf, &report->desc.service_guid);
>> +               if (rc)
>> +                       return rc;
>> +       } else {
>> +               report->desc.service_guid = guid_null;
>> +       }
>> +
>> +       return len;
>> +}
>> +CONFIGFS_ATTR_WO(tsm_report_, service_guid);
>> +
>> +static ssize_t tsm_report_service_version_store(struct config_item *cfg,
>> +                                               const char *buf, size_t len)
>> +{
>> +       struct tsm_report *report = to_tsm_report(cfg);
>> +       unsigned int val;
>> +       int rc;
>> +
>> +       rc = kstrtouint(buf, 0, &val);
>> +       if (rc)
>> +               return rc;
>> +
>> +       guard(rwsem_write)(&tsm_rwsem);
>> +       rc = try_advance_write_generation(report);
>> +       if (rc)
>> +               return rc;
>> +       report->desc.service_version = val;
>> +
>> +       return len;
>> +}
>> +CONFIGFS_ATTR_WO(tsm_report_, service_version);
>> +
>>   static ssize_t tsm_report_inblob_write(struct config_item *cfg,
>>                                         const void *buf, size_t count)
>>   {
>> @@ -163,6 +235,9 @@ static ssize_t __read_report(struct tsm_report *report, void *buf, size_t count,
>>          if (select == TSM_REPORT) {
>>                  out = report->outblob;
>>                  len = report->outblob_len;
>> +       } else if (select == TSM_MANIFEST) {
>> +               out = report->manifestblob;
>> +               len = report->manifestblob_len;
>>          } else {
>>                  out = report->auxblob;
>>                  len = report->auxblob_len;
>> @@ -188,7 +263,7 @@ static ssize_t read_cached_report(struct tsm_report *report, void *buf,
>>
>>          /*
>>           * A given TSM backend always fills in ->outblob regardless of
>> -        * whether the report includes an auxblob or not.
>> +        * whether the report includes an auxblob/manifestblob or not.
>>           */
>>          if (!report->outblob ||
>>              state->read_generation != state->write_generation)
>> @@ -224,8 +299,10 @@ static ssize_t tsm_report_read(struct tsm_report *report, void *buf,
>>
>>          kvfree(report->outblob);
>>          kvfree(report->auxblob);
>> +       kvfree(report->manifestblob);
>>          report->outblob = NULL;
>>          report->auxblob = NULL;
>> +       report->manifestblob = NULL;
>>          rc = ops->report_new(report, provider.data);
>>          if (rc < 0)
>>                  return rc;
>> @@ -252,6 +329,15 @@ static ssize_t tsm_report_auxblob_read(struct config_item *cfg, void *buf,
>>   }
>>   CONFIGFS_BIN_ATTR_RO(tsm_report_, auxblob, NULL, TSM_OUTBLOB_MAX);
>>
>> +static ssize_t tsm_report_manifestblob_read(struct config_item *cfg, void *buf,
>> +                                           size_t count)
>> +{
>> +       struct tsm_report *report = to_tsm_report(cfg);
>> +
>> +       return tsm_report_read(report, buf, count, TSM_MANIFEST);
>> +}
>> +CONFIGFS_BIN_ATTR_RO(tsm_report_, manifestblob, NULL, TSM_OUTBLOB_MAX);
>> +
>>   #define TSM_DEFAULT_ATTRS() \
>>          &tsm_report_attr_generation, \
>>          &tsm_report_attr_provider
>> @@ -265,6 +351,9 @@ static struct configfs_attribute *tsm_report_extra_attrs[] = {
>>          TSM_DEFAULT_ATTRS(),
>>          &tsm_report_attr_privlevel,
>>          &tsm_report_attr_privlevel_floor,
>> +       &tsm_report_attr_svsm,
>> +       &tsm_report_attr_service_guid,
>> +       &tsm_report_attr_service_version,
>>          NULL,
>>   };
>>
>> @@ -280,6 +369,7 @@ static struct configfs_bin_attribute *tsm_report_bin_attrs[] = {
>>   static struct configfs_bin_attribute *tsm_report_bin_extra_attrs[] = {
>>          TSM_DEFAULT_BIN_ATTRS(),
>>          &tsm_report_attr_auxblob,
>> +       &tsm_report_attr_manifestblob,
>>          NULL,
>>   };
>>
>> @@ -288,6 +378,7 @@ static void tsm_report_item_release(struct config_item *cfg)
>>          struct tsm_report *report = to_tsm_report(cfg);
>>          struct tsm_report_state *state = to_state(report);
>>
>> +       kvfree(report->manifestblob);
>>          kvfree(report->auxblob);
>>          kvfree(report->outblob);
>>          kfree(state);
>> diff --git a/include/linux/tsm.h b/include/linux/tsm.h
>> index de8324a2223c..7c36b8448b4f 100644
>> --- a/include/linux/tsm.h
>> +++ b/include/linux/tsm.h
>> @@ -4,6 +4,7 @@
>>
>>   #include <linux/sizes.h>
>>   #include <linux/types.h>
>> +#include <linux/uuid.h>
>>
>>   #define TSM_INBLOB_MAX 64
>>   #define TSM_OUTBLOB_MAX SZ_32K
>> @@ -19,11 +20,17 @@
>>    * @privlevel: optional privilege level to associate with @outblob
>>    * @inblob_len: sizeof @inblob
>>    * @inblob: arbitrary input data
>> + * @svsm: optional indicator of where to obtain the tsm report blob
>> + * @service_guid: optional SVSM service guid to attest
>> + * @service_version: optional SVSM service manifest version requested
>>    */
>>   struct tsm_desc {
>>          unsigned int privlevel;
>>          size_t inblob_len;
>>          u8 inblob[TSM_INBLOB_MAX];
>> +       bool svsm;
>> +       guid_t service_guid;
>> +       unsigned int service_version;
>>   };
>>
>>   /**
>> @@ -33,6 +40,8 @@ struct tsm_desc {
>>    * @outblob: generated evidence to provider to the attestation agent
>>    * @auxblob_len: sizeof(@auxblob)
>>    * @auxblob: (optional) auxiliary data to the report (e.g. certificate data)
>> + * @manifestblob_len: sizeof(@manifestblob)
>> + * @manifestblob: (optional) manifest data associated with the report
>>    */
>>   struct tsm_report {
>>          struct tsm_desc desc;
>> @@ -40,6 +49,8 @@ struct tsm_report {
>>          u8 *outblob;
>>          size_t auxblob_len;
>>          u8 *auxblob;
>> +       size_t manifestblob_len;
>> +       u8 *manifestblob;
>>   };
>>
>>   /**
>> --
>> 2.42.0
>>
>>
> 
> 

