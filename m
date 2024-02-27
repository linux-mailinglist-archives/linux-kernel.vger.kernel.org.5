Return-Path: <linux-kernel+bounces-83309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C88C48691A8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DDBC283A01
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C526713B2A9;
	Tue, 27 Feb 2024 13:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rWW3cyIs"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4CB13A87C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 13:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040216; cv=none; b=jjWZnO6eomLvtPxQIxJvwxHmhfvzYV5Wa+IUtuKt0WX5ycIOo1WrjfOjCn2umjO3wrflB/1CPharMnuNu3rw/b/DXD++ip7E6UZwwNVObvMO/xlTmVG8pIkoWCTfW4pIoZqOrrH0w9F/y0e6nY6KTGVGLCK2DZgxP1F2p/N8ydY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040216; c=relaxed/simple;
	bh=xpxiqCQQ3K6pyTYrJI595L9Z2x7eviwccCbJdPeo4Vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rRqeut91ps5axLQyrlxp9VvcrT6KJYZBaRvhLDbpJVlBqiUjsPAJh83zhin5sIYREx+bAITEDR0UjZ06qq3P0zOMTpHqZKtF4WHYazxlEptWLJc9/lLK9pPYMT10kzxQ38e297jGc/Ke7svJuUtZh7MpnihYWMRziHpLRWhhaYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rWW3cyIs; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d28e465655so25714431fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 05:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709040213; x=1709645013; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tION+eRfh44NM536dssXS05yQfBojvVk3yfrsfxB50E=;
        b=rWW3cyIsI8i2DfrzOCBm2BBfH5TGNLHbqkUf19q2msR9KMnF26hxaPa1UmCwM57qWh
         t5jXFWf7riRlMvuq1uGf1xsVVpmCjWbA0hAIH7RP3SS3bXXuxpehnw5naDOiOfT5UoKT
         1hA7ETIcK1eZtPx1ue+W2pbZ2jvHv1noYDvuIDxgXcqvGfSyir4jljgwvt557Q1YP5yM
         sKC6eC80D3w5Z5aUmKbnVGHsEP49ZhuIpqCEcjgMvxdPL2mvKdwyOMuefMLq7VQpFTEQ
         oLzkmWLy0tmMFdRssQQYvajyrJWUZWFEEVTznoyohX+YqjoImE5pvtyHLeHfN5awXI97
         jlWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709040213; x=1709645013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tION+eRfh44NM536dssXS05yQfBojvVk3yfrsfxB50E=;
        b=umcTzksF5LT8wJswsvyJD+BM/XQWREfKQOifG62E20ICSxRrHZ0VICr+n1Diz2QStn
         6RHkszP8DjzMbNk3FdMM0DqyNepg0zTokMy9YMmtiE/zV+E4e7EJwJywFbl3gaTEXnGq
         9JxJTdIBOPOrfzpP8YiRyOQnds437M1pdXVNuI6yBA3/286uUGR8gvVWOqo1pKkqAgQQ
         csUAHBnM47+iZylYSfnKwvtPrcPcwYl6UHrboYVoloyT1yttXePw4CuBOQ4jWWXSFaY8
         ESazAeiQYKDWbISCWiRIEVohiINQDPBaNBs3LtpC5RoJzFrAZ1Tm8GXan/xigKaQjMBd
         o+2g==
X-Forwarded-Encrypted: i=1; AJvYcCXfpelBT4vHyOK2KgxKwGgF5K+m5Gbw7Fq0FIK0tjuYs/dZEchINHMEAkDizUTj7OeJvFpOrA55sRgAM1HShJmC8gg3kR7VLv4keman
X-Gm-Message-State: AOJu0Ywos/K21XMXKjNko5Qj8Ns8soCEwHuN71pNkhLXWlmRVCGaXw4P
	aiu9WJBR8dEsZgP6q8mhYXPh1hOlFEw3cZntz9iX3wRd/6aPTeWd6qSYleg5kfnY/iFOnMwiPyX
	TocFf8/EhqOBaRbo/KOuEa9iP5gsnLsifsmLLVg==
