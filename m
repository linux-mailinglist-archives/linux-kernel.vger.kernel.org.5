Return-Path: <linux-kernel+bounces-56335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A90F084C8D8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA61C1C25B51
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C21168DC;
	Wed,  7 Feb 2024 10:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxNtV+kb"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C395B14A8E;
	Wed,  7 Feb 2024 10:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707302493; cv=none; b=ePcX45T09d7BhvKOh2WhO6zrjOZBQoRJYr9Vx0RUsOSOQjgDhns7cGrgYHRXGyD+LZt+wLCgZOVZlNCKQbdgZ0sgbSsoa7zzxW0Ndo4yfcMqvSPLGtk6s8YFd6UUnDNShWHAoKusJJY9OUOFUASgo5GRfeEGAhjNBD1HQNgQvBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707302493; c=relaxed/simple;
	bh=73vHyUOG+29DA5uwnOt78bMHxFMroG/qr4k3poT3VKc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hXGRiAakW6PJS+a6qPYX6qsojf75LR8aYxAUaeHEUIOTYD3Vs+OsOz5f92TWrZq+xkqbz5IFNztmyL2yZrjZ9VX62QFzTeNL2UNn5gG391jdQVtsylS0VQboxsmCojzUdVozyGL6HDRvA4co/jThR9Gkz81uA0ysX6kZbTjZ67Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxNtV+kb; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40fe59b22dbso3442805e9.3;
        Wed, 07 Feb 2024 02:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707302490; x=1707907290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IqVnOS/qUrr0zNytXzso07sG3UnG8U3+3iCgGo/2BLg=;
        b=LxNtV+kbud0OHsnqppxd3JXlLaxv/ut/dFGPbS0/5IkFzcOmfBQhaIS45xB6hZd7UY
         gdLjFEGfnOBPkRzHbw6pj2iQeQm1uecMOALGpRXPzDUpWvMT4zC0quetdeVgCFj3t5O5
         iAiLxopHIkW/omEfnOUI/xGVG6VlQbhA56O5s0a+BD+7r2RTcbG8DQqyphPIzvd/B1+G
         I1LtO61srnFHdhD2Yy04/L7GXQMY4XvIk2uhI/VG2I/GbcTBKoSa/vjEEZBdryU5E6cn
         5HxTZC+3i0WlbpAlsYXM1+peOEycap0LUVL7HE75x4R1neyrSnqm8CWuagf9Ufj2whS/
         c6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707302490; x=1707907290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IqVnOS/qUrr0zNytXzso07sG3UnG8U3+3iCgGo/2BLg=;
        b=oBlEYoewuoKIA2d5AkhONDEWsaHD3+LPvAd2pF8hcW4HtIw7e0spTzS/sbIoc5xU4X
         K7yavtb/k2YbNPopFJaz0JJSSkVNJQwVwBeZxmA1EeAVf4SVrotR+2zdnZ7ukn+dQd5U
         xl73LSu6vDVD7IfgWdrhiI7JAdMvsZzq/aRcOHLf21DVi6jYntMsD878ZJqtwN3K8PLi
         5VsBm+5CRNvP3Vo0ArZMWVDLyglv2p4F3UIjE3lrsg1YEKffJP/KD8ijUQrGB0gTX7si
         xFgJ36sb4PypSqYBR0rDfnfHNFfyQMr4CDg1l3joTwmBrPU66J0EthRRnYhuCpSnwNHs
         m41w==
X-Gm-Message-State: AOJu0Ywb92g4aS4Rtbij8krbLkoYSuKzHKPz9trQxd4SJMrqkzouUtfT
	D+P8bDDO8JKGOowgAfFGvzhRYnX5TnxL3vsy7vnd0rVQDCL1QSlt
X-Google-Smtp-Source: AGHT+IFD7Hx6Pp9P3VacJ6jR5IgxVdtp+SBBgjfwAZd5EK3N44Et80YVhP34wnOgy+m9OVjM8vzGtQ==
X-Received: by 2002:a05:600c:4f54:b0:40f:dc4e:69e8 with SMTP id m20-20020a05600c4f5400b0040fdc4e69e8mr4361978wmq.27.1707302489767;
        Wed, 07 Feb 2024 02:41:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWSYi4VM0MiOa/g2nTSxfc1CWWsdwcTmlHD0B+AGbcTMrUgxQfitE7wFbTrTOiZuRRDQhxXiw0ZSmwVF1UwMY3Jui9FB84bz9G7fH1rz2Rp6JnOSpIb0v3ylQEzJBWCrKaCgwpg+ZCD907b2Q6kczuIYWabx/64C8qjMAezkCVrrGPTDdPAQENQ4AlyzMc2lsazkqjd3jojZM002A==
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id bd24-20020a05600c1f1800b0041004826669sm1923962wmb.42.2024.02.07.02.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 02:41:29 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] USB: serial: keyspan: Remove redundant assignment to pointer data
Date: Wed,  7 Feb 2024 10:41:28 +0000
Message-Id: <20240207104128.2441210-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The pointer data is being assigned a value that is not being
read afterwards, it is being re-assigned later inside a do-while
loop. The assignment is redundant and can be removed.

Cleans up clang scan warning:
drivers/usb/serial/keyspan.c:924:2: warning: Value stored to 'data'
is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/usb/serial/keyspan.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/serial/keyspan.c b/drivers/usb/serial/keyspan.c
index 93b17e0e05a3..0a783985197c 100644
--- a/drivers/usb/serial/keyspan.c
+++ b/drivers/usb/serial/keyspan.c
@@ -921,7 +921,6 @@ static void usa28_indat_callback(struct urb *urb)
 
 	port =  urb->context;
 	p_priv = usb_get_serial_port_data(port);
-	data = urb->transfer_buffer;
 
 	if (urb != p_priv->in_urbs[p_priv->in_flip])
 		return;
-- 
2.39.2


