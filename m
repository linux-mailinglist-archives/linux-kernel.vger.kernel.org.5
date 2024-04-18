Return-Path: <linux-kernel+bounces-150762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9038AA43C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CF251C2260F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BC0190690;
	Thu, 18 Apr 2024 20:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dU7FHAXm"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908362E416
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 20:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713473258; cv=none; b=LjiXFzAypwL7r827GlmyQ8/TfeTaAJCHtKZA+OxT9Kdo1F7r38IM55H3IiawZ802UqOczsLl7NMVjA9Ke2v2MoUVX8LPbD+BpVrfEalKmRee5+TEwlInPzFWCnP1n+cJOZaRl2UBHOLXCvpRXtvio3cgvDnazRg5oPbGrOHIWn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713473258; c=relaxed/simple;
	bh=eCAy2VzoQXirIWoHOWI7tU2DYxh8NcxGLr5VGh+V2JE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RdVNiAFmf2hgbCP7qzusPCdha6fz1tJzW20D27/mCjOdX6MRrmsSO1FNKaLoaOfYa8sC2Vmi4IxsKlKkvad2evnpdY6HIItLq9JP6ncd8u2+4lwTLdeLZ9iU89Nkh6soCDTN5Z/S+4NZcAjZG+QARojpg4vKavp0sd4ZGZlgc+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dU7FHAXm; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7d6230233f9so36980339f.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 13:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713473256; x=1714078056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=52Z7ajLFl+Lp6hpQ+qIhOmgAmJ2GpzNTauSk+OYPNpY=;
        b=dU7FHAXmMvmPKpLAeNjZFTwOeY1q9sOd4XGTO0gaIqOSpBPGC0vmLaabTlTfeSw7jv
         dsyVtVQbuEO4jioGms9RHH7EKX5Y16amH4b4gpAwHj2dfDISSoyt/qIuVywkfRWa7ZUL
         2pLp342l6/louXr68w8uQw7GZsM6lILu81xPXptE7EDgNxnvTVZlYb2bgvLv7DjtNBlE
         6x3ruf5EPwIhbLKuQEMyLQxP1eQu7DZEGP41rDI21BGfwj4A2xW4G1rC44+3B3MePwzf
         3dD35+lGlJtPhJdrKgWaoR5LMWqNYqFq4iGGpG7/Jx20bGmV0dbpom6s3XHOL/7isgH1
         fmog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713473256; x=1714078056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=52Z7ajLFl+Lp6hpQ+qIhOmgAmJ2GpzNTauSk+OYPNpY=;
        b=W6IY1NKqQu4IKAH7VNFH2cIROuQENxGDskTfZoNOmOfAJRb+Sdckbvv/emYjN24tdx
         PXEzb7ajFv88hvxC8IutaHbwDEZZvocUyrchol9PXttJRYE/JFAJG6bpYu53Kx1J4yP7
         KXYEUVsBkw7eM3JbdzyBVYvmkWv6GjF+3WO4TtL3q6H/ANM07GNZ7VxG9ej5slBX297o
         fILJltpCJInSzYZjrOY9Quuw8tHgOOmb0t/Q/+duARhS7xILNODlpR/doJRz/yBp5pxp
         YbR9gcBdbfskkd/L/luMpw2cWi6mMY6LO0cYiinBLr7/HdEhkM6/cVoLHVmMk204hzzw
         MNng==
X-Forwarded-Encrypted: i=1; AJvYcCUpX/Xba/JizfFa85V0ArA2Bvem5aqhXBBjzyfOhzqVUMMdPZCsV2O+xW55y9J1iLmQKJKPr4VD6IvlsUTzsKS38IftGUg3UfJk4Wbm
X-Gm-Message-State: AOJu0YyfEPr13/I9PoMKMMzpMBb8x2orAm3baa8B+dfDbKJ4u+nkiujL
	YHjR04ZKfxLKN5paw43YzrcHXf4vBskhZzbd5XXVO9FcrI2VkkgoreDFLFHMQpM=
X-Google-Smtp-Source: AGHT+IG9c7gZDLzp7o26MzKD0Jvqz5A4e/DSQBl0MOwp/717k36BPHRYODJyVnFCA1TiCSnAPJLSCA==
X-Received: by 2002:a6b:4e15:0:b0:7da:18b8:a4fb with SMTP id c21-20020a6b4e15000000b007da18b8a4fbmr411697iob.9.1713473255769;
        Thu, 18 Apr 2024 13:47:35 -0700 (PDT)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id r6-20020a056638300600b00484948cb8f5sm626998jak.91.2024.04.18.13.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 13:47:35 -0700 (PDT)
From: Alex Elder <elder@linaro.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mka@chromium.org,
	andersson@kernel.org,
	quic_cpratapa@quicinc.com,
	quic_avuyyuru@quicinc.com,
	quic_jponduru@quicinc.com,
	quic_subashab@quicinc.com,
	elder@kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/8] net: ipa: eight simple cleanups
Date: Thu, 18 Apr 2024 15:47:21 -0500
Message-Id: <20240418204729.1952353-1-elder@linaro.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains a mix of cleanups, some dating back to
December, 2022.

The first two make it so the IPA SUSPEND interrupt only gets enabled
when necessary.  That make it possible in the third patch to call
device_init_wakeup() during an earlier phase of initialization, and
remove two functions.

The next patch removes IPA register definitions that are never used.
The fifth patch makes ipa_table_hash_support() a real function, so
the IPA structure only needs to be declared rather than defined when
that file is parsed.

The sixth patch fixes improper argument names in two function
declarations.  The seventh removes the declaration for a function
that does not exist, and makes ipa_cmd_init() actually get called.
And the last one eliminates ipa_version_supported(), in favor of
just deciding that if a device is probed because its compatible
matches, that device is assumed to be supported.

					-Alex

Alex Elder (8):
  net: ipa: maintain bitmap of suspend-enabled endpoints
  net: ipa: only enable the SUSPEND IPA interrupt when needed
  net: ipa: call device_init_wakeup() earlier
  net: ipa: remove unneeded FILT_ROUT_HASH_EN definitions
  net: ipa: make ipa_table_hash_support() a real function
  net: ipa: fix two bogus argument names
  net: ipa: fix two minor ipa_cmd problems
  net: ipa: kill ipa_version_supported()

 drivers/net/ipa/ipa_cmd.h            |  8 ------
 drivers/net/ipa/ipa_endpoint.h       |  6 ++---
 drivers/net/ipa/ipa_interrupt.c      | 38 +++++++++++++++++++++++++---
 drivers/net/ipa/ipa_main.c           | 16 +++---------
 drivers/net/ipa/ipa_power.c          | 19 --------------
 drivers/net/ipa/ipa_power.h          | 14 ----------
 drivers/net/ipa/ipa_table.c          |  8 +++++-
 drivers/net/ipa/ipa_table.h          |  7 ++---
 drivers/net/ipa/ipa_version.h        | 18 -------------
 drivers/net/ipa/reg/ipa_reg-v3.1.c   | 14 ----------
 drivers/net/ipa/reg/ipa_reg-v3.5.1.c | 14 ----------
 drivers/net/ipa/reg/ipa_reg-v4.11.c  | 14 ----------
 drivers/net/ipa/reg/ipa_reg-v4.5.c   | 14 ----------
 drivers/net/ipa/reg/ipa_reg-v4.7.c   | 14 ----------
 drivers/net/ipa/reg/ipa_reg-v4.9.c   | 14 ----------
 15 files changed, 51 insertions(+), 167 deletions(-)

-- 
2.40.1


