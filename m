Return-Path: <linux-kernel+bounces-133693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA6C89A771
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 00:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B38801F21C42
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 22:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0647733080;
	Fri,  5 Apr 2024 22:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlVY4DMo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435662E65B;
	Fri,  5 Apr 2024 22:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712357773; cv=none; b=k/OKHavaHAhzluuJH6nOFwSJBiJGDvEkQG7HKJ5LexjS4wvwRN2RwSR7vndu0/ASh6Hc4yvd5fWghJmPXLJzMOxQKKiFZs1/Be1vpwQCe8g0R/aD7OglbfkJWMirAcqr2MWw2GxsPCQplcDYKPjZlRM15XlspivYNCKeKziPE18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712357773; c=relaxed/simple;
	bh=TDecBVGR8Z84vprI1AU7jHqlNMUvpmFqe8+A+uJNij8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RujP46ip75in0di5Wl3MjLccJfuoyaXD13WRp2vJ5nTj92KbSd+pp5VoPwQqio8RYNt2vNO+4EEaNal7tdaf3oExnE5RgapgzBBVpsuxI41rIyulFT+YiO3zA5daKSwELdFBhnKAdEhEOhZLahZ6dfOMHOF69uK8ttDVI+IyiZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlVY4DMo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92392C433C7;
	Fri,  5 Apr 2024 22:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712357772;
	bh=TDecBVGR8Z84vprI1AU7jHqlNMUvpmFqe8+A+uJNij8=;
	h=From:Subject:Date:To:Cc:From;
	b=AlVY4DMoO99H/b4tjpKMrQGNVIai9E0Y4ewseG5Pn+u2BN6Q+u2iX8bhjAF311aJW
	 L2ScV0ahVEX19cyoMsYUmhQgd+v6Jf1Sk+q+1gql1YympTk/8logkRdWcH6Mcwueed
	 Sdjx9oxh3LKK/0DMgndYRlN+DYuPSvd4EKX1tBcVla/LwgmmOFi98LCMFIBEKRT4KY
	 6oI8uUYolLDfGAC80w25R3ihJqP7nTf3YkqEHccD5AnXkBOi8K0G+ZzC36xD5Sq+X2
	 RG6hGit71O4vfhifx9hu04E9pfrAQ3jGw519XhZIlYsxMr4CItPoCBLNTQeEigKYDe
	 ieOjRBm8omWvQ==
From: Rob Herring <robh@kernel.org>
Subject: [PATCH v2 0/3] dt-bindings: kbuild: Rework build rules and
 dependencies
Date: Fri, 05 Apr 2024 17:56:00 -0500
Message-Id: <20240405-dt-kbuild-rework-v2-0-3a035caee357@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAICBEGYC/x3MTQ5AMBBA4avIrE3SVCu4iliUDiYEmfpLxN01l
 t/ivQcCCVOAKnlA6OTA6xKh0wS60S0DIfto0EobZZRFv+PUHjx7FLpWmbDPbO7aolTeWIjZJtT
 z/S/r5n0/USj9dmIAAAA=
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
X-Mailer: b4 0.13-dev

This series reworks the DT binding build rules and dependencies. It 
fixes a problem with if_changed_rule Masahiro reported some time back[1] 
and improves the dependency handling for the DT validation targets.

Relative to v1, I've dropped all but 1 one of the top-level targets 
added in v1. The only top-level target added it for building the 
processed schema used by multiple targets.

Rob

v1: https://lore.kernel.org/all/20220824203934.2855320-1-robh@kernel.org/

[1] https://lore.kernel.org/all/20220817152027.16928-1-masahiroy@kernel.org/

Signed-off-by: Rob Herring <robh@kernel.org>
---
Rob Herring (3):
      dt-bindings: kbuild: Simplify examples target patsubst
      dt-bindings: kbuild: Split targets out to separate rules
      dt-bindings: kbuild: Add separate target/dependency for processed-schema.json

 Documentation/devicetree/bindings/Makefile | 34 ++++++++++++++++++------------
 Makefile                                   | 24 ++++++++++-----------
 scripts/Makefile.lib                       |  2 +-
 3 files changed, 33 insertions(+), 27 deletions(-)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240405-dt-kbuild-rework-f356ab890d45

Best regards,
-- 
Rob Herring <robh@kernel.org>


