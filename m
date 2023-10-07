Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512E37BC5C4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 09:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343715AbjJGHvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 03:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343650AbjJGHvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 03:51:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6FFB9
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 00:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696665047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IL6H5VoBRpOqVzPYQ3RJbppwYGMKi8FhTxtOJkmxhus=;
        b=fHyvfov+D3drIE1sVjLsg+0GfekfLtLuMpBRpKRF7YTijeYc+uKnExy+NkqfDcL6so+zt/
        wxfVQISsLBMEd3NZmfGdF713oBttj7Kpw95U/F337ji+XIe/syuNg+bK9gVB7OxBm6K8jm
        rywTZRJFys7pqXHF+PXvTBXHVzAPi9s=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-w7SxC4ueNaSkhHfQMJOwvw-1; Sat, 07 Oct 2023 03:50:45 -0400
X-MC-Unique: w7SxC4ueNaSkhHfQMJOwvw-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-58b2d243b26so707672a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 00:50:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696665044; x=1697269844;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IL6H5VoBRpOqVzPYQ3RJbppwYGMKi8FhTxtOJkmxhus=;
        b=jVuWs662jV1hTpYzOau0ZW4UR7mbOcHaS3Z8472+TcAVQyYf1Eef2SrdgsUZiugZMi
         wftSuqPiqk1BUAROuU1usEeYK0HwDnUNwZ6vGUSL04hOznx4gv2B2sivRjKRfBfrSB6R
         gITdOC3l8fbk1rjjiC3sOJs0zKBgZGVuD1MABjiMd2YhdFXpLMJF2r1sKDsGdAZXJeHN
         cwCWdh2+XW9GNO5pIRYELNbNFJdhpd0Zj/W/fZ6ylf9iM0bA4GghKMC5gGMehAPe4oXk
         ovGrOvm2pgR5PNYLkPaZ806ToBSjC7NYEEVBvK+6JSwIBxaj30gAfxVRPx1vxX0Hz3eG
         nbYg==
X-Gm-Message-State: AOJu0Yx4s654rd2/EG01sHKsop3mghkmdNM7U7w442l3QiN3vcr4Qw03
        RYbryATV5j1y1XN+UXKwrKFl7Zz652eLu8a0irW/k/ixthsExxCjKaaXPDsrV8yuizzo2A8SJzl
        lYaERlmmEsF7k/c3h7vtpBh7sOnYiQcTt
X-Received: by 2002:a05:6a20:144c:b0:13c:ca8b:7e29 with SMTP id a12-20020a056a20144c00b0013cca8b7e29mr11909256pzi.12.1696665044404;
        Sat, 07 Oct 2023 00:50:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEV+YP75IsHGoH7CRYi4h1SL1w6jeOp8lNxOmS7z+zGawVvDwyAwksYVpWVsM61n+0klP893A==
X-Received: by 2002:a05:6a20:144c:b0:13c:ca8b:7e29 with SMTP id a12-20020a056a20144c00b0013cca8b7e29mr11909245pzi.12.1696665044053;
        Sat, 07 Oct 2023 00:50:44 -0700 (PDT)
Received: from [10.72.112.33] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id r11-20020aa7844b000000b0069b772c4325sm2613613pfn.87.2023.10.07.00.50.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Oct 2023 00:50:43 -0700 (PDT)
Message-ID: <507202a9-b71d-e52b-0306-dd89044ff442@redhat.com>
Date:   Sat, 7 Oct 2023 15:50:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] fuse: pass ATTR_KILL_SUID/ATTR_KILL_SGID mode bits to
 user space
Content-Language: en-US
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230921022436.1191166-1-xiubli@redhat.com>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20230921022436.1191166-1-xiubli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping...

On 9/21/23 10:24, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
>
> Such as for the xfstest-dev's generic/684 test case it will clear
> suid and sgid if the fallocate request is commit by an unprivileged
> user.
>
> We need to pass the ATTR_KILL_SUID/ATTR_KILL_SGID flags to userspace.
>
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>   fs/fuse/dir.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index f67bef9d83c4..73dcf54efbff 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -1938,11 +1938,11 @@ static int fuse_setattr(struct mnt_idmap *idmap, struct dentry *entry,
>   
>   			attr->ia_mode = inode->i_mode;
>   			if (inode->i_mode & S_ISUID) {
> -				attr->ia_valid |= ATTR_MODE;
> +				attr->ia_valid |= ATTR_KILL_SUID | ATTR_MODE;
>   				attr->ia_mode &= ~S_ISUID;
>   			}
>   			if ((inode->i_mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
> -				attr->ia_valid |= ATTR_MODE;
> +				attr->ia_valid |= ATTR_KILL_SGID | ATTR_MODE;
>   				attr->ia_mode &= ~S_ISGID;
>   			}
>   		}

