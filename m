Return-Path: <linux-kernel+bounces-113411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D134F88841C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58645B228F8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A891A69B4;
	Sun, 24 Mar 2024 22:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9K4zOv2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F3C1A6997;
	Sun, 24 Mar 2024 22:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320213; cv=none; b=JdK51YeqsGJnGJusTCgzzQj0FGSBWvh952qvX0BrcleiE/BxxMkPVyD1ypGywSVBrKmwurQhc8UvKg1UfQ4KMry4tkT8Ol1KfoiyGQp7O6PRLrVabpz/OLqSkR0lm2bbCgc8iRaOAAE7to8PV1QJB2odQqgkJQvKWYQQwUjcokk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320213; c=relaxed/simple;
	bh=1L5gyKnUNDWV2C0YYKufGqLKY6PpoYok9dEErj71eac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ddtvmkwv1l330KTNNLepnKcV7G81EOtoGyCYYMMHwIhvL48qbuBMDXSg9Jq2l1qmvQMkqi0MlCDiQFW5MgDvLw4UVUyLVuY6vuWt6FPPJEEM6OZ7Ryn1avq4XfN4VQKYWJgKLJteJCCkhAF665xXcnplgm8mZmfIiHPhGM9d8NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9K4zOv2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC01C433C7;
	Sun, 24 Mar 2024 22:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320213;
	bh=1L5gyKnUNDWV2C0YYKufGqLKY6PpoYok9dEErj71eac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W9K4zOv20eE4YCl1VMdy0ARzY4sWAfZAxX1ZzeEF/7p0uUe+6COzm5IFDtClUs8+G
	 d3HoJ3KcS4MKQ2F0/iRZ6uaIc0+pN+Rd+Byl/psdouuOgqpx74cv5YwfeIz2TU13IG
	 OKU12anOAIz8ClP9YIAuVWIveqjfWzCUx9Jzs8cveMhLyjtt3z6zJVp8/s7o8Lmxfd
	 qfJyDlnXGmgwbFo0C5YgOE1AsLlOt5lUZDqNiNHLoHwYAuOg5i3p2m5rw6I8FTTeYz
	 FCOLRE4ecLamX6qsL69RYsZINBCHI3GzOksm5UVrIRz2epRJMOcJNjNAqRvAE0ME/U
	 kpjVICx6jwWag==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: George Stark <gnstark@salutedevices.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 520/715] leds: aw2013: Unlock mutex before destroying it
Date: Sun, 24 Mar 2024 18:31:39 -0400
Message-ID: <20240324223455.1342824-521-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: George Stark <gnstark@salutedevices.com>

[ Upstream commit 6969d0a2ba1adc9ba6a49b9805f24080896c255c ]

In the probe() callback in case of error mutex is destroyed being locked
which is not allowed so unlock the mutex before destroying.

Fixes: 59ea3c9faf32 ("leds: add aw2013 driver")
Signed-off-by: George Stark <gnstark@salutedevices.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lore.kernel.org/r/20231214173614.2820929-2-gnstark@salutedevices.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/leds-aw2013.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/leds/leds-aw2013.c b/drivers/leds/leds-aw2013.c
index 91f44b23cb113..17235a5e576ae 100644
--- a/drivers/leds/leds-aw2013.c
+++ b/drivers/leds/leds-aw2013.c
@@ -405,6 +405,7 @@ static int aw2013_probe(struct i2c_client *client)
 			       chip->regulators);
 
 error:
+	mutex_unlock(&chip->mutex);
 	mutex_destroy(&chip->mutex);
 	return ret;
 }
-- 
2.43.0


