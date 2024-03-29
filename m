Return-Path: <linux-kernel+bounces-124436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 911608917AF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B754B21D69
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF686A33C;
	Fri, 29 Mar 2024 11:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EFUxathG"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2594539FCE
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 11:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711711610; cv=none; b=R6gnRqmv6SGGijnL4e6MjnQoZEUXXn5RrBy/dv6QtZclMiPk9On1XZyHvmqoEbBmYIN5++1dOG1K3qYxVmgpjGFPzjVRnSl6q9lFrMjcS+rVUcxLo0HIV3M+xBW/Ekkvrsga4EIXe9nq8jza1la+S280cict6PwobiXKwuc6+9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711711610; c=relaxed/simple;
	bh=yZYIKkF8UnLi0VeCGQ8zrkFnGgcqBEWD0cAzkOL8swc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kXEk2HM5KnmLx98e7IfIdhB5E5pIguwwB2yUTwMBhgOIs6i0Sb5+Uy1wOKCULnvCq1ChAhYHg2abMQYvpxWTczAQM1T7lkYQqgIuBbAtGbUvh5UUPFKTP0+G5K6wXkOfiwW3S1BJ6KuWJ560nrL0tgVYkT1Xc0RR39+IcNxP2w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EFUxathG; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-415523d9824so1926995e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 04:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711711606; x=1712316406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=urQSR8k9rOH+nEhJnDB+ssPUq+9+ZuEfluly8f2j41M=;
        b=EFUxathGEBqbGld9LFzx1i+c/5lefNiA3YosEip3XF1F74oR8PVEfoz9Zhteb0RvD8
         jDvRWc3yOPgNYmyJyvSYAQRIDXYV+0m5Nco9IMEza1cGElHHXrcSHrNXAzAkHh39l2kQ
         QjNJJR7Jdhz61fas+wNVLW6GuET98Pwu+cU48XoYLVkZ/skQ67BaCqcwyVkR+HG3tD3T
         i+PKJLgtpUgx1gviBmTZLuCfCu6azh4qhN/aYtoMbaHa4iE7il60+g0tpVoni1g+tgk1
         hx0aouTVwFaV7q1HmyyncmnYKhM2uCudtHBSBueduTzdCen6410rJ5i/7Gbu9WSSHt5L
         Nkrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711711606; x=1712316406;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=urQSR8k9rOH+nEhJnDB+ssPUq+9+ZuEfluly8f2j41M=;
        b=TetOupjtO9XofLUw8jx00IPRAYIFzXWomVv4lvIQCQ6+QCPEnAfDVAbHhn0assvyd1
         Kk+1M/f/RbsLY1Pq1OBntP6PUIjjmvh5f/s8pGR0CeT/JHBZuyvvhQiQeqOlSykjmzzv
         Zdr6lkH8R+r3Y9g+BKPt0YFXrkOf7HiJx0OzcpyfBObKzXswHIuqKnP94bXmAVZjDUmR
         g2ia8Qj+PrbOXdrU6XNYuOuDErv4ZzCFLGmUe6U3yNBtuyJGKP3KnlGd1t6hNUdKycMa
         qzNouHaocMlh0TQN7IZOCktkp/KtaIMOTAzNNLwUR/13ygZGwcrkEnlq0WiMIVVZNbnU
         NqIw==
X-Forwarded-Encrypted: i=1; AJvYcCVlXIYqQhuIBKVNawQXseoPLhY4Ip8RLZU6MyT+Q1gwPXUTXv6KNZ7AWbhITJW6DYvM2h8+MVFQXjVxq60yP/01Bx8DMmUhYDAWezeb
X-Gm-Message-State: AOJu0YwXJlOXPcNSWNYFksmK1xIeBwYhuONFwZR5P9oWwB1CnA3CW6Fr
	TuPcIBNgwLnLEM2GRG32nTuP9LyJziq2hAdoQ9sxECM1NI8hQQWxjbIBYOKCLjXStk6eyz0XdI/
	TGpo=
X-Google-Smtp-Source: AGHT+IEsa3l7CpsgPVX8Rgmc/Uh9bBz2bb8jJuVTT5cPVRLshmDQEunujRnG/h9yH8ptoWIh5fCf+w==
X-Received: by 2002:a05:600c:1c84:b0:414:8e39:7331 with SMTP id k4-20020a05600c1c8400b004148e397331mr1836350wms.3.1711711606499;
        Fri, 29 Mar 2024 04:26:46 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:f8f5:63d4:de5b:e4de])
        by smtp.googlemail.com with ESMTPSA id k33-20020a05600c1ca100b0041409cabb39sm8227448wms.18.2024.03.29.04.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 04:26:46 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: neil.armstrong@linaro.org, mturquette@baylibre.com, 
 khilman@baylibre.com, martin.blumenstingl@googlemail.com, sboyd@kernel.org, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: kernel@salutedevices.com, rockosov@gmail.com, 
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20240328195733.30572-1-ddrokosov@salutedevices.com>
References: <20240328195733.30572-1-ddrokosov@salutedevices.com>
Subject: Re: [PATCH v1] clk: meson: pll: print out pll name when unable to
 lock it
Message-Id: <171171160568.1289725.2666199134517231048.b4-ty@baylibre.com>
Date: Fri, 29 Mar 2024 12:26:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

Applied to clk-meson (v6.10/drivers), thanks!

[1/1] clk: meson: pll: print out pll name when unable to lock it
      https://github.com/BayLibre/clk-meson/commit/16182ac30a68

Best regards,
--
Jerome


