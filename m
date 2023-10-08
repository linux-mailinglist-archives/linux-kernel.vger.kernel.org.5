Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28447BCD11
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 09:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344499AbjJHHvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 03:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJHHvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 03:51:51 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9D7C5;
        Sun,  8 Oct 2023 00:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1696751506;
        bh=BgY4vzub1HaZeHO6+TU8wMKwHTfa845EGfX4ZXvUfTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RD222CdQZNi3cZRdnZz+lZ5S8ZgKXWTAcyHHWABjJI1BXxsNbtt3fIgL7srE4oN1w
         qXG4HUB2LKM7JCwqeTqrpPznbAVuuFKqFrCLRBCGrskHWL8pNm0ZCgIQ8/nPSbG3GX
         Y5QAtvzdfmT4pUKqmhLQ/VyfvDnhjVlA5n5ioLII=
Date:   Sun, 8 Oct 2023 09:51:45 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 2/5] modpost: fix ishtp MODULE_DEVICE_TABLE built on big
 endian host
Message-ID: <79f74670-768b-46f7-b484-a45ddcd9dc6f@t-8ch.de>
References: <20231007170448.505487-1-masahiroy@kernel.org>
 <20231007170448.505487-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231007170448.505487-2-masahiroy@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-08 02:04:45+0900, Masahiro Yamada wrote:
> When MODULE_DEVICE_TABLE(ishtp, ) is built on a host with a different
> endianness from the target architecture, it results in an incorrect
> MODULE_ALIAS().
> 
> For example, see a case where drivers/platform/x86/intel/ishtp_eclite.c
> is built as a module.

Nitpick:

... [as a module] for x86.

So the statements below can be interpreted correctly.

> 
> If you build it on a little endian host, you will get the correct
> MODULE_ALIAS:
> 
>     $ grep MODULE_ALIAS drivers/platform/x86/intel/ishtp_eclite.mod.c
>     MODULE_ALIAS("ishtp:{6A19CC4B-D760-4DE3-B14D-F25EBD0FBCD9}");
> 
> However, if you build it on a big endian host, you will get a wrong
> MODULE_ALIAS:
> 
>     $ grep MODULE_ALIAS drivers/platform/x86/intel/ishtp_eclite.mod.c
>     MODULE_ALIAS("ishtp:{BD0FBCD9-F25E-B14D-4DE3-D7606A19CC4B}");
> 
> This issue has been unnoticed because the x86 kernel is most likely built
> natively on an x86 host.
> 
> The guid field must not be reversed because guid_t is an array of __u8.
> 
> Fixes: fa443bc3c1e4 ("HID: intel-ish-hid: add support for MODULE_DEVICE_TABLE()")

+ Cc: stable@vger.kernel.org

> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>

Thanks!

> ---
> 
>  scripts/mod/file2alias.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> index 70bf6a2f585c..6583b36dbe69 100644
> --- a/scripts/mod/file2alias.c
> +++ b/scripts/mod/file2alias.c
> @@ -1401,10 +1401,10 @@ static int do_mhi_ep_entry(const char *filename, void *symval, char *alias)
>  /* Looks like: ishtp:{guid} */
>  static int do_ishtp_entry(const char *filename, void *symval, char *alias)
>  {
> -	DEF_FIELD(symval, ishtp_device_id, guid);
> +	DEF_FIELD_ADDR(symval, ishtp_device_id, guid);
>  
>  	strcpy(alias, ISHTP_MODULE_PREFIX "{");
> -	add_guid(alias, guid);
> +	add_guid(alias, *guid);
>  	strcat(alias, "}");
>  
>  	return 1;
> -- 
> 2.39.2
> 
