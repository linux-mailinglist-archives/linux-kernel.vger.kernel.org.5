Return-Path: <linux-kernel+bounces-157864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B140E8B1787
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2F971C21A52
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0F216F914;
	Wed, 24 Apr 2024 23:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OGpXuUG6"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E215E16F28F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 23:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714003078; cv=none; b=Arya/iUuoothM4hbqbE7CNB3CDYvhQUY4qLJqfF40xWwzqjL8YcujL3IdpKepJlV/l4RDbD1eJn96HkRugbBlZvu+aheZLTZ3P/cqhMezFRL2GS2Jv+OxRLN9J3+oOUFhvRds3qIWt3kBTzvEwyoxJ8/jGT2IiMxjqYf2a/iM54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714003078; c=relaxed/simple;
	bh=2BPOK2dXp68uRp32sm3Gx35HN6cr79+4gRYJiNQfSb0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OX+nweE/lVr/AItI0KTQHv4vQfkkD5rU1NJmfTa7DjP7gUkVudYiom+/DHioY8qGqBuM9jmzjfzO2NrP2DenAYYBuaBkYXWKyW7LbhRhXO0CSbj9Zj47Ktg5fIz5HNfAf7oPxyn+Y+TvLvUVLtTHe11NB5yUSExoC07RxUqX49k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OGpXuUG6; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e5c7d087e1so3707725ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 16:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714003075; x=1714607875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e23zJ4CHX7X9QHhycswSvTOYU8EPrilYR7yjQqTKu0w=;
        b=OGpXuUG6Wkwod7xRqgxyzZmooVCbNdmE1ig7rqUoSx8FjAW5zJ5xm5DjC717BX4t1i
         KQmPN4+Z1stCbQSXEprOyU0F3FSImrrD6FecJakpDxIsMXQisRv/dDvpXuPzb9WvJIhj
         QYitEDyrr52UxMLEU8jfknewcrKs/HSnTfoHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714003075; x=1714607875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e23zJ4CHX7X9QHhycswSvTOYU8EPrilYR7yjQqTKu0w=;
        b=eiuqIOrbf3UyAGvL30Wji3NnIG+cgHmv1BgHyFL73+G1IbRjf5oW/vQQtxio5f3irJ
         ZbHqvYH+43N+u4yB1JZri3zhb/nX0WldebLftQLfncQLs1cawSdILS8vG3bfboV4WTMA
         9l0W1fosET7qTrwaX7b8jAVpHJFDKUBTmElz5fByKvQpZgJbVe8EU7Vwj56jX/z7mS3I
         cas0LnKTpfb7jVWc+W6hN3dRkFs8l9iU1XzF9p2J2BFAhoFRSzEDu82GVB6g0pKYFAGk
         SdWZkBLcozu0JUpta4FAjzXqvsDGnr5SxMqhcZjJQ9HmXVZEaT4evi/drDt4WynQnlMb
         0Knw==
X-Forwarded-Encrypted: i=1; AJvYcCVxCJFdmswkQtNnmq4FptWSzu8qeb9sWAfLK5p7nBGU12/N2Ac1FXgmUzCW1Fn+EboQLWpr6rJRmeY8Em5RSbVLXaDYd6YePCqkgLyP
X-Gm-Message-State: AOJu0YzwZEfUcC03sXCrmgBS3eDvUoXGLu1s098D4VMevI4Shaw7nfKi
	Yd4rqmTqVJ01k1Tk7oiW8VxH4Jzih/XzMcd6kbCZI3h/wLPAOlKJCH/cqgLT5w==
X-Google-Smtp-Source: AGHT+IEg6R3vEh56TTakIcvssFRBm6oKPIjqtowedm88ZBAYnPxmpoFXQv3vGsHKFQfG284GpQnxiw==
X-Received: by 2002:a17:903:2445:b0:1e5:4f00:3751 with SMTP id l5-20020a170903244500b001e54f003751mr4274814pls.3.1714003075262;
        Wed, 24 Apr 2024 16:57:55 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902780300b001e7b8c21ebesm12661739pll.225.2024.04.24.16.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 16:57:54 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Tyler Hicks <code@tyhicks.com>,
	Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	ecryptfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] fs: ecryptfs: replace deprecated strncpy with strscpy
Date: Wed, 24 Apr 2024 16:57:48 -0700
Message-Id: <171400306698.3284237.12157230203492551357.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240321-strncpy-fs-ecryptfs-crypto-c-v1-1-d78b74c214ac@google.com>
References: <20240321-strncpy-fs-ecryptfs-crypto-c-v1-1-d78b74c214ac@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 21 Mar 2024 00:38:54 +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces. A good alternative is strscpy() as it guarantees
> NUL-termination on the destination buffer.
> 
> In crypto.c:
> We expect cipher_name to be NUL-terminated based on its use with
> the C-string format specifier %s and with other string apis like
> strlen():
> |	printk(KERN_ERR "Error attempting to initialize key TFM "
> |		"cipher with name = [%s]; rc = [%d]\n",
> |		tmp_tfm->cipher_name, rc);
> and
> |	int cipher_name_len = strlen(cipher_name);
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] fs: ecryptfs: replace deprecated strncpy with strscpy
      https://git.kernel.org/kees/c/9a2780409552

Take care,

-- 
Kees Cook


