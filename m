Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA71E789030
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 23:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjHYVKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 17:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjHYVKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 17:10:03 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15FA2691
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 14:09:55 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bc8a2f71eeso10686755ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 14:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692997795; x=1693602595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ioTl4pnPl3Z+sUu/zLbbgMcEXvo9RP4TdutXMy62DoY=;
        b=Bl4a/2bwAgFJ9jQHPgOwtVW76ypJYiv7OBVpItzho33dm0jU6G+PVUJECyF0RmX92G
         ScLc3BXsH7kwklH0VgszuV/glqwgvDbfeqf24mp9bYUDJz6Hi6/s90tpQeDosn0PEEZ5
         wjhg03y2Fo45JobsG831uuKn2iOC7aIQDV+DE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692997795; x=1693602595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ioTl4pnPl3Z+sUu/zLbbgMcEXvo9RP4TdutXMy62DoY=;
        b=ekwFd8FXbV8qD7bkbmDw4Mp+h1dARDYtiseLpk2UlbNFxlbUaol+AoPTWI06QpO0aP
         /PZ4PHCvLpWu6rSrFw/kJ6i/ZsZHkN64aYHjFzl5S39Yv/K4kV+lhTLQroh7gCBPgaDh
         18+XLbRY+c6dC6wRDU1j/1f3SY+o3KAu4Cj7zgTcUBNXm75qMmvq7nuttGtDJoD6Knf2
         oRtEq1oboelL3A81bo4sC1OdVJhjmLYGr9tSLfDBpOITeCawqO5PPHWTOiVMmId/OwwY
         AsBaYBhneeY6r0uB4O7zo/VecLxf9hA4+75vDBxj1vh5/1aG1Iryao4yRlZVsTGY2d7I
         FfvQ==
X-Gm-Message-State: AOJu0YxiKT1KVB6JX2hlbL/RvM8Usf07spb7ifPXFsqE4J1XiMZs1R70
        3EdSjW3OWGHGkxsr+0/QQ87Wgg==
X-Google-Smtp-Source: AGHT+IFMI18U8oAYoerCCz1ml/4BSSkWxer2lCXNRlY65b/XvLu/6VLXjYRjNvHGFbl6mUI06+gjEQ==
X-Received: by 2002:a17:902:d342:b0:1bf:650b:14fb with SMTP id l2-20020a170902d34200b001bf650b14fbmr14746237plk.42.1692997795136;
        Fri, 25 Aug 2023 14:09:55 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u15-20020a17090341cf00b001bdc9daadc9sm2221180ple.89.2023.08.25.14.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 14:09:54 -0700 (PDT)
Date:   Fri, 25 Aug 2023 14:09:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@kernel.org>,
        Amitkumar Karwar <akarwar@marvell.com>,
        Xinming Hu <huxm@marvell.com>, Dan Williams <dcbw@redhat.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 2/3] wifi: mwifiex: Replace one-element array with
 flexible-array member in struct mwifiex_ie_types_rxba_sync
Message-ID: <202308251409.A52310CB@keescook>
References: <cover.1692931954.git.gustavoars@kernel.org>
 <79c801c69c8beece2f80502c60166036d3c047cc.1692931954.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79c801c69c8beece2f80502c60166036d3c047cc.1692931954.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 09:07:43PM -0600, Gustavo A. R. Silva wrote:
> One-element and zero-length arrays are deprecated. So, replace
> one-element array in struct mwifiex_ie_types_rxba_sync with
> flexible-array member, and refactor the rest of the code, accordingly.
> 
> This results in no differences in binary output.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
