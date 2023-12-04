Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27998802F24
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjLDJrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjLDJrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:47:24 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB0CFD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 01:47:30 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-db544987c79so2612851276.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 01:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701683249; x=1702288049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/Va0kOOCQXMJr2TQKWKwJ9zWUP7bBtr/H8JK5walkU=;
        b=zkuwnamvBvJpJncHSIT7eWV87jlt1VfEXLXEGuAo8/GRKGsPcChVxAZ9UgKvNgmUes
         R4PO8bnoJRTwVtlqrxJKZwN20ij9jSgCBDDsdbXvWCHUp9XX86+tTFCWQogUfBwWF/Fc
         Gttd3+ITjvX3AqIv4b+St4K4sW84a3RmYjZbJr4CENY7G/m8HwC8zOz/vQ8r+QoXfLbn
         XAo9KXv0g/xexyBdWH4As88DtS1XqC00XbkC4hUf05HyBOxuOCLIqo4yrRf4kNI1mXtg
         Ob4pEnp2AF09w3jRDjC0LfSqKvLcMGLBDbVdthYlDHEZ0p173x9hEueXaa4ino2RWPR5
         LMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701683249; x=1702288049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/Va0kOOCQXMJr2TQKWKwJ9zWUP7bBtr/H8JK5walkU=;
        b=H5f0VxHF2UGXj31vvPbJMy2pAwKEbt0O8It1/XAocFZTBbhXusoL8vIu97Rr+n7kCW
         RZP+5Y6H8norVRt0NnBoFG4eDouehCqk2I7+EtFcpqyzR90ozjIHpdsL4OqyvA9jxDq9
         iROKB3k9RKyUTtu3QG7NjaKxTmYLFyB4EIHwvf+z8SgcLj4Ak1AuOv0UZ0r7nvnrXTV7
         QmiO0s5DZCk0tquS6sNyeUxu7LETCggsPWfAMPyLRxk9YRxhDlfVmvOFdYp4J2mThfHP
         qeluRV0TXSKGcgJfjs1yc/hvCMQdW2crToMZh0NpLhv/i3RxHrk9wW+t/38UAn51WwSr
         HfJg==
X-Gm-Message-State: AOJu0Yw7Gec5WZV/xi2GdRqBxtJtX9yFgEnl+VuH+V5bWyb2fgiNaM/g
        dzt67J702hmXhQISkA0OFP5ju96jsi+P6o95cBjHRA==
X-Google-Smtp-Source: AGHT+IHzmn4R3eDwNqxLIvsLdnuOrMgDl1kyI5pUXW4FtxkQmVJw7pplvdOzdsQmeJxtozIgo/BWo3hmtyPbnRvdWuw=
X-Received: by 2002:a25:824b:0:b0:db7:dacf:6fe4 with SMTP id
 d11-20020a25824b000000b00db7dacf6fe4mr2504494ybn.108.1701683249364; Mon, 04
 Dec 2023 01:47:29 -0800 (PST)
MIME-Version: 1.0
References: <20231122144744.2222207-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231122144744.2222207-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Dec 2023 10:47:17 +0100
Message-ID: <CACRpkdZtCOwmVa7_vyCfs5i3GVdvopNAGA3rPyij0EeLr8e4MA@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] pinctrl: mediatek: Switch to use no-IRQ PM helpers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 3:49=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Since pm.h provides a helper for system no-IRQ PM callbacks,
> switch the driver to use it instead of open coded variant.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch applied!

Yours,
Linus Walleij
