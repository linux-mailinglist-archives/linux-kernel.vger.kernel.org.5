Return-Path: <linux-kernel+bounces-3077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 260C48166FF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 430E11C20B1D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4FF79E1;
	Mon, 18 Dec 2023 07:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iM9FpNvz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6398579EB;
	Mon, 18 Dec 2023 07:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702883098; x=1734419098;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4lkMmnt6A3bZNifKCcp0MWCE+trhlyI6xx3j5IRsbvY=;
  b=iM9FpNvzsHf5Q9wLDWbveEtfI+6sRXenXACXUFFd+RjaXrfGCzM10qIr
   5ef4ZEvfINRAfOktwphX9LtS+K+JKE3RitUXRPD3bcxjXSehji0wD4a1m
   S7Nru9adhBKmIfw3BPF9Eq5NDg0x+3j62N0Oi1GjdpJMrfErQ0s9WgSNO
   nr5D7rdKugYwFvslEkZyrhKCwr1ZmuHoyf9EKPXrTr3YOpndcctNLfPsu
   LxxJN67aAH25rwtt1UWt0otmbEF8uUOLey2TAbr7NJxfH+wPtbZK2tVHh
   2Kn6T7dQkgbscP7FFXDI6t7ZmiAMgyZCryXsTVd+yDgiThztAR3/gQkmG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="375619037"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="375619037"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 23:04:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="778984771"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="778984771"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Dec 2023 23:04:57 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 17 Dec 2023 23:04:56 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 17 Dec 2023 23:04:56 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 17 Dec 2023 23:04:56 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 17 Dec 2023 23:04:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TX0BqftYU6LuL9cSw+cnoAsmWtU4GelLgqDOI6tbF6YuqfayixmaLPW5i/Q0xLfYN083e8hNxm6qWJgY2AAp0sgzdAWuKrkQNFprwnwDRhVv+h6uKqIAG6VTzh9zmk3rqbkli0m6o67FJq+qIjRDK1wGNyoBpy2wWNjyz3WcBDDZjSDd3Hq3JDlmiLMhkpZGRoMNdVDzHeC+wpQKlnU8pVXqfvyWwvZATHLI6M37J9gUZL44ebuKq1Ee9YYKntZ67YwIM1z+PTs51xEKtuf2C4DZBDFYm0bLak0+cY5i6fUYuW/4GPAAODTENjyLMRrxQz2Kq4iM3H4XG/On+B+Ybw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eeJU3eOkaC93NKpFpiiv2gkb/+MtQxTf+1UaBdcmMg=;
 b=a4qRBnfSS25EI5ZmKTqih+XNJzG9rNNdZ/HmiiH/eg5Wk5tyyAfkui/2l4R+0s7ooVZjh98+QWrGxGeOlELBPCPABu3uQZZo/V1uzLPUvOF/39jqyl1/+MUF0DAH3u2uiwjAyyTej6b2hhhBo+/LWNwawzLUaMTGB4gpMV27g2IPksG+pzeRCoHzllMO9pW+UTpim0Bo1NaVyKBnEApFUHfPCsbAPPsvPXd+r8diG2L/Aagp9CEUR3zfKj/gGz5sl8Wg3DWBEAtHBELnsKJfd0NTXC21g8nG8Qzxb4pVwKeM1dfzh1gcQDTf5rhwZ9v6apWNpVH1XVfecrZQkAoqyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB8256.namprd11.prod.outlook.com (2603:10b6:806:253::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 07:04:54 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 07:04:54 +0000
Date: Mon, 18 Dec 2023 15:04:46 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [mhiramat:topic/fprobe-on-fgraph] [function_graph] b92a5e78c3:
 WARNING:at_kernel/trace/trace.c:#run_tracer_selftest
Message-ID: <202312181100.508f8f48-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0021.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: d2196f7c-5c8a-414d-e0c4-08dbff97a2b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 40vQMVZ5n+OalUnoWNdaWFLyGxRPnKsN9xxyjEv9zv5+kX7dFUI0wg2gicg7hzO8sAm1SVvHmflsy9HTvNszQ0UfcUB4EQhNxIywegKEgtvIwyl/a/7sbgPHJLRNbo5j2UYDm5nBr7l45pHgHAz/g/2AL0ehVSKlI9Tl6ZnWjlO8tjQh9cfhdb7NKTQ/xGcgDpGhYY9H0BEg7VN/jbr/Ulp0AcUVoim5D3MMjQHXfT2EybF57w+c168Mbdk61xlQGSHrrGknhtf4g0iHxrk+MmAsMJ+TiefAo6xSnuJaEHevzOTN3AfbdW+gaEY8rh7KWbt4DmmcZUJa9s1yZNvBCUG/9ifhGnrOTTcHhtWEn7B1uj1sbD6hECS3tmjrDzThGZNWDnBsGjkgvvrv6bNPqkOM8kZ/OwgV5Czm27rT2ezOYM+Lczmj6bbORSnwTBFin5E6P6WNL/kxOROoMEMwabNMM7AzKbpwcSszrSdEdutuIz0qBvP6jLJVnoA+SS2aF9r5cqXkAvaHTkbIWP6blrUNY3W8JvjRMNnHigRSY235S16qz6qysmKwv3d9wyKWCWI/yePZGTLvRN0xvDv58FXwMNDZqQm9iAtAJUp2oUQE004wPQo6bWrrILfSDO/nOtAzBdRKCGY96zO4NUbzlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(230922051799003)(230273577357003)(230173577357003)(64100799003)(186009)(451199024)(1800799012)(107886003)(1076003)(26005)(2616005)(82960400001)(38100700002)(36756003)(86362001)(83380400001)(5660300002)(45080400002)(6512007)(6506007)(6666004)(8676002)(4326008)(8936002)(66946007)(66556008)(6486002)(316002)(6916009)(66476007)(2906002)(41300700001)(478600001)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k9jKyrIf5rT7rve879yss7SilwCLJ1E+6AWRttlnPlaYk+vdjBYDaxvrF9Lt?=
 =?us-ascii?Q?QTK/Q4q23PV3eECeDKz8DPdl6Z63D88oGN5BHJPKJWXXDGitph1JSo5rl7Ng?=
 =?us-ascii?Q?MwB+SrcYdF81IWjy1EeeNH/qJxWuuGXZq/4VVei5Ul5/XXrXvtiNWGj7Q+1m?=
 =?us-ascii?Q?K6yeYGsCvdih+qgbyB5bS1fxUKHdFVWTA4pLLZtqObRGImeJ2MLCjX3QHMTp?=
 =?us-ascii?Q?TvySK29AGwqpoC9RWxnho7wADvjIox6JT7PfhSUDeV1qmMYKdEDRRXkGwdE5?=
 =?us-ascii?Q?47nAGxp5MgFUyD8US/XJCJ5WRsigg5p3cNgDk5db0znNuK7LmQ7twRlX9eWS?=
 =?us-ascii?Q?+Bl7Swrwfx3qrTECT2aOk1XJP6AE9xWNSVssuPHtXR9nc5U9Pe8UitHqBFhH?=
 =?us-ascii?Q?RQ8ngCuPV5N9SMpT4J52FYW0YBUHXcIN8FYTkVmcjRXAz5jeDOVF3QmbaM0i?=
 =?us-ascii?Q?6fXnovmDNOdqrRI1q/8QFPNVZyIh54OBz280rf0DI2batzEiE2ugNfck5z1f?=
 =?us-ascii?Q?ma3xNodxTRzyEcIaJNI++QyjpVHb9EbiUzUQ5QkN6xW6jZu1K+WXc7rq5pS3?=
 =?us-ascii?Q?ZikMcufu19qK//+/WBY+pIatMuY9H8YafNBq2X2JG7RCv9CzQHOTnYw5Cw2B?=
 =?us-ascii?Q?dUdoCB0bc4aXlmFfTcYKwgIvnYSb14uVMQNil5Nbj0mlqw/nij5r9kQEeHZ8?=
 =?us-ascii?Q?g44HgHeOb0GEhfAKcWUwd6HF+/MO/8li0A+gwZevgS+chjNx/TsbScyrW4M7?=
 =?us-ascii?Q?Ugx8xaFFMcWDGD/QYITjORZ1d2X1b4+N0x9/Hj4/muCqGlV55E/Z24HyMKfE?=
 =?us-ascii?Q?c2nRzEv2FrjKaSMz5L9b9fwp6v1yLOMa8UjiFB7Bo92qam0yxbk+RI4iIl0T?=
 =?us-ascii?Q?NOojvR9Dx3VwZmarWCR9gzJcxynkD4ihnJ5kqCmn5uO6QCRRbmTIT9xAOOo/?=
 =?us-ascii?Q?2tOA8x5JGDV1Ze+54l5luFB8h20Lz1ATVyh0ik6cVFK4OVNZEYkrLeEbuDlo?=
 =?us-ascii?Q?YIJXoYzPIV9VvuHEZsp4jYzmYYYFOZAd4yK7zL9T22KKT6rDQHErF5j25pxJ?=
 =?us-ascii?Q?JCleVUtxTy71p2CCxHPBhvruXHm0HRLvD6GMrFRtYQJu5QlE2RYGQitcPfih?=
 =?us-ascii?Q?1ESxFyPChnnWWE0ZEUojUNiN05kyUmFNOgRWYcpaizqerfEcZuwSp7UEZms4?=
 =?us-ascii?Q?jQKG99BtHY4urjMm4nuHT4pH6Ktbw1UAP6sZ2XVzGFfPpkgavfwiPLGrfS+3?=
 =?us-ascii?Q?WpFfk3Q+yQz2Fx6DBbUWFDxuKC9XFNdechf7ytwESNoAwjA2kDRZ5OVj92e0?=
 =?us-ascii?Q?fwms1YK9fv9pxYNZD4SipBfCQaWnwse+YCXPybIvU08lYqYYvzyC507N+I36?=
 =?us-ascii?Q?1Fa4Gowb69D3bNz8IDqQ/jrx09HDS9RZXCZTZO7jBhoAvhMfAxwzOgQB+Esd?=
 =?us-ascii?Q?7C1ZmXA2Ct4kjF3pgdwrZH1WheFt9efZbMsE0MptGXsPMH+ZALky4loBfmHO?=
 =?us-ascii?Q?NHWEaSDUG8/kcJq2c2Ep/c55FdGyQx1tb0jPBCP89anGwFeDqGB9Zvb9k//6?=
 =?us-ascii?Q?6oIsmDn2nCJ+VfbfOrOaXvPmEFJwOEMXCgvIRgi9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d2196f7c-5c8a-414d-e0c4-08dbff97a2b4
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 07:04:53.9437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 36ruuoCpzHTpn43crHh51btqd/9ejpY/5X4TBmwWStPwXrew/3nF6oQvD8K5QGnPzU4bzfSbzoN8jXdEK9yOBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8256
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_kernel/trace/trace.c:#run_tracer_selftest" on:

commit: b92a5e78c35fde3c1be7263b39724388482a4bd9 ("function_graph: Add a new entry handler with parent_ip and ftrace_regs")
https://git.kernel.org/cgit/linux/kernel/git/mhiramat/linux.git topic/fprobe-on-fgraph

in testcase: trinity
version: trinity-i386-abe9de86-1_20230429
with following parameters:

	runtime: 600s

test-description: Trinity is a linux system call fuzz tester.
test-url: http://codemonkey.org.uk/projects/trinity/


compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+----------------------------------------------------------------------------------+------------+------------+
|                                                                                  | 26fcffc6d7 | b92a5e78c3 |
+----------------------------------------------------------------------------------+------------+------------+
| WARNING:at_kernel/trace/trace.c:#run_tracer_selftest                             | 0          | 8          |
| EIP:run_tracer_selftest                                                          | 0          | 8          |
+----------------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202312181100.508f8f48-oliver.sang@intel.com


[    5.502226][    T1] ------------[ cut here ]------------
[ 5.502226][ T1] WARNING: CPU: 1 PID: 1 at kernel/trace/trace.c:2031 run_tracer_selftest (kernel/trace/trace.c:2031 (discriminator 1)) 
[    5.502899][    T1] Modules linked in:
[    5.503348][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.7.0-rc2-00034-gb92a5e78c35f #1
[    5.504358][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 5.505125][ T1] EIP: run_tracer_selftest (kernel/trace/trace.c:2031 (discriminator 1)) 
[ 5.505764][ T1] Code: ff ff a3 18 30 4b c2 89 f8 89 15 1c 30 4b c2 e8 cb b1 ff ff 89 f8 e8 58 52 ff ff e9 c1 fe ff ff 68 50 d6 f9 c1 e8 2d 61 f7 ff <0f> 0b b8 ff ff ff ff 5a e9 22 ff ff ff b8 f4 ff ff ff e9 18 ff ff
All code
========
   0:	ff                   	(bad)
   1:	ff a3 18 30 4b c2    	jmp    *-0x3db4cfe8(%rbx)
   7:	89 f8                	mov    %edi,%eax
   9:	89 15 1c 30 4b c2    	mov    %edx,-0x3db4cfe4(%rip)        # 0xffffffffc24b302b
   f:	e8 cb b1 ff ff       	call   0xffffffffffffb1df
  14:	89 f8                	mov    %edi,%eax
  16:	e8 58 52 ff ff       	call   0xffffffffffff5273
  1b:	e9 c1 fe ff ff       	jmp    0xfffffffffffffee1
  20:	68 50 d6 f9 c1       	push   $0xffffffffc1f9d650
  25:	e8 2d 61 f7 ff       	call   0xfffffffffff76157
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  31:	5a                   	pop    %rdx
  32:	e9 22 ff ff ff       	jmp    0xffffffffffffff59
  37:	b8 f4 ff ff ff       	mov    $0xfffffff4,%eax
  3c:	e9                   	.byte 0xe9
  3d:	18 ff                	sbb    %bh,%bh
  3f:	ff                   	.byte 0xff

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   7:	5a                   	pop    %rdx
   8:	e9 22 ff ff ff       	jmp    0xffffffffffffff2f
   d:	b8 f4 ff ff ff       	mov    $0xfffffff4,%eax
  12:	e9                   	.byte 0xe9
  13:	18 ff                	sbb    %bh,%bh
  15:	ff                   	.byte 0xff
[    5.508031][    T1] EAX: 00000007 EBX: c1f9fa5b ECX: 00000000 EDX: 00000000
[    5.508856][    T1] ESI: c25e18e0 EDI: c0109500 EBP: c031bed4 ESP: c031bec4
[    5.513135][    T1] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010286
[    5.514023][    T1] CR0: 80050033 CR2: 00000000 CR3: 02763000 CR4: 000406d0
[    5.514855][    T1] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    5.515688][    T1] DR6: fffe0ff0 DR7: 00000400
[    5.516235][    T1] Call Trace:
[ 5.516632][ T1] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
[ 5.517125][ T1] ? run_tracer_selftest (kernel/trace/trace.c:2031 (discriminator 1)) 
[ 5.517722][ T1] ? __warn (kernel/panic.c:677) 
[ 5.518185][ T1] ? run_tracer_selftest (kernel/trace/trace.c:2031 (discriminator 1)) 
[ 5.518797][ T1] ? report_bug (lib/bug.c:201 lib/bug.c:219) 
[ 5.519323][ T1] ? exc_overflow (arch/x86/kernel/traps.c:250) 
[ 5.519844][ T1] ? handle_bug (arch/x86/kernel/traps.c:216) 
[ 5.520351][ T1] ? exc_invalid_op (arch/x86/kernel/traps.c:258 (discriminator 1)) 
[ 5.521153][ T1] ? handle_exception (arch/x86/entry/entry_32.S:1049) 
[ 5.521153][ T1] ? exc_overflow (arch/x86/kernel/traps.c:250) 
[ 5.521642][ T1] ? run_tracer_selftest (kernel/trace/trace.c:2031 (discriminator 1)) 
[ 5.522253][ T1] ? exc_overflow (arch/x86/kernel/traps.c:250) 
[ 5.522776][ T1] ? run_tracer_selftest (kernel/trace/trace.c:2031 (discriminator 1)) 
[ 5.523386][ T1] register_tracer (kernel/trace/trace.c:2065 kernel/trace/trace.c:2188) 
[ 5.523932][ T1] ? init_graph_tracefs (kernel/trace/trace_functions_graph.c:1448) 
[ 5.525126][ T1] init_graph_trace (kernel/trace/trace_functions_graph.c:1462) 
[ 5.525126][ T1] do_one_initcall (init/main.c:1236) 
[ 5.525132][ T1] do_initcalls (init/main.c:1297 init/main.c:1314) 
[ 5.525660][ T1] kernel_init_freeable (init/main.c:1553) 
[ 5.526271][ T1] ? rest_init (init/main.c:1433) 
[ 5.526789][ T1] kernel_init (init/main.c:1443) 
[ 5.527291][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 5.527828][ T1] ? rest_init (init/main.c:1433) 
[ 5.529154][ T1] ret_from_fork_asm (arch/x86/entry/entry_32.S:741) 
[ 5.529154][ T1] entry_INT80_32 (arch/x86/entry/entry_32.S:947) 
[    5.529154][    T1] irq event stamp: 2126727
[ 5.529642][ T1] hardirqs last enabled at (2126735): console_unlock (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 kernel/printk/printk.c:341 kernel/printk/printk.c:2706 kernel/printk/printk.c:3038) 
[ 5.530695][ T1] hardirqs last disabled at (2126742): console_unlock (kernel/printk/printk.c:339 kernel/printk/printk.c:2706 kernel/printk/printk.c:3038) 
[ 5.533126][ T1] softirqs last enabled at (2126476): __do_softirq (arch/x86/include/asm/preempt.h:27 kernel/softirq.c:400 kernel/softirq.c:582) 
[ 5.533126][ T1] softirqs last disabled at (2126471): do_softirq_own_stack (arch/x86/kernel/irq_32.c:57 arch/x86/kernel/irq_32.c:147) 
[    5.533126][    T1] ---[ end trace 0000000000000000 ]---
[    5.534553][    T1] prandom: seed boundary self test passed
[    5.537152][    T1] prandom: 100 self tests passed
[    5.537152][    T1] pinctrl core: initialized pinctrl subsystem



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231218/202312181100.508f8f48-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


