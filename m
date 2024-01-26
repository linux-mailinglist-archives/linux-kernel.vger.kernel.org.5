Return-Path: <linux-kernel+bounces-40515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 505A983E1CA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 059401F26D54
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA80722334;
	Fri, 26 Jan 2024 18:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OYim8Ygq"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C5521A0C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 18:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706294378; cv=none; b=nijmX5VQ5qjrtFe3TRSAHyUdsthUOLryDElv6RFRTj+XM03LqBvDCHiKu96uAH6rw+SF2MiSYpKkTjePOWGaAQfiIiKp1ZHPOLotGQlLB231qs0yJMU3/xthJ4/JiK1YRGglOXYEN2dcMbJul+Lu2qIi+nhrT/xBRJEjjmENyD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706294378; c=relaxed/simple;
	bh=pBwTJx9vqo4YpKH1g0zLKQIz+09wVpQoiwp6B3aMnxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=babBTxf1hD7TxYIaqED+B8iz2uVfxhKtGTnBkwBsTI7gb7PKCWhKVJBpI1Fw8Hk48+QvfoKxc/1k0xZpoEvJDb8MvvmWZc1WVVjnto4YJOMTforyABKFEOH3LPg58/tPZxVQbJh5Qs2Cov1AxQZ2xPV8DQcYBYZEH1UMNbF52mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OYim8Ygq; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ddc162d8d5so539820b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 10:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706294377; x=1706899177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S8hCjCIj0wY+btghjatqQCYEGwLIKeiKm/Edu/1s92Y=;
        b=OYim8YgqV/OQwKnAhAW8/8hi4LKOxbI7nM4ezzvyMfMmzOFesbclJh/YNdbsE1eWfj
         q1TT4R9LudMdEfY/3yYoUUsgASlYIPjliH3h5Z9dj9pZIJHXam4EJ2eUlW2+wMMVnFjN
         MfP8GkvrzfipJwhoB+3vCHQqUpNTD8WOM3F5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706294377; x=1706899177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S8hCjCIj0wY+btghjatqQCYEGwLIKeiKm/Edu/1s92Y=;
        b=C4n2CTR0ythhBaKSLMrHZtlhkndErmpLvCJK7VV5d+x32apvOu4CnjY4rQyF6zm7tk
         7OjbN2p0DbaW/fsy4oE7DSjuLmFk0sZpfwAKwX4mdlGRk9iV3VdzBYZsJPv+oNRaXR0P
         TsQ0ANAFDv14VNF4bq2zxYGMnVF9svNIQszSD5tQJRASSy2RsRDOLO7qR9IQk96rGdfv
         GcvQW/Hfh5CdQ6GFNmnj3X3PpRdw2KR9Zw0+6Y2DDi5C7WRvZBix6yzJdjcwq4J5bzBf
         f2Tdso/Kjg/1uZ0Cwun2cIydNt2a99MNdofJbXrPGyqEKzirGZmvmU2BJY64Yxa13WFF
         j6Qw==
X-Gm-Message-State: AOJu0YwgW6/z8h+Mtqb/zyFL8ZtNtPJPRdhbcMJxsc55X22NHRzxnxj5
	z8F9vsPxefSz/vHYmGzp3gxCPl0LEXweur+x+zbEyDRVJxYcPhNdGHz7Lh7WNQ==
X-Google-Smtp-Source: AGHT+IG7XNIvN59laEmO3o+Ym7WWwMrQ8+43ShcapMGKBG2Q+rfb2evR/7Vp9/nfR15l55IWoB9EUQ==
X-Received: by 2002:a62:6287:0:b0:6dd:7d11:41dd with SMTP id w129-20020a626287000000b006dd7d1141ddmr187072pfb.69.1706294376535;
        Fri, 26 Jan 2024 10:39:36 -0800 (PST)
Received: from localhost (209.148.168.34.bc.googleusercontent.com. [34.168.148.209])
        by smtp.gmail.com with UTF8SMTPSA id y12-20020aa7854c000000b006dbd3aec001sm1446879pfn.146.2024.01.26.10.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 10:39:36 -0800 (PST)
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org
Cc: pmalani@chromium.org,
	jthies@google.com,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Prashanth K <quic_prashk@quicinc.com>,
	Rajaram Regupathy <rajaram.regupathy@intel.com>,
	Saranya Gopal <saranya.gopal@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] usb: typec: ucsi: Adding support for UCSI 3.0
Date: Fri, 26 Jan 2024 10:39:06 -0800
Message-ID: <20240126183930.1170845-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Hi Heikki,

This series starts the work adding UCSI 3.0 support to the UCSI driver.

There's a couple of pieces to start here:
* Add version checks and limit read size on 1.2.
* Update Connector Status and Connector Capability structures.
* Expose Partner PD revision from Capability data.

These were tested against on a 6.6 kernel running a usermode PPM against
a Realtek Evaluation board.

One additional note: there are a lot more unaligned fields in UCSI now
and the struct definitions are getting a bit out of hand. We can discuss
alternate mechanisms for defining these structs in the patch that
changes these structures.

Thanks,
Abhishek

Changes in v3:
  - Change include to asm/unaligned.h and reorder include.

Changes in v2:
  - Changed log message to DEBUG
  - Formatting changes and update macro to use brackets.
  - Fix incorrect guard condition when checking connector capability.

Abhishek Pandit-Subedi (3):
  usb: typec: ucsi: Limit read size on v1.2
  usb: typec: ucsi: Update connector cap and status
  usb: typec: ucsi: Get PD revision for partner

 drivers/usb/typec/ucsi/ucsi.c | 49 +++++++++++++++++++++++++--
 drivers/usb/typec/ucsi/ucsi.h | 64 ++++++++++++++++++++++++++++++++---
 2 files changed, 107 insertions(+), 6 deletions(-)

-- 
2.43.0.429.g432eaa2c6b-goog


