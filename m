Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B85752414
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 15:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbjGMNll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 09:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235089AbjGMNlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:41:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D615E68;
        Thu, 13 Jul 2023 06:41:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 091F91FD83;
        Thu, 13 Jul 2023 13:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689255694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JzDdUcKCbfeW+apZkpwtzY2Mpd+KMrda9/Ivf/GReMY=;
        b=UkrVZ1pVeHGxKtLZ9oRTE5PPzDwzEeU3AQUyNQx394I/oSNpdyYvdkdmsYUemWhcAmgOQe
        xhqTBtJoB+dE2QJvHtIQOdX1uAmu20DZpbY6/Djdyj7HHNPoOW7bYarOCsZWYqr4XSeDvq
        ZAL+JbCSjFn7hp43e6C54oZ/CdRLu7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689255694;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JzDdUcKCbfeW+apZkpwtzY2Mpd+KMrda9/Ivf/GReMY=;
        b=zxK7vxImr6j6qtaKchTkrfUabyyRYu9fPbauHHd5W+gIuhVblpjnO9jNKkoLz/Sm4Ac/IH
        4CnDWHvdK0xdP8Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5AAED13489;
        Thu, 13 Jul 2023 13:41:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YuW2Eg3/r2R7UgAAMHmgww
        (envelope-from <dkirjanov@suse.de>); Thu, 13 Jul 2023 13:41:33 +0000
Message-ID: <6a4cf06a-7646-c325-581c-7113202ee21a@suse.de>
Date:   Thu, 13 Jul 2023 16:41:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1] net: lan966x: fix parameter check in two functions
Content-Language: en-US
To:     Minjie Du <duminjie@vivo.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        "maintainer:MICROCHIP LAN966X ETHERNET DRIVER" 
        <UNGLinuxDriver@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        "open list:MICROCHIP LAN966X ETHERNET DRIVER" 
        <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc:     opensource.kernel@vivo.com
References: <20230713085908.12113-1-duminjie@vivo.com>
From:   Denis Kirjanov <dkirjanov@suse.de>
In-Reply-To: <20230713085908.12113-1-duminjie@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/13/23 11:59, Minjie Du wrote:
> Make IS_ERR_OR_NULL() judge the vcap_get_rule() function return
> in lan966x_ptp_add_trap() and lan966x_ptp_del_trap().

Fixes: 72df3489fb103 ("net: lan966x: Add ptp trap rules")
> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
>  drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c b/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
> index 266a21a2d..59dd14247 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
> @@ -59,7 +59,7 @@ static int lan966x_ptp_add_trap(struct lan966x_port *port,
>  	int err;
>  
>  	vrule = vcap_get_rule(lan966x->vcap_ctrl, rule_id);
> -	if (vrule) {
> +	if (!IS_ERR_OR_NULL(vrule)) {
>  		u32 value, mask;
>  
>  		/* Just modify the ingress port mask and exit */
> @@ -106,7 +106,7 @@ static int lan966x_ptp_del_trap(struct lan966x_port *port,
>  	int err;
>  
>  	vrule = vcap_get_rule(lan966x->vcap_ctrl, rule_id);
> -	if (!vrule)
> +	if (IS_ERR_OR_NULL(vrule))
>  		return -EEXIST;
>  
>  	vcap_rule_get_key_u32(vrule, VCAP_KF_IF_IGR_PORT_MASK, &value, &mask);
