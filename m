Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6538000EF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 02:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjLABZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 20:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjLABZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 20:25:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA6810F3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 17:25:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C4FC433C8;
        Fri,  1 Dec 2023 01:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701393922;
        bh=pA9obsUKkI3gLtmE5e/MIgsUKhFNUSwkoGABXxOXVu4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qXgn6AmBfQ/Zd6RVRJTPsZAbwENL/P5ChNB5zVXW0us7mhGHTnTM9sNNTsCC9XQxN
         L1uGh4x2n2RNCNp1RMfq9bjsLjHILqLsFEDBfDoRuu5RbUweF3Qn4DCOZPuUtfOC/W
         cgLl/hy6IQQTBfTywH4xH6a7Ijlk+gb4RALHriraRg/4+zauwSA3WB9jIBHc6UvEMK
         pve1ll983tzlpGE+05zeqz0RtkS54rsaP4JSXJoyKf4BX+eaGsmizKzq1dj0/9ks0B
         AJIe6Qexsgf9KACjBa6OjE70PNGpb1hiWU6Y0mWHs9fPVNfTs8PGu3yaeu8pMQBDFs
         wTU9Lq7vBbWSw==
Date:   Thu, 30 Nov 2023 17:25:20 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     kernel test robot <lkp@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Michael Walle <mwalle@kernel.org>,
        Max Schulze <max.schulze@online.de>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] netlink: Return unsigned value for nla_len()
Message-ID: <20231130172520.5a56ae50@kernel.org>
In-Reply-To: <20231130200058.work.520-kees@kernel.org>
References: <20231130200058.work.520-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2023 12:01:01 -0800 Kees Cook wrote:
> This has the additional benefit of being defensive in the face of nlattr
> corruption or logic errors (i.e. nla_len being set smaller than
> NLA_HDRLEN).

As Johannes predicted I'd rather not :(

The callers should put the nlattr thru nla_ok() during validation
(nla_validate()), or walking (nla_for_each_* call nla_ok()).

> -static inline int nla_len(const struct nlattr *nla)
> +static inline u16 nla_len(const struct nlattr *nla)
>  {
> -	return nla->nla_len - NLA_HDRLEN;
> +	return nla->nla_len > NLA_HDRLEN ? nla->nla_len - NLA_HDRLEN : 0;
>  }

Note the the NLA_HDRLEN is the length of struct nlattr.
I mean of the @nla object that gets passed in as argument here.
So accepting that nla->nla_len may be < NLA_HDRLEN means
that we are okay with dereferencing a truncated object...

We can consider making the return unsinged without the condition maybe?
-- 
pw-bot: cr
