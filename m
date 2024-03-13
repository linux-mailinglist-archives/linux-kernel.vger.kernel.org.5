Return-Path: <linux-kernel+bounces-101754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBD187AB4C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF0531F231DB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A017B5D465;
	Wed, 13 Mar 2024 16:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuJ/sdI7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF76A4CE09;
	Wed, 13 Mar 2024 16:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347578; cv=none; b=kL8VyoCkn02YAjue+5lOK1k3IXRjDjmhiX+NOEOxeZRRieCSkZVXmUeSOqXECU8iqUkLRK4zNv7D0ZosNOjwRGyXdeIPEJ0rg3EqBk6tV8C2BGwXx3KlS2pHTtpREJXR3QJVy0kXbZp9OBS2+ymMP/M7QXZSRx8TX1p+8idH3FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347578; c=relaxed/simple;
	bh=WrKmOiZB7xxVRnCnneu1fDs8CnTQYWSyPmlU31A6yd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b5dhIbm9JU6zxZWXlf/4WShtYPSyXWSRBWI1EPwwaXgWz5pslhQckjm88kWue5z+7mZu6+5sfkhigQp6TlQlPqaFhhkljfyoSVyKL7B7DXl7RIzM49Jb8utMPNXHOys0xpEUw7nqKQwTtyc6l766xH0v4DwWUjSTroae07RZ570=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuJ/sdI7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778AAC433C7;
	Wed, 13 Mar 2024 16:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347577;
	bh=WrKmOiZB7xxVRnCnneu1fDs8CnTQYWSyPmlU31A6yd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UuJ/sdI7f68rf0oXfoAk8tlGPJt1GwG/QN0/BdDUao/w2hkTq0dlbsYG8UG803Vew
	 jDPf1qpf7JnVqruu+oH+HvxDT4y/LeIqSfnXRj2/Leg8txaeMw3MC4c09tx3Y4QN66
	 rjMNRDIxBG8rh3Hwt0MBsdMNMTWGt2VzB/bIrDFFNKyLW0GGLPDTU3oR6wGmdB01jn
	 zk58DdSqvptKkqDKPE0KjEJdOyM5WicZmtgad6jpKqlBnEN/BzS/OlMDFLKMhexwcR
	 W4vmQacwSph9pRa+CvupNS0GcysxbCnrm2aI6o/4PqUoDFxBZhSC4nf39X6LphEcOw
	 h31uUwutFBBjw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 15/61] ice: reconfig host after changing MSI-X on VF
Date: Wed, 13 Mar 2024 12:31:50 -0400
Message-ID: <20240313163236.613880-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163236.613880-1-sashal@kernel.org>
References: <20240313163236.613880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.7.10-rc1
X-KernelTest-Deadline: 2024-03-15T16:32+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

[ Upstream commit 4035c72dc1ba81a96f94de84dfd5409056c1d9c9 ]

During VSI reconfiguration filters and VSI config which is set in
ice_vf_init_host_cfg() are lost. Recall the host configuration function
to restore them.

Without this config VF on which MSI-X amount was changed might had a
connection problems.

Fixes: 4d38cb44bd32 ("ice: manage VFs MSI-X using resource tracking")
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index c4caa9df473b5..cd61928700211 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -1074,6 +1074,7 @@ int ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int msix_vec_count)
 	struct ice_pf *pf = pci_get_drvdata(pdev);
 	u16 prev_msix, prev_queues, queues;
 	bool needs_rebuild = false;
+	struct ice_vsi *vsi;
 	struct ice_vf *vf;
 	int id;
 
@@ -1108,6 +1109,10 @@ int ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int msix_vec_count)
 	if (!vf)
 		return -ENOENT;
 
+	vsi = ice_get_vf_vsi(vf);
+	if (!vsi)
+		return -ENOENT;
+
 	prev_msix = vf->num_msix;
 	prev_queues = vf->num_vf_qs;
 
@@ -1128,7 +1133,7 @@ int ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int msix_vec_count)
 	if (vf->first_vector_idx < 0)
 		goto unroll;
 
-	if (ice_vf_reconfig_vsi(vf)) {
+	if (ice_vf_reconfig_vsi(vf) || ice_vf_init_host_cfg(vf, vsi)) {
 		/* Try to rebuild with previous values */
 		needs_rebuild = true;
 		goto unroll;
@@ -1154,8 +1159,10 @@ int ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int msix_vec_count)
 	if (vf->first_vector_idx < 0)
 		return -EINVAL;
 
-	if (needs_rebuild)
+	if (needs_rebuild) {
 		ice_vf_reconfig_vsi(vf);
+		ice_vf_init_host_cfg(vf, vsi);
+	}
 
 	ice_ena_vf_mappings(vf);
 	ice_put_vf(vf);
-- 
2.43.0


