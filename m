Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590027F9EE2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 12:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbjK0Lpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 06:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233304AbjK0Lpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 06:45:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8A1B8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 03:45:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22067C433C8;
        Mon, 27 Nov 2023 11:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701085558;
        bh=/SPiK+nM81I2NeYQHSsmaqOtUX9qlKShEsdKW1Xgo54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UeV3OYeyFIr9Ll7fbpmmGpyz3uKF6e8h1RE9Ih3UtcFmzDu0xe7stOLB1kFa45cHP
         7W8ETpegQt1J09gK3AsGsrDpQkD7B+S6Ay/ql3oI3xwDpgkq4ytSAZ097Hf2mPStFA
         O/r00GFVG3GFyOip9cnRuvAVkRI2s8sazdq8BN7xqAE4zcRQ6JGxm7rcG/MmyB+/B3
         galFOVHPSFyvL5PB+8HKkS3gc9Knb59lyOum3+FCZRrTu30n97RVYwvMKZvLP9u2YR
         QTsrz80hpMJwNYudGnXE1aYUctgC4m7yEFwRhJN3wmx2sfTPMWnsuKTaLy0U+TKwwH
         71Bmx6gOs7bNw==
From:   djakov@kernel.org
To:     linux@roeck-us.net, sam@gentoo.org, gregkh@linuxfoundation.org
Cc:     akpm@linux-foundation.org, allen.lkml@gmail.com, conor@kernel.org,
        f.fainelli@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, lkft-triage@lists.linaro.org,
        patches@kernelci.org, patches@lists.linux.dev, pavel@denx.de,
        rwarsow@gmx.de, shuah@kernel.org, srw@sladewatkins.net,
        stable@vger.kernel.org, sudipm.mukherjee@gmail.com,
        torvalds@linux-foundation.org, djakov@kernel.org
Subject: [PATCH 5.10] interconnect: qcom: Add support for mask-based BCMs
Date:   Mon, 27 Nov 2023 13:45:51 +0200
Message-Id: <20231127114551.1043891-1-djakov@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <05678c48-bac1-4f17-99f8-21b566c17a6e@roeck-us.net>
References: <05678c48-bac1-4f17-99f8-21b566c17a6e@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Georgi Djakov <djakov@kernel.org>

From: Mike Tipton <mdtipton@codeaurora.org>

[ Upstream commit d8630f050d3fd2079f8617dd6c00c6509109c755 ]

Some BCMs aren't directly associated with the data path (i.e. ACV) and
therefore don't communicate using BW. Instead, they are simply
enabled/disabled with a simple bit mask. Add support for these.

Origin commit retrieved from:
https://git.codelinaro.org/clo/la/kernel/msm-5.15/-/commit/2d1573e0206998151b342e6b52a4c0f7234d7e36

Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
[narmstrong: removed copyright change from original commit]
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230619-topic-sm8550-upstream-interconnect-mask-vote-v2-1-709474b151cc@linaro.org
Fixes: fafc114a468e ("interconnect: qcom: Add SM8450 interconnect provider driver")
Fixes: 2d1f95ab9feb ("interconnect: qcom: Add SC7180 interconnect provider driver")
Signed-off-by: Georgi Djakov <djakov@kernel.org>
---

There is a build error reported in the 5.10.201 stable tree (arm64 allmodconfig),
which is caused by a patch that has a dependency we missed to backport. This is
the missing patch that we need to get into 5.10.202 to fix the build failure.
Thanks to Guenter and Sam for reporting that!

 drivers/interconnect/qcom/bcm-voter.c | 5 +++++
 drivers/interconnect/qcom/icc-rpmh.h  | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
index 3c0809095a31..320e418cf753 100644
--- a/drivers/interconnect/qcom/bcm-voter.c
+++ b/drivers/interconnect/qcom/bcm-voter.c
@@ -90,6 +90,11 @@ static void bcm_aggregate(struct qcom_icc_bcm *bcm)
 
 		temp = agg_peak[bucket] * bcm->vote_scale;
 		bcm->vote_y[bucket] = bcm_div(temp, bcm->aux_data.unit);
+
+		if (bcm->enable_mask && (bcm->vote_x[bucket] || bcm->vote_y[bucket])) {
+			bcm->vote_x[bucket] = 0;
+			bcm->vote_y[bucket] = bcm->enable_mask;
+		}
 	}
 
 	if (bcm->keepalive && bcm->vote_x[QCOM_ICC_BUCKET_AMC] == 0 &&
diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
index e5f61ab989e7..029a350c2884 100644
--- a/drivers/interconnect/qcom/icc-rpmh.h
+++ b/drivers/interconnect/qcom/icc-rpmh.h
@@ -81,6 +81,7 @@ struct qcom_icc_node {
  * @vote_x: aggregated threshold values, represents sum_bw when @type is bw bcm
  * @vote_y: aggregated threshold values, represents peak_bw when @type is bw bcm
  * @vote_scale: scaling factor for vote_x and vote_y
+ * @enable_mask: optional mask to send as vote instead of vote_x/vote_y
  * @dirty: flag used to indicate whether the bcm needs to be committed
  * @keepalive: flag used to indicate whether a keepalive is required
  * @aux_data: auxiliary data used when calculating threshold values and
@@ -97,6 +98,7 @@ struct qcom_icc_bcm {
 	u64 vote_x[QCOM_ICC_NUM_BUCKETS];
 	u64 vote_y[QCOM_ICC_NUM_BUCKETS];
 	u64 vote_scale;
+	u32 enable_mask;
 	bool dirty;
 	bool keepalive;
 	struct bcm_db aux_data;
