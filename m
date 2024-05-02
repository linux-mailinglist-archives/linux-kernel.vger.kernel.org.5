Return-Path: <linux-kernel+bounces-166844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2614D8BA0BD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFA53284227
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469D717557C;
	Thu,  2 May 2024 18:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YJ9i0EhB"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743DE16F90C;
	Thu,  2 May 2024 18:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714675731; cv=fail; b=U1tEylNqR6vYSxi2dF20jU5ilfrKK6oApZvt1kaSoI5WX3mSaTMTWY5PzFyhYAJoTT7WaWk71F4WTl3H4GIKKP3rpzR7YK+opI/uJAI31EUX22cU4XEGDRlz1ef8+MsIEJmxCs74qKWc6Nn4zJllQyvPk0GbM1S/qwh9uj95+MI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714675731; c=relaxed/simple;
	bh=2jSdZYZgeVOuuE1y5CNZzzpaGx73ms9fvEMFntMZaTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hNQ4v/E5SWmhHctpWAE/VRm48bpscIYEAUGKCGl1wBLuMHcG3bEw9z3aMMiuZunbCvBTPOVQWjwWF2AddqnC7aBZgR9aOyEn9pbSSkfyLtBX+4aBDsotjDUXRqLhGk07plZiclq+QwiV4001FjB76zQ3Pv9T3gfKzkHz1cO5FJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YJ9i0EhB; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yq/4odGiXoATAGig5rEuz9L95YenYKqp+dUbyc370duvoJa+wX5HK9zzli5LR4/r9tZDrrPitjThir2QTbdSlXx57R44IA90C62GGlCGvk2JAAQHB7GOymfC62tceUp+Z/dV3GW+Bs70Xgmy6RvvGNbB09E0JFxzMXhv4zg7+4wOu/xM/i34x+Fd+KDqLaeu2fLtN1QI4fBdYtljaX9qogKeibdmYaQkYsiXOCj5j3IZwuXjVbw9RpdcsGYaLhoi6xfbymhv36+9Qocgv5FBJb1PIyB89nSuRJyXXEYnqBSWE2UaqWZh24xPVHGU5jBqyWsnW+Du39eVBG5pfoYd0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69dbbzL6ykgpF2PuDNnNiJVogzQkE9ZpWSZh7+HkBaE=;
 b=bOpJ7ISb4FOzyxH2UMUEVjzorsQVpjC1N84mnQ3/wNhV1FStWGEOD58QMtuE0ShAW+Hs/2O5JxyoNKVB+1gfUiH6R+UyFFZLUqrgBX9tTRh10q9Ml/ZVdnJwldg1z6Vgk9pVZkRmURxRoFt4KWHHnDpdvxCump2qWKkNimIife9lowOWDCv+SyWKWVqVbBwNBXfFsnqKHFAwoArbjSpvtfBJhukJmcROeHnJ2esFmDHFDx8/JyQCgCf7kPCDZTgEaPy27ZOFZd2maHrIqeMZhvRtkDG3JzjG+kU6kVp3fE3Kw8oJtynELxcSyEDdjVe6ZavD79Aqv453vO1vGfUMMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69dbbzL6ykgpF2PuDNnNiJVogzQkE9ZpWSZh7+HkBaE=;
 b=YJ9i0EhBECjQ54z0YrhYrXykoLP9E90HnUITAUri3fUq3ZfXLOoUT2SPMnGtc+Q4Xz7s2P5uglMpywHEBnWWXGk3PCn+ZINfP4c1K/wDnydMNEWj/OWRk9/QsYiN2BfC9CqT2kbNK9YXm8Th7xuZbzNZ9x8+EiKGcrC/FHH6Y5Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DS7PR12MB6047.namprd12.prod.outlook.com (2603:10b6:8:84::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Thu, 2 May
 2024 18:48:40 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%4]) with mapi id 15.20.7519.035; Thu, 2 May 2024
 18:48:40 +0000
Date: Thu, 2 May 2024 20:48:34 +0200
From: Robert Richter <rrichter@amd.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
	Avadhut.Naik@amd.com, John.Allen@amd.com
