Return-Path: <linux-kernel+bounces-115268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75ADD889BFD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AF0C1F333D8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8023214F130;
	Mon, 25 Mar 2024 02:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mforney.org header.i=@mforney.org header.b="IQE+vdCu"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670012FE84D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 01:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711328672; cv=none; b=J1ulLLAvDDVRa2pLioGa3C9CZBI2gKe72uOnFEvo14R/OHXRRzDJeTUYuRfA/Kmm/3Ck2Q7INl+4LZAoeuSeQnJFM5DJYJR9lB9TtP3+pGm0kQB0i2+ADgNnyy1cy3CYoaFNulYSviVsFYuOJV/Dui8QUjLRRlhw9ENEjxN7pK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711328672; c=relaxed/simple;
	bh=HLX58pQI8SXB83k8TSE9weXRimPojqSZLVQ1p1YQbgI=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:Message-Id; b=dXq50LSsyy8xtlzHo2XRGw3quDFQS7qus8aUquERUcrGks4sXRmb/kjvNsL0epdv/xaOxm3H/x5JAP9yTVVhKmxQ8b0lQhbUS72N/A8qLSYIH+8u49c9hF1yZVnZBRwAKmd/AVqGBsRP6L6L6vbPAeJLPmNHOBGqdgk8HflN9Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mforney.org; spf=pass smtp.mailfrom=mforney.org; dkim=pass (2048-bit key) header.d=mforney.org header.i=@mforney.org header.b=IQE+vdCu; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mforney.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mforney.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dddbe47ac1so30223815ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 18:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mforney.org; s=google; t=1711328669; x=1711933469; darn=vger.kernel.org;
        h=user-agent:message-id:in-reply-to:references:from:subject:cc:to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mpHYqBGYlnixcvfc0J1Ave38pS8nETGdngwvpSQTuLI=;
        b=IQE+vdCuZCtEiCY60KpIUO9OQh9G++Wknz78+cyc7Ud2o2qUHznuxRpaLwpAGdJ4rd
         oPDPBZoJdNpoTvUheeUP8nTca9is8fwXXZM96QtWKcTHlwPaukC/wB49eWmtp4YihwBu
         BFgbcITIZ7zzyINgKYG+bwCKuR9xk0ZwJJzgPU8nugxfik2th0xX+4whX7SnZHPcZqxn
         63i9agWvooVS+knqlPzdae5Rjs0OmX46FunjOX/z2aH66+ZFBVGgkVYkhTQZcQOm/0Ma
         J0ASj+MhyjhcFNjoDMOo75f1lw727O7Zwh1a7oAY5ekfmBzb2IuyIRS4ZHAIiQ6Sznkr
         En5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711328669; x=1711933469;
        h=user-agent:message-id:in-reply-to:references:from:subject:cc:to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mpHYqBGYlnixcvfc0J1Ave38pS8nETGdngwvpSQTuLI=;
        b=ZSDAjGTJPN5gcHdIQ8+8T0O/0wJRgyq4RHd0+Omk2urbWDMC91hKj7hCmMvz/EY36K
         AuKs2Ju9x+6grsrdRv2D1LqA+2JaqastqsqSDi78qapZKvdBmi8dnG5KbC4N49j5u70x
         Mi5eFtPm6qiGbexCU1wmeNE/Re+iWOig2ytjCR1GRNV8IJ309p9Ou5z9SofhZEF7u1/R
         G9aVcms0CdiH5HlmrCNitlyNiWS8FtNgslU9q6ULvhmKKyjkXxBQK0HMHitRxa9kJhXV
         3czVCM5VZZRzDhiIuYWpuDCN+42BAEjGm/U/nZ6NLugSZUunCZ0IGKrBuNWYfxktgCfv
         lrEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTmeuEFj9frUjtz9660FsnbNQnfUPlFuS0K+Av/u+yXOrxeDgkUcYNY4jaHX+MgJabHMifGCRe5nOYoae57X+vybwfD6S4YSdhnxUx
X-Gm-Message-State: AOJu0YyjLFYmfvfVsKwGwxFssTQ2YFhYHdS8p09j+pIX9UPrV6sS/bqe
	dEMDQswg42rFXjPXib8X0KYqJZcfoxUTBwaIliP4xNF1OnlU8fkgyYLn3rGmtu0=
X-Google-Smtp-Source: AGHT+IF9rqoIR3PNB/TlJ2XWMaPhpL62UD/3LEoox0CR8/qaVG2+VF6WD+iVHRPIggHdqTBzkOszmg==
X-Received: by 2002:a17:902:ea08:b0:1dd:dcd3:662c with SMTP id s8-20020a170902ea0800b001dddcd3662cmr8076630plg.4.1711328668680;
        Sun, 24 Mar 2024 18:04:28 -0700 (PDT)
Received: from localhost ([2601:647:6400:20b0:cab2:9bff:fe88:d09c])
        by smtp.gmail.com with ESMTPSA id g9-20020a170902740900b001dd3bee3cd6sm3618763pll.219.2024.03.24.18.04.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Mar 2024 18:04:28 -0700 (PDT)
Date: Sun, 24 Mar 2024 17:22:50 -0700
To: Max Kellermann <max.kellermann@ionos.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, brauner@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] Revert "ext4: apply umask if ACL support is disabled"
From: Michael Forney <mforney@mforney.org>
References: <20240315142956.2420360-1-max.kellermann@ionos.com>
In-Reply-To: <20240315142956.2420360-1-max.kellermann@ionos.com>
Message-Id: <3MDOTS1CN0V39.3MG49L9WIC8VM@mforney.org>
User-Agent: mblaze/1.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Max Kellermann <max.kellermann@ionos.com> wrote:
> This reverts commit 484fd6c1de13b336806a967908a927cc0356e312.  The
> commit caused a regression because now the umask was applied to
> symlinks and the fix is unnecessary because the umask/O_TMPFILE bug
> has been fixed somewhere else already.

Thanks, Max! I've verified that this fixes symlink modes for me,
as well as the flatpak corruption error I was getting.

> Fixes: https://lore.kernel.org/lkml/28DSITL9912E1.2LSZUVTGTO52Q@mforney.org/
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

Tested-by: Michael Forney <mforney@mforney.org>

