Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845DB7D620A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbjJYHCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbjJYHCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:02:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81145CE
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:02:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B468721D55;
        Wed, 25 Oct 2023 07:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698217323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kop4RHx3I/qm5cVI02vI0zcS8kCCVSEvMKMqTpMXubU=;
        b=LgEuwx3xKFezlqHMPPzqSfP2fj4/fjEmr58w3uFjGHB/hekiH+HcLmg6Gb8b6XyCGuFBce
        6JFeXdyjCgAVogdio1TxlB3N5aGv9P2jBVs8xqSAj2TYpyuH+10zVC1xToLWg91b7WNH3q
        ZbnNjQmXfuxoYQGTFGHpiG/XGSr9kzs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698217323;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kop4RHx3I/qm5cVI02vI0zcS8kCCVSEvMKMqTpMXubU=;
        b=LdGIokLBkNRWTjqelatOJC4BN8v2xvSBam3sfmKCJym+StnHl4MP/eYPqAXXQ+T738VDnM
        7ezO+huOPnUJZsCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 83E4913524;
        Wed, 25 Oct 2023 07:02:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ORSUHWu9OGWBUQAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 25 Oct 2023 07:02:03 +0000
Message-ID: <60b7f4c3-c5e8-4fab-bf31-d576fff7a016@suse.de>
Date:   Wed, 25 Oct 2023 09:02:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [v2] nvme: keyring: fix conditional compilation
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20231020205521.3577821-1-arnd@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231020205521.3577821-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -7.09
X-Spamd-Result: default: False [-7.09 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         XM_UA_NO_VERSION(0.01)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[9];
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

On 10/20/23 22:54, Arnd Bergmann wrote:
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
> aarch64-linux-ld: drivers/nvme/target/configfs.o: in function `nvmet_ports_make':
> configfs.c:(.text+0x3c0c): undefined reference to `nvme_keyring_id'
> 
> Address this by wrapping the keyring code in stub functions that are
> used exclusively by one or the other side. In the more complicated auth
> interface, this is done in the separate drivers/nvme/{host,target}/auth.c
> that are conditionally compiled, as well as through large #ifdef blocks,
> but for the simpler keyring interface, it is sufficient to just wrap these
> four functions to ensure that they are only called when the feature is
> enabled in its caller.
> 
> In Kconfig, this requires changing the 'select NVME_KEYRING' since the
> keyring calls are done from the host and target core module, which may
> be built-in even when the tcp front-end is in a loadable module.
> 
> Fixes: be8e82caa6859 ("nvme-tcp: enable TLS handshake upcall")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Instead of keying the calls off the Kconfig symbols, replace
> the broken stub helpers with separate ones for host and target
> ---
>   drivers/nvme/host/Kconfig      |  2 +-
>   drivers/nvme/host/core.c       |  6 ++--
>   drivers/nvme/host/tcp.c        |  4 +--
>   drivers/nvme/target/Kconfig    |  2 +-
>   drivers/nvme/target/configfs.c |  4 +--
>   include/linux/nvme-keyring.h   | 56 +++++++++++++++++++++++++++++-----
>   6 files changed, 57 insertions(+), 17 deletions(-)
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
> index 62612f87aafa2..c06fea3f8940a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4724,7 +4724,7 @@ static int __init nvme_core_init(void)
>   		result = PTR_ERR(nvme_ns_chr_class);
>   		goto unregister_generic_ns;
>   	}
> -	result = nvme_keyring_init();
> +	result = nvme_host_keyring_init();
>   	if (result)
>   		goto destroy_ns_chr;
>   	result = nvme_init_auth();
> @@ -4733,7 +4733,7 @@ static int __init nvme_core_init(void)
>   	return 0;
>   
>   keyring_exit:
> -	nvme_keyring_exit();
> +	nvme_host_keyring_exit();
>   destroy_ns_chr:
>   	class_destroy(nvme_ns_chr_class);
>   unregister_generic_ns:
> @@ -4757,7 +4757,7 @@ static int __init nvme_core_init(void)
>   static void __exit nvme_core_exit(void)
>   {
>   	nvme_exit_auth();
> -	nvme_keyring_exit();
> +	nvme_host_keyring_exit();
>   	class_destroy(nvme_ns_chr_class);
>   	class_destroy(nvme_subsys_class);
>   	class_destroy(nvme_class);
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 4714a902f4caa..7e4a878b95383 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1585,7 +1585,7 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
>   	int ret;
>   	struct tls_handshake_args args;
>   	unsigned long tmo = tls_handshake_timeout * HZ;
> -	key_serial_t keyring = nvme_keyring_id();
> +	key_serial_t keyring = nvme_host_keyring_id();
>   
>   	dev_dbg(nctrl->device, "queue %d: start TLS with key %x\n",
>   		qid, pskid);
> @@ -1919,7 +1919,7 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
>   		if (ctrl->opts->tls_key)
>   			pskid = key_serial(ctrl->opts->tls_key);
>   		else
> -			pskid = nvme_tls_psk_default(ctrl->opts->keyring,
> +			pskid = nvme_host_tls_psk_default(ctrl->opts->keyring,
>   						      ctrl->opts->host->nqn,
>   						      ctrl->opts->subsysnqn);
>   		if (!pskid) {
> diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
> index 31633da9427c7..e5cdf92c628d0 100644
> --- a/drivers/nvme/target/Kconfig
> +++ b/drivers/nvme/target/Kconfig
> @@ -6,6 +6,7 @@ config NVME_TARGET
>   	depends on CONFIGFS_FS
>   	select BLK_DEV_INTEGRITY_T10 if BLK_DEV_INTEGRITY
>   	select SGL_ALLOC
> +	select NVME_KEYRING if NVME_TARGET_TCP_TLS
>   	help
>   	  This enabled target side support for the NVMe protocol, that is
>   	  it allows the Linux kernel to implement NVMe subsystems and
> @@ -87,7 +88,6 @@ config NVME_TARGET_TCP
>   config NVME_TARGET_TCP_TLS
>   	bool "NVMe over Fabrics TCP target TLS encryption support"
>   	depends on NVME_TARGET_TCP
> -	select NVME_KEYRING
>   	select NET_HANDSHAKE
>   	select KEYS
>   	help
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index 9eed6e6765eaa..337de8da1c178 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -1893,8 +1893,8 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
>   		return ERR_PTR(-ENOMEM);
>   	}
>   
> -	if (nvme_keyring_id()) {
> -		port->keyring = key_lookup(nvme_keyring_id());
> +	if (nvme_target_keyring_id()) {
> +		port->keyring = key_lookup(nvme_target_keyring_id());
>   		if (IS_ERR(port->keyring)) {
>   			pr_warn("NVMe keyring not available, disabling TLS\n");
>   			port->keyring = NULL;
> diff --git a/include/linux/nvme-keyring.h b/include/linux/nvme-keyring.h
> index 6cc0696625f36..6da4cda7f2f45 100644
> --- a/include/linux/nvme-keyring.h
> +++ b/include/linux/nvme-keyring.h
> @@ -6,8 +6,7 @@
>   #ifndef _NVME_KEYRING_H
>   #define _NVME_KEYRING_H
>   
> -#if IS_ENABLED(CONFIG_NVME_KEYRING)
> -
> +/* internal helpers only, don't call directly */
>   key_serial_t nvme_tls_psk_default(struct key *keyring,
>   		const char *hostnqn, const char *subnqn);
>   
> @@ -15,22 +14,63 @@ key_serial_t nvme_keyring_id(void);
>   int nvme_keyring_init(void);
>   void nvme_keyring_exit(void);
>   
> -#else
> +static inline key_serial_t nvme_host_tls_psk_default(struct key *keyring,
> +		const char *hostnqn, const char *subnqn)
> +{
> +	if (IS_ENABLED(CONFIG_NVME_TCP_TLS))
> +		return nvme_tls_psk_default(keyring, hostnqn, subnqn);
> +
> +	return 0;
> +}
> +static inline key_serial_t nvme_host_keyring_id(void)
> +{
> +	if (IS_ENABLED(CONFIG_NVME_TCP_TLS))
> +		return nvme_keyring_id();
> +
> +	return 0;
> +}
> +static inline int nvme_host_keyring_init(void)
> +{
> +	if (IS_ENABLED(CONFIG_NVME_TCP_TLS))
> +		return nvme_keyring_init();
> +
> +	return 0;
> +}
> +static inline void nvme_host_keyring_exit(void)
> +{
> +	if (IS_ENABLED(CONFIG_NVME_TCP_TLS))
> +		nvme_keyring_exit();
> +}
>   
> -static inline key_serial_t nvme_tls_psk_default(struct key *keyring,
> +static inline key_serial_t nvme_target_tls_psk_default(struct key *keyring,
>   		const char *hostnqn, const char *subnqn)
>   {
> +	if (IS_ENABLED(CONFIG_NVME_TARGET_TCP_TLS))
> +		return nvme_host_tls_psk_default(keyring, hostnqn, subnqn);
> +
>   	return 0;
>   }
> -static inline key_serial_t nvme_keyring_id(void)
> +
> +static inline key_serial_t nvme_target_keyring_id(void)
>   {
> +	if (IS_ENABLED(CONFIG_NVME_TARGET_TCP_TLS))
> +		return nvme_keyring_id();
> +
>   	return 0;
>   }
> -static inline int nvme_keyring_init(void)
> +
> +static inline int nvme_target_keyring_init(void)
>   {
> +	if (IS_ENABLED(CONFIG_NVME_TCP_TLS))
> +		return nvme_keyring_init();
> +
>   	return 0;
>   }
> -static inline void nvme_keyring_exit(void) {}
>   
> -#endif /* !CONFIG_NVME_KEYRING */
> +static inline void nvme_target_keyring_exit(void)
> +{
> +	if (IS_ENABLED(CONFIG_NVME_TARGET_TCP_TLS))
> +		nvme_keyring_exit();
> +}
> +
>   #endif /* _NVME_KEYRING_H */

I guess the right way is to make 'keyring' a 'real' module, and move 
'nvme_keyring_init()' and 'nvme_keyring_exit()' as the modules init/exit 
functions. I'll prepare a patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

