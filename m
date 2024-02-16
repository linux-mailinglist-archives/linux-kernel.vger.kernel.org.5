Return-Path: <linux-kernel+bounces-68134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE6B85764B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DE8BB24592
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD57E20B37;
	Fri, 16 Feb 2024 06:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvbK5G7W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C8920B0E
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 06:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708066476; cv=none; b=FQ14NwA1R52r4zKbEa6lhG1qNtSjtV6Sd3lyoCsrsKGv4W+VUnl4nXdao9NNIM+RNg5n5e+601aoXabvgE3ln1kQeG6pqUOTA9FkHZZ3WfFaShkBCP4dJNaFWaDvWLnQfkILeDNap0kxuViz6ltWxL+kdMrgNoUwdc35UgbSILI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708066476; c=relaxed/simple;
	bh=xZUGSW7pkokV4zLjCnd/mTKR/eQZWFNFZ3+e+td1jik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n7m1Yu4Qf4Iw6UiEQzjyTI2lYcza338ZyoMtRDVJs1c1JpHJHMOMfZ8CwyQx3jjm643Wl98AsabCEOnDTWkz95KbP84csSCJ6IZNACkGCmwSNU/TyiyN0oMPDVlirgRRgqV6WZNJJfS0XNcDJNhgJPknbRmQdPT9SvLNizLo+2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvbK5G7W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B28C43390;
	Fri, 16 Feb 2024 06:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708066475;
	bh=xZUGSW7pkokV4zLjCnd/mTKR/eQZWFNFZ3+e+td1jik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bvbK5G7WtJpIv0+P1LBfllzinl78UnS7HDCkgrkAygGGKuAR/29I82hegp9YHjajH
	 Cv8tWzg5QpvUoZnq320Qk1pz2MrsXgsvoJ6I/Nfb3jIhVUdhbHuAyU0rYcZVokHmUU
	 bsrcuCtwJbUabfZDKwDbYAgHHcBciD58mAuwUrhP8ZefsvoBmecQzDzFP4YY+pUlmo
	 kNHUDzI4my+B9ziMkXSVZB/xu5UJ9g9w+omKiX7cqFuy4EKX5iuMu3DKTMg1x3dMBe
	 SV0Qxg64gnQKK0SqxBKXQg26s3ZetKrwOMWRHEeQCrpvyNHYAg8EHb6fFaTQ3G1lmb
	 pG3wpv4WdY1rw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: jani.nikula@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH 20/21] drm/i915: remove i915_vma::obj_hash
Date: Fri, 16 Feb 2024 07:53:25 +0100
Message-ID: <20240216065326.6910-21-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240216065326.6910-1-jirislaby@kernel.org>
References: <20240216065326.6910-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

i915_vma::obj_hash was never used since its addition in commit
4ff4b44cbb70 (drm/i915: Store a direct lookup from object handle to
vma). Drop it.

Found by https://github.com/jirislaby/clang-struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org
---
 drivers/gpu/drm/i915/i915_vma_types.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_vma_types.h b/drivers/gpu/drm/i915/i915_vma_types.h
index 64472b7f0e77..559de74d0b11 100644
--- a/drivers/gpu/drm/i915/i915_vma_types.h
+++ b/drivers/gpu/drm/i915/i915_vma_types.h
@@ -290,7 +290,6 @@ struct i915_vma {
 
 	struct list_head obj_link; /* Link in the object's VMA list */
 	struct rb_node obj_node;
-	struct hlist_node obj_hash;
 
 	/** This vma's place in the eviction list */
 	struct list_head evict_link;
-- 
2.43.1


