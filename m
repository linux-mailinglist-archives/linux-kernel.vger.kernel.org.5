Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E595B76CC2E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbjHBL7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjHBL7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:59:35 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E16213D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 04:59:34 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742bso71927545e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 04:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690977572; x=1691582372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bp5xBL2+ZyetnS6R/9E4VPAMDlUiJg//neyQGE8mAn8=;
        b=xDAla6uTyC2qwpkOA3lcBp7p6CRW+qzxhUfu1bcdl5YZMnW/kZWFZUfpHkBNzYsxG8
         R2NU+tBQ5sqURKvVW/500rdx4qZ+X0OS2T5IDCA5BwmV+yU+Y+3m6RIhb+jwCWsRtugA
         Pgz4cv4ld7P74eDFrQMLH0h4Y0tRzDW4G+HrTqoHurHdZhFu0lgntnigIkxnpVXMOqia
         sz06gmuwQaDPzlMjBk9vlIkNaJIudhLZiY/rDt7Gerx2BJpW16ZphJ9cv5TcIisOkByx
         WFS1ZFbfbw2W55BXL2yTBQBFwIG71MldYmUpZp5dpY6MYkkmXIhbYYTynVx5KyYo6oyM
         fcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690977572; x=1691582372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bp5xBL2+ZyetnS6R/9E4VPAMDlUiJg//neyQGE8mAn8=;
        b=UQeza08YexNwFhGKw9wfsefZxfp1YAwMMky5Yjd5mLNYcBAhIfPCxHGpXE+V9zfVCW
         eTmgRDPVpfWYIPN5yTrVDIv+G7q2PEbSAPbnVC3gE24FVTPLI1sIjfnHp82043mB7JEd
         vZzMEo6DqC89az3PZt+OqfMt+3rNjKsy44Jbpj1irMQmjkPSLQ2sJiO4j0R37aWtc/8E
         CtjwlC5f3kvGtA6BOkNlWWNGmpp/FvKnHaz4tTb5xtMAYiMdM0DpEy71bD2MvfZOxKkd
         egOYpD7JhE6FVZ6uHw0mtu9Izjfzf4YCnPBFUzhR8tVFgIp4LXXEHzPKPdNu/va6V+Ab
         LeAg==
X-Gm-Message-State: ABy/qLaI+HnZsBdxqxaZ+3yNfQKSHRPZ3Wc6M81zp9k3QHffhqjHZPYz
        o2cJHRwgCRzkFCCiPcVB3sEuqg==
X-Google-Smtp-Source: APBJJlHXTDoc9PC8kQ7qJTabUhxGNnHLykNg77MkUglnWffppm7AHP8+coyKULDEiciGu67SwJb4NA==
X-Received: by 2002:a05:600c:219a:b0:3fe:2108:eb8e with SMTP id e26-20020a05600c219a00b003fe2108eb8emr4601718wme.34.1690977572714;
        Wed, 02 Aug 2023 04:59:32 -0700 (PDT)
Received: from localhost.localdomain (cpc98982-watf12-2-0-cust57.15-2.cable.virginm.net. [82.26.13.58])
        by smtp.gmail.com with ESMTPSA id n16-20020a1c7210000000b003fe1630a8f0sm1502871wmc.24.2023.08.02.04.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 04:59:32 -0700 (PDT)
From:   Rajnesh Kanwal <rkanwal@rivosinc.com>
To:     anshuman.khandual@arm.com
Cc:     acme@kernel.org, broonie@kernel.org, catalin.marinas@arm.com,
        james.clark@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        mark.rutland@arm.com, maz@kernel.org, mingo@redhat.com,
        peterz@infradead.org, robh@kernel.org, suzuki.poulose@arm.com,
        will@kernel.org, atishp@rivosinc.com
Subject: Re: [PATCH V13 - RESEND 09/10] arm64/perf: Implement branch records save on task sched out
Date:   Wed,  2 Aug 2023 12:59:31 +0100
Message-Id: <20230802115931.12212-1-rkanwal@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230711082455.215983-10-anshuman.khandual@arm.com>
References: <20230711082455.215983-10-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
>index 203cd4f350d5..2177632befa6 100644
>--- a/drivers/perf/arm_brbe.c
>+++ b/drivers/perf/arm_brbe.c
>@@ -165,6 +165,36 @@ static int stitch_stored_live_entries(struct brbe_regset *stored,
> 	return min(nr_live + nr_stored, nr_max);
> }
> 
>+static int brbe_branch_save(struct brbe_regset *live, int nr_hw_entries)
>+{
>+	u64 brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
>+	int nr_live;
>+
>+	write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
>+	isb();
>+
>+	nr_live = capture_brbe_regset(live, nr_hw_entries);
>+
>+	write_sysreg_s(brbfcr & ~BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
>+	isb();
>+
>+	return nr_live;
>+}
>+
>+void armv8pmu_branch_save(struct arm_pmu *arm_pmu, void *ctx)
>+{
>+	struct arm64_perf_task_context *task_ctx = ctx;
>+	struct brbe_regset live[BRBE_MAX_ENTRIES];
>+	int nr_live, nr_store, nr_hw_entries;
>+
>+	nr_hw_entries = brbe_get_numrec(arm_pmu->reg_brbidr);
>+	nr_live = brbe_branch_save(live, nr_hw_entries);
>+	nr_store = task_ctx->nr_brbe_records;
>+	nr_store = stitch_stored_live_entries(task_ctx->store, live, nr_store,
>+					      nr_live, nr_hw_entries);
>+	task_ctx->nr_brbe_records = nr_store;
>+}

Asking out-of-curiosity. Have you thought about virtualization use
case. Current LBR implementation create an event for the guest
and save/restore happens using the sched_task callback. (Correct me
if I am wrong). Given you are only saving and processing those saved
entries, how do you plan to expose the entries to the guest?

Thanks
Rajnesh

>+
> /*
>  * Generic perf branch filters supported on BRBE
>  *
>diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
>index 408974d5c57b..aa3c7b3dcdd6 100644
>--- a/drivers/perf/arm_pmuv3.c
>+++ b/drivers/perf/arm_pmuv3.c
>@@ -923,9 +923,19 @@ static int armv8pmu_user_event_idx(struct perf_event *event)
> static void armv8pmu_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
> {
> 	struct arm_pmu *armpmu = to_arm_pmu(pmu_ctx->pmu);
>+	void *task_ctx = pmu_ctx ? pmu_ctx->task_ctx_data : NULL;
> 
>-	if (sched_in && armpmu->has_branch_stack)
>-		armv8pmu_branch_reset();
>+	if (armpmu->has_branch_stack) {
>+		/* Save branch records in task_ctx on sched out */
>+		if (task_ctx && !sched_in) {
>+			armv8pmu_branch_save(armpmu, task_ctx);
>+			return;
>+		}
>+
>+		/* Reset branch records on sched in */
>+		if (sched_in)
>+			armv8pmu_branch_reset();
>+	}
> }
