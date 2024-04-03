Return-Path: <linux-kernel+bounces-130636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC52897AD1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13F401F21280
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED090156971;
	Wed,  3 Apr 2024 21:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yaFtUSg1"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1F415697F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 21:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712179881; cv=none; b=RWrQb2waVWzWz7Or+aPMhq43OTYe0ErnNN/x9B5YV7qchUmtYKcndXxp9ylEwmp/J3FT3dVh4GW7vvH55TMAY1pX3WrnUw7fwGEokq3HfVn+V4VBEtvrElztUHatYKarPcD76/2Db0lfN65/aT1lM2F99CiTTeKRq+GQc9iArXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712179881; c=relaxed/simple;
	bh=qd65umTVAQ0XSi0JI91/G1TwhdG16GZTlBjpX+GqIj0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NkdYbBvKD9nUmZsdzJCt1yZAbmEp2ccfwncbp5ZNwIC3e5vHU7Cf31pUWE695+e3SWe5KvTqfdWys2U45gAGYDUtXPb2/Ox6iM/vQOt2rfaRLGK3NRazKN6hNWSYeWr4cTVGKCoLYrQQvIU+sUb+2DNmdk2H/Be0oaAQKdEXHDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yaFtUSg1; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cd041665bso5894417b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 14:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712179878; x=1712784678; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yNCr2bDNR2DvEpo0s6dJMGGf+uYRS57bSzaDYyN/uVM=;
        b=yaFtUSg1OEEdCvmLla764zL6zkxKoq4Vyt9ixF+9R7sI5Vw+J3gPVnmZwISKO5MYnl
         6nCgZwluOF3tBb3SwMb4kFYL/PEcHKJ59FrgGekTbQc208cF/R4u/W5DVVX7hMPiAYoZ
         4BnlPdPsXp6zsp84aKYLL3G5d6UYyTvNGd8o14pqGe6FtqpSqOAJbOQEOODlp+9opISa
         m0YGE9JGtFh6S2jldS2h9vpaxSbzNUmFrwBtp1HqFg4G3nttR1VcPaRNYWfHJ6TlAsPn
         pn/P9m7WSaIQ1tXcoPIqJU0ixXt2FAj1NLCX9C/ZQoHJtM0F6iJZF8Pl9s4Qv+ZcOixC
         xSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712179878; x=1712784678;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yNCr2bDNR2DvEpo0s6dJMGGf+uYRS57bSzaDYyN/uVM=;
        b=Dh9hrNPs1MLUr7iTbkX5JbA3cANDXy5tu1NlEdfZpUxJcC4qIZ+/de+G9a8usbiRO5
         gsRz/w1Y/Yj7jKbBHxlWpvXWidoH2ieT3wAjLcx20hYCHHAvRivPsjzR2DZ0MH7E1DJp
         OaZ6PYT+G9F3/QWCBpftlfvmNXQJ6bXgofevMnpYlZCv10Hch0gS0fYxnv2HKxj2E+el
         tk6ewO5KF3yn2uz17vVXZYhuEQ3pZ873tObnC8SeB52qc0qmXNz+cfYxiFxygsfDWmsq
         BGO/VYkSddWMPqf+sRvmHAzh649Ja8kz1PfWH18d2H7iJAFLx6BOj2Z8YI2HEp/OkndF
         s6xg==
X-Forwarded-Encrypted: i=1; AJvYcCVATSVvhfDPS3dxJKTwBhHuo4VdAb9meyFNNMRqj021KtlzCFvVd0Ohh2KTaX6tpWf8/gzf+7Y4CppWhsAXX/L/jn4oW2Mbo2tTm1+t
X-Gm-Message-State: AOJu0Ywi6iMhmsE1eIxdflpg8xGygIaSBELaIOeu1D5BDkqf/uD7cqL9
	VPcUjvHHBOJCczTkbJpR+qnxfvot1d9QwRGwSfhEc8+IUErTrRIXgRZ6szf/grfCeTj/YZ9nKA=
	=
X-Google-Smtp-Source: AGHT+IGIAgSCgQUNBNBkWUPGeeh7fRw40CwuHsb4BINZ5t/Z2WvAcnxKKJDnQ4Z32vO5kOAS1sL64ZhAJw==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a05:6902:1821:b0:dc8:5e26:f4d7 with SMTP id
 cf33-20020a056902182100b00dc85e26f4d7mr216064ybb.13.1712179878640; Wed, 03
 Apr 2024 14:31:18 -0700 (PDT)
