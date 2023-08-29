Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC16A78C824
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237145AbjH2O6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237149AbjH2O6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:58:16 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92594BC;
        Tue, 29 Aug 2023 07:58:12 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37TBwgZB019602;
        Tue, 29 Aug 2023 15:40:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=YRG7/1LKonbXReVVMUzYv6d5sYbYplVCZHB7ICikVjE=; b=b4
        TV0rmKjy7gKGpMJIzHDi1cjDRl3JOpB2Gmnc+KCywe+vrB1NrwlHDu8KIFE1rZ2s
        j3CjqacchVgAdIx9P6TWIoirNcKPdIC8u6ujH23Ppc5YV55TwseKaxBlYtXgVoiV
        Vxg232uMKYSFDq1hAaC3mA8Xszj0tRe02LF8H5E/ywpf9XTrNP6xe0k5YGbufY/v
        TqncmDOjC5OV1EbCkk2wojCFSOeEIiqcj2Wf2mDrCw81ETCUfAsbtq/7SYCEkIXs
        AWNDJ8Dy8XX/mVpSMUFqXHHJPMp/SuuntJgiFqHPEanMvx+Ua/3W6XsZ7DIunjAM
        s4FlvpxOuKHwQgPt0XTg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sq6tfmchf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 15:40:56 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DBB7E100057;
        Tue, 29 Aug 2023 15:40:55 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CBC612207DB;
        Tue, 29 Aug 2023 15:40:55 +0200 (CEST)
Received: from localhost (10.201.22.39) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 29 Aug
 2023 15:40:54 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <william.gray@linaro.org>, <lee@kernel.org>
CC:     <alexandre.torgue@foss.st.com>, <fabrice.gasnier@foss.st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/8] counter: chrdev: fix getting array extensions
Date:   Tue, 29 Aug 2023 15:40:22 +0200
Message-ID: <20230829134029.2402868-2-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230829134029.2402868-1-fabrice.gasnier@foss.st.com>
References: <20230829134029.2402868-1-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.22.39]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_10,2023-08-29_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to watch a component array extension, and the array isn't the
first extended element, it fails as the type comparison is always done on
the 1st element. Fix it by indexing the 'ext' array.

Example on a dummy struct counter_comp:
static struct counter_comp dummy[] = {
	COUNTER_COMP_DIRECTION(..),
	...,
	COUNTER_COMP_ARRAY_CAPTURE(...),
};
static struct counter_count dummy_cnt = {
	...
	.ext = dummy,
	.num_ext = ARRAY_SIZE(dummy),
}

Currently, counter_get_ext() returns -EINVAL when trying to add a watch
event on one of the capture array element in such example.

Fixes: d2011be1e22f ("counter: Introduce the COUNTER_COMP_ARRAY component type")
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/counter/counter-chrdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter-chrdev.c
index 80acdf62794a..afc94d0062b1 100644
--- a/drivers/counter/counter-chrdev.c
+++ b/drivers/counter/counter-chrdev.c
@@ -247,8 +247,8 @@ static int counter_get_ext(const struct counter_comp *const ext,
 		if (*id == component_id)
 			return 0;
 
-		if (ext->type == COUNTER_COMP_ARRAY) {
-			element = ext->priv;
+		if (ext[*ext_idx].type == COUNTER_COMP_ARRAY) {
+			element = ext[*ext_idx].priv;
 
 			if (component_id - *id < element->length)
 				return 0;
-- 
2.25.1

