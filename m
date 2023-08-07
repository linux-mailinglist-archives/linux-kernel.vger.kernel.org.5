Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8295B7728CA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjHGPJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjHGPJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:09:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65933198D;
        Mon,  7 Aug 2023 08:09:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68AAE61DB2;
        Mon,  7 Aug 2023 15:08:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE9EC433C7;
        Mon,  7 Aug 2023 15:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691420936;
        bh=3X1Vxk3O7jBMOUlDxSVXoV/71wfwQb0HWcjFUwMy5Kk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aoFH7P/uXdhCKxI8ajWHuFOpMCeQRfjNCZMw9N8cD40C7ddzxpedWW4MKBNFRjcBq
         2XslMjeGyEHH1nM4CyO+2wtPdFrQcag0efOdo2s8cP1w7hDvYgvKmAEAkfwWuceDu/
         JCkhJOCV9Oauol5guq9lKMBZoaOyqgsyaTmRlKHgm/bomio+3HGZV0gzAjKJlhgVlG
         C3WtIfy4DLvsAG70e/a72ekV2TpUy3+Yj5nv4JOnLkbRZpZIpvms6l6I/qQPBN9EO0
         9km67WDRBjsOQWZpLNeg4P4TYqucucJJSarnINgtl3Ym93mmOAxm6VnVgD+tpVGtff
         ZK0v+sAE3LqoQ==
Date:   Mon, 7 Aug 2023 17:08:51 +0200
From:   Simon Horman <horms@kernel.org>
To:     Guangguan Wang <guangguan.wang@linux.alibaba.com>
Cc:     wenjia@linux.ibm.com, jaka@linux.ibm.com, kgraul@linux.ibm.com,
        tonylu@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        alibuda@linux.alibaba.com, guwen@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 net-next 5/6] net/smc: support max links per lgr
 negotiation in clc handshake
Message-ID: <ZNEJA1E6ouOuaAcc@vergenet.net>
References: <20230807062720.20555-1-guangguan.wang@linux.alibaba.com>
 <20230807062720.20555-6-guangguan.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807062720.20555-6-guangguan.wang@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 02:27:19PM +0800, Guangguan Wang wrote:

...

> diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c

...

> @@ -1414,6 +1420,9 @@ int smc_llc_srv_add_link(struct smc_link *link,
>  		goto out;
>  	}
>  
> +	if (lgr->type == SMC_LGR_SINGLE && lgr->max_links <= 1)

Hi Guangguan Wang,

The function will return rc.
Should it be set to an error value here?

Flagged by Smatch.

> +		goto out;
> +
>  	/* ignore client add link recommendation, start new flow */
>  	ini->vlan_id = lgr->vlan_id;
>  	if (lgr->smc_version == SMC_V2) {
> -- 
> 2.24.3 (Apple Git-128)
> 
