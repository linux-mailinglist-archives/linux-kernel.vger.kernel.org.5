Return-Path: <linux-kernel+bounces-115713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8307889484
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78AA01F32629
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7102835F58E;
	Mon, 25 Mar 2024 02:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3gfVVlK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B34215941;
	Sun, 24 Mar 2024 23:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321755; cv=none; b=QBb30LnSFIBapmUw9HszNotJmoJNSsfqLoGVfL/QFnlu0xcuHXL1WNCCy24W6WnhHTD4DCvfbTB7qhR67NIu4Lk8duCb5oPsK1y1DJhkWhXHFyE5Fdpe23A/Ma+sW314Gy64ueOBqvXw2oSAvGkFMrNOF2NwDZwUYdJfILDFW9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321755; c=relaxed/simple;
	bh=1L5gyKnUNDWV2C0YYKufGqLKY6PpoYok9dEErj71eac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lrYlUE9h4LnaXOuo51tkTt7m19DYQhaXSsutwomuoScHyySXo8qHBWtVtDStQUT3C8whrIJkjh3oQiz3/S8UzpdUJnlawXoxNcYSVrf8wLfqDKZrJsAGNIPF+/Bk75wQjj/LOGLgidGA4s1vA7B8inYV/8sSntq/j3NuQLweMrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3gfVVlK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA281C43390;
	Sun, 24 Mar 2024 23:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321754;
	bh=1L5gyKnUNDWV2C0YYKufGqLKY6PpoYok9dEErj71eac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g3gfVVlKQuPZyd03FhasSKZmgBr+vvOyUmiNOAXHmUAgeh07cth3jPdOZkIIbpOUK
	 hpup9yC1ZCyIrzOjGxyw7tFpGhSc5MtoMMzks0nf9XVrxxdAeOPx+HTuYomu5jnEWS
	 v9/z2ErZO1SNs8l45JzmbsdGqO25CTKO2jkpq1n99rRdfUzKSV1xkuJ6mM8jdUzxgZ
	 gmQW0/BlTRrJ4YjhOjYaRuVXT7Ycx8jN8gPRpZnX7mPXksRh10xw3uE26z2ElNeps7
	 k3iKzBZB8pgv6qxHYgvkfpR3okFeepRGusTHDjRoq3WSc/x7rKg9LWGz2SB+Cx1l6F
	 QH0RDldxFjQ0w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: George Stark <gnstark@salutedevices.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 482/638] leds: aw2013: Unlock mutex before destroying it
Date: Sun, 24 Mar 2024 18:58:39 -0400
Message-ID: <20240324230116.1348576-483-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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


