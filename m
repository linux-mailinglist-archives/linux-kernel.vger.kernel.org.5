Return-Path: <linux-kernel+bounces-54296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFE784AD6C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F5981F24215
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020DC74E0C;
	Tue,  6 Feb 2024 04:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DYOPkg05"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A27745FA
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 04:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707193457; cv=none; b=T1yCJ+pjh52nXyualbUuFBfRSUNi6ZvKy8D8gLg6bHtoDHoBALMkFnUdCRzK6Q2tcMqW+Y8B1SV7IyKDJsnbrTER21Dyg/OowF92w3CWjfkHFvjAV86d4LNX08sNeIDXBsf8Z3RYs+CASyUoItSRvJWWUKIXTs8ucKHi7X0YRq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707193457; c=relaxed/simple;
	bh=BBcuUm0bjeZDYFp/nFXayMV+2jioo7Z2SXcSObhkE/0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uCRlELXFAa+sanAo5P2md7ZcqIZ8HEV/3uKcbNeqBetEpNY33G5KTMD60Y9IVsqeG6h0l/5M6ho1Tigr2ru1hVwxWbqJFXu1uXneM6Rmns3dRihfCVLB0rctLn/k7kNbBdNPFqm3x51GPId4dzKL6a6uchFkNVqUwW0mKc9BuwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joychakr.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DYOPkg05; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joychakr.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b9f4a513so8489644276.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 20:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707193455; x=1707798255; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LzWbdYel3aT7imRL2l+83QFH5wg8/SRc2R/DFZ/44Sg=;
        b=DYOPkg05PyWTDjrw2ceopkyrpCRBIr3yqoXhyFVrCIeW4x4U7h3MEJ/Zf0e2Z3pyIV
         2nYAhUGGyApnGZ1oeFsSSzfOiURFOF5Payq7kNWxlC5gpuOm79V4JF7LaEbHj7vHMQZ7
         JmM4/ZWyW/J5IpjoK/AOue0Br8/IpR6FRzUEkI3ZpHby/QazfmROxCGnVR9xPa+JzXiV
         e0UXLEl4oyVrMk9kBn5HEw5eYFgAHnPFOPCNzLAMLFB5GfptyDlScUaC6F1fzJD54+Hi
         S474GT2f11D1dJIGZF0qGzD67hxY96RmRvRkNHbiBz4N0wP+FWDu9ZZwVC+Ny32RTH9R
         jChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707193455; x=1707798255;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LzWbdYel3aT7imRL2l+83QFH5wg8/SRc2R/DFZ/44Sg=;
        b=W2KZx13o/U8+ZzCLxi6Bm0Raxhx5vbUYaJqo3fnA8tEhE4eb7qXSDnQJQbL6ScPDzU
         1EokBKf8oimojwdFuUJOVseTdLc4/f+z2QHbtnQ9ZsXwuDHwHbjKoJqNXEAm+rh9Bx/b
         7+WTuvicz8Io2NqKbyAFyTw0gRC0WfCjOigCQ0E6siDPT+RTCAz3t5cISWlzho14CzVg
         Pr+pCvZEf4JgOeYpJzt3g5BTNqZdS2HFXijIiPb7G3UZ5bGffUrhyDRjmhMOzRqpUhWy
         vXeAXOBBqDPLy/nDBCgjlD+IM4aKikhv0/nN2ZKiXDfbFmoOI6PC4XJEoYEWoKTPjS8X
         EBfA==
X-Gm-Message-State: AOJu0YzTI+rlvm27XA6BYv0MgzvVVu24CrRMX2WKy732Iu4yssCruNuw
	4SyNrtT/9QMUSk7riGI02WfbfVxqPs0QluEx5d5rbYts0nArFAC06L+SsAc7Q/mkNznYTYAqCGC
	L3e0t4vMToA==
X-Google-Smtp-Source: AGHT+IGj2YpbzVhNfVvKI0DNc53QduvGrdnSOTjgYa/3exVdHLgeuMkS/Flk/JrpWsM2ibE1yyo6/SxpceTuxQ==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a05:6902:2485:b0:dc2:550b:a4f4 with SMTP
 id ds5-20020a056902248500b00dc2550ba4f4mr162784ybb.1.1707193454844; Mon, 05
 Feb 2024 20:24:14 -0800 (PST)
Date: Tue,  6 Feb 2024 04:24:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240206042408.224138-1-joychakr@google.com>
Subject: [PATCH v2] nvmem: rmem: Fix return value of rmem_read()
From: Joy Chakraborty <joychakr@google.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: linux-kernel@vger.kernel.org, manugautam@google.com, 
	Joy Chakraborty <joychakr@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

reg_read() callback registered with nvmem core expects an integer error
as a return value but rmem_read() returns the number of bytes read, as a
result error checks in nvmem core fail even when they shouldn't.

Return 0 on success where number of bytes read match the number of bytes
requested and a negative error -EINVAL on all other cases.

Fixes: 5a3fa75a4d9c ("nvmem: Add driver to expose reserved memory as nvmem")
Cc: stable@vger.kernel.org
Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/nvmem/rmem.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/rmem.c b/drivers/nvmem/rmem.c
index 752d0bf4445e..a74dfa279ff4 100644
--- a/drivers/nvmem/rmem.c
+++ b/drivers/nvmem/rmem.c
@@ -46,7 +46,12 @@ static int rmem_read(void *context, unsigned int offset,
 
 	memunmap(addr);
 
-	return count;
+	if (count != bytes) {
+		dev_err(priv->dev, "Failed read memory (%d)\n", count);
+		return -EINVAL;
+	}
+
+	return 0;
 }
 
 static int rmem_probe(struct platform_device *pdev)
-- 
2.43.0.594.gd9cf4e227d-goog


