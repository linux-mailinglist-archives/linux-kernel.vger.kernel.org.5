Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA997A5EEA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjISJ5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjISJ5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:57:25 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86601AC;
        Tue, 19 Sep 2023 02:56:00 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c59c40b840so4643305ad.3;
        Tue, 19 Sep 2023 02:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695117360; x=1695722160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypIZfd7vxnYRjRxyZcN55Sr1pe+QcTMQMhjwJoWQL0g=;
        b=bJ7bShgiFQf/+tk1gGyLZ24v6wjaZzsCqT444EC9SENby+GLtjaZ+QcAxqM35KhRy4
         Rwf8402/1fEuVd17mDId7Vlv13KrXpz6sXFwOtf70wd8F5Ej4Imwjz6mfYxqfLgVWR7v
         z0g0D8g7LvRi3zFYayHtjeVabByyYy1bLzvGWFEmHrDRpAzt/CKFgqeSobCwn+33LBVC
         7ZllfwiDNnhEfe6ikznlrctlsHs03yAq5CbjKPqfVomfC/9Rfp8TMwXbat5Ua0biX2OI
         tox6HokB3P/R+PNzhxPYjfxZHbGcdaCj6X6JyTYt0H1O3skgB6KQmBm8CWzqmvY35P8Y
         vpgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695117360; x=1695722160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ypIZfd7vxnYRjRxyZcN55Sr1pe+QcTMQMhjwJoWQL0g=;
        b=O/PtnZEf8wGhxMwrPO5MDEswaXG0u4Z0JVm0H57Uh+MJb0OfsfYhJCXhTmGQIW6HXn
         k8MYHZQxAgmUdEo+KxQd5meUvPUYRP1v8Tbx4OrZ8NrgL8QefQ1p81qFNYACY0sSYi5x
         D/Qi9hIV3bJcGlPt5lDuM94WFbosGW2jlLz6j4Jms6W4glvvOHFZn1Ol4eW7RougK6rL
         YW2iWB63qYWGTqSeWO2UCLVZh2+CJLKFKWGhmJOLlgv7gwJ4l9i87Ug23IT7aEOVdeaR
         7c9CgavilIZylmnr3wU7q731+Iz+JDumhXTy5U9ypI5311k73qUM2S/RhEfrdIsqiglo
         eJ4A==
X-Gm-Message-State: AOJu0YyZJZqEyp75r/TaseQGzAucFnfG//Xtx/6woMEqBSt8jtgvWW9n
        dAZcT6lvUUlwSn/+cz3unUY=
X-Google-Smtp-Source: AGHT+IHtGxgvyuVZfPp27mXYAOqk9SfkFvkfN4+KmTHmuIqpZ6yBLK+zMBBbUZpRvezSIh/KNtzUsQ==
X-Received: by 2002:a17:903:278d:b0:1c5:7aac:6e5d with SMTP id jw13-20020a170903278d00b001c57aac6e5dmr3751484plb.66.1695117360058;
        Tue, 19 Sep 2023 02:56:00 -0700 (PDT)
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
        by smtp.gmail.com with ESMTPSA id 2-20020a170902c14200b001b672af624esm4097077plj.164.2023.09.19.02.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 02:55:59 -0700 (PDT)
From:   Edward AD <twuufnxlz@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     eadavis@sina.com, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        syzbot+b5d1f455d385b2c7da3c@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, twuufnxlz@gmail.com
Subject: Re: [PATCH] tty: fix memory leak in gsm_activate_mux
Date:   Tue, 19 Sep 2023 17:55:55 +0800
Message-ID: <20230919095554.3764551-2-twuufnxlz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023091921-duke-gory-866e@gregkh>
References: <2023091921-duke-gory-866e@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2023 11:31:57 +0200 Greg KH wrote:
> > On Tue, 19 Sep 2023 10:29:08 +0200 Greg KH wrote:
> > > > When the call to gsm_register_devices() fails, we need to reclaim the memory
> > > > requested in gsm_dlci_alloc().
> > > >
> > > > Fixes: 01aecd917114 ("tty: n_gsm: fix tty registration before control channel open")
> > > > Reported-and-tested-by: syzbot+b5d1f455d385b2c7da3c@syzkaller.appspotmail.com
> > > > Signed-off-by: Edward AD <twuufnxlz@gmail.com>
> > >
> > > Please use your company name/email address, and then just set a manual
> > > "From:" line as the first line in the changelog as the documentation
> > > asks.  That's how developers work around their broken corporate email
> > > systems (but really, you should go and poke your IT group to fix it.)
> > This repair was completed in my personal time. Additionally, there may be a
> > possibility of the company's email being thrown away by 'lore.kernel.org'.
> > If you are not very strict with this, I will continue to use my private email.
> 
> As you previously submitted this under your company name/address, we
> have to be strict for obvious reasons, sorry.
The two email addresses I used before these are all my personal emails.
> 
> > I will only keep one line starting with 'From:' in the patch.
> 
> I don't understand what you mean by this.
Just set a manual "From:" line as the first line in the changelog as the 
documentation asks.

Thanks,
edward
