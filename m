Return-Path: <linux-kernel+bounces-118028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C368E88B293
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E90B2E401D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E586D1AB;
	Mon, 25 Mar 2024 21:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KsJmHKED"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C6E7173A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 21:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711401591; cv=none; b=qzoEJGu99x7AcxAJLEdUzGgTf/pzjB0EPxpgCzdAh+9QBFir0t9i0LmZ//5W8SVI6agcy6QUvpOB1yK+B8kGXBAAn8WFPhvoh4+PqkzYJlf6GAYFa2SFePGErRbRdgKGWjpLHpgA0Osn/O8PmtoboDiPVyyIQpOWisQ8Jxfg628=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711401591; c=relaxed/simple;
	bh=ppMvWVev0cLIJM7WJ4IVef/LN8AiezVVGMMPIfD8CQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DGfxKfCWWr9jRiY8pgkv1Cq9XK1pBZhgJJrB12sR9zLxYlmJdKf8SAL//RxvbyubYuvQPbbgscbsPl442rzoF02rQzJQhKEDmo5muFLf81IEtr8KJPkwyuHkaz5BlhEPmEsgTx1OQX/MByJI2/pXV1vg9pjxPn+KGTUm9isZgdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KsJmHKED; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e6afb754fcso4268063b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711401589; x=1712006389; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IWkKtqlB2IYpNkVz6EWQgOv/DTm4sZRBKwumKBADUJY=;
        b=KsJmHKEDmlarbQ4DTOv3j9DNvkgyDGMBh0ZuauXXw3XHR8PdtZ+QID1uwIj3DhWzbD
         AeKMb2bptOdrqE1eWLR7sfiP32BxYOjQcJkODyQ5CSq403Kvgl2Td3UHIrVuXXRguGUm
         sbrzrbANJsikyJPwQnTpYuAqjx6oQu4JopLmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711401589; x=1712006389;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IWkKtqlB2IYpNkVz6EWQgOv/DTm4sZRBKwumKBADUJY=;
        b=WIO+PLSWS5ilNxjobGdIZfA+Bbg3sTJ3mOjyMAxm8psx1auz/7xqQ/zyuHCtXDXs1y
         UOa989eE/Y7Dc4o6pcCwUPQcpG7rceKge76hThgFWpgyfU0kWxxMb3Z38chVtfCQWyWS
         pUhJFNZ/a8a0FroPcK+uR81RM/OQcvWsj2VawQcV+KSAkDMqBFjapF0P1aYOo345duvd
         3tX+xYb51V+NeGoQvyWFADSv+zLkZ6KcAszOrudpXbaY3JZSe0NcNRPrjJfAlYbKPgbd
         YVv7HU25Dw/bFUZyv7h1Xxgqp2hBNs1DvqZAsObx8IXfZmyL/LAp0Q144cwH2NXzbf1h
         T08Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKULwPWKCkdY0DoHwhO3BzEiZNVDZv9ZHlcc67u/TmviqEv9Gc+HQvcdeVvtJEYou4TWtBJM3sOylX/NyXxOWBEbNiUIhPh8hKvz+v
X-Gm-Message-State: AOJu0Yyp0RcDY2exdYhX+etFjGrMeALYeSU9uTFoMQatZ/4hLBYZhqFm
	LDWfGonA8aYDy7UCmFa8/0tXdq9ljiO9qmZhOq/uhfZsJbdCdJpxKiSsdXolApY3sYrnZtxhFvp
	msA==
X-Google-Smtp-Source: AGHT+IGa9QHBomnxFI9sI+UI1mcpYHhl4i65j4DlNlm8nhqgmv3Q7Naz5j9Z2uKmzsd6N0Gv8/Rkag==
X-Received: by 2002:a05:6a20:9585:b0:1a3:bc78:fd1 with SMTP id iu5-20020a056a20958500b001a3bc780fd1mr9199760pzb.59.1711401589029;
        Mon, 25 Mar 2024 14:19:49 -0700 (PDT)
Received: from pholla1.c.googlers.com (210.73.125.34.bc.googleusercontent.com. [34.125.73.210])
        by smtp.gmail.com with ESMTPSA id r17-20020aa79ed1000000b006eaada3860dsm1851656pfq.200.2024.03.25.14.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 14:19:48 -0700 (PDT)
From: Pavan Holla <pholla@chromium.org>
Date: Mon, 25 Mar 2024 21:19:43 +0000
Subject: [PATCH] usb: typec: ucsi: Wait 20ms before retrying reset
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240325-ucsi-reset-delay-v1-1-d9e183e0f1e6@chromium.org>
X-B4-Tracking: v=1; b=H4sIAG7qAWYC/x3MQQ5AMBBA0avIrE1SpSSuIhalUyYRpIOQxt01l
 m/xfwShwCTQZhECXSy8rQlFnsE423UiZJcMWulKldrgOQpjIKEDHS32wcH5uil0ZYx3kLI9kOf
 7X3b9+37ptv4VYgAAAA==
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, 
 Pavan Holla <pholla@chromium.org>
X-Mailer: b4 0.12.4

The PPM might take time to process reset. Allow 20ms for the reset to
complete before issuing another reset.

Signed-off-by: Pavan Holla <pholla@chromium.org>
---
There is a 20ms delay for a reset retry to complete. However, the first
reset attempt is expected to complete immediately after an async write
of the reset command. This patch adds 20ms between the async write and
the CCI read that expects the reset to be complete. The additional delay
also allows the PPM to settle after the first reset, which seems to be
the intention behind the original 20ms delay ( kernel v4.14 has a comment
regarding the same )
---
 drivers/usb/typec/ucsi/ucsi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index cf52cb34d285..6b642c4c58b7 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1280,6 +1280,9 @@ static int ucsi_reset_ppm(struct ucsi *ucsi)
 			goto out;
 		}
 
+		/* Give the PPM time to reset and stabilize */
+		msleep(20);
+
 		ret = ucsi->ops->read(ucsi, UCSI_CCI, &cci, sizeof(cci));
 		if (ret)
 			goto out;
@@ -1293,7 +1296,6 @@ static int ucsi_reset_ppm(struct ucsi *ucsi)
 				goto out;
 		}
 
-		msleep(20);
 	} while (!(cci & UCSI_CCI_RESET_COMPLETE));
 
 out:

---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240325-ucsi-reset-delay-bdf6712455fd

Best regards,
-- 
Pavan Holla <pholla@chromium.org>


