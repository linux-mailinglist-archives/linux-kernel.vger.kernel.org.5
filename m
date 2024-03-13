Return-Path: <linux-kernel+bounces-101263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D02A87A4B7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2522F1F22886
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81D91CAA3;
	Wed, 13 Mar 2024 09:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdYURgJ3"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A5D1B298;
	Wed, 13 Mar 2024 09:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710321381; cv=none; b=IIEPQF3ocOebo7F98dgX1s5UC1djVB8Rwc3/Di5Xr8HbPAx2gGvP/VqcCTCwgueIzajBTwEaojWqqxAP0cEijv5P4nSad/vlVGBRsk3UZgb+v12tOYZlEhl3liZuRWB3KX+2pox6jxX6XCLClRrw4G43iOD0GoFEUpwCY/rt+g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710321381; c=relaxed/simple;
	bh=Atlbt8XHVDTUdCT97W7QdTOXLmd6AcNECPeg4I4RqlM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=RQtd/LNhxVIXisxN5tEmQEHRUMl8Z7KUOoIl1cbobG0ja//5tTmDNTAWopMllfMXORiulANJ9kAm9EUh4HQohM8AQOE1UY8Kf5/s+8s8+BxUNk5zxlWJUueJSUcju4Ipd/EnnW5Z6v8qXihANsu7mJj45XcBRDzawJiHVOdF4+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdYURgJ3; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33e95b68b3eso2932527f8f.1;
        Wed, 13 Mar 2024 02:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710321378; x=1710926178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mGDcHoSk1YuhKsU3tKb5CF1JuJEf/myqjNAnBVPHlLo=;
        b=HdYURgJ3QjM7vHQRMylTNx8Ek1XtyZMUiljxpzyBFGuLZrUX37u7MDGmVsd4894zRf
         /y+0R1xPK+v0PE586WzkDG6BQC6TAkvX52AfwgYHaVtYut/9kU1A9jBzoMxZCmLzOZm2
         WfMuu4UosEg0zMM02mqIiwpH7Dfuzmp0mjVKMWHTJeEupQdzDMAJcMjvhJRM3bFKRWuW
         iuyYUXIKNcFVkYWgsdKdlW3/1aLq8F6GckDTsXd150jovZ6Unxb82wAY9QQ0SawBPXbL
         OhuYRzN7vnkIRuAJjoyxVik0IuaFtw6iiX6z5/jisc8UE3C0Fq20i44bvkVCR7koGB87
         K6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710321378; x=1710926178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mGDcHoSk1YuhKsU3tKb5CF1JuJEf/myqjNAnBVPHlLo=;
        b=fpEFH61mt7M/u6AFE4tUrsfZIDypdTjrz9nVt4du9PvwZK2OT67V4KujnLPLi51xd6
         NVofh8KtQKGAnM7Y6ZavXe6KrW23Ov3e7gAVO1LpxUi8r9SH0DM9aV+KN9JKW5K7d0i9
         Ep47BdcyuTcjBRFvx9pdWBwgWZlOsDJkhrHiwSxKM11/1gZhobVJMMvRgx6J1oG2d5co
         aCELgMaDtSCJwWvHq4d23Uz9QtJzDyqf1uq04AAcb00ZVu1oi0VMXRqEUtmoNw70wC62
         RvZS/PicgYP1bBEg0M/tRcuY2r4FU/50iddmie43dBgSDWq525oofLdJcRQtNNzQhFJd
         890A==
X-Forwarded-Encrypted: i=1; AJvYcCXQQ1FXKKyIlQrmF60G6tKnHUj6GnM/Gaff0zY1sSgKe8T8MiSSL5ADmRIiCcIrOMHpV3+20kGt4CBO8fEezKd/6XMGDSbowI+sC77C9y1YEXs53d7cvWVq6GEoS70RhU+phLP6NY4jMg==
X-Gm-Message-State: AOJu0YwhP/np7nAbHIm+cD4EXGpGQScojydeLr/8fKUzvIiGJlSbnprD
	8OljKlBdnObmoZRcjCv7C4yUMijFxB6xWLFLigvVhhkZGEVjBG/e
X-Google-Smtp-Source: AGHT+IEruf3cpMcjdOkRLg3eoF7si8rSAhEbBa0Ar3XOh98WB9H4ieC6eWWoBlx+qNRNT7qF6mweCQ==
X-Received: by 2002:adf:cf07:0:b0:33e:b316:8597 with SMTP id o7-20020adfcf07000000b0033eb3168597mr1086816wrj.50.1710321377725;
        Wed, 13 Mar 2024 02:16:17 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id g5-20020a5d6985000000b0033d6c928a95sm11210707wru.63.2024.03.13.02.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 02:16:17 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <sfrench@samba.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ksmbd: Fix spelling mistake "connction" -> "connection"
Date: Wed, 13 Mar 2024 09:16:16 +0000
Message-Id: <20240313091616.2266107-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a ksmbd_debug debug message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/smb/server/oplock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index 9af5fd68bd85..80971e60ca10 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -1843,7 +1843,7 @@ int smb2_check_durable_oplock(struct ksmbd_conn *conn,
 
 	if (memcmp(conn->ClientGUID, fp->client_guid,
 				SMB2_CLIENT_GUID_SIZE)) {
-		ksmbd_debug(SMB, "Client guid of fp is not equal to the one of connction\n");
+		ksmbd_debug(SMB, "Client guid of fp is not equal to the one of connection\n");
 		ret = -EBADF;
 		goto out;
 	}
-- 
2.39.2


