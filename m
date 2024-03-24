Return-Path: <linux-kernel+bounces-113271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 445DE8882FD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8F46B22BC6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB5618AFD3;
	Sun, 24 Mar 2024 22:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OX67gb4x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BC8136E27;
	Sun, 24 Mar 2024 22:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320071; cv=none; b=swgmjsjHEFrsfZ1dP+HwS3uGpC84KTthiCEiuC8owoxhZS9eaN5aQqAZ29KJHc5cIUsBdtrMBr3AzfzY9I+EJHCuDrlMSIsi230EaV7CHh5rOWjBCZ4XWFBxt2NIkkCswXjzvdfxigSydcDnuk+fznBccXvokhzuWR+9Bcv87s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320071; c=relaxed/simple;
	bh=gMPS2vvjXy5HnoZPJSlfOwuKwICB67VYD2q0qu8sqvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ae2LUULl1WEObnKEjkPgX/Emfzd3gO6ew7iAfySFtWNjYjCfghl42jg62gFeM2UFE/noAZqXFj5ghqh0MqaKcz55zJrklehp15YEEMUiUfVp+L6B+CDxdGa4PcwWQ33RgmKaqfe7YjWRB2kvo0gEjGg5M9VCwmG7MUhhG/7Oebc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OX67gb4x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1B8C433C7;
	Sun, 24 Mar 2024 22:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320071;
	bh=gMPS2vvjXy5HnoZPJSlfOwuKwICB67VYD2q0qu8sqvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OX67gb4xWoegb4PHrcE+l+Da4+nWGPmHZJbKVn7YM+DYJ7IIJ7kr0/piaI8LvSnen
	 pJ4rjXMDIQcdtizjJW274Y1Y4qqxcjzxwqgn51VvFPzHknWf7qakm3ei5QUvpLtkgl
	 ira+JBgqrrRVxKCcaLX0WX1djcNA0pspoeNI4ZRxXkSvA+iQzViyJIVV9aJYc4b27B
	 ypQ7UOTFpNetFWYrJFT4hgIiekd8/z5uowPutDT98H24xVMDstUx5OfQLx/M6Lzh2l
	 3f4tHWInvpslahDc7XlvZUA7DZ+T3zA+ZCX9JoejFe6bxyee/Y/evG23tU1pKfBxOT
	 fNQ8Jh5Jiiz0w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 380/715] crypto: qat - avoid memcpy() overflow warning
Date: Sun, 24 Mar 2024 18:29:19 -0400
Message-ID: <20240324223455.1342824-381-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 23a22e831ed4e6aa0831312e8cc8b7c60a657f60 ]

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
Acked-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c
index 9985683056d5f..f752653ccb47e 100644
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
2.43.0


