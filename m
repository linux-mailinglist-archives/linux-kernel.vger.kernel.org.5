Return-Path: <linux-kernel+bounces-127972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B8E8953DC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64DA5B222B5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07BD7E788;
	Tue,  2 Apr 2024 12:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WhPGom5Q"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F94F2A8E5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 12:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712062280; cv=none; b=CNOT6vIMBnTvQsyqDITZFjFSQXvISngOv7GCFQeRTVvR+GCClZa+oBbe/Nb6iKCT58rREwISZmIaykTIt9JZPhC+TYniX76jSYRAx/LXiy/ulLKg48anj6/0fsfjhe5GcXuhvzqE/NJpyRHJDHK4qKeN104LPBXuJrKaKekopxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712062280; c=relaxed/simple;
	bh=oElAllZ5P13j3PQNwwFCGQdwmNrFpD3NdwRGZk5W9/I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GqxeP+556Na+jNelgZdYN/3d/t0cWDT1/cleWJTtLYP6r+U7UMwYsOG4rgAQrlC+3AZ5pysDnLv6aKhdansSuFWb72wblc4GAOMaBMs91kMpV5pO4VJLMylgbvazDfLn0ZUCZcMwTiTUNfNM3W72Dn11HuexiVLqGEsX2OPDFiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WhPGom5Q; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-34368c5cadfso331903f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 05:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712062277; x=1712667077; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OP/IorpMEPaYCSeI9noOVqFaOql+UUAA/5aBbuRUBgs=;
        b=WhPGom5Qr05vODwOwaTYza70q//55pTRbPI01HS8jbimMeTxtWmnoS+wa3UUP1vfxy
         yjcglvuj33MbRRaOQ4vNvnz+Ogdgo92XuhJnsVJusT6ja+5zZUo4ZKifDjzGq84KdFVg
         O5lYvddvGLi38WF6OGEoQUzipfE+p3CjRRlskuQUdur07wzgw2VBZxvN5pereZaO+kcX
         toOUvA3rvvXqMcBcW+UhWMvJ1Ae+EPNaAb7c8qFGwL927A9Dfe+K0iP6M0QdE+XWyPg+
         +/WpFfj5/Y1bgoRrRtYPdhD1WQukpLbEwyejUfDeCk3/T4GQaiE1izvbNZV9r1ytRtT7
         Ip9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712062277; x=1712667077;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OP/IorpMEPaYCSeI9noOVqFaOql+UUAA/5aBbuRUBgs=;
        b=jjHEfq4xPsWi8hGnp3NuKm7GN7s+ixp92X0cbIRw9ASqOghewDJ/dhN2Cq9xBHb2uk
         k2A8wG2XlYC4EXnjR6Gb0c9PMEAuHqlansqkMl2U7DMB2OwJOc5WspZT9t6ESNMHM2Az
         Zz02r0aOzQeOgLaX40pdMHNC1HgSZXYhbt2aPI0BLRMHrQZpHux4D7luUUZD5qozY0y/
         aW2cLD05GScsF1k0ffIavsUYhJVyTfkQ82lMCEjkyeBPOPIGxLjxmgvcFM6sezXbqAzD
         sOt1q070ggsefV10lSazpirJhSVWbwrxds3/4eDa+9102hpFfV42n1VbMnEAMgBkjMjb
         q+YA==
X-Forwarded-Encrypted: i=1; AJvYcCWSI5fQmX3Jhka2HIKDmULSfYNCTpL45wM75Hn1K6aNlLx8gt9IH0Qbx0oHSYPU7HX4iZlZZv7XRd1gx6vDl2CViGyvczw1/DViSwsc
X-Gm-Message-State: AOJu0YwJsHSNrlj3mWt7J49yPvVsiFCAQmzZrBI3/MDpRb8L7cu444kr
	sOb7IQ5yb5CX+ij4LpHbomETINnieWx/w6vqnG1MTRDBnZJ12IYEcpke+o/FZm2s5DHwHtZ6Ns1
	wmG4ekc1nwQ==
X-Google-Smtp-Source: AGHT+IEKQGJhcSfFP21Fqdj+QH/10fP9Zd12ZW+9WsU+VBFP3ePpDhwuu5yXNp94FAP98dcP14owPuAgMCR6Mg==
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a5d:6608:0:b0:33e:d4b6:eac3 with SMTP id
 n8-20020a5d6608000000b0033ed4b6eac3mr28105wru.6.1712062276866; Tue, 02 Apr
 2024 05:51:16 -0700 (PDT)
Date: Tue,  2 Apr 2024 12:51:09 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240402125109.1251232-1-jackmanb@google.com>
Subject: [PATCH v2] Documentation: kunit: Clarify test filter format
From: Brendan Jackman <jackmanb@google.com>
To: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Daniel Latypov <dlatypov@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, davidgow@google.com, rmoar@google.com, 
	corbet@lwn.net, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"

It seems obvious once you know, but at first I didn't realise that the
suite name is part of this format. Document it and add some examples.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
v1->v2: Expanded to clarify that suite_glob and test_glob are two separate
	patterns. Also made some other trivial changes to formatting etc.

 Documentation/dev-tools/kunit/run_wrapper.rst | 33 +++++++++++++++++--
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/Documentation/dev-tools/kunit/run_wrapper.rst b/Documentation/dev-tools/kunit/run_wrapper.rst
index 19ddf5e07013..b07252d3fa9d 100644
--- a/Documentation/dev-tools/kunit/run_wrapper.rst
+++ b/Documentation/dev-tools/kunit/run_wrapper.rst
@@ -156,12 +156,39 @@ Filtering tests
 ===============
 
 By passing a bash style glob filter to the ``exec`` or ``run``
-commands, we can run a subset of the tests built into a kernel . For
-example: if we only want to run KUnit resource tests, use:
+commands, we can run a subset of the tests built into a kernel,
+identified by a string like ``<suite_glob>[.<test_glob>]``.
+
+For example, to run the ``kunit-resource-test`` suite:
+
+.. code-block::
+
+	./tools/testing/kunit/kunit.py run kunit-resource-test
+
+To run a specific test from that suite:
+
+.. code-block::
+
+	./tools/testing/kunit/kunit.py run kunit-resource-test.kunit_resource_test
+
+To run all tests from suites whose names start with ``kunit``:
+
+.. code-block::
+
+	./tools/testing/kunit/kunit.py run 'kunit*'
+
+To run all tests whose name ends with ``remove_resource``:
+
+.. code-block::
+
+	./tools/testing/kunit/kunit.py run '*.*remove_resource'
+
+To run all tests whose name ends with ``remove_resource``, from suites whose
+names start with ``kunit``:
 
 .. code-block::
 
-	./tools/testing/kunit/kunit.py run 'kunit-resource*'
+	./tools/testing/kunit/kunit.py run 'kunit*.*remove_resource'
 
 This uses the standard glob format with wildcard characters.
 
-- 
2.44.0.478.gd926399ef9-goog


