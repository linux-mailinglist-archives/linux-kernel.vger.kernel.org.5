Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8067E2D0E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbjKFTjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbjKFTin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:38:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C628173B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 11:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699299403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/7nXQhaGb4pY7ry3e+e6wtXTEqqn1g4LsKBGCFFbdOs=;
        b=Iw6s+WGzMosFsG26Bx0pjHGxnDyXRDOcQldFAqxJOTArdf7FYoBybH/gpOSvhSmL9K082+
        iGUEVr+nMAtQeJSBMFu0fXVUUpUhIFtmy6x54zzzTZN56xqYvk9OUixuwdCUqkcfs7T68t
        0DuWJ5OYmme2hncuJDQa+k/pXrGxZSk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-LaJe6vf1NySAAtVJC5wstA-1; Mon, 06 Nov 2023 14:36:31 -0500
X-MC-Unique: LaJe6vf1NySAAtVJC5wstA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-77a51a90d6cso531283185a.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 11:36:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699299391; x=1699904191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7nXQhaGb4pY7ry3e+e6wtXTEqqn1g4LsKBGCFFbdOs=;
        b=kFLhVfXgqMNoAqjWyiiUC7qT+7PJHmstUvYl3CoF4Hctt8ZH/lh9KrYOA3IfNw/KVp
         WYptTEq+i/UgaXvxbF/zAgqWy0OeQJzcS5JFt5OeJ7hTJHgWEuA+cBrSi//pU3Rukoy3
         iKs7z4RbenpwgOWr3DmKJ2Doxpva5a5k6bWxn0UqIcXX6P9fnd0OkdU3X606Vy+zMyG4
         xdyb/lnpjOjwLSLOSpUNTvwA61FiM0UxOEEraPjMuZyAtoAr46L0KjmCcPRQV82kIPHM
         Igv2F1riHKO3QwBhHxLUlU1fpjFbykE4kXY5xXe4K0r2OD0qfmItdRnrmgiLAneJElOm
         1nxA==
X-Gm-Message-State: AOJu0YwMKr1Cm52kEYvBHpGRAKciDl1UW06apfxCD1/md/Sewwbni4zh
        a1GKuVTovSyGndaLIrEW9sfBZdp2vy68LDX2PUjAgontqjaqanJHw4q3qhYW/y9qysp/7TG3a7+
        VPRDfGCpOAwitRHKssgreM5GZ
X-Received: by 2002:a05:620a:118e:b0:775:f1bd:f75e with SMTP id b14-20020a05620a118e00b00775f1bdf75emr29927580qkk.39.1699299391174;
        Mon, 06 Nov 2023 11:36:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNkybdYX04EQtC/tz+Zpa+0fOVbb/hUPD57Vng3tHmEY+2ovmvEntRX3G/+cgNqoXu8DTZmg==
X-Received: by 2002:a05:620a:118e:b0:775:f1bd:f75e with SMTP id b14-20020a05620a118e00b00775f1bdf75emr29927560qkk.39.1699299390943;
        Mon, 06 Nov 2023 11:36:30 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id qs16-20020a05620a395000b00774133fb9a3sm3537442qkn.114.2023.11.06.11.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 11:36:30 -0800 (PST)
Date:   Mon, 6 Nov 2023 12:36:29 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        William Roberts <bill.c.roberts@gmail.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        James Bottomley <jejb@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Julien Gomes <julien@arista.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 2/6] tpm: Store TPM buffer length
Message-ID: <4gyb46g6makecsv7mq67qdp5hilytpymvdbffz5q64tday5dva@wjg3achi5rrv>
References: <20231024011531.442587-1-jarkko@kernel.org>
 <20231024011531.442587-3-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024011531.442587-3-jarkko@kernel.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 04:15:20AM +0300, Jarkko Sakkinen wrote:
> Both TPM commands and sized buffers (TPM2B) have a fixed size header, which
> is followed by the body. Store TPM buffer length to a new field in the
> struct tpm_buf.
> 
> The invariant here is that the length field must always contain the total
> length of the buffer, i.e. the sum header and body length. The value must
> then be mapped to the length representation of the buffer type, and this
> correspondence must be maintained.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  drivers/char/tpm/tpm-buf.c                | 36 ++++++++++++++++-------
>  drivers/char/tpm/tpm-interface.c          | 18 +++++++++---
>  include/linux/tpm.h                       | 10 +++----
>  security/keys/trusted-keys/trusted_tpm1.c |  8 ++---
>  4 files changed, 49 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> index 88ce1a5402de..8dc6b9db006b 100644
> --- a/drivers/char/tpm/tpm-buf.c
> +++ b/drivers/char/tpm/tpm-buf.c
> @@ -18,6 +18,12 @@ int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
>  }
>  EXPORT_SYMBOL_GPL(tpm_buf_init);
>  
> +/**
> + * tpm_buf_reset() - Initialize a TPM command
> + * @buf:	A @tpm_buf

One minor thing I meant to mention, did you intend this to be &tpm_buf like it
is for tpm_buf_append?

Regards,
Jerry

