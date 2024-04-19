Return-Path: <linux-kernel+bounces-151603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3607B8AB101
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1A1C1F24769
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A5012FB21;
	Fri, 19 Apr 2024 14:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwtJx5lc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DDB12F5AD;
	Fri, 19 Apr 2024 14:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713538082; cv=none; b=YT91r6yc/8gWV/Mj4dwwGMSaONH+myNcliOXrsAx2mt7b1Q3KohEYAWF59gXoE5tAy9cdwngWObnY6n5m/cJ90MnKzCZifumm6jVmyMkv2ck2tzOyFSYqbCG89Pgwq6NA3K/xM+YIlm298WIPBmSbf2CVysQ+JCc0mRPVKFqom8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713538082; c=relaxed/simple;
	bh=cKfQYZQ7OTCZtL8yoh2ygg4+ioUaBLuR99Mk6YEFOhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TdixRodkXn/Z35PwLuvmSeVnpz26Z3gAH2hJsTJPRmxjl8BaZZz6hlVhwwGg+TrjuMXpROZ3hbiZDrzBXTkZKoRTguOpAuludV/LwPgH++7ytVFce/iWVLuFePFfvmKjYbzqJ0F7/726Wb8A0M4obO0SB1s2sMrXD4v1eGpm65I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwtJx5lc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A53C072AA;
	Fri, 19 Apr 2024 14:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713538082;
	bh=cKfQYZQ7OTCZtL8yoh2ygg4+ioUaBLuR99Mk6YEFOhw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lwtJx5lct1z/v7GandOVBhe3JX4czq6eIptu5ZuurO7kxie94CcbRVNHp7zc8iMct
	 7U3mbi77qdT621CLaSt5cpBmqK1qAhZFRo1m7DCfuOVOGvjLvDoxRBwO7L4vvKnEBx
	 6xPDbDj+tHmMQwfyah9kxoMTwtxvk1TG6+6s6VtmXuYYMNooMEbcclucYepSj3qNnU
	 UHNLx3hfooVl0ZdN+GfRGM3ZsEO27hVajUFTz1TbC5UFhfNMN6LYYOi6JWBD4n/cfA
	 cV1pYI3HJAXP2S7YayDW2CvHrly5NuQW/aOnZoOsgEXNPKn4JEGqna/cVD9OtMECIH
	 OJ8lVs5Ncr5AA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 19 Apr 2024 16:47:52 +0200
Subject: [PATCH 2/3] HID: bpf: fix return value of entrypoints_*__attach()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-hid_bpf_lazy_skel-v1-2-9210bcd4b61c@kernel.org>
References: <20240419-hid_bpf_lazy_skel-v1-0-9210bcd4b61c@kernel.org>
In-Reply-To: <20240419-hid_bpf_lazy_skel-v1-0-9210bcd4b61c@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713538077; l=967;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=cKfQYZQ7OTCZtL8yoh2ygg4+ioUaBLuR99Mk6YEFOhw=;
 b=k7MsPc8/YlVUzmV6a9ykWMJAwR3F/9Qa9SPGvai0abv0lViHFSR+8hELbHVHpQu7lVbtMi/bq
 WGVUtChmZKeBcPUKp/xp3EpTQwndBkF7svqX3nDvUzpDdnBPMtljzwZ
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Turns out that this function returns the attached fd, so a positive
or null value.
Given that we were having no other fds before, we were receiving 0,
and the test passed.

Cc: stable@vger.kernel.org
Fixes: f5c27da4e3c8 ("HID: initial BPF implementation")
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/bpf/hid_bpf_jmp_table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/bpf/hid_bpf_jmp_table.c b/drivers/hid/bpf/hid_bpf_jmp_table.c
index 89496aabbe15..301ac79db241 100644
--- a/drivers/hid/bpf/hid_bpf_jmp_table.c
+++ b/drivers/hid/bpf/hid_bpf_jmp_table.c
@@ -521,7 +521,7 @@ void hid_bpf_free_links_and_skel(void)
 
 #define ATTACH_AND_STORE_LINK(__name) do {					\
 	err = entrypoints_bpf__##__name##__attach(skel);			\
-	if (err)								\
+	if (err < 0)								\
 		goto out;							\
 										\
 	links[idx] = bpf_link_get_from_fd(skel->links.__name##_fd);		\

-- 
2.44.0


