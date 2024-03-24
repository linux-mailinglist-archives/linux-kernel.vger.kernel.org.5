Return-Path: <linux-kernel+bounces-112915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D458887FB8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B58D11F212DC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BDF6D1BB;
	Sun, 24 Mar 2024 22:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4HSJJqq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30156CDDF;
	Sun, 24 Mar 2024 22:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319726; cv=none; b=EJ8bN+Pomj4IFwsALjL01CFdv+CHpIIZUYN6/xI4yKV/wkLr8UGVyJABBmnz2x8EcpJuN+O0bIC+xm/XhfvNqzKzrVpleYbXDYmU8vDyAw6q8nSf8aiUuEJoscG2BcEx5nryooP/tq9s1uW6FAgtkwnqK4lKtUK+3p6Z8AqFrVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319726; c=relaxed/simple;
	bh=kcjCwDbEJD49FCkn7bWPsxt2uts52PTkJf8FWlS/DAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LrZ/kagZnJATaoeKQTqhnHOseecuk01hMqndGbuEpAmuNL10YaOAnUJBxrvxUJ8HJYhqpgMz1F98QDsAJ+8Kr+fJWCkck7p07CJktJmEZy/rSSsowyd5lhloXohlJDpoUhGVM8FdsEn29H2EhJplm9Fjo3jYv5bXYPHxre87HxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4HSJJqq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C652C43399;
	Sun, 24 Mar 2024 22:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319726;
	bh=kcjCwDbEJD49FCkn7bWPsxt2uts52PTkJf8FWlS/DAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g4HSJJqqKGlxdGpcT5rJiXw1C/IvAoxCdtZxXPALN7yNikhdMW5kfFfMU+Kzrnnfk
	 NN0x+mpIMNWHJm8XiJmnQl0kOHipfPkvyXnH4Ih5Msd+VNpczCgG7Jm0LmkL7GiPxk
	 iiYXf5yQj2bLblQZEEWKmhv/KLlOq9USb8SXWcchrXCnthb7XNxs9JsfzDPPzpcoJI
	 79rN3nmh455mvlcOM1NEJ2RdYLwhXXtsYojrkuh0NK+vrrfgfVW14ErqMDGh99yDtK
	 3HTNPH2JQN8SNgiX7gV502/By41lhcjA95d5iK8REqbycf+w7elNF3tPTfSdCmF8n4
	 27AOb14G6gzOA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Gow <davidgow@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Justin Stitt <justinstitt@google.com>,
	Daniel Latypov <dlatypov@google.com>,
	Rae Moar <rmoar@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 028/715] kunit: test: Log the correct filter string in executor_test
Date: Sun, 24 Mar 2024 18:23:27 -0400
Message-ID: <20240324223455.1342824-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: David Gow <davidgow@google.com>

[ Upstream commit 6f2f793fba78eb4a0d5a34a71bc781118ed923d3 ]

KUnit's executor_test logs the filter string in KUNIT_ASSERT_EQ_MSG(),
but passed a random character from the filter, rather than the whole
string.

This was found by annotating KUNIT_ASSERT_EQ_MSG() to let gcc validate
the format string.

Fixes: 76066f93f1df ("kunit: add tests for filtering attributes")
Signed-off-by: David Gow <davidgow@google.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Justin Stitt <justinstitt@google.com>
Reviewed-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: Rae Moar <rmoar@google.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/kunit/executor_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
index 22d4ee86dbedd..3f7f967e3688e 100644
--- a/lib/kunit/executor_test.c
+++ b/lib/kunit/executor_test.c
@@ -129,7 +129,7 @@ static void parse_filter_attr_test(struct kunit *test)
 			GFP_KERNEL);
 	for (j = 0; j < filter_count; j++) {
 		parsed_filters[j] = kunit_next_attr_filter(&filter, &err);
-		KUNIT_ASSERT_EQ_MSG(test, err, 0, "failed to parse filter '%s'", filters[j]);
+		KUNIT_ASSERT_EQ_MSG(test, err, 0, "failed to parse filter from '%s'", filters);
 	}
 
 	KUNIT_EXPECT_STREQ(test, kunit_attr_filter_name(parsed_filters[0]), "speed");
-- 
2.43.0


