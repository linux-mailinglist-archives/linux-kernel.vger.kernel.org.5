Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381F67DDB80
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 04:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbjKAD0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 23:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbjKAD03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 23:26:29 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64727F4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 20:26:22 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9be02fcf268so930175366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 20:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698809180; x=1699413980; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7Z+lhn55caLP7TtRoVh2z9H+OCXVdsgSBhRJz1eTMhQ=;
        b=L2g/MnFICnrHEfo+Ls266fbO9dQbu+fgsRsgJY8h9LkRFGpv+phKvuUn9n6guzd5YT
         xJFGDRjHV9lTGTfh1A7tqSwbWHOeFzfh6o4PhgJOsyDOAuKmAYPus87b2ufJ0kX+SRsr
         L0fb/hyfg+kvBR6sNmoNCZb5Q4kacm/tyn1T8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698809180; x=1699413980;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Z+lhn55caLP7TtRoVh2z9H+OCXVdsgSBhRJz1eTMhQ=;
        b=CyWis04kDK426GotQhHKGS9SfuBh/pHBcvhenDvbDDlC1zc1FV3VAsob9DxsS32D3N
         U+lQ7JfBunbrKhgvHYqT4U5U1Y+Y/2MbbtbnwpeSVChGAiWMRsex98J0ye4j1tH6fa1v
         CBZ35U9j1J7QaensGIGk+ZUX7KrV6wV8ewnR+MUI0N0ax8tDrnne+bbIJDLrWN9rqPp4
         ssSAdHjr8dv2ZAe34rTABYMslAyz/4qnkp33gjwGcv3r+i7u/segvoWkGcTWlDSh0JFr
         uf9B6kUZJPKOqQsFEjVm6AO7AKIkeI5SIS8vdeOZQzBvTvfCKu5bvhaahTuseefqaPF8
         DNRA==
X-Gm-Message-State: AOJu0YzQX92VCtZgDJtUR6jaJsW2nYhYWTLtY2xFSF2PLAiuF//w4BoK
        njo816umtwKG3Lq7vZuGQ/JvKPduhRV2OAL8GQOVnQ==
X-Google-Smtp-Source: AGHT+IFbG8/XxKE1gNy7mX/1EZGBZJv8s6zjOPW+33tkhFshOWCHLXli/pxckg0Zraz4EC6aivrMGA==
X-Received: by 2002:a17:907:720b:b0:9b2:7b89:8199 with SMTP id dr11-20020a170907720b00b009b27b898199mr756372ejc.53.1698809180630;
        Tue, 31 Oct 2023 20:26:20 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id fy23-20020a170906b7d700b009b2f2451381sm1854019ejb.182.2023.10.31.20.26.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 20:26:20 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5435336ab0bso3908835a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 20:26:19 -0700 (PDT)
X-Received: by 2002:a17:906:fe41:b0:9b6:aac1:6fa5 with SMTP id
 wz1-20020a170906fe4100b009b6aac16fa5mr914782ejb.55.1698809179717; Tue, 31 Oct
 2023 20:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0iBWcy2LyeXE0vxqKZOWBK5yWgofktygEvo4B3=6J8Wjg@mail.gmail.com>
In-Reply-To: <CAJZ5v0iBWcy2LyeXE0vxqKZOWBK5yWgofktygEvo4B3=6J8Wjg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 31 Oct 2023 17:26:02 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgYWb+LtHvQM+ULLWjfOLnfGcuDXNLrefEQbwCu=7apGQ@mail.gmail.com>
Message-ID: <CAHk-=wgYWb+LtHvQM+ULLWjfOLnfGcuDXNLrefEQbwCu=7apGQ@mail.gmail.com>
Subject: Re: [GIT PULL] Power management updates for v6.7-rc1
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2023 at 03:52, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> Please pull from the tag
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>  pm-6.7-rc1
>
> with top-most commit bf224871c27a7c7e2146d667176977ffe3752750

Not sure why this didn't get the pr-tracker-bot attention, but it's
merged, so here's the manual version,

                Linus
