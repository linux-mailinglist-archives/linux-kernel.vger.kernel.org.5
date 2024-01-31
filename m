Return-Path: <linux-kernel+bounces-46570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 282C9844176
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7520282E15
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCCF82875;
	Wed, 31 Jan 2024 14:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G5L9qlvb"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48578286D
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706710225; cv=none; b=ao1OFCgQYn6EEIVO0l/oyaZNbvBx1sFKOs9L3RYRdJfq4VaPjOM2gM4c1KN1Gg6mSaxDPDg8gSVeukaDxAXA3UZEZyZpxiEvsEsQ2FY7RmL0mAwoBaQKZVrXFgNH6Ust6iwSsHHUmXYScw1VYh0C4tq/w5SfQvtuwimXg0NF8jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706710225; c=relaxed/simple;
	bh=ChnpHtzhwwEksEpZfUG5N45CvS33hPCxhPKxVI52Zr0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nwvz1X9RYpcj8p6FDiEHdNlBZ7Bfx3ZSEKESOQR9oenb9jsckctvesc9LhcjsRExWFqR/Md5PiwWFgYtSwugraXmFVZlHuOYfEyhnIhESUakVgHaPh7GbVMolJIfyhnoWVUon62oD5uHCL+0T8lcS96xCp+WbrVfgZZkNAs2tAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G5L9qlvb; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-40f00a86728so10884645e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706710222; x=1707315022; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IzlY9A2R0kaKV7lZ2foiFIkkQaUNsuvTSg8191v0PRY=;
        b=G5L9qlvbrgeEzuu8K91kPMG3uNbkzYRxHwQWzmvdkPU5xLF6llFz3M/xh7eKz70YVW
         dW0Tr2HtcGRyxDjA62jfVd4KiG2GOCzIpk9JBq5dvXZ+sh+EdJPTxqymeMhy50SZ34s1
         cqCaFxXkrBoOtVhO7kCa4J0rHAN1iidnDlQ2R5C8tZkh67ylbcW3A8bbVO/rADb6dIs/
         suHKZs2k0N1IvdRdh5UlYZ/Do5wZWujlWNZRkWyR2kITzCb1DUVfJ8SiuRpVz2N81wYP
         +C8oTIgirDYZLBX5BGKrOVUUSnYNpAwEfXEF7txxAaf0L8iasZgoG4Er3YIsaNCxukUS
         kJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706710222; x=1707315022;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IzlY9A2R0kaKV7lZ2foiFIkkQaUNsuvTSg8191v0PRY=;
        b=Wrv6dpZ16dW8sqwkkfVxA7WN5DoixFVZsBMiAZCGw2oUFlWbLDokOoOZz6RsBBMS8u
         Db5vnjTGbitNNLdPrxgObYOgwuhE39pL2r10b09wXgz3qnULKUoyUvyrUHRwjKexXFtz
         2nDwzNy+TkA9xIm2u9GGqtOmmA6kTcUUz7jWE6RLveQSKcUb7MHojEcTylgy3TiK0SsN
         MXFi9HiPADx+e1+0teljYQuHmPHyQkAtwjfZEjG2CMxKpPVmyn3y+rYqhPc8UzMgB4G8
         8UcpySVC63BI8pPbqACOsnFWNCOWD2PIPqREijGYEU6mZAdpWPb7imfv9TgIppQFNa9y
         GbJQ==
X-Gm-Message-State: AOJu0YxLv3R14v1lFWQv/VqvivvQwpfJr/9y2h/Ql5C1q0HwgKgt4cGu
	dS8CijaGvewK1nUkxfKmWwzvyZkUmu9YxE5+bLFZQQ7cuvPXCcdSzdQTfoW6apEjYOUDLonDOOF
	0hL4auw6rymw1Dw5R1w==
X-Google-Smtp-Source: AGHT+IFoIzm7UlztHyR94RuKhnD6orBc64DUoMgvOKfcrGZ0sM+BqGYm3tBri/8v96og+cTTxoB4iflBZRGHIEUL
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:3d8e:b0:40e:f5d0:7002 with
 SMTP id bi14-20020a05600c3d8e00b0040ef5d07002mr5457wmb.8.1706710221712; Wed,
 31 Jan 2024 06:10:21 -0800 (PST)
Date: Wed, 31 Jan 2024 14:09:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240131140955.3322792-1-vdonnefort@google.com>
Subject: [PATCH] ring-buffer: Clean ring_buffer_poll_wait() error return
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The return type for ring_buffer_poll_wait() is __poll_t. This is behind
the scenes an unsigned where we can set event bits. In case of a
non-allocated CPU, we do return instead -EINVAL (0xffffffea). Lucky us,
this ends up setting few error bits (EPOLLERR | EPOLLHUP | EPOLLNVAL), so
user-space at least is aware something went wrong.

Nonetheless, this is an incorrect code. Replace that -EINVAL with a
proper EPOLLERR to clean that output. As this doesn't change the
behaviour, there's no need to treat this change as a bug fix.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 13aaf5e85b81..fd4bfe3ecf01 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -944,7 +944,7 @@ __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
 		full = 0;
 	} else {
 		if (!cpumask_test_cpu(cpu, buffer->cpumask))
-			return -EINVAL;
+			return EPOLLERR;
 
 		cpu_buffer = buffer->buffers[cpu];
 		work = &cpu_buffer->irq_work;

base-commit: 29142dc92c37d3259a33aef15b03e6ee25b0d188
-- 
2.43.0.429.g432eaa2c6b-goog


