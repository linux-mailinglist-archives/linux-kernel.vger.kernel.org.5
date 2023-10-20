Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D2D7D10CF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 15:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377462AbjJTNuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 09:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377456AbjJTNus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 09:50:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B20D53
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 06:50:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7C39C1F854;
        Fri, 20 Oct 2023 13:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1697809843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QsTS9JsJ8ztVmFk/AB2ll3GC2tK9jhtycDEsiAYV9xs=;
        b=Q36U3tNUx2BP2fYVGh5H//GuMMUsb+35pYwlc04JFFV/F8KoT2xjP/C3pYWZ1YqVgk8A3/
        6AcaQvUUYFkS/O0fJVYHYDyI7146qS4sd6eP2WtmFvZHOVmIcSKUZFspwTsJ7fgunumYjX
        ofMfRHiyG03fGPs2eTk5QWzkIIlHeVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1697809843;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QsTS9JsJ8ztVmFk/AB2ll3GC2tK9jhtycDEsiAYV9xs=;
        b=INCuSUnujizvdsAbqkfuE7c9cVB9HRnoS2JYzj/4NHzR1Vc+IaKeZhOsv+aCN/ymEMLP7w
        ZPtN5zses7eVPtAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 334EC13584;
        Fri, 20 Oct 2023 13:50:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id szQOCLOFMmWUMQAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 20 Oct 2023 13:50:43 +0000
Message-ID: <69afc25c-ffc7-4ec4-a290-8c67f4dd36bd@suse.de>
Date:   Fri, 20 Oct 2023 15:50:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme: keyring: fix conditional compilation
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Mike Christie <michael.christie@oracle.com>,
        Uday Shankar <ushankar@purestorage.com>,
        David Howells <dhowells@redhat.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231020130644.485649-1-arnd@kernel.org>
 <20231020130644.485649-2-arnd@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231020130644.485649-2-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -11.09
X-Spamd-Result: default: False [-11.09 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         XM_UA_NO_VERSION(0.01)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_TWELVE(0.00)[12];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/23 15:05, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The keyring and auth functions can be called from both the host and
> the target side and are controlled by Kconfig options for each of the
> combinations, but the declarations are controlled by #ifdef checks
> on the shared Kconfig symbols.
> 
> This leads to link failures in combinations where one of the frontends
> is built-in and the other one is a module, and the keyring code
> ends up in a module that is not reachable from the builtin code:
> 
> ld: drivers/nvme/host/core.o: in function `nvme_core_exit':
> core.c:(.exit.text+0x4): undefined reference to `nvme_keyring_exit'
> ld: drivers/nvme/host/core.o: in function `nvme_core_init':
> core.c:(.init.text+0x94): undefined reference to `nvme_keyring_init
> 
> ld: drivers/nvme/host/tcp.o: in function `nvme_tcp_setup_ctrl':
> tcp.c:(.text+0x4c18): undefined reference to `nvme_tls_psk_default'
> 
> Address this by adding compile-time checks around the callers where
> needed, based on whether the functionality is actually used for
> the target and host side, respectively.
> 
> In Kconfig, this requires changing the 'select NVME_KEYRING'
> since the keyring calls are done from the host core module,
> which may be built-in even when the tcp front-end is in a loadable
> module.
> 
> Fixes: be8e82caa6859 ("nvme-tcp: enable TLS handshake upcall")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/nvme/host/Kconfig      |  2 +-
>   drivers/nvme/host/core.c       | 16 +++++++++++-----
>   drivers/nvme/host/tcp.c        |  2 +-
>   drivers/nvme/target/configfs.c |  2 +-
>   4 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
> index 8fe2dd619e80e..2d53c23f0a483 100644
> --- a/drivers/nvme/host/Kconfig
> +++ b/drivers/nvme/host/Kconfig
> @@ -2,6 +2,7 @@
>   config NVME_CORE
>   	tristate
>   	select BLK_DEV_INTEGRITY_T10 if BLK_DEV_INTEGRITY
> +	select NVME_KEYRING if NVME_TCP_TLS
>   
>   config BLK_DEV_NVME
>   	tristate "NVM Express block device"
> @@ -95,7 +96,6 @@ config NVME_TCP
>   config NVME_TCP_TLS
>   	bool "NVMe over Fabrics TCP TLS encryption support"
>   	depends on NVME_TCP
> -	select NVME_KEYRING
>   	select NET_HANDSHAKE
>   	select KEYS
>   	help
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 62612f87aafa2..ac92534f6da90 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4724,16 +4724,20 @@ static int __init nvme_core_init(void)
>   		result = PTR_ERR(nvme_ns_chr_class);
>   		goto unregister_generic_ns;
>   	}
> -	result = nvme_keyring_init();
> +	if (IS_ENABLED(CONFIG_NVME_TCP_TLS))
> +		result = nvme_keyring_init();
>   	if (result)
>   		goto destroy_ns_chr;
> -	result = nvme_init_auth();
> +
> +	if (IS_ENABLED(CONFIG_NVME_HOST_AUTH))
> +		result = nvme_init_auth();
>   	if (result)
>   		goto keyring_exit;
>   	return 0;
>   
>   keyring_exit:
> -	nvme_keyring_exit();
> +	if (IS_ENABLED(CONFIG_NVME_TCP_TLS))
> +		nvme_keyring_exit();
>   destroy_ns_chr:
>   	class_destroy(nvme_ns_chr_class);
>   unregister_generic_ns:
> @@ -4756,8 +4760,10 @@ static int __init nvme_core_init(void)
>   
>   static void __exit nvme_core_exit(void)
>   {
> -	nvme_exit_auth();
> -	nvme_keyring_exit();
> +	if (IS_ENABLED(CONFIG_NVME_HOST_AUTH))
> +		nvme_exit_auth();
> +	if (IS_ENABLED(CONFIG_NVME_TCP_TLS))
> +		nvme_keyring_exit();
>   	class_destroy(nvme_ns_chr_class);
>   	class_destroy(nvme_subsys_class);
>   	class_destroy(nvme_class);

Please add stub calls and avoid sprinkle the code with
IS_ENABLED statements.

> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 4714a902f4caa..e2b90789c0407 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1915,7 +1915,7 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
>   	int ret;
>   	key_serial_t pskid = 0;
>   
> -	if (ctrl->opts->tls) {
> +	if (IS_ENABLED(CONFIG_NVME_TCP_TLS) && ctrl->opts->tls) {

Why? '->tls' is not protected by a CONFIG options, and should be
available in general ...

>   		if (ctrl->opts->tls_key)
>   			pskid = key_serial(ctrl->opts->tls_key);
>   		else
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index 9eed6e6765eaa..e307a044b1a1b 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -1893,7 +1893,7 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
>   		return ERR_PTR(-ENOMEM);
>   	}
>   
> -	if (nvme_keyring_id()) {
> +	if (IS_ENABLED(CONFIG_NVME_TARGET_TCP_TLS) && nvme_keyring_id()) {
>   		port->keyring = key_lookup(nvme_keyring_id());
>   		if (IS_ERR(port->keyring)) {
>   			pr_warn("NVMe keyring not available, disabling TLS\n");
Please make this a stub.

Cheers,

Hannes

