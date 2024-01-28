Return-Path: <linux-kernel+bounces-41966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D37983FA1C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 22:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0306E281E48
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0243C47B;
	Sun, 28 Jan 2024 21:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="P7F6ClQb"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE633C6BF
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 21:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706477233; cv=none; b=ATGO49erGmIMcMo7xHgEVZNS1nd19LEZGLTjR6gzucWxDeWdBYIHlzgl34AnKiwFIuWc8AXwqKhCoQh0xVW/n0ES8lnNImxH2d8Z0CMBmeh4i32dw135ppUUWh9xxcHqomTPP1fFCd2Yi5y0RgeQTG9fZ1hNyFJYCjF/WbIcKpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706477233; c=relaxed/simple;
	bh=X7GxPWHVGWr0pAtWSlpO57lcSUC3wBBKJbyyqChk0Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fGoUklJ8JrDDeSc3TFHyDjTSl+1ei98uXU9jwtwWu9uXnJfb0jtg87t7NDklF+J0ZJyRqvNBxGTK0GBcYYoHe7/J0yptR9fUd2InYnxZLJOeRGyehjiTVLVC0b8RwoVeujrKwK0NHZKiY8jP1Kxxb8t44dzxB/1/JWhOL12WnFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=P7F6ClQb; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40eb033c1b0so28990185e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 13:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706477229; x=1707082029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B7nI+FYl2ATWbeRP7p2e7xChOwqiLITgmr8UQN8vuDU=;
        b=P7F6ClQbiQXpHRdB0IHLu7xGSI7U3XW2K58HgYoore+DWlxYgFxxUuIS7eiB1RXfRK
         JoElx8X82isgZx4OkpFIzMJZRkt0gXLLKSTV7MxUUCas+eV1ITFRQ2phnnJycr7Fsu7p
         cI74b3uNmcj8vUTgXmgkxg2pR/KFXQZ1f5qnjniKqlrCCcO9wzD6hctxWUyxCuJrhb1n
         sU6RE2h0m4lLaMA7Os2vxDscuuI6MpPAkXj3TuKhXjWgxeki1SORaYQCM3CrjCwl7rgN
         Spejv/E8mrnkhysJzzMEJGXAGEE7zIU9piHcZ+8o1QmLbyThsYjCdnZjjZMh6akqcm1B
         IDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706477229; x=1707082029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B7nI+FYl2ATWbeRP7p2e7xChOwqiLITgmr8UQN8vuDU=;
        b=Ju3Sk3gQg5lcM30GyEn2rmsVDzfoLuG0MHqB0hEjNhoa+6zJ3XccBaOPQ2N+JJvwHe
         l1Q4r6Fgy2DhQmrTJ/19yN2Xk5rQ4Zf7WeddfED5JPAkNWvbfyK3PLdXEHxetWIfpcYB
         8iBLkJRNrAqqS23xshcld6aFUn8wqRuUrq7Cs6miBjTlo4Q1xbUIt+47VCIxEbt/Mg5O
         kKbb9zE8jGfGwY8U3ybiRtclbxRFq6vLxP84gLM3BmcWTFM2GQifFqa+c6VtM1HhYJ7J
         qXw8oaHOHvfNdL4iiSfdyVvxHff63UGLSdap6ju5EeZXgjYPXYZfoej961/29fw/cK/E
         fe2A==
X-Gm-Message-State: AOJu0YyOTNAB5UsqlB8erJMiQIlqMuyvkjOpJgobYVAWubOwybXTBO0A
	83ayZq3fbkYcQqufzda3pLovSwtHNwaa3qIXRnSmmh2ZgLgmErsasfeGb0LPrDQ=
X-Google-Smtp-Source: AGHT+IFu8QXXPo8dGWJsDB1FFkwtblLK2klQlj7lq11rghmXbYS3OjEeGSMPM7tmIom/YJycOxS7Bg==
X-Received: by 2002:a05:600c:19cf:b0:40d:91fd:74e with SMTP id u15-20020a05600c19cf00b0040d91fd074emr3402248wmq.15.1706477228778;
        Sun, 28 Jan 2024 13:27:08 -0800 (PST)
Received: from vermeer.ba.rivosinc.com (lfbn-mon-1-1176-165.w90-113.abo.wanadoo.fr. [90.113.119.165])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c315100b0040d62f89381sm8218208wmo.35.2024.01.28.13.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 13:27:08 -0800 (PST)
From: Samuel Ortiz <sameo@rivosinc.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Samuel Ortiz <sameo@rivosinc.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Qinkun Bao <qinkun@google.com>,
	"Yao, Jiewen" <jiewen.yao@intel.com>,
	"Xing, Cedric" <cedric.xing@intel.com>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	biao.lu@intel.com,
	linux-coco@lists.linux.dev,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/4] tsm: Runtime measurement registers ABI
Date: Sun, 28 Jan 2024 22:25:19 +0100
Message-ID: <20240128212532.2754325-1-sameo@rivosinc.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some confidential computing architectures (Intel TDX, ARM CCA, RISC-V
CoVE) provide their guests with a set of measurements registers that can
be extended at runtime, i.e. after the initial, host-initiated
measurements of the TVM are finalized. Those runtime measurement
registers (RTMR) are isolated from the host accessible ones but TSMs
include them in their signed attestation reports.

All architectures supporting RTMRs expose a similar interface to their
TVMs: An extension command/call that takes a measurement value and an
RTMR index to extend it with, and a readback command for reading an RTMR
value back (taking an RTMR index as an argument as well). This patch series
builds an architecture agnostic, configfs-based ABI for userspace to extend
and read RTMR values back. It extends the current TSM ops structure and
each confidential computing architecture can implement this extension to
provide RTMR support.

Changes since v1 [1]:
- Removed the abilty for userspace to configure the TCG PCR mappings. The
  configfs attribute for the TCG PCR mapping is now RO, and the mapping is
  passed from the TSM provider as a static bitmap.
- Document the added tsm-configs attributes.

TODO:

- Event log support.

[1] https://lore.kernel.org/lkml/20240114223532.290550-1-sameo@rivosinc.com/

---

Samuel Ortiz (4):
  tsm: Runtime measurement register support
  tsm: Add RTMRs to the configfs-tsm hierarchy
  tsm: Map RTMRs to TCG TPM PCRs
  tsm: Allow for extending and reading configured RTMRs

 Documentation/ABI/testing/configfs-tsm |  36 +++
 drivers/virt/coco/Kconfig              |   1 +
 drivers/virt/coco/tsm.c                | 376 +++++++++++++++++++++++++
 include/linux/tsm.h                    |  39 ++-
 4 files changed, 451 insertions(+), 1 deletion(-)

-- 
2.42.0


