Return-Path: <linux-kernel+bounces-117878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C9A88B0B8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7570E1FA764E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382BB41238;
	Mon, 25 Mar 2024 20:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kw+xeenf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C733398B;
	Mon, 25 Mar 2024 20:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711396886; cv=none; b=JHfvZboqsM88V2XWzuWxrPyIQU5kWtNPaDNQibq1T/Ixlm1jHGbo5zDS45pJkMFDwIe8EGsm6RXCEumBWzuO40k3OkqruCX+zYQis+hSNlOU7K/L1aKw9DWWoiSN1jWeyzpXNqA+AT7zXk3HyQl7p51JX4RAaBu63+0Np+wG7Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711396886; c=relaxed/simple;
	bh=RDu+3qkQrCCwfcQEWQKn4nJs8kpWiXDh/iTW0K2LxJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kOicU1pIEzfKnZTE+xqnW1smWiG+siPfLSVo8jd/7Fw9pzFy3tWZ1B3+iojRm6L1Svm3CwLCalAHkKmkvALYTBnuwAlHPXIPvc7zGJ+BKJ5newi2rh078P6y2c6N+s6BiLDVFW8QLuVqz+IbzV+FF7q2QxIBRisPqdDYfdsFNJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kw+xeenf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0E9C433F1;
	Mon, 25 Mar 2024 20:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711396886;
	bh=RDu+3qkQrCCwfcQEWQKn4nJs8kpWiXDh/iTW0K2LxJ4=;
	h=Date:From:To:Cc:Subject:From;
	b=Kw+xeenfF0K7imoo3GDkECAC3ZAd8equPHmCLm5TguelNgMHPLBeOyu/b+ClogqY5
	 AOEWQdIXjGPE0i+thrg4uVg8fE2hSc0qdnOeyeMa8PdJYZJALvQoW2nMioFeq1PBSG
	 bYmcxrHLK6OAEamvNsl3AGd/dykKV18KwP7vyqo7Ahl5s+6W9dmpx7nv0yuC8qbNpw
	 C3c327Kr/0MCSNAng5tNezmrLxRrYti8ch5ysilt+s3fwSVOM02IUTMERikqg1RwR9
	 FcUvxor7Pu461IDzJu0Q2yhKBYpP1Fox64GNFGIM0VuZsVDkb6yqGHOW+TWR2RoMut
	 RqQCNKY7pK0kA==
Date: Mon, 25 Mar 2024 14:01:23 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Tomas Winkler <tomas.winkler@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] mei: Avoid a bunch of -Wflex-array-member-not-at-end
 warnings
Message-ID: <ZgHYE2s5kBGlv1cw@neat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
ready to enable it globally.

After commit 40292383640a ("mei: revamp mei extension header structure layout.")
it seems that flexible-array member `data` in `struct mei_ext_hdr` is no longer
needed. So, remove it and, with that, fix 45 of the following
-Wflex-array-member-not-at-end warnings[1] in drivers/misc/mei/:

drivers/misc/mei/hw.h:280:28: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Link: https://gist.github.com/GustavoARSilva/62dcc235555a6b29b506269edb83da0b [1] 
Link: https://github.com/KSPP/linux/issues/202
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/misc/mei/hw.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/misc/mei/hw.h b/drivers/misc/mei/hw.h
index eb800a07a84b..2e9cf6f4efb6 100644
--- a/drivers/misc/mei/hw.h
+++ b/drivers/misc/mei/hw.h
@@ -247,12 +247,10 @@ enum mei_ext_hdr_type {
  * struct mei_ext_hdr - extend header descriptor (TLV)
  * @type: enum mei_ext_hdr_type
  * @length: length excluding descriptor
- * @data: the extended header payload
  */
 struct mei_ext_hdr {
 	u8 type;
 	u8 length;
-	u8 data[];
 } __packed;
 
 /**
-- 
2.34.1


