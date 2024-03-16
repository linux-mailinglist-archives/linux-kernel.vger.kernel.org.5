Return-Path: <linux-kernel+bounces-105101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A8987D91D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 08:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 710271C21165
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 07:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51638168AB;
	Sat, 16 Mar 2024 07:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzHvVfZD"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4535A1429B;
	Sat, 16 Mar 2024 07:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710573168; cv=none; b=ZVY9AEoNKvw1sFoI/ML8lG+Y8vp2Q2+xWHpTy7Q2B1sleO0OD949LbtHQQh4cj9BHF68U4LHATGZtpvvCpxds+BE6ZSbKjYMF/bUOmOCYL8wzykKQpuO8sB2VS8rfj+taEraNVYzaZHF5R6lhMsWVI2+NTsgq5hHtZJWLXgPfZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710573168; c=relaxed/simple;
	bh=Ek6dyKj8WW1L3vP81KbqdCF+pb4i+hUZKKzEqkEtix0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ow4z/NK2T9GnpCx62IoV1Ad82ZaRzgtqm65srkvNXQn9sOa2q/+q95xExzuu1+jzeHi5vJwiVBs2fvDcwN4ceikXsjEjHYisbUCgdssqo+iYhj/nRrU+mS7+PTqSzFKiG3emFEC+GntQLDT4C9JR6yqgpyrkWotNMlrGyx/t8Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzHvVfZD; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e6082eab17so2556564b3a.1;
        Sat, 16 Mar 2024 00:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710573166; x=1711177966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbRqb26QfAthS3CJVq90TpB3Bg3AO5IdQEZJltedfdA=;
        b=AzHvVfZDnxomLjAtprgD6gmZi9nvCRnjoEqnjZlFGkGxKHTCtHbYkcus88sHW9Zt0x
         sIgTKZetNgWsJKIYxHYpRhE8Mc3trSnESMHyOuaPto481UkSGgV3zdctnnERXRZpoh87
         /bRpwUf4QH/wIvLQNfk/fW5k/CS4Z9jhScIFy9qY8JFG50HDydjwoEwaceGvGPpNMOjk
         7crp+5qfJQZLFT/6cuf2a4sy5fh8qumFXZgU9azfydrKBTuMfKeGYhVX6qQZrwiKoAl8
         NFOdFF1qY7UxZe6P+Mq9E69/H61B57HiSZzn0s81rKYatxlib6+qBPuftvtekMLp5auR
         gjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710573166; x=1711177966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xbRqb26QfAthS3CJVq90TpB3Bg3AO5IdQEZJltedfdA=;
        b=Krq2L15w+yibaybs3gPCHVb/+7ETQHKyBHCGucxjjPRaNX2jBZroOLzeFOL4llMsdE
         ROOZrFqmyCoL1QtF/SYS0MnIF2LLN1tjm7+JPwjn85dqc0rO1N6M5AZCdEaFS0JLMy8c
         QprYq4lMg++lLi3eLCUUnwqEeT8DUvDBzD17QMGoXJdmH1ejZWqZ6oAEyDv0lZxKGC41
         QdMFDTFhv5W+halYb6hJ9q9Kh/vRfAe9nKNx5xzBjcGgctnewpsHavV03SMqkfbMiQnb
         EE9azQN+3yzIjyRK0MzTuZa3NDDzYdOdgmavFvkmEio+kTLXKavPmZ2p9Eoza9Aci/18
         Xrng==
X-Forwarded-Encrypted: i=1; AJvYcCV4pnVVsMzerAkvJ3xgb6roNCVScweI1FT6d3msCercpSYDKWiAHQqPDVlZiOZQ2e1xbSv/GpxGDyOb6CXivcMLcJ61WSOfGYU6HkBaxIbU1VKJD0Q2RrXMAFl+/fB1MBByDyxVvSIDQGg=
X-Gm-Message-State: AOJu0YzBq8HFjrkvKWDkkfie4Om0zlfbjSTuFMZMh04jGVRlMNQjfXec
	pvc1qhlPkKA9DDWaCzdjf6nSKtwbOGS3guPP2mT7jAN0vyKn3+7yRdptyK72WDtT8g==
X-Google-Smtp-Source: AGHT+IF92osGMjBCD+MCHjDpfd5vqx22XGS+49u2F24YM0gP/VESBebJfFcTUfO83t7VsmWelMNYrQ==
X-Received: by 2002:a05:6a00:9a4:b0:6e6:98e4:99a1 with SMTP id u36-20020a056a0009a400b006e698e499a1mr8212531pfg.14.1710573166168;
        Sat, 16 Mar 2024 00:12:46 -0700 (PDT)
Received: from localhost.localdomain ([221.220.133.103])
        by smtp.gmail.com with ESMTPSA id x18-20020aa784d2000000b006e5a915a9e7sm4574651pfn.10.2024.03.16.00.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 00:12:45 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Cc: robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	ezequiel@vanguardiasur.com.ar,
	p.zabel@pengutronix.de,
	mchehab@kernel.org,
	liujianfeng1994@gmail.com,
	sfr@canb.auug.org.au
Subject: [PATCH v4 2/2] dt-bindings: media: rockchip-vpu: Add rk3588 vdpu121 compatible string
Date: Sat, 16 Mar 2024 15:11:00 +0800
Message-Id: <20240316071100.2419369-3-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240316071100.2419369-1-liujianfeng1994@gmail.com>
References: <20240316071100.2419369-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Hantro G1 VPU compatible string for RK3588.
RK3588 has the same Hantro G1 ip as RK3568, which are both
known as VDPU121 in TRM of RK3568 and RK3588.

Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
---
 Documentation/devicetree/bindings/media/rockchip-vpu.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
index c57e1f488..4f667db91 100644
--- a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
+++ b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
@@ -31,6 +31,9 @@ properties:
       - items:
           - const: rockchip,rk3228-vpu
           - const: rockchip,rk3399-vpu
+      - items:
+          - const: rockchip,rk3588-vdpu121
+          - const: rockchip,rk3568-vpu

   reg:
     maxItems: 1
--
2.34.1


