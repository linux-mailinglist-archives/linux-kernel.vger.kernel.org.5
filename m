Return-Path: <linux-kernel+bounces-101009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E39A487A0B4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 218951C20952
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8F61946B;
	Wed, 13 Mar 2024 01:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Rqssngnl"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C984CBE5A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 01:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710293126; cv=none; b=LakwxtzQqtq4aP2iD76WPJ1Rz1HD+XUMQqbDZAJQ6D2ScInj9kwabZttcKAacLu0UrzHj5K9FTFN/WnhOi5C6AVnoJSTE3MCYgpLdkxVZEVRD020DxUkoBEljzROFqbaHMgYtHSjHrSznUH4GNGyl1e5w+rwVhcyLD/BILvaiRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710293126; c=relaxed/simple;
	bh=cu3MMzOHuWJKImjKqYJ4/NXYAdw+8BhcKEGy95D0Imk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kcBOFGI2QOEsPwx0Nxc22JyxEnCGiVWB8mpoeVoqlUL9x6woQl4JlapgrhGt/kQAZH96jxPLCaa6M2WyYCEIoCho8nq1GWG1K4euPPdYnP8oMt53wsVjYrwp1Nc1Lm7MJOOZwpQXMwZe0jlHPSIOcwJcgoAp2pB8qQjfkYDvVzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=Rqssngnl; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-68f41af71ebso4405436d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 18:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1710293123; x=1710897923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jDrn7wgy/ve0lPoR/xKtbF/cZLSIaETTt3wbkL2858=;
        b=RqssngnlyfPfkO1M7NSQ7hg3w1o+3ugwNj8VifSkFo1gE1VncEZG/qRGwEVRuwk5dR
         /Q+q98uVy6tOx2QCuE1fpom5WUFBjIhgylb2lQOzjzRdLS6sJVxiBy5mUS4YPmZZPn/4
         i8CkPjqp+1KWYqvNEOhxS2kbqfgX4IsZwjc7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710293123; x=1710897923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+jDrn7wgy/ve0lPoR/xKtbF/cZLSIaETTt3wbkL2858=;
        b=DdkM5kMYFqEx63wnpciUP7UwGr5AXYnH3Q2BsNeJs66payhbMw8Oq+xEwj+3cZRRua
         2XqC/mRry0/bU6dLE+j3DsRUPDir63XitraVn3smTkVoIfZTzYlt5boxkaWxMpeZQ3RZ
         zUeDVhlWH7sKlnP8kLVB4adXBCqaGKGJ2uYVBMSv2TKxz4JE29qStZHMjcK8JY/gyT7h
         ZqAJBtgUkp/KDUDGj3rQmx18qO6MehgOgCwLLKdYUYfLkZ5epQTg/aNSd6cyLfsAttd9
         qkgmxrUsqZIe6WQK2iJ3fPO56dkdnB8ufoRKToCB+4bhvu0VDskRR3dmwQ1/Sw66INCI
         Zr4w==
X-Gm-Message-State: AOJu0YzpIrfLuz2FlgpQE2dmic7aQxs0HrqLvUsmFb1osyiLma8F5S5R
	dx/TUM17EB4aebhCvv/eW6JskXnVL7q2jRrA50ts6kVUti9YDMsv4mcF/qxFJwrvtg28nxkySiT
	E
X-Google-Smtp-Source: AGHT+IEbJtuWeR15hakVbXEMMZTuDPev36PD/22XP5I3KXlRLbjFh9A2AyTmrw6JNT7mBOc3CUEd2A==
X-Received: by 2002:a05:6214:238a:b0:691:907:f9e5 with SMTP id fw10-20020a056214238a00b006910907f9e5mr1929870qvb.12.1710293123162;
        Tue, 12 Mar 2024 18:25:23 -0700 (PDT)
Received: from joelbox2.. (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id u9-20020a05621411a900b00690314356a4sm4162132qvv.80.2024.03.12.18.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 18:25:21 -0700 (PDT)
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
Subject: [PATCH v2 09/15] admin-guide/hw-vuln: Correct prctl() argument description
Date: Tue, 12 Mar 2024 21:24:45 -0400
Message-Id: <20240313012451.1693807-10-joel@joelfernandes.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313012451.1693807-1-joel@joelfernandes.org>
References: <20240313012451.1693807-1-joel@joelfernandes.org>
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


