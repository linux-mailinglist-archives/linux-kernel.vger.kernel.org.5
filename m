Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DE27A72E7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbjITGif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbjITGic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:38:32 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7AEF1;
        Tue, 19 Sep 2023 23:38:21 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c44a25bd0bso4047155ad.0;
        Tue, 19 Sep 2023 23:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695191901; x=1695796701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJ58+idyugsX9uMTOlAMwq7qziULzVNhZk7UwhCb5C0=;
        b=EsJsP/tLvyd/50JJiK0StGvHHqFEhIfiolXZGYCvd8TGc2jDIFve9+XUbOYn8SB9ok
         aFsU7H8kqnzJLxCnjvns5/m3VmeVTrplYyzNugz3vOZg8Y8nXPv/rogE0Rg6pU5m2qmt
         G79dfs/6dfY35tcbTaTW5GP8HMZMeClW4sBTOcY66tD3b8HzIKPxs6nihryiJq7Kqmz9
         8ls31pt94p21CvdkAa0mBW/gEJ2e3nq+JiJRUrGuZm2SUuH5pnGCM0rAdZrE9tkIRO3Y
         ph3NSQK+uNrOnb0ymnXkN2Qq9WIIXuVExohE4qm9fgxg3/4ADY/dSjOl9AFBPY6uhCYs
         zk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695191901; x=1695796701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJ58+idyugsX9uMTOlAMwq7qziULzVNhZk7UwhCb5C0=;
        b=cepsFRD7m3pm3qZgGqleS+9ji4I7xZOsJCKhnxEj9ESMgct8VYh8C8TkSyJpV7EFAH
         IfITdqO4lIRzOvHIOQPz9ix2hl4N3gy89g9ZEVKXKKaueAQo1LI7i+c0X9YKdH33tAiV
         r3Xf0brtOHhuoPOjoIiiiAIEiqPf0kJUX3fM5nut2pgdEieXZ+PrWT8uIwpHDyikUEVG
         qPE1cjg8NBsmoJWV4gk27srI1vz2nxHreDqaRq9DwC18QMxC9c0khTzlziWq+WVcUVNY
         YR7nyx7SXFGGga1DIDCn3g6umbbddMgGJB5m5AM9kejPLE9tP13hPtFfHL0YjVdqHMQG
         dneA==
X-Gm-Message-State: AOJu0Ywp00cXTJtrp4aFkX2DlPQXcfO0KQVwHzAjYn7koZMxiBlV2QwM
        RKU+sXamTp3RLJsz1GCIJ7E=
X-Google-Smtp-Source: AGHT+IG6gy9m1cKXvKlZF82i9zbmIvvbKo3CfvV1KJgXkk+Ud/7hM166Wq8fhqhG26/3OTvF73AWVQ==
X-Received: by 2002:a17:902:da88:b0:1c4:1195:6de4 with SMTP id j8-20020a170902da8800b001c411956de4mr6347009plx.9.1695191900820;
        Tue, 19 Sep 2023 23:38:20 -0700 (PDT)
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
        by smtp.gmail.com with ESMTPSA id l3-20020a170903244300b001b80d399730sm6843689pls.242.2023.09.19.23.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 23:38:20 -0700 (PDT)
From:   Edward AD <twuufnxlz@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     eadavis@sina.com, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        syzbot+b5d1f455d385b2c7da3c@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, twuufnxlz@gmail.com
Subject: Re: [PATCH] tty: fix memory leak in gsm_activate_mux
Date:   Wed, 20 Sep 2023 14:38:13 +0800
Message-ID: <20230920063812.577917-2-twuufnxlz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023091921-duke-gory-866e@gregkh>
References: <2023091921-duke-gory-866e@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_FILL_THIS_FORM_SHORT autolearn=no autolearn_force=no
        version=3.4.6
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
Before sending this email, according to your reply, I sent a new patch via email eadavis@sina.com.
But we can't see that email in lore.kernel.org
> 
> > I will only keep one line starting with 'From:' in the patch.
> 
> I don't understand what you mean by this.
Just set a manual "From:" line as the first line in the changelog as the 
documentation asks.

Thanks,
edward
