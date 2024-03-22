Return-Path: <linux-kernel+bounces-110902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3DD886570
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 04:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E46285FDD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 03:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A623053B8;
	Fri, 22 Mar 2024 03:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iPqTnJmO"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904C94A07
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 03:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711078028; cv=none; b=DiLKQFyQuNTb1jBT8k8Gi8X3LwsR5Y9zma1IMHbV2tbLjFxPawchEalKE9Luoxa0j7zADfZ97rT1jM9DjabQIGQY0KJBkM+7S1gtfSGmoebV7/wLnTwka8aYHQRnlT8G1CMmx1ZmJMDwjdC+M1waZaGfS6N5MyNQmbdFe4udKtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711078028; c=relaxed/simple;
	bh=rA9OLiQVBndIxCqI/RnL35hJtQlSZt3ZhLZoSTUWMn8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RL8TDuSBVhGdV0Y+YkjN008fcmMupt1W+YAAqMKcKySUy6N2DX3ejh7QqoT9Jizk5FsEM1OnvTWxbu4LVyCHbJbp5vU/r80MhZg1gjnbsq+wmrQ9SH3SkJZbujHeEgl3r7/W+fx/ul5KGu7QfGlLm5GWcDPXe5kMsk+PQZqgVU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iPqTnJmO; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7d02a82018eso32699639f.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 20:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711078025; x=1711682825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcsMqmY7811GML8PC3DqwKOCOYs9+H/dHHUmPBVs1BQ=;
        b=iPqTnJmOZsJPQX9rQ7ZDKO810VhRzhJPJpvFRyLcG3GZ6KXKTRa4p54WeuuFrAwcNM
         b23px0uFeEZtwziUyqP//hvXZU26B5BO9jW0vhZbXW7pQqM6ADIB1GiVnv660RefdXC8
         RA050VK+M553JWSGAOxL2hy4WrLYWwlfUucAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711078025; x=1711682825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UcsMqmY7811GML8PC3DqwKOCOYs9+H/dHHUmPBVs1BQ=;
        b=nnsgiOmqpEFv9rUjZdjHTN5koGgQ/hoxF9mbHqDR4dxjYzyIEc/mCrXsWAv6+5D15o
         q5698UZE6duE33BfUg515L6scZkcSTDetqicV0Mk1cE4CB6oVdL2dVTfHx5VMAXv/Ful
         MPZIkVURpuAONfSRKGxtVglm6QanL7WfQySXf/eAffmHc/W3ZxnyjX45x3jC0O4DmOn1
         9oKcQD6BEcZ8qITrKoVNAy/hRblTpEOSF9RHZIMtzLqOPmo6ZXRNAXl6czfH6U2n0aE1
         Cd3htjY67EP3J1duIRG6yGetZK5wnNCjNEHKW9q0e5JczFMTwcmJ/ODfDiG9ZG81UBiN
         cKIQ==
X-Gm-Message-State: AOJu0YzrzCXMJo9reWn8LHNwgIhICsCYL24RbjP/kUuP1aLD/dfI8gT1
	FXscIHOBIqQpXQ/GV0XJgbdlIw5jfO4CpQQ9n9ViXg9zJwvjQ+mGxrDW9PzJ6g==
X-Google-Smtp-Source: AGHT+IFMNGILCIbGOORMV5AHfyreOQC+oqrzNbTvmrzQsA8QnVKKZXTt1rS+A5kiGLdhP2gdpVAEXw==
X-Received: by 2002:a05:6a21:31c8:b0:1a3:7327:2323 with SMTP id zb8-20020a056a2131c800b001a373272323mr1123844pzb.45.1711077544553;
        Thu, 21 Mar 2024 20:19:04 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902d0ca00b001dc944299acsm657327pln.217.2024.03.21.20.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 20:19:03 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: linux-kernel@vger.kernel.org,
	Max Filippov <jcmvbkbc@gmail.com>
Cc: Kees Cook <keescook@chromium.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Rich Felker <dalias@libc.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] exec: fix linux_binprm::exec in transfer_args_to_stack()
Date: Thu, 21 Mar 2024 20:18:48 -0700
Message-Id: <171107752638.466752.7224681033755371253.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320182607.1472887-1-jcmvbkbc@gmail.com>
References: <20240320182607.1472887-1-jcmvbkbc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 20 Mar 2024 11:26:07 -0700, Max Filippov wrote:
> In NUMMU kernel the value of linux_binprm::p is the offset inside the
> temporary program arguments array maintained in separate pages in the
> linux_binprm::page. linux_binprm::exec being a copy of linux_binprm::p
> thus must be adjusted when that array is copied to the user stack.
> Without that adjustment the value passed by the NOMMU kernel to the ELF
> program in the AT_EXECFN entry of the aux array doesn't make any sense
> and it may break programs that try to access memory pointed to by that
> entry.
> 
> [...]

Applied to for-next/execve, thanks!

[1/1] exec: fix linux_binprm::exec in transfer_args_to_stack()
      https://git.kernel.org/kees/c/2aea94ac14d1

Take care,

-- 
Kees Cook


