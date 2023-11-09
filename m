Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE177E625A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 03:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbjKICoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 21:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbjKICoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 21:44:37 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2EC25BC;
        Wed,  8 Nov 2023 18:44:35 -0800 (PST)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A91jnR3019267;
        Thu, 9 Nov 2023 02:44:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=yGjUww+baZPDXUWVV0Zbc8TKsr6VcifBRdt0d5iUoPs=;
 b=mD3TeK3oem2MFxxZA3a0wITpCXWhXpArWSYbMMEbXmdRKAJkcx4/4Dhagd0w/IJhUl1L
 NYm3nwqd5ka2UCmOJVlNdD27eaZhjqlAGOrsUQgKugS6H9250p8UCFqhaDYIIOcES0w9
 219VbyWVf6fMBGlxd71wk/ix4TYLtsiI3m7FztqN7PdEYFqZpkpTaQDO90nRvGsuOB+L
 zl1xdspTwtch18svonQesr/ptSRGgcQOb27olp61xEye4c+Q83J/qv0JoraBzIGpyxKd
 5l3RkAJf/TvjC90vKZThRgyYNyHlGuCNNZRRfRauhYVkLi1avczFaw2ktznM9X1PGqvv 9Q== 
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3u8gpmb1nx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Nov 2023 02:44:19 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 10D4A131AC;
        Thu,  9 Nov 2023 02:44:19 +0000 (UTC)
Received: from anatevka.americas.hpqcorp.net (unknown [16.231.227.39])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 449AC801FDE;
        Thu,  9 Nov 2023 02:44:18 +0000 (UTC)
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     linux@roeck-us.net, wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH 0/2] watchdog/hpwdt: Cleanup Claiming NMI
Date:   Wed,  8 Nov 2023 19:44:05 -0700
Message-ID: <20231109024407.120856-1-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: oJRol2yvXUVvUDTqIhiKTb_Taf-0tYDq
X-Proofpoint-ORIG-GUID: oJRol2yvXUVvUDTqIhiKTb_Taf-0tYDq
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_01,2023-11-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=834
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1011 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311090020
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to being a watchdog, hpwdt participates in error
containmnet on ProLiant systems.

On legacy platforms (Gen 8/Gen 9 and earlier) Fatal IO errors would be
signaled as an IO CHECK NMI with expectation that hpwdt would be present
to receive the NMI and crash the systems thus containing the error.

A problem was that hwpdt did not discriminate enough in accepting NMIs.
This could lead to problems if an NMI generated for another subsystems
was not claimed by that subsystem and became UNKNOWN and was claimed
by hpwdt.  Application profiling was such an example.  While, profiling
issue was fixed, hpwdt should avoid claiming NMI not intended for it.

In iLO 5 time frame, checks were added to make hpwdt more selective
in claiming NMI.  This patchset cleans up the checks and enables it
for future versions of iLO.


Jerry Hoemann (2):
  watchdog/hpwdt: Only claim UNKNOWN NMI if from iLO
  watchdog/hpwdt: Remove checks on ilo5

 drivers/watchdog/hpwdt.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

-- 
2.41.0

