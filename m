Return-Path: <linux-kernel+bounces-108374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F028809C6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3A8E1C22A6A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCB738DE0;
	Wed, 20 Mar 2024 02:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FpK80cf2"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4976229D05
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 02:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710902555; cv=none; b=t79aIRx5XpiuHuzcpjJ0LbAcdaTZM4STxkVfxGCsZst1VzdyngbjW/B4g39Udgf6pYFaDgPxePtYCOUa+LJBUNqwjIMMzyGzLYJTvdHOXch5lwZt1dnD75SjdcN8EBa8mVCqTZQX49GFPAdX8nzK+KHyrCPMEuE4P5Rfq+QZx98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710902555; c=relaxed/simple;
	bh=s7xt3J/x1P5iR0tIyAeOfFanpdd7tKxd4ngYLSRwbIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+b9xI1UWN+RFUikBR8HVjXyBuCrzemwXKPaxe4Xi7LL4HkbGi7UzM3zN3P1UTQ4N3FNLszuPcJyipMNy2frNEEH/sCOSeEjWx+NQRbJtli8ARp8QnLrATL10zKMgbkoUAwS38+5bTWgDlqbLgwHoidemnDwjz0JkRhiSJqIGrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FpK80cf2; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e88e4c8500so49265b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 19:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710902552; x=1711507352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o2Ii+qg5LzdQ72UpZAw1asNIZXswSUTe3sjnBVEowPI=;
        b=FpK80cf2hM+7NsrMo3H6/99ZxSX+fOtbFEkSaWi8p3DN2NqOxOHPtTOkYEavLFkjT5
         YXJaHKy6FKA12ArFyKOD9WEx+X6Z3d+QJbdN6O6TvYVK3+E1BnOTYovb9pY3ngHxO6Jc
         Fc16DNvtVH5bddpkenEerj37o+ETzsWjyW4dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710902552; x=1711507352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2Ii+qg5LzdQ72UpZAw1asNIZXswSUTe3sjnBVEowPI=;
        b=gXrBtsm3PayZMuvFU4Pedp91nfDziR6BtRZIrU+ye2RS8wlLzD2z2+LVOHoAGJXySe
         aqg7KVU8K0I5m+kFy9YeRlKeEdQdO2UVwAoWAE14dFinSVyUv0VaXaISN6R5NKcKnVGo
         D88YD6LlHsMjleRT8Co5zql6UVV1+85ob2Mwim1ONafZDNwhIeRlIhgEZFmdouP81T3k
         aFitn07XeyIoFVMPwgnm1TdVB0L9DYi4CoabOZ2cbz0CH/QGiXnaRsjnivR+UmS7LiOH
         ov5BWFliRz7+5UwxT+/d7K8JMRhuVh24NHkYQO7QLPRKJWjpLc3xWBQrJf+W3gAFPmSG
         DY+w==
X-Forwarded-Encrypted: i=1; AJvYcCUIFcYVkAEbn9cIVmxGRyZEFD5adog6leHWi/H8Al4zaRiC/LOGBo8dESK/J9UJzh098599fWkU2LHgGjGNozEAclvxy87aJp142EO8
X-Gm-Message-State: AOJu0YxtfEQZHBfGSQ9KUe2T0ikFmc4qXE114uMjzkNPKA4RcQnO8tbb
	HhzbBHlgLyVA+N7MX7TV2Gl7TxbfKXNUcBCT2996Pss4Exczhf1VZmOqabYopw==
X-Google-Smtp-Source: AGHT+IFJ3mimqhyXJl6uZ2iBD7JX313NaQ7js3fa+uG7RNJZ8WFe7D0jn4BJmpYU7bSd6VfpiwLGDg==
X-Received: by 2002:a05:6a00:21cc:b0:6e7:20a7:9fc0 with SMTP id t12-20020a056a0021cc00b006e720a79fc0mr9982708pfj.34.1710902552625;
        Tue, 19 Mar 2024 19:42:32 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r10-20020a056a00216a00b006e6eb8e07edsm10032341pff.50.2024.03.19.19.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 19:42:31 -0700 (PDT)
Date: Tue, 19 Mar 2024 19:42:31 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: target: core: replace deprecated strncpy with
 strscpy
Message-ID: <202403191941.D2818DB@keescook>
References: <20240318-strncpy-drivers-target-target_core_transport-c-v1-1-a086b9a0d639@google.com>
 <202403191908.1B6BBA3@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202403191908.1B6BBA3@keescook>

On Tue, Mar 19, 2024 at 07:23:43PM -0700, Kees Cook wrote:
> Hm, this actually fixes potential over-reads and potential memory content
> exposures (in the face of malicious/weird hardware) since p_buf_len
> appears to always be sizeof(p_buf) in callers, which means the old use
> of strncpy() could have left the string unterminated.
> 
> In practice I would assume it's not a problem, but, for example, here's
> a place where the 254 p_buf_len could run out when doing the sprintf:
> 
> #define VPD_TMP_BUF_SIZE                      254
> ...
> #define INQUIRY_VPD_DEVICE_IDENTIFIER_LEN       254
> ...
> struct t10_vpd {
>         unsigned char device_identifier[INQUIRY_VPD_DEVICE_IDENTIFIER_LEN];
> 	...
> };
> ...
> int transport_dump_vpd_ident(..., unsigned char *p_buf, int p_buf_len)
> {
> 	...
>         unsigned char buf[VPD_TMP_BUF_SIZE];
> 	...
>                 snprintf(buf, sizeof(buf),
>                         "T10 VPD ASCII Device Identifier: %s\n",
>                         &vpd->device_identifier[0]);
> 	...
>         if (p_buf)
>                 strncpy(p_buf, buf, p_buf_len);	// may write 254 chars and no NUL

Wait, no, it's safe; I got confused by the double buffers. The
snprintf() will always NUL-terminate, so "buf" copied into p_buf will
always be NUL terminated.

So, nevermind! Regardless, still a good conversion. Thank you!

-Kees

-- 
Kees Cook

