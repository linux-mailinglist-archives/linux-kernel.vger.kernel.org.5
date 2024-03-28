Return-Path: <linux-kernel+bounces-123057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A5B89018D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 479ACB22DE2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1089384FCE;
	Thu, 28 Mar 2024 14:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VJn6ShWU"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D081F80027
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711635615; cv=none; b=r4Xdm0Tnp8pH5aQPLAfkMday20ERzzpCQt0aSU1Owhxj3/lvwJFbQ7W/tYKg/V9bISUlMO6HHjYxeJjWF7DXHTKo3ANrN0/IidQ4eOhTiMMPYRLXJq/mzgTvPUJunjhEE4yEHNn3FsVac0rMEA1JNqNqx8ygc9DKwmryTYa7Rjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711635615; c=relaxed/simple;
	bh=YHZ2qDQtrHJ7X6uQMFA19oqP0aMOKlutpOAK5TIojS8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OfikdFn3m3Jyinxw/s/xw9bolAbYXUqIxY6nhTJHjcoPXtiQYG0lmYrWDKqzmE+bWzvBaatHLMz3GdDSqxYk0CfvX8/NdOy1wpCM29+PYs9AvqQyODixtP6kJRo07kxxitQZKe9gMjppsTS2Hyqkqu9KeOME/ScY/wR+hOylyKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VJn6ShWU; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dd933a044baso2532186276.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 07:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711635613; x=1712240413; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ywi9W0+VrdEwTHjF11TkVgGoMgKOQYfnHN16lHNeHLA=;
        b=VJn6ShWUsDGhgwyIAESpUvN+73/Tm07JGNVBcPqPRuzcYaop7wLxMq4rM1gBWQaIII
         gs5guBZyrHpywU6wcTzoDAAXFK/rJI4mQD/0rdyMm5eGnOX749TQEXwQAMJDrSHjxZPT
         E5VcsEMzLrxJuAsb9dT9sXeFU8qUS8CbRB/DQSTG5Yug5fT3sq+OPfmjD4RrT5Ptcd8d
         yvblBrnSq01YUNvrbkUceMqUDB9IviJCEgFRpSelBNwFrXGIvSCUMiC5gyxld2HpIqmf
         po8axAGEANyVb5maOSTLXJKjGjQfHB74EgLGyL5oOQ3meWfCBk7KZI9oMxCHEJ8Ik1xm
         MZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711635613; x=1712240413;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ywi9W0+VrdEwTHjF11TkVgGoMgKOQYfnHN16lHNeHLA=;
        b=YQuk/OIKtGCwvvNu2smC++5gkOiqsv7KRBhEABxQNexck46h293DosE4d9rTiBRagt
         CEQqHUjoCVzmF48Q9mGbK9Gm733nCiZ4OaNCBB4CyRKSGECImKtUXRSia5NWD1MZQPNP
         xc1k6hPYXh1ZFxopyQOauI1N2QqJ7wnmxJ1E12KyHX9C0n/7e3asiCs/T95Nsze6MNZW
         AH0I4/LQBKNSme1YBb+67bGSYRmqKLUnWOuqeqyCbgqW4Si1kfnWdAnXyYi8caw3Licr
         96C/p64hCKqQj51jIJykyrbGm6JgQXPNwWYmGiVhmpOi60eRZVLsWg3r4LoDfdr34Irn
         gnbA==
X-Forwarded-Encrypted: i=1; AJvYcCXUFNJx1UN4JTBMB3rSNw4/UoseU5Q14uqsjMGjupMspsK2tZ8XIkb9QJuWnuzhH87wXpXZQ5iUOA1hImKehbVBbkfCtyqktfmIqh7i
X-Gm-Message-State: AOJu0Yw/pHEyMuUXbgGqERyuIhc8eqox0lbnLgNz6hCSqrMHSgbqUzeZ
	ssoYzHI9Jal9sDKboDoglInqVZirKlC3wzQArwcEzkrLIIuXUHEYUJCTktXunRkxDXj6NsNbJlV
	a1oj4tRuIFg==
X-Google-Smtp-Source: AGHT+IF5T/UC/ZI+sJghdQaQT7RB77mNf5c73vZHpF2Z2msrfpy5Y10FafAMAzCctl95KssMUBsd0WjxxlFQSA==
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a05:6902:1507:b0:dbd:ee44:8908 with SMTP
 id q7-20020a056902150700b00dbdee448908mr759573ybu.0.1711635612898; Thu, 28
 Mar 2024 07:20:12 -0700 (PDT)
Date: Thu, 28 Mar 2024 14:20:04 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240328142004.2144568-1-jackmanb@google.com>
Subject: [PATCH] Documentation: kunit: Clarify test filter format
From: Brendan Jackman <jackmanb@google.com>
To: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Brendan Higgins <brendan.higgins@linux.dev>, davidgow@google.com, rmoar@google.com, 
	corbet@lwn.net, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"

It seems obvious once you know, but at first I didn't realise that the
suite name is part of this format. Document it and add example.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 Documentation/dev-tools/kunit/run_wrapper.rst | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kunit/run_wrapper.rst b/Documentation/dev-tools/kunit/run_wrapper.rst
index 19ddf5e07013..e75a5fc05814 100644
--- a/Documentation/dev-tools/kunit/run_wrapper.rst
+++ b/Documentation/dev-tools/kunit/run_wrapper.rst
@@ -156,13 +156,20 @@ Filtering tests
 ===============
 
 By passing a bash style glob filter to the ``exec`` or ``run``
-commands, we can run a subset of the tests built into a kernel . For
+commands, we can run a subset of the tests built into a kernel,
+identified by a string like ``$suite_name.$test_name``. For
 example: if we only want to run KUnit resource tests, use:
 
 .. code-block::
 
 	./tools/testing/kunit/kunit.py run 'kunit-resource*'
 
+Or to run just one specific test from that suite:
+
+.. code-block::
+
+	./tools/testing/kunit/kunit.py run 'kunit-resource-test.kunit_resource_test_init_resources'
+
 This uses the standard glob format with wildcard characters.
 
 .. _kunit-on-qemu:
-- 
2.44.0.396.g6e790dbe36-goog


