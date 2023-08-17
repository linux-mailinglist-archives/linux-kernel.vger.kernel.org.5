Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185FC77FE00
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354522AbjHQSjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354593AbjHQSjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:39:08 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9B8358D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:38:56 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68890d565b5so86408b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1692297536; x=1692902336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKBNIrhPJusfox196yHA3tt3Jgp9Oqcl0jFfRV4J/uQ=;
        b=Rj7mq8TZv2h67st6Cu7VIoQ6RdGMFJylINg5RyQO/xG+/YsPjAfj0uj7QytGjo/y4M
         u214G1mVyNHRAXYOhmAUhlBEG9v897a5HnepliCQBm3FVc6L6eDOxOzRaa/ATEPYMpGL
         jHg+mUr6YyjxhuGL8r9OZfBagIUOGRlkoHa8NfSdkXAF87/jDq4uMEDOfqnfXxlEyXaa
         rhUaDFqFyOobhTrxcl4KIO5cfr2y/ovLhER+aD9bA42TVG5na6qzUYGlEuFaRvXqnNF2
         0TXyQRh0HCu/Wnm+Vtao875gCpEfzVNZ8Ll/Ly1Iy4rKrl6vbT86pQQOpJVM0CNmEsej
         Zh2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692297536; x=1692902336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKBNIrhPJusfox196yHA3tt3Jgp9Oqcl0jFfRV4J/uQ=;
        b=GGbON7COwkxjzI9LDMLXkJT/fs+Jlcd0XZcAJRbyYEk6xO/L2NRzmTpS3xrRmJhicM
         N15eo+pIikCrnqoQopzG2DFAb+6JVBoII4x5SH9KI0fBAv9VimesyBbF4+Ra0lRpW/Lk
         nPGig69XqxAYSCXdFEwasOhyMqbbCleZdDAkbw64dbCjmCjRVx5be2gewCYZ1n8ip4lQ
         IOxLHu1K6AWT0T+hinaHqslB2tvTpRjshpvDIYDtLaWsfSkdP7i3VwSxYBuEVYwDTNt7
         D9Xp18Ecf7athGkWCYlk0n/vx/+YHDsl9KPKId5ePv6XKxLs4qYTJjSayKjToiI6WX3c
         N9cw==
X-Gm-Message-State: AOJu0Yzn0/4RZicmeSgVx5K4dRrcEHlKixYrIm6MPkVzcTf0iGG5FwrZ
        JoqC3Sxzo5xdO4/K7CuN5lOKxQ==
X-Google-Smtp-Source: AGHT+IEvdsEFH6mfdFz8hBtil/8NYdv9myTD5T2MmHUNkvV72yKD4GeyR6JMJ9Ze93wK+LfrMCA75g==
X-Received: by 2002:a05:6a20:3d87:b0:13d:8876:4c97 with SMTP id s7-20020a056a203d8700b0013d88764c97mr667494pzi.16.1692297535845;
        Thu, 17 Aug 2023 11:38:55 -0700 (PDT)
Received: from hermes.local (204-195-127-207.wavecable.com. [204.195.127.207])
        by smtp.gmail.com with ESMTPSA id l12-20020a62be0c000000b0068782960099sm87119pff.22.2023.08.17.11.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 11:38:55 -0700 (PDT)
Date:   Thu, 17 Aug 2023 11:38:53 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Michele Dalle Rive <dallerivemichele@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Greg KH <gregkh@linuxfoundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Davide Rovelli <davide.rovelli@usi.ch>,
        rust-for-linux@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [RFC PATCH 0/7] Rust Socket abstractions
Message-ID: <20230817113853.4b47e636@hermes.local>
In-Reply-To: <CANiq72=3z+FcyYGV0upsezGAkh2J4EmzbJ=5s374gf=10AYnUQ@mail.gmail.com>
References: <20230814092302.1903203-1-dallerivemichele@gmail.com>
        <2023081411-apache-tubeless-7bb3@gregkh>
        <0e91e3be-abbb-4bf7-be05-ba75c7522736@lunn.ch>
        <CACETy0=V9B8UOCi+BKfyrX06ca=WvC0Gvo_ouR=DjX=_-jhAwg@mail.gmail.com>
        <e3b4164a-5392-4209-99e5-560bf96df1df@lunn.ch>
        <CACETy0n0217=JOnHUWvxM_npDrdg4U=nzGYKqYbGFsvspjP6gg@mail.gmail.com>
        <CANiq72=3z+FcyYGV0upsezGAkh2J4EmzbJ=5s374gf=10AYnUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 19:14:19 +0200
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> If I understood correctly from Zulip, you cannot (right now) show your
> use case because it is confidential and therefore you cannot upstream
> it, so we will need another user (and, of course, that is a necessary
> but not sufficient condition for the code to be accepted).

I thought Rust symbols were all export symbol GPL.
And therefore any Rust module using these must also be GPL.
