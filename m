Return-Path: <linux-kernel+bounces-75926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FEE85F0CA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BC281C2160A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DDB748E;
	Thu, 22 Feb 2024 05:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="daoNE5eK"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210C06FCC
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 05:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708578952; cv=none; b=HN3H6TYDZnr+y7YnTX0SoPxzITYOgWup31OCgvT0PSog+K1QESdiuxzDH7EPkCsnUm7FwIDpRpw4sRHzWkTzknML1AqPLEtUt6Cf5zV8cEckebxjDZkbPpXujfN1yVR1mFrsXkvt+SPGezmd2Y+t/ojcnGsSfWTwsY3orxzSQZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708578952; c=relaxed/simple;
	bh=/5pahtp3IV21Zkx7LwhzOaL8qhatST6yLhJWnBUWtrI=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=qNb/VTF+wZur5GzW4FHH+wyoAX6GZdaofPuANdDz5LsqsS71vbwRnTU7/bCW9YA6VveBxyWwhspkXBcy3CH4M1C3LKutDPLkhBgafw91xdjOyPl1ybykg9cSVg9XCWwRfIrcL/beTStjDLBFQSnzKh6ClKjeTVzbQ/ZwobjrTwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=daoNE5eK; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26845cdso2143495276.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 21:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708578950; x=1709183750; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/szi7MXaD7WqR7pua3W77cLv+YU355Nd7WimhF2bWNQ=;
        b=daoNE5eKe1VpC/uzaTBgC5hb6/BoHP/DrwgQOcIjt+Tc3yzOa8vpPUmW3imBoF0gSQ
         riFs66DPIKFDDiHlyRe1p3rfzKzAonIuitwavApvhDhZD6NjGYMWD88TmDg6wmTwux+U
         N6B4YyWdDZUX4U2kCQQLK5j7w6I8PSAHYCtCN6f/Nm6Xr/T8QmZZSCf4gFKD3CQNLxuy
         kSOQuSJucJbeKYiONQSdf/ZLEbPsNEZUXIvatg4tJHGNt+HZfEOts+f4tAvq66qRIDYR
         vpjBg0/xBMLHXSPCvoo3NGgOcv33xsDM/O3nzi4cetk+X7hLLJfHTNOtwIs5V3EF6nx4
         9ifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708578950; x=1709183750;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/szi7MXaD7WqR7pua3W77cLv+YU355Nd7WimhF2bWNQ=;
        b=JOTSKGEzlyq4O+aeRg24o+woFIaAlIKF6YyyFKWTt8dk0IxnvpoebL8JckSenaUrDs
         UO4ePJPs14iSpFhcR4sHLHTdxPYa77N4Go0pODSX87YQEcG1TJC6KyGmDOicaW1wGgHP
         E7xbLTkJKlOQ4QIGAUvnHCU58Q4PuOhA5/pu68dG0GuiuJ0HY3JbAoyabwn+JLQlLoUH
         t2y+H+OfGHSGC963PZB3hhXhw93rBMU7+gsuEJfqB5NGyxOApfN4xyvgUg91b8swvrBN
         KdRIx6VJR97hmCGrtA+cH85+Z/nA8A5S65/ePZz5JWm1+iLsQzNNAyKelmSrmd8RRnTW
         bbNg==
X-Forwarded-Encrypted: i=1; AJvYcCXuHkEOXWJ3cO+cae38U9WAbz4qFp+qVgUzXMDN0rv+m8UUyXgV3gVYM/8i573GVFxxPYVQMP5rt7nu52g9AokasvtUfDNo5CtfCN/e
X-Gm-Message-State: AOJu0YxmIj1bNqVvQvRQCONCy9Okm5LcqBh5vSotNado9sdXO4BCjd2a
	RxD/AxEMhAknIghphNtFlq7r+qZIjG1U0yMC6GTFg5FC+k1Mhb4j/xiLs26LnSx71mGIjOE2rWr
	GRAaDPy1/kGBbsA==
X-Google-Smtp-Source: AGHT+IFI46TY+t86YHH4dK3IrYivpsBHYhG3Zk8JNTF8hrif3KucQdt8o3Xst902ElL9NDZWrH0gvnkppiGHzYE=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:451c:c6c5:1fb1:a2a1])
 (user=saravanak job=sendgmr) by 2002:a05:6902:150c:b0:dc6:e1ed:bd1a with SMTP
 id q12-20020a056902150c00b00dc6e1edbd1amr384095ybu.2.1708578950167; Wed, 21
 Feb 2024 21:15:50 -0800 (PST)
Date: Wed, 21 Feb 2024 21:15:39 -0800
Message-Id: <20240222051539.3001988-3-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Subject: [PATCH 1/2] checkpatch: Don't check for 75 chars per line for
 create/delete mode lines
From: Saravana Kannan <saravanak@google.com>
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Saravana Kannan <saravanak@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Cover letters have a "create/delete mode <mode> <filename>" line for files
added/deleted in the patch series. Ignore these lines when checking for the
maximum 75 chars per line limit.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 scripts/checkpatch.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9c4c4a61bc83..f306634a938c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3271,6 +3271,8 @@ sub process {
 					# filename then :
 		      $line =~ /^\s*(?:Fixes:|$link_tags_search|$signature_tags)/i ||
 					# A Fixes:, link or signature tag line
+		      $line =~ /^\s*(?:delete|create) mode\s+[0-8]+\s+\S+\s*$/i ||
+					# A "create/delete mode <mode> <filename>" line found in cover letters
 		      $commit_log_possible_stack_dump)) {
 			WARN("COMMIT_LOG_LONG_LINE",
 			     "Prefer a maximum 75 chars per line (possible unwrapped commit description?)\n" . $herecurr);
-- 
2.44.0.rc0.258.g7320e95886-goog


