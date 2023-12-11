Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C2D80D080
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344281AbjLKQGb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 Dec 2023 11:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344499AbjLKQFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:05:47 -0500
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58290101;
        Mon, 11 Dec 2023 08:04:17 -0800 (PST)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5908b15f43eso319191eaf.1;
        Mon, 11 Dec 2023 08:04:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702310656; x=1702915456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eIMpn6ss9umZBhmSuB1vL8NZMVZxwbPaHeyzVO2W8AE=;
        b=eiweLRNqgiIU82+TqvzvRwzHf6kMsf6y18dksSAOwQ5K/ytWZYzGteST3wJ0J8jORH
         KbtsF64AKkiU3zSkCAgjIOWFQUEorHOjEtsYs7kYM6ffjkfqVj/LrLMSFdk66aiydFDf
         szbQV1BjISj+VQCPm6zW5W1tFAqdjJefjP3BCI2PxryTZurSJnI5f96XIlFiq9zBFCs2
         adj5Tl0TSjofJZ6+mz0j1RnEm8f/bZNcDxPITKFCQSLA8F7OIATjE9cmviKXBvACK7x4
         GqH3iHMmeMplDFY6b5TuoNxALNNJOO3DRLOdTgOEn+ag08muJjbn7pDQpULjx20So1zE
         hv8w==
X-Gm-Message-State: AOJu0YxIZpVBggSR17qCm/lOvYslE5N6swDyzZ8n6Ndui+Hk9tKA+Szy
        vFdpdmfPJsSTVYLVoq97lZCKTVmWC1SzOgRlBt4=
X-Google-Smtp-Source: AGHT+IGFDTjBOL0lxSzuXs3XLispvYpZjZ3z0ervlBlI3IeXDcvyTmVIVNOE7sGrmOBpS6mUShyIaB8Fjm5Sokz0rlI=
X-Received: by 2002:a4a:d130:0:b0:590:5de3:cca6 with SMTP id
 n16-20020a4ad130000000b005905de3cca6mr7188043oor.0.1702310655912; Mon, 11 Dec
 2023 08:04:15 -0800 (PST)
MIME-Version: 1.0
References: <b2fd8c52429b51fc0c060753e6b616f1edf81d92.1702020689.git.chen.haonan2@zte.com.cn>
In-Reply-To: <b2fd8c52429b51fc0c060753e6b616f1edf81d92.1702020689.git.chen.haonan2@zte.com.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 11 Dec 2023 17:04:04 +0100
Message-ID: <CAJZ5v0jZAOmnccbEUsBNw3f-Uh6TmO-6JGgU+PJazmjFASczHQ@mail.gmail.com>
Subject: Re: [PATCH linux-next] kernel/power: Use kmap_local_page() in snapshot.c
To:     chenguanxi11234@163.com
Cc:     rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chen Haonan <chen.haonan2@zte.com.cn>
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

On Mon, Dec 11, 2023 at 3:52 PM <chenguanxi11234@163.com> wrote:
>
> From: Chen Haonan <chen.haonan2@zte.com.cn>
>
> kmap_atomic() has been deprecated in favor of kmap_local_page().
>
> Each call to kmap_atomic() in the kernel creates a non-preemptable
> segment and disables the missing page exception. This can be one of
> the sources of unexpected latency. Therefore users should choose
> kmap_local_page() over kmap_atomic().

Do you realize that the code being modified runs with only one CPU
online and with interrupts off on that CPU?

> Signed-off-by: Chen Haonan <chen.haonan2@zte.com.cn>
> ---
>  kernel/power/snapshot.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 50a15408c3fc..feef0d4d3288 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -1487,11 +1487,11 @@ static bool copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
>         s_page = pfn_to_page(src_pfn);
>         d_page = pfn_to_page(dst_pfn);
>         if (PageHighMem(s_page)) {
> -               src = kmap_atomic(s_page);
> -               dst = kmap_atomic(d_page);
> +               src = kmap_local_page(s_page);
> +               dst = kmap_local_page(d_page);
>                 zeros_only = do_copy_page(dst, src);
> -               kunmap_atomic(dst);
> -               kunmap_atomic(src);
> +               kunmap_local(dst);
> +               kunmap_local(src);
>         } else {
>                 if (PageHighMem(d_page)) {
>                         /*
> @@ -1499,9 +1499,9 @@ static bool copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
>                          * data modified by kmap_atomic()
>                          */
>                         zeros_only = safe_copy_page(buffer, s_page);
> -                       dst = kmap_atomic(d_page);
> +                       dst = kmap_local_page(d_page);
>                         copy_page(dst, buffer);
> -                       kunmap_atomic(dst);
> +                       kunmap_local(dst);
>                 } else {
>                         zeros_only = safe_copy_page(page_address(d_page), s_page);
>                 }
> --
> 2.25.1
>
