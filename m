Return-Path: <linux-kernel+bounces-60607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FED4850770
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFD791F26308
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B546262A10;
	Sat, 10 Feb 2024 23:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DH9efwl5"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D5B6281C
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 23:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707609073; cv=none; b=dlbOfd5Up4x2euhqQoCbkoGEus3OUp2Gg+LRNqyNLzG1s8ZCYqLyP9IxAVhGj6DH/sQ5LroyNNxcPzVbdJtVa+0aOvM0m9wec/EeR3/Rqlwdalms5/NJB2gfm0TjwJmyJWljc0B6fX7P8LmrOTQsSRvyYROvlAXwe9aAW/d8DnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707609073; c=relaxed/simple;
	bh=Id7179WCdgrN+FSm22opqsAgq898l20m29SsJvJcSX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WFQz7aDbJJdJQdLa6OtfzNZfoUqwXiedJIqg1o38YwqxNhp55tA77Cf49aZ9cUAt5zg9cDCu3YIZr21nhH6YToGqXK+oP/fokqoX55VXMNG032sZxOTheXapyit+xzVeFg2KsSWm7xUHgwnxtcsQBsW1Xt3+Hs15FFJ8Crvl+UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DH9efwl5; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51182ece518so659242e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707609069; x=1708213869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZ+n5vQl9SXL8QPoIUHsB3HUrPVSipwhNEZ+uqM/u1A=;
        b=DH9efwl58sNiWSlsa7aQtkipzrw+KI6G/A2+z5DY0t+KDmGhvIaz1sMzbqLOJ+Hpoh
         zu6qSzVyXjJBT5ExOIuzZN3NKPCudrpSO1m5mSGuqVdLZi4sMwrLMFQT58QsbFe/xxTu
         TWbDu8yPqYztIqcdrk9Jzky8l1pAg9GhScmCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707609069; x=1708213869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZ+n5vQl9SXL8QPoIUHsB3HUrPVSipwhNEZ+uqM/u1A=;
        b=E2umSh/Y+dVH1/d7V6Q/0pc6Y/L9YKQPdt7obkjcVWgoB9g7xNWtGrkydfc5Op12ZJ
         ckhCV3x9493D1/h4eLfd5IShBcJ3IuIDbeuFg2jXjJVUUyAEWP5G1Fsc1kT1VagPiTN7
         BUy1L1P1IQzphDmNUPG0WuhaSG96uOs1o/anAydbuH/XM+a0wldUn065zi9z5FzllD+z
         iLS75ObENK2e/2JcZpaKOREUsyXR1Qz5SS9YtkSJGZ5j4fXeXBchir0Ppq6O8T3PwtNX
         ESrbqpWw6Yuzru63V+kL0wHYy8UgEQGAcAAMWX6jRuoT+g5zOU+GV8cC5b35w4XJMSyW
         CtpQ==
X-Gm-Message-State: AOJu0YxVwyuscdIxzm5H9v4FzHUZQ8IaZ20aQtaVwLgLjLtElCJVQ1W0
	gSku+Tc7nIzGhGaVaTbvsifywfe79p1q1VajIjBdQ5UfjZ6y7xIXARzcRaFt
X-Google-Smtp-Source: AGHT+IH/qcS7sqCO3QyY6vKvWW/RPjYH/FMXLroY5OmuMCaUyphACiXQdTgCsWo4Ff94Eb8A9bKTAQ==
X-Received: by 2002:a05:6512:400c:b0:511:5eec:9b9a with SMTP id br12-20020a056512400c00b005115eec9b9amr2585367lfb.52.1707609069628;
        Sat, 10 Feb 2024 15:51:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU84YU62Gbc/sEoczwbwEueJdzT/vpIAqq0rJ3WslSyzSBLDrnvQfM974LIVoraHFAOYB951XUfArwYNDnheW1sLxBt30Yk+lwPwom7izbVUaBQgeArK3qBTTP24bfn4RkvSKhSkLlg4fs25h2yP5G3hbBpWsmiYbhn1CVT8yEiR5kSrMRulJ5aSjSeStP8wgD7a9qcS5uEl2MQECGvwTg4qKqWPidfZJhGAJ6JsuJzQDBApAT6g8udBuwPZ4VMVOpP1TBwdrdSxmZW4ms/nyIQGb2yDpw6StIFbVbXTfqKp4QFcpvqFBUNqul9WKAfVN6b94gs28nhxltPSykpKMnWZ80k9lID2elJXPE3Y2o4rDskSow0m/2P0BazOHBNNDv9JAFXT3sMblBvhXyJiTft6QaOzMDzxp/pKok8fHkcm6ZJAu8VktI7hMOm/9241kY/75+13IAS/1Q5Qw7fcvZdtSZGRpRPylrHZmiY/XYnFEGi/LfAHrQOV9YeBse+nPi566IsDXwe2oJMHmIurBHwxFZYUQDorGAzaoYSm9ObUUEk6sFLljVub/QpLtoQOvxRqAYzhy6z6ehuzxtHnWNuuXSsQDTZ4lDqXOvF3OxhVnEKKQ==
Received: from ukaszb-l.roam.corp.google.com (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id o27-20020a056512051b00b0051179ae1846sm365561lfb.280.2024.02.10.15.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:51:09 -0800 (PST)
From: =?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>
To: Jason Baron <jbaron@akamai.com>,
	Jim Cromie <jim.cromie@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Douglas Anderson <dianders@chromium.org>
Cc: Guenter Roeck <groeck@google.com>,
	Yaniv Tzoreff <yanivt@google.com>,
	Benson Leung <bleung@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	Pekka Paalanen <ppaalanen@gmail.com>,
	Sean Paul <seanpaul@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	Simon Ser <contact@emersion.fr>,
	John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	linux-kernel@vger.kernel.org,
	upstream@semihalf.com
Subject: [PATCH v4 24/39] dyndbg: report err in ddebug_parse_flags when read_args fails
Date: Sun, 11 Feb 2024 00:49:54 +0100
Message-ID: <20240210235009.2405808-25-ukaszb@chromium.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240210235009.2405808-1-ukaszb@chromium.org>
References: <20240210235009.2405808-1-ukaszb@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jim Cromie <jim.cromie@gmail.com>

read_args() fails on '_' (the last opt-char), and returns null.
report this against the opt-char.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 089765afc972..3d0c6b5faa31 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -903,8 +903,11 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 				read_args = opt_array[i].read_args;
 				if (read_args) {
 					str = read_args(str, modifiers);
-					if (!str)
+					if (!str) {
+						pr_err("err on '%c'\n",
+						       opt_array[i].opt_char);
 						return -EINVAL;
+					}
 				}
 				break;
 			}
-- 
2.43.0.687.g38aa6559b0-goog


