Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467BE80DCB3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 22:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345111AbjLKVK7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 Dec 2023 16:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345051AbjLKVKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 16:10:55 -0500
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF54FCE;
        Mon, 11 Dec 2023 13:11:01 -0800 (PST)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6d9d6f8485eso711709a34.0;
        Mon, 11 Dec 2023 13:11:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702329061; x=1702933861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+28nOcEyCcEuwJJom4JSQW5x+/ek8mhjRptDpKqeApE=;
        b=sqhTYToQpNIxKfyxA2a7yrdheIoCq2ywXrn0fnILnZrcj/pm3iLc1oVjeJrwOJIN7j
         vWk/nNtwXVsVE/oD42h+/WEYd9PKr9u6t9Z1hPUqcJD93IxBYeViiBCP+ArMV2QzLPSj
         lNjPovs0OAToFsWpbc2h+TFC8TkcrJq8QJld+v/FmQ+Zidc6P0rjcqJmkcGNj4dM1ip2
         /ggbJBitjP21muKk0msXHgiY2k30THtNUQRydoQClHIKh/OptQkw6NIV9IFGiDU/Z5F3
         BnNO4xxOdXLBUPO+6z8LVUy0h/18DDCasbHYR6fcwMapRDnIiXHvMgUm++6Q27R0dpjD
         k5Eg==
X-Gm-Message-State: AOJu0YxiBHe3rzoV+HRXqnenwheWtdDFfmJaeJ0Bx1A3cw/n2WKt91om
        HZEByg0E9HkMAyDd8M/trt81zb67PBjLBSzIcKA=
X-Google-Smtp-Source: AGHT+IGPrkYJLDfxqTwDOmJQQiLfS+sFr/VYQzZCMQ4uwzE3+4BdKwQRzCpU3Hz2N5pz5NSxwD7dJv1P28MAUJAKDTY=
X-Received: by 2002:a05:6871:7589:b0:1fa:db26:78a6 with SMTP id
 nz9-20020a056871758900b001fadb2678a6mr10132449oac.1.1702329061054; Mon, 11
 Dec 2023 13:11:01 -0800 (PST)
MIME-Version: 1.0
References: <20231024020434.34145-1-zeming@nfschina.com>
In-Reply-To: <20231024020434.34145-1-zeming@nfschina.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 11 Dec 2023 22:10:50 +0100
Message-ID: <CAJZ5v0iRhjjqOsp+h5KzyJBV33vr2NuUbwaDMrTWdmQvBdX9dQ@mail.gmail.com>
Subject: Re: [PATCH] power: snapshot: Optimize the error variable in the snapshot_write_next()
To:     Li zeming <zeming@nfschina.com>
Cc:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 4:05 AM Li zeming <zeming@nfschina.com> wrote:
>
> Assign a value when removing the definition for error, which is assigned
> before use.
>
> Signed-off-by: Li zeming <zeming@nfschina.com>
> ---
>  kernel/power/snapshot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 87e9f7e2bdc05..40c141144c9a1 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -2776,7 +2776,7 @@ static void *get_buffer(struct memory_bitmap *bm, struct chain_allocator *ca)
>  int snapshot_write_next(struct snapshot_handle *handle)
>  {
>         static struct chain_allocator ca;
> -       int error = 0;
> +       int error;
>
>  next:
>         /* Check if we have already loaded the entire image */
> --

Applied as 6.8 material with rewritten subject and changelog.

Thanks!
