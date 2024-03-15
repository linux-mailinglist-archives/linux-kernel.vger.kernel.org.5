Return-Path: <linux-kernel+bounces-104352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB54C87CC77
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A990B282E7A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160771C287;
	Fri, 15 Mar 2024 11:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="I9tCSUPS"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5471B809;
	Fri, 15 Mar 2024 11:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710502742; cv=none; b=Zc9FWNM9JG/l5TlokHr+GCk8dWQc3+4RKIrlUUPnQRhoEwFH2NkP6rcrR7s0qLYL8mcqE9CpanW9EmfEO+bt6pbHtrA01t9Vz2RbdA5MJijpaCl1MElcM30WHnoWhEtOZ1WTXOA4yNa+gA7dl1Rk2IhrgN96W10MKaYdVqC6Ulk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710502742; c=relaxed/simple;
	bh=orpFgHvtrDbE/5GCfbNJ/7zDDiGgsLl9lSdt61UsgGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BdHfMitR0LNHwxAjQhufM9KTdugpgueZMBNkM4yokRnFMyPfgSZQgV63jpWVW/ZrdR/9CSKaywYQlMWsBdbpeED9TRM1QoBxCKL57mCs/DM0oAj6XaSsrB04h14Bd+LUOX7adLXnWvnYvBNkoGYd/lBmq/lZHhEHyiAiDhccGhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=I9tCSUPS; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a449c5411e1so260277266b.1;
        Fri, 15 Mar 2024 04:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710502739; x=1711107539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1vRUl7sstn1m+3KlSoNBU6wq9u3nGCzm/f05r+8MPQ=;
        b=I9tCSUPSLrU3mzcXMuvKCPvVjauFgTujP/14p+2/cRE7vz9xI7guiPQ6z3w4kCMsLC
         jc28esjZEs4SwZeplSokvBsMjw1dfHKd4wRtndVDGEaDnHAryezLKaozlJQz49OpN024
         LvGqyeByyy3ELRqrTMbfpzhCCaiKyZdmh0huPbvjd7y0cXqxcKsY8+jYVRCc3BHYuv3Y
         /8svInMbSGimZgnsFHxwg6sHB5/GH0YwndiTCBIalOYLrzKxKK9PGB6+XqtPFqXCarAf
         aLshiUSYIGPClfX7NY/Oqrccc12FpSlsYEKzYDvI1c8ohtK1HNQJ3ZtnhnwcKmjIK73w
         vapw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710502739; x=1711107539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1vRUl7sstn1m+3KlSoNBU6wq9u3nGCzm/f05r+8MPQ=;
        b=j4pjfXV+EUzeJpM8j1W13nMvRTm7lYMmwO4EyxU6/pkZW1FTLdt6GOY+5krTCZ6u+T
         2cV2a9d/Sp1RxW1ZfueLyLFjJ1Q6omWDo7HF/b0yYyZH88cC7LWVRkjVSLa5KGThsw9c
         otis+9JAy+6FQryThbZ8fo9KlEgoblhyXVnJW6TkTrsZpdnu9IXyHpttKhvQD8JeG9V8
         Rc4SkGJMNiegNQrYUIiKhb5LU1xHVHGXxUVMwFXPutdSjbxxJEwxpzlApjE99fYP58dK
         2SU+NF0v2QJswW2y/Wy53XAuw/DGyuGmse303uHoOXpDUhPZC6pknE7zXu4X5v9/3Oa0
         L+cw==
X-Forwarded-Encrypted: i=1; AJvYcCV4NQK8iC54Und3P8CHCYsXlbe3MDfbAffh8uCQnn4/OW7OC4wISDXpCcX0XEkg2aiN8bT88InijviJvSXyvfWcR+l4ZuqsU7dOGBF9O8GUDur3SEFpFIS3zJ6ybvKdQnof
X-Gm-Message-State: AOJu0YzFpzn0ptcUGO/RFfUxFC1Fpyj81r6muaVa+4tbmAcXzaoosmPu
	XxzxmjcKUB3T/NR5E5vitzDJ8lL10RHltUohBQqUnxYdNdfocT4GvVH/90p7zZH6vw==
X-Google-Smtp-Source: AGHT+IHnTSUzMhQj8J4CoLtxGIEjCQa5J7Xvsgz1J7EvqPwTz4uTZ1RAxz7js99wxdjPzIEbgYwVKA==
X-Received: by 2002:a17:906:b80b:b0:a46:7ccc:44a with SMTP id dv11-20020a170906b80b00b00a467ccc044amr1914855ejb.14.1710502738897;
        Fri, 15 Mar 2024 04:38:58 -0700 (PDT)
Received: from ddev.DebianHome (dynamic-095-119-217-226.95.119.pool.telefonica.de. [95.119.217.226])
        by smtp.gmail.com with ESMTPSA id fg3-20020a056402548300b005682f47aea7sm1610024edb.94.2024.03.15.04.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 04:38:58 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: linux-security-module@vger.kernel.org
Cc: Serge Hallyn <serge@hallyn.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 03/10] capability: use new capable_any functionality
Date: Fri, 15 Mar 2024 12:37:24 +0100
Message-ID: <20240315113828.258005-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240315113828.258005-1-cgzones@googlemail.com>
References: <20240315113828.258005-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use the new added capable_any function in appropriate cases, where a
task is required to have any of two capabilities.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v3:
  - rename to capable_any()
  - simplify checkpoint_restore_ns_capable()
---
 include/linux/capability.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index eeb958440656..4db0ffb47271 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -204,18 +204,17 @@ extern bool file_ns_capable(const struct file *file, struct user_namespace *ns,
 extern bool ptracer_capable(struct task_struct *tsk, struct user_namespace *ns);
 static inline bool perfmon_capable(void)
 {
-	return capable(CAP_PERFMON) || capable(CAP_SYS_ADMIN);
+	return capable_any(CAP_PERFMON, CAP_SYS_ADMIN);
 }
 
 static inline bool bpf_capable(void)
 {
-	return capable(CAP_BPF) || capable(CAP_SYS_ADMIN);
+	return capable_any(CAP_BPF, CAP_SYS_ADMIN);
 }
 
 static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
 {
-	return ns_capable(ns, CAP_CHECKPOINT_RESTORE) ||
-		ns_capable(ns, CAP_SYS_ADMIN);
+	return ns_capable_any(ns, CAP_CHECKPOINT_RESTORE, CAP_SYS_ADMIN);
 }
 
 /* audit system wants to get cap info from files as well */
-- 
2.43.0


