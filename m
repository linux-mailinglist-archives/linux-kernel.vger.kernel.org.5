Return-Path: <linux-kernel+bounces-7435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3299181A7E7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B953AB22ED9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 21:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB8E495C1;
	Wed, 20 Dec 2023 21:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mLsVrn9y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15960495C0
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 21:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d3f2985425so1200305ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 13:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703107024; x=1703711824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=plCzQlGY/dQiSudjgURo8kfQVZqgAHmTig4adjzQbPU=;
        b=mLsVrn9yiBztS01SR//uv45C26hTRNlRopDydr3b70El4edH3X1bxbJ9K/H55PAVck
         XlYnPjcskp1nPnSiAEXepBNwzJR77HQrX3Y/z5e5zBi8+bC1i0wjZCsJ7hgOUkPTJfH+
         nEvK39/6zQTJrk50WWeh9Z/QtugrnFGiZ+mY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703107024; x=1703711824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=plCzQlGY/dQiSudjgURo8kfQVZqgAHmTig4adjzQbPU=;
        b=wnHx0VuGEBLQSu9lu+pMTyFmA5ejkONyjWYliqlOi8d5l4HhzeO3PfCqe3xe0zQyRK
         TDNK8QlUyB49X1GNyS6r+JFSl2vYiJnJEmoes0FPHfjwx+74pxfAe7mGgNlmUFwxumrI
         BwCGZ9j5CZsE2MdxW1h5C5FHLgxcPath0m6uZI7qyt368Oq2E2FsuSnsgoyjkPnjfEaQ
         mYPYRVGKJt6hSgXYD5h6UoOrEeZ63WTqKpyk/ng4tAmFKbE6pcmWQLrZwfB3egPto5mh
         q85NA6oCNOcJ1IRVd1zPMFJsURQ8JJTXQt69KaCijvoPSo1r60vKb8t9o27ecHJCIpqS
         ahoQ==
X-Gm-Message-State: AOJu0YzEafK/CI1OCBE05y676y4XvMcD8nC++LIPmbnYlmRN/ceJLF0F
	edqxyOsRgXlaF2Bolo6o2K0TXg==
X-Google-Smtp-Source: AGHT+IH8Z9+yInrarq0mHLy0WlmppFY4B2k8ydNwc6zKBV+StP1lSQLEJUGCon+d8mQW4KRncDQIEw==
X-Received: by 2002:a17:902:680a:b0:1d3:4489:3681 with SMTP id h10-20020a170902680a00b001d344893681mr6572592plk.73.1703107024443;
        Wed, 20 Dec 2023 13:17:04 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:5a22:d46c:eec1:e5d4])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902b28a00b001d3dfebc05esm175023plr.21.2023.12.20.13.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 13:17:03 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>,
	Li Zhe <lizhe.67@bytedance.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	John Ogness <john.ogness@linutronix.de>,
	Lecopzer Chen <lecopzer.chen@mediatek.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] watchdog: Better handling of concurrent lockups
Date: Wed, 20 Dec 2023 13:15:33 -0800
Message-ID: <20231220211640.2023645-1-dianders@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


When we get multiple lockups at roughly the same time, the output in
the kernel logs can be very confusing since the reports about the
lockups end up interleaved in the logs. There is some code in the
kernel to try to handle this but it wasn't that complete.

Li Zhe recently made this a bit better for softlockups (specifically
for the case where `kernel.softlockup_all_cpu_backtrace` is not set)
in commit 9d02330abd3e ("softlockup: serialized softlockup's log"),
but that only handled softlockup reports. Hardlockup reports still had
similar issues.

This series also has a small fix to avoid dumping all stacks a second
time in the case of a panic. This is a bit unrelated to the
interleaving fixes but it does also improve the clarity of lockup
reports.


Douglas Anderson (4):
  watchdog/hardlockup: Adopt softlockup logic avoiding double-dumps
  watchdog/softlockup: Use printk_cpu_sync_get_irqsave() to serialize
    reporting
  watchdog/hardlockup: Use printk_cpu_sync_get_irqsave() to serialize
    reporting
  watchdog: If panicking and we dumped everything, don't re-enable
    dumping

 kernel/watchdog.c | 43 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 11 deletions(-)

-- 
2.43.0.472.g3155946c3a-goog


