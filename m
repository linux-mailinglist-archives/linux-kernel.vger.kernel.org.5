Return-Path: <linux-kernel+bounces-100805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 835C2879D78
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6DE91C2134D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639581448CB;
	Tue, 12 Mar 2024 21:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="In86CNjl"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2126.outbound.protection.outlook.com [40.107.237.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1720144045;
	Tue, 12 Mar 2024 21:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710278813; cv=fail; b=pOTE/Og7gt0pPww7PPS+LzIH0qG89J/okF4eEUZGAcnNNm+4MIHsWDepQy1q7U5ObNuAqFWs1jFm4b8C9iWtxs/0u9e7Tv8l60gsrB77n/JX9BXpkqhum2L6Y2B/4/EzAQq8x3uOBkqmYVKUmCa9nDSdrakv9e1U0xoKgx4u1qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710278813; c=relaxed/simple;
	bh=7KYSwtYkAvVikuqxH1teDecaPR5iW4hU9jr/4zD6DX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S7oiMkbkg6Cb5oLKGVJ2+hbijAjg/fkHgt69Qg5mFTM4WENcdiMjVQF7pvo+KJIPGnrvirW/HU/16MR/uqbPesEkZBqfrqRAFwTaP1zDtWNtmtQO6zEyK9r9xR7uYopM2PvTZPH1sZ2Yq3Z3HIPTGIslvwKSkuc/JaCdmpk033Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=In86CNjl; arc=fail smtp.client-ip=40.107.237.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0D6weIAcsAeZ+2vP6kArIHv4O8sapaSifvMsoTtu3DJY/MkPK1QPCrpInl6lc4toIKkvN3UmYv+qc481721gCSZlzsgt5ylF7zzIoO+fM2yo5Lqfxfbdd0GiEZzlKimygoJm/22/BUQaMBowmT43JqsdQ7s/+CleO7kjm9VtcmJwUjTc9aitKO19RjtiZyxLM4E38MENC0dJiWgqxC5IpG5DTnDZRwQUerv1KIaYaHRd/LPBUIfBVksLZssrK0r2K2vdLcthZvYHqcq4+6LVi4OonEkjp5DP5Z+e398arb6RMILK3iEsIL4HX+Qh3E3tUQYVfn9GuXBvPAfeiCQHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntJir3IvZzlv8fon7XmkjeDV5WI86JcU7lrm7tlh8sg=;
 b=WTvd5Jr/Gee7IXk2e2oa+6DTPeH5MvxPNa2PCV+GFqafzaYiVfWBwJNRfPzN+jwoz8xruQnlDi0nZ/HTdob4Zj9/9gt+Ajtpm2bVHehPsChd/dy+RV/IteQPFA7czzXQvmG2hjrsabOXmiEYTc+7iOVu/F2xbNFvTRMwmMK9viw6qLP5eYwkpYEaSl6FFWx62ETNGKxz1YY/xugi0f/dZxhHlZG9mQJ5+Sz5MfJV6AqXp1sykRe+UaD+Fff8HCL3/9NmFWjeysLrf7LKz04ux5Fl9wqjczIzTlk/josC7gjtpzvXJeyr4DqiHtzKELMambKDuXdvOAfJfcv63wd0mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntJir3IvZzlv8fon7XmkjeDV5WI86JcU7lrm7tlh8sg=;
 b=In86CNjlbMSdB2hxIUjg/PhsadH2gVSSGLCfQMTVgRYFF2ZQo3BNWOGdlu/i75nwWbz1UKZkYgTjbFa9CBmOFIBqIMsUWXh3l4feXccawBSN4ns8oeOo7yFyS2QG3du4g/U+vb0wj2Eh6hCK/94BLVI/mFaVvdhlneBUWDX/TwA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 SJ2PR01MB8102.prod.exchangelabs.com (2603:10b6:a03:4fd::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.18; Tue, 12 Mar 2024 21:26:42 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::32c0:d77c:f00b:bacd]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::32c0:d77c:f00b:bacd%6]) with mapi id 15.20.7362.031; Tue, 12 Mar 2024
 21:26:42 +0000
