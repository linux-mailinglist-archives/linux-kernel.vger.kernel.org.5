Return-Path: <linux-kernel+bounces-135187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5F389BC6C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCD5CB22077
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080D54F1E0;
	Mon,  8 Apr 2024 09:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="h4Dyzskj"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22524E1DA
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 09:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712570169; cv=none; b=c44JkLCsqjNOFZiv3DrzdECn2MxaQNfTKIwyc3eY4zNUy8hsDtAFSwObW4+u7ngrM5SBkjDoBW0C+Mj9lKo4N0XYdLY39p/vn+eEIdYy3PyKp303NHx2oNLLuyR+MvIyzOzF3wuhoHB1Ly/xNy96D89usCNm76od+0BI/WbWPXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712570169; c=relaxed/simple;
	bh=LwyvMM/osJwH6vJPmU4ZO2uCiOeVzGUiiHNqjIKfpJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UYuf/YiV0oa8nyTh/mTvxPrrXLh2Wihspk9QgyM7CrRMZMN1K4czFBPkHVSSRXJwEOllIcyOkpDQUnfNZGC0gCTmUWTBJAHVpTQyhFIwcNGjcZVTGfN5CnpIEF+t9oQdsGRcVlTyVQ5NJpDlZI+j2l4qDo+0veeI35pnUHeeGYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h4Dyzskj; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56e2e851794so14561a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 02:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712570166; x=1713174966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NBLlpBXDu8VTMGb4M7KQYnrZBt176tELNst411LxfI=;
        b=h4DyzskjeqyNDor3BayhZbsEIlgTDmEw4jidjv/vi3IEVKrFIUGWor2I7VYTc9O4kf
         Ey/WTu3YOd2eElxZXDzb6R+q8gFaXH77wiX6pf+eMJuiKPJ+kxgWnSuAdGG7hVVCVVgo
         fWkKsvx/pY9vhsjt3kaBSUZ8NGylWJGUfPa/+zjXcs5Uq3n6D73D8WNfCGIHbnx7o7tj
         mWzxNjIGSRa0mPKuNbxaziNAKTM14o4igFfkORjxBxzZeo2VCaFN5wbttjyedm1+cWCx
         sCBhZBvyuUGJflPa8PN10A2494KkGyCRYFk7gVxwUQQMQB56JGyWHvIaTR0IA0uw/oK2
         PEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712570166; x=1713174966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5NBLlpBXDu8VTMGb4M7KQYnrZBt176tELNst411LxfI=;
        b=r0Whh5KeYO/ud8xjqJzVrmw8MoCxXb2Vb8sPbiKKcObULXhzhv+kkwWjSgiWDN8b2c
         Hse5J5p1M0iPssNz4tJejrGqqfc812V0SY3F2W2fu0hX4bazna8AUtwXGR2mrdBe+QUD
         NLJGeHEnmj2AG2puCurm1ywkQ2JsUOA9YoKJznfyHUWODh1/r91A8iseGlu7jKUxYAsy
         AvrkJJH71C3kodlo6M7r9rIX/JZmONp96fOLWvsbxQGchfwXKzRGH3MxluV/y1sKHKDg
         gcQlLaMT6Eotm9JnS+D6aM/GF/ep9ugI1xb3xH/h/Cp5GxmTKypCnOic7AkS/kfWxinO
         d9eQ==
X-Forwarded-Encrypted: i=1; AJvYcCXipp3066WwvO3MQL8Ub73Si45m2u6uHciOGm6/CzOEB/NMVMVzxG8fKAEIqB2uUUKUTAwHT3FXANzUer9f1zJouHXpA5C5cL7X/Xgj
X-Gm-Message-State: AOJu0YxJXjR/9xxgmq0SKLHoFCLdtf4ggEFIYaNNa5gkxxcOa43fcjiq
	OXLIt4lk/eIXFEQZkh+37wgjXFbJ/mtm4tJT+v2rx6fc+IGH0Jo0lUm68vyjNKdVZLS6E/eSmIR
	wOs46Cd8vshLef0paGtS+LYAOpO9wDyvaPShj
X-Google-Smtp-Source: AGHT+IE2qUojADKYdZJqeft3RAdXwSfc5OVrWJTQOnEo9gh9I4EVlEFyGGCO3ijZKUTup4SuuVnvMf9PS8JbxJKUuiU=
X-Received: by 2002:a05:6402:3125:b0:56e:556b:c3fd with SMTP id
 dd5-20020a056402312500b0056e556bc3fdmr120190edb.3.1712570165564; Mon, 08 Apr
 2024 02:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZhJTu7qmOtTs9u2c@zeus>
In-Reply-To: <ZhJTu7qmOtTs9u2c@zeus>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Apr 2024 11:55:54 +0200
Message-ID: <CANn89iJrQevxPFLCj2P=U+XSisYD0jqrUQpa=zWMXTjj5+RriA@mail.gmail.com>
Subject: Re: [PATCH net] nfc: nci: Fix uninit-value in nci_rx_work
To: Ryosuke Yasuoka <ryasuoka@redhat.com>
Cc: krzysztof.kozlowski@linaro.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syoshida@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 7, 2024 at 10:05=E2=80=AFAM Ryosuke Yasuoka <ryasuoka@redhat.co=
m> wrote:
>
> syzbot reported the following uninit-value access issue [1]
>
> nci_rx_work() parses received packet from ndev->rx_q. It should be
> checked skb->len is non-zero to verify if it is valid before processing
> the packet. If skb->len is zero but skb->data is not, such packet is
> invalid and should be silently discarded.
>
> Fixes: d24b03535e5e ("nfc: nci: Fix uninit-value in nci_dev_up and nci_nt=
f_packet")
> Reported-and-tested-by: syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail=
com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dd7b4dc6cd50410152534 [1=
]
> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> ---
>  net/nfc/nci/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
> index 0d26c8ec9993..b7a020484131 100644
> --- a/net/nfc/nci/core.c
> +++ b/net/nfc/nci/core.c
> @@ -1516,7 +1516,7 @@ static void nci_rx_work(struct work_struct *work)
>                 nfc_send_to_raw_sock(ndev->nfc_dev, skb,
>                                      RAW_PAYLOAD_NCI, NFC_DIRECTION_RX);
>
> -               if (!nci_plen(skb->data)) {
> +               if (!skb->len || !nci_plen(skb->data)) {

#define nci_plen(hdr)           (__u8)((hdr)[2])

So your patch will not help if skb->len is 1 or 2.

