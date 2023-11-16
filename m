Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E137EE9F2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 00:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345561AbjKPXWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 18:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjKPXWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 18:22:36 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1074E196
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 15:22:33 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-4ac10aacd27so522822e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 15:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700176951; x=1700781751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8UFWtxxURRZZcJulFD7F7kd/A/pD6gY59BIEgto5Qg=;
        b=LwQhUlAI8q9ZUSqZAkHLaX+BRcwvVBSc4XFJ34dgDe1Reo5kVi1FU7inNXf0bAZJ3q
         25yqty2py71PXbJQLj/085BqrpWAFFXFjJrWRY35Wh2XCUi+yqT7S2ik3rDcB7Lq8/lz
         kURJSaEQHH9nW8xwqaZXKPwdMxF4vV0TMsop2uwkIcfxjVEC3VbnHHSwFAsTkla87olV
         DwLPvgMKyNhgKeie2M+C9qACV2zWz43WUEQd7arVkbSst8GRCCchPlisx61TTqZpyQ0f
         bNcI3oHpXILN5gHqBsGCQj60GaEPOVMwggFZpdzIGqkg59Dy1JqMeJ66honstdusGvwJ
         degw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700176951; x=1700781751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J8UFWtxxURRZZcJulFD7F7kd/A/pD6gY59BIEgto5Qg=;
        b=jCE1H2N6A+3dfRhL7LKkHTPm9JYW8sWNmucUC51bygUy1iBj9O2UUFBVxZL/YoqG7c
         qBLqVEB0Ug7trgJncsROGMavxwdExv0WEWvOr8o70mtI6IlsimPfjNdy1jic4rD0KN6l
         CF0o78UITYNvKNHGgjkLfsq56AV+GDd9Xtp1WMkbln/ZYxJNfc3eOK8ftAHKpM5UoBFL
         6WaMpiZ/CV+iTyTlDvnfY68+xfjx6Nvn8HzBZoTGx6ruuP46hUXARIs7axdE0TQ/7A/K
         3U8Txp1U1XpZc/yBV0raEHJZBn5QSmxzYk8cn+IqYyGPAy5WlzNauKoyFUgziMzJNkHt
         Oi0w==
X-Gm-Message-State: AOJu0YxN2+uzKv0mZjQjByBQkRYtbkFAGIReOiuNBsTXbKONi6kgp0x/
        HZsv1dU6FBueGX/s5PfcDKoHedGGvId9YAClI0oktXr5gt8=
X-Google-Smtp-Source: AGHT+IG7gPfTshs6d6BT7XToKaW3wQmUA2fOMXjsR9K7W00ZIfpncyDe6f7AtRVhBo8ED6MvD1GZY6SVy1s/fJelYcs=
X-Received: by 2002:a1f:fc8a:0:b0:48d:1b20:268e with SMTP id
 a132-20020a1ffc8a000000b0048d1b20268emr19029647vki.10.1700176951514; Thu, 16
 Nov 2023 15:22:31 -0800 (PST)
MIME-Version: 1.0
References: <20231116224318.124209-1-jim.cromie@gmail.com>
In-Reply-To: <20231116224318.124209-1-jim.cromie@gmail.com>
From:   jim.cromie@gmail.com
Date:   Thu, 16 Nov 2023 16:22:04 -0700
Message-ID: <CAJfuBxyjMgxR3+oAuLUK7nrM36S9MEQ67ppQTM_ibOdS4QNysQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] tweak kmemleak report format
To:     linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 3:43=E2=80=AFPM Jim Cromie <jim.cromie@gmail.com> w=
rote:
>
> These 2 patches make minor changes to the report:
>
> 1st strips "age <increasing>" from output.  This makes the output
> idempotent; unchanging until a new leak is reported.
>
> 2nd adds the backtrace.checksum to the "backtrace:" line.  This lets a
> user see repeats without actually reading the whole backtrace.  So now
> the backtrace line looks like this:
>
>   backtrace (ck 603070071):

meh, in the actual patch, thats

backtrace (crc <%x format>)
