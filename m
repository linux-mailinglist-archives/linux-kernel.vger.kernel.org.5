Return-Path: <linux-kernel+bounces-55100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B44184B7B5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F0E31C2413F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5352C132485;
	Tue,  6 Feb 2024 14:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iPjD2+eQ"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B1B132464
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 14:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229344; cv=none; b=RoquLQfpdIRwh0kUCApiHW7rGCCZPg8y5LBBZ8XnuFc2MV2j/D8nGUUyWP5qtikiaec2XRtETr34fuco/Og/7FOAqS9iAZjUQ3t437vGaDN6+gatEh71Aj7YfksN92cpeiJggvBbdI4nEFF5JT4j60F5epkHnEAOkX2GcPbMvs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229344; c=relaxed/simple;
	bh=N/9Ng0mptj3yfICy4oXN/goI9UnQpSxOz06ZQI6nYk4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fk9cWvHvExIH9ucxuOe+J6h/gqunfK4P8n4afPgMuxk+pWU+9S311+gyxO+HP0ays8Xta9j1I3r1muor7BRAIuurFJiQAay0YHRkq7DD/3w1Kxt2pDzmv3LjAJ/dC3klC4WzQFEkfAYiXMA79wuuJzTgXPyp/jGOB83YJKr46MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iPjD2+eQ; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5cddfe0cb64so4434685a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 06:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707229342; x=1707834142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FVP1DxUpo+ofSaUtbzPuqV5g3cinNO86Vhy9zsQ/NBE=;
        b=iPjD2+eQB6nMUGe7r80Masu64Wdb+MizHpoO4SCzoEklFvalMvN9aVLLT2AliBvEZc
         wrc9WZ2mQHKDWEeZ/5UDURHuOkhLPyDNmvZdif8k3sbfa9x1PCAHpBJgbd4pvb74jRBn
         92yBPTGdZt3pulkRgHtYlUDbD0tfJWhBOCqLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707229342; x=1707834142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FVP1DxUpo+ofSaUtbzPuqV5g3cinNO86Vhy9zsQ/NBE=;
        b=EMuhgZUddo+xNQoYuwwFZxTOZDzOc49TYFw/f+7lcmbcaLltRX+oAsygEIxWZu4Tg8
         2VbV4mTQ3e+JQ/IesXRoPrIGkjO6UehF9QvSFaxHoD8kzg32u6G7JgVJZb77YtaiqCwi
         722vCSyYsYVTH2riYHNjmchiXTmZg5ySBzkSKUGqJbuVhwuSgxxHaw6PDqFQk1nsLcyf
         iVfg8EDyJExpQx0DIHGPjUXOEailnNa5HBxM11IUzUTnFBsRofGpIe1A1ppXM5Vfwn4j
         alUbcm4YNqS8TUFTa/hyXqhuMnGvVlgBRaHQORiGX+2Ox43z7U+rd+kmnmv6+ov+xUef
         heEA==
X-Gm-Message-State: AOJu0Yye8HddTlHVyNeVKQU8SRAD1ZGzXOJFvpYEAMiWm2j5CTu+qZWn
	VjlXhjSCsaIvSfrOFJFmid1B5fzxzMDx+Agex19Jo4LnSfbLc0WjZ0Xdns1KuA==
X-Google-Smtp-Source: AGHT+IH/3ADw/HbP9zFsOFQ97SPi8x0OoCSu+gr7lpgWke9HOoS3ZeJ4o/PV81Wj/ab2B0zOGOClZQ==
X-Received: by 2002:a17:90a:4383:b0:290:2e08:74f1 with SMTP id r3-20020a17090a438300b002902e0874f1mr2626348pjg.21.1707229342188;
        Tue, 06 Feb 2024 06:22:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWPxfA7XDSG5g6bhg3dsfrLg38TsikqCieodE01W5MEzy8FgkoYKvX7R3zoTzFVBW6R3Ewy+lqL/j2J1ZQgoasXI4eBNWEBdwJOwc/iN8btJZVe8R/F24jckH8NQ08sQnTbbHCUcESjJvCcyVrZagBs0S1OY1lw0NozhK2x7Ja9Ca9DYp68sKFopMyUgNBZ8bHN2fc4hl2WdTSv04UnQnuG3jINc6YSba81fKpjgliToDdYYQISVxm6bMd33IL96ikkslYy/QMvJQBGgtQ5a6pWhhlyIVfcuG8bWcCSVR9x9sBjT5VhHsY2la5V8SYx3JU/wX2AhNEwjmkXyJdOCCeeoV6niyDttCRHZFQ2a4TY1lL77Hq9ePAN7bnN8vgmF9yt0aLGE9tegfTih8IVpAYHta0wbGPAN2eRhdsAzxtlBA34xqhm718rnGBXxIJeU1EkgWaCd+KhO8U4tUuzFEJv
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id mp2-20020a17090b190200b00296a23e407csm1705112pjb.7.2024.02.06.06.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 06:22:21 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Richard Weinberger <richard@nod.at>,
	Justin Stitt <justinstitt@google.com>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	kernel test robot <lkp@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: [PATCH v3 0/4] string: Allow 2-argument strscpy()
