Return-Path: <linux-kernel+bounces-75725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD94E85EE0B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF8AE1C218C5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67798FBF2;
	Thu, 22 Feb 2024 00:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FewjVpXr"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBD22919
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 00:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708561835; cv=none; b=AVXyn4qpNW3RDq5j2Cd5vAlW8PZAPDm4EF5Vn12+KUoBVPHR9yH06YFkMGeZ9dUuEM1sAL4QpvszhT9xVLonnCqUVXWgOb00jAlHv7BcNludvOLC1TvSAJa7sSZBSIGuYk5ZV1yOHN8mZGs+pxY/yHt/mscCRUFs1sSoedYLf0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708561835; c=relaxed/simple;
	bh=0a+PXUr4/M4QxUhsk3p3ht76EXkTT/vUlf3xCYroLtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7GkDU3WLXOJ0Htv0czbRRq3ZV8RvHe1FPpzUmUz7af3JUnTymKsoP0BcrzUt1yzpH0qndFwlHQQzjGJJJ7PRAFfnzbGLvXjkYBaPr5t0WCs7XeOe3Cmmw15syqiFXEY1HA13DXSLlpg3JnQMXkxgSYB/Tr3G+82uTgyUQ4dW7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FewjVpXr; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-29041136f73so881354a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 16:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708561833; x=1709166633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cphzXha2ug67Fvg8bHldw5MnRmdUMWu6AQ/eN1G60FM=;
        b=FewjVpXrIrXCAek5YMytycaY9A9MQ2RoFd3GLoRK2WyUbT57vK63pWTQjLE7j7ugiX
         nPWzTjI6JiIvnZ6HIzDShW6NbJYJs2Qo3e26peOn8PjRFSgB1gIlF5l4r9fFkVB11kVU
         N9pxagOfd4lKZF/jSVOGF/q8qW7XLoBsp1oRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708561833; x=1709166633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cphzXha2ug67Fvg8bHldw5MnRmdUMWu6AQ/eN1G60FM=;
        b=tdwjQ0NfYS7+GhpUFH2ZHLBeHYKwJzPHQPtruycf0ehA8Q7+VfxpGLb7u9DexNIGXe
         7wwTy9azLj5TBEF/qMisNlDQTdKRFIOcvlXg6GTIT6bT7u0YknC0hSUjNbuGA3ZLo9Br
         V5vX4lIssf+4BWiJcj2vEb111/aJBNfQ6LSfl1etWb5Il/+SDHAB4l+vRpGvACxINiRZ
         kwNpRB861i0/6RGC38DQcmTwEuQFXKLFSWj8oExBaKB6VAj1NleqL2tht+VUbXp35bMS
         evoQ1SsAbDLZ7F1uQPNGXIpbsWq6qXh17j/FiU/Y3ZJx7ocXdfFrhw1XnY9RBEGEhVvB
         Ws4A==
X-Forwarded-Encrypted: i=1; AJvYcCWLjzouRKjozk8AJ78a34gjXUVjgVkhRrxe/lg54Q6GZl7bNcPBzLVIYxLVnquR6R09Muov0H1ewGwyWYkln0/bdZiIqJ/YDxetHNii
X-Gm-Message-State: AOJu0Yy8pPgyTZyC4Lj6ENCI9ot+R3leZKtQaz7E/VZoql1KIU4uk9qx
	40ILCeZVUMrOkUhH1ehWOZ7g4MUS7CMg6G5u1VK7V1972l31WJxnT6fcxjeLoA==
X-Google-Smtp-Source: AGHT+IFPk//p0bZSwagAp3iX4U/EP6BCxupu6BvHEFS6IcIIUIlmW54lKSp/YxG5QTnQKWBq6j+csA==
X-Received: by 2002:a17:90a:b902:b0:299:3258:4053 with SMTP id p2-20020a17090ab90200b0029932584053mr14295400pjr.15.1708561833583;
        Wed, 21 Feb 2024 16:30:33 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e21-20020a17090ac21500b00298dd684b8csm10445951pjt.32.2024.02.21.16.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 16:30:33 -0800 (PST)
Date: Wed, 21 Feb 2024 16:30:32 -0800
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Hannes Reinecke <hare@suse.de>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] scsi: libfc: replace deprecated strncpy with memcpy
Message-ID: <202402211630.184FE822FB@keescook>
References: <20240221-strncpy-drivers-scsi-libfc-fc_encode-h-v2-1-019a0889c5ca@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221-strncpy-drivers-scsi-libfc-fc_encode-h-v2-1-019a0889c5ca@google.com>

On Wed, Feb 21, 2024 at 11:50:26PM +0000, Justin Stitt wrote:
> strncpy() is deprecated [1] and as such we should use different apis to
> copy string data.
> 
> We can see that ct is NUL-initialized with fc_ct_hdr_fill:
> |       ct = fc_ct_hdr_fill(fp, op, sizeof(struct fc_ns_rspn) + len,
> ...
> 
> In fc_ct_hdr_fill():
> |       memset(ct, 0, ct_plen);
> 
> We also calculate the length of the source string:
> |       len = strnlen(fc_host_symbolic_name(lport->host), 255);
> 
> ...then this argument is used in strncpy(), which is bad because the
> pattern of (dest, src, strlen(src)) usually leaves the destination
> buffer without NUL-termination. However, it looks as though we do not
> require NUL-termination since fr_name is part of a seq_buf-like
> structure wherein its length is monitored:
> |       struct fc_ns_rspn {
> |       	struct fc_ns_fid fr_fid;	/* port ID object */
> |       	__u8		fr_name_len;
> |       	char		fr_name[];
> |       } __attribute__((__packed__));
> 
> So, this is really just a byte copy into a length-bounded buffer. Let's
> use memcpy().
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks for the refresh! This looks right to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

