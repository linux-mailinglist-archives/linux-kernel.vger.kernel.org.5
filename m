Return-Path: <linux-kernel+bounces-63422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1917B852F0C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA79C288717
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449F33D99C;
	Tue, 13 Feb 2024 11:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjs7tBKu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C3B3D396;
	Tue, 13 Feb 2024 11:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707823273; cv=none; b=pGro2MuPC7BXCXr7lpTdTyflJKR6WrIxZgZYoh40hq8bHyodo8SNz83id9vyuPQWlMsCK/WqQGKmm/F7fptp3281DkoQavyPXwsWzpIUeKdQEfQRJW3HOMF3knNlGDJyNP5Rbx52oUFDRDZXiAE/WUUaXhPRKASlknNJCA1UIzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707823273; c=relaxed/simple;
	bh=yVDWfsoh7FqeJLjlF1skb90Df8JXvSB4mHHDi6A6xM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lb4tgSJ4iDhsm7IJ18JVaNmo9TADT/LGYz4kB1x828ifDmzsIMB+gETFl0GqlDnoa/GMcZzw9puOZmzYlxnWKL+vqwGdSMWkxj7mh/m2FgTUIiqOtYbcRW4j+c0r552TfQ+ZFrbjGYFjbDSKjdqd9eiyjTTj7CbZyDKmHPIfUYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjs7tBKu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA9DC433B2;
	Tue, 13 Feb 2024 11:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707823273;
	bh=yVDWfsoh7FqeJLjlF1skb90Df8JXvSB4mHHDi6A6xM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gjs7tBKuDgfum3MxGR5V2wxKJK1HqZ5TJ4mTsreDWpzs7YMfOVhnRb8fbYn88zVIV
	 PEM67j4uV03Og1q1VJWDdHdWsC54pINnR94Y96VRF/4oQIHzLOn68jqGaCvKIHaDzJ
	 CtzuQn8iYJ+IV0Rou2jE7eFdkgP/WoCrBsoSRojjacOjf7dzlncKrUCCcrhE1WDznS
	 cfPK4Df3PJafoJnKyNP8KQLClxSdj2og7hXzYuMWOWcglPH++pNIEuNLyj1yCJrsWg
	 fFI/7Dh7yxNwVF3xf1ahVe5zQ1bX9tjtC1RDxk/qTBJkLu25nkSbru8CR8dkCE9lS1
	 Uewfb6NAkZNsQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: bp@alien8.de
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	linux-edac@vger.kernel.org
Subject: [PATCH 5/7] EDAC: Remove edac_pci_ctl_info::edac_subsys
Date: Tue, 13 Feb 2024 12:20:49 +0100
Message-ID: <20240213112051.27715-6-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240213112051.27715-1-jirislaby@kernel.org>
References: <20240213112051.27715-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was never used since its addition in commit 91b99041c1d5
(drivers/edac: updated PCI monitoring). Drop it.

Found by https://github.com/jirislaby/clang-struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: James Morse <james.morse@arm.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Robert Richter <rric@kernel.org>
Cc: linux-edac@vger.kernel.org
---
 drivers/edac/edac_pci.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/edac/edac_pci.h b/drivers/edac/edac_pci.h
index 5175f5724cfa..4159a3ef0dbf 100644
--- a/drivers/edac/edac_pci.h
+++ b/drivers/edac/edac_pci.h
@@ -48,8 +48,6 @@ struct edac_pci_ctl_info {
 
 	int pci_idx;
 
-	struct bus_type *edac_subsys;	/* pointer to subsystem */
-
 	/* the internal state of this controller instance */
 	int op_state;
 	/* work struct for this instance */
-- 
2.43.1


