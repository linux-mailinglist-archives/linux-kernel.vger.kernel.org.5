Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51CB7C6E05
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 14:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378604AbjJLMZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 08:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbjJLMZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 08:25:17 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9A1B7;
        Thu, 12 Oct 2023 05:25:15 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39CCAf88007899;
        Thu, 12 Oct 2023 08:25:13 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3tpd4t19ps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 08:25:13 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 39CCPCVl020590
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Oct 2023 08:25:12 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 12 Oct
 2023 08:25:11 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 12 Oct 2023 08:25:11 -0400
Received: from rbolboac.ad.analog.com ([10.48.65.174])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 39CCP3l0015110;
        Thu, 12 Oct 2023 08:25:06 -0400
From:   Ramona Gradinariu <ramona.gradinariu@analog.com>
To:     <jic23@kernel.org>, <nuno.sa@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: [PATCH 0/1] adis16475.c: Remove scan index from delta channels
Date:   Thu, 12 Oct 2023 15:24:55 +0300
Message-ID: <20231012122456.765709-1-ramona.gradinariu@analog.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: A7bPD2gnjI8SsBDYPa43pvTCYOzuzWey
X-Proofpoint-ORIG-GUID: A7bPD2gnjI8SsBDYPa43pvTCYOzuzWey
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=973 bulkscore=0
 clxscore=1011 malwarescore=0 spamscore=0 phishscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2310120101
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices do not support delta angle and delta velocity
burst readings, which means there should be no buffer support
for these types of channels.
A new list of channels is created which contains the delta
channels structures with the scan index equal to -1 to allow
for raw register readings, without buffer support.
This list of channels is assigned to the devices which
do not support delta angle and delta velocity burst
readings.
This is a fix for the bug which was introduced with
8f6bc87d67c0 ("iio: imu: adis16475.c: Add delta angle and delta velocity channels").

Ramona Gradinariu (1):
  drivers: imu: adis16475.c: Remove scan index from delta channels

 drivers/iio/imu/adis16475.c | 67 +++++++++++++++++++++++++------------
 1 file changed, 46 insertions(+), 21 deletions(-)

--
2.34.1

