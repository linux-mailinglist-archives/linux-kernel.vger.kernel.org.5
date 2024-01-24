Return-Path: <linux-kernel+bounces-37065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C43683AADE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EC181F2BDBA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3F477F0D;
	Wed, 24 Jan 2024 13:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="plhq9YRZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE637182DB;
	Wed, 24 Jan 2024 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706102676; cv=none; b=rPI2PqDyPcqcooUNoS0pH8tFa7FvHfvbQg3oxK5ojW3DJzVfrAxwB4j0AZE44j5cqhY97M4GEe24An6C3cQ1QLjzvZEdG18PrL7iSpVYeIYBCG7kyRnJXD8R5czzGytzfpp3lsZhBQzo6C5iLk2OUFfnsgLCnmb6zyL6614ZH/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706102676; c=relaxed/simple;
	bh=sjW5Y3vFQ/yglaRJzi06dluiBf7NKLTHdsB2pVl+oQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gCSztrD6uvWseDUsGNSjKQiu9Ms2hViENuIsvl4VYbIv2V1yeFL77HymhPr3g5JcWoHjcvb76LsuGrkbTq1/uhrHDZIBN0k7mbkbmsJXCyeR3oaR0ww1aQmB85xnQW0m2hO/d8cuLslw2d8swK5M2ZSMoBWH/cYKqjzFYWUeZ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=plhq9YRZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC00AC433C7;
	Wed, 24 Jan 2024 13:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706102675;
	bh=sjW5Y3vFQ/yglaRJzi06dluiBf7NKLTHdsB2pVl+oQk=;
	h=From:Date:Subject:To:Cc:From;
	b=plhq9YRZNJJr0+rZArm50xpyDcIfz2qqW3WJ/xySksJZoghk/wud3cn4A6e6miUZP
	 OWjy0HWxelMiH+NFHwYwiWWhqkIuGCw/CcvF4l6skCUj44QmtfnMoNY6Rd7FW4UrOX
	 3/UIAcvNB2omZpJrsweSbe+o0yOD0+ByyIPag0dTFL0DRdH+Lhv8Kw5bby8FLa/1Ku
	 NG/31xXjXSIa1razHbSV5TAl5s9oEIZ+6h6nyu777hFroLhzFWqnt6OsEumH/RtYXA
	 5Hso3wIirSJhqjhggu8ydcSkxa0Qf59kMnjs3Li1vEIpUaq1splgXwAUg9B5dCUaLi
	 VGYVcp1IZdwTg==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 24 Jan 2024 13:24:24 +0000
Subject: [PATCH v2] spi: Raise limit on number of chip selects
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240124-spi-multi-cs-max-v2-1-df6fc5ab1abc@kernel.org>
X-B4-Tracking: v=1; b=H4sIAIcPsWUC/2WNyw6CMBBFf4XM2jF0lIes/A/DgrQDTARKWiQY0
 n+3krhyeU5yz93BsxP2UCU7OF7Fi50i0CkB3TdTxygmMlBK11SRQj8Ljq9hEdQex2ZDunBJulS
 Zzg3E2ey4le1IPurIvfjFuvfxsKqv/cXoP7YqVNgUfCu1ydpcF/cnu4mHs3Ud1CGED/V434yxA
 AAA
To: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1289; i=broonie@kernel.org;
 h=from:subject:message-id; bh=sjW5Y3vFQ/yglaRJzi06dluiBf7NKLTHdsB2pVl+oQk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlsQ+QVOH1FyQrc76jnfYnEVQFjrK6lU8TqDVwx
 j64TSNT9PaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZbEPkAAKCRAk1otyXVSH
 0OImB/9Xuvi2Sw8kECn6Zj6oiMkiaf7uWyysbMNm4DVPEyfVlnWXu+hgPXg44oimKhXadk7R4hu
 QIBaKRECNVuKFLFHO566WXtxycztXd7IHP4B3ofgjAF7h3Q8w0nXtOlBLvS9Amzng4I6yBF/0C2
 D6d8B9G7PtbpKDjTbytrDfExSc5YGO/mKb24d8eXGom0cGgtnwqmXfw/JTtRRfcyZFhns2jiHkj
 gzLeoJ4r0W6bfcJ+LLLH57uubsk5NUQWWzhlsDvkJk6bHplAF/cVED3TwEX1pQ2XvIwnIpAijP9
 YNi0BQuNcox5XB9mtMfaJV5wQuVMfm3CioG19TOoqKl1rUcy
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
Changes in v2:
- Raise the limit further, the highest I've seen thus far is 12.
- Link to v1: https://lore.kernel.org/r/20240122-spi-multi-cs-max-v1-1-a7e98cd5f6c7@kernel.org
---
 include/linux/spi/spi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 471fe2ff9066..600fbd5daf68 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -21,7 +21,7 @@
 #include <uapi/linux/spi/spi.h>
 
 /* Max no. of CS supported per spi device */
-#define SPI_CS_CNT_MAX 4
+#define SPI_CS_CNT_MAX 16
 
 struct dma_chan;
 struct software_node;

---
base-commit: 65163d16fcaef37733b5f273ffe4d00d731b34de
change-id: 20240121-spi-multi-cs-max-23e82c815c6d

Best regards,
-- 
Mark Brown <broonie@kernel.org>


