Return-Path: <linux-kernel+bounces-104811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A94A487D409
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FF601F22DCE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A158548F9;
	Fri, 15 Mar 2024 18:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtJUAOvl"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E0E548F6;
	Fri, 15 Mar 2024 18:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710528613; cv=none; b=ESdkobAArooBmXS+Js2wtg6MiH+BB5XCtKPlUXS31aAhMUhayIc8UMQcXkpr8tHci9k0LsHIfnvGdF1TppNXak+3BdmPG1hzsOqLnXiSRIk7ETzeegZZBEDsdy80WfVy+h6KrnfdZh3t0xUrvpuy1vUXT0w3XemsP3n4qR2Qbpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710528613; c=relaxed/simple;
	bh=X40rdRwUf9bLrHuqxsbNliRJdwH1yE24R61jLiII9UA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fl2tlcMuWG/zeKqR1sV6zvEqfI/JGH9iPXI54/0VEY6bgEosgNeMUNZJT0+QGYq9Ad5vjaJHbOMxpVBd8EHs/GwulkM+Ul487M9V9BwOaAiNRGfLQJev4BEfpj/TF90WYnLXZBy63ChCSVQAiWsjONndVayv5J83Xk/Y+y1yczk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtJUAOvl; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e6bee809b8so2326030b3a.1;
        Fri, 15 Mar 2024 11:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710528611; x=1711133411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nbbG9YmsxAe8ShcpMeSH39B4N2p7H9qd49dYIKblRo=;
        b=UtJUAOvlnnsf8jdMiX36ZMVX7cBJSCUsRCNShWSi1S4KvTb9wFYeUVKZoaRcpzShYk
         QTfGUQN952XQ/1nWyJNwbwGzEObyVNKNwtwuwe0/7WNhqgoz8LqM8elZuw/hXNQ1hrhA
         K+AlQDx2W2vTlgXloZpnbrsoVXxVXJ/vCoR+ZUiiNprNB33WFqUzWG0iyMR8UMfuy7QN
         CUCsN/z8cHgF7s2Gq9KpFVGEtNOaQ2BPar8uWuWvnU9LVLcIssbBNzqH2wMIZkNfe4sg
         w7Ys74369NiNvv2SSHZaBOxFb+xc/0ddsL3tHa8gc/9o3Fdd3DniFsXc+0Ybb+1bq0av
         XZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710528611; x=1711133411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1nbbG9YmsxAe8ShcpMeSH39B4N2p7H9qd49dYIKblRo=;
        b=uvH2y4/Z750h6JhZ12sQoZftFYc8PKkMAylRNWAPQQawepEHNqpnjPytdeubi+K2Tt
         5388KzEu3Mzhxf/RUIJqqub5ZDurF4B/eh5qPex7uwmcB0lnXuyNX8uUw3u7I21xW8JT
         cjm8nwqyMrj/JlLBDPaAjkgkVAMfhLrZzvYi/PniBq5TGDyHwtkodP+8k5urrReNE6hU
         l+ze4ZzVx0QkzI8HMoNRAv4qXtFiOqUOW+cKE+JKvg4p1GV91rQL326PQKg/DXFPrXn9
         aBXIWWvq19cLxin6lyd76eXA+PNr1mBO/y8XAEt88xTbXGu4fTUDiXf8lDfBGHiub2JA
         MPUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD42ICHiB4xQrkKmI6lLn+zTMUzRHSceWzW2qTCscXMPybwqbgdHgkXlKOL1P7/elMvS8NrOYWBaTPR02vGDFqLQ0lqG5TwTtF/O7iM2vcVwqrsq5+/+DO71/b0y8iVr9tg0DUuY8WUMGuABIfVlUEQaTSk4JIDZChIiELALObXC3uyg==
X-Gm-Message-State: AOJu0YxZ2BBg2TTKUVc1dWNKrUlDpof2ZwOVCTfWWsrHEQ3RfbgIRIs+
	WebW3DSf1yw80MG3MY2tSG/8EncA8nnjHKfOXokHtVpopjpoHkswMQoD16jP8x97oQ==
X-Google-Smtp-Source: AGHT+IFA9XzN2jLwuRUEijbwT8pIPy83qqcaER/RU0ti3qY2ElIKDW3ox6g28Xxuwh3Y/MTEOyOcvg==
X-Received: by 2002:a05:6a20:1450:b0:1a1:4808:7c95 with SMTP id a16-20020a056a20145000b001a148087c95mr5266375pzi.37.1710528610773;
        Fri, 15 Mar 2024 11:50:10 -0700 (PDT)
Received: from toolbox.iitism.net ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id f17-20020a056a0022d100b006e6cc998be8sm3580784pfj.207.2024.03.15.11.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 11:50:10 -0700 (PDT)
From: Ayush Singh <ayushdevel1325@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Ayush Singh <ayushdevel1325@gmail.com>,
	jkridner@beagleboard.org,
	robertcnelson@beagleboard.org,
	Vaishnav M A <vaishnav@beagleboard.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	greybus-dev@lists.linaro.org
Subject: [PATCH v3 5/8] regulator: fixed-helper: export regulator_register_always_on
Date: Sat, 16 Mar 2024 00:19:03 +0530
Message-ID: <20240315184908.500352-6-ayushdevel1325@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240315184908.500352-1-ayushdevel1325@gmail.com>
References: <20240315184908.500352-1-ayushdevel1325@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Export regulator_register_always_on() to allow use in kernel modules

Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
---
 drivers/regulator/fixed-helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/fixed-helper.c b/drivers/regulator/fixed-helper.c
index 2d5a42b2b3d8..0e9784009c07 100644
--- a/drivers/regulator/fixed-helper.c
+++ b/drivers/regulator/fixed-helper.c
@@ -59,3 +59,4 @@ struct platform_device *regulator_register_always_on(int id, const char *name,
 
 	return &data->pdev;
 }
+EXPORT_SYMBOL_GPL(regulator_register_always_on);
-- 
2.44.0


