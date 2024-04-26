Return-Path: <linux-kernel+bounces-160490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B858B3E2A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAED3B21FD1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9797C171082;
	Fri, 26 Apr 2024 17:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bTEsCjWA"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDAE16D329
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714152309; cv=none; b=twEQQzdWvuiIfqBDsjigVEZjpOMRZHq2N9C7KVtGgrKeiokskJVL4a+cucQkWnx11Q2wbvSUT4UEcucdXY6MS/2a6sNCo8zQUQtmLaxkul4IdKpbZ2OG3dYfISwEmYiAYNKsKNowkbIXtLaSAQ54KslzUc+M8Gk22scQxP8jyRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714152309; c=relaxed/simple;
	bh=oPkhpvPbCU1Wv33arOnKXSw2XoCJOquEb8duMbQ4dZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oz2V+Ou+DvZhL0rc0MXeI8uKxoCxn3+z8bwfM1iGrf1H2600GUbaf7gc3Q+2d/e90Y/MdMbyDNZJgE9y1+hmR230x0mb7sCseWE9xQSHJD1gsHBLXGCAXJkZLFjMifhbx69rZ4CdfrYr0gvyTNEY5oj9TimnHoSvlRBvUcxaiFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bTEsCjWA; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e4266673bbso21237305ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714152308; x=1714757108; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eIBGyKq1rfo9Eo8YNJRz2sicy53y3cFznRkoeYMePvs=;
        b=bTEsCjWA1QAmutxnUZ8MaLRya78f06eH6Qb1Q6vVGAjj5GYFyAGHtmmOs3ZkegOCzt
         gvAvbwIzEWadzyy+m3B4GYfkLOJy9fjQHQFck4z5R3Y1azt+2dJNbCiiizhNtwy05urZ
         4zGWc0duOTjaU2PoDeMtb9c3cgWGu50SDdGUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714152308; x=1714757108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIBGyKq1rfo9Eo8YNJRz2sicy53y3cFznRkoeYMePvs=;
        b=AN7+2DrKj7zwrXq1e9lcF8rLaFJ4L7KVdyfXmbqgrgUz3jhokoXPJQ5MHSota1rFsI
         RmhxZB06lRrtWMU7AqaCr7UcBxdpwhNogtYivRj7iuPj+Q6yqFJlqpOWsar0ovWBNtML
         XRHvftfn3FzfNwKco3zpcCn/dQCyrC3PSfAt1dIpVEMJLkM0VhY72Pl11o2bzlh3qUyV
         6tinUB3MgRdYU8LPpVyAAYWlU461rq0Oyk0alctsblWk+u++wX1F8zY+EtTrkPTrzCeM
         yrm7Wnhh1TPqTu2WJRgPXKsZSVUvVMVuik5HsXrdxDl5YPqf9U5AOgWbUweQHjcIa9a5
         w/7A==
X-Forwarded-Encrypted: i=1; AJvYcCXNAS01ebY1JOwxYKVxBKi/uuRAuAl7S/CR5i31qIhuQ6uxz8bBthbr991fAnYd507abDiWz27ZYP8rm1lUSnvOQ3pqWPCUep0e10Q3
X-Gm-Message-State: AOJu0Yy4X5p4imEVXLjhs7OVnXN+vQZj+dC+fn8l/X1Ai1bfMcdFNEOv
	pDvEMLjF+5dunROec4u67PjlfwBramQIagrjDK3F72hQTySPota0N+JE6I0F4PQME+Jjb082g3w
	=
X-Google-Smtp-Source: AGHT+IG0E5Z74FVbDWrRnuadfoaxsxXmigsr6NiBRtQVcDuOGGVB5BQLKeI6EmE850Ti68uW3W5ELg==
X-Received: by 2002:a17:902:ce84:b0:1e9:5fd6:2b01 with SMTP id f4-20020a170902ce8400b001e95fd62b01mr3798663plg.3.1714152307934;
        Fri, 26 Apr 2024 10:25:07 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y1-20020a17090322c100b001e503c555afsm10044542plg.97.2024.04.26.10.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 10:25:07 -0700 (PDT)
Date: Fri, 26 Apr 2024 10:25:06 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] Bluetooth: hci_conn: Use __counted_by() in
 struct hci_cp_le_big_create_sync and avoid -Wfamnae warning
Message-ID: <202404261024.1F22CC68@keescook>
References: <ZivaHUQyDDK9fXEk@neat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZivaHUQyDDK9fXEk@neat>

On Fri, Apr 26, 2024 at 10:45:17AM -0600, Gustavo A. R. Silva wrote:
> Prepare for the coming implementation by GCC and Clang of the
> __counted_by attribute. Flexible array members annotated with
> __counted_by can have their accesses bounds-checked at run-time
> via CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE
> (for strcpy/memcpy-family functions).
> 
> Also, -Wflex-array-member-not-at-end is coming in GCC-14, and we are
> getting ready to enable it globally.
> 
> So, use the `DEFINE_FLEX()` helper for an on-stack definition of
> a flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> With these changes, fix the following warning:
> net/bluetooth/hci_conn.c:2116:50: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Link: https://github.com/KSPP/linux/issues/202
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Looks right to me. Yay for DEFINE_FLEX(). :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