Subject: Re: [PATCH v2 07/16] x86/mce/amd: Simplify DFR handler setup
Message-ID: <ZjPgAoFZXQDsWMJ_@rric.localdomain>
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
 <20240404151359.47970-8-yazen.ghannam@amd.com>
 <20240424190658.GHZilYUvw1KfSfVd_e@fat_crate.local>
 <e0d10606-4472-4cde-b55d-34180efad42b@amd.com>
 <Zi_oPUzvCDhRVSk4@rric.localdomain>
 <20240430180635.GDZjEzK8H3xQ_uEGYn@fat_crate.local>
 <a5f623ba-6df1-42f1-a709-aafa59b004ba@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5f623ba-6df1-42f1-a709-aafa59b004ba@amd.com>
X-ClientProxiedBy: FR3P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::12) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DS7PR12MB6047:EE_
X-MS-Office365-Filtering-Correlation-Id: 917b4e10-efa2-41d8-fe79-08dc6ad87ba0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RkLsfNVo2+GnWB2hNirQNTb7ci7nyDpe9ROj1ARolCMje0IrTkQmc1VJU9xB?=
 =?us-ascii?Q?zBF48/ZZcGttkmfDbHykZ34Sx8lR7GIPLoDBrRyAOQEH2MMWA9hv5A69heyK?=
 =?us-ascii?Q?+4HN6jyl8w1+F7n+n7ej+lkwvAJ/9x+6Gl1Mk0A+/gRxGQHtq5qaat5LXNYG?=
 =?us-ascii?Q?JKTG3ef1xToB1Uyh8xK+ROwvWiJqBLgLJd0TgpDiQ4QyA7X0i6mGSPr1sEaE?=
 =?us-ascii?Q?gaThoSKmdUwzIcjyYVHmUh/q3zPw2Tr0Ua7hLfxd2RHt7ZUhhn3hocYLl1ZZ?=
 =?us-ascii?Q?a+Y/1LdPEpit3IcYjjvhUC3DixmVtcN9O13Llbs5Pp9Snr8pBp0h5S5H/zy2?=
 =?us-ascii?Q?8zrCvb0yjQ5A0ombtQmnd0Zv2tos6b7x1H+uQiu0GBkh7Ii2dMPEgJ0wvvds?=
 =?us-ascii?Q?9u7oWpFTP9F2TSyPyhNg+1tYdQ8IWMQx0clGN5IJFUvoc3v8r6z/HYn6gUbK?=
 =?us-ascii?Q?cPAFuK46wQj0ke9Gr+9Qf8RJ1VTgxCjEd/LjZ/IhANQ9Ho8gP5oFpmWOViRY?=
 =?us-ascii?Q?ez06uhR6oWebDAUHHvVzmfR4/kOnZEgQicABfzTzSJbgR++jwQunHvHbC0po?=
 =?us-ascii?Q?FJR7Qlcr777klNg5Bum9/iPc+A3DVa7iprGFKc8CyVuPvLUHNtaBNnKCZaVs?=
 =?us-ascii?Q?qqVeZXX7bGS4zn4RSZ0OJFYEqzgeo+CJQo9D58yaRI1R3g0SJVjsRBfHZQBi?=
 =?us-ascii?Q?N3zX3EqbfQeyfKk1twrDsU6Xv4ar1SRjRbGgBJmN0dbncLEZcaoRt3+CwMSu?=
 =?us-ascii?Q?g+1ADODkEK1xBrwYhiBh9vetnhmq/Iiip2Ij8jkCns9gQtu5IKJUq+omyTQ1?=
 =?us-ascii?Q?Bh9Akh2DKprOCB/OijNXRmG1HK9Bz+RYa3kul8VcE5ZBPj1DLRHn6hcMkQMG?=
 =?us-ascii?Q?KGpi7E1Hs3tLPTyg0d6iwg2q5xz8uSmo7FjfE38PrXv1TJJ9yedcSclLOscG?=
 =?us-ascii?Q?LXu+tMiCzx1X+aJPN7LjKmJDAXlA95Y5+Dy/z4tc95ec8bfvSqitE4QkgQb+?=
 =?us-ascii?Q?ipma8PBqNWkOACcrIbNKUKr1QAQIlu4QPQSFL+S3X0fCHq8WkJR6glVeMkmG?=
 =?us-ascii?Q?QJdzUdKnsBZWIRsycbnslfmCCps5etann/qQ3tmqhQABW975etOPUrqPrc+m?=
 =?us-ascii?Q?66IN3LxP7lFMMLnL3LoR9oADCMYRVH1QA+ba7uMoe1nDsT1RIMczh+FyjevR?=
 =?us-ascii?Q?zDj+I+ZYMBXC2HCHY1dcq2IGKyDYrqF3lu59IoJjz7FPM4wGeXd4KL2teZD3?=
 =?us-ascii?Q?ubuabxvp0Y7C9JCCFwou3Nh3HEA5T+mhuNsaHpi5ng=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n7T+UPCiK5NuQIvCf8qE8i5siHn1PqcZo0NP6kO//gxGmzxXwDQ+xsFRYrQb?=
 =?us-ascii?Q?hR3oAV6vWa6QV44mpJcDKOmiq1sH9TUEHa8P2Lj0MSCq8B19N4BLUNm/NY48?=
 =?us-ascii?Q?gnpdB+Jar0+Z+jClygN6i4qx1qQeRwSWd9phWL3QCcNr8b13Lpf2PTOYnD13?=
 =?us-ascii?Q?Jiry6EF58X1RnFOJl9zfXsEPYieGDgiiAyHAS7wtlnmwHWHP7o+EkmT851Md?=
 =?us-ascii?Q?kh6KUImWvt5fOm3tGx6hNP3HjZRXy3LC9uX24eGWDSWQX66DtE8/SXNEma4s?=
 =?us-ascii?Q?pWhCYnVMmGGBe5SOTW1zYMFUKXv1rQZXw5NURjoYGlOaoRRJq3bwQnVciY2e?=
 =?us-ascii?Q?YcxtQeSLU8vTDRpUmtvY6/gErO2vs228t+qfIx2RLgU4GqN76gUOonSHZiqv?=
 =?us-ascii?Q?tcx8SfpkEonw8gDv7RBeZi49HQlDuT22fj4s+GTeijk3GSF71uMgld8HwDGs?=
 =?us-ascii?Q?Xti9+7kxoanyAPO4MFnLbr52F0sRPNN7UATKX5MjvEq4tvFDmdfiA6PHzadw?=
 =?us-ascii?Q?dv8VCfSpYycfM4HSofuLK8lYWvjirn2f2PO5ap9NY4kG7G2dnc4yNzGKCWDk?=
 =?us-ascii?Q?gXVVO3IrzeAZvdeqSAXn8bhnN1HTH4gyNTOXkbRBNLAbiChIbf+us2E4uM9g?=
 =?us-ascii?Q?Uhf/jmr6oX6OIR5h/PTY/bzvwyvHvsByak4pyQ2jEEnQyt5yN0g8ioWKJJdS?=
 =?us-ascii?Q?Xi9aUxOr9tin7Q48jO7wB1rjkeT5GnJ3xuAB77kgDoxtOUBIsZlgFnY3Vg4Q?=
 =?us-ascii?Q?rsDdrqCIAgWQCE3l22xQkYN+Q99WQoPnvpTqrpQ2Gg+lC8Qn7G/7jGcDO2Fb?=
 =?us-ascii?Q?zed2/84xa0XCJLrhrrBKldC3dlUvLT3Y8uJWcXrDSa7SYvsmGq8tqTAkacKD?=
 =?us-ascii?Q?sCHmKo8iGSM5pMkjb0ujnafNS0dFN6tsQkKkPNhekvMExUnVsFczpW3fFh2J?=
 =?us-ascii?Q?vebxZhHRZkma8y6gF5LcCDeUzYvYEjXWCaRHMoZAhrtNCdYIxAuuXpwvwx/m?=
 =?us-ascii?Q?NIhIKKz83azQTX6pgjWoLtwTLvmBELgPHtzZ/4Pf7LkphjTYcFu9ZtHQ+Wqg?=
 =?us-ascii?Q?iTSFlVnBAUT/aZJEQDh95DVKfpv4s1KPwSCYcKfXP99Rg43cgXiSBYUzKhJ1?=
 =?us-ascii?Q?7byzygXlc+uBZiLUPAQ2Hx38adLW+gkMLI8O2ZWUX1h4flmnhNNIh4cAwCMA?=
 =?us-ascii?Q?SVcyVhQNiP6DeL0CiTixkAaT2dd2A1E5lErHXZFPRUm1T0AaK6/HhlxMmOx0?=
 =?us-ascii?Q?amCBOw9zygRwPaxG4RNIM5m3sv35ZdphiaRt+yv0Ie8U0TF2J2cctmkApqk8?=
 =?us-ascii?Q?OsCV2n/8WwrdKfayDRcqlLzEVoVJoJaL84xsx/HYvme1HwthWTrjMv71A4DM?=
 =?us-ascii?Q?3CJfrHg1IE0JAZwv+hIEDNREPuet7l9lvfUV8nyvl7BLNVw6A+vdGh40qJvu?=
 =?us-ascii?Q?5YvJswyaU74s3WH4Nb2ooKY4Vc8mKTdv3HHDs0zR+GQEmlrawLHKO10d3Ui/?=
 =?us-ascii?Q?DsElhiLhCIk6XO+I8PiP440DNxvsG0vp4MeFjkbRAk46JeutFS26AA59DY2e?=
 =?us-ascii?Q?uK5oPSDo6JqwgbEA518hQM2hdJivC8p0evejgN4g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 917b4e10-efa2-41d8-fe79-08dc6ad87ba0
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 18:48:40.0922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PGMxa56tbjcZjeTR0jf6DUk37mxIqWYwsz3+XPrNsC1C5t+vA9aLMjNMK5gj8E2VrhwS9rW5tzodR50EryVAMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6047

