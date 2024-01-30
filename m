Return-Path: <linux-kernel+bounces-43916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94233841AB4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03ED3280FF3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD52374FB;
	Tue, 30 Jan 2024 03:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="WMwvuKG7"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC16374D4
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 03:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706586723; cv=none; b=iI8lJ7NvexDAume/f99+XP3A23qgj5UfpD5aq5opUwpBry0AnBmeNDr4mYDpq2eYcTLY/wm3yh4KS0g9pC18CLoLnCQ+dsmskZqbQWZkzQJoR1gT1DPpFUnObTeWEu1qygf+KCgBufR4mV9hNddCOD4PDyVlYCPXd6fQr4qMQK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706586723; c=relaxed/simple;
	bh=mrSUsYr40vZLSd08HCa9ghUj2kZmeOFNxhdsAlHKBFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RK04/f3pc/+tRN16yoxohk7EVlHPBhXwWy3fgQ+ZDvZTV/r5ViSN+aPsMHnVU31NKnRyD2oWvmWBID0rLKilcY+7cbSChk+wO1J4XO3i7iwMLxTFW4xQkwIgF/9hNedDFub5ykSR6axN66bjUXYkAXyYHLThnfIzPQyCPOk8/Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=WMwvuKG7; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-337d05b8942so3041614f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1706586719; x=1707191519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3IAAtpYMk4Ivb7jeyKnDj3sOOnhVdi6sq/asAwlVHv0=;
        b=WMwvuKG7/TZq0DtcrOUKeNIi/YzL8SAR6/eYBRfInMYk35qTUihSVGabsN2y8Yqw82
         NdteorllG884xr66l8dkAf7qE/tu/rsBga+UiSlwDNGYQeTXJaPzPaicO1AbdCFu3j/A
         G5MnoTCR+AlsHVal7nK4jOa46AqfEJNvOc0Zzn1BRPzU96Pxk0DXH+aq7ynH1wbtHqCX
         VUuRuNyZsp0a23q4hZ9h5NriLK/OTFPo/f936MvWbxZojeTX47Rq3Z3rRDWnEnbdMna3
         Dvtx+NKuJAed/WsZunwNuZImE6YV9WwU++lhlM+Hn4JOuOqtGfbTThuQr839DC/wHQfi
         Ohuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706586719; x=1707191519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3IAAtpYMk4Ivb7jeyKnDj3sOOnhVdi6sq/asAwlVHv0=;
        b=MiuRDJssWEUz9+BcueYs96GcnSvXjulzqPf4MXlpvN9yeB8YiysgMNp2n6EffguFPU
         e5y/1T29qHTOEix4srJuZhwX7LiOwcd3TKkaGxjA1IG9Lu8vsNw68SBaYfPvePncrglQ
         WVXiqLNo/cJiLjICnoLni2/CNk877AuSmaXaAm/4twxpO4w2EBTlPR76we/ZiOyG4v78
         aUKnWNc7D+qLzdMW+mc5qv/uhKNA86Jh2cRorSvCy2JkD0SvvNFsp0NxJOHrY+mwtR+e
         VGAMx2+FgRm+8wUTt6ouK0d69sXvK+n8EG/eBWceUopx/Eged11qyl78s55Oli5n4tf+
         WTvQ==
X-Gm-Message-State: AOJu0YzreH2pVFkN7HbsUAixS98BN3wOtrAIValDSOX/BV8fFYSslWT8
	KN9QNnWfroRmNPtb8QZa+551yb/u2KCusAyVRe7Nm9C/BsVOy7qK9PrH7OEcBw==
X-Google-Smtp-Source: AGHT+IFgxB0xmRcPBgUyJL72I2YQDnGZRrMzC2LF6+dllvtCE0U8JpF0s4du7/8eXY30bDYq8rdv/A==
X-Received: by 2002:a05:6000:2c8:b0:33a:f521:7062 with SMTP id o8-20020a05600002c800b0033af5217062mr1762641wry.3.1706586719581;
        Mon, 29 Jan 2024 19:51:59 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id ay13-20020a5d6f0d000000b00337d6aa3912sm9513207wrb.10.2024.01.29.19.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 19:51:58 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Dmitry Safonov <dima@arista.com>,
	Mohammad Nassiri <mnassiri@ciena.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] selftests/net: A couple of typos fixes in key-management/rst tests
Date: Tue, 30 Jan 2024 03:51:51 +0000
Message-ID: <20240130-tcp-ao-test-key-mgmt-v2-0-d190430a6c60@arista.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-b6b4b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706586711; l=1089; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=mrSUsYr40vZLSd08HCa9ghUj2kZmeOFNxhdsAlHKBFc=; b=neGs9rbOA+EqGzLfMqyu3VFWcABDrXh0tWgdIRGzuXY3D1GWlihFguJm9kCKBjjMSM9vWnxAZ xt7XFjrr9fKA0St+JyMBuYUlSkQFRgyc0lvx0z3G+8M10EKps+dqft3
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

Changes in v2:
- Dropped "selftests/net: Clean-up double assignment", going to send it
  to net-next with other changes (Simon)
- Added a patch to rectify RST selftests.
- Link to v1: https://lore.kernel.org/r/20240118-tcp-ao-test-key-mgmt-v1-0-3583ca147113@arista.com

Two typo fixes, noticed by Mohammad's review.
And a fix for an issue that got uncovered.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
Dmitry Safonov (2):
      selftests/net: Rectify key counters checks
      selftests/net: Repair RST passive reset selftest

Mohammad Nassiri (1):
      selftests/net: Argument value mismatch when calling verify_counters()

 .../testing/selftests/net/tcp_ao/key-management.c  |  46 ++++---
 tools/testing/selftests/net/tcp_ao/lib/sock.c      |  12 +-
 tools/testing/selftests/net/tcp_ao/rst.c           | 138 ++++++++++++++-------
 3 files changed, 124 insertions(+), 72 deletions(-)
---
base-commit: ecb1b8288dc7ccbdcb3b9df005fa1c0e0c0388a7
change-id: 20240118-tcp-ao-test-key-mgmt-bb51a5fe15a2

Best regards,
-- 
Dmitry Safonov <dima@arista.com>


