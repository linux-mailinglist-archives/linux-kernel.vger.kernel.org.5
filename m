Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F467A87F6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbjITPNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234731AbjITPNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:13:35 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1FDB9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 08:13:30 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bf1935f6c2so7379665ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 08:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695222809; x=1695827609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/hyiPJzwLyvz53eOPwWn5KTS3ATXYJRveFNMbAiYRwk=;
        b=P3YvM4YLE5mdSNDQP8M83pygwFAlb3uI5G0LrtEMOn+sJK3er3zTqU/QyIncSs7RoK
         JTMEpFCaTV+ADa9cf4nqwf4nXcWkg8LOHtpidLsiri2q4GtYqUjSghXbS5d5y9lvRvBh
         FJJHr/rKVG9xIiHK/lVpHNeOzMRRTPPAWtpVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695222809; x=1695827609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hyiPJzwLyvz53eOPwWn5KTS3ATXYJRveFNMbAiYRwk=;
        b=Wiv7zSRzHgliZJnfTKkOt3iPXoZ6TLITcVSNPLylsh0x5Sth74oUo4K8y5RhwYQwAJ
         T3eWnnJAawiJMvhz+a5EM8asDDDg86Tk2UQcFfTrZni7UdpRZ0exQRxu+LrFHsREz3Xd
         iABrUqQMe4o47QJUR5xhbxqA2Ezs2Nc4TsAm+J6k6rz7rwzYaftnJsmAqws+TXOfiPNB
         yuN+A8CnrodTP/wTFZniGmSr6haPh5DajSAWQnixvDjn5s1nQiSDLS9YDPErQv2lxhJx
         /1Xg0PAt0g8U5n9uaPt8JvDQCAASTW4cygWGvlZqyHUd7im0y9QT0vO6xmcX/7I4qCAe
         w4FA==
X-Gm-Message-State: AOJu0Yy5SDVqVUOobLhZKVAy+RU/NdH4DGyktMWfyQ2sp5inE7ffoD/K
        Hb3iZrO70sWW0Cg5H140Jc9Hmg==
X-Google-Smtp-Source: AGHT+IHjY/EA4Uaz2uN8Hf+rV5YjM1d2ccJFzhZB2yI5nZQzuRgpHsCOPdzZTHTUX2L8rGpX2Z27SA==
X-Received: by 2002:a17:902:d2cd:b0:1c5:6f43:9502 with SMTP id n13-20020a170902d2cd00b001c56f439502mr4352961plc.14.1695222809493;
        Wed, 20 Sep 2023 08:13:29 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u7-20020a170903124700b001bb0eebd90asm11948601plh.245.2023.09.20.08.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 08:13:28 -0700 (PDT)
Date:   Wed, 20 Sep 2023 08:13:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeems@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v2] vt: Replace strlcpy with strscpy
Message-ID: <202309200813.1B0C125@keescook>
References: <20230919192156.121503-1-azeems@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919192156.121503-1-azeems@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 07:21:56PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first and returns the size of
> the source string, not the destination string, which can be accidentally
> misused [1].
> 
> The copy_to_user() call uses @len returned from strlcpy() directly
> without checking its value. This could potentially lead to read
> overflow. There is no existing bug since @len is always guaranteed to be
> greater than hardcoded strings in @func_table[kb_func]. But as written
> it is very fragile and specifically uses a strlcpy() result without sanity
> checking and using it to copy to userspace.
> 
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeems@google.com>
> ---
> v2:
>  * Return -ENOSPC instead of -EFAULT in case of truncation.
>  * Update commit log to clarify that there is no exploitable bug but instead the code uses a fragile anti-pattern.

Changes look good. Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
