Return-Path: <linux-kernel+bounces-30865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 031C5832543
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36AC81C23620
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EC8D52B;
	Fri, 19 Jan 2024 07:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dtqw5KNs"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CBAD51D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 07:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705650519; cv=none; b=i43P0RhgLycdzDuKG5nWNjnpUN6eO4WZTTQENHgBj8kasWDb8nrgP0g3hE5MJKXQX+ElhlwzjQh9Tb2WqBdm3rOJhCP5oN5NJDiU2SxudRqWtBkj49V87S2cmCT090Vz/KvtnUwNc0qFqGeFRE6yXcA6dBgOPCFrFWEPadSJsMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705650519; c=relaxed/simple;
	bh=ebbJ6bA1dlgy/6ZtQSvyFQkwF2mZTYLPxjDz3eZfPdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WiuTsMerZOvZBQ/YcwQ9jWsMe2O2hLK0rhYVImLyyzmHqwGqzE/55P+vpJTlmJJQdWBXzXPvtr7NjtpXy1pRZltjg5dWxoY/1Vz3MsUb1XX6ttlRs80HjsdQgmEh4IqHPYzQJ5olpnv54oRNcJaolkKIGbw1hFu2SHELRX+cLmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dtqw5KNs; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6d9b5c4f332so372480b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 23:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705650517; x=1706255317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nXGjBm0+HOq1i2RiP/xgovqiQd2Jx9NrE+bGhtMDLmQ=;
        b=dtqw5KNsbDefq64UP+wgTUqnsEAn4ScsQRHKp80TQ+WpAAAH8cOTxN/Aq8rsafVS4y
         r9aRkUwks1e7cnbxnlc1thPavmNOLrTbaXJRxjuoIof2exp3SctAM4SWgnysMx906EuJ
         aCTlAILQK7+FAi8A2gK0Hhz6ZHfA623kPKCKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705650517; x=1706255317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nXGjBm0+HOq1i2RiP/xgovqiQd2Jx9NrE+bGhtMDLmQ=;
        b=rRGXIYFZ9MwjIVer0e+lutba+sNqCzaXG1Q8TaYlA+BESncXhKmXkoRIqUXdYpEg4H
         IfCYqBBHynVVCJ5h0e9jjp793rrTE9kIosj1W7DfIDDxsDW4N/3u+/KdNUA86nQXXhvH
         uP5oolAz4UXrXMpn2bLZ3+Y0hTPgcBWZPUiszX44EzQAAQyNMdkQexSrEraYPSdwX0Qe
         n+L92b/J+KWXsc3xCTP6O8leXb3YZNNSJFtUd+HUP+2+cDCNae71K7FEsHUuQdQdFd88
         7RqH+PKvVjeX/GYco3jz0tpObPv4sFhlkJ82E/Csh572gQprxm89HuEp3nfwMPrZadeO
         oABQ==
X-Gm-Message-State: AOJu0YxezBHcq0mnvnQBSPnhCb0dTu2Jnz3D7oD5BrTYpnvJPEMtyTYD
	/80TLAvk2YLj5P6ima+yu9TjcCFwwChvT9Hhtc6mvXy7qB1Gf8a/IHi1MIcpb6lVfDGWqCr2adM
	=
X-Google-Smtp-Source: AGHT+IHQna9e3X42lqrWFOSQZQYMAmVaV6Zoi5bSDcbYwGwoWzErrSZ7syFdmAt05s4X8B7fmLNpGw==
X-Received: by 2002:a05:6a20:9154:b0:19a:e212:46c with SMTP id x20-20020a056a20915400b0019ae212046cmr1736163pzc.95.1705650516771;
        Thu, 18 Jan 2024 23:48:36 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:a5a9:5dbc:778d:db07])
        by smtp.gmail.com with UTF8SMTPSA id j14-20020a170902da8e00b001d4b1d190e3sm2435533plx.58.2024.01.18.23.48.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 23:48:36 -0800 (PST)
From: Ting Shen <phoenixshen@chromium.org>
X-Google-Original-From: Ting Shen <phoenixshen@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: fshao@chromium.org,
	Ting Shen <phoenixshen@google.com>,
	Benson Leung <bleung@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <groeck@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	chrome-platform@lists.linux.dev,
	=?UTF-8?q?joewu=20=28=E5=90=B3=E4=BB=B2=E6=8C=AF=29?= <joewu@msi.com>,
	linux-input@vger.kernel.org
Subject: [PATCH v2] Input: cros_ec_keyb: add support for base attached event
Date: Fri, 19 Jan 2024 15:48:17 +0800
Message-ID: <20240119074831.2979671-1-phoenixshen@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a new type of ChromeOS detachable keyboard that talks to
the host via CrOS EC host command interface, rather than the USB
interface.

To trigger the firmware update daemon (hammerd) on this keyboard, a
signal is required to replace the typical USB hotplug event. This patch
addresses this by mapping the EC's BASE_ATTACHED event to SW_DOCK.

Signed-off-by: Ting Shen <phoenixshen@google.com>
---

Changes in v2:
- update commit message

 drivers/input/keyboard/cros_ec_keyb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index 30678a34cf647..d2e0d89d4ffdf 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -128,6 +128,11 @@ static const struct cros_ec_bs_map cros_ec_keyb_bs[] = {
 		.code		= SW_TABLET_MODE,
 		.bit		= EC_MKBP_TABLET_MODE,
 	},
+	{
+		.ev_type	= EV_SW,
+		.code		= SW_DOCK,
+		.bit		= EC_MKBP_BASE_ATTACHED,
+	},
 };
 
 /*
-- 
2.43.0.429.g432eaa2c6b-goog


