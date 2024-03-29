Return-Path: <linux-kernel+bounces-124092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACD2891224
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 04:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F4D0B23360
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9979F39FD7;
	Fri, 29 Mar 2024 03:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U3xGBqgq"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634CE748F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 03:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711683851; cv=none; b=TscRcLv/e7PyYxMKRv9kQKA3YR1RVN/KRojE7dbTgJBAgFZDg6f9F1nxyQa4r0d+SMrlOPtsuzCyQ1TuHa4dNnN2B7zTSGTyeJoqHKVStfgMreYOe6nYs/l8zw3LZqFuyGN8PHXpLwM+nWFuQEp6CIL7EJLo/k0ZLOaO0oeEfO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711683851; c=relaxed/simple;
	bh=Hn6PBrUxtM9PEhALDsKdQiFNiP/Av1s0kzCsSuzmZlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzWhIIAqtE4NDxRdG1YDnF6+SLd19wwn6iYqSafnm/eo2TD2gnD8K17TJGfLoaCjBos09YLiHG7v4vjAPU/yDd3lxx3y/QcThBTQ/JS7oAcUBzSGc8q4KfBMMnGCG/HulgJjKojHTD7UoCap7MnQnFfz3uA4sUjXGwjYGOv8/i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=U3xGBqgq; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e782e955adso1528978b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 20:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711683850; x=1712288650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iYyfCUJffNflR102beFTLmybYVFgFGdBqWkYnepitbw=;
        b=U3xGBqgq1ai8g4wb/Amvm1W3TYvkHCDNlrMoNffhbPLkSzf8Fi4qrgqw5BpIlhXdjE
         UZyNEANF+YOh5wqDiaYdZF9+eCEeLx9WVsxlp6rn4ehMMcIX7gwFfmBfNIqXHbcGmAk9
         3eu+JXp8asy/RvUufdSlg+PhAZvAPP3Tv8eSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711683850; x=1712288650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYyfCUJffNflR102beFTLmybYVFgFGdBqWkYnepitbw=;
        b=jie+RoodsxkuJWLXaZkTf6VjPL5f9Y675KceEn10hp2/v9iyx1kLxja96LymS14lB6
         0Fbi6TVjcS04hvKiBx8dM2eIr1hOqKNENBFOzYOPFyoyFobxIUlqxqw6P0apvItZT985
         hZatY3o+n2qsQMfCabI0AHsF97raGtn5IEreqFX3c+j7H3/Qr6tfrpzxPw2advbpJALK
         EgBU9IZxsGEr4jZma1dEqokC+QRzoDizlsNWrckmMdyOVrC/4W/TDd6M5aooFx60W4Oe
         HvirpN1ouGWs26NC7JZid6P8boZ9yI9RhB2FIzGzwlEQq7jgp/vzSKVRZwOrvnL9J12D
         Dw5g==
X-Forwarded-Encrypted: i=1; AJvYcCVK82Mgf6esvyG2GKODjgEpUlfVX4Mc5b5n6f4HDRyyJaazfjL9x3dauSl7zGe+JBtJAVNB3BEylhBFtTJ0WXLfMt/HDHpxfryJSx85
X-Gm-Message-State: AOJu0Yw5riVtMChDfCHMl1mf3l74X9UobDkR35C0FOedx59KjUT712x7
	ZFf8P+EB6FQM1N8/GeQRcAC9nVpEuBfYyurKFsyBRw/ZntosAsEaGqEVscxiug==
X-Google-Smtp-Source: AGHT+IE8eyoGTomKTbjdPTc2Vxuix7uawStOkJXkGHwVk/D4ySfj8KPf9WMW6IKR4qVjgWBaLvkZpw==
X-Received: by 2002:a05:6a20:1595:b0:1a3:8984:b334 with SMTP id h21-20020a056a20159500b001a38984b334mr1223944pzj.22.1711683849766;
        Thu, 28 Mar 2024 20:44:09 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s1-20020a17090a074100b0029c3bac0aa8sm4691791pje.4.2024.03.28.20.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 20:44:09 -0700 (PDT)
Date: Thu, 28 Mar 2024 20:44:08 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] smb: client: replace deprecated strncpy with strscpy
Message-ID: <202403282041.6A4E12EA@keescook>
References: <20240328-strncpy-fs-smb-client-cifssmb-c-v1-1-30d12bcf500d@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328-strncpy-fs-smb-client-cifssmb-c-v1-1-30d12bcf500d@google.com>

On Thu, Mar 28, 2024 at 09:44:48PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> In cifssmb.c:
> Using strncpy with a length argument equal to strlen(src) is generally
> dangerous because it can cause string buffers to not be NUL-terminated.
> In this case, however, there was extra effort made to ensure the buffer
> was NUL-terminated via a manual NUL-byte assignment. In an effort to rid
> the kernel of strncpy() use, let's swap over to using strscpy() which
> guarantees NUL-termination on the destination buffer.
> 
> To handle the case where ea_name is NULL, let's use the ?: operator to
> substitute in an empty string, thereby allowing strscpy to still
> NUL-terminate the destintation string.

Yeah. And for the non-NULL case, namelen is 0-255. And 255 comes from
strnlen() as the limit of characters, so namelen + 1 will include the NUL
terminator.

> Interesting note: this flex array buffer may go on to also have some
> value encoded after the NUL-termination:
> |	if (ea_value_len)
> |		memcpy(parm_data->list.name + name_len + 1,
> |			ea_value, ea_value_len);
> 
> Now for smb2ops.c and smb2transport.c:
> Both of these cases are simple, strncpy() is used to copy string
> literals which have a length less than the destination buffer's size. We
> can simply swap in the new 2-argument version of strscpy() introduced in
> Commit e6584c3964f2f ("string: Allow 2-argument strscpy()").
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

