Return-Path: <linux-kernel+bounces-89869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD3986F6BB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 20:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B415281B1D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 19:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DA979DAB;
	Sun,  3 Mar 2024 19:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnHyqoXf"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642597605D;
	Sun,  3 Mar 2024 19:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709493656; cv=none; b=puHx5vFD1WaqFHJzFXBh2epYWsC2wpcw/RVKq0HZIGIBW8diIwCXTHA+fb1zBE5bs+uwJ4ceEI6IqzIjSQSOVqdiToPmMXvwhnjrOb19A12ipG5pK6T/iY26N7JS1He7sVB62cLVOcB8OCq1VB+O7Kylp8bimiHxUMn0ZX+PyQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709493656; c=relaxed/simple;
	bh=q19qy03OqV1sYE/Cd6Ro7zu5hMUu18O2FfzTZl9cEB8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RwbCNet3yyl0pJGEHI19QZZnoZh1cGzFvLGOhxQ46Mr2engvJmPraCxKNwIcNyAK/fPUTUl/JBt+3UP1nmCvEeHM3+6YhN1NRi2tgfilVaymu0Tey448X/ncQ3MI/ZSI/jQgsTgDZ79HbvXPt24SYhGxNVqOImy5VhpgrBorTn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnHyqoXf; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d269b2ff48so42223151fa.3;
        Sun, 03 Mar 2024 11:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709493652; x=1710098452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rZADT8Xzso2kMaQmTmzt66RpPyIczD7PKHVuaIw0k74=;
        b=RnHyqoXfQ8kvrUm406dh2G3WVbB332NL1koEPebuuQB2L3OBtLWI6SKFan5ne18kuZ
         jKWIZadtibLHR637GLhInou174grbMprVduTiX9CfCV0j+keen/wirsF6Jt63+3othIx
         Oa2PoUnKDjAa0ZlDT78H3NxDEIfNYnLOg1HG9DJgwAjPK07oWS+v9mQ9DNJeRbFN5CBo
         ODGv9HuzPlzXtFFh9DszUi85cNiSZMl3LM1OI3tZa7PaJq0UoJbAlWRJXkHNeBFr9DXS
         6y13ap5Jat1ebT4VzEXmyEcLeLTEA2vsjakcExSfiVQ1sifLPLGcpOBnJuFCI2ndna0B
         uFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709493652; x=1710098452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rZADT8Xzso2kMaQmTmzt66RpPyIczD7PKHVuaIw0k74=;
        b=ByDlskXq5lGc7RACPUWG6mw/ot63F5iaSNQIuzxQ5PwH2J0apY7TgoilNKLZA/dfie
         32djxdSJYXyZVmz+5M6HcmCNA0yvdK2w+ScszkA4K3txd6zU9bs1u0C79/YtAYZiaI0E
         99S+QaTKH4mMgL8Z19faxlrPM2ItmpDKQkoA/vemgY9ApPtIOmcfSJS4hWa4D1jNghlp
         pVdmXc6WP5D5hBkW7848uIJYUKBh2sS8XBlFUJXCXO+SZDfIitpMOFpN0efmdhGVjmB2
         495z1e1e8RSVm0i5fo+3XsRotf3g+Bb9lheJgahytaRMDM61gOK+1kFCEdcAQFytuZ4w
         gCKA==
X-Forwarded-Encrypted: i=1; AJvYcCUGxmLlJEAtLakwtTwGFAPpDukrhFTyl5LUqCgy6fmAtDpvrJ8eOgI9tggi/thjjFwJYTaRGQh5yUEPE37uQ+d6FMNNfclv1V4AkbyElBbguHg/rrHxM30UjTGlhb9kPnxfgNrW9dVsXdM=
X-Gm-Message-State: AOJu0Yx6Jo3S7mT7gcpV7hjnTuKmqc6gbu6ui0QXdhpqiwYikPk6LhC5
	/oZQeWmJgv75BY1rgiRavV5L12iKh1S2dSgJwZ82ttJTm/YxJL6K
X-Google-Smtp-Source: AGHT+IFaRQCUN34EwaoDCNtYgQgn2C2N7m/q35LNxEAYuhgraGSJL5V239YFxz5M40XaQeNYvy+UEw==
X-Received: by 2002:a2e:7a12:0:b0:2d2:ca55:be46 with SMTP id v18-20020a2e7a12000000b002d2ca55be46mr4753304ljc.34.1709493652209;
        Sun, 03 Mar 2024 11:20:52 -0800 (PST)
Received: from localhost.localdomain (c83-255-24-248.bredband.tele2.se. [83.255.24.248])
        by smtp.googlemail.com with ESMTPSA id y10-20020a2e9d4a000000b002d3c466adc7sm68438ljj.15.2024.03.03.11.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 11:20:51 -0800 (PST)
From: Jonathan Bergh <bergh.jonathan@gmail.com>
To: mchehab@kernel.org
Cc: mcgrof@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH 0/9] staging: media: av7110: These patches address various code style and formatting issues in the av7110 driver
Date: Sun,  3 Mar 2024 20:20:31 +0100
Message-Id: <20240303192040.8116-1-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following patches fix a number of code style issues identified by
checkpatch in the av7110 driver.

Jonathan Bergh (9):
  staging: media: av7110: Fix formatting problem where trailing statements
    should be on a new line
  staging: media: av7110: Remove braces for single line statement blocks
  staging: media: av7110: Remove spaces between function name and
    opening parenthesis
  staging: media: av7110: Fix formatting of pointers to meet coding
    style guidelines
  staging: media: av7110: Fix block comments to meet code style
    guidelines
  staging: media: av7110: Remove extra whitespace before opening '['s
  staging: media: av7110: Remove extra whitespace before ','
  staging: media: av7110: Ensure whitespace ahead of opening brace '{'
  staging: media: av7110: Ensure newline after variable declarations

 drivers/staging/media/av7110/sp8870.c | 136 +++++++++++++-------------
 1 file changed, 70 insertions(+), 66 deletions(-)

-- 
2.40.1


