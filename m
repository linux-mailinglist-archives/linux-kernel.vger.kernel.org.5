Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE83C7849AF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 20:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjHVSwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 14:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjHVSwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 14:52:34 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EE3CEC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 11:52:28 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bcb0b973a5so48346141fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 11:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692730347; x=1693335147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3H+P0Mkvd2fTOTo1RM7CVZo6bQhumZ9OmpPaESrgAE=;
        b=H89t4bGhD8ftFlsa+OkGDai4Er8k2zs6QNqS7MwZcIwsvmH+Ul6ncwTDjudcYBJMtz
         okwC0D0kfU5m8s2BdkX0pnfD9BeNmfBTKikrBi21WY1hiv+tndxlVjJz10eqDbtk80Sf
         F9ER0Ew5MK1gGqvx8l3jgBHlRcVGGriXaSa2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692730347; x=1693335147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l3H+P0Mkvd2fTOTo1RM7CVZo6bQhumZ9OmpPaESrgAE=;
        b=GNQvHEK6Ukzp0JHnlIR2svDQRUyiltCePL5L6eGY/pEkRGyV8uzwT1ORIIiuiRsvRU
         Nfbcqd5WmsmmOOq5Tz9uyp4lLuRVe4qoIEHOQtJ29fKzdLq5FOFLIG29Eq50Zk6IfMX9
         Zl5frIlFKeW54WagRuvyErDwYNG+7grMHi3TlQzf2aVxYsf9u7Qguew7WnDIlijna2in
         OaQtWfm3tKod13FBOI/eEsU24RDUCSTyjmdX5FcPquOjGajGiKuL1pISW3AbcW6j18x8
         /naOMCjHZvFp0Kozv+nljGinfpvkm5dZPsl6J5VBq/ORIp+/UNNLlP9Xema6tmwsjoF5
         4jiQ==
X-Gm-Message-State: AOJu0YwBeQjod9NH7CAc4n7XlWONRovR2F7Z27Man/jqBpplWC15AzM2
        dQI42aZtfOZy5QfSyJ7zS683oTETp9NSqGezkwsiWMjawP5lLNpY
X-Google-Smtp-Source: AGHT+IGgrHfnrPEab3Tspw1BQqp7ADVMIrnihXg8lqOSKNBt0xFlzKVsydwRl7SZU3r+p15hjPuUemmwWwQ0o0Q0YTg=
X-Received: by 2002:a2e:8210:0:b0:2bc:c21d:311f with SMTP id
 w16-20020a2e8210000000b002bcc21d311fmr4509194ljg.52.1692730347021; Tue, 22
 Aug 2023 11:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <1393d18f-4928-45da-b504-7e5b6a681e51@paulmck-laptop>
 <20230822161850.GB74437@google.com> <df999cba-a090-4461-8db6-7ddd788ddf85@paulmck-laptop>
In-Reply-To: <df999cba-a090-4461-8db6-7ddd788ddf85@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 22 Aug 2023 14:52:15 -0400
Message-ID: <CAEXW_YS1F7-+0aVsEpqN=v54s1K+UjwtZG5Te1byfDeno=vL6g@mail.gmail.com>
Subject: Re: Question on __torture_rt_boost() else clause
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 1:46=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
[..]
> > > I am putting my best guess in the patch, and am including you on CC.
> >
> > Ok, thanks,
>
> On the other hand, it looks like I can now reproduce a qspinlock hang
> that happens maybe five to ten times a week across the entire fleet
> in a few tens of minutes.  On my laptop.  ;-)
>
> Now to start adding debug.  Which will affect the reproduction times,
> but life is like that sometimes...

I would be happy to review any locktorture changes that come out from
your qspinlock debug effort.

Thanks,

 - Joel