X-Google-Smtp-Source: AGHT+IE/6ReSwzGYn3SyexSXV7z8MzYspaiUyckr5Y+U7BEy6L2CuW0SXzat8pmrO/gSPnsQi8KKJfxD7BeQvRTwCjE=
X-Received: by 2002:a2e:a1cc:0:b0:2d2:6608:3d05 with SMTP id
 c12-20020a2ea1cc000000b002d266083d05mr5390365ljm.52.1709040213091; Tue, 27
 Feb 2024 05:23:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215030002.281456-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20240215030002.281456-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAC_iWj+p6gmcb4-_-f8Kr4Ds6EmSsq2D4GK1XymyybX7i1TMFw@mail.gmail.com> <7bd53417-af59-43a8-965e-f63dfc827f3c@linux.intel.com>
In-Reply-To: <7bd53417-af59-43a8-965e-f63dfc827f3c@linux.intel.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 27 Feb 2024 15:22:57 +0200
Message-ID: <CAC_iWjK3sXq1O4tgR0vEr9n2erfrr+9hqU+xUqiMK-TQa0t-hg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] efi/libstub: Add Confidential Computing (CC)
 measurement support
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Thanks for taking a shot at this.

[...]

> >> +               return status;
> >> +
> >> +       evt->event_data = (struct efi_tcg2_event){
> >> +               .event_size                     = size,
> >> +               .event_header.header_size       = sizeof(evt->event_data.event_header),
> >> +               .event_header.header_version    = EFI_TCG2_EVENT_HEADER_VERSION,
> >> +               .event_header.pcr_index         = events[event].pcr_index,
> >> +               .event_header.event_type        = EV_EVENT_TAG,
> >> +       };
> >> +
> >> +       evt->tagged_event = (struct efi_tcg2_tagged_event){
> >> +               .tagged_event_id                = events[event].event_id,
> >> +               .tagged_event_data_size         = events[event].event_data_len,
> >> +       };
> >> +
> >> +       memcpy(evt->tagged_event_data, events[event].event_data,
> >> +              events[event].event_data_len);
> >> +
> >> +       status = efi_call_proto(tcg2, hash_log_extend_event, 0,
> >> +                               load_addr, load_size, &evt->event_data);
> > The struct filling/memcpying looks similar across the 2 functions.  I
> > wonder if it makes sense to have a common function for that, with an
> > argument for the event data type.
>
> If we want to use helper function, the updated code looks like below.
>
> Are you fine with this version? (compile-tested only)
>
> +struct efi_tcg2_measured_event {
> +       efi_tcg2_event_t        event_data;
> +       efi_tcg2_tagged_event_t tagged_event;
> +       u8                      tagged_event_data[];
> +};
> +
> +struct efi_cc_measured_event {
> +       efi_cc_event_t  event_data;
> +       efi_tcg2_tagged_event_t tagged_event;
> +       u8                      tagged_event_data[];
> +};
> +
> +static void efi_tcg2_event_init(struct efi_tcg2_measured_event *evt,
> +                               size_t size,
> +                               enum efistub_event event)
> +{
> +       evt->event_data = (struct efi_tcg2_event){
> +               .event_size                     = size,
> +               .event_header.header_size       = sizeof(evt->event_data.event_header),
> +               .event_header.header_version    = EFI_TCG2_EVENT_HEADER_VERSION,
> +               .event_header.pcr_index         = events[event].pcr_index,
> +               .event_header.event_type        = EV_EVENT_TAG,
> +       };
> +
> +       evt->tagged_event = (struct efi_tcg2_tagged_event){
> +               .tagged_event_id                = events[event].event_id,
> +               .tagged_event_data_size         = events[event].event_data_len,
> +       };
> +
> +       memcpy(evt->tagged_event_data, events[event].event_data,
> +              events[event].event_data_len);
> +}
> +
> +static efi_status_t tcg2_efi_measure(efi_tcg2_protocol_t *tcg2,
> +                                    unsigned long load_addr,
> +                                    unsigned long load_size,
> +                                    enum efistub_event event)
> +{
> +       struct efi_tcg2_measured_event *evt;
> +       efi_status_t status;
> +       size_t size;
> +
> +       size = sizeof(*evt) + events[event].event_data_len;
> +
> +       status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,
> +                            (void **)&evt);
> +       if (status != EFI_SUCCESS)
> +               return status;
> +
> +       efi_tcg2_event_init(evt, size, event);
> +
> +       status = efi_call_proto(tcg2, hash_log_extend_event, 0,
> +                               load_addr, load_size, &evt->event_data);
> +       efi_bs_call(free_pool, evt);
> +
> +       return status;
> +}
>
> +
> +static efi_status_t cc_efi_measure(efi_cc_protocol_t *cc,
> +                                  unsigned long load_addr,
> +                                  unsigned long load_size,
> +                                  enum efistub_event event)
> +{
> +       struct efi_cc_measured_event *evt;
> +       efi_cc_mr_index_t mr;
> +       efi_status_t status;
> +       size_t size;
> +
> +       status = efi_call_proto(cc, map_pcr_to_mr_index, events[event].pcr_index, &mr);
> +       if (status != EFI_SUCCESS) {
> +               efi_debug("CC_MEASURE: PCR to MR mapping failed\n");
> +               return status;
> +       }
> +
> +       size = sizeof(*evt) + events[event].event_data_len;
> +
> +       status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size, (void **)&evt);
> +       if (status != EFI_SUCCESS)
> +               return status;
> +
> +       efi_tcg2_event_init((struct efi_tcg2_measured_event *)evt, size, event);
> +
> +       evt->event_data = (struct efi_cc_event){
> +               .event_header.header_size       = sizeof(evt->event_data.event_header),
> +               .event_header.header_version    = EFI_CC_EVENT_HEADER_VERSION,
> +               .event_header.mr_index          = mr,
> +       };
> +
> +       status = efi_call_proto(cc, hash_log_extend_event, 0,
> +                               load_addr, load_size, &evt->event_data);
> +
> +       efi_bs_call(free_pool, evt);
> +
> +       return status;
> +}
>

