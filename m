Return-Path: <linux-kernel+bounces-36048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 032B5839AB1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81DE41F2BAD0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E97B613A;
	Tue, 23 Jan 2024 20:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0OSgq+8"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ECF3B199;
	Tue, 23 Jan 2024 20:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706043492; cv=none; b=hlAqTtHUDsDsQ94PpfUfQtR/LDG8XXdluCwB3tzHUKMQ0CDLlLFA7eC+H6yDjjcU6I5oEy0AVd5PgrhV7PeXIlTgrSe+jDYbSjF+dZapDByHhutr5Kor8iK28k/bQtGirfYrMrul4nGLidx5QFTQ2JEmdbPJNpbZvII+fi8Xxuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706043492; c=relaxed/simple;
	bh=+LOWtolt7y+KJAN1QYznwoNgWUtDvoht/BbgXsXbBVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L7q3JUXahVyhHocbhzO9OybDKsg+bFVoVsMuqLFchg204pdrDECVkVZF8xtXF9oOqDuzotH659gkbxbTYImEzQgvMQYe27a+UNbayT3tCI4uYR3mfuUdeCXN+Bce0oVTa/WPwE7g7og3QTfLUustX6g91czVvK9EnxDdR/0E0Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0OSgq+8; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e7065b7bdso56743505e9.3;
        Tue, 23 Jan 2024 12:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706043489; x=1706648289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LOWtolt7y+KJAN1QYznwoNgWUtDvoht/BbgXsXbBVI=;
        b=j0OSgq+86vyTL65C7cnBsPrO8OaMWWHABCMfBpdlMIo7lupehkMF/9DUv+5OmF1On2
         2TRsILZlXBY7Btdg18RWQ48ogBX1uaBwv4wxYsq2JU6bo39rt3kM0eQrTx+Ryz9zoahH
         6QHA2UQ+o3LRa7KWIx0RAv+M77sKvmBLGQQoAMRIMskF8ZBGr4Ywzz9dm1VfKLhvhB+l
         ++Wi8ThZCwiyv9UOLg3om1yfeAs0uU7bI1DBv/0v1GBHBlc+lCwy8l6N2CIGvbS9gOqd
         2y0pCliGQLk944OS/hAv0jSkcrAJ74pS3o/6kNgL1uObFZ7pf/XcCWJsesebZdJlq+8a
         ZLgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706043489; x=1706648289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+LOWtolt7y+KJAN1QYznwoNgWUtDvoht/BbgXsXbBVI=;
        b=lYmyuamchfGd1qppwGXRh0mvPhLj3btoM3vFvuSgY3MmF2OJ6HBUWKFB/4+Y/UajN4
         ji/XRpRSa+Gyhw2DvdYJuBnvTYLlW0U3yo0w2ZDvtmBpAxB4H4tWGb9DGLLKYEJvstBz
         M9kfvF38jmp82zy8IvvNVtDde9HRKVxA2SIfs1ebkxl8SYYNDFsW9K6HkjsJgj5pSoxO
         zB6N5Bd/rDZMWuMMh2eCQ+KHxRtrs10Gru+9+Z2dHWVgMRcRe3Dbvv05qddVgjnU0pbd
         /ENRjZ5tXmUqKEq2dqNxev99xSUCERAyX1BGM4zMgjcN4kEBwN+3iGZtn6bVWviwRs38
         sBLg==
X-Gm-Message-State: AOJu0YwX1AN8/b37+eqjE+0EHUl/WBlNOe0LIPaUrgDhe3yF7UrmUajU
	22bookQFZ+5L0fTF4Mm/xGCwvPAJg57ZRgaA3aVsdhL+onvrw1062xxk75Yw
X-Google-Smtp-Source: AGHT+IHJwJQzACZGeE+ZISr67jPpv8iwqwd1Q++oJrsbIZQfW7cpMZ3Fie62qVDgEKwzt1QwHUZ9hQ==
X-Received: by 2002:a05:600c:3caa:b0:40e:9ef9:838d with SMTP id bg42-20020a05600c3caa00b0040e9ef9838dmr325295wmb.159.1706043488748;
        Tue, 23 Jan 2024 12:58:08 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-14-70.dynamic.telemach.net. [86.58.14.70])
        by smtp.gmail.com with ESMTPSA id q20-20020a05600c46d400b0040e395cd20bsm47421305wmo.7.2024.01.23.12.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 12:58:08 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Randy Dunlap <rdunlap@infradead.org>,
 Emilio =?ISO-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 linux-clk@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] clk: sunxi: a20-gmac: fix kernel-doc warnings
Date: Tue, 23 Jan 2024 21:58:07 +0100
Message-ID: <3464017.QJadu78ljV@jernej-laptop>
In-Reply-To: <20240121051837.17564-1-rdunlap@infradead.org>
References: <20240121051837.17564-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Dne nedelja, 21. januar 2024 ob 06:18:35 CET je Randy Dunlap napisal(a):
> Move the function kernel-doc comment to be immediately before the
> function implementation, then add a function parameter description
> to prevent kernel-doc warnings:
>=20
> clk-a20-gmac.c:43: warning: expecting prototype for sun7i_a20_gmac_clk_se=
tup(). Prototype was for SUN7I_A20_GMAC_GPIT() instead
> clk-a20-gmac.c:53: warning: Function parameter or struct member 'node' no=
t described in 'sun7i_a20_gmac_clk_setup'
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Emilio L=F3pez <emilio@elopez.com.ar>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-sunxi@lists.linux.dev

Merged, thanks!

Best regards,
Jernej



