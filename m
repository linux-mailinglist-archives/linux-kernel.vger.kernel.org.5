Return-Path: <linux-kernel+bounces-55913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3019284C350
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6DEC1F23E19
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975DA11718;
	Wed,  7 Feb 2024 03:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EB0oPSS0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498BD10957
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 03:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707278073; cv=none; b=H/4Hr3p7VEzwS42mB39fLhi6MLf4XuddPrJ9tapS5jz/QiyBdEZYCajO4i4L5PBzl+7fuhcT+kcWKaALUCFE30I73c+kEgWPPwvks1d75n1CwhyQ/dqT5i7cK5TwHZVRqWZiKfe+pWWeIzmdq/YROJjEObOkxzKPPnzVWRTazw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707278073; c=relaxed/simple;
	bh=HeHSpaBPWNe8yR0xTabGzqMF1m+sLioUPLP6/R7rgcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Av1JfLLsTJ5nNeasXDeAG/aPs2xNidFutu2eq5DceK/u86ugH0vB8Me+0+hkXKudz7t2hGAW24hHVRa1bAd1ZOUronTSlUTG4IT43HtlFtPgKWFJIaULKTnuPqmbt7prZuM3quzrGwFlBsRfPtCka6MDD1t64AaLgU84pMrKp/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EB0oPSS0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707278071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B3gLX6Sq94fbV1ugzJ1BRE1vmNqjyOlnYCDmqCtVNNA=;
	b=EB0oPSS0mAUAcfR4oYpjVHHGrOvtEAbXVPLCPwmnwHyQ2lwsFRnhjXRZ5EaUNPnunhW7np
	kZRleYUTwfiYU83CjYDc9Xn/zgSJjaJZ+6nTWgu1fZFvUbePxaivscZgeOM5cb9RXAYgp/
	Ml5gnJwbwlYV3lR0Mst+WzNxxDlunds=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-kX_mSkUbO2OWFGiloA5EgQ-1; Tue, 06 Feb 2024 22:54:29 -0500
X-MC-Unique: kX_mSkUbO2OWFGiloA5EgQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7858da777a5so15650485a.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 19:54:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707278069; x=1707882869;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B3gLX6Sq94fbV1ugzJ1BRE1vmNqjyOlnYCDmqCtVNNA=;
        b=Wo+lSNRsD8ZdDaOoWHHsmJMnqjTNvpxs8E8OGnnn57bmHcfYhaUF/UJcFL4a5yKb4K
         90sxM+KS6x26Dp0fkIKSVs1v3KalmXuZWWn+V2QlC02B3+4EWJYQmxB7DK5olXtzK+mW
         HI4q4T5nbM7JyqcwGCCxOM4u3AuQH6Hd0JbnaS6S6ppVtnh2LPCVmqhGefS2UpoerFsD
         Hwr0xn0vn9pv3xqjTqmbLJGc/6bGRcQ+n1l2qeX3UGwSti8XAI+aEabiS9Ff6jd6mJDi
         y1ncLjY6Ije9Hj0u17Y1obb/P1zuffZWFCyhJ3IR40vz2rbE1SUKQQPKot1EZSd/4kCM
         oMFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+wbZrqR5y6cagW60Nqi7gDs3oIdPoC2cM4g4UvwW581jkL/sOJtY1OkzqhZ1sNj6I9+EpRjSpkOzKCm2Gv+vBkB2OOY9YiF40mMcR
X-Gm-Message-State: AOJu0Yx2X+31h7FkSokOWr3S5PYxnFhJut9Mhht2MFzBQtVSpsl2zk/f
	ElWESl2e4QqnI2j9gmotE3xfQU9toWERNcy/gRHgfKi1vi57HA2IeCoqCGzqEXD8yuwGOH3A888
	y/5NVSZVrify+vYrKOnxPiMCFUc5WYNDu8I3ZDlAgJu4w0B4colhcNiwDBaiV2w==
