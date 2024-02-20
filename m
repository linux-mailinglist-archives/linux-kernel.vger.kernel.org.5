Return-Path: <linux-kernel+bounces-72501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2784985B44F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6439B21379
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E5F5BAEE;
	Tue, 20 Feb 2024 07:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwJcZBhj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDBF5A780
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708415885; cv=none; b=tSiqjRxHlGThWsWcLxxl1cLlDseTUyzKp3lK0qs/+GtCon/049ucg0lxnyevVsu7KyNqeFLyGXJl8dZLxCosTyHrDTh8QHGTYEtXDUyQSYS7rRlBHm/fdTwo1o9qW7ae5iuNTfJc6gfKsGk7/HrvuaDsJ/wS6cHR7xAXSxyNZxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708415885; c=relaxed/simple;
	bh=SKdSzd9Om3ss7aelGSZx7GlrCUSOV8sg/VeHoK4NhKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V8pyhJ/ZvvDYt5b0AFUVcCp+6lFZrV22Fr4OIA7MHw5nykiB51dpFi6P4NVT0WS3XlJMsjJO/nwJKWxNj88OBwq+//IudVdMlhrGbNJ/RucwNbehdy/7ospitSqqxvvxF3QAzdq6YfJpzyVwmrbrwc4KoudrqMR2sbUc94evVuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwJcZBhj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609A0C433C7;
	Tue, 20 Feb 2024 07:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708415885;
	bh=SKdSzd9Om3ss7aelGSZx7GlrCUSOV8sg/VeHoK4NhKs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XwJcZBhjVpfemPFNDSUdBoAOjVkwklq3JUgMim0sXvHVJ+Mv1Im9O/KiFpwe1fdwz
	 Eq4oInUe8QG9haUl3w08iSZ7KN8KTEFJg3wJwC97s77T+q4fRB7TLD3/udIjlQuUR4
	 bCUzLUNFZXm9h89Z5HB+25+HlG2Kjn1S2kwrdcl4ZM6H/0HufS4+esymXeA890Fmeb
	 QMngvObDXjjWXBttrI8poxzR2Y/UPnPO6SZyzZYif9DgJ1wDmoJcNjQCP8X7ezE2rn
	 TXfFCOaz9Vvrzuv8wXFXUt++qaOazsDR/sWqUB5PXAKNLN5Ja5SWMphcQoAc2iqVFu
	 TDHtG++ulF0jw==
Message-ID: <5bf29cb0-96a6-4100-8755-750215d31ab6@kernel.org>
Date: Tue, 20 Feb 2024 15:58:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH v7] f2fs: unify the error handling of
 f2fs_is_valid_blkaddr
Content-Language: en-US
To: Zhiguo Niu <niuzhiguo84@gmail.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, ke.wang@unisoc.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 hongyu.jin@unisoc.com, Zhiguo Niu <zhiguo.niu@unisoc.com>
References: <1707103845-17220-1-git-send-email-zhiguo.niu@unisoc.com>
 <e2680238-9e9c-422a-adf3-bcee71dfe0a8@kernel.org>
 <ZcGoWAsl08d5-U0g@google.com>
 <6f01fe1b-d580-4a2a-adc5-7eb3baebeb7a@kernel.org>
 <CAHJ8P3J6CrYeBHUHmk4rQXRr=V0jHkLWOKHjdC+xuLgb4a+NQQ@mail.gmail.com>
 <17c9e85a-54b6-4e1c-b95f-262c771b0f1d@kernel.org>
 <4bcf0a1c-b21d-4735-bf57-b78439a65df5@kernel.org>
 <CAHJ8P3+25FxdpqWNW53yyiLLG8J7LnMAeYr_DV3ARF9-3LCUUg@mail.gmail.com>
 <c82f8a3f-0184-43c2-b67d-ca53338a153c@kernel.org>
 <CAHJ8P3J8WUAxOrG91id+sKKt7ndLnETdbzz6Zy7haoC9qfT0tg@mail.gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CAHJ8P3J8WUAxOrG91id+sKKt7ndLnETdbzz6Zy7haoC9qfT0tg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/2/20 15:45, Zhiguo Niu wrote:
> 
> 
> On Tue, Feb 20, 2024 at 2:32 PM Chao Yu <chao@kernel.org <mailto:chao@kernel.org>> wrote:
>  >
>  > On 2024/2/20 13:34, Zhiguo Niu wrote:
>  > > I think do f2fs_handle_error in __is_bitmap_valid is a good way.
>  >
>  > Like this?
>  >
>  > ---
>  >   fs/f2fs/checkpoint.c | 28 ++++++++++++++--------------
>  >   1 file changed, 14 insertions(+), 14 deletions(-)
>  >
>  > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>  > index 87b7c988c8ca..b8a7e83eb4e0 100644
>  > --- a/fs/f2fs/checkpoint.c
>  > +++ b/fs/f2fs/checkpoint.c
>  > @@ -155,21 +155,24 @@ static bool __is_bitmap_valid(struct f2fs_sb_info *sbi, block_t blkaddr,
>  >                 return exist;
>  >
>  >         if ((exist && type == DATA_GENERIC_ENHANCE_UPDATE) ||
>  > -               (!exist && type == DATA_GENERIC_ENHANCE)) {
>  > -               f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:%d",
>  > -                        blkaddr, exist);
>  > -               set_sbi_flag(sbi, SBI_NEED_FSCK);
>  > -               dump_stack();
>  > -       }
>  > -
>  > +               (!exist && type == DATA_GENERIC_ENHANCE))
>  > +               goto out_err;
>  > +       if (!exist && type != DATA_GENERIC_ENHANCE_UPDATE)
>  > +               goto out_handle;
>  > +       return exist;
>  > +out_err:
>  > +       f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:%d",
>  > +                blkaddr, exist);
>  > +       set_sbi_flag(sbi, SBI_NEED_FSCK);
>  > +       dump_stack();
>  > +out_handle:
>  > +       f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>  >         return exist;
>  >   }
>  >
>  >   static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
>  >                                         block_t blkaddr, int type)
>  >   {
>  > -       bool valid = false;
>  > -
>  >         switch (type) {
>  >         case META_NAT:
>  >                 break;
>  > @@ -209,10 +212,7 @@ static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
>  >                         dump_stack();
>  >                         goto err;
>  >                 } else {
>  > -                       valid = __is_bitmap_valid(sbi, blkaddr, type);
>  > -                       if ((!valid && type != DATA_GENERIC_ENHANCE_UPDATE) ||
>  > -                               (valid && type == DATA_GENERIC_ENHANCE_UPDATE))
>  > -                               goto err;
>  > +                       return __is_bitmap_valid(sbi, blkaddr, type);
>  >                 }
>  >                 break;
>  >         case META_GENERIC:
>  > @@ -227,7 +227,7 @@ static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
>  >         return true;
>  >   err:
>  >         f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>  > -       return valid;
>  > +       return false;
> I think it's OK.
> Do we need to wait for Jaegeuk Kim’s suggestion or should I update the new patch  version first😀?
> thanks!

I guess we'd better to wait for Jaegeuk's comments.

Thanks,

>  >   }
>  >
>  >   bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
>  > --
>  > 2.40.1
>  >
>  >

