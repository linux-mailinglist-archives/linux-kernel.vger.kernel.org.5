Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714AA7D8211
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 13:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344845AbjJZLyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 07:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344851AbjJZLyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 07:54:22 -0400
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EB61B3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 04:54:19 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 3A5D7C025; Thu, 26 Oct 2023 13:54:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1698321258; bh=ee0LYBUjIFZ+7KVLOmz33ifp2D3uBc4odSfidsaynyY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dobSHw5fXqoNtWFULH+zH44DBHcmqIJ5U6QRE7a8oqB7Zjy2v8HSieUwM3ongq4YK
         tajjyQVHmAuIWz2I+m3SVmoFyCkQ9P+viJ1KFL4cC6G9753r/eVZZwxI2B4jSiw8OB
         7RLCmJij8cj5AU6ysa3DePs1FnSajBhgs6xuxt/T6PXFMKhTlK0vK8YvHSDFzbzsXp
         MdXb3EA+jz5fifAtXsHNgzMmEgQvLav0zD8QGH8rqbItxjKWz/wpLzxwjHbEufPcW/
         35UvUvsElpaGk3ApjItyJIQWhLozn1iJ8mnZ/4KzmBpG9W8VuLjY7hI6g3dAnK1Rqs
         ohPynPrJHaGEw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
Received: from gaia (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id E70DCC01C;
        Thu, 26 Oct 2023 13:54:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1698321257; bh=ee0LYBUjIFZ+7KVLOmz33ifp2D3uBc4odSfidsaynyY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pIFlgNGB79E3zgP+Of/xeL7Me4MOjTBeWoN5+cvcg1kp0/7dnTps/n2eOzdCuBPH9
         zt+3n8/k/az/otUb1DHRGxNwj5UhKM92Gu0wbhhlRWdc48tE7xkEKYNDGy6MVUJ5/D
         m8/B/2a9prVBcUN7lX3FH9tcv5TBArfJ1YNs8BEqRtdgljDcuUKlbZnSVtlRinyOHP
         dz87ZCjVWM8ufjJ+vnqgCxwjDiCDcRp7knn1UTd9hn5VFsgrMfIxW6f7tgvJJBPBfb
         DriZq3/3rbo32PKQ55zeXH+v4J40BzFv3DuAiHI/IGYO1YwDp6RoNLulO5GXDYVLp7
         3M2/Uxgzkr+Xg==
Received: from localhost (gaia [local])
        by gaia (OpenSMTPD) with ESMTPA id 272289d4;
        Thu, 26 Oct 2023 11:54:10 +0000 (UTC)
Date:   Thu, 26 Oct 2023 20:53:55 +0900
From:   asmadeus@codewreck.org
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jvrao@linux.vnet.ibm.com, v9fs@lists.linux.dev,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: 9p: fix possible memory leak in p9_check_errors()
Message-ID: <ZTpTU8-1zn_P22QX@codewreck.org>
References: <20231026092351.30572-1-hbh25y@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231026092351.30572-1-hbh25y@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hangyu Hua wrote on Thu, Oct 26, 2023 at 05:23:51PM +0800:
> When p9pdu_readf is called with "s?d" attribute, it allocates a pointer
> that will store a string. But when p9pdu_readf() fails while handling "d"
> then this pointer will not be freed in p9_check_errors.

Right, that sounds correct to me.

Out of curiosity how did you notice this? The leak shouldn't happen with
any valid server.

This cannot break anything so I'll push this to -next tomorrow and
submit to Linus next week

> Fixes: ca41bb3e21d7 ("[net/9p] Handle Zero Copy TREAD/RERROR case in !dotl case.")

This commit moves this code a bit, but the p9pdu_readf call predates
it -- in this case the Fixes tag is probably not useful; this affects
all maintained kernels.

> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---
>  net/9p/client.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/net/9p/client.c b/net/9p/client.c
> index 86bbc7147fc1..6c7cd765b714 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -540,12 +540,15 @@ static int p9_check_errors(struct p9_client *c, struct p9_req_t *req)
>  		return 0;
>  
>  	if (!p9_is_proto_dotl(c)) {
> -		char *ename;
> +		char *ename = NULL;
>  
>  		err = p9pdu_readf(&req->rc, c->proto_version, "s?d",
>  				  &ename, &ecode);
> -		if (err)
> +		if (err) {
> +			if (ename != NULL)
> +				kfree(ename);

Don't check for NULL before kfree - kfree does it.
If that's the only remark you get I can fix it when applying the commit
on my side.


>  			goto out_err;
> +		}
>  
>  		if (p9_is_proto_dotu(c) && ecode < 512)
>  			err = -ecode;

-- 
Dominique Martinet | Asmadeus
