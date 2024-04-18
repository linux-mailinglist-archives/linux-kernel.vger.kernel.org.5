Return-Path: <linux-kernel+bounces-150097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 850528A9A5D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24C511F215F3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1FE13442C;
	Thu, 18 Apr 2024 12:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="S5pKyZgY"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FEE163A80
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 12:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713444511; cv=none; b=sQKQBw0x3OxfSxZlumOTrmAVF2sfaxsv7PPr63xT1ljqCXJhTsPgFkhq2ABoY04e9UWb/JEWPf/4xn73rFy3b/qxPVpCqCYxH7cH2R19yDzXL2N/1qLVClshbGWfreUG+R9iRpU65SIkjKw6blzG0XJmr0L4VG6OKNyIzQRz4ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713444511; c=relaxed/simple;
	bh=E0hJ0cNVpzGDyCkIHhzVV48In8rsSze1Ba708GHW0DQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=kRkVOakAF6xXEJcUWnmYKi6nGOPIbRsTYAqd4uVJ8S8Cqa1cR44qbsXYcHALlwXFALUMlEYazoUGOssJVWBliQnsCi4JXV7nbrF4AxZCFNZy9200KcmPS+3PNPewfvlhvS7pZikXYM/wkiviJNGkLyg0noy1KGKSBKMhkSUaxhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=S5pKyZgY; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e51398cc4eso7314985ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 05:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1713444505; x=1714049305; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBVJjQh/Nx8BXhkrFisIjtogBH13cAN8LyyArAUlFGo=;
        b=S5pKyZgYuO+xZKmnhRrOhK5YDbE8tmtTVUp3bps8bs4wcmRgoH5AP+aVnDGdfGhCZf
         1OBhaf3zKgFHa3jX2834JmIBHgFsSUMq8nCRTqvS2X4eRhfAxqXWLtBPlJR9K9EJT59D
         FGCD0s5koQqObczKbAd7tsi/4fC6GPmlXx0azCZgTQQjV3i5KX1QyTKvY/IIgCS1G2eT
         iFJNyPiX83PMPWjPpWl8DW28HJ7LJ/+KBCvt5oygDB50DHHXbYGcBBugpGS65vcMPTYp
         y9C8BOd0zQx+I97IYF8DXJBlQGQ4GhM1knhNsNuH4KBf2tLni2vMMcBPeqmpDgiMeMRV
         MwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713444505; x=1714049305;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vBVJjQh/Nx8BXhkrFisIjtogBH13cAN8LyyArAUlFGo=;
        b=TQ8YfbGeMYj4BSdm7tJQOuNRN3tyREVKDpy7g27l7yNfV7k1xxhXssOsjw/iGvBRW8
         iaUeq2A5IrSOGo/O7i5M6WZVw1hATWlTcA5FH/kJXsqgheFi/HzTDVbKlRwQrnaYKAgc
         Vba1oJdAKxrpF0ZBs8dtRJilbVMVt6xGtZk2RyqwH0DLpfMZ6j1rIQv6/t9rSm6TG6vU
         3s+tdyJd5i8IS+7JmpyOny1+5HBfvJX10gN0i8wtDlsahILkE05oR1bCxIedWWDAJ/V0
         rvzW9xfCql95Z+Vpaj7pnzwJuQx7svWPssDTqkwbwnk3gCEgKE+RISPnjhaPMHpyc2JR
         E2rg==
X-Forwarded-Encrypted: i=1; AJvYcCXhAva16oFE9vVBrAIpd5YAB1OIva9o23ozasSjSGRPpO0saQVCJoEa8UBJJ9oilajMvlxiFE5Xd9ULio2mTn86ECYYjoYTlZ9Lel3d
X-Gm-Message-State: AOJu0YyPMQwLapMgfz7iOJqCC2ylMr6rbzyBtTNnX6gsp15cI5WwKuWk
	mBJv+SS/1xil8J8t79TITl1U7sJ4OBNpoinNJx2I7tGJ1w9g9qAqzxBX0p4nIcc=
X-Google-Smtp-Source: AGHT+IGSiSDDmR8LYcqwjG3haTEKWA5AkubEyL3ysc5fD6DHGQT11eT1vAj07i5o5JXkET0KZpz3OA==
X-Received: by 2002:a17:902:9a0a:b0:1e4:24cc:e025 with SMTP id v10-20020a1709029a0a00b001e424cce025mr2713328plp.59.1713444505581;
        Thu, 18 Apr 2024 05:48:25 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id ju24-20020a170903429800b001e3d8c237a2sm1423509plb.260.2024.04.18.05.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 05:48:25 -0700 (PDT)
From: lvzhaoxiong <lvzhaoxiong@huaqin.corp-partner.google.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jikos@kernel.org,
	benjamin.tissoires@redhat.co,
	dianders@google.com,
	hsinyi@google.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvzhaoxiong <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v1 0/2] Add ili2900 timing
Date: Thu, 18 Apr 2024 20:48:13 +0800
Message-Id: <20240418124815.31897-1-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

ILI2900 requires reset to pull down time greater than 10ms,
so the configuration post_power_delay_ms is 10, and the chipset
initial time is required to be greater than 100ms,
so the post_gpio_reset_on_delay_ms is set to 100.

lvzhaoxiong (2):
  dt-bindings: input: i2c-hid: Introduce Ilitek ili2900
  HID: i2c-hid: elan: Add ili2900 timing

 .../devicetree/bindings/input/ilitek,ili9882t.yaml        | 1 +
 drivers/hid/i2c-hid/i2c-hid-of-elan.c                     | 8 ++++++++
 2 files changed, 9 insertions(+)

-- 
2.17.1