Date: Wed,  3 Apr 2024 21:31:11 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240403213111.206047-1-rmoar@google.com>
Subject: [KTAP V2 PATCH v4] ktap_v2: add test metadata
From: Rae Moar <rmoar@google.com>
To: frowand.list@gmail.com, davidgow@google.com, keescook@chromium.org, 
	Tim.Bird@sony.com, shuah@kernel.org, brendanhiggins@google.com, 
	dlatypov@google.com
Cc: tytso@google.com, gustavo.padovan@collabora.com, 
	ricardo.canuelo@collabora.com, corbet@lwn.net, kernelci@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"

Add specification for test metadata to the KTAP v2 spec.

KTAP v1 only specifies the output format of very basic test information:
test result and test name. Any additional test information either gets
added to general diagnostic data or is not included in the output at all.

The purpose of KTAP metadata is to create a framework to include and
easily identify additional important test information in KTAP.

KTAP metadata could include any test information that is pertinent for
user interaction before or after the running of the test. For example,
the test file path or the test speed.

Since this includes a large variety of information, this specification
will recognize notable types of KTAP metadata to ensure consistent format
across test frameworks. See the full list of types in the specification.

Example of KTAP Metadata:

 KTAP version 2
 #:ktap_test: main
 #:ktap_arch: uml
 1..1
     KTAP version 2
     #:ktap_test: suite_1
     #:ktap_subsystem: example
     #:ktap_test_file: lib/test.c
     1..2
     ok 1 test_1
     #:ktap_test: test_2
     #:ktap_speed: very_slow
     # test_2 has begun
     #:custom_is_flaky: true
     ok 2 test_2
 # suite_1 has passed
 ok 1 suite_1

The changes to the KTAP specification outline the format, location, and
different types of metadata.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Rae Moar <rmoar@google.com>
---
Note this version is in reponse to comments made off the list asking for
more explanation on inheritance and edge cases.

Changes since v3:
- Add two metadata ktap_config and ktap_id
- Add section on metadata inheritance
- Add edge case examples

 Documentation/dev-tools/ktap.rst | 248 ++++++++++++++++++++++++++++++-
 1 file changed, 244 insertions(+), 4 deletions(-)

diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
index ff77f4aaa6ef..55bc43cd5aea 100644
--- a/Documentation/dev-tools/ktap.rst
+++ b/Documentation/dev-tools/ktap.rst
@@ -17,19 +17,22 @@ KTAP test results describe a series of tests (which may be nested: i.e., test
 can have subtests), each of which can contain both diagnostic data -- e.g., log
 lines -- and a final result. The test structure and results are
 machine-readable, whereas the diagnostic data is unstructured and is there to
-aid human debugging.
+aid human debugging. Since version 2, tests can also contain metadata which
+consists of important supplemental test information and can be
+machine-readable.
+
+KTAP output is built from five different types of lines:
 
-KTAP output is built from four different types of lines:
 - Version lines
 - Plan lines
 - Test case result lines
 - Diagnostic lines
+- Metadata lines
 
 In general, valid KTAP output should also form valid TAP output, but some
 information, in particular nested test results, may be lost. Also note that
 there is a stagnant draft specification for TAP14, KTAP diverges from this in
-a couple of places (notably the "Subtest" header), which are described where
-relevant later in this document.
+a couple of places, which are described where relevant later in this document.
 
 Version lines
 -------------
@@ -166,6 +169,237 @@ even if they do not start with a "#": this is to capture any other useful
 kernel output which may help debug the test. It is nevertheless recommended
 that tests always prefix any diagnostic output they have with a "#" character.
 
