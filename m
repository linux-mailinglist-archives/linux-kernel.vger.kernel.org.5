Return-Path: <linux-kernel+bounces-128797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53539895FB0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFC991F252B8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17934446D5;
	Tue,  2 Apr 2024 22:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d0saZjSD"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C62335F18;
	Tue,  2 Apr 2024 22:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712097762; cv=fail; b=ABOHzBVQcJPOblP7J86cTtWV36IUenpi/eCE45Ub0bt+RIteUDw0dQY4L60jeQ4oN7NpbIqBCDHlZNSkmHrCgyjhPP0wMiIXNMThSbmDlFw73x7++voQiytFGPe8Ne/FyZwtyNRXHo/mxgmOqGRgLEtHOq75fifzYeUEfmijmqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712097762; c=relaxed/simple;
	bh=ASuHIJDmBTHP+oB2fNRMy0d4hT9DNmEBOZ6NT7hP/OI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKm7sGTY7idZfcNwCMJ4364wh3lOb18mzb779J13XbAW2Y3t5n6SSTGnSkPfeJz3tWqXtH7MbKFubshovbZI1LexTxvN+L0KqLmm7lOh5qjbhtBl0QGrWEk2NvCjdXON0Mx7Sd1qJzjsEuC+cPYZ69s9Z7jKOCIximC7rJySwEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=fail (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d0saZjSD reason="signature verification failed"; arc=fail smtp.client-ip=40.107.223.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qq6TpmP6JzA8xyYpbuv2fcaPCu8lLk/noeiad3j51fKU7GsxDwMZBqjgDyKOAFWM1p63B0qovIRGFYXroEG6XflA8Jh+Zc4DUNnlH16okasr9w7QWM9CDyqH0mNN3aFpxxcZMmNdWqrIFdMYDYAL2m/LaYfjHI27eWKVAjv5xK5kdPROu+rdATrj7fViLOAvzzACcBE9LZ0fVj/LKasTpIlzOsjugqOPrsQijQ41bldF9nrN2lhAXP3VwYNQQSbID2f/pv44rp7QfgAGJsJhrJ/9vwNJq+59ZCYlQOxUEJfGzDhMmLFqEddu7FfCexzVvAmay7QMn6RBdp8A+YbLdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u15pXBRNnszb3d4w9+dS9kFnGQtcw/qHwnBEEgIqJiY=;
 b=ctshENfLFuMafBoKJ5ONAAG9xBHc2XinrgZJUk1wfEqcWZv7balu+AI11/SC1nvX3suO4OuCIN1pE3mf//1/YeIaKhEDAe6cWH8WwrgnI828u/LP0YsYfIVboXZikKZ8EUN+veAn79noIluAi1jk0HDtw7Y6766FPUazzO8li59547U52x80Tn6dNv1ysq2Xwy3SUwUSBiswNUf0d30UpV6DnSQRdtVuIi7wrDzj5BlFbYIRTuDw9LeNXwhranroK4WiHiu7oXMi85wcXhFcJgwFiTbI09vz6nXwmDjzkMqFmQ23k73ZKxGwwMRJz9SNOVvrLcmKCDVOMlZy24ejKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u15pXBRNnszb3d4w9+dS9kFnGQtcw/qHwnBEEgIqJiY=;
 b=d0saZjSDwwo8NdSGV6yVZkatqPJjnCQF/V+umE4tBQBYBwoBxrJcJ2lZUlpv1zfxdCcOIzpwUgQujk67j2BVaDc6zPnatWF/hXY5+sARhJo73hqAQrDW3CeMYEQKZPErGL5NdEREdyK2id/af1mf1byA5sgftj8D83q1focq6yA=
Received: from MW4PR04CA0304.namprd04.prod.outlook.com (2603:10b6:303:82::9)
 by SJ2PR12MB7799.namprd12.prod.outlook.com (2603:10b6:a03:4d3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 22:42:38 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:303:82:cafe::2a) by MW4PR04CA0304.outlook.office365.com
 (2603:10b6:303:82::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 22:42:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 22:42:37 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 2 Apr
 2024 17:42:37 -0500
Date: Tue, 2 Apr 2024 17:42:22 -0500
From: Michael Roth <michael.roth@amd.com>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
CC: Tom Lendacky <thomas.lendacky@amd.com>,
	<linux-tip-commits@vger.kernel.org>, <bp@alien8.de>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/sev: Apply RMP table fixups for kexec.
Message-ID: <20240402224222.vxaqenqvyi32zleb@amd.com>
References: <20240312184757.52699-1-Ashish.Kalra@amd.com>
 <b1822884-cba3-4009-d685-81a36dbb4353@amd.com>
 <b2da0a15-c0f5-49a7-b34c-eb408e9aa293@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2da0a15-c0f5-49a7-b34c-eb408e9aa293@amd.com>
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|SJ2PR12MB7799:EE_
X-MS-Office365-Filtering-Correlation-Id: ea8f21c8-4289-4c29-d879-08dc536632a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	V4nEA2Ye3rQDwARU5zqAH8fRVAYAIFpPmxydiZjw1ZbcVwec1ELzgv4SbbcZSPrWbWaUATY0nmButuEgC6uh3Q5rLr08jqGsA2blu8VVWWIhBOrdXbwFg9/beXD8pDMEw0G+A24R5EfGBJ6R+s1b73MowWP8qfLp5SP78hkhaNBPv1M3nVr8EodTqozQ/glD/vfdD05i1bSkwsuhOM+/QM9qB+wElGHC8B7M82GQvTxcIErR0GG9AyU6L/FPOTHff/4SXs21kwXqmW9diuI4lCR023/9jKGB7FFeo2ZMZRMy1EWujf7yu+TXrxGXFQRMdWwcM/2+m4GHG4/EWKlWeHW8dAH2DdEcum7Ltyhk/zyRhzQqFheOWFc/l7XItWMKNFvJw1wywCSAtest3CtJUGNa937mDPXF/wagcPpgnUTc8TRyJzObeCKzLn1lMB66JCURSlFALduPas0icWJsidCpIAHvFkkEvqT4A4RA2WXHhHz1rblMZKc42NaklnXTQTwETmBeW9N+rqIqE4/oJoTZsJViYDaeE811aU5ih6XZ/oPlPAWi+F5/jj0h74BFt1yFA4NLc/fNjXXFukm5j7NtsT3XcUVnKYaqE2JotIt2+DdIUL+GEaJkUUQWshKHpgnb6/m6VWioN98rwr/uEIepOEhkvR1LtFOGnYuGBQTxdl5oMDc38SDA2P9SESP4qnP7J708af/ZBveYoxqQzY1y5cD601oigbD+wVZ7bWORuYVmJgpxVsOM3htRolzt
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 22:42:37.9729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea8f21c8-4289-4c29-d879-08dc536632a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7799

On Tue, Apr 02, 2024 at 05:31:09PM -0500, Kalra, Ashish wrote:
> 
> On 4/2/2024 5:09 PM, Tom Lendacky wrote:
> > On 3/12/24 13:47, Ashish Kalra wrote:
> > > From: Ashish Kalra <ashish.kalra@amd.com>
> > > 
> > > RMP table start and end physical range may not be aligned to 2MB in
> > > the e820 tables causing fatal RMP page faults during kexec boot when
> > > new page allocations are done in the same 2MB page as the RMP table.
> > > Check if RMP table start and end physical range in e820_table is not
> > > aligned to 2MB and in that case use e820__range_update() to map this
> > > range to reserved.
> > > 
> > > Override e820__memory_setup_default() to check and apply these RMP table
> > > fixups in e820_table before e820_table is used to setup
> > > e280_table_firmware and e820_table_kexec.
> > > 
> > > Fixes: c3b86e61b756 ("x86/cpufeatures: Enable/unmask SEV-SNP CPU
> > > feature")
> > > Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> > > ---
> > >   arch/x86/virt/svm/sev.c | 52 +++++++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 52 insertions(+)
> > > 
> > > diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> > > index cffe1157a90a..e0d7584df28f 100644
> > > --- a/arch/x86/virt/svm/sev.c
> > > +++ b/arch/x86/virt/svm/sev.c
> > > @@ -65,6 +65,8 @@ static u64 probed_rmp_base, probed_rmp_size;
> > >   static struct rmpentry *rmptable __ro_after_init;
> > >   static u64 rmptable_max_pfn __ro_after_init;
> > >   +static char *__init snp_rmptable_e820_fixup(void);
> > > +
> > >   static LIST_HEAD(snp_leaked_pages_list);
> > >   static DEFINE_SPINLOCK(snp_leaked_pages_list_lock);
> > >   @@ -160,9 +162,59 @@ bool snp_probe_rmptable_info(void)
> > >       pr_info("RMP table physical range [0x%016llx - 0x%016llx]\n",
> > >           probed_rmp_base, probed_rmp_base + probed_rmp_size - 1);
> > >   +    /*
> > > +     * Override e820__memory_setup_default() to do any RMP table fixups
> > > +     * for kexec if required.
> > > +     */
> > > +    x86_init.resources.memory_setup = snp_rmptable_e820_fixup;
> > 
> > This produces a build warning:
> > 
> > WARNING: modpost: vmlinux: section mismatch in reference:
> > snp_probe_rmptable_info+0x95 (section: .text) -> x86_init (section:
> > .init.data)
> > WARNING: modpost: vmlinux: section mismatch in reference:
> > snp_probe_rmptable_info+0x99 (section: .text) -> snp_rmptable_e820_fixup
> > (section: .init.text)
> > 
> Oh, so this requires snp_probe_rmptable_info() to be fixed to use the __init
> macro.
> 
> I believe that snp_probe_rmptable_info() should be anyway using the __init
> macro and this fix for snp_probe_rmptable_info() needs to be sent as a
> separate patch and regardless of this patch getting merged or not.

I think you'll hit issues with:

  bsp_determine_snp() ->           //non-__init
    snp_probe_rmptable_info()      //__init

and bsp_determine_snp() sticks around as a function pointer assigned to
cpuinfo_x86 so I don't think you can use __init there.

So might need to just drop __init from snp_rmptable_e820_fixup().

-Mike

> 
> Thanks, Ashish
> 
> > Thanks,
> > Tom
> > 
> > > +
> > >       return true;
> > >   }

