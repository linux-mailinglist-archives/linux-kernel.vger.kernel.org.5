Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D177A8EBD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 23:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjITVyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 17:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjITVyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 17:54:13 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEA4B9;
        Wed, 20 Sep 2023 14:54:07 -0700 (PDT)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38KFeUev025626;
        Wed, 20 Sep 2023 21:54:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=12kpuxrRo97RqCotnj8M2mYZ2N/X3gSL1FIm8u5ldDk=;
 b=Bbli87M5wsdJyb/NGX7fbr7Lmo5h+7hxuxNVJlQT/+EqklOv1iDaVDSFG2UyGpSlQ04g
 EFR/bDxa1nPIlbx5ltUJTsLXDfYIFtZpZZQlV2iAKv9QOaRTz/VgOUl/+gUJ1qJHl/QI
 U9+85LiGN7F4BhHVZUCjCWuv828UZrwmjiMuQ9GsvrUtC7TNu8rRTDyFzLZCCvj18Cgl
 BNJkY9EMxeo3dSPkGEYuuWlHgvQeOw08f7QZuXp9jkT+ZEVEAFMgaICu28MYZbg6H/AO
 uQo1j7Ltk7F673T3o4Lbtitrlgrzv18dhJPksrtQSslPkYTgwdOkeuydn14TpbSAjQde Sg== 
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3t83k0jvr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 21:54:04 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 6D5901318B;
        Wed, 20 Sep 2023 21:54:03 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id BFF39816835;
        Wed, 20 Sep 2023 21:54:02 +0000 (UTC)
From:   charles.kearney@hpe.com
To:     charles.kearney@hpe.com, verdun@hpe.com, nick.hawkins@hpe.com,
        broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] spi: spi-gxp: BUG: Correct spi write return value
Date:   Wed, 20 Sep 2023 21:53:39 +0000
Message-Id: <20230920215339.4125856-2-charles.kearney@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230920215339.4125856-1-charles.kearney@hpe.com>
References: <20230920215339.4125856-1-charles.kearney@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8ZbI35OioMJc6Q0O4Sh2ORdeRh5W68bq
X-Proofpoint-ORIG-GUID: 8ZbI35OioMJc6Q0O4Sh2ORdeRh5W68bq
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_11,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309200183
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charles Kearney <charles.kearney@hpe.com>

Bug fix to correct return value of gxp_spi_write function to zero.
Completion of succesful operation should return zero.

Fixes: 730bc8ba5e9e spi: spi-gxp: Add support for HPE GXP SoCs

Signed-off-by: Charles Kearney <charles.kearney@hpe.com>
---
 drivers/spi/spi-gxp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-gxp.c b/drivers/spi/spi-gxp.c
index fd2fac236bbd..3aff5a166c94 100644
--- a/drivers/spi/spi-gxp.c
+++ b/drivers/spi/spi-gxp.c
@@ -194,7 +194,7 @@ static ssize_t gxp_spi_write(struct gxp_spi_chip *chip, const struct spi_mem_op
 		return ret;
 	}
 
-	return write_len;
+	return 0;
 }
 
 static int do_gxp_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
-- 
2.25.1

