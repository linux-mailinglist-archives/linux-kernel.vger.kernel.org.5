Return-Path: <linux-kernel+bounces-81026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92782866F32
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4947828464C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA40112AAC4;
	Mon, 26 Feb 2024 09:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I5dCuMFR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224BA129A83
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708938921; cv=none; b=XIR9g18Ovza2T4ta02bMs+5C6+OgfEsWQwHgBCsMHRnWmnQOBpGmvMbzCytCE9D4tDFO5q0kSLK1K4L/4jU1mV2+nBtHRqutLRcyrxygzOt+yPt+Solb53bwDVKxw5huz/52JtXzCnEaUI8/m8cbsMyJr50y8SfSTijZNUC0HBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708938921; c=relaxed/simple;
	bh=OPslEpvTPGKWnBZFeMHtrwh2tuZS0bNiX5RiQgg4reo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jsi2Lfo0SDIhAAhv8bGzG9MxULyn1+YF5UPq7VbPdD985hPRpvQHD7UldBQhWGU6y5uLhMN6KC+2OnMEplmNNFuhMb3hJLK2vyT7Ie5yqCN0wGqhse1Uf8tMhua+irBeyF8gOKl4CfdjMeuY452rESHyiSHw+E9blvBKfU6MCQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I5dCuMFR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708938918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XM2rZSrkvpj1hoTBbAanVZWuvHXWVTnHCwh05d8mRxk=;
	b=I5dCuMFRwLkTzEdzRA/J5/dOyfXacjiPaKEZLb481RSDc/2/yyDTf/I2Xf12Bn2tzuR8x3
	9iRTC3yP0F39OJ5yWACZ6iq5cJA+HIri1724MAazz19iWdJPqj8/nhKS7Yc+fS2V8tqsrj
	pGB9+u5z+YuIOWqGWz7pRbNiO9/i8XE=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-IIWS53fPPH6mWO_ZofpbKw-1; Mon, 26 Feb 2024 04:15:16 -0500
X-MC-Unique: IIWS53fPPH6mWO_ZofpbKw-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1d4212b6871so34645535ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 01:15:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708938916; x=1709543716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XM2rZSrkvpj1hoTBbAanVZWuvHXWVTnHCwh05d8mRxk=;
        b=vTM3ko9+TiH2pk7ZKBViCcccUlilEOjyZyIwzK7K5nPRJCye34cKy9hmbKB2qdqqEJ
         rboOpT5gP0H9byNmOATkYAxTe3qAfM+At9pgWfy4gY6Qtbm/9K1Spfb1ygv2+cwKfoiE
         DgJNPYXJBLou63kxZdXE5cx8YQx8+tRpklp2RbJAkpQAD88IBR33SW3SSGyKocuvp0WE
         FzA4OpgX7lhT99Vk8h2DY/Vd68T+8dM2HECFygpnw4c1phJxkQ6dAYjvVltfcGLYo6Yq
         KTyKkf0OWOAnD6hflPEkKupDGskn094YG1yukj0HmIlSavujCYBSYmQ+wl4QjFFOGmeR
         bUlA==
X-Forwarded-Encrypted: i=1; AJvYcCWhuwogHZ0t0INPt4iuiYVPnOGtQ32pz+jNeYUajfhx3kluOGWkYtSGCLewIdfXB7UjbKCIia2xmLs8eA8tbUO1ak4qoI1UEo7FxA09
X-Gm-Message-State: AOJu0YzQ9wOQeVYkmCBt8/GCCNx+p6Q+OdqLFCivC5OH/MqpKocX4RCj
	+1HLZ9rNb3InRsUbrcMGgK70KsfSo+GYnjx2xSPjZ/xZ0k20xLPk49j1qdY3ytzMN/1s00bzNFe
	XXoEcXmLfISeKvBZ6H0tke1k3QgDdLOfXitq95SQRuE/qsw8scQJ3uc8hQgGMTulQhru4xvjg0F
	3gemY6CQeflsBEXkgwyJe94Ha9kGezfG8nGPAx
