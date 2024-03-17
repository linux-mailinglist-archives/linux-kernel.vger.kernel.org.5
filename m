Return-Path: <linux-kernel+bounces-105361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB8B87DCB9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 10:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7871C20953
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 09:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9974C1401F;
	Sun, 17 Mar 2024 09:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRsT1pG2"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4293A125C0
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 09:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710666295; cv=none; b=NTOY6qZDELMVn9he+MrYz609gkzQoSn38O5VCIA12yltXiKFt4CciTDGWyJP4vlLXryZ6f3QX9lDw4DkZe0oyqpHDDYWCNKYOzwHMQaP/B8IXMSaEXb3M9K5hHzHSsCaknTArY302NJXkEQBPYtCRYzGdYNqwym/zs7hn2hgrZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710666295; c=relaxed/simple;
	bh=3BVmMVrqxfeIeWv12FpMrgp2kLIK6rohodVbN6VxhLI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sJHYd2uY/UI3gfPntc0mtlvQAaWaS8ze6/fPAbLzBF5nPStiVYOubTuYJW2qUuiu0mkPpU+iGWQI4LeNhfvZKy5GE8yVSD1RjCS/xZJVU2mVVD+op6Q/sGYUv5sC4c0eZHT2aW49e3WUxRWGC5+XArC4qptPiIJp7kHf71mxZU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRsT1pG2; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a46a7b8e07fso111483966b.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 02:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710666292; x=1711271092; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=H78NCuw5pO9iwByPeKAc/83sPk9MN9xm3bJoBDJ9yf4=;
        b=lRsT1pG25eJuJE62wk/F+xvvzavBGCjNJrH1y56sM/fcR8JMmqnFdPuhmcG/cLbMMM
         728sw1ZLZfnlWhAzr/wyyzQ/s6zJNHEnByMOb8ikgIC1hf0//eS0BxGXAMJA3fVF+0IW
         Via5qxjJFx2VDD4k3nXWMzQxSdSp0otrg4PhkcLe6DQUWun84OeujLJ69D5vaoeRUGuP
         5/NaK/q5nUatcr4EwXnMYqjxKItLHpIVJRwjLMGuYR8b+BUbMhp5KVzLikj+HF/ja6lh
         dhpT6J8/oGd7zFBo0eTi7m5+7Ceq2PIBcc93A6oD07FgAzN1cThGOZ47q1dFlWML3rKD
         IN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710666292; x=1711271092;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H78NCuw5pO9iwByPeKAc/83sPk9MN9xm3bJoBDJ9yf4=;
        b=b9ggz+i7kd/ELO8oHrYvnAmD25uZMq+EibbaAZUGPIVBpInfnVnlvTVazxDL8pR6iv
         ederLD3Lu6rNQUtfnKNmvbMJ7u18Kje5fKEgGEhD66h5q3NKYtKkMKgwvmkVTNPxwwtr
         TDgS+8ZHf7G5JTQcRaNnuqIfOWUoAZLCjyPbabl1tc5fN3qa9Jaup4VoD1guOBNpUlCd
         bLYoTscrt/itvtB/u+3GgMFEeSeeDmpLN83VN+eTJLVuKSCsXKMrJDv6IoFahRI9sU4z
         LsBiVo24meI9RKyIWaV3KimuzyWFlLooJdE0rNagGpahrdJfaFJyYuWFOKor68KMyPzc
         /LlA==
X-Gm-Message-State: AOJu0YxC6cBbYQTNAKDNHrTccOCTy8cUx5vNOlSWOKeMR+0ZGYo2/OS7
	qOKVSAhDsgiQcBJAbBU6EGBewCGl0I8M8RKlRlvpGCAsaZl2lvNCa5rCh7qvgMQ=
X-Google-Smtp-Source: AGHT+IE0id2R32fL4ZiJDrCn+VmuRBMEvQ+P1MkdaMM+sI8W/Y+4RnPGtVjUCPd25HN0M6qQthaGcQ==
X-Received: by 2002:a17:906:6d98:b0:a46:a81a:330f with SMTP id h24-20020a1709066d9800b00a46a81a330fmr1945561ejt.5.1710666292087;
        Sun, 17 Mar 2024 02:04:52 -0700 (PDT)
Received: from gmail.com (195-38-112-2.pool.digikabel.hu. [195.38.112.2])
        by smtp.gmail.com with ESMTPSA id u23-20020a1709064ad700b00a4479997b97sm3587656ejt.66.2024.03.17.02.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 02:04:51 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sun, 17 Mar 2024 10:04:49 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [GIT PULL] timers fix
Message-ID: <ZfayMWuE2MgFHAGT@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest timers/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2024-03-17

   # HEAD: 4b6f4c5a67c07417bf29d896c76f513a4be07516 timer/migration: Remove buggy early return on deactivation

Fix timer migration bug that can result in long bootup
delays and other oddities.

 Thanks,

	Ingo

------------------>
Frederic Weisbecker (1):
      timer/migration: Remove buggy early return on deactivation


 kernel/time/timer_migration.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 8f49b6b96dfd..611cd904f035 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -751,26 +751,6 @@ bool tmigr_update_events(struct tmigr_group *group, struct tmigr_group *child,
 
 		first_childevt = evt = data->evt;
 
-		/*
-		 * Walking the hierarchy is required in any case when a
-		 * remote expiry was done before. This ensures to not lose
-		 * already queued events in non active groups (see section
-		 * "Required event and timerqueue update after a remote
-		 * expiry" in the documentation at the top).
-		 *
-		 * The two call sites which are executed without a remote expiry
-		 * before, are not prevented from propagating changes through
-		 * the hierarchy by the return:
-		 *  - When entering this path by tmigr_new_timer(), @evt->ignore
-		 *    is never set.
-		 *  - tmigr_inactive_up() takes care of the propagation by
-		 *    itself and ignores the return value. But an immediate
-		 *    return is required because nothing has to be done in this
-		 *    level as the event could be ignored.
-		 */
-		if (evt->ignore && !remote)
-			return true;
-
 		raw_spin_lock(&group->lock);
 
 		childstate.state = 0;

