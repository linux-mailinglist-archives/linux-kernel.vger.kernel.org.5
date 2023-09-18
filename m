Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE8D7A509A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjIRRJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjIRRJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:09:39 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE90A9C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 10:09:32 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68fbd31d9ddso3646542b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 10:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jade-fyi.20230601.gappssmtp.com; s=20230601; t=1695056972; x=1695661772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYQSn+OIzp01ryaAaejSH+/Rdtrl+ucwSOYu4Xut+PI=;
        b=X8YWCr0Ar0M1UQ5IUxcRBTS/fDaYLt8TsxUTJMRMpvqZiWlgAganoFHBs9khj1ZK80
         zIXGzByKPMK44TGLaROEwf0oY8XUqjzKIU+rOxUb58M725WPaaII839uYkGJsLosrsgF
         MC2i8W1rEGyOyU6NfeVAbhSg7QsVCxfkAhJXeUKn85/ZO54A+PjSrAVsaZZCDZthVidh
         TxluZV0tUnsraf/JG1Dmxi6kuM+xU4dg0jcRA+lCbPQ18j3CWuj7XvgE4ruAASuHeiGY
         HK/jjXavA6OL0erb3ziOWBE/Qr3UOA+KC8k+4l6Q97u4P9UGWG90gyIoBvP1nHSdxDZQ
         JkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695056972; x=1695661772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AYQSn+OIzp01ryaAaejSH+/Rdtrl+ucwSOYu4Xut+PI=;
        b=J5/ETfZG7uH2ChMo4WGnLJ7J1CVxcaiDzvRuaIWVHYznY3W2sEezioaGwLeQbp0lxk
         uhloKEkRKXgo+qc4j35OLSe+OBNn8WP/J4d2kVKrQQoDeCVzL3d91ZX6s2Vyxxa5xX3L
         NUb9zQ/y+juC8EgeLQDcDizm9N6tr1Pr/4bgVoBE2O+t9NRMAdZk2iWbUeKCLxGvKWuU
         HyeBXRqDXTFHZNhiNHk1V7QQhSRAViQOii8aWJxgmzrowy//uGPxh/pyJs+udB3HMeVx
         NqCmScgZ4vUb1tj8HV+k3CYHL6hsHgQ3RclrtWOW6wA9qcakgb4ji7VqQqFVNKq3iFgP
         MlCg==
X-Gm-Message-State: AOJu0YzGlwSHkhKrnZ5MPXY1ryayiIAhmaCRrCI1wFoNmYrsRQWG+iiQ
        VHReJR3W8qBHsg2UfrR49oCYSw==
X-Google-Smtp-Source: AGHT+IGtUIR1rYu6U73lUGcuPGDdUrU80/1dpmLzoWH5zRK9YDq6P1xbXkYrEtqDzirwAafIJfYUyg==
X-Received: by 2002:a05:6a20:7288:b0:157:e4c6:766a with SMTP id o8-20020a056a20728800b00157e4c6766amr9410730pzk.41.1695056972113;
        Mon, 18 Sep 2023 10:09:32 -0700 (PDT)
Received: from localhost ([172.103.222.8])
        by smtp.gmail.com with ESMTPSA id x14-20020a056a00270e00b0068fe7c4148fsm7330361pfv.57.2023.09.18.10.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 10:09:31 -0700 (PDT)
From:   Jade Lovelace <lists@jade.fyi>
To:     Gene <lists@sapience.com>, Ricky WU <ricky_wu@realtek.com>,
        Keith Busch <kbusch@kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-kernel@vger.kernel.org
Cc:     regressions@lists.linux.dev, Alyssa Ross <hi@alyssa.is>,
        Michal Suchanek <msuchanek@suse.de>,
        "axboe @ kernel . dk " <axboe@kernel.dk>,
        "sagi @ grimberg . me " <sagi@grimberg.me>,
        "linux-nvme @ lists . infradead . org " 
        <linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: [Revert] Re: Possible nvme regression in 6.4.11
Date:   Mon, 18 Sep 2023 10:07:38 -0700
Message-ID: <20230918170831.1677690-2-lists@jade.fyi>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <66bc5229-8131-4111-96fe-bd5ee90314b0@leemhuis.info>
References: <66bc5229-8131-4111-96fe-bd5ee90314b0@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This regression affects all copies of the Dell XPS 15 9560 and Dell Precision
5520 with any SSD including aftermarket ones.

Per the bugzilla discussion here:
https://bugzilla.kernel.org/show_bug.cgi?id=217802 this regression has
been confirmed to also affect 6.5.2 and 6.6-rc1, and affects several
distros.

Known affected branches: 6.1, 6.4, 6.5, 6.6.

It has already been reverted by OpenSUSE and is soon to be reverted in
NixOS. A patch follows, hopefully with the right metadata tags.

I have compiled a kernel 6.1 with the revert and confirmed it now boots
again.

p.s. this is my first time pointing git-send-email at this particular
list, so I'm sorry if I got anything wrong.

Jade


