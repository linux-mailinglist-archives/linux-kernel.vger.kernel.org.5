Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC99D7E924B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 20:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjKLTmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 14:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjKLTmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 14:42:16 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8DA1BFF
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 11:42:12 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-507975d34e8so5363941e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 11:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1699818131; x=1700422931; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ImXR9MiE3qi0DsdC8oVklUneX4f/mvjRK2z3vXRpxy0=;
        b=gBPCvI5flUQMZY+jMnkbpP7H40hLJCBsrGN0OiBueUf3QAUsSnrHvprORwVWC1ax0A
         8Omfm6zOrKXD0ZhmR1gwFCW6ySPeFXxf2zhm+AzSHeAmx+ane66/flWr92P6LC5rdUSc
         iA0qD3cw/AxEgDrgx13OvsEE50b6R+6MsS/yQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699818131; x=1700422931;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ImXR9MiE3qi0DsdC8oVklUneX4f/mvjRK2z3vXRpxy0=;
        b=rFf5071GtPlW4bkijn6Xl/j7VgC3yIGA5zX6oN9+f8yXK2/4Z1p8+cr2cJwlxusdix
         icIAcBZ3jQl2Ivg9UbtTKgrStQJVGKCbKXOeFrsUBtUBomN11z/nbs2Pc137rHCSO7w9
         PR/poAQ4IpbyyNUzwYFhvfFs1cte5QLLooO69vC1rO++ELxoHHo7LsRJogh+qpqt9jzr
         49sw0lFhlxy6TpkofYsVncONlNKf7xd2rFdDwF3rsgNnX5hnlbZd2y3Bv6+XKCTo0Vzw
         uAVgownlc4v37zZhXjF+4nUIfU7xJd/uZYELpmA+FKFG4bzYsDt/sNGeBtWgjgERoXVw
         CM9Q==
X-Gm-Message-State: AOJu0YxKWbLFuRoKc9rf3PGUgoa8MLiITGif9whXnUGy+LwFHXUlQwv2
        0OpS93n/sB5PiK5LBSWjHk9eeo1atOzoCkgWjMW4Bl7+
X-Google-Smtp-Source: AGHT+IE8dhIBbFVNIbjGImBa6I3++1vNroUg2ssr+FbLZU3yuS8eqzjAPHvmXfBiDTzmy1ux9lnUFg==
X-Received: by 2002:a19:6509:0:b0:507:b099:749d with SMTP id z9-20020a196509000000b00507b099749dmr3099206lfb.15.1699818130608;
        Sun, 12 Nov 2023 11:42:10 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id p12-20020ac246cc000000b0050481c400e9sm715291lfo.287.2023.11.12.11.42.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 11:42:10 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50943ccbbaeso5358589e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 11:42:10 -0800 (PST)
X-Received: by 2002:a19:9116:0:b0:500:b553:c09e with SMTP id
 t22-20020a199116000000b00500b553c09emr2970053lfd.32.1699818129698; Sun, 12
 Nov 2023 11:42:09 -0800 (PST)
MIME-Version: 1.0
References: <20231103110600.GAZUTUGFjhoLm1KZzE@fat_crate.local>
 <CAHk-=wg=+8rceshMkB4VnKxmRccVLtBLPBawnewZuuqyx5U=3A@mail.gmail.com>
 <20231111223549.GBZVABxWKgkuGNhEqe@fat_crate.local> <20231112122309.GAZVDDrYRiH4RuVbRV@fat_crate.local>
In-Reply-To: <20231112122309.GAZVDDrYRiH4RuVbRV@fat_crate.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 12 Nov 2023 11:41:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi_ko54kPH3Jc_eEXHrxjJOQ_TDkeo1cjU1pdeC+kzATg@mail.gmail.com>
Message-ID: <CAHk-=wi_ko54kPH3Jc_eEXHrxjJOQ_TDkeo1cjU1pdeC+kzATg@mail.gmail.com>
Subject: Re: [GIT PULL] x86/microcode for 6.7
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Nov 2023 at 04:23, Borislav Petkov <bp@alien8.de> wrote:
>
> Yeah, so I think something along the lines of the below.

I can verify that this makes my boot logs look sane again.

I'm not applying this directly, and will let you do the final version
in the tip tree (split into two?), but thought I'd at least ack that
it works for me.

                 Linus