X-Received: by 2002:a17:902:82cc:b0:1da:1e60:f9fe with SMTP id u12-20020a17090282cc00b001da1e60f9femr6496598plz.54.1708938915903;
        Mon, 26 Feb 2024 01:15:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjtiAUPuzUBh4ubPX1A7L/YMlH/RSQKeJB9SeQOJhVhv0bZs2gncFg69XwV63F4kbstlJtlzKLWYqTjwHKI7s=
X-Received: by 2002:a17:902:82cc:b0:1da:1e60:f9fe with SMTP id
 u12-20020a17090282cc00b001da1e60f9femr6496587plz.54.1708938915603; Mon, 26
 Feb 2024 01:15:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222075806.1816400-1-yukuai1@huaweicloud.com> <20240222075806.1816400-5-yukuai1@huaweicloud.com>
In-Reply-To: <20240222075806.1816400-5-yukuai1@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Mon, 26 Feb 2024 17:15:04 +0800
Message-ID: <CALTww2-heW83=h44Jo1+6urS1xkzm4EWBuoo_0R_Dn-RjiG9eg@mail.gmail.com>
Subject: Re: [PATCH md-6.9 04/10] md/raid1-10: add a helper raid1_check_read_range()
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: paul.e.luse@linux.intel.com, song@kernel.org, neilb@suse.com, shli@fb.com, 
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com, 
	yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 4:04=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> The checking and handler of bad blocks appear many timers during
> read_balance() in raid1 and raid10. This helper will be used in later
> patches to simplify read_balance() a lot.
>
> Co-developed-by: Paul Luse <paul.e.luse@linux.intel.com>
> Signed-off-by: Paul Luse <paul.e.luse@linux.intel.com>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/raid1-10.c | 49 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>
> diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
> index 512746551f36..9bc0f0022a6c 100644
> --- a/drivers/md/raid1-10.c
> +++ b/drivers/md/raid1-10.c
> @@ -227,3 +227,52 @@ static inline bool exceed_read_errors(struct mddev *=
mddev, struct md_rdev *rdev)
>
>         return false;
>  }
> +
> +/**
> + * raid1_check_read_range() - check a given read range for bad blocks,
> + * available read length is returned;
> + * @rdev: the rdev to read;
> + * @this_sector: read position;
> + * @len: read length;
> + *
> + * helper function for read_balance()
> + *
> + * 1) If there are no bad blocks in the range, @len is returned;
> + * 2) If the range are all bad blocks, 0 is returned;
> + * 3) If there are partial bad blocks:
> + *  - If the bad block range starts after @this_sector, the length of fi=
rst
> + *  good region is returned;
> + *  - If the bad block range starts before @this_sector, 0 is returned a=
nd
> + *  the @len is updated to the offset into the region before we get to t=
he
> + *  good blocks;
> + */
> +static inline int raid1_check_read_range(struct md_rdev *rdev,
> +                                        sector_t this_sector, int *len)
> +{
> +       sector_t first_bad;
> +       int bad_sectors;
> +
> +       /* no bad block overlap */
> +       if (!is_badblock(rdev, this_sector, *len, &first_bad, &bad_sector=
s))
> +               return *len;
> +
> +       /*
> +        * bad block range starts offset into our range so we can return =
the
> +        * number of sectors before the bad blocks start.
> +        */
> +       if (first_bad > this_sector)
> +               return first_bad - this_sector;
> +
> +       /* read range is fully consumed by bad blocks. */
> +       if (this_sector + *len <=3D first_bad + bad_sectors)
> +               return 0;
> +
> +       /*
> +        * final case, bad block range starts before or at the start of o=
ur
> +        * range but does not cover our entire range so we still return 0=
 but
> +        * update the length with the number of sectors before we get to =
the
> +        * good ones.
> +        */
> +       *len =3D first_bad + bad_sectors - this_sector;
> +       return 0;
> +}
> --
> 2.39.2
>
>

This patch looks good to me.
Reviewed-by: Xiao Ni <xni@redhat.com>