On 02.05.24 12:02:02, Yazen Ghannam wrote:
> On 4/30/24 2:06 PM, Borislav Petkov wrote:
> > On Mon, Apr 29, 2024 at 08:34:37PM +0200, Robert Richter wrote:
> > > After looking a while into it I think the issue was the following:
> > > 
> > > IBS offset was not enabled by firmware, but MCE already was (due to
> > > earlier setup). And mce was (maybe) not on all cpus and only one cpu
> > > per socket enabled. The IBS vector should be enabled on all cpus. Now
> > > firmware allocated offset 1 for mce (instead of offset 0 as for
> > > k8). This caused the hardcoded value (offset 1 for IBS) to be already
> > > taken. Also, hardcoded values couldn't be used at all as this would
> > > have not been worked on k8 (for mce). Another issue was to find the
> > > next free offset as you couldn't examine just the current cpu. So even
> > > if the offset on the current was available, another cpu might have
> > > that offset already in use. Yet another problem was that programmed
> > > offsets for mce and ibs overlapped each other and the kernel had to
> > > reassign them (the ibs offset).
> > > 
> > > I hope a remember correctly here with all details.
> > 
> > I think you're remembering it correct because after I read this, a very
> > very old and dormant brain cell did light up in my head and said, oh
> > yeah, that definitely rings a bell!
> > 
> > :-P
> > 
> > Yazen, this is the type of mess I was talking about.
> > 
> 
> Yep, I see what you mean. Definitely a pain :/
> 
> So is this the only known issue? And was it encountered in production
> systems? Were/are people using IBS on K8 (Family Fh) systems? I know
> that perf got support at this time, but do people still use it?
> 
> Just as an example, this project has Family 10h as the earliest supported.
> https://github.com/jlgreathouse/AMD_IBS_Toolkit

No, IBS was introduced with 10h, but the eilvt offset came already
with k8, but with only one entry. That affected productions systems
and BIOSes.

> 
> My thinking is that we can simplify the code if there are no practical
> issues. And we can address any reported issues as they come.
> 
> If you think that's okay, then I can continue with this particular clean
> up. If not, then at least we have some more context here.

The general approach to use the preprogrammed offsets looks good to
me. Though, existing code [1] checks the offset and reapplies a
hardcoded value of 2 if it is zero. I don't know the history of
this. However, it would be great if that code could be simplified.

-Robert

[1] commit 24fd78a81f6d ("x86/mce/amd: Introduce deferred error interrupt handler")

> 
> I'm sure there will be more topics like this when redoing the MCA init path.
> 
> :)
> 
> Thanks,
> Yazen

