Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2ABE7D0557
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 01:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346697AbjJSXUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 19:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235549AbjJSXUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 19:20:32 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BF3124
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 16:20:30 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6cd1918afb2so163960a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 16:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697757629; x=1698362429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VxLJorg7sQZllVq+pAfloWwR0pqLP2/+/WDA8tc+KdQ=;
        b=WSnrBaFEfIQzhBeOh2E56RJj/LqIQzFJe0rkjHDDH55NQzKDxQcZjWEM+VvqFwlUhw
         rRVlsincpi5POhv4Ag1fK3Q0iLbGt5r363khKiJ6xyVNkPWKe062IjPo8e9aIwovMx3t
         QiP8rofZnD+0QmmTCyOcF/3GVTBCHJH/cEWHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697757629; x=1698362429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxLJorg7sQZllVq+pAfloWwR0pqLP2/+/WDA8tc+KdQ=;
        b=dAX7dne14dvTqkMn0SvWjF2W7fnPKTHpvfdxyQKpIbNVFRj5qJp4zZXT0Jsz0b3nk1
         Op/w2hdrfC+/FQJWhky0V23JUcPDK1I4LuXsIULg14mSWhAffpEJJegR1HxDCWKAvPu+
         2hDdXpgh236JmhPgphgCz7Mwle896UFhpsS2idfFF73dkJN9PhnMBr8zhx/PrROm2adH
         sC7XDnwUXjzZNkiTwDDGFl/cL+mX4EEAThlRB+PUkgHBWzwCfVr/tivz5WjdFdEYCz2W
         yU++pYRG625BKS6S4S0tdZ7ijVfncH2RcyNFThEEHgoZ/36jEmnIU8mAi20qsFuz2TYq
         xfSA==
X-Gm-Message-State: AOJu0YwwPdDHmKU1SXdzeZh2Ms3DPtYv0+rcdoHRNQhclgJVMpYOWrhb
        83UPxhEOu6CeNlRMKMYwW4aqXw==
X-Google-Smtp-Source: AGHT+IHEKbiPITy9hpXV8pY+6rphvwnVu5/SOd6iNrHlgO7+Ii4hKo6iceZRtrHcdzoNlQQHAXQilg==
X-Received: by 2002:a9d:74d7:0:b0:6cd:cac2:e504 with SMTP id a23-20020a9d74d7000000b006cdcac2e504mr248754otl.18.1697757629690;
        Thu, 19 Oct 2023 16:20:29 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p7-20020aa79e87000000b006b2e07a6235sm302622pfq.136.2023.10.19.16.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 16:20:29 -0700 (PDT)
Date:   Thu, 19 Oct 2023 16:20:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] nvme-fc: replace deprecated strncpy with strscpy
Message-ID: <202310191619.6BE8E38@keescook>
References: <20231019-strncpy-drivers-nvme-host-fc-c-v1-1-5805c15e4b49@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019-strncpy-drivers-nvme-host-fc-c-v1-1-5805c15e4b49@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 09:34:35PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> Let's instead use strscpy() [2] as it guarantees NUL-termination on the
> destination buffer.
> 
> Moreover, there is no need to use:
> 
> |       min(FCNVME_ASSOC_HOSTNQN_LEN, NVMF_NQN_SIZE));
> 
> I imagine this was originally done to make sure the destination buffer
> is NUL-terminated by ensuring we copy a number of bytes less than the
> size of our destination, thus leaving some NUL-bytes at the end.

Yeah, this is odd, but I agree that the resulting strscpy does the
intended copy, since we've seen that other nqn strings are expected to
be %NUL terminated.

> 
> However, with strscpy(), we no longer need to do this and we can instead
> opt for the more idiomatic strscpy() usage of:
> 
> | strscpy(dest, src, sizeof(dest))
> 
> Also, no NUL-padding is required as lsop is zero-allocated:
> 
> |       lsop = kzalloc((sizeof(*lsop) +
> |                        sizeof(*assoc_rqst) + sizeof(*assoc_acc) +
> |                        ctrl->lport->ops->lsrqst_priv_sz), GFP_KERNEL);
> 
> ... and assoc_rqst points to a field in lsop:
> 
> |       assoc_rqst = (struct fcnvme_ls_cr_assoc_rqst *)&lsop[1];
> 
> Therefore, any additional NUL-byte assignments (like the ones that
> strncpy() makes) are redundant.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> Similar-to: https://lore.kernel.org/all/20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com/

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
