Return-Path: <linux-kernel+bounces-63406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A32852EE0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 338F31F270F7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C201133CD2;
	Tue, 13 Feb 2024 11:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PltzndGW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163162C697
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 11:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707822915; cv=none; b=WXU8iAKxdjB+HCk9LxWgpYFT+clO6OQtrvtfZ51BKO7RL8vdkJWdYZ+iq+g9Lzu6IihC2kESmxNu/yW0M3qD8ZaHvZ4Z1313LOLlYKuydMmrxJWNHQFgp++YWqFdD1GwUYKlpCfC5dhvQZeK4IgZOPywnopxkQTujqvWR3SPJTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707822915; c=relaxed/simple;
	bh=APFYotw86p62/fng4yVxpcCYH9lo/o/Vcj6fOv/RC1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gBIlIGJ8lHdkeNSMYIx1pDL01DC/zKdkns3UwLDutAoQEIep3Ma45JTap1OV/eQsO6FSCgsh6JtAG0X2BeH29ZJ1QzuSsT3UDH8SApbrba0mtWig3toE1iwaa2vkmD+F7uA8V9cOqkhjoF+lhk6zk9dIdO3w0A7e4+6yPu3c0pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PltzndGW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E826C433F1;
	Tue, 13 Feb 2024 11:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707822914;
	bh=APFYotw86p62/fng4yVxpcCYH9lo/o/Vcj6fOv/RC1A=;
	h=From:To:Cc:Subject:Date:From;
	b=PltzndGWBmDv79/xBrq7AJdgFkZVFxH4Z7szGa1fV9ivAucdRuutHaGUAmMbNdof0
	 hTslWXhiMAUBoDqPxv9tRx9LoEYjG80z2S03ce1B3dJkmYpDyQzSmAhtkqTcTWZG2m
	 /Sq2wGU72W5seadfu8veobnkvhVUi5stEviuesGw6p7bsMr1LK546aF0OzHCULWolj
	 cDPGehGbrTcMivrgAAtuBMa4ibhwstKGXZAmr51g9aYcYYpRhP9y7wLAaWz4hd2XwD
	 BmYb/bSV+32WkP0LxQboQ6N24ox+m+Uoij43J7hJsbUtdpLKEk+zy9CdKPMH3eLwCT
	 1FpLSK85fkOrw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: airlied@redhat.com
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] char/agp: remove agp_bridge_data::type
Date: Tue, 13 Feb 2024 12:15:11 +0100
Message-ID: <20240213111511.25187-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

agp_bridge_data::type is unused (and I cannot find when was used last).

Therefore, remove it.

Found by https://github.com/jirislaby/clang-struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: David Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org
---
 drivers/char/agp/agp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/agp/agp.h b/drivers/char/agp/agp.h
index 5c36ab85f80b..67d7be800a7c 100644
--- a/drivers/char/agp/agp.h
+++ b/drivers/char/agp/agp.h
@@ -138,7 +138,6 @@ struct agp_bridge_data {
 	unsigned long gart_bus_addr;
 	unsigned long gatt_bus_addr;
 	u32 mode;
-	enum chipset_type type;
 	unsigned long *key_list;
 	atomic_t current_memory_agp;
 	atomic_t agp_in_use;
-- 
2.43.1


