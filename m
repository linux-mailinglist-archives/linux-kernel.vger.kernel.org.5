Return-Path: <linux-kernel+bounces-80232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62648862C55
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 18:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C6D01C20C04
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 17:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C154D18AF9;
	Sun, 25 Feb 2024 17:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbb6E8oj"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6881BF40
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708882432; cv=none; b=HM/f0pdUngCcVTki0BBLQdDLa0ZS8RUOflkMSl35zWl0VZdzctoRnZqwXLWjtKLZlj8fe3maybPyB+KNF1KXVV4xm0TJ4LXzh5l98rqXfe8AuwTKUjhQpoPuTVzAOa4ufKtchH5o7GzWkLEwaVEijy9rwiET6Gfv8ExXC6MIsg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708882432; c=relaxed/simple;
	bh=UWBYLq8HI7GnmwK3+bsQWF0LjzBeaokR18slcb6/RRA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F7CElxc8OfO0w2P3IbH9JHsmrPLDA3s+Dee/7GU2wz2UKNrnBTiwoJxktIFYn9OMa8R1eqmfF6lENgqkE0n2jHD8vgyxqB8dHzf/DeCQLSlaQpB5DMqw/BuwZK/VgwdzBKwcwrO0zpwOZbKGw/wbHf2UM14cZkgMUpOrGnrddfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbb6E8oj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-412a4ec04easo1040415e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 09:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708882429; x=1709487229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TGqIypLRNK413/5tqEUR0eP+aBPssWDBJFP9KRu1Qkw=;
        b=mbb6E8ojCnbbMvU9+qyvKaenr3UGK/DkbIaQKpgDF+B07TFcglL4nb5kV8hGYPp73M
         y5Rwuway/HkVMlbsjepA8wxf2g+xWgZsxujfBpJhNBT+wa2qciKMDxzgr274PPUtWUML
         btzbO2vk/k8L18uIZAKm0q+GXimspAbGOUfOUM0hhFohAk0PdNUwFhRr7QS5A40qflfa
         nPnVY1F0oNOb6wkD2krE1/BHoD6EQcQkcGSQSOjJDkuxKfDaC0yo++TJLn+t/hjkux76
         tmA1yCQa6dxLNxPenpB/kzL/5OgtfONs/wBdN2asyD0qYruONDPW2mpgcbl+LfZB/5An
         4uKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708882429; x=1709487229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TGqIypLRNK413/5tqEUR0eP+aBPssWDBJFP9KRu1Qkw=;
        b=RngPKHT3bP2qscgfSy38Gvajla4+OOO9/kvcZxLGOSQz6//s/UQBdN4qo2fQkgN0D4
         qQIrzfXdF7pkG/zY6SAogJt0ZaCg/bSkOQH7zU2vOzSJIddZYVyHOh19KQPxiKpNoYa5
         9WOZqKQlusWEU9Lz8+zM8a8F7VVUqKBVK8bdvx3Bvq1B+CLBB52S6Zf9gqCfQNetOMiK
         dh0c6kIuf3RR1t1YUd7Af1tfFj0DirNDg4gwWrRXgnYNACVnNW6OsUjcW2ZCUznXvA2g
         mg9bTxPtWZz4h4ECfmULYcwk8MQVqJ/gLCc1pdI/7IR0HnXp7MUJp0RT1ncJvUPC1jN2
         A9xg==
X-Forwarded-Encrypted: i=1; AJvYcCWfKJVV7RLgTtIn6qZtMaG187tNXtd0QQNs/vJzMDxQxbTwEB78IfmoEzIcAZi2He5VMOWrhkQu3DUi6MjDkUwmzofUAEJpW+GOBcaw
X-Gm-Message-State: AOJu0YxSnxl1pNrIf3qb652f/1P4oHFL2dMHVJGNcAqENEQ/SKJVfJPt
	8npAnW7xzFT3Pfk0kP880kaXGXM46yf2/jn9z2LFeRNmfL5aIG6D
X-Google-Smtp-Source: AGHT+IGXJ+i6mALim1Xo3qYN2hIyJ/UwmZqx6KAU2UcuiLb4rlXYoaH4TkF85BRvWmBGb1mkY0FKxQ==
X-Received: by 2002:a05:600c:5d3:b0:412:8e82:9a5c with SMTP id p19-20020a05600c05d300b004128e829a5cmr3818412wmd.38.1708882428907;
        Sun, 25 Feb 2024 09:33:48 -0800 (PST)
Received: from YOGA.local ([2a06:c701:736b:f200:79c9:6db8:8198:3c60])
        by smtp.gmail.com with ESMTPSA id m6-20020a7bce06000000b00410bca333b7sm9400108wmc.27.2024.02.25.09.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 09:33:48 -0800 (PST)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	luca.ceresoli@bootlin.com,
	benjamin.tissoires@redhat.com,
	elder@linaro.org,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] staging: pi433: Remove a duplicated FIFO_SIZE define
Date: Sun, 25 Feb 2024 19:33:40 +0200
Message-Id: <20240225173341.1278918-4-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240225173341.1278918-1-ikobh7@gmail.com>
References: <20240225173341.1278918-1-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FIFO_SIZE is being used in both rf69.c & pi433_if.c source files
It is also already defined in rf69.h header file

Signed-off-by: Shahar Avidar <ikobh7@gmail.com>
---
 drivers/staging/pi433/rf69.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index d7e2dbe70d7c..4bfb1a98328f 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -13,7 +13,6 @@
 #include "rf69_registers.h"
 
 #define F_OSC	  32000000 /* Hz */
-#define FIFO_SIZE 66	   /* in byte */
 
 /*-------------------------------------------------------------------------*/
 
-- 
2.34.1


