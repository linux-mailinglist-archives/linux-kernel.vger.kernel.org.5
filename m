Return-Path: <linux-kernel+bounces-75928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD73585F0CF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE7CC1C21AC3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC91171AF;
	Thu, 22 Feb 2024 05:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x/6hA92u"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3391C79F6
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 05:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708578955; cv=none; b=k4TMDh6NbBOnrZpTxfVSgXuv3k7vO1BLlO4JBu10FnUa9ZPllgcfTDa/69FGHIMHvDHuHeyUdHX/PGPFvgt0Nom0zYAZGVK+vYi8a8zJcWrtXez8KdG8AdSAwuxg6sdynhyL0AjqYM2WmM5t1lWnAKEKZmHY/OC49O+hTWS5W9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708578955; c=relaxed/simple;
	bh=ROo+grb2X1drft9415Y+bp5FUcaXg0WwUm5KqmdBWXU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=EGJx0ZvcMI3oqpQEft5LZDZqv4rFActV5x+q+PwwnUtRC5vddXtxSL2wxtV1t+zPcCQHCQj6Ajy0JK7Vt2aEmJA5CJVPnA/t3G+G8WXm0tAhGl7X1W7BaNUZJhq7a5A8XaAcUbKoWkxfz/DW9KMaAliJ0sd230Wv1jupoKN8b2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x/6hA92u; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc64b659a9cso13338830276.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 21:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708578953; x=1709183753; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b1TAt5v1M0YhGrOgA4n20TxtMypW+3VYDUodyHqRg4I=;
        b=x/6hA92ugkPQsCQwjo8fRm+s0u01mD22yFNZ9O7q+HsdF3CS60U6EKipVa6J7JwGB+
         BODThSU8LKB3Beiz0kfd97tmToxYjgboACDO4u9328uI5onOFM53vEWzGKHPcFhL+v/L
         m4B5eASUI4fk4/XkqcmjXEkaVoXm3mWby+lq2MjT5jzIQj/7Q5MAnAVrqAeo+2q7Z/pN
         bdvoh7jr0EQQDB+tv8LR5Xu+xkM9p2eNpgp4F7YghoyYYOA0m17DgIrz+D+3qyGAkIrA
         CyEEi3qoqXYHQCTrqI26tZyATRk2+aIjfAVzv8e3LpdzHmHQ230kA5j1imDgC2m17eX8
         478Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708578953; x=1709183753;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b1TAt5v1M0YhGrOgA4n20TxtMypW+3VYDUodyHqRg4I=;
        b=wBCjKNhFU8kg9Qij/Ro3T+b+ZQ2Q4GkbvPhN7l+ud5uXe3TJ1vufTThLIGscx0M23v
         WMf/mAM17ndk8q/7zAOqg5JLyD/USIzy37nah/CIO2FgAxQYv8qZ87pDQIrJjrEY7zDS
         EymbUBOLeb3FA+9d3nggb49YivBI0lGPzvHd+5K0knqZkBtVXXO7Wt9MsW+RvFWrdFXF
         Kvg9Y7KkzsCMppHUKNxMA9eyqRuv8kkODFDrbIPEq2MvfoYxcmrHRDDTZpAkRk5AYLsQ
         aNhszeNkqLiUyc1L4NKmxalN8HodNFPFqc7msruylghOOipSsxKmaCMxIUVLWyN/oayc
         Z3mQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5lhN0g8hhNwBLJcroeMJCyJ0w/TcNFceu46eJ2B03LRWiHrpViHpscl7Pd/pQ4kl0GB7FoFBpH2+llQs8wgn6ffclhm0xPpAbgucX
X-Gm-Message-State: AOJu0YwJ6+Mq7JjsQB503WaYsJnZILyK+RES0WgmZyzTJPtnOHgOuopG
	bI12taKhru5f/ZWF8+glCSdS6kDZbPCGQH2lvQz4/Yy9q+DlDzNU1Pqs0V/rDGNQgdYDA3KIpPx
	Dw8dktvOZMwxVIA==
X-Google-Smtp-Source: AGHT+IG8Xm7MI7aV+ERfzXQ6sEY/1JU7h3mFDxCSLc5xiLfJWsV432aZk0GoZESBhYi+BuZXqdZsJKCIeYWyfj8=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:451c:c6c5:1fb1:a2a1])
 (user=saravanak job=sendgmr) by 2002:a05:6902:1109:b0:dc2:4ab7:3d89 with SMTP
 id o9-20020a056902110900b00dc24ab73d89mr369506ybu.1.1708578953292; Wed, 21
 Feb 2024 21:15:53 -0800 (PST)
Date: Wed, 21 Feb 2024 21:15:40 -0800
In-Reply-To: <20240222051539.3001988-3-saravanak@google.com>
Message-Id: <20240222051539.3001988-4-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240222051539.3001988-3-saravanak@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Subject: [PATCH 2/2] checkpatch: Don't check for unified diff format in git
 sendemail headers
From: Saravana Kannan <saravanak@google.com>
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Saravana Kannan <saravanak@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When checkpatch is used as a git sendemail-validate hook, it's also passed
in the email header for sanity check. These headers are, as expected, not
in unified diff format. So, don't complain about unified diff format for
these header files.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index f306634a938c..4312166ca828 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7689,7 +7689,8 @@ sub process {
 		exit(0);
 	}
 
-	if (!$is_patch && $filename !~ /cover-letter\.patch$/) {
+	if (!$is_patch && $filename !~ /cover-letter\.patch$/ &&
+	    $filename !~ /\.git\/\.gitsendemail\.header\.\w+$/) {
 		ERROR("NOT_UNIFIED_DIFF",
 		      "Does not appear to be a unified-diff format patch\n");
 	}
-- 
2.44.0.rc0.258.g7320e95886-goog


