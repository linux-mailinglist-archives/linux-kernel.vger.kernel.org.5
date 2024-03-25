Return-Path: <linux-kernel+bounces-116739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8811988A333
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 426002E216C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1198C170EA4;
	Mon, 25 Mar 2024 10:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dBaMxLRU"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172B915B971
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711357906; cv=none; b=L9AkZHu3ajwVz8OWt38Vkz2Jpcjtdyb6KleHp6RhKTjHzpQPCJD3aVetq2OM6XIH2J3dE/GG0rvfp9wcYcHV0D3+UU8UokVZmpTGB3bujbtEyiqfm/vPQ6ZtMh3swRhG4ZnV/1V66TXxFztqvznpI/wDS24djHIzpsoyxj2dnxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711357906; c=relaxed/simple;
	bh=3IyQ0IHUZedUd4BUZemr8PwrT1edFjZ7/8DR77OpHPo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JniBBv70nD/sc2BjMyx/6RTWZKHV9FWGNeOnlDmL19c4bGn11GE9x23pg4HTE1g+CY8TCUCWNO8cX4znJzH2XhUCZ1GcfpG83v9Mbh68pU3sT2J5NAuMbFV6jcgwP20eBd3/zVZSEmmF7HcREWhdjbSopydPnvyLx5HOuo8jTic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dBaMxLRU; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-515a68d45faso1362098e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 02:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711357903; x=1711962703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RoF9SKtcQIDNK7kNazTEQf3Z7HNt40P18vhcuuLiprE=;
        b=dBaMxLRUhAxqUsFozVzhlMzEUymdFHCE/FgMhvC4G/aoNxZG6EiLmIDh0LZ6XH3mH9
         d+nr3RZESJtW2oz6tWOM5yI9kAkRzI7uzvZgZQgz3tEL0UNnS542KzIRg8Tdqgc/IHHU
         Phzvi+C//lYWijy45XIEfk162SpfIPfG/8HncoJNk+XCC92yxxXu4WrNTIfyiiK6lXcn
         ynLXu4xz5CyB67Vd17uEzrZkEgjlVbi5Ob04WUa9p4/VUBi9nD2cHrMQgL+v5HTejmUS
         9qLiJSW3hpTXYIBmlEZHw0RaREjqRLd5HJfa5tlAhfnfB5bSDzyYJ1NjSv+vikY1UnTY
         KUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711357903; x=1711962703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RoF9SKtcQIDNK7kNazTEQf3Z7HNt40P18vhcuuLiprE=;
        b=ZtRKk7xzfxGRjvDJsSQZTGRhqy7fLPgfYzn7Z8ktF+sDiP9+awrQNUjeVoaiu1E9w+
         DT4ijjpf7WPaciJ2RRUPksGoxxwUxrl8KJCgVO/wv2hXYPNlHmLToDn829pNQj+F/5Lx
         bPboEdt+rqPhgeUGMzXywzw9fpAFbYZH67/vENosjqXOKOso94Q/PR1HBNoH/mlaADYd
         xzshYYmSi2bdmu9vB7msrm+tFT2Qcwd1MO/XFf0RhZd/NDkGi9Prq+gcqSwBhaBG/crP
         pvjZiBsd/H8tzFKc0CHrKB/bojjS7NA22mDy1WkB0tuy4seloqTws96WNPxb2gTaP7I3
         NoEA==
X-Forwarded-Encrypted: i=1; AJvYcCXcau1ZEg5zHav8NefbqpZ2qEnrkgwPudHm2XLOLZJ7y5yBfntfOCGHCKixXoSw8tswQvR1gFJCsILBT8bG0iJ7BKPHr94Lw54CbzuT
X-Gm-Message-State: AOJu0Yx4CqLOTiaMBuBK5QnknrKUOYjI0/93UEMookTysPGFyxPhnh2T
	QZUcaJtO0rAQbjDxSvNxjRGJhzeLIh9SqHxGwH8J/JstZ43n6hNsSTgUWQI3c6k=
X-Google-Smtp-Source: AGHT+IEyPfn3dgbloCj+TwQHEGcc6B6s6dmgZhFHmd8I5jGWzU+1BzuI3rvwBpuZn9wcIqv58h4rqg==
X-Received: by 2002:ac2:4643:0:b0:513:4705:a4f3 with SMTP id s3-20020ac24643000000b005134705a4f3mr4317389lfo.65.1711357903118;
        Mon, 25 Mar 2024 02:11:43 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id t15-20020a5d690f000000b0033e95bf4796sm8947000wru.27.2024.03.25.02.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 02:11:42 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH] docs: dt-bindings: add missing address/size-cells to example
Date: Mon, 25 Mar 2024 10:11:39 +0100
Message-Id: <20240325091139.18602-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Complete the example of recommended order of properties by adding
missing address/size-cells.  They are not necessary to illustrate the
style, but lack of them us bit really correct DTS code which might
confuse readers.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 Documentation/devicetree/bindings/dts-coding-style.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/dts-coding-style.rst b/Documentation/devicetree/bindings/dts-coding-style.rst
index a9bdd2b59dca..8a68331075a0 100644
--- a/Documentation/devicetree/bindings/dts-coding-style.rst
+++ b/Documentation/devicetree/bindings/dts-coding-style.rst
@@ -144,6 +144,8 @@ Example::
 		#dma-cells = <1>;
 		clocks = <&clock_controller 0>, <&clock_controller 1>;
 		clock-names = "bus", "host";
+		#address-cells = <1>;
+		#size-cells = <1>;
 		vendor,custom-property = <2>;
 		status = "disabled";
 
-- 
2.34.1