Date: Tue,  6 Feb 2024 06:22:15 -0800
Message-Id: <20240206142027.make.107-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1391; i=keescook@chromium.org;
 h=from:subject:message-id; bh=N/9Ng0mptj3yfICy4oXN/goI9UnQpSxOz06ZQI6nYk4=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlwkCbqdvmObeC2JAjTy6W0ePQ7fBIrpU8TfXOX
 1DqzXoUD22JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcJAmwAKCRCJcvTf3G3A
 JhEBD/0QqU6lHe80a/AJmrCeyaqtRaXjj/Bcvu9wchmIDYzBanX533oOQubDDX8umogbgp9KFZu
 vYHxnbWpa7BMU6T1dbi/qaIq65DUgE2Ua3M0ls2K97w3GUK4Zdi7mWCklFTES9g+d/evbaGBY9S
 d8NdGIx635IuR+HuIVUQFbKYAt36Aa/dpCyaoy85r5MQrtPh+nk0kg4VCykw08qASuRnO3GWRyu
 VrIJROzHgupw289j/ZRJ9MA92uOH6NUMnJ8hhdeSjNbasrsua/lUGrdtvwFlAi27h6Rl6UMo9xT
 40SoIVEfIAP2c9mpzwRh+fjWqHs5sQFXZakE/FW2negR1aXQ4Inkenjt7fHIOXqeqsFkQFE3a93
 TNjUwRHcJB5OO2ecY6dkGTxXPyoqmlNnzVu9fpuUyz728RagPqL6z3Qd0OHdpmOfHmDo5mR8O5i
 yvwAzT++xzJW/pcRy3V+6avXfnWGFB5lyxaEB/E5oqNYoV0BAyghXynz7MTUNDQ0a6OhR3H+/BB
 xPIhJmiE1zGG8JUcXEkk0Ay3mR2YCalYDnjOwn6qsbLbBgmdeQasAwZJbVtZkkDDvThfYjaBWme
 0siDo27zJMjBojTDaUj+wUihyJadmGRRWUQAe1cgA6TKvEXVZYGiYA1Ohehr3mUj4nfl3agifLl
 axMBwjq f9ga4MeA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

v3:
 - add missed args.h include (andy)
v2: https://lore.kernel.org/all/20240205122916.it.909-kees@kernel.org/
v1: https://lore.kernel.org/all/20240131055340.work.279-kees@kernel.org/

Hi,

Make it possible for strscpy() and strscpy_pad() to use 2 arguments,
making "sizeof(dst)" be the the default 3rd argument for the destination
size. This can make future usage much easier to read. Additionally allows
treewide changes to save a bunch of lines:
 1177 files changed, 2455 insertions(+), 3026 deletions(-)

-Kees

Kees Cook (4):
  string: Redefine strscpy_pad() as a macro
  string: Allow 2-argument strscpy()
  string: Allow 2-argument strscpy_pad()
  um: Convert strscpy() usage to 2-argument style

 arch/um/drivers/net_kern.c               |  2 +-
 arch/um/drivers/vector_kern.c            |  2 +-
 arch/um/drivers/vector_user.c            |  4 +-
 arch/um/include/shared/user.h            |  3 +-
 arch/um/os-Linux/drivers/ethertap_user.c |  2 +-
 arch/um/os-Linux/drivers/tuntap_user.c   |  2 +-
 arch/um/os-Linux/umid.c                  |  6 +-
 include/linux/fortify-string.h           | 22 +------
 include/linux/string.h                   | 76 +++++++++++++++++++++++-
 lib/string.c                             |  4 +-
 lib/string_helpers.c                     | 34 -----------
 11 files changed, 88 insertions(+), 69 deletions(-)

-- 
2.34.1


