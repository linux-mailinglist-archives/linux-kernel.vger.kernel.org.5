Return-Path: <linux-kernel+bounces-136014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E56D89CEE8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DCAC1F24C34
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 23:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C78149E10;
	Mon,  8 Apr 2024 23:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A7tfDht1"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A52D143C65
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 23:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712618456; cv=none; b=FSq4a0CEGb7o75RKbN0nYdzzWcoGhGhjsaOouFsrtmcEIlWLt5MOomg/kOigAlAD2ys2dlpNCQSnUrLw1LIo/95VuiG00/LAXx6oGRz6EY/p+nDTqHsRkZsBziWg+qP1NIKyoo3mHLBzQUe+b9WxBgxs5y/t9Kq5Dhi4BEMn1jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712618456; c=relaxed/simple;
	bh=ABYWepUPTpNOjIti27XRT5vSfcJbPAQWDlfjw/lOhZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwYirbsfqj3XBGeGwhuMfskkaIC/13gJzT+ZI1qBX4aYCBpros/J6Ayk8+Tg/5R6XyPXb5JEq26OAVmNwd5/ZfPBTK63HWqeft8rvbl74SbNMgyaPjk0qv5j009RIihSl9dJvtLUj+WGq5SiaxgFv8OPSW3tXy9tSC3+qB1Snd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A7tfDht1; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so3113924a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 16:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712618454; x=1713223254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k+SiT5TlstlnW48g/wuVm80XsJWvG2bQ8P1YkCxCZTo=;
        b=A7tfDht1QiAasrAarWgQBcp8WjrM0U9g0mZZ4NCgvzol+70SMfDqbCwOKj9bkiy3aN
         3zM/9kN7bm71kuIetoUPLapxRZOM9Rb0mmWODp0EpDPVy/MbcHOrIrKVRMRe48AKCxmJ
         GqhxoZFqH0naH8qdkMPcGDY6ABkAGir+Zwq1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712618454; x=1713223254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+SiT5TlstlnW48g/wuVm80XsJWvG2bQ8P1YkCxCZTo=;
        b=dmI+xmv2zttdoqzid0D2L8JzBNShGqjFpUjKNdKePhug2erCsM6iqblxyQHJBTUemB
         2USQuYZVXkdHSRWTYiuOuZ/XnCSauD8MjRV5ukbGdhl+ttCzZy237ExP9aU7KSScXZQd
         r48SXBggdjcSR2lGkK+JNIVu8pwzdxawSkUOTpUusvu+MiqOZVhjCqLGdrPNvG46a1GR
         vd7OJXsrfX+6bU4Df2K4B/DWUTVACju9nBaXGjlnmGCSbpc4+TN4pyXnDOBhNAAbdlGf
         GwGvKEfZc/C9fgo6WsTjtMM0a7KR+m6+JZ0n0QwUYrUeWR8eaKZBMHH7/iJVMsPipMTg
         2dgA==
X-Forwarded-Encrypted: i=1; AJvYcCWyHpvO/1Wb7PcKLDv4B4KTMQv1osGu/2FOfEjIxLzweaAtV4QbiNqlV+Ned7v1M+1tZ1/sPDCbj4IDGvfp0mhBJlRrb+PwEo+p8pLD
X-Gm-Message-State: AOJu0YxF6b22cNWNap8sqSAIO7lahVzVwll4rIV0tB8HdvdxSCNJW+XW
	yjtC0sXsGNzAjCVwCz5eRFELm80kmmTX7FEo8t85uE28mKzN71IPsM5PAuX3sw==
X-Google-Smtp-Source: AGHT+IFKJzLp05fcugYDvokyR1XjAmUqpeqvOeGNr/xDGBIzmxdVQH9EoFRUIn9jOHtI4yO1H7vVRA==
X-Received: by 2002:a05:6300:8085:b0:1a7:3365:d8ed with SMTP id ap5-20020a056300808500b001a73365d8edmr9271766pzc.29.1712618453799;
        Mon, 08 Apr 2024 16:20:53 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902e9cc00b001defa97c6basm7517122plk.235.2024.04.08.16.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 16:20:53 -0700 (PDT)
Date: Mon, 8 Apr 2024 16:20:52 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH v3] net: dsa: lan9303: use ethtool_puts() for
 lan9303_get_strings()
Message-ID: <202404081620.D050527@keescook>
References: <20240408-strncpy-drivers-net-dsa-lan9303-core-c-v3-1-0c313694d25b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408-strncpy-drivers-net-dsa-lan9303-core-c-v3-1-0c313694d25b@google.com>

On Mon, Apr 08, 2024 at 09:01:57PM +0000, Justin Stitt wrote:
> This pattern of strncpy with some pointer arithmetic setting fixed-sized
> intervals with string literal data is a bit weird so let's use
> ethtool_puts() as this has more obvious behavior and is less-error
> prone.
> 
> Nicely, we also get to drop a usage of the now deprecated strncpy() [1].
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

