Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4817A1932
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbjIOIwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbjIOIwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:52:20 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E6AE7F
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 01:52:15 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d818d4230f6so1661230276.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 01:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694767935; x=1695372735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQEA2FIOx2kKdYQhqTeGKcS5B9p1K7dbq3FSAP3UBRc=;
        b=YSf0EaQAwBVhJ5wCemEofRT6vFIRuzTBW63Gcmqe3yiE2n0Nm3x5seKVpchsL0QshX
         cp1A4jEKTwYX9wpRgn8z0yfMYdSt9J1YoVwNpGNltDW8PUaTnNf5v5Yor40XZhUHPnD9
         sCgnOZwdKQJvl/KXCyDrTd2R8v0a4GY1izrg2tSiu9dnUfvhgtk+dN62BV5h4OO/wtUW
         WBuIagiSwtDgNtoSXGeqrEnt6BNplU9KKibNomoLfZxHxZvkVje0knC0+m+wLFTeqcMh
         VivUGXWWMYp0JhkP7kqKIRYt6w/9QIY8hIn0yWLETzPBmxIh/vqqXSZyKmABNpxBE6UI
         ZV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694767935; x=1695372735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQEA2FIOx2kKdYQhqTeGKcS5B9p1K7dbq3FSAP3UBRc=;
        b=Xs/ifUpekMZ1ZvGpm3aabeAfRNQDtdgAVsOgSb0jItJw3DbEEkm1Q8r4L9IwUhxhdL
         3mIkE1qEy/OqNUY6r7OyIMnTwCWlfM/QYzQr+Iynq+GMwtLhvIH1oCF3+k15NB8arsp7
         nz6ZUTbmaI1mXl385eK5SHQXQLPsRPGPJRvrttUxbjqBxjeVELTXcl0smGQwQgpvzjVw
         C+W7xAKXikOlFAPkkQ9dcPSsBiczX9+dJATxeeQkY5KFMup0Dd/nkCtunBol0xDceRGt
         1mnX4ST4KpVzqPW/6wU8pkqLKQXs6CMlpHF0uCQzCmgzwXgh7SLmpYqt094TxWnyT/LP
         H8qA==
X-Gm-Message-State: AOJu0YwhtA8HRuUEY5/rnpyhCHZI+6f1VTrrc5nBkaapA+4PKeO0hOQc
        5mT/pLP7+Ck3RHDfMLSJS4XXRdusWjrHwLLBeI+Tkw==
X-Google-Smtp-Source: AGHT+IF03Cm5Va9hUiFUq1vEzW6LcyQAcPPtXI3kkxlLHejHACO76N1blpi+PQJOeYgaIv7Amr4/YkwX0A4xUwTw4/k=
X-Received: by 2002:a25:3496:0:b0:d80:b87:3299 with SMTP id
 b144-20020a253496000000b00d800b873299mr602004yba.49.1694767934897; Fri, 15
 Sep 2023 01:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230914150904.155630-1-yann.gautier@foss.st.com>
In-Reply-To: <20230914150904.155630-1-yann.gautier@foss.st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 15 Sep 2023 10:52:04 +0200
Message-ID: <CACRpkdasQqbSGhrd7+0M7t5ATsj7krpvmCGZ9uPsYHcu5K87kw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mmci: stm32: add SDIO in-band interrupt mode
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Rob Herring <robh@kernel.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 5:09=E2=80=AFPM Yann Gautier <yann.gautier@foss.st.=
com> wrote:

> From: Christophe Kerello <christophe.kerello@foss.st.com>
>
> Add the support of SDIO in-band interrupt mode for STM32 and Ux500
> variants.
> It allows the SD I/O card to interrupt the host on SDMMC_D1 data line.
> It is not enabled by default on Ux500 variant as this is unstable and
> Ux500 users should use out-of-band IRQs.
>
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>

v2 looks good to me,
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
