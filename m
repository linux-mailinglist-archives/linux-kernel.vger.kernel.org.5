Return-Path: <linux-kernel+bounces-46308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5E5843DC1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 512D41C2A47C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A68762CD;
	Wed, 31 Jan 2024 11:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="35cvgRHy"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4980E69D39;
	Wed, 31 Jan 2024 11:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706699101; cv=fail; b=tyEyfRFGSMDHnwglg210W8SrDWBOBJFx72QlFo27c1kYxOtMofCFxW4es4Ph4p5W0lLOdmMrIJXq5Uoj1qlroQ7QoLKjd7bVLP/lIshoD/Dk0o2gy78Y8R2Wt8E78CtsMf9351lYNd+XIt70dbLsz6OF0wS2R4WwgVl+PBhxzpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706699101; c=relaxed/simple;
	bh=IaEMWvxM92Q+wy3HhEsFJ2O7Kc+ez0zcnI85i3B7tgQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aGcGoHgvPoYMnzt6R8yYa1jcKSkbIXy5r4LWNi2dCebAEtOCYZAGcHGraG+C8i5IYYZND5zTurmcB7eOu0xmqhGMK2cSUkzBKSPwF62YkW+jIeMsG/W067AebFsdZCvqPx+A1PTu08Xu8ob1TLiiytJwi5M8yKWelpi+VFu/nwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=35cvgRHy; arc=fail smtp.client-ip=40.107.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfK59trBTPzv3m8BySEiP0ctMNDVYYS7cQxK11LD+vbmjlRNMyUvnuB5dBzQ3SElY0cwcYfLQKewOme4M2tUjKy+uyhRT2MbNjqs2CgheTfCiIUUUBWc0qnSFSi2LXDeaGI5igLcabJXFTsbzW9FUn7mC2SOaW+lcRTlHSLRxpXbdy46v1foYZO7whUkInbC4LocdkghfH9MURoNS1rl/VKWWI57GqnPjqP7WNYCUY+fJOhZrEzFvbglRyIAqaO4r1DraWt9+ZzCaMNxKhitMFPi2Na+9ieB59/fTz7y2860+veROkikEHhI+HpH5TEMC72ASXvzHuM0FvbBXs16kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fC33gFJ6fnEwG/20K5/NbVtvpqI4L2OjwfsBd5/hHE4=;
 b=BN4nKgcWnJDA30YeIYTr4FPMNBy+GcKN5Ijvzirh+gnB87S5i03glooH4HL4SmDE7LVS6X5o72pBTD1/vY1l2pSa0cFYZtWffpZ7SWk4mbyKQMiEs9wVpVPAAXeqINeuNQScHEbWRnsjP05Hu1FQk205KN5jJ0g515boQ58ZGXNTaBBXWNeYnJcWXmY/FPKg1A7CdqDZz986dUOGFXo4D8/n9zIi1wm9Ld+mZ47HZpo2Cwq8LLDUVmoZ6YPVxQX2dpiiYv9XUGz8EOtDRnBxE0iBo/vHkfXfRbIomy5nPVVydeB0dhCxdI2+dMt1UqGOckap1yh2qm3c6A5UNdyF3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fC33gFJ6fnEwG/20K5/NbVtvpqI4L2OjwfsBd5/hHE4=;
 b=35cvgRHyctUcQN11B7srcyvkCWQu6xfpnF1Mhvebw5TxE4XsXSJ6fcY6xpXQSER+Lk2Fvkxp0HICXKeBABwCAzu8XNZdV8GkkTz79OY1S8fuIm1fh7n20Len3/tRjg9RkbIUuRkfMFQfutXYxbSkX6e/fyIUXwTAnpkgrhQO1oE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3407.namprd12.prod.outlook.com (2603:10b6:208:c5::18)
 by CYYPR12MB9015.namprd12.prod.outlook.com (2603:10b6:930:c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Wed, 31 Jan
 2024 11:04:57 +0000
Received: from MN2PR12MB3407.namprd12.prod.outlook.com
 ([fe80::6f7:d8c8:b43f:674f]) by MN2PR12MB3407.namprd12.prod.outlook.com
 ([fe80::6f7:d8c8:b43f:674f%3]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 11:04:57 +0000
Message-ID: <471d9438-e2c0-4881-8ace-778c9d14669c@amd.com>
Date: Wed, 31 Jan 2024 11:03:25 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: fpga: xlnx,fpga-slave-selectmap: add DT
 schema
Content-Language: en-GB
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Charles Perry <charles.perry@savoirfairelinux.com>, mdf@kernel.org,
 "michal.simek@amd.com" <michal.simek@amd.com>
Cc: hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
 krzysztof.kozlowski+dt@linaro.org, bcody@markem-imaje.com,
 avandiver@markem-imaje.com, linux-fpga@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240129225602.3832449-1-charles.perry@savoirfairelinux.com>
 <20240129225602.3832449-2-charles.perry@savoirfairelinux.com>
 <9b0680b6-1952-41d3-82f4-88c60469dc3a@linaro.org>
From: Kris Chaplin <kris.chaplin@amd.com>
In-Reply-To: <9b0680b6-1952-41d3-82f4-88c60469dc3a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0226.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::22) To MN2PR12MB3407.namprd12.prod.outlook.com
 (2603:10b6:208:c5::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3407:EE_|CYYPR12MB9015:EE_
X-MS-Office365-Filtering-Correlation-Id: dfae9429-972f-48ef-017f-08dc224c75e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ti8cMLV/ACcV+uHvUmM5/lYocSDCd/RUNJy0WmjGLu4JwgE7T83vJmBF+MmCisOSlZkSDO1OgKGKC+r5NkSFtn/wQe0Mpg6fGosCQFy+p1UE9BOnVOU9JB0DdBz59/jXneFP7YP5x2o5pb0uZgSfIUZy9RnqEVS6xmPHGmcWD1EBylmNS+oM1ZiqtvyjpdVYMCBT+9Ruje8Yhly5pS1RLWBkcg3YPEgnEjIGVG04MuHKHLEYdmxaqAP89m57/6SuJ6mzDMK7q9/32uxgnR+aw2ywIXmHcB4JpK+KYR8OtZFwgiPXp6PAyLPeupAY9ko2/R5YRiUDYx57WKAT/y76LcTE7wKvVdLQj+9h3q756QNyTrcjqyQMlTKh3p3EtdUS02TaB180rzAd8ixjOuC9cdgzGNWwn8MJatKlEt0PiAslgq2IvueeKhktx5nkKvGoqNUk5YWlbxmd79U3znigevpgEzUZfLV1aS2HZHtOWUqSCMKkJ/Tviiey8K/oQhv4gEOKqSY7+Gc4Q3zUxY3WlyH8elXu3eU/KVw0FJBThicKKUWVXf8uw5tpinaKQjU+pmPCxs6M+NHsmcM+EN4xh0JsJ2K5yjNCjRECweLz7itXjF2GAafSnVoe5cV8FuVABd00Sk3Z+1X9YS5qlAwSBg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3407.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(41300700001)(66476007)(4326008)(8676002)(44832011)(7416002)(2906002)(5660300002)(31696002)(8936002)(110136005)(86362001)(66946007)(316002)(36756003)(966005)(6636002)(38100700002)(66556008)(6506007)(53546011)(6512007)(478600001)(6486002)(6666004)(83380400001)(26005)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUlPWDduSEV1WmpMbjhOZlZmcnBrZ1N0Lzg5WEhEL3c1alA5VHpWSWdtNzU2?=
 =?utf-8?B?akVyemFKYWJ6dFpzNjJoQVFsVjBDN0VWN0tXK1J1VmxLM2hqVVpTV3UxczNV?=
 =?utf-8?B?MndrNHBoTkE2N0VYQktnWjMxMXZTVXhFQ3B5bW13bWpPNkhwSklNOGQyMFN3?=
 =?utf-8?B?R1dKOUc1aS8xMFE0SHhMUktWdFgzeXB5dUhwTzR5OENudjRuU1B6S1pDaE0w?=
 =?utf-8?B?MUtieS9KdkdxUmM0L244SDlOaUtDdW5ZTStlU1p2K1dUaDQwak84aXJhTFFk?=
 =?utf-8?B?djc2TForVE5JZ0d1ZmoyTW9ZMmlaVDlsbmNHYTA5Z0RyNDRFeUMxc0ZjMElW?=
 =?utf-8?B?d1N3UzgwRllaU2FROVVqTFVTY1BOemxxbXNoT0U0aDYrVkFQYUdudEROc0kv?=
 =?utf-8?B?bjJnSW04dGJRRUo5VWpWU29TV0VYYzgvdUtwazA1blEvcUdwQlZKZEhZQ1R4?=
 =?utf-8?B?YVdiYjdWUVk0eGdKRDFKWE5xK2EzTFh2TFNGd3Y4V0daM3RZWWI3Wmgwekhp?=
 =?utf-8?B?QnNSR05RM3hIbzhYUy9MOTB4UlF4bjgwYy80RDlTZVdOeUxQeXgyQnRHSTE2?=
 =?utf-8?B?RlR5azhxL2lRNWpyOWxMRllvM0d5MU84QkwwbGNncHZMNlZQTmhhdTVVM1NV?=
 =?utf-8?B?eVhseGlzbjBZWUZTZXZjS2VHSEJVWlVNYTkrWGZGMFAydVdsU3pjVC9mMUtJ?=
 =?utf-8?B?NnFQQjQweFlhWklzRnZjMlcrM09YbzB6RHd3NktXeTVKa3phaStUcVlvRUxZ?=
 =?utf-8?B?K213cVY4OUdlcjBBZC9EZ09FTmRrbG83ZC91OXd4RW5FU29hUktlTmJQbW1z?=
 =?utf-8?B?UUZiaE5QQW53L2pqVHprajVJemtHak8vckVtU2EzbGxUeVowaCttM2lEVW5R?=
 =?utf-8?B?dTNVMmdIam5IRm52cGhxVG9OeVRzM055eXRNUWtqUXh6UTVUSEVVSDJlRDFC?=
 =?utf-8?B?V2xqNVhCbjhGb2F1WnYzdHByZUFOYi81dXlTKzJwWmtMenhNSUZyK0VsQ1h1?=
 =?utf-8?B?Y09RRnRub3VkNjdRQjJKQTZmOGhZOWJMbzI4R0FLS0UwRTFCeEszMGc1elBW?=
 =?utf-8?B?Ylg0Tjk3NFBQTFNUNVkxTDdLdGlKUm95aml0RmNxMTR5RDRvTXExcHd0bndU?=
 =?utf-8?B?bktjMEVjN3hZM0QwQzM4NHovVm45bE8zamtMRFZkYjh4cnBnZWJpTjd5R1c0?=
 =?utf-8?B?L3lrZjdKVWN2bEJ3RmcvVWsrTitUVFM5bzREK0dveUxhWG5tMGdMUEFES3M0?=
 =?utf-8?B?T1ZjMEVEVU9Wa2JCb3dCaUF6WXRweVZXa3N6RWlKcE05VGliSkYxUE5aMUx3?=
 =?utf-8?B?dmRDaGNlSEJBRmtja2NETm5nY0tESDFhdFhmR3pUNVpRb0RhajZnNjVyY3ZK?=
 =?utf-8?B?QmdNc2NHMFZYK3NESkNVT09oU3VNZEV1SkVpTE5aV0lKUEdPYVZFc1pZTDQ1?=
 =?utf-8?B?YlFESzVNeWdxWVEwQzM1K0hqeUVyMktqcHJEUitJb3VCL2QxMzBBQlJaWnIw?=
 =?utf-8?B?cVRhQjFFUFdtZXZJR3IwYjFUK285aHN5RnMrd0xHeWNyT3F0TnZlMldSRkpw?=
 =?utf-8?B?aVVXRTJvYzlGTXFhYityZ2N3ekdRcnVQaGVIYUVkaUx1YU83cXl4c1NGN3Jx?=
 =?utf-8?B?WnNmRWFnQTFwbVphdlBQOXI5Qk8vQ0xUa2VRY2ttb2xwVmswRE0xVGtrWThE?=
 =?utf-8?B?THNycjZXOC9zeExzSW4zcGZrNU9NR2M3ajd5Z1RMTU54UnJuaVQ5clltcEh6?=
 =?utf-8?B?RVJmUUphdnlyT0NtbDNJVWp6OVpmanlNcVZodGZqVTlONXRXeGNWU04vVEJJ?=
 =?utf-8?B?SGh1U3ZOQXVMRFArUkRJSFFaMElIZkw3L0dISFk3cjlaemNXUVhsYzR5SFhK?=
 =?utf-8?B?b0htek5PcDhOWE9HLzloNVQ1MDc3YVVwV3I0UWY1elhKOThJR1lpY092M2tF?=
 =?utf-8?B?N1BCOUxDNm5NUHVJRkZKRkRpUkNUT000UTJydTQ2SFhtak1DSzh0czZUOVFY?=
 =?utf-8?B?WFNNK1hvVkRIVzB0bHpwbzgxSUFPQkRJS05jYU90WUJoNGlXeU1IaFU3d0dB?=
 =?utf-8?B?QjJHQkFTZzJPbGFkWVVuUTRjN0dtbEFGZ2oyaUZUakdFd1RTU0pjVFhnRjBT?=
 =?utf-8?Q?B0lY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfae9429-972f-48ef-017f-08dc224c75e5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3407.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 11:04:57.2225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NT28Ey1ibUsQx3XBjidIU6xi0IllIWsaHu7oTuGlpe5HnLciQFbbU9PoOku++b7Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9015

Hello Krzysztof,

On 30/01/2024 16:09, Krzysztof Kozlowski wrote:

>> +
>> +description: |
>> +  Xilinx 7 Series FPGAs support a method of loading the bitstream over a
>> +  parallel port named the slave SelectMAP interface in the documentation. Only
>> +  the x8 mode is supported where data is loaded at one byte per rising edge of
>> +  the clock, with the MSB of each byte presented to the D0 pin.
>> +
>> +  Datasheets:
>> +    https://www.xilinx.com/support/documentation/user_guides/ug470_7Series_Config.pdf
> 
> I am surprised that AMD/Xilinx still did not update the document to
> modern naming (slave->secondary).

Thank you for bringing this up.

We are moving away from using non-inclusive technical terminology and 
are removing non-inclusive language from our products and related 
collateral.  You will for some time find examples of non-inclusive 
language, especially in our older products as we work to make these 
changes and align with industry standards.  For new IP we're ensuring 
that we switch and stick to inclusive terminology, as you may have seen 
with my recent w1 driver submission.

SelectMAP is a decades-old interface and as such it is unlikely that we 
will update this in all documentation dating back this time.  I shall 
however look to understand what is planned here for active documentation 
and new driver submissions.

regards
Kris

