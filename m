Return-Path: <linux-kernel+bounces-69697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D221F858D6A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 06:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 111CB1C2111A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 05:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896341CD1D;
	Sat, 17 Feb 2024 05:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="trsTAFym"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56FD1CD0A;
	Sat, 17 Feb 2024 05:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708149313; cv=none; b=nfyvF2Yp0JnpPtRa6gqBZehFlb0D1FKXmKCA0hlXO12O63uB2P4k04p2OlTjVjjEN7EjmvBE9I0YkjorOPafadOMIAthx3NdMDZc3kE+90Iqi1Kpp3pnhy1bZVx5QBf61DzOLsmhmXZ9uzPoct2AU3isp0TP67YzEqexipmlwx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708149313; c=relaxed/simple;
	bh=Ear6O+72d1ABDax2WCP/0I/ogBxwZJuvcTt9vAe3Ybc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WCBQNa3IJwV7FhsDEog9QLm4n6W4fwujxK5Xv0sPC4yVDCyXNzUZThaNoNYk2Gh9Vsr4uBEvMmJCIdcNZOXlmtpVKCM+MrHGxpbZdN9Br4+fqG6bNH8bw0IjQ9PS/Ylqz8i6sM7/6hO62uTiFgKV2vEYaafOn9C1nTvcQqGB9jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=trsTAFym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024FEC433C7;
	Sat, 17 Feb 2024 05:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708149313;
	bh=Ear6O+72d1ABDax2WCP/0I/ogBxwZJuvcTt9vAe3Ybc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=trsTAFymcnJ+cLIqtPon8OGRgd5rGz1eElds51+gjS3vOc3KHa2i3Yl4gaQgF7f4Z
	 6QEGkpHgErBUIBS63eMzVJWS5bYq2sOewfdcV3RkE7vI/IdjxPmoh9uyx6Zdbf4owx
	 AsUq8tmZ4eSSaqetbvAdKJaH3bMoXfocDszFR3TAe6TT6AikDTduADqV6zEOIvrvLf
	 5DnjYUNUjkx2PKHU5EY5uuE3utm5yIAJoSmG3yBrkXdU+fqsAIuTGC9iAhu6aHmUIL
	 6dslWxdFvTf1VgTWeDUmfKOPrWZ8fzNXSklcYlSxwt8ThSrdiI6xYhpsmCucEzdTpX
	 PSvGSmNvmBBwQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] kbuild: change DTC_FLAGS_<basetarget>.o to take the path relative to $(obj)
Date: Sat, 17 Feb 2024 14:55:04 +0900
Message-Id: <20240217055504.2059803-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240217055504.2059803-1-masahiroy@kernel.org>
References: <20240217055504.2059803-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the same rationale as commit 54b8ae66ae1a ("kbuild: change
*FLAGS_<basetarget>.o to take the path relative to $(obj)").

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.lib | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 328c0d77ed48..56f7fe2b476d 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -368,7 +368,7 @@ DTC_FLAGS += -Wnode_name_chars_strict \
 	-Wunique_unit_address
 endif
 
-DTC_FLAGS += $(DTC_FLAGS_$(basetarget))
+DTC_FLAGS += $(DTC_FLAGS_$(target-stem))
 
 # Set -@ if the target is a base DTB that overlay is applied onto
 DTC_FLAGS += $(if $(filter $(patsubst $(obj)/%,%,$@), $(base-dtb-y)), -@)
-- 
2.40.1


