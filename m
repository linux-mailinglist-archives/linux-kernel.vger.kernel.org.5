Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AA87A8EBC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 23:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjITVyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 17:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjITVyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 17:54:13 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1892C2;
        Wed, 20 Sep 2023 14:54:06 -0700 (PDT)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38KKZ5v9012940;
        Wed, 20 Sep 2023 21:54:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=401RkIsBm8+RyBq3OiEml3w7eS8f7JgbEqIt2lqRc8s=;
 b=kHhHbFN0KxaDGpjpj6l0BdbGiCbCoVmfDELH+YFa9paeQ4Udm7OrjgkV9TiTHRflJiia
 9piPh2mk+tux6usFAnjH744CsQbQh5jTcRoGQu03jP0AYZ873f6acAGUcYnEKVfPAY7a
 ncluKq2OLrvxPFTbKXQz+m0mwkqxStV+MguuyLMU16uQt1Y/wp8E4C8x4vphwsSOtpN6
 mmOkcifhNftdG3Ph38NmOdl7lKn1w3S4L3Y+LeoCE7+AFMrtwOoUhLRG/sLcxBDV1ZSO
 fw16ueW8SGnepAJeb5CDUhws+BJIih0ch1EdkCabDJrCtwilGgI7vv7m9veTMyG6T/xS Jg== 
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3t86wks0pf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 21:54:02 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 6B7E2130E9;
        Wed, 20 Sep 2023 21:54:01 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id C59578155BE;
        Wed, 20 Sep 2023 21:54:00 +0000 (UTC)
From:   charles.kearney@hpe.com
To:     charles.kearney@hpe.com, verdun@hpe.com, nick.hawkins@hpe.com,
        broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/1] spi: spi-gxp: BUG: Correct spi write return value
Date:   Wed, 20 Sep 2023 21:53:38 +0000
Message-Id: <20230920215339.4125856-1-charles.kearney@hpe.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: bs-6mKt9Bz0dHTAFp4kYjv9CRTHtLFU8
X-Proofpoint-GUID: bs-6mKt9Bz0dHTAFp4kYjv9CRTHtLFU8
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_11,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 adultscore=0 clxscore=1011 impostorscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=609 classifier=spam adjust=0 reason=mlx scancount=1
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

Charles Kearney (1):
  spi: spi-gxp: BUG: Correct spi write return value

 drivers/spi/spi-gxp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.25.1

