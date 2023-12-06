Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998EC8070A2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378441AbjLFNMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378432AbjLFNMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:12:51 -0500
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008911A5;
        Wed,  6 Dec 2023 05:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=vxtmr3/Bwam30pObqH1YX57aCpkWmHrysVP1c64/fRo=; b=V1tRkFcXtqHcFzkrirDzwuGS5g
        X53OZxy+/kYcGkilHA7nhcpH0OwF5wEKrM6Gud6EbyVfqYto9SNxUtxXl9aWuFKLMbXVz0/0/3VGm
        XwY1z5eu1HH+9GOUwBxDzQxG4Jcpxp3/vxi1z7cV8WqlvawLjFsJDVUe1sCRNxMyYj8hTLE5aUc4j
        irPuSPiKo/xZJLRwjvc18BRIxm1ZBik9Le9l6EFQQgIGQzkgU85H70Fz7OJHsJTPCDrJHSD4bbY7Z
        QpCUbO6dsVRUyeVvVXL9URvDP2D2GcXXOYWT/rmnoTi5+zrT89COJgAFNfRF3SZAU3rFPaPobBsXn
        m6nHfwABby6FbYLVc5bxW3LVXXKASP99v9qkWeIKvW0CxS7Og7aMmZJmKTkE35IHww86HqkibC2Nr
        aEheYq6uqS3gsunD4XdL/SydAt3J01K7N06/VMueWHbiGKpM/YTkEPbwEl29Pi9IPQYXaMF/Dphun
        Ca5goSHTTYhgwvfxhDkouc6ZX8rjWPFCcLW+v3m/xrUJ3CDEsWgdRhZkSGlBvtnROrpF3Q0Y2Jv6E
        ztbPYsOG0fXxTjMagx1EmWLzjAz12RX+mx0zZXBvVonoRbxXmycH5xqn44/MQZqrAaXSmGBzS9x3l
        vkfO4oEi0eEc2VULzzO7wDO66eUQLoYcFl0cmWHd8=;
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
Subject: Re: [PATCH v3] net: 9p: avoid freeing uninit memory in p9pdu_vreadf
Date:   Wed, 06 Dec 2023 14:12:37 +0100
Message-ID: <10981267.HhOBSzzNiN@silver>
In-Reply-To: <20231205180523.11318-1-pchelkin@ispras.ru>
References: <20231205180523.11318-1-pchelkin@ispras.ru>
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

On Tuesday, December 5, 2023 7:05:22 PM CET Fedor Pchelkin wrote:
> If some of p9pdu_readf() calls inside case 'T' in p9pdu_vreadf() fails,
> the error path is not handled properly. *wnames or members of *wnames
> array may be left uninitialized and invalidly freed.
> 
> In order not to complicate the code with array index processing, fix the
> problem with initializing *wnames to NULL in beginning of case 'T' and
> using kcalloc() to allocate and initialize the array. For assurance,
> nullify the failing *wnames element (the callee handles that already -
> e.g. see 's' case).
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
> 
>  net/9p/protocol.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/net/9p/protocol.c b/net/9p/protocol.c
> index 4e3a2a1ffcb3..7067fb49d713 100644
> --- a/net/9p/protocol.c
> +++ b/net/9p/protocol.c
> @@ -394,13 +394,14 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
>  				uint16_t *nwname = va_arg(ap, uint16_t *);
>  				char ***wnames = va_arg(ap, char ***);
>  
> +				*wnames = NULL;
> +
>  				errcode = p9pdu_readf(pdu, proto_version,
>  								"w", nwname);
>  				if (!errcode) {
>  					*wnames =
> -					    kmalloc_array(*nwname,
> -							  sizeof(char *),
> -							  GFP_NOFS);
> +					    kcalloc(*nwname, sizeof(char *),
> +						    GFP_NOFS);

Context of this code is transmitting directory entries, e.g. thousands of
array elements. So this would always introduce performance costs. The error
cases this patch addresses should happen rather rarely BTW.

Another option (instead of clearing the entire array) would be just setting
the last entry in the array to NULL, and the loop freeing the elements would
stop at the first NULL entry. That way you don't have to worry about carrying
`i` along and `i` being correctly intitalized. Would require array size +1
though.

In general I agree that this code section calls out to be simplified, but I
doubt that clearing the entire array is the best way to go here.

>  					if (!*wnames)
>  						errcode = -ENOMEM;
>  				}
> @@ -414,8 +415,10 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
>  								proto_version,
>  								"s",
>  								&(*wnames)[i]);
> -						if (errcode)
> +						if (errcode) {
> +							(*wnames)[i] = NULL;
>  							break;
> +						}
>  					}
>  				}
>  
> @@ -425,9 +428,9 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
>  
>  						for (i = 0; i < *nwname; i++)
>  							kfree((*wnames)[i]);
> +						kfree(*wnames);
> +						*wnames = NULL;
>  					}
> -					kfree(*wnames);
> -					*wnames = NULL;
>  				}
>  			}
>  			break;
> 




