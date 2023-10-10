Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D6C7C45A7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 01:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344201AbjJJXqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 19:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJJXqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 19:46:31 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D598F;
        Tue, 10 Oct 2023 16:46:29 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7a52a27fe03so2705528241.0;
        Tue, 10 Oct 2023 16:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696981589; x=1697586389; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CM+jvdydXHv5556bdY8VF7dkGPmKm212tPIOIcFNEEQ=;
        b=mYXJeK6ZUhXkIFFd6pUtbk7rGKnI35JD8PdqklapFkhxSf0xF77/Nt7vUN0V/X0VS7
         kxg+1JBwqdaRZid8mZtX8a4zttGr3ZHlSNn3n2p1uf6ySoe4h+PrxFZuUXWw3EJEj4Gp
         eqOd7h27MAwihaiGWPngyCVhDGlxDyioTp/DUuSAod6Zz0H0qJ0f4gmhvw8Gd/KvsIqV
         boGFDPWqJYwbC9dIX3L0MLQOOIa0hqJkLBOMHjpYeNfacq2LyadvarZY0JakdvAvaGb9
         ff0CDMpnQjNNkACagykvuZgwXxnx+TuflCmYVc6CV/GkBihsfL20tRauE4Yvodf9olUM
         G8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696981589; x=1697586389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CM+jvdydXHv5556bdY8VF7dkGPmKm212tPIOIcFNEEQ=;
        b=tWEdE0IP/vvhEJBx6iIn73vfFbc/aDi65obCOPzhYlxm79cpvbhCxrIIDvsYd6tuuF
         bEaLAi3whrhXNjAD6BUlkGBFqO6dvaGBV4wnZ9P4ZFmA5T/PKcn84uAoJjHoaRLZia7U
         u9/4wsmslnflburDwyoAt317nX5qL4hPSUKpsPzhvp3suwiqlrKEJkTMCodxO5HCwBIM
         sLZQXJZCXWN1MzJ8iNizVEqwY21QzXL6sqCeKgwVcpAK1tUx6kp2/uzTKT3D4dKstjIb
         lvXsRXlU+e2DpiTuNHpgP9ogjmVg20EYc/tdCT+eGq7ChibFolcVKVBr1pnNQ+W72aGc
         g6ag==
X-Gm-Message-State: AOJu0YziXCV/14cOauPEdk4akqfDdgHUzXufvGGobsWxwPdWjup05nNI
        h+vPjYiM8f17/SxMqFLOQ2Y=
X-Google-Smtp-Source: AGHT+IHDqByel4wQUh67zGN6+2lSqQOLNCtEMrq8DUunjw8Og0HhDtVU2Fu84whBnh32yVp3IYXeRg==
X-Received: by 2002:a05:6102:f9c:b0:457:a003:2d26 with SMTP id e28-20020a0561020f9c00b00457a0032d26mr1162297vsv.32.1696981588853;
        Tue, 10 Oct 2023 16:46:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y28-20020ab0561c000000b007a251efad75sm501040uaa.36.2023.10.10.16.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 16:46:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 10 Oct 2023 16:46:26 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     joe@perches.com, gregkh@linuxfoundation.org,
        Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Documentation/process/coding-style.rst: space around
 const
Message-ID: <5e13f429-d08d-4c13-b5e8-72da4624e6a4@roeck-us.net>
References: <20231010125832.1002941-1-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010125832.1002941-1-max.kellermann@ionos.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 02:58:31PM +0200, Max Kellermann wrote:
> There are currently no rules on the placement of "const", but a recent
> code submission revealed that there is clearly a preference for spaces
> around it.
> 
> checkpatch.pl has no check at all for this; though it does sometimes
> complain, but only because it erroneously thinks that the "*" (on
> local variables) is an unary dereference operator, not a pointer type.
> 
> Current coding style for const pointers-to-pointers:
> 
>  "*const*": 2 occurrences
>  "* const*": 3
>  "*const *": 182
>  "* const *": 681
> 
> Just const pointers:
> 
>  "*const": 2833 occurrences
>  "* const": 16615
> 
> Link: https://lore.kernel.org/r/264fa39d-aed6-4a54-a085-107997078f8d@roeck-us.net/
> Link: https://lore.kernel.org/r/f511170fe61d7e7214a3a062661cf4103980dad6.camel@perches.com/
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> V1 -> V2: removed "volatile" on gregkh's request.
> V2 -> V3: moved patch changelog below the "---" line
> ---
>  Documentation/process/coding-style.rst | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index 6db37a46d305..71d62d81e506 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -271,6 +271,17 @@ adjacent to the type name.  Examples:
>  	unsigned long long memparse(char *ptr, char **retptr);
>  	char *match_strdup(substring_t *s);
>  
> +Use space around the ``const`` keyword (except when adjacent to
> +parentheses).  Example:
> +
> +.. code-block:: c
> +
> +	const void *a;
> +	void * const b;
> +	void ** const c;
> +	void * const * const d;
> +	int strcmp(const char *a, const char *b);
> +
>  Use one space around (on each side of) most binary and ternary operators,
>  such as any of these::
>  
> -- 
> 2.39.2
> 
