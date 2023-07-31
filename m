Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53DC76999B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 16:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjGaOf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 10:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbjGaOf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:35:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C5F123;
        Mon, 31 Jul 2023 07:35:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 92780221E0;
        Mon, 31 Jul 2023 14:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1690814123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WNe4swavizqdV55R6wwaZgkXoPj5RhX8v6uZ3GcEnc4=;
        b=DgzSTM0L1Ufxl+X74lXeV446U7HWIvlC5HrpOOkSrLPEq6yoJqFzeNBzwyyC4j8F+JfGnL
        9l5HgKEtMgHGobGOIxmg/SoY2hKDfUWxMj6WAteoULKpdgMvR8Xyjuz0ZG8j9oVctDs9vd
        sJgPpVdr1XlAV7hrS6UA3MKoqcXUl9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1690814123;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WNe4swavizqdV55R6wwaZgkXoPj5RhX8v6uZ3GcEnc4=;
        b=MlhMg9D8BuVbmKp+JlGPDMdK7QZv0idojdX4TldvRofjkbYbd59BXMX3U/T8cyemuyu33N
        HKAef52Q6qNL/zCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 84A61133F7;
        Mon, 31 Jul 2023 14:35:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YJ5XIKvGx2QzWwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 31 Jul 2023 14:35:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 11108A069C; Mon, 31 Jul 2023 16:35:23 +0200 (CEST)
Date:   Mon, 31 Jul 2023 16:35:23 +0200
From:   Jan Kara <jack@suse.cz>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] udf: Fix -Wstringop-overflow warnings
Message-ID: <20230731143523.rfmn6oqob7pofyan@quack3>
References: <ZK7wKS0NgZPfqrZu@work>
 <202307121204.36EF4C1@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202307121204.36EF4C1@keescook>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12-07-23 12:05:34, Kees Cook wrote:
> On Wed, Jul 12, 2023 at 12:25:45PM -0600, Gustavo A. R. Silva wrote:
> > Use unsigned type in call to macro mint_t(). This avoids confusing the
> > compiler about possible negative values that would cause the value in
> > _len_ to wrap around.
> > 
> > Fixes the following -Wstringop-warnings seen when building ARM
> > architecture with allyesconfig (GCC 13):
> > fs/udf/directory.c: In function 'udf_copy_fi':
> > include/linux/fortify-string.h:57:33: warning: '__builtin_memcpy' specified bound between 2147483648 and 4294967295 exceeds maximum object size 2147483647 [-Wstringop-overflow=]
> >    57 | #define __underlying_memcpy     __builtin_memcpy
> >       |                                 ^
> > include/linux/fortify-string.h:648:9: note: in expansion of macro '__underlying_memcpy'
> >   648 |         __underlying_##op(p, q, __fortify_size);                        \
> >       |         ^~~~~~~~~~~~~
> > include/linux/fortify-string.h:693:26: note: in expansion of macro '__fortify_memcpy_chk'
> >   693 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
> >       |                          ^~~~~~~~~~~~~~~~~~~~
> > fs/udf/directory.c:99:9: note: in expansion of macro 'memcpy'
> >    99 |         memcpy(&iter->fi, iter->bh[0]->b_data + off, len);
> >       |         ^~~~~~
> > include/linux/fortify-string.h:57:33: warning: '__builtin_memcpy' specified bound between 2147483648 and 4294967295 exceeds maximum object size 2147483647 [-Wstringop-overflow=]
> >    57 | #define __underlying_memcpy     __builtin_memcpy
> >       |                                 ^
> > include/linux/fortify-string.h:648:9: note: in expansion of macro '__underlying_memcpy'
> >   648 |         __underlying_##op(p, q, __fortify_size);                        \
> >       |         ^~~~~~~~~~~~~
> > include/linux/fortify-string.h:693:26: note: in expansion of macro '__fortify_memcpy_chk'
> >   693 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
> >       |                          ^~~~~~~~~~~~~~~~~~~~
> > fs/udf/directory.c:99:9: note: in expansion of macro 'memcpy'
> >    99 |         memcpy(&iter->fi, iter->bh[0]->b_data + off, len);
> >       |         ^~~~~~
> >   AR      fs/udf/built-in.a
> > 
> > This helps with the ongoing efforts to globally enable
> > -Wstringop-overflow.
> > 
> > Link: https://github.com/KSPP/linux/issues/329
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >  fs/udf/directory.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/udf/directory.c b/fs/udf/directory.c
> > index 1c775e072b2f..93153665eb37 100644
> > --- a/fs/udf/directory.c
> > +++ b/fs/udf/directory.c
> > @@ -95,7 +95,7 @@ static int udf_copy_fi(struct udf_fileident_iter *iter)
> >  	}
> >  
> >  	off = iter->pos & (blksize - 1);
> > -	len = min_t(int, sizeof(struct fileIdentDesc), blksize - off);
> > +	len = min_t(u32, sizeof(struct fileIdentDesc), blksize - off);
> >  	memcpy(&iter->fi, iter->bh[0]->b_data + off, len);
> >  	if (len < sizeof(struct fileIdentDesc))
> >  		memcpy((char *)(&iter->fi) + len, iter->bh[1]->b_data,
> 
> len is u32, "off" can't be less than blksize, so this all looks correct
> to me. Thanks!
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks! I've merged the patch to my tree.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
