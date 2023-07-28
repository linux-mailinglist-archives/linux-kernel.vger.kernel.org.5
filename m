Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39D57670D2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237427AbjG1Pmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237405AbjG1Pmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:42:36 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5679810FA;
        Fri, 28 Jul 2023 08:42:35 -0700 (PDT)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36SEW6hf023510;
        Fri, 28 Jul 2023 15:41:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pps0720; bh=D4UU4pH4kUAWMPAHS8HIBDWEphUtaRF7nkbbuvO28Ek=;
 b=Q43reYUrBosJ+Iy6LQ6JBbZGpgsQSc7Lhx6WkCXaCgnOuN/8ELuytsRmYDnhUIkHkHu7
 ZRD2uA8Wk2vaEjtnZ+Mxz+QVj/i3Io5zU2lL8k0GkaF5xr5eO7hkkj9ebQ5+wYneIro8
 QJV2XN3v4aulaSXMD7nTXuUpB2xwzEvU2l6AuJeVCXGEbjSALYWJqxG1+YfwfeYqEBF9
 X6CYjlxWolqUNGvA8FlCiyPqx0fOJyzWBA7xe9ZJESP7Gjj/A8hFviWUAdev6WrDrN9B
 9kNugsD2ECpez3k5V55/nIpcwmyWn7OcfrdfnAFLyNa7vDt0R0xJ1Wcq3PVMsZk6CGNc zg== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3s48wkbyh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 15:41:54 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 6DD9A803718;
        Fri, 28 Jul 2023 15:41:31 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id A42BA80A27F;
        Fri, 28 Jul 2023 15:41:28 +0000 (UTC)
Date:   Fri, 28 Jul 2023 10:41:26 -0500
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
        linux-scsi@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: Re: [patch v2 00/38] x86/cpu: Rework the topology evaluation
Message-ID: <20230728154047.GA21214@hpe.com>
References: <20230728105650.565799744@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728105650.565799744@linutronix.de>
X-Proofpoint-GUID: M3diYXEsN13Z6X2mEEsSKlMLV6D1v-80
X-Proofpoint-ORIG-GUID: M3diYXEsN13Z6X2mEEsSKlMLV6D1v-80
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1011 suspectscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307280143
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

I successfully booted the same 32-socket, 3840 cpu HPE Sapphire Rapids system
with the V2 update found here:
  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git topo-cpuid-v2

# cat /sys/kernel/debug/x86/topo/cpus/3839
initial_apicid:      ff7
apicid:              ff7
pkg_id:              31
die_id:              31
cu_id:               255
core_id:             59
logical_pkg_id:      31
logical_die_id:      31
llc_id:              3968
l2c_id:              4086
amd_node_id:         0
amd_nodes_per_pkg:   0
max_cores:           60
max_die_per_pkg:     1
smp_num_siblings:    2

