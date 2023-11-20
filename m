Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E897F1735
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbjKTPYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbjKTPYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:24:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B08CF;
        Mon, 20 Nov 2023 07:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700493835; x=1732029835;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=MwiAbgT2DU0ofkf/JZbq/aA93fzsexBlelF1aIRMRvA=;
  b=Y7mpe7ioox8PETQCjaJ4rVvEwPFDIvKjUfO18X1q1GuCVy8HIPAwUIKw
   sgnrWU7gqEDQv/nCENJfndK+afxQ0LBDkwegEw0AjfD2eWkJluBSMDoDk
   LcgUd1I44LyNPmmjkOh51hRKJyxGs4O/odX5DG9T0/dc4rJuci68MUj2z
   +wxAwZoH0u1dsA4LkXB8lDQI6fRqLGM6vYbiAFDHKQHGuWvXMbEeXu5Ct
   yiSFVE+YUmIulj4CSuesuKCUU7KiO+sSOQUE6OTadcEs+nsVfP6skj8yI
   OgBTWnRU+n514gi/4Q6qBPFvR0QmoEAzgJWiWRCLQlxp0rRXsunCaOJyG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="395565379"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="395565379"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 07:23:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="883889035"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="883889035"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 07:23:54 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 07:23:54 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 07:23:54 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 07:23:54 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 07:23:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggGABM6ygc2w0DduLpxxkXk7qFwPp+ree5LRVTzgeRbMjRr4o9MqYSXrDEm/OoPuds9MKcIoMwq9AW5+1oLFNklDZID83OwP7hyJM/oVA4+GW4NvZQZwoBcN/+rlLwMpmhKoi3ByqjtL6aory1xw1CFmv8ceU4ZRwVY/WoshtZKIirLpeSW9Dk7UvuwIsofEnGMzXLLcj4qJvKPPFjUgxQ6tMcQhmnwu1KVM5t14XH/htjPJxKx+uZe44EkQS10AWfFGM3L/iv3epVeCek0lgh2vBDQJqWFceMTBAjMs2NA7e3NoQaXI4mnor57sFy3sxf7ivqobK7jUhgy2Tq9aUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0t+PVWG959FdyxpoMBXlC538D2v/BAic3LTHUxS/74=;
 b=IT43MmUQWKm7P5I2kQfSgxOp+YxW09Tjt8bc7Wn//elw36X+xdIB2rIwCW8MxsscsOIeFU3VYCh77K1+ix/c2RIRvUsS4AwZRnkGEk/Tgc+qzP0Y1efHbmQstsgmbXCqZ91GFc5cZq+knsDA0FLjnARdFLdzXND4WcSwanwqNhEIOA/2mqJMRlPCebucr8KIVrqIrhT7ILQSbHGeoVWwlTxsFYp+qWkbVxFZGYOBu2zOMHifFpus0BXRzC/krmbTPEc3U5wcXWMUXyomaJI79jMjS7cVGs2jR9/91EYuS3KTgKsfFLKOKrMwja0T3jqoVTBqon7jI1f94i6NNcE9SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW3PR11MB4572.namprd11.prod.outlook.com (2603:10b6:303:5e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 15:23:51 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 15:23:51 +0000
Date:   Mon, 20 Nov 2023 23:23:41 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Valentin Schneider <vschneid@redhat.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <dccp@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-rt-users@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tomas Glozar <tglozar@redhat.com>,
        "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, <oliver.sang@intel.com>
Subject: Re: [PATCH v2 2/2] tcp/dcpp: Don't disable bh around timewait_sock
 initialization
