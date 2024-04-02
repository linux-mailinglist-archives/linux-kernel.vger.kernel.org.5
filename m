Return-Path: <linux-kernel+bounces-127795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4639895112
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E548E1C228D4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39C975802;
	Tue,  2 Apr 2024 10:57:40 +0000 (UTC)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE1C69D29;
	Tue,  2 Apr 2024 10:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055460; cv=none; b=uUnCHmC6aTNEhsLX5tUrpNf9KYZlfvnmjFHRuXeQC4B47iiPrNEg6KMtpCmNXwvxRZTxzNgmZRsRrUqSu8zdfu5qH1DS2K6J1OxQdDZ1rQ1ERFR+pDcXz3ZnLtovTKYGyFoVECg1vmjblAegqswwAtvd8Ffqpi1SO51XnTLX0r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055460; c=relaxed/simple;
	bh=ZRYL0tm66PlUF17wSgS7t8Otxaj80Ds/bGY0ik9xez0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XTvdUiASRAOq2GgqjZk69B4YI/VXBud+a4Z85DfyuF8qwo7/a2yjlwN5IbGDv2pYtukNm4yVRcHj8Lh8p6aNfNy0OftExtv59dOGxPOfrjyuFrvuEGW9ukzHUEG+TOR28K+P0FQYOEwZXqWrzO1Pk1QXNOMa9S3TdfPShX8D4GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz8t1712055389tx1i9do
X-QQ-Originating-IP: npMTgiYLrAXZVfH9UzuoxN0WWf6arlNvluh0QgiuEPM=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 02 Apr 2024 18:56:27 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: U4uNK7LTfdrLsqLmQfZRWmU4TTRkTMv9/wdPfBCemXIxmWjsfkg+yE23RLl3O
	yWmO4DknxnZb8FXBxhPsu+CxpuKghtgmdZ/+TJh6K9lHe2TQubcT4IShhqebXjQGM4q3Hrj
	zOc1wfOasA6I5o/rp9VAxtkYDeVIfvj2UmXRBDh+Nr9d9Cp7C57Bq6dFKn0Gu4TWBFuWcYi
	ire/ACUxmnnxV+hEysx2faHEQDe+0cpPtVYQBYsnB7E5Yzg1ORvgFWqUvMYXw0xDajbWtPp
	dgRKhs7VVA0IrpYjQyFzNuVhDufUh4cU+tqhKr5jBMyFSnclf/lrBOBQf7hi+SbnlO6NFs1
	BrGVJ/2WLsuWjm2WgFV1AujEFu1qVc4TvZCZzkAAEHeXXshTcix1WGHgb7bRz5/0CCacN9I
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 13364674971117449586
From: Dawei Li <dawei.li@shingroup.cn>
To: will@kernel.org,
	mark.rutland@arm.com
Cc: xueshuai@linux.alibaba.com,
	renyu.zj@linux.alibaba.com,
	yangyicong@hisilicon.com,
	jonathan.cameron@huawei.com,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH 0/9] perf: Avoid explicit cpumask var allocation from stack 
Date: Tue,  2 Apr 2024 18:56:01 +0800
Message-Id: <20240402105610.1695644-1-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi,

This series try to eliminate direct cpumask var allocation from stack
for perf subsystem.

Direct/explicit allocation of cpumask on stack could be dangerous since
it can lead to stack overflow for systems with big NR_CPUS or
CONFIG_CPUMASK_OFFSTACK=y.

For arm64, it's more urgent since commit 3fbd56f0e7c1 ("ARM64: Dynamically
allocate cpumasks and increase supported CPUs to 512").

It's sort of a pattern that almost every cpumask var in perf subystem
occurs in teardown callback of cpuhp. In which case, if dynamic
allocation failed(which is unlikely), we choose return 0 rather than
-ENOMEM to caller cuz:
@teardown is not supposed to fail and if it does, system crashes:

static int cpuhp_issue_call(int cpu, enum cpuhp_state state, bool bringup,
                            struct hlist_node *node)
{
        struct cpuhp_step *sp = cpuhp_get_step(state);
        int ret;

        /*
         * If there's nothing to do, we done.
         * Relies on the union for multi_instance.
         */
        if (cpuhp_step_empty(bringup, sp))
                return 0;
        /*
         * The non AP bound callbacks can fail on bringup. On teardown
         * e.g. module removal we crash for now.
         */
	#ifdef CONFIG_SMP
        if (cpuhp_is_ap_state(state))
                ret = cpuhp_invoke_ap_callback(cpu, state, bringup, node);
        else
                ret = cpuhp_invoke_callback(cpu, state, bringup, node,
		NULL);
	#else
        ret = cpuhp_invoke_callback(cpu, state, bringup, node, NULL);
	#endif
        BUG_ON(ret && !bringup);
        return ret;
}

Dawei Li (9):
  perf/alibaba_uncore_drw: Avoid explicit cpumask var allocation from
    stack
  perf/arm-cmn: Avoid explicit cpumask var allocation from stack
  perf/arm_cspmu: Avoid explicit cpumask var allocation from stack
  perf/arm_dsu: Avoid explicit cpumask var allocation from stack
  perf/dwc_pcie: Avoid explicit cpumask var allocation from stack
  perf/hisi_pcie: Avoid explicit cpumask var allocation from stack
  perf/hisi_uncore: Avoid explicit cpumask var allocation from stack
  perf/qcom_l2: Avoid explicit cpumask var allocation from stack
  perf/thunder_x2: Avoid explicit cpumask var allocation from stack

 drivers/perf/alibaba_uncore_drw_pmu.c    | 13 +++++++++----
 drivers/perf/arm-cmn.c                   | 13 +++++++++----
 drivers/perf/arm_cspmu/arm_cspmu.c       | 13 +++++++++----
 drivers/perf/arm_dsu_pmu.c               | 18 +++++++++++++-----
 drivers/perf/dwc_pcie_pmu.c              | 17 +++++++++++------
 drivers/perf/hisilicon/hisi_pcie_pmu.c   | 15 ++++++++++-----
 drivers/perf/hisilicon/hisi_uncore_pmu.c | 13 +++++++++----
 drivers/perf/qcom_l2_pmu.c               | 15 ++++++++++-----
 drivers/perf/thunderx2_pmu.c             | 20 ++++++++++++--------
 9 files changed, 92 insertions(+), 45 deletions(-)


Thanks,

    Dawei

-- 
2.27.0


