Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC4880565D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345489AbjLENsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbjLENsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:48:00 -0500
X-Greylist: delayed 1792 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Dec 2023 05:48:06 PST
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05412A8;
        Tue,  5 Dec 2023 05:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=MlRWkhJV0qSH5U01QGui4oeTrYqJubGpGLDBsWklraw=; b=piEwCZuXLbbZffbD9RGKdATv2V
        lX7W3X2jTvFhBOMIx1Lzdjkem4jhtNxBBF9vhEi0jsinJi/xaTTSiiWZxCNl4SN99ZNY2E/Vd/dv2
        XmMq34fW6blMK64yeTu1vzV5NqxUI5phRButXMNKebRmcLjeLjgC1edbxzdSxuvBI3BuLdXuTK6PZ
        q7BLzVO7nKzn9aTw8RHoxw3mbFUGJ3i61lZUKK+4rkr+23lQV4J9bc9vG8dtYHAt76BDcCrZ+5Gep
        v6KXGWhHrb/LP2M9VThSPFYFvXNHy1zzihNVOwIybbi9HBZKbFXFFciiQQm3U+Z2gigQHgSJaqU9O
        Q4KZioqrhI9Lukv9a4nxCHZtrXqXhaJGL+atif60c0igPeAAErevIzaa8e29K1iVljWAMh+sb+gYq
        LtsCDw8b9YFyldvL0yW8mGTSY3lbXlVIXP85jzXZlN2dOguEjnknzBm908I6tNIQ0GayTn5PCKYVg
        E8giISdkklKHaU/xPpeb4tdzBND1+O11KoO9oxUfFhjNGxEAxIeBQmcz73LPgAV7QUSBI1DAVOe5L
        uE+k6iLYnGqHAKeM/MaPVvk+dVIv3m9CHIhYOCZEWHCalsxDB6hkRZ1DIgK3HJK3WIwZcVXJ60bPh
        2Zv/K88X8HOgsRQNivAvtkcv2Ru+Bez6Oq1t1WNDc=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Dominique Martinet <asmadeus@codewreck.org>,
        Fedor Pchelkin <pchelkin@ispras.ru>
Cc:     Fedor Pchelkin <pchelkin@ispras.ru>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, v9fs@lists.linux.dev,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] net: 9p: avoid freeing uninit memory in p9pdu_vreadf
Date:   Tue, 05 Dec 2023 13:29:49 +0100
Message-ID: <1741521.OAD31uVnNo@silver>
In-Reply-To: <20231205091952.24754-1-pchelkin@ispras.ru>
References: <20231205091952.24754-1-pchelkin@ispras.ru>
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

On Tuesday, December 5, 2023 10:19:50 AM CET Fedor Pchelkin wrote:
> If an error occurs while processing an array of strings in p9pdu_vreadf
> then uninitialized members of *wnames array are freed.
> 
> Fix this by iterating over only lower indices of the array. Also handle
> possible uninit *wnames usage if first p9pdu_readf() call inside 'T' case
> fails.
> 
> Found by Linux Verification Center (linuxtesting.org).
> 
> Fixes: ace51c4dd2f9 ("9p: add new protocol support code")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
> v2: I've missed that *wnames can also be left uninitialized. Please
> ignore the patch v1. As an answer to Dominique's comment: my
> organization marks this statement in all commits.
> 
>  net/9p/protocol.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/net/9p/protocol.c b/net/9p/protocol.c
> index 4e3a2a1ffcb3..043b621f8b84 100644
> --- a/net/9p/protocol.c
> +++ b/net/9p/protocol.c
> @@ -393,6 +393,8 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
>  		case 'T':{
>  				uint16_t *nwname = va_arg(ap, uint16_t *);
>  				char ***wnames = va_arg(ap, char ***);
> +				int i;
> +				*wnames = NULL;

Consider also initializing `int i = 0;` here. Because ...

>  
>  				errcode = p9pdu_readf(pdu, proto_version,
>  								"w", nwname);
> @@ -406,8 +408,6 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
>  				}
>  
>  				if (!errcode) {
> -					int i;
> -
>  					for (i = 0; i < *nwname; i++) {

... this block that initializes `i` is conditional. I mean it does work right
now as-is, because ...

>  						errcode =
>  						    p9pdu_readf(pdu,
> @@ -421,13 +421,11 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
>  
>  				if (errcode) {
>  					if (*wnames) {
> -						int i;
> -
> -						for (i = 0; i < *nwname; i++)
> +						while (--i >= 0)
>  							kfree((*wnames)[i]);
> +						kfree(*wnames);
> +						*wnames = NULL;
>  					}

... this is wrapped into `if (*wnames) {` and you initialized *wnames with
NULL, but it just feels like a potential future trap somehow.

Anyway, at least it looks like correct behaviour (ATM), so:

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

> -					kfree(*wnames);
> -					*wnames = NULL;
>  				}
>  			}
>  			break;
> 


