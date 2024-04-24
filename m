Return-Path: <linux-kernel+bounces-156865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4068B096D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CD3B1C23FC1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE5B15B153;
	Wed, 24 Apr 2024 12:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ExKG6atw"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E806215ADBD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 12:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713961554; cv=none; b=AKK3M1iUU0q4cOJNP7f0e1M0ahyNQObhZryKglhivbnHCjdB5r3wUkvtM+Sv7hVwUVVotgFWLa0mDHVrsdZOzJwPnwYPIiSM+kEsUeRJStlWwpzP+pujUXfAUFKab2kkbJb2rRknCkiSIdPZUGOz7ADzAqnhG/Y/1gbCSCV0mrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713961554; c=relaxed/simple;
	bh=rG4d/MnWfaOjQq0qDrwsQuXTojlbohycGBXya8OAIuc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B/Y4wm3ua0ilAFppncMVABWG0N2YjFqfk9mTqAjZGImYp0MDCryWaGRagAyOQlKxCa7oyW5sUNd2O8DY9tFpFRIoGWHrLOT/Jakx2Vd+rQPvRrbXXXO/gOPPFqgjqydnp1HLeXiekr1h8GStFp3nhMvDnCWHCQDf5BK0Ag3oLZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=ExKG6atw; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a55b2f49206so154833466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 05:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1713961551; x=1714566351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6EK3Y3Nu/Z/IArF7/R+9U8KrZLCbZgIZZgP2Ef02z5M=;
        b=ExKG6atwAgL7C6fnrea+BqyqoHZykKEJrQHLkHzYMLyY7CJqm/WrtYDEv8cV6kX/+o
         jb6n6oB+BYouLXLBfA4MpxoHXKHhnOG/23xi8Btyhq7TRVJ6wBbp76weOVnV0TJj0FpK
         42JHhGB396j2YTrxghW9U22LWtaywwUJdgDDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713961551; x=1714566351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6EK3Y3Nu/Z/IArF7/R+9U8KrZLCbZgIZZgP2Ef02z5M=;
        b=QDIGuPhGn+i1IuC7ZYa/QXzhaZo7GbfTNNSb+J1ie/L5Ly4ACm2xUk+JDt+Krhucc2
         ldZqk/RqG+ouyD2q+qDeATkM/tR8NbwYohVL26Sicc6WhoEj2nj1pDlKrDakHzU5I2QN
         gaWDoZnL0WfOu4qgP45gKYlzmbH4b2sI8XuB/dJz6paW+9bosU/+AcNurMEEHBUczf9i
         q3ErofGUeNYDmUWtaQ6Xqi1qgz3s1ZgU66TEFcf9Lk7tT3SkX0VX/d5GJxOMZIbSt9be
         4BTX+qerDWi3xajxvuyWnce1tAQWM0Uz2G4dqvyM4Z/5o3S4YfOLdrUFajcYMchI9ig0
         4UPQ==
X-Gm-Message-State: AOJu0YxetTYjBnIGjAGtmRXC0/VBU41OfhJnzpLPnhKQZAsvtXvqY1bj
	PjinbdZXYaI8hSoCAyKNXTUOQ0haG7d+oQYhraCNB1XS2pkQc/ZrqrVXLRPrRzhqzl0uLs1y+H5
	bGeI=
X-Google-Smtp-Source: AGHT+IEACSnmOdwmOybMgM4QKn4HHUlMUtN23mOm1fXXJAGTvhFCmotMYTZCKh0njhVYjNRuha5ZqA==
X-Received: by 2002:a17:906:3485:b0:a55:690b:b696 with SMTP id g5-20020a170906348500b00a55690bb696mr6278162ejb.9.1713961551046;
        Wed, 24 Apr 2024 05:25:51 -0700 (PDT)
Received: from andrea-amarula.amarulasolutions.com (212-57-59-66.xdsl.deanconnect.nl. [212.57.59.66])
        by smtp.gmail.com with ESMTPSA id bi14-20020a170907368e00b00a5588ed8fa2sm6755202ejc.113.2024.04.24.05.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 05:25:50 -0700 (PDT)
