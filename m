Return-Path: <linux-kernel+bounces-92893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E28388727A7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A7D128D7CB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D154CB28;
	Tue,  5 Mar 2024 19:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="Bm6Put7D"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B850D1C01
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 19:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709667511; cv=none; b=ChzladgKrOO05n0sQNlBY6/BVgHqJS4EhV5bruMIz4HqXYXYhIxKpBYP0Psr1O0OfPxzfjqGAcuWu6oKaltU3HJ8WZvErkFextXLwxgSykZXRJa9Y0a5ipEsOUuhh65FjDO511yqnILnze6oJ48IQZgLfdLAQcj8/RFBEaPwZFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709667511; c=relaxed/simple;
	bh=P/X134+zoyg4s2Jot2r3ay2hXJWBr990/o9hJjnwWHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kOorzsObCfc3EHDCZx81lq08H79yauQRtsE7Y7ZBhem8waovFC1Gd3gZ4hS3PV0lHT1Q5+8bPXSnSq610nHNYnSqPiDt0ro591OLy/25xW4UAlKHwGKOHqsyZdpmIz77e6uc+TvA5F7qur/Yq/rAK0bWDDNtA1VkZNDek6gkL2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=Bm6Put7D; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5dc949f998fso925401a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 11:38:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709667509; x=1710272309;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXfr5UMOCR8axjFfy2MwIX+Lu8p2xjOpYgSyxav7TR4=;
        b=n7MIobCAZi3HUtBUouoxKEpMfdjARMRyoudG+Mqiw3G1yDpbgJRRqKGP7TNkcCWOQt
         qz+0Vjq2jOZJT9UwIjpZfi9IMmYrYBFMpKMQkMUUVLyqubR+vBXgzFn5JQ3O+GNZbBrA
         drnIydS4Kv2JU3EhGY1i/Ja2hSrUAdtS38/7z67L3WmRzBcb7UMDctFXKOXezNkUiWVx
         61yk8DUjsL6L/rnSeAH1ZjBSMFs+BQyuJXgFaMLELfEPFV37tYdYwvbWcK1FsaS9FJOn
         5qjC8eGFdZ9iRNq1UFSB4QUX7iknbgFFzIghmEclzb/dXZHa/sPlMbZZpLFq1TEbXzWm
         2VQw==
X-Gm-Message-State: AOJu0YwcMq8Zs4Ny4gf58e7xNn4t93bnJbpzyFuZaK6drHXdiOshdwvP
	KLeK/Bs14UJMo7DcVjoE+7PtJK/FS3Dje/GmiWLML5ufbcF5ZvyKN1jzYDuSDqpcyw==
X-Google-Smtp-Source: AGHT+IGANiNPnKLY5iyZLa/wKEafOGgKGJRk1y7HKsI81neSolD6PcsxMI6uPGL7vdzCegINIrcrLA==
X-Received: by 2002:a17:90a:d315:b0:299:8ff:40c0 with SMTP id p21-20020a17090ad31500b0029908ff40c0mr9832092pju.28.1709667508954;
        Tue, 05 Mar 2024 11:38:28 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id l22-20020a17090b079600b0029a8e5355fcsm10026978pjz.53.2024.03.05.11.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 11:38:28 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709667507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AXfr5UMOCR8axjFfy2MwIX+Lu8p2xjOpYgSyxav7TR4=;
	b=Bm6Put7DwFpne8ftq8M9r7dESg4K8ewJy8R44hkVAqa4+CysF42OJxSBUNp4+DfsnTs5Hc
	Bk2hkqBEvYxk57ky2DD9nZMOC1aLbMvttbDPgJypksIWtC+2+wub6T1hUrvso3kWKn2X5j
	dS7Mq1lDRF1G/msObNq4IuqJKx7TSTnJUGFSQ9MsLPkmbvO1aXhSvt9md1j29EaW8gqino
	5rYqYk7mWVwi1kV59p7aDBSWQIN8oXh1a/ruYAW+BTgLSqg8oe4KM5LBQnEqNwodwzibP/
	Nx1k/AlO3oMP79HmAZeHNIk7s8U5I/9jJSH2HabpVBbiLBNZ7hTekYOG4rTuuw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 05 Mar 2024 16:38:25 -0300
