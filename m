Return-Path: <linux-kernel+bounces-160643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6194F8B4087
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E4D828A24B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4BC2260A;
	Fri, 26 Apr 2024 19:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiTFUqjJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7FA27711;
	Fri, 26 Apr 2024 19:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714161288; cv=none; b=sQd0UccGWXbH0mGZMoHf28A969HPoTqbSIZm4t5nnSc0u39sECHKK8VvcXdc5M55eTf6iq62N05qODOarF311hnznxCIZGEhBw4iI3ij42LZuT5geP5O36qb1xFckV6BIwwjdxZkohMYm3eue5zlt6czHiJ3ZyD5XekEO/QSDBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714161288; c=relaxed/simple;
	bh=DUfvjJb+PNqMl9axV8GlnzUcU+ktIjRBtm2wSJZLRDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EW4d+h3ytkE6RoK+sIuagvsCSbZcgBI+Pt76QiWR/on7DUUPUiAv4NNjw00CL2ZwBxQb//+Gfz4NhXelvRQmZgk8IC/5T0jUTp9Y+eRzYJRbAWccghMB//0Rk2acX5BPqwsRmR87qnVTeAk9xLVenyOiQrlYaV7im+89IvU/2yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiTFUqjJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E35BC113CD;
	Fri, 26 Apr 2024 19:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714161287;
	bh=DUfvjJb+PNqMl9axV8GlnzUcU+ktIjRBtm2wSJZLRDI=;
	h=From:To:Cc:Subject:Date:From;
	b=QiTFUqjJV3VETjvj3fMyEviluO0LJTqE1B9c5OpwXeXr4MwwbLjgU4mEG2kEh9jG3
	 ALwF//fFD91NsanvkIMj08JL2TNcwZF1b22mIZ/Bv7+FCYrvpQ2Oa/7iU+fTwiA1H2
	 mg/VIj+XDLUZa+GVfoMndzJw9QRLq4pClMhS9ZROIYuspF8JjhXh2GJx/Q8NQ58MF7
	 w+19LwgNO2E7BbDuVMFesgMgxPGcw6d92T4vM9/lV3GAXwYAynMnTLVrsGHcqfnNPu
	 2fOg60xk2nWsSjxidBL1++qTVFevHiveopO96ipfBxnz5pwUNevJp7bpz6n2vi8mKX
	 xN6MokUkEnwEw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] yamllint: Drop excluding quoted values with ',' from checks
Date: Fri, 26 Apr 2024 14:54:37 -0500
Message-ID: <20240426195438.2771968-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Herring <robh@kernel.org>

Strings with commas were excluded from checks because yamllint had false
positives for flow style maps and sequences which need quotes when
values contain commas. This issue has been fixed as of the 1.34 release,
so drop the work-around.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/.yamllint | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/.yamllint b/Documentation/devicetree/bindings/.yamllint
index 358c88813937..fadbc6ad3c76 100644
--- a/Documentation/devicetree/bindings/.yamllint
+++ b/Documentation/devicetree/bindings/.yamllint
@@ -7,7 +7,7 @@ rules:
   quoted-strings:
     required: only-when-needed
     extra-allowed:
-      - '[$^,[]'
+      - '[$^[]'
       - '^/$'
   line-length:
     # 80 chars should be enough, but don't fail if a line is longer
-- 
2.43.0


