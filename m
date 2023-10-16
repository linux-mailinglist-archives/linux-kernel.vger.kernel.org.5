Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AC77C9F19
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 07:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjJPFsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 01:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjJPFsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 01:48:02 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE98D6
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 22:47:59 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4056ce55e7eso40689655e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 22:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697435277; x=1698040077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=APqyNWoGiniVbLUmpGHDy/Anj/nDAihOoYwD68G5Kvc=;
        b=WWU1oiPlc2oIE3KUL3ECJKHqPSwtY7jmAM8/djDse3R9aZ3mxcrbCKET+DXtdvMc2L
         C3IfIUhp5c1pL2GmgF8zG2UZQi3pIfShRxWF6GWnMLQmyEMdZg9+MdLoCkDr//A8EqH8
         K4EmYcPbFpeosN1CQg5Yr5CRGYBtR9UjTbT0vFGTQMDHSW0MWWg4DEU9pmiWe8CAc8/g
         d1xs8+MPshvxhuA4L2E3vTM0u8vEEAAvNTVzCmztn3N4QAVaMYteWMp9mPQFnmYHfkZW
         CYJDG8EN3StEWsqe+n5wcV3NTcs44itulq4wOIOq4NFlSQZwlVAWOXGpeVwRZcAoJbVC
         c3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697435277; x=1698040077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APqyNWoGiniVbLUmpGHDy/Anj/nDAihOoYwD68G5Kvc=;
        b=hTgFFQLaPpx/roXBkgfPpyZgfG5C/ycK1ffObSu4c1uEFQVEyXnkznI/axWdpsonH4
         om21f/oogJA/nsn+TANDCRYoh1DnK3vsbXurjDAOUTfE5YyUDYQuzOeU3SNGI9gsfizX
         p+Jwa4EYcIL4VWcKmuraiOtS8t2VhHOCWaLH15KmXJ3u4Dx4froILOtqOnOy8oyXE75U
         5T3NfkbJw2a5XNL4pkjn21M70iU5596y5lkzxfOE1ssCtAlIsj8QYr/lCXj/48ku1mSF
         OrTK+3BPya6vOljIJvlPhndnQTXJKRL7qeyJ5C4ihsqSOLk9lLCex1mnvYByB1zYBjVG
         4wtw==
X-Gm-Message-State: AOJu0YwegYevxUUWIp0wZ23PB+S+QdHmDDyjvz6UhG07okF0yO7AMmi/
        64uCKwB+R/qX2Z6H8sJ+PO1YAw==
X-Google-Smtp-Source: AGHT+IEqFBJmt4qwktiIeWcTfadTv5RQBY42SkmYDcKqxJZy53DlvvoIzGgZ3IbRwu3jJLQlcNIdvw==
X-Received: by 2002:a05:600c:2298:b0:3fe:1af6:6542 with SMTP id 24-20020a05600c229800b003fe1af66542mr27821090wmf.33.1697435277411;
        Sun, 15 Oct 2023 22:47:57 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 13-20020a05600c230d00b004068495910csm6156468wmo.23.2023.10.15.22.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 22:47:56 -0700 (PDT)
Date:   Mon, 16 Oct 2023 08:47:53 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Simon Horman <horms@kernel.org>
Cc:     Justin Stitt <justinstitt@google.com>,
        Thomas Sailer <t.sailer@alumni.ethz.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-hams@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] hamradio: replace deprecated strncpy with strscpy
Message-ID: <ede96908-76ff-473c-a5e1-39e2ce130df9@kadam.mountain>
References: <20231012-strncpy-drivers-net-hamradio-baycom_epp-c-v1-1-8f4097538ee4@google.com>
 <20231015150619.GC1386676@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231015150619.GC1386676@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 15, 2023 at 05:06:19PM +0200, Simon Horman wrote:
> On Thu, Oct 12, 2023 at 09:33:32PM +0000, Justin Stitt wrote:
> > strncpy() is deprecated for use on NUL-terminated destination strings
> > [1] and as such we should prefer more robust and less ambiguous string
> > interfaces.
> > 
> > We expect both hi.data.modename and hi.data.drivername to be
> > NUL-terminated but not necessarily NUL-padded which is evident by its
> > usage with sprintf:
> > |       sprintf(hi.data.modename, "%sclk,%smodem,fclk=%d,bps=%d%s",
> > |               bc->cfg.intclk ? "int" : "ext",
> > |               bc->cfg.extmodem ? "ext" : "int", bc->cfg.fclk, bc->cfg.bps,
> > |               bc->cfg.loopback ? ",loopback" : "");
> > 
> > Note that this data is copied out to userspace with:
> > |       if (copy_to_user(data, &hi, sizeof(hi)))
> > ... however, the data was also copied FROM the user here:
> > |       if (copy_from_user(&hi, data, sizeof(hi)))
> 
> Thanks Justin,
> 
> I see that too.
> 
> Perhaps I am off the mark here, and perhaps it's out of scope for this
> patch, but I do think it would be nicer if the kernel only sent
> intended data to user-space, even if any unintended payload came
> from user-space.
> 

It's kind of normal to pass user space data back to itself.  We
generally only worry about info leaks.

regards,
dan carpenter

