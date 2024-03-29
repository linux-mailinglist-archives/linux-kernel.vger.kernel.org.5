Return-Path: <linux-kernel+bounces-124367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C23989164A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACE1D1C23486
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1504524D4;
	Fri, 29 Mar 2024 09:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msykGo5F"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657D33BBDB;
	Fri, 29 Mar 2024 09:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711705768; cv=none; b=VGWWXc/zg7h8SKjkJTwAiiIEjciBwndWPkPGSXjoUCi/GibVDAaAj+Lu+IuMRkykQ1Ijes/LnhSZz/FxIeV3+nHTw+ssGBq7g1pR7XhGEl6Fpvqb21R74xWpGpZDV3qjwJwQPb1g53VmkbVluULdTYpt+KKwJ6SbvYO1+2oQg18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711705768; c=relaxed/simple;
	bh=1c0GfFEPUmmfZMeB83civMHb91mX5T3u/YH4/WLOdpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dnVRmh52G5WzZFGMijW+PjJ4PNpSW4MraytlU4Y8dPyKiyQIQo94ElLzyJNmPatOYYDF2/WWUehbPF4j2VQpgnDx3ASdhgSOL0VT6RSXAUoNbrwo0FkK6qco7zo2uUDBLw4DiowX3u7EeC3VT9B0zAgyhW/kYR89/nCug/w3YMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msykGo5F; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56c4ca65dc6so2221190a12.1;
        Fri, 29 Mar 2024 02:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711705765; x=1712310565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+53nVtKSv5Jk7rKbaYFDJuz2r5jEU1fs9QHE79j+A6U=;
        b=msykGo5FCZaEasP28aBRd1Nx19ugBI/pwIPMN9qbtca0GUlQg1CQqlTqCPYAiQSMnZ
         Oi95LoFhQCyrz7IqBEaBJ/u3rbsn/e5mmj9ayH8DfAT8rCing8rKDaR+7DrTAOs87Mdy
         CWMXHXRB1TiK9oTIHE7vxVpZuxSHFkh11YpT4VO4LHyCHzOxdyrMWdMWSvMQcavOimdB
         yPDaqdZY8W6wn0K65zSOyl7tkOuv34O3BsT/LJtNx8eSNr6IyM0Un9MGoP95nROxxCRk
         nmKQUqjZLHyQcxi/0j+g5d6yYLPYxXRtmNksDMpNErt1SVmv6CzSGhLx64xWNs/Q4Pwd
         mEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711705765; x=1712310565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+53nVtKSv5Jk7rKbaYFDJuz2r5jEU1fs9QHE79j+A6U=;
        b=n/9JMR5/TgZrfIv83ALUHFVz5uqHMPj5YMwsctob2DFGaaYYbhX5sE2u6ppoTaf8aE
         2wWV+cgJCj/RcPhcQRx42E880S9x8vg/7ilS6QqU2kKOCwKpchETJ8NbNVRP5GAPFwpH
         SQ92qny60HL3G+zX9tKApZ/RbzfRizHEOL7ykvlA+fBFN9BHLJgcotkfel+/9ydqhEgw
         EpPlmlmrh0w6YAFlwTbhBULPcWaGXGjyXtND4dn5Fy81tuUl0/olRV821TF7pmJgt1g2
         +ZIzzlKcf4O7AsPVJgn9aoKP71L1qwQpE833fcYJIor7kFDM+Tr4GtdMzH3hxrfmBXfO
         42ow==
X-Forwarded-Encrypted: i=1; AJvYcCWKyfF9ubzs/Wh6MQTzrpKaNzRhe0lFtgy990BFDwcTxq1GK3zBExF+jyMnp75CSfkFybxTCGsjkoolT0gaozRkKXZsjGR2h2T2/P5wMYXtm8fqHb5tjdFBFi+nttJ+zoHvuvQGpadvMiiNsIinGCMvBiaNNZy4R+rg
X-Gm-Message-State: AOJu0YxoZoR73OvPELyAP9aL/tuiip07Q8DTXAwAOcuWqkiGyWtmmrP9
	6a9nWVdlkvG4js0JV54ncFQ4pg8/lDjgW10o94mSB6CbN12NkWKx
X-Google-Smtp-Source: AGHT+IET1giK0nCDgaaYNoRofNa4LOOOB4uldHyP/oj/iDaFmAcLATci4GlKLRHJ6In34vRon/dcrw==
X-Received: by 2002:a50:ccc3:0:b0:56b:9f82:4a40 with SMTP id b3-20020a50ccc3000000b0056b9f824a40mr1202811edj.11.1711705764508;
        Fri, 29 Mar 2024 02:49:24 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id b4-20020a0564021f0400b0056c1cca33bfsm1829733edb.6.2024.03.29.02.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 02:49:24 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Joan=20Bruguera=20Mic=C3=B3?= <joanbrugueram@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH RESEND bpf 1/2] x86/bpf: Fix IP after emitting call depth accounting
Date: Fri, 29 Mar 2024 10:46:17 +0100
Message-ID: <20240329094906.18147-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329094906.18147-1-ubizjak@gmail.com>
References: <20240329094906.18147-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Joan Bruguera Micó <joanbrugueram@gmail.com>

Adjust the IP passed to `emit_patch` so it calculates the correct offset
for the CALL instruction if `x86_call_depth_emit_accounting` emits code.
Otherwise we will skip some instructions and most likely crash.

Fixes: b2e9dfe54be4 ("x86/bpf: Emit call depth accounting if required")
Link: https://lore.kernel.org/lkml/20230105214922.250473-1-joanbrugueram@gmail.com/
Signed-off-by: Joan Bruguera Micó <joanbrugueram@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/x86/net/bpf_jit_comp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index a7ba8e178645..09f7dc9d4d65 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -479,9 +479,10 @@ static int emit_call(u8 **pprog, void *func, void *ip)
 
 static int emit_rsb_call(u8 **pprog, void *func, void *ip)
 {
+	void *adjusted_ip;
 	OPTIMIZER_HIDE_VAR(func);
-	x86_call_depth_emit_accounting(pprog, func);
-	return emit_patch(pprog, func, ip, 0xE8);
+	adjusted_ip = ip + x86_call_depth_emit_accounting(pprog, func);
+	return emit_patch(pprog, func, adjusted_ip, 0xE8);
 }
 
 static int emit_jump(u8 **pprog, void *func, void *ip)
-- 
2.44.0


