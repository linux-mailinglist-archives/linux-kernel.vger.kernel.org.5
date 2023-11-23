Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7007F5BD9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbjKWKEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKWKEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:04:06 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBC4D49
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:04:12 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32dff08bbdbso436733f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20230601.gappssmtp.com; s=20230601; t=1700733850; x=1701338650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sDwbgRNkEYSmD6Wb4d6mptBb2LGUPc4R10tj3j0aj2w=;
        b=Ay1zud/mxqAlsiDzSTKbpTVbQf312nEinJbdA7nvRcfl355/ga+VoLHQcwFGgMEtor
         xp6pWH5beSKSElfqjuW/ml9vzSkCKu54x4vp0h3bLmTS6xo+rhA1jJo2NYUzrlOoxrG3
         WcR5BGtvtrVXbfLSiEIi9deM0HJi53/E4gngbC5fRC+rsVEcGG7XI1USy9fmAxIJ0yyz
         Y7/rvyY6ffCZHQmcPcLN0Bj0gg62Ij/G/1cjYByi65l8Y6v+WuiI+eosShhm674gtEFE
         UjRKoK4IQxw3ziDd2QOLQiW7OlK6f1hgxOfz5G7hS4UcWouEE/wzKA8hWHOYS8MMvLpj
         fb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700733850; x=1701338650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDwbgRNkEYSmD6Wb4d6mptBb2LGUPc4R10tj3j0aj2w=;
        b=ArWHvWbsvxKbLRcccM3mn2J7dMInsvNYVhjdpPbNjNQ19+irLX+LQ+ILAERPs0F4gE
         wGr10RztmlBaQ1psLscNTfUTnjnppuuWubBLPDWrmYy0df2rv2LW+aPpx7F7WlUafx/I
         TMh21HI5opXV68vWB8/xsNcfOYYwQAoXv7XNqk2hFYrHsZf70Vu65R3PyKofa0oNL3Mu
         /1lkB81/LPILjhYFJhiLl9Q05zKMQmpfCa3Ey12QcFMevCVjlDL8Eik2fKEC8qxCXgbT
         yHFZ0Ll6zoPRnncxTEAstzInvALg/JZmQrfQS2I3oYbW4EFPzHGLSwu5i/1mtLbIy2Z4
         BC0w==
X-Gm-Message-State: AOJu0Yx33EJlJMmeEhnoDTM953KWnU90zQwP2Md4JB2zqmHpgYdAJkp/
        UcuTWoxCDtEIp6kdozt8gmDEum7xrpfHcxNLLcpZPA==
X-Google-Smtp-Source: AGHT+IEOStGU3DCTitrbY93zDwxWnMbTwYh1PUQpbV3CK/kgOFNS1jMxCJsW3PDcV9wJu8C71iIYtA==
X-Received: by 2002:a5d:6d8b:0:b0:332:c5c5:7847 with SMTP id l11-20020a5d6d8b000000b00332c5c57847mr3680872wrs.5.1700733850534;
        Thu, 23 Nov 2023 02:04:10 -0800 (PST)
Received: from ntb.petris.klfree.czf ([193.86.118.65])
        by smtp.gmail.com with ESMTPSA id f9-20020a0560001b0900b0032196c508e3sm1225906wrz.53.2023.11.23.02.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 02:04:10 -0800 (PST)
Date:   Thu, 23 Nov 2023 11:04:00 +0100
From:   Petr Malat <oss@malat.biz>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     paulmck@kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH 2/2] bootconfig: Apply early options from embedded config
Message-ID: <ZV8jkGVup4KvKiYb@ntb.petris.klfree.czf>
References: <20231121231342.193646-1-oss@malat.biz>
 <20231121231342.193646-3-oss@malat.biz>
 <4a67b4bb-d211-4726-8f43-d3f159127dd9@infradead.org>
 <325042d6-ddd0-4278-a082-9587af77cabe@paulmck-laptop>
 <20231123112207.417b502144a01fc94ad6f87d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123112207.417b502144a01fc94ad6f87d@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Thu, Nov 23, 2023 at 11:22:07AM +0900, Masami Hiramatsu wrote:
> BTW, we also need to make a block-list for some early params. some of those
> MUST be passed from the bootloader. E.g. initrd address and size will be
> passed from the bootloader via commandline. Thus such params in the embedded
> bootconfig should be filtered at the build time.

It's ok to configure these in the embedded bootconfig - in a case they are
provided by the bootloader, the bootconfig value is overridden, if not, the
value from bootconfig is used, so it works as expected.
  Petr
