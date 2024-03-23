Return-Path: <linux-kernel+bounces-112230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDFC88772A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 07:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99B21B22792
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 06:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20607539E;
	Sat, 23 Mar 2024 06:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="YsHkIRqv"
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F81443D
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 06:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711174178; cv=none; b=VP+6YgTUshqvMGz5lddyYO7F74k61rT3qXK+mItfHcYHaVc4PWO3XLL089CvDaAhRrz7+dU66Y1yTI3CwSQyFZU2HhmAy5We0pc5Li7AIOT6zL9Q59i68rM4uCEXsiev1PJgOkG9jdQp76HmLLzSZ/unUjIVoGhFQUcs1VJoPCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711174178; c=relaxed/simple;
	bh=dqNdFzDav8LT0eeQGhnGEPZYDofLjfHq/dxayOwpeo4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=SF1gquKUBoKp/C/mcS8V7iRyh4AVZE11e7Gdq1F84JycuOig+MczhuXIZCYPo+BInbiF4qvfUHDXmgfJgrgxFELWShFkH+MOEP+o6C4x23p7W8ai3AHQprlouMhcAPdKXEaG09Fw0cREEERRLczhGLQna3lmoWBbauWS/QwyRBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=YsHkIRqv; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id 8CA4B1C14A9
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 09:03:57 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:content-type:content-type:mime-version
	:x-mailer:message-id:date:date:subject:subject:to:from:from; s=
	dkim; t=1711173832; x=1712037833; bh=dqNdFzDav8LT0eeQGhnGEPZYDof
	LjfHq/dxayOwpeo4=; b=YsHkIRqvWQKYIMxnD97F0HIXWNpS6EkxErXonl3SSFP
	p+c2GiRkYrjB6bKpRhk1uzvoY8PFbIVEtTZ+rW1t6JLE9Dw9J+WxSQxjekpsb5VY
	p6q1UymDgt0st5IcHKoo7Wq24URe+bgcpGjqKmESGwBNDGvAs8kdKJccpOXHKZlk
	=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DBzKpX5o9QAy for <linux-kernel@vger.kernel.org>;
	Sat, 23 Mar 2024 09:03:52 +0300 (MSK)
Received: from localhost.localdomain (mail.dev-ai-melanoma.ru [185.130.227.204])
	by mail.nppct.ru (Postfix) with ESMTPSA id B46AC1C14A0;
	Sat, 23 Mar 2024 09:03:50 +0300 (MSK)
From: Andrey Shumilin <shum.sdl@nppct.ru>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Andrey Shumilin <shum.sdl@nppct.ru>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	khoroshilov@ispras.ru,
	ykarpov@ispras.ru,
	vmerzlyakov@ispras.ru,
	vefanov@ispras.ru
Subject: [PATCH] amdtp-stream: Checking a variable for zero before dividing
Date: Sat, 23 Mar 2024 09:03:38 +0300
Message-Id: <20240323060338.663707-1-shum.sdl@nppct.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The step variable is initialized to zero.
It changes in the loop, but if it doesn’t change
it will remain zero.
The patch added a variable check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.
Signed-off-by: Andrey Shumilin <shum.sdl@nppct.ru>
---
 sound/firewire/amdtp-stream.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index c9f153f85ae6..b61aa30f43a9 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -168,7 +168,8 @@ static int apply_constraint_to_size(struct snd_pcm_hw_params *params,
 		if (snd_interval_test(r, amdtp_rate_table[i]))
 			step = max(step, amdtp_syt_intervals[i]);
 	}
-
+	if (step == 0)
+		return -EINVAL;
 	t.min = roundup(s->min, step);
 	t.max = rounddown(s->max, step);
 	t.integer = 1;
-- 
2.30.2


