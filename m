Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9767A5DAD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjISJWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjISJWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:22:39 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C867F2;
        Tue, 19 Sep 2023 02:22:33 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-5733aa10291so3510201eaf.3;
        Tue, 19 Sep 2023 02:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695115352; x=1695720152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7cl88MG2Y1v5NFU8r78g+h9zXI7wnsANxaBl2bLSTs=;
        b=jlw7oTsZ6qBDh4lEUeYrARy8ODBYLi1nFAAqfDAVHkBTeOMV8+g4cYJU5AXIsiEBx2
         Zlhk7leVulBydC21U39MXfWhaWIzOk1FZx8vxPAWMWqpQJzlKj7hnfwY7cG2Xo4t0+qd
         aJv9nFED/dPoSbrtMyMzlTSRKFzy62UjrzQVANeXIpJhS1/QskwjHWdCAqaKAnK0IyYI
         c4d/yOlA9BTZunZxQBe0lsSrcZHiJzgS+YUl8XhSDC9Tw68D5/qk48L74ohB9wfUWGBi
         dHEKJN162sMot2jZzKOiSeNoFWJr6dt8uAFWNW+QEhOU0yizpO1V0/pbw9AquuYjMwHR
         hDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695115352; x=1695720152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K7cl88MG2Y1v5NFU8r78g+h9zXI7wnsANxaBl2bLSTs=;
        b=CSt1x/losjBrrJKZaO5K/ygTcJWKuDmKe/ZDoaXGhUzFJpqygGr2oi4AL7Ztbssnzd
         5Q3gDEtiUpnxzhjezHJZ5AknID0/vUFpMjGBpOEuwzd937nojBOB8CrkgRKyV0oItKae
         MKgE/du3IR+yezyUUaoduhRNMqCyfYPhcYTYm+bPkqEckUMqGP4mMJQKk805CBKFSX91
         dauZhcty20orooYPq0Vxoxy9IEob4OA6EA+d8NGS6kvCIGLb4QUOFUGYCyTazKxxSq8W
         uZJHLGEw6OIyR+EOGNuR2E4LtX4F8MIPTbYuwEFXcMoimpYRvlCIq/tzbCoIxe4ESgOb
         R72A==
X-Gm-Message-State: AOJu0Yyyli7ZR6GY1Guv/IGMUhP0fUbUZOxHoU0JIzY51eHYc3ciTx3z
        7UtJcsc7ODz7BbRYIAGM5WQ=
X-Google-Smtp-Source: AGHT+IFWUBZvig2UdoO1fZW/LtSJGwCN7ZDrclibi3mQki3DRLhLXKovo7OY99nt2G7Bbuq/ce46vw==
X-Received: by 2002:a05:6358:2806:b0:13a:c28f:3cd7 with SMTP id k6-20020a056358280600b0013ac28f3cd7mr13733452rwb.14.1695115352210;
        Tue, 19 Sep 2023 02:22:32 -0700 (PDT)
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
        by smtp.gmail.com with ESMTPSA id q12-20020a638c4c000000b005637030d00csm7829270pgn.30.2023.09.19.02.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 02:22:31 -0700 (PDT)
From:   Edward AD <twuufnxlz@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     eadavis@sina.com, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        syzbot+b5d1f455d385b2c7da3c@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, twuufnxlz@gmail.com
Subject: Re: [PATCH] tty: fix memory leak in gsm_activate_mux
Date:   Tue, 19 Sep 2023 17:22:26 +0800
Message-ID: <20230919092225.3732786-2-twuufnxlz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023091922-unplug-flask-f2e5@gregkh>
References: <2023091922-unplug-flask-f2e5@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2023 10:29:08 +0200 Greg KH wrote:
> > When the call to gsm_register_devices() fails, we need to reclaim the memory
> > requested in gsm_dlci_alloc().
> >
> > Fixes: 01aecd917114 ("tty: n_gsm: fix tty registration before control channel open")
> > Reported-and-tested-by: syzbot+b5d1f455d385b2c7da3c@syzkaller.appspotmail.com
> > Signed-off-by: Edward AD <twuufnxlz@gmail.com>
> 
> Please use your company name/email address, and then just set a manual
> "From:" line as the first line in the changelog as the documentation
> asks.  That's how developers work around their broken corporate email
> systems (but really, you should go and poke your IT group to fix it.)
This repair was completed in my personal time. Additionally, there may be a 
possibility of the company's email being thrown away by 'lore.kernel.org'. 
If you are not very strict with this, I will continue to use my private email.

I will only keep one line starting with 'From:' in the patch.

Thanks,
edward
