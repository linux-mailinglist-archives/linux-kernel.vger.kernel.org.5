Return-Path: <linux-kernel+bounces-111690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B37886FAD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9AEFB21529
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EC64DA0F;
	Fri, 22 Mar 2024 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cL45VbWw"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F01A53E2E;
	Fri, 22 Mar 2024 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711120621; cv=none; b=YHpAZOTOCtBujXbB7UfoT2HPMvtPNof9bny2bSKzOH2VNF05tzQc+C23cQHF0K5C4BGkBsQcY0Ac/w4MYYCtO6zHXBJrS25dHWJ1HJn0Q8chm3ys+Pg94ySliZjBPP/LvEcjSnX/iV+PSL3U5ib0QssFNb7LnJCDLY4t7PL4d34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711120621; c=relaxed/simple;
	bh=hzlDQWpaAy8XRudP0fe8Wk/SvOdLzdb9nk6RY9sJYQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nzSteaD8CusvP1Y7bilUE4gNoXQczvgIsZ+EyEldFZRZmYvtw7m67DdQiEapVcwaBo5i6ycqx9tWBQ6hL3AUVLpcUKVfB0I5nIj65VihtZk5ytV6i/5/0fj9/eNRI/ztuWYiKjOXhDTVYayFibN6lblagAlQ47sxcAGKF5aWf4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cL45VbWw; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1def142ae7bso19332875ad.3;
        Fri, 22 Mar 2024 08:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711120620; x=1711725420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZvNCq/vUyxBpwJ9D5tVxN8w0d8YTtddgB0nD7H1fQsk=;
        b=cL45VbWwOUwpl3J9IPFSkYgKmMWS6We+9nraluxWbKqs+RljLnN3FfB15QqSPsmmHJ
         IJbHRY52EIizejeOSrIExuQT4FZitXmUasjPpc5M8Trcs5hTIoYG/3pKh6fzWQ8DgxSI
         I9MwrAMDJX8CdlIuYN64xyevn5eRa/xuWJTrZ+1bRp6KUfHDIDn8TlF2rKeiSIlfP049
         u2/I/ybnJNgN2H6DsRs04bNab5tS4bf0Qp+RW4H90Dk1XeHW5turpqjXp0+peMCFicll
         Mg6eVS9/OyN7OEbDmC/xIw/HKE0e5nd/GWh/xMsch6oUeNzObJcfii19+9QDmt/wzwFl
         IyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711120620; x=1711725420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZvNCq/vUyxBpwJ9D5tVxN8w0d8YTtddgB0nD7H1fQsk=;
        b=duLbCosF+gxRXzRjPnmx3GG8y3n6cWEEVVkwoj9oGttcp1RWIudwQ1Vm29BBNI0fNG
         yShLZB/Z3qxSeyJtwT6RyWtFACukAC5HMHVktAmzmhZThN8qMzuVLliRxffp8wmrKfnu
         3FaRwb85U8Tfgq3nNNR1GHhIcj6UFxMhenWGAaV0jwdtXWii9nwEKF+Y6t7N3lU29hwB
         MNvClc6igkWhjYjXq0FqBiaVXk9bGJCKjArvfx1Jj9Ui87yz5HRMV/+GsbngtqR4zZ2X
         TyBC63rHu4rm/kKNeoOsbOj/c+dxUSKWq61Z4Rjc4e9URiUhyvEl8yhru/8fosur1GHe
         jlew==
X-Forwarded-Encrypted: i=1; AJvYcCXjvxuSzd/G5YlTJwZT0wx3HxKT1euZ3QCbPsR0upZEGkSA6Go10XW0ZRP8iTNtykoqpRPjgFTvBeBFJWpva1WIBALIZqSzvj4rm7L8lvTVUd6MiLaZd1Crqf00+H/HDJ0BFJLE3qZNQJA=
X-Gm-Message-State: AOJu0YzX4X2GpvLEJNG+nDagDmSQieCbtv951oce9Zb/S2GPpZQVqdKj
	2I6+y3yasNFvW9aF/PMHheSiNb4F0DHOL7IdBC3JRVoYi9SuAd6q
X-Google-Smtp-Source: AGHT+IHCgCDL1PxwCnR3s/HSd6meeWjhLlcVL81UDri0NQht+8M2mFw3XMHbUNeMHzSDAayeOBa9Eg==
X-Received: by 2002:a17:902:ce0d:b0:1dd:ae5b:86f1 with SMTP id k13-20020a170902ce0d00b001ddae5b86f1mr59698plg.29.1711120619504;
        Fri, 22 Mar 2024 08:16:59 -0700 (PDT)
Received: from Ubuntu2.. ([14.139.121.51])
        by smtp.googlemail.com with ESMTPSA id p5-20020a170902e34500b001e0287592c4sm2024809plc.267.2024.03.22.08.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 08:16:58 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: 
Cc: sudipm.mukherjee@gmail.com,
	dan.carpenter@linaro.org,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [PATCH v3] staging: sm750fb: Replace comparisons with NULL and 0
Date: Fri, 22 Mar 2024 20:46:33 +0530
Message-Id: <20240322151633.16485-1-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024032208-blunt-ferocity-22f4@gregkh>
References: <2024032208-blunt-ferocity-22f4@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace '(opt != NULL)' with '(opt)' and '(*opt != 0)'
with '(*opt != '\0')' to adhere to the coding standards.

Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---

Please ignore the other v3 patch I sent, I forgot to write
the change log in that patch. Apologies for any incovenienece
caused.

Changes in v2:
  - Update the commit message to reflect the changes better
  - Replace (*opt) with (*opt != '\0')

Changes in v3:
  - Remove unncessary spacing

 drivers/staging/sm750fb/sm750.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 04c1b32a22c5..c4b944f82fb9 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -926,7 +926,7 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 		goto NO_PARAM;
 	}
 
-	while ((opt = strsep(&src, ":")) != NULL && *opt != 0) {
+	while ((opt = strsep(&src, ":")) && *opt != '\0') {
 		dev_info(&sm750_dev->pdev->dev, "opt=%s\n", opt);
 		dev_info(&sm750_dev->pdev->dev, "src=%s\n", src);
 
@@ -1147,7 +1147,7 @@ static int __init lynxfb_setup(char *options)
 	 * strsep() updates @options to pointer after the first found token
 	 * it also returns the pointer ahead the token.
 	 */
-	while ((opt = strsep(&options, ":")) != NULL) {
+	while ((opt = strsep(&options, ":"))) {
 		/* options that mean for any lynx chips are configured here */
 		if (!strncmp(opt, "noaccel", strlen("noaccel"))) {
 			g_noaccel = 1;
-- 
2.34.1