On Fri, Jul 28, 2023 at 02:12:42PM +0200, Thomas Gleixner wrote:
> Hi!
> 
> This is the follow up to V1:
> 
>   https://lore.kernel.org/lkml/20230724155329.474037902@linutronix.de
> 
> which addresses the review feedback and some minor fallout I observed in my
> testing of the work based on top.
> 
> TLDR:
> 
> This reworks the way how topology information is evaluated via CPUID
> in preparation for a larger topology management overhaul to address
> shortcomings of the current code vs. hybrid systems and systems which make
> use of the extended topology domains in leaf 0x1f. Aside of that it's an
> overdue spring cleaning to get rid of accumulated layers of duct tape and
> haywire.
> 
> What changed vs. V1:
> 
>   - Fixed an issue vs. the logical die/pkg management as the current
>     code (ab)uses cpuinfo for persistant storage.
> 
>   - Consolidated APIC ID usage on u32 and ditched the u16 limitation
> 
>   - Addressed the review feedback from Peter and Arjan
> 
>   - Added a new patch which gets rid of XENPV fiddling in the cpuinfo
>     state. That needs some testing on XENPV obviously. The relevant
>     patches are #22 and #37
> 
> I did not pick up any of the tested by tags yet. I hope people can run it
> once more. Neither did I add the Ack from Peter.
> 
> The series is based on the APIC cleanup series:
> 
>   https://lore.kernel.org/lkml/20230724131206.500814398@linutronix.de
> 
> and also available on top of that from git:
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git topo-cpuid-v2
> 
> Thanks,
> 
> 	tglx
> ---
>  Documentation/arch/x86/topology.rst       |   12 -
>  a/arch/x86/kernel/cpu/topology.c          |  168 ---------------------
>  arch/x86/events/amd/core.c                |    2 
>  arch/x86/events/amd/uncore.c              |    2 
>  arch/x86/events/intel/uncore.c            |    2 
>  arch/x86/hyperv/hv_vtl.c                  |    2 
>  arch/x86/include/asm/apic.h               |   32 +---
>  arch/x86/include/asm/cacheinfo.h          |    3 
>  arch/x86/include/asm/cpuid.h              |   32 ++++
>  arch/x86/include/asm/mpspec.h             |    2 
>  arch/x86/include/asm/processor.h          |   60 +++++--
>  arch/x86/include/asm/smp.h                |    4 
>  arch/x86/include/asm/topology.h           |   51 +++++-
>  arch/x86/include/asm/x86_init.h           |    2 
>  arch/x86/kernel/acpi/boot.c               |    4 
>  arch/x86/kernel/amd_nb.c                  |    8 -
>  arch/x86/kernel/apic/apic.c               |   14 -
>  arch/x86/kernel/apic/apic_common.c        |    4 
>  arch/x86/kernel/apic/apic_flat_64.c       |   13 -
>  arch/x86/kernel/apic/apic_noop.c          |    9 -
>  arch/x86/kernel/apic/apic_numachip.c      |   21 --
>  arch/x86/kernel/apic/bigsmp_32.c          |   10 -
>  arch/x86/kernel/apic/local.h              |    6 
>  arch/x86/kernel/apic/probe_32.c           |   10 -
>  arch/x86/kernel/apic/x2apic_cluster.c     |    1 
>  arch/x86/kernel/apic/x2apic_phys.c        |   10 -
>  arch/x86/kernel/apic/x2apic_uv_x.c        |   67 +-------
>  arch/x86/kernel/cpu/Makefile              |    5 
>  arch/x86/kernel/cpu/amd.c                 |  156 --------------------
>  arch/x86/kernel/cpu/cacheinfo.c           |   51 ++----
>  arch/x86/kernel/cpu/centaur.c             |    4 
>  arch/x86/kernel/cpu/common.c              |  111 +-------------
>  arch/x86/kernel/cpu/cpu.h                 |   14 +
>  arch/x86/kernel/cpu/hygon.c               |  133 -----------------
>  arch/x86/kernel/cpu/intel.c               |   38 ----
>  arch/x86/kernel/cpu/mce/amd.c             |    4 
>  arch/x86/kernel/cpu/mce/apei.c            |    4 
>  arch/x86/kernel/cpu/mce/core.c            |    4 
>  arch/x86/kernel/cpu/mce/inject.c          |    7 
>  arch/x86/kernel/cpu/proc.c                |    8 -
>  arch/x86/kernel/cpu/zhaoxin.c             |   18 --
>  arch/x86/kernel/kvm.c                     |    6 
>  arch/x86/kernel/sev.c                     |    2 
>  arch/x86/kernel/smpboot.c                 |   97 +++++++-----
>  arch/x86/kernel/vsmp_64.c                 |   13 -
>  arch/x86/mm/amdtopology.c                 |   35 ++--
>  arch/x86/mm/numa.c                        |    4 
>  arch/x86/xen/apic.c                       |   14 -
>  arch/x86/xen/smp_pv.c                     |    3 
>  b/arch/x86/kernel/cpu/debugfs.c           |   97 ++++++++++++
>  b/arch/x86/kernel/cpu/topology.h          |   51 ++++++
>  b/arch/x86/kernel/cpu/topology_amd.c      |  179 +++++++++++++++++++++++
>  b/arch/x86/kernel/cpu/topology_common.c   |  233 ++++++++++++++++++++++++++++++
>  b/arch/x86/kernel/cpu/topology_ext.c      |  136 +++++++++++++++++
>  drivers/edac/amd64_edac.c                 |    4 
>  drivers/edac/mce_amd.c                    |    4 
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c |    2 
>  drivers/hwmon/fam15h_power.c              |    7 
>  drivers/scsi/lpfc/lpfc_init.c             |    8 -
>  drivers/virt/acrn/hsm.c                   |    2 
>  60 files changed, 1049 insertions(+), 956 deletions(-)
