Return-Path: <linux-kernel+bounces-149167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A49E28A8CC2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DB6E1F2358C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330AB383A0;
	Wed, 17 Apr 2024 20:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PPD1h5D+"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170623839D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 20:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713384465; cv=none; b=mcCEOZbol/FcYxO1Ub1M9JQTjb2xauqDurTwauX1ajo9IjFqJEiKaYwgo5qm9phc6uo6iiBeT8EYkszoRbK/L+Z7NU4V4LsoTsKeZcYzun83WzT9or6MZZCsI4ao12GHKxAEKtPitAxh7Oc7Er1IF8iHTyFr6yJRguYX5ll5Occ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713384465; c=relaxed/simple;
	bh=R/Fnwb9c9N8aN1+rMEQSyK+TRzGedantgI6SeqNlfoo=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=oWOW5ISANFu7I7sTTjxQHQbLrSgG8xeVmCNBeDK6W1xCtT46E+cr6xGMpoZNdNYlcdbS7y4Ioz937zAS2BQyyGDF+2SXsRAYvXl2pyLlNyJsRY3h8Z0wVJVnzhJPvcbahijExQQZQimdSBmLsQ5/mPc7ChebKq7rampZibfu1Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PPD1h5D+; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc693399655so314454276.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 13:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713384462; x=1713989262; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O5cs1fBxJDaZN6YqSCf5MzlG00LUScCVPL4VGimu12Y=;
        b=PPD1h5D+shMCwX36tEyIlpFneYqo7RAy4szqfmloBd+y445eHEzqAAd7CnMkAC7+pu
         Pfv4pEAXUMoFaSNP+EprS5cifaNz//I9+7P3dhOKcO2cl4qxPDxQYq+g4gut7MW3wxRw
         kbjwO9qvDZdB6dD2jtnV0JO9yYlPtVj7pWnbpdnKfrkXiReWiI+yPkIIELt6ywS99RbD
         565xoAZfHn1grqTSepPHMejByj19FIYYjEUIV0YnOmReqviLt+5OutOkSFBY4jmFZtEo
         8Z4JF2x3fn4jqq8On6AtEgUDKScMw1vwqEZ4seMpC5Qbyez8UKOFhcAzoCM5iDHjueTm
         g6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713384462; x=1713989262;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O5cs1fBxJDaZN6YqSCf5MzlG00LUScCVPL4VGimu12Y=;
        b=KgoblUT3YWzOcqreLkthdkjRvYhKcOnegcBzzWRCD+go84OzrLmwaislA9915sSJ5B
         CB1oVL69EYHJMCwpzcyhrRU1RXHnQpLEMBYDrbe0IY3DPPuDbCZOho8cP77F1omw6nse
         c6+r0S8dGgaAjtBjYKWxFUsFoBPEEouMWLDOQH3cGKezNd4rRmmSzqf7SIJdR1yJ8EY3
         zbY2wouRmnNJJZiSpXozuOlTWZKAn6/49amx+41IhGI8gd5iWCgPwZiYsOVdmgiz8rAO
         y+QE3hK6hjVd7LJ3ntFKgQcTB6EjnHAFo1YpLrTMAEdQz1KgCK4edMoRD/1q6B/4s2ZW
         J/0g==
X-Forwarded-Encrypted: i=1; AJvYcCXi2ZE+ZwXhfLHvD1Ro5pTbw50IesKhXRLbMSHLl8ZS1ILNB5vMopaLQcAFPGLTeefvqc/AFMQIH7NuBcDetcsuGhpRQjLyADqo6wPJ
X-Gm-Message-State: AOJu0YyFbYeGA27KEuJMJmhsoy7ZHWA3/iAKtkCx2nzBNG6bssCMW2Fs
	7TDnr6xZQYq66Zwcjvlt2QQcTZe2+K4Vdd1m7mvtL9EpqVO4y8SKIS4AsnZmWsSCz8YFcAfnEre
	5IwhcGZOWiww/iQ==
X-Google-Smtp-Source: AGHT+IHVH0/P6V4QetaySMqB9+GumxJzFMTPG9+eO6bnMhfvbIyKW38v4Q19n4x7pzRVOb7RLYI4EuzMUUs+qLw=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7d65:be58:393e:6674])
 (user=saravanak job=sendgmr) by 2002:a05:6902:1149:b0:dc7:8e30:e2e3 with SMTP
 id p9-20020a056902114900b00dc78e30e2e3mr112153ybu.2.1713384462059; Wed, 17
 Apr 2024 13:07:42 -0700 (PDT)
Date: Wed, 17 Apr 2024 13:07:37 -0700
Message-Id: <20240417200738.1370896-1-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v1] of: property: fw_devlink: Add support for "power-supplies" binding
From: Saravana Kannan <saravanak@google.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>
Cc: Sebastian Reichel <sre@kernel.org>, kernel-team@android.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add support for parsing power-supplies binding so that fw_devlink can
enforce the dependency.

Signed-off-by: Saravana Kannan <saravanak@google.com>
Cc: Sebastian Reichel <sre@kernel.org>
---
 drivers/of/property.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index a6358ee99b74..aa83e9bb9bad 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1252,6 +1252,7 @@ DEFINE_SIMPLE_PROP(backlight, "backlight", NULL)
 DEFINE_SIMPLE_PROP(panel, "panel", NULL)
 DEFINE_SIMPLE_PROP(msi_parent, "msi-parent", "#msi-cells")
 DEFINE_SIMPLE_PROP(post_init_providers, "post-init-providers", NULL)
+DEFINE_SIMPLE_PROP(power_supplies, "power-supplies", NULL)
 DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
 DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
 
@@ -1357,6 +1358,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_backlight, },
 	{ .parse_prop = parse_panel, },
 	{ .parse_prop = parse_msi_parent, },
+	{ .parse_prop = parse_power_supplies, },
 	{ .parse_prop = parse_gpio_compat, },
 	{ .parse_prop = parse_interrupts, },
 	{ .parse_prop = parse_regulators, },
-- 
2.44.0.683.g7961c838ac-goog


