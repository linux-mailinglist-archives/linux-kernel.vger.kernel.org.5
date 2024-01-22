Return-Path: <linux-kernel+bounces-34198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BD1837572
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E42B288F29
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61A1495C2;
	Mon, 22 Jan 2024 21:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GdZ4fLHf"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757B248CF9
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 21:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705959146; cv=none; b=fa3Vd90dEv4o4zMFJdAlmRAoKiefvf1NPPDjgUJdQHfx5RR7MGBDKHZsLlp+E2UNqOEu/oWYneGwP588Q5jXTF5KoUrnJBMZv6g00+inQezuVXUDHyJOczYpfHNv8iWWIyMCU/SyigE14DS+4egJbGiMwePKeZe2wzNamhH5PRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705959146; c=relaxed/simple;
	bh=ib9SRx6LkRZhW0h8GTNvFlw5bOTy+G6SkrbOyw6mexU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwilNWhejDblwMvqUOxqAobjKWsjfinYEVo9JQhmuboLJjfMxFUo7GDJ+hlAcihnSD2ktx2j7QeBK8scsuOZaie4hh2XUIPV5ng8B1oIL2JMW3e+oW+ML+kCM5cVA/8vDYG2k7tLerpEoUG4c9Sfu7lbMtf+eOiNNUb/WXPotH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GdZ4fLHf; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-29041136f73so1728413a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 13:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705959144; x=1706563944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p2tdYfbNQoyjzZj7eaSxYMIkM7B/ZoCmtQ4lSJqnD8c=;
        b=GdZ4fLHfjIom7nqWKjCRem6qs5dBl8yxh7nvAplvtoAU8cMoELzqYo5fnfP131teKo
         /GVvvDQJaxx8ykGOX78iefYktyyHHW5U3fSQRSWMBGUf3sH2qrQp1jHhHtYw//1K+v83
         HDxwe6Urf9/1Plbftu00LiETFusyR5Gw9z7u8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705959144; x=1706563944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2tdYfbNQoyjzZj7eaSxYMIkM7B/ZoCmtQ4lSJqnD8c=;
        b=arnBzoUsOftxXVZLyAUpiB24GTKWq2Ryw5upsKED0HR2zqXoBmjMNBoHoz18OimLPi
         K2mpmW69w5IDRPy0adzKefx9fAIhVuexbG5FVjcK/YL2MTYLFGdk2l1JAFQ4OlmN606y
         kBzYjDhMHYibHlsTzvQySKAaAS5bnGLitqvRgOH6KZl5t57lE0ItIOZ3ErVVfCQW4Vrr
         BeydkTWAuzdeURPbKE43Xwh7egInFb9iIIppPDCxruzHPV9roXT32WDIm3+cpQ1AETAJ
         9vQkltpgEU04STCulDqUtep9KVPOr/x2wCDJU+rFRUb66B4QL2k47EeQWwEfy3sKuHog
         RZFA==
X-Gm-Message-State: AOJu0YwbC9XHonSMzrRnd3BqroPDOEfMkpeeIxMX6W6gTws0J10cnbjo
	M4DyeyjWeNHlLRelI0+xGEyxLoL4BHA/hEQ9ryOOKr/qTtRtx/W5F/QjxU+oRA==
X-Google-Smtp-Source: AGHT+IGdkKz4GRznsc9nMqPp0DRrGmKeDjzgFkStSku0s5GucAOpHvh5RPL6OnXGtRhfhoKOtrm6Uw==
X-Received: by 2002:a17:90a:a793:b0:28f:f4fb:f791 with SMTP id f19-20020a17090aa79300b0028ff4fbf791mr1787141pjq.94.1705959143945;
        Mon, 22 Jan 2024 13:32:23 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id rs7-20020a17090b2b8700b0028d70a8d854sm10131048pjb.54.2024.01.22.13.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 13:32:23 -0800 (PST)
Date: Mon, 22 Jan 2024 13:32:22 -0800
From: Kees Cook <keescook@chromium.org>
To: Mark Brown <broonie@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH v2 2/2] kselftest/seccomp: Report each expectation we
 assert as a KTAP test
Message-ID: <202401221331.2EE8F668@keescook>
References: <20240122-b4-kselftest-seccomp-benchmark-ktap-v2-0-aed137eaea41@kernel.org>
 <20240122-b4-kselftest-seccomp-benchmark-ktap-v2-2-aed137eaea41@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122-b4-kselftest-seccomp-benchmark-ktap-v2-2-aed137eaea41@kernel.org>

On Mon, Jan 22, 2024 at 04:04:16PM +0000, Mark Brown wrote:
> The seccomp benchmark test makes a number of checks on the performance it
> measures and logs them to the output but does so in a custom format which
> none of the automated test runners understand meaning that the chances that
> anyone is paying attention are slim. Let's additionally log each result in
> KTAP format so that automated systems parsing the test output will see each
> comparison as a test case. The original logs are left in place since they
> provide the actual numbers for analysis.
> 
> As part of this rework the flow for the main program so that when we skip
> tests we still log all the tests we skip, this is because the standard KTAP
> headers and footers include counts of the number of expected and run tests.
> 
> Tested-by: Anders Roxell <anders.roxell@linaro.org>

with the S-o-b added,

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

