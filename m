Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFE9762328
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjGYUSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjGYUSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:18:14 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6331BC8;
        Tue, 25 Jul 2023 13:18:12 -0700 (PDT)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PGMFuO014689;
        Tue, 25 Jul 2023 20:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pps0720; bh=DP0Tc00iLRrKt+oMzNbUswBBgoyBxS4KVUAQ2PBclnQ=;
 b=A3bUTl4t6FZOMwnZNaid6iZlB1s2xiqIRmbcxELAdUPuYNbR+iA2Tp2KdFF3sWsTpgfm
 HCt+OKhAsAQ+ERDMb+IIPkVg97RM8x3Zff1ODXCGtqSazIUVxReRFIEHikQ6llqDxTCR
 06KdJBKlKhuGhw7cp5zHOGIPGrCpATYfYr8nXbCs2cdVrx1/izIYWu58S3PrZw1JJSpl
 HeODdmWoqHJJluL+TDTr5b80gTfexR1EYiWBN9G12MUF9BA/crNJ8lVJJVF7N1CyAuy6
 J9n37vwZ908PWeJCfR4gnOeCnv2E5AlAAlFvk2Na87Kgw8USy3HERZ2fhBFTXfGrJf60 lA== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3s2huv9j3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 20:17:38 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 91C0AD2C4;
        Tue, 25 Jul 2023 20:17:37 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 21F70808DAF;
        Tue, 25 Jul 2023 20:17:35 +0000 (UTC)
Date:   Tue, 25 Jul 2023 15:17:33 -0500
From:   Dimitri Sivanich <sivanich@hpe.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: Re: [patch 00/29] x86/cpu: Rework the topology evaluation
Message-ID: <20230725201614.GB97682@hpe.com>
References: <20230724155329.474037902@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724155329.474037902@linutronix.de>
X-Proofpoint-GUID: IvxVjTX67_BAM-JLmyIMHjGZs-SYHHOa
X-Proofpoint-ORIG-GUID: IvxVjTX67_BAM-JLmyIMHjGZs-SYHHOa
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_11,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 adultscore=0 mlxscore=0 clxscore=1011
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250172
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have successfully booted a 32-socket, 3840 cpu HPE Sapphire Rapids system
with your patchset applied, as found in:
  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git topo-cpuid-v1

# cat /sys/kernel/debug/x86/topo/cpus/3839
initial_apicid: ff7
apicid: ff7
pkg_id: 31
die_id: 31
cu_id: 255
core_id: 59
logical_pkg_id: 31
logical_die_id: 31
llc_id: 3968
l2c_id: 4086
amd_node_id: 0
amd_nodes_per_pkg: 0
max_cores: 60
max_die_per_pkg: 1
smp_num_siblings: 2


We were also able to boot a 60-socket, 2160 cpu HPE SuperDome Flex (SkyLake)
with the patchset.

# cat /sys/kernel/debug/x86/topo/cpus/2159
initial_apicid: ef7
apicid: ef7
pkg_id: 59
die_id: 59
cu_id: 255
core_id: 27
logical_pkg_id: 59
logical_die_id: 59
llc_id: 3776
l2c_id: 3830
amd_node_id: 0
amd_nodes_per_pkg: 0
max_cores: 18
max_die_per_pkg: 1
smp_num_siblings: 2


