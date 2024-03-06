Return-Path: <linux-kernel+bounces-94162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B7F873AC7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92B8C1F25221
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381D313793C;
	Wed,  6 Mar 2024 15:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="sRWyUQvj"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDCB13790A
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 15:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739329; cv=none; b=vFZIe6/Y42ZpmaMGdifcqsxg5hW5YNoaizGDdkV+2G3YQlS+lO39kNfhR/VZDmc6bP0srVBUoGs2O0tPgDgWepC5rvK+tWh2DS8dqGAHUOh12DMM7uyxI3xBgSvLl6/wUV9U9WlZ3phXHjevCZ9omZ/gqZIwH3O9VWfnKFnfRX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739329; c=relaxed/simple;
	bh=EiaDPxdGDvN95P2aJU1WedCYWLCUVsWbHIRBxi+88aE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ri7w/kY7O0uHndmo58BI5nyT8Oh4o0VB2Q6erZYjzryH9+2RpvE0TmCpfOyxxjQNSxfeA5/fhENLN2CsWCeomVSDIIsXSNydIa6jPx/9woCoEA8a4sQ7I4LD8DzxU4byAA/XFQ/rYSIfMZqKjAq/rQLWa0J/fAGm+9sZ2VTeH5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=sRWyUQvj; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-365c0dfc769so2153035ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 07:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709739327; x=1710344127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iz9dhqOr1Ud3NvOw8Nr6oScIMnP2/c+zHKrweYL0YBs=;
        b=sRWyUQvjOXUwVj8D/0Xxoh8diWddXU4gt95TNjZbjABv8xvznqF4jHMBMkZNNG2k+n
         y9yekxZ1pxx7zG/naQ2csbZvs3vbin9SYSeYnlSu60pR03TfxaSoE1lK1C8xlf4hPfvg
         ESVbpdT9gUtSgt9kegVCi4+PVxfiu5jCowv1fCV3Q5nit3K2tyLBn6JI/EN+ItL7clvd
         sFZ+vW2wWVqMpHXFuXzPD8A8siMneZAuoUkZr8ddb4O4SMBVSxBdvi7+2xI8sfp/NVYZ
         SsbCd6lhqe/fJCps2ZObUJGhwXyoboAzu0EuBXAM3ATx0o09n/l8s3pvmhaDxXhvyfhS
         KQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709739327; x=1710344127;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iz9dhqOr1Ud3NvOw8Nr6oScIMnP2/c+zHKrweYL0YBs=;
        b=urkxfgTYDXopDARr5B0DB8numqxTwWIVSoKDYT0wDstBelnNHNPy7rmioOGDA8rMNV
         o6M+veLimOmrc9chzJ3g1p+lEsiXYAJCCEbiMGtnK2t9J4pMpy5+eSeQx4G+anmaXOlj
         Yl5XsyQyLC9545f2BFvXD1WPjztLQsO/aKIh1I0cuAfazoAwT1WSh9fz/U7Eob1eTaFO
         ZMUAi2s9Jz+IKRbgIR8AOOkRbO8c6EnSB0vruqliLQWRq+hd7VmI37R0meoAVd6FJW76
         cR326wLUzI2vjV8ZeivfA4Q7kPMTggYV0CqXDyPsh4cRRlp1oW4qd+vCrrvHzNJe60xy
         3rLg==
X-Forwarded-Encrypted: i=1; AJvYcCW9Vp6C4d3msQWVuG5zaKTzYiwBLR6NPDs8fGpj46nY6FD5qXNBgKoDvd9x8OA6daAnSsXo61GmPu32Uyfvlul1m+40/VyFt+5E0eT3
X-Gm-Message-State: AOJu0YzU5SK5IW53GNF9MQE0YUmjCHfnuDKqsvP3pZLDSYfC30a5MReD
	H5LZLcJqCgqVbYT7qYsABylm11Y5ZKspa7wMpTZKIeqPh16WghdLFWnuRmsMioE=
X-Google-Smtp-Source: AGHT+IEpMKeCNyHuNQ869Uxn/zSRMMkFXbQBjmfokpxdpjWTw93gaHDde4ZmdgkX21NmrvO6fw7Yhg==
X-Received: by 2002:a05:6e02:2164:b0:365:4e45:63ee with SMTP id s4-20020a056e02216400b003654e4563eemr4170290ilv.1.1709739327454;
        Wed, 06 Mar 2024 07:35:27 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t2-20020a92cc42000000b003660612cf73sm324467ilq.49.2024.03.06.07.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 07:35:25 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: jonathan.derrick@linux.dev, Li kunyu <kunyu@nfschina.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240306100659.106521-1-kunyu@nfschina.com>
References: <20240306100659.106521-1-kunyu@nfschina.com>
Subject: =?utf-8?q?Re=3A_=5BPATCH=5D_sed-opal=3A_Remove_unnecessary_=E2?=
 =?utf-8?q?=80=980=E2=80=99_values_from_ret?=
Message-Id: <170973932485.23995.10515626710283058348.b4-ty@kernel.dk>
Date: Wed, 06 Mar 2024 08:35:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.5-dev-2aabd


On Wed, 06 Mar 2024 18:06:59 +0800, Li kunyu wrote:
> ret is assigned first, so it does not need to initialize the assignment.
> 
> 

Applied, thanks!

[1/1] sed-opal: Remove unnecessary ‘0’ values from ret
      commit: 2449be8c8cfcbb24b3cd15d8b55c2c91041c847b

Best regards,
-- 
Jens Axboe




