Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D767B421B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 18:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbjI3QXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 12:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjI3QXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 12:23:38 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CD5D3;
        Sat, 30 Sep 2023 09:23:35 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-405417465aaso144296555e9.1;
        Sat, 30 Sep 2023 09:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696091014; x=1696695814; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xp4w/jRk0j30kIVSxaj/yp9HIujxwao61ALVGlcGV7U=;
        b=G6YuluCqVBg2JtAS3fQS8TFBU8vYq6BGFkFq74KTHrGZs1+Vh4MAtXPdzGF/PEbqvB
         TYgNBtQogm5oqmZWzOw29SkTm6DlrqyHt34KUGG6hS6YC7JtG23FbM57exFw7xYbSaIu
         muDsBTqNBLm+IYDCT1OHxSx8K77yDHYIDKu4zAZnBvGhmNJH1GSUeZLxXogZJy2OAXxu
         +WqWx9Nu8M9mIJ5Rk8qyBqYvrg9DFpyTQFGa4xTPihJZK4d8UbSOjy1tP4HZcubD0jRm
         9u7xtt9Pu5r5DTUxrZ+g54P+XT/z+19O5Hnh4tKGZnXixzM90RL2/y/G50+qCp9zV0m1
         w6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696091014; x=1696695814;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xp4w/jRk0j30kIVSxaj/yp9HIujxwao61ALVGlcGV7U=;
        b=D/Ivx8XIgFbk4+gpYXEFSmxsBO64p+1DqnaIgXo91oLyEMHyDWrl4tljkd/Quu8sqF
         ZFa2AUzdt3PjY7luBFrDR8N0x6x9YbmPRLMdzu5KXv91YftpbyvSThHRsQo1Kcis8V6G
         fLY2hBlaey2cdm6+S6ysvVyyKcMnSjptjPswUlBFK1wBlMj7P02GTdi6PTv2bM9Hww3F
         vgWqkB6zzh48gxFsXMoBxVted2DBktLsOAJ3sniq2iPixpVb9M7IH8qGC0Ex94SyO5wo
         zEq2D3007SWHz1HDPQhtghxea2hlRw8JJ43aob6uJ7XU9aVeISBmJGBTQHpSP1qZTq3A
         3KLw==
X-Gm-Message-State: AOJu0YwavMLCTVxfjnlQ/BHVJJL+g7clJiD2G6yA+epsVl2QjyCW9M2A
        hDJ2l9URUJmM/KZg7f1428FxKfctdUFzEH/jyW0=
X-Google-Smtp-Source: AGHT+IFeJb8SEqWexBKYW2cp2WCNXB2f+EuicmyMkGxZV3riHu5oUmCIfRJlKfyciNHh+oNpbKGgp3pnvS7jY0u36gY=
X-Received: by 2002:a5d:67c4:0:b0:31f:b364:a6ba with SMTP id
 n4-20020a5d67c4000000b0031fb364a6bamr6475834wrw.52.1696091013827; Sat, 30 Sep
 2023 09:23:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230926104442.8684-1-dg573847474@gmail.com> <20230930160428.GB92317@kernel.org>
In-Reply-To: <20230930160428.GB92317@kernel.org>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Sun, 1 Oct 2023 00:23:22 +0800
Message-ID: <CAAo+4rUpC0NOyPWt4xDFWmEnHCGEBf-wbFBDn18TVsLabdocTg@mail.gmail.com>
Subject: Re: [PATCH] atm: solos-pci: Fix potential deadlock on &cli_queue_lock
 and &tx_queue_lock
To:     Simon Horman <horms@kernel.org>
Cc:     3chas3@gmail.com, davem@davemloft.net,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

Thanks much for your review on this patch and another patch
that you just commented on.

I will fix the problem mentioned, separate this patch into two
patches and send them as v2 version.

Thanks,
Chengfeng
