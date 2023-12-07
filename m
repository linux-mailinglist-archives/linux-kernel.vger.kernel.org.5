Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F71180887D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbjLGMyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjLGMyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:54:15 -0500
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838FCD6D;
        Thu,  7 Dec 2023 04:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=xaCvAzlwzR9Hokmynfu7A4/6oLv+b96ic63xDkUsACk=; b=EEgZ+CgszC5pK4/GcUfCvYqH04
        GLu1k/eCfcwojQHQ5el6pDSztUvnFz19Bl4B2/S8XTbmFiANjFkROQg0dFUlw/NCGnX6MiqL/cvho
        AB0dPPlwnfe0bwKWgoWkf3FXVQcAZJaTf0OtuMbZxN4DH+978qnPwc8rZ/yZz2U8FZf3f5zp5/nR1
        /e/q06i2kmDqEveKXy6S6DcUP7Xgb77s/B5y9AZjjgHPWsR+L2o0LYLxAdIEXJFhle2FemDi0yWy1
        0sgqlFw2Eck9usYCTda4MIQPQ6gO4KN5DYfQ4u54ZG2pDBfGxhjrmW/UCNtlAs37a63+MHcfWvsrZ
        9h0RGIAgpiD6l0Yf0OyRLhOKreubHCTgeFfmiqM9QyjQgKY2Ck3XY3AXNwUFoxMrf0bgWWps3KOPq
        EXhaWCwetQmq7zhqlDMndBxh4MjDkjMSc+/+OjAZFmqGcUBqYttE8L7zVKNydG81AjqeEaMwcjOoX
        DASbpuccxYgxTCA8YPjQKjImXNSk53F8DrMQkrMSo4fhNCeh5ZxzRimcEy+oCTqziTm9Jdv/zX8E4
        oapJatLZiXWmQ80xIHNG11D02ziTpiahg61UjfZ6iNF/TXc260fF0beo7BcsT+G6g5l35qcVf1hnb
        Pn5UT8uk+aLvs2SmkEbRyRDU7kyAEsOIvr8XWcVLw=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Dominique Martinet <asmadeus@codewreck.org>,
        Fedor Pchelkin <pchelkin@ispras.ru>
Cc:     Fedor Pchelkin <pchelkin@ispras.ru>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, v9fs@lists.linux.dev,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH v4] net: 9p: avoid freeing uninit memory in p9pdu_vreadf
Date:   Thu, 07 Dec 2023 13:54:02 +0100
Message-ID: <1808202.Umia7laAZq@silver>
In-Reply-To: <20231206200913.16135-1-pchelkin@ispras.ru>
References: <20231206200913.16135-1-pchelkin@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, December 6, 2023 9:09:13 PM CET Fedor Pchelkin wrote:
> If some of p9pdu_readf() calls inside case 'T' in p9pdu_vreadf() fails,
> the error path is not handled properly. *wnames or members of *wnames
> array may be left uninitialized and invalidly freed.
> 
> Initialize *wnames to NULL in beginning of case 'T'. Initialize the first
> *wnames array element to NULL and nullify the failing *wnames element so
> that the error path freeing loop stops on the first NULL element and
> doesn't proceed further.
> 
> Found by Linux Verification Center (linuxtesting.org).
> 
> Fixes: ace51c4dd2f9 ("9p: add new protocol support code")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
> v2: I've missed that *wnames can also be left uninitialized. Please
> ignore the patch v1. As an answer to Dominique's comment: my
> organization marks this statement in all commits.
> v3: Simplify the patch by using kcalloc() instead of array indices
> manipulation per Christian Schoenebeck's remark. Update the commit
> message accordingly.
> v4: Per Christian's suggestion, apply another strategy: mark failing
> array element as NULL and move in the freeing loop until it is found.
> Update the commit message accordingly. If v4 is more appropriate than the
> version at
> https://github.com/martinetd/linux/commit/69cc23eb3a0b79538e9b5face200c4cd5cd32ae0
> then please use it, otherwise, I don't think we can provide more
> convenient solution here than the one already queued at github.
> 
>  net/9p/protocol.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/net/9p/protocol.c b/net/9p/protocol.c
> index 4e3a2a1ffcb3..0e6603b1ec90 100644
> --- a/net/9p/protocol.c
> +++ b/net/9p/protocol.c
> @@ -394,6 +394,8 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
>  				uint16_t *nwname = va_arg(ap, uint16_t *);
>  				char ***wnames = va_arg(ap, char ***);
>  
> +				*wnames = NULL;
> +
>  				errcode = p9pdu_readf(pdu, proto_version,
>  								"w", nwname);
>  				if (!errcode) {
> @@ -403,6 +405,8 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
>  							  GFP_NOFS);
>  					if (!*wnames)
>  						errcode = -ENOMEM;
> +					else
> +						(*wnames)[0] = NULL;
>  				}
>  
>  				if (!errcode) {
> @@ -414,8 +418,10 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
>  								proto_version,
>  								"s",
>  								&(*wnames)[i]);
> -						if (errcode)
> +						if (errcode) {
> +							(*wnames)[i] = NULL;
>  							break;
> +						}

I just checked whether this could create a leak, but it looks clean, so LGTM:

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

Dominique, I would tend to use this v4 instead of v2. What do you think?

>  					}
>  				}
>  
> @@ -423,11 +429,14 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
>  					if (*wnames) {
>  						int i;
>  
> -						for (i = 0; i < *nwname; i++)
> +						for (i = 0; i < *nwname; i++) {
> +							if (!(*wnames)[i])
> +								break;
>  							kfree((*wnames)[i]);
> +						}
> +						kfree(*wnames);
> +						*wnames = NULL;
>  					}
> -					kfree(*wnames);
> -					*wnames = NULL;
>  				}
>  			}
>  			break;
> 


