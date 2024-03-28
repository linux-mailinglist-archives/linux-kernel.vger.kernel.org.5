Return-Path: <linux-kernel+bounces-123011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6112989010A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13F192833A2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E028174E;
	Thu, 28 Mar 2024 14:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="qW18UYXO"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FA139FD4
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634597; cv=none; b=MW5Y90GlszY1KnBxMLdxILOlhSSy3CXUKlM2KIK/tCmkFhONe9R3UyyilE4hk53q+RMRgiv6VTL2nXmzM+J8lfR4XXbe/4eLSNFzMzxQKH4PfRpREFCejaEngI9NRkdxZuRbWNIDpgB1USGMz5CvXaSN3Ox2bQm6skckg5udEIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634597; c=relaxed/simple;
	bh=zgoohp6TP+7DK2VDW+QW0zrD0E2nXxV/3n/I1idtg98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jysQq+UZLrLlt6JqP6kRSES+/1ZfPJhGH6MCoKCk7GnHVzQ6uzSHFZMP6k3kyn7ElQO5m3GNr4XdBqU+7mz6QCgrktzn63gr8eYqfA/LpZ5f4nwdVbV7k1rsPcscL8F3ztQsuO35vM4KOxPpNdNPq7Q7Zk1bUTUBNiN3Mcg36uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=qW18UYXO; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a45f257b81fso113872266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 07:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1711634594; x=1712239394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zFHFaYhbiJTu3wWh/FUqbgyhTcKenad53U5xQx+ENpg=;
        b=qW18UYXOZ3sK/9pEP8W5JIaniaPaMGAk4h8g5IDNTmHP6c+nmJgB+9z2RfVNr9JdAO
         DO5GM8edIT6/TDqS36LQGBYQ6M76FO83wFQRxQhDGs2TyD4e7LINHSDzKm5fdazSUEdI
         uDj5kIVwCeCC7kuyAyZMwcGfidTKnSOjj5wZWkbG9YjRtEwWHewgs96DYKq6RP4Hg38C
         ue0Vp7iZ5ZubrUnggZRlXNAJyg0jh1vwT4hPo/RsbB1rHSMr01raFrmoKNetV2d77AET
         CX9EtPvTE07nePtOqRtAZYLrbNod+gA2+fVrubsD6vsBEAqfGxzabUJ9CQ5S299TOtSW
         bJWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711634594; x=1712239394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zFHFaYhbiJTu3wWh/FUqbgyhTcKenad53U5xQx+ENpg=;
        b=DSD6B1A49d0qgCWoUvG7MnovbV7DbupotPilylani16wxBf7RUeTfNpPSKIWQinfgl
         A2QKxTrIow+toVaC/hjB6zd17Q/ugs2dG90p45q86CBPZgp93qkrWrcbtViu+Z+xLEjR
         5dqefDaZuftxdSMW4T0nhCZ9hFS1OO7FVGzEDski3l7TjRCpr/3Y4iJH/tXzu3WKQgY7
         466sNGtLN5gdpiXls5Xhufsh2qyGJ7Wmzky8wmGgqJwnGA+56X5ivEs9blWmpS1ATNPN
         n6dlxy+xz8lGMOyp/DhjpQBddl03GnNtV91ZqVbY17A6n42b1TTYAsVCYMWWydLC+WVJ
         oi/g==
X-Forwarded-Encrypted: i=1; AJvYcCXWbE9JNKJNrPudugcqtglONKePPj/CvhTNQyFJt4SlExPtun9mQTETkl0LCiY9zk9gSieQ5Tt6IEbpGlRfgHXeRdP4oyBN5H44Wvan
X-Gm-Message-State: AOJu0YzWzdXtrO1GxkQA3wQOz0WXqgZRFLeRi05YEYiA27CwXKYiUkj3
	LO2fXJRavLSqJDi0kBXbq4eEbyhTr2etdt+WC0YWP/5lhOSbfAos6zJtuOocCek=
X-Google-Smtp-Source: AGHT+IEVn1KFNj41KXdJYnbXbudHvcOeDBZ/l1OTIy/d6Jkixdhi4F28n2jwIlz35Eq+/ZH+oHbZKw==
X-Received: by 2002:a17:906:4956:b0:a4e:24cf:76d3 with SMTP id f22-20020a170906495600b00a4e24cf76d3mr1345642ejt.50.1711634594192;
        Thu, 28 Mar 2024 07:03:14 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id u23-20020a170906125700b00a47522c193asm783904eja.196.2024.03.28.07.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 07:03:13 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Douglas Anderson <dianders@chromium.org>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] kdb: Use str_plural() to fix Coccinelle warning
Date: Thu, 28 Mar 2024 15:00:17 +0100
Message-ID: <20240328140015.388654-3-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
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


