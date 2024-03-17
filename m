Return-Path: <linux-kernel+bounces-105323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D60A87DC3C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 03:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 374AE1C20B76
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 02:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA7E8C05;
	Sun, 17 Mar 2024 02:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cpp-in.20230601.gappssmtp.com header.i=@cpp-in.20230601.gappssmtp.com header.b="m4W0rfQY"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154D879C4
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 02:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710641093; cv=none; b=aWFXJ6TynxWqdF7EeflL3sepVq2nhK/W/rVJYWB2XaCHqc25un001cTsGCwJW2wqJjJMcdx6VBJWcOLk3Dcp/CHT8kBrPdVjKwfxgk04gzfNY0jjD4glkZPxQr2P7WC715cSYX12eE5D4xegXsuxF3bqDVuj2jbHbJ/PtH2HxEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710641093; c=relaxed/simple;
	bh=aCT0vUa9iGG4jg2bvIm4ZCdWt/b43G+VBuROresZ9VA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=KCoBdb6Hst5gsq7Q2kLpyfHG9eRGgE1x2gA5LVmK+HEVyYa63PtNtSviIWeAh/PDj2Qg3ZKY5fgwfhiAFaVsxk5dzm20MUSnAnDR5/fADUap0K1x45snrI9gq0IhrZ643N03jb3i4qWiH8t8hS/Ojv2on5c3y9T9T4TrVlL9LyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cpp.in; spf=none smtp.mailfrom=cpp.in; dkim=pass (2048-bit key) header.d=cpp-in.20230601.gappssmtp.com header.i=@cpp-in.20230601.gappssmtp.com header.b=m4W0rfQY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cpp.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cpp.in
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dc3b4b9b62so22238945ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 19:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cpp-in.20230601.gappssmtp.com; s=20230601; t=1710641090; x=1711245890; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWtXa4epYbJQbXxdWpC2jiOsOGSFUbjYRhlCuBfpHew=;
        b=m4W0rfQY9orveLLiPnFycdorxiTPY/5TLey1SEPo68ocpSSIasMVoFfbq5qT9DZH3L
         pISO1ebjO/rvPF/z7MU+riD3+2qdbfsoZNZ612ttCcZl09zlK/d14ZIQIyySBFNr5dkt
         ipjpidONNzKO8xw39jG0Vh2pjxttuIFkhSKJmUT3annGg+otQEnZNyuP9Pzeur32V0Fw
         ptQj3DcbNWnkefdzfb+5AavE4z63l2CaBhHs8dWTKSHMBRoMO796tiuCm7lagVhxt81V
         GIX8ips2rZiJ7ZOarBPCfjFp9MJgeYVbBx5L6AAw3SlIZ8tQymi8N7AtegS061PFHBxz
         vDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710641090; x=1711245890;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IWtXa4epYbJQbXxdWpC2jiOsOGSFUbjYRhlCuBfpHew=;
        b=ZR397onqc7kP2V4LPRa3jIDh7DUbbCaY85DCQgK/phPPAdpj218U+wzAAbhpoSCyD4
         llTKQQ+CyB8499bPCQvo+GdpG63ax5MjAOCP7rBk+cqoR99jpggdMUFvvpCNeiL4LHKR
         EzaipfbuWAlrZ4O5TL51wyKXNBtgRLI2Q/3Er536cWC/AQ5OD9Q2Q0EjD4QonwHfh9mH
         fcRvl2edn4UVzxIgtp7hJe7lQPaDVBX2HGXGD0JfcyO/PNNOOAp0tb8T0YupZjPF1A4q
         G/cl8DJqRRTyOtl3xZp7LQR/TFZHjx5aX20Q8MyvMABBfaR3ek7k4ihdGmxGEmK12wMy
         UiXA==
X-Forwarded-Encrypted: i=1; AJvYcCWKIHa2FuunoYQPwqYIbRJgep9fTL1MzWyB9Lrez4mDTabDdCwxa2i1eDAFZXupcY5QmdB3v5RTzRl5GEFuZBTO+sVSybgBiJFHK85v
X-Gm-Message-State: AOJu0Yzy4hRj2jHmUMivdkgYKLbYehy99JlcO2enRFpuiAhyvxg0AgWb
	MbdM5xGEeeolblLib7AHKLWVVHM1yKZhle4TEUvS4GXtQ+QQTxiMkK+/T12Rrw==
X-Google-Smtp-Source: AGHT+IGJfXs2YCoHgkgwujxBkyiSGmRp8KbhcbDvqGktBTuf7mgurovld+JrdIomojDkTkRDlF31Vw==
X-Received: by 2002:a17:902:da8d:b0:1e0:16e0:b28e with SMTP id j13-20020a170902da8d00b001e016e0b28emr210988plx.34.1710641090085;
        Sat, 16 Mar 2024 19:04:50 -0700 (PDT)
Received: from [192.168.3.16] (mx-ll-183.89.30-58.dynamic.3bb.co.th. [183.89.30.58])
        by smtp.gmail.com with ESMTPSA id v11-20020a170902d68b00b001defd3e64d5sm2881143ply.263.2024.03.16.19.04.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Mar 2024 19:04:49 -0700 (PDT)
Message-ID: <570989e3-299f-4617-adde-b6b8d1e06277@cpp.in>
Date: Sun, 17 Mar 2024 05:04:44 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Anthony I Gilea <i@cpp.in>
Subject: [PATCH] ALSA: hda: cs35l41: Support HP Spectre x360 14 eu0000
To: James Schulman <james.schulman@cirrus.com>,
 David Rhodes <david.rhodes@cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The new HP Spectre x360 has _DSD for CS35L41 amps in ACPI but
reset-gpios and spk-id-gpios are merged into single Package of size 4 so
_DSD parser fails to parse it.

Overwrite broken _DSD with the correct configuration.

Signed-off-by: Anthony I Gilea <i@cpp.in>
---
  sound/pci/hda/cs35l41_hda_property.c | 2 ++
  1 file changed, 2 insertions(+)

diff --ruNp a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c

--- a/sound/pci/hda/cs35l41_hda_property.c	2024-03-10 23:38:09.000000000 +0300
+++ b/sound/pci/hda/cs35l41_hda_property.c	2024-03-14 18:22:01.887566917 +0300
@@ -64,6 +64,7 @@ static const struct cs35l41_config cs35l
  	{ "103C8BE5", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
  	{ "103C8BE6", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
  	{ "103C8B3A", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8C15", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
  	{ "104312AF", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
  	{ "10431433", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
  	{ "10431463", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
@@ -405,6 +406,7 @@ static const struct cs35l41_prop_model c
  	{ "CSC3551", "103C8BE5", generic_dsd_config },
  	{ "CSC3551", "103C8BE6", generic_dsd_config },
  	{ "CSC3551", "103C8B3A", generic_dsd_config },
+	{ "CSC3551", "103C8C15", generic_dsd_config },
  	{ "CSC3551", "104312AF", generic_dsd_config },
  	{ "CSC3551", "10431433", generic_dsd_config },
  	{ "CSC3551", "10431463", generic_dsd_config },

