Return-Path: <linux-kernel+bounces-116372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FAB889634
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EA8F1C2FDAA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9559D125C1;
	Mon, 25 Mar 2024 05:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KJWQtPAN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD1F147C88
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 01:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711330131; cv=none; b=X62BUQBGyw+m9BDXYmgk4FC7xgSfeYWGlj3CifX2rJiGxse2aSiSemIvtPfdHFgfdhztCDqldZL/j2ZLArinGpwz0WsA+stIJ8gqzRwQe/AEh8Rw+7DFDd15jDON+be39EKMHxqbTNDxZ9pxDAQA4H2zK5jJ5jUkfBDczyaOT0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711330131; c=relaxed/simple;
	bh=WFXE0LyhpXVE34d6fzCorzPh2exOtIPxJFRjDF9KNQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oj+u6vdhFgpxNCnqrIkM8N7ldkyvFCn+3uZ4zvt58J6Zj9tiIgW5V6udB6DTLvv0ZcC6p5wOTLAyxhsU7FiuqHPMKlxQIeeY/GxhQswwUspb2gAawi+5nKnfnqVwc6alAvTA0SKEMaBMYfcE5xLJktlfRp2FqVsjl0WlNgV/X6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KJWQtPAN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711330128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ftTLhBm1e2gJ56tO/FlETKKI9BM6pFOz9k6Ug2XyB3Y=;
	b=KJWQtPANo0rwQIa0XGChHh4tnMLSetaaqoLy75dnl0waFOQNTvHXRyyalhCc/CMCbDyUvp
	sVRPUpxng0rjVK2u/mNIAjUQUs7L60RCH9YDQVGlCKWpkFS7uFkoZ8B8KvgOmsBu64tP2R
	RrdR7qBwyIuJ2Jp6Gq5XAHJ/bxdpTG4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-iycHjWTKNvW_Xa309VLJhA-1; Sun, 24 Mar 2024 21:28:45 -0400
X-MC-Unique: iycHjWTKNvW_Xa309VLJhA-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1e0ac20246bso8716295ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 18:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711330125; x=1711934925;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftTLhBm1e2gJ56tO/FlETKKI9BM6pFOz9k6Ug2XyB3Y=;
        b=FhpyN9fJ1ONcXQPE/WK957A87nuAgywt17jY0Tf8ZYF/pT0e9WxVaOV9x1K5b2OfxT
         cjIkKgho8qF5Va+BrGq5CT63g3GW6+2XvA4wP4j9uBZyTv+HS+LD0/HI/T65vYiKp4bO
         lTurl0ohwio3QjT1hJvlx0VepG7emHuB7qZMKK4Xed4+QK0d/5vBlzqbbPz/BvzZ3EdI
         fZrE80/YkwX+0v8RARTQrDWY+GT5DuD3kh7dlHo9XQxvOgjNoSw11jf3hfdiwL/PqUq4
         GfCJh7BQawC2TIVDTGMMNyp+trYeqx/0N5h3d0TIbMIHengzkiHGUEbGMiwp4wuHQ0kc
         Y13A==
X-Forwarded-Encrypted: i=1; AJvYcCX+OiphLy2GSBQMJMZj9FNCwx6mwVA5xu4zkouDI6nlM0kA0eP3MreJQXvRkclbAXSJsnVLDJlJp9GxHWaNtiP7WUOLFDSmzLtopKQ5
X-Gm-Message-State: AOJu0YyCKQ9pHWpCUUT1V30h1wcyMpKao92qvDZlaXUi/jyJG1yChR18
	8kSX1Zdj3webqhz6u9e1IJpAhR39p3yjyzzpez6wKKv84W/wdBueUV+6LE3Ksg3U8xE6U0OwVv3
	LPQY3e6euwBzasdp6/+Kwt5L0QjJQCtI/mrqc5QDhR39G0K6occAisG0vk2GWBA==
X-Received: by 2002:a17:902:fc45:b0:1dd:651d:cc47 with SMTP id me5-20020a170902fc4500b001dd651dcc47mr8387346plb.28.1711330124851;
        Sun, 24 Mar 2024 18:28:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7DxffZ6rfU5Q6avcSf5HCRZu31rwVGtmTLzEB1UCS0aZJfYF74AQEynh80jx9s6pF8Xl/tg==
X-Received: by 2002:a17:902:fc45:b0:1dd:651d:cc47 with SMTP id me5-20020a170902fc4500b001dd651dcc47mr8387321plb.28.1711330124461;
        Sun, 24 Mar 2024 18:28:44 -0700 (PDT)
Received: from [10.72.113.22] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902d50500b001dd6e0a0c1bsm3639417plg.268.2024.03.24.18.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Mar 2024 18:28:43 -0700 (PDT)
Message-ID: <88f42e4c-4046-4d8d-a7aa-3aad66f38cba@redhat.com>
Date: Mon, 25 Mar 2024 09:28:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ceph: redirty page before returning
 AOP_WRITEPAGE_ACTIVATE
Content-Language: en-US
To: NeilBrown <neilb@suse.de>, Ilya Dryomov <idryomov@gmail.com>,
 Jeff Layton <jlayton@kernel.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <171131888022.13576.8585118457506044105@noble.neil.brown.name>
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <171131888022.13576.8585118457506044105@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/25/24 06:21, NeilBrown wrote:
> The page has been marked clean before writepage is called.  If we don't
> redirty it before postponing the write, it might never get written.
>
> Fixes: 503d4fa6ee28 ("ceph: remove reliance on bdi congestion")
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>   fs/ceph/addr.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 1340d77124ae..ee9caf7916fb 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -795,8 +795,10 @@ static int ceph_writepage(struct page *page, struct writeback_control *wbc)
>   	ihold(inode);
>   
>   	if (wbc->sync_mode == WB_SYNC_NONE &&
> -	    ceph_inode_to_fs_client(inode)->write_congested)
> +	    ceph_inode_to_fs_client(inode)->write_congested) {
> +		redirty_page_for_writepage(wbc, page);
>   		return AOP_WRITEPAGE_ACTIVATE;
> +	}
>   
>   	wait_on_page_fscache(page);
>   

Good catch!

Applied to the testing branch to run the tests.

Thanks NeilBrown

- Xiubo


