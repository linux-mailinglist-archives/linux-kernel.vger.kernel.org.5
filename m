Return-Path: <linux-kernel+bounces-13241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 068318201CC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 22:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36A5D1C223A2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 21:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FB214A90;
	Fri, 29 Dec 2023 21:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="3gOIgpCN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052FF14292;
	Fri, 29 Dec 2023 21:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703885462;
	bh=h3ANz3W0DslZaQwI4kM53iFECoCiLF7i5w4P/6cAJS8=;
	h=From:To:Cc:Subject:Date:From;
	b=3gOIgpCN0rHmhUVUO1x2NnY6I/4ngpObwu+s2JXdw+Ag6ioDeIyjdvrO/Uk+g24Sq
	 D7Ne+1Ni/VgEbpuKRL05s5UI27ctN3ZkHkPeyWm0iAlwHZ7ytovnXYUueBkoukDqF9
	 UjNMiOP/HVjzYwyncI8WR8sMPsAbOpIz08kRmfrVaazWFSIU22xTHrEe7Yym8yFj2n
	 8mx5y53Iy/5e4FPWcsgN+9YDVEefyQ0LLxiqTW5vhXwLURDC58gwj0FBH/P69XU/7w
	 YwoqaLOCC5jW3B4Dgun60zgg8Bice0jLp0IkvzslrLeytSWfTv9NQqD5card03KGyX
	 ZVcVV3emGe49A==
Received: from localhost.localdomain (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 44A0E3781FD5;
	Fri, 29 Dec 2023 21:30:56 +0000 (UTC)
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
To: Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Hector Yuan <hector.yuan@mediatek.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: cpufreq: Add big CPU supply
Date: Fri, 29 Dec 2023 18:28:39 -0300
Message-ID: <20231229212853.277334-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The performance-controller hardware block on MediaTek SoCs is
responsible for controlling the frequency of the CPUs. As such, it needs
any CPU regulator to have been configured prior to initializing. Add a
phandle in the binding so this dependency can be described.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 .../devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
index d0aecde2b89b..d75b01d04998 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
@@ -33,6 +33,8 @@ properties:
       performance domains.
     const: 1
 
+  big-cpus-supply: true
+
 required:
   - compatible
   - reg
-- 
2.43.0


