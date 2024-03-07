Return-Path: <linux-kernel+bounces-94805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFE5874572
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42F301F23062
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A924468E;
	Thu,  7 Mar 2024 01:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWzu/c2I"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E7446BA
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 01:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709773553; cv=none; b=f6vHW1bZ3jAygva8SChn9ItBc585xOdrOFLo4SkMjKI0zlGbyXGZ0xfHgiViSIPRWrbGMehqtvgFFUyhaIGJVesVblDG63Mcd5aFMcYKvkQvCynb/t9wZSdN+3qE5u8ZL209n/whmOZRRnFITVn4AZGE8/snFXp8CYyaiB6sZ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709773553; c=relaxed/simple;
	bh=BhjxTn+Iq7ongnZSN/4ZW7KL5W+JZ0r7rY3nLp5JHa4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BDqfJlzg8VWCBBLKYR5iYhSiKBRWFs4T7hAK7yRJFlBOeuvIRHleeRwQu0JuMK7hANvOVKhG+R+hvkk7EJa5rSzGP7PJmI65c8P3TZnOlwduYp0ZtQreW7haN2CZvCcFk8Kbje404C++5Ha/WJLunHML81nXVlHkDOOOvRJiUQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWzu/c2I; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-788450cf12aso20674485a.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 17:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709773551; x=1710378351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=eye52Nq6DzbsyvcGLe6F9NZyI7E9KumQ8b0lW6PgSb0=;
        b=AWzu/c2I6H5kPN5h10s7b8a+UBCvXjpteX2IKjNVNKvvt1xVy/wMvI46jO8wdWpQHa
         I5mo6QSQtDauRLygIKU8PS05llilJocktZ5bqX8YREGKIskfQ8bRTnA93GYKugo3IR1P
         FWsIHq0vzWR9joN6kEHPdJBSLKIzsAv+vdetGPNWmDP/FCko2YU2FFWJXPBkOeC3zVhF
         7c9+vQEg01z8dS8Oin9stbNZJD0TOXklhFrtyHW+0XzFpOm/l74pFgrwq1rreOv4PWBb
         As5dbof6QFvNPxBXWb5UIJTpZYVFpy311NaXBgE2za/RQlMTBl2j3Whiy6AGuHU+uH7M
         kX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709773551; x=1710378351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eye52Nq6DzbsyvcGLe6F9NZyI7E9KumQ8b0lW6PgSb0=;
        b=Wn7wcRbYtXOiFoJp2wMqZTdPZlJnSQvS3pIumethglk4wycSpUeWqjxCNjZvpvWcy7
         wZyEPCpc3ZOjZmevKoHyzgzr31WzQuVsQvG2nH4wPdK64YVaA6bzdGo2OZJONowy1bxt
         nQBoatYUgGf9wHtr0ScQbLNAmmqBjKYExRK2b3GRgHgc/rMKGuXThZuWZfAFFjI/7fEY
         CSjbkColCU0lzZOrAk2+nau4Da3S0V7J6cXVSXC54hIeMmVnp3qf0W8N/FiSl0TDs4K1
         Wmc/rd2Wvm45/5TibNIhPmy8kpkuuPC6JNG+qakW1uTyYx7f+wmFvcDD1zG9KV2xIwkj
         sRsg==
X-Forwarded-Encrypted: i=1; AJvYcCVqLvFxX8wEvh87fPti3y7/mnYatf2vt/WS3YGiJocNbNfArcD7/nWsEfoSKJ2ewUGZaua2MfQD3bboU1OkrHplbMsLyU5S/5k/R2ir
X-Gm-Message-State: AOJu0Yx8FM5QK//jMpW/ppdjac9GfMrpzIQu/OIdwrOYjN7NVoS0x00R
	6/gIfuRwDXkVQTYsniqOSFLObUsuGJknC2S5XcoK6ocB1IshfBbu
X-Google-Smtp-Source: AGHT+IGyve37Ve4gfumbpnNvgXbbOC150hHHz+8iZyxrlteaRw4CD9TaTx4Kw/5ypIPliQjHE2M9fA==
X-Received: by 2002:a05:620a:5627:b0:788:2715:8074 with SMTP id vv7-20020a05620a562700b0078827158074mr7093388qkn.27.1709773550898;
        Wed, 06 Mar 2024 17:05:50 -0800 (PST)
Received: from lenb-Intel-NUC8i7HVKVA.intel.com (2603-9000-9f01-67cf-d46e-8590-8b01-6ff9.inf6.spectrum.com. [2603:9000:9f01:67cf:d46e:8590:8b01:6ff9])
        by smtp.gmail.com with ESMTPSA id vq5-20020a05620a558500b00788242166dbsm4256558qkn.133.2024.03.06.17.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 17:05:50 -0800 (PST)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: kbusch@kernel.org,
	linux-nvme@lists.infradead.org
Cc: maxg@mellanox.com,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-kernel@vger.kernel.org,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 1/1] nvme: Use pr_dbg, not pr_info, when setting shutdown timeout
Date: Wed,  6 Mar 2024 20:05:41 -0500
Message-Id: <49a7c0b667abe23d95d67cf0cf7ea7e193d9f2a1.1709773065.git.len.brown@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

Some words are alarming in routine kernel messages.
"timeout" is one of them...

Here NVME is routinely setting a timeout value,
rather than reporting that a timeout has occurred.

Assuming this message is actually useful to somebody somewhere,
let's make it DEBUG level...

Fixes: 1a3838d732ea ("nvme: modify the debug level for setting shutdown timeout")

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0a96362912ce..e361af1953a4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3205,7 +3205,7 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 						 shutdown_timeout, 60);
 
 		if (ctrl->shutdown_timeout != shutdown_timeout)
-			dev_info(ctrl->device,
+			dev_dbg(ctrl->device,
 				 "Shutdown timeout set to %u seconds\n",
 				 ctrl->shutdown_timeout);
 	} else
-- 
2.40.1


