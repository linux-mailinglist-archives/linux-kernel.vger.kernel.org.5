Return-Path: <linux-kernel+bounces-139784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 012C88A07AC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0FA028B51C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2323013C9CA;
	Thu, 11 Apr 2024 05:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="XWf9ThjO"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A18513C80B;
	Thu, 11 Apr 2024 05:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712813115; cv=none; b=kjruu9T03/tjx0oKFMO3K6zISVjnthFqIxcqNnahLF4YNUoXTU/cC9E8KgVnqBf3XNkdND7jCpCfgCi+hLXCQxTUY1M10OUzE04ab6EKLxTKpBHl+7UZn0q1ud5osGwUcOa92zXofi5qbqGkRYfRjNzYKm/0lmrmybTu+BQlHQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712813115; c=relaxed/simple;
	bh=rx7VU7OZ9RYF318nPChdrZeFDynbG6XEw2MFcC9CHDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6rt97JpOc4qP191tRxSFf8RvNsB6Y9k05N7WRPo4bYBiVdAdxfpgTSsS6naSS98ceqlTfY+97ULRWnrzDWAdVRRAYKfVDvQ2lkc3AGgARUQG9Mu8z+1yGcu1IRxjIhwIW8qKnIOG/uz27fcrUCLM8FnN9+08QQXJR3fV6eabXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=XWf9ThjO; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=/afKR5/fKc2eaS0a7AFeI0Fj4yViHtiLGjC2UUKT/pA=; t=1712813112;
	x=1713245112; b=XWf9ThjObYynZU8Q2lO5K3jhjIAxgaUoEoKCZW+MDVwrM51HxjYzOjBUJskI5
	r9hHRqRxdyRbVXmWNRmSu1DnPCBhbyRmL3JJw26KjIHoyXIVpEBvuDZi1u0HVPWKak2GI0igfjk1F
	Km51MuQU2u3EVxD6simLzBTxokcEXA/2wTNNPBh44MXU5SopuXWxPnjtLyhyDoQoTiiFNcIzjdgS7
	r5zXO+QixEfJoNvrsmtSycfQoFwImsRx10L5PvCnC5pBVGaNSYnX8ic8oRGppYs9gWCoc23squzLb
	Q+XTDq7qKxRusLDiF1kfF2ggnuMkp/tyWeut7E5vzMz5DQOCpw==;
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1rumvr-0000rh-M6; Thu, 11 Apr 2024 07:25:07 +0200
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	stable@vger.kernel.org,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/4] docs: stable-kernel-rules: call mainline by its name and change example
Date: Thu, 11 Apr 2024 07:25:05 +0200
Message-ID: <ec5dff37a62681beb74f89f8fcde41b6618152f0.1712812895.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712812895.git.linux@leemhuis.info>
References: <cover.1712812895.git.linux@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1712813112;8245af4a;
X-HE-SMSGID: 1rumvr-0000rh-M6

Fine-tuning:

* s/Linus' tree/Linux mainline/, as mainline is the term used elsewhere
  in the document.

* Provide a better example for the 'delayed backporting' case.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/process/stable-kernel-rules.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
index ebd57cb9277f7b..3c05f39858c78a 100644
--- a/Documentation/process/stable-kernel-rules.rst
+++ b/Documentation/process/stable-kernel-rules.rst
@@ -6,7 +6,7 @@ Everything you ever wanted to know about Linux -stable releases
 Rules on what kind of patches are accepted, and which ones are not, into the
 "-stable" tree:
 
- - It or an equivalent fix must already exist in Linus' tree (upstream).
+ - It or an equivalent fix must already exist in Linux mainline (upstream).
  - It must be obviously correct and tested.
  - It cannot be bigger than 100 lines, with context.
  - It must follow the
@@ -127,7 +127,7 @@ comment to pass arbitrary or predefined notes:
 
    .. code-block:: none
 
-     Cc: <stable@vger.kernel.org> # after 4 weeks in mainline
+     Cc: <stable@vger.kernel.org> # after 6 weeks in a stable mainline release
 
  * Point out known problems:
 
-- 
2.44.0


