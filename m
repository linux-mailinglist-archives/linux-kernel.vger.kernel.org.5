Return-Path: <linux-kernel+bounces-155463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 834248AEAE6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B55A61C2228A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FF913D2A1;
	Tue, 23 Apr 2024 15:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r67htizY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B6A13C66C;
	Tue, 23 Apr 2024 15:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885643; cv=none; b=Tb9/3V+v1xWEeyW8Ra1gtBIpYJoP9z/8vPGDoYIEe2hUZUQU4/U5hCm25Yv0ay6YZ0uNdQGrWMtrsWbaZvtTU8sTf7pSmtvq08Xf8voaKjQAGsRcxOoScA6E+A7PMlxs3sNULbry8WYmpi/e9hJXYxBeAn/xK3Mw7+UDSxYPvj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885643; c=relaxed/simple;
	bh=apXmCZAAlTcv2d9FtqBi2n0toEmnnPvQSjQR+DLhq50=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L7eMw/zQhcMTqMlZttu8jBGGAYksryIymqK/39d8j0upwBcKPZ8kbXTS6Q4hX8m1ay2ZPbZIf04QoJ1jWtOubRgaCR8BpapL/iujR+AYTqKUcCk1/0vGLszonjV65vpqxjD4692kWtSjc+XcLtYhy+Y9VrYoVzCTHbyWRXBWt40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r67htizY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40F41C2BD10;
	Tue, 23 Apr 2024 15:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713885643;
	bh=apXmCZAAlTcv2d9FtqBi2n0toEmnnPvQSjQR+DLhq50=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=r67htizYN/x7WAEHKNnhnuua7N+q/qXlye9hLVC+cItyv+pb6gU/aRy9I1GgtljvV
	 Tnbm9umHVqqBel4x6M6kuwveJIO0GYthsb3vMKLiil80NuEALD/Npo9oaIZTC2JmxH
	 Rgp+GKMS5ZI73KLDMw0a08/jsK/XLD2T0cbDPnC9pNQJUexgZ6UUTYBQmDRSNscPSM
	 IQHzJg+wPCuvk+OgvuUk2noLVL4eU53zn/1q6y/kwCKbh10qzOLUBarXXSAfRjG96o
	 sxEVZ1OwTtkrR6bR7XPi3qmC134bohzvz7jOZCQU+iE3n7E1awPsGY6a/5F8KSQhe/
	 fq9xl0JT1Dijw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F50FC19F4E;
	Tue, 23 Apr 2024 15:20:43 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 23 Apr 2024 17:20:30 +0200
Subject: [PATCH v2 1/4] dev_printk: add new dev_err_probe() helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240423-dev-add_dev_errp_probe-v2-1-12f43c5d8b0d@analog.com>
References: <20240423-dev-add_dev_errp_probe-v2-0-12f43c5d8b0d@analog.com>
In-Reply-To: <20240423-dev-add_dev_errp_probe-v2-0-12f43c5d8b0d@analog.com>
To: Petr Mladek <pmladek@suse.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Chris Down <chris@chrisdown.name>, John Ogness <john.ogness@linutronix.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Andi Shyti <andi.shyti@kernel.org>, Jyoti Bhayana <jbhayana@google.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713885641; l=1170;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=9vRT1yB7cKMgARCNN9R6YoimX7EiL0EJICliqmirgVI=;
 b=/OQCs5rmT3dEQ4zj8HcAF6Mlps+bwWIA1WQPIkd72RdXPAjuUXauUJKqTqgJjsdsztQe/iaVU
 QYcWYv80Ea1BvQ0hoiG+TYe08uVVpiyrbj5RnudcUx5EiejSrl/viaE
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

This is similar to dev_err_probe() but for cases where an ERR_PTR() or
ERR_CAST() is to be returned simplifying patterns like:

	dev_err_probe(dev, ret, ...);
	return ERR_PTR(ret)
or
	dev_err_probe(dev, PTR_ERR(ptr), ...);
	return ERR_CAST(ptr)

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 include/linux/dev_printk.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/dev_printk.h b/include/linux/dev_printk.h
index ae80a303c216..b9623ec22350 100644
--- a/include/linux/dev_printk.h
+++ b/include/linux/dev_printk.h
@@ -277,4 +277,13 @@ do {									\
 
 __printf(3, 4) int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
 
+/* Simple helper for dev_err_probe() when ERR_PTR() is to be returned. */
+#define dev_err_ptr_probe(dev, ___err, fmt, ...)	({		\
+	ERR_PTR(dev_err_probe(dev, ___err, fmt, ##__VA_ARGS__));	\
+})
+
+/* Simple helper for dev_err_probe() when ERR_CAST() is to be returned. */
+#define dev_err_cast_probe(dev, ___err_ptr, fmt, ...)	({			\
+	ERR_PTR(dev_err_probe(dev, PTR_ERR(___err_ptr), fmt, ##__VA_ARGS__));	\
+})
 #endif /* _DEVICE_PRINTK_H_ */

-- 
2.44.0



