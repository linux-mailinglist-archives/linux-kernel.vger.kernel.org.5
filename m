Return-Path: <linux-kernel+bounces-123937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C2D891003
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 630581F2256F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD24125B2;
	Fri, 29 Mar 2024 01:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="brya0Iq7"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1651119A;
	Fri, 29 Mar 2024 01:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711674424; cv=fail; b=aqHY8ZvJ3CVkJEFoG2A2Rt0UKJJvxzUecgAQ4AJLROpAud+pu7aDDEuopw6lHS9cxMmj9ijDv1deZ23SyGdt2FadfruVE5L9AqiZytR0Zcs60kXN56IDW7ZN07iVBPkrzXCwUX6o8w/avdoUSgEqdSS5esFP6bKvw/0sP1T9oYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711674424; c=relaxed/simple;
	bh=Gq65pshimEBBZMyM5geBxVL0DbkPb/pIJnMFwp1KhHA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O+/Uf/SnKvQK9QqXRupEhfetpICJ86l/od0wLHOnjreMvPAJDDjUTNFYbBqTooV49GsHG1ZJfmKJzEq6iLDLYhhXofGWlHvrgmQOdJt6jFk56wFiqvN2f7YgMgJZlQ53wiIeM8pPNNuUtL1U7X6pf3PxYlWKKjvt1h8mZQrz858=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=brya0Iq7; arc=fail smtp.client-ip=40.107.100.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rha/h0HP4PiQpnv2zf/tlQJlL0BRu9ILeQ9thmmmhGM9uZuL3yB77IPGRmD/tKoZwwUYdrat17HXOQTYqO5Ewjo+LsFC7zAQ5ndIYhgRG38uaK59fyQf7FfqFjv7Npl4MFRsPikPqi6tT1vBJE9kn5/QK/5qv3O1vPZG2zlltYO7A3ri7qRp4/N96DtkrnjtWhBevZPV00GZy+lI0LPENNtC+ooEPmtFfTwYGzbUEuabwLnMLI+5lGcMb3W5ElW32yIfLmy9vKVQusaeVfalQUnohqml5Obyj3sdcs2NtaQvptg1j6bvBZMWp5HGWkb8dktH4Hs8NdEFZ/vKBZG9wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsTL1V9OcWCk0b9w7v1taAmhT60s9uugYHr67DSFi9Y=;
 b=iv3ARUCMOvCO9e4OtuAqLCeTJzGFHsOtCMKZUoy78uMQm1+/F4E/UXTWFr6E3UJ3SUUF+KyqczFmCsNzZ9V6TJKdZZB6vib39IeesZ883heYUNFTNl/922W4ZU0UZyPtAXhZ9WB3Wgz86lKkF304F923cupgrJolWMUEp7RtxbCz0M+68eB0KdXEDagUfgwPeLsGoG5isz8pLI/jx1g6EtO/rWYYC0VWjc4FN8RbCpRJrMjH0qLhfN7ylg/Uw+4VTv+3XmAHjHW+8KiYGuPs+GAWW8phnm4MX2SbmJ4E/l3mt+OF21hBMMhRCChIHX5JneufMtDkJB9k3GAtsIXusQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsTL1V9OcWCk0b9w7v1taAmhT60s9uugYHr67DSFi9Y=;
 b=brya0Iq7vles0j9G8jQDh1IzjU9mevOPNnuNQVshlJul6+koOx0sZ1rx0rK6oervCCaZOqc0EAyXpnTPkBc95dpjpv9VWWu0KOGn4Cp6irm/KVPRvGlJIWCeYZJO4nrM9lyE6XSLALwbCWhHandQW3uQZ+ybp/LtkAD7zqFO22A=
Received: from PH1PEPF00013308.namprd07.prod.outlook.com (2603:10b6:518:1::15)
 by DS7PR12MB6310.namprd12.prod.outlook.com (2603:10b6:8:95::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Fri, 29 Mar
 2024 01:06:58 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2a01:111:f403:f910::) by PH1PEPF00013308.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Fri, 29 Mar 2024 01:06:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 29 Mar 2024 01:06:57 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 20:06:56 -0500
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
	<eranian@google.com>, <james.morse@arm.com>
