Return-Path: <linux-kernel+bounces-99520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D573878990
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D30331F21CEA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BEB54FA9;
	Mon, 11 Mar 2024 20:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiLszvZ/"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595CC5336D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 20:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710189640; cv=none; b=BUbyDR/Qxy7DYKCf2CXTqvb79YpUipQCgL1jWFPk3iN54ecOKyE8d7SfnsG5+kd2iFDzIbfT5WfIDUQLoNw2wFwH5gZThfdc+tKy503BV0RFbf3dFlFuUuiX4HxiY+Zl0sXcNE4g+QMPiw8tvg/s6gfOfTvpucUm7bZvLIhGXKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710189640; c=relaxed/simple;
	bh=NgqlqguhW0ZM1ks6G3okpjVdXxcqLDNirpMQmEjgQI0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=f0oN18sXyuVY5NGEjH1rR21/n9h3WrvoJGfVYAJO/bcpYgYvGe3c50DVOA1zv+IbaUbd1U3WBTXXEhfLLS88f1hKY46Ju2jvc/q5VtBhLDRukXU+N3qH9MbtOMYfdtymKMZhAjoarKszMbJn+9GheRzkghCO+8boSR3EFFllsYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EiLszvZ/; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4132f37e0acso5269025e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 13:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710189636; x=1710794436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sOjg3BLEjFW2wr37AxjjUynACUi6JjowFfZ5pjF8XB0=;
        b=EiLszvZ/a7rpz2isGe7v3h0OQT8z/7DZqLq8PgvuRfHdgXEQD/mgfQLBr2CBIcQP7m
         CX6QX1uYdrj6GohGke+CwqReh5aGrhfc08nC3xTgD7hXAzsviPUaBQSNNexHUeVgCcbr
         N8SQZTP/hekEmVbSIjRyhSUvDikU7Uzgukt/lEF2OpDA27z+EM/4tZtAM16IyEjDEDry
         yXP9p0iL8RfVrISc2nEogZpEijZ24uxgS1OV8yyfQOmGamlEwPZTU+M+Of08z+M1v4tf
         uxmFd1/5tUoFBmufOvXaDirUm+NCBrI4GzJCmlDLa8h2Vk2cp6pNTT4GWDaMGML7xMRD
         +QwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710189636; x=1710794436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sOjg3BLEjFW2wr37AxjjUynACUi6JjowFfZ5pjF8XB0=;
        b=qaUVyrg2CQCeGGBZtJxkYjmWex6HNetxKBAMPbwnOdP67z1srXHuWB0l15uldlJrJD
         IygD4gXjYDsX8VwWmVrrQmvgwHkTcypuyHg6c+2RPCN/hObXPfboHyOGMXbF7AwpAb/3
         yOfD7XqeFarPcvMEuL70P/Sz2YwQiSHAm4Xh1dmjcKYn4tZMIPu3zrIv6cIaWRwYmCNM
         vnVqFnTWXRJHKPBMumlOCxE8/NGPGpKVtAtZ9jUMbRJlHG+TeqvHQNekiAStkOZqY8wl
         6Ctbfbbnks2IWzqYsfYewkKHPr/o4VT0UoUEKeVxx33tmmLd0JmgA8ElL59z5SvpvAfk
         tYMg==
X-Forwarded-Encrypted: i=1; AJvYcCWomxGpj84+GOhyL14UNc70SZqRyZOUX+QqrLqWzVX2lo6FVlQfPbEVUbjDjBxn9d0ydhwBUTl6Nznl/0P1tgCsjeMzv0EfDmJR+JgM
X-Gm-Message-State: AOJu0YwcWmtrBiCgU2UNnvQemOqmQmy1trheBotPcS81ZBBE3iRGPAel
	OsUTNMrpsf+/zEicG9IyVRcn3AGnSYKxPTU187KlKelQDLNmZOhK
X-Google-Smtp-Source: AGHT+IFkpYN+HMu5ZAnt8mKuEWtY9+UPK21YAwNrzY3k0k7XspBPH/MZ5hrEEcf4+183iAVLpvrXRw==
X-Received: by 2002:a5d:5505:0:b0:33d:277d:a2c7 with SMTP id b5-20020a5d5505000000b0033d277da2c7mr4383608wrv.16.1710189636160;
        Mon, 11 Mar 2024 13:40:36 -0700 (PDT)
Received: from rex.hwlab.vusec.net (lab-4.lab.cs.vu.nl. [192.33.36.4])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c198e00b0041312c4865asm14929355wmq.2.2024.03.11.13.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 13:40:35 -0700 (PDT)
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	linux-kernel@vger.kernel.org,
	Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Subject: [PATCH 0/7] Improve performance of 'faddr2line'
Date: Mon, 11 Mar 2024 21:40:12 +0100
Message-Id: <20240311204019.1183634-1-bjohannesmeyer@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

I was looking at the performance of faddr2line and noticed that it spends
most of its time performing two tasks:
- (1) Making redundant calls to readelf and addr2line for each address
  (e.g., it makes 7 readelf calls and 2 addr2line calls when converting 1
address, and it makes 252 readelf calls and 51 addr2line calls when
converting 50 addresses); and
- (2) Calculating a symbol’s size by unnecessarily looping through every
  symbol in a particular section.

This patch series consists of the following parts:
- Patches 1-2 reduce the total number of readelf calls to one,
- Patches 3-4 make minor changes in preparation for the following patches,
- Patches 5-6 reduce the total number of addr2line calls to one, and
- Patch 7 modifies the symbol size calculation to only check two symbols.

I evaluated the performance of the patch series by running faddr2line with
a standard kernel image (X86_64 defconfig with CONFIG_DEBUG_INFO enabled).
When converting only 1 address, the patch series gives a negligible
speedup. When converting 50 addresses, however, it gives a 15x speedup.

Cheers,

Brian

Brian Johannesmeyer (7):
  scripts/faddr2line: Reduce number of readelf calls to three
  scripts/faddr2line: Combine three readelf calls into one
  scripts/faddr2line: Check vmlinux only once
  scripts/faddr2line: Pass --addresses argument to addr2line
  scripts/faddr2line: Invoke addr2line as a single long-running process
  scripts/faddr2line: Remove call to addr2line from find_dir_prefix()
  scripts/faddr2line: Check only two symbols when calculating symbol
    size

 scripts/faddr2line | 110 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 84 insertions(+), 26 deletions(-)

-- 
2.34.1


