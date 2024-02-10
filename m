Return-Path: <linux-kernel+bounces-60296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B10E8502D4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 07:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB6901F22881
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 06:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0EF22087;
	Sat, 10 Feb 2024 06:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YB+MfWvL"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86121B7EE
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 06:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707548307; cv=none; b=PGxJeggii0ykM0FfRWjtHZ1/Oxc61Bd0+yvG6Cq5yqDaOCIxNQSTjpr+eMguVbtT/2wsr0xMe2P2cW3IaZpYHwXo9QMLKk2bbKbDCXukuLZeGrPBuf6D82MTTzWOqVa4POGuZ50smeoH9nko1num65Svud0J2lY/C6Y22g86Fus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707548307; c=relaxed/simple;
	bh=puHg0dE4ceDi3jECbpQfs8pnGLC9kzH1lHUcziDIEEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaoeJ4GSbLRL1mzi6nC92CnsN4xJsaBdnwOp1/CO9kfGOpAmMfQ95QNe3u2NdrIzdeiVyNKiM1HHIt11q/F+5ABMETViUYigBSA2xYX5tuwRENDl5Y14VaiJ+N/SC7yo2hAk/y2RgdQ14JHVMtdNWsC1+7JQfFUJ79Zh2gpMx7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YB+MfWvL; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso1271411a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 22:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707548305; x=1708153105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qAvJAaHQK8DLdZ5GSxTHkSnAiWWlU+ZUiJ3CnzbG+aQ=;
        b=YB+MfWvLtZwHBrDbBACwWcA5LAYhtgqUjiWwkTxmgN2FR9rBLWF//LVmKgNWe5Ax8g
         RfPpoWY/+4UBEACcSEfRtzQel27iSyIaO5unX6/NR9zJXCULrn3wZ9+2svo0CCv3B6dn
         uAnL1KjYx5BpkHS1TlYVURR8P1+afQhwyt4BE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707548305; x=1708153105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAvJAaHQK8DLdZ5GSxTHkSnAiWWlU+ZUiJ3CnzbG+aQ=;
        b=dEdvd1GLkyBW5nAgMRudUEvdm58yINYNEarDlw6exaCeFb/WD/T0AgY6GMS48Sk9nJ
         hIXoWTlqxxGLiBHd5cdQlB5X13F5dEdb0vFI4hXwY9hlLs6ncjtwLRcToX/T7Auul4FC
         Udkraf2fRgprMnLsYfFJzgCWKqmYoVgph6jiE8nc9LKPejlP7b2Wd1DosrBmr2pGu8uL
         uthbX6JC4C+Fc5KacgWBgbz66lzqY2WPOXxXgjgqYiLrFpGSyPgWYE1qFSgDZt+dGPgH
         9WfjN7VSy2QOe+GzEQhxWsFDjtWwIczsUbu4DSkJ2rj3bLdnivGczzkmV1P2XeMBR8UM
         OHZw==
X-Gm-Message-State: AOJu0Yyl1BXcCgUwEWrhdkUqO1zES7A+LK4Zw3mHoj9YN1qqOrdBUQsf
	3Xh14xQknymWmbJPXkKsF43g493Ox9P5d9ss38KELQP1/uDyvZeDDa/OVv0viw==
X-Google-Smtp-Source: AGHT+IFbR5sveqUOUpNF5YlLD7APcChRy/NH0dh5rqFO3MwE3/XFu8kPXSQGZ+FdAjtP6noQNRTYTw==
X-Received: by 2002:a05:6a21:3514:b0:19e:b6e0:8d7d with SMTP id zc20-20020a056a21351400b0019eb6e08d7dmr1489594pzb.31.1707548305075;
        Fri, 09 Feb 2024 22:58:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW7DXJ2uGVZJkNb1SJsoIgPlhJhej8RPGz7vL5zZJngjzfJYr/XGiM2wc/zYs+XyzVsgNXdwGOkWXJZ8bCP2AfjAaww0oVLy6vft+XiBtwoJI3TghXWF7IE9FF1qOS5PZ4Gl+A090Fyzzn8eIdI5vAkLi/FpUoSNgVKl5ybkvQMQLTnGhkgYRjBEK3Hvc4FPDc7e9nxM0TqSZxEyw==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id sc1-20020a17090b510100b00296885dcef7sm2934250pjb.16.2024.02.09.22.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 22:58:17 -0800 (PST)
Date: Fri, 9 Feb 2024 22:58:16 -0800
From: Kees Cook <keescook@chromium.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Adam Radford <aradford@gmail.com>, Joel Jacobson <linux@3ware.com>,
	de Melo <acme@conectiva.com.br>, Andre Hedrick <andre@suse.com>
Subject: Re: [PATCH 01/10] scsi: 3w-xxxx: Trivial: Remove trailing whitespace
Message-ID: <202402092257.83ED709990@keescook>
References: <20240208084512.3803250-1-lee@kernel.org>
 <20240208084512.3803250-2-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208084512.3803250-2-lee@kernel.org>

On Thu, Feb 08, 2024 at 08:44:13AM +0000, Lee Jones wrote:
> Since 5a602de99797b ("Add .editorconfig file for basic formatting") my
> editor has been forced to remove trailing whitespace from any file it
> saves.  Instead of fighting this recent kernel default, let's start
> chipping away at fixing the issues.

On, this is a fun addition to the codebase! I wonder how much churn it
will actually create...

> Signed-off-by: Lee Jones <lee@kernel.org>

Regardless, yeah, let's clean them up when we hit them.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

