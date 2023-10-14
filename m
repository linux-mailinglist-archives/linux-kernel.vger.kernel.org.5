Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89DD7C9256
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 04:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbjJNCnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 22:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNCnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 22:43:32 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896EFA9;
        Fri, 13 Oct 2023 19:43:30 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ca052ec63bso9580235ad.1;
        Fri, 13 Oct 2023 19:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697251410; x=1697856210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTITjb+//k4DyyD3GweboqFVPC/ATyRtYY/wTSNvCM4=;
        b=cmHqSYBvcsZgIAwxhCaaujB13IaNCplRmerI9luJ8GQ7jlUoxJ1yy6o0N2rDRreKUi
         hm4wRERJHYjE86cO8WFaoNmasFsEZspnjhBMOduno0ZfdVbgGASmxdpzfCZLoNDvKTWe
         69HeXWBEYwghHww9A8ErfCl07khAWxaJ/eYIGyNRk7wHhGz1E3FXJy0faUTRtf2RfQyL
         hZZnM7UQBUvqNiIn25cORFmMrwBTsb734xwOTXOS/IhNWAyJz6cCIcdyce5q9JOQdOhO
         F4C+t+4DSnB+EnHNEX1bjo2A7wXYfHSjIJmJY2PTiKRVvgsw1wLN/OyWWnCwlylf/3eL
         Wbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697251410; x=1697856210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jTITjb+//k4DyyD3GweboqFVPC/ATyRtYY/wTSNvCM4=;
        b=YRwwcZ3vDClUT5eARegF48CQvHo5ctI/sNjmLaQoZvgxvMiThCqvTROOvKl5bQNCZU
         NFMsIvpzv5lX3Rz7Co00AvSIIby8jbN5D3eq5jXjUu0sTi/+8g0jfhkRdIzPaF3K5Mc/
         IHsZ3o/NM32q8bMupA9S0J2zIOyfjZGklKjsoadaj+WKdF4YKDZeafsFCpv0GTv00lHc
         4wAAlkBfaD73ZI2orD2tgpuvouTildumT3s3JXVOxN6oKbfm8TRrq/8RRsQX+1kwlK9V
         BC1QPEjivZY/UQAWFPQdM1nAfddz+LCBpcFXjwzLon3PF3l0IYXJbWCku4OKgA9GTtez
         YWrA==
X-Gm-Message-State: AOJu0Yze4awPKw4+H7joHnlBm9tM8h/C6d9dDr+0gyxn+sdblw8xOkYQ
        WghJctTKZDFQxs9zvo1ngUI=
X-Google-Smtp-Source: AGHT+IEqg4czoCTQgV5nzmU+1DggLn8urc5zF5zeamlQc9J5Vg1C0OuNeAgCLyJ44mKzrTZyXZf7GQ==
X-Received: by 2002:a05:6a21:62a:b0:170:3e5b:bccd with SMTP id ll42-20020a056a21062a00b001703e5bbccdmr14673239pzb.30.1697251409932;
        Fri, 13 Oct 2023 19:43:29 -0700 (PDT)
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
        by smtp.gmail.com with ESMTPSA id d13-20020a17090b004d00b00273744e6eccsm771880pjt.12.2023.10.13.19.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 19:43:29 -0700 (PDT)
From:   Edward AD <twuufnxlz@gmail.com>
To:     horms@kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, johannes.berg@intel.com,
        johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzbot+509238e523e032442b80@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, twuufnxlz@gmail.com
Subject: Re: [PATCH] rfkill: fix deadlock in rfkill_send_events
Date:   Sat, 14 Oct 2023 10:43:22 +0800
Message-ID: <20231014024321.1002066-2-twuufnxlz@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231013110638.GD29570@kernel.org>
References: <20231013110638.GD29570@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon Horman,
On Fri, 13 Oct 2023 13:06:38 +0200, Simon Horman wrote:
> I am wondering if you considered moving the rfkill_sync() calls
> to before &data->mtx is taken, to avoid the need to drop and
> retake it?
If you move rfkill_sync() before calling &data->mtx, more code will be added 
because rfkill_sync() is in the loop body.
> 
> Perhaps it doesn't work for some reason (compile tested only!).
> But this does seem somehow cleaner for me.
BR,
edward
