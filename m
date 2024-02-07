Return-Path: <linux-kernel+bounces-57141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FC284D46A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B12412843EF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB2B1534F1;
	Wed,  7 Feb 2024 21:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3zst+7S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6594152E07;
	Wed,  7 Feb 2024 21:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341081; cv=none; b=Jbh+F/zYu/GE1eMbzAsrcZG51MXLIwF3ZLf40jCjWp1ig2HjVM+j/SWgPJK8bKIY08sNs5Hqt0xFPaJXDeouzDQxoiBDlw4Plw5bunIQdJkZ2Drly+YN5YJw8GingFqyJ26KjMMFC6ZAM3JSiSVXLh7L03U1whNxfYxtmkzDFD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341081; c=relaxed/simple;
	bh=0m736HT5x3zxAJ7MsSNWQ+HMziYNADUNf1eL8O+UpdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sd63m4AlB/JKKICBR/XXeJ71ywxEZecc4P1UOMag3t9XB/dAf6xcmr/6JWtg6i1wXbsoLefal6R/9lrRDdVwwR+7oxBv8uoupMP9lVju3iHIPBIssfjTjR1nMML5ODHZ2V74mZ2asOTEOrRFaSrNw3igcSu8a5maYKBv/azEI/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3zst+7S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF62C43390;
	Wed,  7 Feb 2024 21:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341081;
	bh=0m736HT5x3zxAJ7MsSNWQ+HMziYNADUNf1eL8O+UpdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z3zst+7SEEDcvaPVNaUnCjdJAn1t3vjHPhdKvtQxaXURN8k3N2lfCQ5ja+EEfcq8z
	 pv+ZydOo8gZ2PVVtBwC/jqfvJB4M10kuGQRk0BcLGJqkHPPNWu4+Va5vYANCDwxKst
	 WnTDL96tH//SLZ2ouJCOrc2ddJUyn6l/I1IFmeOT/W1AFFQmQLkzmr8WMsvHPVDAT6
	 EQK41n79A2th4FypkDdKVU+wYqBEBujchJYgbGRBApF6fEKlUqlRxJ2hopBIpbJCnX
	 M5+KocgEHfrzq8ITf9sKdBcXtuQfcsGYxi8eBKKh2Sec4VNhvhTQbspiTeZ0E5FEP0
	 FxRHib3a+nsEw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 31/38] nvmet-fc: hold reference on hostport match
Date: Wed,  7 Feb 2024 16:23:17 -0500
Message-ID: <20240207212337.2351-31-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212337.2351-1-sashal@kernel.org>
References: <20240207212337.2351-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
Content-Transfer-Encoding: 8bit

From: Daniel Wagner <dwagner@suse.de>

[ Upstream commit ca121a0f7515591dba0eb5532bfa7ace4dc153ce ]

The hostport data structure is shared between the association, this why
we keep track of the users via a refcount. So we should not decrement
the refcount on a match and free the hostport several times.

Reported by KASAN.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index c9ef642313c8..64c26b703860 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1069,8 +1069,6 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 		/* new allocation not needed */
 		kfree(newhost);
 		newhost = match;
-		/* no new allocation - release reference */
-		nvmet_fc_tgtport_put(tgtport);
 	} else {
 		newhost->tgtport = tgtport;
 		newhost->hosthandle = hosthandle;
-- 
2.43.0


