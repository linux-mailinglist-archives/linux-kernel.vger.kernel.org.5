Return-Path: <linux-kernel+bounces-88512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5AF86E2B3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFF9E28C647
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6266F068;
	Fri,  1 Mar 2024 13:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecGGc9Ds"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6920A6EB5D;
	Fri,  1 Mar 2024 13:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709300813; cv=none; b=VtwOpzuqbeIf5Sf2XDPLH9cLspnvJ4yLNZFrTFUFas/+Z6BwqcisqcRdVgalXNq82z1P2zF/GBIrgW1Fse7qOYp231/5JGIKGbtpPC/kIyDs4H9x+Zvxjnm10A5lloliDpeZqGHBheAWHM62MNlC5svq4NY0AYN0wv5I7EFpQCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709300813; c=relaxed/simple;
	bh=5+tsegm35mr2mrlHcxRD4tBazE0gM93OVZb3DJC9fZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kURZ2uWRyZrGxRchR1LU1gtcZNkn2eoZmNGtTZEI2HMho2e0K5+RYC/wRP1c9XgF1kSOnB7KoAAMIrK2TftjGi9HuFAQu5OutNBY2vSfGcn+oWMtMsKET3k6z5k3DWBBeG/nnM0qpSROFzyf5XljxhgONFhtD/qqbKo6xG3E+qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecGGc9Ds; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-563b7b3e3ecso3485153a12.0;
        Fri, 01 Mar 2024 05:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709300810; x=1709905610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umwFC7DE96xZZ1X/nt8K0ZM1RN381g70mq+QxdOjW8Y=;
        b=ecGGc9DsJs/WI8cUoYzJ3KzCYmHJ1xsmMkpj6A4byyozqFvgxXMoLJsEwibPFfjcWI
         Ij8B6zX3cll5MziBVjXXRKqqdmhq9u/QBztALWrgMn18wxtx2VSMHs86VLovJBh2/KdX
         TEqbQZbPykGc7uQnrUB0tvDOyTFj0nyhGIAg+86QQOuS9KqUGtrTabgFbqtWuwSlfaK2
         kdy5CFIldNCWGhFJRdOQeDL2URGflK16RJPjV0cyUAFwxlcEKRe0Dk9Sl7UWdRSor0VA
         6seSfYc00H2zDjJGVOscnTtiBh5Tg8CrA07GlDI80NNekoq9UR/oaxgFs+Tba0JfU2h+
         si6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709300810; x=1709905610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umwFC7DE96xZZ1X/nt8K0ZM1RN381g70mq+QxdOjW8Y=;
        b=hc7NB+khKWXY1daJpvAJdaPivD/Wxp6P90dRGtqRksFFNZhb7SC+GonIftcYnHPI+N
         9rc7TN+53xLwyHusvtMA4PXRYjunHi5YujNokTiGyabgUu9vHMxBw+2k1WsUzMpLik7a
         t6dlGRgCR+3+0gTZvIi2W+A8SQ1wI5K1VbwN+MpHJPtGXiYAmgD97Bc66pwn8O3H1+E+
         ZNZcqEHq8pw4rwX8QdfeQyUg2M+b7dxm0dSFav9MocF3ZuNfi/aRlWCuTCQuOEjPfid9
         IHlXhfVMC7zUfzm/zSrxtO+UdPvTdshfP6Db89E4lDsCQw8hd8Jp+C2WGmrdF43rSVEv
         wbIA==
X-Forwarded-Encrypted: i=1; AJvYcCX9m4ja6A5Ader+41EkFch1LDjERE7oKcszss4WesENPYvTrle8bvJLhIC4RRN5ZgUL6o0H7g3cRRWlZeLnxzD1zvscGiFeAzNj+ZM1aorJ4fih9TJGkUu6NK7l1um7lht0tcPBe77yPIR7y+lgQO5Q+q9pswlRx1HpUc1tkvQKQgv5
X-Gm-Message-State: AOJu0YzSnhkmCuNsgd7zL409wwfN1gXVJnEfEr5hMLQn5pugiz4N06fz
	qWnud1ZqJBMY8hId/r0wAjW7q8+U7Gy6gccivZ8N49rn/cXThYDzjQ0bh3jE4uU=
X-Google-Smtp-Source: AGHT+IFIT1OsbTrR1dkzAXwSu7cccGMBJAd7+5uBJ4pRW1JC93ok7WVxMAzMokgc5zxwHy+yu7kQcQ==
X-Received: by 2002:a50:c943:0:b0:566:14e3:2262 with SMTP id p3-20020a50c943000000b0056614e32262mr1271351edh.36.1709300809753;
        Fri, 01 Mar 2024 05:46:49 -0800 (PST)
Received: from lola.. ([2a02:810d:7e40:14b0:d371:e319:5dd0:9b35])
        by smtp.gmail.com with ESMTPSA id fj10-20020a0564022b8a00b00563f8233ba8sm1584107edb.7.2024.03.01.05.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 05:46:49 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 1/3] docs: submitting-patches: divert focus from PATCH in the subject line
Date: Fri,  1 Mar 2024 14:46:35 +0100
Message-ID: <20240301134637.27880-2-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240301134637.27880-1-lukas.bulwahn@gmail.com>
References: <20240301134637.27880-1-lukas.bulwahn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Submitting-patches is already assuming that git is used to prepare
patches. So, developers will use git format-patch and git send-email, and
this will take care that PATCH is usually in the subject line. Hence, the
'include PATCH in the subject' does not deserve be an own section.

Move this note into 'the canonical patch format' section, where it
currently fits best.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 Documentation/process/submitting-patches.rst | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 66029999b587..2ec0c0d7d68f 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -384,16 +384,6 @@ patch or patch series which have not been modified in any way from the
 previous submission.
 
 
-Include PATCH in the subject
------------------------------
-
-Due to high e-mail traffic to Linus, and to linux-kernel, it is common
-convention to prefix your subject line with [PATCH].  This lets Linus
-and other kernel developers more easily distinguish patches from other
-e-mail discussions.
-
-``git send-email`` will do this for you automatically.
-
 
 Sign your work - the Developer's Certificate of Origin
 ------------------------------------------------------
@@ -616,6 +606,10 @@ The canonical patch subject line is::
 
     Subject: [PATCH 001/123] subsystem: summary phrase
 
+Prefix your subject line with [PATCH]. This allows to distinguish patches
+from other e-mail discussions. ``git send-email`` will do this for you
+automatically.
+
 The canonical patch message body contains the following:
 
   - A ``from`` line specifying the patch author, followed by an empty
-- 
2.43.2