Message-ID: <202311202323.8c66ae1c-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231115210509.481514-3-vschneid@redhat.com>
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW3PR11MB4572:EE_
X-MS-Office365-Filtering-Correlation-Id: 148e3056-8e67-4cae-2716-08dbe9dcb35c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gH2OpuZj3jYjwi2cJOpIW1o6vY+M21qLEpeqt9iYeSAJDeDq2CowOWoPH4vurF+gIFktOeEIdMncov+S6RPrcsVloGqT3t5mlCsqjpCvIpGSRpXD0pH33zdrUBl1a5vE3QBXZkzKxtSQSFnZHvnxkDAGa+3YCcY4vRKADap5deRLfESvUVbZq/957xbgXBrS9OZ29bC34rXFc7CyB5U1xg6mphV0hutZCrKBL6X/2z6cwD6FzJCKJGEJ7ClB/yDWK1hZ1tjX1G2NTE86cU7bmqr/PAsKCC9nXggSCJM0gDkydZF6aCmfao91FiWoK+jlbojHXPnok8CNbHL2XlgQnAgrWb4GZQ4tIv2Y2csuPWmBYvI/cgrGQuExzNrGsP8i6PDITwrfMQKYuFufyHx4h2Wxq2afoMUmHiXTH/D7ndU6XdJJl1yCJUT/bpv4JjYdHwRD77cBtqU3WLY2nmav/WQVyLDdPYeMJ8ncmMFyHFBRB8xr1m/moeIOtxOJFj6nVRqj0J42DRpRfUr0wqdFf/Mblhgy/6Jh5EDIE7YV54LBaj0zepAmgWVf5Wx0y7yv5KAJDnTvgUw+lBLB0/B98AYKJnkm58Y4bMUK8YZS6S1Jh/ksrXO9DhSY0G9gzljMtJ/jCfAvbDhM4SgUfkQKBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(39860400002)(346002)(230922051799003)(230173577357003)(230273577357003)(1800799012)(64100799003)(186009)(451199024)(5660300002)(7416002)(8936002)(4326008)(8676002)(30864003)(2906002)(41300700001)(316002)(6916009)(54906003)(66946007)(66476007)(66556008)(86362001)(478600001)(6486002)(1076003)(26005)(966005)(107886003)(36756003)(6512007)(6506007)(2616005)(6666004)(83380400001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QhmepNqNDOfLnc1IOUSDnPZseK+RnshSdpOYRe0ilQHD2iBG0aJrnkDPCvmA?=
 =?us-ascii?Q?/cUeLkLxRZ/3W+mom3T/wb+bW8jIE4/hZbDXWfoJgeaTyQUjlI6dTamlIix1?=
 =?us-ascii?Q?1ydycapMJPZhxmyCqty+1pOeuQ4DglcDVZpUqVxTqN5Y7h7PGYQ9hpAXNp9h?=
 =?us-ascii?Q?cerqSOI2Ec5JR0d10e1mD4k1fUgVlh+7fdPr5YI1ML/IMLt9NZO3yUhg/8tr?=
 =?us-ascii?Q?/QXbqzyUcU69XK21A9WoYUvREgVIg3jA5YOfZXhgroaXrP8ZlvwYULm89ioM?=
 =?us-ascii?Q?eZaZVXK4JTp/ahD+GIZKkSgo5qFd0Iz7BtPwRNnN0TNOXlK6zBpTjSBEgGd3?=
 =?us-ascii?Q?LeZ5SU9C+zRW6rBeDu5937nC3CdCUcFO67WT3cvecigUG/WB1Xf4Lsis41ul?=
 =?us-ascii?Q?HCWAQ70biKoPEZLYUAL6TyJrOghhO7ZSJGR2Tq8rTuNFakqvyXga8ByOPB+i?=
 =?us-ascii?Q?WAChfI5VszQN0www+bhP2bnr2hbFDe9oGA0eJevssf6NU6+4cdui263iDPJQ?=
 =?us-ascii?Q?2LJ76MQAbcJmkffFXlbaTIg/XXP7xBI5PNcaUcz9fOxvxEICwdoDwbzYgKiQ?=
 =?us-ascii?Q?O23aiq6HXQ3Ysl+8rUFBQYJAghU/vFnPyeun0eHlo1o8FpXUrKd0BQxBpJUY?=
 =?us-ascii?Q?ZpYcHmStPmWBsC7RUKiYbCmN8YqK2scJ2y8+Q+3Hy/SNtuwI95SwIFN5EByD?=
 =?us-ascii?Q?sT6z0NHEZpcRyxj6Oi/fH3ym4bOe0lrzf45N8uPx9UUO1UWppG0PSUn33kp2?=
 =?us-ascii?Q?5A1M63k7DdnpXNAUBI9kWD4AKa/+ocdoYG4+cSklMDc0B7xB3JIzqrzX2cZv?=
 =?us-ascii?Q?iJEZfc6vBMv2WIltzcMYCAcFrS9Ob04fDJZ/FP03dBMwehiIdizfpmxLTrgQ?=
 =?us-ascii?Q?RVfDe6K7HEdaM5cbXJ7a6rfBGr5CNDyeYlSASm1u2jukeu2jAWhdQicusN7S?=
 =?us-ascii?Q?lVjXzPKazWySmIAvtMc9p1mFLLsMtkhwV5em6KOxjitNEAtj7mKFxtav7FS1?=
 =?us-ascii?Q?R9KSslyJjg/EGZj3X4f9JkCvjOhS3wmK2oHjQSMCNnFSZqG/InE0NUHKxxkL?=
 =?us-ascii?Q?5ceZlq+PGT5RFXXq6EThOX3/KN5IJ87cPnKxzf9aWQYw47I9N5wx1DCL0t83?=
 =?us-ascii?Q?PwFp4ppa8lrvDl22k15TVvAE+XACUc2n3xEWIPEtk09wYlboh1RWA9/ag7W5?=
 =?us-ascii?Q?FbjUZfDtuaZNIHeYEQmERjSMXlAfWeonT12vUSqbvSKDpxzX+lu0Petv0Bd2?=
 =?us-ascii?Q?BiGk2c+THss4bt0JD8ps4Y0RqlZLjP42nJwIplZcIXSjmrQruhvAYh6XK73B?=
 =?us-ascii?Q?xIdaRzLEFY6sI9Np7dQGo8gOxkyA/57+EeTWzKMcmJSrmwt6O758XXlGhSRJ?=
 =?us-ascii?Q?MzR2lh68JPhtvFB2M7EFbVS0jSO5ZnEqPb+VJO5NDq8ZH9aLg6tbimJzpMqk?=
 =?us-ascii?Q?pDw/SY/1j5jW80FYAJm2X9l4fLwHvSHLEu/4w//HsWGreG+yv0W8mt7AKJnZ?=
 =?us-ascii?Q?N58sRZSTTDpm2+B0LId0TCYfdqBBsBEY9uBzHfQd+FrxKijwmnqcY1dJ5gvO?=
 =?us-ascii?Q?OC29kIqVtUjjdMxFyyZ+XbnX9Tu3hH4Ce+zkrxMnOnAGDXuqWzZ2VAFhMAYo?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 148e3056-8e67-4cae-2716-08dbe9dcb35c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 15:23:51.7525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MlpemCSiMzdwMGd2XV5Ei95Uvw6CxVMWPH9KX7uVS6HkaPAfPXcgIDBmkstJaxPDZcVfTYKxHAPezeXixpPfDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4572
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "WARNING:inconsistent_lock_state" on:

commit: 0258784e371906dfa1419556dcb7905333039f34 ("[PATCH v2 2/2] tcp/dcpp: Don't disable bh around timewait_sock initialization")
url: https://github.com/intel-lab-lkp/linux/commits/Valentin-Schneider/tcp-dcpp-Un-pin-tw_timer/20231116-053100
base: https://git.kernel.org/cgit/linux/kernel/git/davem/net.git 674e318089468ece99aef4796eaef7add57f36b2
patch link: https://lore.kernel.org/all/20231115210509.481514-3-vschneid@redhat.com/
patch subject: [PATCH v2 2/2] tcp/dcpp: Don't disable bh around timewait_sock initialization

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202311202323.8c66ae1c-oliver.sang@intel.com



[   53.969777][    C0]
[   53.970087][    C0] ================================
[   53.970532][    C0] WARNING: inconsistent lock state
[   53.970976][    C0] 6.6.0-15915-g0258784e3719 #1 Tainted: G        W        N
[   53.971566][    C0] --------------------------------
[   53.972004][    C0] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
[   53.972562][    C0] kallsyms_test/97 [HC0[0]:SC1[1]:HE1:SE0] takes:
[ 53.973095][ C0] ffffc90000281348 (&tcp_hashinfo.bhash[i].lock){+.?.}-{2:2}, at: inet_twsk_hashdance (include/linux/spinlock.h:351 net/ipv4/inet_timewait_sock.c:132) 
[   53.973952][    C0] {SOFTIRQ-ON-W} state was registered at:
[ 53.974434][ C0] __lock_acquire (kernel/locking/lockdep.c:5090) 
[ 53.974857][ C0] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5755 kernel/locking/lockdep.c:5718) 
[ 53.975264][ C0] _raw_spin_lock (include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 53.975673][ C0] inet_twsk_hashdance (include/linux/spinlock.h:351 net/ipv4/inet_timewait_sock.c:132) 
[ 53.976122][ C0] tcp_time_wait (include/net/inet_timewait_sock.h:108 net/ipv4/tcp_minisocks.c:343) 
[ 53.976533][ C0] tcp_fin (net/ipv4/tcp_input.c:4508) 
[ 53.976911][ C0] tcp_data_queue (net/ipv4/tcp_input.c:5188) 
[ 53.977336][ C0] tcp_rcv_state_process (net/ipv4/tcp_input.c:6850) 
[ 53.977802][ C0] tcp_v4_do_rcv (net/ipv4/tcp_ipv4.c:1929) 
[ 53.978216][ C0] __release_sock (net/core/sock.c:2970) 
[ 53.978634][ C0] __tcp_close (net/ipv4/tcp.c:2847) 
[ 53.979035][ C0] tcp_close (net/ipv4/tcp.c:2922) 
[ 53.979413][ C0] inet_release (net/ipv4/af_inet.c:434) 
[ 53.979817][ C0] __sock_release (net/socket.c:660) 
[ 53.980229][ C0] sock_close (net/socket.c:1421) 
[ 53.980610][ C0] __fput (fs/file_table.c:394) 
[ 53.980986][ C0] task_work_run (kernel/task_work.c:182 (discriminator 1)) 
[ 53.981401][ C0] do_exit (kernel/exit.c:872) 
[ 53.981777][ C0] do_group_exit (kernel/exit.c:1002) 
[ 53.982183][ C0] __ia32_sys_exit_group (kernel/exit.c:1030) 
[ 53.982632][ C0] __do_fast_syscall_32 (arch/x86/entry/common.c:164 arch/x86/entry/common.c:230) 
[ 53.983076][ C0] do_fast_syscall_32 (arch/x86/entry/common.c:255) 
[ 53.983505][ C0] entry_SYSENTER_compat_after_hwframe (arch/x86/entry/entry_64_compat.S:121) 
[   53.984034][    C0] irq event stamp: 95812558
[ 53.984434][ C0] hardirqs last enabled at (95812558): _raw_spin_unlock_irqrestore (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194) 
[ 53.985302][ C0] hardirqs last disabled at (95812557): _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:108 kernel/locking/spinlock.c:162) 
[ 53.986123][ C0] softirqs last enabled at (95812510): __do_softirq (arch/x86/include/asm/preempt.h:27 kernel/softirq.c:400 kernel/softirq.c:582) 
[ 53.986900][ C0] softirqs last disabled at (95812513): irq_exit_rcu (kernel/softirq.c:427 kernel/softirq.c:632 kernel/softirq.c:622 kernel/softirq.c:644) 
[   53.987664][    C0]
[   53.987664][    C0] other info that might help us debug this:
[   53.988335][    C0]  Possible unsafe locking scenario:
[   53.988335][    C0]
[   53.988971][    C0]        CPU0
[   53.989291][    C0]        ----
[   53.989611][    C0]   lock(&tcp_hashinfo.bhash[i].lock);
[   53.990076][    C0]   <Interrupt>
[   53.990404][    C0]     lock(&tcp_hashinfo.bhash[i].lock);
[   53.990883][    C0]
[   53.990883][    C0]  *** DEADLOCK ***
[   53.990883][    C0]
[   53.991593][    C0] 3 locks held by kallsyms_test/97:
[ 53.992048][ C0] #0: ffffffff87560480 (rcu_read_lock){....}-{1:2}, at: netif_receive_skb_list_internal (include/linux/rcupdate.h:301 include/linux/rcupdate.h:747 net/core/dev.c:5748) 
[ 53.992919][ C0] #1: ffffffff87560480 (rcu_read_lock){....}-{1:2}, at: ip_local_deliver_finish+0x1d3/0x410 
[ 53.993815][ C0] #2: ffff88816d626cb0 (slock-AF_INET/1){+.-.}-{2:2}, at: tcp_v4_rcv (include/linux/skbuff.h:1609 include/net/tcp.h:2458 net/ipv4/tcp_ipv4.c:2326) 
[   53.994590][    C0]
[   53.994590][    C0] stack backtrace:
[   53.995117][    C0] CPU: 0 PID: 97 Comm: kallsyms_test Tainted: G        W        N 6.6.0-15915-g0258784e3719 #1 f6bfa75c5f93478329dec95cb0ab5dfc3e35c498
[   53.996184][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   53.997020][    C0] Call Trace:
[   53.997341][    C0]  <IRQ>
[ 53.997631][ C0] dump_stack_lvl (lib/dump_stack.c:107) 
[ 53.998033][ C0] mark_lock_irq (kernel/locking/lockdep.c:4216) 
[ 53.998447][ C0] ? print_usage_bug+0x680/0x680 
[ 53.999002][ C0] ? filter_irq_stacks (kernel/stacktrace.c:114) 
[ 53.999514][ C0] ? save_trace (kernel/locking/lockdep.c:586) 
[ 53.999909][ C0] ? __lock_release+0xf6/0x400 
[ 54.000367][ C0] ? __stack_depot_save (lib/stackdepot.c:441) 
[ 54.000823][ C0] ? reacquire_held_locks (kernel/locking/lockdep.c:5404) 
[ 54.001285][ C0] mark_lock (kernel/locking/lockdep.c:4677) 
[ 54.001675][ C0] ? mark_lock_irq (kernel/locking/lockdep.c:4638) 
[ 54.002104][ C0] ? do_raw_spin_unlock (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented.h:33 include/asm-generic/qspinlock.h:57 kernel/locking/spinlock_debug.c:100 kernel/locking/spinlock_debug.c:140) 
[ 54.002546][ C0] mark_usage (kernel/locking/lockdep.c:4566) 
[ 54.002930][ C0] __lock_acquire (kernel/locking/lockdep.c:5090) 
[ 54.003352][ C0] ? mark_lock (arch/x86/include/asm/bitops.h:227 (discriminator 3) arch/x86/include/asm/bitops.h:239 (discriminator 3) include/asm-generic/bitops/instrumented-non-atomic.h:142 (discriminator 3) kernel/locking/lockdep.c:228 (discriminator 3) kernel/locking/lockdep.c:4655 (discriminator 3)) 
[ 54.003748][ C0] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5755 kernel/locking/lockdep.c:5718) 
[ 54.004148][ C0] ? inet_twsk_hashdance (include/linux/spinlock.h:351 net/ipv4/inet_timewait_sock.c:132) 
[ 54.004608][ C0] ? lock_sync (kernel/locking/lockdep.c:5721) 
[ 54.005007][ C0] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4566) 
[ 54.005548][ C0] ? lockdep_init_map_type (kernel/locking/lockdep.c:4891) 
[ 54.006012][ C0] _raw_spin_lock (include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 54.006413][ C0] ? inet_twsk_hashdance (include/linux/spinlock.h:351 net/ipv4/inet_timewait_sock.c:132) 
[ 54.006868][ C0] inet_twsk_hashdance (include/linux/spinlock.h:351 net/ipv4/inet_timewait_sock.c:132) 
[ 54.007313][ C0] ? inet_twsk_alloc (net/ipv4/inet_timewait_sock.c:222) 
[ 54.007742][ C0] tcp_time_wait (include/net/inet_timewait_sock.h:108 net/ipv4/tcp_minisocks.c:343) 
[ 54.008149][ C0] tcp_rcv_state_process (net/ipv4/tcp_input.c:6790) 
[ 54.008621][ C0] ? lock_sync (kernel/locking/lockdep.c:5721) 
[ 54.009020][ C0] ? tcp_rcv_synsent_state_process (net/ipv4/tcp_input.c:6605) 
[ 54.009547][ C0] ? do_raw_spin_lock (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 kernel/locking/spinlock_debug.c:115) 
[ 54.009982][ C0] tcp_v4_do_rcv (net/ipv4/tcp_ipv4.c:1929) 
[ 54.010389][ C0] tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2329) 
[ 54.010795][ C0] ? tcp_v4_early_demux (net/ipv4/tcp_ipv4.c:2162) 
[ 54.011246][ C0] ? lock_sync (kernel/locking/lockdep.c:5721) 
[ 54.011641][ C0] ? raw_rcv (net/ipv4/raw.c:165) 
[ 54.012021][ C0] ? __kmem_cache_free (mm/slub.c:3809 mm/slub.c:3822) 
[ 54.012461][ C0] ip_protocol_deliver_rcu (net/ipv4/ip_input.c:205) 
[ 54.012927][ C0] ip_local_deliver_finish+0x28b/0x410 
[ 54.013467][ C0] ip_sublist_rcv_finish (net/ipv4/ip_input.c:578) 
[ 54.013914][ C0] ip_list_rcv_finish+0x316/0x4b0 
[ 54.014422][ C0] ? ip_rcv_finish_core+0x13d0/0x13d0 
[ 54.014952][ C0] ip_list_rcv (net/ipv4/ip_input.c:645) 
[ 54.015351][ C0] ? ip_rcv (net/ipv4/ip_input.c:645) 
[ 54.015729][ C0] __netif_receive_skb_list_core (net/core/dev.c:5582) 
[ 54.016231][ C0] ? __netif_receive_skb_core+0x2050/0x2050 
[ 54.016798][ C0] ? reacquire_held_locks (kernel/locking/lockdep.c:5404) 
[ 54.017257][ C0] netif_receive_skb_list_internal (net/core/dev.c:5674 net/core/dev.c:5763) 
[ 54.017769][ C0] ? dev_gro_receive (arch/x86/include/asm/bitops.h:227 (discriminator 8) arch/x86/include/asm/bitops.h:239 (discriminator 8) include/asm-generic/bitops/instrumented-non-atomic.h:142 (discriminator 8) net/core/gro.c:533 (discriminator 8)) 
[ 54.018208][ C0] ? process_backlog (net/core/dev.c:5735) 
[ 54.018641][ C0] ? napi_gro_receive (include/trace/events/net.h:288 net/core/gro.c:610) 
[ 54.019075][ C0] ? e1000_clean_rx_irq (drivers/net/ethernet/intel/e1000/e1000_main.c:4480) 
[ 54.019528][ C0] napi_complete_done (include/linux/list.h:37 include/net/gro.h:440 include/net/gro.h:435 net/core/dev.c:6103) 
[ 54.019963][ C0] ? napi_busy_loop (net/core/dev.c:6070) 
[ 54.020389][ C0] ? e1000_clean_rx_ring (drivers/net/ethernet/intel/e1000/e1000_main.c:4350) 
[ 54.020848][ C0] e1000_clean (drivers/net/ethernet/intel/e1000/e1000_main.c:3811) 
[ 54.021235][ C0] ? e1000_clean_tx_irq (drivers/net/ethernet/intel/e1000/e1000_main.c:3796) 
[ 54.021693][ C0] __napi_poll+0x99/0x430 
[ 54.022154][ C0] net_rx_action (net/core/dev.c:6604 net/core/dev.c:6735) 
[ 54.022565][ C0] ? __napi_poll+0x430/0x430 
[ 54.023043][ C0] ? asym_cpu_capacity_scan (kernel/sched/clock.c:389) 
[ 54.023516][ C0] ? lock_sync (kernel/locking/lockdep.c:5721) 
[ 54.023911][ C0] __do_softirq (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 include/trace/events/irq.h:142 kernel/softirq.c:554) 
[ 54.024316][ C0] ? __lock_text_end (kernel/softirq.c:511) 
[ 54.024729][ C0] irq_exit_rcu (kernel/softirq.c:427 kernel/softirq.c:632 kernel/softirq.c:622 kernel/softirq.c:644) 
[ 54.025116][ C0] common_interrupt (arch/x86/kernel/irq.c:247 (discriminator 14)) 
[   54.025529][    C0]  </IRQ>
[   54.025823][    C0]  <TASK>
[ 54.026117][ C0] asm_common_interrupt (arch/x86/include/asm/idtentry.h:636) 
[ 54.026551][ C0] RIP: kallsyms_expand_symbol+0xff/0x2e0 
[ 54.027129][ C0] Code: 48 81 c3 e0 0e a3 86 48 89 d8 49 89 d8 48 89 df 48 c1 e8 03 41 83 e0 07 42 0f b6 04 28 44 38 c0 7f 08 84 c0 0f 85 39 01 00 00 <0f> b6 ad e0 0e a3 86 40 84 ed 74 65 85 d2 75 2a 48 83 c3 01 48 89
All code
========
   0:	48 81 c3 e0 0e a3 86 	add    $0xffffffff86a30ee0,%rbx
   7:	48 89 d8             	mov    %rbx,%rax
   a:	49 89 d8             	mov    %rbx,%r8
   d:	48 89 df             	mov    %rbx,%rdi
  10:	48 c1 e8 03          	shr    $0x3,%rax
  14:	41 83 e0 07          	and    $0x7,%r8d
  18:	42 0f b6 04 28       	movzbl (%rax,%r13,1),%eax
  1d:	44 38 c0             	cmp    %r8b,%al
  20:	7f 08                	jg     0x2a
  22:	84 c0                	test   %al,%al
  24:	0f 85 39 01 00 00    	jne    0x163
  2a:*	0f b6 ad e0 0e a3 86 	movzbl -0x795cf120(%rbp),%ebp		<-- trapping instruction
  31:	40 84 ed             	test   %bpl,%bpl
  34:	74 65                	je     0x9b
  36:	85 d2                	test   %edx,%edx
  38:	75 2a                	jne    0x64
  3a:	48 83 c3 01          	add    $0x1,%rbx
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
===========================================
   0:	0f b6 ad e0 0e a3 86 	movzbl -0x795cf120(%rbp),%ebp
   7:	40 84 ed             	test   %bpl,%bpl
   a:	74 65                	je     0x71
   c:	85 d2                	test   %edx,%edx
   e:	75 2a                	jne    0x3a
  10:	48 83 c3 01          	add    $0x1,%rbx
  14:	48                   	rex.W
  15:	89                   	.byte 0x89


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231120/202311202323.8c66ae1c-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

