Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76E577FA10
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352546AbjHQPAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352592AbjHQO77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:59:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABF835AA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:59:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0FFF673CD
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 14:58:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E83C433C8;
        Thu, 17 Aug 2023 14:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692284334;
        bh=07Q0BsnSYTw2abmakLJYh6f7VgV3hoIX5r+L1SWZFTo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TDrQ14Ukv0FQ/wXBWJtm0+5uH4mYYdXWtqjsfH5zobLICECrK2AvzNz1MkN7YcO7L
         SlSfAjWO7sMpndztcse2BeujWcve5oM4n3iE21xx8eVb8+a2a87oR3WNDI9cTag3H/
         Zd4H7+njwudOdtsevMMssBe5aWIwaEJqZB6WE59bshmf3hh2ADPN9vty8e71g2urqs
         y8r5wfeuhAE7rGA2lpng5r6+mCwUQs2Gvrfd+McsVj3fmFJdW4GroeGJy9fDaCjqsr
         h7bn/OVXW0+/JGazuH7D5dXnSLSY7h7y5vzrhzcAQi+JmDfLkMYCpjZrZbzkw2ajAv
         x2PTR5BdFGu6g==
Message-ID: <ded879cd-9ee0-5f0d-d745-c0ba26eebfb8@kernel.org>
Date:   Thu, 17 Aug 2023 22:58:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] f2fs_io: add do_clearflags to clear nocompress/compress
 flag
Content-Language: en-US
To:     Qi Han <hanqi@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230815111928.31542-1-hanqi@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230815111928.31542-1-hanqi@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/15 19:19, Qi Han wrote:
> To align f2fs_io functionality with chattr +/-c and +/-m, the
> do_clearflags function has been added to clear the FS_COMPR_FL and
> FS_NOCOMP_FL flags.
> 
> Signed-off-by: Qi Han <hanqi@vivo.com>
> ---
>   man/f2fs_io.8           |  4 ++++
>   tools/f2fs_io/f2fs_io.c | 37 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 41 insertions(+)
> 
> diff --git a/man/f2fs_io.8 b/man/f2fs_io.8
> index 450f1b7..4ffb28d 100644
> --- a/man/f2fs_io.8
> +++ b/man/f2fs_io.8
> @@ -18,6 +18,10 @@ Get the flags associated with the specified file.
>   Set an f2fs file on specified file.  The flag can be casefold,
>   compression, and nocompression.
>   .TP
> +\fBclearflags\fR \fI[flag] [file]\fR
> +Clear an f2fs file on specified file.  The flag can be compression,

Clear a specified flag on target file?

Thanks,

> +and nocompression.
> +.TP
>   \fBshutdown\fR \fIshutdown filesystem\fR
>   Freeze and stop all IOs for the file system mounted on
>   .IR dir.
> diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
> index 73ac700..a450bf1 100644
> --- a/tools/f2fs_io/f2fs_io.c
> +++ b/tools/f2fs_io/f2fs_io.c
> @@ -330,6 +330,42 @@ static void do_setflags(int argc, char **argv, const struct cmd_desc *cmd)
>   	exit(0);
>   }
>   
> +#define clearflags_desc "clearflags ioctl"
> +#define clearflags_help						\
> +"f2fs_io clearflags [flag] [file]\n\n"				\
> +"clear a flag given the file\n"					\
> +"flag can be\n"							\
> +"  compression\n"						\
> +"  nocompression\n"						\
> +
> +static void do_clearflags(int argc, char **argv, const struct cmd_desc *cmd)
> +{
> +	long flag = 0;
> +	int ret, fd;
> +
> +	if (argc != 3) {
> +		fputs("Excess arguments\n\n", stderr);
> +		fputs(cmd->cmd_help, stderr);
> +		exit(1);
> +	}
> +
> +	fd = xopen(argv[2], O_RDONLY, 0);
> +
> +	ret = ioctl(fd, F2FS_IOC_GETFLAGS, &flag);
> +	printf("get a flag on %s ret=%d, flags=%lx\n", argv[1], ret, flag);
> +	if (ret)
> +		die_errno("F2FS_IOC_GETFLAGS failed");
> +
> +	if (!strcmp(argv[1], "compression"))
> +		flag &= ~FS_COMPR_FL;
> +	else if (!strcmp(argv[1], "nocompression"))
> +		flag &= ~FS_NOCOMP_FL;
> +
> +	ret = ioctl(fd, F2FS_IOC_SETFLAGS, &flag);
> +	printf("clear a flag on %s ret=%d, flags=%s\n", argv[2], ret, argv[1]);
> +	exit(0);
> +}
> +
>   #define shutdown_desc "shutdown filesystem"
>   #define shutdown_help					\
>   "f2fs_io shutdown [level] [dir]\n\n"			\
> @@ -1464,6 +1500,7 @@ const struct cmd_desc cmd_list[] = {
>   	CMD(set_verity),
>   	CMD(getflags),
>   	CMD(setflags),
> +	CMD(clearflags),
>   	CMD(shutdown),
>   	CMD(pinfile),
>   	CMD(fallocate),
