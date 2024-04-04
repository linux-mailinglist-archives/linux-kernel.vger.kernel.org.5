Return-Path: <linux-kernel+bounces-131263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E92AC898570
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5E1028B661
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6747580C0C;
	Thu,  4 Apr 2024 10:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2tmtILFg"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0728627B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 10:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712227836; cv=none; b=MYHXLZMP4GJ8rAt/b4YK1KY4wTrV+XTa1yGuaWTf91IaA2KWKRIvzanV/5nLnMLXZZJPjE/GOZ7+mm0w/GmQkhyWDp2d98qctcT9NOj9MPh5ndaJjZG9EIR/Ytx+zmFd9Pur5XspQ6VGorkXiBh9/U0CxmZ/mXt7WV8n1tsZBos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712227836; c=relaxed/simple;
	bh=hCUJ9Vyeg9IAERTsInyGPjcv+2BcLki9AiF4RXL+nKk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pX5HfylX5UhBdFk1CeEO2lf0mQEvWhnFt59TuqD9RqLFkPj44pFX8VuHQQ0ZnGvvnA9dtRZRe6mUWin2wMH03qj1k81pnYuatO9sWJWIyPI097YlNxXnIS8GmmhekQffcqCTsXG/NaMgv8LVkz2w71eCtFEgKAIVZ/qvSKUD2dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--apusaka.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2tmtILFg; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--apusaka.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6dbdcfd39so1586222276.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 03:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712227834; x=1712832634; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mlncb6RTaE9eevbsiI44CKn4YnO0CJ8k+DNS9ZBOEnY=;
        b=2tmtILFgzR/QN7WpyW0RJt/3lmH03ce4DXVSkPSwKzDI2n8r/PWBcRjowntWQMvtXH
         n+TodXalvp5hKOUfou2G90+RZ6g7g0uaoH59ILJGIicTA407EM4uqonV9aAy431eoEUf
         Y+bl/Yq9UafV5xZfMSomxHwGQkw9bSjcXth45TQi9cs2yi0tGzs9m4ECiDoISdrPtv3y
         7rI2aABIdutCdP/zwU1YVXDr9hWl7QRQEyK0kgnzKcRXpzMLd9KZwJb72JqQrlp+yeXc
         +aj52IYr3T67WwtGtXQu3zd6Swl3f9KSSVyOzlAIL8rCwda6LNXVI3QR2edf2T1jS1Bk
         t8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712227834; x=1712832634;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mlncb6RTaE9eevbsiI44CKn4YnO0CJ8k+DNS9ZBOEnY=;
        b=dp79qWxCYzzeQpwau31qqjeL03EWq3DdPBbxPSmqrytJ65zC6rza6gVn5vXdxKjVwR
         gEi2HYI23mY2Nv+d4MytiaDd/CnDPPzN/DrmNN0mvCcYP4/5K1NdPCcD9cvEc0Tkm/US
         jLCefEzahoCGUQPY5MGKMmrnT/r04onoQ9ZjnFg6g7Rb/H8gduD6ubb4m33JZ6IBfa0u
         KRHvmpF3vs3MhDDWdUfAIjI1Ne/k1h1TwgLo4J8VVBUd/0KQdqMPhxhc4C6zs5kwuz2n
         oCul2FQrGnfB8VXqnMsfq1kSDP5i4mIjWQVv8h/svWYHpdsSYD1kh7uD/CUCKwT9uw2o
         bCIQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9fj1bRgBTE5AJzr9y3M8HlqFl8BFKf3Ifb03592/9PrLYKB52lY/aUcrBQ3Ofl7jylWe0wC6b7YOxSpd+uVDTai7jT+oTrAst6brv
X-Gm-Message-State: AOJu0YyIVMJv8R6tSrgSygvsFUdzFmezw4grYndgFiCbln2iiQMCOJLT
	gqenEPQ6nT6m8OTsPSmtLIZkCYvKcfP5cPSwbRo/j+3KQN1xpFHeUiA9j+ZTcB46SNSOThI168J
	gFWB6UQ==
X-Google-Smtp-Source: AGHT+IFCI77genrFWALO1MYcTCjnmSXDxKWa/27R7lAj4vgx7ukYdJLz4LoSoP8DLHc1C5Hb9x2H2r3mvNO+
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:17:7828:b507:ed1b:110d])
 (user=apusaka job=sendgmr) by 2002:a05:6902:1505:b0:dcd:ad52:6932 with SMTP
 id q5-20020a056902150500b00dcdad526932mr642375ybu.5.1712227834197; Thu, 04
 Apr 2024 03:50:34 -0700 (PDT)
Date: Thu,  4 Apr 2024 18:50:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240404185022.1.Ic27505c8f1ca7d4a653b1dcc1b08cdfc862a4622@changeid>
Subject: [PATCH] Bluetooth: l2cap: Don't double set the HCI_CONN_MGMT_CONNECTED
 bit
From: Archie Pusaka <apusaka@google.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>
Cc: CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>, 
	Archie Pusaka <apusaka@chromium.org>, Manish Mandlik <mmandlik@chromium.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Archie Pusaka <apusaka@chromium.org>

The bit is set and tested inside mgmt_device_connected(), therefore we
must not set it just outside the function.

Fixes: eeda1bf97bb5 ("Bluetooth: hci_event: Fix not indicating new connection for BIG Sync")
Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Manish Mandlik <mmandlik@chromium.org>

---

 net/bluetooth/l2cap_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index cf3b8e9b7b3ba..b0970462a6899 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4063,8 +4063,7 @@ static int l2cap_connect_req(struct l2cap_conn *conn,
 		return -EPROTO;
 
 	hci_dev_lock(hdev);
-	if (hci_dev_test_flag(hdev, HCI_MGMT) &&
-	    !test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &hcon->flags))
+	if (hci_dev_test_flag(hdev, HCI_MGMT))
 		mgmt_device_connected(hdev, hcon, NULL, 0);
 	hci_dev_unlock(hdev);
 
-- 
2.44.0.478.gd926399ef9-goog


