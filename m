Return-Path: <linux-kernel+bounces-108389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 881D78809E7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18071B23FF7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144221755C;
	Wed, 20 Mar 2024 02:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DNghZSKb"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046E71755B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 02:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710902617; cv=none; b=M4MITTnaPyEEHtzBqAW1FsnIWOfwqMc07b6rWJeN4CpgbA2145a0a2hz8gvtVpNcOqMpDZvK0Qm0ttoRizc8mq0fLqClb0gsaOzn8SbqHfxe4dWrq6b+6YcTD6rOwgXXF+KaJoeg2UOIi/0xshixnmjyIGLxbY61HjUzllgMc7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710902617; c=relaxed/simple;
	bh=BfvY3vyLR6lXc/XFMQ0qkGmpXmDZdpmrBKNycQGWXU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRPC7/3nYd+Ek8hFkYMl64D5QX8PKgpf9x7ZCcSPzMbTppBjSd/85kMd6feDv/HfOmd6W00XMHGTbzxtJl6NqKMoBzLKU/kW5ii9VdrJoot+9kjSmfhxgQJ3QuxM5XeNH0NVmfVTf1etxuRLm6+t6ZvzDda9Kj5K203lbIdLf24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DNghZSKb; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1def142ae7bso43977185ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 19:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710902615; x=1711507415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g6fFauTTG4W/mn5n1JHyH5xPf3JyfWAj7waGLeqk3zI=;
        b=DNghZSKbb+nZ0jz0xHSDiD5ILl/k+Ymy5cPumn3vg3ENIJPXDjGM8oT2zqARxNpjpN
         BdeIiQLHOv6dwQS/xgbzEZWWW1X95qJ21PHWv9umLj0jFP+oGanOucQPpo8hKvtNv+uh
         mIhUqnPr89pk5Ytrk4+KXdQUGEJnBm/Ayj/E8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710902615; x=1711507415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6fFauTTG4W/mn5n1JHyH5xPf3JyfWAj7waGLeqk3zI=;
        b=xTLXXixBgkrTnRSnrpYlA6s7ZYGdu9O31/7cg/m87QfTAOXdZfnDsJAXxqKxUxS+s2
         LTyXladjqEtCrF2Lz1Z9N9Rjn+AUYcjktS9STl8DMcw0fUSHzCbLAYMrtMPraaopQT90
         9pqCk7izuXItGdTm7iM3UGsWzzLMF4wlgSlAoyep90p2Lnl+iMIS1rSyWPoD1yoFjyV+
         SpMP+WvQRQbh25LMJLuixnNmR+m1xJO2NUn9whs/syA4pa0i7Bi9kKQca8Jinp9q7q2M
         aJGOh771/t2MS5TyNiwwraXvJvMtivbQ1VKNSnR6k4z9QD9OIM5eswHKaJowrAZTWTNa
         zrHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZZLW/ohvcXCpyNZh6nzNYKmXgpbXQX1C6GSX7kBjGegocY62BRrA9Osy/UhL/vyiJJtUCUmlmErtGmn+0l3Szm+2T+Gi//8HFZKqC
X-Gm-Message-State: AOJu0YywSaS/Uub+w/+pn+ykJSSNy1fEkT5ZmaXUvqas1pVg4tb2jR9X
	MNlRaCZVb25yPGB+LBygv6CRXpchvfMXyocU5zZuG4JDjmHYx2fCRFNUWMQBbQ==
X-Google-Smtp-Source: AGHT+IEWmlMM501UpoKPpKqkmGwRAMYGO6OYBvdUB6jJX5Jkb9LM3OMFZqUtjh4V2htoBunvlx5FxA==
X-Received: by 2002:a17:902:7798:b0:1dd:ae5b:86f1 with SMTP id o24-20020a170902779800b001ddae5b86f1mr15575726pll.29.1710902615342;
        Tue, 19 Mar 2024 19:43:35 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902784c00b001e0501d3058sm1548080pln.63.2024.03.19.19.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 19:43:34 -0700 (PDT)
Date: Tue, 19 Mar 2024 19:43:33 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: mv_u3d: replace deprecated strncpy with
 strscpy
Message-ID: <202403191943.942C08892@keescook>
References: <20240318-strncpy-drivers-usb-gadget-udc-mv_u3d_core-c-v1-1-64f8dcdb7c07@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318-strncpy-drivers-usb-gadget-udc-mv_u3d_core-c-v1-1-64f8dcdb7c07@google.com>

On Mon, Mar 18, 2024 at 11:31:53PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> Let's opt for the new 2-argument version of strscpy() which guarantees
> NUL-termination on the destination buffer and simplifies snytax. The
> NUL-padding behavior that strncpy() provides is not required as u3d->eps
> is already zero-allocated:
> |	u3d->eps = kzalloc(size, GFP_KERNEL);
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

