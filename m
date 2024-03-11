Return-Path: <linux-kernel+bounces-99524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8410878994
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F089A1C20D83
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39705787A;
	Mon, 11 Mar 2024 20:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBh6vKUT"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7855579F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 20:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710189652; cv=none; b=uYZ9qrTE44WOFQ4fMvc7QQRJ4F/rTz1/i4De8ctRJN4PWhPILX2u7QwZ4yqm5i0oinSi6ToFHNte8p7huChDjnuz/f+hotH1YBAS8IsdyTQCuNAW+thSgx80Rqfbt+kkxJahtPVqxUJ+0Hy+GZkz29/sdU3zmwVYMBpUk5x9X3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710189652; c=relaxed/simple;
	bh=hVTH5bLCNmcxmn1AYn7nqYIKnxCb2Ab5PWYay7BarHM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MOJAs5Xt8Z5MeTh99aVEeJtosLak5HR25Gs7HXl1aIF+pQD8S5CgpXlPCOcWBr8pV2nqJqTx+0pk1ffh2Z0oDhrlNCg5+bq49bXb+WoKZRoUYUwrIGvurDJUgmEVA+jmUBShSbsIwKu1lWFSuubg1gmC0iTidQMekidNaP3qmUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBh6vKUT; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-513a6416058so2063661e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 13:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710189648; x=1710794448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ftY3ceO7IaWaPhjW2mEyGYWXSld3NmgLxCpyOgogGis=;
        b=WBh6vKUTiT2gqu1cHdz2+VgBKIQzNRZkn04q0OChrL5HllEbRsEHfXKJZuE2FQ1KfP
         cB3rPmA2VKknu9++V22vb/df0msxxcpHwI+kHiqhxWIC3lb5+JlVJiwtVb7GtsXeFPDr
         9k8RRjc/l0766Aa+tv4pymcUw+cidLm2BaaVp/6dAWzmi4qY6ADDc5WXQKvPXXJIP5Y/
         Nf2Y63tgUqJnpcTZnTjawj7UhL+UvsxZf0bC5pNboY99g5aLSVPAkAwSaE0BWGKWewjh
         5wjyn6X2s1YKOX+PFkf7IQlu6snCun2VW3ehcZK3afWSySdHXoK4ScXWJFJD/i4cRVbB
         opLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710189648; x=1710794448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftY3ceO7IaWaPhjW2mEyGYWXSld3NmgLxCpyOgogGis=;
        b=VOjYqiSCNXWM6wAaPxbjAb+ACiHSuPfH/KvKA8fV97oxfGWx1NiyQlD0hIepdkaNIS
         /biAQwZd6OJ/Sbi5fNjjNiA1ZUStithePaYqGopyGVUaXxlCXWy87GONryuNhzz1MY8z
         yIxn69Dw/Od7zSwHPSuvimJlIyjZOOgTQsyVMLDix5EMTpdgrI527RwJmwPNMWTm4klC
         jxgbVPsyLvvlXnHKa9HXW00bVIpnsvE5q5MY3Ru01zb+ILR407TnenkUg1E5KWRCt0jN
         N6Dg68DbLzHpEExGx3RKMQ72EW57NViBukVIFiJtJPeID4Nk2nu/14hsDSDoSFncoqPh
         wM4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWRrzG4z74Zh8g3fJMDgYrsg//5HKK6yRLRKqzqwJaRYh4AXUuTzl/h5LnwGepGxJE6CN97wqgbiDVBs6K52hSsbybEPhG2aV6IH2at
X-Gm-Message-State: AOJu0YxeQ6JWa0RbY5PLZDhJwNa9nBzqfPSbjbc4BB5NmfuxQOBJPlSC
	/ykG9rALp1BHWNo8304j5SW4joS/mofWswX8hiQUfIDm0lqoLuvF
X-Google-Smtp-Source: AGHT+IEuo38Nj/u+0ocEJLpw0I9lkC/BxLBa+odAtoJ4d87TGgThDX6RvVzq64ymJi8TTt5sFXXRig==
X-Received: by 2002:a05:6512:49a:b0:513:aa05:9ca6 with SMTP id v26-20020a056512049a00b00513aa059ca6mr2545016lfq.49.1710189648428;
        Mon, 11 Mar 2024 13:40:48 -0700 (PDT)
Received: from rex.hwlab.vusec.net (lab-4.lab.cs.vu.nl. [192.33.36.4])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c198e00b0041312c4865asm14929355wmq.2.2024.03.11.13.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 13:40:46 -0700 (PDT)
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	linux-kernel@vger.kernel.org,
	Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Subject: [PATCH 4/7] scripts/faddr2line: Pass --addresses argument to addr2line
Date: Mon, 11 Mar 2024 21:40:16 +0100
Message-Id: <20240311204019.1183634-5-bjohannesmeyer@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311204019.1183634-1-bjohannesmeyer@gmail.com>
References: <20240311204019.1183634-1-bjohannesmeyer@gmail.com>
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


