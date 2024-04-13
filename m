Return-Path: <linux-kernel+bounces-143746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8F48A3CED
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 16:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5B73282729
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 14:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2B4446B2;
	Sat, 13 Apr 2024 14:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="LiA7Wxy+"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71EF44366
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 14:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713017788; cv=none; b=L7DSjN3PXghPkZ4r5eds7FkrKkNRkNxVO1IoT4hoiKBhYrHxUq3rCgV5l8KYSMk23Q+Ln531ebdP4ZsQm8OsS/k8A97lYEAU/V2DtlqAxln224TXucYkKq+MFiORha/OBtlTc8dt3odEnx9TZ/Hb81qmWctaRG/pDl4oYk6Rrwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713017788; c=relaxed/simple;
	bh=MlP++HH4Ykqei+fsV5ukk1lzmS7/YAI2GCVGI2B/aMA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YUmNXet+2M2lOdp4+rOreMj2fBn/5syAny14W8NrnpGbZ5UdX8v7yP4UQMJbr+kcE330GJZ6ft+i/FkogzXw5Kh75AlVo/6+9CiZ35dlgzw5hiktryEoNyp23CsvDTUHDoefM4ZBnohmt9jkheesao4SJHLCFkJmrojqDszudFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=LiA7Wxy+; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc742543119so1680190276.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 07:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1713017786; x=1713622586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MlP++HH4Ykqei+fsV5ukk1lzmS7/YAI2GCVGI2B/aMA=;
        b=LiA7Wxy+fahbKhamUHnXXXLzwPpvXfx7ZjyG0bwR/rP0+k0hOoRtjmdN6rvtltzP8y
         EqSqtQCXOpY4TjFnINzyutM2ziz4C4YSNznDlX6NF86D+toLKkyT3DeSTnuyudQEJGap
         rjivzpQTMSDRWBNJ/uhL9+fljPKZHIAFP7ueR63oHSCQdgo/qWh9sNFIyn+cL+FluxUV
         UQEu+yo87yhARfu1AFpVn4wRypXb2VSFBFQEZ0PdTSPRt7652guMIg6H9rE7gSXdOUm1
         sP5QwKImjRxof0Nwwe2K7enpisBdlFW9CRjXwhplVvtwNsiOuJDxyYUNQdFABOIjwmvU
         d95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713017786; x=1713622586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MlP++HH4Ykqei+fsV5ukk1lzmS7/YAI2GCVGI2B/aMA=;
        b=BLh7+WNNT4OqJN4tj9TPG+4aMoDpy9chDI0Sv0osIqGxUqwgtPRiO85TVKfT5tdToV
         T+16s2KZ3eMQWMzb6ocWeuQeQ0PFzBT0oF0OxFKisY6e1hjZX3rq6imwmBnjFQBbxj/n
         a8j2bpKJvRJ8bObW3axHOAfJqEMQ7Q9y1MAET/jBC+NuiJte8RonVnwkJ5VTkSydOgJT
         Ou3aInrPgtTYVQ8uLc4PZz6DgN+fqGkkZC2dth18hkmx/jukeNBP0H0j5qpo6mw90BtF
         EkmB1+4lK0nr8xmjKkHc7LYvk+PF4cRx2vazti6oYmbA3gBa8ri9LXc1wReb+Lee721H
         j1lg==
X-Forwarded-Encrypted: i=1; AJvYcCVhU/a9tLumyPN060vNoCacSmChqNrmuflm/B0VMqs5gESTTiaSl7Lk9RiCNuUuUMOyvOfFVOz9GJpjn2BwibAwijfjZCdw4wyckPqj
X-Gm-Message-State: AOJu0YzgIhgrcYECXiix9RpgGwjNEnQhlo+uP92AO2Aqnq2iqyeSGrtZ
	5XSHTvzwhljVv7sEetgo79Y/nKves9902Y7ra9WSltbT+cLTJ3E48V95qF2dpErJIVsYwK/SDVM
	=
X-Google-Smtp-Source: AGHT+IFuHa3D0Je35D8F4xPFU0zQxnZ8JKzo/jGnqcb5+esEWbueGhZb6CdbF82R9aU1KpJfFAUP4w==
X-Received: by 2002:a25:b208:0:b0:dda:d41d:332e with SMTP id i8-20020a25b208000000b00ddad41d332emr5969909ybj.44.1713017785742;
        Sat, 13 Apr 2024 07:16:25 -0700 (PDT)
Received: from ip-172-31-11-157.us-east-2.compute.internal (ec2-3-145-99-109.us-east-2.compute.amazonaws.com. [3.145.99.109])
        by smtp.googlemail.com with ESMTPSA id v5-20020a254805000000b00dcdb6934617sm1193349yba.62.2024.04.13.07.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 07:16:25 -0700 (PDT)
From: Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To: Kyle Huey <khuey@kylehuey.com>,
	linux-kernel@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rodgers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Robert O'Callahan <robert@ocallahan.org>
Subject: [PATCH v3 0/3] perf: Trigger IO signals for watermark_wakeup
Date: Sat, 13 Apr 2024 07:16:15 -0700
Message-Id: <20240413141618.4160-1-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

watermark_wakeup triggers poll events. It would be helpful for rr if
it also triggered FASYNC signals since that's what we use.

Since the last version I split the main code change into a pure move of
perf_event_fasync() and a separate behavior change.



