Return-Path: <linux-kernel+bounces-56488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8956284CAC3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03D9428AFCC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3870D76041;
	Wed,  7 Feb 2024 12:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="NoS06zon"
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B613EA67
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 12:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707309338; cv=none; b=tMdNiYr4RslFrjzF4NbJdu1TtHWOxX3KOB0Y8mZo94WPasxcfwgmmBu8WzGIak9qIX5Sws+5VhrWLD45htN5S4QqXeHmtwfi1YRVohjhcW3gTA8nEMwxRrXTuFBU8OhnS3ITKeQ/GBg7SbnMyB/IJXEZSvz1ufVRWosWEOYQ0sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707309338; c=relaxed/simple;
	bh=b3zEL90q15hC96NDr4vpP1wxQM33aWn3KdnLk0NMY7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MkE0YkEkBVQQ1q0a3QXIcR9JVFgpM47yOPleM48S0ejsd42Lqs/VM4/rNrnVEvauyzjBf9v4dh/s4RyC24iAoUcDDqt1dnbl2LDvuhhPxyzYa08hs+kngnFCnU7ViPsmNsBrFKWAhpcWH1BBiU7/qnQ8D1R623hEBUNMl60qXb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=NoS06zon; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-51142b5b76dso944404e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 04:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1707309334; x=1707914134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSQODvxw90qryNiwnQGt89Wiy04U5DyDbCfGw4ywivs=;
        b=NoS06zonGdmZE2JwHl2NtJ0qYwr+fPqYxtF7rO01H5nS4o4Ac38rfZNu47A3y/2ccx
         UKpLMgL1dgXM5nU3O/qM1gf4ssBLs4oxGJB3BIS5lc4X5wCz0QYa95FHmvpWdwVKCMhU
         WHt3z3YWP0nnKhnzTYjPVOZOkL08Ecqu/3LFucrCjgCe1jXZTkd7HbggxBAw9ebmeD2e
         aJK/tmRCcd7o1NXnv0xUqynCLE1yG4pjNMUa2inacbpYbyTg1zCcQxG4CLvB1zn5evdZ
         lj5AS26qDtqhHv7SbzWTf9gcx7zcTK8zPAKaDd65soy9FWUN5sBpTqU0cu3Um/o5gT3a
         rUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707309334; x=1707914134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RSQODvxw90qryNiwnQGt89Wiy04U5DyDbCfGw4ywivs=;
        b=nZC2rQ9JSlwiiCdq19TJs8N5RDgW9jJMj5iJgqXYlF/sV9Z6oVVMdu1R9KVSmHNWIo
         Xg2Z0Kjb/Xp9nWdbRZoY/mFlqYBGaefSEI1YJ2aJec2YjP3dLR+LrH1z7FbSDRrWDjdG
         YRrSujcXvki6VCjZHA4QZqzF3ZIS2+13MDgGgtFrepPG5UBoYQ1AVcz/HGt9pSpVxgIi
         6Shwq82e3Jw74oC8QhIYcmvJvrBzXlYeVwHx/6qojX4wpP1GeeLE8TFDy2MQPki6Qn6f
         1GJUeLQp/o/FK+TCKIoFaX6w4oehK+g1pgtxVTLQ7NxVY7h5aCQ7hdj993CkJdP+CFAy
         rfAA==
X-Gm-Message-State: AOJu0YwHq6emxQHFfTe8alz5G3covRsO+TGwoz/eLdFZ9NAFiVPm9TSB
	NGIOxydb36TT+lxjl4Du8wMbmbhFR1QGXc2MvKExglELipZhMoSmrbObGQEpU5F5EYh0NoQ1SYf
	dUP0xxQ==
X-Google-Smtp-Source: AGHT+IFjtjRhJK2xtlrVrBdJXUSIDzA3ygeve83h6IjxERxyI9A+loWNicdEdlo+gqsJHEfSwMiQvA==
X-Received: by 2002:ac2:596a:0:b0:511:617a:3137 with SMTP id h10-20020ac2596a000000b00511617a3137mr3009083lfp.40.1707309334294;
        Wed, 07 Feb 2024 04:35:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX8BDOqpOXj548/lDklnh+rDGRL4XtLzgEs2yUBzBZ4Bh515EQPCB/SRUEXIaVis/aNSlsV+ui4bhHTavDUZUPMXYPTk8GoBXY=
Received: from debian.fritz.box (aftr-82-135-80-180.dynamic.mnet-online.de. [82.135.80.180])
        by smtp.gmail.com with ESMTPSA id vo7-20020a170907a80700b00a37fbee48f8sm706871ejc.133.2024.02.07.04.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 04:35:33 -0800 (PST)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [RESEND PATCH] README: Fix spelling/capitalization
Date: Wed,  7 Feb 2024 13:21:31 +0100
Message-Id: <20240207122127.9182-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240205120904.1711-1-thorsten.blum@toblux.com>
References: <20240205120904.1711-1-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Fix spelling/capitalization s/Restructured/ReStructured/

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README b/README
index 669ac7c32292..026eff0b8e06 100644
--- a/README
+++ b/README
@@ -11,7 +11,7 @@ In order to build the documentation, use ``make htmldocs`` or
     https://www.kernel.org/doc/html/latest/
 
 There are various text files in the Documentation/ subdirectory,
-several of them using the Restructured Text markup notation.
+several of them using the ReStructured Text markup notation.
 
 Please read the Documentation/process/changes.rst file, as it contains the
 requirements for building and running the kernel, and information about
-- 
2.39.2


