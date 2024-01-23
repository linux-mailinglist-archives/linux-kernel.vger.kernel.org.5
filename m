Return-Path: <linux-kernel+bounces-35577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B22E83938B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF0511F2A683
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584A762A08;
	Tue, 23 Jan 2024 15:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fI2B7tbe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E2A60263
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024431; cv=none; b=b8k0x7epXb9vDHlgb3N+PY97ZZl9CkSh5ALG7fq/dybFqW8xq3om7b5KCmtlAz+fwZCDryg9EHUyHUYDawfy4QzDPRSa99RC8Toh7eeXD/DV0IQtjACXLL8YWUNUchFO76fhjOldx7UsNAMrvNm4w/4SR8sv41qwpF+eCIMIG8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024431; c=relaxed/simple;
	bh=xomYPaRSCJ17SFHQpi42vpCKL2kFTiH6LcE2pydaTNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RQn2Gj9+z2uc2+N/T5Xkme9jKaTmgtslrGDHCJSo3vLfqmfCrFiZk8siECGHpz8S17m71SBCqEVp7U/bLdbKsa9suwvvxHgeFa6j4MZbGlpVP2+XB2k++fdPKQEOSaiTlMRaXR1j8hJ+im+6dlIzV2A4n1EiH+PdNpHC3xGdSmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fI2B7tbe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8400C433C7;
	Tue, 23 Jan 2024 15:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706024430;
	bh=xomYPaRSCJ17SFHQpi42vpCKL2kFTiH6LcE2pydaTNY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=fI2B7tbevQiY4Kb/UkiDt7ymq7wWm00jflqq3B62ydvJx9RRyixXhjHqkK7RMLpf/
	 di8A+wlgTcbHeC7MHiQvnYrWoiZb68iqRC1bPUV4OFeOal3hay1YCkTpaj/Oqplr0D
	 VLlasYfl1Z/snOz6/Ratx/ExzYGDkajUm5T2DTcZPw3wIEwnZsE2F80DnsvxuFf/bK
	 db5nKZK0O4tkN0uVf4Yodvjs9KuifgrwQj38IsPg/d19gdjn0AEgchUeZOucthrZC8
	 B9os6RxnyeMc+hxvTofg/xwkZm9D2H+FG6VSoZkzjyQLl+3urgTXMRZksR1eutcv0Q
	 HbfSuSUjVFz9w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18A2C47258;
	Tue, 23 Jan 2024 15:40:30 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 23 Jan 2024 16:40:23 +0100
Subject: [PATCH RESEND RFC] driver: core: don't queue device links removal
 for dt overlays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240123-fix-device-links-overlays-v1-1-9e4f6acaab6c@analog.com>
X-B4-Tracking: v=1; b=H4sIAObdr2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQyNj3bTMCt0UoMLkVN2czLzsYt38stSinMTKYl1TEyOjVANj40QDyyQ
 loP6ColSgYrDZ0UpBrsGufi4KQW7OSrG1tQCNgijYdwAAAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706024429; l=4328;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=JVOSn21OvtpDUkPOC5fF8puS0bgK3Rufn2sGa79Madg=;
 b=cfODMPRpL5pVgH6gCwrcVuOzf9hR9c2ZnI52FZAG+HavO68Un6vPiv87iNTZsl81JzVaQTyUi
 fKkWyAvmDM7Ds5gFXS3ylvbYDGtrMwq6oP9l6UhMUZ3uCoVhclfhgGP
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Nuno Sa <nuno.sa@analog.com>

For device links, releasing the supplier/consumer devices references
happens asynchronously in device_link_release_fn(). Hence, the possible
release of an of_node is also asynchronous. If these nodes were added
through overlays we have a problem because this does not respect the
devicetree overlays assumptions that when a changeset is
being removed in __of_changeset_entry_destroy(), it must hold the last
reference to that node. Due to the async nature of device links that
cannot be guaranteed.

Given the above, in case one of the link consumer/supplier is part of
an overlay node we call directly device_link_release_fn() instead of
queueing it. Yes, it might take some significant time for
device_link_release_fn() to complete because of synchronize_srcu() but
we would need to, anyways, wait for all OF references to be released if
we want to respect overlays assumptions.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
This RFC is a follow up of a previous one that I sent to the devicetree
folks [1]. It got rejected because it was not really fixing the root
cause of the issue (which I do agree). Please see the link where I
fully explain what the issue is.

I did also some git blaming and did saw that commit
80dd33cf72d1 ("drivers: base: Fix device link removal") introduced
queue_work() as we could be releasing the last device reference and hence
sleeping which is against SRCU callback requirements. However, that same
commit is now making use of synchronize_srcu() which may take
significant time (and I think that's the reason for the work item?).

However, given the dt overlays requirements, I'm not seeing any
reason to not be able to run device_link_release_fn() synchronously if we
detect an OVERLAY node is being released. I mean, even if we come up
(and I did some experiments in this regard) with some async mechanism to
release the OF nodes refcounts, we still need a synchronization point
somewhere.

Anyways, I would like to have some feedback on how acceptable would this
be or what else could I do so we can have a "clean" dt overlay removal.

I'm also including dt folks so they can give some comments on the new
device_node_overlay_removal() function. My goal is to try to detect when an
overlay is being removed (maybe we could even have an explicit flag for
it?) and only directly call device_link_release_fn() in that case.

[1]: https://lore.kernel.org/linux-devicetree/20230511151047.1779841-1-nuno.sa@analog.com/
---
 drivers/base/core.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 14d46af40f9a..31ea001f6142 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -497,6 +497,18 @@ static struct attribute *devlink_attrs[] = {
 };
 ATTRIBUTE_GROUPS(devlink);
 
+static bool device_node_overlay_removal(struct device *dev)
+{
+	if (!dev_of_node(dev))
+		return false;
+	if (!of_node_check_flag(dev->of_node, OF_DETACHED))
+		return false;
+	if (!of_node_check_flag(dev->of_node, OF_OVERLAY))
+		return false;
+
+	return true;
+}
+
 static void device_link_release_fn(struct work_struct *work)
 {
 	struct device_link *link = container_of(work, struct device_link, rm_work);
@@ -532,8 +544,19 @@ static void devlink_dev_release(struct device *dev)
 	 * synchronization in device_link_release_fn() and if the consumer or
 	 * supplier devices get deleted when it runs, so put it into the "long"
 	 * workqueue.
+	 *
+	 * However, if any of the supplier, consumer nodes is being removed
+	 * through overlay removal, the expectation in
+	 * __of_changeset_entry_destroy() is for the node 'kref' to be 1 which
+	 * cannot be guaranteed with the async nature of
+	 * device_link_release_fn(). Hence, do it synchronously for the overlay
+	 * case.
 	 */
-	queue_work(system_long_wq, &link->rm_work);
+	if (device_node_overlay_removal(link->consumer) ||
+	    device_node_overlay_removal(link->supplier))
+		device_link_release_fn(&link->rm_work);
+	else
+		queue_work(system_long_wq, &link->rm_work);
 }
 
 static struct class devlink_class = {

---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240123-fix-device-links-overlays-5422e033a09b
--

Thanks!
- Nuno Sá


