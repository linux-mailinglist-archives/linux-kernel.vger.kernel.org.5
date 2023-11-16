Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CAD7EE2CB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbjKPOaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjKPOaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:30:08 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78DCAD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:30:01 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cc5916d578so7898615ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700145001; x=1700749801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T5CFIZMwZsIi1w6Tq3EafFzryCHHlKPpfY4zDkytZ7U=;
        b=R3AEqaSZVMIMjjddqI4j6NlcKknYaIrFrVGEqEcMQwcBU8DgIbnVyqQSrDcYbEYncJ
         sVUsdCqAN+/0SPB4QheAyNhquxo3VQGzAuUZkwGZ/zfVLk2cw84wlxdEyI9NHgB4Twep
         7dlv/1ASPG6x9tuWPca9T9e3A80ta4Sa08XTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700145001; x=1700749801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5CFIZMwZsIi1w6Tq3EafFzryCHHlKPpfY4zDkytZ7U=;
        b=n8qsEHaIHoTe4TPpEG0le+0fZ2MsUmiFqw9Ez8x78dfKSwnvSc2bu4L4FYKpVFpuWj
         JPE5qZt6XNUcM25UIxP3vQsXo7+u+LJ/hr71ICyCy1CbWKW2Vte8XxG7pd4YtqPQMOR/
         KuC1AaXko8gH2o5Rcs9d0fY7reBWCpqqN3mTbi+6LAuXpwoGUlujK2fcQBlYQwwii9hO
         ZbuydXvYE77cmIagF22hyhpkSE9JS73bNZj6n/efIbade3tm/kt4frWomn3q6TGyTepl
         nJ1HVb63WbiHRr4Qf9Bigou2vzML5a2gm7rLS4W51YuLVobKooBRjrZDivgq+A/Y9ekR
         9bMQ==
X-Gm-Message-State: AOJu0Yx8SLYQTfmWAt8vKTISwr5LvMKc4jy1UfL5GNgc16wEmdm0oFl5
        Q0m0sGads80xIF240TWoAa8NuA==
X-Google-Smtp-Source: AGHT+IG6V5T+0h2/o/qC5yOwsFvHS/29nOKkQVfCxV97Mw1JK0y5UuHXg3KrPJuJB7pX6mYEVsJa4Q==
X-Received: by 2002:a17:903:1108:b0:1c3:c687:478c with SMTP id n8-20020a170903110800b001c3c687478cmr11031354plh.8.1700145001063;
        Thu, 16 Nov 2023 06:30:01 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t16-20020a170902e85000b001c46d04d001sm9301552plg.87.2023.11.16.06.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 06:30:00 -0800 (PST)
Date:   Thu, 16 Nov 2023 06:29:59 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Ronald Monthero <debug.penguin32@gmail.com>
Cc:     al@alarsen.net, gustavoars@kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] qnx4: fix to avoid panic due to buffer overflow
Message-ID: <202311160612.C38BF44@keescook>
References: <20231112095353.579855-1-debug.penguin32@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231112095353.579855-1-debug.penguin32@gmail.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2023 at 07:53:53PM +1000, Ronald Monthero wrote:
> qnx4 dir name length can vary to be of maximum size
> QNX4_NAME_MAX or QNX4_SHORT_NAME_MAX depending on whether
> 'link info' entry is stored and the status byte is set.
> So to avoid buffer overflow check di_fname length
> fetched from (struct qnx4_inode_entry *)
> before use in strlen to avoid buffer overflow.
> 
> panic context
> [ 4849.636861] detected buffer overflow in strlen
> [ 4849.636897] ------------[ cut here ]------------
> [ 4849.636902] kernel BUG at lib/string.c:1165!
> [ 4849.636917] invalid opcode: 0000 [#2] SMP PTI
> ..
> [ 4849.637047] Call Trace:
> [ 4849.637053]  <TASK>
> [ 4849.637059]  ? show_trace_log_lvl+0x1d6/0x2ea
> [ 4849.637075]  ? show_trace_log_lvl+0x1d6/0x2ea
> [ 4849.637095]  ? qnx4_find_entry.cold+0xc/0x18 [qnx4]
> [ 4849.637111]  ? show_regs.part.0+0x23/0x29
> [ 4849.637123]  ? __die_body.cold+0x8/0xd
> [ 4849.637135]  ? __die+0x2b/0x37
> [ 4849.637147]  ? die+0x30/0x60
> [ 4849.637161]  ? do_trap+0xbe/0x100
> [ 4849.637171]  ? do_error_trap+0x6f/0xb0
> [ 4849.637180]  ? fortify_panic+0x13/0x15
> [ 4849.637192]  ? exc_invalid_op+0x53/0x70
> [ 4849.637203]  ? fortify_panic+0x13/0x15
> [ 4849.637215]  ? asm_exc_invalid_op+0x1b/0x20
> [ 4849.637228]  ? fortify_panic+0x13/0x15
> [ 4849.637240]  ? fortify_panic+0x13/0x15
> [ 4849.637251]  qnx4_find_entry.cold+0xc/0x18 [qnx4]
> [ 4849.637264]  qnx4_lookup+0x3c/0xa0 [qnx4]
> [ 4849.637275]  __lookup_slow+0x85/0x150
> [ 4849.637291]  walk_component+0x145/0x1c0
> [ 4849.637304]  ? path_init+0x2c0/0x3f0
> [ 4849.637316]  path_lookupat+0x6e/0x1c0
> [ 4849.637330]  filename_lookup+0xcf/0x1d0
> [ 4849.637341]  ? __check_object_size+0x1d/0x30
> [ 4849.637354]  ? strncpy_from_user+0x44/0x150
> [ 4849.637365]  ? getname_flags.part.0+0x4c/0x1b0
> [ 4849.637375]  user_path_at_empty+0x3f/0x60
> [ 4849.637383]  vfs_statx+0x7a/0x130
> [ 4849.637393]  do_statx+0x45/0x80
> ..
> 
> Signed-off-by: Ronald Monthero <debug.penguin32@gmail.com>
> ---
>  fs/qnx4/namei.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/qnx4/namei.c b/fs/qnx4/namei.c
> index 8d72221735d7..825b891a52b3 100644
> --- a/fs/qnx4/namei.c
> +++ b/fs/qnx4/namei.c
> @@ -40,6 +40,13 @@ static int qnx4_match(int len, const char *name,
>  	} else {
>  		namelen = QNX4_SHORT_NAME_MAX;
>  	}
> +
> +	/** qnx4 dir name length can vary, check the di_fname
> +	 * fetched from (struct qnx4_inode_entry *) before use in
> +	 * strlen to avoid panic due to buffer overflow"
> +	 */

Style nit: this comment should start with just "/*" alone, like:

	/*
	 * qnx4 dir name ...

> +	if (strnlen(de->di_fname, namelen) >= sizeof(de->di_fname))
> +		return -ENAMETOOLONG;
>  	thislen = strlen( de->di_fname );

de->di_fname is:

struct qnx4_inode_entry {
        char            di_fname[QNX4_SHORT_NAME_MAX];
	...

#define QNX4_SHORT_NAME_MAX     16
#define QNX4_NAME_MAX           48

It's always going to have a max of QNX4_SHORT_NAME_MAX. Is any of this
code correct if namelen ends up being QNX4_NAME_MAX? It'll be reading
past the end of di_fname.

Is bh->b_data actually struct qnx4_inode_entry ?

-Kees

>  	if ( thislen > namelen )
>  		thislen = namelen;
> -- 
> 2.34.1
> 

-- 
Kees Cook
