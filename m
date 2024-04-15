Return-Path: <linux-kernel+bounces-145395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F28E8A55B0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06521C2206B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6D378297;
	Mon, 15 Apr 2024 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YD5mzvMl"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8F775818
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 14:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713192947; cv=none; b=qFMINiMaotHEuO/EJqbyFk88fzZ59efhKNL/iZyGTaOZAqQyrjl4eh/QJwtgUr7ubC/kgA3zPuFTSy6wRyov0NvN0jSn//jHta1WjpLoY10eBn6Yt3r3B5CmMHpBZaZpaRC06dQ4yjSmnUSenVUgMeMjxHEDxd/ibYfJhXqegOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713192947; c=relaxed/simple;
	bh=0Kq0Kgx3d6qdBteVdc49v+B1oL6Tx1LvVDzpIfXgHLU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BtV6oQMyPhm4prz1feBNBT3QwHh570H3fNj9MCRVHfpn9Gil9zR1UAKUElv24XiHCNM/6NZKtPe0lMW0KqpmR2gvkZ3NucGCCb5u/XsobfSDOMuhTO7DVVQf/6PwAEYGDAeIEfp12DrODT7okxtr4ZfRmls/CnavIA+1SF+Ea9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YD5mzvMl; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-516f2e0edb7so3988385e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 07:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713192944; x=1713797744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SeoEezW9/4VkOixPnqAE9ztYSH2P2V/0rjgAzL/X/r4=;
        b=YD5mzvMlnTU1Ea9uKX7vItaE3eZkInnMt8JEppEf2WMzQn5DZrap6uuqtLezN8mEML
         ywMDcLuURFkwYkXL5Pe02DoAhr6Es3vwFsDyMT/coK7+EW0JKxtvLe+nc1dlwv7U2bSq
         mV+KK4Lk5sEkSMQWZMSo+nvajf/P5Uz5z6kpOJljM24rIypk2g3uzQ/tkjbwb3jpKaZ7
         d6teqDWCrim1Jal9JdR6EbSMqO99YVkWM3cuShSci79C5B6ZH6ekzPJfgdqWP/0wulz4
         DHyzSovsDr1+Y8wvCtg+iJoqMqXXsacWXdQ/BegodSJoGQDP4pMkcOUoaVjflITUXVl0
         ozhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713192944; x=1713797744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SeoEezW9/4VkOixPnqAE9ztYSH2P2V/0rjgAzL/X/r4=;
        b=MgYZEas+IVC6VxPlxsLug82rVwTqmqvrw36PAMk7acv1EhgU45wgSSD9iYEkTZHh/l
         lhOHBaUDxpW31hwbhNvAxkyHjWVkFpUG34uBRRLOZMEAAcpSKLq5xi0J6CavMAfjptZC
         824/gfcG+Wh/NQAKnEsbjiY7VEAOgee39bf+VwJIrCSYeq0Gt2ChxzDF+WQI+FeCGeK7
         Q37jsGYYyg/7IL6K5/3snAUr8Elz4xY5JUs0Yid2dOYPUtc//yKgnA+k06DcHvrYJuy5
         BXicjinI625BCVVCVLoN1kuG9GKa0N9i2N3vJaDn0UQoJvo3mpC6tiuVHQ6wKQUKlDmA
         pWEw==
X-Forwarded-Encrypted: i=1; AJvYcCWpkTtTwTPEUwfW/gj8Aea41pYnKtPNe5UoKQt7d74Ii89zrHSOgQJThMo/e1TswaDFVTB4HRBvJOHp0Z34KmpDSckA2QVttRq3Mdqv
X-Gm-Message-State: AOJu0Yx6SsQMUtDq/qO/Ax2CHbTMCWOTDoVa9mmIxbjLia87pJIRKm+q
	JtN1TpxF+MOxpg0EF95ywTg+D1gAn2fUjNUSDGpEHH4KaQcRZmDORVKzSSPz
X-Google-Smtp-Source: AGHT+IFy/Vert0WG2Aez/B7Huq4Te7OsF+3VQrFvaPy0WGwq/20Mwg9gxHMxFRpiOauDvOeL4LZqWg==
X-Received: by 2002:a05:6512:2813:b0:518:e249:c0ff with SMTP id cf19-20020a056512281300b00518e249c0ffmr2702696lfb.41.1713192943986;
        Mon, 15 Apr 2024 07:55:43 -0700 (PDT)
Received: from rex.hwlab.vusec.net (lab-4.lab.cs.vu.nl. [192.33.36.4])
        by smtp.gmail.com with ESMTPSA id s13-20020a056402520d00b0056bf6287f32sm4893415edd.26.2024.04.15.07.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 07:55:43 -0700 (PDT)
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	linux-kernel@vger.kernel.org,
	Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Subject: [PATCH v2 2/7] scripts/faddr2line: Combine three readelf calls into one
Date: Mon, 15 Apr 2024 16:55:33 +0200
Message-Id: <20240415145538.1938745-3-bjohannesmeyer@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415145538.1938745-1-bjohannesmeyer@gmail.com>
References: <20240415145538.1938745-1-bjohannesmeyer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than calling readelf three separate times to collect three different
types of info, call it only once, and parse out the different types of info
from its output.

Signed-off-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
---
 scripts/faddr2line | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index bf394bfd526a..f011bda4ed25 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -105,10 +105,14 @@ find_dir_prefix() {
 
 run_readelf() {
 	local objfile=$1
-
-	ELF_FILEHEADER=$(${READELF} --file-header $objfile)
-	ELF_SECHEADERS=$(${READELF} --section-headers --wide $objfile)
-	ELF_SYMS=$(${READELF} --symbols --wide $objfile)
+	local out=$(${READELF} --file-header --section-headers --symbols --wide $objfile)
+
+	# This assumes that readelf first prints the file header, then the section headers, then the symbols.
+	# Note: It seems that GNU readelf does not prefix section headers with the "There are X section headers"
+	# line when multiple options are given, so let's also match with the "Section Headers:" line.
+	ELF_FILEHEADER=$(echo "${out}" | sed -n '/There are [0-9]* section headers, starting at offset\|Section Headers:/q;p')
+	ELF_SECHEADERS=$(echo "${out}" | sed -n '/There are [0-9]* section headers, starting at offset\|Section Headers:/,$p' | sed -n '/Symbol table .* contains [0-9]* entries:/q;p')
+	ELF_SYMS=$(echo "${out}" | sed -n '/Symbol table .* contains [0-9]* entries:/,$p')
 }
 
 __faddr2line() {
-- 
2.34.1