Subject: [RFC PATCH v3 00/17] x86/resctrl : Support AMD Assignable Bandwidth Monitoring Counters (ABMC)
Date: Thu, 28 Mar 2024 20:06:33 -0500
Message-ID: <cover.1711674410.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|DS7PR12MB6310:EE_
X-MS-Office365-Filtering-Correlation-Id: d111f20f-952f-4302-35a1-08dc4f8c883c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h/0yCCPfojHTEZeP2f/aYGd0397a5+izGr8WmBBJHML8kVL9GsE+PIJNT5DdF4aJ5HZxhEiSIYZJl71gzNrxA/qkstqZxE3ICKL20I4YpUERDzTllQYHXh5CnV6wSCCnFRKvzaRBUSYrxmywt/uKuy9+PYVG9I78p03P4ayv3YjjcViGGUPb5fREwz7GQJvOhUQG3sDJanShROlJY+eGTtZPQx5ldy+dc0f/J64H/j+oINxxxFyJ41xsDpTaskw8Jr7SDbuPHFoEVqpLMExWV/IekHoA5y/i378RVB2/CXAFvxRtjLZ/SZ/RQ5HtoNS+V7dDaHloHF8yqPIoOXFx/RekRN66N6fG6TUpT6rz5zEG/qz9dYz2kfqSFnqy395VuRLwd3DsSqNou7BDPWvX5XL5bIGSF0XPZQezHHbTDE0YyShHFIc4fKUF7nq4Ld9+qYc6te8y6RE8UUWhI+f1Tn5kLrz1SR85gciuJVDZVM9yICR+u0ODA/3TFxG/YZe9WjgTVo2R3Juh+ZiqUNDWlAE9m/6Hn8/3Zjri0GqoHDxp4gil7OdiIb7d0Gf/Y+BCW1/n8swg3nwMwnXxA3lSt+o+iIL8JI8mBRRGEIgAGj4xs0stKpEG8MDTiS64s61NQP76pYQ5Y0IrES9jc0C7JArcOBg+m97cw+voBFMrFZ6bVPMRuS1I8HCJTFkWmBEVkrqRaKP6XljOxDwTvU+7yQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400014)(7416005)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 01:06:57.8180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d111f20f-952f-4302-35a1-08dc4f8c883c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6310


This series adds the support for Assignable Bandwidth Monitoring Counters
(ABMC). It is also called QoS RMID Pinning feature

The feature details are documented in the  APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
Monitoring (ABMC). The documentation is available at
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537

The patches are based on top of commit
cd80c2c94699913f9334414189487ff3f93cf0b5 (tip/master)

# Introduction

AMD hardware can support 256 or more RMIDs. However, bandwidth monitoring
feature only guarantees that RMIDs currently assigned to a processor will
be tracked by hardware. The counters of any other RMIDs which are no longer
being tracked will be reset to zero. The MBM event counters return
"Unavailable" for the RMIDs that are not active.
    
Users can create 256 or more monitor groups. But there can be only limited
number of groups that can give guaranteed monitoring numbers. With ever
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

	#cat /sys/fs/resctrl/info/L3_MON/mbm_assign
	[abmc] 
	legacy_mbm

	Linux kernel detected ABMC feature and it is enabled.

b. Check how many ABMC counters are available. 

	#cat /sys/fs/resctrl/info/L3_MON/mbm_assign_cntrs 
	32

c. Create few resctrl groups.

	# mkdir /sys/fs/resctrl/mon_groups/default_mon1
	# mkdir /sys/fs/resctrl/non_defult_group
	# mkdir /sys/fs/resctrl/non_defult_group/mon_groups/non_default_mon1

d. This series adds a new interface file /sys/fs/resctrl/info/L3_MON/mbm_assign_control
   to list and modify the group's assignment states.

   The list follows the following format:

       * Default CTRL_MON group:
               "//<domain_id>=<assignment_flags>"

       * Non-default CTRL_MON group:
               "<CTRL_MON group>//<domain_id>=<assignment_flags>"

       * Child MON group of default CTRL_MON group:
               "/<MON group>/<domain_id>=<assignment_flags>"

       * Child MON group of non-default CTRL_MON group:
               "<CTRL_MON group>/<MON group>/<domain_id>=<assignment_flags>"

       Assignment flags can be one of the following:

        t  MBM total event is assigned
        l  MBM local event is assigned
        tl Both total and local MBM events are assigned
        _  None of the MBM events are assigned

	Examples:

	# cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control 
	non_defult_group//0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
	non_defult_group/non_default_mon1/0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
	//0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
	/default_mon1/0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;

	There are four groups and all the groups have local and total event assigned.

	"//" - This is a default CONTROL MON group

	"non_defult_group//" - This is non default CONTROL MON group

	"/default_mon1/"  - This is Child MON group of the defult group

	"non_defult_group/non_default_mon1/" - This is child MON group of the non default group

	=tl means both total and local events are assigned.

