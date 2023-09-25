Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9420D7ADAF7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjIYPIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbjIYPH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:07:57 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2B1120
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:07:50 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99c93638322so1513033266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695654469; x=1696259269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEZ5TYqKj7Xpyqh7LsqYS+cjUynAUZpYFGDV9Q2kYbI=;
        b=B6TL+lhWqinETXItX4Ekol+r6/1S5l4o9ko60wHi48LRTUuAE7vA7z9vQmGsPV01AD
         rDSZJ9hCw80d8D54zHPQTDlxdrzk0ZKtQSDIBEJYn7mRYMcUqkkMkr2BN5c0PyYgHnuT
         KOEPc3gwRI69RTQpZCpWBIev7q3epAcu5bywrOWyH7jm9M3cGDJrz7VZIxzTaPQwgvX/
         i1a3j4lXKr8cnI4SOUek/FJ82au/hM/pZYRuIrgAAvj2Zplke97id3RGZE+Rdhxhhaqh
         ti+XT7qsGgJ2M73vR66y6DzS+ke0je6i5bQbHs785iEJKWrLbXdb8ojgDPCpPi92WVgT
         zm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695654469; x=1696259269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tEZ5TYqKj7Xpyqh7LsqYS+cjUynAUZpYFGDV9Q2kYbI=;
        b=dMnh1pCOfC6xzJ0dcDwNa86WA4slq688OzaWJO4DfdZmwr+nKCcgtAcLlmFKpWvZ+X
         DsIECVuCWF48xJzppAJkpU0Pgj4v0GYWeLW0+D5HPMMSs2YUO+o1lhgcY09FoG9sJ4i3
         LaoflNCRjZOHMYscfhbHxiBlRQ8WBxB1H9+bI7G53/XMDRFoAgwWWEdlMX0sHm6di65C
         Wm5+sgm8icbDNcZ06t+XJs1FBCd+XL44FzHTNR+18kXXF/4y2KTB8BS2vG5dw4zZsYk5
         hoGDxT3inKQzMhRiGabmDMa0J5Dh+7lM00+F0JZ5SMgRZgZ0LECQYyooTJe+5UuedOYt
         2ikQ==
X-Gm-Message-State: AOJu0YxnMKMUaNyLkdHgFNYlK3fH6g75PSOXkC7A5s7UpihPgqzT4XAL
        qHYu/2Okz0Y6ushgwvUc4iM=
X-Google-Smtp-Source: AGHT+IHuvDsUyVa2O8phaopW7XqF8puZjg9QRjHcigLXniRoG9KatTQvuRnfy0vTM9Vw7eaMxEcKbQ==
X-Received: by 2002:a17:907:7288:b0:9ae:50ec:bd81 with SMTP id dt8-20020a170907728800b009ae50ecbd81mr15679987ejc.21.1695654468639;
        Mon, 25 Sep 2023 08:07:48 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id s4-20020a170906168400b009ad829ed144sm6409010ejd.130.2023.09.25.08.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 08:07:48 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     wens@csie.org, airlied@gmail.com, daniel@ffwll.ch,
        samuel@sholland.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] drm/sun4i: dw-hdmi: Split driver registration
Date:   Mon, 25 Sep 2023 17:07:45 +0200
Message-ID: <3441738.QJadu78ljV@jernej-laptop>
In-Reply-To: <rvqcfohw4i4y7amod3a5e4u4tkorqmaekvikyqg3fibvy53dsd@be4lk4ae35hq>
References: <20230924192604.3262187-1-jernej.skrabec@gmail.com>
 <20230924192604.3262187-6-jernej.skrabec@gmail.com>
 <rvqcfohw4i4y7amod3a5e4u4tkorqmaekvikyqg3fibvy53dsd@be4lk4ae35hq>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 25. september 2023 ob 09:47:15 CEST je Maxime Ripard napisal(a):
> On Sun, Sep 24, 2023 at 09:26:02PM +0200, Jernej Skrabec wrote:
> > There is no reason to register two drivers in same place. Using macro
> > lowers amount of boilerplate code.
> 
> There's one actually: you can't have several module_init functions in
> the some module, and both files are compiled into the same module.

Yeah, I figured as much. However, I think code clean up is good enough reason
to add hidden option in Kconfig and extra entry in Makefile (in v2).

Do you agree?

Best regards,
Jernej 




