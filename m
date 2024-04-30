Return-Path: <linux-kernel+bounces-163280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6122E8B6823
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 178B31F221A6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F208101C5;
	Tue, 30 Apr 2024 03:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mkGoDDhD"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3847DF58
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 03:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714446294; cv=none; b=amZ57lvYmzDJMxpGdzQfo8vpJB4fUzoTmtEEDf/PqV5/9bNZLv2I8MrB9OR86H5eQ7FHDaegoyfd7GtuqqPuB8BCmf924va6BrQ+XHCBrTcbacmSTXMO6fyacwq/fHj05PhdnuRYnkIRiBkAs8MFQbS6dg7vTQ9ojQU7LT9fON0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714446294; c=relaxed/simple;
	bh=S3dcFG9nl2arKz/OB2xphR0OKK1uAoMU8ChtHy95lPU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=addD7Oh3M/FriyAxgFyjqt38CYpVfZJ7UrD32W+Np0N0dXJEjhmScIG/5iXHXAcI1QNKLuWTuuL2K/Z+/eLmnTa8//cbM0jdNMR05UlFck2bV2v72t10Plg5UuoJJCEI3Ouc7yZsUk1Mm9UEvAeFh5oKfDBj2hlHTrXpQoEBAuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mkGoDDhD; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c74ff209f6so3445881b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 20:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714446292; x=1715051092; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8GmvV6P1saiYDGx6aEXWiDKEEjYyVwYItU/oo2t7qo8=;
        b=mkGoDDhDbcMXpOtD/awIvRX4i+T7K/WTxQ0BZp0TQ+JNGgYl+1gbIM/hrM4st3dhQ8
         SkFJRwxtRDWd2A4VTjLpBk8p7fGivV0yd9DbKMyHgDeD3zQ1JwDx4wA4a88thHVT1u+O
         AQ1G33mQsFMpbMyzADAjCqmtZSscC4wNcEw94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714446292; x=1715051092;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8GmvV6P1saiYDGx6aEXWiDKEEjYyVwYItU/oo2t7qo8=;
        b=QZNfBJ6Hrj+vdLPBATLOchxwcny62GFYUj1YVD2EJ3CnSp93kJ++C48EU2HAr+UN9w
         /7aQWLKm+F6Mpu4HLP9+6xNSYLcRsZu4Oz3t1WxxNGjwYP9BLixM+rA7TOnm8aHs0FR5
         8bE6lAHRxrNAJ/0jMdxQhSgZT9zW6JftM/9hSGUWy4ZnKFQc8PKufXPyEphtKPdEfDKd
         Q/gmsoHN61zu91wOHqZiXFA3mVr+kHv2eJq01u/KSh0DF5sHGxp87NWF8GDpYAU265O0
         zR/jfznv0QJKNJ3ry+z+uxFly6vcH3aG4HAEaHd8knkenPwxMMo+UfdVlySxKZRMT5H6
         JFbA==
X-Forwarded-Encrypted: i=1; AJvYcCUg9+i0BPnv1zoaSSnCCfsNNGP8XJfYVRjZIau6bpNSJczl6SQOtn3GqniFqqwjnxIN1C2nE4RbhrzocZhHxTu5Xog5yHqWJCLLjJW9
X-Gm-Message-State: AOJu0YyBHjPs38+GlPI/8nGOCxF9eE5SsIaVKolDa95ahfZzmOtju8Pk
	nRc6pccyf0BRK58alYpev6K9b1CCysqcx3PdHls/Z+ytTk7r5rsjuK2JfNu2OLpo2Rkv/M5lucY
	=
X-Google-Smtp-Source: AGHT+IHoOv2bed294ADi560bgBmZKT/Ayee8+LWb6/uFb3ODkPyPBkr3pKvDObUtk22A6sGzJHMfUA==
X-Received: by 2002:a05:6808:4c8:b0:3c7:3af6:1cb5 with SMTP id a8-20020a05680804c800b003c73af61cb5mr13307260oie.46.1714446292049;
        Mon, 29 Apr 2024 20:04:52 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:e55f:86cd:c9e1:6daf])
        by smtp.gmail.com with ESMTPSA id g7-20020a632007000000b005e83b64021fsm19850926pgg.25.2024.04.29.20.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 20:04:51 -0700 (PDT)
Date: Tue, 30 Apr 2024 12:04:47 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC] crypto: passing configuration parameters to comp algos
Message-ID: <20240430030447.GE14947@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

	We'd like to be able to pass algorithm-specific parameters to
comp backends. As of this moment, crypto usees hard-coded default
values and does not permit any run-time algorithm configuration,
which in some cases simply disables the most interesting functionality.
E.g. zstd can be configured to use a pre-trained (in the user-space)
compression dictionary, which significantly changes algorithms
characteristics. Another, obvious and trivial example, is algorithms
compression level.

The problem is that we need to pass params to cra_init() function,
because for some algorithms that's the only place where configuration
can take place (e.g. zstd). Changing cra_init() to accept additional
`struct crypto_comp_params` looks to be a little intrusive so before
I write any patches I'd like to hear your thoughts.

