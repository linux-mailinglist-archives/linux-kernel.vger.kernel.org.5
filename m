Return-Path: <linux-kernel+bounces-98822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD961877FEB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFAD61C2200C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CAC3C493;
	Mon, 11 Mar 2024 12:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUDGwidr"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F8FF519;
	Mon, 11 Mar 2024 12:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710159895; cv=none; b=M54ya5rvgrC0CBVNAWJOBKaZ0Ceyb5FBo780RzXCTvMWUh65qzbHAjGAhiiq0RITj305Bt7f4UTM5hF35UVQLTGg7vG4xx0OWYACYtKuXIesnnb5Y2E17pjSstnYwibdYlNzeWIsTyNej1Kmnwv0swdbk+rIHCoL0rQ0yB2g0No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710159895; c=relaxed/simple;
	bh=LluHyhjKemLvziSLq4mu73Bj2Ez4L1mtMOYpKAIdpW8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Jahq4AfxTBidA+pDAUhzGweIwQpoFAg8OOFnEBeEV+W1+emM/eCTxiYY19ixtUhzRoOo3KEehYcdhGh7uee3OzTeUTT1qGOQqk6B+mzYrTm812dr7XxIaG1DPdT0EZNnKjiOW4R9k/q7SjyMGfyZpsFpQcBxB9rvslRUuvFh1O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUDGwidr; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dd8ee2441dso2357485ad.1;
        Mon, 11 Mar 2024 05:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710159893; x=1710764693; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJV6iNofzvP9/1KByDDXNTrF5EbVufMaGdHaNE1qGbU=;
        b=DUDGwidrhzU+TsTaXz6zPbjio/2q/ICe6r2zTffe9JP+zw+y4wy3uBiIcOh4LeN9p2
         uTgww5iH+BXkauAygiPOFyUXnSIvVDYleloifYDmtOYOyE7X4IawfQPIxHdxyjF9M3sJ
         r3DiV1iRnrgvfcbR6U1Rs0X/UEu6RNh87cQ4EOq1KQRcRk/fVfv9fEQQb5USqgasTCxl
         3cgtS18P1bH1g1+p5dxlwvuzzwZO3pV1TcbMqrE6/AgNQjCZJh0wyjvtxRUARSEXSEAL
         UBqYijAkzET92quzZXugrq2rBCSycnGHGcOPpihkDLy2HvHJTP3In41dFmFMQ6DS1sDi
         MNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710159893; x=1710764693;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJV6iNofzvP9/1KByDDXNTrF5EbVufMaGdHaNE1qGbU=;
        b=Ub67cpu3aoBLQvBt+9ZNBx0gflUP9cwDWZMjFuf50E4e1HTaUcBrqpU1DkpIFAo5tI
         oCZp8d0kTh5YEjNU/yfp1L0ryuh8xJqplzQtpyUTCyo+J6vPo4a59MGPVMEeWQF0EtRz
         0Ou4eGcom6u+yH8UMqnRXCFpLm+8UAHjgAeCTu+BgykcrNugoKIcU2GsmfFKMeYeekcp
         1C8kgxmjnJvKJIpsnMvlTuFzpAl90m+peLQuceXuXcCZ1uciTXv2e8KMkmL38+H4w5hH
         TVvUNkHeAirdjqQgS9MrGikEZhOQXWv8mClqMaqt+2YIc7zwnKlI7WCB5mqliKbyaeRI
         V4zg==
X-Forwarded-Encrypted: i=1; AJvYcCW+V86w8cUGGbOhH8OLH06fCgt372grMH14so5x7M5udG8FJniucuhLv765g+/znlZ5A+e5eC6Rxskfa+GzmMqomnYG8kjk
X-Gm-Message-State: AOJu0YxIrwajbXb2oKwDD5Sdn63pCondr8NWhV+QNudAfqCeXVgJq7pE
	7TcO1CCIoHTgT9hdY13C8jVuLjb4KS2S6FBjtDml5h/dn8p7Qz+tP+w9mjFHBP/1RF1c
X-Google-Smtp-Source: AGHT+IHck0HQwvtlHJQzVHVrty9+g5PpjZj7C8mI81TwnrdjValzLLBDT+ZhtfYoISQ5QsL8BOBcIg==
X-Received: by 2002:a05:6a20:9587:b0:1a1:67a6:511e with SMTP id iu7-20020a056a20958700b001a167a6511emr8859997pzb.2.1710159892844;
        Mon, 11 Mar 2024 05:24:52 -0700 (PDT)
Received: from localhost.localdomain ([111.194.45.84])
        by smtp.gmail.com with ESMTPSA id p48-20020a056a0026f000b006e69a142458sm1075106pfw.213.2024.03.11.05.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 05:24:52 -0700 (PDT)
From: Zheng Li <lizheng043@gmail.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	nhorman@tuxdriver.com,
	davem@davemloft.net,
	jmorris@namei.org
Cc: James.Z.Li@Dell.com
Subject: [PATCH] neighbour: guarantee the localhost connections be established successfully even the ARP table is full
Date: Mon, 11 Mar 2024 20:24:01 +0800
Message-Id: <20240311122401.6549-1-lizheng043@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Zheng Li <James.Z.Li@Dell.com>

Inter-process communication on localhost should be established successfully even the ARP table is full,
many processes on server machine use the localhost to communicate such as command-line interface (CLI),
servers hope all CLI commands can be executed successfully even the arp table is full.
Right now CLI commands got timeout when the arp table is full.
Set the parameter of exempt_from_gc to be true for LOOPBACK net device to
keep localhost neigh in arp table, not removed by gc.

the steps of reproduced:
server with "gc_thresh3 = 1024" setting, ping server from more than 1024 IPv4 addresses,
run "ssh localhost" on console interface, then the command will get timeout.

Signed-off-by: Zheng Li <James.Z.Li@Dell.com>
---
 net/core/neighbour.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 552719c3bbc3..d96dee3d4af6 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -734,7 +734,10 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
 struct neighbour *__neigh_create(struct neigh_table *tbl, const void *pkey,
 				 struct net_device *dev, bool want_ref)
 {
-	return ___neigh_create(tbl, pkey, dev, 0, false, want_ref);
+	if (dev->flags & IFF_LOOPBACK)
+		return ___neigh_create(tbl, pkey, dev, 0, true, want_ref);
+	else
+		return ___neigh_create(tbl, pkey, dev, 0, false, want_ref);
 }
 EXPORT_SYMBOL(__neigh_create);
 
-- 
2.17.1


