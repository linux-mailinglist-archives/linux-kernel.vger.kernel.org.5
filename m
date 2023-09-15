Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9FF7A2748
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 21:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237043AbjIOTgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 15:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237001AbjIOTgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:36:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DA551BF2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 12:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694806528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HVf1V3CzDZ5lP3pmoo5CaMEBLPRoiU7cCml7ReFuTR0=;
        b=ccOIFHg+7hLxcLVj61GlZiYIB98Yq9NruOpQPG9+YZKYXrEFJXSkIX1on3tmzZyk7+QVo4
        hQY0j8Cn6EyeLScaz3Ge4Ds5J3STlYXo3LD8X8QjrVuEKhpQhu/FqKPXm2rwZKzNE4gjwJ
        qpoUFF1BQo432Y8wIIMqk6UipzurCUk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-cllQ2L9OOrKeWt2CP3qnUw-1; Fri, 15 Sep 2023 15:35:25 -0400
X-MC-Unique: cllQ2L9OOrKeWt2CP3qnUw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-414d7fb4859so26980421cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 12:35:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694806525; x=1695411325;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HVf1V3CzDZ5lP3pmoo5CaMEBLPRoiU7cCml7ReFuTR0=;
        b=BB0HI1uzMBDo5avHcKFA6bvLoWODhYrMUUAKM1C8vZHzNtUD1MpiKboHnRbnIFWIH4
         H0s8ZjdyZ62Rep4V+1q//jgQsLTDuZUHjYH9mHJYwxbxHWrPXI7zs/vElp7b/NL2KXJf
         NbEwyYO5ebL9BKmTiGYqK905bS5VVyQDTkMC6rwuiq946scFZ5Dp7D/XmMM1oFNGgyyt
         OZk3v2lUFmCnaY4xyp6Rk+rybCkl3Fr4ovs9j4kL0qLp1+o8C8GhhER7EPEBzHIQV4Pp
         4ZZpsA7LhbQvFxtqDPAsEx8bIjqyhtLJLRfFmNlM4sMdV5ARmipsBlDc1+tvbw+mDeyg
         /XQg==
X-Gm-Message-State: AOJu0YzTZJ2Q4mqF+9jkvp8s6ygmCiw0YzuuHEnZATrXD2CWhWi4D8Cd
        1EH34/1mFQMyEU+2eMNW3zqON0JA51ms2gP9WiQGl/tcz3no3MiRFfntyq3h5B59vrqVMP5NXHg
        F3qOzKsOxwK8eqx4W/YpKKINC
X-Received: by 2002:ac8:5bd0:0:b0:412:1e4c:e858 with SMTP id b16-20020ac85bd0000000b004121e4ce858mr2872788qtb.36.1694806525095;
        Fri, 15 Sep 2023 12:35:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhY+zLilO9nIc2jJlB/O2T5ucpf0omBdswrGZrkcwBBrWmTQQAm72M/bgntZ+AUyYEISgoqw==
X-Received: by 2002:ac8:5bd0:0:b0:412:1e4c:e858 with SMTP id b16-20020ac85bd0000000b004121e4ce858mr2872776qtb.36.1694806524860;
        Fri, 15 Sep 2023 12:35:24 -0700 (PDT)
Received: from rh (p200300c93f1ec600a890fb4d684902d4.dip0.t-ipconnect.de. [2003:c9:3f1e:c600:a890:fb4d:6849:2d4])
        by smtp.gmail.com with ESMTPSA id h5-20020ac87765000000b0041514d1da65sm1349819qtu.20.2023.09.15.12.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 12:35:24 -0700 (PDT)
Date:   Fri, 15 Sep 2023 21:35:20 +0200 (CEST)
From:   Sebastian Ott <sebott@redhat.com>
To:     =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>
cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Brown <broonie@kernel.org>, Willy Tarreau <w@1wt.eu>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH RFC] binfmt_elf: fully allocate bss pages
In-Reply-To: <20230914-bss-alloc-v1-1-78de67d2c6dd@weissschuh.net>
Message-ID: <3c0f1acf-b95b-3570-bf51-7716b6209f16@redhat.com>
References: <20230914-bss-alloc-v1-1-78de67d2c6dd@weissschuh.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463795790-230173133-1694806524=:4151"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463795790-230173133-1694806524=:4151
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

Hej Thomas,

On Thu, 14 Sep 2023, Thomas Weißschuh wrote:
> fs/binfmt_elf.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 7b3d2d491407..4008a57d388b 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -112,7 +112,7 @@ static struct linux_binfmt elf_format = {
>
> static int set_brk(unsigned long start, unsigned long end, int prot)
> {
> -	start = ELF_PAGEALIGN(start);
> +	start = ELF_PAGESTART(start);
> 	end = ELF_PAGEALIGN(end);
> 	if (end > start) {
> 		/*
>

My arm box failed to boot with that patch applied on top of 6.6-rc1 .
There was nothing suspicious on the serial console it just hung somewhere
in userspace initialization. Sadly there was also nothing in the system
logs. 6.6-rc1 worked fine.

Sebastian
---1463795790-230173133-1694806524=:4151--