From: Zaid Alali <zaidal@os.amperecomputing.com>
To: zaidal@os.amperecomputing.com,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	bp@alien8.de,
	robert.moore@intel.com,
	Avadhut.Naik@amd.com,
	xueshuai@linux.alibaba.com
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [RFC PATCH 5/5] ACPI: APEI: EINJ: Update the documentation for EINJv2 support
Date: Tue, 12 Mar 2024 14:26:26 -0700
Message-Id: <20240312212626.29007-6-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312212626.29007-1-zaidal@os.amperecomputing.com>
References: <20240312212626.29007-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0005.namprd16.prod.outlook.com (2603:10b6:907::18)
 To SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|SJ2PR01MB8102:EE_
X-MS-Office365-Filtering-Correlation-Id: f2fbbecb-f691-4cc5-42a0-08dc42db1cc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jf2bQP303LM5r4Ox5sOxh/r0oVT5kFkJ/hl1RobYyvkLDlqp+f6BT6qEu6MEFhLS73YdySuRsChC8++Ey1/kapK5/vGyU01BCbpwSmwvlHiNaEkJnbZF5jrhbiMUDBDuBfKk9XgAHAW8QqZSeNIZmHFQUzJ3AQq2mj7R6Jog2I0pKHJ+7xqLGUfhRU+3PMz2h7uNTmMHINHV1/VcKmE7yY7zT7hbfsPZx6o8GPxUSGVj/1+8046UIoVo/9OALe0DVrA5ZnUJQgaXHe79qH1ZdoH1fInJqlj5mJYCZn010QDAQoTGW1dgCFBJgI4eDnaPWEs8XerioNJRfKnonNPfJ5eLrFDgnd5hHu46pdP/4B/HaqGK/e2mWggIPr49tyMFeMUMkS4SdvgPUupMsCnuFOXZCQe1soNhRb9ZPMlnt8ulisZ1F4LnvGn92mHzg01GhZfX/qYTKdzi0AKqjHZY6rYI4GRTHDSyv6ur0QIsiOr35DojmcvVh/ugDMGJhy/IPDZuaOR09U/dqgD96IDWhok8kyeSADVpLaeqbGmPSLEAino8QMfM5dSzAQqiW/4umeAvpz34+l3iJsu5DHknpr8apkVbVMZh59W5V7rAaM3FiZHyOKkx7pCEYanZ5RcBS58dqsF6S+BjTFMhl39ih5cZrYf9Rb2QNRq8JHkN/x0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(52116005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6je0+VbKc2yg2FHemZ9K+p++/s7rAoL9V5zXxKXYbJNgeAt27c/PK4Zetn0T?=
 =?us-ascii?Q?rZEsCpmgE9PuXRKfzrQ/hw26hC2s9w3mWJEBye+pSIJs/VrLDSFwAMceDhVo?=
 =?us-ascii?Q?3f78UdcpQN9nfQDfig6NBRMlCVVGZCFKG7x4S/feCYqpo3t7BxGjoPUip2v2?=
 =?us-ascii?Q?faMnSSnOPqG7VCKpidUMDdKM1rsrYQy9S+6uDxT5icjlOkrmdVhiSVlj/qda?=
 =?us-ascii?Q?PPKY22uPEZZ9+s55DKcDYAn0MkF2auiv7nbNVd1WWvIIPGrG79kPmFsBkWKR?=
 =?us-ascii?Q?6f/xLp7/86Xb8BoGER1DzMJknSbK50YT252NNBfMDDiSpRCnqqhU6OGQDr6O?=
 =?us-ascii?Q?0h4V5UDxCjS60wGM46UqooOKYtvrDvjnSTMvhlIGBNAsaXfpg9vGzTcm1YKM?=
 =?us-ascii?Q?bUTJTVR2dMTS4DnSuv2udfBW9xqXO9SiQLJrJWXWJ0WFKgCOm3gqwa6aE/+M?=
 =?us-ascii?Q?ZEJ2FI+bGYGvoF2VaUZrUgUBoalhU9nyRHgpkkZ/hZq2of16YM4tmptuVBlb?=
 =?us-ascii?Q?abadYky1uNaXXe3/CTswhnrChNNZaWgolHbRbGXuwe+uRbjwJJEfDi5jhgTg?=
 =?us-ascii?Q?K9bmEIyieoejZl4hknPZdkz9h2PO4oQ3RxptR2oNVLhQRi5TvODRrpey0KJe?=
 =?us-ascii?Q?BEXiBB6NmO0L6hCwh4m6FzhZxkHIF9kPTatbqvdGhcS/sQaQdH9E1yXVmA6c?=
 =?us-ascii?Q?vkeYDgx7Od1M1prmFL4kBHcxsWX33gzPz07hPfyxU/7/aMm1YdtYhiyS0Gv+?=
 =?us-ascii?Q?XTNqrJkVm5tnpGvfdAucrsJj50zMo3QnjGgEWRTLZXkKBbVlrih4I4bdJmGb?=
 =?us-ascii?Q?H+cEmtZZ5ZEpnGLa5PoYZ9kUub/rAaPfJLce6+SLMagMOhEeGtJ09DZZUHBt?=
 =?us-ascii?Q?EeFARKYB8c8Dl5sOK6RlOpkoF03lkb3MTCRtMRofOQzw3Zxe+6SRJlErQO83?=
 =?us-ascii?Q?CUsf3Rh8Ddv/t0BE2jMdRHVVSRGPkmqRZQA7xqN8e6jJZNy7z0B9RcNX3WSt?=
 =?us-ascii?Q?vT0jawg/PzQ7D2Pm0k45NSXF66XAJa2gfB2HYAwLVaruD22P8u/wow2LWRrH?=
 =?us-ascii?Q?FSXDnU15R6yi98sIemIAaI/MahHtP42xlnVA/cPrfZxIPucQbGM/1Xn8bnFw?=
 =?us-ascii?Q?w48nIM9HHnEr/BQCqZuHk+HHhM74xcA/4I5gqnDgbAzvYAx8MTiMgMzGVRqF?=
 =?us-ascii?Q?s/7lR7j4mmxR7aMLLeJeTFtSTTBdGJopDShIS8LnQ5DwFeIdjcDjjL1iEUga?=
 =?us-ascii?Q?cDJBBpR61Ha6DMPDbMejEs6epDswi5Eo5LIZ9pfLkFn2G5jw9yrFH/I/Cd36?=
 =?us-ascii?Q?ibT+RU+2SI3vMdLZXmEhtvHqVLZKmKUnhTzgp5uoA29R0qVa/uhs+u70C9QN?=
 =?us-ascii?Q?iIMdiyOYsPWCJrehvlty7LtrHvvps79EIk1r6B43YTud61zRc1MOLgNkgqV8?=
 =?us-ascii?Q?vH2kq/VTnWiv9mZwMmFiZoNIJANA0yikBmar6lDlGnDXzMx2VF0miQba8i1v?=
 =?us-ascii?Q?tXmIGa1+hJkoJR3tlCAEHd1yGcnn+u/8415O5JNP1JcfDri4IKBzVo273nMo?=
 =?us-ascii?Q?1/qVmmDjhUPYnRp9meloXd/F+git09B+OMFklric8EBFpYoP90AnUq9Z+eTV?=
 =?us-ascii?Q?SUt7Rl5ahRrks6JJ+H3vasE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2fbbecb-f691-4cc5-42a0-08dc42db1cc3
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 21:26:42.8632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OyowBWpH9EMJmnDwGD1JYn+aJpHy1EPTpXhEaplLV115CdAzgm3x0d43vg4xoHdp/tGWvPoQXwion9QhmwcLHJsNEFYM1ie+EaUjWKFUDv4f8nEiJ8SRscMfApC84FZB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8102

Add documentation for the proposed ACPI specs for EINJv2(1)(2)

(1)https://bugzilla.tianocore.org/show_bug.cgi?id=4615
(2)https://bugzilla.tianocore.org/attachment.cgi?id=1446

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 .../firmware-guide/acpi/apei/einj.rst         | 44 ++++++++++++++++++-
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentation/firmware-guide/acpi/apei/einj.rst
index d6b61d22f525..7e5c3f71ccd1 100644
--- a/Documentation/firmware-guide/acpi/apei/einj.rst
+++ b/Documentation/firmware-guide/acpi/apei/einj.rst
@@ -57,8 +57,18 @@ The following files belong to it:
   0x00000800        Platform Uncorrectable fatal
   ================  ===================================
 
+  ================  ===================================
+  Error Type Value      Error Description
+  ================  ===================================
+  0x00000001        EINJV2 Processor Error
+  0x00000002        EINJV2 Memory Error
+  0x00000004        EINJV2 PCI Express Error
+  ================  ===================================
+
   The format of the file contents are as above, except present are only
-  the available error types.
+  the available error types. The available Error types are discovered by
+  calling GET_ERROR_TYPE command, and if bit 30 is set in the returned
+  value, then EINJv2 is supported by the system.
 
 - error_type
 
@@ -81,9 +91,11 @@ The following files belong to it:
     Bit 0
       Processor APIC field valid (see param3 below).
     Bit 1
-      Memory address and mask valid (param1 and param2).
+      Memory address and range valid (param1 and param2).
     Bit 2
       PCIe (seg,bus,dev,fn) valid (see param4 below).
+    Bit 3
+      EINJv2 extension structure is valid
 
   If set to zero, legacy behavior is mimicked where the type of
   injection specifies just one bit set, and param1 is multiplexed.
@@ -118,6 +130,17 @@ The following files belong to it:
   this actually works depends on what operations the BIOS actually
   includes in the trigger phase.
 
+- einjv2_component_count
+
+  The value from this file is used to set the "Component Array Count"
+  field of EINJv2 Extension Structure.
+
+- einjv2_component_array
+  The contents of this file are used to set the "Component Array" field
+  of the EINJv2 Extension Structure. The expected format is hex values
+  for component id and syndrom seperated by space, and multiple
+  components are seperated by new line.
+
 BIOS versions based on the ACPI 4.0 specification have limited options
 in controlling where the errors are injected. Your BIOS may support an
 extension (enabled with the param_extension=1 module parameter, or boot
@@ -172,6 +195,23 @@ An error injection example::
   # echo 0x8 > error_type			# Choose correctable memory error
   # echo 1 > error_inject			# Inject now
 
+An EINJv2 error injection example::
+
+  # cd /sys/kernel/debug/apei/einj
+  # cat available_error_type            # See which errors can be injected
+  0x00000002    Processor Uncorrectable non-fatal
+  0x00000008    Memory Correctable
+  0x00000010    Memory Uncorrectable non-fatal
+  ==================
+  0x00000001        EINJV2 Processor Error
+  0x00000002        EINJV2 Memory Error
+
+  # echo 0x12345000 > param1            # Set memory address for injection
+  # echo 0xfffffffffffff000 > param2            # Range - anywhere in this page
+  # echo 0x2 > error_type                       # Choose EINJv2 memory error
+  # echo 0x8 > flags				# set flags to indicate EINJv2
+  # echo 1 > error_inject                       # Inject now
+
 You should see something like this in dmesg::
 
   [22715.830801] EDAC sbridge MC3: HANDLING MCE MEMORY ERROR
-- 
2.34.1


