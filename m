Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AED178E59C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 07:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238010AbjHaFUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 01:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjHaFUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 01:20:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0572BE0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 22:20:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D0CDB82011
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 05:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19930C433C9;
        Thu, 31 Aug 2023 05:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693459211;
        bh=/KlOZJnmyG1AGexQP2I5u3mg+9COpYkMPmCChLIeNuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kd8qVgyTB89QkLKtVB1zPEQgZcLBH8N5g+xBoZhnfccXPzAy/adQnfRI6uKmr8uNE
         n+fvxbiHY9C9HwxPyFxhdePzBgP6oaZsWsY4OCEoM1Rg5CbCh3sFHa8KE6UqyQRHTR
         ZLkuXGmK0ZlPIofdYW2GI2ly763SLU3ouS0pedKtblWWPNj44ZEW2/1z6Wnpg9WtaJ
         KWaCadyqI/zHr05BrEvXaUTz+ChaAyIP54eTDYpBd2a84rhMgxzZ39A8JEvI+Aze6L
         xeDgcUX4wLZ2Nrcs9Fz2DcwrfbRfu2gkvFnZNoVvz+Ugo5E4Iio3/JfRSpMeY0/iJQ
         G5oEiK5cT/lTg==
Date:   Wed, 30 Aug 2023 22:20:09 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] pstore: Base compression input buffer size on estimated
 compressed size
Message-ID: <20230831052009.GA1349@sol.localdomain>
References: <20230830212238.135900-1-ardb@kernel.org>
 <202308301608.739BFA8@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202308301608.739BFA8@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 04:43:37PM -0700, Kees Cook wrote:
> On Wed, Aug 30, 2023 at 11:22:38PM +0200, Ard Biesheuvel wrote:
> > Commit 1756ddea6916 ("pstore: Remove worst-case compression size logic")
> > removed some clunky per-algorithm worst case size estimation routines on
> > the basis that we can always store pstore records uncompressed, and
> > these worst case estimations are about how much the size might
> > inadvertently *increase* due to encapsulation overhead when the input
> > cannot be compressed at all. So if compression results in a size
> > increase, we just store the original data instead.
> 
> Does the Z_FINISH vs Z_SYNC_FLUSH thing need to be fixed as well, or
> does that become a non-issue with this change?

I haven't seen any real evidence that that issue actually exists.

> >  void pstore_record_init(struct pstore_record *record,
> > @@ -305,7 +314,7 @@ static void pstore_dump(struct kmsg_dumper *dumper,
> >  		record.buf = psinfo->buf;
> >  
> >  		dst = big_oops_buf ?: psinfo->buf;
> > -		dst_size = psinfo->bufsize;
> > +		dst_size = max_uncompressed_size ?: psinfo->bufsize;
> >  
> >  		/* Write dump header. */
> >  		header_size = snprintf(dst, dst_size, "%s#%d Part%u\n", why,
> > @@ -326,8 +335,15 @@ static void pstore_dump(struct kmsg_dumper *dumper,
> >  				record.compressed = true;
> >  				record.size = zipped_len;
> >  			} else {
> > -				record.size = header_size + dump_size;
> > -				memcpy(psinfo->buf, dst, record.size);
> > +				/*
> > +				 * Compression failed, so the buffer is most
> > +				 * likely filled with binary data that does not
> > +				 * compress as well as ASCII text. Copy as much
> > +				 * of the uncompressed data as possible into
> > +				 * the pstore record, and discard the rest.
> > +				 */
> > +				record.size = psinfo->bufsize;
> > +				memcpy(psinfo->buf, dst, psinfo->bufsize);
> 
> I don't think this is "friendly" enough. :P
> 
> In the compression failure case, we've got a larger dst_size (and
> dump_size, but technically it might not be true if something else went
> wrong) than psinfo->bufsize, so we want to take the trailing bytes
> (i.e. panic details are more likely at the end). And we should keep
> the header, which is already present in "dst". I think we need to do
> something like this:
> 
> 	size_t buf_size_available = psinfo->bufsize - header_size;
> 	size_t dump_size_wanted = min(dump_size, buf_size_available);
> 
> 	record.size = header_size + dump_size_wanted;
> 	memcpy(psinfo->buf, dst, header_size);
> 	memcpy(psinfo->buf + header_size,
> 	       dst + header_size + (dump_size - dump_size_wanted),
> 	       dump_size_wanted);
> 
> My eyes, my eyes.
> 

How hard would it be to write two uncompressed records when compression fails to
achieve the targeted 50% ratio?

- Eric
