Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1183F804D37
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjLEJHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjLEJHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:07:45 -0500
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A5B10F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:07:49 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 32467C01C; Tue,  5 Dec 2023 10:07:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1701767268; bh=Zcza2koUNlQSollLV/Bg+N9kW0zXA9vz++qJ4d4v5fY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PuHhqmIq4di8uyLbStLheCAmnT2OqjGGfT0vH774lVgOF817jT/ttbkkT0GQP+szo
         4BVrLZyHEK0f2hlA3tKEzdGUhMO9bt01HFIJ2qHcjcAJf03hkZNwdA2ZgWYHojOhBU
         DIwlIpxw/tyTXbNZ2DpRdgY52brbwMOiv8emPejdXzVayHrhglZq9xa/cY52mMLzCK
         jHFk65ERMrDG7wGCYdEALG5fDdB1dkeb7SWfwIoYtot2JsApyejh937yVUDS6oE+xX
         zGObTQweyErTA4hiXfiqxTJZHAN2yQr6b0oE0tqPzE4IEm+5L5lY8Be4gzujA34c1Z
         tNhZuAWWHN+TA==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from gaia (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 586B3C009;
        Tue,  5 Dec 2023 10:07:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1701767258; bh=Zcza2koUNlQSollLV/Bg+N9kW0zXA9vz++qJ4d4v5fY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PLtCjPBoN6k82Qh/P8T2TOhDgZvxpkF4U4kHR6pFz9b9ScBcRsgHpeLIzbA4YrCrS
         ihetjFpGVvB0wwUEnrkRTotWZu8oWwiYfSGl1AtcsBOC+07aYbbaAsUyIEvfTVAUhQ
         NQzWpdnEYr/f0V2iOmmagyCddECvEK7zofcknbkjksaBc/YwcVbZ5goUZCH4b7joia
         hue6N17SNSCzzxEGyGEm58HBOXVoLYmp4eJVrOEjC4yt0vtQElwjV0Z2nJ6uBU+Uj+
         AvJHZAyjctSbABrVdFp0KDUhFOeUlqs0GZbC3QQOaAmZqNIZUjPF2eUSaxibK0pWN8
         hbv5Hp2nRmncQ==
Received: from localhost (gaia [local])
        by gaia (OpenSMTPD) with ESMTPA id 0564bc80;
        Tue, 5 Dec 2023 09:07:30 +0000 (UTC)
Date:   Tue, 5 Dec 2023 18:07:15 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Fedor Pchelkin <pchelkin@ispras.ru>
Cc:     Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, v9fs@lists.linux.dev,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] net: 9p: avoid freeing uninit memory in p9pdu_vreadf
Message-ID: <ZW7oQ1KPWTbiGSzL@codewreck.org>
References: <20231205080524.6635-1-pchelkin@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231205080524.6635-1-pchelkin@ispras.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fedor Pchelkin wrote on Tue, Dec 05, 2023 at 11:05:22AM +0300:
> If an error occurs while processing an array of strings in p9pdu_vreadf
> then uninitialized members of *wnames array are freed.
> 
> Fix this by iterating over only lower indices of the array.
> 
> Found by Linux Verification Center (linuxtesting.org).

You might want to mark that as Reported-by: somehow instead of a free
form comment

> 
> Fixes: ace51c4dd2f9 ("9p: add new protocol support code")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

That aside, it looks good to me -- good find!
I'll push this to Linus with the other pending fix we have next week

> ---
>  net/9p/protocol.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/net/9p/protocol.c b/net/9p/protocol.c
> index 4e3a2a1ffcb3..d33387e74a66 100644
> --- a/net/9p/protocol.c
> +++ b/net/9p/protocol.c
> @@ -393,6 +393,7 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
>  		case 'T':{
>  				uint16_t *nwname = va_arg(ap, uint16_t *);
>  				char ***wnames = va_arg(ap, char ***);
> +				int i;
>  
>  				errcode = p9pdu_readf(pdu, proto_version,
>  								"w", nwname);
> @@ -406,8 +407,6 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
>  				}
>  
>  				if (!errcode) {
> -					int i;
> -
>  					for (i = 0; i < *nwname; i++) {
>  						errcode =
>  						    p9pdu_readf(pdu,
> @@ -421,9 +420,7 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
>  
>  				if (errcode) {
>  					if (*wnames) {
> -						int i;
> -
> -						for (i = 0; i < *nwname; i++)
> +						while (--i >= 0)
>  							kfree((*wnames)[i]);
>  					}
>  					kfree(*wnames);

-- 
Dominique Martinet | Asmadeus
