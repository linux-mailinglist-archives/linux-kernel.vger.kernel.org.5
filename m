Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972A47BD2F8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 08:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345147AbjJIGBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 02:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345137AbjJIGBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 02:01:39 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D581EA4;
        Sun,  8 Oct 2023 23:01:38 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3995sn5s026689;
        Mon, 9 Oct 2023 06:01:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=jvPHV0Eh60HCWWfvX2U16GcYis4/JkEkuuIZg8SCuOA=;
 b=eXwYh1CZWcZonUNle8eWENl7rhprYNNBYCanai+ccqrh5VSmuhAK5mnnD1fH9kzWuvxG
 /YV1bc3/L1V+gQH/p+JigwTTbxE+hkYqCvfZpWqfyPj8CDmVztTZa2KwdAbYKoMCCtdz
 pAJxRFDSCGtWzf+HEDG28kA/jmLvHRB9OtCQ+wmbcH/pBVwA2soQetCWRt0ZMyuxK/zA
 Smw4gY5ZeMcJ+A9grDhnFs2jlcdIr8sycmuNrRpxAdqxjfakBR+h1iuX+ieM/bY4SERf
 Ge/z6TYmxVerrzNOOJ7RVctBZEANGmO0Pzcv9rOtM02Axu0lciHr1hn7PcYqFzKVayRN 8A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tmbsmg420-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 06:01:10 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3995tECB027723;
        Mon, 9 Oct 2023 06:01:09 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tmbsmg41h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 06:01:09 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3993EI7R000685;
        Mon, 9 Oct 2023 06:01:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkk5k6t22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 06:01:08 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 399616xr459342
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Oct 2023 06:01:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C01E20063;
        Mon,  9 Oct 2023 06:01:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB27A2004E;
        Mon,  9 Oct 2023 06:01:03 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.in.ibm.com (unknown [9.109.201.126])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  9 Oct 2023 06:01:03 +0000 (GMT)
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        vschneid@redhat.com
Cc:     sshegde@linux.vnet.ibm.com, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, qperret@google.com,
        srikar@linux.vnet.ibm.com, mingo@kernel.org,
        pierre.gondois@arm.com, yu.c.chen@intel.com,
        tim.c.chen@linux.intel.com, pauld@redhat.com, lukasz.luba@arm.com,
        linux-doc@vger.kernel.org
Subject: [PATCH v6 0/2] sched: EAS changes for EM complexity and sysctl
Date:   Mon,  9 Oct 2023 11:30:35 +0530
Message-Id: <20231009060037.170765-1-sshegde@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RN5JfF2QSDHhjxctS4BS5RVDAC5Ndffg
X-Proofpoint-GUID: 02dwCb0upv6SV3TDuQItBhGpSDN1riEH
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_04,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=656 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310090052
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Brief:
[PATCH v6 1/2] sched/topology: Remove EM_MAX_COMPLEXITY limit
Since the EAS complexity was greatly reduced, bigger platforms can
handle EAS. To reflect this improvement, remove the EAS complexity check.

[PATCH v6 2/2] sched/topology: change behaviour of sysctl sched_energy_aware
based on the platform
Depending on the platform sysctl will either enable/disable EAS and NOP
in case if EAS is not supported.

Patchset contains these two patches. Second patch depends on the first
patch to be applied first.

v5->v6:
Valentin pointed out that sd_asym_cpucapacity is under rcu and to avoid
writing to sysctl if EAS is not possible. Did these two.
v4->v5:
sched_is_eas_possible missed handling of case when EM complexity was high.
Dietmar suggested that there was work done already which removes these
checks. Since it makes sched_is_eas_possible cleaner, picked up that
patch along with v4 and made it as a patchset.
Instead of using first CPU in cpu_active_mask, doing a simple loop across
all CPU in cpu_active_mask to check if there is any asymmetric CPU
capacities since it was breaking EAS capabilities over CPUSET islands.
v3->v4:
valentin suggested it would be better to consider simpler approach that
was mentioned in v2. It is a standard approach to keep the knob visible
but change how read and write are handled. Did that and Refactored the
code to use a common function in build_perf_domains and in sysctl handler.
v2->v3:
Chen Yu and Pierre Gondois both pointed out that if platform becomes
capable of EAS later, this patch was not allowing that to happen.
Addressed that by using a variable to indicate the sysctl change
and re-worded the commit message with desired behaviour,
v1->v2:
Chen Yu had pointed out that this will not destroy the perf domains on
architectures where EAS is supported by changing the sysctl.
[v1] Link: https://lore.kernel.org/lkml/20230829065040.920629-1-sshegde@linux.vnet.ibm.com/
[v2] Link: https://lore.kernel.org/lkml/20230901065249.137242-1-sshegde@linux.vnet.ibm.com/
[v3] Link: https://lore.kernel.org/lkml/20230913114807.665094-1-sshegde@linux.vnet.ibm.com/
[v4] Link: https://lore.kernel.org/lkml/20230926100046.405188-1-sshegde@linux.vnet.ibm.com/
[v5] Link: https://lore.kernel.org/lkml/20230929155209.667764-1-sshegde@linux.vnet.ibm.com/

Pierre Gondois (1):
  sched/topology: Remove EM_MAX_COMPLEXITY limit

Shrikanth Hegde (1):
  sched/topology: change behaviour of sysctl sched_energy_aware based on
    the platform

 Documentation/admin-guide/sysctl/kernel.rst |   3 +-
 Documentation/scheduler/sched-energy.rst    |  29 +---
 kernel/sched/topology.c                     | 151 ++++++++++----------
 3 files changed, 82 insertions(+), 101 deletions(-)

--
2.31.1

