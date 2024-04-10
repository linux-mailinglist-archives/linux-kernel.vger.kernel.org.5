Return-Path: <linux-kernel+bounces-138799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECE389FA7E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D47AC1F2E985
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474B116EBE4;
	Wed, 10 Apr 2024 14:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJy7eDP4"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ADF16C86C;
	Wed, 10 Apr 2024 14:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712760101; cv=none; b=Lukysa0Iao1eGIYQdaFGpxHeIi/eO2zEHiazx9EpLjx9rDXj0TyAoFaVXMJFIUBT8lQP7roJ2WDGmoOYnrdJtOBujCNB2xJNeTT9evaRkkeU3C/A6rfUm/BxN//8/LXE+VO8WB0ARXTTXNy3UGEtQQbA8R9YMUkiNVP8lQaQkA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712760101; c=relaxed/simple;
	bh=eXwx+wQoL+ODyiiDFEy2/qkqUwkZPi5ZruoSzmPNn1M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=cNzfLWpTvKIhGgL5UhwN7VYQHuXGzt/FqJ9WwOYZrN4ObZJeLEDw21/WFe33wEB8Tw0wx3dHydG4fQQfufQ9l6Asl36qquq6zb48d0Ci189uKFxJ6/QAn7Tax1BkhP3jVpAdJVPjoYu71LaRz2ld7lc7gyBnorbOL9IKKtqOYHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJy7eDP4; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-516cbf3fe68so8395391e87.0;
        Wed, 10 Apr 2024 07:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712760098; x=1713364898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8r4DtfNp8+A8ASHcNQoOpnxAj+pTDEaZ0fpsKFQEyGY=;
        b=CJy7eDP4F9gNrpptGe8WLFni4+OJUtPBVIqfIRaJzI+6FIbZKm76nP9FJWMiMlYWoI
         bj8Ec75OOGPiKlDTRCXOTg+IrYnb873oIvYEmKMH/81q87aZIPXKCaKvd2jF6+zbVG17
         HQaC09WXqu4y5RL9C2A9DUZIqQ0f0TuzSlw9t+THOS0hWT/G1iXDWJSi83dFU8bZ+NK8
         X+EOSChEcGJ5km3QVyZ7/5c76pQD/h6tqsOVYgaOvbzDl7KnUHlsCzrAedd/+ioBzjNs
         cdeAzAL32B24qZIzz0SUhBqbbodi1W47KfkaSMt1/ir1LClGybcYWxTyFYRuQOR6lUz3
         kDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712760098; x=1713364898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8r4DtfNp8+A8ASHcNQoOpnxAj+pTDEaZ0fpsKFQEyGY=;
        b=FuqCFV80pjQL+OnqAeZQwfWnMQD/5MJcK/DhLGHaTTPDcretgYGWh+pGSuxoyG8ngH
         sM+YHng2FxGZ4pRI7lPxLR/o42f+W6zRDLM87hqxqm3dEN/KsJMZHNPqKU6BPlxz15aD
         ilt4QVcFfxs2kIQr3EjBwnWzai7lftE/UXVRk+oPBS5+A4AWZ/zI6ZlSI4Qd/hWi6Apv
         iWgtPqXnTc/Ycfe9SrasYzXdrwrVpZhYDmFksPXrk+fXWk3riFciSzSrvhOcf9bNo/rw
         4OA7vSLE/zK3WWv47Uw+H9Da5zMeBUbVlcUgBg2fBoLn817rGsc479xGArJ+zzp13Vhx
         KjKQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0FgkZWCofetCaXxXtZ6UHHbFYtVbv1TzX9UuoISx7zVFEtWSMahaYDj4uJFk/sNt/AJi5/n+G+McqBGzUtVjk+0W95r5Duuy09dgQsv9VmPzOZMSRKv22VCdxJxGqqoJcXspp
X-Gm-Message-State: AOJu0YyDpfYKkSpW8oEFBhJWJJ5jtvny/64+S2PV9oOApzPPN1pQcIqU
	8O/C68e8Ls64b+E0Gkd63RjdnR40KEliAxV2T25QYly0nwBOz70K
X-Google-Smtp-Source: AGHT+IHbr/StM0jqKWACoAq/R6iJnAXnIJZzSuEHigaUgH1vDTMz/X5SPGnGZEfn0wpbYvvQcJUiAQ==
X-Received: by 2002:a19:5f0a:0:b0:516:c4a8:8950 with SMTP id t10-20020a195f0a000000b00516c4a88950mr1709689lfb.8.1712760097737;
        Wed, 10 Apr 2024 07:41:37 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id k2-20020adff282000000b0033e9d9f891csm13839564wro.58.2024.04.10.07.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 07:41:37 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] tls: remove redundant assignment to variable decrypted
Date: Wed, 10 Apr 2024 15:41:36 +0100
Message-Id: <20240410144136.289030-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable decrypted is being assigned a value that is never read,
the control of flow after the assignment is via an return path and
decrypted is not referenced in this path. The assignment is redundant
and can be removed.

Cleans up clang scan warning:
net/tls/tls_sw.c:2150:4: warning: Value stored to 'decrypted' is never
read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 net/tls/tls_sw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index b783231668c6..305a412785f5 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2147,7 +2147,6 @@ int tls_sw_recvmsg(struct sock *sk,
 		if (ret) {
 			if (err >= 0 || err == -EINPROGRESS)
 				err = ret;
-			decrypted = 0;
 			goto end;
 		}
 
-- 
2.39.2


