Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699257CBA9C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 08:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbjJQGMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 02:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234399AbjJQGMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 02:12:21 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4A4B6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 23:12:19 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6C2A468BFE; Tue, 17 Oct 2023 08:12:15 +0200 (CEST)
Date:   Tue, 17 Oct 2023 08:12:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mark O'Donovan <shiftee@posteo.net>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, hch@lst.de, axboe@kernel.dk, kbusch@kernel.org,
        hare@suse.de, Akash Appaiah <Akash.Appaiah@dell.com>
Subject: Re: [PATCH v3 2/3] nvme-auth: use transformed key size to create
 resp
Message-ID: <20231017061215.GB8454@lst.de>
References: <20231016225857.3085234-1-shiftee@posteo.net> <20231016225857.3085234-3-shiftee@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016225857.3085234-3-shiftee@posteo.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +struct nvme_dhchap_key *nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn)

Please avoid the overly long line.

> +		key_len = sizeof(*key) + key->len;

struct_size again.  And maybe add a helper to calculate the size for
a key instea dof duplicating it.

> +		transformed_key = kmemdup(key, key_len, GFP_KERNEL);
>  		return transformed_key ? transformed_key : ERR_PTR(-ENOMEM);

Nit, but I find the ? : syntax very confusing when not used in things
like macros or argument lines.  A 

		if (!transformed_key)
			return ERR_PTR(-ENOMEM);
 		return transformed_key;

is a bit longer, but much easier to read.

>  	}
>  	hmac_name = nvme_auth_hmac_name(key->hash);
> @@ -257,7 +258,7 @@ u8 *nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn)
>  
>  	key_tfm = crypto_alloc_shash(hmac_name, 0, 0);
>  	if (IS_ERR(key_tfm))
> -		return (u8 *)key_tfm;
> +		return (void *)key_tfm;

This should (already in the original code) use ERR_CAST instead.

> +	transformed_key = nvme_auth_transform_key(ctrl->host_key, ctrl->hostnqn);

Please avoid the overly long line here as well.

> +struct nvme_dhchap_key *nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn);

... and here.

