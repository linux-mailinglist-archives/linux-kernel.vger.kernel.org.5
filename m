Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7337A6A67
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 20:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjISSF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 14:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjISSFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 14:05:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA77BBF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 11:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695146700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yPQFDee6tmhjQOr4CBnPWVdaics0wkhWkFarLbL/j5Q=;
        b=c3OF5P6AO2m208ZEHuHXg34IYbU8NTlk+pTgp9wkJOvAfyXseFfRNgw9YEsQr3ZZLkmJYS
        jzIidaFd9Rmd/geLuLs55/0HurvDuzjxg+l4/MWFdwPDA0LjOxeLB3o/Mm54tf79WSiRW2
        y/zy3KxaBZhjZP9tTsI4PC4jYt4Xa1I=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-WrBLGo3GMrSieLHf9oGGcw-1; Tue, 19 Sep 2023 14:04:59 -0400
X-MC-Unique: WrBLGo3GMrSieLHf9oGGcw-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-34ff0d95d83so13555365ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 11:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695146698; x=1695751498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPQFDee6tmhjQOr4CBnPWVdaics0wkhWkFarLbL/j5Q=;
        b=JpIiuRdiyj5en/I5KWQbPJUPLm5DkYCzIuTXOUZNaq/DEybVCTSkFrGZb8oNhM9PQW
         6bMmZJlQPmPQMHgRRf857ilo27QjTaPoZhk8aMASKPXSJ1iEZxlGedBtbROEj2Z0D7ZR
         EZwxaO+2LdoSo4BnWqDGUnOahuQx/BAidoEmsfvGAMqCx1qKz5HL4BSvI5YGcrcdpCYj
         FrilIl8oJ3xpn2NjnLdF8WLBkI55b4y7I1z1BoVNaBvpU+zlaTYUvn8lq37rLzgWppTL
         sLvj7op9uGhHmYsqJTexQ6ALFUAhMc46e7rmdG010hafA+yWL5KgAGSqU4sWhsiXoIv7
         UU9g==
X-Gm-Message-State: AOJu0Yz4n2/+soW3kVq1bN6xPf6T3I0Hv4dSewaUNRImzcO6MbMufJ1D
        vsI7MB62t0EPVzVhwDtZNfHVZesynHyMTEZp5QzBJXVR3oPEVQ+HPIQBVGDGRHm1uhN3EwHQchs
        lCO5hV7g4EKmyX8SotOhjvD4N
X-Received: by 2002:a92:c10b:0:b0:350:ecf2:8eca with SMTP id p11-20020a92c10b000000b00350ecf28ecamr542597ile.19.1695146697699;
        Tue, 19 Sep 2023 11:04:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHow4QEWp5PgAICiygV3zUpB9qg2AEwKhayIppVcrOusKPypNKokF3av7XY+kYtGxweePqDSQ==
X-Received: by 2002:a92:c10b:0:b0:350:ecf2:8eca with SMTP id p11-20020a92c10b000000b00350ecf28ecamr542576ile.19.1695146697461;
        Tue, 19 Sep 2023 11:04:57 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id q18-20020a02cf12000000b004302760aa6bsm3522374jar.4.2023.09.19.11.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 11:04:56 -0700 (PDT)
Date:   Tue, 19 Sep 2023 12:04:56 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Cong Liu <liucong2@kylinos.cn>
Cc:     jgg@ziepe.ca, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vfio: Fix uninitialized symbol and potential
 dereferencing errors in vfio_combine_iova_ranges
Message-ID: <20230919120456.1a68dc4d.alex.williamson@redhat.com>
In-Reply-To: <20230914090839.196314-1-liucong2@kylinos.cn>
References: <ZQGs6F5y3YzlAJaL@ziepe.ca>
        <20230914090839.196314-1-liucong2@kylinos.cn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2023 17:08:39 +0800
Cong Liu <liucong2@kylinos.cn> wrote:

> when compiling with smatch check, the following errors were encountered:
> 
> drivers/vfio/vfio_main.c:957 vfio_combine_iova_ranges() error: uninitialized symbol 'last'.
> drivers/vfio/vfio_main.c:978 vfio_combine_iova_ranges() error: potentially dereferencing uninitialized 'comb_end'.
> drivers/vfio/vfio_main.c:978 vfio_combine_iova_ranges() error: potentially dereferencing uninitialized 'comb_start'.
> 
> this patch fix these error.
> 
> Signed-off-by: Cong Liu <liucong2@kylinos.cn>
> ---
>  drivers/vfio/vfio_main.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 40732e8ed4c6..96d2f3030ebb 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -938,14 +938,17 @@ static int vfio_ioctl_device_feature_migration(struct vfio_device *device,
>  void vfio_combine_iova_ranges(struct rb_root_cached *root, u32 cur_nodes,
>  			      u32 req_nodes)
>  {
> -	struct interval_tree_node *prev, *curr, *comb_start, *comb_end;
> +	struct interval_tree_node *prev, *curr;
> +	struct interval_tree_node *comb_start = NULL, *comb_end = NULL;
>  	unsigned long min_gap, curr_gap;
>  
>  	/* Special shortcut when a single range is required */
>  	if (req_nodes == 1) {
> -		unsigned long last;
> +		unsigned long last = 0;
>  
>  		comb_start = interval_tree_iter_first(root, 0, ULONG_MAX);
> +		if (!comb_start)
> +			return;
>  		curr = comb_start;
>  		while (curr) {
>  			last = curr->last;

@last no longer requires initialization with the @comb_start test.

However, all of these are testing for invalid parameters, which I think
we can eliminate if we simply introduce the following at the start of
the function:

        if (!cur_nodes || cur_nodes <= req_nodes ||
            WARN_ON(!req_nodes || !root->rb_root.rb_node))
                return;

At that point we're guaranteed to have any entry for both the above and
below first entry and there must be at least a second entry (or a
driver bug telling us there are more entries than actually exist) for
the next call below.  Thanks,

Alex


> @@ -963,6 +966,10 @@ void vfio_combine_iova_ranges(struct rb_root_cached *root, u32 cur_nodes,
>  		prev = NULL;
>  		min_gap = ULONG_MAX;
>  		curr = interval_tree_iter_first(root, 0, ULONG_MAX);
> +		if (!curr) {
> +			/* No more ranges to combine */
> +			break;
> +		}
>  		while (curr) {
>  			if (prev) {
>  				curr_gap = curr->start - prev->last;
> @@ -975,6 +982,10 @@ void vfio_combine_iova_ranges(struct rb_root_cached *root, u32 cur_nodes,
>  			prev = curr;
>  			curr = interval_tree_iter_next(curr, 0, ULONG_MAX);
>  		}
> +		if (!comb_start || !comb_end) {
> +			/* No more ranges to combine */
> +			break;
> +		}
>  		comb_start->last = comb_end->last;
>  		interval_tree_remove(comb_end, root);
>  		cur_nodes--;

