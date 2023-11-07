Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9CC7E459F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235450AbjKGQPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235598AbjKGQPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:15:32 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7711FD3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 08:07:11 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-280165bba25so4327210a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 08:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699373230; x=1699978030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YeRdeeSb2IKpx2tfb4UrcUCepKcV2HFO/DXXCsP2H4A=;
        b=uOI+SZrzQ8sBQ12076trZOSgVCPrrgt1wHZ1a1I/XzwvzGWS2fsboOyvQZtK5wQcoV
         K+EAqe0uTjm7UV6F6Tjc9SocFczj1fjShUrNcsQ1aEs0l8JVhIaMeCmJbOvkdbE5lQM6
         UkomqwcqFIUIQXyt1omRNo8zjgNgI81zKaf2paBkbD5NTBSwltM0PnyXWoiynauPcyN/
         nBji77ywo03/D7FX1vAxNyB1i7U9u4dINSR6nbyDfPgkV65nGomSE9vcqC9ihVPXOzsD
         KtvcSpi5dHIHSQrX/Rzy9q+s2QdqxzONxOGK154FBaHgJ4cD36Y9/3UIbaclXUNNuM5b
         fgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699373230; x=1699978030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YeRdeeSb2IKpx2tfb4UrcUCepKcV2HFO/DXXCsP2H4A=;
        b=EdjdEWFnskYQU7QreJhB0qRCdbdnvv/ripR0Iq3BSlCk2Lt5NBXfOfUfuBOUCCi/2Z
         NEOjml+hix7UghtPT/hGOQa47vNMp5K/rd3aKQ5BY7ZfAy1g4ByluLpkPj1g/6/OyZ4S
         BTGdxxXuAgV29nJxbTpaD+M7XNWrnPasWuFuDr4l8RVTs435Hz6ids4dx2eeoOBOcLMQ
         Jv2kPcnOX76txTN84yR5pvelEEEOhgycBiKxOlfcftaflBQEBYtKdFmFV8nJztsINODJ
         PIQNMB+wiPsz/OIFhxe/IGougjdZM2sgdsfAYcNrWs1NpeMi6CM8YL+9eyHqCpL+mtwZ
         v45w==
X-Gm-Message-State: AOJu0YyFnnohDEZL41QKs7teR4HRrlrZiFpYBpRgT8fbiVXlQlV6Y8ML
        SbM1+2RrYcazEVlmYd+nW7phcZfeR0nAaa77Uhg=
X-Google-Smtp-Source: AGHT+IEUl7PQ1Dx23fz6DZtKodWJAcf6vKRwOxs6cxfl1VYjOiKdN8lahOeIByc+wcRGLYimRQ8IRQ==
X-Received: by 2002:a17:90b:164f:b0:281:b68:98ef with SMTP id il15-20020a17090b164f00b002810b6898efmr4834907pjb.18.1699373230192;
        Tue, 07 Nov 2023 08:07:10 -0800 (PST)
Received: from rayden.urgonet (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id o3-20020a17090ab88300b002775281b9easm13437pjr.50.2023.11.07.08.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 08:07:09 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Olivier Deprez <Olivier.Deprez@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v2 0/2] OP-TEE FF-A notifications
Date:   Tue,  7 Nov 2023 17:06:55 +0100
Message-Id: <20231107160657.3798803-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patchset adds support for using FF-A notifications as a delivery
mechanism of asynchronous notifications from OP-TEE running in the secure
world. Support for asynchronous notifications via the SMC ABI was added in
[1], here we add the counterpart needed when using the the FF-A ABI.

Support for FF-A notifications is added with [2] and this patch set is based
on Sudeeps tree at [3].

[1] https://lore.kernel.org/lkml/20211103090255.998070-1-jens.wiklander@linaro.org/
[2] https://lore.kernel.org/linux-arm-kernel/20231005-ffa_v1-1_notif-v4-0-cddd3237809c@arm.com/
[3] https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/tag/?h=ffa-updates-6.7
    commit bcefd1bf63b1 ("firmware: arm_ffa: Upgrade the driver version to v1.1")

v1->v2:
* Applied Sumit's Reviewed-by
* Addressed Sumit's comment on "optee: ffa_abi: add asynchronous
  notifications"

Thanks,
Jens

Jens Wiklander (2):
  optee: provide optee_do_bottom_half() as a common function
  optee: ffa_abi: add asynchronous notifications

 drivers/tee/optee/call.c          | 31 ++++++++++-
 drivers/tee/optee/ffa_abi.c       | 93 ++++++++++++++++++++++++++++++-
 drivers/tee/optee/optee_ffa.h     | 28 ++++++++--
 drivers/tee/optee/optee_private.h |  9 ++-
 drivers/tee/optee/smc_abi.c       | 36 ++----------
 5 files changed, 155 insertions(+), 42 deletions(-)


base-commit: bcefd1bf63b1ec9bb08067021cf47f0fad96f395
-- 
2.34.1