e. Update the group assignment states using the interface file /sys/fs/resctrl/info/L3_MON/mbm_assign_control.

	The write format is similar to the above list format with addition of
	op-code for the assignment operation.

        * Default CTRL_MON group:
                "//<domain_id><op-code><assignment_flags>"

        * Non-default CTRL_MON group:
                "<CTRL_MON group>//<domain_id><op-code><assignment_flags>"

        * Child MON group of default CTRL_MON group:
                "/<MON group>/<domain_id><op-code><assignment_flags>"

        * Child MON group of non-default CTRL_MON group:
                "<CTRL_MON group>/<MON group>/<domain_id><op-code><assignment_flags>"

       Op-code can be one of the following:

        = Update the assignment to match the flags
        + Assign a new state
        - Unassign a new state
        _ Unassign all the states


        Initial group status:

        # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
        non_default_ctrl_mon_grp//0=tl;1=tl;
        non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
        //0=tl;1=tl;
        /child_default_mon_grp/0=tl;1=tl;


        To update the default group to assign only total event.
        # echo "//0=t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control

        Assignment status after the update:
        # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
        non_default_ctrl_mon_grp//0=tl;1=tl;
        non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
        //0=t;1=t;
        /child_default_mon_grp/0=tl;1=tl;

        To update the MON group child_default_mon_grp to remove local event:
        # echo "/child_default_mon_grp/0-l" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control

        Assignment status after the update:
        # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
        //0=t;1=t;
        /child_default_mon_grp/0=t;1=t;
        non_default_ctrl_mon_grp//0=tl;1=tl;
        non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;

        To update the MON group non_default_ctrl_mon_grp/child_non_default_mon_grp to
        remove both local and total events:
        # echo "non_default_ctrl_mon_grp/child_non_default_mon_grp/0_" >
                      /sys/fs/resctrl/info/L3_MON/mbm_assign_control

        Assignment status after the update:
        # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
        //0=t;1=t;
        /child_default_mon_grp/0=t;1=t;
        non_default_ctrl_mon_grp//0=tl;1=tl;
        non_default_ctrl_mon_grp/child_non_default_mon_grp/0=_;1=_;

	
f. Read the event mbm_total_bytes and mbm_local_bytes of the default group.
   There is no change in reading the evetns with ABMC. If the event is unassigned
   when reading, then the read will come back as Unavailable.
	
	# cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
	779247936
	# cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes 
	765207488
	
g. Users will have the option to go back to legacy_mbm mode if required.
   This can be done using the following command.

	# echo "legacy_mbm" > /sys/fs/resctrl/info/L3_MON/mbm_assign
	# cat /sys/fs/resctrl/info/L3_MON/mbm_assign
        abmc
        [legacy_mbm]

	
h. Check the bandwidth configuration for the group. Note that bandwidth
   configuration has a domain scope. Total event defaults to 0x7F (to
   count all the events) and local event defaults to 0x15 (to count all
   the local numa events). The event bitmap decoding is available at
   https://www.kernel.org/doc/Documentation/x86/resctrl.rst
   in section "mbm_total_bytes_config", "mbm_local_bytes_config":
	
	#cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config 
	0=0x7f;1=0x7f
	
	#cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config 
	0=0x15;1=0x15
	
j. Change the bandwidth source for domain 0 for the total event to count only reads.
   Note that this change effects total events on the domain 0.
	
	#echo 0=0x33 > /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config 
	#cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config 
	0=0x33;1=0x7F
	
k. Now read the total event again. The mbm_total_bytes should display
   only the read events.
	
	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
	314101
	
l. Unmount the resctrl
	 
	#umount /sys/fs/resctrl/

---
v3:
   This series adds the support for global assignment mode discussed in
   the thread. https://lore.kernel.org/lkml/20231201005720.235639-1-babu.moger@amd.com/
   Removed the individual assignment mode and included the global assignment interface.
   Added following interface files.
   a. /sys/fs/resctrl/info/L3_MON/mbm_assign
      Used for displaying the current assignment mode and switch between
      ABMC and legacy mode.
   b. /sys/fs/resctrl/info/L3_MON/mbm_assign_control
      Used for lising the groups assignment mode and modify the assignment states.
   c. Most of the changes are related to the new interface.
   d. Addressed the comments from Reinette, James and Peter.
   e. Hope I have addressed most of the major feedbacks discussed. If I missed
      something then it is not intentional. Please feel free to comment.
   f. Sending this as an RFC as per Reinette's comment. So, this is still open
      for discussion.

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

