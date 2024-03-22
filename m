Return-Path: <linux-kernel+bounces-110960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0FA88664D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D91A5282DBF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 05:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE076BA5E;
	Fri, 22 Mar 2024 05:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHLL1jRP"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E05A15BB;
	Fri, 22 Mar 2024 05:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711085866; cv=none; b=m6Sn8H26FrKTqpUiOdiV1BZkT7yxdaVDHVdYp10tCXtDwX+nigJWiYYfYzyQB9yreRATy8VeJr/vrBOvFOnXUsCr2VhIo/b20VZ4tG5cJt0+9PcGNu0y0lR6rZTQIH170/2dxUfpbhRwi5RX5hI+oSaDKA/uYglqKkbWGnxeaPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711085866; c=relaxed/simple;
	bh=MWGc29WSPBB/IpnV1FyWJ0ZHvlcHfhVPz2mwglSK5lg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fK1DycvOw/3v4tIdho+d6+Fny4PwIBL2yuRapoSaphaocImmppw8oAZ9drIWjOR5yBv8bxXdLY6nTh2gTgyyRhBUT3FEPKXkbKXPizjSNz7rT9HM6MZ2Z8hI7HbWS8C2ViuN6SLMhGdr1zJtAcjC3KH6X6PXL/QS2RtmcFnEyHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHLL1jRP; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-789e209544eso104494785a.0;
        Thu, 21 Mar 2024 22:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711085862; x=1711690662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bF5xw9X6amOuhqITJZtEhEpaZ8akuZjX7z9t1wAP4CI=;
        b=DHLL1jRP64uWmEAeycEJGXzpVbXAp9TXvluytcYsXBvoGwVOqU4epMw1OEwqswZX4E
         2/LTVLkL5GE+ZWRm4ZdUP5QOG/OmcPif67VHOf2dWfnnSkvkP8IeRBfoc7Vp1H/P30mP
         UqKDaeavqTG7oUGGmSZm21yoI+s7+J21ytzPOBePveH/nzFIZkdEemhqFowvwLOoE1HN
         gijs+h460DMC0i+AO9ejcqW7EMJIcKIv4SfVleKvNBUyuSXDXgsGRRQEfo1FT84FfSLy
         Oq5oTHEzzKJVHhW2on1WhED1G0+C7qw+Bu/SHAKge6KqKwz1ThJQbWLEuCF43Bhp8a9V
         S8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711085862; x=1711690662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bF5xw9X6amOuhqITJZtEhEpaZ8akuZjX7z9t1wAP4CI=;
        b=JSuoyPljjvw61+oP+gIxkDnsES/2vUjV96yNXpDeGCw8R8vOtjrAepFsGqxIZGuiNB
         kdLzMrQudgqAFvCMohhvpslTgOhWlaHIxofHcqKYDUXQGCGpm+MNv4tCDPmWm/tfIpsO
         uIseHZ9dDJisYnaqml7HdfnISf/dRTAKDBqOgH+OMPmMyfZKPm6E0eYri+komioHWjdD
         uJHVrcBW3T2QPu3J3qlqbLqNu714lkh3G9lXevpo641acd30ye2bgw0Y059/womFiaQh
         WRB/AgeczsrwqGw99BDPVCk1Mi/mVw+YFVBPN19sD633UggXk2GCXdFiippVcvJser6n
         8Ebw==
X-Forwarded-Encrypted: i=1; AJvYcCXKE9mf5ZPIuoGFhBKU84NzxOpKObrxdUXpLWrbHo5xTBxxTkEGGp/iBKjC5yHguDNimr/5z4rOvViOvBz8OHYn6gaf/svN892fen52Is5MGgZu88lRAr+RKTzWe1AC+xwV0v0IIo32rac=
X-Gm-Message-State: AOJu0Yzn2K5Pk+2C9k5sOd950ZO67y+OWyeZdcyoi9pECXX568UOI3IL
	cE2DvfChDXK8aac/foXHla/ftwgz9MVhKYC9vIftPGjkuDgrWI/twjQVytiJdfLMVA==
X-Google-Smtp-Source: AGHT+IGxMakEwV87bA32ET778M6bt37FiWJX59Li7fZ2bCXT0Apviw7VPVvoELjZWzEV4kvaYuJ36Q==
X-Received: by 2002:a05:6a21:1f1e:b0:1a3:4204:2529 with SMTP id ry30-20020a056a211f1e00b001a342042529mr1519681pzb.31.1711085383582;
        Thu, 21 Mar 2024 22:29:43 -0700 (PDT)
Received: from localhost.localdomain ([221.220.133.103])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902d38500b001dffa622527sm882978pld.225.2024.03.21.22.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 22:29:43 -0700 (PDT)
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
	jacob-chen@iotwrt.com,
	ezequiel@vanguardiasur.com.ar,
	mchehab@kernel.org,
	liujianfeng1994@gmail.com,
	sfr@canb.auug.org.au
Subject: [PATCH v1 1/2] dt-bindings: media: rockchip-rga: add rockchip,rk3588-rga
Date: Fri, 22 Mar 2024 13:29:14 +0800
Message-Id: <20240322052915.3507937-2-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322052915.3507937-1-liujianfeng1994@gmail.com>
References: <20240322052915.3507937-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new compatible for the rk3588 Rockchip SoC, which also features an
RGA, which is called RGA2 in the TRM Part2. It is the same core as used
on the rk3288 and rk3568, which documents the same RGA2.

Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
---
 Documentation/devicetree/bindings/media/rockchip-rga.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/rockchip-rga.yaml b/Documentation/devicetree/bindings/media/rockchip-rga.yaml
index ea2342222..ac17cda65 100644
--- a/Documentation/devicetree/bindings/media/rockchip-rga.yaml
+++ b/Documentation/devicetree/bindings/media/rockchip-rga.yaml
@@ -24,6 +24,7 @@ properties:
           - enum:
               - rockchip,rk3228-rga
               - rockchip,rk3568-rga
+              - rockchip,rk3588-rga
           - const: rockchip,rk3288-rga
 
   reg:
-- 
2.34.1