On Mon, Jul 24, 2023 at 07:43:50PM +0200, Thomas Gleixner wrote:
> Hi!
> 
> A recent commit to the CPUID leaf 0xb/0x1f parser made me look deeper at
> the way how topology is evaluated. That "fix" is just yet another cure the
> sypmtom hack which completely ignores the underlying disaster.
> 
> The way how topology evaluation works is to overwrite the relevant
> variables as often as possible. E.g. smp_num_siblings gets overwritten a
> gazillion times, which is wrong to begin with. The boot CPU writes it 3
> times, each AP two times.
> 
> What's worse is that this just works by chance on hybrid systems due to the
> fact that the existing ones all seem to boot on a P-Core which has
> SMT. Would it boot on a E-Core which has no SMT, then parts of the early
> topology evaluation including the primary thread mask which is required for
> parallel CPU bringup would be completely wrong. Overwriting it later on
> with the correct value does not help at all.
> 
> What's wrong today with hybrid already is the number of cores per package.
> On an ADL with 8 P-Cores and 8 E-cores the resulting number of cores per
> package is evaluated to be 12. Which is not further surprising because the
> CPUID 0xb/0x1f parser looks at the number of logical processors at core
> level and divides them by the number of SMP siblings.
> 
>    24 / 2 = 12
> 
> Just that this CPU has obviously 16 cores not 12.
> 
> It's is even clearly documented in the SDM that this is wrong.
> 
>  "Bits 15-00: The number of logical processors across all instances of this
>   domain within the next higher- scoped domain relative to this current
>   logical processor. (For example, in a processor socket/package comprising
>   "M" dies of "N" cores each, where each core has "L" processors, the
>   "die" domain subleaf value of this field would be M*N*L. In an asymmetric
>   topology this would be the summation of the value across the lower domain
>   level instances to create each upper domain level instance.) This number
>   reflects configuration as shipped by Intel. Note, software must not use
>   this field to enumerate processor topology.
> 
>   Software must not use the value of EBX[15:0] to enumerate processor topology
>   of the system. The value is only intended for display and diagnostic purposes.
>   The actual number of logical processors available to BIOS/OS/Applications
>   may be different from the value of EBX[15:0], depending on software and
>   platform hardware configurations."
> 
> This "_NOT_ to use for topology evaluation" sentence existed even before
> hybrid came along and got ignored. The code worked by chance, but with
> hybrid all bets are off. The code completely falls apart once CPUID leaf
> 0x1f enumerates any topology level between CORE and DIE, but that's not a
> suprise.
> 
> The proper thing to do is to actually evaluate the full topology including
> the non-present (hotpluggable) CPUs based on the APICIDs which are provided
> by the firmware and a proper topology domain level parser. This can exactly
> tell the number of physical packages, logical packages etc. _before_ even
> booting a single AP. All of that can be evaluated upfront.
> 
> Aside of that there are too many places which do their own topology
> evaluation, but there is absolutely no central point which can actually
> provide all of that information in a consistent way. This needs to change.
> 
> This series implements another piece towards this: sane CPUID evaluation,
> which is done at _one_ place in a proper well defined order instead of
> having it sprinkled all over the CPUID evaluation code.
> 
> At the end of this series this is pretty much bug compatible with the
> current CPUID evaluation code in respect to the cores per package
> evaluation, but it gets rid of overwriting things like smp_num_siblings,
> which is now written once, but is still not capable to work correctly on a
> hybrid machine which boots from a non SMT core. These things can only be
> fixed up in the next step(s).
> 
> When I tried to go further with this I ran into yet another pile of
> historical layers of duct tape and haywire with a gazillion of random
> variables sprinkled all over the place. That's still work in progress.  It
> actually works, but the last step which switches over is not yet in a shape
> that can be easily reviewed. Stay tuned.
> 
> The series is based on the APIC cleanup series:
> 
>   https://lore.kernel.org/lkml/20230724131206.500814398@linutronix.de
> 
> and also available on top of that from git:
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git topo-cpuid-v1
> 
> Thanks,
> 
> 	tglx
> ---
>  arch/x86/kernel/cpu/topology.c              |  168 --------------------
>  b/Documentation/arch/x86/topology.rst       |   12 -
>  b/arch/x86/events/amd/core.c                |    2 
>  b/arch/x86/events/amd/uncore.c              |    2 
>  b/arch/x86/events/intel/uncore.c            |    2 
>  b/arch/x86/include/asm/apic.h               |    1 
>  b/arch/x86/include/asm/cacheinfo.h          |    3 
>  b/arch/x86/include/asm/cpuid.h              |   32 +++
>  b/arch/x86/include/asm/processor.h          |   58 ++++--
>  b/arch/x86/include/asm/smp.h                |    2 
>  b/arch/x86/include/asm/topology.h           |   51 +++++-
>  b/arch/x86/include/asm/x86_init.h           |    2 
>  b/arch/x86/kernel/amd_nb.c                  |    8 
>  b/arch/x86/kernel/apic/apic_flat_64.c       |    7 
>  b/arch/x86/kernel/apic/apic_noop.c          |    3 
>  b/arch/x86/kernel/apic/apic_numachip.c      |   11 -
>  b/arch/x86/kernel/apic/bigsmp_32.c          |    6 
>  b/arch/x86/kernel/apic/local.h              |    1 
>  b/arch/x86/kernel/apic/probe_32.c           |    6 
>  b/arch/x86/kernel/apic/x2apic_cluster.c     |    1 
>  b/arch/x86/kernel/apic/x2apic_phys.c        |    6 
>  b/arch/x86/kernel/apic/x2apic_uv_x.c        |   63 +------
>  b/arch/x86/kernel/cpu/Makefile              |    5 
>  b/arch/x86/kernel/cpu/amd.c                 |  156 ------------------
>  b/arch/x86/kernel/cpu/cacheinfo.c           |   51 ++----
>  b/arch/x86/kernel/cpu/centaur.c             |    4 
>  b/arch/x86/kernel/cpu/common.c              |  108 +-----------
>  b/arch/x86/kernel/cpu/cpu.h                 |   14 +
>  b/arch/x86/kernel/cpu/debugfs.c             |   98 +++++++++++
>  b/arch/x86/kernel/cpu/hygon.c               |  133 ---------------
>  b/arch/x86/kernel/cpu/intel.c               |   38 ----
>  b/arch/x86/kernel/cpu/mce/amd.c             |    4 
>  b/arch/x86/kernel/cpu/mce/apei.c            |    4 
>  b/arch/x86/kernel/cpu/mce/core.c            |    4 
>  b/arch/x86/kernel/cpu/mce/inject.c          |    7 
>  b/arch/x86/kernel/cpu/proc.c                |    8 
>  b/arch/x86/kernel/cpu/topology.h            |   51 ++++++
>  b/arch/x86/kernel/cpu/topology_amd.c        |  179 +++++++++++++++++++++
>  b/arch/x86/kernel/cpu/topology_common.c     |  233 ++++++++++++++++++++++++++++
>  b/arch/x86/kernel/cpu/topology_ext.c        |  136 ++++++++++++++++
>  b/arch/x86/kernel/cpu/zhaoxin.c             |   18 --
>  b/arch/x86/kernel/smpboot.c                 |   64 ++++---
>  b/arch/x86/kernel/vsmp_64.c                 |   13 -
>  b/arch/x86/mm/amdtopology.c                 |   35 +---
>  b/arch/x86/xen/apic.c                       |    8 
>  b/drivers/edac/amd64_edac.c                 |    4 
>  b/drivers/edac/mce_amd.c                    |    4 
>  b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c |    2 
>  b/drivers/hwmon/fam15h_power.c              |    7 
>  b/drivers/scsi/lpfc/lpfc_init.c             |    8 
>  b/drivers/virt/acrn/hsm.c                   |    2 
>  51 files changed, 964 insertions(+), 881 deletions(-)
> 
> 
> 