v2:
  https://lore.kernel.org/lkml/20231201005720.235639-1-babu.moger@amd.com/

v1 :
   https://lore.kernel.org/lkml/20231201005720.235639-1-babu.moger@amd.com/


Babu Moger (17):
  x86/resctrl: Add support for Assignable Bandwidth Monitoring Counters
    (ABMC)
  x86/resctrl: Add ABMC feature in the command line options
  x86/resctrl: Detect Assignable Bandwidth Monitoring feature details
  x86/resctrl: Introduce resctrl_file_fflags_init
  x86/resctrl: Introduce the interface to display the assignment state
  x86/resctrl: Introduce interface to display number of ABMC counters
  x86/resctrl: Add support to enable/disable ABMC feature
  x86/resctrl: Initialize assignable counters bitmap
  x86/resctrl: Introduce assign state for the mon group
  x86/resctrl: Add data structures for ABMC assignment
  x86/resctrl: Introduce mbm_total_cfg and mbm_local_cfg
  x86/resctrl: Add the functionality to assign the RMID
  x86/resctrl: Add the functionality to unassign the RMID
  x86/resctrl: Enable ABMC by default on resctrl mount
  x86/resctrl: Introduce the interface switch between ABMC and
    legacy_mbm
  x86/resctrl: Introduce interface to list assignment states of all the
    groups
  x86/resctrl: Introduce interface to modify assignment states of the
    groups

 .../admin-guide/kernel-parameters.txt         |   2 +-
 Documentation/arch/x86/resctrl.rst            | 144 ++++
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/msr-index.h              |   2 +
 arch/x86/kernel/cpu/cpuid-deps.c              |   3 +
 arch/x86/kernel/cpu/resctrl/core.c            |  25 +-
 arch/x86/kernel/cpu/resctrl/internal.h        |  56 +-
 arch/x86/kernel/cpu/resctrl/monitor.c         |  24 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c        | 714 +++++++++++++++++-
 arch/x86/kernel/cpu/scattered.c               |   1 +
 include/linux/resctrl.h                       |  12 +
 11 files changed, 964 insertions(+), 20 deletions(-)

-- 
2.34.1


Babu Moger (17):
  x86/resctrl: Add support for Assignable Bandwidth Monitoring Counters
    (ABMC)
  x86/resctrl: Add ABMC feature in the command line options
  x86/resctrl: Detect Assignable Bandwidth Monitoring feature details
  x86/resctrl: Introduce resctrl_file_fflags_init
  x86/resctrl: Introduce the interface to display the assignment state
  x86/resctrl: Introduce interface to display number of ABMC counters
  x86/resctrl: Add support to enable/disable ABMC feature
  x86/resctrl: Initialize assignable counters bitmap
  x86/resctrl: Introduce assign state for the mon group
  x86/resctrl: Add data structures for ABMC assignment
  x86/resctrl: Introduce mbm_total_cfg and mbm_local_cfg
  x86/resctrl: Add the functionality to assign the RMID
  x86/resctrl: Add the functionality to unassign the RMID
  x86/resctrl: Enable ABMC by default on resctrl mount
  x86/resctrl: Introduce the interface switch between ABMC and
    legacy_mbm
  x86/resctrl: Introduce interface to list assignment states of all the
    groups
  x86/resctrl: Introduce interface to modify assignment states of the
    groups

 .../admin-guide/kernel-parameters.txt         |   2 +-
 Documentation/arch/x86/resctrl.rst            | 144 ++++
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/msr-index.h              |   2 +
 arch/x86/kernel/cpu/cpuid-deps.c              |   3 +
 arch/x86/kernel/cpu/resctrl/core.c            |  25 +-
 arch/x86/kernel/cpu/resctrl/internal.h        |  56 +-
 arch/x86/kernel/cpu/resctrl/monitor.c         |  24 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c        | 714 +++++++++++++++++-
 arch/x86/kernel/cpu/scattered.c               |   1 +
 include/linux/resctrl.h                       |  12 +
 11 files changed, 964 insertions(+), 20 deletions(-)

-- 
2.34.1


