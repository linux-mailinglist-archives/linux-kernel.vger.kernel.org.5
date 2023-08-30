Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D08B78E305
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 01:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344399AbjH3XGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 19:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343729AbjH3XGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 19:06:12 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E684CF3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 16:06:02 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c0ecb9a075so1313355ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 16:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693436761; x=1694041561; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9JYKIPS2a/Iw0xLgRaWe30NqFEvhVB2/VIw8SYtFzVk=;
        b=D+hjtrkTRWseAG60mGPALZ4IIorEBJ2o0krbkPxCb6UlzTr7y8SnOmQSanjeWCG5x4
         HZFORxb+guZWshHiM2yEPaA+hzTdm4gjk4qn2lUsDYKPWRDI5jfC0kupC8pq5qN14ooL
         tKZ2mgle4yNJYDuYPqJqtcwhjKifbCMWa0BVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693436761; x=1694041561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JYKIPS2a/Iw0xLgRaWe30NqFEvhVB2/VIw8SYtFzVk=;
        b=W+zuB5A3UhKEO3TGngzrQaSA9duPqOPJl7EMpDDCWhilIttl4mG4jRPt29gW9tw3ft
         02CQgYLGv9rUpH/jzO1j8X7kwLaQbN1VDt3VIv54D/MGYOETXTcjpJPbDBuUuI68hAM3
         c3Z0xPkr3Cl2RAvI3VQlStD+CV3uuIBsnlEQcP8BIRYXjj3vW471zFV/+OVYfNvAF4dy
         xEhTxiGNpF1yOGpGzWb3Y/f6k/6xXfqCiiZvwmq3Ou0CrG2059DWFssq1zAqW6kDJgST
         u6/GofPKSsZGo5lWPZQj7H1Vtvc6eJ/q+OL4GwF+94F0mH5F1QX9OKGJeN3q2+tzWyaq
         Sf4w==
X-Gm-Message-State: AOJu0YymUzgyigoZJdNYRzeibebRqQQCUPbCLkS3c6f3eU2R7Afc4YhU
        8VcIzzqG1PnM7w+oTf9u7QY49g==
X-Google-Smtp-Source: AGHT+IHvcjsgESxgjsBsANNslu2fblYGTWQZibmYJFtloK+JU+1ZiyL/2CGqueDw+/3m2eLV8JFmhg==
X-Received: by 2002:a17:902:a40a:b0:1c0:cb31:d76 with SMTP id p10-20020a170902a40a00b001c0cb310d76mr2761512plq.58.1693436761703;
        Wed, 30 Aug 2023 16:06:01 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a5-20020a170902ee8500b001bd62419744sm26037pld.147.2023.08.30.16.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 16:06:01 -0700 (PDT)
Date:   Wed, 30 Aug 2023 16:06:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        linux-hardening@vger.kernel.org, ocfs2-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 2/2] ocfs2: Replace strlcpy with strscpy
Message-ID: <202308301601.8A8EE6B653@keescook>
References: <20230830215426.4181755-1-azeemshaikh38@gmail.com>
 <20230830215426.4181755-3-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830215426.4181755-3-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 09:54:26PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> Direct replacement is assumed to be safe here since
> it's ok for `kernel_param_ops.get()` to return -errno [3].
> This changes the behavior such that instead of silently ignoring the
> case when sizeof(@buffer) < DLMFS_CAPABILITIES, we now return error.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> [3] https://elixir.bootlin.com/linux/v6.5/source/include/linux/moduleparam.h#L52
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> ---
>  fs/ocfs2/dlmfs/dlmfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
> index 33e529de93b2..b001eccdd2f3 100644
> --- a/fs/ocfs2/dlmfs/dlmfs.c
> +++ b/fs/ocfs2/dlmfs/dlmfs.c
> @@ -80,7 +80,7 @@ static int param_set_dlmfs_capabilities(const char *val,
>  static int param_get_dlmfs_capabilities(char *buffer,
>  					const struct kernel_param *kp)
>  {
> -	return strlcpy(buffer, DLMFS_CAPABILITIES,
> +	return strscpy(buffer, DLMFS_CAPABILITIES,
>  		       strlen(DLMFS_CAPABILITIES) + 1);
>  }

This is another case of "accidentally correct".


param->get() is hooked here, in the sysfs "show" callback:

static ssize_t param_attr_show(struct module_attribute *mattr,
                               struct module_kobject *mk, char *buf)
{
        int count;
        struct param_attribute *attribute = to_param_attr(mattr);

        if (!attribute->param->ops->get)
                return -EPERM;

        kernel_param_lock(mk->mod);
        count = attribute->param->ops->get(buf, attribute->param);
        kernel_param_unlock(mk->mod);
        return count;
}

Meaning ultimately this will show up here, if I'm reading names right:
/sys/module/ocfs/parameters/dlmfs_capabilities

Anyway, the "count" being returned would be quite bad if
DLMFS_CAPABILITIES were dynamic and larger than PAGE_SIZE (the size of
the sysfs buffer).

For this case, I would say replace strlcpy with sysfs_emit:

	return sysfs_emit(buffer, DLMFS_CAPABILITIES);

(Also, ew, existing code doesn't include a trailing "\n". Oh well.)

-Kees

-- 
Kees Cook
