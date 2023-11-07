Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D137E3202
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 01:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbjKGAIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 19:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbjKGAIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 19:08:04 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B54F125
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 16:08:01 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6b709048f32so4739639b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 16:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699315681; x=1699920481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rpBfLqGQ1VKrTJ3rcs4fBikFzF1QxsAIPWYX8n9C+y0=;
        b=Ft2gnIOwSF3Ap0pd8Y1sbge0ZRB+J81+y0RvxcnpMVwcUeRC6cC61fKOUs7GiqGh4Y
         C0hxzu5YEhfJtW2eKWfAeufgWcPvtSPqCc8IxjpLAd+dhhAOGFZUeb2vEN5/tFxdizN4
         j/l+iXo+M6WXhP6u1aMGQ3Cnh+WE5ypXNyqHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699315681; x=1699920481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rpBfLqGQ1VKrTJ3rcs4fBikFzF1QxsAIPWYX8n9C+y0=;
        b=kZdIWTvOrYnp8cn7EEaruSjvOp9bV+a8RZ5IoT5ZKcb3NsHdQmhBl/rZhkpIFIidtb
         vLk76nj4V2yV6OwZJF2Z3fqxrvF40aAT9NuOL4YrdF0Xq4GhXkjX9lA1X/Ccj90uYooA
         uEnVP6m/EamguHN7CUBhOdNEkIYEWLsF0yfqGHGINX8jPVWFcxMFhn+gRSgLYswSnKnP
         FLfu3oesGKl5iaAp4yDGHNy4MIK3xTcbbGzEKtZvMWzT6C3MsYt4kMfsxJdKf/gYtWgQ
         0H8xY+71t4zo+dUjG4Ibt33yxg37AFDusHsG9i8IT5glCWMTfS1AdFt66fOn5HCAo3pB
         JJ8w==
X-Gm-Message-State: AOJu0Yys2tqGG3/aYAmdTZJxIFPlr9uP5RqkehXNKjFrR7OyHufoSlTI
        5THaRbEFJ9Bdr84NJi8zejtq6A==
X-Google-Smtp-Source: AGHT+IGoYzR5kL2w+NjsZnBpueTqNLfZQcNpHmvWNnj8GRYy6lyod5A9USfm/k9J1c/4hIUoODiRdA==
X-Received: by 2002:a05:6a00:244b:b0:68e:496a:7854 with SMTP id d11-20020a056a00244b00b0068e496a7854mr27793278pfj.18.1699315681060;
        Mon, 06 Nov 2023 16:08:01 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r8-20020aa78448000000b0064f76992905sm6076788pfn.202.2023.11.06.16.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 16:08:00 -0800 (PST)
Date:   Mon, 6 Nov 2023 16:08:00 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Brian Foster <bfoster@redhat.com>,
        linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] bcachefs: Use DECLARE_FLEX_ARRAY() helper and fix
 multiple -Warray-bounds warnings
Message-ID: <202311061607.FFD1D68@keescook>
References: <ZUloNt0HSulJgZNH@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUloNt0HSulJgZNH@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 04:27:02PM -0600, Gustavo A. R. Silva wrote:
> Transform zero-length array `s` into a proper flexible-array
> member in `struct snapshot_table` via the DECLARE_FLEX_ARRAY()
> helper; and fix tons of the following -Warray-bounds warnings:
> 
> fs/bcachefs/snapshot.h:36:21: warning: array subscript <unknown> is outside array bounds of 'struct snapshot_t[0]' [-Warray-bounds=]
> fs/bcachefs/snapshot.h:36:21: warning: array subscript <unknown> is outside array bounds of 'struct snapshot_t[0]' [-Warray-bounds=]
> fs/bcachefs/snapshot.c:135:70: warning: array subscript <unknown> is outside array bounds of 'struct snapshot_t[0]' [-Warray-bounds=]
> fs/bcachefs/snapshot.h:36:21: warning: array subscript <unknown> is outside array bounds of 'struct snapshot_t[0]' [-Warray-bounds=]
> fs/bcachefs/snapshot.h:36:21: warning: array subscript <unknown> is outside array bounds of 'struct snapshot_t[0]' [-Warray-bounds=]
> fs/bcachefs/snapshot.h:36:21: warning: array subscript <unknown> is outside array bounds of 'struct snapshot_t[0]' [-Warray-bounds=]
> 
> This helps with the ongoing efforts to globally enable -Warray-bounds.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  fs/bcachefs/subvolume_types.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/bcachefs/subvolume_types.h b/fs/bcachefs/subvolume_types.h
> index 86833445af20..2d2e66a4e468 100644
> --- a/fs/bcachefs/subvolume_types.h
> +++ b/fs/bcachefs/subvolume_types.h
> @@ -20,7 +20,7 @@ struct snapshot_t {
>  };
>  
>  struct snapshot_table {
> -	struct snapshot_t	s[0];
> +	DECLARE_FLEX_ARRAY(struct snapshot_t, s);
>  };

Yup, this is the current way forward for 0-to-flex transformations in
unions or alone in structs (until it's supported correctly by GCC and
Clang, which is in progress).

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
