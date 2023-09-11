Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40D479B3E7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354511AbjIKVy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244020AbjIKSp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 14:45:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9CE721AD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 11:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694457875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ovvc9S0M0fusmEOptIxpRYf51VbT2wJC8z+64gwHvT4=;
        b=hjgIAKEQ03bF2LZPoZO/epEHQdKhFDJn5A6an4pF5wNj34mUVzfXVaixzNtIG9qHqcgX0h
        DHo36lB/cky3kVU4Ad65NyiD821BxkLksfehw3Qz6qGTNLZXp9WI9+bDvVXME3YNocpTA5
        1RudtL6g7IAE17P+av/RV5VilOPpF6E=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-nfx6BQ6mNpixdhhwutjXtA-1; Mon, 11 Sep 2023 14:44:34 -0400
X-MC-Unique: nfx6BQ6mNpixdhhwutjXtA-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-79554d73bd6so331862839f.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 11:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694457873; x=1695062673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovvc9S0M0fusmEOptIxpRYf51VbT2wJC8z+64gwHvT4=;
        b=xQ43zdkjGicHTDNdt85tcMtek2zK+N7ANC9r1d7yidsfwxxdE06D33QF5lYrjzF/WW
         h+OFkR57bt5QMsnWifT5R0qBZnTceOigYe5R4mYC96Um31Dt43sEKDG9jYV0TFRwme+L
         905KV9FQk+/quzt3co9viPT6BZdFAB3kKlw1PxgO3cje5vWJybSW3FIn/yr100OneFOM
         M3N8tiBA+BOLbe5CbmBxaOMPmvV4oJlIJRgPDAuNU8v67FrOv1jESPg7rrSkm9RtnjkQ
         loL6jpatonv5TqUfS6TU9db1du+UW5WxB0K6QOyLMEc1NZZf1QrQBirwW/JCZCCQOfbR
         oGPg==
X-Gm-Message-State: AOJu0Yzl6/FDJvjzfdQ820LgMje2fGG6fRDzk8TRJVAulp+e1OoI9UU0
        XZ7gcRAffuW6i/5YFll5VO54oZFsOphFpbIpvRpe0So0urWB2QXolK7eCCYoUPo99F7VnnHSp1K
        HLRuoJE+uhR8+WPiUFCxdCGcofPpJk9u9
X-Received: by 2002:a5e:9247:0:b0:792:792e:6616 with SMTP id z7-20020a5e9247000000b00792792e6616mr13444917iop.2.1694457873030;
        Mon, 11 Sep 2023 11:44:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5Ns8CF+cguv9IZKBefa7dViaNzCR4oy3BIhvny7IeDcQ2kl9cZDg3xsSJu4ZrwfVj50Pzow==
X-Received: by 2002:a5e:9247:0:b0:792:792e:6616 with SMTP id z7-20020a5e9247000000b00792792e6616mr13444905iop.2.1694457872775;
        Mon, 11 Sep 2023 11:44:32 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id g12-20020a0566380c4c00b004290f6c15bfsm2319678jal.145.2023.09.11.11.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 11:44:32 -0700 (PDT)
Date:   Mon, 11 Sep 2023 12:44:31 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Cong Liu <liucong2@kylinos.cn>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix build error in function vfio_combine_iova_ranges
Message-ID: <20230911124431.5e09f53b.alex.williamson@redhat.com>
In-Reply-To: <20230911094103.57771-1-liucong2@kylinos.cn>
References: <20230911094103.57771-1-liucong2@kylinos.cn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sep 2023 17:41:02 +0800
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
>  drivers/vfio/vfio_main.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 40732e8ed4c6..0a9620409696 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -938,12 +938,13 @@ static int vfio_ioctl_device_feature_migration(struct vfio_device *device,
>  void vfio_combine_iova_ranges(struct rb_root_cached *root, u32 cur_nodes,
>  			      u32 req_nodes)
>  {
> -	struct interval_tree_node *prev, *curr, *comb_start, *comb_end;
> +	struct interval_tree_node *prev, *curr;
> +	struct interval_tree_node *comb_start, *comb_end;

This looks cosmetic, what did it fix?  It's not clear to me how any of
this addresses the last two errors.  Thanks,

Alex

>  	unsigned long min_gap, curr_gap;
>  
>  	/* Special shortcut when a single range is required */
>  	if (req_nodes == 1) {
> -		unsigned long last;
> +		unsigned long last = 0;
>  
>  		comb_start = interval_tree_iter_first(root, 0, ULONG_MAX);
>  		curr = comb_start;

