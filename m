Return-Path: <linux-kernel+bounces-121331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2E288E617
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 612EF29A0C6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF541386B3;
	Wed, 27 Mar 2024 13:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuE7BYnN"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5600D127B74
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 13:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711544405; cv=none; b=gUJ46IJPOWo0rmdw5uA6D+i2LMbR8WT3idEUO0dvAc0r7Nw3oFQIRNgJCcWCf4oGHlp4KG2FzzPfmduxnTMcuNqx/GQqVusProUAyc0fBeQzbYyK8ljAeO8tIXKqykcKPupl3rrIE+aZjXURIp/dsbK5Aipnzh9vLmFy24wmGQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711544405; c=relaxed/simple;
	bh=4HVEa/HFe7JX/HhqqfzC9fsfq8bO473vqm9Cz9tqeHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BnlJ2qMsrUVSV3mj95EtvfzBShIkeKUNJWQZiZe5Nq9bS9uTsXFTyFIk83vDFCAzz3UGtJp98UoT5o4RBK8bJhnGY8LDP8LVwBqPg2649Fz/34Rfq11iB97HYODBYKhAmcy4McDX56pHJJEQEIU2L0amU/jvon2/TZ9ZHWD2PgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuE7BYnN; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d52e65d4a8so89174401fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 06:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711544401; x=1712149201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HVEa/HFe7JX/HhqqfzC9fsfq8bO473vqm9Cz9tqeHE=;
        b=AuE7BYnN4IJX35/2w2jhwGbLEMSjyHLOWP3OiWvBPtRyHDG/fmkEqclaEF4zF3hTz3
         Rq2Xc6nzELh7i/Mg+ninYPz2x9OxS8vBBc6W45UycknB74x0JN4BntrrWM3TZYHq2Gz+
         k/bBmDX/6GN5dXnLfZQA9ty27ht1/vh01G8JhloI5RLOntXbfqnwtvEqXGRVJiK14VdL
         D0qERiEQYEgd+ijkpWfHPPCJ3fuZKUQ7cfYBiT2X0p8hZupQSnDaK/m/GcGNOvEa+Spu
         O5HOUp74czJzEw9HaS2B4imMG2rVzp6rsKO9RrtvshKlGzZl/5yB+XmBNtuLOOr6X4FU
         kO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711544401; x=1712149201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4HVEa/HFe7JX/HhqqfzC9fsfq8bO473vqm9Cz9tqeHE=;
        b=Fj9EAb5Xd+aFUy+iQ6khz4vwuzaQ4zykw64PMU3lMWw6IZneZkMR6+xol1um5gbs1J
         GvRv85RxwBet9BDvf/Kx8u2luNL1m2xtZj2qSfGC95zuRw7CTJ0RuFJA3f4KbQJCnCdT
         WwmrtTHvcjdl+zQpDjgH8UAV9aoQkS8+x/aC/b5RQ8PEWSUIwkerKo7/bfCw4ydilihW
         MmGGhh3YWz0oKnj/KxcOLmr8TKMyBrm4i/u8uRynPrUVXTqeE+ispuoRYj+o4wZLBaUn
         BFm5wEOkdewKY8y1G+ePKD9Am9U/rA8ac/KfDZXxPPy8zEgpM5KsM/E2jYXd0eFfiPtX
         AmRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvcblXhBPsSCEmoCDnzehVwKNtNq2V5NK+WhYWQaWrk3RNd9lNePu7eSQWeU+4HNp2jKRFHLM2ISEeivFZn5SKc4HH2Jqmto0lZ7yk
X-Gm-Message-State: AOJu0YxL2/nyvoSSG3XVvOrng2MS0PGtmV2gKU01AoSyDFJZyOFQZ6dk
	SWFUAy70nQ4wzs6Jrdx5NZ2COFeVF2yt5ne5KFXpBG3migoWNbIS
X-Google-Smtp-Source: AGHT+IFouCRNYkYRV67WQAcwc9OED5iUKbO3r0hO9D8ZlgmVAFEp4RjujTC7cKTS7untWOjRuN2gSA==
X-Received: by 2002:a05:651c:1037:b0:2d6:cb82:24e6 with SMTP id w23-20020a05651c103700b002d6cb8224e6mr820276ljm.37.1711544401122;
        Wed, 27 Mar 2024 06:00:01 -0700 (PDT)
Received: from gmail.com ([104.28.160.248])
        by smtp.gmail.com with ESMTPSA id c21-20020a05600c0a5500b004140c161e8dsm2096164wmq.43.2024.03.27.05.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 06:00:00 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: christoph.muellner@vrull.eu
Cc: ajones@ventanamicro.com,
	alistair.francis@wdc.com,
	aou@eecs.berkeley.edu,
	bjorn@kernel.org,
	conor@kernel.org,
	cooper.qu@linux.alibaba.com,
	dbarboza@ventanamicro.com,
	eric.huang@linux.alibaba.com,
	heiko@sntech.de,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	philipp.tomsich@vrull.eu,
	zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH 0/2] RISC-V: Test th.mxstatus.MAEE bit before enabling MAEE
Date: Wed, 27 Mar 2024 20:59:54 +0800
Message-Id: <20240327125954.1809-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327103130.3651950-1-christoph.muellner@vrull.eu>
References: <20240327103130.3651950-1-christoph.muellner@vrull.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Christoph,

You don't need the access to MXSTATUS. There is SXSTATUS which is a
read-only mirror of MXSTATUS in S-mode.

