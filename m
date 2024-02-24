Return-Path: <linux-kernel+bounces-79529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C438623AD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 10:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C06401F2336E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 09:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B83241E0;
	Sat, 24 Feb 2024 09:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="fVAsJOCx"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC84E3F9E0
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 09:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708765500; cv=none; b=kJ3rSiRve5aTt2z8OJuOvVF/e/+SlejOWxWgc7P+KpnZsDPvgr+hiOBS5CfuEQQQufzAgbcb8iXaxVyRMxSsoZ4EUKorYfGqrr5E8L65fmSfeWYJepP2EZA1nbWISeK/yHMzamNGNosfQLuJlwNSL749yraWIyiP/izhdwb5QXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708765500; c=relaxed/simple;
	bh=W2t1gDt0S4a1/HW/6/kG7xzEKfo9X9H0YdqgUGLKJyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ESU2mUt7gxTqB31dAC3F8cIEnl0U5HE529/z0fR/KMg1MPpDaabs2T72+n6fSr2rRGSG+9CSKYAYqeyMlJ5Gym9ASMmUmcE3dCzf/tpOrr4yBq5Mh/K8UaQZBvqfy0W5SmeTasTrR8G3E/NDQxx/fORdIe2yr5zR0OF1Uxy+lCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=fVAsJOCx; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4129ee52503so753025e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 01:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1708765497; x=1709370297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x86i2bLvLQ8s2ekOK4n+eRSdBkIkaafdJNLN4ekEok0=;
        b=fVAsJOCxmCUI1Kxw29LiXfG+xui/HzyYCAVQpMHLm5MC0zVM88loKBF6sVav42jEwt
         o8NUDMVCz4AiHIblhZE3AulVB1kXI34JlvY+v32TitlwKxnjN+E13eUXZzWXGdyBF6V2
         m1OaGm3Fc1XoK+V8F6t8F1lcLRsJD5cO9wco/Yi3KUq54yBBKpEukTkCWNGYh80Exfim
         mrCifyxfaSfmbzBlUMMkFqNNxk/br5T6fCct5AL/VIK60RWNvqRwWBRMn8pOq+XQ8hhv
         d1E9mgOXkpVeY2pT8XFLSv/v50O3gphVy2lxtgxTSzssbJNhU8u6rdfgwbKkXicEUHFA
         CVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708765497; x=1709370297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x86i2bLvLQ8s2ekOK4n+eRSdBkIkaafdJNLN4ekEok0=;
        b=pe6Z+Cp6H25NyxR2AC2dboT5iv4kAoeYOsQkDoj+XkCUGxOE1RG2gw/jder5c6KtPJ
         Jn0zUFwphfsWV+lkad23QiYOmRtSOrpQ6etvdyjuqXj4HHwxisvH0HBSFepZE6UPthfe
         YM4Z4ASmvfpfXAVCJo4kM1BTt2MH12o8yEAyrixuEJeFeHo8eiAwGcJllWIUHviesUl6
         hEz8RiuwPfRpit3J3hgC9az4BHQWYuM0aSS83FgeJQuuv7yjXkXC1rvvfj/hL87Z4W1G
         sDxvv0ATgU3ZNPimirmk+iXKG4A0WlfFDnuVF1iceiF4jmPtmliSGXTUFfKOYV4rGcO4
         ou2A==
X-Forwarded-Encrypted: i=1; AJvYcCVeZc/OAjKp3OIJTNkD/P3+X1eVEnc2JeQi9kzBWiQ34M5noPt9hQiCgc2xW/QfMmqTrsqma8uqCEQXz0LUQuQAzbnksh/qKnabIDi6
X-Gm-Message-State: AOJu0Yy9dC/XX+92BoILeDwTbs7VoMTusaOUiYQITxTVvTEI+eN4oASN
	aOWK/70G5PdSA2fmKA6NkTlJJbgOB0R+OnL7D2C9h5Q221am+rCylyECXvFdpQ==
X-Google-Smtp-Source: AGHT+IFYZFhVl1THeVUMtDtrUqkTWkBH8i6j7z/8R1v79GFRQA5Oh7V1BKlSbHwyMZa1VzUzVFhfWQ==
X-Received: by 2002:a05:600c:4f52:b0:412:8872:e8f4 with SMTP id m18-20020a05600c4f5200b004128872e8f4mr1491142wmq.1.1708765497395;
        Sat, 24 Feb 2024 01:04:57 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id m6-20020a7bce06000000b00410bca333b7sm5320593wmc.27.2024.02.24.01.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 01:04:56 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Dmitry Safonov <dima@arista.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Dmitry Safonov <0x7f454c46@gmail.com>
Subject: [PATCH net-next 09/10] selftests/net: Don't forget to close nsfd after switch_save_ns()
Date: Sat, 24 Feb 2024 09:04:17 +0000
Message-ID: <20240224-tcp-ao-tracepoints-v1-9-15f31b7f30a7@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240224-tcp-ao-tracepoints-v1-0-15f31b7f30a7@arista.com>
References: <20240224-tcp-ao-tracepoints-v1-0-15f31b7f30a7@arista.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-b6b4b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708765347; l=1645; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=W2t1gDt0S4a1/HW/6/kG7xzEKfo9X9H0YdqgUGLKJyM=; b=HrtiK7tVw/bjSYWfjeueAiyqfvuMn5IWHQgF7i/oeeqthLP8sDdHMXQ2ky8sLEotB7YM5TdU3 8MnzdiddrQEDEnm5kK5GLfccXOWIvziIgaef9UzqhAamDJrH9nnxroF
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

The switch_save_ns() helper suppose to help switching to another
namespace for some action and to return back to original namespace.

The fd should be closed.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/net/tcp_ao/lib/setup.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/tcp_ao/lib/setup.c b/tools/testing/selftests/net/tcp_ao/lib/setup.c
index 92276f916f2f..f80120bef3dc 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/setup.c
+++ b/tools/testing/selftests/net/tcp_ao/lib/setup.c
@@ -142,6 +142,13 @@ int switch_save_ns(int new_ns)
 	return ret;
 }
 
+void switch_close_ns(int fd)
+{
+	if (setns(fd, CLONE_NEWNET))
+		test_error("setns()");
+	close(fd);
+}
+
 static int nsfd_outside	= -1;
 static int nsfd_parent	= -1;
 static int nsfd_child	= -1;
@@ -296,7 +303,7 @@ static bool is_optmem_namespaced(void)
 		int old_ns = switch_save_ns(nsfd_child);
 
 		optmem_ns = !access(optmem_file, F_OK);
-		switch_ns(old_ns);
+		switch_close_ns(old_ns);
 	}
 	return !!optmem_ns;
 }
@@ -317,7 +324,7 @@ size_t test_get_optmem(void)
 		test_error("can't read from %s", optmem_file);
 	fclose(foptmem);
 	if (!is_optmem_namespaced())
-		switch_ns(old_ns);
+		switch_close_ns(old_ns);
 	return ret;
 }
 
@@ -339,7 +346,7 @@ static void __test_set_optmem(size_t new, size_t *old)
 		test_error("can't write %zu to %s", new, optmem_file);
 	fclose(foptmem);
 	if (!is_optmem_namespaced())
-		switch_ns(old_ns);
+		switch_close_ns(old_ns);
 }
 
 static void test_revert_optmem(void)

-- 
2.43.0


