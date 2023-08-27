Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E25578A2BA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 00:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjH0Wci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 18:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjH0WcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 18:32:10 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FE7128
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 15:32:07 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bcb50e194dso39655081fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 15:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693175526; x=1693780326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xG/65WaDY/0ejC6iYQxZu5FGFsb5RPgLQjRdnboGx+8=;
        b=pDJpdZu2j/cEXI8q96VLCQehou6Za8fh3mId760yxzJO2TnQy5gHmHKY41s5tcPqfR
         Qh4u8AN57Gy3uxviVCylc2qNfwx+f/yhFNRh7ejFTlbjcKXhidmqqeiFh4pW4yEK3pZR
         m/XC5VxK84eHhLinGlXYFTi31Gs1ngOI5lDnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693175526; x=1693780326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xG/65WaDY/0ejC6iYQxZu5FGFsb5RPgLQjRdnboGx+8=;
        b=KNAIh+STbuJReSAgdAYIFEKCwcSpSU4xEzYvsuZaYFsL9y39TP6lRd9/eBA9ikYX1F
         wYiG54FHKJ0SwSTeU29R4lUN5zr/DnpJJnJAEcG973cJAuKvvh7GM3jGZ4/7LBjz8IF7
         Jh9t7eqxdH/dS7a5K/Kf422i8hNz0r30DYNxhieuopjDmh8Tfsox4Ze84v87tyobXV4G
         C1g/I4/6dH9Xcn7zybj7ASjImEtB2EXAMqzdsH8CZJppJ8YTS0+m0CYm+BPyb9XvRQ9b
         r0ithyNJNry2uua+KbETlwqKbinc7de4rtCxctZVVsZJbPXh5tG4Z0c/QrD7GEgNbogT
         r63A==
X-Gm-Message-State: AOJu0YxJdHeJTDP7QLIHgXKGY2/bKJl8giqy5KiiCNoVcbMm8y8S9kL+
        WObL5szdGJ4WBoArHJMbKz3LEPiawAj1mtdQUuO8VQ==
X-Google-Smtp-Source: AGHT+IHtdDrMRNrQ66FFvPjFeqlziiP+ZqGr7K+9yBmVWjejtYIy0dZEjeTvNTOwXLa2Qp8rkcr8i5ZyL/UT9eRgCBw=
X-Received: by 2002:a2e:96d7:0:b0:2bc:d09c:853a with SMTP id
 d23-20020a2e96d7000000b002bcd09c853amr12863293ljj.6.1693175525928; Sun, 27
 Aug 2023 15:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230827215741.246948-1-joel@joelfernandes.org> <2023082812-pampers-uptown-69a2@gregkh>
In-Reply-To: <2023082812-pampers-uptown-69a2@gregkh>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 27 Aug 2023 18:31:55 -0400
Message-ID: <CAEXW_YTP9mm2f5YEL=Dbr399KomN6jd8Rwx+N1MXOuefs-vzoA@mail.gmail.com>
Subject: Re: [PATCH 5.15 1/2] torture: Avoid torture-test reboot loops
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2023 at 6:27=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Sun, Aug 27, 2023 at 09:57:39PM +0000, Joel Fernandes (Google) wrote:
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> >
> > [ Upstream commit 10f84c2cfb5045e37d78cb5d4c8e8321e06ae18f ]
>
> I don't see this commit in Linus's tree, am I just missing it somewhere?
>

Ah, this particular patch might not be in Linus's tree yet. It is in
Paul's tree. Feel free to ignore it for now if you want and I'll
resend it later (and likewise for the 5.10 one).

thanks,

 - Joel
