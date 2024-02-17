Return-Path: <linux-kernel+bounces-70092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8D98592EF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 22:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 660801F22075
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 21:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E567F7F4;
	Sat, 17 Feb 2024 21:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="fRjUtNWb"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA9B1CF83
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 21:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708204746; cv=none; b=r9CRdKj1BNlpHk4l4DsKQuAQ+j2277bd0mP9hQPVhKKjhdrxb+PnOv96KjLbqyzG75yr7LnoYRy+ZaZ8CkLhNsB2rFyFnR6aueP8c0QMgK+ZBciuyqYCHMaObTUYObI1RdPllFvVduzxwS/DzyVOQc+pUQ9N7RytZsT2AI4IGHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708204746; c=relaxed/simple;
	bh=jqmSZE/6hIL7tHTUq7XBmsqEMOHIxcazTD9D7B73dnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GNyuUoF+iwMeH4QNbDejV4xFVijm2yo35Rba/HxdwFxOu1nq1a9kw8NEP/4DUh8i9Um7v0mO3p6EGXKFE61kxkyl4JcULHowPt+bf3Ml/hLqN2eQQcfceQQQbVtUJA32JHkhDKBFU71GcjJGiexyjsM44Gj/Y+A1NnPk4WWGxws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=fRjUtNWb; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7875adf71b1so25395085a.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 13:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1708204742; x=1708809542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jsUAb6vb40+XemerMiSmb6ZuxYzXcwGlQ49c+yrXOkw=;
        b=fRjUtNWbyUcxuRIkCB0gXWYH6TIvfHCtO29QgX3+Ws+ceUgFRqNzEYiutvsEmoBBYM
         ypJp25oScrs8hIJBClbEkerQf+Um4HRE0GUZ+JrpN8Pzx8C4G5JwFfJKXVuZvVFP+MIG
         f+tCQxLCGwwjS0d5d8xqHaIMgDw958TM+cDl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708204742; x=1708809542;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jsUAb6vb40+XemerMiSmb6ZuxYzXcwGlQ49c+yrXOkw=;
        b=mY0Q7HP5SARybM2M17gjFStZl+uNi2xJOTmHmj7QDIPtGrcflOQWWc8YmY1AaVBZpH
         /3IuKreSd/8Hjeb5HJxU/IdvNRlX8KMTve0s1Kt/AqncJPP+yiUtYmbK2jWESBvJ0Y3+
         zUmSv7T/N39nzpt+24V4Z+PHz92sCKnjJqNXKB/isbVtLgj1d/rq7l2zi9qTrHUhtVtZ
         lQhphKyFEnlbCkkhOVQQKuoRIPYnYP+NlFGp5URF4a06FWtJh/jyWJB71EjrSFGvNy2T
         4+Gt6sgF8JO9HAF2jfS2liLpR6WPqvb05ibqbPMQ7qNlycncgANfS+mbVqtVMtRj637X
         X1Ag==
X-Forwarded-Encrypted: i=1; AJvYcCVB3J1YZ0cGQRuwQwBairV+zOCiEnRoAImjj0ZvbawZGEnfQMeQfA5R70jSwQWXdhCd28EnY2+TKVFnFemGkMXLBVtLc5Nf7M1u3tV/
X-Gm-Message-State: AOJu0Yw4Ure37w2yCWbOA7cHabt82vpUJbs/PdF9mOk3M/QGiilhTUtn
	l/bLFmXclvG/0F7jaJFC3+S58N75Cgh9Rx6f3iQNAIg5QJY65mSZWTdekP0L5A==
X-Google-Smtp-Source: AGHT+IGP14v6oCCtMP0+vugRbMd2i51vK0hqWp5NBXjAY0xKJajqQMGwjum2Jn2GI6G56nWQ9lc40Q==
X-Received: by 2002:a05:620a:46ab:b0:787:538c:58cb with SMTP id bq43-20020a05620a46ab00b00787538c58cbmr4663545qkb.28.1708204741830;
        Sat, 17 Feb 2024 13:19:01 -0800 (PST)
Received: from [10.211.55.3] (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id c3-20020a05620a11a300b00785d7f634bcsm1116200qkk.8.2024.02.17.13.19.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Feb 2024 13:19:01 -0800 (PST)
Message-ID: <02cf87a3-4e92-4f6d-98f6-dfc0e198d462@ieee.org>
Date: Sat, 17 Feb 2024 15:18:59 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] greybus: audio: apbridgea: Remove flexible array from
 struct audio_apbridgea_hdr
Content-Language: en-US
To: Erick Archer <erick.archer@gmx.com>,
 Vaibhav Agarwal <vaibhav.sr@gmail.com>, Mark Greer <mgreer@animalcreek.com>,
 Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Kees Cook <keescook@chromium.org>
