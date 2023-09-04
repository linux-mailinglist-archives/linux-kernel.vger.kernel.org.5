Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A5F791E0C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 22:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235967AbjIDUBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 16:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbjIDUB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 16:01:27 -0400
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0EECFB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 13:01:15 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.2.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 4EB5F200053;
        Mon,  4 Sep 2023 20:01:14 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id B898021DC8; Mon,  4 Sep 2023 21:59:48 +0200 (CEST)
Date:   Mon, 4 Sep 2023 21:59:48 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia: cs: fix possible hung task and memory leak
 pccardd()
Message-ID: <ZPY3NGjRVECc2AOZ@light.dominikbrodowski.net>
References: <20221112092541.3605038-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221112092541.3605038-1-yangyingliang@huawei.com>
X-TUID: VshhPLds3Pal
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sat, Nov 12, 2022 at 05:25:41PM +0800 schrieb Yang Yingliang:
> If device_register() returns error in pccardd(), it leads two issues:
> 
> 1. The socket_released has never been completed, it will block
>    pcmcia_unregister_socket(), because of waiting for completion
>    of socket_released.
> 2. The device name allocated by dev_set_name() is leaked.
> 
> Fix this two issues by calling put_device() when device_register() fails.
> socket_released can be completed in pcmcia_release_socket(), the name can
> be freed in kobject_cleanup().
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/pcmcia/cs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pcmcia/cs.c b/drivers/pcmcia/cs.c
> index f70197154a36..820cce7c8b40 100644
> --- a/drivers/pcmcia/cs.c
> +++ b/drivers/pcmcia/cs.c
> @@ -605,6 +605,7 @@ static int pccardd(void *__skt)
>  		dev_warn(&skt->dev, "PCMCIA: unable to register socket\n");
>  		skt->thread = NULL;
>  		complete(&skt->thread_done);
> +		put_device(&skt->dev);
>  		return 0;
>  	}
>  	ret = pccard_sysfs_add_socket(&skt->dev);
> -- 
> 2.25.1
> 

Applied to pcmcia-next, thanks!

	Dominik
