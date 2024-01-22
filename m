Return-Path: <linux-kernel+bounces-34196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E74C683756B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C12287915
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3256481C6;
	Mon, 22 Jan 2024 21:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k8iBUnCx"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8E4481AF
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 21:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705959097; cv=none; b=b6cUcqtx12OauehehkfNKK3GzDryaWbuKPMJlGk3Lh8j0x6kqT4YAHsDUV+49hzH1qKZszUEnyGzS/omNOnNCQAO3eAT+SuoqwhxStZCwbAl89o+FCyfMGSjSH5iIStoQxYTsDffxO7AmRp2hhVfQQoe7dedpLBoAqYwzZL4VD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705959097; c=relaxed/simple;
	bh=ZT0OpjSVGgwunUY5YCyRq+HC+sk5few4F7ciRIXkoi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rE8at5UJZKffGcdaAfUcY/kqh73b3gZvOs1JRf9mPFFy2YLxmazVQyl6IpSJsGixEXDEG4zlxDkdtoHfgOvPCehNzr2UNV5HOllk1yL98N/lwpvEIU0pFE39gQpyolytfa4PTzop4z+7TSFWkbdEPLpSegM2Z6N838ay9Pk11yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k8iBUnCx; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d7431e702dso9797975ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 13:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705959095; x=1706563895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TnqfpAGlSXCay/dPTpxKevvMK2f98rL8aVLpxsEQwh8=;
        b=k8iBUnCxiCZzgGo+MKeB4HLzjfb6GgPmS4tICxxfsPtkXX31xz9uduOEQwhtu5IeKO
         KGkpQjOkZEuLZ5n+ZMabmCz08XEz0DqT1HTTUZKHrpqrSzQpAGh+SX3eeVN1UncG22nE
         k0H1oOANVR7uHFhGmgU7pw3c2RG3wEyikfaZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705959095; x=1706563895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnqfpAGlSXCay/dPTpxKevvMK2f98rL8aVLpxsEQwh8=;
        b=GRKfPbPx8ZOokUhEy7zAfzMqHDGWGHKpGjY0WzSg7idkrtBcARDpu+RXRO2l3TsQ26
         IDGPgNdT/34TbSFPWJhryvmF+h3J8GwHcY1LaAuIgzkbJQu5mDBz2I71qR6OkEJ25aZL
         gbiMDpTGAFfG4XG3GBaZC0riIDP3ahicrt+zkXKedpQAab1FSMmJZoLqKWXdPk1co3LE
         /AaeIBwMEawlTTb6ECXoy0NrRWIEv6srqUSqtRUy3h+JLVNSbEGrml1aIik5+W8zXXrg
         JBG313auPyCPVmztXy2fT326s/OBZcMSalapI6yCZ1DLM/Cj6O+yA7dvUK65uBfltaHd
         0AJg==
X-Gm-Message-State: AOJu0YyoK5vjGor8TkDc2a7NoEetGg6xC32JbQb2dhlVfOgDoSdOLWJl
	gCVl16p1z0Yb33+pkR6tphzABlKnOlx38MIpagQMqbkSjkodue5INVxqPH0yVQ==
X-Google-Smtp-Source: AGHT+IEZv1af0Fh8VRf+gMeg2aGlHnwk7/dS6prxyiIYHBGG4vCIHzOBQYSidH0yp6ZviK/m1oBzTQ==
X-Received: by 2002:a17:902:6a87:b0:1d4:be4b:8ff8 with SMTP id n7-20020a1709026a8700b001d4be4b8ff8mr2290503plk.125.1705959095518;
        Mon, 22 Jan 2024 13:31:35 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id kf13-20020a17090305cd00b001d0ca40158dsm7691902plb.280.2024.01.22.13.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 13:31:34 -0800 (PST)
Date: Mon, 22 Jan 2024 13:31:34 -0800
From: Kees Cook <keescook@chromium.org>
To: Mark Brown <broonie@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH v2 1/2] kselftest/seccomp: Use kselftest output functions
 for benchmark
Message-ID: <202401221331.313C61FDB0@keescook>
References: <20240122-b4-kselftest-seccomp-benchmark-ktap-v2-0-aed137eaea41@kernel.org>
 <20240122-b4-kselftest-seccomp-benchmark-ktap-v2-1-aed137eaea41@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122-b4-kselftest-seccomp-benchmark-ktap-v2-1-aed137eaea41@kernel.org>

On Mon, Jan 22, 2024 at 04:04:15PM +0000, Mark Brown wrote:
> In preparation for trying to output the test results themselves in TAP
> format rework all the prints in the benchmark to use the kselftest output
> functions. The uses of system() all produce single line output so we can
> avoid having to deal with fully managing the child process and continue to
> use system() by simply printing an empty message before we invoke system().
> We also leave one printf() used to complete a line of output in place.
> 
> Tested-by: Anders Roxell <anders.roxell@linaro.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

