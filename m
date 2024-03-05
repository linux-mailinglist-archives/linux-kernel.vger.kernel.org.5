Return-Path: <linux-kernel+bounces-92860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F63087270E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B64828C92D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC391BF5D;
	Tue,  5 Mar 2024 18:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HawU4/9M"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6456199BC
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 18:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709664931; cv=none; b=RHVATZ0nQ7ct7X0O0jS62jVdkbtQfulnpN/ec9NpnVa2SE5GY4CXw0pobzmDUkWrcTB+6B6tOZdwA0lls2q5RReXVKzC5ZXGhwLX6E5/oAwkh9gF75wJwpeKugGyUkaZ68FiLYE9lcztFFX9Djf6uKxe/tvCHCdYoCDJtxfBgBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709664931; c=relaxed/simple;
	bh=iF7k1/BvifiPN9TSkNXOCDncvhbUHkmOoNs4nie4SL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rid6UsyqHOl0Wt4aDL5j7Y+xhwQkj3i4KPNdcKaRYTMWzNUTRzDZy4JW+achlOEaMqozADC3JZiANPJeCrpWj5cVHRnh8a8E0i6yy+sSNoXVpzvqnFEmvZ2C3+sa4QjbmR0SAgeQU53fIjVyJjamz3voCBLgJco4psgrnWS1vLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HawU4/9M; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e622b46f45so2092790b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 10:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709664929; x=1710269729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N6tcpCezM4szO4PrRorLtqFpYFaRv1y6CJa/aon/dew=;
        b=HawU4/9M4MnWxQtgipzpt9PqgTG7VjpdQIvAtOzw++aBwYS/ZQuqTtHCND9n0Q8yKZ
         /WHZ+7vWR7Ycjjoajv4J+3Z8yUzgEzABfRnS4O7jusnCgRtD8YXjdlEixeaqV4xlqlIE
         n9KibNMgbfLlSjKkMdiojnAqZl5d4jjysuy6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709664929; x=1710269729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6tcpCezM4szO4PrRorLtqFpYFaRv1y6CJa/aon/dew=;
        b=gstfQ2CDv/QoQJQnoQcwb72VJR8hv7rwUdwb471WOCx6wQ6e55xPBZocbbWPD12mCO
         JOKtqTW+njISbEfwSjfQD2AvMKkhBRsFmWrJxE72ExrwlDLALjUxIrM32Qn4/VVwKWuF
         7ModGOS3M2Rmj1KdRfHoINy6E7Nv2xAuSjgBiMDem6KEKr809GbvLAyFc1hw6d50ISuL
         BAjwkscVzbZvklNU9PIGJ+K6p7OXXMZXzraXHH1HOn8ZwautOixEO6VEWPIY2lgLfNSc
         Ww1RVjdxn/q87ZxLEr92fUvyWRm/kzYA4AfzF/b75Z2WXkzXp1P7mAPxTzjENSiqXwe9
         MNqw==
X-Gm-Message-State: AOJu0YwD/N5m1eiyK+jUAii1WuLB1en4uSxLjuWka9EE5iRFfz/KVTd4
	gU8Kp4luOgFvXgof8Z+E2lqWTjFW5Up4xIUhp6/1skdoWDkKeqv4Mefcjmurkg==
X-Google-Smtp-Source: AGHT+IHucMJYCi/tee/LOp3cS5lJgIaeKKgyMbj7aVLxKu5Ic8uHzyu+W5p5aK2Pcs5AeZOxBZF9FA==
X-Received: by 2002:a05:6a00:3908:b0:6e4:dfec:1b0e with SMTP id fh8-20020a056a00390800b006e4dfec1b0emr13080584pfb.19.1709664929226;
        Tue, 05 Mar 2024 10:55:29 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f6-20020a056a00238600b006e58553e613sm9295684pfc.74.2024.03.05.10.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 10:55:28 -0800 (PST)
Date: Tue, 5 Mar 2024 10:55:28 -0800
From: Kees Cook <keescook@chromium.org>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Attreyee Mukherjee <tintinm2017@gmail.com>
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	syzbot <syzbot+c52569baf0c843f35495@syzkaller.appspotmail.com>,
	linux-usb@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [syzbot] [PATCH] usbhid: fix array-index-out-of-bounds in
 usbhid_parse UBSAN warning
Message-ID: <202403051052.DA58CAC19@keescook>
References: <000000000000d330500607d85a5f@google.com>
 <0000000000009ae37b060d32c643@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000009ae37b060d32c643@google.com>

Hi,

What's happened to getting a new version of this patch? This flaw is
still reachable in -next from what I can see?

Thanks,

-Kees

On Sat, Dec 23, 2023 at 11:59:51AM -0800, syzbot wrote:
> For archival purposes, forwarding an incoming command email to
> linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.
> 
> ***
> 
> Subject: [PATCH] usbhid: fix array-index-out-of-bounds in usbhid_parse UBSAN warning
> Author: tintinm2017@gmail.com
> 
> #syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> 
> Look at the bug https://syzkaller.appspot.com/bug?extid=c52569baf0c843f35495 reported by syzbot. Tested a patch through syzbot, which gives an error. 
> Requesting help from the maintainers to understand what is really going wrong in the code. 
> 
> Based on my understanding, I believe the value of the number of descriptors is calculated incorrectly before the for loop.
> 
> Signed-off-by: Attreyee Mukherjee <tintinm2017@gmail.com>
> ---
>  drivers/hid/usbhid/hid-core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index a90ed2ceae84..582ddbef448f 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -1021,6 +1021,8 @@ static int usbhid_parse(struct hid_device *hid)
>  	       (hdesc->bLength - offset) / sizeof(struct hid_class_descriptor));
>  
>  	for (n = 0; n < num_descriptors; n++)
> +		if (n >= ARRAY_SIZE(hdesc->desc))
> +			break;
>  		if (hdesc->desc[n].bDescriptorType == HID_DT_REPORT)
>  			rsize = le16_to_cpu(hdesc->desc[n].wDescriptorLength);
>  
> -- 
> 2.34.1
> 

-- 
Kees Cook

