Return-Path: <linux-kernel+bounces-70711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF64F859B6B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 05:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E5931C21A15
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 04:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7041CD07;
	Mon, 19 Feb 2024 04:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F1GF5uBY"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8983C26
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 04:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708317577; cv=none; b=ig4UfN7VQ9DNmYRIePSIItDwuPiAKlRjbnaHo9mAKkjRFj+sSexoxf/vQMkMOILMxUzQvoUXmRMRGai7NMFMW8o+jqQtYu3390agCOU5pReLi/wr2mFI577RjuNyAIzPLjMjjhg1BmUYIQ1ZypTkQkl7kkWBRzUYABpC+xwPA9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708317577; c=relaxed/simple;
	bh=jNce4zGsBXTcpAYg6spprQg+FOqejy9WtcVsfsPW6Qc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C73u0cgKEHyqioiZ3ml+UNEX5IEx8/q1DkdjQf8Er3/KDrI0s92UewTGEciGTzud8Bwp8ZYS9HdRgU1vPZ6MCiqvkCX0rWFmKIlv3OUj9ZDyrq+l/fPlTRzJbErMSOiNeR9c9di12KnUH7Ja0hqnNwSQXnj9hPq8iaGcwoSqxGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=F1GF5uBY; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5d8ddbac4fbso3303534a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 20:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708317575; x=1708922375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdNwOk35Zc4yLcZkronDrKEG/Pad3CGoQyORwvnBAjY=;
        b=F1GF5uBYoyeDTEOKgtlot2lsN1nN1lqmiZgqLjQTmkyxCAkz/lVZFENNNy8lPCYUV1
         EHyHMyOPE1GQJr/25VXLWMj1mPfajUoO409uY0rJxRB+/xpHEonMlohlYvPMVcRuq/X8
         WZ5z1cP63t+E+Q49D4TkyQRDZ2YHn55O9pf6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708317575; x=1708922375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdNwOk35Zc4yLcZkronDrKEG/Pad3CGoQyORwvnBAjY=;
        b=Tuob02BvHEouSUXbU79K7ZhxuHtxHO42dpRUe+wBhfWi7kjhLT7ssfEkLmoO51qwPz
         MlAX1mpBFJkOXEEk/9tBsz5Xnkkz1uUUCAjOA6uDmAcqpL8hMoPEMLMIrR8ydb1fZF2L
         8Mh08k/6r7V6TS2PvX3XlAlIELmEe3RKx5osJREDHAkzwhCPdXNCJq79F+uhnsE7vltr
         BEzXoRLYeW/QzC359Kdh/k5G5lw3dsm0Ko1kMj8b1a60rYrfzR2Ew1d3llwB9n3jTfgr
         sH61ict2EXs7shB1xV9aC+6m3joFEFXn+q0ILeWf0tH2b1eRf8KZGE51xQqGkB5nib+g
         7law==
X-Forwarded-Encrypted: i=1; AJvYcCXgUizL9NEUryZHnC0p1HYQiAvZJOjIlv1hAtpbxpSbp3X19XEcSX4ZufxfVoPPrAVtPzXbEWSulVF+3bzoZkiWn6sUA08EgCu+lVdl
X-Gm-Message-State: AOJu0Yye7gmS57MUKkQA2iAv2rVK/uYyiDyiKUMga8AV6tT7tbeKwPse
	qb1BCOiNJ9RuHDyBQAV90nYMgYydJP9qFMB3E6cYj6Q/jqXBMkEPlmC7GfWyPq335z+tB2nEV4k
	=
X-Google-Smtp-Source: AGHT+IHpcygOCwpEkxFwCYsVIRF0pK11TneMKBTtOWTERMPyAyRdjMEZChQcxTwOMgJTkI4XCakVfw==
X-Received: by 2002:a17:902:db11:b0:1db:f03b:6f5b with SMTP id m17-20020a170902db1100b001dbf03b6f5bmr2992719plx.56.1708317575412;
        Sun, 18 Feb 2024 20:39:35 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902eec400b001d911dd145esm3425695plb.219.2024.02.18.20.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 20:39:34 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Julia Lawall <Julia.Lawall@lip6.fr>,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	cocci@systeme.lip6.fr,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coccinelle: semantic patch to check for potential struct_size calls
Date: Sun, 18 Feb 2024 20:38:37 -0800
Message-Id: <170831751501.1712410.1795028010127344315.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230227202428.3657443-1-jacob.e.keller@intel.com>
References: <20230227202428.3657443-1-jacob.e.keller@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 27 Feb 2023 12:24:28 -0800, Jacob Keller wrote:
> include/linux/overflow.h includes helper macros intended for calculating
> sizes of allocations. These macros prevent accidental overflow by
> saturating at SIZE_MAX.
> 
> In general when calculating such sizes use of the macros is preferred. Add
> a semantic patch which can detect code patterns which can be replaced by
> struct_size.
> 
> [...]

If this needs tweaking, we can go from this one.

Applied to for-next/hardening, thanks!

[1/1] coccinelle: semantic patch to check for potential struct_size calls
      https://git.kernel.org/kees/c/39fc2f86ae6a

Take care,

-- 
Kees Cook


