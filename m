Return-Path: <linux-kernel+bounces-31470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5231E832EC8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93862B22009
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5C956455;
	Fri, 19 Jan 2024 18:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DgrXMIuE"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1421F170;
	Fri, 19 Jan 2024 18:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705688551; cv=fail; b=iPUZoKLg+c1mzg9wryyAL16m0N4rkGWQ1yh2rsmrFJnXJPfB5aRccArNvBSiYKQM2vhMCLobjQys41wTkZyYm64DrIFLTnPmiXEdbA54EmF2Xv90kBe7v65N43BAw7FZtKr1nl5cuujhkXTyGRzEjgCunb+TgN1s3i67F3UOInE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705688551; c=relaxed/simple;
	bh=hYFvbkiCkn6JY+LHEm/O2JlTPF+xBB1f4BjAQiUnsE0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BAQEhoDrXz6WymKCgAipCMpUIj+R+aP/WCifSnB0X14KzI1F2RTcdtVNkWmNiHA9bzoojab19Yv0fZKChiSe2WyoYj0TdqgxTLP+8nnYhnQyOGCjzidZoZgFN4Jp0d299hfMvAxWbXXpzhe8RHjUaD1+fiXK3PzV4tb94A2qbD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DgrXMIuE; arc=fail smtp.client-ip=40.107.94.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S2rhsNANnp9AzVGxkL3rdstksHE41l7utXGG1oSYUa8CUMp8I8Wep0Pt+ToTrSUiZiT7K2idcVAZMk2Q5x2dySei4jRf4bIZ4ZN1yvp8lCTI94Hiq5h63zTYO3L+ItBC1LVO5RMjUpnI7tYGLVhM/pLXikMLWJ9z9s27wmaIKjJby97q85NdSjAU3Sq9FpWY1/qc7YVXdh+RPIqnJCuOyaPKWWUaSz7deBd8a5clap5m+WX+rt/L3hcCnhv5ys2JMSsvWDhyFiiZ58Sl7cb9t4sTI778ahSaW4YE8VN7opgnq+fA3b9tAGf238KRugKAU+5zcn0U8aPFiA8KtmpSYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBTWO4HKg5kXdHE4fN/DwYJmPTPBWOrfFZIqDaXQcMY=;
 b=bFBxiU2gCKNu3EOpyMV3+nqCwbIzOHQLB6h7T6OFVeg0qcqNph4gMbxYb9ppy3Mq1u9UWdFGipy59wlydHeG50Qjrip65mv/KL9A131x7nuSiq1BsVWQUZhJSZcrvCvUBgRPVqLfhgH0bge23YLSARzw4Tb2XxIKXSQT/iC1g2IdfG9HsHyy6u5i9KUcINwaxmzqqrixkbvYu+vvEyLU99phWRlTSEURg62OiyznegXQyJci4pwiaa1keyCV2/2HElpYT8a6JHssaiApxBKOMDZZ5pSYfgindIWkbIdrWl35qxMw3zrUTAFM0CZbyNXRWrFvXnsE6eL8y33Zte1Mqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBTWO4HKg5kXdHE4fN/DwYJmPTPBWOrfFZIqDaXQcMY=;
 b=DgrXMIuEIq1+qD7cNV3IL+4oM/f1lu4bo5fryBIkdN0cHIqjk30FXXht6aKQBOAW10dguPp9Rw/Wd/Ujr+KlxpzwRP0GkQAUjT7olcS2qmdk8wJzIPBvGn915pwSeYGrdg0BsisUin4Fxu6UcMYfzoxoAg0lNj40y6PDdi6fJGU=
