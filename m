Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F497AF780
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 02:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbjI0AmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 20:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbjI0AkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 20:40:06 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3139EF1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 14:27:59 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d857847be8cso10631441276.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 14:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1695763678; x=1696368478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwboT3wS2a1yBHjDCQ06HZTwGyv2f0/zi3F8PPJditg=;
        b=Wdre1CXgUDxix66xbAJwHumLtH5lJzKK2jXd5RbWQ675ewAWebuohkoN7zjPXM33Ml
         Ulfn4SUZcBrr0pbjeCbMKYuEED/316rqwSUW/ETFPlntJf6xixDanBNV6LR8xKdVgMps
         T5E/HU1vcD0m4o70Lk/EvISFAaPuQT3W7h1zosuJBspdjIdWWbfeoKqgPXgFcud+aKSr
         DVuVZsDDvF18D/roYVkg04TxNpqc7XnDl/8WbLQhpUYnonMWXZmNJDmB20QASw//coY4
         WCtE6+K/TCotAAgsF585JnF1hXv9TXantyFcuusBd9D7nzvCxNhe9xfD0DzPLIYlYU10
         Iztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695763678; x=1696368478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwboT3wS2a1yBHjDCQ06HZTwGyv2f0/zi3F8PPJditg=;
        b=IgoTWDmaCWNwcMHGpPQPAC0/4edTfinqYmRM2KKD8GepKORoka/zMgxYcZK97KQ/ZQ
         LmPvbTdwnu7biCmcQpwoILtkH6Fh0BqMODZlP64xFbovhQxPhlcdf5KrgEz+qqoGyxvM
         Ce/4dAa5deXQ0ZYamlDlPo5JyoipSl+wa60D56jMddZWD7B2IDP0hxEdK+ahpl64ssVk
         1Fdoavo55uwzJt58RVLvqH83bCYKH1lQR0yZf9CW5Za0UbL0BVbVV7bbRFPwS3IrI9pv
         X/XaeHA+DkkX3vuFQd+JsqOXRwrmOaWVTxRdhbGDD03A5jBdIDvqWT1jgV2KXaZyOW9d
         q+VA==
X-Gm-Message-State: AOJu0Ywez0UadnOZGuPZIbanaGY0/K7NUApUx4VMtRk9WpYfvgK6gOJ9
        ae4cKNG+cylQj6OmWTjCsvhC1wfEDKhQuRf+kUHx
X-Google-Smtp-Source: AGHT+IGEOPatV9DMHgk6ahe+ZNCEftvet7jzAHqC188+LRWLJCUQ62hLSOHIPtTbwO1LBBLGz1+WP4Ij6RfoH/mqsaw=
X-Received: by 2002:a25:7611:0:b0:d81:7f38:6d64 with SMTP id
 r17-20020a257611000000b00d817f386d64mr133266ybc.4.1695763678663; Tue, 26 Sep
 2023 14:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230922152749.244197-1-chris.riches@nutanix.com>
In-Reply-To: <20230922152749.244197-1-chris.riches@nutanix.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 26 Sep 2023 17:27:47 -0400
Message-ID: <CAHC9VhQYFjRnmC3LTKkhXuKhvjGQG+dTXqL6ExXbNC9M2DZ3ZQ@mail.gmail.com>
Subject: Re: [RFC PATCH] audit: Send netlink ACK before setting connection in auditd_set
To:     Chris Riches <chris.riches@nutanix.com>
Cc:     audit@vger.kernel.org, Eric Paris <eparis@redhat.com>,
        jonathan.davies@nutanix.com, linux-kernel@vger.kernel.org
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

On Fri, Sep 22, 2023 at 11:28=E2=80=AFAM Chris Riches <chris.riches@nutanix=
.com> wrote:
>
> When auditd_set sets the auditd_conn pointer, audit messages can
> immediately be put on the socket by other kernel threads. If the backlog
> is large or the rate is high, this can immediately fill the socket
> buffer. If the audit daemon requested an ACK for this operation, a full
> socket buffer causes the ACK to get dropped, also setting ENOBUFS on the
> socket.
>
> To avoid this race and ensure ACKs get through, fast-track the ACK in
> this specific case to ensure it is sent before auditd_conn is set.
>
> Signed-off-by: Chris Riches <chris.riches@nutanix.com>
>
> ---
>
> This mail is more of an RFC than a patch, though the included patch is a
> useful illustation and might even be suitable for inclusion ...

Hi Chris,

Thanks for the patch and the background information, that's always
helpful.  Unfortunately I have limited network access at the moment,
but I'll put this on my list to look at next week.

--=20
paul-moore.com
