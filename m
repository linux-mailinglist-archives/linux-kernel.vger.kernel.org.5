Return-Path: <linux-kernel+bounces-59032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A8F84F019
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF43E1C2152A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 06:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE2857337;
	Fri,  9 Feb 2024 06:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UjXHhvXo"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C25A57307
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 06:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707458746; cv=none; b=PJ12dCDRL47SoQZPVlnLS85NXokMc0tI4rXMugFipuNzKH9S2uv3YOWeBTsmrGisaP6JczBhHnydnIWPLOqYUNHqUp/UJg6joECTrMoFkacp+c7OkwS/wJmewcgdOMDnPT90hCR/rF1sKbRzTL+83oMq2l5L8Y/YwlsP0k2D2Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707458746; c=relaxed/simple;
	bh=qO4AJqFeWco3A8E/6FW7maEYvxGUM+hVSdMsYUPmXqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HkiIJE6t6CgJVm2HEME/xksq+8JURZM6jiCzdHx8sgvYCZeonOVZda20iUqQAVayqcHc8O6XYGEizddZrOp5VMoweLD5ZTst8JWRBYbyVHz2zHLLVlpezHQd2eKnww9qYWAVPbUPIySuU++R4IXRrcn7u+Kur8baHeNJIJy2eHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UjXHhvXo; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d958e0d73dso4892215ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 22:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707458743; x=1708063543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wop2DZZiRdIetXEhCA50GkVFZGoE+ZvL11qzq1IkmSA=;
        b=UjXHhvXoIZsqYATBgAmW5O4yi1MJKQXq45+o0kwSMOLSkDK45zA8DTOeDR5l/kl4FL
         s6PcD8UCdd5iOmdf2HsYatS5riDz+wejPz0EB4d0zQDc4w0//0Itta9uzxlUFJhEF9MN
         cZdcLPzr/vosZBoZoheLh04aComZDz6ubwP2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707458743; x=1708063543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wop2DZZiRdIetXEhCA50GkVFZGoE+ZvL11qzq1IkmSA=;
        b=BITJRACL68eu68Yy5Qj8Y8397G2hKGc49adgKv0D90YabxCmserIiaD5OWuSn45Cok
         wminMoYm5cTeXzgMwQ3QSLpYYiNHbuZVzEtNFKzquskrv7oOQf92TfjEIK8BiEePXTwe
         0E2vs8tqiHlrniBfTn6A4SzznFEgkuxlTbHiLXx9oSgzfJnNnXlRxYphxoFhUGHez3V6
         iwYuZk3dJmBQOtYawuMY/9mAzuYv+6HJjJnEwOWX6RMJ2U9bCeDuLFCD7/Dn75PNvoDq
         o+kXUgaZtkQknV6OskpUKbf1ctH+hd3DaKVaoFyFTeqS9D2SQ/5GU9dB+FrDfo2u3hsv
         t/Ug==
X-Forwarded-Encrypted: i=1; AJvYcCXsUXLHllhUr9ny8GgwpPjVUFMNdThZkPrm0ceO2OrdvtUf1ikZSoDU/AobBnrQymNIaLDL6zwL5dcck6clK34JrRTjFM1tr+AeLCL3
X-Gm-Message-State: AOJu0YxGIWg1ohHN1V8M6+eQhlPhT+1wTR6FKXecZFoICDANo5O6lU8g
	bonW+xCUaaFA9nW+O19BqJj8pyHbMDawODX3oF7n4C7tr6F+DUIGKCeeK/03jA==
X-Google-Smtp-Source: AGHT+IG4blLrJAnRQ4dnM+k8vDlTA7W7qLBZ3PmOf8jOW1WLwU7k1jVGHHDdgbIl7jqfEAQKBIVlzQ==
X-Received: by 2002:a17:902:a3cc:b0:1d9:4e80:ceb6 with SMTP id q12-20020a170902a3cc00b001d94e80ceb6mr68511plb.8.1707458743364;
        Thu, 08 Feb 2024 22:05:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV6647CfHkfhQZv9Ckgr++w4OPqflA+xbPt4uXd4LLw2Ll7daZfyn/zuXc/cWKmleHRHaDYzIVVFFgnNoMlJUcpP5coUWL/2NYjon/XfZcGSg9zwV2M7FDYp0qidmePFWQ/jsr653prtM2cA02drdCrE6PQaSNDmpjRvnJCq5mZxq0iZbMsHJdAYd2urU7mce501l5IiB7E1qwQXgbWQGakux/oarY0EIRNfYSz4pZyXEFtH2l648V5RbHzMUGxH3ljWTtJW9CJPNekLLs2nSCag5G6oKbOBQEUIF26Ayo74oYwTe4VlSzAnoBGJPbF6kryfwZI0DIaxzAqszIwSlZlo91RvSvsQE9MNtSCgM1BmpnRURHtt0WaSQQLsEifbnNyYuzync9GjO5NtKjSSQDHXTnE0T8nnVimM0llW8FEOqHt/iGc2/e65OFWjo5oEwsgdeEN0ET0g6ANWgioCwnvWr6lt0h8OiPnQiOOUv7yszQjN9gPznxwEXz1a2lsNIdgTVabq7DHFWNsSSJFO68BtDc=
Received: from localhost (209.148.168.34.bc.googleusercontent.com. [34.168.148.209])
        by smtp.gmail.com with UTF8SMTPSA id kz6-20020a170902f9c600b001d9a91af8a4sm754421plb.28.2024.02.08.22.05.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 22:05:42 -0800 (PST)
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org
Cc: jthies@google.com,
	pmalani@chromium.org,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Prashanth K <quic_prashk@quicinc.com>,
	Rajaram Regupathy <rajaram.regupathy@intel.com>,
	Saranya Gopal <saranya.gopal@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] usb: typec: ucsi: Adding support for UCSI 3.0
Date: Thu,  8 Feb 2024 22:02:37 -0800
Message-ID: <20240209060353.6613-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
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

Changes in v4:
  - Added missing Tested-By tags from v1 and reviewed-by tags.
  - Fix BCD translation of PD Major Rev
  - Replace IS_MIN_VERSION macro and just compare version directly.

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

 drivers/usb/typec/ucsi/ucsi.c | 49 +++++++++++++++++++++++--
 drivers/usb/typec/ucsi/ucsi.h | 67 ++++++++++++++++++++++++++++++++---
 2 files changed, 110 insertions(+), 6 deletions(-)

-- 
2.43.0.687.g38aa6559b0-goog


