Return-Path: <linux-kernel+bounces-153031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2A98AC814
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EB121C20D73
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8F7548E5;
	Mon, 22 Apr 2024 08:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="YNrr+oQN"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD87E5476B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713775916; cv=none; b=dMjZC1PjrVEgE3m/HFEKasSRFuwYEzA7zuqXda+IUkZMn9UAQFdXNSuIIhyAC8XstY9NYvQbuw6wwtAALqARNac4t88awY0PwPQgHTMezCtorPgn7Lopu5pixlHn1SVI+wGBHA9XXm8Dw9i7gGbooTC6BPqx2U6UzX1caWCj1yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713775916; c=relaxed/simple;
	bh=OnecIB8JDwgB/Bk68alFDNibbe/+MkHa6aJTATPcuvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cj1hKdc5yEoK5/ZYyI1LNc6iSkptt7y8A5mTC20KI5zwNUCU02hOWQieETuYAtFKGbLzVeHjl2YM7GUqeNk4tv9baCW8SHz8TH506wwU3grriucfnoDiWs0U1nbIC4z2xMDjQ96Sk8RdUYRRUN4nLnbZRA0Pu6FizRFbfdYqv/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=YNrr+oQN; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e69888a36so4398569a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 01:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1713775913; x=1714380713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Rt1DqzZQHpNrcSkrbFzv1k9hIQM6x7OmI+95yCtyQs=;
        b=YNrr+oQN81N9a8o7yjoRf6AdqL4nBcNRfWtWxL6sitgSajD9L1p/+KDdNQWyjgXI3b
         f4Lx/XnkoUxmMKRoyabPMAREbGq1T2aevDgf06kI9/36ulBcvNbH3NFx2aDLcQZjUDR/
         Oom6LSmgn5xMbTiLnRqxCEiHSrBtCCXPTPGN0cWjbqq5ySIdCK8Pa9Ln1KtmcId3NMwo
         r0LD23GXg4JG8xHzgjYddnFjZLVjDyx/BMyZSX0oEhc6j88HWJL1axQ+Jq5M/ss95VQM
         M8+hB7kxi7XbnjDnQGWdpWbRhOFUs0MNWFVzY6kf/yLLnRulFSQrD1/OpcwlaXPbbWx+
         /qsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713775913; x=1714380713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Rt1DqzZQHpNrcSkrbFzv1k9hIQM6x7OmI+95yCtyQs=;
        b=W35SkWeQhaRGpl7hf4xi4tslxPSfHM+uATv+1uyh6muJUyUOiNa2gqnzYfqQ3E1DhW
         cljlPVc9Uzj1UYl/Am1dLOedgIbfFjIpn2/P1VZzvo50cY4fS7h5mbG3PuhWvLg1i2Rp
         4QH9om3g4VJ9NtryzWA/eN3g8zJRUL7crT/uemgB0BHJfqFX43Xhpv/QfFMFp30DX3wQ
         1P3KwZQCTkgs5GPJM+Njv88iaEUliLAHlTTJ9SaHpRW32TAeYJyBFwQJMQhgZJUNty0t
         l6L8S6rt52cSW/EDiYISn5ek8Zpvkc/Bw4aGRL/eFkZUBPKweVoqnOKFpFtvV0pG75is
         jGww==
X-Forwarded-Encrypted: i=1; AJvYcCVQAyPK28oAZyGLZNfyDD9bOS3kfiWrpHhKEqxcTnXAQ2bgvdNdky29Ih+nnBHpezxil3jSrpo/GhMJh85ZIuZggWaD4Pji3OFUxliR
X-Gm-Message-State: AOJu0Yyx8MPyYnnC5VG5rptWel4BombNktuIiNz4wYIF4vYxRl2+7/xK
	udQLZs8hasM211nXN+i3kQZOaChMdS9c/YxZTgzdAVebNpGm+Z+aTBBCvPCfQEo=
X-Google-Smtp-Source: AGHT+IF7QX6NRCV7ovrGSxFidjCjmfTcvLkiHjj27eK6dCisOE2ZdrZ0NYqSZfXRrA/2AYtLK+SrMg==
X-Received: by 2002:a17:906:3196:b0:a52:6e3b:fcf1 with SMTP id 22-20020a170906319600b00a526e3bfcf1mr5818778ejy.17.1713775912963;
        Mon, 22 Apr 2024 01:51:52 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id gh16-20020a170906e09000b00a5180d5b31asm5481921ejb.32.2024.04.22.01.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 01:51:52 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: dianders@chromium.org
Cc: christophe.jaillet@wanadoo.fr,
	daniel.thompson@linaro.org,
	jason.wessel@windriver.com,
	kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	thorsten.blum@toblux.com,
	yuran.pereira@hotmail.com
Subject: [RESEND PATCH] kdb: Use str_plural() to fix Coccinelle warning
Date: Mon, 22 Apr 2024 01:26:03 +0200
Message-ID: <20240421232602.956049-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <CAD=FV=V3Cpo38ss1nFvPMbXadaXXpVuN5jdfUKZS4ngDLQX_wQ@mail.gmail.com>
References: <CAD=FV=V3Cpo38ss1nFvPMbXadaXXpVuN5jdfUKZS4ngDLQX_wQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the following Coccinelle/coccicheck warning reported by
string_choices.cocci:

	opportunity for str_plural(days)

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 kernel/debug/kdb/kdb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index d05066cb40b2..664bae55f2c9 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -2517,7 +2517,7 @@ static int kdb_summary(int argc, const char **argv)
 	if (val.uptime > (24*60*60)) {
 		int days = val.uptime / (24*60*60);
 		val.uptime %= (24*60*60);
-		kdb_printf("%d day%s ", days, days == 1 ? "" : "s");
+		kdb_printf("%d day%s ", days, str_plural(days));
 	}
 	kdb_printf("%02ld:%02ld\n", val.uptime/(60*60), (val.uptime/60)%60);
 
-- 
2.44.0


