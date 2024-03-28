Return-Path: <linux-kernel+bounces-123715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A304890D07
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E863028F0B8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B576F13EFEF;
	Thu, 28 Mar 2024 22:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SnG/rCdZ"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EF913E6D4
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 22:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663614; cv=none; b=aBkrMbH2Ue/E8mQa4bLI6gBQPWGtWYPgOd2gtZ6VWgD0A629/1jGLxqPA4ODne6fAC9ZVDEM9wWXSS1M9c3yemeO0fdfiPwluygdJtl3/VjTXNi4xaw52EcklhRT0gfs2JpNISqYl5PQag4/VUDNjQpSjh2ukgSlaBT0DNPQQ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663614; c=relaxed/simple;
	bh=5AJMO6myigFkuoAXfMA9V6C/wHc4aj530blLJIkgPVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKO+wsSEn6G2JgUwvFVozb3BndtDnLSto7qFSdcTKaFWE7sVc1R0/FpmGADHg/tUd+N1Msf8YqmXtVBio+p/ZfttXy9fIROicQFyzxICBNOZLhvMze83H/9n5ptqECjx8EC6C/LL0qggBtzVVi+cUPzpNryJG6uevVCDlTMdhNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SnG/rCdZ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ea8ee55812so1432285b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 15:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711663612; x=1712268412; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FawcQ0+/Re5CGM1VyfGak6NYsr/nN1VT9V2EvlsawhQ=;
        b=SnG/rCdZPSYTqZXyx7kblvvq01NvD8lYu7FQ4biSzbMUZVoZwxV/4dbs0dbEHlxf0r
         AmC3eDqWf+L4ZjF0wRj3RmCxciZGBB9n++5TpUtz7NjT3TqWa7FK5QejboAeu6R4I8+o
         A7sEc8xRGVH8CIgdv25hACaKysz3iLmKQs8oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711663612; x=1712268412;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FawcQ0+/Re5CGM1VyfGak6NYsr/nN1VT9V2EvlsawhQ=;
        b=HwcJZsIAXSzibDm+WNcx9mIRBvmXvrOHD8eum48B7lw9Q/nD0jSrsP+FLf/lkZVgaT
         ALBFyfc0CdMBWwPTRPqyYmc55My01nW2QKoqRN5L+do9h/u8TshGKTL/Un24dyVTeBpk
         oCqgrkI5FXTLuU9eHy1qMNRglXwP2djnton2Ys01KnDpSgl7QKXcO2Uc2ScLCB2e5aki
         I5NxXeI+0NZMVHJTkd+WlOPY1nqk3q/ki3yiqq4zvp6/1BFmsLVi5/4BHvcLzdwNdwku
         klh7m519+QbGskbVsHU1xlhhhMcsOvhbSObq1hBT7vdmHzh334l31A6935qg1Fb+XcYg
         WzBg==
X-Forwarded-Encrypted: i=1; AJvYcCUKGu05Dus93tVXrkNNCz8KjDmL8xQU2l2RKRueSuE6o5HrFB30Sp3eOizfa4apEBmmTd01TuGwJiCZV4/ZSQ8mfWRGt1HDgzl/RQ1z
X-Gm-Message-State: AOJu0YyeAO7OZyXxIyiZ1GnSwL61b6ryigmDq91ZA5hd6NnX5//RJ3l1
	krX0AHi5pr2ANplh69K6hqfP3NShbrEGX7fauVuPgTnWc4+el7UqocW9KD9vRAUzzAFZVDyBRew
	=
X-Google-Smtp-Source: AGHT+IG28FKoAE9GwUDPDbAhJpDSQvO83TTQaELwCTDF264wtxqHJW3X538E+oFBl7uIp2mx5xeCig==
X-Received: by 2002:a05:6a00:2d11:b0:6ea:749c:7849 with SMTP id fa17-20020a056a002d1100b006ea749c7849mr707745pfb.13.1711663612175;
        Thu, 28 Mar 2024 15:06:52 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g21-20020aa78755000000b006e71aec34a8sm1870864pfo.167.2024.03.28.15.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 15:06:51 -0700 (PDT)
Date: Thu, 28 Mar 2024 15:06:51 -0700
From: Kees Cook <keescook@chromium.org>
To: Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>
Cc: linux-security-module@vger.kernel.org,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, apparmor@lists.ubuntu.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] apparmor: fix typo in kernel doc
Message-ID: <202403281506.6E7F782@keescook>
References: <20240315125418.273104-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240315125418.273104-1-cgzones@googlemail.com>

On Fri, Mar 15, 2024 at 01:54:09PM +0100, Christian Göttsche wrote:
> Fix the typo in the function documentation to please kernel doc
> warnings.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

