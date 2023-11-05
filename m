Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2257E161F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 20:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjKETkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 14:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjKETkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 14:40:11 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A5CDD
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 11:40:08 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c5087d19a6so51284801fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 11:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscv-rocks.de; s=google; t=1699213206; x=1699818006; darn=vger.kernel.org;
        h=organization:user-agent:in-reply-to:content-disposition
         :mime-version:references:mail-followup-to:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tdHd2RkgvpY71GPn4HPjS487djSpT0ZIFSpSt/ISOD4=;
        b=X+pYnuXdg+npAenZgI/rLCZKhu+KSdkHzJ8ndT9cNd7ZKL44TmojtUT5PoyQ/Eeimy
         GpHtTo2chAMtWDp0RfVrPHJkZHuyfHZJBh/GrcIWi5EPTPPRAdXALjTjGJOLfDp8D8zE
         v6dzb2iXgX73cNlwxLcQeN0uaH+2ax1MQ4uBDZ53hoALt19w/R10spXLtw21uC/M/0G4
         H4nLdbWi6qNvVgN4w5J7w977Ine4lLSwiCZ/276tQ6GHPJI5L9uneYlYLWQ8w4orVKvl
         TCEwOQyZXd81UlZX8MgDO2DnCpmemV8KBbJQ5AytMwp7/DqhtTXIrpo3h0uMxZjlSbDU
         WphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699213206; x=1699818006;
        h=organization:user-agent:in-reply-to:content-disposition
         :mime-version:references:mail-followup-to:reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdHd2RkgvpY71GPn4HPjS487djSpT0ZIFSpSt/ISOD4=;
        b=ORP0boNj0cQoZPI9NFvuFhPnk0hNxnrtgUjJO8kgFLuSUmSDHw9swc/+a+XMQ9525f
         2k/tK1UdaeUNREtuv7GS1BwsQ8/o57mi8Lgiql7JpRyipf+PGiZ4mgAVbjzeaHE9NjYR
         MM1hkBETcgMcaMFZaLoIX7DeiCVnpg5F0sR7oQS/8YhDjUNuUWrE6F6q5ZgouQD/1tYX
         6KwaxDb4mvo61fOKNIxSLP2278RJFshFRy4dYSzN92oX4f56dV9xevz9Mlr5vMywp4QT
         ftJzAFdGUhc/aEZgaLqushAGPqMews7q5ce9bs8fO/8b8d9DaKHk+ADcGN0f3TamsINJ
         fvMA==
X-Gm-Message-State: AOJu0YyUzfHTWWshIqG7Jh/myQE7z5vgSc8b3iiU9lVVEO+wHr50C1zR
        kIVoYjnN2c8UwRCyBjJaobpvsd1HbYoM18mu6XQCb1Z1
X-Google-Smtp-Source: AGHT+IEDpPOSyQlEYQ599s+ukx7cAmvJLebp+81/y24pOJVyTL+Gogp1IDESO1lAeGkRsIwrlb9Yeg==
X-Received: by 2002:a2e:9015:0:b0:2c5:4a0:f3cb with SMTP id h21-20020a2e9015000000b002c504a0f3cbmr20373578ljg.11.1699213206039;
        Sun, 05 Nov 2023 11:40:06 -0800 (PST)
Received: from fedora.fritz.box (p5494469c.dip0.t-ipconnect.de. [84.148.70.156])
        by smtp.gmail.com with ESMTPSA id bs14-20020a056000070e00b0032d8eecf901sm7650582wrb.3.2023.11.05.11.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 11:40:05 -0800 (PST)
Date:   Sun, 5 Nov 2023 20:40:03 +0100
From:   Damian Tometzki <damian@riscv-rocks.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Steve French <smfrench@gmail.com>,
        Damian Tometzki <damian@riscv-rocks.de>,
        John Sanpe <sanpeqf@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Paulo Alcantara <pc@manguebit.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: smb cifs: Linux 6.7 pre rc-1 kernel dump in smb2_get_aead_req
Message-ID: <ZUfvk-6y2pER6Rmc@fedora.fritz.box>
Reply-To: Damian Tometzki <damian@riscv-rocks.de>
Mail-Followup-To: Eric Biggers <ebiggers@kernel.org>,
        Steve French <smfrench@gmail.com>,
        Damian Tometzki <damian@riscv-rocks.de>,
        John Sanpe <sanpeqf@gmail.com>, CIFS <linux-cifs@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Paulo Alcantara <pc@manguebit.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20231022183917.1013135-1-sanpeqf@gmail.com>
 <ZUfQo47uo0p2ZsYg@fedora.fritz.box>
 <CAH2r5msde65PMtn-96VZDAQkT_rq+e-2G4O+zbPUR8zSWGxMsg@mail.gmail.com>
 <20231105193601.GB91123@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231105193601.GB91123@sol.localdomain>
User-Agent: Mutt
X-Operating-System: Linux Fedora release 39 (Thirty Nine) (Kernel
 6.5.9-300.fc39.x86_64)
Organization: Linux hacker
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05. Nov 11:36, Eric Biggers wrote:
> On Sun, Nov 05, 2023 at 11:05:30AM -0700, Steve French wrote:
> > maybe related to this recent crypto patch?
> > 
> > https://git.samba.org/?p=sfrench/cifs-2.6.git;a=commit;h=783fa2c94f4150fe1b7f7d88b3baf6d98f82b41b
> > 
> > On Sun, Nov 5, 2023, 10:32 Damian Tometzki <damian@riscv-rocks.de> wrote:
> > > [   83.530503] CPU: 7 PID: 4584 Comm: mount.cifs Tainted: G        W
> > >     6.6.0 #61
> > > [   83.530508] Hardware name: LENOVO 20XWCTO1WW/20XWCTO1WW, BIOS N32ET86W
> > > (1.62 ) 07/12/2023
> 
> The above suggests that this warning occurred on 6.6, not on 6.7 pre rc1.
> 
> - Eric
Hello,

is little bit missleading but it is 6.6 from linus mainline git with all
the pull request. 

Damian

