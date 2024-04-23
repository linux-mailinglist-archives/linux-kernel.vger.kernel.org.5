Return-Path: <linux-kernel+bounces-155156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 091038AE5FF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16687B2184B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB53584A2E;
	Tue, 23 Apr 2024 12:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b="as/Udpef"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BE778285
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 12:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713875170; cv=none; b=WZdbmAlaJkjjUtIQmoWymwC10k6HjceHySfrZ+D2665zZFIb6YfEQwirtjwe11z0PCHvDPQ545rpczT6OTjWwro0h345P/KPJMBBywnfYnVHEw34KOC9T8aHVwj8wAVZtrxQy5GjexRxigUBKsdQJC5ykhYkKIhSQ44qjxHe84w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713875170; c=relaxed/simple;
	bh=e6ARaU2OvtoZ+qzRuhjbMDMgcKFgiApYcNksWkkvBME=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=sstF/uFw7cCKfZhgPKogZAySeDR0+DkH2J+P0H/7gfFVL6KVhBxtFEnVbD0Y8Wu1BvVmwaodjFVp4NsKLLjHkZNbP4VPi78mxQTrTbINwzRzcq87oy7P7bfjmuokmU4HH6ZKPKF2J1ogDqcDE0dfR/ehk3BgaWiMJHXZAhE0kYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf; spf=pass smtp.mailfrom=kl.wtf; dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b=as/Udpef; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kl.wtf
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kl.wtf; s=key1;
	t=1713875165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=e6ARaU2OvtoZ+qzRuhjbMDMgcKFgiApYcNksWkkvBME=;
	b=as/Udpef9eDD+8GaJPHSDIIQANVuzGADEdLLCu2Ok9qKb9HbUhQsXLDuQUJZRQUSWP7dD1
	6AQ/02qX/tHtpv5EpmBd25oELsLQhRh0QBbBI93PiMfSd9pJxuDWVtwY3Ah4TXGxFm73o5
	Xb+C/1m4iSChBucJ0m1J49V6XUZtISl1FTeo2SqHVxTeuK1cAHgE23Jee/i78gFGe4gqBZ
	aQxsMhC/JZtHPnsL4l6akpGOZTXa/KvYBCgdriCq5ZHC8Q3hTQbkL0kKB0KoGmuA8q63jF
	v2dOjGogQdxc1zWCWvM2Y6FK6KShSJM9BeQUv/oZETdk7z//RvpF8CvW1i6fbA==
From: Kenny Levinsen <kl@kl.wtf>
To: Jiri Kosina <jikos@kernel.org>,
	Dmitry Torokhov <dtor@chromium.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Douglas Anderson <dianders@chromium.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Maxime Ripard <mripard@kernel.org>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Radoslaw Biernacki <rad@chromium.org>,
	Lukasz Majczak <lma@chromium.org>
Subject: [PATCH v2 0/3] HID: i2c-hid: Probe and wake device with HID descriptor fetch
Date: Tue, 23 Apr 2024 14:07:52 +0200
Message-ID: <20240423122518.34811-1-kl@kl.wtf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This revises my previous patch[0] to add the sleep STM chips seem to
require as per discussion on the original patch from Lukasz and
Radoslaw[1]. I had initially tried without as it had not previously been
needed in the similar logic in our resume path, but it would appear that
this was simply luck as the affected device was woken up in that case by
"noise" from other sources.

To reiterate, the idea is to add the retry that Lukasz and Radoslaw
discovered was necessary, but do away with the dummy smbus probe and
instead just let HID descriptor fetch retry as needed, aligning more
with the existing retry logic used after resume while saving some noise
on the bus and speeding up initialization a tiny bit.

I added Co-developed-by tags, I hope that's appropriate. We should await
an ACK from Lukasz on it fixing their hardware quirk.

[0]: https://lore.kernel.org/all/20240415170517.18780-1-kl@kl.wtf/
[1]: https://lore.kernel.org/all/CAE5UKNqPA4SnnXyaB7Hwk0kcKMMQ_DUuxogDphnnvSGP8g1nAQ@mail.gmail.com/


