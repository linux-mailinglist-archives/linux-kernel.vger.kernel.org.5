Return-Path: <linux-kernel+bounces-145397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A55C48A55B2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 416AD1F22F34
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C5F75818;
	Mon, 15 Apr 2024 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7rQApIk"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922DC78C6D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713192950; cv=none; b=Hjk4txIWy5V7NyNTplwjaJGylfIdchZhdVSVyo9FHzEFQE6PnXB/lRbKx+MAi0goqhGCHdhdD2D2suLOVURN9cWZrjLNwnapr/gV1gkykrtphE0FTEI9ZdoA9cyTI+Su6DPG849qtwwk6KU9OgGqOZV4UUYP72M+eOtRKMcUXcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713192950; c=relaxed/simple;
	bh=hVTH5bLCNmcxmn1AYn7nqYIKnxCb2Ab5PWYay7BarHM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h5bAmPQHQ4z+JojjduOmQFKnUfqbWNfSOMPEcmFA4ylVsVpA/mniYZyJwz9ceOtFy5dO0/vRF+2n4dcb4n+N91/5mHNADycTb702cN1mBBaf7LqQpRaJLE5O/GL8GiVuoKhy5vYK1Aey8jxXbYEL/fty2db+BJJsmla/vELIOjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7rQApIk; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56fffb1d14bso4751005a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 07:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713192947; x=1713797747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ftY3ceO7IaWaPhjW2mEyGYWXSld3NmgLxCpyOgogGis=;
        b=G7rQApIk0jXWhQKQf0l9PRbeSme0TQqtBdrAW4bdopUiXy/YXVG/LiSaLzL4SzrGoZ
         G8P8PWptUVEa8OZmRLkh7Uq+U10bGqUv4Ru5kUk0CMcBsXjkLfm5itCaxnauwQ2vM/pQ
         pXkwdE2yte2wsGsFq/Pm+iJvTVYJIw6jrwJLxnXB6ywmWUMEM2EkzuJHgevQulDqBKe2
         Zrcm25phnDBA3Lt1h4zzAipz8raAPskgek7UAi5fB1Bx3pMvHXK6jjAOLEI0LEDtZ7HU
         TcBTxh3FASIzZH3JP+wi7cLiMVR7ydC9nnb8/oA1YPJ+B3Y4vxp6gZKk+mhDO4JlPaj5
         Kx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713192947; x=1713797747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftY3ceO7IaWaPhjW2mEyGYWXSld3NmgLxCpyOgogGis=;
        b=SbtIrso2qz1ZuNpEh9KIr9WHdsbVaI8K5MMZNNRq5uA3MMr2qLGK2SA8e5lIBBucUl
         U+jXkca53jaC8kgEyIbHdH92Wu30uJ/o/VWQj66hTDdpcQ/2iqzaKB67Rst2XZPQw86D
         oCikWi0HeBw+DIam74lo+gNmYnn6Bv4DxuuJUm+3JSpzjY4mu3qj+VBZg1RHzOJ9cCg4
         IOFV4/xkXSpHtiC/BVCCquqWqUG/b2bJ5+TSSTE1N5hUftl+BiAqbiGm3SkV15F+w7EU
         eBFoPUOyBG+a2NoES+arKOHXibUwqD0qmkzQFz53VW5EMn+3RNWQWdJdbyfE1eiqXgqD
         ON/w==
X-Forwarded-Encrypted: i=1; AJvYcCXCJOnoDNztr1pAiwL8m4CNuUrs1dlVpq65vpjIo8PJq4ZBTRPvKUMfNG8n+jzoab5StG0KYO2wMEeQVdbCJCibLM1NgWVU1pItFrDn
X-Gm-Message-State: AOJu0Yy75iYPx8pvQzB8khfM5DqqIw/64LNcobGm5RkRn0O6gyVcGjfK
	r3dI/BqJzql1ZZTQ0z8Rybwoz8IiUHClSs69ASnx+rB3MRXsUm0b
X-Google-Smtp-Source: AGHT+IHPfdMLWRvO52exJpQuI3qecs0Oxa8deY0XxfMEbWl1m/U/dLeCFRFdY3EaSvrvZdsQ0eqI/g==
X-Received: by 2002:a50:8d5e:0:b0:567:e0e:dda5 with SMTP id t30-20020a508d5e000000b005670e0edda5mr9048713edt.17.1713192946819;
        Mon, 15 Apr 2024 07:55:46 -0700 (PDT)
Received: from rex.hwlab.vusec.net (lab-4.lab.cs.vu.nl. [192.33.36.4])
        by smtp.gmail.com with ESMTPSA id s13-20020a056402520d00b0056bf6287f32sm4893415edd.26.2024.04.15.07.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 07:55:46 -0700 (PDT)
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	linux-kernel@vger.kernel.org,
	Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Subject: [PATCH v2 4/7] scripts/faddr2line: Pass --addresses argument to addr2line
Date: Mon, 15 Apr 2024 16:55:35 +0200
Message-Id: <20240415145538.1938745-5-bjohannesmeyer@gmail.com>
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

In preparation for identifying an addr2line sentinel. See previous work
[0], which applies a similar change to perf.

[0] commit 8dc26b6f718a ("perf srcline: Make sentinel reading for binutils
addr2line more robust")

Signed-off-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
---
 scripts/faddr2line | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index bb3b5f03f4ea..820680c59a39 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -260,9 +260,12 @@ __faddr2line() {
 
 		# Pass section address to addr2line and strip absolute paths
 		# from the output:
-		local args="--functions --pretty-print --inlines --exe=$objfile"
+		local args="--functions --pretty-print --inlines --addresses --exe=$objfile"
 		[[ $IS_VMLINUX = 0 ]] && args="$args --section=$sec_name"
-		local output=$(${ADDR2LINE} $args $addr | sed "s; $dir_prefix\(\./\)*; ;")
+		local output_with_addr=$(${ADDR2LINE} $args $addr | sed "s; $dir_prefix\(\./\)*; ;")
+		[[ -z $output_with_addr ]] && continue
+
+		local output=$(echo "${output_with_addr}" | sed 's/^0x[0-9a-fA-F]*: //')
 		[[ -z $output ]] && continue
 
 		# Default output (non --list):
-- 
2.34.1


