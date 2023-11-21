Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1BE7F3147
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbjKUOl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234359AbjKUOlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:41:23 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE28D69;
        Tue, 21 Nov 2023 06:41:19 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BB4461F8B8;
        Tue, 21 Nov 2023 14:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1700577677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NSc7dP9JzioiJiPzKQCkXwUEPBhmaH4jbrYRamLVKsQ=;
        b=kJI22AIuRUb3nVsA+UJE6w2U9+rrfphlpRFyqA9z71oNPm7LVaJntV8vddvAtR2AHlmWj1
        3zlWa5/ljsCcbJyqP6XJ9afEvEZpRbA+TrMfPsZ49E3KmkkJf62uSLARhUwRhS70mUwVqj
        UlFCWY6twxUQLILMfHpa4V1PO2JNj9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1700577677;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NSc7dP9JzioiJiPzKQCkXwUEPBhmaH4jbrYRamLVKsQ=;
        b=yDveSRTOubmCcQmsntdchqyzuNwmHSc04CB6N/AqUXqbkxdWpKedjuaiLf5arcrx4RJjDv
        jobwcrw/OzS66dCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B1C39138E3;
        Tue, 21 Nov 2023 14:41:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id P8BXK43BXGXnWgAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 21 Nov 2023 14:41:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F2478A07D9; Tue, 21 Nov 2023 15:41:16 +0100 (CET)
Date:   Tue, 21 Nov 2023 15:41:16 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>
Subject: Re: [PATCH 01/17] tty: deprecate tty_write_message()
Message-ID: <20231121144116.4kvwinm2vjevmqcy@quack3>
References: <20231121092258.9334-1-jirislaby@kernel.org>
 <20231121092258.9334-2-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121092258.9334-2-jirislaby@kernel.org>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -5.01
X-Spamd-Result: default: False [-5.01 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         RCPT_COUNT_FIVE(0.00)[5];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.21)[71.76%]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21-11-23 10:22:42, Jiri Slaby (SUSE) wrote:
> tty_write_message() has only one user: quotas. In particular, there the
> use depends on CONFIG_PRINT_QUOTA_WARNING. And that is deprecated and
> marked as BROKEN already too.
> 
> So make tty_write_message() dependent on that very config option. This
> action in fact drops tty_write_message() from the vmlinux binary. Good
> riddance.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Jan Kara <jack@suse.com>

Sure, that was indeed a hack. Feel free to add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/tty/tty_io.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index 06414e43e0b5..ee5a90f9adb5 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -1047,6 +1047,7 @@ static ssize_t iterate_tty_write(struct tty_ldisc *ld, struct tty_struct *tty,
>  	return ret;
>  }
>  
> +#ifdef CONFIG_PRINT_QUOTA_WARNING
>  /**
>   * tty_write_message - write a message to a certain tty, not just the console.
>   * @tty: the destination tty_struct
> @@ -1057,6 +1058,8 @@ static ssize_t iterate_tty_write(struct tty_ldisc *ld, struct tty_struct *tty,
>   * needed.
>   *
>   * We must still hold the BTM and test the CLOSING flag for the moment.
> + *
> + * This function is DEPRECATED, do not use in new code.
>   */
>  void tty_write_message(struct tty_struct *tty, char *msg)
>  {
> @@ -1069,6 +1072,7 @@ void tty_write_message(struct tty_struct *tty, char *msg)
>  		tty_write_unlock(tty);
>  	}
>  }
> +#endif
>  
>  static ssize_t file_tty_write(struct file *file, struct kiocb *iocb, struct iov_iter *from)
>  {
> -- 
> 2.42.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