Yes, I think looks cleaner. Ard thoughts?

Thanks
/Ilias
>
> >
> >> +       efi_bs_call(free_pool, evt);
> >> +
> >> +       return status;
> >> +}
> >> +
> >> +static efi_status_t cc_efi_measure(efi_cc_protocol_t *cc,
> >> +                                  unsigned long load_addr,
> >> +                                  unsigned long load_size,
> >> +                                  enum efistub_event event)
> >> +{
> >> +       struct efi_measured_event {
> >> +               efi_cc_event_t  event_data;
> >> +               efi_tcg2_tagged_event_t tagged_event;
> >> +               u8                      tagged_event_data[];
> >> +       } *evt;
> >> +       size_t size = sizeof(*evt) + events[event].event_data_len;
> >> +       efi_cc_mr_index_t mr;
> >> +       efi_status_t status;
> >> +
> >> +       status = efi_call_proto(cc, map_pcr_to_mr_index, events[event].pcr_index, &mr);
> >> +       if (status != EFI_SUCCESS) {
> >> +               efi_err("CC_MEASURE: PCR to MR mapping failed\n");
> >> +               return status;
> >> +       }
> >> +
> >> +       status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size, (void **)&evt);
> >> +       if (status != EFI_SUCCESS) {
> >> +               efi_err("CC_MEASURE: Allocating event struct failed\n");
> >> +               return status;
> >> +       }
> >> +
> >> +       evt->event_data = (struct efi_cc_event){
> >> +               .event_size                     = size,
> >> +               .event_header.header_size       = sizeof(evt->event_data.event_header),
> >> +               .event_header.header_version    = EFI_CC_EVENT_HEADER_VERSION,
> >> +               .event_header.mr_index          = mr,
> >> +               .event_header.event_type        = EV_EVENT_TAG,
> >> +       };
> >> +
> >> +       evt->tagged_event = (struct efi_tcg2_tagged_event){
> >> +               .tagged_event_id                = events[event].event_id,
> >> +               .tagged_event_data_size         = events[event].event_data_len,
> >> +       };
> >> +
> >> +       memcpy(evt->tagged_event_data, events[event].event_data,
> >> +              events[event].event_data_len);
> >> +
> >> +       status = efi_call_proto(cc, hash_log_extend_event, 0,
> >> +                               load_addr, load_size, &evt->event_data);
> >> +
> >> +       efi_bs_call(free_pool, evt);
> >> +
> >> +       return status;
> >> +}
> >>  static efi_status_t efi_measure_tagged_event(unsigned long load_addr,
> >>                                              unsigned long load_size,
> >>                                              enum efistub_event event)
> >>  {
> >>         efi_guid_t tcg2_guid = EFI_TCG2_PROTOCOL_GUID;
> >> +       efi_guid_t cc_guid = EFI_CC_MEASUREMENT_PROTOCOL_GUID;
> >> +       efi_cc_protocol_t *cc = NULL;
> >>         efi_tcg2_protocol_t *tcg2 = NULL;
> >>         efi_status_t status;
> >>
> >>         efi_bs_call(locate_protocol, &tcg2_guid, NULL, (void **)&tcg2);
> >>         if (tcg2) {
> >> -               struct efi_measured_event {
> >> -                       efi_tcg2_event_t        event_data;
> >> -                       efi_tcg2_tagged_event_t tagged_event;
> >> -                       u8                      tagged_event_data[];
> >> -               } *evt;
> >> -               int size = sizeof(*evt) + events[event].event_data_len;
> >> -
> >> -               status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,
> >> -                                    (void **)&evt);
> >> +               status = tcg2_efi_measure(tcg2, load_addr, load_size, event);
> >>                 if (status != EFI_SUCCESS)
> >>                         goto fail;
> >>
> >> -               evt->event_data = (struct efi_tcg2_event){
> >> -                       .event_size                     = size,
> >> -                       .event_header.header_size       = sizeof(evt->event_data.event_header),
> >> -                       .event_header.header_version    = EFI_TCG2_EVENT_HEADER_VERSION,
> >> -                       .event_header.pcr_index         = events[event].pcr_index,
> >> -                       .event_header.event_type        = EV_EVENT_TAG,
> >> -               };
> >> -
> >> -               evt->tagged_event = (struct efi_tcg2_tagged_event){
> >> -                       .tagged_event_id                = events[event].event_id,
> >> -                       .tagged_event_data_size         = events[event].event_data_len,
> >> -               };
> >> -
> >> -               memcpy(evt->tagged_event_data, events[event].event_data,
> >> -                      events[event].event_data_len);
> >> -
> >> -               status = efi_call_proto(tcg2, hash_log_extend_event, 0,
> >> -                                       load_addr, load_size, &evt->event_data);
> >> -               efi_bs_call(free_pool, evt);
> >> +               return EFI_SUCCESS;
> >> +       }
> >>
> >> +       efi_bs_call(locate_protocol, &cc_guid, NULL, (void **)&cc);
> >> +       if (cc) {
> >> +               status = cc_efi_measure(cc, load_addr, load_size, event);
> >>                 if (status != EFI_SUCCESS)
> >>                         goto fail;
> >> +
> >>                 return EFI_SUCCESS;
> >>         }
> >>
> > [...]
> >
> > Thanks
> > /Ilias
>
> --
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
>

