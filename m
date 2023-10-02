Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23CA7B5902
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 19:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjJBRiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjJBRiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:38:18 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4510F9E
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 10:38:15 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3ae65e8eb45so14866b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 10:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696268294; x=1696873094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nZdjMGhKnja++t4G0+IGwkpRsvCc+P6k0aX0HlX3RbU=;
        b=Noy6DnfeZ05f/R8ut7vjtHZcFxg6g3oSWTNVXtzhUfVktfxjC2CtusoEE3DLypknrI
         jzWjB7X4/xSsCvE4/1nU2jJuSNM/2ZplVaBBfJz7aJTdFZoczFgl+yNRnp7Cf8d8hICG
         4GWoYnAZzwytYNcZRetrXYhorgx9rz4JJhFQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696268294; x=1696873094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZdjMGhKnja++t4G0+IGwkpRsvCc+P6k0aX0HlX3RbU=;
        b=TWRNGwSG/JPzP/59IyBmj0ecigNwTQKt4E7dWs0Ql2TVV2VDcQFIZGzFowg2WBVk71
         7CA6TI6+6eX2JlMutvP+B0qsDxAXZbxnKhonoBRRTXAqwTrUYXjVUA+PB1BvUt2A8Ey9
         Jg6aiDH6vhD2Vl9RnvG2CX10tuhvUOHfI8iZP/HDgkgIx/D0MZDuSBuc7GP5huJ9MCoo
         KStewjPXIxeuDTTkq90Wg6hjdBEAOaGjP82qFo1K5AUIJoao6bapojUQtzIFYnz0vm70
         7rv7p19sA5c04HgdBYe56zw+6RLsIjy13A5lGfYZrwUXc/A5bLcug+OISIBB0hvVgSPT
         n2KQ==
X-Gm-Message-State: AOJu0YwkvdlcSPSc7lUmyjkgFmhDaA1GYWpAU36pFLXE4F1m1LvTzvA5
        Ldt9y4uXVEzxlUjotnvPODvD9A==
X-Google-Smtp-Source: AGHT+IF62FOVZA3oL8q16eIdT1W2zWITx4eI7ky2roTfIwlDc1mzrjtysFRODnQhS8L/pv5FUCuKdg==
X-Received: by 2002:a05:6808:f04:b0:3af:6cf3:d62f with SMTP id m4-20020a0568080f0400b003af6cf3d62fmr13262587oiw.29.1696268294499;
        Mon, 02 Oct 2023 10:38:14 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s65-20020a17090a69c700b00276d039aecasm7216306pjj.13.2023.10.02.10.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 10:38:14 -0700 (PDT)
Date:   Mon, 2 Oct 2023 10:38:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] udf: Fix undefined behavior bug in struct
 udf_fileident_iter
Message-ID: <202310021038.9F85D987AE@keescook>
References: <ZRrsYkKIQe8K6F/t@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRrsYkKIQe8K6F/t@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 06:14:26PM +0200, Gustavo A. R. Silva wrote:
> `struct fileIdentDesc` is a flexible structure, which means that it
> contains a flexible-array member at the bottom. This could potentially
> lead to an overwrite of the objects following `fi` in `struct
> udf_fileident_iter` at run-time.
> 
> Fix this by placing the declaration of object `fi` at the end of
> `struct udf_fileident_iter`.
> 
> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
> ready to enable it globally.
> 
> Fixes: d16076d9b684 ("udf: New directory iteration code")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Looks right.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
