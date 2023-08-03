Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51C276F0D0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 19:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbjHCRnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 13:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235232AbjHCRnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 13:43:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6776A139;
        Thu,  3 Aug 2023 10:43:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0541161E57;
        Thu,  3 Aug 2023 17:43:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE62CC433C8;
        Thu,  3 Aug 2023 17:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691084583;
        bh=TXt73pdbEsVjNXx498XOQs5hPMVwlvDMtseT7OsCBTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HIYMoE504Ia2M5zkEN+fdiA4gv4woltf3Opl2nbyoWra7Aa/MTzEvymq3lg2Puedq
         yVW6V4wWznxVdhWnv+mtGNdRSbKyw1DONbXDh1j6BXWsfn2b300r/jAceMd9jbZmt0
         NcMYtm5d7V/Xi1czCcdKMkLFRc5xJt5zReHDCZbzF6qcBKyFH31zHS9ob27EeR4KC4
         pf7nHlUGKJNBi0jCOXsw6vDk2ftw7aMVv7zGAxKu5K0zJuaeA60802dmu5TKXMH5p5
         NNf7aSNdsm8K8a1T7SOrAerdxArv27H/QbnSilSot86JWPSTcbJpcQwugTBdScjO9T
         2QpkUgfWVBQnA==
Date:   Thu, 3 Aug 2023 19:42:58 +0200
From:   Simon Horman <horms@kernel.org>
To:     Guangguan Wang <guangguan.wang@linux.alibaba.com>
Cc:     wenjia@linux.ibm.com, jaka@linux.ibm.com, kgraul@linux.ibm.com,
        tonylu@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 1/6] net/smc: support smc release version
 negotiation in clc handshake
Message-ID: <ZMvnIszqS4ZpkYHj@kernel.org>
References: <20230803132422.6280-1-guangguan.wang@linux.alibaba.com>
 <20230803132422.6280-2-guangguan.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803132422.6280-2-guangguan.wang@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 09:24:17PM +0800, Guangguan Wang wrote:

...

Hi Guangguan Wang,

> @@ -1063,7 +1063,7 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
>  				memcpy(clc_v2->r1.eid, eid, SMC_MAX_EID_LEN);
>  			len = SMCR_CLC_ACCEPT_CONFIRM_LEN_V2;
>  			if (first_contact) {
> -				smc_clc_fill_fce(&fce, &len);
> +				smc_clc_fill_fce(&fce, &len, ini->release_ver);

Here ini is dereferenced...


>  				fce.v2_direct = !link->lgr->uses_gateway;
>  				memset(&gle, 0, sizeof(gle));
>  				if (ini && clc->hdr.type == SMC_CLC_CONFIRM) {

... but here it is assumed that ini may be NULL.

This seems inconsistent.

As flagged by Smatch.

...

-- 
pw-bot: changes-requested
