Return-Path: <linux-kernel+bounces-52519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00474849934
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 335B71C22731
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FFA18EAD;
	Mon,  5 Feb 2024 11:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aJLkMblF"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883981AAB9
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 11:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707133738; cv=none; b=EV6frs794abb6BY2m/ZhfFTGXp2Elh2TigKrtKzfRkVdhqDgmYqX6nbpS2qK9BwOOGhNiaIwNLFXxKbDQ8wGaLtqIMLHaUrpd6I6MRJpuOIL2k9eLqt4TqWhVDGgFkhCm87neNM17cGZlHNMNjSlGSptHP90KEDc3yfDNWYIHE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707133738; c=relaxed/simple;
	bh=66nJ5U9a3ygOX+4bgNF22AZhA969qXdhW9QnM1tqb+U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=M3Li8MZ8E7TXPwaDUHiF2A2MI64bjvgDhVPkAXz/n6giuUB3JGfjFRJO2LlS9zUAEvFkpaY0T8PQO9c1cgnLzcB/QOJmt55xHv9U1cZln3AT70MBzbTwLySqLAlJU4PNdm2Uecf97v1T+JoclKhIF11fZ2X/s2U2UPrlFbd5B9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joychakr.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aJLkMblF; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joychakr.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60402c8d651so69541557b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 03:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707133735; x=1707738535; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u9pWmEPb+QInAD00/XoRdhrFOb+26lZmMlfpGr1ljBY=;
        b=aJLkMblFWBL9XVc1PJoJXSkm8ljOnaOEEA6+3BswwYhNIKmh2NNRjD05c8GUrp8m3V
         BnC6dQ4Rt/0+NE6pGEs4Lv/lSzV/937B9X86IsZYHhHi+WIPxxR60TXpfasrKE4HeUhU
         vlm8K5DezmD5/PChIFbj2PqVFCt8vJft+qlzEhTzSQRI+LSWU/f5lThHdo2rIm2tFYBz
         Mk684qg2sk8zdUxYzYPXcdLBt39ox9akjoH7Ka/iZBZvsTvkilrD1yIegcTWjnxxNh+Z
         R+9zLzErx1vNDVx/Ypm/a8F2IGXb/2s8RgkdN8nSQYeieoKH7/BVbo/Pp2iYh+heXsgh
         YwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707133735; x=1707738535;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u9pWmEPb+QInAD00/XoRdhrFOb+26lZmMlfpGr1ljBY=;
        b=WjKofLWAnf3gDjapLzjOdzjTwUqOzded4Ssfs1bBGe4e90/2OxHHyZ8Zp4OWjXYSaz
         1P6OIYUYjwK5A8oPyCzArEBPoCkQIVjrjHoqM51j43Pg5iq7QDPL2/M2c5pg7P5swa8h
         xr99bTO6kKKfIKPGNQYkIycvFxSQoPHL+YO8rWxtug8Ev2sI92h8PhZZxEG9++acGKgB
         lOpY9suKARadtJJUf9LRikd3vFanaOVg4WA6sJ+Q0jwf3gMe84B7jp1lrGmP9/OVwXP/
         yVQjWy8tnqSxqhYnWbdIQDclggpZjDQGxJoUVceuVntkIQTSwPFegBKofQjlAXBaEE3y
         mgOg==
X-Gm-Message-State: AOJu0Yw0uTgIRftuVPUEzcFFvVhUpWGHYJ1zPSm5yxkmlTsPX2qAN9/W
	ZcekiPZnJIFR1FVeRJXUzZUw/NSnB2bzVVEhUP6/PdnQt7eHy7X0PC3C3mswGlgqKCTBFLB7Cmy
	n5IL+Z65r5g==
X-Google-Smtp-Source: AGHT+IEPDNTIa/kKHtaCXI3j37eU6GqdIPxhD6Vmn3ytaAwwRwQ+2yvQ4xpCwyA7G89YtL2LJe0aotg9tt3g6w==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a05:690c:39d:b0:5ff:5135:ffcf with SMTP
 id bh29-20020a05690c039d00b005ff5135ffcfmr2388161ywb.4.1707133735545; Mon, 05
 Feb 2024 03:48:55 -0800 (PST)
Date: Mon,  5 Feb 2024 11:48:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240205114826.39036-1-joychakr@google.com>
Subject: [PATCH] nvmem: rmem: Fix return value of rmem_read()
From: Joy Chakraborty <joychakr@google.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: linux-kernel@vger.kernel.org, manugautam@google.com, 
	Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"

reg_read() callback registered with nvmem core expects an integer error
as a return value but rmem_read() returns the number of bytes read, as a
result error checks in nvmem core fail even when they shouldn't.

Return 0 on success where number of bytes read match the number of bytes
requested and a negative error -EINVAL on all other cases.

Fixes: 5a3fa75a4d9c ("nvmem: Add driver to expose reserved memory as nvmem")
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


