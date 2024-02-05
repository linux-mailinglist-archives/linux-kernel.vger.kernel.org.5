Return-Path: <linux-kernel+bounces-52957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FEA849ECD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6AAF1C22233
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B122E63B;
	Mon,  5 Feb 2024 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6+K8S8M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D4C3A1C3
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707148394; cv=none; b=PBmbn9VHr/tg5vuMKa4IFf1FJrUyYlT6UgZ1XgNxw1KEgokYm5o/ZoDLrSGm8UhjECcnWr4xyhIuq1ksEKNQo339OGfb3Mx1Cc8XqSzstx7zfyXBCtYa9WVc8sN5egNwK+yoKpoiBQ8sLw/Ugdt4nf2D6kwf/Ps7F4mHkLqece8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707148394; c=relaxed/simple;
	bh=J8roI+XJDSVMI0a0Dhawqwac0Zkmnw0WWNfCfpE3idI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cJkaasuKaEDNIz3zXknmVmb90VIlcqLTxTJyaO6WQOmJy8xdQeNvIxITgSGrETcDwsux3Q5izpHbrr1rViu69Q7akG0hslpd0a7bgRSihuL21m2u7qEI3MOpsBYHi1PQKX52r56nff3Cl6KjUXs+mNdcYs3nKTpoeeYd+y6hdnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P6+K8S8M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707148391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J8roI+XJDSVMI0a0Dhawqwac0Zkmnw0WWNfCfpE3idI=;
	b=P6+K8S8MCSBfOBiY+90WZP/UxX017LukqqYtPXPcLrhjxlqFPETwhxMsn3fXPZUgEu9y+l
	ND/cnXcdz+kJPbNJBrsDmIT5zMsKprBDJMnH67fNwCDExHgv9/1QiOy3d0guUlX8p5XEpt
	d9eNBXTiDrVs7KwkSTFRuOJZjlN48KM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-fiFtJEsLObmQkatB51vtFg-1; Mon, 05 Feb 2024 10:53:10 -0500
X-MC-Unique: fiFtJEsLObmQkatB51vtFg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5606d5d14edso705316a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 07:53:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707148389; x=1707753189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J8roI+XJDSVMI0a0Dhawqwac0Zkmnw0WWNfCfpE3idI=;
        b=K5gy9JIrZ53sfkXJEA1u8TI/NREFHh8uzLR7jvzIMT4xmJjT0aCMBGgWea7FBS+hT/
         Ye/x+cU9tsxPMlY0/93W4ZmmjUx9bavPl/gBXvjI2xe8F704Ys+++/PUV2ghV+Z40fGn
         smc7WyHZDDfg/QS1ZG0t2md/vL7MDm0lA+JYObRzVlhvh0Jbb3RQyGLa5t0GgzvRPtLV
         KRxG2/jZune5c+Akj4gBFj0gVP6MgnGfq8dboh9YYOKwrpIkO1pF7sKmHsNLjGRfYvn5
         LXvCUny2mF8vmv9Oyp3Fv+YifDj21uLbfbdBNhMca47tx+XrGKvgBiUt0lqK2ojPPoPr
         sIiQ==
X-Gm-Message-State: AOJu0YwhuwnOwtENG9U6F6vlYH8epHeK2VXl9oX/P51F2/0Ew+rLwJ+w
	1arDItL+JaExzS3BUBe8zOYyP04czPdEIWnMXfKCqGMe/ALcOIXdrWSgK+wFtHl+n88yZ31uXyp
	k2wx6dfEWdpB7bonZgIFJctfM6X7moMkTycs/YtdxQEBUjo3oELOT2dmOi0ZlmV9oQzF5AN6fV/
	5ueP5HD5HjT4XuFYnf+dtpsCpdlQkiGgvZFklYiFUz+LzMvYA=
X-Received: by 2002:aa7:c89a:0:b0:55f:fad9:a91c with SMTP id p26-20020aa7c89a000000b0055ffad9a91cmr4963743eds.6.1707148388964;
        Mon, 05 Feb 2024 07:53:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6NX6qqHmiFdtuSKtOZNZLcM6JUDXJlz0lA4ylVz4SdTvG0QkbsGX8bI+10/SGJEYXt3Fexd6AN+vUoubJvhA=
X-Received: by 2002:aa7:c89a:0:b0:55f:fad9:a91c with SMTP id
 p26-20020aa7c89a000000b0055ffad9a91cmr4963735eds.6.1707148388821; Mon, 05 Feb
 2024 07:53:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117094912.155729-1-chentao@kylinos.cn>
In-Reply-To: <20240117094912.155729-1-chentao@kylinos.cn>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 5 Feb 2024 10:52:58 -0500
Message-ID: <CAK-6q+gjtDZOb-JFFPCt9oR1jPZ=NsLeph3H4npF8rrb0ifm5A@mail.gmail.com>
Subject: Re: [PATCH] fs: dlm: Simplify the allocation of slab caches in dlm_lowcomms_msg_cache_create
To: Kunwu Chan <chentao@kylinos.cn>
Cc: teigland@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 17, 2024 at 4:54=E2=80=AFAM Kunwu Chan <chentao@kylinos.cn> wro=
te:
>
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
>
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Acked-by: Alexander Aring <aahringo@redhat.com>

- Alex


