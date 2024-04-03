Return-Path: <linux-kernel+bounces-130653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 323C8897AFB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0E4E28389D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28250156879;
	Wed,  3 Apr 2024 21:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QAPAsgiX"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AF118AF9
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 21:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712180763; cv=none; b=qF9bBikrjASUJYcOcG12CitNFeatqTSfxdwELZI9XyyH339dzIRwc2txw5Cf0tvjosbf9LAKmD1smcaLMR4i4pm5U+E5eToOSqQ5apMYOVga+t4stuWWmWB4j13UcVZvq/cZFrIi9khftCi/7cMKonXgKbDqDrNhnW6UXk41ahE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712180763; c=relaxed/simple;
	bh=k5u6LmE/KxCA46smReOIOiyt166x2BcM8K8CPNETK+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fPHVHdnUxQfd0tY1cLevGiNwHGTJVYEBKgJvaxcngBPoWiypnRW9R0TKV65vwyFP4FTkXGyfXHkdaCqQNAbtTiUrcRNsbyOa9bBVHNotHzIrkq9R66A7AvhpTYCo0Iea24MiaxWz760bp/1JqomBkzxR4SOBCrmUQZlczWYPcvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QAPAsgiX; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e244c7cbf8so2757315ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 14:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712180761; x=1712785561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9Rfo0GuMUhNW4rnyw2FKeITsblkzXdY57eMgq2brH0=;
        b=QAPAsgiX0KETh+O1kEmxkOY5DlsMqwkPeGtzG0Vc7d46d42QpioPWdSp8hZDrz6ghp
         LW0ErAJ6/eKAKMgyJ3JAwVNaaJ+UmpmCnaW7iVE81Wj1oYYKKqER26VYt6678JyFqZcv
         ii0mjJ1Ppw77bhD2nJli8kkhOIeTeaz+8HOkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712180761; x=1712785561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9Rfo0GuMUhNW4rnyw2FKeITsblkzXdY57eMgq2brH0=;
        b=BQs4Zk/tOZHLTeA+J6K8ze8Odr0vggBLDnFuatzvqrfHsv75qC+6JJVtVapRN20r65
         aq3pO6geeU0S58+AEBffjsdioWoqFLrVxi1WAlQztugKDe51gm7eGQ4kj0quyjlmNQFC
         ZU6nEIQ/hj34shwNMN9iRBVoaFVFOeQQ4WVBz+l2SMHKuj6CiUB/2M5f/AnwJ2on8Emm
         MzJo1A9YCyHolVW4XChUcKiKajiDJiNaeLrW3lr75v/xeNeLpx5FZJeupw5PVN7KPRPM
         FCuvjqUbsd6+h5E3ZmwQvbQNWX/b338E2YMDNOBzJvwUg5uDYPl8NOsEFWKOCBGt4tal
         UsVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc1ejMNasdkeik85laz/2sYr/OaGY8aBpzmdHZ94AfN8Yju2juyX/clE8HzMZmVPDWg5L95pCoKMhzutocNqNgw+dzWs5xbLHrpYvq
X-Gm-Message-State: AOJu0YwcIwXw/O7gvaw1gOKFrneSAfIKJ+YnqN6r584wZnh/K0bNRwQp
	oaJriBPN4fhpMrtaIgZlmhDho8UOEreeme02n8kECo1eIosedUxZwQBkxeOPNY7JdQL5j11EOcE
	=
X-Google-Smtp-Source: AGHT+IGBMjFH67wQAQE46z0VwQgaz6/YQJDPFvSADzCC/5+gkq45buN2d3WBVkg4g1zFkD/ZN7bS2w==
X-Received: by 2002:a17:902:e885:b0:1e0:c824:2510 with SMTP id w5-20020a170902e88500b001e0c8242510mr663550plg.14.1712180761442;
        Wed, 03 Apr 2024 14:46:01 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902b70900b001db37fd26bcsm13828562pls.116.2024.04.03.14.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 14:46:00 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Jeremy Linton <jeremy.linton@arm.com>,
	Kees Cook <keescook@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	Elena Reshetova <elena.reshetova@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] randomize_kstack: Improve entropy diffusion
Date: Wed,  3 Apr 2024 14:45:45 -0700
Message-Id: <171218074192.1346108.13742168050970266873.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240309202445.work.165-kees@kernel.org>
References: <20240309202445.work.165-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 09 Mar 2024 12:24:48 -0800, Kees Cook wrote:
> The kstack_offset variable was really only ever using the low bits for
> kernel stack offset entropy. Add a ror32() to increase bit diffusion.
> 
> 

Applied to for-next/hardening:

[1/1] randomize_kstack: Improve entropy diffusion
      https://git.kernel.org/kees/c/9c573cd31343

-- 
Kees Cook


