Return-Path: <linux-kernel+bounces-124105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA93891247
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 05:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C667B1F224A5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 04:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5113A1AC;
	Fri, 29 Mar 2024 04:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F46zPyhk"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFE6381A1
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 04:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711685133; cv=none; b=YaS+9hGzoeHemt2lAh/u52pWX8zi6Yb5imdWiZZorevLWaWHSegLZc+R23+Py2x54ier2dQ1Vo0DncBrqejKI1oCFcOcW5NNHdIm1gdJN7D0ON+L2jbTYm29FYPYC6udxBG0NB9A+QMfoW/Cdtg2/swTqXjyuJearkigtDbbI4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711685133; c=relaxed/simple;
	bh=oFGr6hCM3PzxNaylrf42uZzkAP51fUMJrt0ornlm2/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzHdlvxyGU8BY88Y9wJfv1RhbsgMXm8hxFth5v2EtWeKuZj1Fl0UoduDbpG+r2Tx/EZBbMlogSmdFR0x6DKDKl6i6IZZZdRpVzzBKMKl77zEtGXQZ2f130tQyjgdtg/zNi7eOtSufAH3VA0hOjOI9rFYRQ4tBRk45c8iCW3dGuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=F46zPyhk; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e88e4c8500so1379629b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 21:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711685131; x=1712289931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+BfIDju2MLKQM1ZH/SmKqeg1WOOWWWQIwZEViiqCej8=;
        b=F46zPyhkiex/ObTJC0fXHTuWO3KfNC1hSQ6fdU/Y68yuIDiWcD9pM+I/i1VDZNjKVp
         kIgeEL0TXlnOZ3gsHiHR5xyJLHIbQR2jKO3Tb0CPa/ZJsq3MZvauGQjpXqZNahENgr7s
         y4f/Q4L3Cp9idb9VUSGfPnNbJxIawZUCtMqQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711685131; x=1712289931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BfIDju2MLKQM1ZH/SmKqeg1WOOWWWQIwZEViiqCej8=;
        b=JbX2WuAAd+brfWS/TIPB31cIa28fpmAJPYH/+0KQ05Z/T1K+WIBiyt0NnboBbBUOG/
         qP3HNYXwWapvbD9LXKfe5j15/ezw+RE2uyWUWIM4RJezU8XCP2cESEC3oL+eQBc+E055
         eTQSPITnSyQocfOfsViwy6Xer+tDut7nYtxH5ju9Nh6htrsZHLqVOBB97nJPt5cUYGRT
         EE1/aKyalZCp8kBbSFXhzVVMBJLUXFTd3THofk/ysQZhjmiJccQHLzEb0jPIITldpW83
         v3M73AAh/4ob+NFNVBTzpk16mGtAgezumSbMw8PwqMr8Eezn+8U8GIWYWnm876noRoZ7
         GjIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUglcOmWA86dVPyBG2DtQkZQoqt5dPrFnF/S/ZpHA8Ya6pz/srgPXI1GBLFgFImpNY2W8bq8TAkCswZVlBOXuVs8TbIsCdPCEEC42g+
X-Gm-Message-State: AOJu0Yy2KBPqWVqVQJQE3ZX1xNrE2KmmADwerPEVYIdLx5/Tw0bpCgrF
	qB6coxUJqhBKAPjw6Wd15xaVm/6HEfVkmtMN/Wdons73YDN409AntIWJ6EhQfQ==
X-Google-Smtp-Source: AGHT+IGaCxTi+p1S4dkJyCaFZHFw9yFwUBwZuRqfcbEkvFu2SFjTbyW2QlP06JR8Bm5kBsLChpFcuQ==
X-Received: by 2002:a05:6a20:d396:b0:1a3:aea1:bc7d with SMTP id iq22-20020a056a20d39600b001a3aea1bc7dmr1177152pzb.30.1711685130989;
        Thu, 28 Mar 2024 21:05:30 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f15-20020a170902ce8f00b001e0fcf995easm2458362plg.202.2024.03.28.21.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 21:05:30 -0700 (PDT)
Date: Thu, 28 Mar 2024 21:05:29 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Michal Januszewski <spock@gentoo.org>, Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] fbdev: uvesafb: replace deprecated strncpy with
 strscpy_pad
Message-ID: <202403282105.574E19BFA@keescook>
References: <20240320-strncpy-drivers-video-fbdev-uvesafb-c-v1-1-fd6af3766c80@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320-strncpy-drivers-video-fbdev-uvesafb-c-v1-1-fd6af3766c80@google.com>

On Wed, Mar 20, 2024 at 11:04:44PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect v86d_path to be NUL-terminated based on its use with the
> C-string format specifier in printf-likes:
> |	pr_err("failed to execute %s\n", v86d_path);
> and
> |	return snprintf(buf, PAGE_SIZE, "%s\n", v86d_path);
> 
> Let's also opt to pad v86d_path since it may get used in and around
> userspace:
> |	return call_usermodehelper(v86d_path, argv, envp, UMH_WAIT_PROC);
> 
> Considering the above, strscpy_pad() is the best replacement as it
> guarantees both NUL-termination and NUL-padding on the destination
> buffer.
> 
> Note that this patch relies on the _new_ 2-argument versions of
> strscpy() and strscpy_pad() introduced in Commit e6584c3964f2f ("string:
> Allow 2-argument strscpy()").
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

