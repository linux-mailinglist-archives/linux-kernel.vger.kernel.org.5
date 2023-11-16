Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C8F7EDD12
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 09:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344971AbjKPIo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 03:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjKPIoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 03:44:22 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B9D1A1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 00:44:19 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54366bb1c02so5411a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 00:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700124257; x=1700729057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15Ckw1RtaRbBRvnRVWh1ML35SM8E8zgJILg29jp+Kk8=;
        b=Ba1PJ5xST+5KadfEw0wJqatM9FQU51DTPhKxQiGpsd+JUsP3bAAkvIykt51SrqpHgw
         mLyMv+vBW6hiFlhmXZUOuv10NPzKiz2OrTWdYHvlNOlrOB9pfxrfU//i0ysbxPLClaNy
         8m8aVTK3SFXA/coHCmXKYpk0GVD1z5RrkeqspUjYDxyTl6TCjfmjuB0qRug22b90luVm
         q2Hp6rDBPmUpUYUCEDBKR7XcrWWwYPoTqWWrfTe0BLl64RteN0VqDm4RoZ+toC7DeTYA
         BPUf0wxU0U2EwAQXCulAnpXmpm3kjarTXPTkz/tAynHRbaZ6L/hUcFNZLo57PH0dhiFr
         Qr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700124257; x=1700729057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15Ckw1RtaRbBRvnRVWh1ML35SM8E8zgJILg29jp+Kk8=;
        b=ZQfBCqfnXpDCka60Ci4WOYY+fNF65HeMYYXh3AijoBy6qWtrXiUAZlI/y/IahrvOO2
         WeAeF3EFy88AJdtL7sx1OTPqaHPj9dANSBhvunAlgwp1MySwRf3zvfwn8B6wzVU3PARL
         9Eor6uLghm93IF8R8IsCM+cC+D/hxobRYbvMnNbaZiJ3fr0gdC/iZF3IO0iNpvgMvEYZ
         i01b/mdVFz0Ew/2R0x7ERdkCXOdGSUhtfuH+y6wiU4oM7npHrEzqjhx0Mxr8a8VnUAoD
         fgLz7uYuMFvboQ4OunM5Xrrdf/FtsDe8iReNm6dPYWxfQTWs19OvhXVRT5rTpYNVO7PR
         NXLw==
X-Gm-Message-State: AOJu0Yw3M7m7mD2b8ehKOXfyKp8Rbs5DFMRBMJO6MV3b8oY6QRoAlSEY
        XVA939BJr5gBsImg6OptDWynqPvkpsaNU1Y+Wuu+RA==
X-Google-Smtp-Source: AGHT+IGVPb2NZqiKSwpNNjNi9eEikFGWD/JhfnBt7Ryi+ZjxJ3E2ljCxv4wI4vNKiW8ZBbdf1eIjFLQm7FM8SiR1Xc0=
X-Received: by 2002:aa7:c592:0:b0:545:2921:d217 with SMTP id
 g18-20020aa7c592000000b005452921d217mr81119edq.6.1700124257443; Thu, 16 Nov
 2023 00:44:17 -0800 (PST)
MIME-Version: 1.0
References: <20231116022213.28795-1-duminjie@vivo.com>
In-Reply-To: <20231116022213.28795-1-duminjie@vivo.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 16 Nov 2023 09:44:03 +0100
Message-ID: <CANn89i+B2gNO7-Mnai59Tpn44tomfLN1m9NnSEMq-qkt7AyyRw@mail.gmail.com>
Subject: Re: [PATCH v2] net/tcp: use kfree_sensitive() instend of kfree() in
 two functions
To:     Minjie Du <duminjie@vivo.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "open list:NETWORKING [TCP]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 3:22=E2=80=AFAM Minjie Du <duminjie@vivo.com> wrote=
:
>
> key might contain private information, so use kfree_sensitive to free it.
> In tcp_time_wait_init() and tcp_md5_twsk_free_rcu() use kfree_sensitive()=
.
>
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
>

You have not addressed my prior feedback.

3) You forgot tcp_time_wait_init(), tcp_md5_do_del(), tcp_md5_key_copy(),
    tcp_md5_do_add(), tcp_clear_md5_list().
