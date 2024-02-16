Return-Path: <linux-kernel+bounces-69169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF9A85854C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AE35B2558E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37A213B288;
	Fri, 16 Feb 2024 18:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="g5RWjmtE"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DDE1350D2
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 18:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708108319; cv=none; b=J5Lj/P+yfAsOqpKQ/U02wu2+oW44FH4nP99PCMWO9IjsJhB12B5n1kcUnPjo+syaCtmBsVv16EWS0Z9aZCdMEI02tlj37uHcZrAzIV9KW4luqlv4VSSEdxlWtzGsTRzGhle+BRsXkAwXezWTYG9mu2yAPEc6z3fIwOn9Ir8ibGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708108319; c=relaxed/simple;
	bh=cu3MMzOHuWJKImjKqYJ4/NXYAdw+8BhcKEGy95D0Imk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YVEgxKwXQuy5HhsAqPP4G4PjDxHU1FUrRSVrqAPZD4ZBZ/4FR1UjI89uKZxmz/8Kqzw8ly1jQMBXaSksQsjpydtR2Cm8VxzROqWFCb3v2czKDT6uOdCC65SPAmdqnq5jgdixo/MzCBbL2KlgmTMmvevLBy5spIlk0fsxkekgAZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=g5RWjmtE; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6818aa07d81so15849196d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1708108316; x=1708713116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jDrn7wgy/ve0lPoR/xKtbF/cZLSIaETTt3wbkL2858=;
        b=g5RWjmtE4GeWFZAaV/uIOkmk7lxOE7p7YrGvVJmAcKzXvTzNblJIjIzroSJ1DZOx8s
         10g4s5s2oVoLfPMsw/ZdSlJcCRY/0V6duVc/nPqY+7wYUNTvLMH+bgC1ZNqZWi3hLG1Y
         Yg244tgwGgsbBZ1rcW/qjluZ+b7u7d335ytdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708108316; x=1708713116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+jDrn7wgy/ve0lPoR/xKtbF/cZLSIaETTt3wbkL2858=;
        b=WAIQu2v4gTMzLeSE93OM23AF12QpTKC2BO8Gl/awIoRkI2bVmQATw5UhqnZ14vVdxy
         D5C7SBR94dGqEGwZVBKOqM2uN3MfguDVFz6Ic1KZ3/3YA9QY0J8mLRmy9+6EJgvKKz7H
         +X45+zHTeTt7TNoMkB6vVuYnxMWJ6+lKb1TgbOO9ro2CJ9BGybK0nY0E6e/SVkgIeBXX
         Omx/XmkYgLwmdSS5Fep6hTyebL8+fbm13Dpp8U1uWSZ7WBih7RDtkifH2xE4rq3lS0NY
         W2f1cdugKnj0pN+2gZLL29Xm6kBwl9qhSBTZ5HVi0dx8Hi/e+ApzpJ2J+bmwGytgJCaV
         NYSA==
X-Gm-Message-State: AOJu0YzspS2xvuJnMoAkk1Dr+aVfnqS03PZl/iaX262nm9Xkz7mDygNa
	N03HPQSYGPzhNeoL8EaJJwrFTiE/2RKhP3zLncWe3lYreeIANRvIvpHnWhGIt0kUHd9zJyImtci
	w
X-Google-Smtp-Source: AGHT+IEMG/tv2++C9Upd1PzGPby/mwewGK3XuvH9GyHJN5ozTK/AseozSEHuW8OieKt6MmugUwdvUQ==
X-Received: by 2002:a0c:ca0f:0:b0:68f:144f:4c4 with SMTP id c15-20020a0cca0f000000b0068f144f04c4mr6750511qvk.37.1708108316068;
        Fri, 16 Feb 2024 10:31:56 -0800 (PST)
Received: from joelbox2.. (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id nd13-20020a056214420d00b0068cdadb5e7esm159722qvb.31.2024.02.16.10.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 10:31:55 -0800 (PST)
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Suleiman Souhlal <suleiman@google.com>,
	Youssef Esmat <youssefesmat@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	David Vernet <void@manifault.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	joseph.salisbury@canonical.com,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Phil Auld <pauld@redhat.com>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	linux-doc@vger.kernel.org
Subject: [PATCH 09/10] admin-guide/hw-vuln: Correct prctl() argument description
Date: Fri, 16 Feb 2024 13:31:07 -0500
Message-Id: <20240216183108.1564958-10-joel@joelfernandes.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240216183108.1564958-1-joel@joelfernandes.org>
References: <20240216183108.1564958-1-joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the description for arg4 which appears to be outdated.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 Documentation/admin-guide/hw-vuln/core-scheduling.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/core-scheduling.rst b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
index cf1eeefdfc32..338d639a8127 100644
--- a/Documentation/admin-guide/hw-vuln/core-scheduling.rst
+++ b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
@@ -62,8 +62,8 @@ arg3:
 
 arg4:
     ``pid_type`` for which the operation applies. It is one of
-    ``PR_SCHED_CORE_SCOPE_``-prefixed macro constants.  For example, if arg4
-    is ``PR_SCHED_CORE_SCOPE_THREAD_GROUP``, then the operation of this command
+    ``PIDTIME_``-prefixed macro constants.  For example, if arg4
+    is ``PIDTYPE_TGID``, then the operation of this command
     will be performed for all tasks in the task group of ``pid``.
 
 arg5:
-- 
2.34.1