Received: from BYAPR11CA0046.namprd11.prod.outlook.com (2603:10b6:a03:80::23)
 by DS0PR12MB7852.namprd12.prod.outlook.com (2603:10b6:8:147::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.26; Fri, 19 Jan
 2024 18:22:26 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::a3) by BYAPR11CA0046.outlook.office365.com
 (2603:10b6:a03:80::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.26 via Frontend
 Transport; Fri, 19 Jan 2024 18:22:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Fri, 19 Jan 2024 18:22:26 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 19 Jan
 2024 12:22:24 -0600
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <babu.moger@amd.com>, <kim.phillips@amd.com>,
	<lukas.bulwahn@gmail.com>, <seanjc@google.com>, <jmattson@google.com>,
	<leitao@debian.org>, <jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>
Subject: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth Monitoring Counters (ABMC)
Date: Fri, 19 Jan 2024 12:22:02 -0600
Message-ID: <cover.1705688538.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201005720.235639-1-babu.moger@amd.com>
References: <20231201005720.235639-1-babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|DS0PR12MB7852:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b39f223-8a12-4762-8dfe-08dc191b96f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hsbHMqMegj3CQr2lrO58tYi6Da2cIo2VVs51eeokx6Dg1KLC4s0FcoBUw3aQ0jJsqOcRmkJsnDsqyo/8LF+a40JidD4yTJ3iw7gO1S10y6DKDnMsXqFzfqe0+61KFvADP6b3N7fOup/WMJeIEpVdW1LQfw39NH71O65dZKbuYuopImarQN0CkuMDCGJWuDvmwthD9684jvHuS2//rk02K04kqhWwGu2FjwxuWrYRNdB4wlm9Q3EB4AHeVrxcHoswnRgxs6+vIYHMFi+oKErWYMgfOi38PdUM/Hv9ceDhstp23UvoajC4KA6lYBOj7QXnxi2QB0qPD6LL8rOZGrqjpcMio5ozsEJNpyVVhJEP7t6K+sAbafTqtQq09eCks+y+FTnZHxMIi96equ7pMe3EbqDcVYwUKh3zLN/UXVn9Sw8Xl4lDi9Z83mx2eQ2/6Iu/80Ndo54BOEe3KuODOg7I8Kf/pyI0WTbC9Rpt56v5prZY8Vzf25TBM+CqbFdRbwGXFKD8P/Dp9AWuUiB4jIv405TyjpK2p4GWAC+xxbC2qT284CjAbIC62/4C6jq8St4J9wYO+e3wABfaEKPc47Mtx7wGJGYALksV3QVUuoJV1acte5YoJSV/SXKCRh97J4o7ozQhteFD9fTRbdosppDMEFWNVmol8r/8PyigeuYNK7qFQvof3RTPnIrx+Qe/i72QowWuaQfL2WXqRZdbPTA6plHxhOdGbJvQsZpIjtx/mX5MEBWNioryFp3Z2c5CT1o5rPSH1zf5+Gzux0d2m9tvnoplyeHC327Ni350LmorOWk=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(346002)(396003)(230922051799003)(451199024)(186009)(82310400011)(64100799003)(1800799012)(36840700001)(46966006)(40470700004)(86362001)(40460700003)(40480700001)(70586007)(36756003)(2616005)(426003)(83380400001)(81166007)(356005)(16526019)(336012)(47076005)(26005)(70206006)(7416002)(7406005)(316002)(2906002)(5660300002)(110136005)(54906003)(966005)(478600001)(7696005)(4326008)(6666004)(44832011)(82740400003)(41300700001)(8676002)(36860700001)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 18:22:26.5807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b39f223-8a12-4762-8dfe-08dc191b96f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7852


These series adds the support for Assignable Bandwidth Monitoring Counters
(ABMC). It is also called QoS RMID Pinning feature

The feature details are documented in the  APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
Monitoring (ABMC). The documentation is available at
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537

The patches are based on top of commit
1ac6b49423e83af2abed9be7fbdf2e491686c66b (tip/master)

# Introduction

AMD hardware can support 256 or more RMIDs. However, bandwidth monitoring
feature only guarantees that RMIDs currently assigned to a processor will
be tracked by hardware. The counters of any other RMIDs which are no longer
being tracked will be reset to zero. The MBM event counters return
"Unavailable" for the RMIDs that are not active.
    
Users can create 256 or more monitor groups. But there can be only limited
number of groups that can be give guaranteed monitoring numbers.  With ever
changing configurations there is no way to definitely know which of these
groups will be active for certain point of time. Users do not have the
option to monitor a group or set of groups for certain period of time
without worrying about RMID being reset in between.
    
The ABMC feature provides an option to the user to assign an RMID to the
hardware counter and monitor the bandwidth for a longer duration.
The assigned RMID will be active until the user unassigns it manually.
There is no need to worry about counters being reset during this period.
Additionally, the user can specify a bitmask identifying the specific
bandwidth types from the given source to track with the counter.

Without ABMC enabled, monitoring will work in current mode without
assignment option.

# Linux Implementation

Linux resctrl subsystem provides the interface to count maximum of two
memory bandwidth events per group, from a combination of available total
and local events. Keeping the current interface, users can assign a maximum
of 2 ABMC counters per group. User will also have the option to assign only
one counter to the group. If the system runs out of assignable ABMC
counters, kernel will display an error. Users need to unassign an already
assigned counter to make space for new assignments.


# Examples

a. Check if ABMC support is available
	#mount -t resctrl resctrl /sys/fs/resctrl/

	#cat /sys/fs/resctrl/info/L3_MON/mon_features 
	llc_occupancy
	mbm_total_bytes
	mbm_total_bytes_config
	mbm_local_bytes
	mbm_local_bytes_config
	mbm_assign_capable ←  Linux kernel detected ABMC feature

b. Check if ABMC is enabled. By default, ABMC feature is disabled.
   Monitoring works in legacy monitor mode when ABMC is not enabled.

	#cat /sys/fs/resctrl/info/L3_MON/mbm_assign_enable
	0

c. There will be new file "monitor_state" for each monitor group when ABMC
   feature is supported. However, monitor_state is not available if ABMC is
   disabled.
	
	#cat /sys/fs/resctrl/monitor_state 
	Unsupported
	
d. Read the event mbm_total_bytes and mbm_local_bytes. Without ABMC
   enabled, monitoring will work in current mode without assignment option.
	
	# cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
	779247936
	# cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes 
	765207488
	
e. Enable ABMC mode.

	#echo 1 > /sys/fs/resctrl/info/L3_MON/mbm_assign_enable
        #cat /sys/fs/resctrl/info/L3_MON/mbm_assign_enable
        1

f. Read the monitor states. By default, both total and local MBM
	events are in "unassign" state.
	
	#cat /sys/fs/resctrl/monitor_state
	total=unassign;local=unassign

g. Read the event mbm_total_bytes and mbm_local_bytes. In ABMC mode,
   the MBA events are not available until the user assigns the events
   explicitly.
	
	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
	Unsupported
	
	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes 
	Unsupported

h. The event llc_occupancy is not affected by ABMC mode. Users can still
   read the llc_occupancy.

	#cat /sys/fs/resctrl/mon_data/mon_L3_00/llc_occupancy 
	557056

i. Now assign the total event and read the monitor_state.
	
	#echo total=assign > /sys/fs/resctrl/monitor_state
	#cat /sys/fs/resctrl/monitor_state 
	total=assign;local=unassign
	
j. Now that the total event is assigned. Read the total event.
	
	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
	6136000
	
k. Now assign the local event and read the monitor_state.
	
	#echo local=assign > /sys/fs/resctrl/monitor_state
	#cat /sys/fs/resctrl/monitor_state
	total=assign;local=assign

        Users can also assign both total and local events in one single
	command.

l. Now that both total and local events are assigned, read the events.
	
	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
	6136000
	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
	58694
	
m. Check the bandwidth configuration for the group. Note that bandwidth
   configuration has a domain scope. Total event defaults to 0x7F (to
   count all the events) and local event defaults to 0x15 (to count all
   the local numa events). The event bitmap decoding is available at
   https://www.kernel.org/doc/Documentation/x86/resctrl.rst
   in section "mbm_total_bytes_config", "mbm_local_bytes_config":
	
	#cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config 
	0=0x7f;1=0x7f
	
	#cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config 
	0=0x15;1=0xi15
	
n. Change the bandwidth source for domain 0 for the total event to count only reads.
   Note that this change effects lotal events on the domain 0.
	
	#echo 0=0x33 > /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config 
	#cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config 
	0=0x33;1=0x7F
	
o. Now read the total event again. The mbm_total_bytes should display
   only the read events.
	
	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
	314101
	
p. Unmount the resctrl
	 
	#umount /sys/fs/resctrl/

NOTE: For simplicity these examples are run on a default resctrl group.
Similar experiments are can be run non-defaults groups.
---
v2:
   a. Major change is the way ABMC is enabled. Earlier, user needed to remount
      with -o abmc to enable ABMC feature. Removed that option now.
      Now users can enable ABMC by "$echo 1 to /sys/fs/resctrl/info/L3_MON/mbm_assign_enable".
     
   b. Added new word 21 to x86/cpufeatures.h.

   c. Display unsupported if user attempts to read the events when ABMC is enabled
      and event is not assigned.

   d. Display monitor_state as "Unsupported" when ABMC is disabled.
  
   e. Text updates and rebase to latest tip tree (as of Jan 18).
 
   f. This series is still work in progress. I am yet to hear from ARM developers. 

v1 :
   https://lore.kernel.org/lkml/20231201005720.235639-1-babu.moger@amd.com/

Babu Moger (17):
  x86/cpufeatures: Add word 21 for scattered CPUID features
  x86/resctrl: Add support for Assignable Bandwidth Monitoring Counters
    (ABMC)
  x86/resctrl: Add ABMC feature in the command line options
  x86/resctrl: Detect Assignable Bandwidth Monitoring feature details
  x86/resctrl: Introduce resctrl_file_fflags_init
  x86/resctrl: Introduce interface to display number of ABMC counters
  x86/resctrl: Add support to enable/disable ABMC feature
  x86/resctrl: Introduce the interface to display ABMC state
  x86/resctrl: Introdruce rdtgroup_assign_enable_write
  x86/resctrl: Add interface to display monitor state of the group
  x86/resctrl: Report Unsupported when MBM events are read
  x86/resctrl: Initialize assignable counters bitmap
  x86/resctrl: Add data structures for ABMC assignment
  x86/resctrl: Introduce mbm_total_cfg and mbm_local_cfg
  x86/resctrl: Add the interface to assign the RMID
  x86/resctrl: Add the interface unassign the RMID
  x86/resctrl: Update RMID assignments on event configuration changes

 .../admin-guide/kernel-parameters.txt         |   2 +-
 Documentation/arch/x86/resctrl.rst            |  62 +++
 arch/x86/include/asm/cpufeature.h             |   6 +-
 arch/x86/include/asm/cpufeatures.h            |   7 +-
 arch/x86/include/asm/disabled-features.h      |   3 +-
 arch/x86/include/asm/msr-index.h              |   2 +
 arch/x86/include/asm/required-features.h      |   3 +-
 arch/x86/kernel/cpu/cpuid-deps.c              |   3 +
 arch/x86/kernel/cpu/resctrl/core.c            |  25 +-
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c     |  15 +
 arch/x86/kernel/cpu/resctrl/internal.h        |  54 +-
 arch/x86/kernel/cpu/resctrl/monitor.c         |  26 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c        | 466 +++++++++++++++++-
 arch/x86/kernel/cpu/scattered.c               |   1 +
 include/linux/resctrl.h                       |   2 +
 15 files changed, 651 insertions(+), 26 deletions(-)

-- 
2.34.1


