Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D03B781B89
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 02:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjHTAKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 20:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjHTAJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 20:09:58 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD24FF580
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 12:58:30 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-c5f98fc4237so1930538276.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 12:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692475110; x=1693079910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BAkAuNe9NJjwjQqyjAM3yeCNaIWRCI7bzhWC7D4W7Y=;
        b=KNsQVirAS/ePte3cX6FuHEwA19OoxS/BDi5jok/YRIKa7p/aIY3wvlPgB6zeZGvYOb
         bIQER/yL0gP4oH+iRG1cMxpbx0UBi26qXyp6ER8sd82+pohIkLHj7d/gu8FrI3p6RFpR
         jAjZCe+1bkMmrrmvoZOMOc5RHyufL+lmzUyomUxRwu+e+vg4MbSRY+M6dFoj8Cx1eLv1
         i9Q63XayMGk8uvSk2HVyiXnQu4duQpV7vU1q+uagLj8saGjnT9gvpFekXgOGfhOg+JL4
         pqCZQJlxk5VeOkeAMUKBQcs4ZJprx+U+WNGiMDRKcTCg03KvhNtLcHg2Ekam6FKH5cHK
         6Jxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692475110; x=1693079910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6BAkAuNe9NJjwjQqyjAM3yeCNaIWRCI7bzhWC7D4W7Y=;
        b=g28WgmqOl/fpgj02ydcpt2rMHcF0tkxwFthgGEziQCpqv7Pf2hJZq5JN4BEedZsdB5
         LYHjkSZs+AZXzON3v2rR5ZjTkI0RW4F5RgCxt2KufM2rNjf2wVrqgpE5BZenloMiARiR
         ft+EjyrtlkrG8hrOuvKdG60g6Rk9sW8AcGALnCKn+7owvmozCc14JkHzIBVHafbCrqMQ
         rAGpSUWpFtE1WjV7WHu3C3T0eIcHo4vVe4Qybh27yEtuGw2IrJ4YG1Kch/UZePBI3JYg
         XcfA7QU7XlJWAwE8iUsoKOTodQLAjEpoc5mqhny+J805xOJJnOyNYeTnRde4KSrV4G1P
         OHzA==
X-Gm-Message-State: AOJu0YyLx8t4sRgy+ZGrq8hRphG1LSYQ1W+q40ViILNzzr59ut3YvpNn
        vb/1WV4JpgXGdKT53iyt1r1sTsKy5mtDq3PC4k0=
X-Google-Smtp-Source: AGHT+IER9E2BNVurjcsST1ZO5imWBGOX/2qyxdxY9QHsOu4Ie9rhbUPzlb0ZStIKt9ZdkQlGJuAe7RJjlFlMxkcHPRU=
X-Received: by 2002:a25:508:0:b0:d1c:6a5e:463e with SMTP id
 8-20020a250508000000b00d1c6a5e463emr2711391ybf.28.1692475109938; Sat, 19 Aug
 2023 12:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230722180925.1408885-1-hugo@hugovil.com>
In-Reply-To: <20230722180925.1408885-1-hugo@hugovil.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 19 Aug 2023 21:58:19 +0200
Message-ID: <CANiq72=MsytTivumoe-F7sr_00om8tjvV_54mEXQf52YCiM5wQ@mail.gmail.com>
Subject: Re: [PATCH v2] auxdisplay: hd44780: move cursor home after clear
 display command
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 22, 2023 at 8:09=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> =
wrote:
>
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> The DISPLAY_CLEAR command on the NewHaven NHD-0220DZW-AG5 display
> does NOT change the DDRAM address to 00h (home position) like the
> standard Hitachi HD44780 controller. As a consequence, the starting
> position of the initial string LCD_INIT_TEXT is not guaranteed to be
> at 0,0 depending on where the cursor was before the DISPLAY_CLEAR
> command.
>
> Extract of DISPLAY_CLEAR command from datasheets of:
>
>     Hitachi HD44780:
>         ... It then sets DDRAM address 0 into the address counter...
>
>     NewHaven NHD-0220DZW-AG5 datasheet:
>         ... This instruction does not change the DDRAM Address
>
> Move the cursor home after sending DISPLAY_CLEAR command to support
> non-standard LCDs.
>
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Applied to `auxdisplay` -- thanks everyone!

Cheers,
Miguel