Cc: greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240217154758.7965-1-erick.archer@gmx.com>
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20240217154758.7965-1-erick.archer@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/17/24 9:47 AM, Erick Archer wrote:
> When a struct containing a flexible array is included in another struct,
> and there is a member after the struct-with-flex-array, there is a
> possibility of memory overlap. These cases must be audited [1]. See:
> 
> struct inner {
> 	...
> 	int flex[];
> };
> 
> struct outer {
> 	...
> 	struct inner header;
> 	int overlap;
> 	...
> };
> 
> This is the scenario for the "struct audio_apbridgea_hdr" structure
> that is included in the following "struct audio_apbridgea_*_request"
> structures:

Yeah this was not a very good way to define these header
structures, but I'm glad to hear the flexible array at the
end was never used.  I don't know why it was there; maybe
it's an artifact from some other information that got removed.

If the code compiles with your change, it ought to be fine.
(It compiles for me.)

It would be good for Vaibhav or Mark to comment though, maybe
they can provide some context.


> 
> struct audio_apbridgea_set_config_request
> struct audio_apbridgea_register_cport_request
> struct audio_apbridgea_unregister_cport_request
> struct audio_apbridgea_set_tx_data_size_request
> struct audio_apbridgea_prepare_tx_request
> struct audio_apbridgea_start_tx_request
> struct audio_apbridgea_stop_tx_request
> struct audio_apbridgea_shutdown_tx_request
> struct audio_apbridgea_set_rx_data_size_request
> struct audio_apbridgea_prepare_rx_request
> struct audio_apbridgea_start_rx_request
> struct audio_apbridgea_stop_rx_request
> struct audio_apbridgea_shutdown_rx_request
> 
> The pattern is like the one shown below:
> 
> struct audio_apbridgea_hdr {
> 	...
> 	__u8 data[];
> } __packed;
> 
> struct audio_apbridgea_*_request {
> 	struct audio_apbridgea_hdr hdr;
> 	...
> } __packed;
> 
> In this case, the trailing flexible array can be removed because it is
> never used.
> 
> Link: https://github.com/KSPP/linux/issues/202 [1]
> Signed-off-by: Erick Archer <erick.archer@gmx.com>
> ---
> Hi everyone,
> 
> I'm not sure this patch is correct. My concerns are:
> 
> The "struct audio_apbridgea_hdr" structure is used as a first member in
> all the "struct audio_apbridgea_*_request" structures. And these last
> structures are used in the "gb_audio_apbridgea_*(...)" functions. These
> functions fill the "request" structure and always use:
> 
> 	gb_hd_output(connection->hd, &req, sizeof(req),
> 		     GB_APB_REQUEST_AUDIO_CONTROL, true);
> 
> Then, the "gb_hd_output(struct gb_host_device *hd, ...)" function calls:
> 
> 	hd->driver->output(hd, req, size, cmd, async);
> 
> The first parameter to this function is of type:
> 
> 	struct gb_host_device {
> 		...
> 		const struct gb_hd_driver *driver;
> 		...
> 	};
> 
> And the "gb_hd_driver" structure is defined as:
> 
> 	struct gb_hd_driver {
> 		...
> 		int (*output)(struct gb_host_device *hd, void *req, u16 size, u8 cmd,
> 			      bool async);
> 	};
> 
> Therefore, my question is:
> Where is the "output" function pointer set? I think I'm missing something.

I think it will be drivers/greybus/es2.c:output().

But in any case, the output function will know nothing about
the structure of the request, so I think it's unrelated to
the change you're proposing.

Johan can confirm this.

I'd like to hear from these others, but otherwise this change
looks good to me.

Reviewed-by: Alex Elder <elder@linaro.org>

> 
> I have search for another greybus drivers and I have found that, for
> example, the "es2_ap_driver" (drivers/greybus/es2.c) sets the "output"
> member in:
> 
> 	static struct gb_hd_driver es2_driver = {
> 		...
> 		.output	= output,
> 	};
> 
> I think that the flexible array that I have removed should be used in
> the function assigned to the "output" function pointer. But I am not
> able to find this function.
> 
> A bit of light on this would be greatly appreciated.
> 
> Thanks,
> Erick
> ---
>   drivers/staging/greybus/audio_apbridgea.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/audio_apbridgea.h b/drivers/staging/greybus/audio_apbridgea.h
> index efec0f815efd..ab707d310129 100644
> --- a/drivers/staging/greybus/audio_apbridgea.h
> +++ b/drivers/staging/greybus/audio_apbridgea.h
> @@ -65,7 +65,6 @@
>   struct audio_apbridgea_hdr {
>   	__u8	type;
>   	__le16	i2s_port;
> -	__u8	data[];
>   } __packed;
> 
>   struct audio_apbridgea_set_config_request {
> --
> 2.25.1
> 


