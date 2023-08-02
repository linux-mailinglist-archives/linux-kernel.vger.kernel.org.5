Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AEC76D2BB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjHBPrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbjHBPrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:47:19 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A123D9B;
        Wed,  2 Aug 2023 08:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=u+eTVzDBOj1InyZSduxL/CRo1hb2JHwGid0R+96a+4A=; b=R8nVVThaPu37mhmrjlsqLt5r/F
        wT4rNJt2iafYVQYZ1qEZJ0ZdTF213lPo3aB9cVKEp+z+oSYkJygZRzkSEX9cR7bIQZGAyDe7B0mss
        31dGjJ51OjjKDbanIkl6EZdvJAV4sw6SWUBJb7up8WumIHIFNVpfSjEpUv2Chwp2gsLRgBS88egUW
        rJQ/1LYYgZg9mznMj/11RVNJLZxfertQ1Ck2Abj7M25RQUd6KMbdtpQOi4ylg1MWajbPVIlYkDotf
        Ms6DAVKu+Gb/9AkNKMwD9ozYjlP5gnkBs8koBNOp4bhGsFOymBrUnZaJgYd9YbfeXAcexK1lPFcZQ
        qMrHaUlw==;
Received: from 201-92-22-215.dsl.telesp.net.br ([201.92.22.215] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qRE3s-00BGGs-8w; Wed, 02 Aug 2023 17:46:56 +0200
Message-ID: <f0cc1d69-71a2-e50d-07ea-b17ab26d6cf4@igalia.com>
Date:   Wed, 2 Aug 2023 12:46:49 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/1] pstore/ram: Check member of buffers during the
 initialization phase of the pstore
Content-Language: en-US
To:     Yunlong Xing <yunlong.xing@unisoc.com>, keescook@chromium.org,
        tony.luck@intel.com, joel@joelfernandes.org, enlin.mu@unisoc.com
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        enlinmu@gmail.com, yunlong.xing23@gmail.com
References: <20230801060432.1307717-1-yunlong.xing@unisoc.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20230801060432.1307717-1-yunlong.xing@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2023 03:04, Yunlong Xing wrote:
> [...]

> diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
> index 85aaf0fc6d7d..eb6df190d752 100644
> --- a/fs/pstore/ram_core.c
> +++ b/fs/pstore/ram_core.c
> @@ -519,7 +519,7 @@ static int persistent_ram_post_init(struct persistent_ram_zone *prz, u32 sig,
>  	sig ^= PERSISTENT_RAM_SIG;
>  
>  	if (prz->buffer->sig == sig) {
> -		if (buffer_size(prz) == 0) {
> +		if (buffer_size(prz) == 0 && buffer_start(prz) == 0) {
>  			pr_debug("found existing empty buffer\n");

Thanks for the patch! I'd also adjust the above print statement to
reflect the different paths (empty buffers vs illegal one) and maybe
bump it to pr_info, or even pr_warn(_once?).

What do you all think, makes sense or could we pollute dmesg too much?
Cheers!
