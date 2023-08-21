Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143DA78241D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 09:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbjHUHEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 03:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbjHUHEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 03:04:42 -0400
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D0BAF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 00:04:41 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id XyxoqoQ3VuWDMXyxoqWxoR; Mon, 21 Aug 2023 09:04:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1692601479;
        bh=omj5Cu2WnrhUZEiagPndlyI+KCEZ2ygnsWdsBFXoZkU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=FaIiZCnPi+DVyWDLrR4bakN/8a69A89ZzRDO20POhotfGmeAUjpz4tNHBO6oYCjsh
         DbsInWWbowgaYYSU3i1+E4Hy5I5mqoEmD1qVvqoxIZSTpMKxU18Y/FgGM+Pvqc0Hh0
         T4O5RyOK1Sbmxr5knc/0NC0xUNLmfYv7zMa9KMG/hkRMXXzRQnA/tyn6Fz4R2Jj+RA
         V6b6/2CC/yj9OzG2XZnjWJC9d7imqBcfvhOu7C/IsLrTXEofczwErycukQ6b3Y/ExA
         R3vXVhlrawUvILzR1MlBs69kNOzV8qBmaYy2sGKdCWYmovfkrTah8O/we/IrEUwZrN
         RWo+2jpJpQJXQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 21 Aug 2023 09:04:39 +0200
X-ME-IP: 86.243.2.178
Message-ID: <38503377-ec27-09dd-dc6b-836a9ac0a5df@wanadoo.fr>
Date:   Mon, 21 Aug 2023 09:04:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/ast: Avoid possible NULL dereference
Content-Language: fr
To:     Su Hui <suhui@nfschina.com>, airlied@redhat.com,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch
Cc:     eich@suse.de, tiwai@suse.de, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20230821062159.198691-1-suhui@nfschina.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230821062159.198691-1-suhui@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 21/08/2023 à 08:22, Su Hui a écrit :
> smatch error:
> drivers/gpu/drm/ast/ast_dp501.c:227 ast_launch_m68k() error:
> we previously assumed 'ast->dp501_fw' could be null (see line 223)
> 
> when "!ast->dp501_fw" and "ast_load_dp501_microcode(dev) >= 0" is true,
> there will be a NULL dereference of 'ast->dp501_fw'.
> 
> Fixes: 12f8030e05c6 ("drm/ast: Actually load DP501 firmware when required")
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>   drivers/gpu/drm/ast/ast_dp501.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ast/ast_dp501.c b/drivers/gpu/drm/ast/ast_dp501.c
> index 1bc35a992369..d9f3a0786a6f 100644
> --- a/drivers/gpu/drm/ast/ast_dp501.c
> +++ b/drivers/gpu/drm/ast/ast_dp501.c
> @@ -224,8 +224,10 @@ static bool ast_launch_m68k(struct drm_device *dev)
>   			    ast_load_dp501_microcode(dev) < 0)
>   				return false;
>   
> -			fw_addr = (u8 *)ast->dp501_fw->data;
> -			len = ast->dp501_fw->size;
> +			if (ast->dp501_fw) {
> +				fw_addr = (u8 *)ast->dp501_fw->data;
> +				len = ast->dp501_fw->size;
> +			}
>   		}
>   		/* Get BootAddress */
>   		ast_moutdwm(ast, 0x1e6e2000, 0x1688a8a8);

Hi,

this looks like a false positive.

If "!ast->dp501_fw", and ast_load_dp501_microcode()>=0, then 
ast_load_dp501_microcode() will set a valid value in ast->dp501_fw.

CJ
