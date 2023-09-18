Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250FD7A4A16
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241471AbjIRMt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241989AbjIRMty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:49:54 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B8D10CF;
        Mon, 18 Sep 2023 05:48:49 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68cc1b70e05so1130246b3a.1;
        Mon, 18 Sep 2023 05:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695041329; x=1695646129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2XuLP7J6klW1W8khpX6M/kOt4MCq1SwjY4i5neGyMk=;
        b=kIurHka7DbXlojwl6n5qEGeGMrqkT8GrZzB8eyYnNtmFl3xLWfnTb3xjsqh2zO6Kuu
         s8ZsWqTycKKW9hTXfjOrLAVOYy7BhoFDvy56ljA4uU/pfF91heTq3qXnNagAu+YmwubM
         xbuOPWfHQ98fF2qw9ONbUHofURCVsTNULspIOFhxJBHtLylgWQYV7ool7fRd2yGAuJ31
         irXAqpDKO2Qf2PDlXexL067GOCEPnXB4AwBSE88yL+zVbVqFJUEgHR8mPibrUzByKarL
         eb+MM5vclQvzozreB2t58kx1SNA1i1anEGM/Ft2YscSd/VOLFTbf7PhYO+fIOp3uzeZv
         5LJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695041329; x=1695646129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2XuLP7J6klW1W8khpX6M/kOt4MCq1SwjY4i5neGyMk=;
        b=sx2LR/wJwwjxoPWwf+SNXQneWTgpI/nxXOWd5XiOXgsfAcjJMPrCtOhmJyjcfiGFd+
         yQXsCHpjxMuUSmKqfIt7zGNNHspt0XUDXNlZTENqkGJsqsnBGkrvWOK+Hgf0c8AtYXzR
         DaybFqc6f1+VRadAcYzu1nfdGTTSFTsDyY0pA9KqqOB82La2anQVD6sa1fG8OU3OMWjo
         ocpxXpalLL269xzjz1TJuS06eQqLIcRg4plCzz66a7godhbtZm8Xkeu972miNeMg7yz7
         MTJo8kjMQ2dWXC1uw0WdTaooqUD7SjaS4EDlw/z1tDzuP/731lOdoRPZq4mDow35xkCe
         G7Vg==
X-Gm-Message-State: AOJu0YxIzwsi0RKHsLXL40sK/DA2uCKmIu14U+rUOGevQwzhrCgsLGbw
        tIEHXaCw8e9uHFhXbJjGtVea6on+BhgbiQ8rD576s2a9yqk=
X-Google-Smtp-Source: AGHT+IHhNMUSnn5Vl1VkICrbAlUnuV+twFFLy2/WROqopztdUi+zPIKvW00uPJjwgg35wUFitcKqIRE07dn41gGms9w=
X-Received: by 2002:a05:6a20:8f11:b0:133:6e3d:68cd with SMTP id
 b17-20020a056a208f1100b001336e3d68cdmr10720405pzk.3.1695041328774; Mon, 18
 Sep 2023 05:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230917164037.29284-1-stefanmoring@gmail.com> <20230917184720.wzigwjk4v5wakmz6@mercury.elektranox.org>
In-Reply-To: <20230917184720.wzigwjk4v5wakmz6@mercury.elektranox.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 18 Sep 2023 09:48:36 -0300
Message-ID: <CAOMZO5CFEZ1BCccQfCtA+j0x_u+95NH66ZmpaerOUNgkh2knpA@mail.gmail.com>
Subject: Re: [PATCH 1/1] spi: imx: take in account bits per word instead of
 assuming 8-bits
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Stefan Moring <stefanmoring@gmail.com>, broonie@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronxi.de, linux-imx@nxmp.com,
        linux-psi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

There is a typo in the spi mailing list. It should be linux-spi@vger.kernel=
.org.

On Sun, Sep 17, 2023 at 3:47=E2=80=AFPM Sebastian Reichel <sre@kernel.org> =
wrote:
>
> Hi,
>
> On Sun, Sep 17, 2023 at 06:40:37PM +0200, Stefan Moring wrote:
> > The IMX spi driver has a hardcoded 8, breaking the driver for word
> > lengths other than 8.
> >
> > Signed-off-by: Stefan Moring <stefanmoring@gmail.com>
> > ---
>
> patch subject is missing the 'spi: imx:' prefix. Otherwise:
>
> Reported-by: Sebastian Reichel <sre@kernel.org>
> Fixes: 15a6af94a277 ("spi: Increase imx51 ecspi burst length based on tra=
nsfer length")
> Tested-by: Sebastian Reichel <sre@kernel.org>

With the above tags added and the Subject line fixed:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
