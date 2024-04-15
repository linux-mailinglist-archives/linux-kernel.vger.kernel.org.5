Return-Path: <linux-kernel+bounces-145400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3678A55B8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACEE41F21B62
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8176A80BFF;
	Mon, 15 Apr 2024 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ch+va08l"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7985E7F7D3
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713192953; cv=none; b=cz4jI5ky4G281Tgo2mtkHo0MK2ymgb57XXhRRVlfJ4yAbsHoIZTizi7rWme6jWNAviaj41S+ZALBYz1CtQ6PSL+pupN7ZBM7/dgHS7npdHlOZPyl9a2okUltZBUblxfiDn7uhCcCWi5l/xZHbMhdlWpI1lRM4DNQ6qgsqtl8GwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713192953; c=relaxed/simple;
	bh=SYZQwZ1nd0gWTuMIjYQjQKxvHXOJ7zdRVmEi5YursJE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C1eAhg55/8fj6hGVjh4fOxw5ZHY7iirJnf9KFOtaCQAZ2hvzQssEZSB6MwR0rbj0oYldKMMqvZkqkmZ4NvBBHFR+pE1suqf6KSXmnuunCnbtC00J5sW+sXkWYrklLZW8S8gp5cFUt3r/UN3sEKBlhh156hH0H4pBSzcpuOS25+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ch+va08l; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2da0b3f7ad2so40400981fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 07:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713192951; x=1713797751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OCU+ngmCJtGcdsTc7HXhUVIxaK+w/jL7NlKhh+I/haU=;
        b=ch+va08loRFe7DgC4oO9xVFmQ945w4k29yGGFIx5YZOOp94S/CDd5Oseexm99nU2vQ
         Jxhv10+GSN0/fQSy4TryADglEkMLcBbLDq7trm8r2gujGnCx0+D6qmTGiYmh06mhswvJ
         cRwW1+c/Ojvqtb2NdYE/JOTBTwFw2gxJUuV1/3BmmnFNKRJkdHzR0loxE+L0XuhfTdAy
         NFwLONivNovgz7M1M09Fk5ocyLF0PPl6ztJE9ekTmfuWddJOruCChU4YQWL+VGTwSPP2
         R1I5/Ey+w3msI+TdXiO34vlRx90dSQt2aW/SohYr7d7hxN7/DnqGonbsdtghWnrI919E
         GIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713192951; x=1713797751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OCU+ngmCJtGcdsTc7HXhUVIxaK+w/jL7NlKhh+I/haU=;
        b=hG+ARrSuenASHgl2cAoCakEW11sZGf8H6BnTT6wgys6RugtLMBHyI30+o6dI9sAhRn
         lbwdWrOSgHinATunYg9KTSYgeaqzRhiXFZ59phaNezsU30sMcZtLKR5QCqUkRbIgmrlP
         51idgPDhl3RymjXV9CjGMRxRfhEbW6rie4BExBIE7Axlr2kobr7MFWSWMqpTjkDfwWT4
         fwE7112s7ITRvrG7WEOs58UWknt7lwtpc/Y9KRt9NOy8kN6ui4Mbx1cYtwunZPYRyBpQ
         Laa5d93qJgZvE9VZ3PTPlrI7VS0CYVvlyeEcukYmjzxcSVf6PClH9hu14+TqVRBoK5Wx
         Z3EA==
X-Forwarded-Encrypted: i=1; AJvYcCXh4248b1jLm9cVRbliDOrX/q9BLjaDBEQg2ltvawMJndUV1Q5YvFzrrMbqOqNu4fEzrI2U/MjanSNDYPvMmBfe/x8XTKT0pBSCogkl
X-Gm-Message-State: AOJu0Ywtaytf9ugOrv12RMKFBlY9cb2W+3Rn4qjpLr7lgDod7lMoR9Ew
	jxdaunHIXfQLz5CDnW7ECr6IH80QeA3vRSwBNQ07wSALBtQ+k5gGAsZvYmWH
X-Google-Smtp-Source: AGHT+IG1l9YsumIN7q2c3NzIx0GlAkl+UGmyc/KwccXzukbcjmNfMbsMc9WrWAHCVT9DpgBoEN/z5w==
X-Received: by 2002:ac2:465e:0:b0:516:cd76:ee11 with SMTP id s30-20020ac2465e000000b00516cd76ee11mr6102580lfo.17.1713192950679;
        Mon, 15 Apr 2024 07:55:50 -0700 (PDT)
Received: from rex.hwlab.vusec.net (lab-4.lab.cs.vu.nl. [192.33.36.4])
        by smtp.gmail.com with ESMTPSA id s13-20020a056402520d00b0056bf6287f32sm4893415edd.26.2024.04.15.07.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 07:55:50 -0700 (PDT)
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	linux-kernel@vger.kernel.org,
	Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Subject: [PATCH v2 7/7] scripts/faddr2line: Check only two symbols when calculating symbol size
Date: Mon, 15 Apr 2024 16:55:38 +0200
Message-Id: <20240415145538.1938745-8-bjohannesmeyer@gmail.com>
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

Rather than looping through each symbol in a particular section to
calculate a symbol's size, grep for the symbol and its immediate
successor, and only use those two symbols.

Signed-off-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
---
 scripts/faddr2line | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 1fa6beef9f97..fe0cc45f03be 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -252,7 +252,7 @@ __faddr2line() {
 				found=2
 				break
 			fi
-		done < <(echo "${ELF_SYMS}" | sed 's/\[.*\]//' | ${AWK} -v sec=$sym_sec '$7 == sec' | sort --key=2)
+		done < <(echo "${ELF_SYMS}" | sed 's/\[.*\]//' | ${AWK} -v sec=$sym_sec '$7 == sec' | sort --key=2 | ${GREP} -A1 --no-group-separator " ${sym_name}$")
 
 		if [[ $found = 0 ]]; then
 			warn "can't find symbol: sym_name: $sym_name sym_sec: $sym_sec sym_addr: $sym_addr sym_elf_size: $sym_elf_size"
-- 
2.34.1