+KTAP metadata lines
+-------------------
+
+KTAP metadata lines are used to include and easily identify important
+supplemental test information in KTAP. These lines may appear similar to
+diagnostic lines. The format of metadata lines is below:
+
+.. code-block:: none
+
+	#:<prefix>_<metadata type>: <metadata value>
+
+The <prefix> indicates where to find the specification for the type of
+metadata, such as the name of a test framework or "ktap" to indicate this
+specification. The list of currently approved prefixes and where to find the
+documentation of the metadata types is below. Note any metadata type that does
+not use a prefix from the list below must use the prefix "custom".
+
+Current List of Approved Prefixes:
+
+- ``ktap``: See Types of KTAP Metadata below for the list of metadata types.
+
+The format of <metadata type> and <value> varies based on the type. See the
+individual specification. For "custom" types the <metadata type> can be any
+string excluding ":", spaces, or newline characters and the <value> can be any
+string.
+
+**Location:**
+
+The first KTAP metadata line for a test must be "#:ktap_test: <test name>",
+which acts as a header to associate metadata with the correct test. Metadata
+for the main KTAP level uses the test name "main". A test's metadata ends
+with a "ktap_test" line for a different test.
+
+For test cases, the location of the metadata is between the prior test result
+line and the current test result line. For test suites, the location of the
+metadata is between the suite's version line and test plan line. For the main
+level, the location of the metadata is between the main version line and main
+test plan line. See the example below.
+
+Note that a test case's metadata is inline with the test's result line. Whereas
+a suite's metadata is inline with the suite's version line and thus will be
+more indented than the suite's result line. Additionally, metadata for the main
+level is inline with the main version line.
+
+KTAP metadata for a test does not need to be contiguous. For example, a kernel
+warning or other diagnostic output could interrupt metadata lines. However, it
+is recommended to keep a test's metadata lines in the correct location and
+together when possible, as this improves readability.
+
+**Example of KTAP metadata:**
+
+::
+
+        KTAP version 2
+        #:ktap_test: main
+        #:ktap_arch: uml
+        1..1
+          KTAP version 2
+          #:ktap_test: suite_1
+          #:ktap_subsystem: example
+          #:ktap_test_file: lib/test.c
+          1..2
+          # WARNING: test_1 skipped
+          ok 1 test_1 # SKIP
+          #:ktap_test: test_2
+          #:ktap_speed: very_slow
+          # test_2 has begun
+          #:custom_is_flaky: true
+          ok 2 test_2
+        # suite_1 passed
+        ok 1 suite_1
+
+In this example, the tests are running on UML. The test suite "suite_1" is part
+of the subsystem "example" and belongs to the file "lib/test.c". It has
+two subtests, "test_1" and "test_2". The subtest "test_2" has a speed of
+"very_slow" and has been marked with a custom KTAP metadata type called
+"custom_is_flaky" with the value of "true".
+
+**Inheritance of KTAP metadata**
+
+Tests can inherit KTAP metadata. A child test inherits all the parent test's
+KTAP metadata except for directly opposing metadata.  For example, if a suite
+has a property of "#:ktap_speed: slow", all child test cases are also marked as
+slow. However, if one of the test cases has metadata of "#:ktap_speed:
+very_slow" then that test case would be marked as very_slow instead and not
+slow.
+
+Note if a test case inherits metadata it does not need to appear as a line in
+the KTAP. Using the example above, not every test case would have the line
+"#:ktap_speed: slow" in their metadata.
+
+**Edge Case Examples of KTAP metadata**
+
+Here are a few edge case examples of KTAP metadata. The first example shows
+metadata in the wrong location.
+
+::
+
+        KTAP version 2
+        1..1
+          KTAP version 2
+          #:ktap_test: suite_1
+          1..3
+          ok 1 test_1
+          #:ktap_test: test_2
+          #:ktap_speed: very_slow
+          ok 2 test_2
+          #:ktap_duration: 1.342s
+          #:ktap_test: test_3
+          #:ktap_speed: slow
+          ok 3 test_3
+        ok 1 suite_1
+
+In this example, the metadata "#:ktap_duration: 1.342s" is in the wrong
+location. It was meant to belong to test_2 but was printed late. The location
+of this metadata is not recommended. However, it is allowed because the line is
+still below "#:ktap_test: test_2" and above any other ktap_test lines.
+
+This second example shows metadata in the correct location but without the
+proper header.
+
+::
+
+        KTAP version 2
+        1..1
+          KTAP version 2
+          #:ktap_test: suite_1
+          1..2
+          not ok 1 test_1
+          #:ktap_speed: very_slow
+          ok 2 test_2
+        ok 1 suite_1
+
+In this example, the metadata "#:ktap_speed: very_slow" is meant to belong to
+test_2. It is in the correct location but does not fall below a ktap_test line
+for test_2. Instead this metadata might be mistaken for belonging to suite_1
+because it does fall under the ktap_test line for suite_1. This lack of header
+is not allowed.
+
+**Types of KTAP Metadata:**
+
+This is the current list of KTAP metadata types recognized in this
+specification. Note that all of these metadata types are optional (except for
+ktap_test as the KTAP metadata header).
+
+- ``ktap_test``: Name of test (used as header of KTAP metadata). This should
+  match the test name printed in the test result line: "ok 1 [test_name]".
+
+- ``ktap_module``: Name of the module containing the test
+
+- ``ktap_subsystem``: Name of the subsystem being tested
+
+- ``ktap_start_time``: Time tests started in ISO8601 format
+
+  - Example: "#:ktap_start_time: 2024-01-09T13:09:01.990000+00:00"
+
+- ``ktap_duration``: Time taken (in seconds) to execute the test
+
+  - Example: "#:ktap_duration: 10.154s"
+
+- ``ktap_speed``: Category of how fast test runs: "normal", "slow", or
+  "very_slow"
+
+- ``ktap_test_file``: Path to source file containing the test. This metadata
+  line can be repeated if the test is spread across multiple files.
+
+  - Example: "#:ktap_test_file: lib/test.c"
+
+- ``ktap_generated_file``: Description of and path to file generated during
+  test execution. This could be a core dump, generated filesystem image, some
+  form of visual output (for graphics drivers), etc. This metadata line can be
+  repeated to attach multiple files to the test. Note use ktap_log_file or
+  ktap_error_file instead of this type if more applicable.
+
+  - Example: "#:ktap_generated_file: Core dump: /var/lib/systemd/coredump/hello.core"
+
+- ``ktap_log_file``: Path to file containing kernel log test output
+
+  - Example: "#:ktap_log_file: /sys/kernel/debugfs/kunit/example/results"
+
+- ``ktap_error_file``: Path to file containing context for test failure or
+  error. This could include the difference between optimal test output and
+  actual test output.
+
+  - Example: "#:ktap_error_file: fs/results/example.out.bad"
+
+- ``ktap_results_url``: Link to webpage describing this test run and its
+  results
+
+  - Example: "#:ktap_results_url: https://kcidb.kernelci.org/hello"
+
+- ``ktap_arch``: Architecture used during test run
+
+  - Example: "#:ktap_arch: x86_64"
+
+- ``ktap_compiler``: Compiler used during test run
+
+  - Example: "#:ktap_compiler: gcc (GCC) 10.1.1 20200507 (Red Hat 10.1.1-1)"
+
+- ``ktap_respository_url``: Link to git repository of the checked out code.
+
+  - Example: "#:ktap_respository_url: https://github.com/torvalds/linux.git"
+
+- ``ktap_git_branch``: Name of git branch of checked out code
+
+  - Example: "#:ktap_git_branch: kselftest/kunit"
+
+- ``ktap_kernel_version``: Version of Linux Kernel being used during test run
+
+  - Example: "#:ktap_kernel_version: 6.7-rc1"
+
+- ``ktap_config``: Config name and value. This does not necessarly need to be
+  restricted to Kconfig.
+
+  - Example: "#:ktap_config: CONFIG_SYSFS=y"
+
+- ``ktap_id``: Description of ID and ID value. This is an open-ended metadata
+  used for IDs, such as checkout id or test run id.
+
+  - Example: "#:ktap_id: Test run id: 14e782"
+
+- ``ktap_commit_hash``: The full git commit hash of the checked out base code.
+
+  - Example: "#:ktap_commit_hash: 064725faf8ec2e6e36d51e22d3b86d2707f0f47f"
+
+**Other Metadata Types:**
+
+There can also be KTAP metadata that is not included in the recognized list
+above. This metadata must be prefixed with the test framework, ie. "kselftest",
+or with the prefix "custom". For example, "# custom_batch: 20".
+
 Unknown lines
 -------------
 