X-Received: by 2002:a05:620a:2a0b:b0:785:9698:f5a3 with SMTP id o11-20020a05620a2a0b00b007859698f5a3mr2123654qkp.76.1707278069377;
        Tue, 06 Feb 2024 19:54:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWg956Vk1ongLTPMuU4aVgl1ljYtphImbazJCZsVO5D1+1uyie+YIy9ImtSpfJG1/Yss1BWg==
X-Received: by 2002:a05:620a:2a0b:b0:785:9698:f5a3 with SMTP id o11-20020a05620a2a0b00b007859698f5a3mr2123643qkp.76.1707278069164;
        Tue, 06 Feb 2024 19:54:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXvlpCNIsZUaElGHEq/fgh7QjQ9sevS4GsxMVvZ82Gcb+1WocQiFTswVmx95rNAyUrtSHsMzR9H01upFD/q6pCEjHTmaw5pRNf2QhudR5D8P1kEqUM8zo+REVzy3ygANoKFUid4SP9l8YiOJMYIkWkKhf+wSkGrn93fOtsDyLdZMR9nkgJlRG3Qlm9lsasCI8oXOKYNuk/OwW8Srt+TNGoyuCHZI0S0F+ZHEI21j3JqqWO8epRKma+5tXWYS9Tty2LsUn7Ymw3WeqvaZeyDP2AiPQT36xUE+XpXoDaI8Wp2v95MV68UEY3ZJGQD3vovAepJ60OfiXg=
Received: from [192.168.1.158] ([70.22.187.239])
        by smtp.gmail.com with ESMTPSA id z35-20020a05620a262300b00783148d1269sm158484qko.62.2024.02.06.19.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 19:54:28 -0800 (PST)
Message-ID: <ed502d03-adf0-6eec-5392-02569ae48889@redhat.com>
Date: Tue, 6 Feb 2024 22:54:27 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: linux-next: build failure after merge of the device-mapper tree
Content-Language: en-US
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Alasdair G Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>
Cc: Hongyu Jin <hongyu.jin@unisoc.com>,
 "J. corwin Coburn" <corwin@hurlbutnet.net>, John Wiele <jwiele@redhat.com>,
 Michael Sclafani <vdo-devel@redhat.com>,
 Thomas Jaskiewicz <tom@jaskiewicz.us>, Yibin Ding <yibin.ding@unisoc.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20240207144053.1285b3e2@canb.auug.org.au>
From: Matthew Sakai <msakai@redhat.com>
In-Reply-To: <20240207144053.1285b3e2@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Acknowledged. We will get this sorted out as soon as possible.

Matt

On 2/6/24 22:40, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the device-mapper tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/md/dm-vdo/io-factory.c: In function 'read_ahead':
> drivers/md/dm-vdo/io-factory.c:118:17: error: too few arguments to function 'dm_bufio_prefetch'
>    118 |                 dm_bufio_prefetch(reader->client, block_number, read_ahead);
>        |                 ^~~~~~~~~~~~~~~~~
> In file included from drivers/md/dm-vdo/io-factory.h:9,
>                   from drivers/md/dm-vdo/io-factory.c:6:
> include/linux/dm-bufio.h:86:6: note: declared here
>     86 | void dm_bufio_prefetch(struct dm_bufio_client *c,
>        |      ^~~~~~~~~~~~~~~~~
> drivers/md/dm-vdo/io-factory.c: In function 'position_reader':
> drivers/md/dm-vdo/io-factory.c:182:24: error: too few arguments to function 'dm_bufio_read'
>    182 |                 data = dm_bufio_read(reader->client, block_number, &buffer);
>        |                        ^~~~~~~~~~~~~
> include/linux/dm-bufio.h:64:7: note: declared here
>     64 | void *dm_bufio_read(struct dm_bufio_client *c, sector_t block,
>        |       ^~~~~~~~~~~~~
> 
> Caused by commit
> 
>    82da73bac1ee ("dm vdo: add deduplication index storage interface")
> 
> interacting with commit
> 
>    3be93545346e ("dm bufio: Support IO priority")
> 
> I have used the device-mapper tree from next-20240206 for today.
> 


