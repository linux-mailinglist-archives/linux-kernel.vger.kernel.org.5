Return-Path: <linux-kernel+bounces-32258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44814835922
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 02:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6C5C1F22BFA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 01:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A7E7FF;
	Mon, 22 Jan 2024 01:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDeznDiS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EE436B;
	Mon, 22 Jan 2024 01:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705886515; cv=none; b=aPKWYwxCPLIwPHgPV1ZFoWCDmfu3DIf97UgpasZtRKKbnrNy0FffaRPbyuNMVgsQDhzsNac9i3K1PSiRZXPST0d5XklWkGEO+brBVGJHcE6Z+iUDFM+MKaEW13J6w2qmkkv6zYLsQPBd2cRCYXFpbakRs/Z9YehgmMp1O0lCXiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705886515; c=relaxed/simple;
	bh=n3n03d/eMf3LiEFMS7wP775MM314QYFKkEoIgmrsK04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jfJK5PLZyWkYls0/7xYqWTaeDtsZCaiynIW0BMGyWXNgQydFXPOjOzWNnhIYRXpYlyZRdt1aDPU+mwMHoi6ntZ609HluywstLtDcLmthRIKeE6zO2wkizQJvIoXlrg9fA091QT0dXo13c1U+Bw3ggY5Ijgt5SLrSmA7HT0JuaS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDeznDiS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7104C433C7;
	Mon, 22 Jan 2024 01:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705886515;
	bh=n3n03d/eMf3LiEFMS7wP775MM314QYFKkEoIgmrsK04=;
	h=From:Date:Subject:To:Cc:From;
	b=FDeznDiS8+nF0YIX2GvN3jNksydTpYdHBssnMQtlUVsQet2RchBT9aSExvIidc/cC
	 RcOB2nz52uo29Gm3Noq1blWp6yAwTEn3clGBD7hdhOxauwqoPB/VEa4b8xoGFSP8yB
	 u4VTgdCJq3XHCwcQn89QSEn4ERPvcLizVK4UANM9TzVzmS8papFQxcyxOqPVm7tS+u
	 v0gEatzw1C0XN8LlxBb+ovgd9cKReABnRuJqlFuI7nacJ0wxzOQYmt+Xe/IHXmQNtw
	 noCrVlog8ozrXxoXiPbwMdskfyKE1/0hY7eyF30896x2KgzdXmOHbmRSDXgY/q4hK4
	 R5Wm3Ydh8nXgA==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 22 Jan 2024 01:21:46 +0000
Subject: [PATCH] spi: Raise limit on number of chip selects
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240122-spi-multi-cs-max-v1-1-a7e98cd5f6c7@kernel.org>
X-B4-Tracking: v=1; b=H4sIACnDrWUC/x3MSQqAMAxA0atI1gbaOCBeRVyUGjXgRKMiSO9uc
 fkW/7+gHIQV2uyFwLeo7FuCzTPws9smRhmSgQyVxpJFPQTXazkFveLqHqSCG/KNrXw9QMqOwKM
 8/7LrY/wAImQgM2IAAAA=
To: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1105; i=broonie@kernel.org;
 h=from:subject:message-id; bh=n3n03d/eMf3LiEFMS7wP775MM314QYFKkEoIgmrsK04=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhtS1hw3WvHFtsCkyWRCutqhcuvHT0sx1+tce5x3Ou/+g/
 EYLzy2JTkZjFgZGLgZZMUWWtc8yVqWHS2yd/2j+K5hBrEwgUxi4OAVgIsE87P/do+RyGWIaAq4L
 Lz3Hmbz28+G6ig2WIrWPP6zgv9xwsSbiREd4zr6+fe+el6YYxu184PdE5EzB8el7Lf+0NWruiH4
 sPqu2dLJAI39gyqENXhc6T8y5//qf9PsZ/BO+qO9r62nTP+H2amGGwzMzpxtZO6JzpLbkMSdy7v
 ktFr5LIOAXy6nLu4/F+2pyhSdnqtzxOsq1Yc1DLm7ZREa5aycrJ2o9+Hv5aF5KhwLnu/CeZEb93
 o4CfmuR3e3q2xxCNdjuvJ1eMdGgLcZO3Cvt8t4AS39vR/evis8TVd1Tf9loewfmWuasn6o95RtD
 1FETldLV772FrpuE9ljp9lctYTpfwPzP+keK3olDnioTAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

As reported by Guenter the limit we've got on the number of chip selects is
set too low for some systems, raise the limit. We should really remove the
hard coded limit but this is needed as a fix so let's do the simple thing
and raise the limit for now.

Fixes: 4d8ff6b0991d ("spi: Add multi-cs memories support in SPI core")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Suggested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/spi/spi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 471fe2ff9066..d71483bf253a 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -21,7 +21,7 @@
 #include <uapi/linux/spi/spi.h>
 
 /* Max no. of CS supported per spi device */
-#define SPI_CS_CNT_MAX 4
+#define SPI_CS_CNT_MAX 8
 
 struct dma_chan;
 struct software_node;

---
base-commit: 65163d16fcaef37733b5f273ffe4d00d731b34de
change-id: 20240121-spi-multi-cs-max-23e82c815c6d

Best regards,
-- 
Mark Brown <broonie@kernel.org>


