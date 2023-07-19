Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7881E758D6E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 08:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjGSGJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 02:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGSGJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 02:09:35 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFB31BF2;
        Tue, 18 Jul 2023 23:09:34 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36J63CHZ024876;
        Wed, 19 Jul 2023 06:09:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=V39H711HKU9/skviqQuB5rlaLN3pdUAYy7qVwSsavpo=;
 b=thvydvDkjuNczqJTv/FZl5HQUfI23eLsauF2+AWGbccPat1x5jrmroSbFTRFtZXuJjjM
 jm1x8mJpN1OsWg+oTOcHaAFDaVTAsNy6ooW0wTKF0LRA3+7Xv+4n69r1FDViaXyw5X1X
 Ieeu3K0L5iNFb8r3cx6z3pRlECOsTbnwImPPL4KiClsVn+/FM2ui6qp9+0RIxmolAbs0
 wj6zIg78waGay2MxDYnsj08jTNc6JtXSqlTQ6AFma2abIkpfc0kXt2+OcK0D2+P6r20t
 MBiB+rCaEWs6Ihl+BfVQWJ1Dk12SuhJ4edqrx15euEkxQ5GW4xXNNGBcygR0WfQiyTOZ fA== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rxa7hrdyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 06:09:21 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36J2fGoc004510;
        Wed, 19 Jul 2023 06:07:19 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rv80j5wqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 06:07:19 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36J67GE445351566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jul 2023 06:07:16 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4803120043;
        Wed, 19 Jul 2023 06:07:16 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF5BD20040;
        Wed, 19 Jul 2023 06:07:10 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com.com (unknown [9.43.119.126])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 19 Jul 2023 06:07:10 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, disgoel@linux.ibm.com,
        kjain@linux.ibm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: [PATCH v3 00/10] Add sysfs interface files to hv_gpci device to expose system information
Date:   Wed, 19 Jul 2023 11:36:42 +0530
Message-Id: <20230719060652.625387-1-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: v_kyyCPmHtdRquiGc8LGAiZ2cYwS6ps-
X-Proofpoint-ORIG-GUID: v_kyyCPmHtdRquiGc8LGAiZ2cYwS6ps-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_02,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307190056
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hcall H_GET_PERF_COUNTER_INFO can be used to get data related to
chips, dimms and system topology, by passing different counter request
values.
Patchset adds sysfs files to "/sys/devices/hv_gpci/interface/"
of hv_gpci pmu driver, which will expose system topology information
using H_GET_PERF_COUNTER_INFO hcall. The added sysfs files are
available for power10 and above platforms and needs root access
to read the data.

Patches 1,3,5,7,9 adds sysfs interface files to the hv_gpci
pmu driver, to get system topology information.

List of added sysfs files:
-> processor_bus_topology (Counter request value : 0xD0)
-> processor_config (Counter request value : 0x90)
-> affinity_domain_via_virtual_processor (Counter request value : 0xA0)
-> affinity_domain_via_domain (Counter request value : 0xB0)
-> affinity_domain_via_partition (Counter request value : 0xB1)

Patches 2,4,6,8,10 adds details of the newly added hv_gpci
interface files listed above in the ABI documentation.

Patches 2,4,6,8,10 adds details of the newly added hv_gpci
interface files listed above in the ABI documentation.

Changelog:
v2 -> v3
-> Make nit changes in documentation patches as suggested by Randy Dunlap.

v1 -> v2
-> Incase the HCALL fails with errors that can be resolve during runtime,
   then only add sysinfo interface attributes to the interface_attrs
   attribute array. Even if one of the counter request value HCALL fails,
   don't add any sysinfo attribute to the interface_attrs attribute array.
   Add the code changes to make sure sysinfo interface added only when all
   the requirements met as suggested by Michael Ellerman.
-> Make changes in documentation, adds detail of errors type
   which can be resolved at runtime as suggested by Michael Ellerman.
-> Add new enum and sysinfo_counter_request array to get required
   counter request value in hv-gpci.c file.
-> Move the macros for interface attribute array index to hv-gpci.c, as
   these macros currently only used in hv-gpci.c file.

Kajol Jain (10):
  powerpc/hv_gpci: Add sysfs file inside hv_gpci device to show
    processor bus topology information
  docs: ABI: sysfs-bus-event_source-devices-hv_gpci: Document
    processor_bus_topology sysfs interface file
  powerpc/hv_gpci: Add sysfs file inside hv_gpci device to show
    processor config information
  docs: ABI: sysfs-bus-event_source-devices-hv_gpci: Document
    processor_config sysfs interface file
  powerpc/hv_gpci: Add sysfs file inside hv_gpci device to show affinity
    domain via virtual processor information
  docs: ABI: sysfs-bus-event_source-devices-hv_gpci: Document
    affinity_domain_via_virtual_processor sysfs interface file
  powerpc/hv_gpci: Add sysfs file inside hv_gpci device to show affinity
    domain via domain information
  docs: ABI: sysfs-bus-event_source-devices-hv_gpci: Document
    affinity_domain_via_domain sysfs interface file
  powerpc/hv_gpci: Add sysfs file inside hv_gpci device to show affinity
    domain via partition information
  docs: ABI: sysfs-bus-event_source-devices-hv_gpci: Document
    affinity_domain_via_partition sysfs interface file

 .../sysfs-bus-event_source-devices-hv_gpci    | 160 +++++
 arch/powerpc/perf/hv-gpci.c                   | 640 +++++++++++++++++-
 2 files changed, 798 insertions(+), 2 deletions(-)

-- 
2.39.3

