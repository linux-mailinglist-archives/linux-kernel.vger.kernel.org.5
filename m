Return-Path: <linux-kernel+bounces-95980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B517875598
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C3A9B2204D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F42B130E58;
	Thu,  7 Mar 2024 17:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DU5jzMG9"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231991DA27
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 17:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709834065; cv=none; b=oTn7KyzBs2uQ/4eh+mgJqRZg6HnY8Z34EPktjhst0QHHvooTiVMAHzylfWQyhmWG6CIDXc0yVRsKQciK4edGnalSyQeHWjdUMhMXZcQVb+ll1jk1WO+p8kCCI370RPrmOBrPuf6CA3YftMNzXzED2ogwBnz1Aaot/Mxtu+Ljr0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709834065; c=relaxed/simple;
	bh=gL2PUG8wkeC1np6GBiLpogsA+xXsDUCoIx/Wk/Y2ahg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVKx9XqRkxh/7hQau/9UsKl/gnOTLZfnxiUr/gaSqVu8uIBXjwqe0PDmeKmsZFBtYTX6eoqU+y2hcmMbgQSsYWjXuIWbNtNwCyWdgzrQ4NFcUIUpsl1viLi7DFmthUX/nIz6eC78a6n7dbAVudEZnLD9EpOxtS8BRiEaJ0NMEHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DU5jzMG9; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dd10ae77d8so10463365ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 09:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709834063; x=1710438863; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q/X9WiAZ298nMlpwZKocfmBQTYiNw1IbFj7J55m43DY=;
        b=DU5jzMG9S2KQ3f4emnrXDRwe+CrWvJhdp7uQLvLQmX/vWpez7HiYJcyUfv9N+s8PF0
         eCuNU0gjp+ZUcucBXSGIW/4+klv2T1/vqFOUtiA3hpdot+rVEJRNp8E4Ugwt6lXgDBQN
         5arJjOvqnbD3XhwVga4zhl+eD6Qqz1/mxfTlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709834063; x=1710438863;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/X9WiAZ298nMlpwZKocfmBQTYiNw1IbFj7J55m43DY=;
        b=ZhfvlilEpY9SzXjlh1eJFBSOr+yzTwBDP+hkqA8fZ+tgd8JtV8pjLYDzLsc1k4n2Yg
         ZaMWJHysjb//ESqT91c5PWNmkC+xTYqCzUTPzOmg3pLaNJTyCuuE3mimvl7nhHfkBuTR
         Rf7eza+pivIqJ0Xjymgpq26gxMjGCcBRfdlpxnlS1EE8ReEnIWulc8W08vSVG8bowjEL
         7R5YRnpNcFIli4Jv8d++DX/HTmzFRk2JelAHtMBCEZk0B10cSwzBQeYolbgZBCT0o+8l
         P/J7jVUjTBhNRri7izTj0aBaxgJzqj8tKD7j9Y0UrXeN7hcPI3cBf2OKc2F6LxdSAWs/
         OXyA==
X-Forwarded-Encrypted: i=1; AJvYcCWGh1K3dXcFCSqHEW8Giy1spVy2t5TerRj6SVQ49Zzy2ILEQlbQgWbUpIzFuuyVNT7fmHby+soqQA74r/xr3hHb/ygn1duKviN/1Qdc
X-Gm-Message-State: AOJu0YwZ3redhwbYtge9yj52OWssy1aVznglu1MKxqLg5MlTaKtNbnIR
	SWg3So5XQprhSr/Eat2BH5C7CbAjqy2UscB2Zj/GZUziICbSXQte2EJxCHZDeg==
X-Google-Smtp-Source: AGHT+IHUxQ9DWu9gysEex2ejtTK+1HHHKEo3vq3YQF4KtyNv591GHTuR4rvCLhlFEW54mpHAl/SO9Q==
X-Received: by 2002:a17:903:2348:b0:1d7:5d88:f993 with SMTP id c8-20020a170903234800b001d75d88f993mr9618761plh.41.1709834063497;
        Thu, 07 Mar 2024 09:54:23 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y6-20020a17090322c600b001d9edac54b1sm14951503plg.171.2024.03.07.09.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 09:54:22 -0800 (PST)
Date: Thu, 7 Mar 2024 09:54:22 -0800
From: Kees Cook <keescook@chromium.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Jann Horn <jannh@google.com>, Paul Moore <paul@paul-moore.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	"Serge E . Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] landlock: Use f_cred in security_file_open() hook
Message-ID: <202403070951.22E77FD709@keescook>
References: <20240307095203.1467189-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240307095203.1467189-1-mic@digikod.net>

On Thu, Mar 07, 2024 at 10:52:03AM +0100, Mickaël Salaün wrote:
> Use landlock_cred(file->f_cred)->domain instead of
> landlock_get_current_domain() in security_file_open() hook
> implementation.
> 
> This should not change the current behavior but could avoid potential
> race conditions in case of current task's credentials change.
> 
> This will also ensure consistency with upcoming audit support relying on
> file->f_cred.
> 
> Add and use a new get_fs_domain() helper to mask non-filesystem domains.
> 
> file->f_cred is set by path_openat()/alloc_empty_file()/init_file() just
> before calling security_file_alloc().
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Günther Noack <gnoack@google.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20240307095203.1467189-1-mic@digikod.net

This looks sensible to me. It follows best practices[1] for avoiding
confused deputy attacks as well.

Reviewed-by: Kees Cook <keescook@chromium.org>

[1] https://docs.kernel.org/security/credentials.html?highlight=confused+deputy#open-file-credentials

-- 
Kees Cook

