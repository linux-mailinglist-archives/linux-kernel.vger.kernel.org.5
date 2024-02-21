Return-Path: <linux-kernel+bounces-75548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A39BA85EB05
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3856C1F23463
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A73C127B57;
	Wed, 21 Feb 2024 21:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GGu4vyyk"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD6112882F
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 21:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550791; cv=none; b=ScGqMKBevxH+sU7jXtjtsWhKQPON2aJqqVthViYF6rINwR4F3+uRGOpkMzrInEwZYuUywJ6tsBwXZNx7D/WaDfnk6P+1dSr0D7Dl3KRdCuFShmKE2orH72gX9YNxWIWy7tPqJzKU1nxKG146l+Ap0ja/evN8P3VKnq6N1+f708Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550791; c=relaxed/simple;
	bh=spjmovyqWWJ+CnNL4umKyVRlDIu1FG7HgQO344HeZf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9H+OVsthWFnHK5TIogePpeN5UH/f7oT6i97OIzQJr14Sn4uKaYcwOBpQw23TTVhSWqdCsxAg+RK3w+xON9qiN0Z+S0cjpae08zjRqTpfAW17Jc4PKbgV+zVmtfMgVDBLJZYPq5gnZAazA7s+b0xBGd8/BUye5J3PlRz1+788HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GGu4vyyk; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-363bdac74c6so19662375ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708550788; x=1709155588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ei6xuNgF/xoTMzRe+RBiR7YMpzO4E4Wmr5k4IfUD1BE=;
        b=GGu4vyykHtXA/VGgP/j+FQl++3+a5FC+Crmix1M4TWLsGpDF4q5q2DruxE/uFnj9ah
         ewf/bEK4rqYsMuVr2ZVX+hE77YgWRECEg17eISkKuyou9HRdX6rgmLri7SGSHW3HXL0z
         Tv0csZk9jyA7j32XsANR72zK1wmaKfEOITpR2PMvriy8U+bHk++7DQIa5XzSXs4NzWLn
         EvCLeg6SfvclRdi/xdbUs8aoBOMzdtwSkYGeC5b+0ANsasbZt3DGUV2Dt6Hfgo5ScGWQ
         DPngbVs1BXN8wyNj1gcgfQ0ZCIo9P2odKIbewTI16dnOdH+iKV7BRJdQd07OE05s0NP4
         t+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708550788; x=1709155588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ei6xuNgF/xoTMzRe+RBiR7YMpzO4E4Wmr5k4IfUD1BE=;
        b=j1lhPppswI3gWdzryFF0Vr33kbj2DRNC9i/Q0uC+DRcbNJBdnZ9SeXWNwhB+E1XN/6
         NXZK45Jq81CfGbI1K/Mt0QnJzC3s8PrhlQOKmT9w+TGM0pRIj08MAoIKq0gwkF9B+FoO
         99poZzZVglpogW3tDlUC4U49ns4ApWRpye8LVM8A0PsDwBE6/JO4VQvQNNosoBqTpV5X
         g1YSEglMaF0cezhfxGhbv8YXyyxtD3DQsNt28Lo1VXF9Pgwpke8bhBfL4cDBb3ZXXqUP
         sAs9d5+g2Yxr4dErCJE4p8UsAmstBWTiMm3XeZorxDEDwg8z7yRGlQRfA+afPsB73aPH
         JIbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUz1OXT8NqXLUobtsXzRWUvsTP4elsKN4/8EbmZU7xL0wqLHrORJ5z9qpmHmlcPxbpHER6XTuEYb1D0HcJ6Tjz0Yo9Pyn0dUiP9hCn+
X-Gm-Message-State: AOJu0Yxe8E9E/Z69QKKfFsxs16V0W/xU0x4Xkdd/+4/yPVsAEoOWVG4/
	MpJbiTg4b4XNJa9MVQs2zRx6Lrqk7o2HOaZ2URl3p45dKkthgMCMgUiFzSB1kA==
X-Google-Smtp-Source: AGHT+IE94cj8KTh5vsD6rggbO3A8K/diAIkIrFg2CCSYRvCxTJhEhQffit7CiRPnd2AjVYaPB7SsEQ==
X-Received: by 2002:a05:6e02:4cd:b0:365:b29:3fda with SMTP id f13-20020a056e0204cd00b003650b293fdamr16002018ils.24.1708550787816;
        Wed, 21 Feb 2024 13:26:27 -0800 (PST)
Received: from google.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id o16-20020a056e02069000b00362759b0e4asm3592139ils.32.2024.02.21.13.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 13:26:27 -0800 (PST)
Date: Wed, 21 Feb 2024 21:26:24 +0000
From: Justin Stitt <justinstitt@google.com>
To: David Gow <davidgow@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>, Rae Moar <rmoar@google.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Kees Cook <keescook@chromium.org>,
	=?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Willem de Bruijn <willemb@google.com>,
	Florian Westphal <fw@strlen.de>,
	Cassio Neri <cassio.neri@gmail.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Arthur Grillo <arthur.grillo@usp.br>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Daniel Latypov <dlatypov@google.com>,
	Stephen Boyd <sboyd@kernel.org>, David Airlie <airlied@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org, linux-rtc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-hardening@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 6/9] net: test: Fix printf format specifier in
 skb_segment kunit test
Message-ID: <20240221212624.w4r2w6acijkwn7qg@google.com>
References: <20240221092728.1281499-1-davidgow@google.com>
 <20240221092728.1281499-7-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221092728.1281499-7-davidgow@google.com>

Hi,

On Wed, Feb 21, 2024 at 05:27:19PM +0800, David Gow wrote:
> KUNIT_FAIL() accepts a printf-style format string, but previously did
> not let gcc validate it with the __printf() attribute. The use of %lld
> for the result of PTR_ERR() is not correct.
>
> Instead, use %pe and pass the actual error pointer. printk() will format
> it correctly (and give a symbolic name rather than a number if
> available, which should make the output more readable, too).
>
> Fixes: b3098d32ed6e ("net: add skb_segment kunit test")
> Signed-off-by: David Gow <davidgow@google.com>

Looks good.

For those wondering, %pe has a special meaning in the kernel which can
be seen in lib/vsprintf.c.

Reviewed-by: Justin Stitt <justinstitt@google.com>
> ---
>  net/core/gso_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/core/gso_test.c b/net/core/gso_test.c
> index 4c2e77bd12f4..358c44680d91 100644
> --- a/net/core/gso_test.c
> +++ b/net/core/gso_test.c
> @@ -225,7 +225,7 @@ static void gso_test_func(struct kunit *test)
>
>  	segs = skb_segment(skb, features);
>  	if (IS_ERR(segs)) {
> -		KUNIT_FAIL(test, "segs error %lld", PTR_ERR(segs));
> +		KUNIT_FAIL(test, "segs error %pe", segs);
>  		goto free_gso_skb;
>  	} else if (!segs) {
>  		KUNIT_FAIL(test, "no segments");
> --
> 2.44.0.rc0.258.g7320e95886-goog
>

Thanks
Justin

