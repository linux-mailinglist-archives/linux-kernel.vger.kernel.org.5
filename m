Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F61B7D5A2A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 20:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344113AbjJXSIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 14:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344096AbjJXSIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 14:08:23 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBCD10D4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 11:08:21 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6b497c8575aso4738868b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 11:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698170900; x=1698775700; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k3017rfLAsmBWrjhLTGlW8FveYh7+csB/i8dPVteIyE=;
        b=KMSq+g5B/9/mmBrXtqyNbFrp+0a6B204TjFXffcvyOjFPY0rGmqwfBWVTDiv6HtseO
         MvfxKD0P36CPrfLAwoKQATvJPJk2T8W1WCFYc6eZCoNaSuDnsCgUoX6S4CXvqIcaKQOW
         ChWI30wJAjUeSLvpD7ATMycS43SqfZ3ziZ9j4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698170900; x=1698775700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3017rfLAsmBWrjhLTGlW8FveYh7+csB/i8dPVteIyE=;
        b=Z8OX8e7z3Ns1XwI2lWWHnSkQV11rO0i3HByv+7GPiHr/B5dhKcW2iSjUr9eYKf5bnx
         WyjNXPCJZj3hY7UkZSaU3MVoZ4NNp0e/F8MImuhdcM7FObalaY8LTD0RlqUQ1U4jliiQ
         oYZsJbrhEYmsYph/8jh7voz8QOVxVrTcgc4okcp3wOPYT180wMrBsotFAOuRqjvKDXwM
         SkISoEWiZvgwEX9TP/Pn5OsYkHULEfyVQg95QrLWKzjZ1BnC8mKPj8KFYzOtMok86Dkz
         UlRY99Cu9fiOU5BuZL0B+1NzJypNk8yeeP2nuZcJH0KBIZY6GywfEN4TazlJbW2xjMtY
         wt4w==
X-Gm-Message-State: AOJu0YwH8YSjSQj5cNf8WmeaceStZ94TnFtNlHUljSntGSxmuVxnmAJt
        FQKzknx8rtUOQezeNEdxTFKVOw==
X-Google-Smtp-Source: AGHT+IFGxHFp5kySQjiH/D3DhnH8iCrDxB0Ra53C+jTN6JyknU2xEf0SERhhIgYYJS8DDiyE+OW6OQ==
X-Received: by 2002:a05:6a21:7803:b0:16b:e46e:1246 with SMTP id be3-20020a056a21780300b0016be46e1246mr3564795pzc.30.1698170900569;
        Tue, 24 Oct 2023 11:08:20 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d15-20020a65620f000000b0057e7ae47893sm6448886pgv.47.2023.10.24.11.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 11:08:19 -0700 (PDT)
Date:   Tue, 24 Oct 2023 11:08:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] s390/qeth: replace deprecated strncpy with strscpy
Message-ID: <202310241029.3E4A634@keescook>
References: <20231023-strncpy-drivers-s390-net-qeth_core_main-c-v1-1-e7ce65454446@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023-strncpy-drivers-s390-net-qeth_core_main-c-v1-1-e7ce65454446@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 07:39:39PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect new_entry->dbf_name to be NUL-terminated based on its use with
> strcmp():
> |       if (strcmp(entry->dbf_name, name) == 0) {
> 
> Moreover, NUL-padding is not required as new_entry is kzalloc'd just
> before this assignment:
> |       new_entry = kzalloc(sizeof(struct qeth_dbf_entry), GFP_KERNEL);
> 
> ... rendering any future NUL-byte assignments (like the ones strncpy()
> does) redundant.
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

struct qeth_dbf_entry {
        char dbf_name[DBF_NAME_LEN];

The sizeof() replace looks right to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  drivers/s390/net/qeth_core_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
> index cd783290bde5..6af2511e070c 100644
> --- a/drivers/s390/net/qeth_core_main.c
> +++ b/drivers/s390/net/qeth_core_main.c
> @@ -6226,7 +6226,7 @@ static int qeth_add_dbf_entry(struct qeth_card *card, char *name)
>  	new_entry = kzalloc(sizeof(struct qeth_dbf_entry), GFP_KERNEL);
>  	if (!new_entry)
>  		goto err_dbg;
> -	strncpy(new_entry->dbf_name, name, DBF_NAME_LEN);
> +	strscpy(new_entry->dbf_name, name, sizeof(new_entry->dbf_name));
>  	new_entry->dbf_info = card->debug;
>  	mutex_lock(&qeth_dbf_list_mutex);
>  	list_add(&new_entry->dbf_list, &qeth_dbf_list);
> 
> ---
> base-commit: 9c5d00cb7b6bbc5a7965d9ab7d223b5402d1f02c
> change-id: 20231023-strncpy-drivers-s390-net-qeth_core_main-c-0b0ee08672ec
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
> 

-- 
Kees Cook
