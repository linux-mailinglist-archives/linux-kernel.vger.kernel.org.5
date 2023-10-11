Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FB87C5526
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbjJKNVj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 11 Oct 2023 09:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbjJKNVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:21:36 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31C990;
        Wed, 11 Oct 2023 06:21:35 -0700 (PDT)
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1qqZ9U-0002pt-2W;
        Wed, 11 Oct 2023 09:21:28 -0400
Message-ID: <60b4d916663ea31ae05a958b6dea8aa5bf740d0a.camel@surriel.com>
Subject: Re: [PATCH] execve.2: execve also returns E2BIG if a string is too
 long
From:   Rik van Riel <riel@surriel.com>
To:     Alejandro Colomar <alx@kernel.org>
Cc:     linux-man@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@meta.com, Eric Biederman <ebiederm@xmission.com>
Date:   Wed, 11 Oct 2023 09:21:28 -0400
In-Reply-To: <ZSZ7yXwYAg-xPC7P@debian>
References: <20231010234153.021826b1@imladris.surriel.com>
         <ZSZ7yXwYAg-xPC7P@debian>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Sender: riel@surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-10-11 at 12:41 +0200, Alejandro Colomar wrote:
> Hi Rik,
> 
> On Tue, Oct 10, 2023 at 11:41:53PM -0400, Rik van Riel wrote:
> > Document that if a command line or environment string is too long
> > (> MAX_ARG_STRLEN), execve will also return E2BIG.
> 
> That's already implied by the current text:
> 
>        E2BIG  The total number of bytes in the environment (envp) and
> argument
>               list (argv) is too large.
> 
> That means that
> 
> size_t  bytes;
> 
> bytes = 0;
> for (char *e = envp; e != NULL; e++)
>         bytes += strlen(e) + 1;  // I have doubts about the +1
> for (char *a = argv; a != NULL; a++)
>         bytes += strlen(a) + 1;  // Same doubts
> 
> if (bytes > MAX_ARG_STRLEN)  // Maybe >= ?
>         return -E2BIG;

The code in fs/exec.c enforces MAX_ARG_STRLEN against
each individual string, not against the total.

If any string, either argument or environment, is larger
than 32 * PAGE_SIZE, the kernel will return -E2BIG.

do_execveat_common() has this code, which uses copy_strings
to copy both the strings from the environment, and from
the command line arguments:

        retval = copy_strings(bprm->envc, envp, bprm);
        if (retval < 0)
                goto out_free;

        retval = copy_strings(bprm->argc, argv, bprm);
        if (retval < 0)
                goto out_free;

Inside copy_strings() we have this code:


        while (argc-- > 0) {
...
                len = strnlen_user(str, MAX_ARG_STRLEN);
                if (!len)
                        goto out;

                ret = -E2BIG;
                if (!valid_arg_len(bprm, len))
                        goto out;

The valid_arg_len() function does not need explanation:

static bool valid_arg_len(struct linux_binprm *bprm, long len)
{
        return len <= MAX_ARG_STRLEN;
}


The current man page wording is very clear about the total
length being enforced, but IMHO not as clear about the limit
that gets enforced on each individual string.

The total length limit of environment & commandline arguments
is enforced by bprm_stack_limits(), and is checked against
either 1/4 of the maximum stack size, or 3/4 of _STK_LIM, whichever
is smaller. The MAX_ARG_STRLEN value does not come into play when
enforcing the total.

-- 
All Rights Reversed.
