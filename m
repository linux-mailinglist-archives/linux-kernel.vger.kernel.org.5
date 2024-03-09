Return-Path: <linux-kernel+bounces-98033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9318773E0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 21:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C92071F21808
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 20:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7594D10A;
	Sat,  9 Mar 2024 20:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H0VGmGZX"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BF422F07
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 20:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710016437; cv=none; b=tvVcXyuByOcVk+hLb1Fe3p3zEAyEgjUUbDk4tEdR9X1nty+jW7iU5zUsogmTxjqm7oFlXFp6dK5pn9Qf3gpuKY1jF028n34ngf2RMIFg0oAsgTsuLDynBIvjWuRcb9pan1dJ6qJNyOTNGUHvXkkivs9wyszvYBx+SmQNzse9q+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710016437; c=relaxed/simple;
	bh=EcVIXfIICY3Ok2eDXhdHjNP9eppBGwoPoBbQbWCdGQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GvjWiv58EEASa3l6nsLTGphskyQki1SEfivj1xH/yO3+UxWjXWb3Grye8O7L+6jI3Z6QAdusmrTqrcdKMlWai1sPswllFd0zOqfEA1tfUQ1uIUAmJInilOA859oVx5UQknSOW7NygnhDOSzVbJrSlOZyi6L50eW6cZFgVREE1C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H0VGmGZX; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so2722507a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 12:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710016435; x=1710621235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsLvds74XFvPRZt+5SLhXxXFTA14aJAZhNEVhjPIrvk=;
        b=H0VGmGZXyUF+OV3/clYF/ovjxWbHc2nKovGKsUKXgr4m0F4BoSTLxopfmw7MHCxtJS
         Qf384rAFnF8rjq+UkIiawNKdPbYQytf8KSQAl8XnilBaIEKmxR84O4F8DTBPjC9KoslF
         3L0f/k9BPEJqOdpVWpBiJaTXmfgwoZieyRfVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710016435; x=1710621235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wsLvds74XFvPRZt+5SLhXxXFTA14aJAZhNEVhjPIrvk=;
        b=IHRnbzq0kBfnUfGlo/LpDPk/13AGvNlssc5u3t4rKpjQ90fLiJZxE3oizdgqFSxegJ
         wX4739MUr3PSL5r6OaSuqioaYXYpyi+0gZeTADTuUjnYN0eaIoXZgRyrBCodkurj+Dir
         tna4Ukr7YIjHIn5Zi4t5Fcj2QbEHtc89j4f5ztij26U6FWaBGUf8ee0To2avpvhuqSGD
         YR7ADA7cONrpfrFF1AC6UmH2FSOrGslYb1SH5bcpnjkVZsZOv2liKGzZzcDPDZujxwis
         UnA0tPePjMuYv7sYrFiy1nmNvemda7U1BrWDf76IvmWY3TT4q1pPAC0SeoFq/bf1hA5e
         af0A==
X-Forwarded-Encrypted: i=1; AJvYcCWLyjwmkGLKjrcXZNAtwATwojWyQOLx9R8CWYZRi5H8P/dGJGwjA+Y5aqQX/Xd0Q5wKnhd2fXUvgCK9lSAkszOiOO4felNDIo4fJajv
X-Gm-Message-State: AOJu0Yz/8hjIlMxs2w6L1/wmz1Hd6AsoMMWImYo7PJIhFenOO3b2ALOW
	55SOXv6M0HJ6GXxXL64WDrYHNSVIhOtTWdck/Ns6eQs1gbnJ7zn2Q9rur1igzw==
X-Google-Smtp-Source: AGHT+IGs8pUXb5mDGS8kHPviqknzo+hzJ7Te+hq+G7yo5xcEkhGPpfVIqG3exWqTnYNB4l5GZuju7w==
X-Received: by 2002:a05:6a20:72a6:b0:1a3:11b7:a0de with SMTP id o38-20020a056a2072a600b001a311b7a0demr317316pzk.15.1710016434950;
        Sat, 09 Mar 2024 12:33:54 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a18-20020a637f12000000b005e49bf50ff9sm1644000pgd.0.2024.03.09.12.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 12:33:54 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] pstore/zone: Don't clear memory twice
Date: Sat,  9 Mar 2024 12:33:51 -0800
Message-Id: <171001642971.4101342.15404186717889149238.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <fa2597400051c18c6ca11187b0e4b906729991b2.1709972649.git.christophe.jaillet@wanadoo.fr>
References: <fa2597400051c18c6ca11187b0e4b906729991b2.1709972649.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 09 Mar 2024 09:24:27 +0100, Christophe JAILLET wrote:
> There is no need to call memset(..., 0, ...) on memory allocated by
> kcalloc(). It is already zeroed.
> 
> Remove the redundant call.
> 
> 

Applied to for-next/pstore, thanks!

[1/1] pstore/zone: Don't clear memory twice
      https://git.kernel.org/kees/c/c8d25d696f52

Take care,

-- 
Kees Cook


