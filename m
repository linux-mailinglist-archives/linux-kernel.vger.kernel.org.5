Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908328115ED
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442451AbjLMPQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442261AbjLMPQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:16:05 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7A9EA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:16:10 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7b7684f0fe4so21835039f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1702480570; x=1703085370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uewgFUrXAkDfEjDIhgFTikSg31fgOKfkxWQH0ytJjl4=;
        b=LMfx12+blqVRXs1RTPceZjYGi0Y12pCJsyzNFZ8NbZZZJWx1dTMucYFpF0MXtlGeoX
         akiU7e6KtOhSDiJqHCnK0WZ5WrQK1UF95SbP2Njdoppn/2e9rf6I+7fp81znvDM/ttiY
         7GXxscAumf0ZsN8+8yOoHCA9nYSstxGeNR3h8FVZCVyJ5E8i9Kmb1thEt8HJWWZUqECD
         C+FKTTuS7+HzZrqg/pBjT5dH/npWaLT86zcS+E9cbzDHrNtHnH0+v0y6rEfOtakp5vH+
         SxlEYWT9bQ9Vql9uCFnH6oOa6a5NB1pCJV1/awZGxwpDzoACwvqhBqPMOaxWl1vFccGn
         Q4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702480570; x=1703085370;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uewgFUrXAkDfEjDIhgFTikSg31fgOKfkxWQH0ytJjl4=;
        b=lxnvQQVuO7b7YFm8L4kojtvRN4ls+lxQ2nbWXziuOTgITU5bT9JzpzWp5rzQGjVYug
         K1aFyo7hrSCwNGOLZeywgtqjYt/rPoeXuBW80PkROY1o2ofhpXBi7brYqCwVx2EiouB/
         OtyGIc6tEPV3ri/GKzHQeeCEafSSFyUTS3u+lUwjo58opWdAGtxoYFzYqBsCOlwdpLlO
         2Ql+Cj9FZwkt/v/AjHnehbQCSU9rLW8jAjWS4SUhNQRCQihMWX5x6IumtbzNWrzGedpl
         YL2FJ1bRoBYAvvsywlaSi9gZXszHt3HaccGb3B28t+J+Hsug0cgA7s7xHWQPWiY1uqZL
         cWkQ==
X-Gm-Message-State: AOJu0YwejweVB2M8/E3mjyA6SGLCGhZayodAW6LkfsW3tX0xRaFyCPnb
        iV+8dmMEMBMDVSgo3d8Ocmf56g==
X-Google-Smtp-Source: AGHT+IH/shbRPqxSdrHsCi3YSVAXuMFbwsH0rjMNL+wzVgnAcEDJUAeKpM9jP/po3XTdRFYcCQYGNg==
X-Received: by 2002:a6b:a0d:0:b0:7b6:f0b4:92aa with SMTP id z13-20020a6b0a0d000000b007b6f0b492aamr14346479ioi.0.1702480570069;
        Wed, 13 Dec 2023 07:16:10 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id d7-20020a028587000000b00469297cbf72sm2990832jai.153.2023.12.13.07.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 07:16:09 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Kees Cook <keescook@chromium.org>
Cc:     kernel test robot <lkp@intel.com>,
        Jack Wang <jinpu.wang@ionos.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20231212214738.work.169-kees@kernel.org>
References: <20231212214738.work.169-kees@kernel.org>
Subject: Re: [PATCH] block/rnbd-srv: Check for unlikely string overflow
Message-Id: <170248056905.41187.18405305753131685807.b4-ty@kernel.dk>
Date:   Wed, 13 Dec 2023 08:16:09 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-7edf1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 12 Dec 2023 13:47:42 -0800, Kees Cook wrote:
> Since "dev_search_path" can technically be as large as PATH_MAX,
> there was a risk of truncation when copying it and a second string
> into "full_path" since it was also PATH_MAX sized. The W=1 builds were
> reporting this warning:
> 
> drivers/block/rnbd/rnbd-srv.c: In function 'process_msg_open.isra':
> drivers/block/rnbd/rnbd-srv.c:616:51: warning: '%s' directive output may be truncated writing up to 254 bytes into a region of size between 0 and 4095 [-Wformat-truncation=]
>   616 |                 snprintf(full_path, PATH_MAX, "%s/%s",
>       |                                                   ^~
> In function 'rnbd_srv_get_full_path',
>     inlined from 'process_msg_open.isra' at drivers/block/rnbd/rnbd-srv.c:721:14: drivers/block/rnbd/rnbd-srv.c:616:17: note: 'snprintf' output between 2 and 4351 bytes into a destination of size 4096
>   616 |                 snprintf(full_path, PATH_MAX, "%s/%s",
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   617 |                          dev_search_path, dev_name);
>       |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied, thanks!

[1/1] block/rnbd-srv: Check for unlikely string overflow
      commit: 9e4bf6a08d1e127bcc4bd72557f2dfafc6bc7f41

Best regards,
-- 
Jens Axboe



