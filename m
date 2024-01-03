Return-Path: <linux-kernel+bounces-15746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D0B823141
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 963911C23A65
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866D41BDC9;
	Wed,  3 Jan 2024 16:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgtnolu1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F821BDC3;
	Wed,  3 Jan 2024 16:26:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F45C433C7;
	Wed,  3 Jan 2024 16:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704299174;
	bh=4rFtZTk/CSyYTYOlTo0igxEY+Pn+iCcuCMqZdpDydfA=;
	h=From:To:Cc:Subject:Date:From;
	b=dgtnolu1WIZU8u9TNIazyOPm19CpnM1XlsbkNFKQkH8J0QKToEEfqrritT0jYywN4
	 GTBc0Rclz4+tl+qH0gPvLMbVpJ8g72+YMmC2fQ2YcjSvMez2e1AyZWJsSJPMh4wx3s
	 ny0jcXRCby8yyS59WQxbAXZnGqn1n/6AzYbt9iRqDq7S2WHCkTPn5x/2Ke7UpSKock
	 UQpeffL/NvTlzISkfplQZk2Qr2lH/Fky0h6zu1b781LrXbx0xoCpNsRtX7RD7H78Aq
	 /yBqjMD4kvHmmr6YpuBuMk9heTJGqi+CTY2k218GEcpK5sPcxMEqEHEVtnD0/aE/P9
	 aHKUTLB89BsGw==
From: Arnd Bergmann <arnd@kernel.org>
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Damian Muszynski <damian.muszynski@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Jie Wang <jie.wang@intel.com>,
	qat-linux@intel.com,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: qat - avoid memcpy() overflow warning
Date: Wed,  3 Jan 2024 17:26:02 +0100
Message-Id: <20240103162608.987145-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The use of array_size() leads gcc to assume the memcpy() can have a larger
limit than actually possible, which triggers a string fortification warning:

In file included from include/linux/string.h:296,
                 from include/linux/bitmap.h:12,
                 from include/linux/cpumask.h:12,
                 from include/linux/sched.h:16,
                 from include/linux/delay.h:23,
                 from include/linux/iopoll.h:12,
                 from drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c:3:
In function 'fortify_memcpy_chk',
    inlined from 'adf_gen4_init_thd2arb_map' at drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c:401:3:
include/linux/fortify-string.h:579:4: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
  579 |    __write_overflow_field(p_size_field, size);
      |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/fortify-string.h:588:4: error: call to '__read_overflow2_field' declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror=attribute-warning]
  588 |    __read_overflow2_field(q_size_field, size);
      |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Add an explicit range check to avoid this.

Fixes: 5da6a2d5353e ("crypto: qat - generate dynamically arbiter mappings")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c
index 9985683056d5..f752653ccb47 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c
@@ -398,6 +398,9 @@ int adf_gen4_init_thd2arb_map(struct adf_accel_dev *accel_dev)
 			 ADF_GEN4_ADMIN_ACCELENGINES;
 
 	if (srv_id == SVC_DCC) {
+		if (ae_cnt > ICP_QAT_HW_AE_DELIMITER)
+			return -EINVAL;
+
 		memcpy(thd2arb_map, thrd_to_arb_map_dcc,
 		       array_size(sizeof(*thd2arb_map), ae_cnt));
 		return 0;
-- 
2.39.2


