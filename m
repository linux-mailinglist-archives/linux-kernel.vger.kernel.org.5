Return-Path: <linux-kernel+bounces-104637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 199BD87D155
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0447282AAD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B95E45970;
	Fri, 15 Mar 2024 16:44:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C953C680
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 16:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521051; cv=none; b=WwmornK7wG8ILS5Sn47yRVDpBR/ygC/iQqMf4b+o0h7Je2XUBjv0UAaINp0PF/a+qfbOhMeVh/X3sexbgvmmwVYKi89UgasKbTfybPzhAVM7xtYsdJOi4BaGYwNmBGTqlFtR6Qd4lR6k6JemRYumLazuFXXsPys1wTvM+IQofTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521051; c=relaxed/simple;
	bh=jLNuWcPtsxUJWQztXx7RPqipSpD4lImifsUOZ+kZPJ4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=iV6qLStL1sBLrRRetPZjx8h9qSKq6WNR4MV/kYSB9GavrCwX5QcR4qoVXAIblAcjmBpV3J9BdyjDxSvDLziC8VW2YWRO61ywTG+YDIlzfQAyVULohzpdHd8bikH+uHWGYPz4m2p+S2PSFCyFPkz6L66OKUPZ1dE3jUR0mDUsrhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63486C43399;
	Fri, 15 Mar 2024 16:44:11 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rlAhN-000000033H4-1el6;
	Fri, 15 Mar 2024 12:46:25 -0400
Message-ID: <20240315164625.260447550@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 15 Mar 2024 12:46:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: "John Warthog9 Hawley" <warthog9@kernel.org>,
 John Hawley <warthog9@eaglescrag.net>,
 "Ricardo B. Marliere" <ricardo@marliere.net>
Subject: [for-next][PATCH 2/2] ktest: force $buildonly = 1 for make_warnings_file test type
References: <20240315164601.705819502@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Ricardo B. Marliere" <ricardo@marliere.net>

The test type "make_warnings_file" should have no mandatory configuration
parameters other than the ones required by the "build" test type, because
its purpose is to create a file with build warnings that may or may not be
used by other subsequent tests. Currently, the only way to use it as a
stand-alone test is by setting POWER_CYCLE, CONSOLE, SSH_USER,
BUILD_TARGET, TARGET_IMAGE, REBOOT_TYPE and GRUB_MENU.

Link: https://lkml.kernel.org/r/20240315-ktest-v2-1-c5c20a75f6a3@marliere.net

Cc: John Hawley <warthog9@eaglescrag.net>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 4383729e0fc2..eb31cd9c977b 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -847,6 +847,7 @@ sub set_value {
     if ($lvalue =~ /^(TEST|BISECT|CONFIG_BISECT)_TYPE(\[.*\])?$/ &&
 	$prvalue !~ /^(config_|)bisect$/ &&
 	$prvalue !~ /^build$/ &&
+	$prvalue !~ /^make_warnings_file$/ &&
 	$buildonly) {
 
 	# Note if a test is something other than build, then we
-- 
2.43.0



