Return-Path: <linux-kernel+bounces-116397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E385D889A57
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EB7A2A2D0C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3003E44384;
	Mon, 25 Mar 2024 05:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWcuIo6h"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B10C13F449;
	Mon, 25 Mar 2024 02:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711332236; cv=none; b=mIEj7QF+QcLyq//D2ni7s+DzwNLU264mCgkqtTHanHYh+r9fYqIPhQMuYi7iMRCFTzK2bNs7l12HYqbeIcl9BjZwzlqOJ8RmJWgFleUPkeWwDDWa+ciFgAGu+brRreLB9Z95rimFGKpQoMiN02ZI3MSORjccDHz9y748ny2hxU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711332236; c=relaxed/simple;
	bh=UalUTF2iqRjxJm5BRWPYfnuu8z/bakUMFe6q3qjPta8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lljC7ZyG22Mpn4uwk/IRbQyDS5EvU0FHkYxKjHGG4235DsyqrrV1Foa6Ck+P9S5EYBUAGracMTriO0JW4LGlWNfr4ohfuO9pPbWMN8Xb9+E2FZa7OC9V3p7fdA+MMN81uYU8tuF5PA5Hi3wDrUzCpQNBIzSyix8yfTIXdRjgUB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWcuIo6h; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e0025ef1efso22107095ad.1;
        Sun, 24 Mar 2024 19:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711332235; x=1711937035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UalUTF2iqRjxJm5BRWPYfnuu8z/bakUMFe6q3qjPta8=;
        b=EWcuIo6hg0QvU7VUjXmSKkXtQPq1pOzSI8B1TbeB8YlUPK6vynd2UvlFrBpojVe5AX
         2b0hULteCj/ooFU7awfpDnOr4syPBubix5SobxDkcVeiRwQs4e1kdDCX6WfVv8ny20jp
         H08irRm4W8lmCujNTti3DIb8FTXH6hdDNGi6mbsfUaaDKvhlHkp67BVl6NbFDmlsySkZ
         YOgIEsh2Qi3DzwFzpDOzOAklSNB/ZbnQsix5XkOphcVryZ1/Y8/aUVRa2WW5Nc9lBa7J
         i+aIVSp/bT4h3VIeNukvIgiDf6uXl1+t8R/nanTVNlZ619gSrLZ2b785ZC8AdOZDKqaG
         weZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711332235; x=1711937035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UalUTF2iqRjxJm5BRWPYfnuu8z/bakUMFe6q3qjPta8=;
        b=CZbc/+GVUI55xkZR0zutnCvjfy2vmiyWvIkC8c5c3L4r9u5lmFW8Mktv+w/LvBPto7
         bPrTTDHbalYieuX1QgFVC/+kX1qZ2x0tdr39FvZ9NwyNGquUGbKHYqcQ5rFIHnKHUMtk
         +i4ek2Jb5mrTgy7vv0PU8RAXqtstvNw7rCzxTgbZePLw4p6f14zDGpi2P/ZTZyAX2U9i
         Zs7YvpfesO1idP9aDPjqNwvpQ7qIEFUjT1EJh1vKRcnIThZrW4yI/w9thOHXbDNEw5Xg
         R0FoefItPtkojjcdPeo0qCeGJvtNHdG5LBCZeWsoF4APoQMNJmzkS1x1DrZjf0GuDrCw
         BOPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5Bte9S1DBfkyiByvCXa7kB2CWm1xFrpuWxgMxDeOr6IvC69Dn8rmIqpTcIRGy0ncevPSurPJZCddq0aDYvzJ555Qi991+tDbv/wsLRqSbvBzyOaxSqw39JzAsEEIahNoietTAdvqxIRRewL6W9f5kyM9rqk0vPmRzgOBVLdXdsdrOTtQmXpi7ME3o95aUZkcSn9ZA2NiI9GE3hZD39ck=
X-Gm-Message-State: AOJu0YzW+cu8xvGuY6iiqunI4kD/eqH7rxa23XICeryMOZPt2Dl40WRI
	8l8RR5kwmA1tDMZPuQktLg7kRk3tqQFx8RtJZaTne8KB9ZxatKMZi1wmmC2F2QGczA==
X-Google-Smtp-Source: AGHT+IFke4+IkGE9FkicVvdk3GsuRfMPNbkgBJVDWwxCLpUbSSpb694v2kg3JJXAMyLX+BgGZPyyHQ==
X-Received: by 2002:a17:903:1d2:b0:1e0:c74c:dfcc with SMTP id e18-20020a17090301d200b001e0c74cdfccmr354616plh.57.1711332234623;
        Sun, 24 Mar 2024 19:03:54 -0700 (PDT)
Received: from gmail.com ([2a09:bac5:6249:183c::26a:10])
        by smtp.gmail.com with ESMTPSA id m6-20020a170902db0600b001e0b287c1d2sm1985284plx.215.2024.03.24.19.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 19:03:54 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: cyy@cyyself.name
Cc: aou@eecs.berkeley.edu,
	conor@kernel.org,
	devicetree@vger.kernel.org,
	dlemoal@kernel.org,
	guoren@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	linus.walleij@linaro.org,
	linux-clk@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	mturquette@baylibre.com,
	p.zabel@pengutronix.de,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh+dt@kernel.org,
	sboyd@kernel.org
Subject: Re: [PATCH v6 10/11] riscv: dts: add initial canmv-k230 and k230-evb dts
Date: Mon, 25 Mar 2024 10:03:33 +0800
Message-Id: <20240325020334.4033-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <tencent_DF5D7CD182AFDA188E0FB80E314A21038D08@qq.com>
References: <tencent_DF5D7CD182AFDA188E0FB80E314A21038D08@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Yangyu,

> - Support for "zicbom" is tested by hand

C908 also supports zicbop and zicboz. You may add them as well.

