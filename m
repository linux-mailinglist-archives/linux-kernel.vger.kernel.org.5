Return-Path: <linux-kernel+bounces-112050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D509688749B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 22:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 908BB283BEC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 21:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786818120A;
	Fri, 22 Mar 2024 21:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qGfcP3pd"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87A580628
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 21:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711144344; cv=none; b=bmkszJULqoktLVXxW7RSg4oaF33iVIEUznspJvjlmckDMGIFLnp8nuoZQMZwl1WmUZdsQrwpRBuooAw0QVhpJvRPqAiepBfIA0jE9nIS0dy7iPHo+3pTeLkn+mLdc8JxjzhklLgjCvOsBK0Ahp3QwyOLMvD2OamUyDllIE/huU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711144344; c=relaxed/simple;
	bh=jYLrs9FzuD/uXocxQfXfUA+/zRjYUAxdEYngmXiXnyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zd8P3C5WEaNtvP1/qq64yrKBWuwq1nhx0SOTleVk6iaHFl3GpPfKZbGDCGs4o5PwkkMet3nZ+YwOqY6bFCxCHB053rRMcabjPIcfAg0uULrH+zyM2/roODKXQRejlqVjtw4IUoPTprkGVWqauidWwG/DuqCsovghIUZkCC5C+34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qGfcP3pd; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c38f4e18eeso1688251b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 14:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711144342; x=1711749142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8CLFi25Vmi0M7L3CTPnrBRviDBPZHtDLMk3xJ3WKq50=;
        b=qGfcP3pdGzPbVUM6MX5aqub9ODSGWjOLNM7B90eT6jj40PCXGffzYtRh7LmMlMt+gS
         LrU+2kJVL0khCEJny/iBdM8z8MoR9ctF3u/+LHxoUgG5UCMrdvQpBjKngOn045MpbNJY
         RF0I6T64nkxW8KlnjLrF6hlLhrThUTvQTQVcRJV8eaSFTbCuXtWmxUX2jr5TVp10qJdB
         UFOoRgC1ShAAfqmgfM3ENcfuEI3QhYlGGCPuWHUZlZw3Kx+4tls6MS/VX9Z73QcTKMm9
         N9m+nDKPv6mloQ8/RMh09ushB/QNIf7kjIaDEovWRs2wqCsJAYe5rlAGGCEKtDwBcIYZ
         AbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711144342; x=1711749142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8CLFi25Vmi0M7L3CTPnrBRviDBPZHtDLMk3xJ3WKq50=;
        b=JZpkpAntRI4hrDOSuyQF+w2HN5PG52EmCtkZGzvu49sty6042DsFuMC1mG49dAX8ab
         z/DW3BuDb/id+oOWdf2HUjQSsXmtWYmdjf8bqzDf2IgsEC9mZ5NvRw1k6ud3mTaBFBdQ
         qNBVmgpWtUpd3E69E7AHkRtMDLxC9P1vRxdP1F/xgmPudQhMv9FzqwI/Xlie/jDcANBH
         ca0F998gIj8hrwUGOzXUuypLmOO3PtqUIbec1SFGXOdJPR5/gz5wEFGZBgyl4iNv0Szf
         VeGAXGzWLcYcNfTZOIsRj80vPjj+Iy9pq39mo27gcavuRIP0+KwzqPPZxTNK3+kspp7b
         HDxw==
X-Forwarded-Encrypted: i=1; AJvYcCXfGcgG8IT+Vscq8MUo2JGm+M9iojLLBSp5G6gDnNIabaldEenGpVjdKkG1Krrvyih+juBCOdxHfTY6ysaeDTjIJzyGPDg9l60wgWby
X-Gm-Message-State: AOJu0Yw4eYjfK46/b9MGYiCC7E7069gkSaxkg/fJzc3x8TqDn5Fk+Wqr
	BVe6R3Wg6WzczS47oMyCFr2dmtE+lCwkGsvtSVhXVQx6G6lpAgE4oRNsIBU8dbk=
X-Google-Smtp-Source: AGHT+IEhahZJfwf604IZtu7lbi/ax/6vF+wMAUo1Iyn5jinQ4p2xQd4Vs3Su3pPg/PcBO2WOIiErLw==
X-Received: by 2002:a05:6808:3c98:b0:3c3:9949:b457 with SMTP id gs24-20020a0568083c9800b003c39949b457mr1256083oib.22.1711144342078;
        Fri, 22 Mar 2024 14:52:22 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id x20-20020a544014000000b003c37b3571d3sm88254oie.8.2024.03.22.14.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 14:52:21 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] MAINTAINERS: add Documentation/iio/ to IIO subsystem
Date: Fri, 22 Mar 2024 16:52:13 -0500
Message-ID: <20240322-mainline-ad7944-doc-v2-1-0923d35d5596@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240322-mainline-ad7944-doc-v2-0-0923d35d5596@baylibre.com>
References: <20240322-mainline-ad7944-doc-v2-0-0923d35d5596@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

Patches touching the IIO subsystem documentation should also be sent to
the IIO mailing list.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7b1a6f2d0c9c..fb2377bad376 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10466,6 +10466,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
 F:	Documentation/ABI/testing/configfs-iio*
 F:	Documentation/ABI/testing/sysfs-bus-iio*
 F:	Documentation/devicetree/bindings/iio/
+F:	Documentation/iio/
 F:	drivers/iio/
 F:	drivers/staging/iio/
 F:	include/dt-bindings/iio/

-- 
2.43.2


