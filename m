Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0D57F18B1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 17:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjKTQfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 11:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjKTQfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 11:35:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975DCC5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 08:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700498101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RZvczFxIKyKy6D2excjoW9QSNl/x+SIklQ2YwnPNLtE=;
        b=Gp6hnjM0nN5WIinUdZ4cQMP6wxHtovXz9KVCpDQaJCS2IpCJX+puH/uQKYWv682IAJ7CzP
        ou+BB5AafrrquIRtDCu6pHRlSf59K6OP3hQjEcZlHYFhpq6tiPsQo50vQzBt+6C7xIeoae
        TuRQFlOoCu/YXbiD4yiWzZUT3HBzUVY=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-a3NuuBPnN3Wfx6Zp3V8zug-1; Mon, 20 Nov 2023 11:35:00 -0500
X-MC-Unique: a3NuuBPnN3Wfx6Zp3V8zug-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-58a23b6c2d3so4357051eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 08:35:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700498099; x=1701102899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZvczFxIKyKy6D2excjoW9QSNl/x+SIklQ2YwnPNLtE=;
        b=hdAwut1kiy7qh2o//h3SQYKYNlJb3R4yLqylVn+HoElHulz0n8ZKAdY8J0J9TYLK1V
         TXjO28JGlYBN5zoZP+2O/E7BG60689g8MmzQrC58RBdh04GEyw95KgxZf20irLmsLRYA
         B7BrEkIiG0K7EVyKiJQ+Uq459fA2aPgcCF9/m/u/WCRncpp58nR+0EOYykFgVvFa0okw
         tGndwctpJFyCIQnhquDXBwP/OnQhID8yHMYYU3VduaEoNXSCcr/lv8kCeQLWe6WRQJIk
         xJEi1bHuPd69ify2lTv9ov4nLpFTKiMv0wi//ZIX3/jCetVSh+3/egORfyj4ka7/npnc
         HesQ==
X-Gm-Message-State: AOJu0YzRZ/8TjCgcm/J87mHOQzb1TKAByzyM8z8dO06LL0skYuZBLNt5
        DqMagMa+FIaznJ6eAUUQeozkP7ZqFCno8BCEcHGwjCTNw/fHWlhFQjroaWbHcDfAqHd8UGQlU9e
        UB3t+eIrcsnd5xn3Q9j8d4X2VYtKF/6oEvJmia6/r
X-Received: by 2002:a05:6358:726:b0:16b:4b12:1842 with SMTP id e38-20020a056358072600b0016b4b121842mr8647509rwj.6.1700498099552;
        Mon, 20 Nov 2023 08:34:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFR0FE8SSbDLW3AevgsAwFEu6zOq5yK2N2TwdyzHuvhL6NWib3gECyjA5arteEcU++mTZz2XKREqHBK0HUJhqc=
X-Received: by 2002:a05:6358:726:b0:16b:4b12:1842 with SMTP id
 e38-20020a056358072600b0016b4b121842mr8647488rwj.6.1700498099328; Mon, 20 Nov
 2023 08:34:59 -0800 (PST)
MIME-Version: 1.0
References: <20231120105545.1209530-1-cmirabil@redhat.com> <8818a183-84a3-4460-a8ca-73a366ae6153@kernel.dk>
In-Reply-To: <8818a183-84a3-4460-a8ca-73a366ae6153@kernel.dk>
From:   Charles Mirabile <cmirabil@redhat.com>
Date:   Mon, 20 Nov 2023 11:34:48 -0500
Message-ID: <CABe3_aHtkDm0y2mhKF0BJu5VUcMvzRWSd7sPeyTFCZEFZt05rA@mail.gmail.com>
Subject: Re: [PATCH] io_uring/fs: consider link->flags when getting path for LINKAT
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, asml.silence@gmail.com,
        io-uring@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 10:59=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> On 11/20/23 3:55 AM, Charles Mirabile wrote:
> > In order for `AT_EMPTY_PATH` to work as expected, the fact
> > that the user wants that behavior needs to make it to `getname_flags`
> > or it will return ENOENT.
>
> Looks good - do you have a liburing test case for this too?
Yes, see here https://github.com/axboe/liburing/issues/995 and here
https://github.com/axboe/liburing/pull/996.
>
> --
> Jens Axboe
>
Best - Charlie

