Return-Path: <linux-kernel+bounces-60455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF636850529
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60FD92835B2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98D55C5FF;
	Sat, 10 Feb 2024 16:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="2QQ17jfR"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DC0364BF;
	Sat, 10 Feb 2024 16:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707582597; cv=none; b=NSg69TkyuiawWTaMj9Uu8VfNMGn4/+krh8ZW+puER5LmzEgi0mZIrFuOW28S8ukcyrxu5C/7AIMs5qsrPv18kYjNH5ndXvMJReFfxfOyl7+cSrFKh3oj/5RAniTpsZXK8wz3AzRd+ii520fUhtgDUsm9rXzPo8aiaZhQYQhBQSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707582597; c=relaxed/simple;
	bh=IAULVgXcV4yTsqI0dDqXRkB38uG90/GIQjySUkSdNXE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QeDYcnX3/3Pyd4kZf6f1BiZ9n85zYEhatldZOiaUiglDb6hDDfUR5LySXiTp431LWeBILYvswoiAqxXQoJ5U+MVli0+PbG+WL19d4ullakE8sgsqmvrdsKpK1L+PK2d6g47HIbAOZossF7s9CHmylgzsUvEMfytUFnu2BrqlEh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=2QQ17jfR; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1707582593; bh=IAULVgXcV4yTsqI0dDqXRkB38uG90/GIQjySUkSdNXE=;
	h=From:Subject:Date:To:Cc;
	b=2QQ17jfRjSQ0Iz642llM+UfhJ8aEGsfQra26tPgH1kckvweFW1qdMhWwPJTSxH6Ly
	 45Cc4EaIsbAqQKl+cbJ6TbBWVzL/kvcbfDt7eIIdt78dKPGkqcig5aFOUxHG5O41vE
	 ckot9xTKCmyEi0Sh+2/+9hy5u9KV/vhyxJnEkKBA=
From: Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH v2 0/3] Bring up more CPU cores on MSM8226
Date: Sat, 10 Feb 2024 17:28:51 +0100
Message-Id: <20240210-msm8226-cpu-v2-0-5d9cb4c35204@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEOkx2UC/23MOw7CMBBF0a1EUzPIHqPIomIfKAWOBzJFPrITK
 x9575jUlPdJ7xwQOQhHuFcHBE4SZRxK0KWCtnsNH0bxpYEUGU3KYB97S1RjOy1olXbsHHtrayi
 PKfBb1lN7NqU7ifMYthNP+rf+d5JGhV5btsbclDP02M0wL9d126HJOX8BoVrXw6YAAAA=
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>, 
 =?utf-8?q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>, 
 Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1163; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=IAULVgXcV4yTsqI0dDqXRkB38uG90/GIQjySUkSdNXE=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlx6R5r8qe5fRNeseT6VBwQWvB6o/YvJKhNCeDV
 ZhKYmDF2XCJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZcekeQAKCRBy2EO4nU3X
 VsINEADLvZDpcJ4FCpORafNmljwjN4fhw5Dl7ASHPW/XDozABDtZrfyVFLpDQwAjCDg9fmQ0mzJ
 GPJd5ZJxyUhl9gjKo3JC705jYUEYbhGaBrMpm+nyHbTE+eU14fBG9NaraXdtchYrCv/4N4ntVWO
 Dl8FixbJ5KjxlchD2pB+7KyvOqKpf6rlTKiYOA1nR062xP7D/3dATG+VeeBWZ0Ey+h6ZJ40BoT2
 b1FWRWhm0f0AxPSerz+yg9ZhCQyxvkjPdx06pSuLlPDOs4QI4Blx0usIXp01QEMyWKr5L2EJ4o1
 FO+PUvuZpLyIcV6IyHQIdsls10CAQnguTKk9J13TAz3U2T7ThVKyUNwUV6+lD8Kx4ecgLmbO74e
 LVwGUg2bHWgwFaMaFjDOgnFfjdrBNG15XgVCdwSY2ELbA6eCcuBtXpf+CWtq/eYIPyu+9o7b0+G
 pN4BOQA0pFLa3YG+1hE7b5ojeWrqTw0fUo5hZJcajdJ24AYjwbSbzmlNeuKpAo4e2BVQq0CupEe
 yT+xL5xULGRfgLROjjw4WNdj2nMkL/ysXeJHeqjftQw/SSgQEsD1E8XO9p0rTxYbuegF4+bw0BY
 yq0uRXuwKxxGCPpBLB1Tcel0KOx9VdRFJLrTYrY+zx1uQf2lyweoy7JK+LUX57nGJ96S73FRVUg
 DG3+3idf67XeegQ==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Add some nodes to bring up SMP on msm8226 SoC. Another commit to fix the
sorting of the nodes is also included since the ordering is currently a
bit all over the place.

The bindings patch depends on the following series:
https://lore.kernel.org/linux-arm-msm/20240102-saw2-spm-regulator-v7-0-0472ec237f49@linaro.org/

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes in v2:
- Add saw_l2 node with bindings
- Rebase on linux-next
- Pick up tags
- Link to v1: https://lore.kernel.org/r/20231203-msm8226-cpu-v1-0-d18e83340b32@z3ntu.xyz

---
Ivaylo Ivanov (1):
      ARM: dts: qcom: msm8226: Add CPU and SAW/ACC nodes

Luca Weiss (1):
      dt-bindings: soc: qcom: qcom,saw2: add msm8226 l2 compatible

Matti Lehtimäki (1):
      ARM: dts: qcom: msm8226: Sort and clean up nodes

 .../devicetree/bindings/soc/qcom/qcom,saw2.yaml    |   1 +
 arch/arm/boot/dts/qcom/qcom-msm8226.dtsi           | 756 ++++++++++++---------
 2 files changed, 427 insertions(+), 330 deletions(-)
---
base-commit: b9fed7419cce45b97bc3217f07920751a6ff9a18
change-id: 20231203-msm8226-cpu-801bebbed886

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>


