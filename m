Return-Path: <linux-kernel+bounces-105142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1080A87D99F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 10:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FCF21C21144
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 09:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4ACA14AB8;
	Sat, 16 Mar 2024 09:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q4ykPHFH"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DD612B79
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 09:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710582288; cv=none; b=eLZecgWLYkLiq6+Mw6N1taIv1P3mT9Pe5LdxRwgVMyNLhIb8X5TOrLj/dZIfhQmphrrHEFT8behjwDYqVO94WYcIid7YA4XAaJKJyeV6hay5hhkvFI9ZKX4U03wi8RQ2X3bHj8jFt03QO4AdTCmjivvNRovAuA3slziEqWI6BlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710582288; c=relaxed/simple;
	bh=3bDlKy2nzAl5JOkcvkmJwxyf1GS0vVOX5MatiJK86Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VSzlUG8HBXEuTtOr1ts4h4RURl8hCMUEp7hjKSQ2mvnrRO0EsM+y+TMI7qGUPC0jHfdLYa+nDqJ8QZhdK4gha1iUMXPiKZPxK+8ny/S8brjuIXdWoU0MkWsUnT/YBNBcdWD9yw/l/0kghZNJ0mjxqA+0Gzx7oT0aedYLg0we3Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q4ykPHFH; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33ed5b6bf59so713602f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 02:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710582284; x=1711187084; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eZiaMvkrAIYRvQGhX/VCrACQexpce25p/Aogx0gSR78=;
        b=Q4ykPHFH9k5MWBa7RqVIsFBBhRJ9b0KbGGiVwyhlKIqPoZ8PySluHXRVxAtjMFl4U1
         Epa46E0AoTIbtNSznQW2fgGv5lBVWg2PbOyh4UZIltxgsSEZ9CxXusM/dzxe8tVH/DOR
         F5IAeN1e2ssvZQl/SkIFkKjmQcl2iNaVT4sWNZ/oaWahjfqPCJ91PP5Ol0aVKWAnyxbO
         77iwvaLiygB0acqEwkT4YJlGM9bx7daDkKSWv9lf7ObrLWJdpHY7sxPW+0U0xw4stMMj
         hvBRGueIqiRmJkdRyS/fVgssroIp+sd5nfRS2OjWAmxHXZBPlyD5Eq50dWKQ/ybbnD51
         uSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710582284; x=1711187084;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eZiaMvkrAIYRvQGhX/VCrACQexpce25p/Aogx0gSR78=;
        b=dlnTnP9DTABnEAP69+UcJdOcr2r3KEyN5dCRZQteTByxL5aaZAUVRoBpG8YKrfxSFl
         bnzrEOfHx0nAx/p/UDVQFZkXHCKgGuJwexJ4hWywhOp45vnm+ZNHpaBPap0DrQv1VkA5
         3k6m40s5QM1q7G1Fid1ZluQC91B0ZZYEIXaabb5zBS/KdUth1V/5cPpCnfXKCBF0rzM4
         YaRv/i64Z7tqbzZeDqapKuc1ZlK342BfUK0KDZzMYioyS+eFZhswkH4hZ0br6gSbpGEu
         09K1PGvSnR+FD5jd+Kyf5y5TZI7kIx8XZzuiwUyFoYRtVYAxFKQXFx1wLZkK6w7E2Uls
         5TSA==
X-Forwarded-Encrypted: i=1; AJvYcCX02ZRJ7Ii3oD9nGbEMx/HfraTyyf5ScVnq8Won768Cfe44+IelVA3pTK8hN6899hVccRwMZ8UahoO+CtSMkBpPAlnZEL8fVPwJAaO1
X-Gm-Message-State: AOJu0YwlzDLH/NFq0CVPx6/6uRPHgP5hKZmSPzvdOZb4fGJTjH+bRXHt
	Ql8n/AmzFKVxc7x70FpcxuwhmOVPnFS1P4fyBilI4RI+IRG188nySVwfsBp8Jf8=
X-Google-Smtp-Source: AGHT+IFOW1q6txMH9F3aIQBkLScKJhp062IvZBzvTzICyAWp7NA/r2UF046gqnjt7+cVDSSe9CEKdA==
X-Received: by 2002:a5d:47ac:0:b0:33e:d865:41f with SMTP id 12-20020a5d47ac000000b0033ed865041fmr1595984wrb.35.1710582284437;
        Sat, 16 Mar 2024 02:44:44 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ay19-20020a5d6f13000000b0033e2291fbc0sm5157397wrb.68.2024.03.16.02.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 02:44:44 -0700 (PDT)
Date: Sat, 16 Mar 2024 12:44:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net] ice: Fix freeing uninitialized pointers
Message-ID: <77145930-e3df-4e77-a22d-04851cf3a426@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Automatically cleaned up pointers need to be initialized before exiting
their scope.  In this case, they need to be initialized to NULL before
any return statement.

Fixes: 90f821d72e11 ("ice: avoid unnecessary devm_ usage")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/intel/ice/ice_common.c  | 4 ++--
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 4d8111aeb0ff..4b27d2bc2912 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1002,8 +1002,8 @@ static void ice_get_itr_intrl_gran(struct ice_hw *hw)
  */
 int ice_init_hw(struct ice_hw *hw)
 {
-	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree);
-	void *mac_buf __free(kfree);
+	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree) = NULL;
+	void *mac_buf __free(kfree) = NULL;
 	u16 mac_buf_len;
 	int status;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 255a9c8151b4..78b833b3e1d7 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -941,11 +941,11 @@ static u64 ice_loopback_test(struct net_device *netdev)
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 	struct ice_vsi *orig_vsi = np->vsi, *test_vsi;
 	struct ice_pf *pf = orig_vsi->back;
+	u8 *tx_frame __free(kfree) = NULL;
 	u8 broadcast[ETH_ALEN], ret = 0;
 	int num_frames, valid_frames;
 	struct ice_tx_ring *tx_ring;
 	struct ice_rx_ring *rx_ring;
-	u8 *tx_frame __free(kfree);
 	int i;
 
 	netdev_info(netdev, "loopback test\n");
-- 
2.43.0


