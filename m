Return-Path: <linux-kernel+bounces-106010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F4F87E77D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B16A32835DE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154C2364DC;
	Mon, 18 Mar 2024 10:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UvZ2Vuip"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDAD364A7
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 10:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710758413; cv=none; b=EmUpoPhhAMzE0nnIOLgY5kaUx7OAiNQVhNW+G0AHR4B1L1URuOplSwR96vOSjsTUPPJTEq2BJnZo1ISLorl0w0yS5svk6H60MtHTnu3t3pTLp3KIFRk3dvlZjIoXRircSd9Fq2NDsZr/bDBse+0aK4kL7qnigteobz2G03TRMk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710758413; c=relaxed/simple;
	bh=Bc0vuGBBjoAPO0Gnkdiq35Bk+ZiPc/LTDUGB63jOnmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dumvYhDT2Pv+xELOorq2AkSbydFZy3oJAxwzIfLgNBXWM5jYzIdLH6krNNf1Qj3B93X7sIfYYsQzwjAEFmdH1mMKX/DnqMGceCKoaNv/dslhTM+A9I/8n7UX9omBdlc56D9Nc8cdTn9EQ5m29GslglJD8lxqq5ClteP8eDWMDMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=UvZ2Vuip; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e6adc557b6so3926376b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 03:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1710758411; x=1711363211; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3nNTcXNffy4KdPfHJUqr4Rqkbq2/2XQcn/yEKFcKSuc=;
        b=UvZ2VuipTCm2gMnf9td+XXO0tyBRtJxGEQQj7XwF7CCV+49nxSr3Ll56qppYE0ikri
         6/zbFHO4AZQnujHDtu107BqAa6qPeegpiHkemik2EbcVpcg6rfyyHErxQBk93V9QtEri
         FbcQvbwlaRH+sBmLYxDmyKUFjRgIw1cgYIK/e3FemPwG+vS+pRlelRm2SJoph+T23ZZ2
         BAD2qYIcwTfqKz5gHr/k4prIfIz4VMq4ag2pI40TUtE/Q/39OmEd0P0zdMamWQlJ+zPt
         86/V2PLa4GyQGyCJUm9Y3qS+QzpItzMKyX/fPikhmPbe37eMwqL4TMUnwhpdkKYLmIM/
         IQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710758411; x=1711363211;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3nNTcXNffy4KdPfHJUqr4Rqkbq2/2XQcn/yEKFcKSuc=;
        b=LLpejQcV/J+I+McpqkjuqSg0ROEFLa0enyatXvERr8vv3Sr8rCJcZ0pcWxiOTW3kmN
         7/BnFdvWlHonc2BYafByEOsp2KhkRJ4ecZEdHex7enIU7EMJs88dkt5fvTFGY8+W0/1i
         ewss8PLK/6msnQWyikmyZPAwhjiWl6OeNNJ7EDqiWgQfp5+ovfH2vvxRAYmbTFnD3Mw8
         D2UWDaxLzW0OMzYIxeb5GGdOpu2NKMSZOOgm8doZkZdY4qdsKs4QkctVGswtP8La3bG/
         RblzQMgKZzGG+WWr+FZrGIl0ptJsGi+ISGUdOHF0XG3XMeZ88ie26VGMEPrwHRpJW4Bl
         0Wng==
X-Forwarded-Encrypted: i=1; AJvYcCVsny2rTzHinjcfXP5T4yjumPX6yiI7AeQMvRFrIbLX+WLndMpsgn6cnonjtvwStNPt7T1zHe8uE9Y6g6inSsEhozAJ0ICVdSQSYZKn
X-Gm-Message-State: AOJu0YyfIftn5ndlrORUG92cMo7+4p9nea7+lkjerrRvpDxjLNpbvyFC
	0m3hnr7fkcTXudcsWlRFZWJY1ISkwEB2baMAhjMGRJRCXhlAOKHiFcL5QLRHaAYNTOmamep8rlE
	Y1oA=
X-Google-Smtp-Source: AGHT+IFsD3XyPwieL+ff+1DLNCsk15WFel5OqZJunIAZxacfoadhr6HvNJChmCWf1p/8ZTzzdtfAgQ==
X-Received: by 2002:a05:6a00:1806:b0:6e4:62ed:23c3 with SMTP id y6-20020a056a00180600b006e462ed23c3mr13506206pfa.9.1710758411364;
        Mon, 18 Mar 2024 03:40:11 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id c11-20020a056a00008b00b006e647716b6esm7838969pfj.149.2024.03.18.03.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 03:40:11 -0700 (PDT)
From: Andy Chiu <andy.chiu@sifive.com>
Date: Mon, 18 Mar 2024 18:39:56 +0800
Subject: [PATCH v3 3/7] riscv: cpufeature: call match_isa_ext() for
 single-letter extensions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240318-zve-detection-v3-3-e12d42107fa8@sifive.com>
References: <20240318-zve-detection-v3-0-e12d42107fa8@sifive.com>
In-Reply-To: <20240318-zve-detection-v3-0-e12d42107fa8@sifive.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Andy Chiu <andy.chiu@sifive.com>, Vincent Chen <vincent.chen@sifive.com>, 
 Heiko Stuebner <heiko@sntech.de>, Conor Dooley <conor.dooley@microchip.com>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmer@rivosinc.com>, 
 Greentime Hu <greentime.hu@sifive.com>, Guo Ren <guoren@kernel.org>, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.13-dev-a684c

Single-letter extensions may also imply multiple subextensions. For
example, Vector extension implies zve64d, and zve64d implies zve64f.

Extension parsing for "riscv,isa-extensions" has the ability to resolve
the dependency by calling match_isa_ext(). This patch makes deprecated
parser call the same function for single letter extensions.

Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
---
Changelog v3:
- Remove set_bit for single-letter extensions as they are all checked in
match_isa_ext. (Clément)
---
 arch/riscv/kernel/cpufeature.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index db9fb90cb272..cbdd63165e85 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -457,16 +457,15 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
 
 		if (unlikely(ext_err))
 			continue;
+
+		for (int i = 0; i < riscv_isa_ext_count; i++)
+			match_isa_ext(&riscv_isa_ext[i], ext, ext_end, isainfo);
+
 		if (!ext_long) {
 			int nr = tolower(*ext) - 'a';
 
-			if (riscv_isa_extension_check(nr)) {
+			if (riscv_isa_extension_check(nr))
 				*this_hwcap |= isa2hwcap[nr];
-				set_bit(nr, isainfo->isa);
-			}
-		} else {
-			for (int i = 0; i < riscv_isa_ext_count; i++)
-				match_isa_ext(&riscv_isa_ext[i], ext, ext_end, isainfo);
 		}
 	}
 }

-- 
2.44.0.rc2


