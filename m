Return-Path: <linux-kernel+bounces-155346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8148AE930
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CAF11F23532
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754D813B2B2;
	Tue, 23 Apr 2024 14:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SvoKQV2Q"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F06D13AD00
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 14:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713881421; cv=none; b=WmqhKs5z9sRduh/ygQ1YXiCcSGbs4xkcfSFv0rjB0AwV0nHkrHq28tEr5bYM3mGBr+y+gmwIpar9GqWibVSpOjrkoewdHSqW16eQIhhO5K/zGNNVukzZrmJ7xVHxlpXbwV6/VgZa2q7tdhZQaD0Fn70FMnSQYFgFb8nkhfx8004=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713881421; c=relaxed/simple;
	bh=8vCT6GgBfiWWTRo1K6S36+Bf7DHRYQO9bOz5YVWhoM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oFj70kq19TBMDUkp3uwWz5K1OpG7/SSAXy7ok+ODrs2eTMAE18ezjFbotOD8S3KUwyvugLfmGq3xs7H2KMpcCbUD+x3G14DVlfLksUquSXOFOaZyqlQ710JkK6LNRt3ezLgRmfLPbbXOb28X8B9sWPrSPIqkL4jzL0y0PJOHvlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SvoKQV2Q; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-571b5fba660so15142a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 07:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713881416; x=1714486216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57fbJa8Cqm06V2ZeHJvielxUFsz8TmnwQIW1J9QeY04=;
        b=SvoKQV2QrJlLoA2z8jctD8mQdnIavT1dq8XFjVlWoJ+PALeAzIwLyBEGScAU3CT67Y
         J+vikZNfao8PT9N0219iX8zxF3MKoP1uJv8E7wUBzJ3o8klTOloC1AQ1oBZfVsqg5I1v
         dZ9WxrcfHczXJT3jKkQxLSKEnUmU4BUmaDjZBwiNqRW6GmTqwjaakP03PleO/35nKR2z
         KOgrDxY9dHn8tFus6bpFiNfde37HjgOzhRAnCZE1pLOCym05m8+xB5ONcte37wRuDQwl
         wgewGHotZ08WD1dD2Ks54bNdm/sDYuJPTIS0cOGL6+EjecC4z3th8svKzdLXFaOIxhKp
         uJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713881416; x=1714486216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57fbJa8Cqm06V2ZeHJvielxUFsz8TmnwQIW1J9QeY04=;
        b=VGuL7vmLXkvuCpuUxZnQ0pweq25Gi/Zp7fMAuA51yqp0ob9CXLpjOeIp3YdTI3yuLn
         zLyzHJVMtKYW/q3FpD8yLH7C9OZH6WTJi6hSCN8l/dG689xC6rPiLgbf7rrpFdDc7KdE
         IvSrWUMMTAsSeV3DEU6Qkub5goK03+36ydNvLTbm5dr2gCXtufOKNE2hkqkLXJGjgd5O
         fSnDRYkaODqvhZ9BjTaI4QphrcDpm81cdwOtLTUk0rHqjw5TaRzP4Ps41ry8DS0So84j
         XlDStTmcCZe2GBqYwGSSYB8qy0alEYTY/6CF5uEt6Ezd5+EV/ZHLIKxq8mdD3UFa3Nvo
         pfsg==
X-Forwarded-Encrypted: i=1; AJvYcCVNcyFN74HbTRQG5BcGRgy/w6yRPz6zrjGzdhYHgbJXvDfS/SmVl6pOjn8Fph3yVG4DSmHosZWV6mgGVyXe6yK4e6Wu8CSrpKhzEKx0
X-Gm-Message-State: AOJu0YwewQc9fs9NnXxo6wJrhrcd+XX+upSAwnXGnEIiDP9/4Nrl/KM6
	rTQ7fr7EBM8NWzb2tOENNcbv0OPy1SOj0E1xX4p+gC9QNFNt1ln9NVOhYhN2D9qegpqcCTHfjdy
	RlhdK6FDvASIc5FGXyvlzWzgvA5xqp6dyNlir
X-Google-Smtp-Source: AGHT+IFKMJbkXvNVepKk5DFhQD95LPFER6KYKwveNEskM71CTHSLjko+K/mmIBKYtON3Ufe0XHQHKGyKgRlS3i13O24=
X-Received: by 2002:aa7:df98:0:b0:572:2611:6f38 with SMTP id
 b24-20020aa7df98000000b0057226116f38mr29594edy.2.1713881416313; Tue, 23 Apr
 2024 07:10:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423134731.918157-1-vinschen@redhat.com>
In-Reply-To: <20240423134731.918157-1-vinschen@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 23 Apr 2024 16:10:05 +0200
Message-ID: <CANn89iKv1J3AS3rEmEhFq5McHmM+L=32pWg3Wj4_drsdKUx77A@mail.gmail.com>
Subject: Re: [PATCH net v2] igb: cope with large MAX_SKB_FRAGS
To: Corinna Vinschen <vinschen@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, Nikolay Aleksandrov <razor@blackwall.org>, 
	Jason Xing <kerneljasonxing@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 3:47=E2=80=AFPM Corinna Vinschen <vinschen@redhat.c=
om> wrote:
>
> From: Paolo Abeni <pabeni@redhat.com>
>
> Sabrina reports that the igb driver does not cope well with large
> MAX_SKB_FRAG values: setting MAX_SKB_FRAG to 45 causes payload
> corruption on TX.
>
> An easy reproducer is to run ssh to connect to the machine.  With
> MAX_SKB_FRAGS=3D17 it works, with MAX_SKB_FRAGS=3D45 it fails.
>
> The root cause of the issue is that the driver does not take into
> account properly the (possibly large) shared info size when selecting
> the ring layout, and will try to fit two packets inside the same 4K
> page even when the 1st fraglist will trump over the 2nd head.
>
> Address the issue forcing the driver to fit a single packet per page,
> leaving there enough room to store the (currently) largest possible
> skb_shared_info.
>
> Fixes: 3948b05950fd ("net: introduce a config option to tweak MAX_SKB_FRA=
G")
> Reported-by: Jan Tluka <jtluka@redhat.com>
> Reported-by: Jirka Hladky <jhladky@redhat.com>
> Reported-by: Sabrina Dubroca <sd@queasysnail.net>
> Tested-by: Sabrina Dubroca <sd@queasysnail.net>
> Tested-by: Corinna Vinschen <vinschen@redhat.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v2: fix subject, add a simple reproducer
>
>  drivers/net/ethernet/intel/igb/igb_main.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethe=
rnet/intel/igb/igb_main.c
> index a3f100769e39..22fb2c322bca 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -4833,6 +4833,7 @@ static void igb_set_rx_buffer_len(struct igb_adapte=
r *adapter,
>
>  #if (PAGE_SIZE < 8192)
>         if (adapter->max_frame_size > IGB_MAX_FRAME_BUILD_SKB ||
> +           SKB_HEAD_ALIGN(adapter->max_frame_size) > (PAGE_SIZE / 2) ||

I wonder if adding IGB_SKB_PAD would be needed ?

adapter->max_frame_size does not seem to include it.

I would try using all mtus between 1200 and 1280 to make sure this works.

Thanks !

>             rd32(E1000_RCTL) & E1000_RCTL_SBP)
>                 set_ring_uses_large_buffer(rx_ring);
>  #endif
> --
> 2.44.0
>

