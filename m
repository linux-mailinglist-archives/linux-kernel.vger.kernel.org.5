Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E1B776FCE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 07:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbjHJFuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 01:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjHJFuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 01:50:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BF3DC;
        Wed,  9 Aug 2023 22:50:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6420663ABD;
        Thu, 10 Aug 2023 05:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB362C433C7;
        Thu, 10 Aug 2023 05:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691646619;
        bh=ZkXUBpDBu9QwnkLpxahRZNB7OCdEJLkymsg75+zlQw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PE4e5cA16I3LFCbnc+VsECOpyw9dMz502u49bpTHGFAaeIEt4ni5RnZwfFchxkKO5
         tAZ49l4eHxZKPJzuQIFc6fydXeyuKtcN3xQXNX/hyIMCwN5/aKwKa8DqjwKxJhMPUG
         zmDW0mfUQy5oXc4wjr4acOwj8l2rzku8KhHZJJes=
Date:   Thu, 10 Aug 2023 07:50:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     dhowells@redhat.com, dwmw2@infradead.org, masahiroy@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu,
        linux-kernel@vger.kernel.org, sshedi@vmware.com,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v9 3/7] sign-file: move file signing logic to its own
 function
Message-ID: <2023081040-rarity-presuming-842d@gregkh>
References: <20230809172211.343677-1-yesshedi@gmail.com>
 <20230809172211.343677-4-yesshedi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809172211.343677-4-yesshedi@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 10:52:06PM +0530, Shreenidhi Shedi wrote:
> Keep the main function bare minimal and do less in main function.

"do less" means exactly what?

> This patch is pre-work for bulk module signing support.
> 
> Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
> ---
>  scripts/sign-file.c | 115 +++++++++++++++++++++-----------------------
>  1 file changed, 54 insertions(+), 61 deletions(-)
> 
> diff --git a/scripts/sign-file.c b/scripts/sign-file.c
> index b0f340ea629b..64d5e00f08e2 100644
> --- a/scripts/sign-file.c
> +++ b/scripts/sign-file.c
> @@ -313,10 +313,10 @@ static void parse_args(int argc, char **argv, struct cmd_opts *opts)
>  	} while (opt != -1);
>  }
>  
> -int main(int argc, char **argv)
> +static int sign_single_file(struct cmd_opts *opts)
>  {
>  	struct module_signature sig_info = { .id_type = PKEY_ID_PKCS7 };
> -	unsigned char buf[4096];
> +	unsigned char buf[4096] = {};

Why make this change?  What requires it to now be zero initialized?

thanks,

greg k-h