Subject: [PATCH] pcmcia: cs: make pcmcia_socket_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-class_cleanup-brodo-v1-1-9bac7b015641@marliere.net>
X-B4-Tracking: v=1; b=H4sIALB052UC/x3MQQqAIBBA0avIrBPMCqqrRITpVAOh4lAE4d2Tl
 m/x/wuMiZBhFC8kvIkp+IK6EmAP43eU5IpBK92qRnXSnoZ5sScaf0W5puCCbLpNm6Eeer0qKGV
 MuNHzX6c55w+laSEGZQAAAA==
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1858; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=P/X134+zoyg4s2Jot2r3ay2hXJWBr990/o9hJjnwWHg=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl53Swm6kHlOSIPs1UhLtSg+MdfWuMcywtuuEkJ
 KuJv1brarGJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZed0sAAKCRDJC4p8Y4ZY
 pl4aEACnZBgAW55z5Y4KPR71YvKK3gWZjKqPpvdj46dCyDV78AEV38YH9b7+Z1yu0xUNHFpatew
 xJ19stvaBgbq2aAWkqBDcNVIbxpGhFX2ffAL0m6YD9tyDbX4d6KwUE+I0WZojTfvfjQEUwhpmCd
 DZXg5MvqvQdk59Y2KhUoOKmhJ6XmJ5vZGHygo6zb84xsyPBkul5TWYiuAGbdUOgtAxw/7XyulQa
 JQsJXLO+3KCo01yKGz+Sja7yOBqUSAkmRz4D4jwrMmxBVxkbtVus6JJG27TWHe4l300lJTa1foC
 qtvDLi9NiTsCzzf4g6Vu4nZaVqJ+qPE47d/fK4869yRt+5HcZ0N/TnpbtkB+fdceRP1vWGeLxPG
 jQmLyJcwV5VWoUjOfXHZ3ma1adFXpEoFs/nbIwD+ZjHUL/FSqOCtDanpYhDSEk6DPF4tnDZXtZJ
 NJOLi3NYcjnQI8Aos7W1n1X6bbL00ftDm5heNziMAR+lThvbG+LL/2+y1TwqFSILSYy557yGcLm
 YbHTsnqNFQVCG5mWH/iz/Gc2OI/MEDo+mzDGfuq96GwZOvG1TfVii2Ra7IOnC0mu52r8TL4X/3y
 Zws4jXP6F9bXYyijs+gG/GGHAM7JYuAr3orFCFU4uq7CrZQ4IjY+wXl4U0orCl9/2hz8yN9/9qg
 pR8H/1cHpAw4lVA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the pcmcia_socket_class structure to be declared at build
time placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/pcmcia/cs.c          | 2 +-
 drivers/pcmcia/cs_internal.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pcmcia/cs.c b/drivers/pcmcia/cs.c
index b33be1e63c98..c75f55e1250a 100644
--- a/drivers/pcmcia/cs.c
+++ b/drivers/pcmcia/cs.c
@@ -892,7 +892,7 @@ static const struct dev_pm_ops pcmcia_socket_pm_ops = {
 
 #endif /* CONFIG_PM */
 
-struct class pcmcia_socket_class = {
+const struct class pcmcia_socket_class = {
 	.name = "pcmcia_socket",
 	.dev_uevent = pcmcia_socket_uevent,
 	.dev_release = pcmcia_release_socket,
diff --git a/drivers/pcmcia/cs_internal.h b/drivers/pcmcia/cs_internal.h
index 999332bc4378..02a83ca44e77 100644
--- a/drivers/pcmcia/cs_internal.h
+++ b/drivers/pcmcia/cs_internal.h
@@ -113,7 +113,7 @@ struct pcmcia_callback{
 /* cs.c */
 extern struct rw_semaphore pcmcia_socket_list_rwsem;
 extern struct list_head pcmcia_socket_list;
-extern struct class pcmcia_socket_class;
+extern const struct class pcmcia_socket_class;
 
 int pccard_register_pcmcia(struct pcmcia_socket *s, struct pcmcia_callback *c);
 struct pcmcia_socket *pcmcia_get_socket_by_nr(unsigned int nr);

---
base-commit: 1bec7691b32710ea27741f0f8b00c1dc98d92930
change-id: 20240305-class_cleanup-brodo-35f2a91982b0

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


