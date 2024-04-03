Return-Path: <linux-kernel+bounces-129599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE02896D08
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C3441C270ED
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1120145FF9;
	Wed,  3 Apr 2024 10:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="FMspfFXl"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B0E136674
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 10:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141097; cv=none; b=r22FTSxN58oZUfq6hzKCWx2k3VBapXRovwQzCO8BpfrZKW2c/me3RiQPhEs5GCn+0VqYJx4wSklu6RX0HHNjk0bx9AJK5cV54eu7wHAS9tn5TuZ+bx4n+RTg/xsNsgr/Bq/9NBHgO+lA6xh3D6ecvzfKUNGyLPT/3LZmB/2LSfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141097; c=relaxed/simple;
	bh=Pi0U5AZkjMe4lXemTVOzXIlfpNO/K4FeBDBX8b2DQ5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WYnPp7b+YUHn86nfNdrKJOOyyIVwbAp6WpV28ghi5uccNLcLwpTRxYlIj34wFPI0rvk7W5DJg5UhfriVv0sQbWggKwpHSSD5iVYqdzuIPWmypIVj88m+uRldOf+11DR8v24VWXyjsg/QDThMpzJQkmhWvmu4cpDlpQeRWH07dHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=FMspfFXl; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 7CA2F240106
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 12:44:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
	t=1712141093; bh=Pi0U5AZkjMe4lXemTVOzXIlfpNO/K4FeBDBX8b2DQ5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Autocrypt:OpenPGP:From;
	b=FMspfFXloRJvCUXCstiM7oec7eIyP+Z/4rPGQgJvW7KsMkGZ1yv0vvx9y2+qegAKL
	 bfRluCS7kQXDLfHjSAuexO+W9v74xeR3wD26mQ/q0ZQJEr5znyVqhhjC8DJrJLh0ny
	 iZq08YOOh6d3S4pIoCf6uweaaFYM2Pe5i+tbzCcwh0OUbg3ER+b6HvtdItF5luBpp1
	 f9LpVGuDkJTaR/76/KtfRuFamASeZNf1OHvuseRBHyVnx5ztVdDLnj2ylaeuJYeL5Z
	 ciOGhzZzPFVd7IV7tkovHa7AUqrbBYlEHgwW4WfpKtGl3sJYlz37LGXrSHiipxEata
	 BahZUb7ASS02Q==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4V8hGC75Q5z9rxK;
	Wed,  3 Apr 2024 12:44:51 +0200 (CEST)
From: Alexander Reimelt <alexander.reimelt@posteo.de>
To: andersson@kernel.org,
	pvorel@suse.cz,
	konrad.dybcio@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: arm: qcom: Add LG G4 (h815)
Date: Wed,  3 Apr 2024 10:43:29 +0000
Message-ID: <20240403104415.30636-2-alexander.reimelt@posteo.de>
In-Reply-To: <20240403104415.30636-1-alexander.reimelt@posteo.de>
References: <20240403104415.30636-1-alexander.reimelt@posteo.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Autocrypt: addr=alexander.reimelt@posteo.de;
  keydata=xjMEZg0fSRYJKwYBBAHaRw8BAQdAIcaNTdj3NWDe5HQPCUs6oYyQygAJWP9LCzhr+C7RwMrNG2Fs
  ZXhhbmRlci5yZWltZWx0QHBvc3Rlby5kZcKZBBMWCgBBFiEEM+Wy6sI/mP5S0zIFHqi3OKk8uRIF
  AmYNH0kCGwMFCQWjo9cFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQHqi3OKk8uRJ8ogD9
  EVg4zgfmC2SqXCgms6LETAzVX4CrAS8yMhyd7Md921cA/R8lhm9B96RYgA7MvFPFJb1T6JFY75Jg
  QLXrtIE5llwHzjgEZg0fSRIKKwYBBAGXVQEFAQEHQBGDuxZLOTvppxyM4G18fSR6xzT0xkkPOia7
  Bh6L1vAAAwEIB8J+BBgWCgAmFiEEM+Wy6sI/mP5S0zIFHqi3OKk8uRIFAmYNH0kCGwwFCQWjo9cA
  CgkQHqi3OKk8uRIa1wD8CZDdCAKXstgXY96eeSSP7MecEF5TBdmWOiVgjlEIpoEA/RnGuDaj06B1
  F51wyGAjYXSmn5qFoNHu3yXyLUkFz1ME
OpenPGP: url=https://posteo.de/keys/alexander.reimelt@posteo.de.asc

International variant of the LG G4 from 2015.

Signed-off-by: Alexander Reimelt <alexander.reimelt@posteo.de>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 66beaac60e1d..76aefd4aac67 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -237,6 +237,7 @@ properties:
       - items:
           - enum:
               - lg,bullhead
+              - lg,h815
               - microsoft,talkman
               - xiaomi,libra
           - const: qcom,msm8992
-- 
2.44.0


