Return-Path: <linux-kernel+bounces-48044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAC2845696
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AE6C283FC6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A17B15F300;
	Thu,  1 Feb 2024 11:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHZ5XMxG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A195415DBD1;
	Thu,  1 Feb 2024 11:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706788410; cv=none; b=gY14VRitLsFObEl31yYs9WZE/UIHrqJcikGn9xtXKI+XHjCLkxIhFZN2JBZCZ5WDQ+6rz1MFVG1GXTrj/oMoWeY+2aEAs1yxnQjOoXBUry3JShm91dDp6ODuLk/sopXlh8BVJ/EwqoMVfHJGGgy1qz4ZF7nlau6v9QtI+t2tjb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706788410; c=relaxed/simple;
	bh=R9mqcGZb3HMeav7eRqumn5/IPLY4C5cuLq+LnSwMoPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X8Bg0TgOM3OUyQYvlNIn7CFKuFXZ0EnzyWG13I7KJslPPldGFMdsfTLzlJmcqpBzXzrTk04s/8AB2DtWegQIRkMW860zVCjV2XBt4vy7zciYFyi8r0tYBZZpmbwYh+0cYEJC3MhECdkZjTKLiyPLHo3C3eBuyja1GBhp7sZjyMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHZ5XMxG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40E2C43394;
	Thu,  1 Feb 2024 11:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706788410;
	bh=R9mqcGZb3HMeav7eRqumn5/IPLY4C5cuLq+LnSwMoPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VHZ5XMxGtA8VGFAHELiWxWp1TYfwdLGudPaHlCjFVRz6z97iIb4EHBwiChbXjoVSf
	 Yinshu6Xpsu/owG2i4xIYTn6T1QCdBMvZuYMkzyjcOANW8e4+KQ1ZwTjca5FvISyeZ
	 LbjDcYRfKDsdQ7gOlbOhsS7xKM70i8gbo2Vj31sBDrYwyDbZqa1R5j3bdolgM5VPzV
	 nHSY4YKkowuGhVDG8zhxS5gcGeMiemlARIOvSqTkMf9ezirZZdSjQdur5LK5o/cZDN
	 YWaJkky8uL0KhusM24069OvlmlwPJPOYEXplCQyxmEGU3tdriWjORLtaJ71NKpPZ1X
	 FKdHqN65Qzocw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: jikos@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 3/7] HID: protect hid_device::bpf by CONFIG_HID_BPF
Date: Thu,  1 Feb 2024 12:53:16 +0100
Message-ID: <20240201115320.684-4-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201115320.684-1-jirislaby@kernel.org>
References: <20240201115320.684-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

And not by CONFIG_BPF. BPF can be selected while HID_BPF does not have
to. It actually cannot be on some platforms due to Kconfig dependences.

This saves quite some bytes on those setups.

Found by https://github.com/jirislaby/clang-struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 include/linux/hid.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index 7c26db874ff0..b12cb1c8e682 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -683,9 +683,9 @@ struct hid_device {							/* device report descriptor */
 
 	unsigned int id;						/* system unique id */
 
-#ifdef CONFIG_BPF
+#ifdef CONFIG_HID_BPF
 	struct hid_bpf bpf;						/* hid-bpf data */
-#endif /* CONFIG_BPF */
+#endif /* CONFIG_HID_BPF */
 };
 
 void hiddev_free(struct kref *ref);
-- 
2.43.0