@@ -206,6 +440,7 @@ An example of a test with two nested subtests:
 	KTAP version 2
 	1..1
 	  KTAP version 2
+	  #:ktap_test: example
 	  1..2
 	  ok 1 test_1
 	  not ok 2 test_2
@@ -219,6 +454,7 @@ An example format with multiple levels of nested testing:
 	KTAP version 2
 	1..2
 	  KTAP version 2
+	  #:ktap_test: example_test_1
 	  1..2
 	    KTAP version 2
 	    1..2
@@ -254,6 +490,7 @@ Example KTAP output
 	KTAP version 2
 	1..1
 	  KTAP version 2
+	  #:ktap_test: main_test
 	  1..3
 	    KTAP version 2
 	    1..1
@@ -261,11 +498,14 @@ Example KTAP output
 	    ok 1 test_1
 	  ok 1 example_test_1
 	    KTAP version 2
+	    #:ktap_test: example_test_2
+	    #:ktap_speed: slow
 	    1..2
 	    ok 1 test_1 # SKIP test_1 skipped
 	    ok 2 test_2
 	  ok 2 example_test_2
 	    KTAP version 2
+	    #:ktap_test: example_test_3
 	    1..3
 	    ok 1 test_1
 	    # test_2: FAIL

base-commit: 906f02e42adfbd5ae70d328ee71656ecb602aaf5
-- 
2.44.0.478.gd926399ef9-goog


