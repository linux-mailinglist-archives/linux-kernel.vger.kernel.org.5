Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6039F75B3D7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 18:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjGTQIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 12:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjGTQII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 12:08:08 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D22F0;
        Thu, 20 Jul 2023 09:08:06 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36KG571m029141;
        Thu, 20 Jul 2023 16:08:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=WW8wnQDb5F04c8xPquGYN1xbIFjNJENXcqLbV7qEtsk=;
 b=M5Ye+ZwEtM/STZRtpe7Je8s9VAzE14AaDdKOOgcc18Z8r1Hww4JmPEt/Szyatp6glwqn
 F/Y5rh9u0OV44HRCa07oVphQkCJ991uMLnZ3ENJ9agJwykKCqA5ExG8E1dN9GLsUl0r1
 hOjjHoQOajFTGy+dfqd5ybfWwkUg5vCihCVp7bFe8VaxkHkwYXITv6ZraCLoawHPdV8o
 SP5W/L1eoVAbTcuj4TtSJAaAHVeinlQgpBokFOpAjUfXdnK9mcNlOEeBXpRevLvRSjHA
 RZmSG9EtptlTNz/k1YAc5l5vENULPHlFO/s0NnAniClF6i2kvfa8uzyvPQ/8tVIeJe0I UQ== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3rxwk7e1wf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 16:08:05 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id A994AD2CF;
        Thu, 20 Jul 2023 16:08:04 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.39])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 53E0180CBEB;
        Thu, 20 Jul 2023 16:08:04 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 48746)
        id CDFFC302F47FB; Thu, 20 Jul 2023 11:08:03 -0500 (CDT)
From:   Frank Ramsay <frank.ramsay@hpe.com>
To:     Frank Ramsay <frank.ramsay@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tools/power/x86/intel-speed-select: Support more than 8 sockets.
Date:   Thu, 20 Jul 2023 11:08:03 -0500
Message-Id: <20230720160803.1648970-1-frank.ramsay@hpe.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 1s8DvVvOYPEgCw-8rqXI84_qufLTSZM4
X-Proofpoint-GUID: 1s8DvVvOYPEgCw-8rqXI84_qufLTSZM4
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_08,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 impostorscore=0
 bulkscore=0 malwarescore=0 adultscore=0 mlxlogscore=863 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307200135
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAX_PACKAGE_COUNT limits the intel-speed-select to systems with 8 sockets or fewer.
On a system with more than 8 sockets intel-speed-select silently ignores everything
beyond the 8th socket, rendering the tool useless for those systems.

Increase MAX_PACKAGE_COUNT to support systems with up to 32 sockets.

Signed-off-by: Frank Ramsay <frank.ramsay@hpe.com>
---
 tools/power/x86/intel-speed-select/isst.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/intel-speed-select/isst.h b/tools/power/x86/intel-speed-select/isst.h
index 54fc21575d56..8def22dec4a2 100644
--- a/tools/power/x86/intel-speed-select/isst.h
+++ b/tools/power/x86/intel-speed-select/isst.h
@@ -79,7 +79,7 @@
 
 #define DISP_FREQ_MULTIPLIER 100
 
-#define MAX_PACKAGE_COUNT	8
+#define MAX_PACKAGE_COUNT	32
 #define MAX_DIE_PER_PACKAGE	2
 #define MAX_PUNIT_PER_DIE	8
 
-- 
2.39.1

