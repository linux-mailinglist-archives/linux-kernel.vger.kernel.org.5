Return-Path: <linux-kernel+bounces-167987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BAC8BB1EC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97C9F1C214C2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE75F158214;
	Fri,  3 May 2024 17:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoHu0LzS"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FB723749;
	Fri,  3 May 2024 17:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714758760; cv=none; b=JztCjJjqMxhP75FlOyZi8iFIMhroOvjUXTYRUq8IvhF1x1V9H4lUItAk/hxaGEFhcV+gR5vP/cJxSnaBjjYG3V3JNHroxTGIMnrh0cikRX0BLAhflvaXj+68TYo5tO4Gf5H+wlmJj+tfdnqY4qUGorT6TiP28wmbU92jM+ttHL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714758760; c=relaxed/simple;
	bh=26lFkDSslFUBARmxaoBwnZXKXDz1wLRsTHBw5LcZKiA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SZo6DDgcq+IilL7pykr30HssX6FELnLBIy/Fn2cgQ8xlpdkMfXfmgHCfTEtBNHEHRjkN8KUkRHvQJ88N4T11WQEvan3URdX665M9sBQBKNsAzdq45Mrgs7wdZ/bQLNFpYgBhYM6HBGgFuV9OpCs326zIAv156rGoP+QnbOO/kCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IoHu0LzS; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a524ecaf215so1367155466b.2;
        Fri, 03 May 2024 10:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714758757; x=1715363557; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S5Lj7EMp57A1ZOWJ8YtZlI8QLrZzM8FZK+WR00Wk7Lw=;
        b=IoHu0LzSbZHf7Gh7zKARmfA1rYxElm9vc+uPZb+HvNwtIVyDgoB8Bq1GOKszmtb3EH
         UW+biTDMSIGWDo3N5DE1MQKTJTs0bgvl1AR3+UyozvqQQvUiwWJAzjVTncglP4iUYAbA
         LSgcP8pZij5cpi+ko0uLlB45Jqzhxq4RsxuDCLrB3TCarttgNk4Yp1mVOdgOZJQf+Kk4
         f+vihmW6ljClYltz42j4clC/Q7gcAXbeIXzs/qr9TyDcYIKQswvqHy82NfY9aEpIPMmZ
         EEFPpH+pq1ncntS8qeJ10dIG/H7IWpnfy1DXrBdX6xaPGfg12eHslQb19ye2dQ3lNYHT
         fXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714758757; x=1715363557;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S5Lj7EMp57A1ZOWJ8YtZlI8QLrZzM8FZK+WR00Wk7Lw=;
        b=ZzL7fRuzSiJJxy8fxIXOhbPlDLHnO+8DcFUhipMujcZ1zLd4S4PNU1gxP0ODsQyMRf
         p6+a0A4lcdHWXKhVZH+TpTl6yo8GRYyZpIuOsUD6/aKjZGZc2iyBl8ErHc/ElAcWcEb3
         hj/Gi0aqBTLLpPlfqCNbq7FydHo77WJJD7Iw7DkEHSA4x9KFBI4H7csVfO+utB0u1xmY
         r3wijwE+vZCGzfRCmov3bx/8POYELqP9amW/jPpgZ7Is1dLZaRqKBuZJ/hspUJg2YTx8
         wDj+jnAHIsVzvhQJ1NrTGUB7+K5o0b4lqVlsQYEoNd27nEFGzFVmptZ5O7OIJqk1SA8y
         W5zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYMeDulHuod8Zev7SgkgwmFhkdEBPMWpndU2aD9Pspi6FrBzM8FfHVWn13NoGF7s+Gm5vCPrMG5dxDc/0a9UsNKFVUhLyWX5SqySGm
X-Gm-Message-State: AOJu0YwndnOahH8gtp3wR2WhExn0HYuiDynwmt9bUwdOmu3HpVKqATb3
	ICgi88xUI1XRzWlzVz+HeS5P4rQFGoF1VlhJWNFLZseNQXIffwTi
X-Google-Smtp-Source: AGHT+IF4dsd0FfkWVX3KX+wiy07pKW/AhU4MNhSgBTpRv5E/JETN74/vLWBFDE0BMS4HIFD2W3PVxQ==
X-Received: by 2002:a50:a696:0:b0:568:d5e7:37a1 with SMTP id e22-20020a50a696000000b00568d5e737a1mr2215751edc.36.1714758756804;
        Fri, 03 May 2024 10:52:36 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-47.cable.dynamic.surfer.at. [84.115.213.47])
        by smtp.gmail.com with ESMTPSA id q28-20020a50aa9c000000b00572469a7948sm1968368edc.45.2024.05.03.10.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 10:52:36 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/2] cpufreq: sun50i: fix memory leak and remove
 of_node_put()
Date: Fri, 03 May 2024 19:52:31 +0200
Message-Id: <20240503-sun50i-cpufreq-nvmem-cleanup-v1-0-0a2352cac46b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF8kNWYC/x3MwQqDMAwA0F+RnBeIrpXhr8gOpaYa0Ky2VAbiv
 1s8vss7IXMSzjA0JyQ+JMtPK9pXA35xOjPKVA0ddYYsvTEXtSToYwmJd9Rj4w39yk5LREPO+PA
 JzvYT1CImDvJ/+vF7XTdx4KIFbgAAAA==
To: Yangtao Li <tiny.windzz@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714758755; l=1729;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=26lFkDSslFUBARmxaoBwnZXKXDz1wLRsTHBw5LcZKiA=;
 b=SAyC1/2rpo7KrfqQ3wLlae9m8UXTOYb4VAe330AWXXwusl1ENis3BtDioVvV8r8YDz5yvQHKR
 QzpMy9YoqUzBxOEAK9wzbzCFss4+EKjtvl/cpdv2TW5D/WLnigd2ZJ6
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series fixes a memory leak by means of the _scoped version of the
for_each_child_of_node() loop, which was recently introduced with
34af4554fb0c ("of: Introduce for_each_*_child_of_node_scoped() to
automate of_node_put() handling").

The new approach is still not widely used, but this might be a good
occasion to use it in a driver because it actually fixes a bug, and
the loop is rather simple.

The creator of the new macro was added to the discussion in case the
new approach is still not mature enough, even for such simple case.

Additionally, the existing uses of of_node_put() have been removed to
favour the _free() cleanup handler, which reduces the chances of having
any other memory leak because some of_node_put() is missing as well as
simplifies the current code.

I don't have the real hardware to test the series, so I "faked" the node
in a device tree for an arm64 device (Rockchip) and hacked the driver
to get to run dt_has_supported_hw(). The new implementation works as
expected, but if someone wants to test it with the proper SoC,
additional tests are always welcome. The same applies for the removals
of of_node_put().

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (2):
      cpufreq: sun50i: fix memory leak in dt_has_supported_hw()
      cpufreq: sun50i: replace of_node_put() with automatic cleanup handler

 drivers/cpufreq/sun50i-cpufreq-nvmem.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)
---
base-commit: 9221b2819b8a4196eecf5476d66201be60fbcf29
change-id: 20240503-sun50i-cpufreq-nvmem-cleanup-40a4cf8fa56d

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


