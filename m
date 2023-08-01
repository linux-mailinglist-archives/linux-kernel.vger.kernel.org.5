Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BAB76A889
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 07:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjHAF4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 01:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjHAF4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 01:56:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E034BE7D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 22:56:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6847961291
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 05:56:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D8FC433C7;
        Tue,  1 Aug 2023 05:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690869402;
        bh=FxgbuCrtMjAtsnDyQPk8xZvAZHTawLstjXuSJzIsfRg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W4vkNRs9u/ZtiRv5SpGE6W56nszk+XjHPT99uYApblzMBzJhDpFITofUXuffNcsGO
         foAWk19J6RjQKq34WvdayeU5gqYJlXM+8ZbfDZIAgVuHxLNdPJj5zk7NwtKJef2btq
         aeNaCmZoB4OTzhFjgmxMjExYnmaFbgxX671mDJzM=
Date:   Tue, 1 Aug 2023 07:56:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     oushixiong <oushixiong@kylinos.cn>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: vt: Remove some repetitive initialization
Message-ID: <2023080159-chatting-endanger-7115@gregkh>
References: <20230801054933.895780-1-oushixiong@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801054933.895780-1-oushixiong@kylinos.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 01:49:33PM +0800, oushixiong wrote:
> Some members of struct vc_data have been initialized in the vc_visual(),

Which members specifically?

> so it no longer to initialized them in vc_init().
> 
> Signed-off-by: oushixiong <oushixiong@kylinos.cn>
> ---
>  drivers/tty/vt/vt.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 1e8e57b45688..cf77011a8f4e 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -140,8 +140,7 @@ EXPORT_SYMBOL(vc_cons);
>  static const struct consw *con_driver_map[MAX_NR_CONSOLES];
>  
>  static int con_open(struct tty_struct *, struct file *);
> -static void vc_init(struct vc_data *vc, unsigned int rows,
> -		    unsigned int cols, int do_clear);
> +static void vc_init(struct vc_data *vc, int do_clear);
>  static void gotoxy(struct vc_data *vc, int new_x, int new_y);
>  static void save_cur(struct vc_data *vc);
>  static void reset_terminal(struct vc_data *vc, int do_clear);
> @@ -1103,7 +1102,7 @@ int vc_allocate(unsigned int currcons)	/* return 0 on success */
>  	if (global_cursor_default == -1)
>  		global_cursor_default = 1;
>  
> -	vc_init(vc, vc->vc_rows, vc->vc_cols, 1);
> +	vc_init(vc, 1);
>  	vcs_make_sysfs(currcons);
>  	atomic_notifier_call_chain(&vt_notifier_list, VT_ALLOCATE, &param);
>  
> @@ -3398,16 +3397,10 @@ module_param_named(color, default_color, int, S_IRUGO | S_IWUSR);
>  module_param_named(italic, default_italic_color, int, S_IRUGO | S_IWUSR);
>  module_param_named(underline, default_underline_color, int, S_IRUGO | S_IWUSR);
>  
> -static void vc_init(struct vc_data *vc, unsigned int rows,
> -		    unsigned int cols, int do_clear)
> +static void vc_init(struct vc_data *vc, int do_clear)
>  {
>  	int j, k ;
>  
> -	vc->vc_cols = cols;
> -	vc->vc_rows = rows;
> -	vc->vc_size_row = cols << 1;
> -	vc->vc_screenbuf_size = vc->vc_rows * vc->vc_size_row;

Where are these being set now?

thanks,

greg k-h