From: Andrea Calabrese <andrea.calabrese@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org,
	Andrea Calabrese <andrea.calabrese@amarulasolutions.com>
Subject: [PATCH] map.c: refactoring magic constant
Date: Wed, 24 Apr 2024 14:25:33 +0200
Message-Id: <20240424122533.79720-1-andrea.calabrese@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In map.c there is a magic constant of value 255 for the maximum number
of probes. It is in many places in the code, in this commit I modified
it to make it more clear

Signed-off-by: Andrea Calabrese <andrea.calabrese@amarulasolutions.com>
---
 drivers/base/map.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/base/map.c b/drivers/base/map.c
index 83aeb09ca161..b27f0cf557f4 100644
--- a/drivers/base/map.c
+++ b/drivers/base/map.c
@@ -16,6 +16,8 @@
 #include <linux/kobject.h>
 #include <linux/kobj_map.h>
 
+#define MAX_PROBES = 255
+
 struct kobj_map {
 	struct probe {
 		struct probe *next;
@@ -25,7 +27,7 @@ struct kobj_map {
 		kobj_probe_t *get;
 		int (*lock)(dev_t, void *);
 		void *data;
-	} *probes[255];
+	} *probes[MAX_PROBES];
 	struct mutex *lock;
 };
 
@@ -38,8 +40,8 @@ int kobj_map(struct kobj_map *domain, dev_t dev, unsigned long range,
 	unsigned int i;
 	struct probe *p;
 
-	if (n > 255)
-		n = 255;
+	if (n > MAX_PROBES)
+		n = MAX_PROBES;
 
 	p = kmalloc_array(n, sizeof(struct probe), GFP_KERNEL);
 	if (p == NULL)
@@ -55,7 +57,7 @@ int kobj_map(struct kobj_map *domain, dev_t dev, unsigned long range,
 	}
 	mutex_lock(domain->lock);
 	for (i = 0, p -= n; i < n; i++, p++, index++) {
-		struct probe **s = &domain->probes[index % 255];
+		struct probe **s = &domain->probes[index % MAX_PROBES];
 		while (*s && (*s)->range < range)
 			s = &(*s)->next;
 		p->next = *s;
@@ -72,13 +74,13 @@ void kobj_unmap(struct kobj_map *domain, dev_t dev, unsigned long range)
 	unsigned int i;
 	struct probe *found = NULL;
 
-	if (n > 255)
-		n = 255;
+	if (n > MAX_PROBES)
+		n = MAX_PROBES;
 
 	mutex_lock(domain->lock);
 	for (i = 0; i < n; i++, index++) {
 		struct probe **s;
-		for (s = &domain->probes[index % 255]; *s; s = &(*s)->next) {
+		for (s = &domain->probes[index % MAX_PROBES]; *s; s = &(*s)->next) {
 			struct probe *p = *s;
 			if (p->dev == dev && p->range == range) {
 				*s = p->next;
@@ -100,7 +102,7 @@ struct kobject *kobj_lookup(struct kobj_map *domain, dev_t dev, int *index)
 
 retry:
 	mutex_lock(domain->lock);
-	for (p = domain->probes[MAJOR(dev) % 255]; p; p = p->next) {
+	for (p = domain->probes[MAJOR(dev) % MAX_PROBES]; p; p = p->next) {
 		struct kobject *(*probe)(dev_t, int *, void *);
 		struct module *owner;
 		void *data;
@@ -147,7 +149,7 @@ struct kobj_map *kobj_map_init(kobj_probe_t *base_probe, struct mutex *lock)
 	base->dev = 1;
 	base->range = ~0;
 	base->get = base_probe;
-	for (i = 0; i < 255; i++)
+	for (i = 0; i < MAX_PROBES; i++)
 		p->probes[i] = base;
 	p->lock = lock;
 	return p;
-- 
2.34.1


