Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E50A7567B0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjGQPVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjGQPVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:21:32 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B7D103
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:21:04 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-66f5faba829so3305356b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689607224; x=1692199224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G4erhyV5rhAgSTRhQd8/0rL6paDuQerHIfnNF64n4IQ=;
        b=PyklcFyCG1jvU66nFZo49tfVzOlUIZTMPQGmpxD6Np3mZynRHUY4TUHZybBJ5pHhSK
         fq0iEEwQnSR9cEMlbMSDlYIZMmYPMtVoq330H29F2nnA6lFRAprwTMnUQpcB5Ae/jFMb
         LOIjbJfSlUhWvrKQ71ueK0dCC/9fiqrtwTl/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689607224; x=1692199224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4erhyV5rhAgSTRhQd8/0rL6paDuQerHIfnNF64n4IQ=;
        b=Ir4RF7431JpmS4XzKq96K6MpTPaiaIkauaRO9na0KLkDJbal2N76QtzISOAVEMs+UU
         3f4J8vJ37jLv7ezrC6CFVye8Q2cQiZHjrrHtpvJ/RX+eRoAsB5CpkycOEWeKFcC7eSs4
         DnJQL3sACmfowzEbw8f6gkqD8uE24Jb1zjhyKo3BXhZ42Zo4Ym1sNKC8BDaNHDEK6q2B
         xJFp2B5vZ0AUuvdUWTNp4MaicfPEaV2G/wULX3WlC30PBjmHVpG8zqecdUR1Cfzi343x
         HLB9J1PzwXUBQYqJHa4tLEjFUQQGJEVuCTJLHEgvjAYsZYHZfdbaIisbXguNJBy3awN7
         Iekw==
X-Gm-Message-State: ABy/qLZcCK2jvaju0ZSwzsEWPARq55jjCgjF5ZqBKlvh7LERHk+kaJ7i
        DU2Kr8+tnArUN0nljB2khmYUQh/DZH6zOMENc2U=
X-Google-Smtp-Source: APBJJlFK8qLuq+bm7ZIAL2Np1LEcUmDeQtmNwTzG2b/Ge8rh2Mt1VKhO7CFQArc8XMHeJKILIOSSPA==
X-Received: by 2002:a05:6a00:1409:b0:682:d2af:218 with SMTP id l9-20020a056a00140900b00682d2af0218mr13158098pfu.24.1689607224473;
        Mon, 17 Jul 2023 08:20:24 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k10-20020a633d0a000000b0054fe6bae952sm13180487pga.4.2023.07.17.08.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 08:20:23 -0700 (PDT)
Date:   Mon, 17 Jul 2023 08:20:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Bob Copeland <me@bobcopeland.com>,
        linux-karma-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] fs: omfs: Use flexible-array member in struct
 omfs_extent
Message-ID: <202307170758.14B5D83D@keescook>
References: <ZLGodUeD307GlINN@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLGodUeD307GlINN@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 01:56:37PM -0600, Gustavo A. R. Silva wrote:
> There are some binary differences before and after changes, but this are
> expected due to the change in the size of 'struct omfs_extent' and the
> necessary adjusments.

For binary changes, I think commit logs should have more details. In
this case, I can figure it out:

> diff --git a/fs/omfs/file.c b/fs/omfs/file.c
> index de8f57ee39ec..6b580b9da8e3 100644
> --- a/fs/omfs/file.c
> +++ b/fs/omfs/file.c
> @@ -14,7 +14,7 @@ static u32 omfs_max_extents(struct omfs_sb_info *sbi, int offset)
>  {
>  	return (sbi->s_sys_blocksize - offset -
>  		sizeof(struct omfs_extent)) /
> -		sizeof(struct omfs_extent_entry) + 1;
> +		sizeof(struct omfs_extent_entry);
>  }

I think the original calculation meant to do:

  	return (sbi->s_sys_blocksize - offset -
  		(sizeof(struct omfs_extent) - sizeof(struct omfs_extent_entry))) /
		sizeof(struct omfs_extent_entry);

So this binary difference looks correct. I rebuilt before/after this
patch with omfs_max_extents() marked as noinline, and all the binary
changes were isolated here, and did exactly as expected: the first half
is 16 smaller (size of struct omfs_extent_entry), and the final +1 is
removed:

-     2e1:      lea    -0x20(%rbx),%rax
+     2e1:      lea    -0x10(%rbx),%rax
      2e5:      pop    %rbx
      2e6:      pop    %rbp
      2e7:      shr    $0x4,%rax
-     2eb:      add    $0x1,%eax

So this looks correct to me. Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
